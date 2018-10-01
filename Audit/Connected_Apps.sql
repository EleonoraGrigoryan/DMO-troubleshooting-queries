--TSQL

--Identify currently running application names, IP address, host name, login name, and connection, session count

select dm_dec.[client_net_address],
dm_des.[program_name] ,
dm_des.[host_name] ,
dm_des.[login_name] ,
count(dm_dec.connection_id) as connection_count,
count(dm_dec.session_id) as [session_count]
from sys.dm_exec_sessions as dm_des
inner join sys.dm_exec_connections as dm_dec
on dm_des.session_id = dm_dec.session_id
group by dm_dec.client_net_address ,
dm_des.[program_name] ,
dm_des.[host_name],
dm_des.[login_name]
--having count(dm_dec.session_id) > 1
order by dm_des.program_name,
dm_dec.client_net_address ;
