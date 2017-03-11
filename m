From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] add driver for cypress cy8cmbr3102
Date: Fri, 10 Mar 2017 16:42:59 -0800
Message-ID: <20170311004259.GC7384@dtor-ws>
References: <1487659221-14665-1-git-send-email-Patrick.Vogelaar@gigatronik.com>
 <1487659221-14665-2-git-send-email-Patrick.Vogelaar@gigatronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487659221-14665-2-git-send-email-Patrick.Vogelaar-E/lnIDgSqyPyoQHixxa+JQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Vogelaar <Patrick.Vogelaar-E/lnIDgSqyPyoQHixxa+JQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Patrick,

On Tue, Feb 21, 2017 at 07:40:20AM +0100, Patrick Vogelaar wrote:
> Version 2:
> * removed .owner
> * based on branch next

A better changelog would be nice: the kid of device, limitations, etc.

> 
> Signed-off-by: Patrick Vogelaar <Patrick.Vogelaar-E/lnIDgSqyPyoQHixxa+JQ@public.gmane.org>
> ---
>  drivers/input/misc/Kconfig       |  12 +++
>  drivers/input/misc/Makefile      |   1 +
>  drivers/input/misc/cy8cmbr3102.c | 221 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/input/misc/cy8cmbr3102.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 5b6c522..be3071e 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -822,4 +822,16 @@ config INPUT_HISI_POWERKEY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called hisi_powerkey.
>  
> +config INPUT_CY8CMBR3102
> +	tristate "Cypress CY8CMBR3102 CapSense Express controller"
> +	depends on I2C
> +	select INPUT_POLLDEV
> +	default n

"default n" can be omitted.

> +	help
> +	  Say yes here to enable support for the Cypress CY8CMBR3102
> +	  CapSense Express controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called cy8cmbr3102.
> +
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index b10523f..f9959ed 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -77,3 +77,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
>  obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
>  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
>  obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
> +obj-$(CONFIG_INPUT_CY8CMBR3102)		+= cy8cmbr3102.o
> diff --git a/drivers/input/misc/cy8cmbr3102.c b/drivers/input/misc/cy8cmbr3102.c
> new file mode 100644
> index 0000000..ed67a63
> --- /dev/null
> +++ b/drivers/input/misc/cy8cmbr3102.c
> @@ -0,0 +1,221 @@
> +/* Driver for Cypress CY8CMBR3102 CapSense Express Controller
> + *
> + * (C) 2017 by Gigatronik Technologies GmbH
> + * Author: Patrick Vogelaar <patrick.vogelaar-E/lnIDgSqyPyoQHixxa+JQ@public.gmane.org>
> + * All rights reserved.
> + *
> + * This code is based on mma8450.c and atmel_captouch.c.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * NOTE: This implementation does not implement the full range of functions the
> + * Cypress CY8CMBR3102 CapSense Express controller provides. It only implements
> + * its use for connected touch buttons (yet).
> + */
> +
> +#define DRV_VERSION "0.1"
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/of.h>
> +
> +/* I2C Registers */
> +#define CY8CMBR3102_DEVICE_ID_REG		0x90
> +#define CY8CMBR3102_BUTTON_STAT			0xAA
> +
> +
> +#define CY8CMBR3102_MAX_NUM_OF_BUTTONS		0x02
> +#define CY8CMBR3102_DRV_NAME			"cy8cmbr3102"
> +#define CY8CMBR3102_POLL_INTERVAL		200
> +#define CY8CMBR3102_POLL_INTERVAL_MAX		300
> +#define CY8CMBR3102_DEVICE_ID			2561
> +#define CY8CMBR3102_MAX_RETRY			5
> +
> +/*
> + * @i2c_client: I2C slave device client pointer
> + * @idev: Input (polled) device pointer

This kind of comments are not really helpful and just clutter the
source. Anyone looking at the structure can see that they are dealing
with i2c client pointer and polled input device pointer.

> + * @num_btn: Number of buttons
> + * @keycodes: map of button# to KeyCode
> + * @cy8cmbr3102_lock: mutex lock
> + */
> +struct cy8cmbr3102_device {
> +	struct i2c_client *client;
> +	struct input_polled_dev *idev;
> +	u32 num_btn;
> +	u32 keycodes[CY8CMBR3102_MAX_NUM_OF_BUTTONS];
> +	struct mutex cy8cmbr3102_lock;

I do not think you need this mutex: we will not run several instances of
poll function simultaneously.

> +};
> +
> +static const struct i2c_device_id cy8cmbr3102_idtable[] = {
> +		{"cy8cmbr3102", 0},
> +		{}

Extra indent.

> +};
> +MODULE_DEVICE_TABLE(i2c, cy8cmbr3102_idtable);

Please move to the driver structure.

