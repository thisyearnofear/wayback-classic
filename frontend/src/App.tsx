import React from "react";
import { Routes, Route, Link } from "react-router-dom";

const navLink =
  "px-3 py-1 mx-1 text-xs font-retro border rounded border-retroAccent bg-retroAccent/20 hover:bg-retroAccent/50 transition";

function RetroHeader() {
  return (
    <header className="w-full bg-retroHeader text-retroAccent flex items-center gap-4 px-8 py-4 border-b-4 border-retroAccent shadow-retro">
      <img
        src="/favicon.ico"
        alt="Retro Logo"
        className="w-8 h-8 mr-3"
        style={{ imageRendering: "pixelated" }}
      />
      <div>
        <h1 className="text-xl font-retro tracking-widest mb-1">Wayback Mall</h1>
        <div className="text-xs font-retro text-retroAccent/80">
          AI &amp; Onchain Social Commerce – Retro Edition
        </div>
      </div>
      <nav className="ml-auto flex items-center">
        <Link className={navLink} to="/">Home</Link>
        <Link className={navLink} to="/product">Product</Link>
        <Link className={navLink} to="/agent">Agent</Link>
        <Link className={navLink} to="/profile">Profile</Link>
      </nav>
    </header>
  );
}

function LegacyLanding() {
  return (
    <div className="w-full flex justify-center items-center py-10 bg-retroBg min-h-[70vh]">
      <iframe
        src="/index.html"
        title="Legacy Landing"
        className="w-[900px] h-[650px] border-4 border-retroHeader shadow-retro bg-white"
        style={{ background: "#fff" }}
      />
    </div>
  );
}

// Placeholder components for future routes
const Product = () => <div className="font-retro p-8 text-lg">Product Page Coming Soon</div>;
const Agent = () => <div className="font-retro p-8 text-lg">AI Agent Dashboard Coming Soon</div>;
const Profile = () => <div className="font-retro p-8 text-lg">Profile Page Coming Soon</div>;

const App: React.FC = () => (
  <div className="min-h-screen font-retro bg-retroBg">
    <RetroHeader />
    <Routes>
      <Route path="/" element={<LegacyLanding />} />
      <Route path="/product" element={<Product />} />
      <Route path="/agent" element={<Agent />} />
      <Route path="/profile" element={<Profile />} />
    </Routes>
  </div>
);

export default App;