import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router";

const ListPanggilAntrian: React.FC = () => {
  const [data, setData] = useState<
    {
      nama_layar: string;
      kategori: { nama_antrian_kategori: string; tujuan: string[] }[];
    }[]
  >([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    // Ganti dengan endpoint API Anda
    fetch("http://127.0.0.1:8000/api/antrian-panggil")
      .then((response) => response.json())
      .then((data) => {
        setData(data.data);
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return <div className="p-6 text-center">Memuat data...</div>;
  }

  return (
    <div className="bg-white min-h-screen">
      <h1 className="text-2xl font-bold text-center mb-6">
        Daftar Antrian Panggil
      </h1>
      <div className="space-y-4">
        {data.map((layar, index) => (
          <div key={index} className="bg-white shadow-lg rounded-lg p-6">
            <div className="inline-block bg-green-100 text-blue-800 text-2xl font-semibold px-3 py-1 rounded-full mb-4">
              {layar.nama_layar}
            </div>
            {layar.kategori.length > 0 ? (
              <div className="space-y-4">
                {layar.kategori.map((kategori, idx) => (
                  <div key={idx} className="border-l-4 border-blue-500 pl-4">
                    <h3 className="text-lg font-medium">
                      {kategori.nama_antrian_kategori}
                    </h3>
                    <div className="mt-2 space-y-2">
                      {kategori.tujuan.map((tujuan, i) => (
                        <p key={i} className="text-gray-600">
                          Tujuan: {tujuan}
                        </p>
                      ))}
                    </div>
                    <button
                      onClick={() => {
                        console.log("Navigasi dengan state:", {
                          layar: layar.nama_layar,
                          kategori: kategori.nama_antrian_kategori,
                        });
                        navigate("/panggil-antrian", {
                          state: {
                            layar: layar.nama_layar,
                            kategori: kategori.nama_antrian_kategori,
                          },
                        });
                      }}
                      className="mt-4 bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition duration-300"
                    >
                      View
                    </button>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-gray-500">Tidak ada kategori tersedia.</p>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

export default ListPanggilAntrian;
