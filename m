From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 11/15] Input: synaptics-rmi4 - add regulator support
Date: Tue, 4 Feb 2014 15:10:32 -0800
Message-ID: <52F17368.1030808@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:11706 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933867AbaBDXKd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:10:33 -0500
In-Reply-To: <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> Add support for VDD and VIO power supplies.  Since we may need a delay
> after turning on the chip, adjust code to manage that.  This removes the
> scanning for active interrupts on resume, as we should get an interrupt
> when the chip is ready.

This looks potentially useful.  But what happens in devices where you 
want to power the touch sensor on at initial boot, but need to leave it 
power on during suspend/resume states?  Also, how does this work when 
there are multiple RMI4 sensors in the system?

See also comments below.

> Cc: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> ---
>   Documentation/devicetree/bindings/input/rmi4.txt | 10 +++++
>   drivers/input/rmi4/rmi_driver.c                  | 53 +++++++++++++++++++++++-
>   drivers/input/rmi4/rmi_driver.h                  |  4 ++
>   3 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/input/rmi4.txt b/Documentation/devicetree/bindings/input/rmi4.txt
> index fff9db7..d41beac 100644
> --- a/Documentation/devicetree/bindings/input/rmi4.txt
> +++ b/Documentation/devicetree/bindings/input/rmi4.txt
> @@ -12,6 +12,16 @@ interrupts:
>   	Desc: See devicetree/bindings/interrupt-controller/interrupts.txt;
>   		Trigger sense required in mask
>
> +vdd-supply:
> +	Usage: optional (default: no regulator)
> +	Type: <prop-encoded-array>
> +	Desc: VDD power supply; See devicetree/bindings/regulator/regulator.txt
> +
> +vio-supply:
> +	Usage: optional (default: no regulator)
> +	Type: <prop-encoded-array>
> +	Desc: VIO power supply; See devicetree/bindings/regulator/regulator.txt
> +
>   syn,reset-delay:
>   	Usage: optional (default: 100)
>   	Type: u32, milliseconds
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 92415ce..52345ae 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -28,6 +28,7 @@
>   #include <linux/uaccess.h>
>   #include <linux/of_irq.h>
>   #include <linux/of.h>
> +#include <linux/regulator/consumer.h>
>   #include <uapi/linux/input.h>
>   #include "rmi_bus.h"
>   #include "rmi_driver.h"
> @@ -101,7 +102,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
>
>   	data->enabled = true;
>
> -	return process_interrupt_requests(rmi_dev);
> +	return 0;

enable_sensor() and disable_sensor() may be called in a variety of 
contexts, and there may be pending interrupts at the time 
enable_sensor() is called.

>   }
>
>   static void rmi_free_function_list(struct rmi_device *rmi_dev)
> @@ -616,14 +617,29 @@ error_exit:
>   static int rmi_driver_suspend(struct device *dev)
>   {
>   	struct rmi_device *rmi_dev = to_rmi_device(dev);
> +	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>
>   	disable_sensor(rmi_dev);
> +
> +	regulator_disable(data->vio);
> +	regulator_disable(data->vdd);
> +
>   	return 0;
>   }
>
>   static int rmi_driver_resume(struct device *dev)
>   {
>   	struct rmi_device *rmi_dev = to_rmi_device(dev);
> +	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> +	int retval;
> +
> +	retval = regulator_enable(data->vdd);
> +	if (retval)
> +		return retval;
> +	retval = regulator_enable(data->vio);
> +	if (retval)
> +		return retval;

If you've toggled power to the sensor, you may need to do a reset wait 
here, just like you did on initialization.

> +
>   	return enable_sensor(rmi_dev);
>   }
>
> @@ -634,7 +650,12 @@ static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend, rmi_driver_resume);
>   static int rmi_driver_remove(struct device *dev)
>   {
>   	struct rmi_device *rmi_dev = to_rmi_device(dev);
> +	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> +
>   	disable_sensor(rmi_dev);
> +
> +	regulator_disable(data->vio);
> +	regulator_disable(data->vdd);
>   	rmi_free_function_list(rmi_dev);
>
>   	return 0;
> @@ -649,6 +670,7 @@ static int rmi_driver_probe(struct device *dev)
>   	int retval = 0;
>   	struct rmi_device *rmi_dev;
>   	unsigned int irq;
> +	bool delay_start = false;
>   	u32 reset_delay;
>
>   	dev_dbg(dev, "%s: Starting probe.\n", __func__);
> @@ -696,6 +718,33 @@ static int rmi_driver_probe(struct device *dev)
>   	dev_set_drvdata(&rmi_dev->dev, data);
>   	mutex_init(&data->pdt_mutex);
>
> +	data->vdd = devm_regulator_get_optional(dev, "vdd");
> +	if (IS_ERR(data->vdd)) {
> +		dev_err(dev, "Failed to get regulator 'vdd'\n");
> +		return PTR_ERR(data->vdd);
> +	}
> +	data->vio = devm_regulator_get_optional(dev, "vio");
> +	if (IS_ERR(data->vio)) {
> +		dev_err(dev, "Failed to get regulator 'vio'\n");
> +		return PTR_ERR(data->vio);
> +	}
> +
> +	if (data->vdd && !regulator_is_enabled(data->vdd))
> +		delay_start = true;
> +	if (data->vio && !regulator_is_enabled(data->vio))
> +		delay_start = true;
> +
> +	retval = regulator_enable(data->vdd);
> +	if (retval) {
> +		dev_err(dev, "Failed to enable regulator\n");
> +		return retval;
> +	}
> +	retval = regulator_enable(data->vio);
> +	if (retval) {
> +		dev_err(dev, "Failed to enable regulator\n");
> +		return retval;
> +	}
> +
>   	/*
>   	 * Right before a warm boot, the sensor might be in some unusual state,
>   	 * such as F54 diagnostics, or F34 bootloader mode.  In order to clear
> @@ -714,6 +763,8 @@ static int rmi_driver_probe(struct device *dev)
>   	 */
>   	if (!reset_delay)
>   		reset_delay = DEFAULT_RESET_DELAY_MS;
> +	if (delay_start)
> +		mdelay(reset_delay);
>   	retval = rmi_initial_reset(rmi_dev, reset_delay);
>   	if (retval)
>   		dev_warn(dev, "RMI initial reset failed! Continuing in spite of this.\n");
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index eafbdb3..d553722 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -29,9 +29,13 @@
>
>   #define RMI_PDT_PROPS_HAS_BSR 0x02
>
> +struct regulator;
> +
>   struct rmi_driver_data {
>   	struct list_head function_list;
>
> +	struct regulator *vdd;
> +	struct regulator *vio;
>   	struct rmi_device *rmi_dev;
>
>   	struct rmi_function *f01_container;
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
