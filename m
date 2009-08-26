From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
	in driver
Date: Wed, 26 Aug 2009 13:36:14 +0200
Message-ID: <1251286574.32399.3.camel@miria>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090302112400.GA2356@khazad-dum.debian.net>
	 <1236164049.3936.17.camel@hughsie-work.lan>
	 <20090304120439.GA31850@khazad-dum.debian.net>
	 <1250625730.2257.11.camel@hidalgo>  <20090818201002.GA32638@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:39512 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbZHZLlo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2009 07:41:44 -0400
In-Reply-To: <20090818201002.GA32638@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On mar, 2009-08-18 at 21:10 +0100, Matthew Garrett wrote:
> > So what's the status for this?
> 
> KEY_SLEEP is suspend to RAM, KEY_SUSPEND is suspend to disk. xfpm should 
> be changed to match.

Hmh, there's something weird.

In /usr/include/X11/XF86keysym.h we can see:

#define XF86XK_Suspend    0x1008FFA7   /* Sleep to RAM                */        
#define XF86XK_Hibernate  0x1008FFA8   /* Sleep to disk               */

So (some) userspace seems to have switched already?

Cheers,
-- 
Yves-Alexis

