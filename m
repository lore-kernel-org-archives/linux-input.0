From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/touchscreen: Fix a missing check on
 regmap_bulk_read
Date: Wed, 26 Dec 2018 12:08:38 -0800
Message-ID: <20181226200838.GC5999@dtor-ws>
References: <20181224183719.22211-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181224183719.22211-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, Dec 24, 2018 at 12:37:19PM -0600, Aditya Pakki wrote:
> regmap_bulk_read() can return a non zero value on failure. The fix
> checks if the function call succeeded before calling mod_timer.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/input/touchscreen/ad7879.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 6bad23ee47a1..735cb4c0d913 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -247,11 +247,12 @@ static void ad7879_timer(struct timer_list *t)
>  static irqreturn_t ad7879_irq(int irq, void *handle)
>  {
>  	struct ad7879 *ts = handle;
> +	int ret;
>  
> -	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
> -			 ts->conversion_data, AD7879_NR_SENSE);
> +	ret = regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
> +				ts->conversion_data, AD7879_NR_SENSE);

I'd probably say:

	error = regmap_bulk_read(...);
	if (error)
		dev_err_ratelimited(...);
	else if (!ad7879_report(ts))
		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);

Were the failures observed in real life or it is some kind of class
project?

>  
> -	if (!ad7879_report(ts))
> +	if (!ret && !ad7879_report(ts))
>  		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
>  
>  	return IRQ_HANDLED;
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
