From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 06/15] Input: synaptics-rmi4 - remove platform suspend
 callbacks
Date: Tue, 4 Feb 2014 15:09:45 -0800
Message-ID: <52F17339.2010406@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:16986 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbaBDXJr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:09:47 -0500
In-Reply-To: <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> These are unnecessary and ugly. Remove them, and all related code.

Ugly though they might be, on a number of hardware implementations they 
are quite necessary in order to provide hooks to handle hardware 
specific suspend/resume activities relating to power management and 
device configuration.  Your subsequent patch relating to the VIO/VDD 
regulators might eventually render these obsolete, but in the meantime 
let's not kill them off while they're still useful.

>
> Cc: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> ---
>   drivers/input/rmi4/rmi_driver.c | 57 ++---------------------------------------
>   drivers/input/rmi4/rmi_driver.h | 10 --------
>   include/linux/rmi.h             | 20 ---------------
>   3 files changed, 2 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 780742f..691b6fb 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -621,60 +621,16 @@ error_exit:
>   #ifdef CONFIG_PM_SLEEP
>   static int rmi_driver_suspend(struct device *dev)
>   {
> -	struct rmi_driver_data *data;
> -	int retval = 0;
>   	struct rmi_device *rmi_dev = to_rmi_device(dev);
>
> -	data = dev_get_drvdata(&rmi_dev->dev);
> -
> -	mutex_lock(&data->suspend_mutex);
> -
> -	if (data->pre_suspend) {
> -		retval = data->pre_suspend(data->pm_data);
> -		if (retval)
> -			goto exit;
> -	}
> -
>   	disable_sensor(rmi_dev);
> -
> -	if (data->post_suspend)
> -		retval = data->post_suspend(data->pm_data);
> -
> -exit:
> -	mutex_unlock(&data->suspend_mutex);
> -	return retval;
> +	return 0;
>   }
>
>   static int rmi_driver_resume(struct device *dev)
>   {
> -	struct rmi_driver_data *data;
> -	int retval = 0;
>   	struct rmi_device *rmi_dev = to_rmi_device(dev);
> -
> -	data = dev_get_drvdata(&rmi_dev->dev);
> -	mutex_lock(&data->suspend_mutex);
> -
> -	if (data->pre_resume) {
> -		retval = data->pre_resume(data->pm_data);
> -		if (retval)
> -			goto exit;
> -	}
> -
> -	retval = enable_sensor(rmi_dev);
> -	if (retval)
> -		goto exit;
> -
> -
> -	if (data->post_resume) {
> -		retval = data->post_resume(data->pm_data);
> -		if (retval)
> -			goto exit;
> -	}
> -
> -	data->suspended = false;
> -exit:
> -	mutex_unlock(&data->suspend_mutex);
> -	return retval;
> +	return enable_sensor(rmi_dev);
>   }
>
>   #endif /* CONFIG_PM_SLEEP */
> @@ -811,15 +767,6 @@ static int rmi_driver_probe(struct device *dev)
>   		retval = -ENOMEM;
>   		goto err_free_data;
>   	}
> -	if (IS_ENABLED(CONFIG_PM)) {
> -		data->pm_data = pdata->pm_data;
> -		data->pre_suspend = pdata->pre_suspend;
> -		data->post_suspend = pdata->post_suspend;
> -		data->pre_resume = pdata->pre_resume;
> -		data->post_resume = pdata->post_resume;
> -
> -		mutex_init(&data->suspend_mutex);
> -	}
>
>   	data->irq = pdata->irq;
>   	if (data->irq < 0) {
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index aef5521..f28166f 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -53,16 +53,6 @@ struct rmi_driver_data {
>   	u8 bsr;
>
>   	bool enabled;
> -#ifdef CONFIG_PM_SLEEP
> -	bool suspended;
> -	struct mutex suspend_mutex;
> -
> -	void *pm_data;
> -	int (*pre_suspend) (const void *pm_data);
> -	int (*post_suspend) (const void *pm_data);
> -	int (*pre_resume) (const void *pm_data);
> -	int (*post_resume) (const void *pm_data);
> -#endif
>
>   #ifdef CONFIG_RMI4_DEBUG
>   	struct dentry *debugfs_delay;
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index 326e741..41c2c04 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -204,8 +204,6 @@ struct rmi_device_platform_data_spi {
>    * @f11_rezero_wait - if non-zero, this is how may milliseconds the F11 2D
>    * sensor will wait before being be rezeroed on exit from suspend.  If
>    * this value is zero, the F11 2D sensor will not be rezeroed on resume.
> - * @pre_suspend - this will be called before any other suspend operations are
> - * done.
>    * @power_management - overrides default touch sensor doze mode settings (see
>    * above)
>    * @f19_button_map - provide initial input subsystem key mappings for F19.
> @@ -213,16 +211,6 @@ struct rmi_device_platform_data_spi {
>    * @gpioled_map - provides initial settings for GPIOs and LEDs controlled by
>    * F30.
>    * @f41_button_map - provide initial input subsystem key mappings for F41.
> - *
> - * @post_suspend - this will be called after all suspend operations are
> - * completed.  This is the ONLY safe place to power off an RMI sensor
> - * during the suspend process.
> - * @pre_resume - this is called before any other resume operations.  If you
> - * powered off the RMI4 sensor in post_suspend(), then you MUST power it back
> - * here, and you MUST wait an appropriate time for the ASIC to come up
> - * (100ms to 200ms, depending on the sensor) before returning.
> - * @pm_data - this will be passed to the various (pre|post)_(suspend/resume)
> - * functions.
>    */
>   struct rmi_device_platform_data {
>   	int irq;
> @@ -242,14 +230,6 @@ struct rmi_device_platform_data {
>   #ifdef CONFIG_RMI4_FWLIB
>   	char *firmware_name;
>   #endif
> -
> -#ifdef	CONFIG_PM
> -	void *pm_data;
> -	int (*pre_suspend) (const void *pm_data);
> -	int (*post_suspend) (const void *pm_data);
> -	int (*pre_resume) (const void *pm_data);
> -	int (*post_resume) (const void *pm_data);
> -#endif
>   };
>
>   /**
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
