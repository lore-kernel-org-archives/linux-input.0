From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: suspend / hibernate nomenclature
Date: Sun, 8 Mar 2009 16:07:50 -0700
Message-ID: <20090308230741.GA5357@dtor-d630.eng.vmware.com>
References: <1235992429.3858.58.camel@hughsie-work.lan> <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com> <20090308144145.GB26233@srcf.ucam.org> <200903082156.46219.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:39879 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbZCHXIB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Mar 2009 19:08:01 -0400
Content-Disposition: inline
In-Reply-To: <200903082156.46219.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Richard Hughes <hughsient@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Sun, Mar 08, 2009 at 09:56:45PM +0100, Rafael J. Wysocki wrote:
> On Sunday 08 March 2009, Matthew Garrett wrote:
> > On Sun, Mar 08, 2009 at 08:45:59AM +0000, Richard Hughes wrote:
> > > On Sat, Mar 7, 2009 at 8:39 PM, Matthew Garrett <mjg@redhat.com> wrote:
> > > > We don't have to at all - as far as I've been able to tell, the kernel
> > > > is utterly consistent in its current usage. The only drivers that emit
> > > > KEY_SLEEP are either embedded-specific (where it's clearly suspend to
> > > > RAM and not hibernate), the ACPI driver (where usage in other operating
> > > > systems is consistent with it being suspent to RAM) and the panasonic
> > > > and thinkpad drivers which use it consistently. If there's any
> > > > confusion, it's over the fact that KEY_SUSPEND is is used for suspend to
> > > > RAM in a (smaller) number of places.
> > > 
> > > The fact that we're mapping x->y and y->x is the reason people keep
> > > getting it wrong.
> > 
> > Sure, doing things differently would have made sense several years ago 
> > when nobody was relying on this behaviour. We don't have that option now 
> > - making this change will break things, and we've got no idea how much 
> > it'll break.
> 
> Which is a good enough reason to avoid it.
> 
> Alternatively, we can add completely new definitions _along_ _with_ the old
> ones, mark the old ones as obsolete (after some time) and try to make the
> user space start using the new ones only (that may be difficult, though).
> 
> I said I liked the names, but I didn't realize that changing them would break
> things.
> 

I don't think we want to break anything if we can help it. The problem
with Richard's patch is that it changes meaning of KEY_SUSPEND from STD
to STR. I would prefer if we could do the following:

- KEY_SLEEP - leave the keycode, the action should be the default
system state defined by either platform or user. I expect that the vast
majority of system have default state similar to S3 so there should not
be anysurprises.

- KEY_SUSPEND - provide better comment for its intended usage and maybe
add KEY_HIBERNATE alias.

- KEY_SUSPEND2RAM - add a new definition.

Do you think this would this work?

I intend to back out the patch in question for the time being.

Thanks.

-- 
Dmitry
