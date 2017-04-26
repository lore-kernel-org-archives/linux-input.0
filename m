From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: mxs-lradc: Checking for ERR_PTR
 instead of NULL in probe
Date: Wed, 26 Apr 2017 14:08:03 -0700
Message-ID: <CAKdAkRSwjoUgsn4kYDeP4CCozHhUeeSnui4xSMB8JPWFbPkM0Q@mail.gmail.com>
References: <20170426210410.k2pe5ov2nkxtuf54@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33964 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967655AbdDZVIF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Apr 2017 17:08:05 -0400
In-Reply-To: <20170426210410.k2pe5ov2nkxtuf54@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org

Hi Dan,

On Wed, Apr 26, 2017 at 2:04 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> devm_ioremap() returns NULL on error.  It never returns error pointers.
>
> Fixes: d81ca730e3e4 ("input: touchscreen: mxs-lradc: Add support for touchscreen")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index 4b4aebfe3e7f..ff9cda29d9a0 100644
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -631,8 +631,8 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
>
>         iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
> -       if (IS_ERR(ts->base))
> -               return PTR_ERR(ts->base);
> +       if (!ts->base)
> +               return -ENOMEM;
>
>         ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
>                                    &ts_wires);

As mentioned in another email I'd prefer we switched to
devm_ioremap_resource() instead.

-- 
Dmitry
