From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Tue, 23 Nov 2010 22:55:56 -0600
Message-ID: <AANLkTi=FLyZ5eWb0M4fNg76YuzU_Cpasb3b0xjeNhLE5@mail.gmail.com>
References: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
	<20101123223018.GC20283@core.coreip.homeip.net>
	<AANLkTi=sEJC9r=ZL7rJH9ojOjadmriNFbN97t+=HpTwy@mail.gmail.com>
	<20101124025248.GD27368@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40523 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab0KXEz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 23:55:57 -0500
Received: by ywl5 with SMTP id 5so876164ywl.19
        for <linux-input@vger.kernel.org>; Tue, 23 Nov 2010 20:55:57 -0800 (PST)
In-Reply-To: <20101124025248.GD27368@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Tue, Nov 23, 2010 at 8:52 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 23, 2010 at 02:40:00PM -0800, Ping Cheng wrote:
>> On Tue, Nov 23, 2010 at 2:30 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Tue, Nov 23, 2010 at 12:48:07PM -0800, Ping Cheng wrote:
>> >> Hi all,
>> >>
>> >> I am not going to write a patch for this request before I get the
>> >> permission for the new tool type. It affects all touch screen dev=
ices
>> >> (under drivers/input/touchscreen) that support both pen and touch=
=2E
>> >>
>> >> Right now, in the user land, BTN_TOUCH is used to indicate a sing=
le
>> >> touch events. BTN_TOUCH and !BTN_TOOL_PEN
>> >> (http://udev.sourcearchive.com/documentation/161-1/input__id_8c-s=
ource.html)
>> >> are used to determine if the device is a touch screen device or n=
ot a
>> >> pen. With both pen and touch on the same logical port (serial tou=
ch
>> >> screen with pen and touch enabled, refer to wacom_w8001.c), BTN_T=
OUCH
>> >> and !BTN_TOOL_PEN will always be false, which indicates a
>> >> non-touchscreen device. That is wrong.
>> >>
>> >> Unless we have other means to tell the user land a device is a
>> >> touchscreen, BTN_TOUCH with !BTN_TOOL_PEN won't do the job for us=
=2E
>> >>
>> >> I've already had a value for the new type:
>> >>
>> >> +#define BTN_TOOL_TOUCH =A0 =A0 =A0 0x149
>> >>
>> >> This new type resolves the confusion we had for the existing seri=
al
>> >> pen and touch enabled touchscreen devices. Considering we are mer=
ging
>> >> the two logical ports for USB devices, the new type is required f=
or
>> >> the future USB touchscreen support as well.
>> >
>> > How is BTN_TOOL_TOUCH is different from BTN_TOOL_FINGER?
>>
>> Good question.
>>
>> BTN_TOOL_FINGER is used for touchpad or trackpad, or whichever term
>> that works for you. It indicates a relative cursor movement. The tou=
ch
>> screen needs to translate the (x,y) events into absolute movement.
>> That's why none of those touchscreen drivers use BTN_TOOL_FINGER so
>> far.
>>
>
> BTN_TOOL_FINGER and the new BTN_TOOL_TOUCH convey the same data to th=
e
> userspace, namely that there is a finger on the owrking surface, as
> oopsed to pen, mouse, lens or something else. It does not dictate how
> exactly the data should be used, although right now we have heuristic=
 to
> decide the class of the device we are dealing with.

I've a small clarification for readers that might not be aware.  For
BTN_TOOL_FINGER, its still used to mean a kinda of "in proximity of
surface" and BTN_TOUCH is used when actually touching touchpad.  For
touchpad, those two things probably should follow each other... but as
an example the synaptics driver only sets BTN_TOOL_FINGER immediately
but BTN_TOUCH when pressure is over some threshold.  So there is a
time period when they do not match.

Touchscreens today can only send BTN_TOUCH event... which is a little
odd but works.

>
> It looks like that we getting into fuzzy area where it is hard to
> classify the device solely by its capabilities. Maybe it is time we
> revisited the topic of adding "flags" or "hint" to the device to
> describe it's main purpose(s).
>

I think the proposed BTN_TOOL_TOUCH is in the same spirit of most
other BTN_TOOL_*'s.

We seem comfortable that userland wants to know difference between pen
and eraser tools.  The only thing unique they bring to table is a type
of resolution (fine tip vs. blunt tip) as well as an indication of
tool switching.

I'm not sure we needed 8 tools to express resolution concepts or tool
switching concepts but we do have them.

To me, the BTN_TOOL_TOUCH fits in just fine with this.  It says its
low resolution like both BTN_TOOL_ERASER and BTN_TOOL_FINGER say to
different degrees.  But it also says that, unlike BTN_TOOL_FINGER, it
has touchscreen visibility going for it to replace missing
in-proximity concept and effectively increase its resolution... and so
you do not need to revert to relative emulation.

As the udev input-id shows, I think we have pretty firm class of
devices and it seems touchscreens are only ones not cleanly defined.
It does show something is clearly missing from kernel side.

Mice - BTN_TOOL_MOUSE or anything that only has REL_* events.
Touchpads - BTN_TOOL_FINGER
Tablets - BTN_TOOL_PEN
Touchscreens - fall threw case if you don't find above.

it seems BTN_TOOL_TOUCH(screen) is probably only needed/missing value.
 Are there other major classes that are not just combo devices?  I
guess my point is it looks like we will not need to keep extending
BTN_TOOL_ for device classes over time.

Adding a new BTN_TOOL_TOUCH sure is less disrupted to userland  as we
start to expand to support combo pen+touch devices.

If we took the flags/hint approach then BTN_TOOL_FINGER becomes pretty
meaningless for both touchpads and touchscreens.

I do also want to discuss if its OK to send BTN_TOOL_FINGER=3D1 and
BTN_TOOL_DOUBLETAP/TRIPLETAP=3D1 at same time and also proper way to
send DOUBLETAP/TRIPLETAP on touchscreens since they can't use
BTN_TOOL_FINGER today... but I'll save that for a new thread. :-)

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
