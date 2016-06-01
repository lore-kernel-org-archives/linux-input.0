From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] Input: ti_am335x_tsc - use variable name for
 sizeof() operator
Date: Wed, 1 Jun 2016 11:35:19 -0700
Message-ID: <20160601183519.GG4114@dtor-ws>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-9-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160531170013.2649-9-afd-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, May 31, 2016 at 12:00:13PM -0500, Andrew F. Davis wrote:
> Fix the code formatting to use the kernel preferred style
> of using the actual variables to determize the size using
> the sizeof() operator.
> 
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 8b3f15c..7953381 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -406,7 +406,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	int err;
>  
>  	/* Allocate memory for device */
> -	ts_dev = kzalloc(sizeof(struct titsc), GFP_KERNEL);
> +	ts_dev = kzalloc(sizeof(*ts_dev), GFP_KERNEL);
>  	input_dev = input_allocate_device();
>  	if (!ts_dev || !input_dev) {
>  		dev_err(&pdev->dev, "failed to allocate memory.\n");
> -- 
> 2.8.3
> 

-- 
Dmitry
