From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH] Input: omap4-keypad - don't leak in omap4_keypad_probe()
Date: Wed, 8 Aug 2012 09:13:19 +0530
Message-ID: <CAK9yfHxS=VvZ8Cuhd4LAUG+JnOK0g6=xCEoX45mtuVwj-+8D_g@mail.gmail.com>
References: <alpine.LNX.2.00.1208072014140.3227@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1208072014140.3227@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>
List-Id: linux-input@vger.kernel.org

On 7 August 2012 23:46, Jesper Juhl <jj@chaosbits.net> wrote:
> If omap4_keypad_parse_dt() does not return 0 (zero) in
> omap4_keypad_probe() we will leak the memory we allocated for
> 'keypad_data' with kzalloc() when we return and the variable goes out
> of scope.

How about using devm_kzalloc() instead which will take care of freeing
the memory on detach?

> Fix the leak by jumping to the 'err_free_keypad' label where we
> properly free the allocated memory, instead of returning directly.
>
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  drivers/input/keyboard/omap4-keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>  Compile tested only.
>
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index c05f98c..9c2ac87 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -281,7 +281,7 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>         } else {
>                 error = omap4_keypad_parse_dt(&pdev->dev, keypad_data);
>                 if (error)
> -                       return error;
> +                       goto err_free_keypad;
>         }
>
>         res = request_mem_region(res->start, resource_size(res), pdev->name);
> --
> 1.7.11.4
>
>
> --
> Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
> Don't top-post http://www.catb.org/jargon/html/T/top-post.html
> Plain text mails only, please.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Regards,
Sachin
