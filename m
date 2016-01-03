From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: byd - add BYD PS/2 touchpad driver
Date: Sat, 2 Jan 2016 21:02:30 -0800
Message-ID: <20160103050230.GD23680@dtor-ws>
References: <1451272536-22065-1-git-send-email-chris@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33189 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcACFCe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jan 2016 00:02:34 -0500
Received: by mail-pa0-f52.google.com with SMTP id cy9so180327408pac.0
        for <linux-input@vger.kernel.org>; Sat, 02 Jan 2016 21:02:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1451272536-22065-1-git-send-email-chris@diamand.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@diamand.org
Cc: linux-input@vger.kernel.org

Hi Chris,

On Mon, Dec 28, 2015 at 03:15:36AM +0000, chris@diamand.org wrote:
> From: Chris Diamand <chris@diamand.org>
> 
> Driver for the BYD BTP10463 touchpad. This patch sends the magic
> command sequence to enable gesture recognition, and interprets the
> resulting intellimouse-style packets.
> 
> At present, this supports two-finger vertical and horizontal
> scrolling, and provides the framework to expose the other gestures
> recognized by the touchpad.

Could you please tell me what boxes use this touchpad?

> 
> Signed-off-by: Chris Diamand <chris@diamand.org>
> ---
>  drivers/input/mouse/Kconfig        |  10 ++
>  drivers/input/mouse/Makefile       |   1 +
>  drivers/input/mouse/byd.c          | 344 +++++++++++++++++++++++++++++++++++++
>  drivers/input/mouse/byd.h          |  18 ++
>  drivers/input/mouse/psmouse-base.c |  16 ++
>  drivers/input/mouse/psmouse.h      |   1 +
>  6 files changed, 390 insertions(+)
>  create mode 100644 drivers/input/mouse/byd.c
>  create mode 100644 drivers/input/mouse/byd.h
> 
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index 17f97e5..096abb4 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -48,6 +48,16 @@ config MOUSE_PS2_ALPS
>  
>  	  If unsure, say Y.
>  
> +config MOUSE_PS2_BYD
> +	bool "BYD PS/2 mouse protocol extension" if EXPERT
> +	default y
> +	depends on MOUSE_PS2
> +	help
> +	  Say Y here if you have a BYD PS/2 touchpad connected to
> +	  your system.
> +
> +	  If unsure, say Y.
> +
>  config MOUSE_PS2_LOGIPS2PP
>  	bool "Logitech PS/2++ mouse protocol extension" if EXPERT
>  	default y
> diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
> index ee6a6e9..6168b13 100644
> --- a/drivers/input/mouse/Makefile
> +++ b/drivers/input/mouse/Makefile
> @@ -28,6 +28,7 @@ cyapatp-objs := cyapa.o cyapa_gen3.o cyapa_gen5.o cyapa_gen6.o
>  psmouse-objs := psmouse-base.o synaptics.o focaltech.o
>  
>  psmouse-$(CONFIG_MOUSE_PS2_ALPS)	+= alps.o
> +psmouse-$(CONFIG_MOUSE_PS2_BYD)		+= byd.o
>  psmouse-$(CONFIG_MOUSE_PS2_ELANTECH)	+= elantech.o
>  psmouse-$(CONFIG_MOUSE_PS2_OLPC)	+= hgpk.o
>  psmouse-$(CONFIG_MOUSE_PS2_LOGIPS2PP)	+= logips2pp.o
> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> new file mode 100644
> index 0000000..6441de1
> --- /dev/null
> +++ b/drivers/input/mouse/byd.c
> @@ -0,0 +1,344 @@
> +/*
> + * BYD TouchPad PS/2 mouse driver
> + *
> + * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/input.h>
> +#include <linux/libps2.h>
> +#include <linux/serio.h>
> +
> +#include "psmouse.h"
> +#include "byd.h"
> +
> +#define PS2_Y_OVERFLOW (0x1 << 7)
> +#define PS2_X_OVERFLOW (0x1 << 6)
> +#define PS2_Y_SIGN (0x1 << 5)
> +#define PS2_X_SIGN (0x1 << 4)
> +#define PS2_ALWAYS_1 (0x1 << 3)
> +#define PS2_MIDDLE (0x1 << 2)
> +#define PS2_RIGHT (0x1 << 1)
> +#define PS2_LEFT (0x1 << 0)

We have nice BIT() macro for these.

> +
> +enum bydscroll {
> +	BYD_SCROLLUP = 0xCA,
> +	BYD_SCROLLDOWN = 0x36,
> +	BYD_SCROLLLEFT = 0xCB,
> +	BYD_SCROLLRIGHT = 0x35,
> +	BYD_2DOWN = 0x2B,
> +	BYD_2UP = 0xD5,
> +	BYD_2LEFT = 0xD6,
> +	BYD_2RIGHT = 0x2A,
> +	BYD_ZOOMOUT = 0xD8,
> +	BYD_ZOOMIN = 0x28,
> +	BYD_3UP = 0xD3,
> +	BYD_3DOWN = 0x2D,
> +	BYD_3LEFT = 0xD4,
> +	BYD_3RIGHT = 0x2C,
> +	BYD_4UP = 0xCD,
> +	BYD_4DOWN = 0x33
> +};

This represents raw data from the wire, I'd rather have it as #defines
and u8 instead of enum. Also if you could document the meaning of these
codes that would be great.

> +
> +int byd_detect(struct psmouse *psmouse, bool set_properties)
> +{
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +	unsigned char param[4];
> +
> +	param[0] = 0x03;
> +	param[1] = 0x00;
> +	param[2] = 0x00;
> +	param[3] = 0x00;
> +
> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> +		return -1;
> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> +		return -1;
> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> +		return -1;
> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> +		return -1;
> +	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> +		return -1;
> +
> +	if (param[1] != 0x03 || param[2] != 0x64)
> +		return -ENODEV;
> +
> +	psmouse_info(psmouse, "BYD touchpad detected\n");

psmouse_dbg() please: input core will emit log message with touchpad
details for us.


> +
> +	if (set_properties) {
> +		psmouse->vendor = "BYD";
> +		psmouse->name = "TouchPad";
> +	}
> +
> +	return 0;
> +}
> +
> +static void report_buttons(struct psmouse *psmouse)
> +{
> +	u8 b = psmouse->packet[0];
> +
> +	input_report_key(psmouse->dev, BTN_LEFT, b & PS2_LEFT);
> +	input_report_key(psmouse->dev, BTN_RIGHT, b & PS2_RIGHT);
> +	input_report_key(psmouse->dev, BTN_MIDDLE, b & PS2_MIDDLE);
> +}
> +
> +static int interpret_scroll(struct psmouse *psmouse)
> +{
> +	struct input_dev *dev = psmouse->dev;
> +	enum bydscroll scroll = psmouse->packet[3];
> +
> +	switch (scroll) {
> +	case BYD_SCROLLDOWN:
> +	case BYD_2DOWN:
> +		input_report_rel(dev, REL_WHEEL, -1);
> +		return 1;
> +	case BYD_SCROLLUP:
> +	case BYD_2UP:
> +		input_report_rel(dev, REL_WHEEL, 1);
> +		return 1;
> +	case BYD_SCROLLLEFT:
> +	case BYD_2LEFT:
> +		input_report_rel(dev, REL_HWHEEL, -1);
> +		return 1;
> +	case BYD_SCROLLRIGHT:
> +	case BYD_2RIGHT:
> +		input_report_rel(dev, REL_HWHEEL, 1);
> +		return 1;
> +	case BYD_ZOOMOUT:
> +	case BYD_ZOOMIN:
> +	case BYD_3UP:
> +	case BYD_3DOWN:
> +	case BYD_3LEFT:
> +	case BYD_3RIGHT:
> +	case BYD_4UP:
> +	case BYD_4DOWN:
> +		return 1;
> +	}

Hmm, so the touchpad can't report absolute coordinates for us? That's
unfortunate.

> +
> +	if (scroll != 0) {
> +		psmouse_warn(psmouse,
> +			     "Unrecognized Z: pkt = %02x %02x %02x %02x\n",
> +			     psmouse->packet[0], psmouse->packet[1],
> +			     psmouse->packet[2], psmouse->packet[3]);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
> +{
> +	u8 *pkt = psmouse->packet;
> +
> +	if (psmouse->pktcnt > 0 && !(pkt[0] & PS2_ALWAYS_1)) {
> +		psmouse_warn(psmouse, "Always_1 bit not 1. pkt[0] = %02x\n",
> +			     pkt[0]);
> +		return PSMOUSE_BAD_DATA;
> +	}
> +
> +	if (psmouse->pktcnt < psmouse->pktsize)
> +		return PSMOUSE_GOOD_DATA;
> +
> +	/* Otherwise, a full packet has been received */
> +	if (!interpret_scroll(psmouse)) {
> +		/* Sign-extend if a sign bit is set. */
> +		unsigned int signx = pkt[0] & PS2_X_SIGN ? ~0xFF : 0;
> +		unsigned int signy = pkt[0] & PS2_Y_SIGN ? ~0xFF : 0;
> +		int dx = signx | (int) pkt[1];
> +		int dy = signy | (int) pkt[2];
> +
> +		report_buttons(psmouse);
> +
> +		input_report_rel(psmouse->dev, REL_X, dx);
> +		input_report_rel(psmouse->dev, REL_Y, -dy);
> +	}

