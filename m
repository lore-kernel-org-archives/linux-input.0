From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] sh: maple: add support for Visual Memory Card devices, and make consequential changes to maple input drivers - 2/3 - v5
Date: Mon, 9 Feb 2009 19:11:43 -0500
Message-ID: <200902091911.46383.vapier@gentoo.org>
References: <1234122069.6736.8.camel@localhost.localdomain> <200902091433.57126.vapier@gentoo.org> <1234215716.6756.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:58282 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243AbZBJALs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Feb 2009 19:11:48 -0500
In-Reply-To: <1234215716.6756.18.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Monday 09 February 2009 16:41:56 Adrian McMenamin wrote:
> But the basic point here is that changing the bus code is necessary to
> get the VMU driver (or *any* VMU driver) to work, but changing the bus
> driver also breaks the two existing drivers in mainline that use the
> bus. The breakage in terms of lines to be fixed is small, but it still
> needs to be done 'all at once'.

the bus change and the resulting fallout in those drivers should be 1 
changeset.  if you want to do more work than just transitioning those drivers, 
that should be additional patches that depend on that bus changeset.  that way 
bisection will not break as Paul highlighted.
-mike
