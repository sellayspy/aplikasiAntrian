import React from "react";

interface ButtonAmbilAntrianProps {
  antrianData: {
    nama_layar: string;
    kategori: Array<{
      nama_kategori: string;
      tujuan_antrian: string;
      sisa_antrian: number;
      urut: number;
    }>;
  } | null;
  setAntrianData: React.Dispatch<React.SetStateAction<any>>;
}

const ButtonAmbilAntrian: React.FC<ButtonAmbilAntrianProps> = ({
  antrianData,
  setAntrianData,
}) => {
  if (!antrianData || !antrianData.kategori) {
    return <div>Data tidak tersedia</div>;
  }

  const getButtonStyles = (index: number) => {
    const styles = [
      "bg-gradient-to-r from-blue-500 to-blue-700 hover:from-blue-600 hover:to-blue-800",
      "bg-gradient-to-r from-green-500 to-green-700 hover:from-green-600 hover:to-green-800",
      "bg-gradient-to-r from-purple-500 to-purple-700 hover:from-purple-600 hover:to-purple-800",
    ];
    return styles[index % styles.length];
  };

  const handleAmbilAntrian = async (namaKategori: string) => {
    try {
      const response = await fetch("http://localhost:8000/api/ambil-antrian", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          layar: antrianData.nama_layar,
          kategori: namaKategori,
        }),
      });

      const result = await response.json();

      if (response.ok) {
        const updateKategori = antrianData.kategori.map((item: any) =>
          item.nama_kategori === namaKategori
            ? { ...item, sisa_antrian: item.sisa_antrian + 1 }
            : item
        );
        setAntrianData({ ...antrianData, kategori: updateKategori });
      } else {
        alert(`Gagal mengambil antrian: ${result.message}`);
      }
    } catch (error) {
      console.error("Error saat mengambil antrian:", error);
      alert("Terjadi kesalahan saat menghubungi server.");
    }
  };

  return (
    <div className="bg-white rounded-xl shadow-xl p-8 w-full max-w-5xl transform transition-all">
      {/* Header */}
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold text-gray-800 tracking-wide">
          Silahkan Ambil Antrian - {antrianData.nama_layar}
        </h1>
        <p className="text-gray-500 mt-2">Pilih jenis layanan di bawah ini</p>
      </div>

      {/* Button Container */}
      <div className="flex flex-col md:flex-row justify-center gap-8">
        {antrianData.kategori.map((item, index) => (
          <button
            key={item.urut}
            onClick={() => handleAmbilAntrian(item.nama_kategori)}
            className={`${getButtonStyles(
              index
            )} text-white font-semibold w-48 h-48 rounded-lg flex flex-col items-center transition-all duration-300 shadow-md hover:shadow-lg`}
          >
            <div className="w-full bg-white/30 text-white text-sm font-medium py-2 rounded-t-lg">
              Tujuan: {item.tujuan_antrian}
            </div>
            <div className="flex flex-col items-center justify-center gap-2 flex-grow p-4">
              <span className="text-lg font-medium text-center">
                {item.nama_kategori}
              </span>
              <div className="flex items-center gap-1 bg-white/20 px-2 py-1 rounded-md">
                <span className="text-sm font-semibold">Sisa:</span>
                <span className="text-sm font-bold">{item.sisa_antrian}</span>
              </div>
            </div>
          </button>
        ))}
      </div>
    </div>
  );
};

export default ButtonAmbilAntrian;
