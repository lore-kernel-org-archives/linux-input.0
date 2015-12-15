From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/touchscreen: New EETI eGalaxTouch serial
 touchscreen driver
Date: Tue, 15 Dec 2015 13:21:23 -0800
Message-ID: <20151215212123.GA18844@dtor-ws>
References: <1450178527-26745-1-git-send-email-zboszormenyi@sicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34224 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965279AbbLOVV0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2015 16:21:26 -0500
Received: by mail-pa0-f47.google.com with SMTP id wq6so11429415pac.1
        for <linux-input@vger.kernel.org>; Tue, 15 Dec 2015 13:21:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450178527-26745-1-git-send-email-zboszormenyi@sicom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszormenyi@sicom.com>
Cc: linux-input@vger.kernel.org, =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszor@pr.hu>

Hi Zolt=E1n,

On Tue, Dec 15, 2015 at 12:22:07PM +0100, B=F6sz=F6rm=E9nyi Zolt=E1n wr=
ote:
> From: B=F6sz=F6rm=E9nyi Zolt=E1n <zboszor@pr.hu>
>=20
> There are two EETI touchscreen drivers in the kernel (eeti_ts and ega=
lax_ts)
> but both are for I2C-connected panels. This is for a different, seria=
l
> and not multi-touch touchscreen panel. The protocol documentation is =
at
> http://www.eeti.com.tw/pdf/Software%20Programming%20Guide_v2.0.pdf
>=20
> Signed-off-by: B=F6sz=F6rm=E9nyi Zolt=E1n <zboszor@pr.hu>
>=20

Thank you for your patch, it looks pretty good, just a few comments
below.

> ---
>  drivers/input/touchscreen/Kconfig  |  10 ++
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/egalax.c | 210 +++++++++++++++++++++++++++=
++++++++++
>  include/uapi/linux/serio.h         |   1 +
>  4 files changed, 222 insertions(+)
>  create mode 100644 drivers/input/touchscreen/egalax.c
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index ae33da7..816a9dc 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -301,20 +301,30 @@ config TOUCHSCREEN_FT6236
>  	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here to enable support for the I2C connected FT6x06 and
>  	  FT6x36 family of capacitive touchscreen drivers.
> =20
>  	  If unsure, say N.
> =20
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ft6236.
> =20
> +config TOUCHSCREEN_EGALAX_SERIO

I'd rather called it TOUCHSCREEN_EGALAX_SERIAL

> +	tristate "EETI eGalax serial touchscreen"
> +	select SERIO
> +	help
> +	  Say Y here to enable support for serial connected EETI
> +	  eGalax touch panels.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called egalax.
> +
>  config TOUCHSCREEN_FUJITSU
>  	tristate "Fujitsu serial touchscreen"
>  	select SERIO
>  	help
>  	  Say Y here if you have the Fujitsu touchscreen (such as one
>  	  installed in Lifebook P series laptop) connected to your
>  	  system.
> =20
>  	  If unsure, say N.
> =20
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index cbaa6ab..6f63b51 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -28,20 +28,21 @@ obj-$(CONFIG_TOUCHSCREEN_CYTTSP4_SPI)	+=3D cyttsp=
4_spi.o
>  obj-$(CONFIG_TOUCHSCREEN_DA9034)	+=3D da9034-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_DA9052)	+=3D da9052_tsi.o
>  obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+=3D dynapro.o
>  obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06)	+=3D edt-ft5x06.o
>  obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+=3D hampshire.o
>  obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+=3D gunze.o
>  obj-$(CONFIG_TOUCHSCREEN_EETI)		+=3D eeti_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ELAN)		+=3D elants_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_ELO)		+=3D elo.o
>  obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+=3D egalax_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIO)	+=3D egalax.o

I think better name is egalax_ts_serial.

