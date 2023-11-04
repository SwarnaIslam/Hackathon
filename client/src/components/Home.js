import React, { useEffect, useState } from "react";
import Web3 from "web3";
import { ethers } from "ethers";
import { useNavigate } from "react-router-dom";
const Home = () => {
  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState(0);
  const navigate = useNavigate();

  const reload = localStorage.getItem("autoReload");

  useEffect(() => {
    console.log(reload);
    // Check if Metamask is available
    if (window.ethereum && reload) {
      const web3 = new Web3(window.ethereum);

      // Function to update account and balance
      const updateAccountAndBalance = async () => {
        const accounts = await web3.eth.getAccounts();

        if (accounts.length > 0) {
          const selectedAccount = accounts[0];
          setAccount(selectedAccount);

          // Get ETH balance
          const ethBalance = await web3.eth.getBalance(selectedAccount);
          setBalance(web3.utils.fromWei(ethBalance, "ether"));

          localStorage.setItem("autoReload", true);
        } else {
          // No account found, handle as needed
          setAccount("No account found");
          setBalance(0);
          localStorage.setItem("autoReload", false);
        }
      };

      // Initial account check
      updateAccountAndBalance();

      // Listen for account changes
      window.ethereum.on("accountsChanged", () => {
        updateAccountAndBalance();
        localStorage.setItem("autoReload", false);
        localStorage.setItem('acountAddress', account);
        window.location.reload();
      });
    } else {
      console.log("Metamask is not installed.");
    }
  }, []);

  const btnhandler = () => {
    // Asking if metamask is already present or not
    if (window.ethereum) {
      // res[0] for fetching a first wallet
      window.ethereum
        .request({ method: "eth_requestAccounts" })
        .then((res) => accountChangeHandler(res[0]))
        .catch((error) => {
          console.log("no error");
        });
    } else {
      alert("install metamask extension!!");
    }
  };

  // getbalance function for getting a balance in
  // a right format with help of ethers
  const getbalance = (address) => {
    // Requesting balance method
    window.ethereum
      .request({
        method: "eth_getBalance",
        params: [address, "latest"],
      })
      .then((balance) => {
        // Setting balance
        setBalance(ethers.utils.formatEther(balance));
      })
      .catch((error) => {
        console.log("no error");
      });

    localStorage.setItem("autoReload", true);
    localStorage.setItem('acountAddress', address);
  };

  // Function for getting handling all events
  const accountChangeHandler = (account) => {
    // Setting an address data
    setAccount(account);

    // Setting a balance
    getbalance(account);
  };

  function handleABXButtonClick() {
    navigate("/buyabx");
  }
  function createCommunity() {
    navigate("/createCommunity");
  }
  return (
    <div className="App">
      <h1>Metamask Wallet</h1>
      <p>Connected Account: {account}</p>
      <p>Balance: {balance} ETH</p>
      <button onClick={btnhandler}>Connect</button>
      <button onClick={handleABXButtonClick}>Import ABX Token</button>
      <button onClick={createCommunity}>Create Community</button>
    </div>
  );
};

export default Home;
