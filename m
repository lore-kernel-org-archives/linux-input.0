From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: goodix - do not explicitly set evbits in input
 device
Date: Wed, 10 Jun 2015 10:39:21 -0400
Message-ID: <20150610143910.GB27326@mail.corp.redhat.com>
References: <20150609185219.GA33366@dtor-ws>
 <1433931490.5707.18.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133AbbFJOjY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2015 10:39:24 -0400
Content-Disposition: inline
In-Reply-To: <1433931490.5707.18.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 10 2015 or thereabouts, Bastien Nocera wrote:
> On Tue, 2015-06-09 at 11:52 -0700, Dmitry Torokhov wrote:
> > input_mt_init_slots() will do that for us.
> 
> I'm guessing you know what you're doing here, but I couldn't find where
> the EV_SYN bit would have been set in the input_mt_init_slots() call
> chain.

input_register_device() sets EV_SYN bit for us (it is a mandatory field
for input).

> 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/touchscreen/goodix.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/goodix.c 
> > b/drivers/input/touchscreen/goodix.c
> > index 73ade35..b4d12e2 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -301,10 +301,6 @@ static int goodix_request_input_dev(struct 
> > goodix_ts_data *ts, u16 version,
> >               return -ENOMEM;
> >       }
> >  
> > -     ts->input_dev->evbit[0] = BIT_MASK(EV_SYN) |
> > -                               BIT_MASK(EV_KEY) |
> > -                               BIT_MASK(EV_ABS);
> > -

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> >       input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> >                            0, ts->abs_x_max, 0, 0);
> >       input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> > -- 
> > 2.2.0.rc0.207.ga3a616c
> > 
> > 
