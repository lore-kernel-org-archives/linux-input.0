From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v8 3/3] OMAP4:keypad: PM runtime
Date: Tue, 08 Feb 2011 14:00:58 +0530
Message-ID: <4D50FF42.1070401@ti.com>
References: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com> <1293429106-16543-2-git-send-email-shubhrajyoti@ti.com> <1293429106-16543-3-git-send-email-shubhrajyoti@ti.com> <1293429106-16543-4-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55580 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab1BHIbG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Feb 2011 03:31:06 -0500
Received: by gxk4 with SMTP id 4so2310487gxk.35
        for <linux-input@vger.kernel.org>; Tue, 08 Feb 2011 00:31:04 -0800 (PST)
In-Reply-To: <1293429106-16543-4-git-send-email-shubhrajyoti@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: shubhrajyoti@ti.com, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello,
Any comments/suggestions.

Thanks,

On Monday 27 December 2010 11:21 AM, shubhrajyoti@ti.com wrote:
> From: Abraham Arce<x0066660@ti.com>
>
> Enable Runtime PM functionality in OMAP4 driver based on the following assumptions
>
> A minimal pm runtime get/put approach is implemented in probe/remove calls
> respectively.
>
> - Keyboard controller in wakeup domain so it is always on and
>    power impact may be minimal
> - In OMAP4 the device control is at module/device level and ick/fclk level control is
>    difficult so cutting of clocks will prevent interrupts.
>
> Signed-off-by: Abraham Arce<x0066660@ti.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> ---
>   drivers/input/keyboard/omap4-keypad.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index 45bd097..fcfbb9b 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -29,6 +29,7 @@
>   #include<linux/io.h>
>   #include<linux/input.h>
>   #include<linux/slab.h>
> +#include<linux/pm_runtime.h>
>
>   #include<plat/omap4-keypad.h>
>
> @@ -239,6 +240,9 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>   	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
>   			input_dev->keycode, input_dev->keybit);
>
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
>   	omap4_keypad_config(keypad_data);
>
>   	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
> @@ -278,6 +282,10 @@ static int __devexit omap4_keypad_remove(struct platform_device *pdev)
>   	struct resource *res;
>
>   	free_irq(keypad_data->irq, keypad_data);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
>   	input_unregister_device(keypad_data->input);
>
>   	iounmap(keypad_data->base);

