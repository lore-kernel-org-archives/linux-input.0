From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Disable IRQ across suspend
Date: Fri, 27 Sep 2019 17:16:26 -0700
Message-ID: <20190928001626.GT237523@dtor-ws>
References: <20190924215238.184750-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190924215238.184750-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Jongpil Jung <jongpil19.jung@samsung.com>, Furquan Shaikh <furquan@chromium.org>, Rajat Jain <rajatja@chromium.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Evan,

On Tue, Sep 24, 2019 at 02:52:38PM -0700, Evan Green wrote:
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
> ---
> 
> Changes in v2:
>  - Enable and disable unconditionally (Dmitry)
> 
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 24c4b691b1c9..a58092488679 100644
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
> @@ -3174,6 +3175,7 @@ static int __maybe_unused mxt_resume(struct device *dev)
>  		mxt_start(data);
>  
>  	mutex_unlock(&input_dev->mutex);
> +	enable_irq(data->irq);

At least for older devices that do soft reset on resume we need
interrupts to already work when we call mxt_start().

In general, order of resume steps should mirror suspend.

Thanks.

-- 
Dmitry
