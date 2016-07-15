From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input: touchscreen: ts4800-ts: add missing
 of_node_put after calling of_parse_phandle
Date: Fri, 15 Jul 2016 09:32:46 -0700
Message-ID: <20160715163246.GB27847@dtor-ws>
References: <1468575125-24920-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34484 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcGOQct (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 12:32:49 -0400
Received: by mail-pa0-f66.google.com with SMTP id hh10so6365302pac.1
        for <linux-input@vger.kernel.org>; Fri, 15 Jul 2016 09:32:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468575125-24920-1-git-send-email-peter.chen@nxp.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>, Damien Riegel <damien.riegel@savoirfairelinux.com>

On Fri, Jul 15, 2016 at 05:32:05PM +0800, Peter Chen wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
> 
> Cc: linux-input@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/input/touchscreen/ts4800-ts.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/ts4800-ts.c b/drivers/input/touchscreen/ts4800-ts.c
> index 3c3dd78..8f27ad8 100644
> --- a/drivers/input/touchscreen/ts4800-ts.c
> +++ b/drivers/input/touchscreen/ts4800-ts.c
> @@ -135,6 +135,7 @@ static int ts4800_parse_dt(struct platform_device *pdev,
>  	ts->bit = BIT(bit);
>  
>  	ts->regmap = syscon_node_to_regmap(syscon_np);
> +	of_node_put(syscon_np);

This does not help with the other 2 "returns" above which also leak the
reference count. I'll switch the code around and apply.

>  	if (IS_ERR(ts->regmap)) {
>  		dev_err(dev, "cannot get parent's regmap\n");
>  		return PTR_ERR(ts->regmap);
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
