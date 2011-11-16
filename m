From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add generic GPIO-tilt driver
Date: Tue, 15 Nov 2011 23:18:22 -0800
Message-ID: <20111116071822.GA19407@core.coreip.homeip.net>
References: <201110211043.47742.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51897 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab1KPHS3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 02:18:29 -0500
Received: by iage36 with SMTP id e36so209326iag.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 23:18:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201110211043.47742.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-input@vger.kernel.org

Hi Heiko,

On Fri, Oct 21, 2011 at 10:43:47AM +0200, Heiko St=FCbner wrote:
> There exist tilt switches that simply report their tilt-state via som=
e gpios.
>=20
> The number and orientation of their axes can vary depending on the sw=
itch
> used and the build of the device. Also two or more one-axis switches
> could be combined to provide multi-dimensional orientation.
>=20
> One example of a device using such a switch is the family of Qisda
> ebook readers, where the switch provides information about the
> landscape / portrait orientation of the device. The example in
> Documentation/input/gpio-tilt.txt documents exactly this one-axis dev=
ice.
>=20

Looks very nice, just a few comments below.


> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/input/gpio-tilt.txt     |  103 ++++++++++++
>  drivers/input/misc/Kconfig            |   14 ++
>  drivers/input/misc/Makefile           |    1 +
>  drivers/input/misc/gpio_tilt_polled.c |  276 +++++++++++++++++++++++=
++++++++++
>  include/linux/gpio_tilt.h             |   73 +++++++++
>  5 files changed, 467 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/input/gpio-tilt.txt
>  create mode 100644 drivers/input/misc/gpio_tilt_polled.c
>  create mode 100644 include/linux/gpio_tilt.h
>=20
> diff --git a/Documentation/input/gpio-tilt.txt b/Documentation/input/=
gpio-tilt.txt
> new file mode 100644
> index 0000000..06d60c3
> --- /dev/null
> +++ b/Documentation/input/gpio-tilt.txt
> @@ -0,0 +1,103 @@
> +Driver for tilt-switches connected via GPIOs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Generic driver to read data from tilt switches connected via gpios.
> +Orientation can be provided by one or more than one tilt switches,
> +i.e. each tilt switch providing one axis, and the number of axes
> +is also not limited.
> +
> +
> +Data structures:
> +----------------
> +
> +The array of struct gpio in the gpios field is used to list the gpio=
s
> +that represent the current tilt state.
> +
> +The array of struct gpio_tilt_axis describes the axes that are repor=
ted
> +to the input system. The values set therein are used for the
> +input_set_abs_params calls needed to init the axes.
> +
> +The array of struct gpio_tilt_state maps gpio states to the correspo=
nding
> +values to report. The gpio state is represented as a bitfield where =
the
> +bit-index corresponds to the index of the gpio in the struct gpio ar=
ray.
> +In the same manner the values stored in the axes array correspond to
> +the elements of the gpio_tilt_axis-array.
> +
> +
> +Example:
> +--------
> +
> +Example configuration for a single TS1003 tilt switch that rotates a=
round
> +one axis in 4 steps and emitts the current tilt via two GPIOs.
> +
> +static int sg060_tilt_enable(struct device *dev) {
> +	/* code to enable the sensors */
> +};
> +
> +static void sg060_tilt_disable(struct device *dev) {
> +	/* code to disable the sensors */
> +};
> +
> +static struct gpio sg060_tilt_gpios[] =3D {
> +	{ SG060_TILT_GPIO_SENSOR1, GPIOF_IN, "tilt_sensor1" },
> +	{ SG060_TILT_GPIO_SENSOR2, GPIOF_IN, "tilt_sensor2" },
> +};
> +
> +static struct gpio_tilt_state sg060_tilt_states[] =3D {
> +	{
> +		.gpios =3D (0 << 1) | (0 << 0),
> +		.axes =3D (int[]) {
> +			0,
> +		},
> +	}, {
> +		.gpios =3D (0 << 1) | (1 << 0),
> +		.axes =3D (int[]) {
> +			1, /* 90 degrees */
> +		},
> +	}, {
> +		.gpios =3D (1 << 1) | (1 << 0),
> +		.axes =3D (int[]) {
> +			2, /* 180 degrees */
> +		},
> +	}, {
> +		.gpios =3D (1 << 1) | (0 << 0),
> +		.axes =3D (int[]) {
> +			3, /* 270 degrees */
> +		},
> +	},
> +};
> +
> +static struct gpio_tilt_axis sg060_tilt_axes[] =3D {
> +	{
> +		.axis =3D ABS_RY,
> +		.min =3D 0,
> +		.max =3D 3,
> +		.fuzz =3D 0,
> +		.flat =3D 0,
> +	},
> +};
> +
> +static struct gpio_tilt_platform_data sg060_tilt_pdata=3D {
> +	.gpios =3D sg060_tilt_gpios,
> +	.nr_gpios =3D ARRAY_SIZE(sg060_tilt_gpios),
> +
> +	.axes =3D sg060_tilt_axes,
> +	.nr_axes =3D ARRAY_SIZE(sg060_tilt_axes),
> +
> +	.states =3D sg060_tilt_states,
> +	.nr_states =3D ARRAY_SIZE(sg060_tilt_states),
> +
> +	.debounce_interval =3D 100,
> +
> +	.poll_interval =3D 1000,
> +	.enable =3D sg060_tilt_enable,
> +	.disable =3D sg060_tilt_disable,
> +};
> +
> +static struct platform_device sg060_device_tilt =3D {
> +	.name =3D "gpio-tilt-polled",
> +	.id =3D -1,
> +	.dev =3D {
> +		.platform_data =3D &sg060_tilt_pdata,
> +	},
> +};
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 22d875f..e53b443 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -179,6 +179,20 @@ config INPUT_APANEL
>  	 To compile this driver as a module, choose M here: the module will
>  	 be called apanel.
> =20
> +config INPUT_GPIO_TILT_POLLED
> +	tristate "Polled GPIO tilt switch"
> +	depends on GENERIC_GPIO
> +	select INPUT_POLLDEV
> +	help
> +	  This driver implements support for tilt switches connected
> +	  to GPIO pins that are not capable of generating interrupts.
> +
> +	  The list of gpios to use and the mapping of their states
> +	  to specific angles is done via platform data.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gpio_tilt_polled.
> +
>  config INPUT_IXP4XX_BEEPER
>  	tristate "IXP4XX Beeper support"
>  	depends on ARCH_IXP4XX
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefil=
e
> index a244fc6..90070c1 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C)		+=3D cma3000_d0x_i=
2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+=3D cobalt_btns.o
>  obj-$(CONFIG_INPUT_DM355EVM)		+=3D dm355evm_keys.o
>  obj-$(CONFIG_HP_SDC_RTC)		+=3D hp_sdc_rtc.o
> +obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+=3D gpio_tilt_polled.o
>  obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+=3D ixp4xx-beeper.o
>  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+=3D keyspan_remote.o
>  obj-$(CONFIG_INPUT_KXTJ9)		+=3D kxtj9.o
> diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/mi=
sc/gpio_tilt_polled.c
> new file mode 100644
> index 0000000..15ab935
> --- /dev/null
> +++ b/drivers/input/misc/gpio_tilt_polled.c
> @@ -0,0 +1,276 @@
> +/*
> + *  Driver for tilt switches connected via GPIO lines
> + *  not capable of generating interrupts
> + *
> + *  Copyright (C) 2011 Heiko Stuebner <heiko@sntech.de>
> + *
> + *  based on: /drivers/input/keyboard/gpio_keys_polled.c
> + *
> + *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
> + *  Copyright (C) 2010 Nuno Goncalves <nunojpg@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or mo=
dify
> + *  it under the terms of the GNU General Public License version 2 a=
s
> + *  published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_tilt.h>
> +
> +#define DRV_NAME	"gpio-tilt-polled"
> +
> +struct gpio_tilt_polled_dev {
> +	struct input_polled_dev *poll_dev;
> +	struct device *dev;
> +
> +	struct gpio *gpios;
> +	int nr_gpios;
> +
> +	struct gpio_tilt_state *states;
> +	int nr_states;
> +
> +	int *axes;
> +	int nr_axes;
> +
> +	int last_state;
> +
> +	int threshold;
> +	int count;
> +
> +	int (*enable)(struct device *dev);
> +	void (*disable)(struct device *dev);
> +};
> +
> +static void gpio_tilt_polled_poll(struct input_polled_dev *dev)
> +{
> +	struct gpio_tilt_polled_dev *bdev =3D dev->private;

Call it tdev or tilt or tilt_dev or something? bdev is not very fitting
here.

> +	struct input_dev *input =3D dev->input;
> +	struct gpio_tilt_state *tilt_state =3D NULL;
> +	int state, i;
> +
> +	if (bdev->count < bdev->threshold) {
> +		bdev->count++;
> +	} else {
> +		state =3D 0;
> +		for (i =3D 0; i < bdev->nr_gpios; i++)
> +			state |=3D (!!gpio_get_value(bdev->gpios[i].gpio) << i);
> +
> +		if (state !=3D bdev->last_state) {
> +			for (i =3D 0; i < bdev->nr_states; i++)
> +				if (bdev->states[i].gpios =3D=3D state)
> +					tilt_state =3D &bdev->states[i];
> +
> +			if (tilt_state) {
> +				for (i =3D 0; i < bdev->nr_axes; i++)
> +					input_report_abs(input, bdev->axes[i],
> +							 tilt_state->axes[i]);
> +
> +				input_sync(input);
> +			}
> +
> +			bdev->count =3D 0;
> +			bdev->last_state =3D state;
> +		}
> +	}
> +}
> +
> +static void gpio_tilt_polled_open(struct input_polled_dev *dev)
> +{
> +	struct gpio_tilt_polled_dev *bdev =3D dev->private;
> +
> +	if (bdev->enable)
> +		bdev->enable(bdev->dev);
> +}
> +
> +static void gpio_tilt_polled_close(struct input_polled_dev *dev)
> +{
> +	struct gpio_tilt_polled_dev *bdev =3D dev->private;
> +
> +	if (bdev->disable)
> +		bdev->disable(bdev->dev);
> +}
> +
> +static int __devinit gpio_tilt_polled_probe(struct platform_device *=
pdev)
> +{
> +	struct gpio_tilt_platform_data *pdata =3D pdev->dev.platform_data;
> +	struct device *dev =3D &pdev->dev;
> +	struct gpio_tilt_polled_dev *bdev;
> +	struct input_polled_dev *poll_dev;
> +	struct input_dev *input;
> +	int error, i;
> +
> +	if (!pdata || !pdata->poll_interval)
> +		return -EINVAL;
> +
> +	bdev =3D kzalloc(sizeof(struct gpio_tilt_polled_dev), GFP_KERNEL);
> +	if (!bdev) {
> +		dev_err(dev, "no memory for private data\n");
> +		return -ENOMEM;
> +	}
> +
> +	bdev->gpios =3D kmemdup(pdata->gpios,
> +				 pdata->nr_gpios * sizeof(struct gpio),
> +				 GFP_KERNEL);
> +	if (bdev->gpios =3D=3D NULL) {
> +		dev_err(&pdev->dev, "Failed to allocate gpio data\n");
> +		error =3D -ENOMEM;
> +		goto err_free_bdev;
> +	}
> +	bdev->nr_gpios =3D pdata->nr_gpios;

Do you actually need to do this? Can't you just store the pointer to
the platform data and use it instead? Same goes for the rest of items
you are cloning.

> +
> +	error =3D gpio_request_array(bdev->gpios, bdev->nr_gpios);
> +	if (error) {
> +		dev_err(dev,
> +		   "Could not request tilt GPIOs: %d\n", error);
> +		goto err_free_gpiomem;
> +	}
> +
> +	bdev->states =3D kmemdup(pdata->states,
> +				pdata->nr_states *
> +					 sizeof(struct gpio_tilt_state),
> +				GFP_KERNEL);
> +	if (bdev->states =3D=3D NULL) {
> +		dev_err(dev, "Failed to allocate state data\n");
> +		error =3D -ENOMEM;
> +		goto err_free_gpios;
> +	}
> +	bdev->nr_states =3D pdata->nr_states;
> +
> +	bdev->axes =3D kzalloc(pdata->nr_axes * sizeof(int), GFP_KERNEL);
> +	if (!bdev->axes) {
> +		dev_err(dev, "no memory for axes data\n");
> +		error =3D -ENOMEM;
> +		goto err_free_states;
> +	}
> +
> +	poll_dev =3D input_allocate_polled_device();
> +	if (!poll_dev) {
> +		dev_err(dev, "no memory for polled device\n");
> +		error =3D -ENOMEM;
> +		goto err_free_axes;
> +	}
> +
> +	poll_dev->private =3D bdev;
> +	poll_dev->poll =3D gpio_tilt_polled_poll;
> +	poll_dev->poll_interval =3D pdata->poll_interval;
> +	poll_dev->open =3D gpio_tilt_polled_open;
> +	poll_dev->close =3D gpio_tilt_polled_close;
> +
> +	input =3D poll_dev->input;
> +
> +	input->name =3D pdev->name;
> +	input->phys =3D DRV_NAME"/input0";
> +	input->dev.parent =3D &pdev->dev;
> +
> +	input->id.bustype =3D BUS_HOST;
> +	input->id.vendor =3D 0x0001;
> +	input->id.product =3D 0x0001;
> +	input->id.version =3D 0x0100;
> +
> +	__set_bit(EV_ABS, input->evbit);
> +	for (i =3D 0; i < pdata->nr_axes; i++) {
> +		input_set_abs_params(input, pdata->axes[i].axis,
> +				     pdata->axes[i].min, pdata->axes[i].max,
> +				     pdata->axes[i].fuzz, pdata->axes[i].flat);
> +
> +		bdev->axes[i] =3D pdata->axes[i].axis;
> +	}
> +	bdev->nr_axes =3D pdata->nr_axes;
> +
> +	bdev->threshold =3D DIV_ROUND_UP(pdata->debounce_interval,
> +				       pdata->poll_interval);
> +
> +	bdev->poll_dev =3D poll_dev;
> +	bdev->dev =3D dev;
> +
> +	bdev->enable =3D pdata->enable;
> +	bdev->disable =3D pdata->disable;
> +
> +	error =3D input_register_polled_device(poll_dev);
> +	if (error) {
> +		dev_err(dev, "unable to register polled device, err=3D%d\n",
> +			error);
> +		goto err_free_polldev;
> +	}
> +
> +	platform_set_drvdata(pdev, bdev);
> +
> +	/* report initial state of the buttons */
> +	bdev->last_state =3D -1;
> +	bdev->count =3D bdev->threshold;
> +	gpio_tilt_polled_poll(poll_dev);

