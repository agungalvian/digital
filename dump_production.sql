--
-- PostgreSQL database dump
--

\restrict yHTMEUGZPmZfHDPdt0wRvJ3DOPrjwA0aI3LINm8BVd1wvpJxN9zZocgB7dpZO4Z

-- Dumped from database version 15.15
-- Dumped by pg_dump version 15.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: aktivitas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.aktivitas VALUES ('act_6a3163d3ec773', 'FGD Integrasi Perpajakan', 'persiapan FGD Integrasi Perpajakan', 'Kolaborasi', '["Perpajakan"]', 'API Dokuman', 'ketepatan sasaran dan KSWP', 'Deputi Komisioner Bidang Pemanfaatan Dana Tapera | Direktorat Kerja Sama dan Kebijakan Pembiayaan', 'Dirjen Pajak, Kementerian Keuangan', 'Pemerintah Pusat', '2026-W27', '2026-W28', 'RESTful API (JSON)', 'Synchronous (Real-time P2P)', 'Kebocoran Data (Security)', 'Autentikasi OAuth 2.0 / JWT', '2026-06-16 16:55:15');


--
-- Data for Name: aspek; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.aspek VALUES ('A.001.001', 'A.001', 'A', 'Kelola perkumpulan Pusat', 'Aspek ini mencakup pengelolaan data, peran, koordinasi, dan tata kelola perkumpulan pada tingkat pusat sebagai simpul utama ekosistem supply perumahan. Fokusnya adalah memastikan standar, kebijakan operasional, dan mekanisme kolaborasi antar pelaku dapat berjalan seragam serta terdokumentasi dalam platform digital.');
INSERT INTO public.aspek VALUES ('A.001.002', 'A.001', 'A', 'Kelola perkumpulan Daerah', 'Aspek ini mencakup pengelolaan perkumpulan pada tingkat daerah untuk mendukung pelaksanaan program perumahan sesuai kondisi lokal. Kegiatan utamanya meliputi pendataan anggota, koordinasi lapangan, validasi kebutuhan daerah, serta penghubung antara kebijakan pusat dan implementasi di wilayah.');
INSERT INTO public.aspek VALUES ('A.002.001', 'A.002', 'A', 'Geometri BIM', 'Aspek geometri BIM berfungsi menyediakan model bangunan tiga dimensi yang memuat bentuk, ukuran, elemen, dan informasi teknis rumah atau kawasan hunian. Data ini menjadi dasar simulasi, pemeriksaan teknis, estimasi kebutuhan material, serta integrasi dengan proses perizinan dan pembangunan.');
INSERT INTO public.aspek VALUES ('A.002.002', 'A.002', 'A', 'Poligon GIS 2D', 'Aspek poligon GIS 2D mencakup penyediaan batas bidang, tapak, zona, atau kawasan dalam format spasial dua dimensi. Informasi ini digunakan untuk membaca posisi lahan, keterhubungan dengan tata ruang, akses infrastruktur, serta kesesuaian lokasi terhadap rencana pengembangan perumahan.');
INSERT INTO public.aspek VALUES ('A.002.003', 'A.002', 'A', 'Siteplan Latar', 'Aspek siteplan latar menyediakan rencana tata letak dasar yang menggambarkan hubungan antara bangunan, kavling, jalan, ruang terbuka, drainase, dan fasilitas pendukung. Data ini membantu proses penilaian awal kelayakan kawasan serta menjadi konteks visual bagi pemodelan BIM dan GIS.');
INSERT INTO public.aspek VALUES ('A.003.001', 'A.003', 'A', 'Aspek Ruang', 'Aspek aspek ruang memuat informasi mengenai pemanfaatan ruang, struktur kawasan, pola permukiman, dan keterhubungan antar fungsi lahan. Analisis ini digunakan untuk menilai kesesuaian rencana perumahan dengan kebutuhan pengembangan wilayah dan arah kebijakan tata ruang.');
INSERT INTO public.aspek VALUES ('A.003.002', 'A.003', 'A', 'Administrasi', 'Aspek administrasi memuat data batas wilayah, kode administrasi, kewenangan pemerintahan, serta struktur pengelolaan daerah. Informasi ini penting untuk memastikan setiap rencana, perizinan, dan program perumahan terhubung dengan lokasi serta instansi penanggung jawab yang tepat.');
INSERT INTO public.aspek VALUES ('A.003.003', 'A.003', 'A', 'Tata Ruang', 'Aspek tata ruang mencakup informasi rencana pola ruang, struktur ruang, zonasi, serta ketentuan pemanfaatan lahan yang berlaku. Data ini menjadi dasar untuk menilai kesesuaian kegiatan perumahan sebelum masuk ke proses perizinan dan pengambilan keputusan investasi.');
INSERT INTO public.aspek VALUES ('A.003.004', 'A.003', 'A', 'Legalitas', 'Aspek legalitas mencakup status penguasaan, kepemilikan, peruntukan, dan dokumen hukum atas lahan atau aset perumahan. Tujuannya adalah mengurangi risiko sengketa, memastikan kepastian hukum, dan mendukung proses transaksi maupun pengembangan rumah secara tertib.');
INSERT INTO public.aspek VALUES ('A.003.005', 'A.003', 'A', 'Lingkungan', 'Aspek lingkungan memuat kondisi daya dukung, daya tampung, kawasan lindung, potensi dampak, dan persyaratan pengelolaan lingkungan. Data ini membantu memastikan pengembangan perumahan tetap memperhatikan keberlanjutan, kualitas hidup, serta kepatuhan terhadap persetujuan lingkungan.');
INSERT INTO public.aspek VALUES ('A.003.006', 'A.003', 'A', 'Kebencanaan', 'Aspek kebencanaan mencakup informasi risiko banjir, longsor, gempa, kebakaran, tsunami, dan ancaman lain yang relevan dengan lokasi perumahan. Analisis ini digunakan untuk menentukan mitigasi, standar desain, prioritas intervensi, dan kelayakan kawasan hunian.');
INSERT INTO public.aspek VALUES ('A.003.007', 'A.003', 'A', 'Topografi', 'Aspek topografi memuat data kontur, elevasi, kemiringan lahan, dan karakter permukaan kawasan. Informasi ini menjadi dasar dalam perencanaan tapak, desain drainase, pengendalian pekerjaan tanah, serta estimasi biaya pembangunan perumahan.');
INSERT INTO public.aspek VALUES ('A.003.008', 'A.003', 'A', 'Transportasi', 'Aspek transportasi mencakup jaringan jalan, akses angkutan umum, konektivitas kawasan, jarak ke pusat layanan, dan potensi pergerakan penghuni. Data ini digunakan untuk menilai kemudahan akses, biaya mobilitas, serta kelayakan lokasi perumahan bagi berbagai kelompok masyarakat.');
INSERT INTO public.aspek VALUES ('A.003.009', 'A.003', 'A', 'Prasarana dan Utilitas Kawasan', 'Aspek prasarana dan utilitas kawasan memuat ketersediaan serta kapasitas jalan lingkungan, drainase, sanitasi, air minum, listrik, persampahan, dan fasilitas pendukung lainnya. Informasi ini digunakan untuk memastikan kawasan perumahan dapat dihuni secara layak dan terintegrasi dengan layanan dasar.');
INSERT INTO public.aspek VALUES ('A.003.010', 'A.003', 'A', 'Sosial dan Ekonomi', 'Aspek sosial dan ekonomi mencakup profil penduduk, kemampuan ekonomi, mata pencaharian, akses layanan, dan dinamika komunitas pada suatu wilayah. Data ini membantu menyelaraskan skema penyediaan rumah dengan kebutuhan nyata, daya beli, serta karakter masyarakat sasaran.');
INSERT INTO public.aspek VALUES ('A.003.011', 'A.003', 'A', 'Iklim', 'Aspek iklim memuat data curah hujan, suhu, kelembaban, arah angin, dan kondisi mikroklimat yang memengaruhi desain rumah serta kawasan. Informasi ini digunakan untuk mendorong perencanaan hunian yang nyaman, hemat energi, dan tahan terhadap perubahan iklim.');
INSERT INTO public.aspek VALUES ('A.003.012', 'A.003', 'A', 'Kawasan Khusus', 'Aspek kawasan khusus mencakup area dengan karakter atau ketentuan tertentu seperti kawasan strategis, kawasan rawan, kawasan perbatasan, kawasan adat, atau kawasan dengan pengaturan sektoral. Data ini memastikan rencana perumahan memperhatikan batasan, peluang, dan prosedur khusus yang berlaku.');
INSERT INTO public.aspek VALUES ('A.004.001', 'A.004', 'A', 'Arsitektur', 'Aspek arsitektur memuat informasi desain bentuk, tampilan, tata ruang, bukaan, akses, dan kualitas hunian dalam model BIM. Data ini digunakan untuk menilai fungsi, kenyamanan, keterbangunan, serta kesesuaian desain rumah dengan standar teknis dan kebutuhan penghuni.');
INSERT INTO public.aspek VALUES ('A.004.002', 'A.004', 'A', 'Struktur', 'Aspek struktur mencakup elemen fondasi, kolom, balok, pelat, rangka, dan komponen penahan beban bangunan. Informasi ini digunakan untuk memeriksa keamanan, kekuatan, stabilitas, serta kesesuaian konstruksi terhadap standar bangunan gedung.');
INSERT INTO public.aspek VALUES ('A.004.003', 'A.004', 'A', 'Ruang', 'Aspek ruang memuat pembagian fungsi ruang, luasan, hubungan antar ruang, sirkulasi, dan kapasitas penggunaan bangunan. Data ini membantu memastikan rumah atau bangunan hunian memenuhi kebutuhan aktivitas penghuni secara layak, efisien, dan mudah dievaluasi.');
INSERT INTO public.aspek VALUES ('A.004.004', 'A.004', 'A', 'Utilitas Bangunan', 'Aspek utilitas bangunan mencakup jaringan listrik, air bersih, air kotor, drainase, ventilasi, proteksi kebakaran, dan sistem pendukung lainnya. Informasi ini digunakan untuk memastikan bangunan dapat beroperasi dengan aman, sehat, dan siap terhubung dengan prasarana kawasan.');
INSERT INTO public.aspek VALUES ('A.004.005', 'A.004', 'A', 'Lantai Bangunan', 'Aspek lantai bangunan memuat informasi jumlah lantai, elevasi, fungsi tiap lantai, dan hubungan vertikal antar ruang. Data ini membantu pemeriksaan desain, perhitungan luas, aksesibilitas, keselamatan, serta kesesuaian bangunan dengan ketentuan teknis.');
INSERT INTO public.aspek VALUES ('A.004.006', 'A.004', 'A', 'Material', 'Aspek material mencakup jenis, spesifikasi, mutu, volume, dan asal material yang digunakan dalam bangunan. Informasi ini mendukung estimasi biaya, pengendalian kualitas, pemilihan material berkelanjutan, serta transparansi rantai pasok pembangunan rumah.');
INSERT INTO public.aspek VALUES ('A.004.007', 'A.004', 'A', 'Dimensi dan Volume', 'Aspek dimensi dan volume memuat ukuran elemen bangunan, luasan ruang, volume pekerjaan, dan parameter kuantitatif lain dari model BIM. Data ini menjadi dasar perhitungan kebutuhan material, biaya, jadwal pekerjaan, serta pemeriksaan kesesuaian desain.');
INSERT INTO public.aspek VALUES ('A.004.008', 'A.004', 'A', 'Fungsi Bangunan', 'Aspek fungsi bangunan menjelaskan peruntukan, kapasitas, pola penggunaan, dan hubungan bangunan dengan kebutuhan hunian atau layanan kawasan. Informasi ini digunakan untuk memastikan desain dan operasi bangunan sesuai dengan tujuan program perumahan.');
INSERT INTO public.aspek VALUES ('A.004.009', 'A.004', 'A', 'Keselamatan Bangunan', 'Aspek keselamatan bangunan mencakup aspek evakuasi, proteksi kebakaran, kekuatan struktur, akses darurat, dan pengendalian risiko bagi penghuni. Data ini digunakan untuk mendukung pemeriksaan teknis agar bangunan layak, aman, dan memenuhi ketentuan keselamatan.');
INSERT INTO public.aspek VALUES ('A.004.010', 'A.004', 'A', 'Operasi dan Pemeliharaan', 'Aspek operasi dan pemeliharaan memuat informasi yang diperlukan untuk mengelola bangunan setelah selesai dibangun, termasuk aset, jadwal perawatan, komponen kritis, dan catatan teknis. Tujuannya adalah menjaga kualitas layanan hunian dan memperpanjang umur bangunan.');
INSERT INTO public.aspek VALUES ('A.004.011', 'A.004', 'A', 'Kuantitas Pekerjaan', 'Aspek kuantitas pekerjaan mencakup daftar pekerjaan, volume, satuan, dan kebutuhan pelaksanaan yang diturunkan dari model teknis. Informasi ini menjadi dasar penyusunan rencana anggaran, pengadaan, pengawasan konstruksi, dan evaluasi progres pembangunan.');
INSERT INTO public.aspek VALUES ('A.005.001', 'A.005', 'A', 'geometri BIM', 'Aspek geometri BIM pada dokumen teknis perizinan menyediakan model bangunan yang siap digunakan sebagai lampiran digital untuk pemeriksaan teknis. Data ini membantu mempercepat validasi bentuk, ukuran, elemen bangunan, dan kesesuaian desain dalam proses persetujuan.');
INSERT INTO public.aspek VALUES ('A.005.002', 'A.005', 'A', 'Poligon GIS 2D', 'Aspek poligon GIS 2D pada dokumen teknis perizinan menyediakan batas spasial lokasi, bidang, atau kawasan yang menjadi objek permohonan. Informasi ini membantu instansi terkait memeriksa posisi, luasan, tata ruang, dan keterkaitan lokasi dengan data wilayah.');
INSERT INTO public.aspek VALUES ('A.005.003', 'A.005', 'A', 'Siteplan Latar', 'Aspek siteplan latar pada dokumen teknis perizinan memuat tata letak bangunan dan fasilitas pendukung sebagai konteks pemeriksaan. Data ini memudahkan penilaian hubungan antara kavling, akses jalan, prasarana, ruang terbuka, dan utilitas kawasan.');
INSERT INTO public.aspek VALUES ('A.006.001', 'A.006', 'A', 'Integrasi KKPR (Kesesuaian Kegiatan Pemanfaatan Ruang)', 'Aspek integrasi KKPR menghubungkan data rencana perumahan dengan proses penilaian kesesuaian kegiatan pemanfaatan ruang. Integrasi ini memastikan lokasi dan kegiatan yang diajukan dapat diverifikasi terhadap ketentuan tata ruang secara digital dan tertelusur.');
INSERT INTO public.aspek VALUES ('A.006.002', 'A.006', 'A', 'Integrasi PL (Persetujuan Lingkungan)', 'Aspek integrasi PL menghubungkan rencana pembangunan perumahan dengan proses persetujuan lingkungan. Data yang terintegrasi membantu menilai potensi dampak, kebutuhan pengelolaan lingkungan, serta kepatuhan terhadap ketentuan keberlanjutan.');
INSERT INTO public.aspek VALUES ('A.006.003', 'A.006', 'A', 'Integrasi PBG (Persetujuan Bangunan Gedung)', 'Aspek integrasi PBG menghubungkan dokumen teknis bangunan dengan proses persetujuan bangunan gedung. Tujuannya adalah mempercepat pemeriksaan arsitektur, struktur, utilitas, keselamatan, dan kelengkapan teknis melalui data digital yang konsisten.');
INSERT INTO public.aspek VALUES ('A.006.004', 'A.006', 'A', 'Integrasi SLF (Sertifikat Laik Fungsi)', 'Aspek integrasi SLF menghubungkan data bangunan terbangun dengan proses sertifikasi laik fungsi. Informasi ini digunakan untuk menilai kesiapan operasi, keselamatan, kesehatan, kenyamanan, dan kesesuaian bangunan sebelum dimanfaatkan oleh penghuni.');
INSERT INTO public.aspek VALUES ('A.007.001', 'A.007', 'A', 'Pembiayaan Rumah Baru (KPR)', 'Aspek pembiayaan rumah baru melalui KPR mencakup pengelolaan penawaran, persyaratan, kelayakan calon pembeli, dan hubungan dengan lembaga pembiayaan. Skema ini membantu masyarakat mengakses rumah baru melalui mekanisme kredit yang terdata dan dapat dipantau.');
INSERT INTO public.aspek VALUES ('A.007.002', 'A.007', 'A', 'Pembiayaan Rumah Perlalihan (KRP)', 'Aspek pembiayaan rumah peralihan melalui KRP mencakup dukungan pembiayaan untuk transaksi rumah yang berpindah kepemilikan atau status penguasaan. Data ini membantu memastikan proses peralihan rumah berjalan tertib, layak secara finansial, dan sesuai ketentuan program.');
INSERT INTO public.aspek VALUES ('A.007.003', 'A.007', 'A', 'Pembiayaan Renovasi Rumah (KRR)', 'Aspek pembiayaan renovasi rumah melalui KRR mencakup dukungan pendanaan untuk perbaikan, peningkatan kualitas, atau penyesuaian fungsi rumah. Skema ini ditujukan agar rumah eksisting dapat menjadi lebih layak huni, aman, dan sesuai kebutuhan penghuni.');
INSERT INTO public.aspek VALUES ('A.007.004', 'A.007', 'A', 'Pembiayaan Bangun Rumah Baru (KBR)', 'Aspek pembiayaan bangun rumah baru melalui KBR mencakup dukungan bagi masyarakat yang membangun rumah di lahan sendiri atau lokasi yang telah memenuhi syarat. Data Aspek ini menghubungkan kelayakan lahan, rencana teknis, kebutuhan biaya, dan sumber pembiayaan.');
INSERT INTO public.aspek VALUES ('A.007.005', 'A.007', 'A', 'Kelola Penjualan Rumah Tapak', 'Aspek kelola penjualan rumah tapak mencakup pendataan unit, harga, status ketersediaan, legalitas, dan proses transaksi rumah tapak. Informasi ini memudahkan calon penghuni, pengembang, dan pemerintah memantau pasokan rumah yang siap dipasarkan.');
INSERT INTO public.aspek VALUES ('A.007.006', 'A.007', 'A', 'Kelola Penjualan Rumah Susun', 'Aspek kelola penjualan rumah susun mencakup pengelolaan unit vertikal, status kepemilikan, fasilitas bersama, harga, dan proses transaksi. Data ini mendukung transparansi pasokan hunian susun serta memudahkan pencocokan dengan kebutuhan kelompok sasaran.');
INSERT INTO public.aspek VALUES ('A.007.007', 'A.007', 'A', 'Kelola Rumah Sewa Susun', 'Aspek kelola rumah sewa susun mencakup pengelolaan unit sewa, penghuni, tarif, masa sewa, fasilitas, dan pemeliharaan rumah susun. Tujuannya adalah memastikan hunian sewa vertikal dapat dikelola tertib, terjangkau, dan berkelanjutan.');
INSERT INTO public.aspek VALUES ('A.007.008', 'A.007', 'A', 'Kelola Rumah Sewa Tapak', 'Aspek kelola rumah sewa tapak mencakup pendataan unit rumah tapak yang disewakan, pemilik, penghuni, tarif, masa sewa, dan kondisi bangunan. Informasi ini mendukung penyediaan pilihan hunian sewa yang layak bagi masyarakat yang belum siap membeli rumah.');
INSERT INTO public.aspek VALUES ('A.007.009', 'A.007', 'A', 'Kelola Rumah Sosial', 'Aspek kelola rumah sosial mencakup pengelolaan hunian bagi kelompok rentan atau masyarakat yang membutuhkan dukungan khusus. Data ini membantu menentukan sasaran, pola bantuan, status pemanfaatan, dan keberlanjutan layanan hunian sosial.');
INSERT INTO public.aspek VALUES ('A.007.010', 'A.007', 'A', 'Kelola Rumah bencana', 'Aspek kelola rumah bencana mencakup penyediaan, pendataan, dan pengelolaan hunian bagi masyarakat terdampak bencana. Informasi ini mendukung respon cepat, rehabilitasi, relokasi, serta pemulihan hunian secara terkoordinasi.');
INSERT INTO public.aspek VALUES ('A.007.011', 'A.007', 'A', 'Dana Stimulan Rumah', 'Aspek dana stimulan rumah mencakup pengelolaan bantuan atau insentif yang diberikan untuk mendorong pembangunan, perbaikan, atau peningkatan kualitas rumah. Data ini digunakan untuk memastikan sasaran tepat, nilai bantuan transparan, dan progres pemanfaatan dapat dipantau.');
INSERT INTO public.aspek VALUES ('A.008.001', 'A.008', 'A', 'Dana Bantuan PSU', 'Aspek dana bantuan PSU mencakup dukungan pembiayaan prasarana, sarana, dan utilitas umum pada kawasan perumahan. Bantuan ini diarahkan untuk meningkatkan kelayakan kawasan melalui penyediaan jalan, drainase, air, sanitasi, listrik, dan fasilitas pendukung lainnya.');
INSERT INTO public.aspek VALUES ('A.009.001', 'A.009', 'A', 'Material', 'Aspek material mencakup pengelolaan informasi bahan bangunan, spesifikasi, ketersediaan, harga, mutu, dan sumber pasok. Data ini membantu pengendalian biaya, pemilihan material yang sesuai standar, serta penguatan rantai pasok pembangunan perumahan.');
INSERT INTO public.aspek VALUES ('A.009.002', 'A.009', 'A', 'Jasa', 'Aspek jasa mencakup pendataan penyedia layanan perencanaan, konstruksi, pengawasan, konsultansi, pemeliharaan, dan layanan pendukung lainnya. Informasi ini membantu mempertemukan kebutuhan proyek perumahan dengan pelaku jasa yang kompeten dan terverifikasi.');
INSERT INTO public.aspek VALUES ('A.010.001', 'A.010', 'A', 'Listrik', 'Aspek listrik mencakup ketersediaan jaringan, kapasitas daya, kebutuhan sambungan, status layanan, dan koordinasi dengan penyedia tenaga listrik. Data ini memastikan rumah dan kawasan perumahan dapat memperoleh layanan energi yang aman dan memadai.');
INSERT INTO public.aspek VALUES ('A.010.002', 'A.010', 'A', 'Air', 'Aspek air mencakup ketersediaan sumber air, jaringan distribusi, kapasitas layanan, kualitas air, dan kebutuhan sambungan. Informasi ini menjadi dasar pemenuhan layanan air bersih bagi rumah, kawasan hunian, dan fasilitas pendukung.');
INSERT INTO public.aspek VALUES ('A.011.001', 'A.011', 'A', 'Rumah Susun', 'Aspek rumah susun dalam manajemen properti mencakup pengelolaan unit, penghuni, fasilitas bersama, iuran, pemeliharaan, keamanan, dan administrasi hunian vertikal. Tujuannya adalah menjaga keberfungsian bangunan serta kualitas hidup penghuni secara berkelanjutan.');
INSERT INTO public.aspek VALUES ('A.011.002', 'A.011', 'A', 'Rumah Tapak', 'Aspek rumah tapak dalam manajemen properti mencakup pengelolaan data unit, penghuni, lingkungan, pemeliharaan, layanan kawasan, dan administrasi hunian horizontal. Informasi ini membantu memastikan rumah tapak dan lingkungannya tetap tertata, aman, dan layak huni.');
INSERT INTO public.aspek VALUES ('B.001.001', 'B.001', 'B', 'APBN', 'Aspek APBN mencakup pengelolaan sumber pendanaan pemerintah pusat untuk program perumahan, termasuk alokasi, rencana kegiatan, penyaluran, dan pemantauan realisasi. Dana ini menjadi instrumen utama untuk mendukung prioritas nasional dalam penyediaan hunian layak.');
INSERT INTO public.aspek VALUES ('B.001.002', 'B.001', 'B', 'Non APBN', 'Aspek non APBN mencakup sumber dukungan pemerintah pusat di luar belanja APBN langsung, seperti skema kerja sama, dana bergulir, fasilitas, atau dukungan kelembagaan. Informasi ini memperluas pilihan pembiayaan program perumahan tanpa hanya bergantung pada anggaran reguler.');
INSERT INTO public.aspek VALUES ('B.002.001', 'B.002', 'B', 'APBD Provinsi', 'Aspek APBD Provinsi mencakup pendanaan pemerintah provinsi untuk mendukung program perumahan lintas kabupaten/kota atau prioritas kewilayahan. Data ini digunakan untuk menyelaraskan rencana provinsi dengan kebutuhan daerah dan target ekosistem perumahan.');
INSERT INTO public.aspek VALUES ('B.002.002', 'B.002', 'B', 'Non APBD Provinsi', 'Aspek non APBD Provinsi mencakup dukungan provinsi di luar anggaran langsung, seperti kerja sama daerah, pemanfaatan aset, kemitraan, atau fasilitasi program. Skema ini membantu memperluas kapasitas provinsi dalam mendorong layanan perumahan.');
INSERT INTO public.aspek VALUES ('B.003.001', 'B.003', 'B', 'APBD Kab-Kota', 'Aspek APBD Kab-Kota mencakup pendanaan pemerintah kabupaten/kota untuk kebutuhan perumahan yang dekat dengan masyarakat dan lokasi program. Data ini mendukung perencanaan, pelaksanaan, serta pengawasan intervensi perumahan pada tingkat lokal.');
INSERT INTO public.aspek VALUES ('B.003.002', 'B.003', 'B', 'Non APBD Kab-Kota', 'Aspek non APBD Kab-Kota mencakup dukungan daerah di luar belanja anggaran langsung, termasuk kerja sama dengan komunitas, swasta, lembaga sosial, atau pemanfaatan aset lokal. Skema ini membantu pemerintah daerah memperkuat layanan perumahan dengan sumber daya tambahan.');
INSERT INTO public.aspek VALUES ('B.004.001', 'B.004', 'B', 'Perbankan', 'Aspek perbankan mencakup kemitraan dengan bank untuk penyaluran KPR, pembiayaan konstruksi, escrow, tabungan perumahan, dan layanan keuangan terkait. Peran perbankan penting untuk menghubungkan kelayakan calon penerima, proyek, dan sumber dana komersial.');
INSERT INTO public.aspek VALUES ('B.004.002', 'B.004', 'B', 'Lembaga Pembiayaan', 'Aspek lembaga pembiayaan mencakup kerja sama dengan perusahaan pembiayaan atau lembaga keuangan non-bank untuk mendukung pembelian, renovasi, atau pembangunan rumah. Skema ini memperluas akses masyarakat dan pelaku usaha terhadap pilihan pembiayaan yang lebih beragam.');
INSERT INTO public.aspek VALUES ('B.004.003', 'B.004', 'B', 'Pasar Modal', 'Aspek pasar modal mencakup pemanfaatan instrumen investasi, sekuritisasi, obligasi, dana investasi, atau produk keuangan lain untuk mendukung pembiayaan perumahan. Data ini membantu membuka sumber dana jangka panjang bagi program dan proyek perumahan.');
INSERT INTO public.aspek VALUES ('B.004.004', 'B.004', 'B', 'Investor Pribadi', 'Aspek investor pribadi mencakup partisipasi individu sebagai penyedia modal, pembeli portofolio, pemilik aset sewa, atau mitra pendanaan proyek perumahan. Informasi ini membantu mengelola kontribusi investor secara transparan dan sesuai tujuan program.');
INSERT INTO public.aspek VALUES ('B.004.005', 'B.004', 'B', 'Institusi', 'Aspek institusi mencakup keterlibatan badan usaha, lembaga, yayasan, koperasi, atau organisasi formal sebagai mitra pendanaan dan pelaksana program. Kemitraan institusi memperkuat kapasitas ekosistem melalui modal, aset, jaringan, dan kemampuan operasional.');
INSERT INTO public.aspek VALUES ('B.004.006', 'B.004', 'B', 'Fintech', 'Aspek fintech mencakup pemanfaatan teknologi finansial untuk pembiayaan, verifikasi, pembayaran, cicilan, investasi mikro, atau penggalangan dana perumahan. Skema ini mendukung layanan yang lebih cepat, terukur, dan mudah diakses oleh berbagai kelompok masyarakat.');
INSERT INTO public.aspek VALUES ('B.004.007', 'B.004', 'B', 'Tabungan Sukarela', 'Aspek tabungan sukarela mencakup mekanisme penghimpunan dana masyarakat secara bertahap untuk tujuan kepemilikan, renovasi, atau peningkatan kualitas rumah. Data ini membantu membangun riwayat kesiapan finansial dan memperkuat akses ke pembiayaan formal.');
INSERT INTO public.aspek VALUES ('B.005.001', 'B.005', 'B', 'Donasi', 'Aspek donasi mencakup pengumpulan dan penyaluran kontribusi sukarela untuk mendukung rumah layak huni, bantuan bencana, atau kelompok rentan. Pengelolaan digital diperlukan agar sumber, sasaran, nilai, dan hasil pemanfaatan donasi dapat dipantau secara transparan.');
INSERT INTO public.aspek VALUES ('B.005.002', 'B.005', 'B', 'Hibah', 'Aspek hibah mencakup bantuan dana, aset, atau barang yang diberikan tanpa kewajiban pengembalian untuk mendukung program perumahan. Data hibah membantu memastikan pemanfaatan tepat sasaran, sesuai perjanjian, dan terintegrasi dengan kebutuhan program.');
INSERT INTO public.aspek VALUES ('B.005.003', 'B.005', 'B', 'Wakaf', 'Aspek wakaf mencakup pemanfaatan aset atau dana wakaf untuk penyediaan hunian, lahan, fasilitas, atau layanan pendukung perumahan. Pengelolaannya menuntut pencatatan yang akuntabel agar manfaat sosial dapat berlangsung jangka panjang dan sesuai ketentuan wakaf.');
INSERT INTO public.aspek VALUES ('B.006.001', 'B.006', 'B', 'Swadaya', 'Aspek swadaya mencakup kontribusi masyarakat dalam bentuk tenaga, dana, material, lahan, atau dukungan lokal untuk pembangunan dan perbaikan rumah. Data ini membantu mengakui kapasitas komunitas serta menghubungkannya dengan bantuan teknis dan pembiayaan yang sesuai.');
INSERT INTO public.aspek VALUES ('B.006.002', 'B.006', 'B', 'Partisipasi', 'Aspek partisipasi mencakup pelibatan warga, komunitas, profesi, dan pemangku kepentingan dalam perencanaan, pelaksanaan, pemantauan, dan evaluasi program perumahan. Partisipasi memperkuat rasa kepemilikan, ketepatan sasaran, dan keberlanjutan layanan.');
INSERT INTO public.aspek VALUES ('C.001.001', 'C.001', 'C', 'Dukcapil', 'Aspek Dukcapil mencakup integrasi data kependudukan untuk memverifikasi identitas, status keluarga, domisili, dan profil dasar calon penerima layanan perumahan. Data ini menjadi fondasi agar pengelolaan demand lebih akurat, tidak ganda, dan dapat dipertanggungjawabkan.');
INSERT INTO public.aspek VALUES ('C.001.002', 'C.001', 'C', 'Subsidi cheking', 'Aspek subsidi checking mencakup pemeriksaan riwayat, status, dan kelayakan calon penerima terhadap bantuan atau subsidi perumahan yang pernah atau sedang diterima. Proses ini membantu mencegah duplikasi manfaat dan memastikan subsidi diberikan kepada sasaran yang tepat.');
INSERT INTO public.aspek VALUES ('C.001.003', 'C.001', 'C', 'Perpajakan', 'Aspek perpajakan mencakup pemanfaatan data pajak untuk membaca kemampuan ekonomi, kepemilikan aset, aktivitas transaksi, dan kepatuhan calon penerima atau pelaku usaha. Informasi ini membantu proses segmentasi, verifikasi kelayakan, dan pengendalian risiko program.');
INSERT INTO public.aspek VALUES ('C.001.004', 'C.001', 'C', 'DTSN', 'Aspek DTSN mencakup integrasi data kesejahteraan atau data sosial nasional yang digunakan untuk mengidentifikasi kelompok sasaran prioritas. Data ini membantu memetakan kebutuhan bantuan, tingkat kerentanan, dan jenis intervensi perumahan yang paling sesuai.');
INSERT INTO public.aspek VALUES ('C.001.005', 'C.001', 'C', 'PLN', 'Aspek PLN mencakup pemanfaatan data sambungan listrik, daya terpasang, konsumsi, dan status layanan sebagai indikator kondisi rumah serta kemampuan ekonomi. Informasi ini mendukung verifikasi hunian, segmentasi demand, dan perencanaan kebutuhan utilitas.');
INSERT INTO public.aspek VALUES ('C.001.006', 'C.001', 'C', 'SILK OJK', 'Aspek SILK OJK mencakup integrasi informasi layanan keuangan untuk menilai riwayat kredit, profil risiko, dan akses pembiayaan calon penerima. Data ini membantu mempertemukan masyarakat dengan skema pembiayaan rumah yang sesuai kemampuan.');
INSERT INTO public.aspek VALUES ('C.001.007', 'C.001', 'C', 'Finance activity', 'Aspek finance activity mencakup pembacaan aktivitas keuangan yang relevan untuk menilai kemampuan bayar, pola transaksi, dan kesiapan calon penerima terhadap produk pembiayaan perumahan. Informasi ini digunakan secara terukur untuk mendukung analisis kelayakan dan mitigasi risiko.');
INSERT INTO public.aspek VALUES ('C.001.008', 'C.001', 'C', 'Sekmentasi', 'Aspek segmentasi mencakup pengelompokan calon penerima berdasarkan pendapatan, kebutuhan hunian, lokasi, kemampuan bayar, status kepemilikan, dan tingkat prioritas. Segmentasi membantu menentukan jenis program, kanal layanan, dan skema pembiayaan yang paling tepat.');
INSERT INTO public.aspek VALUES ('C.002.001', 'C.002', 'C', 'Kelompok Stimulan', 'Aspek kelompok stimulan mencakup pengelolaan sasaran masyarakat yang membutuhkan dorongan bantuan awal untuk membangun, memperbaiki, atau meningkatkan kualitas rumah. Data ini membantu menentukan nilai stimulan, prioritas penerima, dan progres pemanfaatannya.');
INSERT INTO public.aspek VALUES ('C.002.002', 'C.002', 'C', 'Kelompok Penghasilan Rendah', 'Aspek kelompok penghasilan rendah mencakup pengelolaan demand masyarakat berpendapatan rendah yang membutuhkan dukungan subsidi, bantuan, atau skema pembiayaan khusus. Fokusnya adalah memastikan akses terhadap rumah layak tetap terjangkau dan tepat sasaran.');
INSERT INTO public.aspek VALUES ('C.002.003', 'C.002', 'C', 'Kelompok Penghasilan Menengah', 'Aspek kelompok penghasilan menengah mencakup pengelolaan demand masyarakat yang memiliki kemampuan bayar lebih baik namun tetap membutuhkan pilihan produk hunian dan pembiayaan yang sesuai. Data ini membantu menyediakan skema rumah baru, renovasi, sewa, atau pembelian yang realistis.');
INSERT INTO public.aspek VALUES ('C.002.004', 'C.002', 'C', 'Kelompok Penghasilan Tinggi', 'Aspek kelompok penghasilan tinggi mencakup pengelolaan demand masyarakat dengan kemampuan finansial lebih kuat yang dapat mendukung pasar hunian komersial dan investasi perumahan. Informasi ini membantu menjaga keseimbangan pasar serta membuka peluang pembiayaan silang dalam ekosistem.');
INSERT INTO public.aspek VALUES ('D.001.001', 'D.001', 'D', 'SKKNI', 'Aspek SKKNI mencakup penyusunan, pemetaan, dan penerapan standar kompetensi kerja nasional untuk pelaku layanan digital perumahan. Standar ini menjadi acuan bagi operator, teknisi, analis, dan ahli agar pekerjaan berbasis data, BIM, GIS, pembiayaan, dan layanan publik dilakukan secara profesional.');
INSERT INTO public.aspek VALUES ('D.001.002', 'D.001', 'D', 'Industri', 'Aspek industri mencakup pelibatan pelaku usaha, profesi, lembaga pendidikan, asosiasi, dan penyedia teknologi dalam penguatan literasi serta kompetensi perumahan digital. Kolaborasi ini memastikan kebutuhan keahlian ekosistem dapat terhubung dengan praktik kerja dan perkembangan industri.');


