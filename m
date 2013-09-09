From: "Breton M. Saunders" <bms20@brettnet.eu>
Subject: Re: HID input dealing with multiple collections?
Date: Mon, 09 Sep 2013 16:40:46 +0100
Message-ID: <522DEBFE.1040303@brettnet.eu>
References: <522DC594.2000305@brettnet.eu> <CAN+gG=ELptZsD37P9XMAgbLCFt-yZVbgmbGrk+mLvT6G2raKLQ@mail.gmail.com> <522DD4AA.3020501@brettnet.eu> <CAN+gG=F9OmeXM_s_MX1_q+H=hAwZB518Lx_6FZd42Z8PX=SpJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55383 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3IIPku (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 11:40:50 -0400
In-Reply-To: <CAN+gG=F9OmeXM_s_MX1_q+H=hAwZB518Lx_6FZd42Z8PX=SpJw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

HI Benjamin,
> You can still try to use my backport available here:
> https://github.com/bentiss/hid-multitouch
Great - thanks for that!  It may be a solution.
>
> it _should_ work on a 3.2. You only have to add your VID/PID in
> hid-multitouch to make it work.

Unfortunately not. It seems that writes on the device to the interrupt 
endpoint never complete; I haven't had the USB analyzer on this yet, but 
I suspect that the host running kernel 3.2 is not polling the endpoint.

I did upgrade my Mint13 box to Ubuntu's latest kernel 3.11; and the 
multitouch support looks pretty good.  It worked out of the box. 
However, the mouse channel support isn't working - if I cat /dev/mouse1 
or /dev/mouse2 I see no data coming over when I report mouse events from 
my device.

>
>>    I will, however, install a more modern kernel to test against; esp. since
>> I note your HID-replay tool requires 3.6 to test with.
> well, it requires the module uhid, which is available in 3.6, but also
> in my backport :)
> run "modprobe uhid_compat" and run hid-replay against the
> /dev/hidraw-compatN device.
>
> Anyway, if this is too much of a pain, just send me the report
> descriptor in hexadecimal (and some hexadecimal captures of your
> events), I'll do the formatting myself.
Let me check if I can do this; I may get permission to open up the 
descriptors too.

>>    Would the correct approach here be to implement a composite USB device and
>> have separate USB interfaces for mouse, touch and pen for compatibility with
>> older kernel revisions?
> I would say no because I don't know what would be the behavior of
> Windows. But if you don't care about Windows and if this solution
> works, it's entirely up to you.
>

I may have to resort to that approach.  I believe Microsoft added the 
mouse top level collection to support windows xp; so it may also just 
work out of the box if a separate mouse appears on the same interface.

Cheers,

-Brett

