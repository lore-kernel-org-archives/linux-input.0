From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
Date: Thu, 21 Jul 2016 08:29:50 +0200
Message-ID: <20160721062950.GB5993@lukather>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469003351-15263-5-git-send-email-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 10:29:10AM +0200, Quentin Schulz wrote:
> This adds support for Allwinner SoCs' (A10, A13 and A31) resistive
> touchscreen. This driver is probed by the MFD sunxi-gpadc-mfd.
>=20
> This driver uses ADC channels exposed through the IIO framework by
> sunxi-gpadc-iio to get its data. When opening this input device, it will
> start buffering in the ADC driver and enable a TP_UP_PENDING irq. The ADC
> driver will fill in a buffer with all data and call the callback the input
> device associated with this buffer. The input device will then read the
> buffer two by two and send X and Y coordinates to the input framework bas=
ed
> on what it received from the ADC's buffer. When closing this input device,
> the buffering is stopped.
>=20
> Note that locations in the first received buffer after an TP_UP_PENDING i=
rq
> occurred are unreliable, thus dropped.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/input/touchscreen/Kconfig          |  11 +-
>  drivers/input/touchscreen/Makefile         |   2 +-
>  drivers/input/touchscreen/sun4i-ts.c       | 419 -----------------------=
------
>  drivers/input/touchscreen/sunxi-gpadc-ts.c | 195 ++++++++++++++

This new driver and the removal of the old one should be in two
separate patches, the removal being in the last one. You break
bisectability here, since the new driver won't be loaded, and the old
one will not be there anymore.

