From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 4/4] Input: ad7879 - do not manipulate capability bits
 directly
Date: Wed, 1 Mar 2017 08:37:49 +0100
Message-ID: <109567db-75f3-cdd7-966b-f77967fe4092@analog.com>
References: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
 <20170228220848.31185-4-dmitry.torokhov@gmail.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228220848.31185-4-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 28.02.2017 23:08, Dmitry Torokhov wrote:
> Instead of manipulating capabilities bits of input device directly, let's
> use input_set_capability() API.
>
> Also, stop setting ABS_X/Y bits explicitly as input_set_abs_params() does
> this for us.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7879.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index c415614ada68..196028c45210 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -590,13 +590,7 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
>
>  	input_set_drvdata(input_dev, ts);
>
> -	__set_bit(EV_ABS, input_dev->evbit);
> -	__set_bit(ABS_X, input_dev->absbit);
> -	__set_bit(ABS_Y, input_dev->absbit);
> -	__set_bit(ABS_PRESSURE, input_dev->absbit);
> -
> -	__set_bit(EV_KEY, input_dev->evbit);
> -	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
>
>  	if (pdata) {
>  		input_set_abs_params(input_dev, ABS_X,
> @@ -614,6 +608,7 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
>  	} else {
>  		input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
>  		input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
> +		input_set_capability(input_dev, EV_ABS, ABS_PRESSURE);
>  		touchscreen_parse_properties(input_dev, false, NULL);
>  		if (!input_abs_get_max(input_dev, ABS_PRESSURE)) {
>  			dev_err(dev, "Touchscreen pressure is not specified\n");
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
