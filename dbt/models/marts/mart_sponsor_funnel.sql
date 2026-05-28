with fct_matches as (

  select * from {{ ref('fct_patient_trial_matches') }}

)

, dim_sites_data as (

  select * from {{ ref('dim_sites') }}

)

, dim_trials_data as (

  select * from {{ ref('dim_trials') }}

)

, dim_sponsors_data as (

  select * from {{ ref('dim_sponsors') }}

)

, grouped_funnel as (

  select
    dsp.sponsor_name
    , ds.country_name
    , dt.trialName
    , dt.trial_id
    , dt.sponsor_id
    , dt.indication
    , dt.phase
    , dt.status
    , count(distinct fm.patient_id) as total_patients
    , sum(cast(fm.is_processed as int)) as patients_processed
    , sum(cast(fm.is_reviewed as int)) as patients_reviewed
    , sum(cast(fm.is_enrolled as int)) as patients_enrolled
  from fct_matches fm
  left join dim_sites_data ds on fm.site_id = ds.site_id
  left join dim_trials_data dt on fm.trial_id = dt.trial_id
  left join dim_sponsors_data dsp on dt.sponsor_id = dsp.sponsor_id
  group by
    dsp.sponsor_name
    , ds.country_name
    , dt.trialName
    , dt.trial_id
    , dt.sponsor_id
    , dt.indication
    , dt.phase
    , dt.status

)

select * from grouped_funnel
