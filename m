From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH 8/8] Input: xpad: do not submit active URBs
Date: Fri, 31 Jul 2015 15:08:15 +0200
Message-ID: <CA+b0ujd3v+OV=ZHerN9o3oD0RR_OxwfpgbpV+itwW6aVSiULHA@mail.gmail.com>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
 <1436572068-10661-9-git-send-email-rojtberg@gmail.com> <20150730065958.GD35939@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35000 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbbGaNIf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 09:08:35 -0400
Received: by qgii95 with SMTP id i95so44872897qgi.2
        for <linux-input@vger.kernel.org>; Fri, 31 Jul 2015 06:08:34 -0700 (PDT)
In-Reply-To: <20150730065958.GD35939@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Greg KH <gregkh@linuxfoundation.org>

2015-07-30 8:59 GMT+02:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Sat, Jul 11, 2015 at 01:47:48AM +0200, Pavel Rojtberg wrote:
>> From: Pavel Rojtberg <rojtberg@gmail.com>
>>
>> track the active status of the irq_out URB to prevent submission while
>> it is active. Failure to do so results in the "URB submitted while
>> active" warning/ stacktrace.
>>
>> Also add missing mutex locking around xpad->odata usages.
>>
>> This is an workaround for a suspend/ resume issue on my machine, where
>> after resume irq_out is completely dead.
>>
>> In preliminary testing I could not observe any dropping of packets.
>> (controlling rumble with fftest while setting the LEDs using sysfs)
>> If there actually are cases where packets are dropped an extension of
>> this patch to queue the URBs instead of dropping is straightforward.
>
> We need to implement it. If you weren't able to reproduce the race it
> does not mean it does not exist.
I will probably just back out this one from v2. It is not quite clear to me
whether we are at fault here for not buffering the packets or the userspace
for submitting too many.

Furthermore I found out that I can wake up irq_out by resetting the usb device
after suspend/ resume. This would be a better fix for my issue at hand.

> Also you can not take mutex in xpad_play_effect as it is called under a
> spinlock with interrupts disabled.
Should the odata_mutex better be replaced by a spinlock then?

> Thanks.
>
> --
> Dmitry
