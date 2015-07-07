From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/6] Input: pixcir_i2c_ts - allow using with GPIO expanders
Date: Tue, 7 Jul 2015 13:55:44 +0300
Message-ID: <559BB030.2000804@ti.com>
References: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com> <1436229011-29655-3-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436229011-29655-3-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 07/07/15 03:30, Dmitry Torokhov wrote:
> We are using threaded interrupt handler and thus are allowed to sleep.
> Let's switch over to gpiod_get_value_cansleep() so that we do not get
> ugly warnings in case GPIO controller might sleep when accessing GPIO.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>   drivers/input/touchscreen/pixcir_i2c_ts.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 9093aa9..8965d7c 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -171,7 +171,7 @@ static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
>   		/* report it */
>   		pixcir_ts_report(tsdata, &report);
>
> -		if (gpiod_get_value(tsdata->gpio_attb)) {
> +		if (gpiod_get_value_cansleep(tsdata->gpio_attb)) {
>   			if (report.num_touches) {
>   				/*
>   				 * Last report with no finger up?
>
