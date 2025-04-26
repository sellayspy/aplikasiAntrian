import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router";
import Swal from "sweetalert2";
import echo from "../../../config/echo";

const PanggilAntrian: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();

  if (!location.state || !location.state.layar || !location.state.kategori) {
    console.error("State tidak ditemukan atau tidak lengkap!");
    navigate("/daftar-antrian");
    return null;
  }

  const { layar, kategori } = location.state;

  const [antrianSekarang, setAntrianSekarang] = useState<string | null>(null);
  const [listAntrian, setListAntrian] = useState<string[]>([]);
  const [tujuanAntrian, setTujuanAntrian] = useState<string>("");
  const [totalAntrian, setTotalAntrian] = useState<number>(0);
  const [selesaiAntrian, setSelesaiAntrian] = useState<string[]>([]);
  const [sisaAntrian, setSisaAntrian] = useState<number>(0);
  const [showPanggilAntrian, setShowPanggilAntrian] = useState<boolean>(false);
  const [searchTerm, setSearchTerm] = useState<string>("");
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [loading, setLoading] = useState<boolean>(true);
  const itemsPerPage = 8;

  const fetchAntrianData = () => {
    fetch(
      `http://127.0.0.1:8000/api/antrian-panggil-detail?layar=${layar}&kategori=${kategori}`
    )
      .then((response) => response.json())
      .then((data) => {
        setAntrianSekarang(data.data.antrian_sekarang || 0);
        setListAntrian(data.data.menunggu_antrian || []);
        setSelesaiAntrian(data.data.selesai_antrian || []);
        setSisaAntrian(data.data.sisa_antrian || 0);
        setTujuanAntrian(data.data.nama_antrian || "");
        setTotalAntrian(data.data.jumlah_antrian || 0);

        setLoading(false);
      })
      .catch((error: any) => {
        setLoading(false);
      });
  };

  useEffect(() => {
    const channel = echo.channel("antrian");
    channel.listen(".AntrianUpdated", (e: any) => {
      const eventData = e.data || e;
      setAntrianSekarang(eventData.antrian_sekarang);
      setSisaAntrian(eventData.sisa_antrian ?? null);
      setListAntrian(eventData.menunggu_antrian || []);
      setSelesaiAntrian(eventData.selesai_antrian || []);

      if (eventData.sisa_antrian === 0) {
        Swal.fire({
          icon: "warning",
          title: "Antrian Habis",
          text: "Tidak ada lagi antrian yang tersisa untuk kategori ini.",
          confirmButtonText: "OK",
        });
      }
    });

    channel.error((err: any) => {
      console.error("Error di channel antrian:", err);
    });

    const normalizedLayar = layar.replace(" ", "-");
    console.log("Mendengarkan channel:", `antrian.${normalizedLayar}`);
    const antrianChannel = echo.channel(`antrian.${normalizedLayar}`);
    antrianChannel.listen(".antrian.diambil", (e: any) => {
      const eventData = e.data || e;
      console.log("Event Antrian.diambil diterima:", eventData);
      setSisaAntrian(eventData.sisaAntrian);
      setTotalAntrian(eventData.jumlahAntrian);
    });

    antrianChannel.error((err: any) => {
      console.error("Error di channel antrian layar:", err);
    });

    return () => {
      console.log("Cleanup: Meninggalkan channel antrian");
      echo.leave("antrian");
    };
  }, []);

  useEffect(() => {
    fetchAntrianData();
  }, [layar, kategori]);

  const PanggilAntrian = () => {
    fetch(`http://127.0.0.1:8000/api/panggil-next-antrian`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        layar: layar,
        kategori: kategori,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log("Data panggil antrian:", data);
        if (data.status === "success") {
          setAntrianSekarang(data.data.antrian_sekarang);
          setSisaAntrian(data.data.sisa_antrian);
          console.log("Updated sisaAntrian:", data.data.sisa_antrian);

          if (data.data.sisa_antrian === 0) {
            Swal.fire({
              icon: "warning",
              title: "Antrian Habis",
              text: "Tidak ada antrian tersisa",
              confirmButtonText: "OK",
            });
          }
        } else {
          console.error("Gagal memanggil antrian:", data);
        }
      })
      .catch((error) => {
        console.error("Error calling next queue:", error);
      });
  };

  const PanggilAntrianUlang = (antrian: string) => {
    fetch("http://127.0.0.1:8000/api/panggil-ulang-antrian", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        layar: layar,
        kategori: kategori,
        nomorPanggil: antrian,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log("Data panggil ulang antrian:", data);
      })
      .catch((error) => {
        console.error("Error recalling missed queue:", error);
      });
  };

  const HandleClickShow = () => {
    setShowPanggilAntrian(!showPanggilAntrian);
  };

  const filterAntrian = selesaiAntrian.filter((queue) =>
    queue.toLowerCase().includes(searchTerm.toLowerCase())
  );
  const totalPages = Math.ceil(filterAntrian.length / itemsPerPage);
  const displayAntrian = filterAntrian.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  if (loading) {
    return <div className="p-6 text-center">Memuat data...</div>;
  }

  console.log(
    "Render UI - antrianSekarang:",
    antrianSekarang,
    "sisaAntrian:",
    sisaAntrian,
    "jumlahAntrian:",
    totalAntrian
  );
  return (
    <div className="flex items-center justify-center bg-gray-100">
      <div className="bg-white p-8 rounded-lg shadow-lg w-full">
        <h1 className="text-4xl font-bold mb-2 text-center">{layar}</h1>
        <h1 className="text-3xl font-bold mb-4 text-center">
          Panggil Antrian {kategori}
        </h1>

        <div className="mb-8 text-center">
          <h2 className="text-2xl font-semibold mb-4">Sedang Dipanggil</h2>
          <div className="text-6xl font-bold bg-blue-100 p-6 rounded-lg">
            {antrianSekarang || "-"}
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-green-100 p-4 rounded-lg text-center">
            <h3 className="text-xl font-semibold">Sisa Antrian</h3>
            <p className="text-3xl font-bold">{sisaAntrian}</p>
          </div>
          <div className="bg-yellow-100 p-4 rounded-lg text-center">
            <h3 className="text-xl font-semibold">Jumlah Antrian</h3>
            <p className="text-3xl font-bold">{totalAntrian}</p>
          </div>
          <div className="bg-red-100 p-4 rounded-lg text-center">
            <h3 className="text-xl font-semibold">Tujuan Antrian</h3>
            <p className="text-2xl font-bold">{tujuanAntrian}</p>
          </div>
        </div>

        <div className="mb-8">
          <h2 className="text-2xl font-semibold mb-4">
            Antrian yang Sudah Terpanggil
          </h2>
          <button
            onClick={HandleClickShow}
            className="bg-gray-200 px-4 py-2 rounded-lg mb-4 hover:bg-gray-300 transition duration-300"
          >
            {showPanggilAntrian ? "Sembunyikan" : "Tampilkan"} Daftar
          </button>
          {showPanggilAntrian && (
            <>
              <input
                type="text"
                placeholder="Cari antrian..."
                className="w-full p-2 mb-4 border rounded-lg"
                onChange={(e) => setSearchTerm(e.target.value)}
              />
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 max-h-64 overflow-y-auto">
                {displayAntrian.map((antrian, index) => (
                  <div
                    key={index}
                    className="bg-gray-100 p-3 rounded-lg text-center cursor-pointer hover:bg-gray-200 transition duration-300"
                    onClick={() => PanggilAntrianUlang(antrian)}
                  >
                    <span className="text-xl font-bold">{antrian}</span>
                  </div>
                ))}
              </div>
              <div className="flex justify-center mt-4">
                <button
                  className="px-4 py-2 mx-1 bg-gray-300 rounded-lg disabled:opacity-50"
                  disabled={currentPage === 1}
                  onClick={() => setCurrentPage(currentPage - 1)}
                >
                  Prev
                </button>
                <span className="px-4 py-2">
                  {currentPage} / {totalPages || 1}
                </span>
                <button
                  className="px-4 py-2 mx-1 bg-gray-300 rounded-lg disabled:opacity-50"
                  disabled={currentPage === totalPages}
                  onClick={() => setCurrentPage(currentPage + 1)}
                >
                  Next
                </button>
              </div>
            </>
          )}
        </div>

        <div className="flex justify-center gap-4">
          <button
            onClick={PanggilAntrian}
            className="bg-blue-500 text-white px-6 py-3 rounded-lg hover:bg-blue-600 transition duration-300"
          >
            Panggil Berikutnya
          </button>
          <button
            onClick={() =>
              antrianSekarang && PanggilAntrianUlang(antrianSekarang)
            }
            className="bg-green-500 text-white px-6 py-3 rounded-lg hover:bg-green-600 transition duration-300"
          >
            Panggil Ulang
          </button>
        </div>
      </div>
    </div>
  );
};

export default PanggilAntrian;
