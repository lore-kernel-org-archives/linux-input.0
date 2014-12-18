From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] Input: touchscreen-iproc: Add Broadcom iProc
 touchscreen driver
Date: Wed, 17 Dec 2014 18:14:41 -0800
Message-ID: <1418868881.28384.8.camel@perches.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
	 <1418867992-3550-1-git-send-email-jonathar@broadcom.com>
	 <1418867992-3550-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418867992-3550-2-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2014-12-17 at 17:59 -0800, Jonathan Richardson wrote:
> Add initial version of the Broadcom touchscreen driver.

trivia:

> diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c

> +/* Bit values for REGCTL2 */
> +#define TS_CONTROLLER_EN_BIT    (1 << 16)
> +#define TS_CONTROLLER_AVGDATA_SHIFT 8
> +#define TS_CONTROLLER_AVGDATA_MASK (0x7 << TS_CONTROLLER_AVGDATA_SHIFT)
> +#define TS_CONTROLLER_PWR_LDO   (1<<5)
> +#define TS_CONTROLLER_PWR_ADC   (1<<4)
> +#define TS_CONTROLLER_PWR_BGP   (1<<3)
> +#define TS_CONTROLLER_PWR_TS    (1<<2)
> +#define TS_WIRE_MODE_BIT        (1<<1)

Be nicer to use the same spacing around <<
or maybe use the BIT macro.

[]

> +static int get_tsc_config(struct device_node *np, struct iproc_ts_priv *priv)
> +{
> +	int ret;
> +	u32 val;
> +	struct device *dev = &priv->pdev->dev;
> +
> +	priv->cfg_params = default_config;
> +
> +	ret = of_property_read_u32(np, "scanning_period", &val);
> +	if (ret >= 0) {
> +		if ((1 <= val) && (val <= 256))
> +			priv->cfg_params.scanning_period = val;
> +		else {
> +			dev_err(dev, "scanning_period must be [1-256]");
> +			return -EINVAL;
> +		}

ret is never used so I'd probably remove it
from all these blocks.

It's probably be nicer to invert the logic ald
remove the else.

There's a missing terminating newline too.

Something like:

	if (of_property_read_u32(np, "scanning_period", &val) >= 0) {
		if (val < 1 || val > 256) {
			dev_err(dev, "scanning_period must be [1-256]\n");
			return -EINVAL;
		}
		priv->cfg_params.scanning_period = val;
	}

etc...
