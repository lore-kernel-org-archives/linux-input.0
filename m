From: "Chris Verges" <chrisv@cyberswitching.com>
Subject: [PATCH 1/1] linux-2.6.32-tsc2008.patch
Date: Wed, 20 Jan 2010 11:39:58 -0800
Message-ID: <68FBE0F3CE97264395875AC1C468F22C220789@mail03.cyberswitching.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01CA9A08.5C506042"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from p01c12o141.mxlogic.net ([208.65.145.64]:42868 "EHLO
	p01c12o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab0ATTsN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 14:48:13 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA9A08.5C506042
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry and fellow input driver developers,

Attached is an updated driver for the tsc2008.  This new driver
completely replaces older versions, and has been confirmed to work on
actual hardware.  The TSC2008 is an SPI touchscreen controller produced
by Texas Instruments.

An example of integrating this driver into board-sam9263ek board is
below.  Note that only the sections relevant to the tsc2008 driver are
included.

   #include "linux/spi/tsc2008.h"

   #if defined (CONFIG_TOUCHSCREEN_TSC2008)
   static int tsc2008_pendown_state(void)
   {
      return !at91_get_gpio_value(AT91_PIN_PA15);
   }

   static struct tsc2008_platform_data tsc2008_info =3D {
      .x_plate_ohms        =3D 450,
      .bit_mode            =3D 8,
      .get_pendown_state   =3D tsc2008_pendown_state,
      .clear_penirq        =3D NULL,
      .init_platform_hw    =3D NULL,
      .exit_platform_hw    =3D NULL,
   };

   static void __init ek_add_device_ts(void)
   {
      at91_set_B_periph(AT91_PIN_PA15, 1);
      at91_set_gpio_input(AT91_PIN_PA31, 1);
   }
   #else
   static void __init ek_add_device_ts(void) {}
   #endif

   static struct spi_board_info ek_spi_devices[] =3D {
   # if defined(CONFIG_TOUCHSCREEN_TSC2008)
      {
         .modalias       =3D "tsc2008",
         .bus_num        =3D 1,
         .chip_select    =3D 1,
         .max_speed_hz   =3D 25000000,
         .platform_data  =3D &tsc2008_info,
         .irq            =3D AT91SAM9263_ID_IRQ1,
      },
   #endif
   }

   static void __init ek_board_init(void)
   {
      ek_add_device_ts();
   }

Please review, provide feedback, and consider the driver for inclusion
in the upstream.

Thanks,
Chris

------ PATCH BELOW ------

Signed-off-by: Chris Verges <chrisv@cyberswitching.com>

Index: include/linux/spi/tsc2008.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/spi/tsc2008.h	(.../tags/linux-2.6.32.1)
(revision 0)
+++ b/include/linux/spi/tsc2008.h
(.../branches/at91sam9263cs-2.6.32.1)	(revision 184)
@@ -0,0 +1,18 @@
+#ifndef __LINUX_SPI_TSC2008_H
+#define __LINUX_SPI_TSC2008_H
+
+/* linux/spi/tsc2008.h */
+
+struct tsc2008_platform_data {
+	u16	model;				/* 2008. */
+	u16	x_plate_ohms;
+	u16	bit_mode;			/* 8 (default) or 12 */
+
+	int	(*get_pendown_state)(void);
+	void	(*clear_penirq)(void);		/* If needed, clear 2nd
level
+						   interrupt source */
+	int	(*init_platform_hw)(void);
+	void	(*exit_platform_hw)(void);
+};
+
+#endif
Index: drivers/input/touchscreen/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/input/touchscreen/Kconfig	(.../tags/linux-2.6.32.1)
(revision 184)
+++ b/drivers/input/touchscreen/Kconfig
(.../branches/at91sam9263cs-2.6.32.1)	(revision 184)
@@ -512,6 +512,19 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called tsc2007.
=20
+config TOUCHSCREEN_TSC2008
+	tristate "TSC2008 based touchscreens"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a touchscreen interface using the
+	  TSC2008 controller, and your board-specific setup code
+	  includes that in its table of SPI devices.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc2008.
+
 config TOUCHSCREEN_W90X900
 	tristate "W90P910 touchscreen driver"
 	depends on HAVE_CLK
