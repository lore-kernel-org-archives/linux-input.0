From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Wed, 15 Jun 2011 00:26:55 +0200
Message-ID: <7710689.O2quS97bHe@qosmio-x300>
References: <2502891.N5kVV5at6b@qosmio-x300> <e8b1518b49c3c1dd660270df5e512705.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32927 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab1FNW0y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 18:26:54 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so14969fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 15:26:53 -0700 (PDT)
In-Reply-To: <e8b1518b49c3c1dd660270df5e512705.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: jkosina@suse.cz, linux-input@vger.kernel.org

On Tuesday 14 of June 2011 17:20:52 you wrote:
> > Hello,
> > 
> > this patch fixes two issues with autocentering in lgff driver. Current
> > implementation incorrectly assumes that the saturation force is always
> > 0x80 which is
> > inconsistent with behavior of the official driver. It also makes it
> > impossible to disable autocentering on some wheels - at least Logitech
> > Formula Force RX is
> > the case. Values of stiffness coefficient were also calculated
> > incorrectly. Formula used in this patch appears to generate the same
> > commands as the official
> > Logitech drivers. The patch also fixes two minor coding style issues.
> 
> Hi Michal,
> Can you elaborate more on the difference between stiffness and saturation?
> And how these might work in the Linux FF system which only accounts a
> single parameter.
> 
> On my reverse engineering of the Wii Wheel (1) I noticed that the
> AutoCentre consisted of 3 variables, but did realise the precise details.
> Perhaps I can factor in a similar adjustment....
> 
> BTW - I also discovered some other modes of feedback beyond AutoCentre and
> CF which might be applicable to other Logitech wheels. (2)
> 
> Simon
> 
> 1.
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=dr
> ivers/hid/hid-lg4ff.c;h=fa550c8e1d1bc639bd3e9c34a299903391bca44a;hb=3a2289a4
> a317e0290a8bc7af28c62c9830cb12e5#l72
> 
> 2. http://wiibrew.org/wiki/Logitech_USB_steering_wheel

Sure, but please don't take it like I have some inside knowledge of Logitech FF implementation. I've been given few bits of useful information, the rest I 
figured out from sniffed USB communication.

Centering force seems to be modeled as a spring effect. Force created by a spring can be calculated as "F = -k*x" where F = force, k = stiffness coefficient 
and x = deflection from centre. The higher the k is, the faster the centering force increases when the wheel is turned. Saturation force seems to be the limit 
centering force, so when kx > saturation_force => F = saturation_force.
Logitech driver has a slider which sets the centering force from 0 % to 150 % (it's actually from 0 % to 200 %, at least the values in the command suggest 
so) and both the stiffness coeff and saturation force increase gradually with the centering force according to the formula I provide in the patch, so just the 
magnitude value is enough. It looks like the stiffness coeff actually wraps around, because 0 = no stiffness, 7 = max stiffness, 8 = low stiffness, 15 = max 
stiffness. It'd be interesting to see if you can observe the same behavior on the Wii wheel.

As for the other FF effects, I guess these are things like "rumble" etc. I'm planning to look into it more when I'll have some extra free time.

Regards, Michal.
