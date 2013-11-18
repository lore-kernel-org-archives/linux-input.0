From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: About the PS3 Sixaxis linux driver
Date: Mon, 18 Nov 2013 12:02:56 -0500
Message-ID: <528A4840.6010205@redhat.com>
References: <526A697E.7050605@corpsmoderne.net>	<1256411740.1745741.1383597450835.JavaMail.root@redhat.com>	<20131104221824.2bd181e60f01f41e1e4f4898@studenti.unina.it>	<6ead5599102745d03c2c28b640b11fb4.squirrel@mungewell.org>	<20131116180607.8508c13158a181f8c5fa7dd6@studenti.unina.it>	<528A3482.8040807@redhat.com> <20131118172535.e6abd12d338023ead6477058@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab3KRRDP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 12:03:15 -0500
In-Reply-To: <20131118172535.e6abd12d338023ead6477058@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: simon@mungewell.org, Henrik Rydberg <rydberg@euromail.se>, case <case@corpsmoderne.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

On 18/11/13 11:25, Antonio Ospite wrote:
> On Mon, 18 Nov 2013 10:38:42 -0500
> Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
>> Hi guys,
>>
>> I forgot to say that:
>> - IMO, the approach raised in 2011 by Antonio[1] was the correct one:
>> the multitouch protocol introduced a regression with devices providing
>> large axis number, so we should fix this in input core, not on a per
>> device basis.
>> - I'll send an update to this patch later this week.
> 
> Thanks.
> 
>> - I don't think remapping the PS3 axis now will make into upstream
>> (backward compatibility), but this is only my own opinion
> 
> What do other people think? I was going to motivate the change of
> keycodes with the fact that the device was not fully functional for a
> long time, but if you fix it in input core this argument does not hold
> anymore :)

Just FYI, I mentioned this because there already has been 2 or 3 threads
regarding bad uses of keycodes/axis for gamepads (WII, XBox, and PS3
IIRC), and the result was always "we do not break user space".
Personally, I have nothing against mapping the correct axis :)

> 
> It would have been a good excuse to have a user of the full gamepad
> API and of a good part of the motion-tracking API, but I won't push
> this too hard.

There are some initiatives in the user space to fix those kernel
problems. libinputmapper (find one of David Herrmann's post) and
libevdev (on Freedesktop) are some good candidates.

Cheers,
Benjamin
