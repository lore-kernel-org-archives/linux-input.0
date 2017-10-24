From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: Re: [PATCH] Input: ps2-gpio - actually abort probe when connected to
 sleeping GPIOs
Date: Tue, 24 Oct 2017 09:08:29 +0200
Message-ID: <3add1a5c711650bde8226e483bc83a1e@dk-develop.de>
References: <20171023234447.qaohcuyfvnwn5m2n@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs01.dk-develop.de ([213.136.71.231]:38986 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdJXHPR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Oct 2017 03:15:17 -0400
In-Reply-To: <20171023234447.qaohcuyfvnwn5m2n@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org

On 2017-10-24 01:44, Dmitry Torokhov wrote:
> We've been missing a goto to the unwind path...
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/serio/ps2-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/serio/ps2-gpio.c 
> b/drivers/input/serio/ps2-gpio.c
> index b50e3817f3c4..c62cceb97bb1 100644
> --- a/drivers/input/serio/ps2-gpio.c
> +++ b/drivers/input/serio/ps2-gpio.c
> @@ -366,6 +366,7 @@ static int ps2_gpio_probe(struct platform_device 
> *pdev)
>  	    gpiod_cansleep(drvdata->gpio_clk)) {
>  		dev_err(dev, "GPIO data or clk are connected via slow bus\n");
>  		error = -EINVAL;
> +		goto err_free_serio;
Good catch, thanks.
>  	}
> 
>  	drvdata->irq = platform_get_irq(pdev, 0);
> --
> 2.15.0.rc0.271.g36b669edcc-goog
