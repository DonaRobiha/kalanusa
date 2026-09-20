-- =======================================================
-- Database SQL Dump untuk Kalanusa (XAMPP MySQL)
-- Aplikasi: Kalanusa - Travel & Nusantara Explorer
-- =======================================================

CREATE DATABASE IF NOT EXISTS `kalanusa` 
  CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;

USE `kalanusa`;

SET FOREIGN_KEY_CHECKS = 0;

-- -------------------------------------------------------
-- 1. Tabel: users (Admin & Pengguna)
-- -------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `email` VARCHAR(255) NULL UNIQUE,
  `email_verified_at` TIMESTAMP NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `remember_token` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- 2. Tabel: anggota (Daftar Anggota Kelompok)
-- -------------------------------------------------------
DROP TABLE IF EXISTS `anggota`;
CREATE TABLE `anggota` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(255) NOT NULL,
  `nim` VARCHAR(50) NOT NULL UNIQUE,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- 3. Tabel: destinasi (Destinasi Wisata Nusantara)
-- -------------------------------------------------------
DROP TABLE IF EXISTS `destinasi`;
CREATE TABLE `destinasi` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(255) NOT NULL,
  `lokasi` VARCHAR(255) NOT NULL,
  `kategori` VARCHAR(100) NOT NULL,
  `biaya` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
  `deskripsi` TEXT NULL,
  `foto` TEXT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- 4. Tabel: rencana_perjalanan (Manajemen Travel Plans)
-- -------------------------------------------------------
DROP TABLE IF EXISTS `rencana_perjalanan`;
CREATE TABLE `rencana_perjalanan` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tujuan` VARCHAR(255) NOT NULL,
  `tanggal` VARCHAR(100) NOT NULL,
  `orang` VARCHAR(50) NOT NULL,
  `budget` VARCHAR(100) NOT NULL,
  `catatan` TEXT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- 5. Tabel: komputasi_perjalanan (Kalkulasi Anggaran Biaya)
-- -------------------------------------------------------
DROP TABLE IF EXISTS `komputasi_perjalanan`;
CREATE TABLE `komputasi_perjalanan` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama_rencana` VARCHAR(255) NULL,
  `jumlah_orang` INT NOT NULL DEFAULT 1,
  `transportasi` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
  `penginapan` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
  `makan` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
  `tiket_aktivitas` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
  `total_biaya` DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------
-- 6. Tabel: catatan_kalender (Jadwal & Catatan Kalender)
-- -------------------------------------------------------
DROP TABLE IF EXISTS `catatan_kalender`;
CREATE TABLE `catatan_kalender` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `judul` VARCHAR(255) NOT NULL,
  `tanggal` VARCHAR(100) NOT NULL,
  `keterangan` TEXT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- =======================================================
-- DATA AWAL (SEEDER)
-- =======================================================

-- Admin user (Default: username 'admin', password '12345')
INSERT INTO `users` (`id`, `name`, `username`, `email`, `password`)
VALUES 
  (1, 'Administrator Kalanusa', 'admin', 'admin@kalanusa.local', '$2y$12$e4JcW4zKkI1s3F1l7G5o/.jKqJjI9hC1m2.ZzQ9O4yV4fB0mE6eGa');

-- Anggota Kelompok
INSERT INTO `anggota` (`id`, `nama`, `nim`)
VALUES
  (1, 'Dona Robiha', '124240026'),
  (2, 'Dhini Rahayu', '124240197');

-- Destinasi Wisata
INSERT INTO `destinasi` (`id`, `nama`, `lokasi`, `kategori`, `biaya`, `deskripsi`, `foto`)
VALUES
  (1, 'Borobudur', 'Magelang, Jawa Tengah', 'Wisata Budaya', 50000.00, 'Candi Buddha terbesar di dunia yang menjadi salah satu warisan budaya dunia UNESCO.', 'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=800'),
  (2, 'Raja Ampat', 'Papua Barat Daya', 'Wisata Alam', 500000.00, 'Gugusan pulau karang indah dengan keanekaragaman biota laut terbaik di dunia.', 'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?w=800'),
  (3, 'Bali', 'Bali', 'Wisata Pantai', 100000.00, 'Pulau Dewata dengan pantai eksotis, kebudayaan luhur, dan tradisi yang mendunia.', 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800');

-- Rencana Perjalanan
INSERT INTO `rencana_perjalanan` (`id`, `tujuan`, `tanggal`, `orang`, `budget`, `catatan`)
VALUES
  (1, 'Yogyakarta', '20 September 2026', '3 orang', 'Rp1.500.000', 'Wisata dan kuliner Malioboro serta candi-candi sekitar.');

-- Komputasi Perjalanan Awal
INSERT INTO `komputasi_perjalanan` (`id`, `nama_rencana`, `jumlah_orang`, `transportasi`, `penginapan`, `makan`, `tiket_aktivitas`, `total_biaya`)
VALUES
  (1, 'Liburan Yogyakarta 3 Hari', 3, 450000.00, 600000.00, 300000.00, 150000.00, 1500000.00);

-- Catatan Kalender Awal
INSERT INTO `catatan_kalender` (`id`, `judul`, `tanggal`, `keterangan`)
VALUES
  (1, 'Hari Libur Nasional & Rencana Trip', '2026-09-20', 'Perjalanan wisata budaya Kalanusa ke Yogyakarta');
