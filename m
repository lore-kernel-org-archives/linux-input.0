From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/4] Documentation: Add evdev type and code definitions
Date: Thu, 16 Dec 2010 08:56:58 -0600
Message-ID: <AANLkTinjHuOv=sd_C-e1OLXuH_AS0YU_Hfj77zien27F@mail.gmail.com>
References: <1292361672-2581-1-git-send-email-chase.douglas@canonical.com>
	<1292361672-2581-3-git-send-email-chase.douglas@canonical.com>
	<20101215235900.GA4952@salty.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101215235900.GA4952@salty.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Chase Douglas <chase.douglas@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 15, 2010 at 5:59 PM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Tue, Dec 14, 2010 at 01:21:10PM -0800, Chase Douglas wrote:
>> This commit adds the file Documentation/input/evdev-codes.txt.
>>
>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
>> ---
>> =A0Documentation/input/evdev-codes.txt | =A0160 ++++++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 160 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/input/evdev-codes.txt
>>
>> diff --git a/Documentation/input/evdev-codes.txt b/Documentation/inp=
ut/evdev-codes.txt
>> new file mode 100644
>> index 0000000..69c810f
>> --- /dev/null
>> +++ b/Documentation/input/evdev-codes.txt
>> @@ -0,0 +1,160 @@
>> +The evdev protocol uses a map of types and codes to express input d=
evice values
>> +to userspace. This document describes the types and codes and how a=
nd when they
>> +may be used.
>> +
>> +Types:
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Types are groupings of codes under a logical input construct. Each =
type has a
>> +set of applicable codes to be used in generating events. See the Co=
des section
>> +for details on valid codes for each type.
>> +
>> +* EV_SYN:
>> + =A0- Used as markers to separate events. Events may be separated i=
n time or in
>> + =A0 =A0space, such as with the multitouch protocol.
>> +* EV_KEY:
>> + =A0- Used to describe keyboard and other key-like input events.
>> +* EV_REL:
>> + =A0- Used to describe relative input events, e.g. moving the mouse=
 5 units to the
>> + =A0 =A0left.
>> +* EV_ABS:
>> + =A0- Used to describe absolute input events, e.g. describing the c=
oordinates of a
>> + =A0 =A0touch on a touchscreen.
>> +* EV_MSC:
>> + =A0- Used to describe miscellaneous input events that do not fit i=
nto other
>> + =A0 =A0types.
>> +* EV_SW:
>> + =A0- Used to describe binary state input switches.
>> +* EV_LED:
>> + =A0- Used to turn LEDs on devices on and off.
>> +* EV_SND:
>> + =A0- Used to output sound to devices.
>> +* EV_REP:
>> + =A0- Used for autorepeating devices.
>> +* EV_FF:
>> + =A0- Used to send force feedback commands to an input device.
>> +* EV_PWR:
>> + =A0- A special type for power button and switch input.
>> +* EV_FF_STATUS:
>> + =A0- Used to receive force feedback device status.
>> +
>> +Codes:
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Codes define the precise type of event.
>> +
>> +EV_SYN Codes:
>> +----------
>> +EV_SYN event values are undefined. Their usage is
>> +defined only by when they are sent in the evdev event stream.
>> +
>> +* SYN_REPORT:
>> + =A0- Used to synchronize and separate events in time. For example,=
 motion of a
>> + =A0 =A0mouse may set the REL_X and REL_Y values for one motion, th=
en emit a
>> + =A0 =A0SYN_REPORT. The next motion will emit more REL_X and REL_Y =
values and send
>> + =A0 =A0another SYN_REPORT.
>> +* SYN_CONFIG:
>> + =A0- TBD
>> +* SYN_MT_REPORT:
>> + =A0- Used to synchronize and separate touch events. See the
>> + =A0 =A0multi-touch-protocol.txt document for more information.
>> +
>> +EV_KEY:
>> +----------
>> +EV_KEY events take the form KEY_<name> or BTN_<name>. For example, =
KEY_A is used
>> +to represent the 'A' key on a keyboard. When a key is depressed, an=
 event with
