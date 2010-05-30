From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Input: Add tsc2046 touchscreen driver
Date: Sun, 30 May 2010 13:21:01 -0700
Message-ID: <AANLkTike4Hu6xJ52fcC9TcKaeD4hLeWxHwUvA90tc3_Q@mail.gmail.com>
References: <1260736754-374-1-git-send-email-darkstar6262@gmail.com>
	<20100417082841.GB19866@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36518 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab0E3UVX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 16:21:23 -0400
Received: by pvg11 with SMTP id 11so1072403pvg.19
        for <linux-input@vger.kernel.org>; Sun, 30 May 2010 13:21:22 -0700 (PDT)
In-Reply-To: <20100417082841.GB19866@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Sat, Apr 17, 2010 at 1:28 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Cory,
>
> Sorry for not reviewing the driver earlier.
>
> On Sun, Dec 13, 2009 at 12:39:14PM -0800, Cory Maccarrone wrote:
>> This change implements a new driver for the TSC2046-series
>> touchscreen found on many HTC OMAP850-based smartphones.
>> This driver differs from the ADS7846 in that it uses 16-bit
>> commands instead of 8-bit, and does not include temerature
>> or voltage sensing capabilities.
>>
>> This driver was submitted in May of 2007 to the linux-omap
>> list at:
>>
>> http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/0097=
45.html
>>
>> This is a resubmit of this driver, with additions that allows
>> the injection of pointercal parameters from tslib through
>> /sys. =C2=A0This was done for the Wing Linux project primarily to
>> allow this touchscreen to work with Android, but it's useful for
>> any userspace that doesn't support tslib calibration. =C2=A0Pointerc=
al
>> use is optional -- it produces raw parameters unless the use_pointer=
cal
>> /sys file is set to 1.
>
> The current poiicy is simply use tslib and push the filtering and
> scaling out of the kernel. I do not see the reason for this driver be=
 an
> exception.
>
>>
>> Though this driver was previously submitted to linux-omap, there
>> is nothing omap-specific in this driver.
>>
>
> Overall I would like to see this being not a standalone driver but
> instead tsc2046 support being plugged into existing tsc2007, extendin=
g
> it. There are a few of TSC drivers floating around, all of them very
> similar, with the difference of the transport (i2c vs spi) and regist=
er
> sets but all having very similar core interrupt handling, suspend and
> resume algorithms... This is a waste.
>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> ---
>> =C2=A0drivers/input/touchscreen/Kconfig =C2=A0 | =C2=A0 14 +
>> =C2=A0drivers/input/touchscreen/Makefile =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0drivers/input/touchscreen/tsc2046.c | =C2=A0740 ++++++++++++++=
+++++++++++++++++++++
>> =C2=A0include/linux/input/tsc2046.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 26=
 ++
>> =C2=A04 files changed, 781 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 drivers/input/touchscreen/tsc2046.c
>> =C2=A0create mode 100644 include/linux/input/tsc2046.h
>>
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touch=
screen/Kconfig
>> index 8cc453c..1f3273b 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -501,6 +501,20 @@ config TOUCHSCREEN_TOUCHIT213
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, choo=
se M here: the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 module will be called touchit213.
>>
>> +config TOUCHSCREEN_TSC2046
>> + =C2=A0 =C2=A0 tristate "TSC2046 based touchscreens"
>> + =C2=A0 =C2=A0 depends on SPI_MASTER
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 Say Y here if you have a touchscreen interfac=
e using the
>> + =C2=A0 =C2=A0 =C2=A0 TI TSC 2046 controller, and your board-specif=
ic initialization
>> + =C2=A0 =C2=A0 =C2=A0 code includes that in its table of SPI device=
s. =C2=A0Also make
>> + =C2=A0 =C2=A0 =C2=A0 sure the proper SPI controller is selected.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 If unsure, say N (but it's safe to say "Y").
>> +
>> + =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, choose M =
here: the
>> + =C2=A0 =C2=A0 =C2=A0 module will be called tsc2046.
>> +
>> =C2=A0config TOUCHSCREEN_TSC2007
>> =C2=A0 =C2=A0 =C2=A0 tristate "TSC2007 based touchscreens"
>> =C2=A0 =C2=A0 =C2=A0 depends on I2C
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touc=
hscreen/Makefile
>> index 15fa62c..3c413f7 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -30,6 +30,7 @@ obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213) =C2=A0 =C2=A0=
 =C2=A0 =C2=A0+=3D touchit213.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT) +=3D touchright.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN) =C2=A0 +=3D touchwin.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_TSC2007) =C2=A0 =C2=A0+=3D tsc2007.o
