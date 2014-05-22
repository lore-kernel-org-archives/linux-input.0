From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] dt/sparc: Introduce the use of the managed version of
 kzalloc
Date: Fri, 23 May 2014 07:35:47 +0800 (SGT)
Message-ID: <alpine.DEB.2.10.1405230735060.2606@hadrien>
References: <20140522193430.GA16315@himangi-Dell> <20140522194539.GA7708@core.coreip.homeip.net> <alpine.DEB.2.10.1405230700090.2606@hadrien>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:20859
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751247AbaEVXgV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 19:36:21 -0400
In-Reply-To: <alpine.DEB.2.10.1405230700090.2606@hadrien>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Himangi Saraogi <himangi774@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On Fri, 23 May 2014, Julia Lawall wrote:

>
>
> On Thu, 22 May 2014, Dmitry Torokhov wrote:
>
> > Hi Himangi,
> >
> > On Fri, May 23, 2014 at 01:04:30AM +0530, Himangi Saraogi wrote:
> > > This patch moves data allocated using kzalloc to managed data allocated
> > > using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
> > > functions. Also the unnecessary labels are done away with.
> >
> > Please no more partial devm conversions. I am not interested in patches
> > that change only 1 resource to be managed and leaving the rest as is.
> >
> > If you want to do devm conversion please do it if you convert all (or at
> > least majority) of resource handling to managed resources.
>
> Sorry, I don't think we are clear on what is wanted.  Himangi's patches
> convert everything where a devm function is already available (to our
> knowledge).  Do you prefer that new devm functions be introduced?  On the
> one hand, that is perhaps useful from a safety point of view.  On the
> other hand, it could lead to a huge number of rarely used devm functions
> that no one knows about and to a lot of code diversity.  So I don't know
> what is the good solution.

I guess that the concrete problem is of_ioremap?  Since that is a pretty
common function, I guess it could be reasonable to introduce a devm
function for it as well.  Or maybe one already exists and we overlooked
it.

julia
