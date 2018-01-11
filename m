From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: snvs_pwrkey: add clock support
Date: Wed, 10 Jan 2018 16:23:22 -0800
Message-ID: <20180111002322.jc6xgrjl27zclecv@dtor-ws>
References: <1515575422-8843-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46710 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbeAKAXZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 Jan 2018 19:23:25 -0500
Content-Disposition: inline
In-Reply-To: <1515575422-8843-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: keescook@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Jan 10, 2018 at 05:10:22PM +0800, Anson Huang wrote:
> Add optional clock enable/disable support for the SNVS pwrkey,
> which is required for accessing SNVS block on some i.MX SoCs
> like i.MX7D.
> 
> If SNVS clock is required, it needs to be passed from dtb file
> and SNVS pwrkey driver will enable it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 53c768b..51642aa 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> @@ -43,6 +44,7 @@ struct pwrkey_drv_data {
>  	int wakeup;
>  	struct timer_list check_timer;
>  	struct input_dev *input;
> +	struct clk *clk;
>  };
>  
>  static void imx_imx_snvs_check_for_events(struct timer_list *t)
> @@ -129,6 +131,18 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pdata->clk)) {
> +		pdata->clk = NULL;

This is not right, as you do not handle the deferrals properly, not
differentiate between missing clock and other fatal errors.

Also, it looks like we need something like devm_clk_get_optional() for
your use case. Have you looked into adding such API?

> +	} else {
> +		error = clk_prepare_enable(pdata->clk);
> +		if (error) {
> +			dev_err(&pdev->dev,
> +				"Could not prepare or enable the snvs clock\n");
> +			return error;
> +		}
> +	}
> +
>  	regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_DEP_EN, SNVS_LPCR_DEP_EN);
>  
>  	/* clear the unexpected interrupt before driver ready */
> @@ -139,7 +153,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	input = devm_input_allocate_device(&pdev->dev);
>  	if (!input) {
>  		dev_err(&pdev->dev, "failed to allocate the input device\n");
> -		return -ENOMEM;
> +		error = -ENOMEM;
> +		goto error_snvs_pwrkey_device_register;

Instead of mixing automatic and manual resource release please install a
custom devm action disabling the clock. This will also ensure that we
disable the clock when unbinding device.

Thanks.

-- 
Dmitry