>> +the key's code is emitted with value 1. When the key is depressed, =
an event is
>> +emitted with value 0. In general, KEY_<name> is used for keyboard k=
eys, and
>> +BTN_<name> is used for other types of momentary switch events.
>
> repeat keys have value 2, might want to add this here.
>
>> +
>> +A few EV_KEY codes have special meanings:
>> +
>> +* BTN_TOOL_<name>, BTN_TOUCH:
>> + =A0- These codes are used in conjunction with input trackpads, tab=
lets, and
>> + =A0 =A0touchscreens. These devices may be used with fingers, pens,=
 or other tools.
>> + =A0 =A0When an event occurs and a tool is used, the corresponding =
BTN_TOOL_<name>
>> + =A0 =A0code should be set to a value of 1. When the tool is no lon=
ger interacting
>> + =A0 =A0with the input device, the BTN_TOOL_<name> code should be r=
eset to 0. All
>> + =A0 =A0trackpads, tablets, and touchscreens should use at least on=
e BTN_TOOL_<name>
>> + =A0 =A0code when events are generated. For non-tablet devices, the=
 tool is usually
>> + =A0 =A0BTN_TOUCH.
>
> BTN_TOUCH is used as proximity delimiter. e.g. wacom sends BTN_TOOL_P=
EN when
> the pen comes into proximity and (in addition) BTN_TOUCH when the pen
> actually touches the tablet. synaptics does the same IIRC except that=
 it
> doesn't support hovering, so BTN_TOOL_FINGER and BTN_TOUCH are always
> set/unset in the same EV_SYN frame.

This area is where most special cases are so somehow I think it
deserves extra attention.  Either in paragraphs or in sample events.

There is the special historical case of touchscreen were
BTN_TOOL_FINGER is not sent; which mostly works because most
touchscreens do not support proximity/hover concepts.  It can
recommend not to use this approach and to use new ioctl() to convey
touchscreen vs. touchpad information.

