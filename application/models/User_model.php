<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class User_model extends CI_Model 
{
	function __construct()
	{
		$this->db = $this->load->database('default', TRUE);
	}

	function checkUserExist($p_user_email)
	{
		$sql = "SELECT 
				  user_id,
				  user_active,
				  user_register_via,
				  CASE user_register_via WHEN '1' THEN 'facebook' WHEN '2' THEN 'twitter' WHEN '99' THEN 'email' ELSE NULL END as user_register_via_name
				FROM tm_user
				WHERE user_email = '$p_user_email' ";
		$query = $this->db->query($sql);
		return $query->row_data();
	}

	function registerViaEmail($api_id, $user_register_via, $p_user_email, $p_user_password, $user_token_activation, $p_user_phone, $p_user_fullname, $p_user_gender, $p_user_birth_date)
	{
		$sql = "INSERT INTO tm_user (
									   user_email
									  ,user_password
									  ,user_phone
									  ,user_fullname
									  ,user_birthdate
									  ,user_gender
									  ,user_register_via
									  ,create_date
									  ,user_token_activation
									  ,tm_api_api_id
									) VALUES (
									  ,'$p_user_email' -- user_email - IN varchar(100)
									  ,'$p_user_password'  -- user_password - IN varchar(80)
									  ,'$p_user_phone'  -- user_phone - IN varchar(20)
									  ,'$p_user_fullname'  -- user_fullname - IN varchar(150)
									  ,'$p_user_birth_date'  -- user_birthdate - IN date
									  ,'$p_user_gender'  -- user_gender - IN enum('1','2')
									  ,'$user_register_via' -- user_register_via - IN enum('1','2','99')
									  ,now() -- create_date - IN datetime
									  ,'$user_token_activation'  -- user_token_activation - IN varchar(70)
									  ,'$api_id'   -- tm_api_api_id - IN int(11)
									) ";
		$query = $this->db->query($sql);
		if ($query)
		{
			return true;
		}
	}

	function getUserId($p_user_email)
	{
		$sql = "SELECT 
				  user_id
				FROM tm_user
				WHERE user_email = '$p_user_email' ";
		$query = $this->db->query($sql);
		$query = $query->row_data();
		return $query['user_id'];
	}

	function sentEmailActivation($p_user_email)
	{
		$sql = "UPDATE tm_user 
				SET user_token_activation_sent_date = now() 
				WHERE user_email = '$p_user_email' ";
		$query = $this->db->query($sql);
	}

	function checkUserRegistered($p_user_email)
	{
		$sql = " SELECT user_id
    			 FROM tm_user
    			 WHERE user_email = '$p_user_email' ";
    	$query = $this->db->query($sql);
    	$query = $query->num_rows($query);
    	return $query;
	}

	function checkUserActived($p_user_email)
	{
		$sql = " SELECT user_id
    			 FROM tm_user
    			 WHERE user_email = '$p_user_email'
    			 	AND user_active = '1' ";
    	$query = $this->db->query($sql);
    	$query = $query->num_rows($query);
    	return $query;
	}

	function checkUserDeleted($p_user_email)
	{
		$sql = " SELECT user_id
    			 FROM tm_user
    			 WHERE user_email = '$p_user_email'
    			 	AND user_deleted = '1' ";
    	$query = $this->db->query($sql);
    	$query = $query->num_rows($query);
    	return $query;
	}

	function loginViaEmail($p_user_email, $p_user_password)
	{
		$sql = " SELECT user_id, user_email
    			 FROM tm_user
    			 WHERE user_email = '$p_user_email'
    			 	AND user_password = '$p_user_password'
    			 	AND user_active = '1'
    			 	AND user_deleted = '0' ";
    	$query = $this->db->query($sql);
    	$query = $query->row_array($query);
    	return $query;
	}

	function updateUserLastLogin($p_user_email, $p_user_password, $user_access_token)
	{
		$sql = "UPDATE tm_user 
                SET user_last_login = now(), user_closed_account = '0', 
                	user_access_token = '$user_access_token', user_access_token_expired = NOW() + INTERVAL 6 HOUR
                WHERE user_email = '$p_user_email'
                    AND user_password = '$p_user_password'
                ";
        $query = $this->db->query($sql);
	}
}