From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
	in driver
Date: Tue, 18 Aug 2009 21:45:08 +0100
Message-ID: <20090818204508.GA886@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan> <20090302112400.GA2356@khazad-dum.debian.net> <1236164049.3936.17.camel@hughsie-work.lan> <20090304120439.GA31850@khazad-dum.debian.net> <1250625730.2257.11.camel@hidalgo> <20090818201002.GA32638@srcf.ucam.org> <1250627230.2257.15.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51835 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZHRUpY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2009 16:45:24 -0400
Content-Disposition: inline
In-Reply-To: <1250627230.2257.15.camel@hidalgo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Ali Abdallah <aliov@xfce.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-acpi <linux-acpi@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>, linux-input <linux-input@vger.kernel.org>

On Tue, Aug 18, 2009 at 10:27:10PM +0200, Yves-Alexis Perez wrote:
> On mar, 2009-08-18 at 21:10 +0100, Matthew Garrett wrote:
> > 
> > > It seems that this patch is still not in master?
> > 
> > Correct. We can't change the existing semantics without breaking 
> > existing userspace applications.
> 
> Hmh ok, but is it planned?

No. We'd break userspace.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
