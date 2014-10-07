From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: clps711x-keypad: Remove cond_resched() call
Date: Tue, 7 Oct 2014 16:48:54 -0700
Message-ID: <20141007234854.GM16469@dtor-ws>
References: <1411115346-22034-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:61933 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396AbaJGXtA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 19:49:00 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so8006334pab.18
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2014 16:49:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411115346-22034-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

Hi Alexander,

On Fri, Sep 19, 2014 at 12:29:06PM +0400, Alexander Shiyan wrote:
> cond_resched() is not works as expected for clps711x-keypad driver
> and cause runtime error.
> This patch replaces this call with udelay().
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/input/keyboard/clps711x-keypad.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/keyboard/clps711x-keypad.c
> index 552b65c..650205d 100644
> --- a/drivers/input/keyboard/clps711x-keypad.c
> +++ b/drivers/input/keyboard/clps711x-keypad.c
> @@ -9,13 +9,13 @@
>   * (at your option) any later version.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/input.h>
>  #include <linux/input-polldev.h>
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <linux/sched.h>
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/clps711x.h>
> @@ -54,9 +54,9 @@ static void clps711x_keypad_poll(struct input_polled_dev *dev)
>  
>  			/* Read twice for protection against fluctuations */
>  			do {
> -				state = gpiod_get_value_cansleep(data->desc);
> -				cond_resched();
> -				state1 = gpiod_get_value_cansleep(data->desc);
> +				state = gpiod_get_value(data->desc);
> +				udelay(5);
> +				state1 = gpiod_get_value(data->desc);

Why are you changing gpiod_get_value_cansleep() -> gpiod_get_value().
I am not saying it is incorrect, but could you give reasoning in the
changelog?

Thanks.

-- 
Dmitry
