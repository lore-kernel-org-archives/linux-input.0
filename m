From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 36/38] input: tsc2007 - drop the driver_module assignment
 in iio interface.
Date: Mon, 29 May 2017 19:41:04 -0700
Message-ID: <20170530024104.GA32841@dtor-ws>
References: <20170529155154.22580-1-jic23@kernel.org>
 <20170529155154.22580-37-jic23@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170529155154.22580-37-jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, May 29, 2017 at 04:51:52PM +0100, Jonathan Cameron wrote:
> This is now handled via some macro magic during the register.  The
> field in iio_info will be removed shortly.
> 
> Cc: Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

It sounds the patch needs something from your tree so please merge it
though there.

Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/input/touchscreen/tsc2007_iio.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2007_iio.c b/drivers/input/touchscreen/tsc2007_iio.c
> index 27b25a9fce83..e27a956f5f2b 100644
> --- a/drivers/input/touchscreen/tsc2007_iio.c
> +++ b/drivers/input/touchscreen/tsc2007_iio.c
> @@ -104,7 +104,6 @@ static int tsc2007_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info tsc2007_iio_info = {
>  	.read_raw = tsc2007_read_raw,
> -	.driver_module = THIS_MODULE,
>  };
>  
>  int tsc2007_iio_configure(struct tsc2007 *ts)
> -- 
> 2.13.0
> 

-- 
Dmitry
