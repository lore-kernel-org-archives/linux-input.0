From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH v3] input: Add a driver TSC-40 (serial)
Date: Wed, 28 Sep 2011 11:44:08 +0200
Message-ID: <CAH9NwWe-FeoKqCKSefB+gmk1_CGH6GfAdfzNfn-oGS92d+=Ckg@mail.gmail.com>
References: <CAH9NwWetEaxzNihxRduvnWN0ADfJKADALmyeUVZnxr5cz-eU2A@mail.gmail.com>
 <20110928044430.GA28341@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65488 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab1I1Jo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Sep 2011 05:44:28 -0400
Received: by iaqq3 with SMTP id q3so6704156iaq.19
        for <linux-input@vger.kernel.org>; Wed, 28 Sep 2011 02:44:28 -0700 (PDT)
In-Reply-To: <20110928044430.GA28341@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi Dmitry.

2011/9/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Christian,
>
> On Tue, Sep 27, 2011 at 09:30:10AM +0200, Christian Gmeiner wrote:
>> From e90718a2fa33442c3897185653cbf5fd9a9d7bfe Mon Sep 17 00:00:00 20=
01
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Date: Tue, 27 Sep 2011 11:22:25 +0200
>> Subject: [PATCH v3] input: Add a driver TSC-40 (serial)
>>
>> This patch adds the TSC-40 serial touchscreen driver and
>> should be compatible with TSC-10 and TSC-25.
>>
>> The driver was written by Linutronix on behalf of
>> Bachmann electronic GmbH.
>>
>
> Looking at the data sheet you mentioned it looks like it should be
> possible to perform some validation of the data stream coming from th=
e
> device. Could you please tell me if the version below still works for
> you?
>

Touch is working as expected. I only found a very simple problem - see =
below.
I hope that the driver makes it into 3.2.

>
> Input: add a driver for TSC-40 serial touchscreen
>
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> This patch adds the TSC-40 serial touchscreen driver and should be
> compatible with TSC-10 and TSC-25.
>
> The driver was written by Linutronix on behalf of Bachmann electronic=
 GmbH.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =C2=A0drivers/input/touchscreen/Kconfig =C2=A0| =C2=A0 12 ++
> =C2=A0drivers/input/touchscreen/Makefile | =C2=A0 =C2=A01
> =C2=A0drivers/input/touchscreen/tsc40.c =C2=A0| =C2=A0180 +++++++++++=
+++++++++++++++++++++++++
> =C2=A0include/linux/serio.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01
> =C2=A04 files changed, 194 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/input/touchscreen/tsc40.c
>
>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index c27b28e..11a67e3 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -712,6 +712,18 @@ config TOUCHSCREEN_TOUCHIT213
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module,=
 choose M here: the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called touchit213.
