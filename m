From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: Add a driver TSC-40 (serial)
Date: Fri, 23 Sep 2011 10:44:05 -0700
Message-ID: <20110923174404.GA25516@core.coreip.homeip.net>
References: <CAH9NwWfPwg69DpGNyd0rDs=OEDpBxrD_D_QPuunwMLN1iF3nyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33139 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1IWRoM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Sep 2011 13:44:12 -0400
Received: by gwb15 with SMTP id 15so3898930gwb.19
        for <linux-input@vger.kernel.org>; Fri, 23 Sep 2011 10:44:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH9NwWfPwg69DpGNyd0rDs=OEDpBxrD_D_QPuunwMLN1iF3nyw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi Christian,

On Fri, Sep 23, 2011 at 12:35:31PM +0200, Christian Gmeiner wrote:
> From 7fc3295f1a4d987af846851f13d185e5f5877411 Mon Sep 17 00:00:00 2001
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Fri, 23 Sep 2011 14:22:18 +0200
> Subject: [PATCH v2] input: Add a driver TSC40 (serial)
> 
> This patch adds the TSC-40 serial touchscreen driver and
> should be compatible with TSC-10 and TSC-25.
> 
> The driver was written by Linutronix on behalf of
> Bachmann electronic GmbH.
> 
> Changes v1 -> v2:
> - initialisation of the controller moved to inputattach

Was the patch to inputattach posted here?

> - incorporated feedback from Dmitry Torokhov and
>   Sebastian Andrzej Siewior
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig  |    7 ++
>  drivers/input/touchscreen/Makefile |    1 +
>  drivers/input/touchscreen/tsc40.c  |  176 ++++++++++++++++++++++++++++++++++++
>  include/linux/serio.h              |    1 +
>  4 files changed, 185 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/tsc40.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> index cabd9e5..c1b6ed9 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -651,6 +651,13 @@ config TOUCHSCREEN_TOUCHIT213
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called touchit213.
> 
> +config TOUCHSCREEN_TSC_SERIO
> +	tristate "TSC-10/25/40 serial touchscreen"
> +	select SERIO
> +	help
> +	  Say Y here if you have a TSC-10, 25 or 40 serial touchscreen connected
> +	  to your system.
> +

"To compile this driver as a module..."

>  config TOUCHSCREEN_TSC2005
>          tristate "TSC2005 based touchscreens"
>          depends on SPI_MASTER && GENERIC_HARDIRQS
> diff --git a/drivers/input/touchscreen/Makefile
> b/drivers/input/touchscreen/Makefile
> index 282d6f7..f957676 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_TOUCHSCREEN_TNETV107X)	+= tnetv107x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
> +obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)	+= tsc40.o
>  obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
>  obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
>  obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
> diff --git a/drivers/input/touchscreen/tsc40.c
> b/drivers/input/touchscreen/tsc40.c
> new file mode 100644
> index 0000000..eeb53a8
> --- /dev/null
> +++ b/drivers/input/touchscreen/tsc40.c
> @@ -0,0 +1,176 @@
> +/*
> + * TSC-40 serial touchscreen driver. It should be compatiible with
> TSC-10 and 25.
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
> +#define PACKET_LENGTH  5
> +struct tsc_ser {
> +	struct input_dev *dev;
> +	struct serio *serio;
> +	u32 idx;
> +	unsigned char data[PACKET_LENGTH];
> +	char phys[32];
> +};
> +
> +static void tsc_process_data(struct tsc_ser *ptsc)
> +{
> +	struct input_dev *dev = ptsc->dev;
> +	u8 *data = ptsc->data;
> +	u32 x;
> +	u32 y;
> +	u32 touch;
> +
> +	x = ((data[1] & 0x03) << 8) | data[2];
> +	y = ((data[3] & 0x03) << 8) | data[4];
> +	touch = data[0] & 0x01;
> +
> +	input_report_abs(dev, ABS_X, x);
> +	input_report_abs(dev, ABS_Y, y);
> +	input_report_abs(dev, ABS_PRESSURE, touch << 7);

The device does not seem to produce valud pressure readings so please do
not fake ABS_PRESSURE events. Tslib has been updated several years ago
so that it does not require ABS_PRESSURE.

> +	input_report_key(dev, BTN_TOUCH, touch);
> +
> +	input_sync(dev);
> +
> +	ptsc->idx = 0;
> +}
> +
> +static int pen_is_up(u8 data)

bool.

> +{
> +	/* SW[01] are unknown */
> +	u8 val = data & 0x3f;
> +	u8 up_val = 1 << 4;
> +
> +	return val == up_val;
> +}
> +
> +static irqreturn_t tsc_interrupt(struct serio *serio,
> +		unsigned char data, unsigned int flags)
> +{
> +	struct tsc_ser *ptsc = serio_get_drvdata(serio);
> +	struct input_dev *dev = ptsc->dev;
> +
> +	if (!ptsc->idx && pen_is_up(data)) {

I am curious, does the device really transmit single byte when pen is
lifted up?

Thanks.

-- 
Dmitry
