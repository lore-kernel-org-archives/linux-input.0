From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH V2] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 16:42:49 +0200
Message-ID: <201110101642.49145.oneukum@suse.de>
References: <1318254086-22752-1-git-send-email-mjg@redhat.com> <201110101634.39018.oneukum@suse.de> <20111010143802.GA18364@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38874 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab1JJOma (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 10:42:30 -0400
In-Reply-To: <20111010143802.GA18364@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, dtor@mail.ru

Am Montag, 10. Oktober 2011, 16:38:02 schrieb Matthew Garrett:
> On Mon, Oct 10, 2011 at 04:34:38PM +0200, Oliver Neukum wrote:
> > Am Montag, 10. Oktober 2011, 16:16:35 schrieb Matthew Garrett:
> > > On Mon, Oct 10, 2011 at 04:06:37PM +0200, Oliver Neukum wrote:
> > > 
> > > > This is odd, because the hardware shouldn't generate remote wakeups unless you
> > > > request them, like this (usbhid)
> > > 
> > > I thought needs_remote_wakeup was a hint to the kernel that remote 
> > > wakeup ability was required for the hardware to autosuspend? In theory I
> > 
> > It fulfills that role, but it is not its sole function.
> > 
> > > guess it should be set, but in practice all the hardware supported by 
> > > this driver generates them so it'd be a noop. No objection to adding it 
> > > in the name of correctness (or if some future version is broken, I 
> > > guess...), though.
> > 
> > It is used in usb_port_suspend in form of do_remote_wakeup which
> > is computed from it. And we send a real control message.
> 
> do_remote_wakeup will be set if device_may_wakeup is true, regardless of 
> whether the driver asks for it. Or am I misreading choose_wakeup()?

Indeed things have changed. Arguably this raises power consumption.
Anyway, you ought to set it so usbcore will refuse should remote wakeup
fail to be enabled.

	Regards
		Oliver
