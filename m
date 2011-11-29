From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3] Add generic GPIO-tilt driver
Date: Tue, 29 Nov 2011 16:12:40 +0100
Message-ID: <201111291612.41069.heiko@sntech.de>
References: <201111291324.34045.heiko@sntech.de> <CAM=Q2cv3rFmxGLUrcEBWdr+kMyoX2mP3Qcr9G41Z0i57uPN=pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:43513 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab1K2PMo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 10:12:44 -0500
In-Reply-To: <CAM=Q2cv3rFmxGLUrcEBWdr+kMyoX2mP3Qcr9G41Z0i57uPN=pw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Shubhrajyoti,

Am Dienstag, 29. November 2011, 15:59:29 schrieb Shubhrajyoti Datta:
> Hi Heiko,
>=20
> On Tue, Nov 29, 2011 at 5:54 PM, Heiko St=FCbner <heiko@sntech.de> wr=
ote:
> > There exist tilt switches that simply report their tilt-state via s=
ome
> > gpios.
> >=20
> > The number and orientation of their axes can vary depending on the =
switch
> > used and the build of the device. Also two or more one-axis switche=
s
> > could be combined to provide multi-dimensional orientation.
> >=20
> > One example of a device using such a switch is the family of Qisda
> > ebook readers, where the switch provides information about the
> > landscape / portrait orientation of the device. The example in
> > Documentation/input/gpio-tilt.txt documents exactly this one-axis d=
evice.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > changes since v2: use module_platform_driver
> > changes since v1: address comments from Dmitry Torokhov
> > * bdev -> tdev
> > * report initial axis state during open and not during probe
> > * don't clone platform data and use the original instead
> >=20
> >  Documentation/input/gpio-tilt.txt     |  103 ++++++++++++++++
> >  drivers/input/misc/Kconfig            |   14 ++
> >  drivers/input/misc/Makefile           |    1 +
> >  drivers/input/misc/gpio_tilt_polled.c |  214
> > +++++++++++++++++++++++++++++++++ include/linux/gpio_tilt.h        =
   =20
> > |   73 +++++++++++
> >  5 files changed, 405 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/input/gpio-tilt.txt
> >  create mode 100644 drivers/input/misc/gpio_tilt_polled.c
> >  create mode 100644 include/linux/gpio_tilt.h
> >=20
> > diff --git a/Documentation/input/gpio-tilt.txt
> > b/Documentation/input/gpio-tilt.txt new file mode 100644
> > index 0000000..06d60c3
> > --- /dev/null
> > +++ b/Documentation/input/gpio-tilt.txt
> > @@ -0,0 +1,103 @@
> > +Driver for tilt-switches connected via GPIOs
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Generic driver to read data from tilt switches connected via gpios=
=2E
> > +Orientation can be provided by one or more than one tilt switches,
> > +i.e. each tilt switch providing one axis, and the number of axes
> > +is also not limited.
> > +
> > +
> > +Data structures:
> > +----------------
> > +
> > +The array of struct gpio in the gpios field is used to list the gp=
ios
> > +that represent the current tilt state.
> > +
> > +The array of struct gpio_tilt_axis describes the axes that are rep=
orted
> > +to the input system. The values set therein are used for the
> > +input_set_abs_params calls needed to init the axes.
> > +
> > +The array of struct gpio_tilt_state maps gpio states to the
> > corresponding +values to report. The gpio state is represented as a
> > bitfield where the +bit-index corresponds to the index of the gpio =
in
> > the struct gpio array. +In the same manner the values stored in the=
 axes