> +
> +static void cy8cmbr3102_poll(struct input_polled_dev *idev)
> +{
> +	struct cy8cmbr3102_device *dev = idev->private;
> +	int i, ret, btn_state;
> +
> +	mutex_lock(&dev->cy8cmbr3102_lock);
> +
> +	ret = i2c_smbus_read_word_data(dev->client, CY8CMBR3102_BUTTON_STAT);
> +	if (ret < 0) {
> +		dev_err(&dev->client->dev, "i2c io error: %d\n", ret);
> +		mutex_unlock(&dev->cy8cmbr3102_lock);
> +		return;
> +	}
> +
> +	for (i = 0; i < dev->num_btn; i++) {
> +		btn_state = ret & (0x1 << i);
> +		input_report_key(idev->input, dev->keycodes[i], btn_state);

		input_report_key(idev->input, dev->keycodes[i], ret & BIT(i));

> +		input_sync(idev->input);
> +	}
> +
> +	mutex_unlock(&dev->cy8cmbr3102_lock);
> +}
> +
> +static int cy8cmbr3102_remove(struct i2c_client *client)
> +{
> +	struct cy8cmbr3102_device *dev = i2c_get_clientdata(client);
> +	struct input_polled_dev *idev = dev->idev;
> +
> +	dev_dbg(&client->dev, "%s\n", __func__);
> +
> +	mutex_destroy(&dev->cy8cmbr3102_lock);
> +	input_unregister_polled_device(idev);

Not needed with devm. In fact, this whole function is not needed.
> +
> +	return 0;
> +}
> +
> +static int cy8cmbr3102_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct cy8cmbr3102_device *drvdata;
> +	struct device *dev = &client->dev;
> +	struct device_node *node;
> +	int i, err, ret;
> +
> +	dev_dbg(&client->dev, "%s\n", __func__);
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +						I2C_FUNC_SMBUS_WORD_DATA |
> +						I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +		dev_err(dev, "needed i2c functionality is not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->client = client;
> +	i2c_set_clientdata(client, drvdata);
> +
> +	/* device is in low-power mode and needs to be waken up */
> +	for (i = 0; (i < CY8CMBR3102_MAX_RETRY) &&
> +					(ret != CY8CMBR3102_DEVICE_ID); i++) {
> +		ret = i2c_smbus_read_word_data(drvdata->client,
> +		CY8CMBR3102_DEVICE_ID_REG);

Weird indent.

> +		dev_dbg(dev, "DEVICE_ID (%i): %i\n", i, ret);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c io error: %d\n", ret);
> +		return -EIO;

		return ret;

> +	} else if (ret != CY8CMBR3102_DEVICE_ID) {
> +		dev_err(&client->dev, "read device ID %i is not equal to %i!\n",
> +				ret, CY8CMBR3102_DEVICE_ID);
> +		return -ENXIO;
> +	}
> +	dev_dbg(dev, "device identified by device ID\n");
> +
> +	drvdata->idev = devm_input_allocate_polled_device(dev);
> +	if (!drvdata->idev) {
> +		dev_err(dev, "failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	node = dev->of_node;
> +	if (!node) {
> +		dev_err(dev, "failed to find matching node in device tree\n");
> +		return -EINVAL;
> +	}

Please drop.

> +
> +	if (of_property_read_bool(node, "autorepeat"))

Use generic device properties:

	if (device_property_read_bool(...))

> +		__set_bit(EV_REP, drvdata->idev->input->evbit);
> +
> +	drvdata->num_btn = of_property_count_u32_elems(node, "linux,keycodes");

	size = device_property_read_u32_array(dev, "linux,keycodes", NULL, 0);
	... etc.

Se matrix-keymap.c for parsing.


> +	if (drvdata->num_btn > CY8CMBR3102_MAX_NUM_OF_BUTTONS)
> +		drvdata->num_btn = CY8CMBR3102_MAX_NUM_OF_BUTTONS;
> +
> +	err = of_property_read_u32_array(node, "linux,keycodes",
> +			drvdata->keycodes, drvdata->num_btn);
> +
> +	if (err) {
> +		dev_err(dev, "failed to read linux,keycodes property: %d\n",
> +				err);
> +		return err;
> +	}
> +
> +	for (i = 0; i < drvdata->num_btn; i++)
> +		__set_bit(drvdata->keycodes[i], drvdata->idev->input->keybit);
> +
> +	drvdata->idev->input->id.bustype = BUS_I2C;
> +	drvdata->idev->input->id.product = 0x3102;
> +	drvdata->idev->input->id.version = 0;
> +	drvdata->idev->input->name = CY8CMBR3102_DRV_NAME;
> +	drvdata->idev->poll = cy8cmbr3102_poll;
> +	drvdata->idev->poll_interval = CY8CMBR3102_POLL_INTERVAL;
> +	drvdata->idev->poll_interval_max = CY8CMBR3102_POLL_INTERVAL_MAX;
> +	drvdata->idev->private = drvdata;
> +	drvdata->idev->input->keycode = drvdata->keycodes;
> +	drvdata->idev->input->keycodemax = drvdata->num_btn;
> +	drvdata->idev->input->keycodesize = sizeof(drvdata->keycodes[0]);
> +	__set_bit(EV_KEY, drvdata->idev->input->evbit);
> +
> +	mutex_init(&drvdata->cy8cmbr3102_lock);
> +
> +	err = input_register_polled_device(drvdata->idev);
> +	if (err)
> +		return err;
> +
> +	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");

Please drop.

> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cy8cmbr3102_match[] = {
> +		{.compatible = "cypress,cy8cmbr3102", },
> +		{}
> +};
> +MODULE_DEVICE_TABLE(of, of_cy8cmbr3102_match);
> +#endif
> +
> +static struct i2c_driver cy8cmbr3102_driver = {
> +		.driver			= {
> +			.name		= "cy8cmbr3102",
> +			.of_match_table	= of_match_ptr(of_cy8cmbr3102_match),
> +		},
> +		.probe = cy8cmbr3102_probe,
> +		.remove = cy8cmbr3102_remove,
> +		.id_table = cy8cmbr3102_idtable,
> +};
> +module_i2c_driver(cy8cmbr3102_driver);
> +
> +MODULE_AUTHOR("Patrick Vogelaar <patrick.vogelaar-E/lnIDgSqyPyoQHixxa+JQ@public.gmane.org>");
> +MODULE_DESCRIPTION("Cypress CY8CMBR3102 CapSense Express controller");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
