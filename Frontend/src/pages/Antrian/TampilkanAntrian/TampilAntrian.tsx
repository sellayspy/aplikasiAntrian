import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router";
import Header from "../../../components/TampilanAntrian/Header";
import AntrianDipanggil from "../../../components/TampilanAntrian/AntrianDipanggil";
import VideoPlayer from "../../../components/TampilanAntrian/VideoPlayer";
import Footer from "../../../components/TampilanAntrian/Footer";
import WaitingListAntrian from "../../../components/TampilanAntrian/WaitingListAntrian";
import axios from "axios";
import echo from "../../../config/echo";

const TampilAntrian: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [antrianData, setAntrianData] = useState({
    sedang_dilayani: null,
    menunggu_berikutnya: [],
  });

  useEffect(() => {
    if (!location.state || !location.state.layar) {
      console.error("State tidak ditemukan atau tidak lengkap!");
      navigate("/daftar-antrian");
    }
  }, [location, navigate]);

  const { layar } = location.state || {};

  const fetchAntrianData = async (layar: string) => {
    try {
      const response = await axios.get(
        `http://127.0.0.1:8000/api/layar-antrian?layar=${layar}`
      );

      console.log("Full Response dari API:", response);

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
    const initialFetch = async () => {
      if (layar) {
        const data = await fetchAntrianData(layar);
        if (data) {
          setAntrianData(data);
        }
      }
    };
    initialFetch();

    echo.channel("antriandisplay").listen(".AntrianLayarUpdated", (e: any) => {
      const eventData = e.data || e;
      console.log("Event data dari Echo:", eventData);
      setAntrianData(eventData);
    });

    return () => {
      echo.leave("antriandisplay");
    };
  }, [layar]);

  console.log("State antrianData saat ini:", antrianData);

  return (
    <div className="flex flex-col min-h-screen bg-gray-100">
      <Header />
      <div className="flex-grow grid grid-cols-12 gap-3 md:gap-4 p-4">
        <div className="col-span-12 space-y-6 xl:col-span-4">
          <AntrianDipanggil antrian={antrianData.sedang_dilayani} />
        </div>
        <div className="col-span-12 xl:col-span-8 hidden sm:block">
          <VideoPlayer />
        </div>
      </div>
      <div className="p-4">
        <WaitingListAntrian antrian={antrianData.menunggu_berikutnya || []} />
      </div>
      <Footer />
    </div>
  );
};

export default TampilAntrian;