>> +obj-$(CONFIG_TOUCHSCREEN_TSC2046) =C2=A0 =C2=A0+=3D tsc2046.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_UCB1400) =C2=A0 =C2=A0+=3D ucb1400_ts=
=2Eo
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0+=3D wacom_w8001.o
>> =C2=A0obj-$(CONFIG_TOUCHSCREEN_WM97XX) =C2=A0 =C2=A0 +=3D wm97xx-ts.=
o
>> diff --git a/drivers/input/touchscreen/tsc2046.c b/drivers/input/tou=
chscreen/tsc2046.c
>> new file mode 100644
>> index 0000000..e45d251
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/tsc2046.c
>> @@ -0,0 +1,740 @@
>> +/*
>> + * TSC2046 Touchscreen driver
>> + *
>> + * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.c=
om>
>> + *
>> + * Communication details from original TI driver
>> + * Copyright (C) 2004-2005 Texas Instruments, Inc.
>> + *
>> + * Structure based heavily on TSC2301 driver
>> + * Copyright (C) 2005-2006 Nokia Corporation
>> + *
>> + * 2007 (c) MontaVista Software, Inc. This file is licensed under
>> + * the terms of the GNU General Public License version 2. This prog=
ram
>> + * is licensed "as is" without any warranty of any kind, whether ex=
press
>> + * or implied.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/input.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/gpio.h>
>> +
>> +#include <linux/input/tsc2046.h>
>> +
>> +/* TSC2046 commands */
>> +#define START_BYTE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8000
>> +#define X_CMDWD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00xd300
>> +#define Y_CMDWD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x9300
>> +#define Z1_CMDWD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xb300
>> +#define Z2_CMDWD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc300
>> +
>> +#define TSC2046_TS_SCAN_TIME 1
>> +#define MAX_12BIT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((1 << 1=
2) - 1)
>> +
>> +#define MIN_ABS_X =C2=A0 =C2=A0528
>> +#define MAX_ABS_X =C2=A0 =C2=A03760
>> +#define MIN_ABS_Y =C2=A0 =C2=A0624
>> +#define MAX_ABS_Y =C2=A0 =C2=A03760
>> +
>> +/* The TSC2046 operates at a maximum speed of 2MHz */
>> +#define TSC2046_HZ =C2=A0 2000000
>> +
>> +#define CONV_DATA(d1, d2) \
>> + =C2=A0(((d1 & 0x7f) << 5) | ((d2 >> 11) & 0x1f))
>> +
>> +/* Convenience macros for pointercal calibration calculation */
>> +#define PA ts->pointercal[0]
>> +#define PB ts->pointercal[1]
>> +#define PC ts->pointercal[2]
>> +#define PD ts->pointercal[3]
>> +#define PE ts->pointercal[4]
>> +#define PF ts->pointercal[5]
>> +#define PS ts->pointercal[6]
>> +
>> +struct tsc2046_ts {
>> + =C2=A0 =C2=A0 struct input_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0*idev;
>> + =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0phys[32];
>> + =C2=A0 =C2=A0 struct timer_list =C2=A0 =C2=A0 =C2=A0 timer;
>> + =C2=A0 =C2=A0 spinlock_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0lock;
>> +
>> + =C2=A0 =C2=A0 struct spi_transfer =C2=A0 =C2=A0 read_xfer[3];
>> + =C2=A0 =C2=A0 struct spi_message =C2=A0 =C2=A0 =C2=A0read_msg;
>> + =C2=A0 =C2=A0 struct spi_message =C2=A0 =C2=A0 =C2=A0enable_msg;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 data[5];
>> +
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 x;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 y;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 p;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 old_x;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 old_y;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 old_pressure;
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 sample_cnt;
>> +
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ignore_last : 1;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 x_plate_ohm;
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 max_pressure;
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 touch_pressure;
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pressure_limit;
>> +
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pointercal[7];
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 x_res;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 y_res;
>> +
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 irq_enabled:1;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pen_down:1;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 disabled:1;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pending:1;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 use_pointercal:1;
>> +
>> + =C2=A0 =C2=A0 s16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 dav_gpio;
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (*get_pendown_state)(void);
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 irq;
>> +};
>> +
>> +struct tsc2046 {
>> + =C2=A0 =C2=A0 struct spi_device =C2=A0 =C2=A0 =C2=A0 *spi;
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts;
>> +};
>
> Why is such a split?
>
>> +
>> +static const u16 tsc2046_ts_cmd_data[] =3D {
>> + =C2=A0 =C2=A0 START_BYTE, X_CMDWD, Y_CMDWD, Z1_CMDWD, Z2_CMDWD,
>> +};
>> +
>> +static int tsc2046_device_suspended(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 *tsc =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 return dev->power.power_state.event !=3D PM_EVENT_ON=
 || tsc->ts->disabled;
>> +}
>> +
>> +static void tsc2046_update_pen_state(struct tsc2046 *tsc, int x, in=
t y, int pressure)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> +
>> + =C2=A0 =C2=A0 if (x <=3D ts->old_x - 4 || x >=3D ts->old_x + 4 ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 y <=3D ts->old_y - 4 || y >=3D ts->old=
_y + 4 ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 pressure <=3D ts->old_pressure - 4 || =
pressure >=3D ts->old_pressure + 4)
>> + =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pressure) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!ts->use_pointercal || (ts->use_pointercal &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 x >=3D 0 &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 x <=3D ts->x_res - 1 &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 y >=3D 0 &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 y <=3D ts->y_res - 1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs(ts->idev, ABS_X, x);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs(ts->idev, ABS_Y, y);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs(ts->idev, ABS_PRESSURE=
, 1);
>
> Why don't you report true pressure reading instead of clamping to [0,=
1]
> range?
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(ts->idev, BTN_TOUCH, 1=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->pen_down =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs(ts->idev, ABS_PRESSURE=
, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(ts->idev, BTN_TOUCH, 0=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->pen_down =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 input_report_abs(ts->idev, ABS_PRESSURE, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 input_report_key(ts->idev, BTN_TOUCH, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ts->pen_down =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->old_x =3D x;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->old_y =3D y;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->old_pressure =3D pre=
ssure;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(ts->idev);
>> +
>> +#ifdef VERBOSE
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&tsc->spi->dev, =
"x %4d y %4d p %4d\n", x, y, pressure);
>> +#endif
>
> dev_vdbg().
>
>
>> + =C2=A0 =C2=A0 }
>> +}
>> +
>> +/*
>> + * This procedure is called by the SPI framework after the coordina=
tes
>> + * have been read from TSC2046
>> + */
>> +static void tsc2046_ts_rx(void *arg)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 *tsc =3D arg;
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> + =C2=A0 =C2=A0 unsigned int x, y, z1, z2, pressure;
>> + =C2=A0 =C2=A0 int xN, yN;
>> +
>> + =C2=A0 =C2=A0 x =C2=A0=3D CONV_DATA(ts->data[2], ts->data[3]);
>> + =C2=A0 =C2=A0 y =C2=A0=3D CONV_DATA(ts->data[1], ts->data[2]);
>> + =C2=A0 =C2=A0 z1 =3D CONV_DATA(ts->data[3], ts->data[4]);
>> + =C2=A0 =C2=A0 z2 =3D CONV_DATA(ts->data[4], 0);
>> +
>> + =C2=A0 =C2=A0 if (z1) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pressure =3D ts->x_plate=
_ohm * x;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pressure /=3D 4096;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pressure *=3D z2 - z1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pressure /=3D z1;
>> + =C2=A0 =C2=A0 } else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pressure =3D 0;
>> +
>> + =C2=A0 =C2=A0 if (ts->use_pointercal) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Transform pen state a=
ccording to calibration parameters. =C2=A0This
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* algorithm is the=
 same used by tslib and Qt to do 7-value
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* screen transform=
s. =C2=A0See:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* http://doc.troll=
tech.com/4.3/qwscalibratedmousehandler.html#transform
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xN =3D ((PA * x) + (PB *=
 y) + PC) / PS;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yN =3D ((PD * x) + (PE *=
 y) + PF) / PS;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x =3D (xN < 0) ? 0 : (xN=
 > ts->x_res ? ts->x_res - 1 : (unsigned int)xN);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y =3D (yN < 0) ? 0 : (yN=
 > ts->y_res ? ts->y_res - 1 : (unsigned int)yN);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 /* If pressure value is above a preset limit (pen is=
 barely
>> + =C2=A0 =C2=A0 =C2=A0* touching the screen) we can't trust the coor=
dinate values.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 if (pressure < ts->pressure_limit && x < MAX_12BIT &=
& y < MAX_12BIT) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->pressure_limit =3D t=
s->max_pressure;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ts->ignore_last) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ts->sample_cnt)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tsc2046_update_pen_state(tsc, ts->x, ts=
->y, ts->p);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ts->x =3D x;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ts->y =3D y;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ts->p =3D pressure;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tsc2046_update_pen_state(tsc, x, y, pressure);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->sample_cnt++;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 mod_timer(&ts->timer,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 jiffies + msecs_t=
o_jiffies(TSC2046_TS_SCAN_TIME));
>> +}
>> +
>> +static int tsc2046_is_pen_down(struct tsc2046_ts *ts)
>> +{
>> + =C2=A0 =C2=A0 return ts->pen_down;
>> +}
>> +
>> +static int tsc2046_get_pendown_state(struct tsc2046_ts *ts)
>> +{
>> + =C2=A0 =C2=A0 if (ts->get_pendown_state)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ts->get_pendown_s=
tate();
>> +
>> + =C2=A0 =C2=A0 return !gpio_get_value(ts->dav_gpio);
>> +}
>> +
>> +/*
>> + * Timer is called every TSC2046_TS_SCAN_TIME when the pen is down
>> + */
>> +static void tsc2046_ts_timer(unsigned long arg)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 *tsc =3D (void *) arg;
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> + =C2=A0 =C2=A0 unsigned long flags;
>> + =C2=A0 =C2=A0 int ndav;
>> + =C2=A0 =C2=A0 int r;
>> +
>> + =C2=A0 =C2=A0 spin_lock_irqsave(&ts->lock, flags);
>> + =C2=A0 =C2=A0 ndav =3D tsc2046_get_pendown_state(ts);
>> + =C2=A0 =C2=A0 if (!ndav || tsc2046_device_suspended(&tsc->spi->dev=
)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Pen has been lifted *=
/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tsc2046_device_susp=
ended(&tsc->spi->dev) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !ts->irq_e=
nabled)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ts->irq_enabled =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 enable_irq(ts->irq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tsc2046_update_pen_state=
(tsc, 0, 0, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->pending =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&=
ts->lock, flags);
>> +
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->pen_down =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&=
ts->lock, flags);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D spi_async(tsc->spi=
, &ts->read_msg);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_err(&tsc->spi->dev, "ts: spi_async() failed");
>> + =C2=A0 =C2=A0 }
>> +}
>> +
>> +/*
>> + * This interrupt is called when pen is down and first coordinates =
are
>> + * available. That is indicated by a falling edge on DEV line. =C2=A0=
IRQ is
>> + * disabled here because while the pen is down the coordinates are
>> + * read by a timer.
>> + */
>> +static irqreturn_t tsc2046_ts_irq_handler(int irq, void *dev_id)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 *tsc =3D dev_id;
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> + =C2=A0 =C2=A0 unsigned long flags;
>> +
>> + =C2=A0 =C2=A0 spin_lock_irqsave(&ts->lock, flags);
>> + =C2=A0 =C2=A0 if (ts->irq_enabled) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->irq_enabled =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_irq_nosync(ts->i=
rq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->pending =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->pressure_limit =3D t=
s->touch_pressure;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->sample_cnt =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_timer(&ts->timer,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 jiffies + msecs_to_jiffies(TSC2046_TS_SCAN_TIME));
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 spin_unlock_irqrestore(&ts->lock, flags);
>> +
>> + =C2=A0 =C2=A0 return IRQ_HANDLED;
>> +}
>> +
>> +/* Must be called with ts->lock held */
>> +static void tsc2046_ts_disable(struct tsc2046 *tsc)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> +
>> + =C2=A0 =C2=A0 if (ts->disabled)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 ts->disabled =3D 1;
>> + =C2=A0 =C2=A0 if (!ts->pending) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->irq_enabled =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_irq(ts->irq);
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (ts->pending) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 spin_unlock_irq(&ts->lock);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 msleep(1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 spin_lock_irq(&ts->lock);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>> +}
>> +
>> +static void tsc2046_ts_enable(struct tsc2046 *tsc)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> +
>> + =C2=A0 =C2=A0 if (!ts->disabled)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 ts->disabled =3D 0;
>> + =C2=A0 =C2=A0 ts->irq_enabled =3D 1;
>> + =C2=A0 =C2=A0 enable_irq(ts->irq);
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +int tsc2046_ts_suspend(struct tsc2046 *tsc)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> +
>> + =C2=A0 =C2=A0 spin_lock_irq(&ts->lock);
>> + =C2=A0 =C2=A0 tsc2046_ts_disable(tsc);
>> + =C2=A0 =C2=A0 spin_unlock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +void tsc2046_ts_resume(struct tsc2046 *tsc)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> +
>> + =C2=A0 =C2=A0 spin_lock_irq(&ts->lock);
>> + =C2=A0 =C2=A0 tsc2046_ts_enable(tsc);
>> + =C2=A0 =C2=A0 spin_unlock_irq(&ts->lock);
>> +}
>> +#endif
>> +
>> +static void tsc2046_ts_setup_spi_xfer(struct tsc2046 *tsc)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> + =C2=A0 =C2=A0 struct spi_message *m =3D &ts->read_msg;
>> + =C2=A0 =C2=A0 struct spi_transfer *x =3D &ts->read_xfer[1];
>> +
>> + =C2=A0 =C2=A0 spi_message_init(m);
>> +
>> + =C2=A0 =C2=A0 /* read and write data in one transaction */
>> + =C2=A0 =C2=A0 x->tx_buf =3D &tsc2046_ts_cmd_data;
>> + =C2=A0 =C2=A0 x->rx_buf =3D &ts->data;
>> + =C2=A0 =C2=A0 x->len =C2=A0 =C2=A0=3D 10;
>> + =C2=A0 =C2=A0 spi_message_add_tail(x, m);
>> +
>> + =C2=A0 =C2=A0 /* send another START_BYTE to (re)enable pen interru=
pts */
>> + =C2=A0 =C2=A0 x++;
>> + =C2=A0 =C2=A0 x->tx_buf =3D &tsc2046_ts_cmd_data[0];
>> + =C2=A0 =C2=A0 x->rx_buf =3D &ts->data;
>> + =C2=A0 =C2=A0 x->len =3D 2;
>> + =C2=A0 =C2=A0 spi_message_add_tail(x, m);
>> +
>> + =C2=A0 =C2=A0 m->complete =3D tsc2046_ts_rx;
>> + =C2=A0 =C2=A0 m->context =3D tsc;
>> +}
>> +
>> +/* Attribute functions */
>> +
>> +static ssize_t tsc2046_ts_use_pointercal_show(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct devic=
e_attribute *attr, char *buf)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts=
c =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts =3D tsc->=
ts;
>> +
>> + =C2=A0 =C2=A0 return sprintf(buf, "%u\n", ts->use_pointercal);
>> +}
>> +
>> +static ssize_t tsc2046_ts_use_pointercal_store(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct devi=
ce_attribute *attr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*buf, size_t count)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts=
c =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts =3D tsc->=
ts;
>> + =C2=A0 =C2=A0 char *endp;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 i =3D simple_strtoul(buf, &endp, 10);
>> + =C2=A0 =C2=A0 spin_lock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 if (i)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->use_pointercal =3D 1=
;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->use_pointercal =3D 0=
;
>> +
>> + =C2=A0 =C2=A0 spin_unlock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 return count;
>> +}
>> +
>> +static DEVICE_ATTR(use_pointercal, 0644, tsc2046_ts_use_pointercal_=
show, tsc2046_ts_use_pointercal_store);
>> +
>> +static ssize_t tsc2046_ts_pointercal_show(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct devi=
ce_attribute *attr, char *buf)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts=
c =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts =3D tsc->=
ts;
>> +
>> + =C2=A0 =C2=A0 return sprintf(buf, "%d %d %d %d %d %d %d\n", PA, PB=
, PC, PD, PE, PF, PS);
>> +}
>> +
>> +static ssize_t tsc2046_ts_pointercal_store(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct devi=
ce_attribute *attr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*buf, size_t count)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts=
c =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts =3D tsc->=
ts;
>> + =C2=A0 =C2=A0 char *endp;
>> + =C2=A0 =C2=A0 int i;
>> + =C2=A0 =C2=A0 unsigned int index =3D 0, offset =3D 0;
>> +
>> + =C2=A0 =C2=A0 spin_lock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 for (index =3D 0; index < 7; index++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Grab the numbers */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D simple_strtol(buf =
+ offset, &endp, 10);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->pointercal[index] =3D=
 i;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Skip the space */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D endp - buf + =
1;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 spin_unlock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 return count;
>> +}
>> +
>> +static DEVICE_ATTR(pointercal, 0644, tsc2046_ts_pointercal_show, ts=
c2046_ts_pointercal_store);
>> +
>> +static ssize_t tsc2046_ts_screen_res_show(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct devi=
ce_attribute *attr, char *buf)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts=
c =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts =3D tsc->=
ts;
>> +
>> + =C2=A0 =C2=A0 return sprintf(buf, "%u %u\n", ts->x_res, ts->y_res)=
;
>> +}
>> +
>> +static ssize_t tsc2046_ts_screen_res_store(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct devi=
ce_attribute *attr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*buf, size_t count)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts=
c =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts =3D tsc->=
ts;
>> + =C2=A0 =C2=A0 char *endp;
>> + =C2=A0 =C2=A0 unsigned int i, offset =3D 0;
>> +
>> + =C2=A0 =C2=A0 spin_lock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 /* Grab the x res */
>> + =C2=A0 =C2=A0 i =3D simple_strtoul(buf, &endp, 10);
>> + =C2=A0 =C2=A0 ts->x_res =3D i;
>> +
>> + =C2=A0 =C2=A0 /* Skip the space */
>> + =C2=A0 =C2=A0 offset =3D endp - buf + 1;
>> +
>> + =C2=A0 =C2=A0 /* Grab the y res */
>> + =C2=A0 =C2=A0 i =3D simple_strtoul(buf + offset, &endp, 10);
>> + =C2=A0 =C2=A0 ts->y_res =3D i;
>> +
>> + =C2=A0 =C2=A0 /* Update the device parameters */
>> + =C2=A0 =C2=A0 input_set_abs_params(ts->idev, ABS_X, 0, ts->x_res -=
 1, 0, 0);
