select * from {{ ref('mart_sponsor_funnel') }}
where sponsor_name = 'Sanofi'