Just an FYI: Synaptics is only sending BTN_TOUCH when pressure is >30
for what ever historical reason (and duplicating logic in
xf86-input-synaptics) so it usually won't be in same sync window as
BTN_TOOL_FINGER.  I think its only touchpad left doing this so I think
we may want to recommend best practice is to have BTN_TOOL_FINGER/*TAP
and BTN_TOUCH track each other when hover is not supported.

>
>
>> +
>> +* BTN_TOOL_FINGER, BTN_TOOL_DOUBLETAP, BTN_TOOL_TRIPLETAP, BTN_TOOL=
_QUADTAP:
>> + =A0- These codes denote one, two, three, and four finger interacti=
on on a
>> + =A0 =A0trackpad or touchscreen. For example, if the user uses two =
fingers and moves
>> + =A0 =A0them on the touchpad in an effort to scroll content on scre=
en,
>> + =A0 =A0BTN_TOOL_DOUBLETAP should be set to value 1 for the duratio=
n of the motion.
>> + =A0 =A0Note that these codes and the BTN_TOOL_<name> and BTN_TOUCH=
 codes are
>> + =A0 =A0orthogonal in purpose. A trackpad event generated by finger=
 touches should
>> + =A0 =A0generate events for one code from each group.

We should probably recommend a best practice here.  Almost all drivers
today send only 1 of BTN_TOOL_FINGER/*TAP today.  For example, if 1
touch then BTN_TOOL_FINGER=3D1 and BTN_TOOL_DOUBLETAP=3D0 and during 2
touch then BTN_TOOL_FINGER=3D0 and BTN_TOOL_DOUBLETAP=3D1.

I think at least 1 driver sends them concurrently today and you must
look for highest finger count tool.  I'm pretty sure historically a
lot of the drivers sent them concurrently as well.

>> +
>> +* KEY_SUSPEND, KEY_POWER:
>> + =A0- These codes are reserved for the EV_PWR type.
>> +
>> +EV_REL:
>> +----------
>> +EV_REL events describe relative changes in a property. For example,=
 a mouse may
>> +move to the left by a certain number of units, but its absolute pos=
ition in
>> +space is unknown. If the absolute position is known, EV_ABS codes s=
hould be used
>> +instead of EV_REL codes.
>> +
>> +A few EV_REL codes have special meanings:
>> +
>> +* REL_WHEEL, REL_HWHEEL:
>> + =A0- These codes are used for vertical and horizontal scroll wheel=
s,
>> + =A0 =A0respectively.
>
> I'm not sure they're special, other than in X where we still treat th=
em as
> buttons by convention. It's good to describe them here, just in case,=
 but I
> wouldn't call that a "special meaning".
>
>> +
>> +EV_ABS:
>> +----------
>> +EV_ABS events describe absolute changes in a property. For example,=
 a touchpad
>> +may emit coordinates for a touch location.
>> +
>> +A few EV_ABS codes have special meanings:
>> +
>> +* ABS_PRESSURE:
>> + =A0- Used to describe the pressure of a touch interaction on an in=
put device.
>
> again, that's not really special IMO. it pretty much does what it say=
s on
> the box :)

:-)

It may be worth noting though that this is optional event.  When it
doesn't exist then BTN_TOUCH indicates touch.  When it does exist then
this is preferred indication of touch and should be used to debounced
touches because of fact that majority of touchpad/touchscreen will
start detecting contact while hovering.  But then that leads to
optional ABS_DISTANCE...

Chris

>
> fwiw, I know that even though the documentation should be enough as-i=
s,
> having a few simple examples are always really useful to form the pic=
ture in
> one's head. especially for newcomers who don't understand the basic c=
oncepts
> yet.
>
> just something like:
> "for example, an absolute device moving to a new position and pressin=
g and
> releasing a button may send events like this:
> code =A0 =A0 =A0 =A0 =A0 =A0value
> -----------------------
> ABS_X =A0 =A0 =A0 =A0 =A0 10
> ABS_Y =A0 =A0 =A0 =A0 =A0 100
> BTN_LEFT =A0 =A0 =A0 =A01
> EV_SYN =A0 =A0 =A0 =A0 =A0SYN_REPORT
> BTN_LEFT =A0 =A0 =A0 =A00
> EV_SYN =A0 =A0 =A0 =A0 =A0SYN_REPORT
>
> This immediately makes it obvious that buttons and axes can be mixed =
in the
> same frame. you may want to also point to a few tools that show the e=
vent
> stream (evtest comes to mind as the most widely distributed).
>
> Cheers,
> =A0Peter
>
>> +* ABS_DISTANCE:
>> + =A0- Used to describe the distance of a tool from an interaction s=
urface. This
>> + =A0 =A0should only be used while the tool is in close proximity of=
 the device. If
>> + =A0 =A0the input device may be used freely in three dimensions, co=
nsider ABS_Z
>> + =A0 =A0instead.
>> +* ABS_MT_<name>:
>> + =A0- Used to describe multitouch input events. Please see
>> + =A0 =A0multi-touch-protocol.txt for details.
>> +
>> +EV_SW:
>> +----------
>> +EV_SW events describe stateful binary switches. For example, the SW=
_LID code is
>> +used to denote when a laptop lid is closed.
>> +
>> +EV_MSC:
>> +----------
>> +EV_MSC events are used for input and output events that do not fall=
 under other
>> +categories.
>> +
>> +EV_LED:
>> +----------
>> +EV_LED events are used for input and output to set and query the st=
ate of
>> +various LEDs on devices.
>> +
>> +EV_REP:
>> +----------
>> +EV_REP events are used for specifying autorepeating events.
>> +
>> +EV_SND:
>> +----------
>> +EV_SND events are used for sending sound commands to simple sound o=
utput
>> +devices.
>> +
>> +EV_FF:
>> +----------
>> +EV_FF events are used to initialize a force feedback capable device=
 and to cause
>> +such device to feedback.
>> +
>> +EV_PWR:
>> +----------
>> +EV_PWR events are a special type of key event used specifically for=
 monitoring
>> +power buttons and switches. The two codes in use are:
>> +
>> +* KEY_POWER:
>> + =A0- Used to denote a power button event.
>> +* KEY_SUSPEND:
>> + =A0- Used to denote a suspend button event.
>> --
>> 1.7.1
>
