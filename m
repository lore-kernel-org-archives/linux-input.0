From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 16/19] mfd / input: ti_am335x_tsc: rename device from tsc
 to TI-tsc
Date: Tue, 4 Jun 2013 09:50:35 -0700
Message-ID: <20130604165035.GE26400@core.coreip.homeip.net>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-17-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369681926-22185-17-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, May 27, 2013 at 09:12:03PM +0200, Sebastian Andrzej Siewior wrote:
> tsc is a very generic name. This patch adds a TI prefix to make it a
> little less generic.
> While here add an alias so the driver is loaded on demand.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c |    3 ++-
>  drivers/mfd/ti_am335x_tscadc.c            |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 96accaa..2921163 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -543,11 +543,12 @@ static struct platform_driver ti_tsc_driver = {
>  	.probe	= titsc_probe,
>  	.remove	= titsc_remove,
>  	.driver	= {
> -		.name   = "tsc",
> +		.name   = "TI-tsc",

Still quite generic... Why not call it "TI-am335x-tsc"?

Thanks.

-- 
Dmitry
