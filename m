From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Thu, 19 Mar 2015 10:14:21 +0100
Message-ID: <1426756461.3815.3.camel@suse.de>
References: <20150207154859.89a7e4e3.cand@gmx.com>
	 <1423476481.10695.2.camel@linux-0dmf.site>
	 <20150209204414.a4d205be.cand@gmx.com>
	 <1423556076.19839.3.camel@linux-0dmf.site> <20150316211056.GB11441@amd>
	 <alpine.LNX.2.00.1503162236420.25438@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45305 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbbCSJO5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 05:14:57 -0400
In-Reply-To: <alpine.LNX.2.00.1503162236420.25438@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, Lauri Kasanen <cand@gmx.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ao2@ao2.it, AndrewD207@aol.com

On Mon, 2015-03-16 at 22:37 +0100, Jiri Kosina wrote:
> On Mon, 16 Mar 2015, Pavel Machek wrote:
> 
> > > > Oliver Neukum <oneukum@suse.de> wrote:
> > > > 
> > > > > > +	ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
> > > > > > +				buf2, sizeof(buf2),
> > > > > > +				&transfered, USB_CTRL_SET_TIMEOUT);
> > > > > 
> > > > > You cannot do this. Even for a single byte DMA on the stack is
> > > > > wrong. Not on all architectures it works at all and you violate
> > > > > the DMA constrainsts. You must use kmalloc().
> > > > 
> > > > Hi Oliver,
> > > > 
> > > > Does this still apply when using hid_hw_output_report?
> > > 
> > > Yes. For USB devices hid_hw_output_report() goes to
> > > usbhid_output_report(). That goes to usb_interrupt_msg(),
> > > which passes the buffer pointer. It will then be mapped
> > > for DMA. You must not do that on the stack.
> > 
> > Should we have some kind of runtime test for this ...? Because this is
> > very very easy to get wrong... and I bet we do get it wrong at > 1
> > place...
> 
> Are you sure CONFIG_DMA_API_DEBUG wouldn't warn here?

As far as I can tell, it will not warn. The problem is not in the
mapping itself. That is usually legitimate. The problem arises
because the buffer doesn't have a cacheline of its own. Thus the
memory corruption happens after the IO operation has started.

	Regards
		Oliver



