From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - Remove unnecessary byte_offset
 check
Date: Mon, 9 Oct 2017 10:38:55 -0700
Message-ID: <20171009173855.GA19253@dtor-ws>
References: <1507488258-22409-1-git-send-email-chris.gekas@gmail.com>
 <20171008194116.GB29090@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33841 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754287AbdJIRi7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Oct 2017 13:38:59 -0400
Content-Disposition: inline
In-Reply-To: <20171008194116.GB29090@lava.h.shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Christos Gkekas <chris.gekas@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 08, 2017 at 08:41:16PM +0100, Nick Dyer wrote:
> On Sun, Oct 08, 2017 at 07:44:18PM +0100, Christos Gkekas wrote:
> > Variable byte_offset is unsigned so checking whether it is greater or
> > equal to zero is redundant.
> > 
> > Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
> 
> Yep - looks sensible to me.
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>

I believe this has been discussed before and Linus told us to keep the
such checks as is: they neatly document the ranges of values, safe in
case we ever change the type of the variables, and do not cost us
anything at execution time.


> 
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 7659bc4..baafaed 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -1356,7 +1356,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
> >  
> >  			byte_offset = reg + i - cfg_start_ofs;
> >  
> > -			if (byte_offset >= 0 && byte_offset < config_mem_size) {
> > +			if (byte_offset < config_mem_size) {
> >  				*(config_mem + byte_offset) = val;
> >  			} else {
> >  				dev_err(dev, "Bad object: reg:%d, T%d, ofs=%d\n",
> > -- 
> > 2.7.4
> > 

Thanks.

-- 
Dmitry
