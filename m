From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Thu, 15 Mar 2012 21:57:30 -0500
Message-ID: <CAGzDe_ZVUSu+zFq8giOJfOTYzYWrf=2+Z64KASTE_MpVQ1yMzw@mail.gmail.com>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de>
	<CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com>
	<20120315175635.GA23155@stud.informatik.uni-erlangen.de>
	<4F623511.3040907@gmail.com>
	<20120316015224.GA8230@stud.informatik.uni-erlangen.de>
	<4F629F60.7010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61581 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab2CPC5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 22:57:32 -0400
Received: by lbbgm6 with SMTP id gm6so1820277lbb.19
        for <linux-input@vger.kernel.org>; Thu, 15 Mar 2012 19:57:30 -0700 (PDT)
In-Reply-To: <4F629F60.7010600@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, =?ISO-8859-1?Q?Maximilian_Kr=FCger?= <maxfragg@gmail.com>, i4passt@lists.informatik.uni-erlangen.de

On Thu, Mar 15, 2012 at 9:03 PM, Chase Douglas <chasedouglas@gmail.com>=
 wrote:
> On 03/15/2012 06:52 PM, Thorsten Wissmann wrote:
>> On Thu, Mar 15, 2012 at 11:29:37AM -0700, Chase Douglas wrote:
>>> On 03/15/2012 10:56 AM, Thorsten Wissmann wrote:
>>>> On Thu, Mar 15, 2012 at 12:27:22PM -0500, Chris Bagwell wrote:
>>>>> If you want to work with other unmodified user land apps (perhaps
>>>>> xf86-input-evdev for touches) then its probably easiest to split =
pen
>>>>> and touch to separate input devices. =A0drivers/input/tablet/waco=
m_wac.c
>>>>> shows some examples of that approach but that driver doesn't have=
 to
>>>>> work to hard to split in to 2 input devices because the USB devic=
e
>>>>> already puts the events on separate USB =A0interfaces.
>>>>
>>>> OK. We want the device to work with the xf86-input-evdev driver. S=
o we
>>>> will split it into two devices.
>>>
>>> Or you could teach evdev to know how to handle mixed devices :). I =
think
>>> that's the "better" approach over all, but it's up to you.
>>
>> Thanks! We didn't thought about this. It turned out that the problem
>> isn't caused by the usage of both BTN_TOOL_PEN and BTN_TOOL_FINGER.
>>
>> It turned out xf86-input-evdev really discards all non-multitouch ev=
ents
>> (especially ABS_X and ABS_Y) events in EvdevProcessAbsoluteMotionEve=
nt()
>> in evdev.c, if the device is configured as a multitouch device. So t=
here
>> is a quick fix (or only workaround?), which processes ABS_X and ABS_=
Y
>> events even if it is a multitouch device:
>>
>> diff --git a/src/evdev.c b/src/evdev.c
>> index d540b87..b857b83 100644
>> --- a/src/evdev.c
>> +++ b/src/evdev.c
>> @@ -832,7 +832,7 @@ EvdevProcessAbsoluteMotionEvent(InputInfoPtr pIn=
fo,
>> struct input_event *ev)
>> =A0 =A0 =A0if (ev->code >=3D ABS_MT_SLOT) {
>> =A0 =A0 =A0 =A0 =A0EvdevProcessTouchEvent(pInfo, ev);
>> =A0 =A0 =A0 =A0 =A0pEvdev->abs_queued =3D 1;
>> - =A0 =A0} else if (!pEvdev->mt_mask) {
>> + =A0 =A0} else if (!pEvdev->mt_mask || ev->code =3D=3D ABS_X || ev-=
>code =3D=3D
>> ABS_Y) {
>> =A0 =A0 =A0 =A0 =A0map =3D pEvdev->axis_map[ev->code];
>> =A0 =A0 =A0 =A0 =A0valuator_mask_set(pEvdev->vals, map, value);
>> =A0 =A0 =A0 =A0 =A0pEvdev->abs_queued =3D 1;
>>
>> This patch already is submitted to the xorg bugtracker and can be fo=
und
>> at [1].
>>
>> The only remaining question is: Does it break other drivers?
>>
>> =A0 =A0 Max and Thorsten
>>
>> [1] https://bugs.freedesktop.org/show_bug.cgi?id=3D47382
>
> Great!
>
> I haven't fully thought about it enough to give a reviewed-by, but it
> seems sane.
>
> I suggest sending the patch to xorg-devel@lists.x.org. That's where m=
ost
> patch reviews are handled. You will likely get faster results there.
>
> -- Chase

Yep, agree thats also a great way to go.

One thing I might suggest is to include with patch your thinking on
how a pen+multitouch device should send events to help in review of
the patch.  Just the basics.  For example, from above patch I have an
assumption that your sending ABS_X/Y only for PEN events and
ABS_MT_POSITION_X/Y only for touch events; but then again I'm not 100%
sure of that .

If ABS_X/Y is only for PEN events, then pEvdev->in_proximity in
xf86-input-evdev may be a less restrictive check to allow even
BTN_STYLUS and ABS_X/Y events to be processed.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
