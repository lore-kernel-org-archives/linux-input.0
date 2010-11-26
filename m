From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Fri, 26 Nov 2010 16:48:32 -0600
Message-ID: <AANLkTimS96HiQaO9WApVRc2ANumY+9io2gacsbSk07Gb@mail.gmail.com>
References: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
	<20101123223018.GC20283@core.coreip.homeip.net>
	<AANLkTi=sEJC9r=ZL7rJH9ojOjadmriNFbN97t+=HpTwy@mail.gmail.com>
	<20101124025248.GD27368@core.coreip.homeip.net>
	<AANLkTi=FLyZ5eWb0M4fNg76YuzU_Cpasb3b0xjeNhLE5@mail.gmail.com>
	<20101124202603.GH27368@core.coreip.homeip.net>
	<AANLkTimZ7hDEEO7xbRT3Xt7fRHwBHgx=NT70q=C60tDS@mail.gmail.com>
	<20101125013102.GA3081@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44082 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0KZWsc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Nov 2010 17:48:32 -0500
Received: by ywl5 with SMTP id 5so1152139ywl.19
        for <linux-input@vger.kernel.org>; Fri, 26 Nov 2010 14:48:32 -0800 (PST)
In-Reply-To: <20101125013102.GA3081@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Wed, Nov 24, 2010 at 7:31 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Nov 24, 2010 at 04:55:32PM -0600, Chris Bagwell wrote:
>> >
>> >>
>> >> Touchscreens today can only send BTN_TOUCH event... which is a li=
ttle
>> >> odd but works.
>> >>
>> >> >
>> >> > It looks like that we getting into fuzzy area where it is hard =
to
>> >> > classify the device solely by its capabilities. Maybe it is tim=
e we
>> >> > revisited the topic of adding "flags" or "hint" to the device t=
o
>> >> > describe it's main purpose(s).
>> >> >
>> >>
>> >> I think the proposed BTN_TOOL_TOUCH is in the same spirit of most
>> >> other BTN_TOOL_*'s.
>> >>
>> >> We seem comfortable that userland wants to know difference betwee=
n pen
>> >> and eraser tools. =A0The only thing unique they bring to table is=
 a type
>> >> of resolution (fine tip vs. blunt tip) as well as an indication o=
f
>> >> tool switching.
>> >
>> > And the expected action when you actually using the tool.
>>
>> Agree. =A0Its important point that happens to be in line with why I =
like
>> BTN_TOOL_TOUCH concept. =A0More below.
>>
>> >
>> >>
>> >> I'm not sure we needed 8 tools to express resolution concepts or =
tool
>> >> switching concepts but we do have them.
>> >>
>> >> To me, the BTN_TOOL_TOUCH fits in just fine with this. =A0It says=
 its
>> >> low resolution like both BTN_TOOL_ERASER and BTN_TOOL_FINGER say =
to
>> >> different degrees. =A0But it also says that, unlike BTN_TOOL_FING=
ER, it
>> >> has touchscreen visibility going for it to replace missing
>> >> in-proximity concept and effectively increase its resolution... a=
nd so
>> >> you do not need to revert to relative emulation.
>> >
>> > Huh? I want to reiterate that I do not see any difference between
>> > proposed BTN_TOOL_TOUCH and existing BTN_TOOL_FINGER - both indica=
te
>> > that a finger either touches or is in proximity of the working sur=
face.
>> >
>> > The only difference between tablet, touchcsreen and touchpad is ho=
w we
>> > react to the same data (i.e. relative/absolute movement; pointer
>> > tracking or not, etc).
>> >
>>
>> Let me give an example of drawing program and worst case where all
>> major device classes are merged in single input device. =A0The input=
 has
>> pen/eraser/touchscreen/touchpad/mouse and user expected behavior.
>
> This is a faulty assumption as I do not see how you could come across
> such a beast. Touchscreens, tablets and touchpads are different devic=
es
> and require different handling:
>
> - touchpads require conversion from absolute to relative movement, an=
d
> =A0movement causes on-screen pointer movement;
>
> - tablets (unless we are talking about wacom mouse tool which is
> =A0special) operate in absolute coordinates but still require on-scre=
en
> =A0pointer movement;
>
> - touchscreens work in absolute coordinates and do not require pointe=
r
> =A0tracking as your tool (finger, stylus) serves as a pointer.
>
> While I can see manufacturers packaging let's say touchscreen and a
> touchpad into a single chip solution we should not try to jam them al=
l
> together into single logical input device but rather split them
> accordingly (based on work surface for example).
>
> Given that you won't ever have to deal with something that is
> touchscreen, tabled and touchpad at once the rest of your example is =
not
> interesting.

Hmmm.  Let me start of easy part.  Having touchpad+touchscreen on
single input doesn't make sense even though it was in my example.  I
agree with that.  The rest are valid examples that exist today.

touchscreen/wacom_w8001.c is example of serial device (1 input device
to user) that has tablet features (BTN_TOOL_PEN and BTN_TOOL_FINGER)
and touchscreen touch.  Today its playing some games and not sending
BTN_TOOL_FINGER events to prevent device from being directed to
xf86-input-synaptics.  This can be fixed after thread is finalized.

