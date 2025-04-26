import React from "react";

interface AntrianDipanggilProps {
  antrian: {
    nama_kategori?: string;
    nama_tujuan?: string;
    awalan_panggil?: string;
    nomor_panggil?: string;
    status?: string;
    waktu_panggil?: string | null;
  } | null;
}

const AntrianDipanggil: React.FC<AntrianDipanggilProps> = ({ antrian }) => {
  return (
    <div className="rounded-2xl border border-gray-200 bg-gray-100 dark:border-gray-800 dark:bg-gray-800 h-[50vh] flex flex-col p-0">
      {/* Header */}
      <div className="bg-blue-500 text-white rounded-t-lg px-4 py-3 w-full text-center">
        <span className="text-5xl font-semibold">NOMOR ANTRIAN</span>
      </div>

      {/* Nomor Antrian */}
      <div className="bg-white dark:bg-gray-700 p-4 w-full text-center flex-1 flex flex-col items-center justify-center gap-y-2">
        {antrian ? (
          <>
            <h1 className="text-9xl font-bold text-gray-800 dark:text-white">
              {antrian.awalan_panggil}
              {antrian.nomor_panggil}
            </h1>
            <span className="text-sm py-2 px-4 bg-green-500 text-white rounded-full font-semibold">
              {antrian.status} {/* Tampilkan status dari data */}
            </span>
          </>
        ) : (
          <h1 className="text-4xl font-bold text-gray-800 dark:text-white">
            --
          </h1>
        )}
      </div>

      {/* Nama Kategori */}
      <div className="bg-green-500 text-white rounded-lg px-4 py-2 mt-4 w-full text-center">
        <span className="text-5xl font-semibold">
          {antrian?.nama_tujuan
            ? antrian.nama_tujuan.toUpperCase()
            : "BELUM ADA"}
        </span>
      </div>
    </div>
  );
};

export default AntrianDipanggil;
