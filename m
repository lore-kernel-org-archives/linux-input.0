From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 13:24:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110121323090.2093-100000@iolanthe.rowland.org>
References: <20111012165905.GA29313@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44365 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753631Ab1JLRYn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 13:24:43 -0400
In-Reply-To: <20111012165905.GA29313@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, 12 Oct 2011, Matthew Garrett wrote:

> On Wed, Oct 12, 2011 at 06:56:32PM +0200, Oliver Neukum wrote:
> > Am Mittwoch, 12. Oktober 2011, 18:16:51 schrieb Matthew Garrett:
> > > Yeah. Plausibly the model we have in hid is wrong at the moment - rather 
> > > than set flags that block suspend, it might make more sense to take 
> > > references. It'd complicate things a little, in that we'd have to take 
> > > more care in terms of keeping track of the state.
> > 
> > I am afraid references are very hard to take there because it needs to be done
> > in interrupt.
> 
> True. That makes things rather more awkward.

What about the second idea I mentioned?  If autosuspend fails with
-EBUSY or -EAGAIN, usbcore could schedule another autosuspend attempt.

Alan Stern

