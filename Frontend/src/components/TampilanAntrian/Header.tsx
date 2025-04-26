import React, { useEffect, useState } from "react";

const Header: React.FC = () => {
  const [currentTime, setCurrentTime] = useState(new Date());

  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentTime(new Date());
    }, 1000);

    return () => clearInterval(timer);
  }, []);

  const formatTime = (date: Date) => {
    return date.toLocaleTimeString();
  };

  const formatDate = (date: Date) => {
    return date.toLocaleDateString("id-ID", {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
    });
  };
  return (
    <header className="bg-gradient-to-r from-blue-500 to-purple-600 text-white p-4 flex justify-between items-center h-20">
      <div className="flex items-center">
        <img src="" alt="Hospital" className="h-12 w-12 mr-4" />
        <h1 className="text-2xl font-bold">Rumah Sakit Jiwa</h1>
      </div>
      <div className="text-right">
        <div className="text-3xl font-semibold">{formatTime(currentTime)}</div>
        <div className="text-1xl">{formatDate(currentTime)}</div>
      </div>
    </header>
  );
};

export default Header;
