From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] input: eglx_ts, remove irq trigger flags
Date: Thu, 12 Mar 2015 16:18:03 +0100
Message-ID: <1426173483.14455.73.camel@pengutronix.de>
References: <1426171816-26609-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426171816-26609-1-git-send-email-mpa@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Markus,

Am Donnerstag, den 12.03.2015, 15:50 +0100 schrieb Markus Pargmann:
> The trigger settings for a given irq are parsed from DT. Defining them
> as flag for devm_request_threaded_irq() overwrites these settings. This
> results in wrong trigger settings for boards which have different irq
> triggers.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/input/touchscreen/egalax_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
> index 4c56299284ef..b0e6448b743c 100644
> --- a/drivers/input/touchscreen/egalax_ts.c
> +++ b/drivers/input/touchscreen/egalax_ts.c
> @@ -218,7 +218,7 @@ static int egalax_ts_probe(struct i2c_client *client,
>  
>  	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>  					  egalax_ts_interrupt,
> -					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					  IRQF_ONESHOT,
>  					  "egalax_ts", ts);
>  	if (error < 0) {
>  		dev_err(&client->dev, "Failed to register interrupt\n");

There are three device trees which have eeti,egalax_ts nodes with
interrupt flags 0:

arch/arm/boot/dts/imx53-tx53-x13x.dts (twice),
arch/arm/boot/dts/imx6dl-tx6u-811x.dts, and
arch/arm/boot/dts/imx6q-tx6q-1110.dts.

Will these still work after this change?

regards
Philipp
