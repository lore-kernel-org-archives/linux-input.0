From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] input: touchscreen: mxs-lradc: Fix return value
 check in mxs_lradc_ts_probe()
Date: Tue, 25 Apr 2017 00:09:25 -0700
Message-ID: <CAKdAkRQn72fs=dPiO8AbkVYmiShGBdix57d=QTV_8scN_1=D=A@mail.gmail.com>
References: <20170425062646.26043-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33026 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170389AbdDYHJ0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 03:09:26 -0400
Received: by mail-vk0-f66.google.com with SMTP id j127so7354894vkh.0
        for <linux-input@vger.kernel.org>; Tue, 25 Apr 2017 00:09:26 -0700 (PDT)
In-Reply-To: <20170425062646.26043-1-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>, Wei Yongjun <weiyongjun1@huawei.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Wei,

On Mon, Apr 24, 2017 at 11:26 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> In case of error, the function devm_ioremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.

I'd rather we switched to devm_ioremap_resource() that does return
ERR_PTR-encoded error.

>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/input/touchscreen/mxs-lradc-ts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index 4b4aebf..ff9cda2 100644
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
>

Thanks.

-- 
Dmitry
