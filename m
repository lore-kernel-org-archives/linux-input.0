From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
 in driver
Date: Wed, 26 Aug 2009 19:51:11 -0300
Message-ID: <20090826225111.GC23973@khazad-dum.debian.net>
References: <1235992429.3858.58.camel@hughsie-work.lan>
 <20090302112400.GA2356@khazad-dum.debian.net>
 <1236164049.3936.17.camel@hughsie-work.lan>
 <20090304120439.GA31850@khazad-dum.debian.net>
 <1250625730.2257.11.camel@hidalgo>
 <20090818201002.GA32638@srcf.ucam.org>
 <1251286574.32399.3.camel@miria>
 <20090826134349.GA12404@srcf.ucam.org>
 <1251309161.10837.6.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55444 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754186AbZHZWvO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2009 18:51:14 -0400
Content-Disposition: inline
In-Reply-To: <1251309161.10837.6.camel@hidalgo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Matthew Garrett <mjg@redhat.com>, Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>, aliov@xfce.org

On Wed, 26 Aug 2009, Yves-Alexis Perez wrote:
> On mer, 2009-08-26 at 14:43 +0100, Matthew Garrett wrote:
> > On Wed, Aug 26, 2009 at 01:36:14PM +0200, Yves-Alexis Perez wrote:
> > > #define XF86XK_Suspend    0x1008FFA7   /* Sleep to RAM                */        
> > > #define XF86XK_Hibernate  0x1008FFA8   /* Sleep to disk               */
> > > 
> > > So (some) userspace seems to have switched already?
> > 
> > Adding those keysyms was, with hindsight, an error.
> 
> Ok, so every userland app which began the transition should step back
> until a correct migration plan is set up?

IMHO it would be both easier and faster to deploy a proper migration plan
and keep going.  Nobody said the names used by X.org keysyms have to agree
with the ones used by input devices, for example... and a mapping table is
already used anyway.

So, userspace can use the X keysyms like the above. There's nothing wrong
with it.  But the correct mapping for kernel input events to those keysyms
is AND WILL REMAIN:

KEY_SLEEP -> XF86XK_Suspend
KEY_SUSPEND -> XF86XK_Hibernate

If people want to define two new input events, say KEY_SUSPENDTORAM and
KEY_SUSPENDTODISK, start migrating the kernel drivers to use these two, and
after some time with no use of KEY_SLEEP in the kernel, reclaim it to
be a generic "sleep the system in some unspecified way", I'd be fine with
it.

So, you'd have:
KEY_SLEEP -> XF86XK_Suspend
KEY_SUSPENDTORAM -> XF86XK_Suspend
KEY_SUSPEND -> XF86XK_Hibernate
KEY_SUSPENDTODISK -> XF86XK_Hibernate

I'd guess the only thing that could make us break that ABI the way people
wanted us to (i.e. change the meaning of KEY_SUSPEND and KEY_SLEEP, and add
a new KEY_HIBERNATE), is a proof that we got the USB HID table wrong and
that USB keyboards are doing the wrong thing because of it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
