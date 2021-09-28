function payload_contextItemFilter($types_filter, $states_filter, $periodStart){
    If($config.runExplicitDates -eq 'Yes'){
        $script:start = $config.start
        $script:end = If($config.end -eq ""){(Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.000Z")}else{$config.end}
    }else{
        $script:start = (Get-Date).ToUniversalTime().AddDays(-$periodStart).ToString("yyyy-MM-ddTHH:mm:ss.000Z")
        $script:end = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.000Z")
    }

    $contextBody = @{
        filters = @(
            @{ type = "TYPE_FILTER"; types = $types_filter},
            @{ type = "CURRENT_STATE_FILTER"; states =  $states_filter},
            @{ type = "INTERVAL_FILTER"; startDate = $start; endDate = $end})
    }
    
    $contextBody|ConvertTo-Json -Depth 10

}
