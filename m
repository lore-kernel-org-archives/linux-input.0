From: =?big5?B?RUxBTiC8QrnFwkA=?= <scott.liu@emc.com.tw>
Subject: RE: [PATCH] Input: elants_i2c - wire up regulator support
Date: Thu, 6 Aug 2015 15:03:36 +0800
Message-ID: <005d01d0d016$072f9080$158eb180$@emc.com.tw>
References: <20150805185357.GA31387@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:30646 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbbHFHN6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 03:13:58 -0400
In-Reply-To: <20150805185357.GA31387@dtor-ws>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dtor@chromium.org>
Cc: 'Rob Herring' <robh+dt@kernel.org>, 'Mark Rutland' <mark.rutland@arm.com>, 'Benson Leung' <bleung@chromium.org>, 'Duson Lin' <dusonlin@emc.com.tw>, 'James Chen' <james.chen@emc.com.tw>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Dmitry

	I am curious about how reset gpio works and I think the reset gpio
at low level after elants_i2c_power_on(),
	So that the controller won't response anyway, please see below my
question and correct me if I am wrong.

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dtor@chromium.org]
> Sent: Thursday, August 06, 2015 2:54 AM
> To: linux-input@vger.kernel.org
> Cc: Rob Herring; Mark Rutland; Benson Leung; Duson Lin; Scott Liu; James
> Chen; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-input@vger.kernel.org
> Subject: [PATCH] Input: elants_i2c - wire up regulator support
> 
> Elan touchscreen controllers use two power supplies, vcc33 and vccio, and
> we need to enable them before trying to access the device. On X86 firmware
> usually does this, but on ARM it is usually left to the kernel.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  .../devicetree/bindings/input/elants_i2c.txt       |   3 +
>  drivers/input/touchscreen/elants_i2c.c             | 184
> ++++++++++++++++++---
>  2 files changed, 165 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/elants_i2c.txt
> b/Documentation/devicetree/bindings/input/elants_i2c.txt
> index a765232..8a71038 100644
> --- a/Documentation/devicetree/bindings/input/elants_i2c.txt
> +++ b/Documentation/devicetree/bindings/input/elants_i2c.txt
> @@ -13,6 +13,9 @@ Optional properties:
>  - pinctrl-names: should be "default" (see pinctrl binding [1]).
>  - pinctrl-0: a phandle pointing to the pin settings for the device (see
>    pinctrl binding [1]).
> +- reset-gpios: reset gpio the chip is connected to.
> +- vcc33-supply: a phandle for the regulator supplying 3.3V power.
> +- vccio-supply: a phandle for the regulator supplying IO power.
> 
>  [0]:
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  [1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> diff --git a/drivers/input/touchscreen/elants_i2c.c
> b/drivers/input/touchscreen/elants_i2c.c
> index 42e43f1..1912265 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -38,6 +38,8 @@
>  #include <linux/input/mt.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
>  #include <asm/unaligned.h>
> 
>  /* Device, Driver information */
> @@ -102,6 +104,9 @@
>  /* calibration timeout definition */
>  #define ELAN_CALI_TIMEOUT_MSEC	10000
> 
> +#define ELAN_POWERON_DELAY_USEC	500
> +#define ELAN_RESET_DELAY_MSEC	20
> +
>  enum elants_state {
>  	ELAN_STATE_NORMAL,
>  	ELAN_WAIT_QUEUE_HEADER,
> @@ -118,6 +123,10 @@ struct elants_data {
>  	struct i2c_client *client;
>  	struct input_dev *input;
> 
> +	struct regulator *vcc33;
> +	struct regulator *vccio;
> +	struct gpio_desc *reset_gpio;
> +
>  	u16 fw_version;
>  	u8 test_version;
>  	u8 solution_version;
> @@ -141,6 +150,7 @@ struct elants_data {
>  	u8 buf[MAX_PACKET_SIZE];
> 
>  	bool wake_irq_enabled;
> +	bool keep_power_in_suspend;
>  };
> 
>  static int elants_i2c_send(struct i2c_client *client, @@ -1058,6 +1068,67
> @@ static void elants_i2c_remove_sysfs_group(void *_data)
>  	sysfs_remove_group(&ts->client->dev.kobj,
> &elants_attribute_group);  }
> 
> +static int elants_i2c_power_on(struct elants_data *ts) {
> +	int error;
> +
> +	/*
> +	 * If we do not have reset gpio assume platform firmware
> +	 * controls regulators and does power them on for us.
> +	 */
> +	if (IS_ERR_OR_NULL(ts->reset_gpio))
> +		return 0;
> +
> +	gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +
> +	error = regulator_enable(ts->vcc33);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"failed to enable vcc33 regulator: %d\n",
> +			error);
> +		goto release_reset_gpio;
> +	}
> +
> +	error = regulator_enable(ts->vccio);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"failed to enable vccio regulator: %d\n",
> +			error);
> +		regulator_disable(ts->vcc33);
> +		goto release_reset_gpio;
> +	}
> +
> +	/*
> +	 * We need to wait a bit after powering on controller before
> +	 * we are allowed to release reset GPIO.
> +	 */
> +	udelay(ELAN_POWERON_DELAY_USEC);
> +
> +release_reset_gpio:
> +	gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +	if (error)
> +		return error;
> +
> +	msleep(ELAN_RESET_DELAY_MSEC);
> +
> +	return 0;
> +}
> +
> +static void elants_i2c_power_off(void *_data) {
> +	struct elants_data *ts = _data;
> +
> +	if (!IS_ERR_OR_NULL(ts->reset_gpio)) {
> +		/*
> +		 * Activate reset gpio to prevent leakage through the
> +		 * pin once we shut off power to the controller.
> +		 */
> +		gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +		regulator_disable(ts->vccio);
> +		regulator_disable(ts->vcc33);
> +	}
> +}
> +
>  static int elants_i2c_probe(struct i2c_client *client,
>  			    const struct i2c_device_id *id)
>  {
> @@ -1072,13 +1143,6 @@ static int elants_i2c_probe(struct i2c_client
> *client,
>  		return -ENXIO;
>  	}
> 
> -	/* Make sure there is something at this address */
> -	if (i2c_smbus_xfer(client->adapter, client->addr, 0,
> -			I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy) < 0) {
> -		dev_err(&client->dev, "nothing at this address\n");
> -		return -ENXIO;
> -	}
> -
>  	ts = devm_kzalloc(&client->dev, sizeof(struct elants_data),
> GFP_KERNEL);
>  	if (!ts)
>  		return -ENOMEM;
> @@ -1089,6 +1153,70 @@ static int elants_i2c_probe(struct i2c_client
> *client,
>  	ts->client = client;
>  	i2c_set_clientdata(client, ts);
> 
> +	ts->vcc33 = devm_regulator_get(&client->dev, "vcc33");
> +	if (IS_ERR(ts->vcc33)) {
> +		error = PTR_ERR(ts->vcc33);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&client->dev,
> +				"Failed to get 'vcc33' regulator: %d\n",
> +				error);
> +		return error;
> +	}
> +
> +	ts->vccio = devm_regulator_get(&client->dev, "vccio");
> +	if (IS_ERR(ts->vccio)) {
> +		error = PTR_ERR(ts->vccio);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&client->dev,
> +				"Failed to get 'vccio' regulator: %d\n",
> +				error);
> +		return error;
> +	}
> +
> +	ts->reset_gpio = devm_gpiod_get(&client->dev, "reset");
> +	if (IS_ERR(ts->reset_gpio)) {
> +		error = PTR_ERR(ts->reset_gpio);
> +
> +		if (error == -EPROBE_DEFER)
> +			return error;
> +
> +		if (error != -ENOENT && error != -ENOSYS) {
> +			dev_err(&client->dev,
> +				"failed to get reset gpio: %d\n",
> +				error);
> +			return error;
> +		}
> +
> +		ts->keep_power_in_suspend = true;
> +	} else {
> +		error = gpiod_direction_output(ts->reset_gpio, 0);

	Does it mean to reset our controller? (reset gpio pull low).

> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to configure reset gpio as output:
%d\n",
> +				error);
> +			return error;
> +		}
> +	}
> +
> +	error = elants_i2c_power_on(ts);

	If reset gpio is at low, controller won't response initialize flow.
	I am curious that does reset pin be at low level after
