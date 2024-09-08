SELECT *
FROM spotify_user_data;

-- Analisis waktu mendengarkan berdasarkan di jam tertentu
SELECT
	EXTRACT(HOUR FROM listening_timestamp) AS hour,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY EXTRACT(HOUR FROM listening_timestamp)
ORDER BY listen_count DESC;

-- Analisis waktu mendengarkan berdasarkan hari
SELECT
	DAYNAME(listening_timestamp) AS day_of_week,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY DAYNAME(listening_timestamp)
ORDER BY listen_count;

-- Artis yang paling sering didengarkan
SELECT
	artist,
	COUNT(*) AS total_user
FROM spotify_user_data
GROUP BY artist
ORDER BY total_user DESC;

-- Genre yang paling sering didengarkan
SELECT 
	genre,
	COUNT(*) AS total_user
FROM spotify_user_data
GROUP BY genre, artist
ORDER BY total_user DESC;

-- Rata-rata durasi lagu yang didengarkan berdasarkan artis tertentu
SELECT
	artist,
	ROUND(AVG(song_duration), 2) AS avg_song_duration
FROM spotify_user_data
GROUP BY artist
ORDER BY avg_song_duration DESC;
-- Mengelompokan lagu berdasarkan durasi untuk melihat pola apakah lagu-lagu pendek atau panjang lebih populer
SELECT
	song_duration,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY song_duration
ORDER BY listen_count DESC;

-- Perangkat yang sering digunakan untuk mendengarkan musik oleh user
SELECT
	device,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY device
ORDER BY listen_count DESC;

-- Mengidentifikasi perangkat yang lebih sering digunakan pada waktu tertentu
SELECT
	device,
    EXTRACT(HOUR FROM listening_timestamp) AS hour,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY 1, 2
ORDER BY 2, 3 DESC;

-- Mengidentifikasi genre atau artis favorit berdasarkan kelompok usia
SELECT
	age,
    genre,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY age, genre
ORDER BY age;

-- Mengidentifikasi apakah ada perbedaan pola mendengarkan berdasarkan usia pada waktu yang berbeda
SELECT
	age,
    EXTRACT(HOUR FROM listening_timestamp) AS hour,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY age, EXTRACT(HOUR FROM listening_timestamp) 
ORDER BY hour;

-- Mengidentifikasi lokasi geografis pengguna yang paling aktif mendengarkan musik
SELECT
	location,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY location
ORDER BY listen_count DESC;

-- Menganalisis genre atau artis favorit berdasarkan lokasi pengguna
SELECT
	location,
    genre,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY location, genre
ORDER BY listen_count DESC;

-- Mengidentifikasi pola mendengarkan musik berdasarkan tipe langganan
SELECT
	subscription_type,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY subscription_type
ORDER BY listen_count DESC;

-- Mengetahui apakah pengguna dengan jenis langganan tertentu mendengarkan musik lebih lama atau lebih sering
SELECT
	subscription_type,
    ROUND(AVG(song_duration), 2) AS avg_duration
FROM spotify_user_data
GROUP BY subscription_type
ORDER BY avg_duration;

-- Mengidentifikasi pengguna yang paling sering mendengarkan musik
SELECT
	user_id,
    COUNT(*) AS listen_count
FROM spotify_user_data
GROUP BY user_id
ORDER BY listen_count DESC;

-- Mengidentifikasi user yang mendengarkan musik di waktu-waktu tertentu    
WITH time_periods AS (
    SELECT
        CASE 
            WHEN EXTRACT(HOUR FROM listening_timestamp) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM listening_timestamp) BETWEEN 12 AND 14 THEN 'Day'
            WHEN EXTRACT(HOUR FROM listening_timestamp) BETWEEN 15 AND 17 THEN 'Afternoon'
            WHEN EXTRACT(HOUR FROM listening_timestamp) BETWEEN 18 AND 23 THEN 'Evening'
            ELSE 'Night'
        END AS time_period
    FROM 
        spotify_user_data
)
SELECT 
    time_period,
    COUNT(*) AS listen_count
FROM 
    time_periods
GROUP BY 
    time_period
ORDER BY 
    listen_count DESC;





































