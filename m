From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH v3] Documentation: Add evdev type and code definitions
Date: Thu, 24 Mar 2011 13:44:25 -0500
Message-ID: <AANLkTimv3ZVQmgB-tbMthCYdEsK3Spk0WY9Vs9VLQEVs@mail.gmail.com>
References: <1300988652-25353-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42142 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933681Ab1CXSo0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2011 14:44:26 -0400
In-Reply-To: <1300988652-25353-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Peter Hutterer <peter.hutterer@who-t.net>, Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Looking good.  Minor comments at end.

On Thu, Mar 24, 2011 at 12:44 PM, Chase Douglas
<chase.douglas@canonical.com> wrote:
> This commit adds the file Documentation/input/evdev-codes.txt.
>
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Cc: Chris Bagwell <chris@cnpbagwell.com>
> Cc: Peter Hutterer <peter.hutterer@who-t.net>
> Cc: Nikolai Kondrashov <spbnick@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Henrik Rydberg <rydberg@euromail.se>
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
> This revision has been a long time coming. Sorry for the delay! Chang=
es from the
> previous revision:
>
> * Use EVIOCG* to retrieve evdev state and note sysfs capabilities inf=
o
> * Clarify wording of BTN_TOOL_<name> and BTN_TOUCH usage for multi-fi=
nger modes
> * Remove KEY_POWER, KEY_SUSPEND documentation
> * State that EV_PWR is not well defined and will be addressed later
> * Add text about reporting switch state when binding or resuming
> * Add a "Guidelines" section describing basic mouse, touchscreen, and=
 trackpad
> =A0protocol usage
>
> This is perhaps more important than ever before. We're seeing a lot o=
f new
> drivers that were obviously only written to support Android and do no=
t conform
> to the evdev protocol that X.org's input modules need and expect. I'v=
e had
> multiple people come to me asking why their android derived touchscre=
en driver
> isn't working properly in Ubuntu, only to find that the driver is onl=
y reporting
> ABS_MT_POSITION_{X,Y} and ABS_MT_TOUCH_MAJOR. Hopefully this will hel=
p others
> understand what is required for a full window management system based=
 on
> historical X.org usage.
>
> =A0Documentation/input/evdev-codes.txt | =A0238 +++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 238 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/input/evdev-codes.txt
>
> diff --git a/Documentation/input/evdev-codes.txt b/Documentation/inpu=
t/evdev-codes.txt
> new file mode 100644
> index 0000000..473ce9d
> --- /dev/null
> +++ b/Documentation/input/evdev-codes.txt
> @@ -0,0 +1,238 @@
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
> +evdev code values using the EVIOCG* ioctls defined in linux/input.h.=
 The evdev
> +reports supported by a device are also provided by sysfs in
> +class/input/event*/device/capabilities/, and the properties of a dev=
ice are
> +provided in class/input/event*/device/properties.
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
> + =A0 =A0Note that all BTN_TOOL_<name> codes and the BTN_TOUCH code a=
re orthogonal in
> + =A0 =A0purpose. A trackpad event generated by finger touches should=
 generate events
> + =A0 =A0for one code from each group. At most only one of these BTN_=
TOOL_<name>
> + =A0 =A0codes should have a value of 1 during any synchronization fr=
ame.
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
> +Upon binding to a device or resuming from suspend, a driver must rep=
ort the
> +the current switch state. This ensures that the device, kernel, and =
userspace
> +state is in sync.
> +
> +Upon resume, if the switch state is the same as before suspend, then=
 the input
> +subsystem will filter out the duplicate switch state reports. The dr=
iver does
> +not need to keep the state of the switch at any time.
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
> +EV_PWR events are a special type of event used specifically for powe=
r
> +mangement. Its usage is not well defined. To be addressed later.
> +
> +Guidelines:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The guidelines below ensure proper single-touch and multi-finger fun=
ctionality.
> +For multi-touch functionality, see the multi-touch-protocol.txt docu=
ment for
> +more information.
> +
> +Mice:
> +----------
> +REL_{X,Y} must be reported when the mouse moves. BTN_LEFT must be us=
ed to report
> +the primary button press. BTN_{MIDDLE,RIGHT,4,5,etc.} should be used=
 to report
> +further buttons of the device. REL_WHEEL and REL_HWHEEL should be us=
ed to report
> +scroll wheel events where available.
> +
> +Touchscreens:
> +----------
> +ABS_{X,Y} must be reported with the location of the touch. BTN_TOUCH=
 must be
> +used to report when a touch is active on the screen.
> +BTN_{MOUSE,LEFT,MIDDLE,RIGHT} must not be reported. BTN_TOOL_<name> =
events
> +should be reported where possible.

Does the real button event restriction solve something?  I know
majority of touchscreens are not sending a button today but usually
there is a button on the touchscreen frame that I'd image at least
some devices hooking it up to touchscreen interface.

stylus+touchscreen combo devices are surely going to want to do this.

> +
> +Trackpads:
> +----------
> +Legacy trackpads that only provide relative position information mus=
t report
> +events like mice described above.
> +
> +Trackpads that provide absolute touch position must report ABS_{X,Y}=
 for the
> +location of the touch. BTN_TOUCH should be used to report when a tou=
ch is active
> +on the trackpad. Where multi-finger support is available, BTN_TOOL_<=
name> should
> +be used to report the number of touches active on the trackpad.

How about a Tablet?

Something like:

Tablets:
--------

BTN_TOOL_<name> events must be reported when a stylus or other tool is
active on tablet.  ABS_{X,Y} must be reported with the location of the
tool. BTN_TOUCH should be used to report when the tool is in contact
with the tablet. BTN_{STYLUS,STLUS2} should be used to report buttons
on tool itself and BTN_{LEFT,MIDDLE,RIGHT,1,2,etc} should be used to
report buttons on tablet.

Some tablets send ABS_PRESSURE with no BTN_TOUCH (why I said should
instead of must).  Probably this is not worth mentioning here?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