>  obj-$(CONFIG_TOUCHSCREEN_FT6236)	+=3D ft6236.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+=3D fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+=3D goodix.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+=3D ili210x.o
>  obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+=3D imx6ul_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+=3D inexio.o
>  obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+=3D intel-mid-touch.o
>  obj-$(CONFIG_TOUCHSCREEN_IPROC)		+=3D bcm_iproc_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+=3D lpc32xx_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+=3D max11801_ts.o
> diff --git a/drivers/input/touchscreen/egalax.c b/drivers/input/touch=
screen/egalax.c
> new file mode 100644
> index 0000000..94ac9bd
> --- /dev/null
> +++ b/drivers/input/touchscreen/egalax.c
> @@ -0,0 +1,210 @@
> +/*
> + * EETI Egalax serial touchscreen driver
> + *
> + * Copyright (c) 2015 Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>
> + *
> + * based on the
> + *
> + * Hampshire serial touchscreen driver (Copyright (c) 2010 Adam Benn=
ett)
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/serio.h>
> +
> +#define DRIVER_DESC	"EETI Egalax serial touchscreen driver"
> +
> +MODULE_AUTHOR("Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>");
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");
> +
> +/*
> + * Definitions & global arrays.
> + */
> +
> +#define EGALAX_FORMAT_MAX_LENGTH 6
> +#define EGALAX_RESPONSE_BEGIN_BYTE 0x80
> +#define EGALAX_FORMAT_PRESSURE_BIT 0x40
> +#define EGALAX_FORMAT_TOUCH_BIT 0x01

We have BIT() macro that would be very useful here.

> +#define EGALAX_FORMAT_RESOLUTION 0x06
> +
> +#define EGALAX_MIN_XC 0
> +#define EGALAX_MAX_XC 0x4000
> +#define EGALAX_MIN_YC 0
> +#define EGALAX_MAX_YC 0x4000
> +
> +#define EGALAX_GET_XC(data, resbits, shift) ((((data[1] & (resbits))=
 << 7) | (data[2] & 0x7f)) << shift)
> +#define EGALAX_GET_YC(data, resbits, shift) ((((data[3] & (resbits))=
 << 7) | (data[4] & 0x7f)) << shift)
