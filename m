From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] input: Add support for Wacom protocol 4 serial tablets
Date: Sun, 20 Jul 2014 16:23:14 +0200
Message-ID: <53CBD0D2.8060005@redhat.com>
References: <1405787920-3354-1-git-send-email-hdegoede@redhat.com> <1405787920-3354-2-git-send-email-hdegoede@redhat.com> <20140719230807.GA19006@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51763 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbaGTOXX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 10:23:23 -0400
In-Reply-To: <20140719230807.GA19006@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Julian Squires <julian@cipht.net>, linux-input@vger.kernel.org

Hi,

On 07/20/2014 01:08 AM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Sat, Jul 19, 2014 at 06:38:40PM +0200, Hans de Goede wrote:
>> Recent version of xf86-input-wacom no longer support directly accessing
>> serial tablets. Instead xf86-input-wacom now expects all wacom tablets to
>> be driven by the kernel and to show up as evdev devices.
>>
>> This has caused old serial Wacom tablets to stop working for people who still
>> have such tablets. Julian Squires has written a serio input driver to fix this:
>> https://github.com/tokenrove/wacom-serial-iv
>>
>> This is a cleaned up version of this driver with improved Graphire support
>> (I own an old Graphire myself).
>>
>> Signed-off-by: Julian Squires <julian@cipht.net>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  MAINTAINERS                          |   7 +
>>  drivers/input/tablet/Kconfig         |  12 +
>>  drivers/input/tablet/Makefile        |   1 +
>>  drivers/input/tablet/wacom_serial4.c | 600 +++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serio.h           |   1 +
>>  5 files changed, 621 insertions(+)
>>  create mode 100644 drivers/input/tablet/wacom_serial4.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1629ac9..1128b57 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9855,6 +9855,13 @@ M:	Pierre Ossman <pierre@ossman.eu>
>>  S:	Maintained
>>  F:	drivers/mmc/host/wbsd.*
>>  
>> +WACOM PROTOCOL 4 SERIAL TABLETS
>> +M:	Julian Squires <julian@cipht.net>
>> +M:	Hans de Goede <hdegoede@redhat.com>
>> +L:	linux-input@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/input/tablet/wacom_serial4.c
>> +
>>  WATCHDOG DEVICE DRIVERS
>>  M:	Wim Van Sebroeck <wim@iguana.be>
>>  L:	linux-watchdog@vger.kernel.org
>> diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
>> index bed7cbf..d7c764a 100644
>> --- a/drivers/input/tablet/Kconfig
>> +++ b/drivers/input/tablet/Kconfig
>> @@ -89,4 +89,16 @@ config TABLET_USB_WACOM
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called wacom.
>>  
>> +config TABLET_SERIAL_WACOM4
>> +	tristate "Wacom protocol 4 serial tablet support"
>> +	select SERIO
>> +	help
>> +	  Say Y here if you want to use Wacom protocol 4 serial tablets.
>> +	  E.g. serial versions of the Cintiq, Graphire or Penpartner.
>> +	  Make sure to say Y to "Mouse support" (CONFIG_INPUT_MOUSEDEV) and/or
>> +	  "Event interface support" (CONFIG_INPUT_EVDEV) as well.
> 
> Do we really need mousedev for wacom to work?

No I don't think so I just copy and pasted this from the other tablet
Kconfig options, I'll drop it in v2.

