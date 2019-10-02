From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: atmel_mxt_ts - Disable IRQ across suspend
Date: Wed, 2 Oct 2019 14:01:46 -0700
Message-ID: <20191002210146.GB20549@dtor-ws>
References: <20191001181504.207486-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001181504.207486-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Jongpil Jung <jongpil19.jung@samsung.com>, Furquan Shaikh <furquan@chromium.org>, Rajat Jain <rajatja@chromium.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 01, 2019 at 11:15:03AM -0700, Evan Green wrote:
> Across suspend and resume, we are seeing error messages like the following:
> 
> atmel_mxt_ts i2c-PRP0001:00: __mxt_read_reg: i2c transfer failed (-121)
> atmel_mxt_ts i2c-PRP0001:00: Failed to read T44 and T5 (-121)
> 
> This occurs because the driver leaves its IRQ enabled. Upon resume, there
> is an IRQ pending, but the interrupt is serviced before both the driver and
> the underlying I2C bus have been resumed. This causes EREMOTEIO errors.
> 
> Disable the IRQ in suspend, and re-enable it on resume. If there are cases
> where the driver enters suspend with interrupts disabled, that's a bug we
> should fix separately.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Applied, thank you.

> ---
> 
> Changes in v3:
>  - Move enable_irq to the beginning of resume (Dmitry)
> 
> Changes in v2:
>  - Enable and disable unconditionally (Dmitry)
> 
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 24c4b691b1c9..1627fcb27f35 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3155,6 +3155,7 @@ static int __maybe_unused mxt_suspend(struct device *dev)
>  		mxt_stop(data);
>  
>  	mutex_unlock(&input_dev->mutex);
> +	disable_irq(data->irq);
>  
>  	return 0;
>  }
> @@ -3168,6 +3169,7 @@ static int __maybe_unused mxt_resume(struct device *dev)
>  	if (!input_dev)
>  		return 0;
>  
> +	enable_irq(data->irq);
>  	mutex_lock(&input_dev->mutex);
>  
>  	if (input_dev->users)
> -- 
> 2.21.0
> 

-- 
Dmitry
