// AmbilAntrian.tsx
import React, { useEffect, useState } from "react";
import Header from "../../../components/TampilanAntrian/Header";
import ButtonAmbilAntrian from "../../../components/AmbilAntrian/ButtonAmbilAntrian";
import Footer from "../../../components/TampilanAntrian/Footer";
import { useLocation, useNavigate } from "react-router";
import axios from "axios";
import echo from "../../../config/echo";

const AmbilAntrian: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [antrianData, setAntrianData] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  const { layar } = location.state || {};

  const fetchAntrianData = async () => {
    try {
      const response = await axios.get(
        `http://127.0.0.1:8000/api/daftar-layanan-detail?layar=${layar}`
      );

      if (!response.data || !response.data.data) {
        console.error("Data yang diterima tidak sesuai:", response.data);
        return null;
      }

      return response.data.data;
    } catch (error) {
      console.error("Error fetching antrian data:", error);
      return null;
    }
  };

  useEffect(() => {
    fetchAntrianData();
  });

  useEffect(() => {
    if (!location.state || !location.state.layar) {
      console.error("State tidak ditemukan atau tidak lengkap!");
      navigate("/daftar-ambil");
      return;
    }

    const loadData = async () => {
      setLoading(true);
      const data = await fetchAntrianData();
      setAntrianData(data);
      setLoading(false);
    };

    loadData();

    console.log("Menginisialisasi channel WebSocket untuk layar:", layar);
    const channel = echo.channel(`antrian.${layar}`);
    console.log("Channel berhasil dibuat:", channel);

    console.log("Mendaftarkan listener untuk event AntrianAmbilUpdated");
    channel.listen("AntrianAmbilUpdated", (e: any) => {
      console.log("Event AntrianAmbilUpdated diterima:", e);
      const eventData = e.data || e;
      console.log("Data event yang diproses:", eventData);
      setAntrianData({
        nama_layar: eventData.nama_layar,
        kategori: eventData.kategori || [],
      });
    });

    return () => {
      console.log("Membersihkan listener dan channel untuk layar:", layar);
      channel.stopListening("AntrianAmbilUpdated");
      echo.leaveChannel(`antrian.${layar}`);
    };
  }, [layar, navigate]);

  if (loading) {
    return (
      <div className="flex flex-col min-h-screen bg-gray-100">
        <Header />
        <div className="flex-grow flex items-center justify-center p-4">
          <div>Loading...</div>
        </div>
        <Footer />
      </div>
    );
  }

  return (
    <div className="flex flex-col min-h-screen bg-gray-100">
      <Header />
      <div className="flex-grow flex items-center justify-center p-4">
        <ButtonAmbilAntrian
          antrianData={antrianData}
          setAntrianData={setAntrianData}
        />
      </div>
      <Footer />
    </div>
  );
};

export default AmbilAntrian;
