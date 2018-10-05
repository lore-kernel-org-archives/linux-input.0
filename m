From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: st1232: set INPUT_PROP_DIRECT property
Date: Fri, 5 Oct 2018 11:47:08 -0700
Message-ID: <20181005184708.GA215120@dtor-ws>
References: <20181005081407.15376-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005081407.15376-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: geert+renesas@glider.be, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 05, 2018 at 10:14:07AM +0200, Martin Kepplinger wrote:
> This is how userspace checks for touchscreen devices most reliably.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/st1232.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index d5dfa4053bbf..b71673911aac 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -195,6 +195,7 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	input_dev->id.bustype = BUS_I2C;
>  	input_dev->dev.parent = &client->dev;
>  
> +	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
>  	__set_bit(EV_SYN, input_dev->evbit);
>  	__set_bit(EV_KEY, input_dev->evbit);
>  	__set_bit(EV_ABS, input_dev->evbit);
> -- 
> 2.19.0
> 

-- 
Dmitry
