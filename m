From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - do not explicitly set evbits in input
 device
Date: Wed, 10 Jun 2015 12:18:10 +0200
Message-ID: <1433931490.5707.18.camel@hadess.net>
References: <20150609185219.GA33366@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150609185219.GA33366@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2015-06-09 at 11:52 -0700, Dmitry Torokhov wrote:
> input_mt_init_slots() will do that for us.

I'm guessing you know what you're doing here, but I couldn't find where
the EV_SYN bit would have been set in the input_mt_init_slots() call
chain.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/goodix.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c 
> b/drivers/input/touchscreen/goodix.c
> index 73ade35..b4d12e2 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -301,10 +301,6 @@ static int goodix_request_input_dev(struct 
> goodix_ts_data *ts, u16 version,
>               return -ENOMEM;
>       }
>  
> -     ts->input_dev->evbit[0] = BIT_MASK(EV_SYN) |
> -                               BIT_MASK(EV_KEY) |
> -                               BIT_MASK(EV_ABS);
> -
>       input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
>                            0, ts->abs_x_max, 0, 0);
>       input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> -- 
> 2.2.0.rc0.207.ga3a616c
> 
> 
