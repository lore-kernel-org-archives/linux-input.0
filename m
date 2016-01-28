From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] input: keyboard: cap11xx: Add missing of_node_put
Date: Thu, 28 Jan 2016 10:16:39 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1601281014320.2516@hadrien>
References: <20160125153121.GA21093@amitoj-Inspiron-3542> <20160127234858.GI28687@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19444 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755043AbcA1JRQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2016 04:17:16 -0500
In-Reply-To: <20160127234858.GI28687@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On Wed, 27 Jan 2016, Dmitry Torokhov wrote:

> On Mon, Jan 25, 2016 at 09:01:21PM +0530, Amitoj Kaur Chawla wrote:
> > for_each_child_of_node performs an of_node_get on each iteration, so
> > to break out of the loop an of_node_put is required.
> >
> > Found using Coccinelle. The semantic patch used for this is as follows:
> >
> > // <smpl>
> > @@
> > expression e;
> > local idexpression n;
> > @@
> >
> >  for_each_child_of_node(..., n) {
> >    ... when != of_node_put(n)
> >        when != e = n
> > (
> >    return n;
> > |
> > +  of_node_put(n);
> > ?  return ...;
> > )
> >    ...
> >  }
> > // </smpl
> >
> > Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> > ---
> >  drivers/input/keyboard/cap11xx.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> > index 378db10..27cd7df 100644
> > --- a/drivers/input/keyboard/cap11xx.c
> > +++ b/drivers/input/keyboard/cap11xx.c
> > @@ -304,8 +304,10 @@ static int cap11xx_init_leds(struct device *dev,
> >  		led->cdev.brightness = LED_OFF;
> >
> >  		error = of_property_read_u32(child, "reg", &reg);
> > -		if (error != 0 || reg >= num_leds)
> > -			return -EINVAL;
> > +		if (error != 0 || reg >= num_leds) {
> > +			error = -EINVAL;
> > +			goto putchild;
>
> Instead of jumping to a label I added of_node_put here and also below
> and applied, thank you.

Do you have a general strategy for this?

I asked Arnd Bergmann, and he said that if things were shared and if all
failures later in the function could use the shared label, then one should
use a label.  But I can see that there could be different opinions about
it.  Maybe two instances is not enough for sharing?  Maybe the fact that
the need for this error handling is limited to the loop means that there
should never be sharing?

thanks,
julia

>
> I believe there is another input driver that returns from
> for_each_child_of_node() without dropping reference.
>
> Thanks.
>
> --
> Dmitry
>
