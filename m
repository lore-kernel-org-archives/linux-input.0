From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input: improve usage of gpiod API
Date: Fri, 6 Mar 2015 11:54:56 +0100
Message-ID: <CACRpkdYxwy58k7q0bNtroUNfg2KM-OH6J134ypYmXxmYmD3Q7w@mail.gmail.com>
References: <1424256433-8090-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35018 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbbCFKy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 05:54:57 -0500
Received: by oifz81 with SMTP id z81so16957882oif.2
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 02:54:56 -0800 (PST)
In-Reply-To: <1424256433-8090-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Alexandre Courbot <acourbot@nvidia.com>, Mark Brown <broonie@linaro.org>

On Wed, Feb 18, 2015 at 11:47 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() function=
s)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additio=
nal
> parameter that allows to specify direction and initial value for
> output. Simplify drivers accordingly.
>
> Note that in the case of the drv260x driver error checking is more
> strict now because -ENOSYS is reported to the caller now. But this
> should only be returned if GPIOLIB is disabled which shouldn't happen=
 as
> the driver depends on GPIOLIB.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks a lot for your hard work on this.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
