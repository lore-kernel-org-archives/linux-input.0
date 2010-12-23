From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: Add MULTI_INPUT quirk for another D-WAV touchscreen
Date: Thu, 23 Dec 2010 23:17:29 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012232315510.16569@pobox.suse.cz>
References: <1292928918-31264-1-git-send-email-anisse@astier.eu> <20101222191926.GA30150@polaris.bitmath.org> <20101223174750.5eea0e7b@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60649 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab0LWWRb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Dec 2010 17:17:31 -0500
In-Reply-To: <20101223174750.5eea0e7b@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

On Thu, 23 Dec 2010, Anisse Astier wrote:

> On Wed, 22 Dec 2010 20:19:26 +0100, "Henrik Rydberg" <rydberg@euromail.se> wrote :
> 
> > On Tue, Dec 21, 2010 at 10:55:18AM -0000, Anisse Astier wrote:
> > > Signed-off-by: Anisse Astier <anisse@astier.eu>
> > 
> > Thanks for the patch - full multitouch support for this device will be enabled in 2.6.38.
> > 
> > (@jiri: yes, and it is already queued)
> 
> I checked quickly Jiri's tree to see if it was already supported in the
> HID branch before sending. How could I check your patch queue or
> Stephane's in the future ?

This merge window is quite special ... normally all the hid-related 
changes go through my tree. But this time, there is huge multitouch rework 
happening in input core, and all the changes that depend on it flow 
altogether with it (i.e. through input tree).

Next time, things should be back to normal, with drivers/hid/* going 
through my tree.

> I've also had another USB touchscreen with USB id 222a:0001 needing the 
> MULTI_INPUT quirk, but I don't have the hardware anymore and I don't 
> know it'll be of useful to anyone.

I'll happily merge any VID/PID addition if it makes any hardware piece 
work properly.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
