From: Chris Diamand <chris@diamand.org>
Subject: Re: [PATCH] psmouse: added BYD touchpad driver
Date: Wed, 3 Feb 2016 00:41:53 +0000
Message-ID: <20160203004153.GA15147@smaug>
References: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36113 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbcBCAl5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Feb 2016 19:41:57 -0500
Received: by mail-wm0-f49.google.com with SMTP id p63so142580374wmp.1
        for <linux-input@vger.kernel.org>; Tue, 02 Feb 2016 16:41:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Pospesel <pospeselr@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Richard,

> This adds proper single-touch support for BYD touchpads to the psmouse input
> driver.

I posted a driver for the same touchpad a few weeks ago, which has been merged
into linux-next. There's some stuff in this patch which is missing in my driver
though, so we should definitely try and include that, and I'm very curious
about the pseudo-absolute mode.

> This patch is against commit b82dde0230439215b55e545880e90337ee16f51a (Merge tag
> 'please-pull-copy_file_range' of
> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux ) of Linus' kernel
> branch.

Can you rebase against
'git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input'?

> +/* BYD commands reverse engineered from windows driver */
> +
> +/*
> + * swipe gesture from off-pad to on-pad
> + *  0 : disable
> + *  1 : enable
> + */
> +#define BYD_CMD_SET_OFFSCREEN_SWIPE             0xcc
> +/*
> + * tap and drag delay time
> + *  0 : disable
> + *  1 - 8 : least to most delay
> + */
> +#define BYD_CMD_SET_TAP_DRAG_DELAY_TIME         0xcf
> +/*
> + * physical buttons function mapping
> + *  0 : enable
> + *  4 : normal
> + *  5 : left button custom command
> + *  6 : right button custom command
> + *  8 : disable
> + */
> +#define BYD_CMD_SET_PHYSICAL_BUTTONS            0xd0
> +/*
> + * absolute mode (1 byte X/Y resolution)
> + *  0 : disable
> + *  2 : enable
> + */
> +#define BYD_CMD_SET_ABSOLUTE_MODE               0xd1
> +/*
> + * two finger scrolling
> + *  1 : vertical
> + *  2 : horizontal
> + *  3 : vertical + horizontal
> + *  4 : disable
> + */
> +#define BYD_CMD_SET_TWO_FINGER_SCROLL           0xd2
> +/*
> + * handedness
> + *  1 : right handed
> + *  2 : left handed
> + */
> +#define BYD_CMD_SET_HANDEDNESS                  0xd3
> +/*
> + * tap to click
> + *  1 : enable
> + *  2 : disable
> + */
> +#define BYD_CMD_SET_TAP                         0xd4
> +/*
> + * tap and drag
> + *  1 : tap and hold to drag
> + *  2 : tap and hold to drag + lock
> + *  3 : disable
> + */
> +#define BYD_CMD_SET_TAP_DRAG                    0xd5
> +/*
> + * touch sensitivity
> + *  1 - 7 : least to most sensitive
> + */
> +#define BYD_CMD_SET_TOUCH_SENSITIVITY           0xd6
> +/*
> + * one finger scrolling
> + *  1 : vertical
> + *  2 : horizontal
> + *  3 : vertical + horizontal
> + *  4 : disable
> + */
> +#define BYD_CMD_SET_ONE_FINGER_SCROLL           0xd7
> +/*
> + * one finger scrolling function
> + *  1 : free scrolling
> + *  2 : edge motion
> + *  3 : free scrolling + edge motion
> + *  4 : disable
> + */
> +#define BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC      0xd8
> +/*
> + * sliding speed
> + *  1 - 5 : slowest to fastest
> + */
> +#define BYD_CMD_SET_SLIDING_SPEED               0xda
> +/*
> + * edge motion
> + *  1 : disable
> + *  2 : enable when dragging
> + *  3 : enable when dragging and pointing
> + */
> +#define BYD_CMD_SET_EDGE_MOTION                 0xdb
> +/*
> + * left edge region size
> + *  0 - 7 : smallest to largest width
> + */
> +#define BYD_CMD_SET_LEFT_EDGE_REGION            0xdc
> +/*
> + * top edge region size
> + *  0 - 9 : smallest to largest height
> + */
> +#define BYD_CMD_SET_TOP_EDGE_REGION             0xdd
> +/*
> + * disregard palm press as clicks
> + *  1 - 6 : smallest to largest
> + */
> +#define BYD_CMD_SET_PALM_CHECK                  0xde
> +/* right edge region size
> + *  0 - 7 : smallest to largest width
> + */
> +#define BYD_CMD_SET_RIGHT_EDGE_REGION           0xdf
> +/*
> + * bottom edge region size
> + *  0 - 9 : smallest to largest height
> + */
> +#define BYD_CMD_SET_BOTTOM_EDGE_REGION          0xe1
> +/*
> + * multitouch gestures
> + *  1 : enable
> + *  2 : disable
> + */
> +#define BYD_CMD_SET_MULTITOUCH                  0xe3
> +/*
> + * edge motion speed
> + *  0 : control with finger pressure
> + *  1 - 9 : slowest to fastest
> + */
> +#define BYD_CMD_SET_EDGE_MOTION_SPEED           0xe4
> +/*
> + * two finger scolling function
> + *  0 : free scrolling
> + *  1 : free scrolling (with momentum)
> + *  2 : edge motion
> + *  3 : free scrolling (with momentum) + edge motion
> + *  4 : disable
> + */
> +#define BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC      0xe5

