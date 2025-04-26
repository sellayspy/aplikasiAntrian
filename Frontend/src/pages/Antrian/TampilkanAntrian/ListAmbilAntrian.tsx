import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router";

const ListAmbilAntrian: React.FC = () => {
  const [data, setData] = useState<
    {
      nama_layar: string;
      kategori: { nama_kategori: string; urut: number }[];
    }[]
  >([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    fetch("http://127.0.0.1:8000/api/daftar-layanan")
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
    <div className="bg-white min-h-screen p-6">
      <h1 className="text-2xl font-bold text-center mb-6">
        Daftar Layar Antrian
      </h1>
      <div className="space-y-4">
        {data.length > 0 ? (
          data.map((layar, index) => (
            <div key={index} className="bg-white shadow-lg rounded-lg p-6">
              <div className="inline-block bg-green-100 text-blue-800 text-2xl font-semibold px-3 py-1 rounded-full mb-4">
                {layar.nama_layar}
              </div>
              {layar.kategori.length > 0 ? (
                <div className="space-y-4">
                  {layar.kategori.map((kategori, idx) => (
                    <div key={idx} className="border-l-4 border-blue-500 pl-4">
                      <h3 className="text-lg font-medium">
                        {kategori.nama_kategori}
                      </h3>
                      <p className="text-gray-600">Urut: {kategori.urut}</p>
                    </div>
                  ))}
                </div>
              ) : (
                <p className="text-gray-500">Tidak ada kategori</p>
              )}
              <button
                onClick={() => {
                  console.log("Navigasi dengan state:", {
                    layar: layar.nama_layar,
                    kategori: layar.kategori,
                  });
                  navigate("/ambil-antrian", {
                    state: {
                      layar: layar.nama_layar,
                      kategori: layar.kategori,
                    },
                  });
                }}
                className="mt-4 bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition duration-300"
              >
                View
              </button>
            </div>
          ))
        ) : (
          <p className="text-gray-500 text-center">Tidak ada data</p>
        )}
      </div>
    </div>
  );
};

export default ListAmbilAntrian;
