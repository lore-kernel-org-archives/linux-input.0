From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix spelling in defines
Date: Thu, 19 May 2016 09:32:48 -0700
Message-ID: <20160519163248.GC38800@dtor-ws>
References: <1463646466-893-1-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34374 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbcESQcw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 12:32:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so8647249pfz.1
        for <linux-input@vger.kernel.org>; Thu, 19 May 2016 09:32:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1463646466-893-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Andrew Duggan <aduggan@synaptics.com>

On Thu, May 19, 2016 at 09:27:46AM +0100, Nick Dyer wrote:
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_f01.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index eb362bc..fac81fc 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -81,26 +81,26 @@ struct f01_basic_properties {
>   * This bit disables whatever sleep mode may be selected by the sleep_mode
>   * field and forces the device to run at full power without sleeping.
>   */
> -#define RMI_F01_CRTL0_NOSLEEP_BIT	BIT(2)
> +#define RMI_F01_CTRL0_NOSLEEP_BIT	BIT(2)
>  
>  /*
>   * When this bit is set, the touch controller employs a noise-filtering
>   * algorithm designed for use with a connected battery charger.
>   */
> -#define RMI_F01_CRTL0_CHARGER_BIT	BIT(5)
> +#define RMI_F01_CTRL0_CHARGER_BIT	BIT(5)
>  
>  /*
>   * Sets the report rate for the device. The effect of this setting is
>   * highly product dependent. Check the spec sheet for your particular
>   * touch sensor.
>   */
> -#define RMI_F01_CRTL0_REPORTRATE_BIT	BIT(6)
> +#define RMI_F01_CTRL0_REPORTRATE_BIT	BIT(6)
>  
>  /*
>   * Written by the host as an indicator that the device has been
>   * successfully configured.
>   */
> -#define RMI_F01_CRTL0_CONFIGURED_BIT	BIT(7)
> +#define RMI_F01_CTRL0_CONFIGURED_BIT	BIT(7)
>  
>  /**
>   * @ctrl0 - see the bit definitions above.
> @@ -330,10 +330,10 @@ static int rmi_f01_probe(struct rmi_function *fn)
>  	case RMI_F01_NOSLEEP_DEFAULT:
>  		break;
>  	case RMI_F01_NOSLEEP_OFF:
> -		f01->device_control.ctrl0 &= ~RMI_F01_CRTL0_NOSLEEP_BIT;
> +		f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_NOSLEEP_BIT;
>  		break;
>  	case RMI_F01_NOSLEEP_ON:
> -		f01->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
> +		f01->device_control.ctrl0 |= RMI_F01_CTRL0_NOSLEEP_BIT;
>  		break;
>  	}
>  
> @@ -349,7 +349,7 @@ static int rmi_f01_probe(struct rmi_function *fn)
>  		f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
>  	}
>  
> -	f01->device_control.ctrl0 |= RMI_F01_CRTL0_CONFIGURED_BIT;
> +	f01->device_control.ctrl0 |= RMI_F01_CTRL0_CONFIGURED_BIT;
>  
>  	error = rmi_write(rmi_dev, fn->fd.control_base_addr,
>  			  f01->device_control.ctrl0);
> @@ -535,8 +535,8 @@ static int rmi_f01_suspend(struct rmi_function *fn)
>  	int error;
>  
>  	f01->old_nosleep =
> -		f01->device_control.ctrl0 & RMI_F01_CRTL0_NOSLEEP_BIT;
> -	f01->device_control.ctrl0 &= ~RMI_F01_CRTL0_NOSLEEP_BIT;
> +		f01->device_control.ctrl0 & RMI_F01_CTRL0_NOSLEEP_BIT;
> +	f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_NOSLEEP_BIT;
>  
>  	f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
>  	if (device_may_wakeup(fn->rmi_dev->xport->dev))
> @@ -549,7 +549,7 @@ static int rmi_f01_suspend(struct rmi_function *fn)
>  	if (error) {
>  		dev_err(&fn->dev, "Failed to write sleep mode: %d.\n", error);
>  		if (f01->old_nosleep)
> -			f01->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
> +			f01->device_control.ctrl0 |= RMI_F01_CTRL0_NOSLEEP_BIT;
>  		f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
>  		f01->device_control.ctrl0 |= RMI_SLEEP_MODE_NORMAL;
>  		return error;
> @@ -564,7 +564,7 @@ static int rmi_f01_resume(struct rmi_function *fn)
>  	int error;
>  
>  	if (f01->old_nosleep)
> -		f01->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
> +		f01->device_control.ctrl0 |= RMI_F01_CTRL0_NOSLEEP_BIT;
>  
>  	f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
>  	f01->device_control.ctrl0 |= RMI_SLEEP_MODE_NORMAL;
> -- 
> 2.5.0
> 

-- 
Dmitry
