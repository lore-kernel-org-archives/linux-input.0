From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers: tca8418: Change the interrupt type
Date: Tue, 8 Nov 2016 16:04:00 -0800
Message-ID: <20161109000400.GA8719@dtor-ws>
References: <20161107144024.15291-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161107144024.15291-1-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 07, 2016 at 03:40:24PM +0100, Maxime Ripard wrote:
> The TCA8418 interrupt has a level trigger, not a edge one.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Hmm, maybe we could rely on OF data for trigger type?

> ---
>  drivers/input/keyboard/tca8418_keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index 9002298698fc..b88b3696a2e1 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -360,7 +360,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
>  		irq = gpio_to_irq(irq);
>  
>  	error = devm_request_threaded_irq(dev, irq, NULL, tca8418_irq_handler,
> -					  IRQF_TRIGGER_FALLING |
> +					  IRQF_TRIGGER_LOW |
>  						IRQF_SHARED |
>  						IRQF_ONESHOT,
>  					  client->name, keypad_data);
> -- 
> 2.10.1
> 

-- 
Dmitry
