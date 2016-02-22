From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: byd - enable absolute mode
Date: Mon, 22 Feb 2016 12:05:53 -0800
Message-ID: <20160222200553.GC28343@dtor-ws>
References: <1455754072-16364-1-git-send-email-chris@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35912 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbcBVUF5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 15:05:57 -0500
Received: by mail-pa0-f49.google.com with SMTP id yy13so96252204pab.3
        for <linux-input@vger.kernel.org>; Mon, 22 Feb 2016 12:05:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455754072-16364-1-git-send-email-chris@diamand.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: linux-input@vger.kernel.org, Richard Pospesel <pospeselr@gmail.com>

Hi Chris,

On Thu, Feb 18, 2016 at 12:07:52AM +0000, Chris Diamand wrote:
> From: Richard Pospesel <pospeselr@gmail.com>
> 
> The Windows driver's settings dialog contains a visualization of the
> regions for the hardware edge scrolling capability, which uses a
> temporarily-enabled limited-resolution absolute mode.
> 
> This patch enables this during normal operation, and combines the
> absolute packets with the existing relative packets to provide
> accurate absolute position and touch reporting.
> 
> It also adds documentation for all known gesture packets and
> initialization commands.
> 
> Reviewed-by: Chris Diamand <chris@diamand.org>
> Signed-off-by: Richard Pospesel <pospeselr@gmail.com>
> [chris@diamand.org: add more detail to commit message]
> Signed-off-by: Chris Diamand <chris@diamand.org>
> ---
> (Resending on Richard's behalf with correct mailer settings)
> 
> Hi Dmitry,
> 
> I'm happy with this patch - would you mind taking a look at it please?
> 
> Thanks!
> Chris
> 
>  drivers/input/mouse/byd.c          | 578 ++++++++++++++++++++++++-------------
>  drivers/input/mouse/psmouse-base.c |   2 +-
>  2 files changed, 379 insertions(+), 201 deletions(-)
> 
> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index 9425e0f..5b004b2c 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -2,20 +2,32 @@
>   * BYD TouchPad PS/2 mouse driver
>   *
>   * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
> + * Copyright (C) 2015 Richard Pospesel <pospeselr@gmail.com>
> + * Copyright (C) 2015 Tai Chi Minh Ralph Eastwood
> + * Copyright (C) 2015 Martin Wimpress
> + * Copyright (C) 2015 Jay Kuri
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License version 2 as published by
>   * the Free Software Foundation.
> + *
> + * Protocol of BYD Touch Pad reverse-engineered from windows driver:
> + * filename:  "byd touchpad driver - win7, 8, 8.1 - 2.4.1.102.zip"
> + * md5:       0d5e4660b98fca9587a0df212fca3048
> + * sha1:      97a0eca8edc482bf9d08ab9509084a514dad4c4b
> + * datasheet: http://bydit.com/userfiles/file/BTP10463-XXX.pdf
>   */
>  
>  #include <linux/delay.h>
>  #include <linux/input.h>
>  #include <linux/libps2.h>
>  #include <linux/serio.h>
> +#include <linux/slab.h>
>  
>  #include "psmouse.h"
>  #include "byd.h"
>  
> +/* PS2 Bits */
>  #define PS2_Y_OVERFLOW	BIT_MASK(7)
>  #define PS2_X_OVERFLOW	BIT_MASK(6)
>  #define PS2_Y_SIGN	BIT_MASK(5)
> @@ -26,69 +38,247 @@
>  #define PS2_LEFT	BIT_MASK(0)
>  
>  /*
> - * The touchpad reports gestures in the last byte of each packet. It can take
> - * any of the following values:
> + * BYD pad constants
>   */
>  
> -/* One-finger scrolling in one of the edge scroll zones. */
> -#define BYD_SCROLLUP		0xCA
> -#define BYD_SCROLLDOWN		0x36
> -#define BYD_SCROLLLEFT		0xCB
> -#define BYD_SCROLLRIGHT		0x35
> -/* Two-finger scrolling. */
> -#define BYD_2DOWN		0x2B
> -#define BYD_2UP			0xD5
> -#define BYD_2LEFT		0xD6
> -#define BYD_2RIGHT		0x2A
> -/* Pinching in or out. */
> -#define BYD_ZOOMOUT		0xD8
> -#define BYD_ZOOMIN		0x28
> -/* Three-finger swipe. */
> -#define BYD_3UP			0xD3
> -#define BYD_3DOWN		0x2D
> -#define BYD_3LEFT		0xD4
> -#define BYD_3RIGHT		0x2C
> -/* Four-finger swipe. */
> -#define BYD_4UP			0xCD
> -#define BYD_4DOWN		0x33
> +/*
> + * True device resolution is unknown, however experiments show the
> + * resolution is about 111 units/mm.
> + * Absolute coordinate packets are in the range 0-255 for both X and Y
> + * we pick ABS_X/ABS_Y dimensions which are multiples of 256 and in
> + * the right ballpark given the touchpad's physical dimensions and estimate
> + * resolution per spec sheet, device active area dimensions are
> + * 101.6 x 60.1 mm.
> + */
> +#define BYD_PAD_WIDTH		11264
> +#define BYD_PAD_HEIGHT		6656
> +#define BYD_PAD_RESOLUTION	111
>  
> -int byd_detect(struct psmouse *psmouse, bool set_properties)
> -{
> -	struct ps2dev *ps2dev = &psmouse->ps2dev;
> -	unsigned char param[4];
> +/*
> + * Given the above dimensions, relative packets velocity is in multiples of
> + * 1 unit / 11 milliseconds.  We use this dt to estimate distance traveled
> + */
> +#define BYD_DT				11
> +/* Time in milliseconds used to timeout various touch events */
> +#define BYD_TOUCH_TIMEOUT_MS		64
> +#define BYD_TOUCH_TIMEOUT_JIFFIES	msecs_to_jiffies(BYD_TOUCH_TIMEOUT_MS)
>  
> -	param[0] = 0x03;
> -	param[1] = 0x00;
> -	param[2] = 0x00;
> -	param[3] = 0x00;
> +/* BYD commands reverse engineered from windows driver */
>  
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -		return -1;
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -		return -1;
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -		return -1;
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> -		return -1;
> -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> -		return -1;
> -
> -	if (param[1] != 0x03 || param[2] != 0x64)
> -		return -ENODEV;
> +/*
> + * Swipe gesture from off-pad to on-pad
> + *  0 : disable
> + *  1 : enable
> + */
> +#define BYD_CMD_SET_OFFSCREEN_SWIPE		0x10cc
> +/*
> + * Tap and drag delay time
> + *  0 : disable
> + *  1 - 8 : least to most delay
> + */
> +#define BYD_CMD_SET_TAP_DRAG_DELAY_TIME		0x10cf
> +/*
> + * Physical buttons function mapping
> + *  0 : enable
> + *  4 : normal
> + *  5 : left button custom command
> + *  6 : right button custom command
> + *  8 : disable
> + */
> +#define BYD_CMD_SET_PHYSICAL_BUTTONS		0x10d0
> +/*
> + * Absolute mode (1 byte X/Y resolution)
> + *  0 : disable
> + *  2 : enable
> + */
> +#define BYD_CMD_SET_ABSOLUTE_MODE		0x10d1
> +/*
> + * Two finger scrolling
> + *  1 : vertical
> + *  2 : horizontal
> + *  3 : vertical + horizontal
> + *  4 : disable
> + */
> +#define BYD_CMD_SET_TWO_FINGER_SCROLL		0x10d2
> +/*
> + * Handedness
> + *  1 : right handed
> + *  2 : left handed
> + */
> +#define BYD_CMD_SET_HANDEDNESS			0x10d3
> +/*
> + * Tap to click
> + *  1 : enable
> + *  2 : disable
> + */
> +#define BYD_CMD_SET_TAP				0x10d4
> +/*
> + * Tap and drag
> + *  1 : tap and hold to drag
> + *  2 : tap and hold to drag + lock
> + *  3 : disable
> + */
> +#define BYD_CMD_SET_TAP_DRAG			0x10d5
> +/*
> + * Touch sensitivity
> + *  1 - 7 : least to most sensitive
> + */
> +#define BYD_CMD_SET_TOUCH_SENSITIVITY		0x10d6
> +/*
> + * One finger scrolling
> + *  1 : vertical
> + *  2 : horizontal
> + *  3 : vertical + horizontal
> + *  4 : disable
> + */
> +#define BYD_CMD_SET_ONE_FINGER_SCROLL		0x10d7
> +/*
> + * One finger scrolling function
> + *  1 : free scrolling
> + *  2 : edge motion
> + *  3 : free scrolling + edge motion
> + *  4 : disable
> + */
> +#define BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC	0x10d8
> +/*
> + * Sliding speed
> + *  1 - 5 : slowest to fastest
> + */
> +#define BYD_CMD_SET_SLIDING_SPEED		0x10da
> +/*
> + * Edge motion
> + *  1 : disable
> + *  2 : enable when dragging
> + *  3 : enable when dragging and pointing
> + */
> +#define BYD_CMD_SET_EDGE_MOTION			0x10db
> +/*
> + * Left edge region size
> + *  0 - 7 : smallest to largest width
> + */
> +#define BYD_CMD_SET_LEFT_EDGE_REGION		0x10dc
> +/*
> + * Top edge region size
> + *  0 - 9 : smallest to largest height
> + */
> +#define BYD_CMD_SET_TOP_EDGE_REGION		0x10dd
> +/*
> + * Disregard palm press as clicks
> + *  1 - 6 : smallest to largest
> + */
> +#define BYD_CMD_SET_PALM_CHECK			0x10de
> +/*
> + * Right edge region size
> + *  0 - 7 : smallest to largest width
> + */
> +#define BYD_CMD_SET_RIGHT_EDGE_REGION		0x10df
> +/*
> + * Bottom edge region size
> + *  0 - 9 : smallest to largest height
> + */
> +#define BYD_CMD_SET_BOTTOM_EDGE_REGION		0x10e1
> +/*
> + * Multitouch gestures
> + *  1 : enable
> + *  2 : disable
> + */
> +#define BYD_CMD_SET_MULTITOUCH			0x10e3
> +/*
> + * Edge motion speed
> + *  0 : control with finger pressure
> + *  1 - 9 : slowest to fastest
> + */
> +#define BYD_CMD_SET_EDGE_MOTION_SPEED		0x10e4
> +/*
> + * Two finger scolling function
> + *  0 : free scrolling
> + *  1 : free scrolling (with momentum)
> + *  2 : edge motion
> + *  3 : free scrolling (with momentum) + edge motion
> + *  4 : disable
> + */
> +#define BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC	0x10e5
>  
> -	psmouse_dbg(psmouse, "BYD touchpad detected\n");
> +/*
> + * The touchpad generates a mixture of absolute and relative packets, indicated
> + * by the the last byte of each packet being set to one of the following:
> + */
> +#define BYD_PACKET_ABSOLUTE			0xf8
> +#define BYD_PACKET_RELATIVE			0x00
> +/* Multitouch gesture packets */
> +#define BYD_PACKET_PINCH_IN			0xd8
> +#define BYD_PACKET_PINCH_OUT			0x28
> +#define BYD_PACKET_ROTATE_CLOCKWISE		0x29
> +#define BYD_PACKET_ROTATE_ANTICLOCKWISE		0xd7
> +#define BYD_PACKET_TWO_FINGER_SCROLL_RIGHT	0x2a
> +#define BYD_PACKET_TWO_FINGER_SCROLL_DOWN	0x2b
> +#define BYD_PACKET_TWO_FINGER_SCROLL_UP		0xd5
> +#define BYD_PACKET_TWO_FINGER_SCROLL_LEFT	0xd6
> +#define BYD_PACKET_THREE_FINGER_SWIPE_RIGHT	0x2c
> +#define BYD_PACKET_THREE_FINGER_SWIPE_DOWN	0x2d
> +#define BYD_PACKET_THREE_FINGER_SWIPE_UP	0xd3
> +#define BYD_PACKET_THREE_FINGER_SWIPE_LEFT	0xd4
> +#define BYD_PACKET_FOUR_FINGER_DOWN		0x33
> +#define BYD_PACKET_FOUR_FINGER_UP		0xcd
> +#define BYD_PACKET_REGION_SCROLL_RIGHT		0x35
> +#define BYD_PACKET_REGION_SCROLL_DOWN		0x36
> +#define BYD_PACKET_REGION_SCROLL_UP		0xca
> +#define BYD_PACKET_REGION_SCROLL_LEFT		0xcb
> +#define BYD_PACKET_RIGHT_CORNER_CLICK		0xd2
> +#define BYD_PACKET_LEFT_CORNER_CLICK		0x2e
> +#define BYD_PACKET_LEFT_AND_RIGHT_CORNER_CLICK	0x2f
> +#define BYD_PACKET_ONTO_PAD_SWIPE_RIGHT		0x37
> +#define BYD_PACKET_ONTO_PAD_SWIPE_DOWN		0x30
> +#define BYD_PACKET_ONTO_PAD_SWIPE_UP		0xd0
> +#define BYD_PACKET_ONTO_PAD_SWIPE_LEFT		0xc9
> +
> +struct byd_data {
> +	struct timer_list timer;
> +	s32 abs_x;
> +	s32 abs_y;
> +	u32 last_touch_time;
> +	bool btn_left  : 1;
> +	bool btn_right : 1;
> +	bool touch     : 1;

I'd rather we did not use bitfields here: I do not think we are actually
saving any memory and we definitely pay read/modify/update penalty if
they are packed into single byte.

> +};
> +
> +static void byd_report_input(struct psmouse *psmouse)
> +{
> +	struct byd_data *priv = psmouse->private;
> +	struct input_dev *dev = psmouse->dev;
>  
> -	if (set_properties) {
> -		psmouse->vendor = "BYD";
> -		psmouse->name = "TouchPad";
> -	}
> +	input_report_abs(dev, ABS_X, priv->abs_x);
> +	input_report_abs(dev, ABS_Y, priv->abs_y);
> +	input_report_key(dev, BTN_LEFT, priv->btn_left);
> +	input_report_key(dev, BTN_RIGHT, priv->btn_right);
> +	input_report_key(dev, BTN_TOUCH, priv->touch);

Please report BTN_TOUCH first, it will help mousedev to handle the
device.

> +	input_report_key(dev, BTN_TOOL_FINGER, priv->touch);
> +	input_sync(dev);
> +}
>  
> -	return 0;
> +static void byd_clear_touch(unsigned long data)
> +{
> +	struct psmouse *psmouse = (struct psmouse *)data;
> +	struct byd_data *priv = psmouse->private;
> +
> +	serio_pause_rx(psmouse->ps2dev.serio);
> +	priv->touch = false;
> +	/*
> +	 * Move cursor back to center of pad when we lose touch - this
> +	 * specifically improves user experience when moving cursor with one
> +	 * finger, and pressing a button with another.
> +	 */
> +	priv->abs_x = BYD_PAD_WIDTH / 2;
> +	priv->abs_y = BYD_PAD_HEIGHT / 2
> +;	byd_report_input(psmouse);

Semicolon should go to previous line. I am also confused why we need to
report coordinates when BTN_TOUCH will be 0, especially if BTN_TOUCH is
reported first. None of the other devices need this.

> +
> +	serio_continue_rx(psmouse->ps2dev.serio);
>  }
>  
>  static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
>  {
> -	struct input_dev *dev = psmouse->dev;
> +	struct byd_data *priv = psmouse->private;
> +	u32 now = jiffies_to_msecs(jiffies);
>  	u8 *pkt = psmouse->packet;
>  
>  	if (psmouse->pktcnt > 0 && !(pkt[0] & PS2_ALWAYS_1)) {
> @@ -102,53 +292,33 @@ static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
>  
>  	/* Otherwise, a full packet has been received */
>  	switch (pkt[3]) {
> -	case 0: {
> +	case BYD_PACKET_ABSOLUTE:
> +		/* Only use absolute packets for the start of movement. */
> +		if (!priv->touch) {
> +			priv->abs_x = pkt[1] * (BYD_PAD_WIDTH / 256);
> +			priv->abs_y = (255 - pkt[2]) *
> +				      (BYD_PAD_HEIGHT / 256);
> +
> +			/* needed to detect tap */
> +			if (now - priv->last_touch_time > BYD_TOUCH_TIMEOUT_MS)
> +				priv->touch = true;

This is not correct: it will break when time wraps around. If you need
to store/compare times do it in jiffies and use
time_before()/time_after() API.

But I am confused why you need this. Can you please explain?

Thanks.

-- 
Dmitry
