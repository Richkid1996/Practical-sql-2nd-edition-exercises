CREATE TABLE train_rides (
    trip_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    segment text NOT NULL,
    departure timestamptz NOT NULL,
    arrival timestamptz NOT NULL
);

INSERT INTO train_rides (segment, departure, arrival)
VALUES
    ('Chicago to New York', '2020-11-13 21:30 CST', '2020-11-14 18:23 EST'),
    ('New York to New Orleans', '2020-11-15 14:15 EST', '2020-11-16 19:32 CST'),
    ('New Orleans to Los Angeles', '2020-11-17 13:45 CST', '2020-11-18 9:00 PST'),
    ('Los Angeles to San Francisco', '2020-11-19 10:10 PST', '2020-11-19 21:24 PST'),
    ('San Francisco to Denver', '2020-11-20 9:10 PST', '2020-11-21 18:38 MST'),
    ('Denver to Chicago', '2020-11-22 19:10 MST', '2020-11-23 14:50 CST');

SET TIME ZONE 'US/Central';

SELECT * FROM train_rides;

-- Calculates the duration of each segment
SELECT segment,
to_char(departure, 'YYYY-MM-DD HH12:MI a.m. TZ') AS departure,
       arrival - departure AS segment_duration
FROM public.train_rides;


--Calculating Cumulative Trip time
SELECT segment,
arrival - departure AS segment_duration,
       justify_interval(sum(arrival - departure) OVER (ORDER BY trip_id)) AS cume_duration
FROM public.train_rides;
