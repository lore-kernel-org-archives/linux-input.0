From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH] USB: gtco: remove unnecessary variable assignments
Date: Thu, 15 Jun 2017 21:25:18 +0200
Message-ID: <20170615192517.4giikw5z7etu56a6@beacon.debie>
References: <20170615015029.GA5601@embeddedgus>
 <1497502848.14396.2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:33065 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbdFOTZ3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 15:25:29 -0400
Content-Disposition: inline
In-Reply-To: <1497502848.14396.2.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Joe, Gustavo,

On Wed, Jun 14, 2017 at 10:00:48PM -0700, Joe Perches wrote:
> On Wed, 2017-06-14 at 20:50 -0500, Gustavo A. R. Silva wrote:
> > Remove unnecessary variable assignments.
> > Variable _val_ is overwritten before the value stored in it can be used.
> > 
> > Addresses-Coverity-ID: 1397695
> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> > ---
> >  drivers/input/tablet/gtco.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
> > index b796e89..d9de13c 100644
> > --- a/drivers/input/tablet/gtco.c
> > +++ b/drivers/input/tablet/gtco.c
> > @@ -652,8 +652,6 @@ static void gtco_urb_callback(struct urb *urbinfo)
> >  		switch (device->buffer[0]) {
> >  		case 5:
> >  			/* Pressure is 9 bits */
> > -			val = ((u16)(device->buffer[8]) << 1);
> > -			val |= (u16)(device->buffer[7] >> 7);
> >  			input_report_abs(inputdev, ABS_PRESSURE,
> >  					 device->buffer[8]);
> 
> Perhaps more likely to be
> 
> 			input_report_abs(inputdev, ABS_PRESSURE, val);

Probably that was the original intention but changing it that way now
would give a shift of factor 2 to userspace.

But if the 2 lines are deleted, I would update the comment above it so it
is clear the lowest significant bit in buffer[7] is not included in the
report call.

Kind regards,
Ulrik
