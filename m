From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Documentation: Add evdev type and code definitions
Date: Thu, 16 Dec 2010 08:57:41 -0800
Message-ID: <20101216165741.GA28364@core.coreip.homeip.net>
References: <1292361672-2581-1-git-send-email-chase.douglas@canonical.com>
 <1292361672-2581-3-git-send-email-chase.douglas@canonical.com>
 <20101215235900.GA4952@salty.local>
 <AANLkTinjHuOv=sd_C-e1OLXuH_AS0YU_Hfj77zien27F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59237 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab0LPQ5w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Dec 2010 11:57:52 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinjHuOv=sd_C-e1OLXuH_AS0YU_Hfj77zien27F@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 16, 2010 at 08:56:58AM -0600, Chris Bagwell wrote:
> On Wed, Dec 15, 2010 at 5:59 PM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > On Tue, Dec 14, 2010 at 01:21:10PM -0800, Chase Douglas wrote:
> >> This commit adds the file Documentation/input/evdev-codes.txt.
> >>
> >> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> >> ---
> >> =A0Documentation/input/evdev-codes.txt | =A0160 ++++++++++++++++++=
+++++++++++++++++
> >> =A01 files changed, 160 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 Documentation/input/evdev-codes.txt
> >>
> >> diff --git a/Documentation/input/evdev-codes.txt b/Documentation/i=
nput/evdev-codes.txt
> >> new file mode 100644
> >> index 0000000..69c810f
> >> --- /dev/null
> >> +++ b/Documentation/input/evdev-codes.txt
> >> @@ -0,0 +1,160 @@
> >> +The evdev protocol uses a map of types and codes to express input=
 device values
> >> +to userspace. This document describes the types and codes and how=
 and when they
> >> +may be used.
> >> +
> >> +Types:
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +Types are groupings of codes under a logical input construct. Eac=
h type has a
> >> +set of applicable codes to be used in generating events. See the =
Codes section
> >> +for details on valid codes for each type.
> >> +
> >> +* EV_SYN:
> >> + =A0- Used as markers to separate events. Events may be separated=
 in time or in
> >> + =A0 =A0space, such as with the multitouch protocol.
> >> +* EV_KEY:
> >> + =A0- Used to describe keyboard and other key-like input events.
> >> +* EV_REL:
> >> + =A0- Used to describe relative input events, e.g. moving the mou=
se 5 units to the
> >> + =A0 =A0left.
> >> +* EV_ABS:
> >> + =A0- Used to describe absolute input events, e.g. describing the=
 coordinates of a
> >> + =A0 =A0touch on a touchscreen.
> >> +* EV_MSC:
> >> + =A0- Used to describe miscellaneous input events that do not fit=
 into other
> >> + =A0 =A0types.
> >> +* EV_SW:
> >> + =A0- Used to describe binary state input switches.
> >> +* EV_LED:
> >> + =A0- Used to turn LEDs on devices on and off.
> >> +* EV_SND:
> >> + =A0- Used to output sound to devices.
> >> +* EV_REP:
> >> + =A0- Used for autorepeating devices.
> >> +* EV_FF:
> >> + =A0- Used to send force feedback commands to an input device.
> >> +* EV_PWR:
> >> + =A0- A special type for power button and switch input.
> >> +* EV_FF_STATUS:
> >> + =A0- Used to receive force feedback device status.
> >> +
> >> +Codes:
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +Codes define the precise type of event.
> >> +
> >> +EV_SYN Codes:
> >> +----------
> >> +EV_SYN event values are undefined. Their usage is
> >> +defined only by when they are sent in the evdev event stream.
> >> +
> >> +* SYN_REPORT:
> >> + =A0- Used to synchronize and separate events in time. For exampl=
e, motion of a
> >> + =A0 =A0mouse may set the REL_X and REL_Y values for one motion, =
then emit a
> >> + =A0 =A0SYN_REPORT. The next motion will emit more REL_X and REL_=
Y values and send
> >> + =A0 =A0another SYN_REPORT.
> >> +* SYN_CONFIG:
> >> + =A0- TBD
> >> +* SYN_MT_REPORT:
> >> + =A0- Used to synchronize and separate touch events. See the
> >> + =A0 =A0multi-touch-protocol.txt document for more information.
> >> +
> >> +EV_KEY:
> >> +----------
> >> +EV_KEY events take the form KEY_<name> or BTN_<name>. For example=
, KEY_A is used
> >> +to represent the 'A' key on a keyboard. When a key is depressed, =
an event with
> >> +the key's code is emitted with value 1. When the key is depressed=
, an event is
> >> +emitted with value 0. In general, KEY_<name> is used for keyboard=
 keys, and
> >> +BTN_<name> is used for other types of momentary switch events.
> >
> > repeat keys have value 2, might want to add this here.
> >
> >> +
> >> +A few EV_KEY codes have special meanings:
> >> +
> >> +* BTN_TOOL_<name>, BTN_TOUCH:
> >> + =A0- These codes are used in conjunction with input trackpads, t=
ablets, and
> >> + =A0 =A0touchscreens. These devices may be used with fingers, pen=
s, or other tools.
> >> + =A0 =A0When an event occurs and a tool is used, the correspondin=
g BTN_TOOL_<name>
> >> + =A0 =A0code should be set to a value of 1. When the tool is no l=
onger interacting
> >> + =A0 =A0with the input device, the BTN_TOOL_<name> code should be=
 reset to 0. All
> >> + =A0 =A0trackpads, tablets, and touchscreens should use at least =
one BTN_TOOL_<name>
> >> + =A0 =A0code when events are generated. For non-tablet devices, t=
he tool is usually
> >> + =A0 =A0BTN_TOUCH.
> >
> > BTN_TOUCH is used as proximity delimiter. e.g. wacom sends BTN_TOOL=
_PEN when
> > the pen comes into proximity and (in addition) BTN_TOUCH when the p=
en
> > actually touches the tablet. synaptics does the same IIRC except th=
at it
> > doesn't support hovering, so BTN_TOOL_FINGER and BTN_TOUCH are alwa=
ys
> > set/unset in the same EV_SYN frame.
>=20
> This area is where most special cases are so somehow I think it
> deserves extra attention.  Either in paragraphs or in sample events.
>=20
> There is the special historical case of touchscreen were
> BTN_TOOL_FINGER is not sent; which mostly works because most
> touchscreens do not support proximity/hover concepts.  It can
> recommend not to use this approach and to use new ioctl() to convey
> touchscreen vs. touchpad information.
>=20
> Just an FYI: Synaptics is only sending BTN_TOUCH when pressure is >30
> for what ever historical reason (and duplicating logic in
> xf86-input-synaptics) so it usually won't be in same sync window as
> BTN_TOOL_FINGER.

mousedev. Synaptics devices used to be (still are?) very sensitive and
if you start sending BTN_TOUCH whenever you detect contact the touchpad
is not useable without synaptics X driver.

>  I think its only touchpad left doing this so I think
> we may want to recommend best practice is to have BTN_TOOL_FINGER/*TA=
P
> and BTN_TOUCH track each other when hover is not supported.

Alps does this as well. Any device that starts sending contacts while
hovering should consider legacy drivers when choosing when to emit
BTN_TOUCH.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