I am curious why you split reportign like that; I;d kept it together
in the single function.

> +
> +	input_sync(psmouse->dev);
> +
> +	return PSMOUSE_FULL_PACKET;
> +}
> +
> +/* Send a sequence of bytes, where each is ACKed before the next is sent. */
> +static int send_sequence(struct psmouse *psmouse, const u8 *seq, size_t len)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < len; ++i) {
> +		if (ps2_command(&psmouse->ps2dev, NULL, seq[i]))
> +			return -1;
> +	}
> +	return 0;
> +}
> +
> +/* Keep scrolling after fingers are removed. */
> +#define SCROLL_INERTIAL 0x01
> +#define SCROLL_NO_INERTIAL 0x02
> +
> +/* Clicking can be done by tapping or pressing. */
> +#define CLICK_BOTH 0x01
> +/* Clicking can only be done by pressing. */
> +#define CLICK_PRESS_ONLY 0x02
> +
> +static int byd_enable(struct psmouse *psmouse)
> +{
> +	const u8 seq1[] = { 0xE2, 0x00, 0xE0, 0x02, 0xE0 };
> +	const u8 seq2[] = {
> +		0xD3, 0x01,
> +		0xD0, 0x00,
> +		0xD0, 0x04,
> +		/* Whether clicking is done by tapping or pressing. */
> +		0xD4, CLICK_PRESS_ONLY,
> +		0xD5, 0x01,
> +		0xD7, 0x03,
> +		/* Vertical and horizontal one-finger scroll zone inertia. */
> +		0xD8, SCROLL_INERTIAL,
> +		0xDA, 0x05,
> +		0xDB, 0x02,
> +		0xE4, 0x05,
> +		0xD6, 0x01,
> +		0xDE, 0x04,
> +		0xE3, 0x01,
> +		0xCF, 0x00,
> +		0xD2, 0x03,
> +		/* Vertical and horizontal two-finger scrolling inertia. */
> +		0xE5, SCROLL_INERTIAL,
> +		0xD9, 0x02,
> +		0xD9, 0x07,
> +		0xDC, 0x03,
> +		0xDD, 0x03,
> +		0xDF, 0x03,
> +		0xE1, 0x03,
> +		0xD1, 0x00,
> +		0xCE, 0x00,
> +		0xCC, 0x00,
> +		0xE0, 0x00,
> +		0xE2, 0x01
> +	};
> +	u8 param[4];
> +
> +	if (send_sequence(psmouse, seq1, sizeof(seq1) / sizeof(*seq1)))

ARRAY_SIZE().

> +		return -1;
> +
> +	/* Send a 0x01 command, which should return 4 bytes. */
> +	if (ps2_command(&psmouse->ps2dev, param, 0x0401))
> +		return -1;
> +
> +	if (send_sequence(psmouse, seq2, sizeof(seq2) / sizeof(*seq2)))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int send_intellimouse_sequence(struct psmouse *psmouse)
> +{
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +	u8 param[4];
> +
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_RESET_BAT);
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_RESET_BAT);
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
> +
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETSCALE11);
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETSCALE11);
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETSCALE11);
> +
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
> +
> +	param[0] = 0x03;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
> +
> +	param[0] = 0xC8;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> +	param[0] = 0x64;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> +	param[0] = 0x50;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> +
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
> +
> +	param[0] = 0xC8;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> +	param[0] = 0xC8;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> +	param[0] = 0x50;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> +
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
> +
> +	param[0] = 0x64;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> +	param[0] = 0x03;
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
> +
> +	ps2_command(ps2dev, param, PSMOUSE_CMD_ENABLE);