> +#define EGALAX_GET_TOUCHED(data) (EGALAX_FORMAT_TOUCH_BIT & data[0])
> +
> +/*
> + * Per-touchscreen data.
> + */
> +
> +struct egalax {
> +	struct input_dev *dev;
> +	struct serio *serio;
> +	int idx;
> +	int bytes;
> +	int resbits;
> +	int shift;
> +	unsigned char data[EGALAX_FORMAT_MAX_LENGTH];
> +	char phys[32];
> +};
> +
> +static void egalax_process_data(struct egalax *pegalax)
> +{
> +	struct input_dev *dev =3D pegalax->dev;
> +
> +	if (++pegalax->idx =3D=3D pegalax->bytes) {
> +		input_report_abs(dev, ABS_X, EGALAX_GET_XC(pegalax->data, pegalax-=
>resbits, pegalax->shift));
> +		input_report_abs(dev, ABS_Y, EGALAX_GET_YC(pegalax->data, pegalax-=
>resbits, pegalax->shift));
> +		input_report_key(dev, BTN_TOUCH, EGALAX_GET_TOUCHED(pegalax->data)=
);
> +		input_sync(dev);
> +
> +		pegalax->idx =3D 0;
> +	}
> +}
> +
> +static irqreturn_t egalax_interrupt(struct serio *serio,
> +		unsigned char data, unsigned int flags)
> +{
> +	struct egalax *pegalax =3D serio_get_drvdata(serio);
> +
> +	pegalax->data[pegalax->idx] =3D data;
> +
> +	if (EGALAX_RESPONSE_BEGIN_BYTE & pegalax->data[0]) {
> +		pegalax->bytes =3D (EGALAX_FORMAT_PRESSURE_BIT & pegalax->data[0] =
? 6 : 5);
> +		switch ((EGALAX_FORMAT_RESOLUTION & pegalax->data[0]) >> 1) {
> +		case 0:
> +			pegalax->resbits =3D 0x0f;
> +			pegalax->shift =3D 3;
> +			break;
> +		case 1:
> +			pegalax->resbits =3D 0x1f;
> +			pegalax->shift =3D 2;
> +			break;
> +		case 2:
> +			pegalax->resbits =3D 0x3f;
> +			pegalax->shift =3D 1;
> +			break;
> +		default:
> +			pegalax->resbits =3D 0x7f;
> +			pegalax->shift =3D 0;
> +			break;
> +		}
> +		egalax_process_data(pegalax);

There is no reason to recalculate shift and mask on every byte and call
egalax_process_data(), better is to wait till you get full packet and
then do the claculations. Also I think you can avoid conditional
computation (switch) here.

> +	}
> +	else
> +		dev_dbg(&serio->dev, "unknown/unsynchronized data: %x\n",
> +			pegalax->data[0]);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void egalax_disconnect(struct serio *serio)
> +{
> +	struct egalax *pegalax =3D serio_get_drvdata(serio);
> +
> +	input_get_device(pegalax->dev);
> +	input_unregister_device(pegalax->dev);
> +	serio_close(serio);
> +	serio_set_drvdata(serio, NULL);
> +	input_put_device(pegalax->dev);
> +	kfree(pegalax);

This is needlessly complicated (although I do know we have this code in
other drivers). Since we do not send any data *to* the touch controller
we can close the port first and then unregister the device.

Could you please try the version of the patch below and let me know if
it works for you?

Thanks!

--=20
Dmitry


Input: input/touchscreen - new EETI eGalaxTouch serial touchscreen driv=
er

=46rom: B=F6sz=F6rm=E9nyi Zolt=E1n <zboszor@pr.hu>

There are two EETI touchscreen drivers in the kernel (eeti_ts and egala=
x_ts)
but both are for I2C-connected panels. This is for a different, serial
and not multi-touch touchscreen panel. The protocol documentation is at
http://www.eeti.com.tw/pdf/Software%20Programming%20Guide_v2.0.pdf

Signed-off-by: B=F6sz=F6rm=E9nyi Zolt=E1n <zboszor@pr.hu>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig            |   10 +
 drivers/input/touchscreen/Makefile           |    1=20
 drivers/input/touchscreen/egalax_ts_serial.c |  194 ++++++++++++++++++=
++++++++
 include/uapi/linux/serio.h                   |    1=20
 4 files changed, 206 insertions(+)
 create mode 100644 drivers/input/touchscreen/egalax_ts_serial.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index 901160a..09707d8 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -295,6 +295,16 @@ config TOUCHSCREEN_EGALAX
 	  To compile this driver as a module, choose M here: the
 	  module will be called egalax_ts.
=20
+config TOUCHSCREEN_EGALAX_SERIAL
+	tristate "EETI eGalax serial touchscreen"
+	select SERIO
+	help
+	  Say Y here to enable support for serial connected EETI
+	  eGalax touch panels.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called egalax_ts_serial.
+
 config TOUCHSCREEN_FT6236
 	tristate "FT6236 I2C touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index f60ef31..c5cabdf 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_TOUCHSCREEN_EETI)		+=3D eeti_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ELAN)		+=3D elants_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+=3D elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+=3D egalax_ts.o
+obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+=3D egalax_ts_serial.o
 obj-$(CONFIG_TOUCHSCREEN_FT6236)	+=3D ft6236.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+=3D fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+=3D goodix.o
diff --git a/drivers/input/touchscreen/egalax_ts_serial.c b/drivers/inp=
ut/touchscreen/egalax_ts_serial.c
new file mode 100644
index 0000000..76cef21
--- /dev/null
+++ b/drivers/input/touchscreen/egalax_ts_serial.c
@@ -0,0 +1,194 @@
+/*
+ * EETI Egalax serial touchscreen driver
+ *
+ * Copyright (c) 2015 Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>
+ *
+ * based on the
+ *
+ * Hampshire serial touchscreen driver (Copyright (c) 2010 Adam Bennet=
t)
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+
+#define DRIVER_DESC	"EETI Egalax serial touchscreen driver"
+
+/*
+ * Definitions & global arrays.
+ */
+
+#define EGALAX_FORMAT_MAX_LENGTH	6
+#define EGALAX_FORMAT_START_BIT		BIT(7)
+#define EGALAX_FORMAT_PRESSURE_BIT	BIT(6)
+#define EGALAX_FORMAT_TOUCH_BIT		BIT(0)
+#define EGALAX_FORMAT_RESOLUTION_MASK	0x06
+
+#define EGALAX_MIN_XC			0
+#define EGALAX_MAX_XC			0x4000
+#define EGALAX_MIN_YC			0
+#define EGALAX_MAX_YC			0x4000
+
+/*
+ * Per-touchscreen data.
+ */
+struct egalax {
+	struct input_dev *input;
+	struct serio *serio;
+	int idx;
+	u8 data[EGALAX_FORMAT_MAX_LENGTH];
+	char phys[32];
+};
+
+static void egalax_process_data(struct egalax *egalax)
+{
+	struct input_dev *dev =3D egalax->input;
+	u8 *data =3D egalax->data;
+	u16 x, y;
+	u8 shift;
+	u8 mask;
+
+	shift =3D 3 - ((data[0] & EGALAX_FORMAT_RESOLUTION_MASK) >> 1);
+	mask =3D -1U >> (shift + 1);
+
+	x =3D (((u16)data[1] & mask) << 7) | ((data[2] & 0x7f) << shift);
+	y =3D (((u16)data[3] & mask) << 7) | ((data[4] & 0x7f) << shift);
+
+	input_report_key(dev, BTN_TOUCH, data[0] & EGALAX_FORMAT_TOUCH_BIT);
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+	input_sync(dev);
+}
+
+static irqreturn_t egalax_interrupt(struct serio *serio,
+				    unsigned char data, unsigned int flags)
+{
+	struct egalax *egalax =3D serio_get_drvdata(serio);
+	int pkt_len;
+
+	egalax->data[egalax->idx++] =3D data;
+
+	if (likely(egalax->data[0] & EGALAX_FORMAT_START_BIT)) {
+		pkt_len =3D egalax->data[0] & EGALAX_FORMAT_PRESSURE_BIT ? 6 : 5;
+		if (pkt_len =3D=3D egalax->idx) {
+			egalax_process_data(egalax);
+			egalax->idx =3D 0;
+		}
+	} else {
+		dev_dbg(&serio->dev, "unknown/unsynchronized data: %x\n",
+			egalax->data[0]);
+		egalax->idx =3D 0;
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * egalax_connect() is the routine that is called when someone adds a
+ * new serio device that supports egalax protocol and registers it as
+ * an input device. This is usually accomplished using inputattach.
+ */
+static int egalax_connect(struct serio *serio, struct serio_driver *dr=
v)
+{
+	struct egalax *egalax;
+	struct input_dev *input_dev;
+	int error;
+
+	egalax =3D kzalloc(sizeof(struct egalax), GFP_KERNEL);
+	input_dev =3D input_allocate_device();
+	if (!egalax) {
+		error =3D -ENOMEM;
+		goto err_free_mem;
+	}
+
+	egalax->serio =3D serio;
+	egalax->input =3D input_dev;
+	snprintf(egalax->phys, sizeof(egalax->phys),
+		 "%s/input0", serio->phys);
+
+	input_dev->name =3D "EETI eGalaxTouch Serial TouchScreen";
+	input_dev->phys =3D egalax->phys;
+	input_dev->id.bustype =3D BUS_RS232;
+	input_dev->id.vendor =3D SERIO_EGALAX;
+	input_dev->id.product =3D 0;
+	input_dev->id.version =3D 0x0001;
+	input_dev->dev.parent =3D &serio->dev;
+
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X,
+			     EGALAX_MIN_XC, EGALAX_MAX_XC, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y,
+			     EGALAX_MIN_YC, EGALAX_MAX_YC, 0, 0);
+
+	serio_set_drvdata(serio, egalax);
+
+	error =3D serio_open(serio, drv);
+	if (error)
+		goto err_reset_drvdata;
+
+	error =3D input_register_device(input_dev);
+	if (error)
+		goto err_close_serio;
+
+	return 0;
+
+err_close_serio:
+	serio_close(serio);
+err_reset_drvdata:
+	serio_set_drvdata(serio, NULL);
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(egalax);
+	return error;
+}
+
+static void egalax_disconnect(struct serio *serio)
+{
+	struct egalax *egalax =3D serio_get_drvdata(serio);
+
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_unregister_device(egalax->input);
+	kfree(egalax);
+}
+
+/*
+ * The serio driver structure.
+ */
+
+static const struct serio_device_id egalax_serio_ids[] =3D {
+	{
+		.type	=3D SERIO_RS232,
+		.proto	=3D SERIO_EGALAX,
+		.id	=3D SERIO_ANY,
+		.extra	=3D SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, egalax_serio_ids);
+
+static struct serio_driver egalax_drv =3D {
+	.driver		=3D {
+		.name	=3D "egalax",
+	},
+	.description	=3D DRIVER_DESC,
+	.id_table	=3D egalax_serio_ids,
+	.interrupt	=3D egalax_interrupt,
+	.connect	=3D egalax_connect,
+	.disconnect	=3D egalax_disconnect,
+};
+module_serio_driver(egalax_drv);
+
+MODULE_AUTHOR("Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/serio.h b/include/uapi/linux/serio.h
index becdd78..c2ea169 100644
--- a/include/uapi/linux/serio.h
+++ b/include/uapi/linux/serio.h
@@ -77,5 +77,6 @@
 #define SERIO_PS2MULT	0x3c
 #define SERIO_TSC40	0x3d
 #define SERIO_WACOM_IV	0x3e
+#define SERIO_EGALAX	0x3f
=20
 #endif /* _UAPI_SERIO_H */
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
