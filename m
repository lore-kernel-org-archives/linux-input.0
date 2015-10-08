From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
Date: Thu, 8 Oct 2015 10:05:26 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0F77D6@irsmsx105.ger.corp.intel.com>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
 <1441636583-14188-2-git-send-email-irina.tirdea@intel.com>
 <20151004194632.GA27633@xo-6d-61-c0.localdomain>
 <1F3AC3675D538145B1661F571FE1805F2F0EE716@irsmsx105.ger.corp.intel.com>
 <20151005205752.GA10479@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34505 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbbJHKFb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2015 06:05:31 -0400
In-Reply-To: <20151005205752.GA10479@xo-6d-61-c0.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: 05 October, 2015 23:58
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
> 
> Hi!
> 

Hi!

> > > Subject: Re: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
> > >
> > > On Mon 2015-09-07 17:36:15, Irina Tirdea wrote:
> > > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > > > ---
> > > >  drivers/input/touchscreen/goodix.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > Don't.
> > >
> > > Yes, we sometimes sort includes... to avoid patch rejects.
> > >
> > > This is guaranteed to cause rejects.
> > >
> > > If we do sort them, we use "longest-first" usually.
> > >
> >
> > When using random order, I've been told by reviewers that my ordering
> > is wrong [1], but I could not figure out what the "right" ordering is in order to apply.
> > I did not find any mention of how to sort includes in  Documentation/CodingStyle,
> > but I've seen patches in the kernel that fix random ordering by sorting them
> > alphabetically [2].
> 
> Ok, I have seen this more often:
> 
> https://lkml.org/lkml/2009/3/28/99
> 

I see. I wasn't aware of the inverse Xmas tree ordering.

> > However, I do not feel strongly about this so I can drop this patch.
> 
> Well, its really nit picking.
> 

I was thinking of dropping it since there does not seem to be a consensus on how
to order the includes (or even if we should order them).  In this case, I guess it's
up to Dmitry.
I'll use the inverse Xmas tree ordering in next patch set and see if that works for him.

Thanks,
Irina

> 										Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
