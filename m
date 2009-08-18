From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
	in driver
Date: Tue, 18 Aug 2009 21:10:02 +0100
Message-ID: <20090818201002.GA32638@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan> <20090302112400.GA2356@khazad-dum.debian.net> <1236164049.3936.17.camel@hughsie-work.lan> <20090304120439.GA31850@khazad-dum.debian.net> <1250625730.2257.11.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41532 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZHRUKW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2009 16:10:22 -0400
Content-Disposition: inline
In-Reply-To: <1250625730.2257.11.camel@hidalgo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Tue, Aug 18, 2009 at 10:02:10PM +0200, Yves-Alexis Perez wrote:

> It seems that this patch is still not in master?

Correct. We can't change the existing semantics without breaking 
existing userspace applications.

> Currently (on debian unstable), input-events reports on my T61:
> 
> KEY_SLEEP for Fn+F4
> KEY_SUSPEND for Fn+F12
>
> which kind-of breaks xfce4-power-manager, where SLEEP and SUSPEND both
> suspend to ram, so I don't have any way to hibernate. Changing xfpm
> doesn't seem like a good idea if the way to go is to use SUSPEND for
> STR, HIBERNATE for STD and SLEEP for either.
> 
> So what's the status for this?

KEY_SLEEP is suspend to RAM, KEY_SUSPEND is suspend to disk. xfpm should 
be changed to match.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