elants_i2c_power_on(ts)?

Thanks,
Scott

> +	if (error)
> +		return error;
> +
> +	error = devm_add_action(&client->dev, elants_i2c_power_off, ts);
> +	if (error) {
> +		dev_err(&client->dev,
> +			"failed to install power off action: %d\n", error);
> +		elants_i2c_power_off(ts);
> +		return error;
> +	}
> +
> +	/* Make sure there is something at this address */
> +	if (i2c_smbus_xfer(client->adapter, client->addr, 0,
> +			   I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy) < 0) {
> +		dev_err(&client->dev, "nothing at this address\n");
> +		return -ENXIO;
> +	}
> +
>  	error = elants_i2c_initialize(ts);
>  	if (error) {
>  		dev_err(&client->dev, "failed to initialize: %d\n", error);
@@
> -1196,17 +1324,23 @@ static int __maybe_unused elants_i2c_suspend(struct
> device *dev)
> 
>  	disable_irq(client->irq);
> 
> -	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
> -		error = elants_i2c_send(client, set_sleep_cmd,
> -					sizeof(set_sleep_cmd));
> -		if (!error)
> -			break;
> +	if (device_may_wakeup(dev) || ts->keep_power_in_suspend) {
> +		for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
> +			error = elants_i2c_send(client, set_sleep_cmd,
> +						sizeof(set_sleep_cmd));
> +			if (!error)
> +				break;
> 
> -		dev_err(&client->dev, "suspend command failed: %d\n",
error);
> -	}
> +			dev_err(&client->dev,
> +				"suspend command failed: %d\n", error);
> +		}
> 
> -	if (device_may_wakeup(dev))
> -		ts->wake_irq_enabled = (enable_irq_wake(client->irq) == 0);
> +		if (device_may_wakeup(dev))
> +			ts->wake_irq_enabled =
> +					(enable_irq_wake(client->irq) == 0);
> +	} else {
> +		elants_i2c_power_off(ts);
> +	}
> 
>  	return 0;
>  }
> @@ -1222,13 +1356,19 @@ static int __maybe_unused
> elants_i2c_resume(struct device *dev)
>  	if (device_may_wakeup(dev) && ts->wake_irq_enabled)
>  		disable_irq_wake(client->irq);
> 
> -	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
> -		error = elants_i2c_send(client, set_active_cmd,
> -					sizeof(set_active_cmd));
> -		if (!error)
> -			break;
> +	if (ts->keep_power_in_suspend) {
> +		for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
> +			error = elants_i2c_send(client, set_active_cmd,
> +						sizeof(set_active_cmd));
> +			if (!error)
> +				break;
> 
> -		dev_err(&client->dev, "resume command failed: %d\n", error);
> +			dev_err(&client->dev,
> +				"resume command failed: %d\n", error);
> +		}
> +	} else {
> +		elants_i2c_power_on(ts);
> +		elants_i2c_initialize(ts);
>  	}
> 
>  	ts->state = ELAN_STATE_NORMAL;
> --
> 2.5.0.rc2.392.g76e840b
> 
> 
> --
> Dmitry

