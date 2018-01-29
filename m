From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 5/8] Input: mms114 - use lower case for hexadecimal
 values
Date: Tue, 30 Jan 2018 08:29:23 +0900
Message-ID: <20180129232923.GW7575@gangnam.samsung>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p29c39450d723f7d2085fc10a74a74e53c@epcas2p2.samsung.com>
        <20180129113323.18961-6-andi.shyti@samsung.com>
        <20180129185631.wvgl3il6tu6nk7ew@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29213 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeA2X31 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Jan 2018 18:29:27 -0500
Content-disposition: inline
In-reply-to: <20180129185631.wvgl3il6tu6nk7ew@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>

Hi Dmitry,

On Mon, Jan 29, 2018 at 10:56:31AM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 29, 2018 at 08:33:20PM +0900, Andi Shyti wrote:
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> 
> But why?

I think this patch is trivial and the subject itself is quite
self-explanatory and the commit message would be a copy-paste of
it.

OK, if you want I will add "some comment".

Andi

> > ---
> >  drivers/input/touchscreen/mms114.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> > index 11dba8bb48e3..fdf23bc416af 100644
> > --- a/drivers/input/touchscreen/mms114.c
> > +++ b/drivers/input/touchscreen/mms114.c
> > @@ -20,7 +20,7 @@
> >  
> >  /* Write only registers */
> >  #define MMS114_MODE_CONTROL		0x01
> > -#define MMS114_OPERATION_MODE_MASK	0xE
> > +#define MMS114_OPERATION_MODE_MASK	0xe
> >  #define MMS114_ACTIVE			(1 << 1)
> >  
> >  #define MMS114_XY_RESOLUTION_H		0x02
> > @@ -30,12 +30,12 @@
> >  #define MMS114_MOVING_THRESHOLD		0x06
> >  
> >  /* Read only registers */
> > -#define MMS114_PACKET_SIZE		0x0F
> > +#define MMS114_PACKET_SIZE		0x0f
> >  #define MMS114_INFOMATION		0x10
> > -#define MMS114_TSP_REV			0xF0
> > +#define MMS114_TSP_REV			0xf0
> >  
> > -#define MMS152_FW_REV			0xE1
> > -#define MMS152_COMPAT_GROUP		0xF2
> > +#define MMS152_FW_REV			0xe1
> > +#define MMS152_COMPAT_GROUP		0xf2
> >  
> >  /* 200ms needs after power on */
> >  #define MMS114_POWERON_DELAY		200
> > -- 
> > 2.15.1
> > 
> 
> -- 
> Dmitry
> 
