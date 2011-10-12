From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 10:18:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110121014550.2093-100000@iolanthe.rowland.org>
References: <20111012135439.GA25266@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33708 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750990Ab1JLOSd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 10:18:33 -0400
In-Reply-To: <20111012135439.GA25266@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Wed, 12 Oct 2011, Matthew Garrett wrote:

> On Wed, Oct 12, 2011 at 09:03:00AM +0200, Oliver Neukum wrote:
> > Am Dienstag, 11. Oktober 2011, 18:43:55 schrieb Alan Stern:
> > > On Tue, 11 Oct 2011, Dmitry Torokhov wrote:
> >  
> > > > Hmm, reading Alan's comment I can see why wakeup might be beneficial
> > > > when system is in the sleep state, but while it is running and there is
> > > > no driver or driver wants to disable wakeups I think we should
> > > > accommodate it.
> > > 
> > > Currently, wakeup is enabled for USB devices during autosuspend if and
> > > only if one or more of the interface drivers has set the
> > > intf->needs_remote_wakeup flag.  Therefore all that usbhid should need 
> > > to do is clear that flag when the device file is closed.
> > 
> > Now I am confused because Matthew reported that his device generated
> > remote wakeups without setting needs_remote_wakeup at all.
> > Matthew, could you clarify?
> 
> I /think/ Alan's wrong here - do_remote_wakeup is set to
> device_may_wakeup(), which will be true if the device can generate 
> remote wakeups even if nothing's asked for them. I'm basing this on 
> autosuspend_check() and choose_wakeup(). Alan, am I misinterpreting this 
> code?

We may be talking about different things.  choose_wakeup() is called
for system suspend, whereas autosuspend_check() is called (obviously!)
for autosuspend.

Yes, choose_wakeup() uses device_may_wakeup().  But I was referring
only to autosuspend (as was Dmitry).  In autosuspend_check(),
do_remote_wakeup is set to w, which is the result of or'ing all the
intf->needs_remote_wakeup values.

Alan Stern

