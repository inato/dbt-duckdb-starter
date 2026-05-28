with matches as (

  select * from {{ ref('stg_patient_trial_matches') }}

)

, final as (

  select
    patient_id
    , trial_id
    , site_id
    , processed_at
    , reviewed_at
    , enrolled_at
    , processed_at is not null as is_processed
    , reviewed_at is not null as is_reviewed
    , enrolled_at is not null as is_enrolled
  from matches

)

select * from final
