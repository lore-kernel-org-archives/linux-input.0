From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Wed, 24 Nov 2010 16:55:32 -0600
Message-ID: <AANLkTimZ7hDEEO7xbRT3Xt7fRHwBHgx=NT70q=C60tDS@mail.gmail.com>
References: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
	<20101123223018.GC20283@core.coreip.homeip.net>
	<AANLkTi=sEJC9r=ZL7rJH9ojOjadmriNFbN97t+=HpTwy@mail.gmail.com>
	<20101124025248.GD27368@core.coreip.homeip.net>
	<AANLkTi=FLyZ5eWb0M4fNg76YuzU_Cpasb3b0xjeNhLE5@mail.gmail.com>
	<20101124202603.GH27368@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39315 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab0KXWzd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 17:55:33 -0500
Received: by gxk22 with SMTP id 22so164818gxk.19
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 14:55:32 -0800 (PST)
In-Reply-To: <20101124202603.GH27368@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Wed, Nov 24, 2010 at 2:26 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 23, 2010 at 10:55:56PM -0600, Chris Bagwell wrote:
>> On Tue, Nov 23, 2010 at 8:52 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Tue, Nov 23, 2010 at 02:40:00PM -0800, Ping Cheng wrote:
>> >> On Tue, Nov 23, 2010 at 2:30 PM, Dmitry Torokhov
>> >> <dmitry.torokhov@gmail.com> wrote:
>> >> > On Tue, Nov 23, 2010 at 12:48:07PM -0800, Ping Cheng wrote:
>> >> > How is BTN_TOOL_TOUCH is different from BTN_TOOL_FINGER?
>> >>
>> >> Good question.
>> >>
>> >> BTN_TOOL_FINGER is used for touchpad or trackpad, or whichever te=
rm
>> >> that works for you. It indicates a relative cursor movement. The =
touch
>> >> screen needs to translate the (x,y) events into absolute movement=
=2E
>> >> That's why none of those touchscreen drivers use BTN_TOOL_FINGER =
so
>> >> far.
>> >>
>> >
>> > BTN_TOOL_FINGER and the new BTN_TOOL_TOUCH convey the same data to=
 the
>> > userspace, namely that there is a finger on the owrking surface, a=
s
>> > oopsed to pen, mouse, lens or something else. It does not dictate =
how
>> > exactly the data should be used, although right now we have heuris=
tic to
>> > decide the class of the device we are dealing with.
>>
>> I've a small clarification for readers that might not be aware. =A0F=
or
>> BTN_TOOL_FINGER, its still used to mean a kinda of "in proximity of
>> surface" and BTN_TOUCH is used when actually touching touchpad. =A0F=
or
>
> BTN_TOUCH means something (we do not specify what) touches working
> surface.
>
>> touchpad, those two things probably should follow each other... but =
as
>> an example the synaptics driver only sets BTN_TOOL_FINGER immediatel=
y
>> but BTN_TOUCH when pressure is over some threshold. =A0So there is a
>> time period when they do not match.
>
> In Synaptics BTN_TOUCH was used for legacy clients not understanding
> BTN_TOOL_FINGER/ABS_PRESSURE (read: mousedev) and had arbitrary press=
ure
> thresholds.

Does this mean BTN_TOUCH is optional for absolute devices (tablets and
touchpads)?  Its not for touchscreens simply because its defacto event
used were other devices use BTN_TOOL_*.

Probably we should document this stuff, similar to how MT did, for
common understanding.  I may be up for that task soon.

>
>>
>> Touchscreens today can only send BTN_TOUCH event... which is a littl=
e
>> odd but works.
>>
>> >
>> > It looks like that we getting into fuzzy area where it is hard to
>> > classify the device solely by its capabilities. Maybe it is time w=
e
>> > revisited the topic of adding "flags" or "hint" to the device to
>> > describe it's main purpose(s).
>> >
>>
>> I think the proposed BTN_TOOL_TOUCH is in the same spirit of most
>> other BTN_TOOL_*'s.
>>
>> We seem comfortable that userland wants to know difference between p=
en
>> and eraser tools. =A0The only thing unique they bring to table is a =
type
>> of resolution (fine tip vs. blunt tip) as well as an indication of
>> tool switching.
>
> And the expected action when you actually using the tool.

Agree.  Its important point that happens to be in line with why I like
BTN_TOOL_TOUCH concept.  More below.

>
>>
>> I'm not sure we needed 8 tools to express resolution concepts or too=
l
>> switching concepts but we do have them.
>>
>> To me, the BTN_TOOL_TOUCH fits in just fine with this. =A0It says it=
s
>> low resolution like both BTN_TOOL_ERASER and BTN_TOOL_FINGER say to
>> different degrees. =A0But it also says that, unlike BTN_TOOL_FINGER,=
 it
>> has touchscreen visibility going for it to replace missing
>> in-proximity concept and effectively increase its resolution... and =
so
>> you do not need to revert to relative emulation.
>
> Huh? I want to reiterate that I do not see any difference between
> proposed BTN_TOOL_TOUCH and existing BTN_TOOL_FINGER - both indicate
> that a finger either touches or is in proximity of the working surfac=
e.
>
> The only difference between tablet, touchcsreen and touchpad is how w=
e
> react to the same data (i.e. relative/absolute movement; pointer
> tracking or not, etc).
>

Let me give an example of drawing program and worst case where all
major device classes are merged in single input device.  The input has
pen/eraser/touchscreen/touchpad/mouse and user expected behavior.
All tools except mouse share ABS_X/Y/PRESSURE and BTN_TOUCH.   Mouse
uses REL_* events.

* BTN_TOOL_PEN - Small point pen with black ink.  Draws upon BTN_TOUCH
or ABS_PRESSURE.
* BTN_TOOL_ERASER - Large point pen with white ink (simple erase
concept).  Draws upon BTN_TOUCH or ABS_PRESSURE.
* BTN_TOOL_TOUCH - Large point pen with black ink.  Draws upon
BTN_TOUCH or ABS_PRESSURE.
* BTN_TOOL_FINGER - Small (maybe) point pen with black ink.  Only
moves cursor with BTN_TOUCH or ABS_PRESSURE.  No drawing unless
BTN_RIGHT clicked.
* BTN_TOOL_MOUSE - Small (maybe) point pen with black ink.  Only moves
cursor on REL_ events.  No drawing unless BTN_RIGHT clicked.  <-- this
is existing wacom example.  If reports ABS_* then it would probably
use BTN_TOOL_FINGER tool even though a mouse puck.

Notice how expected behavior of touchscreen is so close to tablet
tools.  TOUCH is just a complement tablet tool in same way ERASER is
complement to PEN.  Touchpads are so unique in how they behave that I
think they deserve their own tool type.

Your point about only the "how to react" being different between
touchpad and touchscreen is also true for all tools above.  I'm not
sure why your limiting comment and not including tablet and mice
tools.  We could switch to BTN_TOOL_1/2/3/4 and some sort of per tool
hint (BTN_TOOL_CAPABILITIES sent with tool events perhaps?) but I'm
not real excited about work involved in userland for that.

If your still not convinced on BTN_TOOL_TOUCH (I've not really
mentioned much new info) then can you give rough ideas of what flags
interface should look like?

=46or example, should it be sent as BTN_TOOL_CAPABILITIES event for eac=
h
tool change?  Or should it be an ioctl() per BTN_TOOL_*?  The former
is good if we think BTN_TOOL_*'s will use tool ID's and two tools may
have different capabilities.

Once solved for ST, it also needs solution for MT.  For slot based MT,
it may need to be sent as events if we allow tools to float between
slots.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
