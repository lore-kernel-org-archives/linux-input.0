From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/3] Input: atmel_mxt_ts: Wait for device be ready for
 communication
Date: Mon, 14 Jan 2019 16:42:32 -0800
Message-ID: <20190115004232.GK117329@dtor-ws>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
 <20181214151214.5391-3-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214151214.5391-3-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 14, 2018 at 04:12:13PM +0100, Paweł Chmiel wrote:
> According to documentation, device isn't ready for communication,
> until firmware asserts the CHG line. Add missing wait for this.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Fix checkpatch issues
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 55a107fc1b73..e8949c6ceafa 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -202,6 +202,7 @@ enum t100_type {
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> +#define MXT_POWERON_DELAY	150	/* msec */
>  
>  /* Command to unlock bootloader */
>  #define MXT_UNLOCK_CMD_MSB	0xaa
> @@ -3070,6 +3071,16 @@ static int mxt_regulator_enable(struct mxt_data *data)
>  		msleep(MXT_REGULATOR_DELAY);
>  		gpiod_set_value(data->reset_gpio, 1);
>  		msleep(MXT_RESET_INVALID_CHG);
> +
> +retry_wait:
> +		reinit_completion(&data->bl_completion);
> +		data->in_bootloader = true;

I think you would want to reinit the ocmpletion and set the flag before
releasing reset line and sleeping, otherwise if interrupt fires too
early you'll be spinning for extra time.

I'd also really want to hear from Nick on this change.

> +		error = mxt_wait_for_completion(data, &data->bl_completion,
> +						MXT_POWERON_DELAY);
> +		if (error == -EINTR)
> +			goto retry_wait;
> +
> +		data->in_bootloader = false;
>  	}
>  
>  	return 0;
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
