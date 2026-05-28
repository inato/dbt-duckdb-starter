with source as (

  select * from {{ ref('raw_trials') }}

)

, final as (

  select
    {{ dbt_utils.generate_surrogate_key(['trial_id']) }} as stg_trial_id
    , trial_id
    , sponsor_id
    , trialName
    , indication
    , phase
    , status
    , start_date
    , end_date
  from source

)

select * from final
