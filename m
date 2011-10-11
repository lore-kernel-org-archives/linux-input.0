From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Tue, 11 Oct 2011 12:43:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110111240210.2177-100000@iolanthe.rowland.org>
References: <20111011160544.GC10286@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54237 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754969Ab1JKQnz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 12:43:55 -0400
In-Reply-To: <20111011160544.GC10286@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Tue, 11 Oct 2011, Dmitry Torokhov wrote:

> On Tue, Oct 11, 2011 at 06:10:12AM +0200, Oliver Neukum wrote:
> > Am Dienstag, 11. Oktober 2011, 02:11:03 schrieb Matthew Garrett:
> > 
> > > Ah, right, sorry - I wasn't trying to use the device after it had been 
> > > closed. In an ideal world we'd really want to be able to indicate that 
> > > we don't want a remote wakeup in that situation. Otherwise, the patch 
> > > looks good. Thank you!
> > 
> > It looks like we had exactly that capability until
> > 48826626263d4a61d06fd8c5805da31f925aefa0
> > removed it.
> > 
> 
> Hmm, reading Alan's comment I can see why wakeup might be beneficial
> when system is in the sleep state, but while it is running and there is
> no driver or driver wants to disable wakeups I think we should
> accommodate it.

Currently, wakeup is enabled for USB devices during autosuspend if and
only if one or more of the interface drivers has set the
intf->needs_remote_wakeup flag.  Therefore all that usbhid should need 
to do is clear that flag when the device file is closed.

Alan Stern

