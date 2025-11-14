create database india_election_result;  # Database creation
use india_election_result;

create table partywise_results (
party varchar(100),
won int,
party_id int);

create table states (
state_id varchar(100),
state varchar(100)
);

create table constituencywise_details (
s_n int,
candidate varchar(100),
party varchar(100),
evm_votes bigint,
postal_votes int,
total_votes int,
percentage_of_votes float,
constituency_id varchar(50)
);

create table constituencywise_results (
s_n int,
parliament_constituency varchar(100),
constituency_name varchar(100),
winning_candidate varchar(100),
total_votes int,
margin int,
constituency_id varchar(100),
party_id int 
);

create table statewise_results (
constituency varchar(100),
const_no int,
parliament_constituency varchar(100),
leading_candidate varchar(100),
trailing_candidate varchar(100),
margin int,
status varchar(100),
state_id varchar(100),
state varchar(100)
);


-- Total seats
SELECT DISTINCT COUNT(parliament_constituency) AS total_seats FROM  constituencywise_results ;

-- What are the total numbers of seats available for election in each state
SELECT s.state AS state_name, COUNT(cr.parliament_constituency) AS Total_Seats_In_State
FROM constituencywise_results AS cr
INNER JOIN statewise_results AS sr 
ON cr.parliament_constituency = sr.parliament_constituency
INNER JOIN states AS s
ON sr.state_id = s.state_id
GROUP BY s.state
ORDER BY total_seats_in_state;

-- Total seats won by NDA Alliance
SELECT 
    SUM(
        CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
                'Janata Dal (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
                'Janata Dal (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN won
            ELSE 0 
        END
    ) AS NDA_Total_Seats_Won
FROM 
    partywise_results;

-- Seats won by NDA Alliance Parties
SELECT 
    party AS Party_Name,
    won AS Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
        'Janata Dal (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
        'Janata Dal (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY 
    seats_won DESC;

-- Total seats won by I.N.D.I.A. Alliance
SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN won
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results ;

-- Seats won by I.N.D.I.A. Alliance Parties
SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
        'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY Seats_Won DESC;

-- Add new column field in table partywise_results to get the party alliance as NDA, I.N.D.I.A and OTHER
ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);

# I.N.D.I.A Alliance

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India (Marxist) - CPI(M)',
    'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

# NDA Alliance

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

# OTHER

UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

SELECT * FROM partywise_results;

-- Which party alliance (NDA, I.N.D.I.A or OTHER) won the most seats across all states ?
SELECT 
    p.party_alliance,
    COUNT(cr.constituency_id) AS Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.party_id = p.party_id
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY 
    p.party_alliance
ORDER BY 
    seats_won DESC;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
SELECT cr.winning_Candidate, p.party, p.party_alliance, cr.total_votes, cr.margin, cr.constituency_name, s.state
FROM constituencywise_results cr
JOIN partywise_results p ON cr.party_id = p.party_id
JOIN statewise_results sr ON cr.parliament_constituency = sr.parliament_constituency
JOIN states s ON sr.state_id = s.state_id
WHERE s.state = 'Maharashtra' AND cr.constituency_name = 'NANDED';

SELECT cr.winning_Candidate, p.party, p.party_alliance, cr.total_votes, cr.margin, cr.constituency_name, s.state
FROM constituencywise_results AS cr
JOIN partywise_results AS p ON cr.party_id = p.party_id
JOIN statewise_results AS sr ON cr.parliament_constituency = sr.parliament_constituency
JOIN states s ON sr.state_id = s.state_id
WHERE s.state = 'Maharashtra' AND cr.constituency_name = 'PARBHANI';

-- Which parties won the most seats in s State, and how many seats did each party win?
SELECT p.party, COUNT(cr.constituency_id) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results AS p 
ON cr.party_id = p.party_id
JOIN statewise_results AS sr 
ON cr.parliament_constituency = sr.parliament_constituency
JOIN states AS s 
ON sr.state_id = s.state_id
WHERE s.state = 'Maharashtra'
GROUP BY p.party
ORDER BY seats_won DESC;

-- Which candidate received the highest number of EVM votes in each constituency (Top 10)?
SELECT 
    cr.constituency_name,
    cd.constituency_id,
    cd.candidate,
    cd.evm_votes
FROM constituencywise_details AS cd
JOIN constituencywise_results AS cr ON cd.constituency_id = cr.constituency_id
WHERE cd.evm_votes = ( 
SELECT MAX(cd1.evm_votes)
FROM constituencywise_details AS cd1
WHERE cd1.constituency_id = cd.constituency_id
)
ORDER BY cd.evm_votes DESC 
LIMIT 10 ;

