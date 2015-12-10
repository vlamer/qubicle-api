<?php

defined('BASEPATH') OR exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
require APPPATH . '/libraries/REST_Controller.php';

/**
 * This is an example of a few basic user interaction methods you could use
 * all done with a hardcoded array
 *
 * @package         CodeIgniter
 * @subpackage      Rest Server
 * @category        Controller
 * @author          Yansen
 * @license         Qubicle - Codigo
 * @link            
 */
class User extends REST_Controller 
{
    function __construct()
    {
        // Construct the parent class
        parent::__construct();

        // Configure limits on our controller methods
        // Ensure you have created the 'limits' table and enabled 'limits' within application/config/rest.php
        // $this->methods['user_get']['limit'] = 500; // 500 requests per hour per user/key
        // $this->methods['user_post']['limit'] = 100; // 100 requests per hour per user/key
        // $this->methods['user_delete']['limit'] = 50; // 50 requests per hour per user/key

        $parameter_sent       = $this->input->post();
        $this->api_id         = $this->input->post('api_id');
        $this->api_key        = substr($this->input->post('api_key'), 32);
        $this->api_secret     = $this->input->post('api_secret');
        $this->ip             = $_SERVER['REMOTE_ADDR'];
        $this->parameter_sent = http_build_query($parameter_sent, '', '&amp;');
    }

