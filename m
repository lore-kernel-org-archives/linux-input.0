From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elants_i2c - Avoid divide by 0 errors on bad
 touchscreen data
Date: Thu, 5 Jan 2017 14:18:48 -0800
Message-ID: <20170105221848.GB20478@dtor-ws>
References: <1483640265-688-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483640265-688-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Johnny Chuang <johnny.chuang@emc.com.tw>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 05, 2017 at 10:17:45AM -0800, Guenter Roeck wrote:
> The following crash may be seen if bad data is received from the
> touchscreen.
> 
> [ 2189.425150] elants_i2c i2c-ELAN0001:00: unknown packet ff ff ff ff
> [ 2189.430738] divide error: 0000 [#1] PREEMPT SMP
...
> 
> The problem was seen with a 3.18 based kernel, but there is no reason
> to believe that the upstream code is safe.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied and marked for stable, thank you.

> ---
>  drivers/input/touchscreen/elants_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 02aec284deca..3e6003d32e56 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -914,9 +914,9 @@ static irqreturn_t elants_i2c_irq(int irq, void *_dev)
>  
>  		case QUEUE_HEADER_NORMAL:
>  			report_count = ts->buf[FW_HDR_COUNT];
> -			if (report_count > 3) {
> +			if (report_count == 0 || report_count > 3) {
>  				dev_err(&client->dev,
> -					"too large report count: %*ph\n",
> +					"bad report count: %*ph\n",
>  					HEADER_SIZE, ts->buf);
>  				break;
>  			}
> -- 
> 2.7.4
> 

-- 
Dmitry
