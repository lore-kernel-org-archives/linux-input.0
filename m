From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 3/4] Input: ad7879 - try parsing properties on non-DT
 systems
Date: Wed, 1 Mar 2017 08:38:41 +0100
Message-ID: <2cbe69fd-7d69-4f8f-e46b-12bc7b4e0b1b@analog.com>
References: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
 <20170228220848.31185-3-dmitry.torokhov@gmail.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn3nam01on0061.outbound.protection.outlook.com ([104.47.33.61]:23647
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751560AbdCAHzN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Mar 2017 02:55:13 -0500
In-Reply-To: <20170228220848.31185-3-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 28.02.2017 23:08, Dmitry Torokhov wrote:
> We have switched the driver to use generic device properties API, so there
> is no need to check for presence of DT node before trying parse properties.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7879.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 7118f611e222..c415614ada68 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -560,11 +560,10 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
>  		ts->averaging = pdata->averaging;
>  		ts->pen_down_acc_interval = pdata->pen_down_acc_interval;
>  		ts->median = pdata->median;
> -	} else if (dev->of_node) {
> -		ad7879_parse_dt(dev, ts);
>  	} else {
> -		dev_err(dev, "No platform data\n");
> -		return -EINVAL;
> +		err = ad7879_parse_dt(dev, ts);
> +		if (err)
> +			return err;
>  	}
>
>  	input_dev = devm_input_allocate_device(dev);
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
