From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH v2] Documentation: Add evdev type and code definitions
Date: Fri, 7 Jan 2011 19:15:56 -0600
Message-ID: <AANLkTi=u=zft-0fyUEPz0n2+xC7EgWE7TyQudHScNu0P@mail.gmail.com>
References: <1294435695-16750-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37391 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1AHBP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 20:15:57 -0500
In-Reply-To: <1294435695-16750-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Peter Hutterer <peter.hutterer@who-t.net>, Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Chase,

On Fri, Jan 7, 2011 at 3:28 PM, Chase Douglas
<chase.douglas@canonical.com> wrote:
> This commit adds the file Documentation/input/evdev-codes.txt.
>
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Cc: Chris Bagwell <chris@cnpbagwell.com>
> Cc: Peter Hutterer <peter.hutterer@who-t.net>
> Cc: Nikolai Kondrashov <spbnick@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
> =A0Documentation/input/evdev-codes.txt | =A0206 +++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 206 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/input/evdev-codes.txt
>
> diff --git a/Documentation/input/evdev-codes.txt b/Documentation/inpu=
t/evdev-codes.txt
> new file mode 100644
> index 0000000..8d7262c
> --- /dev/null
> +++ b/Documentation/input/evdev-codes.txt
> @@ -0,0 +1,206 @@
> +The evdev protocol uses a map of types and codes to express input de=
vice values
> +to userspace. This document describes the types and codes and how an=
d when they
> +may be used.
> +
> +The evdev protocol is a stateful protocol. Events are emitted only w=
hen values
> +of evdev codes have changed. However, the state is maintained within=
 the Linux
> +input subsystem; drivers do not need to maintain the state and may a=
ttempt to
> +emit unchanged values without harm. Userspace may obtain the current=
 state of
> +evdev code values using the EVIOCGABS ioctl defined in linux/input.h=
=2E
> +
> +Types:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Types are groupings of codes under a logical input construct. Each t=
ype has a
> +set of applicable codes to be used in generating events. See the Cod=
es section
> +for details on valid codes for each type.
> +
> +* EV_SYN:
> + =A0- Used as markers to separate events. Events may be separated in=
 time or in
> + =A0 =A0space, such as with the multitouch protocol.
> +
> +* EV_KEY:
> + =A0- Used to describe keyboard and other key-like input events.
> +
> +* EV_REL:
> + =A0- Used to describe relative input events, e.g. moving the mouse =
5 units to the
> + =A0 =A0left.
> +
> +* EV_ABS:
> + =A0- Used to describe absolute input events, e.g. describing the co=
ordinates of a
> + =A0 =A0touch on a touchscreen.
> +
> +* EV_MSC:
> + =A0- Used to describe miscellaneous input events that do not fit in=
to other
> + =A0 =A0types.
> +
> +* EV_SW:
> + =A0- Used to describe binary state input switches.
> +
> +* EV_LED:
> + =A0- Used to turn LEDs on devices on and off.
> +
> +* EV_SND:
> + =A0- Used to output sound to devices.
> +
> +* EV_REP:
> + =A0- Used for autorepeating devices.
> +
> +* EV_FF:
> + =A0- Used to send force feedback commands to an input device.
> +
> +* EV_PWR:
> + =A0- A special type for power button and switch input.
> +
> +* EV_FF_STATUS:
> + =A0- Used to receive force feedback device status.
> +
> +Codes:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Codes define the precise type of event.
> +
> +EV_SYN:
> +----------
> +EV_SYN event values are undefined. Their usage is
> +defined only by when they are sent in the evdev event stream.
> +
> +* SYN_REPORT:
> + =A0- Used to synchronize and separate events into frames of time. F=
or example,
> + =A0 =A0motion of a mouse may set the REL_X and REL_Y values for one=
 motion, then
> + =A0 =A0emit a SYN_REPORT. The next motion will emit more REL_X and =
REL_Y values and
> + =A0 =A0send another SYN_REPORT.
> +
> +* SYN_CONFIG:
> + =A0- TBD
> +
> +* SYN_MT_REPORT:
> + =A0- Used to synchronize and separate touch events. See the
> + =A0 =A0multi-touch-protocol.txt document for more information.
> +
> +EV_KEY:
> +----------
> +EV_KEY events take the form KEY_<name> or BTN_<name>. For example, K=
EY_A is used
> +to represent the 'A' key on a keyboard. When a key is depressed, an =
event with
> +the key's code is emitted with value 1. When the key is released, an=
 event is
> +emitted with value 0. Some hardware send events when a key is repeat=
ed. These
> +events have a value of 2. In general, KEY_<name> is used for keyboar=
d keys, and
> +BTN_<name> is used for other types of momentary switch events.
> +
> +A few EV_KEY codes have special meanings:
> +
> +* BTN_TOOL_<name>:
> + =A0- These codes are used in conjunction with input trackpads, tabl=
ets, and
> + =A0 =A0touchscreens. These devices may be used with fingers, pens, =
or other tools.
> + =A0 =A0When an event occurs and a tool is used, the corresponding B=
TN_TOOL_<name>
> + =A0 =A0code should be set to a value of 1. When the tool is no long=
er interacting
> + =A0 =A0with the input device, the BTN_TOOL_<name> code should be re=
set to 0. All
> + =A0 =A0trackpads, tablets, and touchscreens should use at least one=
 BTN_TOOL_<name>
