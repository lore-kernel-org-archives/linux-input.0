From: <Steve.Grahovac@microchip.com>
Subject: RE: [PATCH 1/1] Added support for Microchip Projected Capacitive Touchscreen controllers for UART communications
Date: Mon, 3 Jan 2011 09:07:29 -0700
Message-ID: <E773D38DD616EA4A9B9DBDA8009918200B22F45F@CHN-CL-MAIL01.mchp-main.com>
References: <1294027991-2537-1-git-send-email-user@linux-mint> <1294027991-2537-2-git-send-email-user@linux-mint> <20110103070207.GC26703@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.microchip.com ([198.175.253.48]:41034 "EHLO
	smtp02.microchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178Ab1ACQHa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Jan 2011 11:07:30 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20110103070207.GC26703@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, steve.grahovac@gmail.com
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Thank you for all your great input.  I will work on resubmitting with
your recommended changes for both drivers.

>Actually, this looks very much like mtouch driver but with multi-touch
support. I think they should be merged together.

I would like to point out to avoid any potential merging that the mtouch
controller (short for Microtouch) is a direct competitor to us (3M) and
the "mTouch" name as it pertains to Microchip is for a family of
products.  While I believe you are correct that they could be merged, it
may make things a bit awkward.

Best regards,

Steve Grahovac
Sr. Software Engineer
Microchip Technology, Inc.
9055 N. 51st Street Suite H
Brown Deer, WI 53223 USA
Steve.Grahovac@microchip.com
Ph: 414.355.4675
FX: 414.355.4775





-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Monday, January 03, 2011 1:02 AM
To: Steve Grahovac
Cc: linux-input@vger.kernel.org; Steve Grahovac - C13916
Subject: Re: [PATCH 1/1] Added support for Microchip Projected
Capacitive Touchscreen controllers for UART communications

On Sun, Jan 02, 2011 at 10:13:10PM -0600, Steve Grahovac wrote:
> From: Steve Grahovac <steve.grahovac@microchip.com>
> 
> 
> Signed-off-by: Steve Grahovac <steve.grahovac@microchip.com>
> ---
>  drivers/input/touchscreen/Kconfig      |   10 ++
>  drivers/input/touchscreen/Makefile     |    1 +
>  drivers/input/touchscreen/mchppcapmt.c |  263
++++++++++++++++++++++++++++++++
>  include/linux/serio.h                  |    1 +
>  4 files changed, 275 insertions(+), 0 deletions(-)
>  create mode 100755 drivers/input/touchscreen/mchppcapmt.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
> index 400c99d..e69ec50 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -648,4 +648,14 @@ config TOUCHSCREEN_STMPE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stmpe-ts.
>  
> +config TOUCHSCREEN_MCHPPCAP
> +	tristate "Microchip PCAP touchscreen"
> +	select SERIO
> +	help
> +	  Say Y here if you have a Microchip PCAP Controller and
> +	  want to enable support for the built-in touchscreen.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mchippcap.
> +

Please try keeping Kconfig and Makefile sorted alphabetically.

>  endif
> diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
> index 22e2d59..9575478 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -53,3 +53,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+=
mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_MCHPPCAP)	+= mchppcapmt.o
> diff --git a/drivers/input/touchscreen/mchppcapmt.c
b/drivers/input/touchscreen/mchppcapmt.c
> new file mode 100755
> index 0000000..047a4d0
> --- /dev/null
> +++ b/drivers/input/touchscreen/mchppcapmt.c
> @@ -0,0 +1,263 @@
> +/*
> + * Microchip Serial Touchscreen Driver
> + *
> + * Copyright (c) 2010 Microchip Technology, Inc.
> + *
> + * http://www.microchip.com/mtouch
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or
modify it
> + * under the terms of the GNU General Public License version 2 as
published by
> + * the Free Software Foundation.
> + */
> +
> +/*
> + * This driver can handle serial Microchip controllers using the
Projected
> + * Capacitive 5-byte protocol
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/serio.h>
> +#include <linux/init.h>
> +#include <linux/ctype.h>
> +
> +#define DRIVER_DESC "Microchip Project Capacitive Serial Touchscreen
Driver"
> +
> +MODULE_AUTHOR("Steve Grahovac <steve.grahovac@microchip.com>");
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");
> +
> +/*
> + * Definitions & global arrays.
> + */
> +
> +#define MCHIP_MAX_LENGTH	5
> +
> +/*
> + * Per-touchscreen controller data.
> + */
> +
> +struct mchip {
> +	struct input_dev *dev;
> +	struct serio *serio;
> +	int id;
> +	int index;
> +	unsigned char data[MCHIP_MAX_LENGTH];
> +	char phys[32];
> +};
> +
> +static void mchppcap_process_data(struct mchip *mchip, unsigned char
data)
> +{
> +	struct input_dev *dev = mchip->dev;
> +
> +	mchip->data[mchip->index] = data;
> +
> +	/****************************************************
> +	Data format, 5 bytes: SYNC, DATA1, DATA2, DATA3, DATA4
> +	SYNC [7:0]: 1,TOUCHID[6:5],0,0,TOUCHSTATUS[2:0]
> +	DATA1[7:0]: 0,X-LOW[6:0]
> +	DATA2[7:0]: 0,X-HIGH[2:0]
> +	DATA3[7:0]: 0,Y-LOW[6:0]
> +	DATA4[7:0]: 0,Y-HIGH[2:0]
> +	TOUCHSTATUS: 0 = Touch up, 1 = Touch down
> +	****************************************************/
> +	switch (mchip->index++) {
> +	case 0:
> +		/* Verify if sync bit is set for the first byte of
packet */
> +		if (!(0x80 & data))
> +			mchip->index = 0;
> +		break;
> +
> +	case (MCHIP_MAX_LENGTH - 1):
> +		/* verify byte is valid for current index */
> +		if (0x80 & data) {
> +			/* byte not valid */
> +			mchip->data[0] = data;
> +			mchip->index = 1;
> +			break;
> +		}
> +
> +		mchip->index = 0;
> +		input_report_abs(dev, ABS_MT_TRACKING_ID, \
> +		(mchip->data[0]&0x60) >> 5);

There is no need to escape line endings for multi-line statements.

> +		input_report_abs(dev, ABS_MT_POSITION_X, \
> +		((mchip->data[2] & 0x1f) << 7) | (mchip->data[1] &
0x7f));
> +		input_report_abs(dev, ABS_MT_POSITION_Y, \
> +		((mchip->data[4] & 0x1f) << 7) | (mchip->data[3] &
0x7f));
> +		input_report_abs(dev, ABS_MT_TOUCH_MAJOR, \
> +		255*(0 != (mchip->data[0] & 7)));

The device does not report size of the touch so you do not need to
report ABS_MT_TOUCH_MAJOR.

> +		input_mt_sync(dev);
> +
> +		/* touchscreen emulation for ID 0 */
> +		if (0 == ((mchip->data[0]&0x60) >> 5)) {
> +			input_report_abs(dev, ABS_X, \
> +			((mchip->data[2]&0x1f) <<
7)|(mchip->data[1]&0x7f));
> +			input_report_abs(dev, ABS_Y, \
> +			((mchip->data[4]&0x1f) <<
7)|(mchip->data[3]&0x7f));
> +			input_report_key(dev, BTN_TOUCH, \
> +			0 != (mchip->data[0] & 7));

It would be better to compute values once and reuse them.

Actually, this looks very much like mtouch driver but with multi-touch
support. I think they should be merged together.


> +		}
> +
> +		input_sync(dev);
> +		break;
> +	default:
> +		/* verify byte is valid for current index */
> +		if (0x80 & data) {
> +			/* byte not valid */
> +			mchip->data[0] = data;
> +			mchip->index = 1;
> +		}
> +		break;
> +	}
> +}
> +
> +
> +static irqreturn_t mchppcap_interrupt(struct serio *serio,
> +		unsigned char data, unsigned int flags)
> +{
> +	struct mchip *mchip = serio_get_drvdata(serio);
> +
> +	mchppcap_process_data(mchip, data);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mchppcap_setup(struct mchip *mchip)
> +{
> +	struct input_dev *dev = mchip->dev;
> +
> +	input_set_abs_params(dev, ABS_X, 0, 1023, 0, 0);
> +	input_set_abs_params(dev, ABS_Y, 0, 1023, 0, 0);
> +
> +	input_set_abs_params(dev, ABS_MT_POSITION_X, 0, 1023, 0, 0);
> +	input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, 1023, 0, 0);
> +	input_set_abs_params(dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(dev, ABS_MT_TRACKING_ID, 0, 3, 0, 0);
> +
> +	return 0;
> +}
> +
> +/*
> + * mchppcap_disconnect() is the opposite of mchppcap_connect()
> + */
> +
> +static void mchppcap_disconnect(struct serio *serio)
> +{
> +	struct mchip *mchip = serio_get_drvdata(serio);
> +
> +	input_get_device(mchip->dev);
> +	input_unregister_device(mchip->dev);
> +	serio_close(serio);
> +	serio_set_drvdata(serio, NULL);
> +	input_put_device(mchip->dev);
> +	kfree(mchip);
> +}
> +
> +/*
> + * mchppcap_connect() is the routine that is called when someone adds
a
> + * new serio device that supports PCAP protocol and registers it as
> + * an input device.
> + */
> +
> +static int mchppcap_connect(struct serio *serio, struct serio_driver
*drv)
> +{
> +	struct mchip *mchip;
> +	struct input_dev *input_dev;
> +	int err;
> +
> +	mchip = kzalloc(sizeof(struct mchip), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!mchip || !input_dev) {
> +		err = -ENOMEM;
> +		goto fail1;
> +	}
> +
> +	mchip->serio = serio;
> +	mchip->id = serio->id.id;
> +	mchip->dev = input_dev;
> +	snprintf(mchip->phys, sizeof(mchip->phys), "%s/input0",
serio->phys);
> +
> +	input_dev->name = "Microchip Serial TouchScreen";
> +	input_dev->phys = mchip->phys;
> +	input_dev->id.bustype = BUS_RS232;
> +	input_dev->id.vendor = SERIO_MCHPPCAP;
> +	input_dev->id.product = mchip->id;
> +	input_dev->id.version = 0x0100;
> +	input_dev->dev.parent = &serio->dev;
> +
> +	set_bit(EV_SYN, input_dev->evbit);
> +	set_bit(EV_KEY, input_dev->evbit);
> +	set_bit(BTN_TOUCH, input_dev->keybit);
> +	set_bit(BTN_2, input_dev->keybit);
> +	set_bit(EV_ABS, input_dev->evbit);
> +
> +	serio_set_drvdata(serio, mchip);
> +
> +	err = serio_open(serio, drv);
> +	if (err)
> +		goto fail2;
> +
> +
> +	mchppcap_setup(mchip);
> +
> +	err = input_register_device(mchip->dev);
> +	if (err)
> +		goto fail3;
> +
> +	return 0;
> +
> +fail3: serio_close(serio);
> +fail2: serio_set_drvdata(serio, NULL);
> +fail1: input_free_device(input_dev);
> +	kfree(mchip);
> +	return err;
> +}
> +
> +/*
> + * The serio driver structure.
> + */
> +
> +static struct serio_device_id mchppcap_serio_ids[] = {
> +	{
> +		.type	= SERIO_RS232,
> +		.proto	= SERIO_MCHPPCAP,
> +		.id	= SERIO_ANY,
> +		.extra	= SERIO_ANY,
> +	},
> +	{ 0 }
> +};
> +
> +MODULE_DEVICE_TABLE(serio, mchppcap_serio_ids);
> +
> +static struct serio_driver mchppcap_drv = {
> +	.driver		= {
> +		.name	= "mchip",
> +	},
> +	.description	= DRIVER_DESC,
> +	.id_table	= mchppcap_serio_ids,
> +	.interrupt	= mchppcap_interrupt,
> +	.connect	= mchppcap_connect,
> +	.disconnect	= mchppcap_disconnect,
> +};
> +
> +/*
> + * The functions for inserting/removing us as a module.
> + */
> +
> +static int __init mchppcap_init(void)
> +{
> +	return serio_register_driver(&mchppcap_drv);
> +}
> +
> +static void __exit mchppcap_exit(void)
> +{
> +	serio_unregister_driver(&mchppcap_drv);
> +}
> +
> +module_init(mchppcap_init);
> +module_exit(mchppcap_exit);
> diff --git a/include/linux/serio.h b/include/linux/serio.h
> index b555256..3a7b8a9 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -197,5 +197,6 @@ static inline void serio_continue_rx(struct serio
*serio)
>  #define SERIO_W8001	0x39
>  #define SERIO_DYNAPRO	0x3a
>  #define SERIO_HAMPSHIRE	0x3b
> +#define SERIO_MCHPPCAP	0x3d
>  
>  #endif
> -- 
> 1.7.1
> 

Thanks.

-- 
Dmitry
