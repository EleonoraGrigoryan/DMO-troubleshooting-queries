-- TSQL

-- Shows all wait types and their occurances in the server since the last server start

select 
    dows.wait_type,
    sum(DOWS.wait_time_ms / 1000) as [wait_time_s]
from sys.dm_os_wait_stats as dows
where 
    dows.wait_type not in 
    ( 
        'SLEEP_TASK', 'BROKER_TASK_STOP',
        'SQLTRACE_BUFFER_FLUSH', 'CLR_AUTO_EVENT',
        'CLR_MANUAL_EVENT', 'LAZYWRITER_SLEEP' 
    )
group by 
    dows.wait_type
order by 
    sum(dows.wait_time_ms) desc;
