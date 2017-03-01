From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/4] Input: ad7879 - make sure we set up drvdata
Date: Wed, 1 Mar 2017 08:40:56 +0100
Message-ID: <df4ed62b-d2dc-65a5-7e87-916eb7965e7c@analog.com>
References: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:61504
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751824AbdCAHzN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Mar 2017 02:55:13 -0500
In-Reply-To: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 28.02.2017 23:08, Dmitry Torokhov wrote:
> The conversion to devm accidentally removed setting up of I2C client data
> upon successful probe of the touchscreen. Let's move this setting into the
> core, so we do not forger about it again.
>
> Fixes: 381f688eee3d ("Input: ad7879 - use more devm interfaces")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7879-spi.c | 2 --
>  drivers/input/touchscreen/ad7879.c     | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
> index c73798297b98..59486ccba37d 100644
> --- a/drivers/input/touchscreen/ad7879-spi.c
> +++ b/drivers/input/touchscreen/ad7879-spi.c
> @@ -49,8 +49,6 @@ static int ad7879_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(ts))
>  		return PTR_ERR(ts);
>
> -	spi_set_drvdata(spi, ts);
> -
>  	return 0;
>  }
>
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 1bd870277e1a..52daaa4edc67 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -680,6 +680,8 @@ struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
>  	if (err)
>  		return ERR_PTR(err);
>
> +	dev_set_drvdata(dev, ts);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(ad7879_probe);
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
