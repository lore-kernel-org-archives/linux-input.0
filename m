From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Mon, 16 Mar 2015 22:10:56 +0100
Message-ID: <20150316211056.GB11441@amd>
References: <20150207154859.89a7e4e3.cand@gmx.com>
 <1423476481.10695.2.camel@linux-0dmf.site>
 <20150209204414.a4d205be.cand@gmx.com>
 <1423556076.19839.3.camel@linux-0dmf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42684 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932913AbbCPVK7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 17:10:59 -0400
Content-Disposition: inline
In-Reply-To: <1423556076.19839.3.camel@linux-0dmf.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Lauri Kasanen <cand@gmx.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ao2@ao2.it, AndrewD207@aol.com

On Tue 2015-02-10 09:14:36, Oliver Neukum wrote:
> On Mon, 2015-02-09 at 20:44 +0200, Lauri Kasanen wrote:
> > On Mon, 09 Feb 2015 11:08:01 +0100
> > Oliver Neukum <oneukum@suse.de> wrote:
> > 
> > > > +	ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
> > > > +				buf2, sizeof(buf2),
> > > > +				&transfered, USB_CTRL_SET_TIMEOUT);
> > > 
> > > You cannot do this. Even for a single byte DMA on the stack is
> > > wrong. Not on all architectures it works at all and you violate
> > > the DMA constrainsts. You must use kmalloc().
> > 
> > Hi Oliver,
> > 
> > Does this still apply when using hid_hw_output_report?
> 
> Yes. For USB devices hid_hw_output_report() goes to
> usbhid_output_report(). That goes to usb_interrupt_msg(),
> which passes the buffer pointer. It will then be mapped
> for DMA. You must not do that on the stack.

Should we have some kind of runtime test for this ...? Because this is
very very easy to get wrong... and I bet we do get it wrong at > 1
place...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
