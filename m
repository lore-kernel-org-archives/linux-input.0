From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH v2] input: Add a driver TSC-40 (serial)
Date: Mon, 26 Sep 2011 11:52:14 +0200
Message-ID: <CAH9NwWc=6VzBV-a-P=7Hogju8bL-5hGdcAaN40PkrT2Exppd0A@mail.gmail.com>
References: <CAH9NwWfPwg69DpGNyd0rDs=OEDpBxrD_D_QPuunwMLN1iF3nyw@mail.gmail.com>
 <20110923174404.GA25516@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63685 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1IZJwf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 05:52:35 -0400
Received: by iaqq3 with SMTP id q3so4368444iaq.19
        for <linux-input@vger.kernel.org>; Mon, 26 Sep 2011 02:52:35 -0700 (PDT)
In-Reply-To: <20110923174404.GA25516@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi Dmitry,

2011/9/23 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Christian,
>
> On Fri, Sep 23, 2011 at 12:35:31PM +0200, Christian Gmeiner wrote:
>> From 7fc3295f1a4d987af846851f13d185e5f5877411 Mon Sep 17 00:00:00 20=
01
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Date: Fri, 23 Sep 2011 14:22:18 +0200
>> Subject: [PATCH v2] input: Add a driver TSC40 (serial)
>>
>> This patch adds the TSC-40 serial touchscreen driver and
>> should be compatible with TSC-10 and TSC-25.
>>
>> The driver was written by Linutronix on behalf of
>> Bachmann electronic GmbH.
>>
>> Changes v1 -> v2:
>> - initialisation of the controller moved to inputattach
>
> Was the patch to inputattach posted here?

Not yet... will do it when I post a new version of the patch.

>
>> - incorporated feedback from Dmitry Torokhov and
>> =C2=A0 Sebastian Andrzej Siewior
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>> ---
>> =C2=A0drivers/input/touchscreen/Kconfig =C2=A0| =C2=A0 =C2=A07 ++
>> =C2=A0drivers/input/touchscreen/Makefile | =C2=A0 =C2=A01 +
>> =C2=A0drivers/input/touchscreen/tsc40.c =C2=A0| =C2=A0176 ++++++++++=
++++++++++++++++++++++++++
>> =C2=A0include/linux/serio.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A04 files changed, 185 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 drivers/input/touchscreen/tsc40.c
>>
>> diff --git a/drivers/input/touchscreen/Kconfig
>> b/drivers/input/touchscreen/Kconfig
>> index cabd9e5..c1b6ed9 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -651,6 +651,13 @@ config TOUCHSCREEN_TOUCHIT213
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, choo=
se M here: the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 module will be called touchit213.
>>
>> +config TOUCHSCREEN_TSC_SERIO
>> + =C2=A0 =C2=A0 tristate "TSC-10/25/40 serial touchscreen"
>> + =C2=A0 =C2=A0 select SERIO
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 Say Y here if you have a TSC-10, 25 or 40 ser=
ial touchscreen connected
>> + =C2=A0 =C2=A0 =C2=A0 to your system.
>> +
>
> "To compile this driver as a module..."

okay