>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called wacom_serial4.
>> +
>>  endif
>> diff --git a/drivers/input/tablet/Makefile b/drivers/input/tablet/Makefile
>> index 3f6c252..4d9339f 100644
>> --- a/drivers/input/tablet/Makefile
>> +++ b/drivers/input/tablet/Makefile
>> @@ -11,3 +11,4 @@ obj-$(CONFIG_TABLET_USB_GTCO)	+= gtco.o
>>  obj-$(CONFIG_TABLET_USB_HANWANG) += hanwang.o
>>  obj-$(CONFIG_TABLET_USB_KBTAB)	+= kbtab.o
>>  obj-$(CONFIG_TABLET_USB_WACOM)	+= wacom.o
>> +obj-$(CONFIG_TABLET_SERIAL_WACOM4) += wacom_serial4.o
>> diff --git a/drivers/input/tablet/wacom_serial4.c b/drivers/input/tablet/wacom_serial4.c
>> new file mode 100644
>> index 0000000..587e47c
>> --- /dev/null
>> +++ b/drivers/input/tablet/wacom_serial4.c
>> @@ -0,0 +1,600 @@
>> +/*
>> + * Wacom protocol 4 serial tablet driver
>> + *
>> + * Copyright 2014      Hans de Goede <hdegoede@redhat.com>
>> + * Copyright 2011-2012 Julian Squires <julian@cipht.net>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; either version of 2 of the License, or (at your
>> + * option) any later version. See the file COPYING in the main directory of
>> + * this archive for more details.
>> + *
>> + * Many thanks to Bill Seremetis, without whom PenPartner support
>> + * would not have been possible. Thanks to Patrick Mahoney.
>> + *
>> + * This driver was developed with reference to much code written by others,
>> + * particularly:
>> + *  - elo, gunze drivers by Vojtech Pavlik <vojtech@ucw.cz>;
>> + *  - wacom_w8001 driver by Jaya Kumar <jayakumar.lkml@gmail.com>;
>> + *  - the USB wacom input driver, credited to many people
>> + *    (see drivers/input/tablet/wacom.h);
>> + *  - new and old versions of linuxwacom / xf86-input-wacom credited to
>> + *    Frederic Lepied, France. <Lepied@XFree86.org> and
>> + *    Ping Cheng, Wacom. <pingc@wacom.com>;
>> + *  - and xf86wacom.c (a presumably ancient version of the linuxwacom code),
>> + *    by Frederic Lepied and Raph Levien <raph@gtk.org>.
>> + *
>> + * To do:
>> + *  - support pad buttons; (requires access to a model with pad buttons)
>> + *  - support (protocol 4-style) tilt (requires access to a > 1.4 rom model)
>> + */
>> +
>> +/*
>> + * Wacom serial protocol 4 documentation taken from linuxwacom-0.9.9 code,
>> + * protocol 4 uses 7 or 9 byte of data in the following format:
>> + *
>> + *	Byte 1
>> + *	bit 7  Sync bit always 1
>> + *	bit 6  Pointing device detected
>> + *	bit 5  Cursor = 0 / Stylus = 1
>> + *	bit 4  Reserved
>> + *	bit 3  1 if a button on the pointing device has been pressed
>> + *	bit 2  P0 (optional)
>> + *	bit 1  X15
>> + *	bit 0  X14
>> + *
>> + *	Byte 2
>> + *	bit 7  Always 0
>> + *	bits 6-0 = X13 - X7
>> + *
>> + *	Byte 3
>> + *	bit 7  Always 0
>> + *	bits 6-0 = X6 - X0
>> + *
>> + *	Byte 4
>> + *	bit 7  Always 0
>> + *	bit 6  B3
>> + *	bit 5  B2
>> + *	bit 4  B1
>> + *	bit 3  B0
>> + *	bit 2  P1 (optional)
>> + *	bit 1  Y15
>> + *	bit 0  Y14
>> + *
>> + *	Byte 5
>> + *	bit 7  Always 0
>> + *	bits 6-0 = Y13 - Y7
>> + *
>> + *	Byte 6
>> + *	bit 7  Always 0
>> + *	bits 6-0 = Y6 - Y0
>> + *
>> + *	Byte 7
>> + *	bit 7 Always 0
>> + *	bit 6  Sign of pressure data; or wheel-rel for cursor tool
>> + *	bit 5  P7; or REL1 for cursor tool
>> + *	bit 4  P6; or REL0 for cursor tool
>> + *	bit 3  P5
>> + *	bit 2  P4
>> + *	bit 1  P3
>> + *	bit 0  P2
>> + *
>> + *	byte 8 and 9 are optional and present only
>> + *	in tilt mode.
>> + *
>> + *	Byte 8
>> + *	bit 7 Always 0
>> + *	bit 6 Sign of tilt X
>> + *	bit 5  Xt6
>> + *	bit 4  Xt5
>> + *	bit 3  Xt4
>> + *	bit 2  Xt3
>> + *	bit 1  Xt2
>> + *	bit 0  Xt1
>> + *
>> + *	Byte 9
>> + *	bit 7 Always 0
>> + *	bit 6 Sign of tilt Y
>> + *	bit 5  Yt6
>> + *	bit 4  Yt5
>> + *	bit 3  Yt4
>> + *	bit 2  Yt3
>> + *	bit 1  Yt2
>> + *	bit 0  Yt1
>> + *
>> + *	For more info see:
>> + *	http://sourceforge.net/apps/mediawiki/linuxwacom/index.php?title=Serial_Protocol_IV
> 
> It looks this link is stale.

Already? I added that myself recently, Ah well the comment itself contains 99% of the info
so lets just drop the link.

> 
>> + */
>> +
>> +#include <linux/completion.h>
>> +#include <linux/init.h>
>> +#include <linux/input.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/serio.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include "wacom_wac.h"
>> +
>> +MODULE_AUTHOR("Julian Squires <julian@cipht.net>, Hans de Goede <hdegoede@redhat.com>");
>> +MODULE_DESCRIPTION("Wacom protocol 4 serial tablet driver");
>> +MODULE_LICENSE("GPL");
>> +
>> +#define REQUEST_MODEL_AND_ROM_VERSION	"~#"
>> +#define REQUEST_MAX_COORDINATES		"~C\r"
>> +#define REQUEST_CONFIGURATION_STRING	"~R\r"
>> +#define REQUEST_RESET_TO_PROTOCOL_IV	"\r#"
>> +/* Note: sending "\r$\r" causes at least the Digitizer II to send
>> + * packets in ASCII instead of binary.  "\r#" seems to undo that. */
>> +
>> +#define COMMAND_START_SENDING_PACKETS		"ST\r"
>> +#define COMMAND_STOP_SENDING_PACKETS		"SP\r"
>> +#define COMMAND_MULTI_MODE_INPUT		"MU1\r"
>> +#define COMMAND_ORIGIN_IN_UPPER_LEFT		"OC1\r"
>> +#define COMMAND_ENABLE_ALL_MACRO_BUTTONS	"~M0\r"
>> +#define COMMAND_DISABLE_GROUP_1_MACRO_BUTTONS	"~M1\r"
>> +#define COMMAND_TRANSMIT_AT_MAX_RATE		"IT0\r"
>> +#define COMMAND_DISABLE_INCREMENTAL_MODE	"IN0\r"
>> +#define COMMAND_ENABLE_CONTINUOUS_MODE		"SR\r"
>> +#define COMMAND_ENABLE_PRESSURE_MODE		"PH1\r"
>> +#define COMMAND_Z_FILTER			"ZF1\r"
>> +
>> +/* Note that this is a protocol 4 packet without tilt information. */
>> +#define PACKET_LENGTH		7
>> +#define DATA_SIZE		32
>> +
>> +/* flags */
>> +#define F_COVERS_SCREEN		0x01
>> +#define F_HAS_STYLUS2		0x02
>> +#define F_HAS_SCROLLWHEEL	0x04
>> +
>> +enum { STYLUS = 1, ERASER, CURSOR };
>> +struct { int device_id; int input_id; } tools[] = {
>> +	{ 0, 0 },
>> +	{ STYLUS_DEVICE_ID, BTN_TOOL_PEN },
>> +	{ ERASER_DEVICE_ID, BTN_TOOL_RUBBER },
>> +	{ CURSOR_DEVICE_ID, BTN_TOOL_MOUSE },
>> +};
>> +
>> +struct wacom {
>> +	struct input_dev *dev;
>> +	struct completion cmd_done;
>> +	int expect;
>> +	int result;
> 
> I think these 2 should be u8.

Result gets set to 0, or things like -ENODEV. So it should
stay an int, your right about expect though.

> 
>> +	int extra_z_bits;
>> +	int eraser_mask;
>> +	int flags;
>> +	int res_x, res_y;
>> +	int max_x, max_y;
>> +	int tool;
>> +	int idx;
> 
> And these are unsigned ints.

Fixed.

>> +	unsigned char data[DATA_SIZE];
>> +	char phys[32];
>> +};
>> +
>> +enum {
>> +	MODEL_CINTIQ		= 0x504C, /* PL */
>> +	MODEL_CINTIQ2		= 0x4454, /* DT */
>> +	MODEL_DIGITIZER_II	= 0x5544, /* UD */
>> +	MODEL_GRAPHIRE		= 0x4554, /* ET */
>> +	MODEL_PENPARTNER	= 0x4354, /* CT */
>> +};
>> +
>> +static void handle_model_response(struct wacom *wacom)
>> +{
>> +	int major_v, minor_v, r = 0;
>> +	char *p;
>> +
>> +	p = strrchr(wacom->data, 'V');
>> +	if (p)
>> +		r = sscanf(p + 1, "%u.%u", &major_v, &minor_v);
>> +	if (r != 2)
>> +		major_v = minor_v = 0;
>> +
>> +	switch (wacom->data[2] << 8 | wacom->data[3]) {
>> +	case MODEL_CINTIQ:	/* UNTESTED */
>> +	case MODEL_CINTIQ2:
>> +		if ((wacom->data[2] << 8 | wacom->data[3]) == MODEL_CINTIQ) {
>> +			wacom->dev->name = "Wacom Cintiq";
>> +			wacom->dev->id.version = MODEL_CINTIQ;
>> +		} else {
>> +			wacom->dev->name = "Wacom Cintiq II";
>> +			wacom->dev->id.version = MODEL_CINTIQ2;
>> +		}
>> +		wacom->res_x = 508;
>> +		wacom->res_y = 508;
>> +		switch (wacom->data[5]<<8 | wacom->data[6]) {
>> +		case 0x3731: /* PL-710 */
>> +			wacom->res_x = 2540;
>> +			wacom->res_y = 2540;
>> +			/* fall through */
>> +		case 0x3535: /* PL-550 */
>> +		case 0x3830: /* PL-800 */
>> +			wacom->extra_z_bits = 2;
>> +		}
>> +		wacom->flags = F_COVERS_SCREEN;
>> +		break;
>> +	case MODEL_PENPARTNER:
>> +		wacom->dev->name = "Wacom Penpartner";
>> +		wacom->dev->id.version = MODEL_PENPARTNER;
>> +		wacom->res_x = 1000;
>> +		wacom->res_y = 1000;
>> +		break;
>> +	case MODEL_GRAPHIRE:
>> +		wacom->dev->name = "Wacom Graphire";
>> +		wacom->dev->id.version = MODEL_GRAPHIRE;
>> +		wacom->res_x = 1016;
>> +		wacom->res_y = 1016;
>> +		wacom->max_x = 5103;
>> +		wacom->max_y = 3711;
>> +		wacom->extra_z_bits = 2;
>> +		wacom->eraser_mask = 0x08;
>> +		wacom->flags = F_HAS_STYLUS2 | F_HAS_SCROLLWHEEL;
>> +		break;
>> +	case MODEL_DIGITIZER_II:
>> +		wacom->dev->name = "Wacom Digitizer II";
>> +		wacom->dev->id.version = MODEL_DIGITIZER_II;
>> +		if (major_v == 1 && minor_v <= 2)
>> +			wacom->extra_z_bits = 0; /* UNTESTED */
>> +		break;
>> +	default:
>> +		dev_err(&wacom->dev->dev, "Unsupported Wacom model %s\n",
>> +			wacom->data);
>> +		wacom->result = -ENODEV;
>> +		return;
>> +	}
>> +	dev_info(&wacom->dev->dev, "%s tablet, version %u.%u\n",
>> +		 wacom->dev->name, major_v, minor_v);
>> +}
>> +
>> +static void handle_configuration_response(struct wacom *wacom)
>> +{
>> +	int r, skip;
>> +
>> +	dev_dbg(&wacom->dev->dev, "Configuration string: %s\n", wacom->data);
>> +	r = sscanf(wacom->data, "~R%x,%u,%u,%u,%u", &skip, &skip, &skip,
>> +		   &wacom->res_x, &wacom->res_y);
>> +	if (r != 5)
>> +		dev_warn(&wacom->dev->dev, "could not get resolution\n");
>> +}
>> +
>> +static void handle_coordinates_response(struct wacom *wacom)
>> +{
>> +	int r;
>> +
>> +	dev_dbg(&wacom->dev->dev, "Coordinates string: %s\n", wacom->data);
>> +	r = sscanf(wacom->data, "~C%u,%u", &wacom->max_x, &wacom->max_y);
>> +	if (r != 2)
>> +		dev_warn(&wacom->dev->dev, "could not get max coordinates\n");
>> +}
>> +
>> +static void handle_response(struct wacom *wacom)
>> +{
>> +	if (wacom->data[0] != '~' || wacom->data[1] != wacom->expect) {
>> +		dev_err(&wacom->dev->dev,
>> +			"Wacom got an unexpected response: %s\n", wacom->data);
>> +		wacom->result = -EIO;
>> +		complete(&wacom->cmd_done);
>> +		return;
>> +	}
>> +
>> +	wacom->result = 0;
>> +
>> +	switch (wacom->data[1]) {
>> +	case '#':
>> +		handle_model_response(wacom);
>> +		break;
>> +	case 'R':
>> +		handle_configuration_response(wacom);
>> +		break;
>> +	case 'C':
>> +		handle_coordinates_response(wacom);
>> +		break;
>> +	}
>> +
>> +	complete(&wacom->cmd_done);
>> +}
>> +
>> +static void handle_packet(struct wacom *wacom)
>> +{
>> +	int in_proximity_p, stylus_p, button, x, y, z;
>> +	int tool;
>> +
>> +	in_proximity_p = wacom->data[0] & 0x40;
>> +	stylus_p = wacom->data[0] & 0x20;
>> +	button = (wacom->data[3] & 0x78) >> 3;
>> +	x = (wacom->data[0] & 3) << 14 | wacom->data[1]<<7 | wacom->data[2];
>> +	y = (wacom->data[3] & 3) << 14 | wacom->data[4]<<7 | wacom->data[5];
>> +
>> +	if (in_proximity_p && stylus_p) {
>> +		z = wacom->data[6] & 0x7f;
>> +		if (wacom->extra_z_bits >= 1)
>> +			z = z << 1 | (wacom->data[3] & 0x4) >> 2;
>> +		if (wacom->extra_z_bits > 1)
>> +			z = z << 1 | (wacom->data[0] & 0x4) >> 2;
>> +		z = z ^ (0x40 << wacom->extra_z_bits);
>> +	} else {
>> +		z = -1;
> 
> I do not believe it is nice to send -1 as pressure. What does it even
> mean to userspace? Does wacom_usb do this as well?

Yes, e.g. take a look at wacom_wac.c line 53 .

I'll send a v2 with all other remarks fixed, thanks for the review.

Regards,

Hans
