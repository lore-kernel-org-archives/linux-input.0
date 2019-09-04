From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3] input: keyboard: snvs_pwrkey: Send key events for
 i.MX6 S, DL and Q
Date: Wed, 4 Sep 2019 08:52:48 +0200
Message-ID: <20190904065248.4i7q2vuxxt2xdnrr@pengutronix.de>
References: <20190904062329.97520-1-robin@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190904062329.97520-1-robin@protonic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin van der Gracht <robin@protonic.nl>
Cc: "linux-input @ vger . kernel . org" <linux-input@vger.kernel.org>, "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, RobinGong <yibin.gong@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Adam Ford <aford173@gmail.com>, "linux-arm-kernel @ lists . infradead . org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Hi Robin,

thanks for the patch it looks quite good, just two minor nitpicks.

On 19-09-04 06:23, Robin van der Gracht wrote:
> The first generation i.MX6 processors does not send an interrupt when the
> power key is pressed. It sends a power down request interrupt if the key is
> released before a hard shutdown (5 second press). This should allow
> software to bring down the SoC safely.
> 
> For this driver to work as a regular power key with the older SoCs, we need
> to send a keypress AND release when we get the power down request irq.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> ---
> 
> Changes v2 -> v3:
>  - Drop alt compatible string for identifying first revision snvs hardware,
>    read minor revision from register instead.
>  - Drop imx6qdl.dtsi modification and device-tree binding documentation.
>  - Add an additional input_sync() to create 2 seperate input reports for press
>    and release.
> 
>  drivers/input/keyboard/Kconfig       |  2 +-
>  drivers/input/keyboard/snvs_pwrkey.c | 28 ++++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 7c4f19dab34f..937e58da5ce1 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -436,7 +436,7 @@ config KEYBOARD_SNVS_PWRKEY
>  	depends on OF
>  	help
>  	  This is the snvs powerkey driver for the Freescale i.MX application
> -	  processors that are newer than i.MX6 SX.
> +	  processors.
>  
>  	  To compile this driver as a module, choose M here; the
>  	  module will be called snvs_pwrkey.
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 5342d8d45f81..828580eee0d2 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -19,6 +19,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  
> +#define SNVS_HPVIDR1_REG 0xF8
>  #define SNVS_LPSR_REG	0x4C	/* LP Status Register */
>  #define SNVS_LPCR_REG	0x38	/* LP Control Register */
>  #define SNVS_HPSR_REG	0x14
> @@ -37,6 +38,7 @@ struct pwrkey_drv_data {
>  	int wakeup;
>  	struct timer_list check_timer;
>  	struct input_dev *input;
> +	u8 minor_rev;
>  };
>  
>  static void imx_imx_snvs_check_for_events(struct timer_list *t)
> @@ -45,6 +47,20 @@ static void imx_imx_snvs_check_for_events(struct timer_list *t)
>  	struct input_dev *input = pdata->input;
>  	u32 state;
>  
> +	if (pdata->minor_rev == 0) {

Should we use a define here and ..

> +		/*
> +		 * The first generation i.MX6 SoCs only sends an interrupt on
> +		 * button release. To mimic power-key usage, we'll prepend a
> +		 * press event.
> +		 */
> +		input_report_key(input, pdata->keycode, 1);
> +		input_sync(input);
> +		input_report_key(input, pdata->keycode, 0);
> +		input_sync(input);
> +		pm_relax(input->dev.parent);
> +		return;
> +	}
> +
>  	regmap_read(pdata->snvs, SNVS_HPSR_REG, &state);
>  	state = state & SNVS_HPSR_BTN ? 1 : 0;
>  
> @@ -67,13 +83,17 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
>  {
>  	struct platform_device *pdev = dev_id;
>  	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +	unsigned long expire = jiffies;
>  	u32 lp_status;
>  
>  	pm_wakeup_event(pdata->input->dev.parent, 0);
>  
>  	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
> -	if (lp_status & SNVS_LPSR_SPO)
> -		mod_timer(&pdata->check_timer, jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
> +	if (lp_status & SNVS_LPSR_SPO) {
> +		if (pdata->minor_rev > 0)

here? Just a nitpick, feel free to add/drop it.

> +			expire = jiffies + msecs_to_jiffies(DEBOUNCE_TIME);
> +		mod_timer(&pdata->check_timer, expire);
> +	}
>  
>  	/* clear SPO status */
>  	regmap_write(pdata->snvs, SNVS_LPSR_REG, SNVS_LPSR_SPO);
> @@ -94,6 +114,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	struct input_dev *input = NULL;
>  	struct device_node *np;
>  	int error;
> +	u32 vid;
>  
>  	/* Get SNVS register Page */
>  	np = pdev->dev.of_node;
> @@ -123,6 +144,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	regmap_read(pdata->snvs, SNVS_HPVIDR1_REG, &vid);

Should we check the return val here?

Regards,
  Marco

> +	pdata->minor_rev = vid & 0xff;
> +
>  	regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_DEP_EN, SNVS_LPCR_DEP_EN);
>  
>  	/* clear the unexpected interrupt before driver ready */
> -- 
> 2.20.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