>
>> =C2=A0config TOUCHSCREEN_TSC2005
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "TSC2005 based touchscree=
ns"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SPI_MASTER && GENERIC_H=
ARDIRQS
>> diff --git a/drivers/input/touchscreen/Makefile
>> b/drivers/input/touchscreen/Makefile
>> index 282d6f7..f957676 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -46,6 +46,7 @@ obj-$(CONFIG_TOUCHSCREEN_TNETV107X) +=3D tnetv107x=
-ts.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213) +=3D touchit213.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT) +=3D touchright.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN) =C2=A0 +=3D touchwin.o
>> +obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO) =C2=A0+=3D tsc40.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TSC2005) =C2=A0 =C2=A0+=3D tsc2005.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TSC2007) =C2=A0 =C2=A0+=3D tsc2007.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_UCB1400) =C2=A0 =C2=A0+=3D ucb1400_ts=
=2Eo
>> diff --git a/drivers/input/touchscreen/tsc40.c
>> b/drivers/input/touchscreen/tsc40.c
>> new file mode 100644
>> index 0000000..eeb53a8
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/tsc40.c
>> @@ -0,0 +1,176 @@
>> +/*
>> + * TSC-40 serial touchscreen driver. It should be compatiible with
>> TSC-10 and 25.
>> + * Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> + * License: GPLv2 as published by the FSF.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/input.h>
>> +#include <linux/serio.h>
>> +#include <linux/init.h>
>> +
>> +#define PACKET_LENGTH =C2=A05
>> +struct tsc_ser {
>> + =C2=A0 =C2=A0 struct input_dev *dev;
>> + =C2=A0 =C2=A0 struct serio *serio;
>> + =C2=A0 =C2=A0 u32 idx;
>> + =C2=A0 =C2=A0 unsigned char data[PACKET_LENGTH];
>> + =C2=A0 =C2=A0 char phys[32];
>> +};
>> +
>> +static void tsc_process_data(struct tsc_ser *ptsc)
>> +{
>> + =C2=A0 =C2=A0 struct input_dev *dev =3D ptsc->dev;
>> + =C2=A0 =C2=A0 u8 *data =3D ptsc->data;
>> + =C2=A0 =C2=A0 u32 x;
>> + =C2=A0 =C2=A0 u32 y;
>> + =C2=A0 =C2=A0 u32 touch;
>> +
>> + =C2=A0 =C2=A0 x =3D ((data[1] & 0x03) << 8) | data[2];
>> + =C2=A0 =C2=A0 y =3D ((data[3] & 0x03) << 8) | data[4];
>> + =C2=A0 =C2=A0 touch =3D data[0] & 0x01;
>> +
>> + =C2=A0 =C2=A0 input_report_abs(dev, ABS_X, x);
>> + =C2=A0 =C2=A0 input_report_abs(dev, ABS_Y, y);
>> + =C2=A0 =C2=A0 input_report_abs(dev, ABS_PRESSURE, touch << 7);
>
> The device does not seem to produce valud pressure readings so please=
 do
> not fake ABS_PRESSURE events. Tslib has been updated several years ag=
o
> so that it does not require ABS_PRESSURE.

fine.. will remove it

>
>> + =C2=A0 =C2=A0 input_report_key(dev, BTN_TOUCH, touch);
>> +
>> + =C2=A0 =C2=A0 input_sync(dev);
>> +
>> + =C2=A0 =C2=A0 ptsc->idx =3D 0;
>> +}
>> +
>> +static int pen_is_up(u8 data)
>
> bool.

okay

>
>> +{
>> + =C2=A0 =C2=A0 /* SW[01] are unknown */
>> + =C2=A0 =C2=A0 u8 val =3D data & 0x3f;
>> + =C2=A0 =C2=A0 u8 up_val =3D 1 << 4;
>> +
>> + =C2=A0 =C2=A0 return val =3D=3D up_val;
>> +}
>> +
>> +static irqreturn_t tsc_interrupt(struct serio *serio,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char data, unsi=
gned int flags)
>> +{
>> + =C2=A0 =C2=A0 struct tsc_ser *ptsc =3D serio_get_drvdata(serio);
>> + =C2=A0 =C2=A0 struct input_dev *dev =3D ptsc->dev;
>> +
>> + =C2=A0 =C2=A0 if (!ptsc->idx && pen_is_up(data)) {
>
> I am curious, does the device really transmit single byte when pen is
> lifted up?
>

Have a look at the datasheet page 17 "Data description"
http://www.distec.de/PDF/Drivers/DMC/TSC40_Protocol_Description.pdf

greets
--
Christian Gmeiner, MSc
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
