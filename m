From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: USB interrupt times
Date: Wed, 15 Aug 2012 11:02:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208151102040.7026@pobox.suse.cz>
References: <20120814103936.GA7105@flint.arm.linux.org.uk> <alpine.LNX.2.00.1208141250020.12490@pobox.suse.cz> <20120814121804.GC7105@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35236 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab2HOJCq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 05:02:46 -0400
In-Reply-To: <20120814121804.GC7105@flint.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Henrik Rydberg <rydberg@euromail.se>

On Tue, 14 Aug 2012, Russell King wrote:

> > Actually, Henrik (added to CC) has been doing some latency improvements 
> > both for input core in general, and for HID devices as well lately. I 
> > still have his patchset in my to-review queue, as I have just came back 
> > from offline vacation, but the patch below definitely can't hurt and 
> > should significantly lower the time spent in handling the irq for hid 
> > device in common situation (i.e. noone listening for debugfs events).
> > 
> > Could you please measure how much it helps on your system?
> 
> Ok, it looks like it's changed the maximum USB interrupt execution
> time from around 364us to 255us.
> 
> If I also do a similar trick with the debug code in hid_input_report()
> then I get down to 212us - iow, something like the patch below.

Are you testing with kernel that contains b94e3c94aae04 already? That 
should cover that case.

-- 
Jiri Kosina
SUSE Labs
