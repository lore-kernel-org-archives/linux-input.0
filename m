From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] input: touchscreen: mxs-lradc: || vs && typos
Date: Thu, 27 Apr 2017 09:03:54 +0100
Message-ID: <20170427080354.ltqoisfnnnrdki24@dell>
References: <20170426210431.mqze5ehrijm7l2ey@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170426210431.mqze5ehrijm7l2ey@mwanda>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 27 Apr 2017, Dan Carpenter wrote:

> These tests are meaningless as is because "adapt" can't possibly be both
> less than 1 and greater than 32.
> 
> Fixes: d81ca730e3e4 ("input: touchscreen: mxs-lradc: Add support for touchscreen")
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Applied, thanks.

> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index ff9cda29d9a0..369ef83234ef 100644
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -642,7 +642,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(node, "fsl,ave-ctrl", &adapt)) {
>  		ts->over_sample_cnt = 4;
>  	} else {
> -		if (adapt >= 1 || adapt <= 32) {
> +		if (adapt >= 1 && adapt <= 32) {
>  			ts->over_sample_cnt = adapt;
>  		} else {
>  			dev_err(ts->dev, "Invalid sample count (%u)\n",
> @@ -654,7 +654,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(node, "fsl,ave-delay", &adapt)) {
>  		ts->over_sample_delay = 2;
>  	} else {
> -		if (adapt >= 2 || adapt <= LRADC_DELAY_DELAY_MASK + 1) {
> +		if (adapt >= 2 && adapt <= LRADC_DELAY_DELAY_MASK + 1) {
>  			ts->over_sample_delay = adapt;
>  		} else {
>  			dev_err(ts->dev, "Invalid sample delay (%u)\n",
> @@ -666,7 +666,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(node, "fsl,settling", &adapt)) {
>  		ts->settling_delay = 10;
>  	} else {
> -		if (adapt >= 1 || adapt <= LRADC_DELAY_DELAY_MASK) {
> +		if (adapt >= 1 && adapt <= LRADC_DELAY_DELAY_MASK) {
>  			ts->settling_delay = adapt;
>  		} else {
>  			dev_err(ts->dev, "Invalid settling delay (%u)\n",

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
