From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Fri, 16 Mar 2012 13:27:23 -0700
Message-ID: <4F63A22B.4090102@gmail.com>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de> <CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com> <20120315175635.GA23155@stud.informatik.uni-erlangen.de> <4F623511.3040907@gmail.com> <20120316015224.GA8230@stud.informatik.uni-erlangen.de> <4F629F60.7010600@gmail.com> <CAGzDe_ZVUSu+zFq8giOJfOTYzYWrf=2+Z64KASTE_MpVQ1yMzw@mail.gmail.com> <20120316173332.GA28620@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42293 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965082Ab2CPU0z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 16:26:55 -0400
Received: by mail-pz0-f46.google.com with SMTP id r28so6589691daj.19
        for <linux-input@vger.kernel.org>; Fri, 16 Mar 2012 13:26:54 -0700 (PDT)
In-Reply-To: <20120316173332.GA28620@stud.informatik.uni-erlangen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, =?ISO-8859-1?Q?Maximilian_Kr=FCger?= <maxfragg@gmail.com>, i4passt@lists.informatik.uni-erlangen.de

On 03/16/2012 10:33 AM, Thorsten Wissmann wrote:
> On Thu, Mar 15, 2012 at 09:57:30PM -0500, Chris Bagwell wrote:
>> On Thu, Mar 15, 2012 at 9:03 PM, Chase Douglas <chasedouglas@gmail.com> wrote:
>>> On 03/15/2012 06:52 PM, Thorsten Wissmann wrote:
>>>> It turned out xf86-input-evdev really discards all non-multitouch events
>>>> (especially ABS_X and ABS_Y) events in EvdevProcessAbsoluteMotionEvent()
>>>> in evdev.c, if the device is configured as a multitouch device. So there
>>>> is a quick fix (or only workaround?), which processes ABS_X and ABS_Y
>>>> events even if it is a multitouch device:
>>>>
>>>> diff --git a/src/evdev.c b/src/evdev.c
>>>> index d540b87..b857b83 100644
>>>> --- a/src/evdev.c
>>>> +++ b/src/evdev.c
>>>> @@ -832,7 +832,7 @@ EvdevProcessAbsoluteMotionEvent(InputInfoPtr pInfo,
>>>> struct input_event *ev)
>>>>      if (ev->code >= ABS_MT_SLOT) {
>>>>          EvdevProcessTouchEvent(pInfo, ev);
>>>>          pEvdev->abs_queued = 1;
>>>> -    } else if (!pEvdev->mt_mask) {
>>>> +    } else if (!pEvdev->mt_mask || ev->code == ABS_X || ev->code ==
>>>> ABS_Y) {
>>>>          map = pEvdev->axis_map[ev->code];
>>>>          valuator_mask_set(pEvdev->vals, map, value);
>>>>          pEvdev->abs_queued = 1;
>>>>
>>>> This patch already is submitted to the xorg bugtracker and can be found
>>>> at [1].
>>>>
>>>> The only remaining question is: Does it break other drivers?
>>>>
>>>> [1] https://bugs.freedesktop.org/show_bug.cgi?id=47382
>>>
>>> Great!
>>>
>>> I haven't fully thought about it enough to give a reviewed-by, but it
>>> seems sane.
>>>
>>> I suggest sending the patch to xorg-devel@lists.x.org. That's where most
>>> patch reviews are handled. You will likely get faster results there.
>>
>> Yep, agree thats also a great way to go.
> 
> Thanks!
> 
>> One thing I might suggest is to include with patch your thinking on
>> how a pen+multitouch device should send events to help in review of
>> the patch.  Just the basics.  For example, from above patch I have an
>> assumption that your sending ABS_X/Y only for PEN events and
>> ABS_MT_POSITION_X/Y only for touch events; but then again I'm not 100%
>> sure of that.
> 
> That's correct. In our case, it's ABS_X/Y for pen, ABS_MT_* for fingers
> (normal touches). But maybe other devices behave different. So we should
> send something like this as an addition to the patch on the x.org list?
> 
> # finger touch
>     ABS_MT_SLOT 0
>     ABS_MT_TRACKING_ID 42
>     ABS_MT_POSITION_X finger_x
>     ABS_MT_POSITION_Y finger_y
>     SYN_MT_REPORT
>     SYN_REPORT
> # finger release
>     ABS_MT_SLOT 0
>     ABS_MT_TRACKING_ID -1
>     SYN_REPORT
> # pen motion
>     ABS_X pen_x
>     ABS_Y pen_y
>     SYN_REPORT

The proper way to send events through evdev when there are two different
"tools" (pen and touch) is to use BTN_TOOL_*. In your example above, it
would be:

# finger touch (Note lack of tool, it's assumed to be finger)
    ABS_MT_SLOT 0
    ABS_MT_TRACKING_ID 42
    ABS_MT_POSITION_X finger_x
    ABS_MT_POSITION_Y finger_y
    SYN_MT_REPORT
    ABS_X finger_x
    ABS_Y finger_y
    SYN_REPORT
# finger release
    ABS_MT_SLOT 0
    ABS_MT_TRACKING_ID -1
    SYN_REPORT
# pen motion
    BTN_TOOL_PEN 1
    ABS_X pen_x
    ABS_Y pen_y
    SYN_REPORT
# finger touch begin
    ABS_MT_SLOT 0
    ABS_MT_TRACKING_ID 42
    ABS_MT_POSITION_X finger_x
    ABS_MT_POSITION_Y finger_y
    SYN_MT_REPORT
    BTN_TOOL_PEN 0
    ABS_X finger_x
    ABS_Y finger_y
    SYN_REPORT
etc.

Then, xf86-input-evdev ignores ABS_{X,Y} events when there is no
BTN_TOOL_* active.

-- Chase
