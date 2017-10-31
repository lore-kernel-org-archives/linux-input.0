From: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v2 1/2] HID: i2c-hid: add reset gpio property
Date: Tue, 31 Oct 2017 10:47:45 +0200
Message-ID: <87k1zbema6.fsf@intel.com>
References: <1509418996-25348-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51521 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbdJaIsP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Oct 2017 04:48:15 -0400
In-Reply-To: <1509418996-25348-1-git-send-email-hl@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jikos@kernel.org, robh@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, briannorris@chromium.org, devicetree@vger.kernel.org, Lin Huang <hl@rock-chips.com>

On Tue, 31 Oct 2017, Lin Huang <hl@rock-chips.com> wrote:
> some i2c hid devices have reset gpio, need to control
> it in the driver.

So I have Reviewed-by and Acked-by on *one* commit touching the files
being changed here. get_maintainer.pl is clueless, and you shouldn't use
its output verbatim.

BR,
Jani.

> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - Add 10us in usleep_range() upper range
> - reuse post_power_delay_ms as deassert reset delay
> - delete deassert_reset_us property
>
>  drivers/hid/i2c-hid/i2c-hid.c         | 61 +++++++++++++++++++++++++++--------
>  include/linux/platform_data/i2c-hid.h |  3 ++
>  2 files changed, 50 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 9145c21..9f06135 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -38,6 +38,7 @@
>  #include <linux/mutex.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/platform_data/i2c-hid.h>
> @@ -793,6 +794,35 @@ struct hid_ll_driver i2c_hid_ll_driver = {
>  };
>  EXPORT_SYMBOL_GPL(i2c_hid_ll_driver);
>  
> +static int i2c_hid_hw_power_on(struct i2c_hid *ihid)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(ihid->pdata.supply);
> +	if (ret < 0)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
> +	if (ihid->pdata.assert_reset_us)
> +		usleep_range(ihid->pdata.assert_reset_us,
> +			     ihid->pdata.assert_reset_us + 10);
> +
> +	gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 0);
> +
> +	/* use for power supply delay or reset deassert delay */
> +	if (ihid->pdata.post_power_delay_ms)
> +		msleep(ihid->pdata.post_power_delay_ms);
> +
> +	return ret;
> +}
> +
> +static int i2c_hid_hw_power_off(struct i2c_hid *ihid)
> +{
> +	gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
> +
> +	return regulator_disable(ihid->pdata.supply);
> +}
> +
>  static int i2c_hid_init_irq(struct i2c_client *client)
>  {
>  	struct i2c_hid *ihid = i2c_get_clientdata(client);
> @@ -934,6 +964,9 @@ static int i2c_hid_of_probe(struct i2c_client *client,
>  	if (!ret)
>  		pdata->post_power_delay_ms = val;
>  
> +	of_property_read_u32(dev->of_node, "assert-reset-us",
> +			     &pdata->assert_reset_us);
> +
>  	return 0;
>  }
>  
> @@ -1002,14 +1035,16 @@ static int i2c_hid_probe(struct i2c_client *client,
>  		goto err;
>  	}
>  
> -	ret = regulator_enable(ihid->pdata.supply);
> +	ihid->pdata.reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> +							 GPIOD_OUT_HIGH);
> +	if (IS_ERR(ihid->pdata.reset_gpio))
> +		goto err;
> +
> +	ret = i2c_hid_hw_power_on(ihid);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Failed to enable regulator: %d\n",
> -			ret);
> +		dev_err(&client->dev, "Failed to power on: %d\n", ret);
>  		goto err;
>  	}
> -	if (ihid->pdata.post_power_delay_ms)
> -		msleep(ihid->pdata.post_power_delay_ms);
>  
>  	i2c_set_clientdata(client, ihid);
>  
> @@ -1086,7 +1121,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	pm_runtime_disable(&client->dev);
>  
>  err_regulator:
> -	regulator_disable(ihid->pdata.supply);
> +	i2c_hid_hw_power_off(ihid);
>  
>  err:
>  	i2c_hid_free_buffers(ihid);
> @@ -1112,8 +1147,7 @@ static int i2c_hid_remove(struct i2c_client *client)
>  	if (ihid->bufsize)
>  		i2c_hid_free_buffers(ihid);
>  
> -	regulator_disable(ihid->pdata.supply);
> -
> +	i2c_hid_hw_power_off(ihid);
>  	kfree(ihid);
>  
>  	return 0;
> @@ -1165,9 +1199,10 @@ static int i2c_hid_suspend(struct device *dev)
>  			hid_warn(hid, "Failed to enable irq wake: %d\n",
>  				wake_status);
>  	} else {
> -		ret = regulator_disable(ihid->pdata.supply);
> +		ret = i2c_hid_hw_power_off(ihid);
>  		if (ret < 0)
> -			hid_warn(hid, "Failed to disable supply: %d\n", ret);
> +			hid_warn(hid, "Failed to disable hw power: %d\n",
> +				 ret);
>  	}
>  
>  	return 0;
> @@ -1182,11 +1217,9 @@ static int i2c_hid_resume(struct device *dev)
>  	int wake_status;
>  
>  	if (!device_may_wakeup(&client->dev)) {
> -		ret = regulator_enable(ihid->pdata.supply);
> +		ret = i2c_hid_hw_power_on(ihid);
>  		if (ret < 0)
> -			hid_warn(hid, "Failed to enable supply: %d\n", ret);
> -		if (ihid->pdata.post_power_delay_ms)
> -			msleep(ihid->pdata.post_power_delay_ms);
> +			hid_warn(hid, "Failed to enable hw power: %d\n", ret);
>  	} else if (ihid->irq_wake_enabled) {
>  		wake_status = disable_irq_wake(client->irq);
>  		if (!wake_status)
> diff --git a/include/linux/platform_data/i2c-hid.h b/include/linux/platform_data/i2c-hid.h
> index 1fb0882..40f1840 100644
> --- a/include/linux/platform_data/i2c-hid.h
> +++ b/include/linux/platform_data/i2c-hid.h
> @@ -14,6 +14,7 @@
>  
>  #include <linux/types.h>
>  
> +struct gpio_desc;
>  struct regulator;
>  
>  /**
> @@ -37,6 +38,8 @@ struct i2c_hid_platform_data {
>  	u16 hid_descriptor_address;
>  	struct regulator *supply;
>  	int post_power_delay_ms;
> +	struct gpio_desc *reset_gpio;
> +	int assert_reset_us;
>  };
>  
>  #endif /* __LINUX_I2C_HID_H */

-- 
Jani Nikula, Intel Open Source Technology Center