    /*----------------------------------------------------------------------*
    * registerViaEmail                                              *
    * ~~~~~~~~~~~~~                                                        *
    *                                                                      *
    * Description   - function ini untuk proses register via email *
    *                                                                      *
    * Change Request-                                            *
    * Specification -                                               *
    * Programmer    - Yansen                     *
    * Date          - 10.09.2015                                           *
    * Version       - 0.1                                                  *
    *----------------------------------------------------------------------*
    * @parameter_required = user_email, user_password
    *----------------------------------------------------------------------*
    * Amendment History                                                    *
    * ~~~~~~~~~~~~~~~~~                                                    *
    * Ref | Date     | Programmer | Correction | Description               *
    * ~~~   ~~~~~~~~   ~~~~~~~~~~   ~~~~~~~~~~   ~~~~~~~~~~~               *
    *           *
    *----------------------------------------------------------------------*/
    function registerViaEmail_post()
    {
        $this->form_validation->set_rules('user_email','user_email','required|xss_clean|valid_email|max_length[100]');
        $this->form_validation->set_rules('user_password','user_password','required|xss_clean|max_length[80]');
        $this->form_validation->set_rules('user_phone','user_phone','xss_clean|max_length[20]');
        $this->form_validation->set_rules('user_fullname','user_fullname','xss_clean|max_length[150]');
        $this->form_validation->set_rules('user_birth_date','user_birth_date','xss_clean');
        $this->form_validation->set_rules('user_gender','user_gender','xss_clean|max_length[1]|is_natural_no_zero');
        if ($this->form_validation->run()==true)
        {
            $this->load->model('User_model');

            $user_register_via = "99"; // user register via email
            $p_user_email      = $this->input->post('user_email');
            $p_user_password   = $this->input->post('user_password');
            $p_user_phone      = $this->input->post('user_phone');
            $p_user_fullname   = $this->input->post('user_fullname');
            $p_user_birth_date = $this->input->post('user_birth_date');
            $p_user_gender     = $this->input->post('user_gender');

            // validate user birthdate yyyy-mm-dd
            $date_regex = '/^(19|20)\d\d[\-\/.](0[1-9]|1[012])[\-\/.](0[1-9]|[12][0-9]|3[01])$/';
            if ($p_user_birth_date!="")
            {
                if (!preg_match($date_regex, $p_user_birth_date))
                {
                    $log_status  = "400";
                    $log_message = "Bad request, user_birth_date is not valid format. Ex (yyyy-mm-dd)";
                    $this->insert_log_api_rest($this->api_id, "registerViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);

                    $result['status']  = $log_status;
                    $result['message'] = $log_message;

                    $this->response($result, 200);
                }
            }

            // validate phonenumber
            if ($p_user_phone!="")
            {
                if (strlen($p_user_phone)<8)
                {
                    $log_status  = "400";
                    $log_message = "Bad request, user_phone must be filled out at least 8 character. Ex (+62xxxxxx)";
                    $this->insert_log_api_rest($this->api_id, "registerViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);

                    $result['status']  = $log_status;
                    $result['message'] = $log_message;

                    $this->response($result, 200);
                }

                if (!preg_match( '/^[+]?([\d]{0,3})?[\(\.\-\s]?([\d]{3})[\)\.\-\s]*([\d]{3})[\.\-\s]?([\d]{4})$/', $p_user_phone))
                {
                    $log_status  = "400";
                    $log_message = "Bad request, user_phone is not valid format. Ex (+62xxxxxx)";
                    $this->insert_log_api_rest($this->api_id, "registerViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);

                    $result['status']  = $log_status;
                    $result['message'] = $log_message;

                    $this->response($result, 200);
                }
            }
            
            // validate gender
            if ($p_user_gender!="")
            {
                if ($p_user_gender!="1" && $p_user_gender!="2")
                {
                    $log_status  = "400";
                    $log_message = "Bad request, gender not valid";
                    $this->insert_log_api_rest($this->api_id, "registerViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);

                    $result['status']  = $log_status;
                    $result['message'] = $log_message;

                    $this->response($result, 200);
                }
            }

            /* START - validate check user exist */
            $check_user_exist = $this->User_model->checkUserExist($p_user_email);
            if (count($check_user_exist)>0) // exist
            {       
                $log_status = "409";
                $log_message = "Conflict, email already exist and has been registered via ".$check_user_exist['user_register_via_name'];

                if ($check_user_exist['user_active']=="0")
                {
                    $log_message .= " but not activated"; 
                }

                $this->insert_log_api_rest($this->api_id, "registerViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
                
                $result['status']  = $log_status;
                $result['message'] = $log_message;
                $result['user_id'] = $check_user_exist['user_id'];
                $result['user_active'] = $check_user_exist['user_active'];
                $result['user_register_via']  = $check_user_exist['user_register_via'];
                $result['user_register_via_name']  = $check_user_exist['user_register_via_name'];

                $this->response($result, 200);
            }
            /* END - validate check user exist */

            // generate user_token_activation
            $salt = "emailactivatiONC0d3_c0d!g0_CrazyassLongSALTThatMakesYourUsersPasswordVeryLong123!!312567__asdSdas";
            $user_token_activation = hash('sha256', $salt.$p_user_email.md5(time()));

            $registerViaEmail = $this->User_model->registerViaEmail($this->api_id, $user_register_via, $p_user_email, $p_user_password, $user_token_activation, $p_user_phone, $p_user_fullname, $p_user_gender, $p_user_birth_date);
            if ($registerViaEmail==true) 
            {
                $log_status = "200";
                $log_message = "OK, Success register user via email";
                $this->insert_log_api_rest($this->api_id, "registerViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
                
                
                /* START SEND EMAIL ACTIVATION ACCOUNT */
                    $url_activation = "".URL_SEND_EMAIL_ACTIVATION_ACCOUNT.$user_token_activation;
                    $from_add       = "No Reply - UMS Mailer<ums.mailer@codigo.co.id>"; 

                    $to_add  = $p_user_email; //<-- put your yahoo/gmail email address here
                    $subject = "Activation Account";
                    $message = "Please click this link above for activate your account\n".$url_activation;
                    
                    $headers = "From: $from_add \r\n";
                    $headers .= "Reply-To: $from_add \r\n";
                    $headers .= "Return-Path: $from_add\r\n";
                    $headers .= "X-Mailer: PHP \r\n";
                    if(mail($to_add,$subject,$message,$headers)) 
                    {
                        $this->User_model->sentEmailActivation($p_user_email);
                    }
                /* END SEND EMAIL ACTIVATION ACCOUNT */

                $result['status']  = $log_status;
                $result['message'] = $log_message;
                $result['user_token_activation'] = $user_token_activation;

                $this->response($result, 200);
                unset($result);

            }
            else // fail insert register via email
            {
                $log_status  = "500";
                $log_message = "Internal Server Error, Failed register user via email";
                $this->insert_log_api_rest($this->api_id, "registerViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
                
                $result['status']  = $log_status;
                $result['message'] = $log_message;

                $this->response($result, 200);
                unset($result);
            }
        }
        else
        {
            $log_status  = "400";
            $log_message = "Bad request, ".validation_errors();
            $this->insert_log_api_rest($this->api_id, "registerViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
            
            $result['status']  = $log_status;
            $result['message'] = $log_message;

            $this->response($result, 200);
        }
    }

    /*----------------------------------------------------------------------*
    * loginViaEmail                                              *
    * ~~~~~~~~~~~~~                                                        *
    *                                                                      *
    * Description   - function ini untuk proses login user register via email *
    *                                                                      *
    * Change Request-                                            *
    * Specification -                                               *
    * Programmer    - Yansen                     *
    * Date          - 10.09.2015                                           *
    * Version       - 0.1                                                  *
    *----------------------------------------------------------------------*
    * @parameter_required = user_email, user_password
    *----------------------------------------------------------------------*
    * Amendment History                                                    *
    * ~~~~~~~~~~~~~~~~~                                                    *
    * Ref | Date     | Programmer | Correction | Description               *
    * ~~~   ~~~~~~~~   ~~~~~~~~~~   ~~~~~~~~~~   ~~~~~~~~~~~               *
    *           *
    *----------------------------------------------------------------------*/
    function loginViaEmail_post()
    {
        $this->form_validation->set_rules('user_email','user_email','required|xss_clean|valid_email|max_length[100]');
        $this->form_validation->set_rules('user_password','user_password','required|xss_clean|max_length[80]');
        if ($this->form_validation->run()==true)
        {
            $this->load->model('User_model');

            $user_register_via = "99"; // user register via email
            $p_user_email      = $this->input->post('user_email');
            $p_user_password   = $this->input->post('user_password');

            $checkUserRegistered = $this->User_model->checkUserRegistered($p_user_email);
            if ($checkUserRegistered<1) // check user jika tidak ada
            {   
                $log_status = "409";
                $log_message = "Conflict, user email not registered";
                $this->insert_log_api_rest($this->api_id, "loginViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
                
                $result['status']  = $log_status;
                $result['message'] = $log_message;

                $this->response($result, 200);
            }

            $checkUserActived = $this->User_model->checkUserActived($p_user_email);
            if ($checkUserActived<1) // check user jika tidak aktif
            {   
                $log_status = "409";
                $log_message = "Conflict, user is not active";
                $this->insert_log_api_rest($this->api_id, "loginViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
                
                $result['status']  = $log_status;
                $result['message'] = $log_message;

                $this->response($result, 200);
            }

            $checkUserDeleted = $this->User_model->checkUserDeleted($p_user_email);
            if ($checkUserDeleted>0) // check user jika deleted status
            {   
                $log_status = "409";
                $log_message = "Conflict, user has been deleted";
                $this->insert_log_api_rest($this->api_id, "loginViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
                
                $result['status']  = $log_status;
                $result['message'] = $log_message;

                $this->response($result, 200);
            }

            $loginViaEmail = $this->User_model->loginViaEmail($p_user_email, $p_user_password);
            if (count($loginViaEmail)>0) 
            {
                $user_access_token = md5(md5($p_user_email.md5($p_user_password).md5(time())).time());

                $this->User_model->updateUserLastLogin($p_user_email, $p_user_password, $user_access_token);

                $user_id = $loginViaEmail['user_id'];
                $user_email = $loginViaEmail['user_email'];

                $log_status = "200";
                $log_message = "OK, User Logged In";
                $this->insert_log_api_rest($this->api_id, "loginViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
                
                $result['status']  = $log_status;
                $result['message'] = $log_message;

                $this->response($result, 200);
                unset($result);
            }
            else 
            {
                $log_status = "203";
                $log_message = "Non-Authoritative, Email or password not match";
                $this->insert_log_api_rest($this->api_id, "loginViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);
                
                $result['status']  = $log_status;
                $result['message'] = $log_message;

                $this->response($result, 200);
                unset($result);
            }
        }
        else
        {   
            $log_status = "400";
            $log_message = "Bad request, ".validation_errors();
            $this->insert_log_api_rest($this->api_id, "loginViaEmail", $log_status, $log_message, $this->ip, $this->parameter_sent);

            $result['status'] = "400";
            $result['message'] = "Bad request, ".validation_errors();

            $result['status']  = $log_status;
            $result['message'] = $log_message;

            $this->response($result, 200);
            unset($result);
        }
    }

    function registerViaFb_post()
    {

    }

    function registerViaTw_post()
    {
        
    }

    function forgotPassword_post()
    {

    }

    function recoveryPassword_post()
    {

    }

    function activationUser_post()
    {

    }

    function basicInfoUser_post()
    {

    }

    function updateBasicInfoUser_post()
    {

    }

    function changeImageProfile_post()
    {

    }

    function changePassword_post()
    {

    }

    function followUser_post()
    {

    }

    function unFollowUser_post()
    {

    }

    function listFollowerUser_post()
    {

    }

    function closedAccount_post()
    {

    }

    function checkUserToken_post()
    {
        
    }
}