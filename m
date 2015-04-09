From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH V1 1/2] input: misc: da9063: OnKey driver
Date: Thu, 09 Apr 2015 14:01:42 +0200
Message-ID: <1428580902.14000.48.camel@x220>
References: <cover.1428504804.git.stwiss.opensource@diasemi.com>
	 <0219212ab4e2b01256f2dac92d9a0d848c44197a.1428504804.git.stwiss.opensource@diasemi.com>
	 <1428569273.14000.17.camel@x220>
	 <6ED8E3B22081A4459DAC7699F3695FB7014B2139E2@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lb2-smtp-cloud2.xs4all.net ([194.109.24.25]:47860 "EHLO
	lb2-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755071AbbDIMBr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Apr 2015 08:01:47 -0400
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B2139E2@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

On Thu, 2015-04-09 at 10:12 +0000, Opensource [Steve Twiss] wrote:
> On 09 April 2015 09:48 Paul Bolle wrote:
> 
> > > This patch is dependent on PATCH V1 2/2
> >     This patch is dependent on PATCH V1 1/2
> > Which makes it all rather confusing.
> 
> It is a bit circular, I'll take that out for the next patch
> 
> > > +++ b/drivers/input/misc/da9063-onkey.c
> > > @@ -0,0 +1,227 @@
> > > +/* da9063-onkey.c - Onkey device driver for DA9063
> > > + * Copyright (C) 2013  Dialog Semiconductor Ltd.
> > > + *
> > > + * This library is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU Library General Public
> > > + * License as published by the Free Software Foundation; either
> > > + * version 2 of the License, or (at your option) any later version.
> > > + *
> > > + * This library is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > GNU
> > > + * Library General Public License for more details.
> > > + */
> > 
> > This states the license is GPL v2 or later.
> > 
> > > +MODULE_LICENSE("GPL v2");
> > 
> > And (according to include/linux/module.h) this states the license is
> > (just) GPL v2.
> 
> Ah, I'll fix that for the future.

My reading comprehension is declining. Because I only now noticed that
the comment at the top of this file states the license is LGPL v2 or
later (note the L).

Grepping the tree for "Library General" gave over 100 hits, a few of
them even in drivers/, so I suppose LPGL v2 is fine for the kernel. It
_feels_ a bit odd to use it for a driver, but that might just be me.


Paul Bolle

