From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V2] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 15:38:02 +0100
Message-ID: <20111010143802.GA18364@srcf.ucam.org>
References: <1318254086-22752-1-git-send-email-mjg@redhat.com>
 <201110101606.37878.oneukum@suse.de>
 <20111010141635.GA17889@srcf.ucam.org>
 <201110101634.39018.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36300 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab1JJOiF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 10:38:05 -0400
Content-Disposition: inline
In-Reply-To: <201110101634.39018.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, dtor@mail.ru

On Mon, Oct 10, 2011 at 04:34:38PM +0200, Oliver Neukum wrote:
> Am Montag, 10. Oktober 2011, 16:16:35 schrieb Matthew Garrett:
> > On Mon, Oct 10, 2011 at 04:06:37PM +0200, Oliver Neukum wrote:
> > 
> > > This is odd, because the hardware shouldn't generate remote wakeups unless you
> > > request them, like this (usbhid)
> > 
> > I thought needs_remote_wakeup was a hint to the kernel that remote 
> > wakeup ability was required for the hardware to autosuspend? In theory I
> 
> It fulfills that role, but it is not its sole function.
> 
> > guess it should be set, but in practice all the hardware supported by 
> > this driver generates them so it'd be a noop. No objection to adding it 
> > in the name of correctness (or if some future version is broken, I 
> > guess...), though.
> 
> It is used in usb_port_suspend in form of do_remote_wakeup which
> is computed from it. And we send a real control message.

do_remote_wakeup will be set if device_may_wakeup is true, regardless of 
whether the driver asks for it. Or am I misreading choose_wakeup()?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
