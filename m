From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] Input: gpio_keys - trigger input event if key is
 pressed in boot stage
Date: Wed, 20 May 2015 09:37:36 -0700
Message-ID: <20150520163736.GA23809@dtor-ws>
References: <CAGsJ_4z-CZShfCQ2JNgOKX1dtfGksX+Naj++4tugPCriiY=ESg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35413 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbETQhl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 12:37:41 -0400
Received: by iesa3 with SMTP id a3so43611066ies.2
        for <linux-input@vger.kernel.org>; Wed, 20 May 2015 09:37:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGsJ_4z-CZShfCQ2JNgOKX1dtfGksX+Naj++4tugPCriiY=ESg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Andy.Sun@csr.com

Hi Barry,

On Wed, May 20, 2015 at 06:02:36PM +0800, Barry Song wrote:
> sometimes we press a key to boot, and the boot stage need to get this
> event.
> the current codes use edge trigger, so we have no chance to report
> the cold-touch event.
> but our user sceneries like Linux navigator does need it.

Input events that come before input device is opened (either by
userspace or by a kernel consumer) are ignored by input core and we
already call gpio_keys_report_state() from gpio_keys_open() so I do not
think this patch has any effect.

Thanks.

> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -RFC: for the moment, only an idea
> 
>  drivers/input/keyboard/gpio_keys.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c
> b/drivers/input/keyboard/gpio_keys.c
> index ddf4045..77fe0dd 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -766,6 +766,19 @@ static int gpio_keys_probe(struct platform_device *pdev)
> 
>      device_init_wakeup(&pdev->dev, wakeup);
> 
> +    /* if the key is pressed while system boot, force an interrupt */
> +    for (i = 0; i < pdata->nbuttons; i++) {
> +        const struct gpio_keys_button *button = &pdata->buttons[i];
> +        struct gpio_button_data *bdata = &ddata->data[i];
> +        int state;
> +
> +        if (gpio_is_valid(button->gpio)) {
> +            state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^
> button->active_low;
> +            if (state)
> +                gpio_keys_gpio_isr(bdata->irq, bdata);
> +        }
> +    }
> +
>      return 0;
> 
>  err_remove_group:
> -- 
> 1.9.1

-- 
Dmitry
