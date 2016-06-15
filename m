From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/7] Input: synaptics-rmi4: Add parameters for dribble
 packets and palm detect gesture
Date: Wed, 15 Jun 2016 11:28:36 +0200
Message-ID: <20160615092836.GT24234@mail.corp.redhat.com>
References: <1464979175-2438-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbcFOJ2l (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2016 05:28:41 -0400
Content-Disposition: inline
In-Reply-To: <1464979175-2438-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>

On Jun 03 2016 or thereabouts, Andrew Duggan wrote:
> The rmi_f11 driver currently disables dribble packets and the palm detect
> gesture for all devices. This patch creates a parameter in the 2d sensor
> platform data for controlling this functionality on a per device basis.
> 
> For more information on dribble packets:
> Commit 05ba999fcabb ("HID: rmi: disable dribble packets on Synaptics
> touchpads")
> 
> For more information on the palm detect gesture:
> Commit f097deef59a6 ("HID: rmi: disable palm detect gesture when present")
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  drivers/input/rmi4/rmi_2d_sensor.h |  2 ++
>  drivers/input/rmi4/rmi_f01.c       |  6 +++---
>  drivers/input/rmi4/rmi_f11.c       | 32 ++++++++++++++++++++++++++++----
>  include/linux/rmi.h                | 21 +++++++++++++--------
>  4 files changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_2d_sensor.h b/drivers/input/rmi4/rmi_2d_sensor.h
> index 77fcdfe..a9de0fb 100644
> --- a/drivers/input/rmi4/rmi_2d_sensor.h
> +++ b/drivers/input/rmi4/rmi_2d_sensor.h
> @@ -67,6 +67,8 @@ struct rmi_2d_sensor {
>  	u8 report_rel;
>  	u8 x_mm;
>  	u8 y_mm;
> +	int dribble;
> +	int palm_detect;

These 2 fields should probably be "enum rmi_reg_state", not int.

The rest looks fine. With this amended:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  };
>  
>  int rmi_2d_sensor_of_probe(struct device *dev,
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index fac81fc..2cfa9f6 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -327,12 +327,12 @@ static int rmi_f01_probe(struct rmi_function *fn)
>  	}
>  
>  	switch (pdata->power_management.nosleep) {
> -	case RMI_F01_NOSLEEP_DEFAULT:
> +	case RMI_REG_STATE_DEFAULT:
>  		break;
> -	case RMI_F01_NOSLEEP_OFF:
> +	case RMI_REG_STATE_OFF:
>  		f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_NOSLEEP_BIT;
>  		break;
> -	case RMI_F01_NOSLEEP_ON:
> +	case RMI_REG_STATE_ON:
>  		f01->device_control.ctrl0 |= RMI_F01_CTRL0_NOSLEEP_BIT;
>  		break;
>  	}
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index ec8a10d..e691432 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -1125,6 +1125,8 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>  	sensor->topbuttonpad = f11->sensor_pdata.topbuttonpad;
>  	sensor->kernel_tracking = f11->sensor_pdata.kernel_tracking;
>  	sensor->dmax = f11->sensor_pdata.dmax;
> +	sensor->dribble = f11->sensor_pdata.dribble;
> +	sensor->palm_detect = f11->sensor_pdata.palm_detect;
>  
>  	if (f11->sens_query.has_physical_props) {
>  		sensor->x_mm = f11->sens_query.x_sensor_size_mm;
> @@ -1192,11 +1194,33 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>  		ctrl->ctrl0_11[RMI_F11_DELTA_Y_THRESHOLD] =
>  			sensor->axis_align.delta_y_threshold;
>  
> -	if (f11->sens_query.has_dribble)
> -		ctrl->ctrl0_11[0] = ctrl->ctrl0_11[0] & ~BIT(6);
> +	if (f11->sens_query.has_dribble) {
> +		switch (sensor->dribble) {
> +		case RMI_REG_STATE_OFF:
> +			ctrl->ctrl0_11[0] = ctrl->ctrl0_11[0] & ~BIT(6);
> +			break;
> +		case RMI_REG_STATE_ON:
> +			ctrl->ctrl0_11[0] = ctrl->ctrl0_11[0] | BIT(6);
> +			break;
> +		case RMI_REG_STATE_DEFAULT:
> +		default:
> +			break;
> +		}
> +	}
>  
> -	if (f11->sens_query.has_palm_det)
> -		ctrl->ctrl0_11[11] = ctrl->ctrl0_11[11] & ~BIT(0);
> +	if (f11->sens_query.has_palm_det) {
> +		switch (sensor->palm_detect) {
> +		case RMI_REG_STATE_OFF:
> +			ctrl->ctrl0_11[11] = ctrl->ctrl0_11[11] & ~BIT(0);
> +			break;
> +		case RMI_REG_STATE_ON:
> +			ctrl->ctrl0_11[11] = ctrl->ctrl0_11[11] & BIT(0);
> +			break;
> +		case RMI_REG_STATE_DEFAULT:
> +		default:
> +			break;
> +		}
> +	}
>  
>  	rc = f11_write_control_regs(fn, &f11->sens_query,
>  			   &f11->dev_controls, fn->fd.query_base_addr);
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index e0aca14..bda72f2 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -99,6 +99,8 @@ struct rmi_2d_sensor_platform_data {
>  	bool topbuttonpad;
>  	bool kernel_tracking;
>  	int dmax;
> +	int dribble;
> +	int palm_detect;
>  };
>  
>  /**
> @@ -116,14 +118,17 @@ struct rmi_f30_data {
>  	bool disable;
>  };
>  
> -/**
> - * struct rmi_f01_power - override default power management settings.
> - *
> +
> +/*
> + * Set the state of a register
> + *	DEFAULT - use the default value set by the firmware config
> + *	OFF - explicitly disable the register
> + *	ON - explicitly enable the register
>   */
> -enum rmi_f01_nosleep {
> -	RMI_F01_NOSLEEP_DEFAULT = 0,
> -	RMI_F01_NOSLEEP_OFF = 1,
> -	RMI_F01_NOSLEEP_ON = 2
> +enum rmi_reg_state {
> +	RMI_REG_STATE_DEFAULT = 0,
> +	RMI_REG_STATE_OFF = 1,
> +	RMI_REG_STATE_ON = 2
>  };
>  
>  /**
> @@ -143,7 +148,7 @@ enum rmi_f01_nosleep {
>   * when the touch sensor is in doze mode, in units of 10ms.
>   */
>  struct rmi_f01_power_management {
> -	enum rmi_f01_nosleep nosleep;
> +	enum rmi_reg_state nosleep;
>  	u8 wakeup_threshold;
>  	u8 doze_holdoff;
>  	u8 doze_interval;
> -- 
> 2.5.0
> 
