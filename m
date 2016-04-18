From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] input: twl6040-vibra: add handler to unregister
 input if module is removed
Date: Mon, 18 Apr 2016 14:12:57 -0700
Message-ID: <20160418211257.GA1006@dtor-ws>
References: <cover.1461009340.git.hns@goldelico.com>
 <89f53877b821049c789256dd1b0c0b1dbb604de9.1461009340.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35463 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbcDRVNC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 17:13:02 -0400
Content-Disposition: inline
In-Reply-To: <89f53877b821049c789256dd1b0c0b1dbb604de9.1461009340.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org

On Mon, Apr 18, 2016 at 09:55:38PM +0200, H. Nikolaus Schaller wrote:
> commit 1f9e1470ab34 ("Input: twl6040-vibra - use devm functions")
> 
> converted everything to devm but we still need to call
> input_unregister_device(info->input_dev)

No, this is not needed, because devm-managed input devices will be
unregistered automatically.

> 
> Solution: add back twl6040_vibra_remove to call input_unregister_device
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/input/misc/twl6040-vibra.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
> index 7221a00..1e9902d 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -384,8 +384,18 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int twl6040_vibra_remove(struct platform_device *pdev)
> +{
> +	struct vibra_info *info = platform_get_drvdata(pdev);
> +
> +	input_unregister_device(info->input_dev);
> +
> +	return 0;
> +	}
> +
>  static struct platform_driver twl6040_vibra_driver = {
>  	.probe		= twl6040_vibra_probe,
> +	.remove		= twl6040_vibra_remove,
>  	.driver		= {
>  		.name	= "twl6040-vibra",
>  		.pm	= &twl6040_vibra_pm_ops,
> -- 
> 2.7.3
> 

Thanks.

-- 
Dmitry