This should probably be in gpio_tilt_polled_open().

> +
> +	return 0;
> +
> +err_free_polldev:
> +	input_free_polled_device(poll_dev);
> +err_free_axes:
> +	kfree(bdev->axes);
> +err_free_states:
> +	kfree(bdev->states);
> +err_free_gpios:
> +	gpio_free_array(bdev->gpios, bdev->nr_gpios);
> +err_free_gpiomem:
> +	kfree(bdev->gpios);
> +err_free_bdev:
> +	kfree(bdev);
> +
> +	return error;
> +}
> +
> +static int __devexit gpio_tilt_polled_remove(struct platform_device =
*pdev)
> +{
> +	struct gpio_tilt_polled_dev *bdev =3D platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	input_unregister_polled_device(bdev->poll_dev);
> +	input_free_polled_device(bdev->poll_dev);
> +
> +	kfree(bdev->axes);
> +
> +	kfree(bdev->states);
> +
> +	gpio_free_array(bdev->gpios, bdev->nr_gpios);
> +
> +	kfree(bdev->gpios);
> +
> +	kfree(bdev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver gpio_tilt_polled_driver =3D {
> +	.probe	=3D gpio_tilt_polled_probe,
> +	.remove	=3D __devexit_p(gpio_tilt_polled_remove),
> +	.driver	=3D {
> +		.name	=3D DRV_NAME,
> +		.owner	=3D THIS_MODULE,
> +	},
> +};
> +
> +static int __init gpio_tilt_polled_init(void)
> +{
> +	return platform_driver_register(&gpio_tilt_polled_driver);
> +}
> +
> +static void __exit gpio_tilt_polled_exit(void)
> +{
> +	platform_driver_unregister(&gpio_tilt_polled_driver);
> +}
> +
> +module_init(gpio_tilt_polled_init);
> +module_exit(gpio_tilt_polled_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
> +MODULE_DESCRIPTION("Polled GPIO tilt driver");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/gpio_tilt.h b/include/linux/gpio_tilt.h
> new file mode 100644
> index 0000000..809fe93
> --- /dev/null
> +++ b/include/linux/gpio_tilt.h
> @@ -0,0 +1,73 @@
> +#ifndef _GPIO_TILT_H
> +#define _GPIO_TILT_H
> +
> +/**
> + * struct gpio_tilt_axis - Axis used by the tilt switch
> + * @axis:		Constant describing the axis, e.g. ABS_X
> + * @min:		minimum value for abs_param
> + * @max:		maximum value for abs_param
> + * @fuzz:		fuzz value for abs_param
> + * @flat:		flat value for abs_param
> + */
> +struct gpio_tilt_axis {
> +	int axis;
> +	int min;
> +	int max;
> +	int fuzz;
> +	int flat;
> +};
> +
> +/**
> + * struct gpio_tilt_state - state description
> + * @gpios:		bitfield of gpio target-states for the value
> + * @axes:		array containing the axes settings for the gpio state
> + *			The array indizes must correspond to the axes defined
> + *			in platform_data
> + *
> + * This structure describes a supported axis settings
> + * and the necessary gpio-state which represent it.
> + *
> + * The n-th bit in the bitfield describes the state of the n-th GPIO
> + * from the gpios-array defined in gpio_regulator_config below.
> + */
> +struct gpio_tilt_state {
> +	int gpios;
> +	int *axes;
> +};
> +
> +/**
> + * struct gpio_tilt_platform_data
> + * @gpios:		Array containing the gpios determining the tilt state
> + * @nr_gpios:		Number of gpios
> + * @axes:		Array of gpio_tilt_axis descriptions
> + * @nr_axes:		Number of axes
> + * @states:		Array of gpio_tilt_state entries describing
> + *			the gpio state for specific tilts
> + * @nr_states:		Number of states available
> + * @debounce_interval:	debounce ticks interval in msecs
> + * @poll_interval:	polling interval in msecs - for polling driver on=
ly
> + * @enable:		callback to enable the tilt switch
> + * @disable:		callback to disable the tilt switch
> + *
> + * This structure contains gpio-tilt-switch configuration
> + * information that must be passed by platform code to the
> + * gpio-tilt input driver.
> + */
> +struct gpio_tilt_platform_data {
> +	struct gpio *gpios;
> +	int nr_gpios;
> +
> +	struct gpio_tilt_axis *axes;
> +	int nr_axes;
> +
> +	struct gpio_tilt_state *states;
> +	int nr_states;
> +
> +	int debounce_interval;
> +
> +	unsigned int poll_interval;
> +	int (*enable)(struct device *dev);
> +	void (*disable)(struct device *dev);
> +};
> +
> +#endif
> --=20
> 1.7.5.4
>=20

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
