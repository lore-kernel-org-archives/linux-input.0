From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] input: samsung-keypad: Use devm_* functions
Date: Fri, 23 Nov 2012 11:59:38 +0530
Message-ID: <CAK9yfHynYeBP2yQfHU6oznwks6u2P5BAY8L67Lg=NuPCYC3J-Q@mail.gmail.com>
References: <1352980598-6305-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60198 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab2KWG3j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Nov 2012 01:29:39 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so3378252vbb.19
        for <linux-input@vger.kernel.org>; Thu, 22 Nov 2012 22:29:38 -0800 (PST)
In-Reply-To: <1352980598-6305-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, patches@linaro.org

Hi Dmitry,

Any comments on this patch.

On 15 November 2012 17:26, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> devm_* functions are device managed and make error handling
> and code simpler.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/input/keyboard/samsung-keypad.c |   59 +++++++++---------------------
>  1 files changed, 18 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index 9d7a111..abf6d3d 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -405,36 +405,29 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>         row_shift = get_count_order(pdata->cols);
>         keymap_size = (pdata->rows << row_shift) * sizeof(keypad->keycodes[0]);
>
> -       keypad = kzalloc(sizeof(*keypad) + keymap_size, GFP_KERNEL);
> -       input_dev = input_allocate_device();
> -       if (!keypad || !input_dev) {
> -               error = -ENOMEM;
> -               goto err_free_mem;
> -       }
> +       keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad) + keymap_size, GFP_KERNEL);
> +       input_dev = devm_input_allocate_device(&pdev->dev);
> +       if (!keypad || !input_dev)
> +               return -ENOMEM;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               error = -ENODEV;
> -               goto err_free_mem;
> -       }
> +       if (!res)
> +               return -ENODEV;
>
> -       keypad->base = ioremap(res->start, resource_size(res));
> -       if (!keypad->base) {
> -               error = -EBUSY;
> -               goto err_free_mem;
> -       }
> +       keypad->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +       if (!keypad->base)
> +               return -EBUSY;
>
> -       keypad->clk = clk_get(&pdev->dev, "keypad");
> +       keypad->clk = devm_clk_get(&pdev->dev, "keypad");
>         if (IS_ERR(keypad->clk)) {
>                 dev_err(&pdev->dev, "failed to get keypad clk\n");
> -               error = PTR_ERR(keypad->clk);
> -               goto err_unmap_base;
> +               return PTR_ERR(keypad->clk);
>         }
>
>         error = clk_prepare(keypad->clk);
>         if (error) {
>                 dev_err(&pdev->dev, "keypad clock prepare failed\n");
> -               goto err_put_clk;
> +               goto err_dt_gpio_free;
>         }
>
>         keypad->input_dev = input_dev;
> @@ -479,14 +472,15 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>         keypad->irq = platform_get_irq(pdev, 0);
>         if (keypad->irq < 0) {
>                 error = keypad->irq;
> -               goto err_put_clk;
> +               goto err_dt_gpio_free;
>         }
>
> -       error = request_threaded_irq(keypad->irq, NULL, samsung_keypad_irq,
> -                       IRQF_ONESHOT, dev_name(&pdev->dev), keypad);
> +       error = devm_request_threaded_irq(&pdev->dev, keypad->irq, NULL,
> +                                         samsung_keypad_irq, IRQF_ONESHOT,
> +                                         dev_name(&pdev->dev), keypad);
>         if (error) {
>                 dev_err(&pdev->dev, "failed to register keypad interrupt\n");
> -               goto err_put_clk;
> +               goto err_dt_gpio_free;
>         }
>
>         device_init_wakeup(&pdev->dev, pdata->wakeup);
> @@ -505,20 +499,13 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>         return 0;
>
>  err_free_irq:
> -       free_irq(keypad->irq, keypad);
>         pm_runtime_disable(&pdev->dev);
>         device_init_wakeup(&pdev->dev, 0);
>         platform_set_drvdata(pdev, NULL);
>  err_unprepare_clk:
>         clk_unprepare(keypad->clk);
> -err_put_clk:
> -       clk_put(keypad->clk);
> +err_dt_gpio_free:
>         samsung_keypad_dt_gpio_free(keypad);
> -err_unmap_base:
> -       iounmap(keypad->base);
> -err_free_mem:
> -       input_free_device(input_dev);
> -       kfree(keypad);
>
>         return error;
>  }
> @@ -533,19 +520,9 @@ static int __devexit samsung_keypad_remove(struct platform_device *pdev)
>
>         input_unregister_device(keypad->input_dev);
>
> -       /*
> -        * It is safe to free IRQ after unregistering device because
> -        * samsung_keypad_close will shut off interrupts.
> -        */
> -       free_irq(keypad->irq, keypad);
> -
>         clk_unprepare(keypad->clk);
> -       clk_put(keypad->clk);
>         samsung_keypad_dt_gpio_free(keypad);
>
> -       iounmap(keypad->base);
> -       kfree(keypad);
> -
>         return 0;
>  }
>
> --
> 1.7.4.1
>



-- 
With warm regards,
Sachin
