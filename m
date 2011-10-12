From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 14:54:39 +0100
Message-ID: <20111012135439.GA25266@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1110111240210.2177-100000@iolanthe.rowland.org>
 <201110120903.00651.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38170 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab1JLNyn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 09:54:43 -0400
Content-Disposition: inline
In-Reply-To: <201110120903.00651.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Wed, Oct 12, 2011 at 09:03:00AM +0200, Oliver Neukum wrote:
> Am Dienstag, 11. Oktober 2011, 18:43:55 schrieb Alan Stern:
> > On Tue, 11 Oct 2011, Dmitry Torokhov wrote:
>  
> > > Hmm, reading Alan's comment I can see why wakeup might be beneficial
> > > when system is in the sleep state, but while it is running and there is
> > > no driver or driver wants to disable wakeups I think we should
> > > accommodate it.
> > 
> > Currently, wakeup is enabled for USB devices during autosuspend if and
> > only if one or more of the interface drivers has set the
> > intf->needs_remote_wakeup flag.  Therefore all that usbhid should need 
> > to do is clear that flag when the device file is closed.
> 
> Now I am confused because Matthew reported that his device generated
> remote wakeups without setting needs_remote_wakeup at all.
> Matthew, could you clarify?

I /think/ Alan's wrong here - do_remote_wakeup is set to
device_may_wakeup(), which will be true if the device can generate 
remote wakeups even if nothing's asked for them. I'm basing this on 
autosuspend_check() and choose_wakeup(). Alan, am I misinterpreting this 
code?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