>  4 files changed, 201 insertions(+), 426 deletions(-)
>  delete mode 100644 drivers/input/touchscreen/sun4i-ts.c
>  create mode 100644 drivers/input/touchscreen/sunxi-gpadc-ts.c
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscree=
n/Kconfig
> index 8ecdc38..f16ce36 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1072,14 +1072,13 @@ config TOUCHSCREEN_STMPE
>  config TOUCHSCREEN_SUN4I
>  	tristate "Allwinner sun4i resistive touchscreen controller support"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on HWMON
> -	depends on THERMAL || !THERMAL_OF
> +	depends on SUNXI_ADC
>  	help
> -	  This selects support for the resistive touchscreen controller
> -	  found on Allwinner sunxi SoCs.
> +	  This selects support for the resistive touchscreen controller found
> +	  on Allwinner SoCs (A10, A13, A31).
> =20
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called sun4i-ts.
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sunxi-gpadc-ts.
> =20
>  config TOUCHSCREEN_SUR40
>  	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscre=
en/Makefile
> index f42975e..bdc1889 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -65,7 +65,7 @@ obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+=3D pixcir_i2c_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+=3D s3c2410_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ST1232)	+=3D st1232.o
>  obj-$(CONFIG_TOUCHSCREEN_STMPE)		+=3D stmpe-ts.o
> -obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+=3D sun4i-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+=3D sunxi-gpadc-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SUR40)		+=3D sur40.o
>  obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+=3D ti_am335x_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+=3D touchit213.o
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchsc=
reen/sun4i-ts.c
> deleted file mode 100644
> index d07dd29..0000000
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ /dev/null
> @@ -1,419 +0,0 @@
> -/*
> - * Allwinner sunxi resistive touchscreen controller driver
> - *
> - * Copyright (C) 2013 - 2014 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> - *
> - * The hwmon parts are based on work by Corentin LABBE which is:
> - * Copyright (C) 2013 Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -/*
> - * The sun4i-ts controller is capable of detecting a second touch, but w=
hen a
> - * second touch is present then the accuracy becomes so bad the reported=
 touch
> - * location is not useable.
> - *
> - * The original android driver contains some complicated heuristics usin=
g the
> - * aprox. distance between the 2 touches to see if the user is making a =
pinch
> - * open / close movement, and then reports emulated multi-touch events a=
round
> - * the last touch coordinate (as the dual-touch coordinates are worthles=
s).
> - *
> - * These kinds of heuristics are just asking for trouble (and don't belo=
ng
> - * in the kernel). So this driver offers straight forward, reliable sing=
le
> - * touch functionality only.
> - *
> - * s.a. A20 User Manual "1.15 TP" (Documentation/arm/sunxi/README)
> - * (looks like the description in the A20 User Manual v1.3 is better
> - * than the one in the A10 User Manual v.1.5)
> - */
> -
> -#include <linux/err.h>
> -#include <linux/hwmon.h>
> -#include <linux/thermal.h>
> -#include <linux/init.h>
> -#include <linux/input.h>
> -#include <linux/interrupt.h>
> -#include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/of_platform.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -
> -#define TP_CTRL0		0x00
> -#define TP_CTRL1		0x04
> -#define TP_CTRL2		0x08
> -#define TP_CTRL3		0x0c
> -#define TP_INT_FIFOC		0x10
> -#define TP_INT_FIFOS		0x14
> -#define TP_TPR			0x18
> -#define TP_CDAT			0x1c
> -#define TEMP_DATA		0x20
> -#define TP_DATA			0x24
> -
> -/* TP_CTRL0 bits */
> -#define ADC_FIRST_DLY(x)	((x) << 24) /* 8 bits */
> -#define ADC_FIRST_DLY_MODE(x)	((x) << 23)
> -#define ADC_CLK_SEL(x)		((x) << 22)
> -#define ADC_CLK_DIV(x)		((x) << 20) /* 3 bits */
> -#define FS_DIV(x)		((x) << 16) /* 4 bits */
> -#define T_ACQ(x)		((x) << 0) /* 16 bits */
> -
> -/* TP_CTRL1 bits */
> -#define STYLUS_UP_DEBOUN(x)	((x) << 12) /* 8 bits */
> -#define STYLUS_UP_DEBOUN_EN(x)	((x) << 9)
> -#define TOUCH_PAN_CALI_EN(x)	((x) << 6)
> -#define TP_DUAL_EN(x)		((x) << 5)
> -#define TP_MODE_EN(x)		((x) << 4)
> -#define TP_ADC_SELECT(x)	((x) << 3)
> -#define ADC_CHAN_SELECT(x)	((x) << 0)  /* 3 bits */
> -
> -/* on sun6i, bits 3~6 are left shifted by 1 to 4~7 */
> -#define SUN6I_TP_MODE_EN(x)	((x) << 5)
> -
> -/* TP_CTRL2 bits */
> -#define TP_SENSITIVE_ADJUST(x)	((x) << 28) /* 4 bits */
> -#define TP_MODE_SELECT(x)	((x) << 26) /* 2 bits */
> -#define PRE_MEA_EN(x)		((x) << 24)
> -#define PRE_MEA_THRE_CNT(x)	((x) << 0) /* 24 bits */
> -
> -/* TP_CTRL3 bits */
> -#define FILTER_EN(x)		((x) << 2)
> -#define FILTER_TYPE(x)		((x) << 0)  /* 2 bits */
> -
> -/* TP_INT_FIFOC irq and fifo mask / control bits */
> -#define TEMP_IRQ_EN(x)		((x) << 18)
> -#define OVERRUN_IRQ_EN(x)	((x) << 17)
> -#define DATA_IRQ_EN(x)		((x) << 16)
> -#define TP_DATA_XY_CHANGE(x)	((x) << 13)
> -#define FIFO_TRIG(x)		((x) << 8)  /* 5 bits */
> -#define DATA_DRQ_EN(x)		((x) << 7)
> -#define FIFO_FLUSH(x)		((x) << 4)
> -#define TP_UP_IRQ_EN(x)		((x) << 1)
> -#define TP_DOWN_IRQ_EN(x)	((x) << 0)
> -
> -/* TP_INT_FIFOS irq and fifo status bits */
> -#define TEMP_DATA_PENDING	BIT(18)
> -#define FIFO_OVERRUN_PENDING	BIT(17)
> -#define FIFO_DATA_PENDING	BIT(16)
> -#define TP_IDLE_FLG		BIT(2)
> -#define TP_UP_PENDING		BIT(1)
> -#define TP_DOWN_PENDING		BIT(0)
> -
> -/* TP_TPR bits */
> -#define TEMP_ENABLE(x)		((x) << 16)
> -#define TEMP_PERIOD(x)		((x) << 0)  /* t =3D x * 256 * 16 / clkin */
> -
> -struct sun4i_ts_data {
> -	struct device *dev;
> -	struct input_dev *input;
> -	void __iomem *base;
> -	unsigned int irq;
> -	bool ignore_fifo_data;
> -	int temp_data;
> -	int temp_offset;
> -	int temp_step;
> -};
> -
> -static void sun4i_ts_irq_handle_input(struct sun4i_ts_data *ts, u32 reg_=
val)
> -{
> -	u32 x, y;
> -
> -	if (reg_val & FIFO_DATA_PENDING) {
> -		x =3D readl(ts->base + TP_DATA);
> -		y =3D readl(ts->base + TP_DATA);
> -		/* The 1st location reported after an up event is unreliable */
> -		if (!ts->ignore_fifo_data) {
> -			input_report_abs(ts->input, ABS_X, x);
> -			input_report_abs(ts->input, ABS_Y, y);
> -			/*
> -			 * The hardware has a separate down status bit, but
> -			 * that gets set before we get the first location,
> -			 * resulting in reporting a click on the old location.
> -			 */
> -			input_report_key(ts->input, BTN_TOUCH, 1);
> -			input_sync(ts->input);
> -		} else {
> -			ts->ignore_fifo_data =3D false;
> -		}
> -	}
> -
> -	if (reg_val & TP_UP_PENDING) {
> -		ts->ignore_fifo_data =3D true;
> -		input_report_key(ts->input, BTN_TOUCH, 0);
> -		input_sync(ts->input);
> -	}
> -}
> -
> -static irqreturn_t sun4i_ts_irq(int irq, void *dev_id)
> -{
> -	struct sun4i_ts_data *ts =3D dev_id;
> -	u32 reg_val;
> -
> -	reg_val  =3D readl(ts->base + TP_INT_FIFOS);
> -
> -	if (reg_val & TEMP_DATA_PENDING)
> -		ts->temp_data =3D readl(ts->base + TEMP_DATA);
> -
> -	if (ts->input)
> -		sun4i_ts_irq_handle_input(ts, reg_val);
> -
> -	writel(reg_val, ts->base + TP_INT_FIFOS);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static int sun4i_ts_open(struct input_dev *dev)
> -{
> -	struct sun4i_ts_data *ts =3D input_get_drvdata(dev);
> -
> -	/* Flush, set trig level to 1, enable temp, data and up irqs */
> -	writel(TEMP_IRQ_EN(1) | DATA_IRQ_EN(1) | FIFO_TRIG(1) | FIFO_FLUSH(1) |
> -		TP_UP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
> -
> -	return 0;
> -}
> -
> -static void sun4i_ts_close(struct input_dev *dev)
> -{
> -	struct sun4i_ts_data *ts =3D input_get_drvdata(dev);
> -
> -	/* Deactivate all input IRQs */
> -	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
> -}
> -
> -static int sun4i_get_temp(const struct sun4i_ts_data *ts, int *temp)
> -{
> -	/* No temp_data until the first irq */
> -	if (ts->temp_data =3D=3D -1)
> -		return -EAGAIN;
> -
> -	*temp =3D ts->temp_data * ts->temp_step - ts->temp_offset;
> -
> -	return 0;
> -}
> -
> -static int sun4i_get_tz_temp(void *data, int *temp)
> -{
> -	return sun4i_get_temp(data, temp);
> -}
> -
> -static struct thermal_zone_of_device_ops sun4i_ts_tz_ops =3D {
> -	.get_temp =3D sun4i_get_tz_temp,
> -};
> -
> -static ssize_t show_temp(struct device *dev, struct device_attribute *de=
vattr,
> -			 char *buf)
> -{
> -	struct sun4i_ts_data *ts =3D dev_get_drvdata(dev);
> -	int temp;
> -	int error;
> -
> -	error =3D sun4i_get_temp(ts, &temp);
> -	if (error)
> -		return error;
> -
> -	return sprintf(buf, "%d\n", temp);
> -}
> -
> -static ssize_t show_temp_label(struct device *dev,
> -			      struct device_attribute *devattr, char *buf)
> -{
> -	return sprintf(buf, "SoC temperature\n");
> -}
> -
> -static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
> -static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);
> -
> -static struct attribute *sun4i_ts_attrs[] =3D {
> -	&dev_attr_temp1_input.attr,
> -	&dev_attr_temp1_label.attr,
> -	NULL
> -};
> -ATTRIBUTE_GROUPS(sun4i_ts);
> -
> -static int sun4i_ts_probe(struct platform_device *pdev)
> -{
> -	struct sun4i_ts_data *ts;
> -	struct device *dev =3D &pdev->dev;
> -	struct device_node *np =3D dev->of_node;
> -	struct device *hwmon;
> -	int error;
> -	u32 reg;
> -	bool ts_attached;
> -	u32 tp_sensitive_adjust =3D 15;
> -	u32 filter_type =3D 1;
> -
> -	ts =3D devm_kzalloc(dev, sizeof(struct sun4i_ts_data), GFP_KERNEL);
> -	if (!ts)
> -		return -ENOMEM;
> -
> -	ts->dev =3D dev;
> -	ts->ignore_fifo_data =3D true;
> -	ts->temp_data =3D -1;
> -	if (of_device_is_compatible(np, "allwinner,sun6i-a31-ts")) {
> -		/* Allwinner SDK has temperature (C) =3D (value / 6) - 271 */
> -		ts->temp_offset =3D 271000;
> -		ts->temp_step =3D 167;
> -	} else if (of_device_is_compatible(np, "allwinner,sun4i-a10-ts")) {
> -		/*
> -		 * The A10 temperature sensor has quite a wide spread, these
> -		 * parameters are based on the averaging of the calibration
> -		 * results of 4 completely different boards, with a spread of
> -		 * temp_step from 0.096 - 0.170 and temp_offset from 176 - 331.
> -		 */
> -		ts->temp_offset =3D 257000;
> -		ts->temp_step =3D 133;
> -	} else {
> -		/*
> -		 * The user manuals do not contain the formula for calculating
> -		 * the temperature. The formula used here is from the AXP209,
> -		 * which is designed by X-Powers, an affiliate of Allwinner:
> -		 *
> -		 *     temperature (C) =3D (value * 0.1) - 144.7
> -		 *
> -		 * Allwinner does not have any documentation whatsoever for
> -		 * this hardware. Moreover, it is claimed that the sensor
> -		 * is inaccurate and cannot work properly.
> -		 */
> -		ts->temp_offset =3D 144700;
> -		ts->temp_step =3D 100;
> -	}
> -
> -	ts_attached =3D of_property_read_bool(np, "allwinner,ts-attached");
> -	if (ts_attached) {
> -		ts->input =3D devm_input_allocate_device(dev);
> -		if (!ts->input)
> -			return -ENOMEM;
> -
> -		ts->input->name =3D pdev->name;
> -		ts->input->phys =3D "sun4i_ts/input0";
> -		ts->input->open =3D sun4i_ts_open;
> -		ts->input->close =3D sun4i_ts_close;
> -		ts->input->id.bustype =3D BUS_HOST;
> -		ts->input->id.vendor =3D 0x0001;
> -		ts->input->id.product =3D 0x0001;
> -		ts->input->id.version =3D 0x0100;
> -		ts->input->evbit[0] =3D  BIT(EV_SYN) | BIT(EV_KEY) | BIT(EV_ABS);
> -		__set_bit(BTN_TOUCH, ts->input->keybit);
> -		input_set_abs_params(ts->input, ABS_X, 0, 4095, 0, 0);
> -		input_set_abs_params(ts->input, ABS_Y, 0, 4095, 0, 0);
> -		input_set_drvdata(ts->input, ts);
> -	}
> -
> -	ts->base =3D devm_ioremap_resource(dev,
> -			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> -	if (IS_ERR(ts->base))
> -		return PTR_ERR(ts->base);
> -
> -	ts->irq =3D platform_get_irq(pdev, 0);
> -	error =3D devm_request_irq(dev, ts->irq, sun4i_ts_irq, 0, "sun4i-ts", t=
s);
> -	if (error)
> -		return error;
> -
> -	/*
> -	 * Select HOSC clk, clkin =3D clk / 6, adc samplefreq =3D clkin / 8192,
> -	 * t_acq =3D clkin / (16 * 64)
> -	 */
> -	writel(ADC_CLK_SEL(0) | ADC_CLK_DIV(2) | FS_DIV(7) | T_ACQ(63),
> -	       ts->base + TP_CTRL0);
> -
> -	/*
> -	 * tp_sensitive_adjust is an optional property
> -	 * tp_mode =3D 0 : only x and y coordinates, as we don't use dual touch
> -	 */
> -	of_property_read_u32(np, "allwinner,tp-sensitive-adjust",
> -			     &tp_sensitive_adjust);
> -	writel(TP_SENSITIVE_ADJUST(tp_sensitive_adjust) | TP_MODE_SELECT(0),
> -	       ts->base + TP_CTRL2);
> -
> -	/*
> -	 * Enable median and averaging filter, optional property for
> -	 * filter type.
> -	 */
> -	of_property_read_u32(np, "allwinner,filter-type", &filter_type);
> -	writel(FILTER_EN(1) | FILTER_TYPE(filter_type), ts->base + TP_CTRL3);
> -
> -	/* Enable temperature measurement, period 1953 (2 seconds) */
> -	writel(TEMP_ENABLE(1) | TEMP_PERIOD(1953), ts->base + TP_TPR);
> -
> -	/*
> -	 * Set stylus up debounce to aprox 10 ms, enable debounce, and
> -	 * finally enable tp mode.
> -	 */
> -	reg =3D STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1);
> -	if (of_device_is_compatible(np, "allwinner,sun6i-a31-ts"))
> -		reg |=3D SUN6I_TP_MODE_EN(1);
> -	else
> -		reg |=3D TP_MODE_EN(1);
> -	writel(reg, ts->base + TP_CTRL1);
> -
> -	/*
> -	 * The thermal core does not register hwmon devices for DT-based
> -	 * thermal zone sensors, such as this one.
> -	 */
> -	hwmon =3D devm_hwmon_device_register_with_groups(ts->dev, "sun4i_ts",
> -						       ts, sun4i_ts_groups);
> -	if (IS_ERR(hwmon))
> -		return PTR_ERR(hwmon);
> -
> -	devm_thermal_zone_of_sensor_register(ts->dev, 0, ts, &sun4i_ts_tz_ops);
> -
> -	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
> -
> -	if (ts_attached) {
> -		error =3D input_register_device(ts->input);
> -		if (error) {
> -			writel(0, ts->base + TP_INT_FIFOC);
> -			return error;
> -		}
> -	}
> -
> -	platform_set_drvdata(pdev, ts);
> -	return 0;
> -}
> -
> -static int sun4i_ts_remove(struct platform_device *pdev)
> -{
> -	struct sun4i_ts_data *ts =3D platform_get_drvdata(pdev);
> -
> -	/* Explicit unregister to avoid open/close changing the imask later */
> -	if (ts->input)
> -		input_unregister_device(ts->input);
> -
> -	/* Deactivate all IRQs */
> -	writel(0, ts->base + TP_INT_FIFOC);
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id sun4i_ts_of_match[] =3D {
> -	{ .compatible =3D "allwinner,sun4i-a10-ts", },
> -	{ .compatible =3D "allwinner,sun5i-a13-ts", },
> -	{ .compatible =3D "allwinner,sun6i-a31-ts", },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, sun4i_ts_of_match);
> -
> -static struct platform_driver sun4i_ts_driver =3D {
> -	.driver =3D {
> -		.name	=3D "sun4i-ts",
> -		.of_match_table =3D of_match_ptr(sun4i_ts_of_match),
> -	},
> -	.probe	=3D sun4i_ts_probe,
> -	.remove	=3D sun4i_ts_remove,
> -};
> -
> -module_platform_driver(sun4i_ts_driver);
> -
> -MODULE_DESCRIPTION("Allwinner sun4i resistive touchscreen controller dri=
ver");
> -MODULE_AUTHOR("Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/input/touchscreen/sunxi-gpadc-ts.c b/drivers/input/t=
ouchscreen/sunxi-gpadc-ts.c
> new file mode 100644
> index 0000000..410d14f
> --- /dev/null
> +++ b/drivers/input/touchscreen/sunxi-gpadc-ts.c
> @@ -0,0 +1,195 @@
> +/* Touchscreen driver for Allwinner SoCs (A10, A13, A31) GPADC
> + *
> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it under
> + * the terms of the GNU General Public License version 2 as published by=
 the
> + * Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/consumer.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +
> +struct sunxi_gpadc_ts {
> +	struct iio_cb_buffer	*buffer;
> +	struct input_dev	*input;
> +	struct platform_device	*pdev;
> +	unsigned int		tp_up_irq;
> +	bool			ignore_fifo_data;
> +};
> +
> +static int sunxi_gpadc_ts_open(struct input_dev *dev)
> +{
> +	struct sunxi_gpadc_ts *info =3D input_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D iio_channel_start_all_cb(info->buffer);
> +	if (ret) {
> +		dev_err(dev->dev.parent,
> +			"failed to start iio channels with callback\n");
> +		return ret;
> +	}
> +
> +	enable_irq(info->tp_up_irq);
> +
> +	return 0;
> +}
> +
> +static void sunxi_gpadc_ts_close(struct input_dev *dev)
> +{
> +	struct sunxi_gpadc_ts *info =3D input_get_drvdata(dev);
> +
> +	iio_channel_stop_all_cb(info->buffer);
> +
> +	disable_irq(info->tp_up_irq);
> +}
> +
> +/*
> + * This function will be called by iio_push_to_buffers from another driv=
er
> + * (namely sunxi-gpadc-iio).

This can change in the future, please just mention the ADC driver.

> It will be passed the buffer filled with input
> + * values (X value then Y value) and the sunxi_gpadc_ts structure repres=
enting
> + * the device.
> + */
> +static int sunxi_gpadc_ts_callback(const void *data, void *private)
> +{
> +	const struct sunxi_gpadc_buffer *buffer =3D data;
> +	struct sunxi_gpadc_ts *info =3D private;
> +	int i =3D 0;
> +
> +	/* Locations in the first buffer after an up event are unreliable */
> +	if (info->ignore_fifo_data) {
> +		info->ignore_fifo_data =3D false;
> +		return 0;
> +	}
> +
> +	while (i + 1 < buffer->buff_size) {

So.... for (i =3D 0; i < buffer->buff_size; i +=3D 2) { ?

> +		input_event(info->input, EV_ABS, ABS_X, buffer->buffer[i++]);
> +		input_event(info->input, EV_ABS, ABS_Y, buffer->buffer[i++]);

Using i and i + 1 as indinces here.

> +		input_event(info->input, EV_KEY, BTN_TOUCH, 1);
> +		input_sync(info->input);
> +	}

Why do you need an additional buffer compared to IIO's ?

This intertwined layout between X and Y would is rather complicated,
and would be better expressed with a structure with both
fields. Especially since X and Y are sampled at the same time.

> +
> +	return 0;
> +}
> +
> +static irqreturn_t sunxi_gpadc_tp_up_irq_handler(int irq, void *dev_id)
> +{
> +	struct sunxi_gpadc_ts *info =3D dev_id;
> +
> +	info->ignore_fifo_data =3D true;
> +
> +	input_event(info->input, EV_KEY, BTN_TOUCH, 0);
> +	input_sync(info->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sunxi_gpadc_ts_probe(struct platform_device *pdev)
> +{
> +	struct input_dev *input;
> +	struct sunxi_gpadc_ts *info;
> +	int ret, irq;
> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev;
> +
> +	input =3D devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->buffer =3D iio_channel_get_all_cb(&pdev->dev,
> +					      &sunxi_gpadc_ts_callback,
> +					      (void *)info);
> +	if (IS_ERR(info->buffer)) {
> +		if (PTR_ERR(info->buffer) =3D=3D -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(info->buffer);
> +	}
> +
> +	info->pdev =3D pdev;
> +	info->input =3D input;
> +	info->ignore_fifo_data =3D false;
> +	platform_set_drvdata(pdev, info);
> +
> +	input->dev.parent =3D &pdev->dev;
> +	input->name =3D "sunxi-gpadc-ts";
> +	input->id.bustype =3D BUS_HOST;
> +	input->open =3D sunxi_gpadc_ts_open;
> +	input->close =3D sunxi_gpadc_ts_close;
> +	__set_bit(EV_SYN, input->evbit);
> +	input_set_capability(input, EV_KEY, BTN_TOUCH);
> +	input_set_abs_params(input, ABS_X, 0, 4095, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, 4095, 0, 0);

Shouldn't the max be the screen pixel size here?

> +	input_set_drvdata(input, info);
> +
> +	irq =3D platform_get_irq_byname(pdev, "TP_UP_PENDING");
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no TP_UP_PENDING interrupt registered\n");
> +		ret =3D irq;
> +		goto err;
> +	}
> +
> +	sunxi_gpadc_mfd_dev =3D dev_get_drvdata(pdev->dev.parent);
> +
> +	irq =3D regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +					   sunxi_gpadc_tp_up_irq_handler, 0,
> +					   "tp_up", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request TP_UP_PENDING interrupt: %d\n", ret);
> +		goto err;
> +	}

You enable the interrupts...

> +	info->tp_up_irq =3D irq;
> +	disable_irq(irq);
> +
> +	ret =3D input_register_device(input);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		goto err;
> +	}

=2E.. but your driver isn't registered yet. How does input_report and
input_sync behave in such a case?

> +	return 0;
> +
> +err:
> +	iio_channel_release_all_cb(info->buffer);
> +
> +	return ret;
> +}
> +
> +static int sunxi_gpadc_ts_remove(struct platform_device *pdev)
> +{
> +	struct sunxi_gpadc_ts *info =3D platform_get_drvdata(pdev);
> +
> +	iio_channel_stop_all_cb(info->buffer);
> +	iio_channel_release_all_cb(info->buffer);
> +
> +	disable_irq(info->tp_up_irq);
> +
> +	return 0;
> +}

I would expect your close function to have been called already when
you're there. Which would lead to two calls to iio_channel_stop_all_cb
and disable_irq.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkGveAAoJEBx+YmzsjxAg0lMP/2j2WMT8LNqAbbvVWQ7so5Av
E5kuuFdnezuLsVjg6Shric3jCJpGhXSnofhVTFxWvbZI1XiB/FPUTHjuW6JQ0bzD
odZnrffstCupeEVk9PUgVN7CUCtLR1HzdMtZGdxx1DkC1M5OC3px1kdkBQQSbR/v
g96s1BX6Dn148i+PhEY3MVs5m4De0PK0k38ioYKmVUy7TUwidDFqlOni2OyCHXrz
JcR1MORrZQBWYXmFEUnTwKt00WJPa3mylNO3rrd062safKycOj98LI2UmdBnpGtd
YwD7/ovu5CixTz93z9Xbwgb9VrCkJR2oI/e9BS3Kp8TsTnIrY8BXS3kreDqxOaQL
v60TvljomgywyEK/K4yt2Uaas+dIWXxsSCmPtPrDGLqBPAaQOlc5+LQq5Q+rTVOa
LFEe306XUeaAzlkq/VeiwFfDNbiBdVa4gxBE9Tt8lZgNCnki8cQ+jW5ee6ltdtPb
NQX7k74vwaX+EeaSAmDlDtlMVVzmtnpOmCK4RDtzD3i/1rQKj8KKkdpvjQ+mZJoq
UVIQQwMQ/161rHnFhHSprBc2p/wpBS7Lj0qyORtQ0LUO3OUNqW+QJbwyZ5fCIsKY
e1ExyUS02c/IWscO+uYhRTN2EAFugb1Xy0OzqwMlvi9yAa3WgqjtVoWQVo4b+rfA
c1I8DzyJXrRSVmPn+17O
=AWoP
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
