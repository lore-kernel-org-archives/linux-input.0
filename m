From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: snvs_pwrkey - drop input_free_device call if
 input_register_device fails
Date: Fri, 23 Sep 2016 15:01:20 -0700
Message-ID: <20160923220120.GD25499@dtor-ws>
References: <1474249756-30843-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33821 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964952AbcIWWBY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 23 Sep 2016 18:01:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id 21so5789986pfy.1
        for <linux-input@vger.kernel.org>; Fri, 23 Sep 2016 15:01:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1474249756-30843-1-git-send-email-axel.lin@ingics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Frank Li <Frank.Li@nxp.com>, Robin Gong <b38343@freescale.com>, Shawn Guo <shawnguo@kernel.org>, linux-input@vger.kernel.org

On Mon, Sep 19, 2016 at 09:49:16AM +0800, Axel Lin wrote:
> Current code uses devm_input_allocate_device() so don't explicitly call
> input_free_device if input_register_device fails.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 24a9f59..7544888 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -168,7 +168,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	error = input_register_device(input);
>  	if (error < 0) {
>  		dev_err(&pdev->dev, "failed to register input device\n");
> -		input_free_device(input);
>  		return error;
>  	}
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
