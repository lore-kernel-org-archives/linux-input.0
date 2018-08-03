From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v12 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Fri, 3 Aug 2018 14:12:50 +0300
Message-ID: <20180803111250.GC20907@localhost.localdomain>
References: <cover.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
 <4f49022ed8e4fa357bf5d213c57ad57752e72aa4.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f49022ed8e4fa357bf5d213c57ad57752e72aa4.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com, linus.walleij@linaro.org, mazziesaccount@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 03, 2018 at 02:08:14PM +0300, Matti Vaittinen wrote:
> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for three subsystems:
> - clk
> - Regulators
> - input/power-key
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I maintained Enric's Reviewed-by as only change I did to v12 was:

> +	ret = regmap_irq_get_virq(bd71837->irq_data, BD71837_INT_PWRBTN_S);
> +
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to get the IRQ\n");
> +		return ret;
> +	}
> +
> +	button.irq = ret;

instead of v11 which was:

+       button.irq = regmap_irq_get_virq(bd71837->irq_data,
+                                         BD71837_INT_PWRBTN_S);
+
+       if (button.irq < 0) {
+               dev_err(&i2c->dev, "Failed to get the IRQ\n");
+               return button.irq;
+       }

Br,
	Matti Vaittinen
