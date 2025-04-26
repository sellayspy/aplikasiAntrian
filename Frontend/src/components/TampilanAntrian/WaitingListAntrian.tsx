import React from "react";

interface AntrianItem {
  nama_kategori: string;
  nama_tujuan: string;
  awalan_panggil: string;
  nomor_panggil: number;
  status: string;
  waktu_panggil: string | null;
}

interface WaitingListAntrianProps {
  antrian: AntrianItem[];
}

const WaitingListAntrian: React.FC<WaitingListAntrianProps> = ({ antrian }) => {
  // Fungsi untuk menentukan warna berdasarkan nama_kategori
  const getCategoryStyles = (kategori: string) => {
    switch (kategori) {
      case "BPJS Racikan":
        return {
          bgColor: "bg-blue-100",
          headerBg: "bg-blue-500",
        };
      case "BPJS Non Racikan":
        return {
          bgColor: "bg-green-100",
          headerBg: "bg-green-500",
        };
      case "Pasien Umum Dan Asuransi":
        return {
          bgColor: "bg-yellow-100",
          headerBg: "bg-orange-500",
        };
      default:
        return {
          bgColor: "bg-gray-100",
          headerBg: "bg-gray-500",
        };
    }
  };

  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6">
      {antrian.length > 0 ? (
        antrian.map((item, index) => {
          const { bgColor, headerBg } = getCategoryStyles(item.nama_kategori);
          const nomorAntrian = `${item.awalan_panggil}${item.nomor_panggil}`;

          return (
            <div
              key={index}
              className={`rounded-2xl border border-gray-200 ${bgColor} dark:border-gray-800 dark:bg-gray-800 min-h-[200px] flex flex-col items-center justify-center p-0`}
            >
              <div
                className={`${headerBg} text-white rounded-t-lg px-4 py-2 w-full text-center`}
              >
                <span className="text-3xl font-semibold">
                  {item.nama_kategori}
                </span>
              </div>
              <div className="rounded-lg p-4 w-full text-center">
                <h1 className="text-8xl font-bold text-gray-800 dark:text-white/90">
                  {nomorAntrian}
                </h1>
              </div>
              <span className="mb-4 text-sm py-2 px-4 bg-blue-500 text-white rounded-full font-semibold">
                {item.status}
              </span>
            </div>
          );
        })
      ) : (
        <div className="col-span-full text-center text-gray-500">--</div>
      )}
    </div>
  );
};

export default WaitingListAntrian;