> + =A0 =A0code when events are generated.
> +
> +* BTN_TOUCH:
> + =A0 =A0BTN_TOUCH is used for touch contact. While an input tool is =
determined to be
> + =A0 =A0within meaningful physical contact, the value of this proper=
ty must be set
> + =A0 =A0to 1. Meaningful physical contact may mean any contact, or i=
t may mean
> + =A0 =A0contact conditioned by an implementation defined property. F=
or example, a
> + =A0 =A0touchpad may set the value to 1 only when the touch pressure=
 rises above a
> + =A0 =A0certain value. BTN_TOUCH may be combined with BTN_TOOL_<name=
> codes. For
> + =A0 =A0example, a pen tablet may set BTN_TOOL_PEN to 1 and BTN_TOUC=
H to 0 while the
> + =A0 =A0pen is hovering over but not touching the tablet surface.
> +
> +Note: For appropriate function of the legacy mousedev emulation driv=
er,
> +BTN_TOUCH must be the first evdev code emitted in a synchronization =
frame.
> +
> +Note: Historically a touch device with BTN_TOOL_FINGER and BTN_TOUCH=
 was
> +interpreted as a touchpad by userspace, while a similar device witho=
ut
> +BTN_TOOL_FINGER was interpreted as a touchscreen. For backwards comp=
atibility
> +with current userspace it is recommended to follow this distinction.=
 In the
> +future, this distinction will be deprecated and the device propertie=
s ioctl
> +EVIOCGPROP, defined in linux/input.h, will be used to convey the dev=
ice type.
> +
> +* BTN_TOOL_FINGER, BTN_TOOL_DOUBLETAP, BTN_TOOL_TRIPLETAP, BTN_TOOL_=
QUADTAP:
> + =A0- These codes denote one, two, three, and four finger interactio=
n on a
> + =A0 =A0trackpad or touchscreen. For example, if the user uses two f=
ingers and moves
> + =A0 =A0them on the touchpad in an effort to scroll content on scree=
n,
> + =A0 =A0BTN_TOOL_DOUBLETAP should be set to value 1 for the duration=
 of the motion.
> + =A0 =A0Note that these codes and the BTN_TOOL_<name> and BTN_TOUCH =
codes are
> + =A0 =A0orthogonal in purpose. A trackpad event generated by finger =
touches should
> + =A0 =A0generate events for one code from each group. At most only o=
ne of these
> + =A0 =A0codes should have a value of 1 during any synchronization fr=
ame.

I think the "Note" sentence needs an update.  I can interpret it as
defining 3 groups but only 2 exist.

Maybe: "Note that all BTN_TOOL_<name> codes (include these finger
touch codes) and the BTN_TOUCH code are orthogonal in purpose. "

Thats my only comment.  This doc will be great to have!

I'll propose a couple of example event sequences to add once this gets
committed.

Chris
> +
> +Note: Historically some drivers emitted multiple of the finger count=
 codes with
> +a value of 1 in the same synchronization frame. This usage is deprec=
ated.
> +
> +Note: In multitouch drivers, the input_mt_report_finger_count() func=
tion should
> +be used to emit these codes. Please see multi-touch-protocol.txt for=
 details.
> +
> +* KEY_SUSPEND, KEY_POWER:
> + =A0- These codes are reserved for the EV_PWR type.
> +
> +EV_REL:
> +----------
> +EV_REL events describe relative changes in a property. For example, =
a mouse may
> +move to the left by a certain number of units, but its absolute posi=
tion in
> +space is unknown. If the absolute position is known, EV_ABS codes sh=
ould be used
> +instead of EV_REL codes.
> +
> +A few EV_REL codes have special meanings:
> +
> +* REL_WHEEL, REL_HWHEEL:
> + =A0- These codes are used for vertical and horizontal scroll wheels=
,
> + =A0 =A0respectively.
> +
> +EV_ABS:
> +----------
> +EV_ABS events describe absolute changes in a property. For example, =
a touchpad
> +may emit coordinates for a touch location.
> +
> +A few EV_ABS codes have special meanings:
> +
> +* ABS_DISTANCE:
> + =A0- Used to describe the distance of a tool from an interaction su=
rface. This
> + =A0 =A0should only be used while the tool is hovering, meaning in c=
lose proximity
> + =A0 =A0of the device. If the input device may be used freely in thr=
ee dimensions,
> + =A0 =A0consider ABS_Z instead.
> +
> +* ABS_MT_<name>:
> + =A0- Used to describe multitouch input events. Please see
> + =A0 =A0multi-touch-protocol.txt for details.
> +
> +EV_SW:
> +----------
> +EV_SW events describe stateful binary switches. For example, the SW_=
LID code is
> +used to denote when a laptop lid is closed.
> +
> +EV_MSC:
> +----------
> +EV_MSC events are used for input and output events that do not fall =
under other
> +categories.
> +
> +EV_LED:
> +----------
> +EV_LED events are used for input and output to set and query the sta=
te of
> +various LEDs on devices.
> +
> +EV_REP:
> +----------
> +EV_REP events are used for specifying autorepeating events.
> +
> +EV_SND:
> +----------
> +EV_SND events are used for sending sound commands to simple sound ou=
tput
> +devices.
> +
> +EV_FF:
> +----------
> +EV_FF events are used to initialize a force feedback capable device =
and to cause
> +such device to feedback.
> +
> +EV_PWR:
> +----------
> +EV_PWR events are a special type of key event used specifically for =
monitoring
> +power buttons and switches. The two codes in use are:
> +
> +* KEY_POWER:
> + =A0- Used to denote a power button event.
> +
> +* KEY_SUSPEND:
> + =A0- Used to denote a suspend button event.
> --
> 1.7.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