> > array correspond to +the elements of the gpio_tilt_axis-array.
> > +
> > +
> > +Example:
> > +--------
> > +
> > +Example configuration for a single TS1003 tilt switch that rotates
> > around +one axis in 4 steps and emitts the current tilt via two GPI=
Os.
> > +
> > +static int sg060_tilt_enable(struct device *dev) {
> > +       /* code to enable the sensors */
> > +};
> > +
> > +static void sg060_tilt_disable(struct device *dev) {
> > +       /* code to disable the sensors */
> > +};
> > +
> > +static struct gpio sg060_tilt_gpios[] =3D {
> > +       { SG060_TILT_GPIO_SENSOR1, GPIOF_IN, "tilt_sensor1" },
> > +       { SG060_TILT_GPIO_SENSOR2, GPIOF_IN, "tilt_sensor2" },
> > +};
> > +
> > +static struct gpio_tilt_state sg060_tilt_states[] =3D {
> > +       {
> > +               .gpios =3D (0 << 1) | (0 << 0),
> > +               .axes =3D (int[]) {
> > +                       0,
> > +               },
> > +       }, {
> > +               .gpios =3D (0 << 1) | (1 << 0),
> > +               .axes =3D (int[]) {
> > +                       1, /* 90 degrees */
> > +               },
> > +       }, {
> > +               .gpios =3D (1 << 1) | (1 << 0),
> > +               .axes =3D (int[]) {
> > +                       2, /* 180 degrees */
> > +               },
> > +       }, {
> > +               .gpios =3D (1 << 1) | (0 << 0),
> > +               .axes =3D (int[]) {
> > +                       3, /* 270 degrees */
> > +               },
> > +       },
> > +};
> > +
> > +static struct gpio_tilt_axis sg060_tilt_axes[] =3D {
> > +       {
> > +               .axis =3D ABS_RY,
> > +               .min =3D 0,
> > +               .max =3D 3,
> > +               .fuzz =3D 0,
> > +               .flat =3D 0,
> > +       },
> > +};
> > +
> > +static struct gpio_tilt_platform_data sg060_tilt_pdata=3D {
> > +       .gpios =3D sg060_tilt_gpios,
> > +       .nr_gpios =3D ARRAY_SIZE(sg060_tilt_gpios),
> > +
> > +       .axes =3D sg060_tilt_axes,
> > +       .nr_axes =3D ARRAY_SIZE(sg060_tilt_axes),
> > +
> > +       .states =3D sg060_tilt_states,
> > +       .nr_states =3D ARRAY_SIZE(sg060_tilt_states),
> > +
> > +       .debounce_interval =3D 100,
> > +
> > +       .poll_interval =3D 1000,
> > +       .enable =3D sg060_tilt_enable,
> > +       .disable =3D sg060_tilt_disable,
> > +};
> > +
> > +static struct platform_device sg060_device_tilt =3D {
> > +       .name =3D "gpio-tilt-polled",
> > +       .id =3D -1,
> > +       .dev =3D {
> > +               .platform_data =3D &sg060_tilt_pdata,
> > +       },
> > +};
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfi=
g
> > index 22d875f..e53b443 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -179,6 +179,20 @@ config INPUT_APANEL
> >         To compile this driver as a module, choose M here: the modu=
le
> > will be called apanel.
> >=20
> > +config INPUT_GPIO_TILT_POLLED
> > +       tristate "Polled GPIO tilt switch"
> > +       depends on GENERIC_GPIO
> > +       select INPUT_POLLDEV
> > +       help
> > +         This driver implements support for tilt switches connecte=
d
> > +         to GPIO pins that are not capable of generating interrupt=
s.
> > +
> > +         The list of gpios to use and the mapping of their states
> > +         to specific angles is done via platform data.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called gpio_tilt_polled.
> > +
> >  config INPUT_IXP4XX_BEEPER
> >        tristate "IXP4XX Beeper support"
> >        depends on ARCH_IXP4XX
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makef=
ile
> > index a244fc6..90070c1 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C)               +=3D
> > cma3000_d0x_i2c.o obj-$(CONFIG_INPUT_COBALT_BTNS)                +=3D
> > cobalt_btns.o obj-$(CONFIG_INPUT_DM355EVM)           +=3D dm355evm_=
keys.o
> >  obj-$(CONFIG_HP_SDC_RTC)               +=3D hp_sdc_rtc.o
> > +obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)   +=3D gpio_tilt_polled.o
> >  obj-$(CONFIG_INPUT_IXP4XX_BEEPER)      +=3D ixp4xx-beeper.o
> >  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)     +=3D keyspan_remote.o
> >  obj-$(CONFIG_INPUT_KXTJ9)              +=3D kxtj9.o
> > diff --git a/drivers/input/misc/gpio_tilt_polled.c
> > b/drivers/input/misc/gpio_tilt_polled.c new file mode 100644
> > index 0000000..ebc3f08
> > --- /dev/null
> > +++ b/drivers/input/misc/gpio_tilt_polled.c
> > @@ -0,0 +1,214 @@
> > +/*
> > + *  Driver for tilt switches connected via GPIO lines
> > + *  not capable of generating interrupts
> > + *
> > + *  Copyright (C) 2011 Heiko Stuebner <heiko@sntech.de>
> > + *
> > + *  based on: /drivers/input/keyboard/gpio_keys_polled.c
> > + *
> > + *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
> > + *  Copyright (C) 2010 Nuno Goncalves <nunojpg@gmail.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or =
modify
> > + *  it under the terms of the GNU General Public License version 2=
 as
> > + *  published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/input.h>
> > +#include <linux/input-polldev.h>
> > +#include <linux/ioport.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/gpio.h>
> > +#include <linux/gpio_tilt.h>
> > +
> > +#define DRV_NAME       "gpio-tilt-polled"
> > +
> > +struct gpio_tilt_polled_dev {
> > +       struct input_polled_dev *poll_dev;
> > +       struct device *dev;
> > +       struct gpio_tilt_platform_data *pdata;
> > +
> > +       int last_state;
> > +
> > +       int threshold;
> > +       int count;
> > +};
> > +
> > +static void gpio_tilt_polled_poll(struct input_polled_dev *dev)
> > +{
> > +       struct gpio_tilt_polled_dev *tdev =3D dev->private;
> > +       struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> > +       struct input_dev *input =3D dev->input;
> > +       struct gpio_tilt_state *tilt_state =3D NULL;
> > +       int state, i;
> > +
> > +       if (tdev->count < tdev->threshold) {
>=20
> Nitpick : the braces are not necessary.
hmm ... for me it's easier to read if the style of the braces does not =
change
between if and else, i.e. both with or without braces.
And the kernel CodingStyle-file seems also to be in my favor ;-)
[starting from line 169].

> > +               tdev->count++;
> > +       } else {
> > +               state =3D 0;
> > +               for (i =3D 0; i < pdata->nr_gpios; i++)
> > +                       state |=3D (!!gpio_get_value(pdata->gpios[i=
].gpio)
> > << i); +
> > +               if (state !=3D tdev->last_state) {
> > +                       for (i =3D 0; i < pdata->nr_states; i++)
> > +                               if (pdata->states[i].gpios =3D=3D s=
tate)
> > +                                       tilt_state =3D &pdata->stat=
es[i];
> > +
> > +                       if (tilt_state) {
> > +                               for (i =3D 0; i < pdata->nr_axes; i=
++)
> > +                                       input_report_abs(input,
> > +                                                     =20
> >  pdata->axes[i].axis, +                                            =
   =20
> >        tilt_state->axes[i]); +
> > +                               input_sync(input);
> > +                       }
> > +
> > +                       tdev->count =3D 0;
> > +                       tdev->last_state =3D state;
> > +               }
> > +       }
> > +}
> > +
> > +static void gpio_tilt_polled_open(struct input_polled_dev *dev)
> > +{
> > +       struct gpio_tilt_polled_dev *tdev =3D dev->private;
> > +       struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> > +
> > +       if (pdata->enable)
> > +               pdata->enable(tdev->dev);
> > +
> > +       /* report initial state of the axes */
> > +       tdev->last_state =3D -1;
> > +       tdev->count =3D tdev->threshold;
> > +       gpio_tilt_polled_poll(tdev->poll_dev);
> > +}
> > +
> > +static void gpio_tilt_polled_close(struct input_polled_dev *dev)
> > +{
> > +       struct gpio_tilt_polled_dev *tdev =3D dev->private;
> > +       struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> > +
> > +       if (pdata->disable)
> > +               pdata->disable(tdev->dev);
> > +}
> > +
> > +static int __devinit gpio_tilt_polled_probe(struct platform_device
> > *pdev) +{
> > +       struct gpio_tilt_platform_data *pdata =3D pdev->dev.platfor=
m_data;
> > +       struct device *dev =3D &pdev->dev;
> > +       struct gpio_tilt_polled_dev *tdev;
> > +       struct input_polled_dev *poll_dev;
> > +       struct input_dev *input;
> > +       int error, i;
> > +
> > +       if (!pdata || !pdata->poll_interval)
> > +               return -EINVAL;
>=20
> Could we have a default poll interval if passed 0 ?
> Feel free to ignore if you feel otherwise.
=46or me either way is fine but I'm not sure what would be a generic
enough default value for most cases (500, 1000 ? ).

> > +
> > +       tdev =3D kzalloc(sizeof(struct gpio_tilt_polled_dev), GFP_K=
ERNEL);
> > +       if (!tdev) {
> > +               dev_err(dev, "no memory for private data\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       error =3D gpio_request_array(pdata->gpios, pdata->nr_gpios)=
;
> > +       if (error) {
> > +               dev_err(dev,
> > +                  "Could not request tilt GPIOs: %d\n", error);
> > +               goto err_free_tdev;
> > +       }
> > +
> > +       poll_dev =3D input_allocate_polled_device();
> > +       if (!poll_dev) {
> > +               dev_err(dev, "no memory for polled device\n");
> > +               error =3D -ENOMEM;
> > +               goto err_free_gpios;
> > +       }
> > +
> > +       poll_dev->private =3D tdev;
> > +       poll_dev->poll =3D gpio_tilt_polled_poll;
> > +       poll_dev->poll_interval =3D pdata->poll_interval;
> > +       poll_dev->open =3D gpio_tilt_polled_open;
> > +       poll_dev->close =3D gpio_tilt_polled_close;
> > +
> > +       input =3D poll_dev->input;
> > +
> > +       input->name =3D pdev->name;
> > +       input->phys =3D DRV_NAME"/input0";
> > +       input->dev.parent =3D &pdev->dev;
> > +
> > +       input->id.bustype =3D BUS_HOST;
> > +       input->id.vendor =3D 0x0001;
> > +       input->id.product =3D 0x0001;
> > +       input->id.version =3D 0x0100;
> > +
> > +       __set_bit(EV_ABS, input->evbit);
> > +       for (i =3D 0; i < pdata->nr_axes; i++) {
> > +               input_set_abs_params(input, pdata->axes[i].axis,
> > +                                    pdata->axes[i].min,
> > pdata->axes[i].max, +                                 =20
> >  pdata->axes[i].fuzz, pdata->axes[i].flat); +       }
> > +
> > +       tdev->threshold =3D DIV_ROUND_UP(pdata->debounce_interval,
> > +                                      pdata->poll_interval);
> > +
> > +       tdev->poll_dev =3D poll_dev;
> > +       tdev->dev =3D dev;
> > +       tdev->pdata =3D pdata;
> > +
> > +       error =3D input_register_polled_device(poll_dev);
> > +       if (error) {
> > +               dev_err(dev, "unable to register polled device,
> > err=3D%d\n", +                       error);
> > +               goto err_free_polldev;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, tdev);
> > +
> > +       return 0;
> > +
> > +err_free_polldev:
> > +       input_free_polled_device(poll_dev);
> > +err_free_gpios:
> > +       gpio_free_array(pdata->gpios, pdata->nr_gpios);
> > +err_free_tdev:
> > +       kfree(tdev);
> > +
> > +       return error;
> > +}
> > +
> > +static int __devexit gpio_tilt_polled_remove(struct platform_devic=
e
> > *pdev) +{
> > +       struct gpio_tilt_polled_dev *tdev =3D platform_get_drvdata(=
pdev);
> > +       struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> > +
> > +       platform_set_drvdata(pdev, NULL);
> > +
> > +       input_unregister_polled_device(tdev->poll_dev);
> > +       input_free_polled_device(tdev->poll_dev);
> > +
> > +       gpio_free_array(pdata->gpios, pdata->nr_gpios);
> > +
> > +       kfree(tdev);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver gpio_tilt_polled_driver =3D {
> > +       .probe  =3D gpio_tilt_polled_probe,
> > +       .remove =3D __devexit_p(gpio_tilt_polled_remove),
> > +       .driver =3D {
> > +               .name   =3D DRV_NAME,
> > +               .owner  =3D THIS_MODULE,
> > +       },
> > +};
> > +
> > +module_platform_driver(gpio_tilt_polled_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
> > +MODULE_DESCRIPTION("Polled GPIO tilt driver");
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > diff --git a/include/linux/gpio_tilt.h b/include/linux/gpio_tilt.h
> > new file mode 100644
> > index 0000000..809fe93
> > --- /dev/null
> > +++ b/include/linux/gpio_tilt.h
> > @@ -0,0 +1,73 @@
> > +#ifndef _GPIO_TILT_H
> > +#define _GPIO_TILT_H
> > +
> > +/**
> > + * struct gpio_tilt_axis - Axis used by the tilt switch
> > + * @axis:              Constant describing the axis, e.g. ABS_X
> > + * @min:               minimum value for abs_param
> > + * @max:               maximum value for abs_param
> > + * @fuzz:              fuzz value for abs_param
> > + * @flat:              flat value for abs_param
> > + */
> > +struct gpio_tilt_axis {
> > +       int axis;
> > +       int min;
> > +       int max;
> > +       int fuzz;
> > +       int flat;
> > +};
> > +
> > +/**
> > + * struct gpio_tilt_state - state description
> > + * @gpios:             bitfield of gpio target-states for the valu=
e
> > + * @axes:              array containing the axes settings for the =
gpio
> > state + *                     The array indizes must correspond to =
the
> > axes defined + *                     in platform_data
> > + *
> > + * This structure describes a supported axis settings
> > + * and the necessary gpio-state which represent it.
> > + *
> > + * The n-th bit in the bitfield describes the state of the n-th GP=
IO
> > + * from the gpios-array defined in gpio_regulator_config below.
> > + */
> > +struct gpio_tilt_state {
> > +       int gpios;
> > +       int *axes;
> > +};
> > +
> > +/**
> > + * struct gpio_tilt_platform_data
> > + * @gpios:             Array containing the gpios determining the =
tilt
> > state + * @nr_gpios:          Number of gpios
> > + * @axes:              Array of gpio_tilt_axis descriptions
> > + * @nr_axes:           Number of axes
> > + * @states:            Array of gpio_tilt_state entries describing
> > + *                     the gpio state for specific tilts
> > + * @nr_states:         Number of states available
> > + * @debounce_interval: debounce ticks interval in msecs
> > + * @poll_interval:     polling interval in msecs - for polling dri=
ver
> > only + * @enable:            callback to enable the tilt switch
> > + * @disable:           callback to disable the tilt switch
> > + *
> > + * This structure contains gpio-tilt-switch configuration
> > + * information that must be passed by platform code to the
> > + * gpio-tilt input driver.
> > + */
> > +struct gpio_tilt_platform_data {
> > +       struct gpio *gpios;
> > +       int nr_gpios;
> > +
> > +       struct gpio_tilt_axis *axes;
> > +       int nr_axes;
> > +
> > +       struct gpio_tilt_state *states;
> > +       int nr_states;
> > +
> > +       int debounce_interval;
> > +
> > +       unsigned int poll_interval;
> > +       int (*enable)(struct device *dev);
> > +       void (*disable)(struct device *dev);
> > +};
> > +
> > +#endif
> > --
> > 1.7.5.4
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-inp=
ut" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
