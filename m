From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Complete support for the new unibody macbooks
Date: Wed, 19 Nov 2008 23:33:21 +0100
Message-ID: <49249431.9040104@euromail.se>
References: <49109C91.6090207@euromail.se> <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz> <4919C979.3000501@euromail.se> <alpine.LNX.1.10.0811112347260.24889@jikos.suse.cz> <20081119113753.ZZRA012@mailhub.coreip.homeip.net> <alpine.LNX.1.10.0811191803320.19853@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:38086 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750969AbYKSWdb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2008 17:33:31 -0500
In-Reply-To: <alpine.LNX.1.10.0811191803320.19853@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Jiri Kosina wrote:
[...]
>>> Yes, I am aware of bcm5974 being dependent in HID driver not claiming 
>>> the mouse interface on this hardware.
>>> Dmitry, what are your plans with this bcm5974 patch? 2.6.28 or 2.6.29?
>> 2.6.29 - the driver is in use so I did nto want to touch it after .28 
>> merge window closed. 
> 
> I see. I have already pushed the bits that ignore the mouse interface on 
> the hardware in question in HID code. But that should be perfectly fine, 
> as as the HID driver can't do anything with that mouse anyway.

Without the mouse ignore quirk, HID will find the "normal" usb mouse
interface. The current situation is much worse than to throw the bcm5974
patches in untested. And this is not even the case; the updated driver has
been in use as a dkms package for almost a month.

Cheers,
Henrik