--
-- Data for Name: kelompok; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kelompok VALUES ('A.001', 'A', 'Perkumpulan');
INSERT INTO public.kelompok VALUES ('A.002', 'A', 'Simulasi Pemodelan');
INSERT INTO public.kelompok VALUES ('A.003', 'A', 'Sumber Analisa Pemodelan GIS');
INSERT INTO public.kelompok VALUES ('A.004', 'A', 'Sumber Analisa Pemodelan BIM');
INSERT INTO public.kelompok VALUES ('A.005', 'A', 'Dokumen Teknis Perizinan');
INSERT INTO public.kelompok VALUES ('A.006', 'A', 'Proses Persetujuan');
INSERT INTO public.kelompok VALUES ('A.007', 'A', 'Skema Program Rumah');
INSERT INTO public.kelompok VALUES ('A.008', 'A', 'Skema Program Kawasan Perumahan');
INSERT INTO public.kelompok VALUES ('A.009', 'A', 'Material dan Jasa');
INSERT INTO public.kelompok VALUES ('A.010', 'A', 'Listrik & Air');
INSERT INTO public.kelompok VALUES ('A.011', 'A', 'Manajemen Properti');
INSERT INTO public.kelompok VALUES ('B.001', 'B', 'Dana Pemerintah Pusat');
INSERT INTO public.kelompok VALUES ('B.002', 'B', 'Dana Pemerintah Provinsi');
INSERT INTO public.kelompok VALUES ('B.003', 'B', 'Dana Pemerintah Kab-Kota');
INSERT INTO public.kelompok VALUES ('B.004', 'B', 'Dana Kemitraan Komersil');
INSERT INTO public.kelompok VALUES ('B.005', 'B', 'Dana Kemitraan Flantropi');
INSERT INTO public.kelompok VALUES ('B.006', 'B', 'Dana Kemitraan Komunitas');
INSERT INTO public.kelompok VALUES ('C.001', 'C', 'RIISD');
INSERT INTO public.kelompok VALUES ('C.002', 'C', 'PENGELOLAAN DEMAND');
INSERT INTO public.kelompok VALUES ('D.001', 'D', 'LITERASI & KOMPETENSI');