Index: drivers/input/touchscreen/tsc2008.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/input/touchscreen/tsc2008.c
(.../tags/linux-2.6.32.1)	(revision 0)
+++ b/drivers/input/touchscreen/tsc2008.c
(.../branches/at91sam9263cs-2.6.32.1)	(revision 184)
@@ -0,0 +1,519 @@
+/*
+ * drivers/input/touchscreen/tsc2008.c
+ *
+ * Copyright (c) 2010 Cyber Switching, Inc.
+ *    Chris Verges <chrisv@cyberswitching.com>
+ *    Robert Mehranfar <robertme@earthlink.net>
+ *
+ * Using code from:
+ *  - tsc2008.c
+ *      Copyright (c) 2008 MtekVision Co., Ltd.
+ *	Kwangwoo Lee <kwlee@mtekvision.com>
+ *  - ads7846.c
+ *	Copyright (c) 2005 David Brownell
+ *	Copyright (c) 2006 Nokia Corporation
+ *  - corgi_ts.c
+ *	Copyright (C) 2004-2005 Richard Purdie
+ *  - omap_ts.[hc], ads7846.h, ts_osk.c
+ *	Copyright (C) 2002 MontaVista Software
+ *	Copyright (C) 2004 Texas Instruments
+ *	Copyright (C) 2005 Dirk Behme
+ *
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2008.h>
+
+#define TS_POLL_DELAY			1 /* ms delay between samples */
+#define TS_POLL_PERIOD			1 /* ms delay between samples */
+
+#define TSC2008_START_CMD		(0x1 << 7)
+
+#define TSC2008_MEASURE_TEMP1		(0x0 << 4)
+#define TSC2008_MEASURE_Y		(0x1 << 4)
+#define TSC2008_SETUP			(0x2 << 4)
+#define TSC2008_MEASURE_Z1		(0x3 << 4)
+#define TSC2008_MEASURE_Z2		(0x4 << 4)
+#define TSC2008_MEASURE_X		(0x5 << 4)
+#define TSC2008_MEASURE_AUX		(0x6 << 4)
+#define TSC2008_MEASURE_TEMP2		(0x7 << 4)
+
+#define TSC2008_USE_50K			(0x0 << 3)
+#define TSC2008_USE_90K			(0x1 << 3)
+
+#define TSC2008_ENABLE_MAV		(0x0 << 2)
+#define TSC2008_DISABLE_MAV		(0x1 << 2)
+
+#define TSC2008_SOFTWARE_RESET		(0x1 << 0)
+
+#define TSC2008_POWER_OFF_IRQ_EN	(0x0 << 0)
+#define TSC2008_ADC_ON_IRQ_DIS0		(0x1 << 0)
+#define TSC2008_ADC_OFF_IRQ_EN		(0x2 << 0)
+#define TSC2008_ADC_ON_IRQ_DIS1		(0x3 << 0)
+
+#define TSC2008_12BIT			(0x0 << 1)
+#define TSC2008_8BIT			(0x1 << 1)
+
+#define	MAX_12BIT			(1 << 12)
+#define MAX_8BIT			(1 << 8)
+
+#define ADC_ON_12BIT	(TSC2008_START_CMD | TSC2008_12BIT |
TSC2008_POWER_OFF_IRQ_EN)
+#define ADC_ON_8BIT	(TSC2008_START_CMD | TSC2008_8BIT |
TSC2008_POWER_OFF_IRQ_EN)
+
+/* usec, SCLK=3D25MHz w/o MAV */
+#define TX_DELAY	(40)
+#define RX_DELAY	(40)
+
+struct ts_event {
+	uint16_t	x;
+	uint16_t	y;
+	uint16_t	z1, z2;
+};
+
+struct tsc2008 {
+	struct input_dev	*input;
+	char			phys[32];
+	struct delayed_work	work;
+
+	struct spi_device	*spi;
+	struct spi_message	msg;
+	struct spi_transfer	xfer[8];
+	uint8_t			tx_buf[4];
+
+	uint16_t		model;
+	uint16_t		x_plate_ohms;
+	uint16_t		max_bits;
+
+	bool			pendown;
+	int			irq;
+
+	int			(*get_pendown_state)(void);
+	void			(*clear_penirq)(void);
+};
+
+static void tsc2008_read_values(struct tsc2008 *tsc, struct ts_event
*tc)
+{
+	/* Read the values from the TSC2008 */
+	tsc->xfer[1].rx_buf =3D &tc->x;
+	tsc->xfer[3].rx_buf =3D &tc->y;
+	tsc->xfer[5].rx_buf =3D &tc->z1;
+	tsc->xfer[7].rx_buf =3D &tc->z2;
+
+	spi_sync(tsc->spi, &tsc->msg);
+
+	dev_dbg(&tsc->spi->dev, "data: x  %05u 0x%08x\n", tc->x, tc->x);
+	dev_dbg(&tsc->spi->dev, "data: y  %05u 0x%08x\n", tc->y, tc->y);
+	dev_dbg(&tsc->spi->dev, "data: z1 %05u 0x%08x\n", tc->z1,
tc->z1);
+	dev_dbg(&tsc->spi->dev, "data: z2 %05u 0x%08x\n", tc->z2,
tc->z2);
+
+	if (tsc->max_bits =3D=3D MAX_8BIT) {
+		tc->x  =3D (tc->x  << 1) & 0x00FF;
+		tc->y  =3D (tc->y  << 1) & 0x00FF;
+		tc->z1 =3D (tc->z1 << 1) & 0x00FF;
+		tc->z2 =3D (tc->z2 << 1) & 0x00FF;
+	} else if (tsc->max_bits =3D=3D MAX_12BIT) {
+		tc->x  =3D (be16_to_cpu(tc->x)  << 1) >> 4 & 0x0FFF;
+		tc->y  =3D (be16_to_cpu(tc->y)  << 1) >> 4 & 0x0FFF;
+		tc->z1 =3D (be16_to_cpu(tc->z1) << 1) >> 4 & 0x0FFF;
+		tc->z2 =3D (be16_to_cpu(tc->z2) << 1) >> 4 & 0x0FFF;
+	} else {
+		dev_err(&tsc->spi->dev, "invalid number of bits
expected\n");
+	}
+
+	dev_dbg(&tsc->spi->dev, "data: x  %05u 0x%08x\n", tc->x, tc->x);
+	dev_dbg(&tsc->spi->dev, "data: y  %05u 0x%08x\n", tc->y, tc->y);
+	dev_dbg(&tsc->spi->dev, "data: z1 %05u 0x%08x\n", tc->z1,
tc->z1);
+	dev_dbg(&tsc->spi->dev, "data: z2 %05u 0x%08x\n", tc->z2,
tc->z2);
+}
+
+static uint32_t tsc2008_calculate_pressure(struct tsc2008 *tsc, struct
ts_event *tc)
+{
+	uint32_t rt =3D 0;
+
+	/* range filtering */
+	if (tc->x =3D=3D (tsc->max_bits - 1))
+		tc->x =3D 0;
+
+	if (likely(tc->x && tc->z1)) {
+		rt =3D (tc->z2 / tc->z1) - 1;
+		rt *=3D tc->y * tsc->x_plate_ohms;
+		rt /=3D tsc->max_bits;
+
+		if (tsc->max_bits =3D=3D MAX_8BIT)
+			rt &=3D 0x00FF;
+		else
+			rt &=3D 0x0FFF;
+	}
+
+	dev_dbg(&tsc->spi->dev, "pressure: %05u 0x%08x\n", rt, rt);
+
+	return rt;
+}
+
+static void tsc2008_send_up_event(struct tsc2008 *tsc)
+{
+	struct input_dev *input =3D tsc->input;
+
+	dev_dbg(&tsc->spi->dev, "UP\n");
+
+	input_report_key(input, BTN_TOUCH, 0);
+	input_report_abs(input, ABS_PRESSURE, 0);
+	input_sync(input);
+}
+
+static void tsc2008_work(struct work_struct *work)
+{
+	struct tsc2008 *ts =3D
+		container_of(to_delayed_work(work), struct tsc2008,
work);
+	struct ts_event tc;
+	uint32_t rt;
+
+	/*
+	 * NOTE: We can't rely on the pressure to determine the pen down
+	 * state, even though this controller has a pressure sensor.
+	 * The pressure value can fluctuate for quite a while after
+	 * lifting the pen and in some cases may not even settle at the
+	 * expected value.
+	 *
+	 * The only safe way to check for the pen up condition is in the
+	 * work function by reading the pen signal state (it's a GPIO
+	 * and IRQ). Unfortunately such callback is not always
available,
+	 * in that case we have rely on the pressure anyway.
+	 */
+	if (ts->get_pendown_state) {
+		if (unlikely(!ts->get_pendown_state())) {
+			dev_dbg(&ts->spi->dev, "detected pen UP via GPIO
read\n");
+
+			tsc2008_send_up_event(ts);
+			ts->pendown =3D false;
+			goto out;
+		}
+
+		dev_dbg(&ts->spi->dev, "pen is still down\n");
+	} else {
+		dev_dbg(&ts->spi->dev, "get_pendown_state undefined, "
+				"using pressure instead\n");
+	}
+
+	tsc2008_read_values(ts, &tc);
+
+	rt =3D tsc2008_calculate_pressure(ts, &tc);
+	if (rt >=3D ts->max_bits) {
+		/*
+		 * Sample found inconsistent by debouncing or pressure
is
+		 * beyond the maximum. Don't report it to user space,
+		 * repeat at least once more the measurement.
+		 */
+		dev_dbg(&ts->spi->dev, "ignored pressure %d\n", rt);
+		goto out;
+	}
+
+	if (rt) {
+		struct input_dev *input =3D ts->input;
+
+		if (!ts->pendown) {
+			dev_dbg(&ts->spi->dev, "DOWN\n");
+
+			input_report_key(input, BTN_TOUCH, 1);
+			ts->pendown =3D true;
+		}
+
+		input_report_abs(input, ABS_X, tc.x);
+		input_report_abs(input, ABS_Y, tc.y);
+		input_report_abs(input, ABS_PRESSURE, rt);
+
+		input_sync(input);
+
+		dev_dbg(&ts->spi->dev, "point(%4d,%4d), pressure
(%4u)\n",
+			tc.x, tc.y, rt);
+	} else if (!ts->get_pendown_state && ts->pendown) {
+		/*
+		 * We don't have callback to check pendown state, so we
+		 * have to assume that since pressure reported is 0 the
+		 * pen was lifted up.
+		 */
+		tsc2008_send_up_event(ts);
+		ts->pendown =3D false;
+	} else {
+		dev_dbg(&ts->spi->dev, "no change in pen state
detected\n");
+	}
+
+ out:
+	if (ts->pendown)
+		schedule_delayed_work(&ts->work,
+				      msecs_to_jiffies(TS_POLL_PERIOD));
+	else
+		enable_irq(ts->irq);
+}
+
+static irqreturn_t tsc2008_irq(int irq, void *handle)
+{
+	struct tsc2008 *ts =3D handle;
+
+	if (!ts->get_pendown_state || likely(ts->get_pendown_state())) {
+		disable_irq_nosync(ts->irq);
+		schedule_delayed_work(&ts->work,
+				      msecs_to_jiffies(TS_POLL_DELAY));
+	}
+
+	if (ts->clear_penirq)
+		ts->clear_penirq();
+
+	return IRQ_HANDLED;
+}
+
+static void tsc2008_free_irq(struct tsc2008 *ts)
+{
+	free_irq(ts->irq, ts);
+	if (cancel_delayed_work_sync(&ts->work)) {
+		/*
+		 * Work was pending, therefore we need to enable
+		 * IRQ here to balance the disable_irq() done in the
+		 * interrupt handler.
+		 */
+		enable_irq(ts->irq);
+	}
+}
+
+static int __devinit tsc2008_probe(struct spi_device *spi)
+{
+	struct tsc2008 *ts;
+	struct tsc2008_platform_data *pdata =3D spi->dev.platform_data;
+	struct input_dev *input_dev;
+	struct spi_transfer *x;
+	uint8_t tx_buf;
+	int num_bytes_rx;
+	int err;
+
+	if (!pdata) {
+		dev_err(&spi->dev, "platform data is required!\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->get_pendown_state) {
+		dev_err(&spi->dev, "pendown function is required!\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->bit_mode) {
+		dev_dbg(&spi->dev, "bit mode not specified, using 8-bit
mode\n");
+		pdata->bit_mode =3D 8;
+	} else if (pdata->bit_mode !=3D 8 && pdata->bit_mode !=3D 12) {
+		dev_err(&spi->dev, "invalid bit mode specified, 8-bit or
12-bit expected\n");
+		return -EINVAL;
+	}
+
+	err =3D spi_setup(spi);
+	if (err) {
+		dev_err(&spi->dev, "unable to initialize spi\n");
+		return -ENODEV;
+	}
+
+	ts =3D kzalloc(sizeof(struct tsc2008), GFP_KERNEL);
+	input_dev =3D input_allocate_device();
+	if (!ts || !input_dev) {
+		err =3D -ENOMEM;
+		goto err_free_mem;
+	}
+
+	dev_set_drvdata(&spi->dev, ts);
+	ts->spi =3D spi;
+	ts->irq =3D spi->irq;
+	ts->input =3D input_dev;
+	INIT_DELAYED_WORK(&ts->work, tsc2008_work);
+
+	ts->model             =3D pdata->model;
+	ts->x_plate_ohms      =3D pdata->x_plate_ohms;
+	ts->max_bits          =3D 1 << pdata->bit_mode;	/* Match either
MAX_8BIT or MAX_12BIT */
+	ts->get_pendown_state =3D pdata->get_pendown_state;
+	ts->clear_penirq      =3D pdata->clear_penirq;
+
+	snprintf(ts->phys, sizeof(ts->phys),
+		 "%s/input0", dev_name(&spi->dev));
+
+	input_dev->name =3D "TSC2008 Touchscreen";
+	input_dev->dev.parent =3D &spi->dev;
+	input_dev->phys =3D ts->phys;
+
+	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input_dev, ABS_X, 0, ts->max_bits, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, ts->max_bits, 0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, ts->max_bits,
0, 0);
+
+	if (pdata->init_platform_hw)
+		pdata->init_platform_hw();
+
+	err =3D request_irq(ts->irq, tsc2008_irq, 0,
+			spi->dev.driver->name, ts);
+	if (err < 0) {
+		dev_err(&spi->dev, "irq %d busy?\n", ts->irq);
+		goto err_free_mem;
+	}
+
+	/* Setup SPI variables */
+	spi_message_init(&ts->msg);
+
+	/*
+	 * TSC2008_MEASURE_X and TSC2008_MEASURE_Y are intentionally
+	 * swapped below.
+	 */
+	if (ts->max_bits =3D=3D MAX_8BIT) {
+		dev_dbg(&spi->dev, "using 8-bit mode\n");
+		num_bytes_rx =3D 1;
+		ts->tx_buf[0] =3D ADC_ON_8BIT | TSC2008_MEASURE_Y;
+		ts->tx_buf[1] =3D ADC_ON_8BIT | TSC2008_MEASURE_X;
+		ts->tx_buf[2] =3D ADC_ON_8BIT | TSC2008_MEASURE_Z1;
+		ts->tx_buf[3] =3D ADC_ON_8BIT | TSC2008_MEASURE_Z2;
+	} else {
+		dev_dbg(&spi->dev, "using 12-bit mode\n");
+		num_bytes_rx =3D 2;
+		ts->tx_buf[0] =3D ADC_ON_12BIT | TSC2008_MEASURE_Y;
+		ts->tx_buf[1] =3D ADC_ON_12BIT | TSC2008_MEASURE_X;
+		ts->tx_buf[2] =3D ADC_ON_12BIT | TSC2008_MEASURE_Z1;
+		ts->tx_buf[3] =3D ADC_ON_12BIT | TSC2008_MEASURE_Z2;
+	}
+
+	x =3D &ts->xfer[0];
+	memset(x, 0, sizeof(*x));
+	x->tx_buf =3D &ts->tx_buf[0];
+	x->len =3D 1;
+	x->delay_usecs =3D TX_DELAY;
+	spi_message_add_tail(x, &ts->msg);
+
+	x =3D &ts->xfer[1];
+	memset(x, 0, sizeof(*x));
+	x->len =3D num_bytes_rx;
+	x->delay_usecs =3D RX_DELAY;
+	spi_message_add_tail(x, &ts->msg);
+
+	x =3D &ts->xfer[2];
+	memset(x, 0, sizeof(*x));
+	x->tx_buf =3D &ts->tx_buf[1];
+	x->len =3D 1;
+	x->delay_usecs =3D TX_DELAY;
+	spi_message_add_tail(x, &ts->msg);
+
+	x =3D &ts->xfer[3];
+	memset(x, 0, sizeof(*x));
+	x->len =3D num_bytes_rx;
+	x->delay_usecs =3D RX_DELAY;
+	spi_message_add_tail(x, &ts->msg);
+
+	x =3D &ts->xfer[4];
+	memset(x, 0, sizeof(*x));
+	x->tx_buf =3D &ts->tx_buf[2];
+	x->len =3D 1;
+	x->delay_usecs =3D TX_DELAY;
+	spi_message_add_tail(x, &ts->msg);
+
+	x =3D &ts->xfer[5];
+	memset(x, 0, sizeof(*x));
+	x->len =3D num_bytes_rx;
+	x->delay_usecs =3D RX_DELAY;
+	spi_message_add_tail(x, &ts->msg);
+
+	x =3D &ts->xfer[6];
+	memset(x, 0, sizeof(*x));
+	x->tx_buf =3D &ts->tx_buf[3];
+	x->len =3D 1;
+	x->delay_usecs =3D TX_DELAY;
+	spi_message_add_tail(x, &ts->msg);
+
+	x =3D &ts->xfer[7];
+	memset(x, 0, sizeof(*x));
+	x->len =3D num_bytes_rx;
+	spi_message_add_tail(x, &ts->msg);
+
+	/*
+	 * Reset the controller once using the sequence described
+	 * on page 29 of the TSC2008 manual (March 2009 revision)
+	 */
+	tx_buf =3D TSC2008_START_CMD
+			| TSC2008_SETUP
+			| TSC2008_SOFTWARE_RESET;
+	err =3D spi_write(spi, &tx_buf, 1);
+	if (err < 0)
+		goto err_free_irq;
+	udelay(1);
+
+	/* Configure the pull-up resistor and MAV settings */
+	tx_buf =3D TSC2008_START_CMD
+			| TSC2008_SETUP
+			| TSC2008_USE_90K
+			| TSC2008_DISABLE_MAV;
+	err =3D spi_write(spi, &tx_buf, 1);
+	if (err < 0)
+		goto err_free_irq;
+
+	/* Finish input device registration */
+	err =3D input_register_device(input_dev);
+	if (err)
+		goto err_free_irq;
+
+	return 0;
+
+ err_free_irq:
+	tsc2008_free_irq(ts);
+	if (pdata->exit_platform_hw)
+		pdata->exit_platform_hw();
+ err_free_mem:
+	input_free_device(input_dev);
+	kfree(ts);
+	return err;
+}
+
+static int __devexit tsc2008_remove(struct spi_device *spi)
+{
+	struct tsc2008 *ts =3D dev_get_drvdata(&spi->dev);
+	struct tsc2008_platform_data *pdata =3D spi->dev.platform_data;
+
+	tsc2008_free_irq(ts);
+
+	if (pdata->exit_platform_hw)
+		pdata->exit_platform_hw();
+
+	input_unregister_device(ts->input);
+	kfree(ts);
+
+	dev_dbg(&spi->dev, "unregistered touchscreen\n");
+
+	return 0;
+}
+
+static struct spi_driver tsc2008_driver =3D {
+	.driver =3D {
+		.owner	=3D THIS_MODULE,
+		.name	=3D "tsc2008",
+		.bus	=3D &spi_bus_type,
+	},
+	.probe		=3D tsc2008_probe,
+	.remove		=3D __devexit_p(tsc2008_remove),
+};
+
+static int __init tsc2008_init(void)
+{
+	return spi_register_driver(&tsc2008_driver);
+}
+
+static void __exit tsc2008_exit(void)
+{
+	spi_unregister_driver(&tsc2008_driver);
+}
+
+module_init(tsc2008_init);
+module_exit(tsc2008_exit);
+
+MODULE_AUTHOR("Chris Verges <chrisv@cyberswitching.com>, "
+		"Robert Mehranfar <robertme@earthlink.net>");
+MODULE_DESCRIPTION("TSC2008 Touchscreen Driver");
+MODULE_LICENSE("GPL");
Index: drivers/input/touchscreen/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/input/touchscreen/Makefile
(.../tags/linux-2.6.32.1)	(revision 184)
+++ b/drivers/input/touchscreen/Makefile
(.../branches/at91sam9263cs-2.6.32.1)	(revision 184)
@@ -30,6 +30,7 @@
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+=3D touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+=3D touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+=3D tsc2007.o
+obj-$(CONFIG_TOUCHSCREEN_TSC2008)	+=3D tsc2008.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+=3D ucb1400_ts.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+=3D wacom_w8001.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+=3D wm97xx-ts.o

------_=_NextPart_001_01CA9A08.5C506042
Content-Type: application/octet-stream;
	name="linux-2.6.32-tsc2008.patch"
Content-Transfer-Encoding: base64
Content-Description: linux-2.6.32-tsc2008.patch
Content-Disposition: attachment;
	filename="linux-2.6.32-tsc2008.patch"

U2lnbmVkLW9mZi1ieTogQ2hyaXMgVmVyZ2VzIDxjaHJpc3ZAY3liZXJzd2l0Y2hpbmcuY29tPgoK
SW5kZXg6IGluY2x1ZGUvbGludXgvc3BpL3RzYzIwMDguaAo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBhL2luY2x1
ZGUvbGludXgvc3BpL3RzYzIwMDguaAkoLi4uL3RhZ3MvbGludXgtMi42LjMyLjEpCShyZXZpc2lv
biAwKQorKysgYi9pbmNsdWRlL2xpbnV4L3NwaS90c2MyMDA4LmgJKC4uLi9icmFuY2hlcy9hdDkx
c2FtOTI2M2NzLTIuNi4zMi4xKQkocmV2aXNpb24gMTg0KQpAQCAtMCwwICsxLDE4IEBACisjaWZu
ZGVmIF9fTElOVVhfU1BJX1RTQzIwMDhfSAorI2RlZmluZSBfX0xJTlVYX1NQSV9UU0MyMDA4X0gK
KworLyogbGludXgvc3BpL3RzYzIwMDguaCAqLworCitzdHJ1Y3QgdHNjMjAwOF9wbGF0Zm9ybV9k
YXRhIHsKKwl1MTYJbW9kZWw7CQkJCS8qIDIwMDguICovCisJdTE2CXhfcGxhdGVfb2htczsKKwl1
MTYJYml0X21vZGU7CQkJLyogOCAoZGVmYXVsdCkgb3IgMTIgKi8KKworCWludAkoKmdldF9wZW5k
b3duX3N0YXRlKSh2b2lkKTsKKwl2b2lkCSgqY2xlYXJfcGVuaXJxKSh2b2lkKTsJCS8qIElmIG5l
ZWRlZCwgY2xlYXIgMm5kIGxldmVsCisJCQkJCQkgICBpbnRlcnJ1cHQgc291cmNlICovCisJaW50
CSgqaW5pdF9wbGF0Zm9ybV9odykodm9pZCk7CisJdm9pZAkoKmV4aXRfcGxhdGZvcm1faHcpKHZv
aWQpOworfTsKKworI2VuZGlmCkluZGV4OiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL0tjb25m
aWcKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQotLS0gYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL0tjb25maWcJKC4u
Li90YWdzL2xpbnV4LTIuNi4zMi4xKQkocmV2aXNpb24gMTg0KQorKysgYi9kcml2ZXJzL2lucHV0
L3RvdWNoc2NyZWVuL0tjb25maWcJKC4uLi9icmFuY2hlcy9hdDkxc2FtOTI2M2NzLTIuNi4zMi4x
KQkocmV2aXNpb24gMTg0KQpAQCAtNTEyLDYgKzUxMiwxOSBAQAogCSAgVG8gY29tcGlsZSB0aGlz
IGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlCiAJICBtb2R1bGUgd2lsbCBi
ZSBjYWxsZWQgdHNjMjAwNy4KIAorY29uZmlnIFRPVUNIU0NSRUVOX1RTQzIwMDgKKwl0cmlzdGF0
ZSAiVFNDMjAwOCBiYXNlZCB0b3VjaHNjcmVlbnMiCisJZGVwZW5kcyBvbiBTUElfTUFTVEVSCisJ
aGVscAorCSAgU2F5IFkgaGVyZSBpZiB5b3UgaGF2ZSBhIHRvdWNoc2NyZWVuIGludGVyZmFjZSB1
c2luZyB0aGUKKwkgIFRTQzIwMDggY29udHJvbGxlciwgYW5kIHlvdXIgYm9hcmQtc3BlY2lmaWMg
c2V0dXAgY29kZQorCSAgaW5jbHVkZXMgdGhhdCBpbiBpdHMgdGFibGUgb2YgU1BJIGRldmljZXMu
CisKKwkgIElmIHVuc3VyZSwgc2F5IE4uCisKKwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMg
YSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQorCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIHRz
YzIwMDguCisKIGNvbmZpZyBUT1VDSFNDUkVFTl9XOTBYOTAwCiAJdHJpc3RhdGUgIlc5MFA5MTAg
dG91Y2hzY3JlZW4gZHJpdmVyIgogCWRlcGVuZHMgb24gSEFWRV9DTEsKSW5kZXg6IGRyaXZlcnMv
aW5wdXQvdG91Y2hzY3JlZW4vdHNjMjAwOC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGEvZHJpdmVycy9pbnB1
dC90b3VjaHNjcmVlbi90c2MyMDA4LmMJKC4uLi90YWdzL2xpbnV4LTIuNi4zMi4xKQkocmV2aXNp
b24gMCkKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi90c2MyMDA4LmMJKC4uLi9icmFu
Y2hlcy9hdDkxc2FtOTI2M2NzLTIuNi4zMi4xKQkocmV2aXNpb24gMTg0KQpAQCAtMCwwICsxLDUx
OSBAQAorLyoKKyAqIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vdHNjMjAwOC5jCisgKgorICog
Q29weXJpZ2h0IChjKSAyMDEwIEN5YmVyIFN3aXRjaGluZywgSW5jLgorICogICAgQ2hyaXMgVmVy
Z2VzIDxjaHJpc3ZAY3liZXJzd2l0Y2hpbmcuY29tPgorICogICAgUm9iZXJ0IE1laHJhbmZhciA8
cm9iZXJ0bWVAZWFydGhsaW5rLm5ldD4KKyAqCisgKiBVc2luZyBjb2RlIGZyb206CisgKiAgLSB0
c2MyMDA4LmMKKyAqICAgICAgQ29weXJpZ2h0IChjKSAyMDA4IE10ZWtWaXNpb24gQ28uLCBMdGQu
CisgKglLd2FuZ3dvbyBMZWUgPGt3bGVlQG10ZWt2aXNpb24uY29tPgorICogIC0gYWRzNzg0Ni5j
CisgKglDb3B5cmlnaHQgKGMpIDIwMDUgRGF2aWQgQnJvd25lbGwKKyAqCUNvcHlyaWdodCAoYykg
MjAwNiBOb2tpYSBDb3Jwb3JhdGlvbgorICogIC0gY29yZ2lfdHMuYworICoJQ29weXJpZ2h0IChD
KSAyMDA0LTIwMDUgUmljaGFyZCBQdXJkaWUKKyAqICAtIG9tYXBfdHMuW2hjXSwgYWRzNzg0Ni5o
LCB0c19vc2suYworICoJQ29weXJpZ2h0IChDKSAyMDAyIE1vbnRhVmlzdGEgU29mdHdhcmUKKyAq
CUNvcHlyaWdodCAoQykgMjAwNCBUZXhhcyBJbnN0cnVtZW50cworICoJQ29weXJpZ2h0IChDKSAy
MDA1IERpcmsgQmVobWUKKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVy
bXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcworICogIHB1
Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICovCisKKyNpbmNsdWRl
IDxsaW51eC9kZWxheS5oPgorI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CisjaW5jbHVkZSA8bGlu
dXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGlu
dXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4KKyNpbmNsdWRlIDxsaW51eC9z
cGkvdHNjMjAwOC5oPgorCisjZGVmaW5lIFRTX1BPTExfREVMQVkJCQkxIC8qIG1zIGRlbGF5IGJl
dHdlZW4gc2FtcGxlcyAqLworI2RlZmluZSBUU19QT0xMX1BFUklPRAkJCTEgLyogbXMgZGVsYXkg
YmV0d2VlbiBzYW1wbGVzICovCisKKyNkZWZpbmUgVFNDMjAwOF9TVEFSVF9DTUQJCSgweDEgPDwg
NykKKworI2RlZmluZSBUU0MyMDA4X01FQVNVUkVfVEVNUDEJCSgweDAgPDwgNCkKKyNkZWZpbmUg
VFNDMjAwOF9NRUFTVVJFX1kJCSgweDEgPDwgNCkKKyNkZWZpbmUgVFNDMjAwOF9TRVRVUAkJCSgw
eDIgPDwgNCkKKyNkZWZpbmUgVFNDMjAwOF9NRUFTVVJFX1oxCQkoMHgzIDw8IDQpCisjZGVmaW5l
IFRTQzIwMDhfTUVBU1VSRV9aMgkJKDB4NCA8PCA0KQorI2RlZmluZSBUU0MyMDA4X01FQVNVUkVf
WAkJKDB4NSA8PCA0KQorI2RlZmluZSBUU0MyMDA4X01FQVNVUkVfQVVYCQkoMHg2IDw8IDQpCisj
ZGVmaW5lIFRTQzIwMDhfTUVBU1VSRV9URU1QMgkJKDB4NyA8PCA0KQorCisjZGVmaW5lIFRTQzIw
MDhfVVNFXzUwSwkJCSgweDAgPDwgMykKKyNkZWZpbmUgVFNDMjAwOF9VU0VfOTBLCQkJKDB4MSA8
PCAzKQorCisjZGVmaW5lIFRTQzIwMDhfRU5BQkxFX01BVgkJKDB4MCA8PCAyKQorI2RlZmluZSBU
U0MyMDA4X0RJU0FCTEVfTUFWCQkoMHgxIDw8IDIpCisKKyNkZWZpbmUgVFNDMjAwOF9TT0ZUV0FS
RV9SRVNFVAkJKDB4MSA8PCAwKQorCisjZGVmaW5lIFRTQzIwMDhfUE9XRVJfT0ZGX0lSUV9FTgko
MHgwIDw8IDApCisjZGVmaW5lIFRTQzIwMDhfQURDX09OX0lSUV9ESVMwCQkoMHgxIDw8IDApCisj
ZGVmaW5lIFRTQzIwMDhfQURDX09GRl9JUlFfRU4JCSgweDIgPDwgMCkKKyNkZWZpbmUgVFNDMjAw
OF9BRENfT05fSVJRX0RJUzEJCSgweDMgPDwgMCkKKworI2RlZmluZSBUU0MyMDA4XzEyQklUCQkJ
KDB4MCA8PCAxKQorI2RlZmluZSBUU0MyMDA4XzhCSVQJCQkoMHgxIDw8IDEpCisKKyNkZWZpbmUJ
TUFYXzEyQklUCQkJKDEgPDwgMTIpCisjZGVmaW5lIE1BWF84QklUCQkJKDEgPDwgOCkKKworI2Rl
ZmluZSBBRENfT05fMTJCSVQJKFRTQzIwMDhfU1RBUlRfQ01EIHwgVFNDMjAwOF8xMkJJVCB8IFRT
QzIwMDhfUE9XRVJfT0ZGX0lSUV9FTikKKyNkZWZpbmUgQURDX09OXzhCSVQJKFRTQzIwMDhfU1RB
UlRfQ01EIHwgVFNDMjAwOF84QklUIHwgVFNDMjAwOF9QT1dFUl9PRkZfSVJRX0VOKQorCisvKiB1
c2VjLCBTQ0xLPTI1TUh6IHcvbyBNQVYgKi8KKyNkZWZpbmUgVFhfREVMQVkJKDQwKQorI2RlZmlu
ZSBSWF9ERUxBWQkoNDApCisKK3N0cnVjdCB0c19ldmVudCB7CisJdWludDE2X3QJeDsKKwl1aW50
MTZfdAl5OworCXVpbnQxNl90CXoxLCB6MjsKK307CisKK3N0cnVjdCB0c2MyMDA4IHsKKwlzdHJ1
Y3QgaW5wdXRfZGV2CSppbnB1dDsKKwljaGFyCQkJcGh5c1szMl07CisJc3RydWN0IGRlbGF5ZWRf
d29yawl3b3JrOworCisJc3RydWN0IHNwaV9kZXZpY2UJKnNwaTsKKwlzdHJ1Y3Qgc3BpX21lc3Nh
Z2UJbXNnOworCXN0cnVjdCBzcGlfdHJhbnNmZXIJeGZlcls4XTsKKwl1aW50OF90CQkJdHhfYnVm
WzRdOworCisJdWludDE2X3QJCW1vZGVsOworCXVpbnQxNl90CQl4X3BsYXRlX29obXM7CisJdWlu
dDE2X3QJCW1heF9iaXRzOworCisJYm9vbAkJCXBlbmRvd247CisJaW50CQkJaXJxOworCisJaW50
CQkJKCpnZXRfcGVuZG93bl9zdGF0ZSkodm9pZCk7CisJdm9pZAkJCSgqY2xlYXJfcGVuaXJxKSh2
b2lkKTsKK307CisKK3N0YXRpYyB2b2lkIHRzYzIwMDhfcmVhZF92YWx1ZXMoc3RydWN0IHRzYzIw
MDggKnRzYywgc3RydWN0IHRzX2V2ZW50ICp0YykKK3sKKwkvKiBSZWFkIHRoZSB2YWx1ZXMgZnJv
bSB0aGUgVFNDMjAwOCAqLworCXRzYy0+eGZlclsxXS5yeF9idWYgPSAmdGMtPng7CisJdHNjLT54
ZmVyWzNdLnJ4X2J1ZiA9ICZ0Yy0+eTsKKwl0c2MtPnhmZXJbNV0ucnhfYnVmID0gJnRjLT56MTsK
Kwl0c2MtPnhmZXJbN10ucnhfYnVmID0gJnRjLT56MjsKKworCXNwaV9zeW5jKHRzYy0+c3BpLCAm
dHNjLT5tc2cpOworCisJZGV2X2RiZygmdHNjLT5zcGktPmRldiwgImRhdGE6IHggICUwNXUgMHgl
MDh4XG4iLCB0Yy0+eCwgdGMtPngpOworCWRldl9kYmcoJnRzYy0+c3BpLT5kZXYsICJkYXRhOiB5
ICAlMDV1IDB4JTA4eFxuIiwgdGMtPnksIHRjLT55KTsKKwlkZXZfZGJnKCZ0c2MtPnNwaS0+ZGV2
LCAiZGF0YTogejEgJTA1dSAweCUwOHhcbiIsIHRjLT56MSwgdGMtPnoxKTsKKwlkZXZfZGJnKCZ0
c2MtPnNwaS0+ZGV2LCAiZGF0YTogejIgJTA1dSAweCUwOHhcbiIsIHRjLT56MiwgdGMtPnoyKTsK
KworCWlmICh0c2MtPm1heF9iaXRzID09IE1BWF84QklUKSB7CisJCXRjLT54ICA9ICh0Yy0+eCAg
PDwgMSkgJiAweDAwRkY7CisJCXRjLT55ICA9ICh0Yy0+eSAgPDwgMSkgJiAweDAwRkY7CisJCXRj
LT56MSA9ICh0Yy0+ejEgPDwgMSkgJiAweDAwRkY7CisJCXRjLT56MiA9ICh0Yy0+ejIgPDwgMSkg
JiAweDAwRkY7CisJfSBlbHNlIGlmICh0c2MtPm1heF9iaXRzID09IE1BWF8xMkJJVCkgeworCQl0
Yy0+eCAgPSAoYmUxNl90b19jcHUodGMtPngpICA8PCAxKSA+PiA0ICYgMHgwRkZGOworCQl0Yy0+
eSAgPSAoYmUxNl90b19jcHUodGMtPnkpICA8PCAxKSA+PiA0ICYgMHgwRkZGOworCQl0Yy0+ejEg
PSAoYmUxNl90b19jcHUodGMtPnoxKSA8PCAxKSA+PiA0ICYgMHgwRkZGOworCQl0Yy0+ejIgPSAo
YmUxNl90b19jcHUodGMtPnoyKSA8PCAxKSA+PiA0ICYgMHgwRkZGOworCX0gZWxzZSB7CisJCWRl
dl9lcnIoJnRzYy0+c3BpLT5kZXYsICJpbnZhbGlkIG51bWJlciBvZiBiaXRzIGV4cGVjdGVkXG4i
KTsKKwl9CisKKwlkZXZfZGJnKCZ0c2MtPnNwaS0+ZGV2LCAiZGF0YTogeCAgJTA1dSAweCUwOHhc
biIsIHRjLT54LCB0Yy0+eCk7CisJZGV2X2RiZygmdHNjLT5zcGktPmRldiwgImRhdGE6IHkgICUw
NXUgMHglMDh4XG4iLCB0Yy0+eSwgdGMtPnkpOworCWRldl9kYmcoJnRzYy0+c3BpLT5kZXYsICJk
YXRhOiB6MSAlMDV1IDB4JTA4eFxuIiwgdGMtPnoxLCB0Yy0+ejEpOworCWRldl9kYmcoJnRzYy0+
c3BpLT5kZXYsICJkYXRhOiB6MiAlMDV1IDB4JTA4eFxuIiwgdGMtPnoyLCB0Yy0+ejIpOworfQor
CitzdGF0aWMgdWludDMyX3QgdHNjMjAwOF9jYWxjdWxhdGVfcHJlc3N1cmUoc3RydWN0IHRzYzIw
MDggKnRzYywgc3RydWN0IHRzX2V2ZW50ICp0YykKK3sKKwl1aW50MzJfdCBydCA9IDA7CisKKwkv
KiByYW5nZSBmaWx0ZXJpbmcgKi8KKwlpZiAodGMtPnggPT0gKHRzYy0+bWF4X2JpdHMgLSAxKSkK
KwkJdGMtPnggPSAwOworCisJaWYgKGxpa2VseSh0Yy0+eCAmJiB0Yy0+ejEpKSB7CisJCXJ0ID0g
KHRjLT56MiAvIHRjLT56MSkgLSAxOworCQlydCAqPSB0Yy0+eSAqIHRzYy0+eF9wbGF0ZV9vaG1z
OworCQlydCAvPSB0c2MtPm1heF9iaXRzOworCisJCWlmICh0c2MtPm1heF9iaXRzID09IE1BWF84
QklUKQorCQkJcnQgJj0gMHgwMEZGOworCQllbHNlCisJCQlydCAmPSAweDBGRkY7CisJfQorCisJ
ZGV2X2RiZygmdHNjLT5zcGktPmRldiwgInByZXNzdXJlOiAlMDV1IDB4JTA4eFxuIiwgcnQsIHJ0
KTsKKworCXJldHVybiBydDsKK30KKworc3RhdGljIHZvaWQgdHNjMjAwOF9zZW5kX3VwX2V2ZW50
KHN0cnVjdCB0c2MyMDA4ICp0c2MpCit7CisJc3RydWN0IGlucHV0X2RldiAqaW5wdXQgPSB0c2Mt
PmlucHV0OworCisJZGV2X2RiZygmdHNjLT5zcGktPmRldiwgIlVQXG4iKTsKKworCWlucHV0X3Jl
cG9ydF9rZXkoaW5wdXQsIEJUTl9UT1VDSCwgMCk7CisJaW5wdXRfcmVwb3J0X2FicyhpbnB1dCwg
QUJTX1BSRVNTVVJFLCAwKTsKKwlpbnB1dF9zeW5jKGlucHV0KTsKK30KKworc3RhdGljIHZvaWQg
dHNjMjAwOF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKK3sKKwlzdHJ1Y3QgdHNjMjAw
OCAqdHMgPQorCQljb250YWluZXJfb2YodG9fZGVsYXllZF93b3JrKHdvcmspLCBzdHJ1Y3QgdHNj
MjAwOCwgd29yayk7CisJc3RydWN0IHRzX2V2ZW50IHRjOworCXVpbnQzMl90IHJ0OworCisJLyoK
KwkgKiBOT1RFOiBXZSBjYW4ndCByZWx5IG9uIHRoZSBwcmVzc3VyZSB0byBkZXRlcm1pbmUgdGhl
IHBlbiBkb3duCisJICogc3RhdGUsIGV2ZW4gdGhvdWdoIHRoaXMgY29udHJvbGxlciBoYXMgYSBw
cmVzc3VyZSBzZW5zb3IuCisJICogVGhlIHByZXNzdXJlIHZhbHVlIGNhbiBmbHVjdHVhdGUgZm9y
IHF1aXRlIGEgd2hpbGUgYWZ0ZXIKKwkgKiBsaWZ0aW5nIHRoZSBwZW4gYW5kIGluIHNvbWUgY2Fz
ZXMgbWF5IG5vdCBldmVuIHNldHRsZSBhdCB0aGUKKwkgKiBleHBlY3RlZCB2YWx1ZS4KKwkgKgor
CSAqIFRoZSBvbmx5IHNhZmUgd2F5IHRvIGNoZWNrIGZvciB0aGUgcGVuIHVwIGNvbmRpdGlvbiBp
cyBpbiB0aGUKKwkgKiB3b3JrIGZ1bmN0aW9uIGJ5IHJlYWRpbmcgdGhlIHBlbiBzaWduYWwgc3Rh
dGUgKGl0J3MgYSBHUElPCisJICogYW5kIElSUSkuIFVuZm9ydHVuYXRlbHkgc3VjaCBjYWxsYmFj
ayBpcyBub3QgYWx3YXlzIGF2YWlsYWJsZSwKKwkgKiBpbiB0aGF0IGNhc2Ugd2UgaGF2ZSByZWx5
IG9uIHRoZSBwcmVzc3VyZSBhbnl3YXkuCisJICovCisJaWYgKHRzLT5nZXRfcGVuZG93bl9zdGF0
ZSkgeworCQlpZiAodW5saWtlbHkoIXRzLT5nZXRfcGVuZG93bl9zdGF0ZSgpKSkgeworCQkJZGV2
X2RiZygmdHMtPnNwaS0+ZGV2LCAiZGV0ZWN0ZWQgcGVuIFVQIHZpYSBHUElPIHJlYWRcbiIpOwor
CisJCQl0c2MyMDA4X3NlbmRfdXBfZXZlbnQodHMpOworCQkJdHMtPnBlbmRvd24gPSBmYWxzZTsK
KwkJCWdvdG8gb3V0OworCQl9CisKKwkJZGV2X2RiZygmdHMtPnNwaS0+ZGV2LCAicGVuIGlzIHN0
aWxsIGRvd25cbiIpOworCX0gZWxzZSB7CisJCWRldl9kYmcoJnRzLT5zcGktPmRldiwgImdldF9w
ZW5kb3duX3N0YXRlIHVuZGVmaW5lZCwgIgorCQkJCSJ1c2luZyBwcmVzc3VyZSBpbnN0ZWFkXG4i
KTsKKwl9CisKKwl0c2MyMDA4X3JlYWRfdmFsdWVzKHRzLCAmdGMpOworCisJcnQgPSB0c2MyMDA4
X2NhbGN1bGF0ZV9wcmVzc3VyZSh0cywgJnRjKTsKKwlpZiAocnQgPj0gdHMtPm1heF9iaXRzKSB7
CisJCS8qCisJCSAqIFNhbXBsZSBmb3VuZCBpbmNvbnNpc3RlbnQgYnkgZGVib3VuY2luZyBvciBw
cmVzc3VyZSBpcworCQkgKiBiZXlvbmQgdGhlIG1heGltdW0uIERvbid0IHJlcG9ydCBpdCB0byB1
c2VyIHNwYWNlLAorCQkgKiByZXBlYXQgYXQgbGVhc3Qgb25jZSBtb3JlIHRoZSBtZWFzdXJlbWVu
dC4KKwkJICovCisJCWRldl9kYmcoJnRzLT5zcGktPmRldiwgImlnbm9yZWQgcHJlc3N1cmUgJWRc
biIsIHJ0KTsKKwkJZ290byBvdXQ7CisJfQorCisJaWYgKHJ0KSB7CisJCXN0cnVjdCBpbnB1dF9k
ZXYgKmlucHV0ID0gdHMtPmlucHV0OworCisJCWlmICghdHMtPnBlbmRvd24pIHsKKwkJCWRldl9k
YmcoJnRzLT5zcGktPmRldiwgIkRPV05cbiIpOworCisJCQlpbnB1dF9yZXBvcnRfa2V5KGlucHV0
LCBCVE5fVE9VQ0gsIDEpOworCQkJdHMtPnBlbmRvd24gPSB0cnVlOworCQl9CisKKwkJaW5wdXRf
cmVwb3J0X2FicyhpbnB1dCwgQUJTX1gsIHRjLngpOworCQlpbnB1dF9yZXBvcnRfYWJzKGlucHV0
LCBBQlNfWSwgdGMueSk7CisJCWlucHV0X3JlcG9ydF9hYnMoaW5wdXQsIEFCU19QUkVTU1VSRSwg
cnQpOworCisJCWlucHV0X3N5bmMoaW5wdXQpOworCisJCWRldl9kYmcoJnRzLT5zcGktPmRldiwg
InBvaW50KCU0ZCwlNGQpLCBwcmVzc3VyZSAoJTR1KVxuIiwKKwkJCXRjLngsIHRjLnksIHJ0KTsK
Kwl9IGVsc2UgaWYgKCF0cy0+Z2V0X3BlbmRvd25fc3RhdGUgJiYgdHMtPnBlbmRvd24pIHsKKwkJ
LyoKKwkJICogV2UgZG9uJ3QgaGF2ZSBjYWxsYmFjayB0byBjaGVjayBwZW5kb3duIHN0YXRlLCBz
byB3ZQorCQkgKiBoYXZlIHRvIGFzc3VtZSB0aGF0IHNpbmNlIHByZXNzdXJlIHJlcG9ydGVkIGlz
IDAgdGhlCisJCSAqIHBlbiB3YXMgbGlmdGVkIHVwLgorCQkgKi8KKwkJdHNjMjAwOF9zZW5kX3Vw
X2V2ZW50KHRzKTsKKwkJdHMtPnBlbmRvd24gPSBmYWxzZTsKKwl9IGVsc2UgeworCQlkZXZfZGJn
KCZ0cy0+c3BpLT5kZXYsICJubyBjaGFuZ2UgaW4gcGVuIHN0YXRlIGRldGVjdGVkXG4iKTsKKwl9
CisKKyBvdXQ6CisJaWYgKHRzLT5wZW5kb3duKQorCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnRz
LT53b3JrLAorCQkJCSAgICAgIG1zZWNzX3RvX2ppZmZpZXMoVFNfUE9MTF9QRVJJT0QpKTsKKwll
bHNlCisJCWVuYWJsZV9pcnEodHMtPmlycSk7Cit9CisKK3N0YXRpYyBpcnFyZXR1cm5fdCB0c2My
MDA4X2lycShpbnQgaXJxLCB2b2lkICpoYW5kbGUpCit7CisJc3RydWN0IHRzYzIwMDggKnRzID0g
aGFuZGxlOworCisJaWYgKCF0cy0+Z2V0X3BlbmRvd25fc3RhdGUgfHwgbGlrZWx5KHRzLT5nZXRf
cGVuZG93bl9zdGF0ZSgpKSkgeworCQlkaXNhYmxlX2lycV9ub3N5bmModHMtPmlycSk7CisJCXNj
aGVkdWxlX2RlbGF5ZWRfd29yaygmdHMtPndvcmssCisJCQkJICAgICAgbXNlY3NfdG9famlmZmll
cyhUU19QT0xMX0RFTEFZKSk7CisJfQorCisJaWYgKHRzLT5jbGVhcl9wZW5pcnEpCisJCXRzLT5j
bGVhcl9wZW5pcnEoKTsKKworCXJldHVybiBJUlFfSEFORExFRDsKK30KKworc3RhdGljIHZvaWQg
dHNjMjAwOF9mcmVlX2lycShzdHJ1Y3QgdHNjMjAwOCAqdHMpCit7CisJZnJlZV9pcnEodHMtPmly
cSwgdHMpOworCWlmIChjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnRzLT53b3JrKSkgeworCQkv
KgorCQkgKiBXb3JrIHdhcyBwZW5kaW5nLCB0aGVyZWZvcmUgd2UgbmVlZCB0byBlbmFibGUKKwkJ
ICogSVJRIGhlcmUgdG8gYmFsYW5jZSB0aGUgZGlzYWJsZV9pcnEoKSBkb25lIGluIHRoZQorCQkg
KiBpbnRlcnJ1cHQgaGFuZGxlci4KKwkJICovCisJCWVuYWJsZV9pcnEodHMtPmlycSk7CisJfQor
fQorCitzdGF0aWMgaW50IF9fZGV2aW5pdCB0c2MyMDA4X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNl
ICpzcGkpCit7CisJc3RydWN0IHRzYzIwMDggKnRzOworCXN0cnVjdCB0c2MyMDA4X3BsYXRmb3Jt
X2RhdGEgKnBkYXRhID0gc3BpLT5kZXYucGxhdGZvcm1fZGF0YTsKKwlzdHJ1Y3QgaW5wdXRfZGV2
ICppbnB1dF9kZXY7CisJc3RydWN0IHNwaV90cmFuc2ZlciAqeDsKKwl1aW50OF90IHR4X2J1ZjsK
KwlpbnQgbnVtX2J5dGVzX3J4OworCWludCBlcnI7CisKKwlpZiAoIXBkYXRhKSB7CisJCWRldl9l
cnIoJnNwaS0+ZGV2LCAicGxhdGZvcm0gZGF0YSBpcyByZXF1aXJlZCFcbiIpOworCQlyZXR1cm4g
LUVJTlZBTDsKKwl9CisKKwlpZiAoIXBkYXRhLT5nZXRfcGVuZG93bl9zdGF0ZSkgeworCQlkZXZf
ZXJyKCZzcGktPmRldiwgInBlbmRvd24gZnVuY3Rpb24gaXMgcmVxdWlyZWQhXG4iKTsKKwkJcmV0
dXJuIC1FSU5WQUw7CisJfQorCisJaWYgKCFwZGF0YS0+Yml0X21vZGUpIHsKKwkJZGV2X2RiZygm
c3BpLT5kZXYsICJiaXQgbW9kZSBub3Qgc3BlY2lmaWVkLCB1c2luZyA4LWJpdCBtb2RlXG4iKTsK
KwkJcGRhdGEtPmJpdF9tb2RlID0gODsKKwl9IGVsc2UgaWYgKHBkYXRhLT5iaXRfbW9kZSAhPSA4
ICYmIHBkYXRhLT5iaXRfbW9kZSAhPSAxMikgeworCQlkZXZfZXJyKCZzcGktPmRldiwgImludmFs
aWQgYml0IG1vZGUgc3BlY2lmaWVkLCA4LWJpdCBvciAxMi1iaXQgZXhwZWN0ZWRcbiIpOworCQly
ZXR1cm4gLUVJTlZBTDsKKwl9CisKKwllcnIgPSBzcGlfc2V0dXAoc3BpKTsKKwlpZiAoZXJyKSB7
CisJCWRldl9lcnIoJnNwaS0+ZGV2LCAidW5hYmxlIHRvIGluaXRpYWxpemUgc3BpXG4iKTsKKwkJ
cmV0dXJuIC1FTk9ERVY7CisJfQorCisJdHMgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgdHNjMjAw
OCksIEdGUF9LRVJORUwpOworCWlucHV0X2RldiA9IGlucHV0X2FsbG9jYXRlX2RldmljZSgpOwor
CWlmICghdHMgfHwgIWlucHV0X2RldikgeworCQllcnIgPSAtRU5PTUVNOworCQlnb3RvIGVycl9m
cmVlX21lbTsKKwl9CisKKwlkZXZfc2V0X2RydmRhdGEoJnNwaS0+ZGV2LCB0cyk7CisJdHMtPnNw
aSA9IHNwaTsKKwl0cy0+aXJxID0gc3BpLT5pcnE7CisJdHMtPmlucHV0ID0gaW5wdXRfZGV2Owor
CUlOSVRfREVMQVlFRF9XT1JLKCZ0cy0+d29yaywgdHNjMjAwOF93b3JrKTsKKworCXRzLT5tb2Rl
bCAgICAgICAgICAgICA9IHBkYXRhLT5tb2RlbDsKKwl0cy0+eF9wbGF0ZV9vaG1zICAgICAgPSBw
ZGF0YS0+eF9wbGF0ZV9vaG1zOworCXRzLT5tYXhfYml0cyAgICAgICAgICA9IDEgPDwgcGRhdGEt
PmJpdF9tb2RlOwkvKiBNYXRjaCBlaXRoZXIgTUFYXzhCSVQgb3IgTUFYXzEyQklUICovCisJdHMt
PmdldF9wZW5kb3duX3N0YXRlID0gcGRhdGEtPmdldF9wZW5kb3duX3N0YXRlOworCXRzLT5jbGVh
cl9wZW5pcnEgICAgICA9IHBkYXRhLT5jbGVhcl9wZW5pcnE7CisKKwlzbnByaW50Zih0cy0+cGh5
cywgc2l6ZW9mKHRzLT5waHlzKSwKKwkJICIlcy9pbnB1dDAiLCBkZXZfbmFtZSgmc3BpLT5kZXYp
KTsKKworCWlucHV0X2Rldi0+bmFtZSA9ICJUU0MyMDA4IFRvdWNoc2NyZWVuIjsKKwlpbnB1dF9k
ZXYtPmRldi5wYXJlbnQgPSAmc3BpLT5kZXY7CisJaW5wdXRfZGV2LT5waHlzID0gdHMtPnBoeXM7
CisKKwlpbnB1dF9kZXYtPmV2Yml0WzBdID0gQklUX01BU0soRVZfS0VZKSB8IEJJVF9NQVNLKEVW
X0FCUyk7CisJaW5wdXRfZGV2LT5rZXliaXRbQklUX1dPUkQoQlROX1RPVUNIKV0gPSBCSVRfTUFT
SyhCVE5fVE9VQ0gpOworCisJaW5wdXRfc2V0X2Fic19wYXJhbXMoaW5wdXRfZGV2LCBBQlNfWCwg
MCwgdHMtPm1heF9iaXRzLCAwLCAwKTsKKwlpbnB1dF9zZXRfYWJzX3BhcmFtcyhpbnB1dF9kZXYs
IEFCU19ZLCAwLCB0cy0+bWF4X2JpdHMsIDAsIDApOworCWlucHV0X3NldF9hYnNfcGFyYW1zKGlu
cHV0X2RldiwgQUJTX1BSRVNTVVJFLCAwLCB0cy0+bWF4X2JpdHMsIDAsIDApOworCisJaWYgKHBk
YXRhLT5pbml0X3BsYXRmb3JtX2h3KQorCQlwZGF0YS0+aW5pdF9wbGF0Zm9ybV9odygpOworCisJ
ZXJyID0gcmVxdWVzdF9pcnEodHMtPmlycSwgdHNjMjAwOF9pcnEsIDAsCisJCQlzcGktPmRldi5k
cml2ZXItPm5hbWUsIHRzKTsKKwlpZiAoZXJyIDwgMCkgeworCQlkZXZfZXJyKCZzcGktPmRldiwg
ImlycSAlZCBidXN5P1xuIiwgdHMtPmlycSk7CisJCWdvdG8gZXJyX2ZyZWVfbWVtOworCX0KKwor
CS8qIFNldHVwIFNQSSB2YXJpYWJsZXMgKi8KKwlzcGlfbWVzc2FnZV9pbml0KCZ0cy0+bXNnKTsK
KworCS8qCisJICogVFNDMjAwOF9NRUFTVVJFX1ggYW5kIFRTQzIwMDhfTUVBU1VSRV9ZIGFyZSBp
bnRlbnRpb25hbGx5CisJICogc3dhcHBlZCBiZWxvdy4KKwkgKi8KKwlpZiAodHMtPm1heF9iaXRz
ID09IE1BWF84QklUKSB7CisJCWRldl9kYmcoJnNwaS0+ZGV2LCAidXNpbmcgOC1iaXQgbW9kZVxu
Iik7CisJCW51bV9ieXRlc19yeCA9IDE7CisJCXRzLT50eF9idWZbMF0gPSBBRENfT05fOEJJVCB8
IFRTQzIwMDhfTUVBU1VSRV9ZOworCQl0cy0+dHhfYnVmWzFdID0gQURDX09OXzhCSVQgfCBUU0My
MDA4X01FQVNVUkVfWDsKKwkJdHMtPnR4X2J1ZlsyXSA9IEFEQ19PTl84QklUIHwgVFNDMjAwOF9N
RUFTVVJFX1oxOworCQl0cy0+dHhfYnVmWzNdID0gQURDX09OXzhCSVQgfCBUU0MyMDA4X01FQVNV
UkVfWjI7CisJfSBlbHNlIHsKKwkJZGV2X2RiZygmc3BpLT5kZXYsICJ1c2luZyAxMi1iaXQgbW9k
ZVxuIik7CisJCW51bV9ieXRlc19yeCA9IDI7CisJCXRzLT50eF9idWZbMF0gPSBBRENfT05fMTJC
SVQgfCBUU0MyMDA4X01FQVNVUkVfWTsKKwkJdHMtPnR4X2J1ZlsxXSA9IEFEQ19PTl8xMkJJVCB8
IFRTQzIwMDhfTUVBU1VSRV9YOworCQl0cy0+dHhfYnVmWzJdID0gQURDX09OXzEyQklUIHwgVFND
MjAwOF9NRUFTVVJFX1oxOworCQl0cy0+dHhfYnVmWzNdID0gQURDX09OXzEyQklUIHwgVFNDMjAw
OF9NRUFTVVJFX1oyOworCX0KKworCXggPSAmdHMtPnhmZXJbMF07CisJbWVtc2V0KHgsIDAsIHNp
emVvZigqeCkpOworCXgtPnR4X2J1ZiA9ICZ0cy0+dHhfYnVmWzBdOworCXgtPmxlbiA9IDE7CisJ
eC0+ZGVsYXlfdXNlY3MgPSBUWF9ERUxBWTsKKwlzcGlfbWVzc2FnZV9hZGRfdGFpbCh4LCAmdHMt
Pm1zZyk7CisKKwl4ID0gJnRzLT54ZmVyWzFdOworCW1lbXNldCh4LCAwLCBzaXplb2YoKngpKTsK
Kwl4LT5sZW4gPSBudW1fYnl0ZXNfcng7CisJeC0+ZGVsYXlfdXNlY3MgPSBSWF9ERUxBWTsKKwlz
cGlfbWVzc2FnZV9hZGRfdGFpbCh4LCAmdHMtPm1zZyk7CisKKwl4ID0gJnRzLT54ZmVyWzJdOwor
CW1lbXNldCh4LCAwLCBzaXplb2YoKngpKTsKKwl4LT50eF9idWYgPSAmdHMtPnR4X2J1ZlsxXTsK
Kwl4LT5sZW4gPSAxOworCXgtPmRlbGF5X3VzZWNzID0gVFhfREVMQVk7CisJc3BpX21lc3NhZ2Vf
YWRkX3RhaWwoeCwgJnRzLT5tc2cpOworCisJeCA9ICZ0cy0+eGZlclszXTsKKwltZW1zZXQoeCwg
MCwgc2l6ZW9mKCp4KSk7CisJeC0+bGVuID0gbnVtX2J5dGVzX3J4OworCXgtPmRlbGF5X3VzZWNz
ID0gUlhfREVMQVk7CisJc3BpX21lc3NhZ2VfYWRkX3RhaWwoeCwgJnRzLT5tc2cpOworCisJeCA9
ICZ0cy0+eGZlcls0XTsKKwltZW1zZXQoeCwgMCwgc2l6ZW9mKCp4KSk7CisJeC0+dHhfYnVmID0g
JnRzLT50eF9idWZbMl07CisJeC0+bGVuID0gMTsKKwl4LT5kZWxheV91c2VjcyA9IFRYX0RFTEFZ
OworCXNwaV9tZXNzYWdlX2FkZF90YWlsKHgsICZ0cy0+bXNnKTsKKworCXggPSAmdHMtPnhmZXJb
NV07CisJbWVtc2V0KHgsIDAsIHNpemVvZigqeCkpOworCXgtPmxlbiA9IG51bV9ieXRlc19yeDsK
Kwl4LT5kZWxheV91c2VjcyA9IFJYX0RFTEFZOworCXNwaV9tZXNzYWdlX2FkZF90YWlsKHgsICZ0
cy0+bXNnKTsKKworCXggPSAmdHMtPnhmZXJbNl07CisJbWVtc2V0KHgsIDAsIHNpemVvZigqeCkp
OworCXgtPnR4X2J1ZiA9ICZ0cy0+dHhfYnVmWzNdOworCXgtPmxlbiA9IDE7CisJeC0+ZGVsYXlf
dXNlY3MgPSBUWF9ERUxBWTsKKwlzcGlfbWVzc2FnZV9hZGRfdGFpbCh4LCAmdHMtPm1zZyk7CisK
Kwl4ID0gJnRzLT54ZmVyWzddOworCW1lbXNldCh4LCAwLCBzaXplb2YoKngpKTsKKwl4LT5sZW4g
PSBudW1fYnl0ZXNfcng7CisJc3BpX21lc3NhZ2VfYWRkX3RhaWwoeCwgJnRzLT5tc2cpOworCisJ
LyoKKwkgKiBSZXNldCB0aGUgY29udHJvbGxlciBvbmNlIHVzaW5nIHRoZSBzZXF1ZW5jZSBkZXNj
cmliZWQKKwkgKiBvbiBwYWdlIDI5IG9mIHRoZSBUU0MyMDA4IG1hbnVhbCAoTWFyY2ggMjAwOSBy
ZXZpc2lvbikKKwkgKi8KKwl0eF9idWYgPSBUU0MyMDA4X1NUQVJUX0NNRAorCQkJfCBUU0MyMDA4
X1NFVFVQCisJCQl8IFRTQzIwMDhfU09GVFdBUkVfUkVTRVQ7CisJZXJyID0gc3BpX3dyaXRlKHNw
aSwgJnR4X2J1ZiwgMSk7CisJaWYgKGVyciA8IDApCisJCWdvdG8gZXJyX2ZyZWVfaXJxOworCXVk
ZWxheSgxKTsKKworCS8qIENvbmZpZ3VyZSB0aGUgcHVsbC11cCByZXNpc3RvciBhbmQgTUFWIHNl
dHRpbmdzICovCisJdHhfYnVmID0gVFNDMjAwOF9TVEFSVF9DTUQKKwkJCXwgVFNDMjAwOF9TRVRV
UAorCQkJfCBUU0MyMDA4X1VTRV85MEsKKwkJCXwgVFNDMjAwOF9ESVNBQkxFX01BVjsKKwllcnIg
PSBzcGlfd3JpdGUoc3BpLCAmdHhfYnVmLCAxKTsKKwlpZiAoZXJyIDwgMCkKKwkJZ290byBlcnJf
ZnJlZV9pcnE7CisKKwkvKiBGaW5pc2ggaW5wdXQgZGV2aWNlIHJlZ2lzdHJhdGlvbiAqLworCWVy
ciA9IGlucHV0X3JlZ2lzdGVyX2RldmljZShpbnB1dF9kZXYpOworCWlmIChlcnIpCisJCWdvdG8g
ZXJyX2ZyZWVfaXJxOworCisJcmV0dXJuIDA7CisKKyBlcnJfZnJlZV9pcnE6CisJdHNjMjAwOF9m
cmVlX2lycSh0cyk7CisJaWYgKHBkYXRhLT5leGl0X3BsYXRmb3JtX2h3KQorCQlwZGF0YS0+ZXhp
dF9wbGF0Zm9ybV9odygpOworIGVycl9mcmVlX21lbToKKwlpbnB1dF9mcmVlX2RldmljZShpbnB1
dF9kZXYpOworCWtmcmVlKHRzKTsKKwlyZXR1cm4gZXJyOworfQorCitzdGF0aWMgaW50IF9fZGV2
ZXhpdCB0c2MyMDA4X3JlbW92ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQoreworCXN0cnVjdCB0
c2MyMDA4ICp0cyA9IGRldl9nZXRfZHJ2ZGF0YSgmc3BpLT5kZXYpOworCXN0cnVjdCB0c2MyMDA4
X3BsYXRmb3JtX2RhdGEgKnBkYXRhID0gc3BpLT5kZXYucGxhdGZvcm1fZGF0YTsKKworCXRzYzIw
MDhfZnJlZV9pcnEodHMpOworCisJaWYgKHBkYXRhLT5leGl0X3BsYXRmb3JtX2h3KQorCQlwZGF0
YS0+ZXhpdF9wbGF0Zm9ybV9odygpOworCisJaW5wdXRfdW5yZWdpc3Rlcl9kZXZpY2UodHMtPmlu
cHV0KTsKKwlrZnJlZSh0cyk7CisKKwlkZXZfZGJnKCZzcGktPmRldiwgInVucmVnaXN0ZXJlZCB0
b3VjaHNjcmVlblxuIik7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVjdCBzcGlfZHJp
dmVyIHRzYzIwMDhfZHJpdmVyID0geworCS5kcml2ZXIgPSB7CisJCS5vd25lcgk9IFRISVNfTU9E
VUxFLAorCQkubmFtZQk9ICJ0c2MyMDA4IiwKKwkJLmJ1cwk9ICZzcGlfYnVzX3R5cGUsCisJfSwK
KwkucHJvYmUJCT0gdHNjMjAwOF9wcm9iZSwKKwkucmVtb3ZlCQk9IF9fZGV2ZXhpdF9wKHRzYzIw
MDhfcmVtb3ZlKSwKK307CisKK3N0YXRpYyBpbnQgX19pbml0IHRzYzIwMDhfaW5pdCh2b2lkKQor
eworCXJldHVybiBzcGlfcmVnaXN0ZXJfZHJpdmVyKCZ0c2MyMDA4X2RyaXZlcik7Cit9CisKK3N0
YXRpYyB2b2lkIF9fZXhpdCB0c2MyMDA4X2V4aXQodm9pZCkKK3sKKwlzcGlfdW5yZWdpc3Rlcl9k
cml2ZXIoJnRzYzIwMDhfZHJpdmVyKTsKK30KKworbW9kdWxlX2luaXQodHNjMjAwOF9pbml0KTsK
K21vZHVsZV9leGl0KHRzYzIwMDhfZXhpdCk7CisKK01PRFVMRV9BVVRIT1IoIkNocmlzIFZlcmdl
cyA8Y2hyaXN2QGN5YmVyc3dpdGNoaW5nLmNvbT4sICIKKwkJIlJvYmVydCBNZWhyYW5mYXIgPHJv
YmVydG1lQGVhcnRobGluay5uZXQ+Iik7CitNT0RVTEVfREVTQ1JJUFRJT04oIlRTQzIwMDggVG91
Y2hzY3JlZW4gRHJpdmVyIik7CitNT0RVTEVfTElDRU5TRSgiR1BMIik7CkluZGV4OiBkcml2ZXJz
L2lucHV0L3RvdWNoc2NyZWVuL01ha2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGEvZHJpdmVycy9pbnB1
dC90b3VjaHNjcmVlbi9NYWtlZmlsZQkoLi4uL3RhZ3MvbGludXgtMi42LjMyLjEpCShyZXZpc2lv
biAxODQpCisrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vTWFrZWZpbGUJKC4uLi9icmFu
Y2hlcy9hdDkxc2FtOTI2M2NzLTIuNi4zMi4xKQkocmV2aXNpb24gMTg0KQpAQCAtMzAsNiArMzAs
NyBAQAogb2JqLSQoQ09ORklHX1RPVUNIU0NSRUVOX1RPVUNIUklHSFQpCSs9IHRvdWNocmlnaHQu
bwogb2JqLSQoQ09ORklHX1RPVUNIU0NSRUVOX1RPVUNIV0lOKQkrPSB0b3VjaHdpbi5vCiBvYmot
JChDT05GSUdfVE9VQ0hTQ1JFRU5fVFNDMjAwNykJKz0gdHNjMjAwNy5vCitvYmotJChDT05GSUdf
VE9VQ0hTQ1JFRU5fVFNDMjAwOCkJKz0gdHNjMjAwOC5vCiBvYmotJChDT05GSUdfVE9VQ0hTQ1JF
RU5fVUNCMTQwMCkJKz0gdWNiMTQwMF90cy5vCiBvYmotJChDT05GSUdfVE9VQ0hTQ1JFRU5fV0FD
T01fVzgwMDEpCSs9IHdhY29tX3c4MDAxLm8KIG9iai0kKENPTkZJR19UT1VDSFNDUkVFTl9XTTk3
WFgpCSs9IHdtOTd4eC10cy5vCg==

------_=_NextPart_001_01CA9A08.5C506042--
