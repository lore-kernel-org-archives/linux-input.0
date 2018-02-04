From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iio/pressure: Delete an error message for a failed
 memory allocation in hid_press_probe()
Date: Sun, 4 Feb 2018 10:58:39 +0000
Message-ID: <20180204105839.606f8d2e@archlinux>
References: <e7dfe444-616a-e156-31d5-8ed626434d1f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e7dfe444-616a-e156-31d5-8ed626434d1f-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archana Patni <archana.patni-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 29 Jan 2018 22:04:11 +0100
SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> wrote:

> From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Date: Mon, 29 Jan 2018 21:55:08 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Whilst the error message doesn't add a lot, it does add some information
over a simple memory copy failed error.

Hence I think we should keep it.

Jonathan

> ---
>  drivers/iio/pressure/hid-sensor-press.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index 4c437918f1d2..9de7590d50b0 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -280,10 +280,8 @@ static int hid_press_probe(struct platform_device *pdev)
>  
>  	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
>  				      GFP_KERNEL);
> -	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> +	if (!indio_dev->channels)
>  		return -ENOMEM;
> -	}
>  
>  	ret = press_parse_report(pdev, hsdev,
>  				 (struct iio_chan_spec *)indio_dev->channels,
