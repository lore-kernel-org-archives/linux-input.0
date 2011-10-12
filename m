From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 15:21:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110121518510.2093-100000@iolanthe.rowland.org>
References: <20111012183306.GA10397@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:32902 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751988Ab1JLTV4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 15:21:56 -0400
In-Reply-To: <20111012183306.GA10397@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, 12 Oct 2011, Henrik Rydberg wrote:

> On Wed, Oct 12, 2011 at 05:59:05PM +0100, Matthew Garrett wrote:
> > On Wed, Oct 12, 2011 at 06:56:32PM +0200, Oliver Neukum wrote:
> > > Am Mittwoch, 12. Oktober 2011, 18:16:51 schrieb Matthew Garrett:
> > > > Yeah. Plausibly the model we have in hid is wrong at the moment - rather 
> > > > than set flags that block suspend, it might make more sense to take 
> > > > references. It'd complicate things a little, in that we'd have to take 
> > > > more care in terms of keeping track of the state.
> > > 
> > > I am afraid references are very hard to take there because it needs to be done
> > > in interrupt.
> > 
> > True. That makes things rather more awkward.
> 
> I was looking at usb_autopm_get_interface_no_resume() yesterday for
> the same reason, it seemed light-weight enough. No?
> 
> Btw, I wonder if the patch below would make sense or if calling put*()
> is always a bug at zero usage count.

It's always a bug.  However, the patch I sent to Matthew should fix the 
immediate problem.

In fact, the original autosuspend design intended to allow drivers to 
do this -- keep devices awake by failing suspend requests even though 
the usage count is 0.  Under some conditions, that's the approach with 
the least overhead.  But the code to handle this got lost by mistake, 
so now it needs to be added back.

Alan Stern

