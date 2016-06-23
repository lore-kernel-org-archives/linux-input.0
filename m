From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: wacom_w8001 - Ignore invalid pen data packets
Date: Thu, 23 Jun 2016 11:00:32 -0700
Message-ID: <20160623180032.GK32561@dtor-ws>
References: <1464059067-6244-1-git-send-email-pingc@wacom.com>
 <20160524050435.GB11910@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34044 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbcFWSAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 14:00:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id 66so7270365pfy.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2016 11:00:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160524050435.GB11910@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

On Tue, May 24, 2016 at 03:04:35PM +1000, Peter Hutterer wrote:
> On Mon, May 23, 2016 at 08:04:27PM -0700, Ping Cheng wrote:
> > ThinkPad X60 Tablet PC (pen only device) sometime posts
> > packets that are larger than W8001_PKTLEN_TPCPEN.
> > 
> > Reported-by: Chris J Arges <christopherarges@gmail.com>
> > Tested-by: Chris J Arges <christopherarges@gmail.com>
> > Signed-off-by: Ping Cheng <pingc@wacom.com>
> 
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> 
> Cheers,
>    Peter
> 
> > ---
> >  drivers/input/touchscreen/wacom_w8001.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> > index b1b4127..d5dcda2 100644
> > --- a/drivers/input/touchscreen/wacom_w8001.c
> > +++ b/drivers/input/touchscreen/wacom_w8001.c
> > @@ -339,6 +339,15 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
> >  		w8001->idx = 0;
> >  		parse_multi_touch(w8001);
> >  		break;
> > +
> > +	default:
> > +		/*
> > +		 * ThinkPad X60 Tablet PC (pen only device) sometime sends
> > +		 * invalid data packets that are larger than W8001_PKTLEN_TPCPEN.
> > +		 * Let's start over again.
> > +		 */
> > +		if (!w8001->touch_dev && w8001->idx > W8001_PKTLEN_TPCPEN - 1)
> > +			w8001->idx = 0;
> >  	}
> >  
> >  	return IRQ_HANDLED;
> > -- 
> > 1.9.1
>  

-- 
Dmitry
