import React from "react";

const Footer: React.FC = () => {
  return (
    <div className="bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white p-4 flex justify-between items-center h-20 shadow-lg">
      <div className="overflow-hidden whitespace-nowrap w-full">
        <div className="animate-marquee text-2xl font-semibold text-shadow">
          Selamat datang di layanan antrian kami! Harap bersabar dan tunggu
          nomor antrian Anda dipanggil.
        </div>
      </div>
    </div>
  );
};

export default Footer;
