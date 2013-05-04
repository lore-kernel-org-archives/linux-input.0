From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 3/9] Input: gpio_tilt_polled - Remove redundant platform_set_drvdata()
Date: Sat, 4 May 2013 21:44:48 +0200
Message-ID: <201305042144.50286.heiko@sntech.de>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org> <1367679118-2980-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34453 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700Ab3EDToy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 May 2013 15:44:54 -0400
In-Reply-To: <1367679118-2980-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Am Samstag, 4. Mai 2013, 16:51:52 schrieb Sachin Kamat:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>

not sure, if it's needed for such a small change, but nevertheless
Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/input/misc/gpio_tilt_polled.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/gpio_tilt_polled.c
> b/drivers/input/misc/gpio_tilt_polled.c index da05cca..714c683 100644
> --- a/drivers/input/misc/gpio_tilt_polled.c
> +++ b/drivers/input/misc/gpio_tilt_polled.c
> @@ -184,8 +184,6 @@ static int gpio_tilt_polled_remove(struct
> platform_device *pdev) struct gpio_tilt_polled_dev *tdev =
> platform_get_drvdata(pdev);
>  	const struct gpio_tilt_platform_data *pdata = tdev->pdata;
> 
> -	platform_set_drvdata(pdev, NULL);
> -
>  	input_unregister_polled_device(tdev->poll_dev);
>  	input_free_polled_device(tdev->poll_dev);

