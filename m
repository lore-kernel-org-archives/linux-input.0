From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: as5011: avoid using __set_bit() for
 capabilities
Date: Tue, 8 May 2018 15:32:34 -0700
Message-ID: <20180508223234.GB129015@dtor-ws>
References: <20180331112143.18768-1-marcus.folkesson@gmail.com>
 <20180331112143.18768-2-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180331112143.18768-2-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 31, 2018 at 01:21:41PM +0200, Marcus Folkesson wrote:
> input_set_capability() and input_set_abs_param() will do it for you.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/as5011.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
> index 005d852a06e9..f051993c568e 100644
> --- a/drivers/input/joystick/as5011.c
> +++ b/drivers/input/joystick/as5011.c
> @@ -269,9 +269,7 @@ static int as5011_probe(struct i2c_client *client,
>  	input_dev->id.bustype = BUS_I2C;
>  	input_dev->dev.parent = &client->dev;
>  
> -	__set_bit(EV_KEY, input_dev->evbit);
> -	__set_bit(EV_ABS, input_dev->evbit);
> -	__set_bit(BTN_JOYSTICK, input_dev->keybit);
> +	input_set_capability(input_dev, EV_KEY, BTN_JOYSTICK);
>  
>  	input_set_abs_params(input_dev, ABS_X,
>  		AS5011_MIN_AXIS, AS5011_MAX_AXIS, AS5011_FUZZ, AS5011_FLAT);
> -- 
> 2.16.2
> 

-- 
Dmitry
