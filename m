From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Mon, 19 Mar 2012 20:04:38 -0500
Message-ID: <CAGzDe_Zagbkzgq+Y=3rofi0nEXsFyiunBb=KAvLJsPTbWLQoJw@mail.gmail.com>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de>
	<CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com>
	<20120315175635.GA23155@stud.informatik.uni-erlangen.de>
	<4F623511.3040907@gmail.com>
	<20120316015224.GA8230@stud.informatik.uni-erlangen.de>
	<4F629F60.7010600@gmail.com>
	<CAGzDe_ZVUSu+zFq8giOJfOTYzYWrf=2+Z64KASTE_MpVQ1yMzw@mail.gmail.com>
	<20120316173332.GA28620@stud.informatik.uni-erlangen.de>
	<4F63A22B.4090102@gmail.com>
	<20120319063915.GA15489@polaris.bitmath.org>
	<4F67519D.7050206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65522 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754485Ab2CTBEk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 21:04:40 -0400
Received: by lahj13 with SMTP id j13so5202952lah.19
        for <linux-input@vger.kernel.org>; Mon, 19 Mar 2012 18:04:38 -0700 (PDT)
In-Reply-To: <4F67519D.7050206@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>, linux-input@vger.kernel.org, =?ISO-8859-1?Q?Maximilian_Kr=FCger?= <maxfragg@gmail.com>, i4passt@lists.informatik.uni-erlangen.de

2012/3/19 Chase Douglas <chasedouglas@gmail.com>:
> On 03/18/2012 11:39 PM, Henrik Rydberg wrote:
>>> The proper way to send events through evdev when there are two diff=
erent
>>> "tools" (pen and touch) is to use BTN_TOOL_*. In your example above=
, it
>>> would be:
>>>
>>> # finger touch (Note lack of tool, it's assumed to be finger)
>>> =A0 =A0 ABS_MT_SLOT 0
>>> =A0 =A0 ABS_MT_TRACKING_ID 42
>>> =A0 =A0 ABS_MT_POSITION_X finger_x
>>> =A0 =A0 ABS_MT_POSITION_Y finger_y
>>> =A0 =A0 SYN_MT_REPORT
>>> =A0 =A0 ABS_X finger_x
>>> =A0 =A0 ABS_Y finger_y
>>> =A0 =A0 SYN_REPORT
>>> # finger release
>>> =A0 =A0 ABS_MT_SLOT 0
>>> =A0 =A0 ABS_MT_TRACKING_ID -1
>>> =A0 =A0 SYN_REPORT
>>> # pen motion
>>> =A0 =A0 BTN_TOOL_PEN 1
>>> =A0 =A0 ABS_X pen_x
>>> =A0 =A0 ABS_Y pen_y
>>> =A0 =A0 SYN_REPORT
>>> # finger touch begin
>>> =A0 =A0 ABS_MT_SLOT 0
>>> =A0 =A0 ABS_MT_TRACKING_ID 42
>>> =A0 =A0 ABS_MT_POSITION_X finger_x
>>> =A0 =A0 ABS_MT_POSITION_Y finger_y
>>> =A0 =A0 SYN_MT_REPORT
>>> =A0 =A0 BTN_TOOL_PEN 0
>>> =A0 =A0 ABS_X finger_x
>>> =A0 =A0 ABS_Y finger_y
>>> =A0 =A0 SYN_REPORT
>>> etc.
>>>
>>> Then, xf86-input-evdev ignores ABS_{X,Y} events when there is no
>>> BTN_TOOL_* active.
>>
>> On the subject how pen and touch could work going forward, the MT
>> protocol is prepared to deal with tool type per slot. It makes a lot
>> of sense to move away from the above example, towards a fully parall=
el
>> representation of pen and touch data. Today's multitouch interfaces
>> are really tremendously restrictive; I am looking forward to the day
>> when one does not need to worry about touching or resting on a surfa=
ce
>> in order to operate it.
>>
>> In short, why not make xf86-input-evdev aware of MT_TOOL_TYPE?
>
> There's no reason it can't be made aware. The question is whether you
> want to create separate X input devices, or annotate events with the
> tool type. No one has really bothered looking into it outside of waco=
m
> devices, but my understanding is that wacom is a big special cased
> situation due to historical reasons anyway.
>
> If we merely annotate events by setting valuator values, that's a
> trivial change that may even be already supported out of the box.
> Splitting the evdev device into multiple X input devices is also
> possible, since xf86-input-wacom does it, but would require a large
> refactoring of xf86-input-evdev.
>

=46WIW, non-wacom pen+touch devices should work with current
xf86-input-wacom if they use above events.  You will get split devices
as long as you modify xorg.conf.d to route this input.  MT events will
be treated roughly like xf86-input-synaptics would treat DOUBLETAP
though (internal 1 and 2 finger gesture support only).

My plan is to take your xf86-input-evdev/synaptics X Input 2.2 work
and merge it into xf86-input-wacom soon to benefit from those
improvements.  In addition to Wacom MT hardware, I try to occasionally
test xf86-input-wacom with a hid-multitouch touchscreen to verify it
isn't needlessly wacom specific.

Having said that, I think its good to improve multi-tool support in
xf86-input-evdev in parallel to the multi-touch improvements.  In
addition, xf86-input-evdev would be a much better base to start
experimenting with annotating events.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
