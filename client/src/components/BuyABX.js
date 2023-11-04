import { Button, Form, Input, Select } from "antd";
import React, { useState, useEffect } from "react";
import Web3 from "web3"; // or import { ethers } from 'ethers';
import abi from "../contracts/ABX.json"; // Replace with your ABI file
import { ethers } from "ethers";
const layout = {
  labelCol: {
    span: 8,
  },
  wrapperCol: {
    span: 16,
  },
};
const tailLayout = {
  wrapperCol: {
    offset: 8,
    span: 16,
  },
};

const BuyABX = () => {
  // Replace with your Ethereum node URL
  const contractAddress = "0x38b23c06be9c1bee388305153737f3de98a763e5"; // Replace with your contract's address
  const userAddress = localStorage.getItem("acountAddress"); // Replace with the user's account address

  const provider = window.ethereum;

  const web3 = new Web3(provider);
  const contractABI = abi.abi;
  const abxcontract = new web3.eth.Contract(contractABI, contractAddress);

  const formRef = React.useRef(null);
  const [ether, setEther] = useState(0);

  const onChange = async (values) => {
    //const buymethod = abxcontract.methods.buyTokens(); // Replace with your method and parameters

    // try {
    //   const estimatedGas = await buymethod.estimateGas({
    //     from: userAddress,
    //   });
    //   console.log("Estimated gas price:", estimatedGas);
    // } catch (error) {
    //   console.error("Gas estimation error:", error);
    // }
    setEther(values.ABX / 10000);
  };

  const buyTokens = async () => {
    try {
      if (typeof provider !== "undefined") {
        // Convert the ETH amount to Wei (1 ETH = 1e18 Wei)
        const amount = { value: ethers.utils.parseEther("0.01") };
        console.log(amount);
        const ethAmountInWei = web3.utils.toWei(ether.toString(), "ether");
        console.log("contract addr: ",contractAddress);
        await abxcontract.methods.buyTokens().send({
          from: userAddress,
          value: ethAmountInWei,
        });
      }

      // Success message
      alert("Tokens purchased successfully!");
    } catch (error) {
      console.error("Error while buying tokens:", error);
      alert("Error while buying tokens. Check the console for details.");
    }
  };
  return (
    <Form
      {...layout}
      ref={formRef}
      name="control-ref"
      onValuesChange={onChange}
      onFinish={buyTokens}
      style={{
        maxWidth: 600,
      }}
    >
      <Form.Item
        name="ABX"
        label="ABX Token"
        rules={[
          {
            required: true,
          },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item name="Ether" label="Ether">
        <Input readOnly={true} placeholder={ether} />
      </Form.Item>
      <Form.Item {...tailLayout}>
        <Button type="primary" htmlType="submit">
          Submit
        </Button>
      </Form.Item>
    </Form>
  );
};
export default BuyABX;
