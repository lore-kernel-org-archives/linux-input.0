From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and
 clean up maple bus driver (2/3)
Date: Thu, 29 Jan 2009 00:49:30 +0000
Message-ID: <1233190170.6734.36.camel@localhost.localdomain>
References: <1233186456.6734.16.camel@localhost.localdomain>
	 <1233187069.6734.21.camel@localhost.localdomain>
	 <1233187750.6734.27.camel@localhost.localdomain>
	 <200901281944.57894.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mk-filter-2-a-1.mail.uk.tiscali.com ([212.74.100.53]:18742 "EHLO
	mk-filter-2-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752253AbZA2Awr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 19:52:47 -0500
In-Reply-To: <200901281944.57894.vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>

On Wed, 2009-01-28 at 19:44 -0500, Mike Frysinger wrote:
> On Wednesday 28 January 2009 19:09:10 Adrian McMenamin wrote:
> > +static struct maple_driver vmu_flash_driver = {
> > +	.function =	MAPLE_FUNC_MEMCARD,
> > +	.drv = {
> > +		.name =		"Dreamcast_visual_memory",
> 
> i thought there was like a 16byte limit or something on this ?


Don't think so, it's just a const char* isn't it?