>> + =C2=A0 =C2=A0 input_set_abs_params(ts->idev, ABS_Y, 0, ts->y_res -=
 1, 0, 0);
>> +
>> + =C2=A0 =C2=A0 spin_unlock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 return count;
>> +}
>> +
>> +static DEVICE_ATTR(screen_res, 0644, tsc2046_ts_screen_res_show, ts=
c2046_ts_screen_res_store);
>> +
>> +static ssize_t tsc2046_ts_pen_down_show(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct devi=
ce_attribute *attr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 *tsc =3D dev_get_drvdata(dev);
>> +
>> + =C2=A0 =C2=A0 return sprintf(buf, "%u\n", tsc2046_is_pen_down(tsc-=
>ts));
>> +}
>> +
>> +static DEVICE_ATTR(pen_down, S_IRUGO, tsc2046_ts_pen_down_show, NUL=
L);
>> +
>> +static ssize_t tsc2046_ts_disable_show(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct devic=
e_attribute *attr, char *buf)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts=
c =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts =3D tsc->=
ts;
>> +
>> + =C2=A0 =C2=A0 return sprintf(buf, "%u\n", ts->disabled);
>> +}
>> +
>> +static ssize_t tsc2046_ts_disable_store(struct device *dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct devi=
ce_attribute *attr,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*buf, size_t count)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts=
c =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 *ts =3D tsc->=
ts;
>> + =C2=A0 =C2=A0 char *endp;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 i =3D simple_strtoul(buf, &endp, 10);
>> + =C2=A0 =C2=A0 spin_lock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 if (i)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tsc2046_ts_disable(tsc);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tsc2046_ts_enable(tsc);
>> +
>> + =C2=A0 =C2=A0 spin_unlock_irq(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 return count;
>> +}
>> +
>> +static DEVICE_ATTR(disable_ts, 0664, tsc2046_ts_disable_show,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tsc2046_ts_=
disable_store);
>> +
>> +/* Init functions */
>> +
>> +static int __devinit tsc2046_probe(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*tsc;
>> + =C2=A0 =C2=A0 struct tsc2046_ts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 *ts;
>> + =C2=A0 =C2=A0 struct tsc2046_platform_data =C2=A0 =C2=A0*pdata =3D=
 spi->dev.platform_data;
>> + =C2=A0 =C2=A0 struct input_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*idev;
>> + =C2=A0 =C2=A0 int r =3D -ENODEV;
>> +
>> + =C2=A0 =C2=A0 dev_dbg(&spi->dev, "%s\n", __FUNCTION__);
>> +
>> + =C2=A0 =C2=A0 if (!pdata) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&spi->dev, "no p=
latform data?\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 tsc =3D kzalloc(sizeof(*tsc), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (tsc =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> +
>> + =C2=A0 =C2=A0 dev_set_drvdata(&spi->dev, tsc);
>> + =C2=A0 =C2=A0 tsc->spi =3D spi;
>> + =C2=A0 =C2=A0 spi->dev.power.power_state =3D PMSG_ON;
>> +
>> + =C2=A0 =C2=A0 spi->mode =3D SPI_MODE_1;
>> + =C2=A0 =C2=A0 spi->bits_per_word =3D 16;
>> +
>> + =C2=A0 =C2=A0 /* The max speed might've been defined by the board-=
specific
>> + =C2=A0 =C2=A0 =C2=A0* struct */
>> + =C2=A0 =C2=A0 if (!spi->max_speed_hz)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spi->max_speed_hz =3D TS=
C2046_HZ;
>> + =C2=A0 =C2=A0 spi_setup(spi);
>> +
>> + =C2=A0 =C2=A0 if (spi->irq < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&tsc->spi->dev, =
"need DAV IRQ/GPIO");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (!pdata->get_pendown_state && !gpio_is_valid(pdat=
a->gpio_pendown)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&spi->dev, "no g=
et_pendown_state nor gpio_pendown?\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ts =3D kzalloc(sizeof(*ts), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (ts =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> + =C2=A0 =C2=A0 tsc->ts =3D ts;
>> +
>> + =C2=A0 =C2=A0 if (pdata->get_pendown_state)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->get_pendown_state =3D=
 pdata->get_pendown_state;
>> + =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->dav_gpio =3D pdata->=
gpio_pendown;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D gpio_request(ts->d=
av_gpio, dev_name(&tsc->spi->dev));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_err(&tsc->spi->dev, "unable to get DAV GPIO");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto err1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_direction_input(ts-=
>dav_gpio);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ts->irq =3D spi->irq;
>> +
>> + =C2=A0 =C2=A0 init_timer(&ts->timer);
>> + =C2=A0 =C2=A0 ts->timer.data =3D (unsigned long) tsc;
>> + =C2=A0 =C2=A0 ts->timer.function =3D tsc2046_ts_timer;
>> +
>> + =C2=A0 =C2=A0 spin_lock_init(&ts->lock);
>> +
>> + =C2=A0 =C2=A0 ts->x_plate_ohm =3D pdata->ts_x_plate_ohm ? : 280;
>> + =C2=A0 =C2=A0 ts->max_pressure =3D pdata->ts_max_pressure ? : MAX_=
12BIT;
>> + =C2=A0 =C2=A0 ts->touch_pressure =3D pdata->ts_touch_pressure ? : =
ts->max_pressure;
>> + =C2=A0 =C2=A0 ts->ignore_last =3D pdata->ts_ignore_last;
>> +
>> + =C2=A0 =C2=A0 idev =3D input_allocate_device();
>> + =C2=A0 =C2=A0 if (idev =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err2;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 idev->name =3D "TSC2046 touchscreen";
>> + =C2=A0 =C2=A0 snprintf(ts->phys, sizeof(ts->phys),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%s/input-ts", dev=
_name(&tsc->spi->dev));
>> + =C2=A0 =C2=A0 idev->phys =3D ts->phys;
>> +
>> + =C2=A0 =C2=A0 idev->evbit[0] =3D BIT(EV_ABS) | BIT(EV_KEY);
>> + =C2=A0 =C2=A0 idev->absbit[0] =3D BIT(ABS_X) | BIT(ABS_Y) | BIT(AB=
S_PRESSURE);
>> + =C2=A0 =C2=A0 ts->idev =3D idev;
>> +
>> + =C2=A0 =C2=A0 tsc2046_ts_setup_spi_xfer(tsc);
>> +
>> + =C2=A0 =C2=A0 /* X and Y res default to 240x320 */
>> + =C2=A0 =C2=A0 ts->x_res =3D pdata->ts_x_res ? : 240;
>> + =C2=A0 =C2=A0 ts->y_res =3D pdata->ts_y_res ? : 320;
>> +
>> + =C2=A0 =C2=A0 input_set_abs_params(idev, ABS_X, 0, ts->x_res - 1, =
0, 0);
>> + =C2=A0 =C2=A0 input_set_abs_params(idev, ABS_Y, 0, ts->y_res - 1, =
0, 0);
>> + =C2=A0 =C2=A0 input_set_abs_params(idev, ABS_PRESSURE, 0, 1, 0, 0)=
;
>> +
>> + =C2=A0 =C2=A0 set_bit(BTN_TOUCH, idev->keybit);
>> +
>> + =C2=A0 =C2=A0 r =3D request_irq(ts->irq, tsc2046_ts_irq_handler,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "tsc2046-ts", tsc);
>> + =C2=A0 =C2=A0 if (r < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&tsc->spi->dev, =
"unable to get DAV IRQ");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err3;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 set_irq_wake(ts->irq, 1);
>> + =C2=A0 =C2=A0 ts->irq_enabled =3D 1;
>> +
>> + =C2=A0 =C2=A0 /* Create the various driver attributes */
>> + =C2=A0 =C2=A0 if (device_create_file(&tsc->spi->dev, &dev_attr_pen=
_down) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err4;
>> + =C2=A0 =C2=A0 if (device_create_file(&tsc->spi->dev, &dev_attr_dis=
able_ts) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err5;
>> + =C2=A0 =C2=A0 if (device_create_file(&tsc->spi->dev, &dev_attr_use=
_pointercal) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err6;
>> + =C2=A0 =C2=A0 if (device_create_file(&tsc->spi->dev, &dev_attr_poi=
ntercal) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err7;
>> + =C2=A0 =C2=A0 if (device_create_file(&tsc->spi->dev, &dev_attr_scr=
een_res) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err8;
>
> If there are still more than 1 attriute left then anonymous attribute
> group should be used. HOwever if you remove pointercal support that
> basically leaves disable methid and I am not too keen on having it
> either - I believe we need a generic solution for shutting off an
> arbitrary device and not somethign that has to be reimplemented in ev=
ery
> driver.
>
>> +
>> + =C2=A0 =C2=A0 r =3D input_register_device(idev);
>> + =C2=A0 =C2=A0 if (r < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&tsc->spi->dev, =
"can't register touchscreen device\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err9;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 /* kick off a transaction to enable pen interrupts *=
/
>> + =C2=A0 =C2=A0 spi_async(tsc->spi, &ts->read_msg);
>
> Should be done in open() method.
>
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +err9:
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_screen_=
res);
>> +err8:
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_pointer=
cal);
>> +err7:
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_use_poi=
ntercal);
>> +err6:
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_disable=
_ts);
>> +err5:
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_pen_dow=
n);
>> +err4:
>> + =C2=A0 =C2=A0 free_irq(ts->irq, tsc);
>> +err3:
>> + =C2=A0 =C2=A0 input_free_device(idev);
>> +err2:
>> + =C2=A0 =C2=A0 if (ts->dav_gpio)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_free(ts->dav_gpio);
>> +err1:
>> + =C2=A0 =C2=A0 kfree(ts);
>> + =C2=A0 =C2=A0 return r;
>> +}
>> +
>> +static int __devexit tsc2046_remove(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 struct tsc2046 *tsc =3D dev_get_drvdata(&spi->dev);
>> + =C2=A0 =C2=A0 struct tsc2046_ts *ts =3D tsc->ts;
>> + =C2=A0 =C2=A0 unsigned long flags;
>> +
>> + =C2=A0 =C2=A0 dev_dbg(&tsc->spi->dev, "%s\n", __FUNCTION__);
>> +
>> + =C2=A0 =C2=A0 spin_lock_irqsave(&ts->lock, flags);
>> + =C2=A0 =C2=A0 tsc2046_ts_disable(tsc);
>> + =C2=A0 =C2=A0 spin_unlock_irqrestore(&ts->lock, flags);
>> +
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_disable=
_ts);
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_pen_dow=
n);
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_use_poi=
ntercal);
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_pointer=
cal);
>> + =C2=A0 =C2=A0 device_remove_file(&tsc->spi->dev, &dev_attr_screen_=
res);
>> +
>> + =C2=A0 =C2=A0 free_irq(ts->irq, tsc);
>> + =C2=A0 =C2=A0 input_unregister_device(ts->idev);
>> +
>> + =C2=A0 =C2=A0 if (ts->dav_gpio)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_free(ts->dav_gpio);
>> +
>> + =C2=A0 =C2=A0 kfree(ts);
>> + =C2=A0 =C2=A0 kfree(tsc);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static struct spi_driver tsc2046_driver =3D {
>> + =C2=A0 =C2=A0 .driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D "=
tsc2046",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bus =3D &s=
pi_bus_type,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D =
THIS_MODULE,
>> + =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 .probe =3D tsc2046_probe,
>> + =C2=A0 =C2=A0 .remove =3D __devexit_p(tsc2046_remove),
>> +};
>> +
>> +static int __init tsc2046_init(void)
>> +{
>> + =C2=A0 =C2=A0 printk(KERN_INFO "TSC2046 driver initializing\n");
>> +
>> + =C2=A0 =C2=A0 return spi_register_driver(&tsc2046_driver);
>> +}
>> +
>> +static void __exit tsc2046_exit(void)
>> +{
>> + =C2=A0 =C2=A0 spi_unregister_driver(&tsc2046_driver);
>> +}
>> +
>> +module_init(tsc2046_init);
>> +module_exit(tsc2046_exit);
>> +
>> +MODULE_AUTHOR("Kevin Hilman <khilman@mvista.com>");
>> +MODULE_LICENSE("GPL");
>> +
>> diff --git a/include/linux/input/tsc2046.h b/include/linux/input/tsc=
2046.h
>> new file mode 100644
>> index 0000000..acb8fed
>> --- /dev/null
>> +++ b/include/linux/input/tsc2046.h
>> @@ -0,0 +1,26 @@
>> +#ifndef _LINUX_INPUT_TSC2046_H
>> +#define _LINUX_INPUT_TSC2046_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/timer.h>
>> +
>> +struct tsc2046_platform_data {
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 (*get_pendown_state)(void);
>> + =C2=A0 =C2=A0 int =C2=A0 =C2=A0 gpio_pendown;
>> + =C2=A0 =C2=A0 s16 =C2=A0 =C2=A0 gpio_debounce;
>> + =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 ts_x_plate_ohm;
>> + =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 ts_max_pressure; =C2=A0/* Samples =
with bigger pressure value will
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be ignored, since t=
he corresponding X, Y
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0values are unreliab=
le */
>> + =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 ts_touch_pressure;/* Pressure limi=
t until we report a
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0touch event. After =
that we switch
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to ts_max_pressure.=
 */
>> + =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 ts_x_res;
>> + =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 ts_y_res;
>> + =C2=A0 =C2=A0 unsigned ts_ignore_last : 1;
>> +
>> +};
>> +
>> +#endif
>> +
>> +
>
> Thanks.
>
> --
> Dmitry
>

Turns out the ads7846 driver works fine for this hardware -- there was
a bug in the SPI100k driver we were using that caused a problem with
it.  With that fixed, there's no more need for this driver.

Thanks for reviewing it.
- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
