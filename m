From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: USB interrupt times
Date: Wed, 15 Aug 2012 10:15:54 +0100
Message-ID: <20120815091554.GD7105@flint.arm.linux.org.uk>
References: <20120814103936.GA7105@flint.arm.linux.org.uk> <alpine.LNX.2.00.1208141250020.12490@pobox.suse.cz> <20120814121804.GC7105@flint.arm.linux.org.uk> <alpine.LNX.2.00.1208151102040.7026@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38986 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab2HOJQE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 05:16:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1208151102040.7026@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Henrik Rydberg <rydberg@euromail.se>

On Wed, Aug 15, 2012 at 11:02:37AM +0200, Jiri Kosina wrote:
> On Tue, 14 Aug 2012, Russell King wrote:
> 
> > > Actually, Henrik (added to CC) has been doing some latency improvements 
> > > both for input core in general, and for HID devices as well lately. I 
> > > still have his patchset in my to-review queue, as I have just came back 
> > > from offline vacation, but the patch below definitely can't hurt and 
> > > should significantly lower the time spent in handling the irq for hid 
> > > device in common situation (i.e. noone listening for debugfs events).
> > > 
> > > Could you please measure how much it helps on your system?
> > 
> > Ok, it looks like it's changed the maximum USB interrupt execution
> > time from around 364us to 255us.
> > 
> > If I also do a similar trick with the debug code in hid_input_report()
> > then I get down to 212us - iow, something like the patch below.
> 
> Are you testing with kernel that contains b94e3c94aae04 already? That 
> should cover that case.

No - the kernel I'm dealing with is unfortunately based upon v3.5.0-rc5
with many other patches on top (which add support for this platform.)
However, I'll pick that commit into this tree.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