We have Wacom Bamboo's (tablet/wacom_wac.c) that have tablet features
(BTN_TOOL_PEN and BTN_TOOL_ERASER) on 1 input device and touchpad
feature (BTN_TOOL_FINGER) on another input device.  On another thread,
we talked about merging these into 1 logical input device because it
eases filtering those BTN_TOOL_FINGER events while user is using
stylus and resting hand on tablet.

Also, Wacom Tablet PC's (tablet/wacom_wac.c) and hid-ntrig.c have
tablet (BTN_TOOL_PEN and BTN_TOOL_ERASER) and touchscreen (BTN_TOUCH).
  These could be combined and the Wacom Tablet PC's events should be
modified to look closer to hid-ntrig.c... although hid-ntrig.c also
isn't sending BTN_TOOL_FINGER for xf86-input-synaptics reasons.
=2E
>
>> All tools except mouse share ABS_X/Y/PRESSURE and BTN_TOUCH. =A0 Mou=
se
>> uses REL_* events.
>>
>> * BTN_TOOL_PEN - Small point pen with black ink. =A0Draws upon BTN_T=
OUCH
>> or ABS_PRESSURE.
>> * BTN_TOOL_ERASER - Large point pen with white ink (simple erase
>> concept). =A0Draws upon BTN_TOUCH or ABS_PRESSURE.
>> * BTN_TOOL_TOUCH - Large point pen with black ink. =A0Draws upon
>> BTN_TOUCH or ABS_PRESSURE.
>> * BTN_TOOL_FINGER - Small (maybe) point pen with black ink. =A0Only
>> moves cursor with BTN_TOUCH or ABS_PRESSURE. =A0No drawing unless
>> BTN_RIGHT clicked.
>> * BTN_TOOL_MOUSE - Small (maybe) point pen with black ink. =A0Only m=
oves
>> cursor on REL_ events. =A0No drawing unless BTN_RIGHT clicked. =A0<-=
- this
>> is existing wacom example. =A0If reports ABS_* then it would probabl=
y
>> use BTN_TOOL_FINGER tool even though a mouse puck.
>>
>> Notice how expected behavior of touchscreen is so close to tablet
>> tools. =A0TOUCH is just a complement tablet tool in same way ERASER =
is
>> complement to PEN. =A0Touchpads are so unique in how they behave tha=
t I
>> think they deserve their own tool type.
>
> No, they deserve to be handled differently (as I outlined above) but =
the
> tool is still the same. It is your finger. If it was a different tool
> that would mean that there could be a device that supports both
> BTN_TOOL_FINGER and BTN_TOOL_TOUCH. Now how would you differentiate
> between them? When use one and when the other (given that it is
> physically the same object touching the device)?
>

I now see I had flawed outlook because I was stuck on udev and
xf86-input-evdev logic to much.  I wanted to send something along with
each tool that said how to treat in terms of historical device
classes.  As example, I wanted to say "Use BTN_TOOL_PEN with logic you
used to use for Tablets." and "Use BTN_TOOL_FINGER with logic you used
to use for touchscreens".  BTN_TOOL_TOUCH was just way of encoding
that extra info without new interface.

Thats why I mentioned per-tool a few times.  Your examples show its
better to say "use this BTN_TOOL_* in whatever way makes sense with
Touchscreen (or whatever physical attribute of HW is)."

Both viewpoints come to same answer in the end but yours is best.  Its
basically 1 value per input device; as you show below.

It doesn't quite work if we have combined touchscreen+touchpad but I
agree that case is probably best to break into 2 input devices.

>>
>> Your point about only the "how to react" being different between
>> touchpad and touchscreen is also true for all tools above. =A0I'm no=
t
>> sure why your limiting comment and not including tablet and mice
>> tools. =A0We could switch to BTN_TOOL_1/2/3/4 and some sort of per t=
ool
>> hint (BTN_TOOL_CAPABILITIES sent with tool events perhaps?) but I'm
>> not real excited about work involved in userland for that.
>>
>> If your still not convinced on BTN_TOOL_TOUCH (I've not really
>> mentioned much new info) then can you give rough ideas of what flags
>> interface should look like?
>>
>> For example, should it be sent as BTN_TOOL_CAPABILITIES event for ea=
ch
>> tool change? =A0Or should it be an ioctl() per BTN_TOOL_*? =A0The fo=
rmer
>> is good if we think BTN_TOOL_*'s will use tool ID's and two tools ma=
y
>> have different capabilities.
>
> No, the hint or flags or type is per device. So you'd do:
>
> =A0 =A0 =A0 =A0ioctl(fd, EVIOCGDEVTYPE, &type);
>
> when you notified about a new device and it would return a bitmap of =
all
> that it could be, like INPUT_TYPE_TOUCHSCREEN or INPUT_TYPE_TABLET. A=
nd
> then you'd know how to deal with that device.

Thanks for example.  That cleared up some things in my mind on how you =
see it.

Chris

>
>>
>> Once solved for ST, it also needs solution for MT. =A0For slot based=
 MT,
>> it may need to be sent as events if we allow tools to float between
>> slots.
>>
>
> I do not see how that involves ST vs MT at all.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
