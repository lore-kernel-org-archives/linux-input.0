From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Input: max11801_ts - drop call to input_set_drvdata()
Date: Sun, 22 Jan 2017 03:25:57 -0800
Message-ID: <dd170278-d556-2f73-cdbe-ee69f9a19423@roeck-us.net>
References: <20170122073846.GA30131@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170122073846.GA30131@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/21/2017 11:38 PM, Dmitry Torokhov wrote:
> Nobody calls input_get_drvdata() so setting it is not required.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Surprisingly, there is about a dozen of those. I'll send a series of
coccinelle generated patches later.

Guenter

> ---
>  drivers/input/touchscreen/max11801_ts.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
> index d87b89da114e..a595ae5284e3 100644
> --- a/drivers/input/touchscreen/max11801_ts.c
> +++ b/drivers/input/touchscreen/max11801_ts.c
> @@ -199,7 +199,6 @@ static int max11801_ts_probe(struct i2c_client *client,
>  	__set_bit(BTN_TOUCH, input_dev->keybit);
>  	input_set_abs_params(input_dev, ABS_X, 0, MAX11801_MAX_X, 0, 0);
>  	input_set_abs_params(input_dev, ABS_Y, 0, MAX11801_MAX_Y, 0, 0);
> -	input_set_drvdata(input_dev, data);
>
>  	max11801_ts_phy_init(data);
>
>
