From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: elan_i2c - Return error code when resume fail.
Date: Sat, 7 Mar 2015 21:11:42 -0800
Message-ID: <20150308051142.GC4054@dtor-ws>
References: <1425728567-14089-1-git-send-email-dusonlin@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:42806 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbCHFLq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Mar 2015 00:11:46 -0500
Content-Disposition: inline
In-Reply-To: <1425728567-14089-1-git-send-email-dusonlin@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Duson Lin <dusonlin@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

On Sat, Mar 07, 2015 at 07:42:47PM +0800, Duson Lin wrote:
> The resume function always return success, so stop event can not be
> triggered when "suspend_stress_test" running. In order to debug more
> easily, we add some error messages in elan_enable_power and
> elan_disable_power funtion.
> 
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c |   10 +++++++---
>  drivers/input/mouse/elan_i2c_i2c.c  |    7 ++++++-
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 16f9584..f24078b 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -111,6 +111,7 @@ static int elan_enable_power(struct elan_tp_data *data)
>  		msleep(30);
>  	} while (--repeat > 0);
>  
> +	dev_err(&data->client->dev, "Failed to enable power\n");
>  	return error;
>  }
>  
> @@ -138,6 +139,7 @@ static int elan_disable_power(struct elan_tp_data *data)
>  		msleep(30);
>  	} while (--repeat > 0);
>  
> +	dev_err(&data->client->dev, "Failed to disable power\n");
>  	return error;
>  }
>  
> @@ -1084,16 +1086,18 @@ static int __maybe_unused elan_resume(struct device *dev)
>  	}
>  
>  	error = elan_enable_power(data);
> -	if (error)
> +	if (error) {
>  		dev_err(dev, "power up when resuming failed: %d\n", error);
> +		goto err;
> +	}
>  
>  	error = elan_initialize(data);
>  	if (error)
>  		dev_err(dev, "initialize when resuming failed: %d\n", error);
>  
> +err:
>  	enable_irq(data->client->irq);
> -
> -	return 0;
> +	return error;
>  }
>  
>  static SIMPLE_DEV_PM_OPS(elan_pm_ops, elan_suspend, elan_resume);
> diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_i2c_i2c.c
> index 029941f..e29b28c 100644
> --- a/drivers/input/mouse/elan_i2c_i2c.c
> +++ b/drivers/input/mouse/elan_i2c_i2c.c
> @@ -117,7 +117,12 @@ static int elan_i2c_write_cmd(struct i2c_client *client, u16 reg, u16 cmd)
>  	int ret;
>  
>  	ret = i2c_transfer(client->adapter, &msg, 1);
> -	return ret == 1 ? 0 : (ret < 0 ? ret : -EIO);
> +	if (ret != 1) {
> +		dev_err(&client->dev, "writing cmd (0x%04x) fail.\n", reg);
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	return 0;
>  }
>  
>  static int elan_i2c_initialize(struct i2c_client *client)
> -- 
> 1.7.10.4
> 

-- 
Dmitry
