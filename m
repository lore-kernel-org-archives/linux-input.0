From: Richard Pospesel <pospeselr@gmail.com>
Subject: Re: [PATCH] psmouse: added BYD touchpad driver
Date: Tue, 2 Feb 2016 18:30:16 -0800
Message-ID: <CAHc7Qt0RUV4D7TzdrgRyxXqKYSnBfo+FxQm+GkozWKY7dVY8Sg@mail.gmail.com>
References: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
	<20160203004153.GA15147@smaug>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34462 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380AbcBCCaR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Feb 2016 21:30:17 -0500
Received: by mail-io0-f179.google.com with SMTP id 9so40328497iom.1
        for <linux-input@vger.kernel.org>; Tue, 02 Feb 2016 18:30:17 -0800 (PST)
In-Reply-To: <20160203004153.GA15147@smaug>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Chris,

Reporting absolute position allows the synaptics and libinput xorg
drivers to treat the BYD touchpad as a touchpad, rather than a mouse.
This allows edge scrolling, tap to click, natural scrolling and any
other location based single touch gesture to work.

I opted to completely disable the hardware multitouch gesture
recognition (including two finger scroll) for a couple of reasons:

1.  time delta between gesture packets was very large resulting in a
rather jerky scrolling experience, especially compared to touchpad
with real multitouch reporting.
2.  Reporting absolute position and touch support enables the users to
configure the touchpad in the touchpad settings section of gnome,
cinnamon, etc because those applets configure synaptics and libinput.
Otherwise xorg thinks it's just a mouse.
3.  Enabling multitouch gesture recognition results in the mouse
cursor freezing up when the user uses two fingers, one to move the
mouse cursor and another to click.  This is because movement packets
stop getting sent while a gesture (such as pinch, rotate, etc) is
being detected and/or reported.  Disabling all hardware gesture
detection, including two finger scroll, provides the most fluid user
experience.

Regarding serio_pause_rx(), I was following a pattern similar to
another touchpad driver in psmouse.  That whole callback mechanism is
required to report the touch had ended, since the BYD hardware only
sends packets when a touch is occurring.  Is there a better way?

I'll try to rebase and post an updated patch tonight.

best,
Richard

