From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Thu, 19 Mar 2015 10:38:34 +0100
Message-ID: <20150319093834.GB18997@amd>
References: <20150207154859.89a7e4e3.cand@gmx.com>
 <1423476481.10695.2.camel@linux-0dmf.site>
 <20150209204414.a4d205be.cand@gmx.com>
 <1423556076.19839.3.camel@linux-0dmf.site>
 <20150316211056.GB11441@amd>
 <alpine.LNX.2.00.1503162236420.25438@pobox.suse.cz>
 <1426756461.3815.3.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426756461.3815.3.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ao2@ao2.it, AndrewD207@aol.com
List-Id: linux-input@vger.kernel.org

On Thu 2015-03-19 10:14:21, Oliver Neukum wrote:
> On Mon, 2015-03-16 at 22:37 +0100, Jiri Kosina wrote:
> > On Mon, 16 Mar 2015, Pavel Machek wrote:
> > 
> > > > > Oliver Neukum <oneukum@suse.de> wrote:
> > > > > 
> > > > > > > +	ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
> > > > > > > +				buf2, sizeof(buf2),
> > > > > > > +				&transfered, USB_CTRL_SET_TIMEOUT);
> > > > > > 
> > > > > > You cannot do this. Even for a single byte DMA on the stack is
> > > > > > wrong. Not on all architectures it works at all and you violate
> > > > > > the DMA constrainsts. You must use kmalloc().
> > > > > 
> > > > > Hi Oliver,
> > > > > 
> > > > > Does this still apply when using hid_hw_output_report?
> > > > 
> > > > Yes. For USB devices hid_hw_output_report() goes to
> > > > usbhid_output_report(). That goes to usb_interrupt_msg(),
> > > > which passes the buffer pointer. It will then be mapped
> > > > for DMA. You must not do that on the stack.
> > > 
> > > Should we have some kind of runtime test for this ...? Because this is
> > > very very easy to get wrong... and I bet we do get it wrong at > 1
> > > place...
> > 
> > Are you sure CONFIG_DMA_API_DEBUG wouldn't warn here?
> 
> As far as I can tell, it will not warn. The problem is not in the
> mapping itself. That is usually legitimate. The problem arises
> because the buffer doesn't have a cacheline of its own. Thus the
> memory corruption happens after the IO operation has started.

Nasty. Would WARN_ON(buffer & CACHELINE_SIZE-1) do at least part of
the trick? Alternatively, could we call ksize() on the object, and
fail if it is not big enough?

Alternatively, we could create "allocate_for_usb" function, and only
take pointers allocated by that function in usb functions. That would
also teach people the problem exists...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
