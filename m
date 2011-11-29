From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH v3] Add generic GPIO-tilt driver
Date: Tue, 29 Nov 2011 20:29:29 +0530
Message-ID: <CAM=Q2cv3rFmxGLUrcEBWdr+kMyoX2mP3Qcr9G41Z0i57uPN=pw@mail.gmail.com>
References: <201111291324.34045.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36625 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab1K2O7a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 09:59:30 -0500
Received: by vcbfk14 with SMTP id fk14so4676887vcb.19
        for <linux-input@vger.kernel.org>; Tue, 29 Nov 2011 06:59:29 -0800 (PST)
In-Reply-To: <201111291324.34045.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Heiko,

On Tue, Nov 29, 2011 at 5:54 PM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> There exist tilt switches that simply report their tilt-state via som=
e gpios.
>
> The number and orientation of their axes can vary depending on the sw=
itch
> used and the build of the device. Also two or more one-axis switches
> could be combined to provide multi-dimensional orientation.
>
> One example of a device using such a switch is the family of Qisda
> ebook readers, where the switch provides information about the
> landscape / portrait orientation of the device. The example in
> Documentation/input/gpio-tilt.txt documents exactly this one-axis dev=
ice.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v2: use module_platform_driver
> changes since v1: address comments from Dmitry Torokhov
> * bdev -> tdev
> * report initial axis state during open and not during probe
> * don't clone platform data and use the original instead
>
> =A0Documentation/input/gpio-tilt.txt =A0 =A0 | =A0103 +++++++++++++++=
+
> =A0drivers/input/misc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 ++
> =A0drivers/input/misc/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/input/misc/gpio_tilt_polled.c | =A0214 +++++++++++++++++++=
++++++++++++++
> =A0include/linux/gpio_tilt.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 73 +++++++=
++++
> =A05 files changed, 405 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/input/gpio-tilt.txt
> =A0create mode 100644 drivers/input/misc/gpio_tilt_polled.c
> =A0create mode 100644 include/linux/gpio_tilt.h
>
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
> + =A0 =A0 =A0 /* code to enable the sensors */
> +};
> +
> +static void sg060_tilt_disable(struct device *dev) {
> + =A0 =A0 =A0 /* code to disable the sensors */
> +};
> +
> +static struct gpio sg060_tilt_gpios[] =3D {
> + =A0 =A0 =A0 { SG060_TILT_GPIO_SENSOR1, GPIOF_IN, "tilt_sensor1" },
> + =A0 =A0 =A0 { SG060_TILT_GPIO_SENSOR2, GPIOF_IN, "tilt_sensor2" },
> +};
> +
> +static struct gpio_tilt_state sg060_tilt_states[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpios =3D (0 << 1) | (0 << 0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .axes =3D (int[]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpios =3D (0 << 1) | (1 << 0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .axes =3D (int[]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, /* 90 degrees */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpios =3D (1 << 1) | (1 << 0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .axes =3D (int[]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2, /* 180 degrees */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpios =3D (1 << 1) | (0 << 0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .axes =3D (int[]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3, /* 270 degrees */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> +};
> +
> +static struct gpio_tilt_axis sg060_tilt_axes[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .axis =3D ABS_RY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .fuzz =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flat =3D 0,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct gpio_tilt_platform_data sg060_tilt_pdata=3D {
> + =A0 =A0 =A0 .gpios =3D sg060_tilt_gpios,
> + =A0 =A0 =A0 .nr_gpios =3D ARRAY_SIZE(sg060_tilt_gpios),
> +
> + =A0 =A0 =A0 .axes =3D sg060_tilt_axes,
> + =A0 =A0 =A0 .nr_axes =3D ARRAY_SIZE(sg060_tilt_axes),
> +
> + =A0 =A0 =A0 .states =3D sg060_tilt_states,
> + =A0 =A0 =A0 .nr_states =3D ARRAY_SIZE(sg060_tilt_states),
> +
> + =A0 =A0 =A0 .debounce_interval =3D 100,
> +
> + =A0 =A0 =A0 .poll_interval =3D 1000,
> + =A0 =A0 =A0 .enable =3D sg060_tilt_enable,
> + =A0 =A0 =A0 .disable =3D sg060_tilt_disable,
> +};
> +
> +static struct platform_device sg060_device_tilt =3D {
> + =A0 =A0 =A0 .name =3D "gpio-tilt-polled",
> + =A0 =A0 =A0 .id =3D -1,
> + =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &sg060_tilt_pdata,
> + =A0 =A0 =A0 },
> +};
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 22d875f..e53b443 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -179,6 +179,20 @@ config INPUT_APANEL
> =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: th=
e module will
> =A0 =A0 =A0 =A0 be called apanel.
>
> +config INPUT_GPIO_TILT_POLLED
> + =A0 =A0 =A0 tristate "Polled GPIO tilt switch"
> + =A0 =A0 =A0 depends on GENERIC_GPIO
> + =A0 =A0 =A0 select INPUT_POLLDEV
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This driver implements support for tilt switches co=
nnected
> + =A0 =A0 =A0 =A0 to GPIO pins that are not capable of generating int=
errupts.
> +
> + =A0 =A0 =A0 =A0 The list of gpios to use and the mapping of their s=
tates
> + =A0 =A0 =A0 =A0 to specific angles is done via platform data.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
> + =A0 =A0 =A0 =A0 module will be called gpio_tilt_polled.
> +
> =A0config INPUT_IXP4XX_BEEPER
> =A0 =A0 =A0 =A0tristate "IXP4XX Beeper support"
> =A0 =A0 =A0 =A0depends on ARCH_IXP4XX
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefil=
e
> index a244fc6..90070c1 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 +=3D cma3000_d0x_i2c.o
> =A0obj-$(CONFIG_INPUT_COBALT_BTNS) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 cobalt_btns.o
> =A0obj-$(CONFIG_INPUT_DM355EVM) =A0 =A0 =A0 =A0 =A0 +=3D dm355evm_key=
s.o
> =A0obj-$(CONFIG_HP_SDC_RTC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D hp_sdc_r=
tc.o
> +obj-$(CONFIG_INPUT_GPIO_TILT_POLLED) =A0 +=3D gpio_tilt_polled.o
> =A0obj-$(CONFIG_INPUT_IXP4XX_BEEPER) =A0 =A0 =A0+=3D ixp4xx-beeper.o
> =A0obj-$(CONFIG_INPUT_KEYSPAN_REMOTE) =A0 =A0 +=3D keyspan_remote.o
> =A0obj-$(CONFIG_INPUT_KXTJ9) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D kxtj9.o
> diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/mi=
sc/gpio_tilt_polled.c
> new file mode 100644
> index 0000000..ebc3f08
> --- /dev/null
> +++ b/drivers/input/misc/gpio_tilt_polled.c
> @@ -0,0 +1,214 @@
> +/*
> + * =A0Driver for tilt switches connected via GPIO lines
> + * =A0not capable of generating interrupts
> + *
> + * =A0Copyright (C) 2011 Heiko Stuebner <heiko@sntech.de>
> + *
> + * =A0based on: /drivers/input/keyboard/gpio_keys_polled.c
> + *
> + * =A0Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
> + * =A0Copyright (C) 2010 Nuno Goncalves <nunojpg@gmail.com>
> + *
> + * =A0This program is free software; you can redistribute it and/or =
modify
> + * =A0it under the terms of the GNU General Public License version 2=
 as
> + * =A0published by the Free Software Foundation.
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
> +#define DRV_NAME =A0 =A0 =A0 "gpio-tilt-polled"
> +
> +struct gpio_tilt_polled_dev {
> + =A0 =A0 =A0 struct input_polled_dev *poll_dev;
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct gpio_tilt_platform_data *pdata;
> +
> + =A0 =A0 =A0 int last_state;
> +
> + =A0 =A0 =A0 int threshold;
> + =A0 =A0 =A0 int count;
> +};
> +
> +static void gpio_tilt_polled_poll(struct input_polled_dev *dev)
> +{
> + =A0 =A0 =A0 struct gpio_tilt_polled_dev *tdev =3D dev->private;
> + =A0 =A0 =A0 struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> + =A0 =A0 =A0 struct input_dev *input =3D dev->input;
> + =A0 =A0 =A0 struct gpio_tilt_state *tilt_state =3D NULL;
> + =A0 =A0 =A0 int state, i;
> +
> + =A0 =A0 =A0 if (tdev->count < tdev->threshold) {
Nitpick : the braces are not necessary.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tdev->count++;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->nr_gpios; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state |=3D (!!gpio_get_=
value(pdata->gpios[i].gpio) << i);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (state !=3D tdev->last_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata=
->nr_states; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pda=
ta->states[i].gpios =3D=3D state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tilt_state =3D &pdata->states[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tilt_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =
=3D 0; i < pdata->nr_axes; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 input_report_abs(input,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->axes[i].axis,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tilt_state->axes[i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_s=
ync(input);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tdev->count =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tdev->last_state =3D st=
ate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +static void gpio_tilt_polled_open(struct input_polled_dev *dev)
> +{
> + =A0 =A0 =A0 struct gpio_tilt_polled_dev *tdev =3D dev->private;
> + =A0 =A0 =A0 struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> +
> + =A0 =A0 =A0 if (pdata->enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->enable(tdev->dev);
> +
> + =A0 =A0 =A0 /* report initial state of the axes */
> + =A0 =A0 =A0 tdev->last_state =3D -1;
> + =A0 =A0 =A0 tdev->count =3D tdev->threshold;
> + =A0 =A0 =A0 gpio_tilt_polled_poll(tdev->poll_dev);
> +}
> +
> +static void gpio_tilt_polled_close(struct input_polled_dev *dev)
> +{
> + =A0 =A0 =A0 struct gpio_tilt_polled_dev *tdev =3D dev->private;
> + =A0 =A0 =A0 struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> +
> + =A0 =A0 =A0 if (pdata->disable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->disable(tdev->dev);
> +}
> +
> +static int __devinit gpio_tilt_polled_probe(struct platform_device *=
pdev)
> +{
> + =A0 =A0 =A0 struct gpio_tilt_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct gpio_tilt_polled_dev *tdev;
> + =A0 =A0 =A0 struct input_polled_dev *poll_dev;
> + =A0 =A0 =A0 struct input_dev *input;
> + =A0 =A0 =A0 int error, i;
> +
> + =A0 =A0 =A0 if (!pdata || !pdata->poll_interval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
Could we have a default poll interval if passed 0 ?
=46eel free to ignore if you feel otherwise.

> +
> + =A0 =A0 =A0 tdev =3D kzalloc(sizeof(struct gpio_tilt_polled_dev), G=
=46P_KERNEL);
> + =A0 =A0 =A0 if (!tdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no memory for private dat=
a\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 error =3D gpio_request_array(pdata->gpios, pdata->nr_gp=
ios);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Could not request tilt GPIOs: %=
d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_tdev;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 poll_dev =3D input_allocate_polled_device();
> + =A0 =A0 =A0 if (!poll_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no memory for polled devi=
ce\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_gpios;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 poll_dev->private =3D tdev;
> + =A0 =A0 =A0 poll_dev->poll =3D gpio_tilt_polled_poll;
> + =A0 =A0 =A0 poll_dev->poll_interval =3D pdata->poll_interval;
> + =A0 =A0 =A0 poll_dev->open =3D gpio_tilt_polled_open;
> + =A0 =A0 =A0 poll_dev->close =3D gpio_tilt_polled_close;
> +
> + =A0 =A0 =A0 input =3D poll_dev->input;
> +
> + =A0 =A0 =A0 input->name =3D pdev->name;
> + =A0 =A0 =A0 input->phys =3D DRV_NAME"/input0";
> + =A0 =A0 =A0 input->dev.parent =3D &pdev->dev;
> +
> + =A0 =A0 =A0 input->id.bustype =3D BUS_HOST;
> + =A0 =A0 =A0 input->id.vendor =3D 0x0001;
> + =A0 =A0 =A0 input->id.product =3D 0x0001;
> + =A0 =A0 =A0 input->id.version =3D 0x0100;
> +
> + =A0 =A0 =A0 __set_bit(EV_ABS, input->evbit);
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->nr_axes; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input, pdata->axes=
[i].axis,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0pdata->axes[i].min, pdata->axes[i].max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0pdata->axes[i].fuzz, pdata->axes[i].flat);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tdev->threshold =3D DIV_ROUND_UP(pdata->debounce_interv=
al,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0pdata->poll_interval);
> +
> + =A0 =A0 =A0 tdev->poll_dev =3D poll_dev;
> + =A0 =A0 =A0 tdev->dev =3D dev;
> + =A0 =A0 =A0 tdev->pdata =3D pdata;
> +
> + =A0 =A0 =A0 error =3D input_register_polled_device(poll_dev);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "unable to register polled=
 device, err=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_polldev;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, tdev);
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_free_polldev:
> + =A0 =A0 =A0 input_free_polled_device(poll_dev);
> +err_free_gpios:
> + =A0 =A0 =A0 gpio_free_array(pdata->gpios, pdata->nr_gpios);
> +err_free_tdev:
> + =A0 =A0 =A0 kfree(tdev);
> +
> + =A0 =A0 =A0 return error;
> +}
> +
> +static int __devexit gpio_tilt_polled_remove(struct platform_device =
*pdev)
> +{
> + =A0 =A0 =A0 struct gpio_tilt_polled_dev *tdev =3D platform_get_drvd=
ata(pdev);
> + =A0 =A0 =A0 struct gpio_tilt_platform_data *pdata =3D tdev->pdata;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> +
> + =A0 =A0 =A0 input_unregister_polled_device(tdev->poll_dev);
> + =A0 =A0 =A0 input_free_polled_device(tdev->poll_dev);
> +
> + =A0 =A0 =A0 gpio_free_array(pdata->gpios, pdata->nr_gpios);
> +
> + =A0 =A0 =A0 kfree(tdev);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver gpio_tilt_polled_driver =3D {
> + =A0 =A0 =A0 .probe =A0=3D gpio_tilt_polled_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(gpio_tilt_polled_remove),
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +module_platform_driver(gpio_tilt_polled_driver);
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
> + * @axis: =A0 =A0 =A0 =A0 =A0 =A0 =A0Constant describing the axis, e=
=2Eg. ABS_X
> + * @min: =A0 =A0 =A0 =A0 =A0 =A0 =A0 minimum value for abs_param
> + * @max: =A0 =A0 =A0 =A0 =A0 =A0 =A0 maximum value for abs_param
> + * @fuzz: =A0 =A0 =A0 =A0 =A0 =A0 =A0fuzz value for abs_param
> + * @flat: =A0 =A0 =A0 =A0 =A0 =A0 =A0flat value for abs_param
> + */
> +struct gpio_tilt_axis {
> + =A0 =A0 =A0 int axis;
> + =A0 =A0 =A0 int min;
> + =A0 =A0 =A0 int max;
> + =A0 =A0 =A0 int fuzz;
> + =A0 =A0 =A0 int flat;
> +};
> +
> +/**
> + * struct gpio_tilt_state - state description
> + * @gpios: =A0 =A0 =A0 =A0 =A0 =A0 bitfield of gpio target-states fo=
r the value
> + * @axes: =A0 =A0 =A0 =A0 =A0 =A0 =A0array containing the axes setti=
ngs for the gpio state
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The array indizes must co=
rrespond to the axes defined
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in platform_data
> + *
> + * This structure describes a supported axis settings
> + * and the necessary gpio-state which represent it.
> + *
> + * The n-th bit in the bitfield describes the state of the n-th GPIO
> + * from the gpios-array defined in gpio_regulator_config below.
> + */
> +struct gpio_tilt_state {
> + =A0 =A0 =A0 int gpios;
> + =A0 =A0 =A0 int *axes;
> +};
> +
> +/**
> + * struct gpio_tilt_platform_data
> + * @gpios: =A0 =A0 =A0 =A0 =A0 =A0 Array containing the gpios determ=
ining the tilt state
> + * @nr_gpios: =A0 =A0 =A0 =A0 =A0Number of gpios
> + * @axes: =A0 =A0 =A0 =A0 =A0 =A0 =A0Array of gpio_tilt_axis descrip=
tions
> + * @nr_axes: =A0 =A0 =A0 =A0 =A0 Number of axes
> + * @states: =A0 =A0 =A0 =A0 =A0 =A0Array of gpio_tilt_state entries =
describing
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the gpio state for specif=
ic tilts
> + * @nr_states: =A0 =A0 =A0 =A0 Number of states available
> + * @debounce_interval: debounce ticks interval in msecs
> + * @poll_interval: =A0 =A0 polling interval in msecs - for polling d=
river only
> + * @enable: =A0 =A0 =A0 =A0 =A0 =A0callback to enable the tilt switc=
h
> + * @disable: =A0 =A0 =A0 =A0 =A0 callback to disable the tilt switch
> + *
> + * This structure contains gpio-tilt-switch configuration
> + * information that must be passed by platform code to the
> + * gpio-tilt input driver.
> + */
> +struct gpio_tilt_platform_data {
> + =A0 =A0 =A0 struct gpio *gpios;
> + =A0 =A0 =A0 int nr_gpios;
> +
> + =A0 =A0 =A0 struct gpio_tilt_axis *axes;
> + =A0 =A0 =A0 int nr_axes;
> +
> + =A0 =A0 =A0 struct gpio_tilt_state *states;
> + =A0 =A0 =A0 int nr_states;
> +
> + =A0 =A0 =A0 int debounce_interval;
> +
> + =A0 =A0 =A0 unsigned int poll_interval;
> + =A0 =A0 =A0 int (*enable)(struct device *dev);
> + =A0 =A0 =A0 void (*disable)(struct device *dev);
> +};
> +
> +#endif
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