On Tue, Feb 2, 2016 at 4:41 PM, Chris Diamand <chris@diamand.org> wrote:
> Hi Richard,
>
>> This adds proper single-touch support for BYD touchpads to the psmouse input
>> driver.
>
> I posted a driver for the same touchpad a few weeks ago, which has been merged
> into linux-next. There's some stuff in this patch which is missing in my driver
> though, so we should definitely try and include that, and I'm very curious
> about the pseudo-absolute mode.
>
>> This patch is against commit b82dde0230439215b55e545880e90337ee16f51a (Merge tag
>> 'please-pull-copy_file_range' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux ) of Linus' kernel
>> branch.
>
> Can you rebase against
> 'git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input'?
>
>> +/* BYD commands reverse engineered from windows driver */
>> +
>> +/*
>> + * swipe gesture from off-pad to on-pad
>> + *  0 : disable
>> + *  1 : enable
>> + */
>> +#define BYD_CMD_SET_OFFSCREEN_SWIPE             0xcc
>> +/*
>> + * tap and drag delay time
>> + *  0 : disable
>> + *  1 - 8 : least to most delay
>> + */
>> +#define BYD_CMD_SET_TAP_DRAG_DELAY_TIME         0xcf
>> +/*
>> + * physical buttons function mapping
>> + *  0 : enable
>> + *  4 : normal
>> + *  5 : left button custom command
>> + *  6 : right button custom command
>> + *  8 : disable
>> + */
>> +#define BYD_CMD_SET_PHYSICAL_BUTTONS            0xd0
>> +/*
>> + * absolute mode (1 byte X/Y resolution)
>> + *  0 : disable
>> + *  2 : enable
>> + */
>> +#define BYD_CMD_SET_ABSOLUTE_MODE               0xd1
>> +/*
>> + * two finger scrolling
>> + *  1 : vertical
>> + *  2 : horizontal
>> + *  3 : vertical + horizontal
>> + *  4 : disable
>> + */
>> +#define BYD_CMD_SET_TWO_FINGER_SCROLL           0xd2
>> +/*
>> + * handedness
>> + *  1 : right handed
>> + *  2 : left handed
>> + */
>> +#define BYD_CMD_SET_HANDEDNESS                  0xd3
>> +/*
>> + * tap to click
>> + *  1 : enable
>> + *  2 : disable
>> + */
>> +#define BYD_CMD_SET_TAP                         0xd4
>> +/*
>> + * tap and drag
>> + *  1 : tap and hold to drag
>> + *  2 : tap and hold to drag + lock
>> + *  3 : disable
>> + */
>> +#define BYD_CMD_SET_TAP_DRAG                    0xd5
>> +/*
>> + * touch sensitivity
>> + *  1 - 7 : least to most sensitive
>> + */
>> +#define BYD_CMD_SET_TOUCH_SENSITIVITY           0xd6
>> +/*
>> + * one finger scrolling
>> + *  1 : vertical
>> + *  2 : horizontal
>> + *  3 : vertical + horizontal
>> + *  4 : disable
>> + */
>> +#define BYD_CMD_SET_ONE_FINGER_SCROLL           0xd7
>> +/*
>> + * one finger scrolling function
>> + *  1 : free scrolling
>> + *  2 : edge motion
>> + *  3 : free scrolling + edge motion
>> + *  4 : disable
>> + */
>> +#define BYD_CMD_SET_ONE_FINGER_SCROLL_FUNC      0xd8
>> +/*
>> + * sliding speed
>> + *  1 - 5 : slowest to fastest
>> + */
>> +#define BYD_CMD_SET_SLIDING_SPEED               0xda
>> +/*
>> + * edge motion
>> + *  1 : disable
>> + *  2 : enable when dragging
>> + *  3 : enable when dragging and pointing
>> + */
>> +#define BYD_CMD_SET_EDGE_MOTION                 0xdb
>> +/*
>> + * left edge region size
>> + *  0 - 7 : smallest to largest width
>> + */
>> +#define BYD_CMD_SET_LEFT_EDGE_REGION            0xdc
>> +/*
>> + * top edge region size
>> + *  0 - 9 : smallest to largest height
>> + */
>> +#define BYD_CMD_SET_TOP_EDGE_REGION             0xdd
>> +/*
>> + * disregard palm press as clicks
>> + *  1 - 6 : smallest to largest
>> + */
>> +#define BYD_CMD_SET_PALM_CHECK                  0xde
>> +/* right edge region size
>> + *  0 - 7 : smallest to largest width
>> + */
>> +#define BYD_CMD_SET_RIGHT_EDGE_REGION           0xdf
>> +/*
>> + * bottom edge region size
>> + *  0 - 9 : smallest to largest height
>> + */
>> +#define BYD_CMD_SET_BOTTOM_EDGE_REGION          0xe1
>> +/*
>> + * multitouch gestures
>> + *  1 : enable
>> + *  2 : disable
>> + */
>> +#define BYD_CMD_SET_MULTITOUCH                  0xe3
>> +/*
>> + * edge motion speed
>> + *  0 : control with finger pressure
>> + *  1 - 9 : slowest to fastest
>> + */
>> +#define BYD_CMD_SET_EDGE_MOTION_SPEED           0xe4
>> +/*
>> + * two finger scolling function
>> + *  0 : free scrolling
>> + *  1 : free scrolling (with momentum)
>> + *  2 : edge motion
>> + *  3 : free scrolling (with momentum) + edge motion
>> + *  4 : disable
>> + */
>> +#define BYD_CMD_SET_TWO_FINGER_SCROLL_FUNC      0xe5
>
> These are definitely worth merging into the existing driver - I never got the
> time to figure out all of the different settings.
>
>> +
>> +struct byd_data {
>> + struct timer_list timer;
>> + int32_t abs_x;
>> + int32_t abs_y;
>> + uint32_t last_touch_time;
>> + uint32_t button_left      : 1;
>> + uint32_t button_right     : 1;
>> + uint32_t touch            : 1;
>> +};
>> +
>
> It looks like whatever email client you used has broken the formatting - when
> you resend, can you use something which will preserve whitespace properly? See
> 'Documentation/email-clients.txt'.
>
>> +static void byd_report_input(struct psmouse *psmouse)
>> +{
>> + struct byd_data *priv = (struct byd_data *)psmouse->private;
>> + struct input_dev *dev = psmouse->dev;
>> +
>> + input_report_abs(dev, ABS_X, priv->abs_x);
>> + input_report_abs(dev, ABS_Y, priv->abs_y);
>> + input_report_key(dev, BTN_LEFT, priv->button_left);
>> + input_report_key(dev, BTN_RIGHT, priv->button_right);
>> + input_report_key(dev, BTN_TOUCH, priv->touch);
>> + input_report_key(dev, BTN_TOOL_FINGER, priv->touch);
>> +
>> + input_sync(dev);
>> +}
>
> Could you explain generally why you're reporting in absolute mode? What
> advantage does it have over using relative reporting and turning off the
> absolute packets in the touchpad init sequence?
>
>> +
>> +static void byd_clear_touch(unsigned long data)
>> +{
>> + struct psmouse *psmouse = (struct psmouse *)data;
>> + struct byd_data *priv = psmouse->private;
>> +
>> + serio_pause_rx(psmouse->ps2dev.serio);
>> +
>> + priv->touch = 0;
>> + /*
>> + * move cursor back to center of pad when we lose touch
>> + * this specifically improves user experiencce when moving
>> + * cursor with one finger, and pressing butoton with other
>> + */
>> + priv->abs_x = BYD_CONST_PAD_WIDTH / 2;
>> + priv->abs_y = BYD_CONST_PAD_HEIGHT / 2;
>> +
>> + byd_report_input(psmouse);
>
> serio_pause_rx() takes a spinlock - might be worth checking that
> byd_report_input() doesn't do anything that might sleep.
>
>> + switch (packet[3]) {
>> + case BYD_PKT_ABSOLUTE:
>> + /* on first touch, use the absolute packet to determine our start location */
>> + if (priv->touch == 0) {
>> + priv->abs_x = packet[1] * (BYD_CONST_PAD_WIDTH / 256);
>> + priv->abs_y = (255 - packet[2]) * (BYD_CONST_PAD_HEIGHT / 256);
>> +
>> + /* needed to detect tap */
>> + if (now_msecs - priv->last_touch_time > 64) {
>> + priv->touch = 1;
>> + }
>> + }
>> + break;
>> + case BYD_PKT_RELATIVE:
>> + {
>> + int32_t rel_x, rel_y;
>> +
>> + /* same as regular PS/2 psmouse protocoal */
>> + rel_x = packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0;
>> + rel_y = packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0;
>> +
>> + /*
>> + * experiments show relative mouse packets come in increments of
>> + * 1 unit / 11 msecs (regardless of time delta between relative packets)
>> + */
>> + priv->abs_x += rel_x * 11;
>> + priv->abs_y += rel_y * 11;
>> +
>> + priv->touch = 1;
>> + }
>
> So can this not handle gestures/multitouch?
>
> Cheers!
> Chris
