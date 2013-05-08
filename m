From: Todd Showalter <todd@electronjump.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Wed, 8 May 2013 12:40:51 -0400
Message-ID: <CAFmpkyigapfb52ke-8vvKcwqmF8EVsUF8md-0kFTHHDxDzKxRA@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
	<CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
	<CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
	<CANq1E4T9eoBVvbq8J+2ps5CJ-9G1782j7TjanqWLJVUCQ1k60g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:59975 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab3EHQkw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 May 2013 12:40:52 -0400
Received: by mail-qe0-f50.google.com with SMTP id k5so1220980qej.23
        for <linux-input@vger.kernel.org>; Wed, 08 May 2013 09:40:52 -0700 (PDT)
In-Reply-To: <CANq1E4T9eoBVvbq8J+2ps5CJ-9G1782j7TjanqWLJVUCQ1k60g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, May 8, 2013 at 11:33 AM, David Herrmann <dh.herrmann@gmail.com> wrote:

>>     They're digital on the classic pro, but they're analog on the
>> classic, IIRC.  I believe they also have separate "button" values when
>> they bottom out, much like the gamecube controller, but that's beyond
>> the scope of the standard gamepad I'm proposing.
>
> What's the problem with using both, ABS _and_ BTN? I don't think we
> should do any interpretation in the kernel. Devices that have analog
> triggers report ABS_XTRIG, devices with digital triggers report
> BTN_TX. Userspace simply needs to listen for both. And if a device
> exports both (like the Wii classic controller), they simply export
> both and userspace chooses whatever it prefers.

    My opinion is that the kernel is the right place to provide
hardware abstraction, and that a standard gamepad is useful the same
way a standard mouse, a standard ethernet device or a standard
filesystem interface are useful abstractions.  That is, I don't want
to have to care who made it if I want to make normal use of it.  My
opinion isn't universally shared, however, so I'm working on a library
to sit between the kernel and things that want a standard gamepad.

> As long as both ABS_XTRIG and BTN_TX are defined to correspond to the
> same triggers, I think it's better to use both. Or am I missing
> something?

    The problem is the specific thing I'm trying to solve with the
idea of the standard gamepad.  Right now, if I open() something in
/dev/input that seems like it ought to be a gamepad, I get a giant
unsorted bag of events that are only comprehensible via a priori
knowledge.  I keep coming back to the ps3 controller because it's the
worst offender that I've found; the right stick maps to ABS_Z, ABS_RZ,
while the XBox controller right stick maps to ABS_RX, ABS_RY.  This is
not documented anywhere I've found, and I've no idea what quirks other
controllers have in their mappings or whether they are documented or
not.

    What I'm trying to do is make it so that there are five categories
of control, in order of usefulness to games:

1) known controls that all sane gamepads will have (left stick, dpad,
NSEW buttons...)
2) known controls that most sane gamepads will have (right stick...)
3) known controls that many gamepads have (system/mode button, select button...)
4) common things (accelerometers...)
5) device-specific controls

    Right now, almost everything is in bucket 5, and from a game
development point of view that sucks.  The further up the buckets we
can move a control, the better.

    So, the problem that I have with "devices that have analog
triggers report XTRIG, devices with digital triggers report TX" is
that absent a common mapping I now potentially have to care about the
difference when I'm developing a game.  It moves these to bucket 3,
which means as a developer I likely just don't use them unless my game
really needs them.

> As I said before, I don't really care. I will send v2 with a patch
> that introduces these buttons. Lets see what Dmitry thinks.
>
> But we need a user-space library, anyway, to get button-names (as I
> explained earlier).

    I'm working on that. :)

> No, I meant what's wrong with re-using BTN_ZX for this purpose? Why
> introduce new constants? Just say, all new drivers must not use BTN_ZX
> if it's not a shoulder button. This avoids introducing BTN_XSHOULDER.

    I suppose we could just use that.  It probably makes more sense to
use BTN_TL and BTN_TR, though; the xbox 360 controller maps LB and RB
to BTN_TL and BTN_TR, and they're equivalent placement and function.

> And btw., there is no BTN_ZL/ZR, I meant BTN_TL2/TR2.. sorry for the
> confusion, my bad.

    Fair enough.

> So how about the following?
>
> +static const __u16 wiimod_pro_map[] = {
> +       BTN_EAST,          /* WIIMOD_PRO_KEY_A */
> +       BTN_SOUTH,          /* WIIMOD_PRO_KEY_B */
> +       BTN_NORTH,          /* WIIMOD_PRO_KEY_X */
> +       BTN_WEST,          /* WIIMOD_PRO_KEY_Y */
> +       BTN_START,      /* WIIMOD_PRO_KEY_PLUS */
> +       BTN_SELECT,     /* WIIMOD_PRO_KEY_MINUS */
> +       BTN_MODE,       /* WIIMOD_PRO_KEY_HOME */
> +       BTN_DLEFT,       /* WIIMOD_PRO_KEY_LEFT */
> +       BTN_DRIGHT,      /* WIIMOD_PRO_KEY_RIGHT */
> +       BTN_DUP,         /* WIIMOD_PRO_KEY_UP */
> +       BTN_DDOWN,       /* WIIMOD_PRO_KEY_DOWN */
> +       BTN_TL,         /* WIIMOD_PRO_KEY_TL */
> +       BTN_TR,         /* WIIMOD_PRO_KEY_TR */
> +       BTN_TL2,        /* WIIMOD_PRO_KEY_ZL */
> +       BTN_TR2,        /* WIIMOD_PRO_KEY_ZR */
> +       BTN_THUMBL,     /* WIIMOD_PRO_KEY_THUMBL */
> +       BTN_THUMBR,     /* WIIMOD_PRO_KEY_THUMBR */
> +};
>
> That would introduce BTN_DLEFT/DRIGHT/DUP/DDOWN for D-Pad buttons and
> BTN_EAST/SOUTH/NORTH/WEST for action buttons.

    That looks fine to me.

                                      Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
