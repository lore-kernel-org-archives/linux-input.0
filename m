From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: goodix: Poll the 'buffer status' bit before
 reading data
Date: Thu, 30 Mar 2017 15:48:00 -0700
Message-ID: <20170330224800.GA15258@dtor-ws>
References: <20170330133349.19931-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170330133349.19931-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 30, 2017 at 03:33:49PM +0200, Paul Cercueil wrote:
> The Goodix panel triggers an interrupt on touch events. However, its
> registers will contain the valid values a short time after the
> interrupt, and not when it's raised. At that moment, the 'buffer status'
> bit is set.

Yay for awesome hardware.

> 
> Previously, if the 'buffer status' bit was not set when the registers
> were read, the data was discarded and no input event was emitted,
> causing "finger down" or "finger up" events to be missed sometimes.
> 
> This went unnoticed until v4.9, as the DesignWare I2C driver commonly
> used with this driver had enough latency for that bug to never trigger.
> 
> Now, in the IRQ handler we will poll (with a timeout) the 'buffer status'
> bit and process the data of the panel as soon as this bit gets set.
> 
> Note that the Goodix panel will send a few spurious interrupts after the
> 'finger up' event, in which the 'buffer status' bit will never be set.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/input/touchscreen/goodix.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 240b16f3ee97..7a8b89b87c2f 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -195,18 +195,34 @@ static int goodix_get_cfg_len(u16 id)
>  
>  static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
>  {
> +	unsigned int timeout = 100;
>  	int touch_num;
>  	int error;
>  
> -	error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data,
> +	/* The 'buffer status' bit, which indicates that the data is valid, is
> +	 * not set as soon as the interrupt is raised, but slightly after.
> +	 */
> +	do {
> +		error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data,
>  				GOODIX_CONTACT_SIZE + 1);
> -	if (error) {
> -		dev_err(&ts->client->dev, "I2C transfer error: %d\n", error);
> -		return error;
> -	}
> +		if (error) {
> +			dev_err(&ts->client->dev, "I2C transfer error: %d\n",
> +					error);
> +			return error;
> +		}
>  
> -	if (!(data[0] & 0x80))
> -		return -EAGAIN;
> +		if (data[0] & 0x80)
> +			break;
> +
> +		usleep_range(100, 200);

What is the typical delay between IRQ and data being ready? 100 repeats
suggest that poll interval is too small.

> +	} while (--timeout);
> +
> +	if (!timeout) {
> +		/* The Goodix panel will send spurious interrupts after a
> +		 * 'finger up' event, which will always cause a timeout.
> +		 */
> +		return 0;
> +	}
>  
>  	touch_num = data[0] & 0x0f;
>  	if (touch_num > ts->max_touch_num)
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry
