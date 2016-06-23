From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: wacom_w8001 - W8001_MAX_LENGTH should be 13
Date: Thu, 23 Jun 2016 11:00:13 -0700
Message-ID: <20160623180013.GJ32561@dtor-ws>
References: <1464059020-6205-1-git-send-email-pingc@wacom.com>
 <20160524050145.GA11910@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35314 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbcFWSAS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 14:00:18 -0400
Received: by mail-pa0-f68.google.com with SMTP id hf6so7049197pac.2
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2016 11:00:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160524050145.GA11910@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

On Tue, May 24, 2016 at 03:01:45PM +1000, Peter Hutterer wrote:
> On Mon, May 23, 2016 at 08:03:40PM -0700, Ping Cheng wrote:
> > Somehow the patch that added two-finger touch support forgot to update
> > W8001_MAX_LENGTH from 11 to 13.
> > 
> > Signed-off-by: Ping Cheng <pingc@wacom.com>
> 
> whoops, I think that was me.
> 
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> 
> Cheers,
>    Peter
> 
> > ---
> >  drivers/input/touchscreen/wacom_w8001.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> > index bab3c6a..b1b4127 100644
> > --- a/drivers/input/touchscreen/wacom_w8001.c
> > +++ b/drivers/input/touchscreen/wacom_w8001.c
> > @@ -27,7 +27,7 @@ MODULE_AUTHOR("Jaya Kumar <jayakumar.lkml@gmail.com>");
> >  MODULE_DESCRIPTION(DRIVER_DESC);
> >  MODULE_LICENSE("GPL");
> >  
> > -#define W8001_MAX_LENGTH	11
> > +#define W8001_MAX_LENGTH	13
> >  #define W8001_LEAD_MASK		0x80
> >  #define W8001_LEAD_BYTE		0x80
> >  #define W8001_TAB_MASK		0x40
> > -- 
> > 1.9.1
> > 

-- 
Dmitry