--
-- Data for Name: organisasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organisasi VALUES (5, '{"komisioner": {"jabatan": "Komisioner", "unit_di_bawah": [{"nama": "Direktorat Perencanaan Strategis, Manajemen Risiko, dan Kerja Sama", "divisi": ["Perencanaan Strategis", "Manajemen Risiko dan Kepatuhan", "Sekretariat dan Komunikasi Badan"]}, {"jabatan": "Deputi Komisioner Bidang Pengerahan Dana Tapera", "direktorat": [{"nama": "Direktorat Kepesertaan", "divisi": ["Layanan Kepesertaan I", "Layanan Kepesertaan II", "Data Kepesertaan"]}, {"nama": "Direktorat Operasi Pengerahan", "divisi": ["Registrasi dan Simpanan dan Pengembalian", "Layanan Contact Center"]}]}, {"jabatan": "Deputi Komisioner Bidang Pemupukan Dana Tapera", "direktorat": [{"nama": "Direktorat Tresuri dan Investasi", "divisi": ["Pengelolaan Dana Tapera", "Divisi Pengelolaan Aset BP Tapera", "Divisi Pengelolaan Investasi Pemerintah", "Divisi Pengelolaan Sumber Dana Lain"]}, {"nama": "Direktorat Operasi Pemupukan", "divisi": ["Manajemen Kas dan Settlement", "Evaluasi Kinerja Bank Kustodian"]}]}, {"jabatan": "Deputi Komisioner Bidang Pemanfaatan Dana Tapera", "direktorat": [{"nama": "Direktorat Kerja Sama dan Kebijakan Pembiayaan", "divisi": ["Kerja Sama Mitra dan Stakeholder", "Jaminan Pembiayaan"]}, {"nama": "Direktorat Pemasaran Pembiayaan", "divisi": ["Pemasaran", "Pemasaran II"]}, {"nama": "Direktorat Operasi Pemanfaatan", "divisi": ["Operasi Pembiayaan", "Pemantauan dan Evaluasi"]}]}, {"jabatan": "Deputi Komisioner Bidang Hukum dan Administrasi", "direktorat": [{"nama": "Direktorat Hukum dan Sumber Daya Manusia", "divisi": ["Hukum", "Sumber Daya Manusia"]}, {"nama": "Direktorat Keuangan dan Umum", "divisi": ["Keuangan", "Pengelolaan Aset Tetap dan Umum"]}, {"nama": "Direktorat Teknologi Informasi", "unit": ["Unit Layanan Pengadaan"], "divisi": ["Manajemen Teknologi Informasi", "Pengembangan Aplikasi", "Operasional Teknologi Informasi", "Keamanan Teknologi Informasi dan Manajemen Data", "Layanan Digital"]}]}], "unit_pendukung": [{"nama": "Penasihat"}, {"nama": "Komisi"}, {"nama": "Satuan Pengawas Internal"}, {"nama": "Dewan Pengawas Syariah"}]}, "organisasi": "BP Tapera"}');


--
-- Data for Name: pilar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pilar VALUES ('A', 'SUPPLY');
INSERT INTO public.pilar VALUES ('B', 'PROGRAM');
INSERT INTO public.pilar VALUES ('C', 'DEMAND');
INSERT INTO public.pilar VALUES ('D', 'LITERASI');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'admin', '$2b$10$g2coFoAgqFIbPjyBRUjo6eHy6Rs7TbdUF6pl3B9TnPkUZD5biiRve', 'admin', '2026-06-17 10:05:17.28927');


--
-- Name: organisasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organisasi_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

\unrestrict yHTMEUGZPmZfHDPdt0wRvJ3DOPrjwA0aI3LINm8BVd1wvpJxN9zZocgB7dpZO4Z