These are definitely worth merging into the existing driver - I never got the
time to figure out all of the different settings.

> +
> +struct byd_data {
> + struct timer_list timer;
> + int32_t abs_x;
> + int32_t abs_y;
> + uint32_t last_touch_time;
> + uint32_t button_left      : 1;
> + uint32_t button_right     : 1;
> + uint32_t touch            : 1;
> +};
> +

It looks like whatever email client you used has broken the formatting - when
you resend, can you use something which will preserve whitespace properly? See
'Documentation/email-clients.txt'.

> +static void byd_report_input(struct psmouse *psmouse)
> +{
> + struct byd_data *priv = (struct byd_data *)psmouse->private;
> + struct input_dev *dev = psmouse->dev;
> +
> + input_report_abs(dev, ABS_X, priv->abs_x);
> + input_report_abs(dev, ABS_Y, priv->abs_y);
> + input_report_key(dev, BTN_LEFT, priv->button_left);
> + input_report_key(dev, BTN_RIGHT, priv->button_right);
> + input_report_key(dev, BTN_TOUCH, priv->touch);
> + input_report_key(dev, BTN_TOOL_FINGER, priv->touch);
> +
> + input_sync(dev);
> +}

Could you explain generally why you're reporting in absolute mode? What
advantage does it have over using relative reporting and turning off the
absolute packets in the touchpad init sequence?

> +
> +static void byd_clear_touch(unsigned long data)
> +{
> + struct psmouse *psmouse = (struct psmouse *)data;
> + struct byd_data *priv = psmouse->private;
> +
> + serio_pause_rx(psmouse->ps2dev.serio);
> +
> + priv->touch = 0;
> + /*
> + * move cursor back to center of pad when we lose touch
> + * this specifically improves user experiencce when moving
> + * cursor with one finger, and pressing butoton with other
> + */
> + priv->abs_x = BYD_CONST_PAD_WIDTH / 2;
> + priv->abs_y = BYD_CONST_PAD_HEIGHT / 2;
> +
> + byd_report_input(psmouse);

serio_pause_rx() takes a spinlock - might be worth checking that
byd_report_input() doesn't do anything that might sleep.

> + switch (packet[3]) {
> + case BYD_PKT_ABSOLUTE:
> + /* on first touch, use the absolute packet to determine our start location */
> + if (priv->touch == 0) {
> + priv->abs_x = packet[1] * (BYD_CONST_PAD_WIDTH / 256);
> + priv->abs_y = (255 - packet[2]) * (BYD_CONST_PAD_HEIGHT / 256);
> +
> + /* needed to detect tap */
> + if (now_msecs - priv->last_touch_time > 64) {
> + priv->touch = 1;
> + }
> + }
> + break;
> + case BYD_PKT_RELATIVE:
> + {
> + int32_t rel_x, rel_y;
> +
> + /* same as regular PS/2 psmouse protocoal */
> + rel_x = packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0;
> + rel_y = packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0;
> +
> + /*
> + * experiments show relative mouse packets come in increments of
> + * 1 unit / 11 msecs (regardless of time delta between relative packets)
> + */
> + priv->abs_x += rel_x * 11;
> + priv->abs_y += rel_y * 11;
> +
> + priv->touch = 1;
> + }

So can this not handle gestures/multitouch?

Cheers!
Chris
