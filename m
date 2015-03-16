From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Mon, 16 Mar 2015 22:37:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503162236420.25438@pobox.suse.cz>
References: <20150207154859.89a7e4e3.cand@gmx.com> <1423476481.10695.2.camel@linux-0dmf.site> <20150209204414.a4d205be.cand@gmx.com> <1423556076.19839.3.camel@linux-0dmf.site> <20150316211056.GB11441@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42357 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964950AbbCPVhV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 17:37:21 -0400
In-Reply-To: <20150316211056.GB11441@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Oliver Neukum <oneukum@suse.de>, Lauri Kasanen <cand@gmx.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ao2@ao2.it, AndrewD207@aol.com

On Mon, 16 Mar 2015, Pavel Machek wrote:

> > > Oliver Neukum <oneukum@suse.de> wrote:
> > > 
> > > > > +	ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
> > > > > +				buf2, sizeof(buf2),
> > > > > +				&transfered, USB_CTRL_SET_TIMEOUT);
> > > > 
> > > > You cannot do this. Even for a single byte DMA on the stack is
> > > > wrong. Not on all architectures it works at all and you violate
> > > > the DMA constrainsts. You must use kmalloc().
> > > 
> > > Hi Oliver,
> > > 
> > > Does this still apply when using hid_hw_output_report?
> > 
> > Yes. For USB devices hid_hw_output_report() goes to
> > usbhid_output_report(). That goes to usb_interrupt_msg(),
> > which passes the buffer pointer. It will then be mapped
> > for DMA. You must not do that on the stack.
> 
> Should we have some kind of runtime test for this ...? Because this is
> very very easy to get wrong... and I bet we do get it wrong at > 1
> place...

Are you sure CONFIG_DMA_API_DEBUG wouldn't warn here?

-- 
Jiri Kosina
SUSE Labs
