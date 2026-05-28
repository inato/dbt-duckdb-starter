with source as (

  select * from {{ ref('raw_patient_trial_matches') }}

)

, select_and_cast as (

  select
      patient_id
    , trial_id
    , replace(site_id, 'SITE-', '') as site_id
    , cast(processedAt as timestamp) as processed_at
    , cast(reviewedAt as timestamp) as reviewed_at
    , cast(enrolledAt as timestamp) as enrolled_at
  from source

)

select * from select_and_cast