>
> +config TOUCHSCREEN_TSC_SERIO
> + =C2=A0 =C2=A0 =C2=A0 tristate "TSC-10/25/40 serial touchscreen supp=
ort"
> + =C2=A0 =C2=A0 =C2=A0 select SERIO
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here if you have a TSC-10, 25 or =
40 serial touchscreen connected
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 to your system.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, cho=
ose M here: the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 module will be called tsc40.
> +
> =C2=A0config TOUCHSCREEN_TSC2005
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 tristate "TSC2005 based touchscreens"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on SPI_MASTER && GENERIC_HARDIRQS
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index f2a1f0b..d697e16 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_TNETV107X) =C2=A0 +=3D tne=
tv107x-ts.o
> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213) =C2=A0 +=3D touchit213.o
> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT) =C2=A0 +=3D touchright.o
> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN) =C2=A0 =C2=A0 +=3D touchwin.=
o
> +obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO) =C2=A0 =C2=A0+=3D tsc40.o
> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TSC2005) =C2=A0 =C2=A0 =C2=A0+=3D tsc2=
005.o
> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TSC2007) =C2=A0 =C2=A0 =C2=A0+=3D tsc2=
007.o
> =C2=A0obj-$(CONFIG_TOUCHSCREEN_UCB1400) =C2=A0 =C2=A0 =C2=A0+=3D ucb1=
400_ts.o
> diff --git a/drivers/input/touchscreen/tsc40.c b/drivers/input/touchs=
creen/tsc40.c
> new file mode 100644
> index 0000000..1a7b357
> --- /dev/null
> +++ b/drivers/input/touchscreen/tsc40.c
> @@ -0,0 +1,180 @@
> +/*
> + * TSC-40 serial touchscreen driver. It should be compatible with TS=
C-10 and 25.
> + * Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> + * License: GPLv2 as published by the FSF.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/serio.h>
> +#include <linux/init.h>
> +
> +#define PACKET_LENGTH =C2=A05
> +struct tsc_ser {
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *dev;
> + =C2=A0 =C2=A0 =C2=A0 struct serio *serio;
> + =C2=A0 =C2=A0 =C2=A0 u32 idx;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char data[PACKET_LENGTH];
> + =C2=A0 =C2=A0 =C2=A0 char phys[32];
> +};
> +
> +static void tsc_process_data(struct tsc_ser *ptsc)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *dev =3D ptsc->dev;
> + =C2=A0 =C2=A0 =C2=A0 u8 *data =3D ptsc->data;
> + =C2=A0 =C2=A0 =C2=A0 u32 x;
> + =C2=A0 =C2=A0 =C2=A0 u32 y;
> +
> + =C2=A0 =C2=A0 =C2=A0 x =3D ((data[1] & 0x03) << 8) | data[2];
> + =C2=A0 =C2=A0 =C2=A0 y =3D ((data[3] & 0x03) << 8) | data[4];
> +
> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(dev, ABS_X, x);
> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(dev, ABS_Y, y);
> + =C2=A0 =C2=A0 =C2=A0 input_report_key(dev, BTN_TOUCH, 1);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_sync(dev);
> +}
> +
> +static irqreturn_t tsc_interrupt(struct serio *serio,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char data=
, unsigned int flags)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct tsc_ser *ptsc =3D serio_get_drvdata(ser=
io);
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *dev =3D ptsc->dev;
> +
> + =C2=A0 =C2=A0 =C2=A0 ptsc->data[ptsc->idx] =3D data;
> + =C2=A0 =C2=A0 =C2=A0 switch (ptsc->idx++) {
> + =C2=A0 =C2=A0 =C2=A0 case 0:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely((data=
 & 0x3e) !=3D 0x10)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_dbg(&serio->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "unsynchronized packet start (0x%02=
x)\n", data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ptsc->idx =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!(data =
& 0x01)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 input_report_key(dev, BTN_TOUCH, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 input_sync(dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ptsc->idx =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case 1:
> + =C2=A0 =C2=A0 =C2=A0 case 3:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(data =
& 0xfc)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_dbg(&serio->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "unsynchronized data 0x%02x at offs=
et %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data, ptsc->idx - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ptsc->idx =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case 4:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tsc_process_data(p=
tsc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptsc->idx =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}
> +
> +static int tsc_connect(struct serio *serio, struct serio_driver *drv=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct tsc_ser *ptsc;
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *input_dev;
> + =C2=A0 =C2=A0 =C2=A0 int error;
> +
> + =C2=A0 =C2=A0 =C2=A0 ptsc =3D kzalloc(sizeof(struct tsc_ser), GFP_K=
ERNEL);
> + =C2=A0 =C2=A0 =C2=A0 input_dev =3D input_allocate_device();
> + =C2=A0 =C2=A0 =C2=A0 if (!ptsc || !input_dev) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ptsc->serio =3D serio;
> + =C2=A0 =C2=A0 =C2=A0 ptsc->dev =3D input_dev;
> + =C2=A0 =C2=A0 =C2=A0 snprintf(ptsc->phys, sizeof(ptsc->phys), "%s/i=
nput0", serio->phys);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_dev->name =3D "TSC-10/25/40 Serial Touch=
Screen";
> + =C2=A0 =C2=A0 =C2=A0 input_dev->phys =3D ptsc->phys;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->id.bustype =3D BUS_RS232;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->id.vendor =3D SERIO_TSC40;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->id.product =3D 40;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->id.version =3D 0x0001;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->dev.parent =3D &serio->dev;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT=
_MASK(EV_ABS);
> + =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOUCH, input_dev->keybit);
> + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(ptsc->dev, ABS_X, 0, 0x3f=
f, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(ptsc->dev, ABS_Y, 0, 0x3f=
f, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(ptsc->dev, ABS_PRESSURE, =
0, 0, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 serio_set_drvdata(serio, ptsc);
> +
> + =C2=A0 =C2=A0 =C2=A0 error =3D serio_open(serio, drv);
> + =C2=A0 =C2=A0 =C2=A0 if (error)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail2;
> +
> + =C2=A0 =C2=A0 =C2=A0 error =3D input_register_device(ptsc->dev);
> + =C2=A0 =C2=A0 =C2=A0 if (error)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail3;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +fail3:
> + =C2=A0 =C2=A0 =C2=A0 serio_close(serio);
> +fail2:
> + =C2=A0 =C2=A0 =C2=A0 serio_set_drvdata(serio, NULL);
> +fail1:
> + =C2=A0 =C2=A0 =C2=A0 input_free_device(input_dev);
> + =C2=A0 =C2=A0 =C2=A0 kfree(ptsc);
> + =C2=A0 =C2=A0 =C2=A0 return error;
> +}
> +
> +static void tsc_disconnect(struct serio *serio)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct tsc_ser *ptsc =3D serio_get_drvdata(ser=
io);
> +
> + =C2=A0 =C2=A0 =C2=A0 serio_close(serio);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_unregister_device(ptsc->dev);
> + =C2=A0 =C2=A0 =C2=A0 kfree(ptsc);
> +
> + =C2=A0 =C2=A0 =C2=A0 serio_set_drvdata(serio, NULL);
> +}
> +
> +static struct serio_device_id tsc_serio_ids[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =C2=A0 =3D S=
ERIO_RS232,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .proto =C2=A0=3D S=
ERIO_TSC40,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =
=3D SERIO_ANY,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .extra =C2=A0=3D S=
ERIO_ANY,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 { 0 }
> +};
> +MODULE_DEVICE_TABLE(serio, tsc_serio_ids);
> +
> +#define DRIVER_DESC =C2=A0 =C2=A0"TSC-10/25/40 serial touchscreen dr=
iver"
> +
> +static struct serio_driver tsc_drv =3D {
> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "=
tsc40",
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .description =C2=A0 =C2=A0=3D DRIVER_DESC,
> + =C2=A0 =C2=A0 =C2=A0 .id_table =C2=A0 =C2=A0 =C2=A0 =3D tsc_serio_i=
ds,
> + =C2=A0 =C2=A0 =C2=A0 .interrupt =C2=A0 =C2=A0 =C2=A0=3D tsc_interru=
pt,
> + =C2=A0 =C2=A0 =C2=A0 .connect =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D tsc_co=
nnect,
> + =C2=A0 =C2=A0 =C2=A0 .disconnect =C2=A0 =C2=A0 =3D tsc_disconnect,
> +};
> +
> +static int __init tsc_ser_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return serio_register_driver(&tsc_drv);
> +}
> +module_init(tsc_ser_init);
> +
> +static void __exit tsc_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 serio_unregister_driver(&tsc_drv);
> +}
> +module_exit(tsc_exit);
> +
> +MODULE_AUTHOR("Sebastian Andrzej Siewior <bigeasy@linutronix.de>");
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPLv2");

There is a typo.. should be
MODULE_LICENSE("GPL v2");

root@OT:~# modprobe tsc40
[   43.086732] tsc40: module license 'GPLv2' taints kernel.
[   43.087602] Disabling lock debugging due to kernel taint

Can you fix it or should I resend a v4?

> diff --git a/include/linux/serio.h b/include/linux/serio.h
> index e26f478..be7dfb0 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -199,5 +199,6 @@ static inline void serio_continue_rx(struct serio=
 *serio)
> =C2=A0#define SERIO_DYNAPRO =C2=A00x3a
> =C2=A0#define SERIO_HAMPSHIRE =C2=A0 =C2=A0 =C2=A0 =C2=A00x3b
> =C2=A0#define SERIO_PS2MULT =C2=A00x3c
> +#define SERIO_TSC40 =C2=A0 =C2=A00x3d
>
> =C2=A0#endif
>

Thanks
--
Christian Gmeiner, MSc
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
