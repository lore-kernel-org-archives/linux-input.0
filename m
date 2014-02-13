From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 01/11] Input: synaptics-rmi4 - do not kfree() managed
 memory in F01
Date: Thu, 13 Feb 2014 11:11:30 -0800
Message-ID: <52FD18E2.4060501@synaptics.com>
References: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:31137 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaBMTLb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 14:11:31 -0500
In-Reply-To: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On 02/12/2014 09:27 PM, Dmitry Torokhov wrote:
> Data that is allocated with devm_kzalloc() should not be freed with
> kfree(). In fact, we should rely on the fact that memory is managed and let
> devres core free it for us.
>
> Reported-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>

> ---
>   drivers/input/rmi4/rmi_f01.c | 23 +++++++++--------------
>   1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 381ad60..92b90d1 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -272,7 +272,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   	if (error < 0) {
>   		dev_err(&fn->dev,
>   			"Failed to read F01 control interrupt enable register.\n");
> -		goto error_exit;
> +		return error;
>   	}
>
>   	ctrl_base_addr += data->num_of_irq_regs;
> @@ -307,14 +307,14 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   					data->device_control.doze_interval);
>   			if (error < 0) {
>   				dev_err(&fn->dev, "Failed to configure F01 doze interval register.\n");
> -				goto error_exit;
> +				return error;
>   			}
>   		} else {
>   			error = rmi_read(rmi_dev, data->doze_interval_addr,
>   					&data->device_control.doze_interval);
>   			if (error < 0) {
>   				dev_err(&fn->dev, "Failed to read F01 doze interval register.\n");
> -				goto error_exit;
> +				return error;
>   			}
>   		}
>
> @@ -328,14 +328,14 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   					data->device_control.wakeup_threshold);
>   			if (error < 0) {
>   				dev_err(&fn->dev, "Failed to configure F01 wakeup threshold register.\n");
> -				goto error_exit;
> +				return error;
>   			}
>   		} else {
>   			error = rmi_read(rmi_dev, data->wakeup_threshold_addr,
>   					&data->device_control.wakeup_threshold);
>   			if (error < 0) {
>   				dev_err(&fn->dev, "Failed to read F01 wakeup threshold register.\n");
> -				goto error_exit;
> +				return error;
>   			}
>   		}
>   	}
> @@ -351,14 +351,14 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   					data->device_control.doze_holdoff);
>   			if (error < 0) {
>   				dev_err(&fn->dev, "Failed to configure F01 doze holdoff register.\n");
> -				goto error_exit;
> +				return error;
>   			}
>   		} else {
>   			error = rmi_read(rmi_dev, data->doze_holdoff_addr,
>   					&data->device_control.doze_holdoff);
>   			if (error < 0) {
>   				dev_err(&fn->dev, "Failed to read F01 doze holdoff register.\n");
> -				goto error_exit;
> +				return error;
>   			}
>   		}
>   	}
> @@ -367,22 +367,17 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   		&data->device_status, sizeof(data->device_status));
>   	if (error < 0) {
>   		dev_err(&fn->dev, "Failed to read device status.\n");
> -		goto error_exit;
> +		return error;
>   	}
>
>   	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
>   		dev_err(&fn->dev,
>   			"Device was reset during configuration process, status: %#02x!\n",
>   			RMI_F01_STATUS_CODE(data->device_status));
> -		error = -EINVAL;
> -		goto error_exit;
> +		return -EINVAL;
>   	}
>
>   	return 0;
> -
> - error_exit:
> -	kfree(data);
> -	return error;
>   }
>
>   static int rmi_f01_config(struct rmi_function *fn)
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
