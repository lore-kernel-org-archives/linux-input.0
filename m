From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] Input: ar1021 - do not force raising edge IRQ trigger
Date: Sat, 15 Apr 2017 08:44:05 +0200
Message-ID: <20170415084405.6eef66b8@endymion>
References: <20170413234923.GA38321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413234923.GA38321@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 13 Apr 2017 16:49:23 -0700, Dmitry Torokhov wrote:
> We should not be forcing edge triggered interrupt, but rather let platform
> decide the kind of trigger it needs to use. Also, the driver is not quite
> safe with regard to edge-triggered interrupts as it does not try to kick
> the controller after requesting/enabling IRQ.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/ar1021_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 6797e123925a..6c3c79b7ff51 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -109,7 +109,7 @@ static int ar1021_i2c_probe(struct i2c_client *client,
>  
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
>  					  NULL, ar1021_i2c_irq,
> -					  IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					  IRQF_ONESHOT,
>  					  "ar1021_i2c", ar1021);
>  	if (error) {
>  		dev_err(&client->dev,

Acked-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
