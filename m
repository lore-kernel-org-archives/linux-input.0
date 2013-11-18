From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: About the PS3 Sixaxis linux driver
Date: Mon, 18 Nov 2013 10:38:42 -0500
Message-ID: <528A3482.8040807@redhat.com>
References: <526A697E.7050605@corpsmoderne.net>	<1256411740.1745741.1383597450835.JavaMail.root@redhat.com>	<20131104221824.2bd181e60f01f41e1e4f4898@studenti.unina.it>	<6ead5599102745d03c2c28b640b11fb4.squirrel@mungewell.org> <20131116180607.8508c13158a181f8c5fa7dd6@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64831 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab3KRPjR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 10:39:17 -0500
In-Reply-To: <20131116180607.8508c13158a181f8c5fa7dd6@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>, simon@mungewell.org
Cc: Henrik Rydberg <rydberg@euromail.se>, case <case@corpsmoderne.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi guys,

I forgot to say that:
- IMO, the approach raised in 2011 by Antonio[1] was the correct one:
the multitouch protocol introduced a regression with devices providing
large axis number, so we should fix this in input core, not on a per
device basis.
- I'll send an update to this patch later this week.
- I don't think remapping the PS3 axis now will make into upstream
(backward compatibility), but this is only my own opinion
- I have discussed this with the Xinput maintainer, and he also would
like to get the information from the kernel when the ABS_MT axis are
used as ABS_MT or ABS_MISC, so I'll also add a property in this way.

Cheers,
Benjamin

[1] http://www.spinics.net/lists/linux-input/msg16881.html

On 16/11/13 12:06, Antonio Ospite wrote:
> On Mon, 4 Nov 2013 16:40:29 -0500
> simon@mungewell.org wrote:
> 
> Hi Simon, sorry for the delay on this one.
>  
>>> Actually I intended to rewrite the whole HID descriptor and add a sane
>>> mapping for all the buttons (maybe following the Gamepad API and
>>> even using the new ABS_ACCEL_* and ABS_GYRO_* events from David
>>> Hermann).
>>
>> I think that the root of the problem here is simply the large number of
>> axis, and that the keycodes start at 'axis-x' then overflow into/past the
>> MultiTouch keycode.
>>
> 
> Yes, and the code that maps HID usages to event keycodes also comes into
> play I guess.
> 
>> This problem is going to be a more common one as HID drivers present more
>> buttons/axis.
>>
>> We did some patching here:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-sony.c?id=refs/tags/v3.12#n301
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/hid-sony.c?id=61ab44bebdefab296487e7cd723a634849278827
>>
>> Do we need to fix this is the HID descriptor, or in 'hid-sony' input stuff?
> 
> I think both:
> 
>   1. adjust the HID descriptor into something that can be more easily
>      remapped;
> 
>   2. remap the keycodes in hid-sony to those of the gamepad API, because
>      AFAICT that can't be achieved by solely deciding HID usage codes in
>      the descriptor.
> 
>> Do you have example of another driver to copy?
> 
> I am doing some work already in this direction, on the lines of what we
> did for the ps3remote in hid-sony, but it needs some input bits not
> merged yet, I'll send an RFC as soon as this becomes more easily
> testable.
> 
> Regards,
>    Antonio
> 