Should we check results of any of the above commands?

> +
> +	return 0;
> +}
> +
> +static int reset_touchpad(struct psmouse *psmouse)
> +{
> +	if (send_intellimouse_sequence(psmouse))
> +		return -EIO;
> +
> +	if (byd_enable(psmouse))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int byd_reconnect(struct psmouse *psmouse)
> +{
> +	int retry = 0, error = 0;
> +
> +	psmouse_info(psmouse, "Reconnect\n");
> +	do {
> +		psmouse_reset(psmouse);
> +		if (retry)
> +			ssleep(1);
> +		error = byd_detect(psmouse, 0);
> +	} while (error && ++retry < 3);
> +
> +	if (error)
> +		return error;
> +	psmouse_info(psmouse, "Reconnected after %d attempts\n", retry);
> +
> +	error = reset_touchpad(psmouse);
> +	if (error) {
> +		psmouse_err(psmouse, "Unable to initialize device\n");
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +int byd_init(struct psmouse *psmouse)
> +{
> +	struct input_dev *dev = psmouse->dev;
> +
> +	if (psmouse_reset(psmouse))
> +		return -EIO;
> +	if (reset_touchpad(psmouse))
> +		return -EIO;
> +
> +	psmouse->reconnect = byd_reconnect;
> +	psmouse->protocol_handler = byd_process_byte;
> +	psmouse->pktsize = 4;
> +	psmouse->resync_time = 0;
> +
> +	__set_bit(EV_KEY, dev->evbit);
> +	__set_bit(BTN_LEFT, dev->keybit);
> +	__set_bit(BTN_MIDDLE, dev->keybit);
> +	__set_bit(BTN_RIGHT, dev->keybit);
> +
> +	__set_bit(EV_REL, dev->evbit);
> +	__set_bit(REL_WHEEL, dev->relbit);
> +	__set_bit(REL_HWHEEL, dev->relbit);
> +
> +	__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);

This property does not make sense for relative devices.

> +
> +	return 0;
> +}
> diff --git a/drivers/input/mouse/byd.h b/drivers/input/mouse/byd.h
> new file mode 100644
> index 0000000..d6c120c
> --- /dev/null
> +++ b/drivers/input/mouse/byd.h
> @@ -0,0 +1,18 @@
> +#ifndef _BYD_H
> +#define _BYD_H
> +
> +#ifdef CONFIG_MOUSE_PS2_BYD
> +int byd_detect(struct psmouse *psmouse, bool set_properties);
> +int byd_init(struct psmouse *psmouse);
> +#else
> +static inline int byd_detect(struct psmouse *psmouse, bool set_properties)
> +{
> +	return -ENOSYS;
> +}
> +static inline int byd_init(struct psmouse *psmouse)
> +{
> +	return -ENOSYS;
> +}
> +#endif /* CONFIG_MOUSE_PS2_BYD */
> +
> +#endif /* _BYD_H */
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index ad18dab..439be98 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -37,6 +37,7 @@
>  #include "cypress_ps2.h"
>  #include "focaltech.h"
>  #include "vmmouse.h"
> +#include "byd.h"
>  
>  #define DRIVER_DESC	"PS/2 mouse driver"
>  
> @@ -904,6 +905,12 @@ static int psmouse_extensions(struct psmouse *psmouse,
>  		max_proto = PSMOUSE_IMEX;
>  	}
>  
> +	if (max_proto > PSMOUSE_IMEX &&
> +	    psmouse_do_detect(byd_detect, psmouse, set_properties) == 0) {
> +		if (!set_properties || byd_init(psmouse) == 0)
> +			return PSMOUSE_BYD;
> +	}
> +

It looks like you are patching against older kernel. Can you please send
me next version against linux-next?

>  	if (max_proto > PSMOUSE_IMEX) {
>  		if (psmouse_do_detect(genius_detect,
>  				      psmouse, set_properties) == 0)
> @@ -1056,6 +1063,15 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>  		.init		= alps_init,
>  	},
>  #endif
> +#ifdef CONFIG_MOUSE_PS2_BYD
> +	{
> +		.type		= PSMOUSE_BYD,
> +		.name		= "BydPS/2",
> +		.alias		= "byd",
> +		.detect		= byd_detect,
> +		.init		= byd_init
> +	},
> +#endif
>  #ifdef CONFIG_MOUSE_PS2_LIFEBOOK
>  	{
>  		.type		= PSMOUSE_LIFEBOOK,
> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
> index ad5a5a1..e0ca6cd 100644
> --- a/drivers/input/mouse/psmouse.h
> +++ b/drivers/input/mouse/psmouse.h
> @@ -104,6 +104,7 @@ enum psmouse_type {
>  	PSMOUSE_CYPRESS,
>  	PSMOUSE_FOCALTECH,
>  	PSMOUSE_VMMOUSE,
> +	PSMOUSE_BYD,
>  	PSMOUSE_AUTO		/* This one should always be last */
>  };
>  
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
