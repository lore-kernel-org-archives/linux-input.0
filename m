From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Mon, 19 Mar 2012 08:32:45 -0700
Message-ID: <4F67519D.7050206@gmail.com>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de> <CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com> <20120315175635.GA23155@stud.informatik.uni-erlangen.de> <4F623511.3040907@gmail.com> <20120316015224.GA8230@stud.informatik.uni-erlangen.de> <4F629F60.7010600@gmail.com> <CAGzDe_ZVUSu+zFq8giOJfOTYzYWrf=2+Z64KASTE_MpVQ1yMzw@mail.gmail.com> <20120316173332.GA28620@stud.informatik.uni-erlangen.de> <4F63A22B.4090102@gmail.com> <20120319063915.GA15489@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51757 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab2CSPcJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 11:32:09 -0400
Received: by pbcun15 with SMTP id un15so1150275pbc.19
        for <linux-input@vger.kernel.org>; Mon, 19 Mar 2012 08:32:09 -0700 (PDT)
In-Reply-To: <20120319063915.GA15489@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, =?ISO-8859-1?Q?Maximilian_Kr=FCger?= <maxfragg@gmail.com>, i4passt@lists.informatik.uni-erlangen.de

On 03/18/2012 11:39 PM, Henrik Rydberg wrote:
>> The proper way to send events through evdev when there are two different
>> "tools" (pen and touch) is to use BTN_TOOL_*. In your example above, it
>> would be:
>>
>> # finger touch (Note lack of tool, it's assumed to be finger)
>>     ABS_MT_SLOT 0
>>     ABS_MT_TRACKING_ID 42
>>     ABS_MT_POSITION_X finger_x
>>     ABS_MT_POSITION_Y finger_y
>>     SYN_MT_REPORT
>>     ABS_X finger_x
>>     ABS_Y finger_y
>>     SYN_REPORT
>> # finger release
>>     ABS_MT_SLOT 0
>>     ABS_MT_TRACKING_ID -1
>>     SYN_REPORT
>> # pen motion
>>     BTN_TOOL_PEN 1
>>     ABS_X pen_x
>>     ABS_Y pen_y
>>     SYN_REPORT
>> # finger touch begin
>>     ABS_MT_SLOT 0
>>     ABS_MT_TRACKING_ID 42
>>     ABS_MT_POSITION_X finger_x
>>     ABS_MT_POSITION_Y finger_y
>>     SYN_MT_REPORT
>>     BTN_TOOL_PEN 0
>>     ABS_X finger_x
>>     ABS_Y finger_y
>>     SYN_REPORT
>> etc.
>>
>> Then, xf86-input-evdev ignores ABS_{X,Y} events when there is no
>> BTN_TOOL_* active.
> 
> On the subject how pen and touch could work going forward, the MT
> protocol is prepared to deal with tool type per slot. It makes a lot
> of sense to move away from the above example, towards a fully parallel
> representation of pen and touch data. Today's multitouch interfaces
> are really tremendously restrictive; I am looking forward to the day
> when one does not need to worry about touching or resting on a surface
> in order to operate it.
> 
> In short, why not make xf86-input-evdev aware of MT_TOOL_TYPE?

There's no reason it can't be made aware. The question is whether you
want to create separate X input devices, or annotate events with the
tool type. No one has really bothered looking into it outside of wacom
devices, but my understanding is that wacom is a big special cased
situation due to historical reasons anyway.

If we merely annotate events by setting valuator values, that's a
trivial change that may even be already supported out of the box.
Splitting the evdev device into multiple X input devices is also
possible, since xf86-input-wacom does it, but would require a large
refactoring of xf86-input-evdev.

-- Chase
