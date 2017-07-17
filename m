From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv4 1/4] mfd: da9052: fix manual ADC read after timed out
 read
Date: Mon, 17 Jul 2017 11:49:16 +0100
Message-ID: <20170717104916.exhaspyska4okclc@dell>
References: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
 <20170630143506.10541-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630143506.10541-2-sebastian.reichel@collabora.co.uk>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 30 Jun 2017, Sebastian Reichel wrote:

> It is possible that under heavy system load, the counter in the completion
> struct, used for waiting for end of AD conversion, gets incremented twice.
> To make sure the driver recovers from this situation, the completion struct
> should be reinitialized.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/da9052-core.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
> index a88c2065d8ab..977418ca9117 100644
> --- a/drivers/mfd/da9052-core.c
> +++ b/drivers/mfd/da9052-core.c
> @@ -386,6 +386,8 @@ int da9052_adc_manual_read(struct da9052 *da9052, unsigned char channel)
>  
>  	mutex_lock(&da9052->auxadc_lock);
>  
> +	reinit_completion(&da9052->done);
> +
>  	/* Channel gets activated on enabling the Conversion bit */
>  	mux_sel = chan_mux[channel] | DA9052_ADC_MAN_MAN_CONV;
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
