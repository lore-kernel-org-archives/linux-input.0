From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 10/15] Input: synaptics-rmi4 - add devicetree support
Date: Tue, 4 Feb 2014 15:10:16 -0800
Message-ID: <52F17358.6060704@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:52455 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933694AbaBDXKR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:10:17 -0500
In-Reply-To: <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/23/2014 04:00 PM, Courtney Cavin wrote:

This is pretty interesting, and looks potentially useful.  I'm not very 
familiar with OF/DT structures, though.  What happens if there are two 
different RMI4 devices in the system, each of which has its own platform 
settings?

> Cc: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> ---
>   Documentation/devicetree/bindings/input/rmi4.txt   | 107 +++++++++++++++++
>   .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>   drivers/input/rmi4/rmi_bus.c                       |  12 +-
>   drivers/input/rmi4/rmi_bus.h                       |   3 +-
>   drivers/input/rmi4/rmi_driver.c                    |  44 +++++--
>   drivers/input/rmi4/rmi_f01.c                       | 107 +++++++++++++++--
>   drivers/input/rmi4/rmi_f11.c                       | 133 ++++++++++++++++++++-
>   drivers/input/rmi4/rmi_i2c.c                       |  19 +--
>   8 files changed, 388 insertions(+), 38 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/input/rmi4.txt
>
> diff --git a/Documentation/devicetree/bindings/input/rmi4.txt b/Documentation/devicetree/bindings/input/rmi4.txt
> new file mode 100644
> index 0000000..fff9db7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/rmi4.txt
> @@ -0,0 +1,107 @@
> +Synaptics RMI4-based input device binding
> +
> +PROPERTIES
> +
> +compatible:
> +	Usage: required
> +	Type: string, must be "syn,rmi_i2c"
> +
> +interrupts:
> +	Usage: required
> +	Type: <prop-encoded-array>
> +	Desc: See devicetree/bindings/interrupt-controller/interrupts.txt;
> +		Trigger sense required in mask
> +
> +syn,reset-delay:
> +	Usage: optional (default: 100)
> +	Type: u32, milliseconds
> +	Desc: Delay after issuing a reset
> +
> +syn,power-no-sleep:
> +	Usage: optional, mutually exclusive with syn,power-sleep
> +		(default: chip-specific)
> +	Type: boolean
> +	Desc: Disable sleep mode
> +
> +syn,power-sleep:
> +	Usage: optional, mutually exclusive with syn,power-no-sleep
> +		(default: chip-specific)
> +	Type: boolean
> +	Desc: Enable sleep mode
> +
> +syn,power-wakeup-thresh:
> +	Usage: optional (default: chip-specific)
> +	Type: u32, chip-specific unit [0-255]
> +	Desc: Capacitance threshold at which device should wake
> +
> +syn,power-doze-holdoff:
> +	Usage: optional (default: chip-specific)
> +	Type: u32, milliseconds [0-25500]
> +	Desc: Idle delay before entering sleep mode
> +
> +syn,power-doze-interval:
> +	Usage: optional (default: chip-specific)
> +	Type: u32, milliseconds [0-2550]
> +	Desc: Interval between checks for idle
> +
> +syn,2d-rezero-wait:
> +	Usage: optional (default: no re-zeroing)
> +	Type: u32, milliseconds [0-65535]
> +	Desc: Delay after resume to re-zero sensor
> +
> +syn,2d-axis-swap:
> +	Usage: optional (default: false)
> +	Type: boolean
> +	Desc: Swap X and Y axis
> +
> +syn,2d-flip-x:
> +	Usage: optional (default: false)
> +	Type: boolean
> +	Desc: Invert X axis
> +
> +syn,2d-flip-y:
> +	Usage: optional (default: false)
> +	Type: boolean
> +	Desc: Invert Y axis
> +
> +syn,2d-clip-range:
> +	Usage: optional (default: clip disabled)
> +	Type: u32 array (<top left bottom right>) [0-65535]
> +	Usage: Clip values outside this range
> +
> +syn,2d-offset:
> +	Usage: optional (default: offset disabled)
> +	Type: u32 array (<X-offset Y-offset>) [0-65535]
> +	Usage: Add offset values to reported events
> +
> +syn,2d-delta-thresh:
> +	Usage: optional (default: chip-specific)
> +	Type: u32 array (<X-delta Y-delta>) [0-255]
> +	Usage: Minimum delta before event is reported
> +
> +syn,2d-sensor-type:
> +	Usage: optional (default: chip-specific)
> +	Type: string, "indirect" or "direct"
> +	Usage: Set screen type for event reporting
> +
> +syn,2d-type-a:
> +	Usage: optional (default: false)
> +	Type: boolean
> +	Usage: Sensor supports only Multifinger Type A protocol
> +
> +EXAMPLE
> +
> +i2c@0 {
> +	compatible = "...";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	synaptics_rmi4@2c {
> +		compatible = "syn,rmi_i2c";
> +		reg = <0x2c>;
> +
> +		interrupts = <61 IRQ_TYPE_EDGE_FALLING>;
> +
> +		syn,2d-clip-range = <0 0 1919 1079>;
> +	};
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index edbb8d8..3388986 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -72,6 +72,7 @@ snps 	Synopsys, Inc.
>   st	STMicroelectronics
>   ste	ST-Ericsson
>   stericsson	ST-Ericsson
> +syn	Synaptics, Inc.
>   ti	Texas Instruments
>   toshiba	Toshiba Corporation
>   toumaz	Toumaz
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index a51e6b4..57de579 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -52,14 +52,11 @@ bool rmi_is_physical_device(struct device *dev)
>   int rmi_register_transport_device(struct rmi_transport_dev *xport)
>   {
>   	static atomic_t transport_device_count = ATOMIC_INIT(0);
> -	struct rmi_device_platform_data *pdata = xport->dev->platform_data;
>   	struct rmi_device *rmi_dev;
>   	int error;
>
> -	if (!pdata) {
> -		dev_err(xport->dev, "no platform data!\n");
> -		return -EINVAL;
> -	}
> +	if (unlikely(!rmi_bus_type.p))
> +		return -EPROBE_DEFER;
>
>   	rmi_dev = kzalloc(sizeof(struct rmi_device), GFP_KERNEL);
>   	if (!rmi_dev)
> @@ -70,8 +67,10 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
>
>   	dev_set_name(&rmi_dev->dev, "sensor%02d", rmi_dev->number);
>
> +	rmi_dev->dev.parent = xport->dev;
>   	rmi_dev->dev.bus = &rmi_bus_type;
>   	rmi_dev->dev.type = &rmi_device_type;
> +	rmi_dev->dev.of_node = xport->dev->of_node;
>
>   	xport->rmi_dev = rmi_dev;
>
> @@ -206,6 +205,9 @@ int __rmi_register_function_handler(struct rmi_function_handler *handler,
>   	struct device_driver *driver = &handler->driver;
>   	int error;
>
> +	if (WARN_ON(unlikely(!rmi_bus_type.p)))
> +		return -EAGAIN;
> +
>   	driver->bus = &rmi_bus_type;
>   	driver->owner = owner;
>   	driver->mod_name = mod_name;
> diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
> index a21e4c4..51f9372 100644
> --- a/drivers/input/rmi4/rmi_bus.h
> +++ b/drivers/input/rmi4/rmi_bus.h
> @@ -212,7 +212,8 @@ struct rmi_device {
>   };
>
>   #define to_rmi_device(d) container_of(d, struct rmi_device, dev)
> -#define to_rmi_platform_data(d) ((d)->xport->dev->platform_data)
> +#define to_rmi_xport_device(d) ((d)->xport->dev)
> +#define to_rmi_platform_data(d) (dev_get_platdata(to_rmi_xport_device(d)))
>
>   bool rmi_is_physical_device(struct device *dev);
>
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 9ec7b93..92415ce 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -26,6 +26,8 @@
>   #include <linux/rmi.h>
>   #include <linux/slab.h>
>   #include <linux/uaccess.h>
> +#include <linux/of_irq.h>
> +#include <linux/of.h>
>   #include <uapi/linux/input.h>
>   #include "rmi_bus.h"
>   #include "rmi_driver.h"
> @@ -498,7 +500,7 @@ static int create_function(struct rmi_device *rmi_dev,
>    * We have to do this before actually building the PDT because the reflash
>    * updates (if any) might cause various registers to move around.
>    */
> -static int rmi_initial_reset(struct rmi_device *rmi_dev)
> +static int rmi_initial_reset(struct rmi_device *rmi_dev, u32 reset_delay)
>   {
>   	struct pdt_entry pdt_entry;
>   	int page;
> @@ -507,8 +509,6 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev)
>   	bool has_f01 = false;
>   	int i;
>   	int retval;
> -	const struct rmi_device_platform_data *pdata =
> -			to_rmi_platform_data(rmi_dev);
>
>   	dev_dbg(dev, "Initial reset.\n");
>
> @@ -538,7 +538,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev)
>   						retval);
>   					return retval;
>   				}
> -				mdelay(pdata->reset_delay_ms);
> +				mdelay(reset_delay);
>   				done = true;
>   				has_f01 = true;
>   				break;
> @@ -648,6 +648,8 @@ static int rmi_driver_probe(struct device *dev)
>   	struct rmi_device_platform_data *pdata;
>   	int retval = 0;
>   	struct rmi_device *rmi_dev;
> +	unsigned int irq;
> +	u32 reset_delay;
>
>   	dev_dbg(dev, "%s: Starting probe.\n", __func__);
>
> @@ -661,6 +663,28 @@ static int rmi_driver_probe(struct device *dev)
>   	rmi_dev->driver = rmi_driver;
>
>   	pdata = to_rmi_platform_data(rmi_dev);
> +	if (pdata == NULL) {
> +#ifdef CONFIG_OF
> +		const char *p;
> +
> +		p = "syn,reset-delay";
> +		retval = of_property_read_u32(dev->of_node, p, &reset_delay);
> +		if (retval && retval != -EINVAL) {
> +			dev_err(dev, "Invalid '%s' property\n", p);
> +			return -EINVAL;
> +		}
> +		if (retval == -EINVAL)
> +			reset_delay = 0;
> +
> +		irq = irq_of_parse_and_map(dev->of_node, 0);
> +#else
> +		dev_err(dev, "No pdata\n");
> +		return -EINVAL;
> +#endif
> +	} else {
> +		reset_delay = pdata->reset_delay_ms;
> +		irq = pdata->irq;
> +	}
>
>   	data = devm_kzalloc(dev, sizeof(struct rmi_driver_data), GFP_KERNEL);
>   	if (!data) {
> @@ -688,9 +712,9 @@ static int rmi_driver_probe(struct device *dev)
>   	 * and leave the customer's device unusable.  So we warn them, and
>   	 * continue processing.
>   	 */
> -	if (!pdata->reset_delay_ms)
> -		pdata->reset_delay_ms = DEFAULT_RESET_DELAY_MS;
> -	retval = rmi_initial_reset(rmi_dev);
> +	if (!reset_delay)
> +		reset_delay = DEFAULT_RESET_DELAY_MS;
> +	retval = rmi_initial_reset(rmi_dev, reset_delay);
>   	if (retval)
>   		dev_warn(dev, "RMI initial reset failed! Continuing in spite of this.\n");
>
> @@ -762,10 +786,10 @@ static int rmi_driver_probe(struct device *dev)
>   		goto err_free_data;
>   	}
>
> -	data->irq = pdata->irq;
> -	if (data->irq < 0) {
> +	data->irq = irq;
> +	if (data->irq < 0 || data->irq == NO_IRQ) {
>   		dev_err(dev, "Failed to get attn IRQ.\n");
> -		retval = data->irq;
> +		retval = -EINVAL;
>   		goto err_free_data;
>
>   	}
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 4cb9fcb..22b57f2 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -12,6 +12,7 @@
>   #include <linux/rmi.h>
>   #include <linux/slab.h>
>   #include <linux/uaccess.h>
> +#include <linux/of.h>
>   #include "rmi_driver.h"
>
>   #define RMI_PRODUCT_ID_LENGTH    10
> @@ -169,15 +170,104 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF
> +static int rmi_f01_of_parse(struct device *dev,
> +		struct rmi_f01_power_management *cdata)
> +{
> +	bool sleep, nosleep;
> +	const char *p;
> +	u32 val;
> +	int rc;
> +
> +	if (dev->of_node == NULL)
> +		return -EINVAL;
> +
> +	memset(cdata, 0, sizeof(*cdata));
> +
> +	sleep = of_property_read_bool(dev->of_node, "syn,power-sleep");
> +	nosleep = of_property_read_bool(dev->of_node, "syn,power-nosleep");
> +	if (sleep && nosleep) {
> +		dev_err(dev, "'syn,power-sleep' and 'syn,power-nosleep' are mutually exclusive\n");
> +		return -EINVAL;
> +	}
> +	if (sleep)
> +		cdata->nosleep = RMI_F01_NOSLEEP_OFF;
> +	else if (nosleep)
> +		cdata->nosleep = RMI_F01_NOSLEEP_ON;
> +
> +	p = "syn,power-wakeup-thresh";
> +	rc = of_property_read_u32(dev->of_node, p, &val);
> +	if (rc && rc != -EINVAL) {
> +		dev_err(dev, "Invalid '%s' property\n", p);
> +		return rc;
> +	}
> +	if (rc != -EINVAL) {
> +		if (val & ~0xff) {
> +			dev_err(dev, "'%s' out of range [0-255]\n", p);
> +			return -EINVAL;
> +		}
> +		cdata->wakeup_threshold = val;
> +	}
> +
> +	p = "syn,power-doze-holdoff";
> +	rc = of_property_read_u32(dev->of_node, p, &val);
> +	if (rc && rc != -EINVAL) {
> +		dev_err(dev, "Invalid '%s' property\n", p);
> +		return rc;
> +	}
> +	if (rc != -EINVAL) {
> +		if (val > 25500) {
> +			dev_err(dev, "'%s' out of range [0-25500]ms\n", p);
> +			return -EINVAL;
> +		}
> +		cdata->doze_holdoff = (val + 50) / 100;
> +	}
> +
> +	p = "syn,power-doze-interval";
> +	rc = of_property_read_u32(dev->of_node, p, &val);
> +	if (rc && rc != -EINVAL) {
> +		dev_err(dev, "Invalid '%s' property\n", p);
> +		return rc;
> +	}
> +	if (rc != -EINVAL) {
> +		if (val > 2550) {
> +			dev_err(dev, "'%s' out of range [0-2550]ms\n", p);
> +			return -EINVAL;
> +		}
> +		cdata->doze_interval = (val + 5) / 10;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int rmi_f01_of_parse(struct device *dev,
> +		struct rmi_f01_power_management *cdata)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>   static int rmi_f01_initialize(struct rmi_function *fn)
>   {
>   	u8 temp;
>   	int error;
>   	u16 ctrl_base_addr;
> +	struct rmi_f01_power_management cdata;
>   	struct rmi_device *rmi_dev = fn->rmi_dev;
> +	struct device *dev = to_rmi_xport_device(rmi_dev);
>   	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
>   	struct f01_data *data = fn->data;
> -	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
> +	struct rmi_device_platform_data *pdata = dev_get_platdata(dev);
> +
> +	if (pdata != NULL) {
> +		cdata = pdata->power_management;
> +	} else {
> +		error = rmi_f01_of_parse(dev, &cdata);
> +		if (error) {
> +			dev_err(dev, "Unable to parse DT data\n");
> +			return error;
> +		}
> +	}
>
>   	/*
>   	 * Set the configured bit and (optionally) other important stuff
> @@ -191,7 +281,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   		dev_err(&fn->dev, "Failed to read F01 control.\n");
>   		return error;
>   	}
> -	switch (pdata->power_management.nosleep) {
> +	switch (cdata.nosleep) {
>   	case RMI_F01_NOSLEEP_DEFAULT:
>   		break;
>   	case RMI_F01_NOSLEEP_OFF:
> @@ -262,9 +352,9 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   		data->doze_interval_addr = ctrl_base_addr;
>   		ctrl_base_addr++;
>
> -		if (pdata->power_management.doze_interval) {
> +		if (cdata.doze_interval) {
>   			data->device_control.doze_interval =
> -				pdata->power_management.doze_interval;
> +				cdata.doze_interval;
>   			error = rmi_write(rmi_dev, data->doze_interval_addr,
>   					data->device_control.doze_interval);
>   			if (error < 0) {
> @@ -283,9 +373,9 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   		data->wakeup_threshold_addr = ctrl_base_addr;
>   		ctrl_base_addr++;
>
> -		if (pdata->power_management.wakeup_threshold) {
> +		if (cdata.wakeup_threshold) {
>   			data->device_control.wakeup_threshold =
> -				pdata->power_management.wakeup_threshold;
> +				cdata.wakeup_threshold;
>   			error = rmi_write(rmi_dev, data->wakeup_threshold_addr,
>   					data->device_control.wakeup_threshold);
>   			if (error < 0) {
> @@ -306,9 +396,8 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>   		data->doze_holdoff_addr = ctrl_base_addr;
>   		ctrl_base_addr++;
>
> -		if (pdata->power_management.doze_holdoff) {
> -			data->device_control.doze_holdoff =
> -				pdata->power_management.doze_holdoff;
> +		if (cdata.doze_holdoff) {
> +			data->device_control.doze_holdoff = cdata.doze_holdoff;
>   			error = rmi_write(rmi_dev, data->doze_holdoff_addr,
>   					data->device_control.doze_holdoff);
>   			if (error < 0) {
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index b114f25..837b6e7 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -13,6 +13,7 @@
>   #include <linux/input.h>
>   #include <linux/input/mt.h>
>   #include <linux/kconfig.h>
> +#include <linux/of.h>
>   #include <linux/rmi.h>
>   #include <linux/slab.h>
>   #include "rmi_driver.h"
> @@ -794,9 +795,120 @@ static void f11_set_abs_params(struct rmi_function *fn)
>   				     0, MT_TOOL_FINGER, 0, 0);
>   }
>
> +#ifdef CONFIG_OF
> +static int rmi_f11_of_parse(struct device *dev,
> +		struct rmi_f11_sensor_data *cdata)
> +{
> +	const char *type;
> +	const char *p;
> +	u32 a[4];
> +	int rc;
> +
> +	if (dev->of_node == NULL)
> +		return -EINVAL;
> +
> +	memset(cdata, 0, sizeof(*cdata));
> +
> +	p = "syn,2d-rezero-wait";
> +	rc = of_property_read_u32(dev->of_node, p, &a[0]);
> +	if (rc && rc != -EINVAL) {
> +		dev_err(dev, "Invalid '%s' property\n", p);
> +		return rc;
> +	}
> +	if (rc != -EINVAL) {
> +		if (a[0] & ~0xffff) {
> +			dev_err(dev, "'%s' value out of range [0-65535]\n", p);
> +			return -EINVAL;
> +		}
> +		cdata->rezero_wait = a[0];
> +	}
> +
> +	cdata->type_a = of_property_read_bool(dev->of_node, "syn,2d-type-a");
> +	cdata->axis_align.swap_axes = of_property_read_bool(dev->of_node,
> +			"syn,2d-axis-swap");
> +	cdata->axis_align.flip_x = of_property_read_bool(dev->of_node,
> +			"syn,2d-flip-x");
> +	cdata->axis_align.flip_y = of_property_read_bool(dev->of_node,
> +			"syn,2d-flip-y");
> +
> +	p = "syn-2d-clip-range";
> +	rc = of_property_read_u32_array(dev->of_node, p, a, 4);
> +	if (rc && rc != -EINVAL) {
> +		dev_err(dev, "Invalid '%s' property\n", p);
> +		return rc;
> +	}
> +	if (rc != -EINVAL) {
> +		if ((a[0] | a[1] | a[2] | a[3]) & ~0xffff) {
> +			dev_err(dev, "'%s' values out of range [0-65535]\n", p);
> +			return -EINVAL;
> +		}
> +		cdata->axis_align.clip_x_low = a[0];
> +		cdata->axis_align.clip_y_low = a[1];
> +		cdata->axis_align.clip_x_high = a[2];
> +		cdata->axis_align.clip_y_high = a[3];
> +	}
> +
> +	p = "syn-2d-offset";
> +	rc = of_property_read_u32_array(dev->of_node, p, a, 2);
> +	if (rc && rc != -EINVAL) {
> +		dev_err(dev, "Invalid '%s' property\n", p);
> +		return rc;
> +	}
> +	if (rc != -EINVAL) {
> +		if ((a[0] | a[1]) & ~0xffff) {
> +			dev_err(dev, "'%s' values out of range [0-65535]\n", p);
> +			return -EINVAL;
> +		}
> +		cdata->axis_align.offset_x = a[0];
> +		cdata->axis_align.offset_y = a[1];
> +	}
> +
> +	p = "syn,2d-delta-thresh";
> +	rc = of_property_read_u32_array(dev->of_node, p, a, 2);
> +	if (rc && rc != -EINVAL) {
> +		dev_err(dev, "Invalid '%s' property\n", p);
> +		return rc;
> +	}
> +	if (rc != -EINVAL) {
> +		if ((a[0] | a[1]) & ~0xff) {
> +			dev_err(dev, "'%s' values out of range [0-255]\n", p);
> +			return -EINVAL;
> +		}
> +		cdata->axis_align.delta_x_threshold = a[0];
> +		cdata->axis_align.delta_y_threshold = a[1];
> +	}
> +
> +	p = "syn,2d-sensor-type";
> +	rc = of_property_read_string(dev->of_node, p, &type);
> +	if (rc && rc != -EINVAL) {
> +		dev_err(dev, "Invalid '%s' property\n", p);
> +		return rc;
> +	}
> +	if (rc != -EINVAL) {
> +		if (!strcmp(type, "direct")) {
> +			cdata->sensor_type = RMI_F11_SENSOR_DIRECT;
> +		} else if (!strcmp(type, "indirect")) {
> +			cdata->sensor_type = RMI_F11_SENSOR_INDIRECT;
> +		} else {
> +			dev_err(dev, "'%s' must be one of: \"indirect\", \"direct\"\n", p);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int rmi_f11_of_parse(struct device *dev,
> +		struct rmi_f11_sensor_data *cdata)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>   static int rmi_f11_initialize(struct rmi_function *fn)
>   {
>   	struct rmi_device *rmi_dev = fn->rmi_dev;
> +	struct device *dev = to_rmi_xport_device(rmi_dev);
>   	struct f11_data *f11;
>   	struct f11_2d_ctrl *ctrl;
>   	u8 query_offset;
> @@ -804,12 +916,23 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>   	u16 control_base_addr;
>   	u16 max_x_pos, max_y_pos, temp;
>   	int rc;
> -	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
> +	struct rmi_device_platform_data *pdata = dev_get_platdata(dev);
> +	struct rmi_f11_sensor_data cdata;
>   	struct f11_2d_sensor *sensor;
>   	u8 buf;
>
>   	dev_dbg(&fn->dev, "Initializing F11 values.\n");
>
> +	if (pdata != NULL) {
> +		cdata = pdata->f11_sensor_data;
> +	} else {
> +		rc = rmi_f11_of_parse(dev, &cdata);
> +		if (rc) {
> +			dev_err(dev, "Unable to parse DT data\n");
> +			return rc;
> +		}
> +	}
> +
>   	/*
>   	** init instance data, fill in values and create any sysfs files
>   	*/
> @@ -818,7 +941,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>   		return -ENOMEM;
>
>   	fn->data = f11;
> -	f11->rezero_wait_ms = pdata->f11_sensor_data.rezero_wait;
> +	f11->rezero_wait_ms = cdata.rezero_wait;
>
>   	query_base_addr = fn->fd.query_base_addr;
>   	control_base_addr = fn->fd.control_base_addr;
> @@ -851,9 +974,9 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>   		return rc;
>   	}
>
> -	sensor->axis_align = pdata->f11_sensor_data.axis_align;
> -	sensor->type_a = pdata->f11_sensor_data.type_a;
> -	sensor->sensor_type = pdata->f11_sensor_data.sensor_type;
> +	sensor->axis_align = cdata.axis_align;
> +	sensor->type_a = cdata.type_a;
> +	sensor->sensor_type = cdata.sensor_type;
>
>   	rc = rmi_read_block(rmi_dev,
>   		control_base_addr + F11_CTRL_SENSOR_MAX_X_POS_OFFSET,
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index aebf974..377d4cc 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -186,16 +186,9 @@ static const struct rmi_transport_ops rmi_i2c_ops = {
>   static int rmi_i2c_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
> -	const struct rmi_device_platform_data *pdata =
> -				dev_get_platdata(&client->dev);
>   	struct rmi_i2c_xport *rmi_i2c;
>   	int retval;
>
> -	if (!pdata) {
> -		dev_err(&client->dev, "no platform data\n");
> -		return -EINVAL;
> -	}
> -
>   	dev_dbg(&client->dev, "Probing %#02x.\n", client->addr);
>
>   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> @@ -258,10 +251,20 @@ static const struct i2c_device_id rmi_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, rmi_id);
>
> +#ifdef CONFIG_OF
> +static struct of_device_id rmi_match_table[] = {
> +	{ .compatible = "syn,rmi_i2c", },
> +	{ },
> +};
> +#else
> +#define rmi_match_table NULL
> +#endif
> +
>   static struct i2c_driver rmi_i2c_driver = {
>   	.driver = {
>   		.owner	= THIS_MODULE,
> -		.name	= "rmi_i2c"
> +		.name	= "rmi_i2c",
> +		.of_match_table = rmi_match_table,
>   	},
>   	.id_table	= rmi_id,
>   	.probe		= rmi_i2c_probe,
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
