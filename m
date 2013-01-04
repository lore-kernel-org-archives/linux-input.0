From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/4] input: keyboard: tegra: add support for rows/cols
 configuration from dt
Date: Fri, 04 Jan 2013 12:50:07 -0700
Message-ID: <50E7326F.7090201@wwwdotorg.org>
References: <1357297330-28878-1-git-send-email-ldewangan@nvidia.com> <1357297330-28878-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1357297330-28878-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: dmitry.torokhov@gmail.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, swarren@nvidia.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/04/2013 04:02 AM, Laxman Dewangan wrote:
> The NVIDIA's Tegra KBC has maximum 24 pins to make matrix keypad.
> Any pin can be configured as row or column. The maximum column pin
> can be 8 and maximum row pin can be 16.
> 
> Remove the assumption that all first 16 pins will be used as row
> and remaining as columns and Add the property for configuring pins
> to either row or column from DT. Update the devicetree binding
> document accordingly.

> diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt

>  Required properties:

> +- nvidia,kbc-rows: The KBC pins which are configured as row. This is the
> +  array of pinmnumber.
> +- nvidia,kbc-cols: The KBC pins which are configured as column. This is the
> +  array of pinmnumber.

"the array of pinmnumber" -> "an array of pin numbers"?

I wonder if "row-pins" and "col-pins" would be a better name; "rows" and
"cols" sound like a count not a lines. But perhaps that's just
bike-shedding.

> +	linux,keymap = < 0x00000074
> +			 0x00010067
> +			 0x00020066
> +			 0x01010068
> +			 0x02000069
> +			 0x02010070
> +			 0x02020071 >;

Nit-pick: no space after < or before >. At least, the Tegra DTs are all
currently cleaned up that way.

> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c

> +	/* Set all pins as non-configured */
> +	for (i = 0; i < KBC_MAX_GPIO; i++) {
>  		pdata->pin_cfg[i].num = i;
> +		pdata->pin_cfg[i].type = PIN_CFG_IGNORE;
> +	}
...
> +	for (i = 0; i < num_rows; i++) {
> +		pdata->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
> +		pdata->pin_cfg[rows_cfg[i]].num = i;

If we're setting up "num" here for the valid rows/cols, then why is the
".num = i" assignment needed in the loop above that sets .type = IGNORE?

>  	}
>  
> +	for (i = 0; i < num_cols; i++) {
> +		pdata->pin_cfg[cols_cfg[i]].type = PIN_CFG_COL;
> +		pdata->pin_cfg[cols_cfg[i]].num = i;
>  	}

> -	if (!pdata) {
> +	if (IS_ERR_OR_NULL(pdata)) {
>  		dev_err(&pdev->dev, "Platform data missing\n");
> -		return -EINVAL;
> +		return (pdata) ? PTR_ERR(pdata) : -EINVAL;

No need for () around the first use of pdata there.

