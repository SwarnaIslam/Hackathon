import React from "react";
import { Button, Form, Input, Select } from "antd";
import Web3 from "web3";
import abi from "../contracts/Communities.json";

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
const Community = () => {
  const formRef = React.useRef(null);
  const contractAddress = "0x498a3655B5afB3f749e7077bB73f3dfbB4206cE4"; // Replace with your contract's address
  const userAddress = localStorage.getItem("acountAddress"); // Replace with the user's account address

  const provider = window.ethereum;

  const web3 = new Web3(provider);
  const contractABI = abi.abi;
  const communityContract = new web3.eth.Contract(contractABI, contractAddress);

  async function handleSubmit(value) {
    try {
      if (typeof provider !== "undefined") {
        console.log(userAddress);
        console.log(communityContract);
        // const ct = value.community_title;
        // const d = value.description;
        // const ntm = value.native_token_name;
        // const nts = value.native_token_symbol;
        await communityContract.methods
          .createCommunity(
            value.community_title,
            value.description,
            parseInt(value.stake_amount),
            parseInt(value.exchange_rate),
            value.native_token_name,
            value.native_token_symbol
          )
          .call({ from: userAddress });
      }

      // Success message
      alert("Community created successfully!");
    } catch (error) {
      console.error("Error while creating community:", error);
      alert("Error while creating community. Check the console for details.");
    }
  }
  return (
    <Form
      {...layout}
      ref={formRef}
      name="control-ref"
      onFinish={handleSubmit}
      style={{
        maxWidth: 600,
      }}
    >
      <Form.Item
        name="community_title"
        label="Community Title"
        rules={[
          {
            required: true,
          },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item
        name="description"
        label="Description"
        rules={[
          {
            required: true,
          },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item
        name="exchange_rate"
        label="Exchange rate"
        rules={[
          {
            required: true,
          },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item
        name="native_token_name"
        label="Native Token name"
        rules={[
          {
            required: true,
          },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item
        name="native_token_symbol"
        label="Native Token Symbol"
        rules={[
          {
            required: true,
          },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item
        name="stake_amount"
        label="Stake Amount"
        rules={[
          {
            required: true,
          },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item {...tailLayout}>
        <Button type="primary" htmlType="submit">
          Submit
        </Button>
      </Form.Item>
    </Form>
  );
};

export default Community;
