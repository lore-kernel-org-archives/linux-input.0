From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid: Complete support for the new unibody macbooks
Date: Wed, 19 Nov 2008 11:40:35 -0500
Message-ID: <20081119113753.ZZRA012@mailhub.coreip.homeip.net>
References: <49109C91.6090207@euromail.se> <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz> <4919C979.3000501@euromail.se> <alpine.LNX.1.10.0811112347260.24889@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f11.google.com ([209.85.217.11]:38129 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbYKSQkm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2008 11:40:42 -0500
Received: by gxk4 with SMTP id 4so2001gxk.13
        for <linux-input@vger.kernel.org>; Wed, 19 Nov 2008 08:40:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0811112347260.24889@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 11, 2008 at 11:48:31PM +0100, Jiri Kosina wrote:
> On Tue, 11 Nov 2008, Henrik Rydberg wrote:
> 
> > No worries. I should have mentioned earlier that the hid update is best 
> > synchronized with the bcm5974 update, since the latter is the only 
> > driver that will pick the mouse interface up after the hid update. The 
> > bcm5974 patch was sent on October 23, but I have not received any 
> > feedback to it yet.
> 
> Yes, I am aware of bcm5974 being dependent in HID driver not claiming the 
> mouse interface on this hardware.
> 
> Dmitry, what are your plans with this bcm5974 patch? 2.6.28 or 2.6.29?
> 

2.6.29 - the driver is in use so I did nto want to touch it after .28
merge window closed. Also I am moving to the west coast so swamped
anyways but I hope I will be somewhat settled after December 8th.

Btw, if you see something that you think needs to go into .28 for
input could please merge it for me? I also going to ask Linus to pull
from my for-linus branch in the next couple of days.

Thanks!

-- 
Dmitry
