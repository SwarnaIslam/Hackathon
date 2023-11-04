import React from "react";
import { Route, Routes } from "react-router-dom";
import Home from "./components/Home";
import BuyABX from "./components/BuyABX";
import Community from "./components/Community";

function App() {
  return (
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/buyabx" element={<BuyABX />} />
        <Route path="/createCommunity" element={<Community />} />
      </Routes>
  );
}

export default App;
