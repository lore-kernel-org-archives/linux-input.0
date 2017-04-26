From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: touchscreen: mxs-lradc: || vs && typos
Date: Wed, 26 Apr 2017 14:12:31 -0700
Message-ID: <20170426211231.GA34586@dtor-ws>
References: <20170426210431.mqze5ehrijm7l2ey@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34471 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030213AbdDZVMe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Apr 2017 17:12:34 -0400
Content-Disposition: inline
In-Reply-To: <20170426210431.mqze5ehrijm7l2ey@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org

On Thu, Apr 27, 2017 at 12:04:31AM +0300, Dan Carpenter wrote:
> These tests are meaningless as is because "adapt" can't possibly be both
> less than 1 and greater than 32.
> 
> Fixes: d81ca730e3e4 ("input: touchscreen: mxs-lradc: Add support for touchscreen")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Lee, could you take this one?

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

Thanks.

-- 
Dmitry
