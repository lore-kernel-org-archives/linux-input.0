From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: pmic8xxx-pwrkey - Support shutdown
Date: Mon, 13 Jul 2015 17:25:04 -0700
Message-ID: <20150714002504.GC7945@dtor-ws>
References: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Bjorn Andersson <bjorn.andersson@sonymobile.com>
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On Mon, Jul 13, 2015 at 04:30:34PM -0700, Stephen Boyd wrote:
> On pm8xxx PMICs, shutdown and restart are signaled to the PMIC
> via a pin called PS_HOLD. When this pin goes low, the PMIC
> performs a configurable power sequence. Add a .shutdown hook so
> that we can properly configure this power sequence for shutdown
> or restart depending on the system state.

Just a bit of bikeshedding on my part...

> 
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/input/misc/pmic8xxx-pwrkey.c | 284 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 277 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
> index c4ca20e63221..1d1ee5951b3a 100644
> --- a/drivers/input/misc/pmic8xxx-pwrkey.c
> +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
> @@ -20,17 +20,72 @@
>  #include <linux/regmap.h>
>  #include <linux/log2.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #define PON_CNTL_1 0x1C
>  #define PON_CNTL_PULL_UP BIT(7)
>  #define PON_CNTL_TRIG_DELAY_MASK (0x7)
> +#define PON_CNTL_1_PULL_UP_EN			0xe0
> +#define PON_CNTL_1_USB_PWR_EN			0x10
> +#define PON_CNTL_1_WD_EN_RESET			0x08
> +
> +#define PM8058_SLEEP_CTRL			0x02b
> +#define PM8921_SLEEP_CTRL			0x10a
> +
> +#define SLEEP_CTRL_SMPL_EN_RESET		0x04
> +
> +/* Regulator master enable addresses */
> +#define REG_PM8058_VREG_EN_MSM			0x018
> +#define REG_PM8058_VREG_EN_GRP_5_4		0x1C8
> +
> +/* Regulator control registers for shutdown/reset */
> +#define PM8058_S0_CTRL				0x004
> +#define PM8058_S1_CTRL				0x005
> +#define PM8058_S3_CTRL				0x111
> +#define PM8058_L21_CTRL				0x120
> +#define PM8058_L22_CTRL				0x121
> +
> +#define PM8058_REGULATOR_ENABLE_MASK		0x80
> +#define PM8058_REGULATOR_ENABLE			0x80
> +#define PM8058_REGULATOR_DISABLE		0x00
> +#define PM8058_REGULATOR_PULL_DOWN_MASK		0x40
> +#define PM8058_REGULATOR_PULL_DOWN_EN		0x40
> +
> +/* Buck CTRL register */
> +#define PM8058_SMPS_LEGACY_VREF_SEL		0x20
> +#define PM8058_SMPS_LEGACY_VPROG_MASK		0x1F
> +#define PM8058_SMPS_ADVANCED_BAND_MASK		0xC0
> +#define PM8058_SMPS_ADVANCED_BAND_SHIFT		6
> +#define PM8058_SMPS_ADVANCED_VPROG_MASK		0x3F
> +
> +/* Buck TEST2 registers for shutdown/reset */
> +#define PM8058_S0_TEST2				0x084
> +#define PM8058_S1_TEST2				0x085
> +#define PM8058_S3_TEST2				0x11A
> +
> +#define PM8058_REGULATOR_BANK_WRITE		0x80
> +#define PM8058_REGULATOR_BANK_MASK		0x70
> +#define PM8058_REGULATOR_BANK_SHIFT		4
> +#define PM8058_REGULATOR_BANK_SEL(n)	((n) << PM8058_REGULATOR_BANK_SHIFT)
> +
> +/* Buck TEST2 register bank 1 */
> +#define PM8058_SMPS_LEGACY_VLOW_SEL		0x01
> +
> +/* Buck TEST2 register bank 7 */
> +#define PM8058_SMPS_ADVANCED_MODE_MASK		0x02
> +#define PM8058_SMPS_ADVANCED_MODE		0x02
> +#define PM8058_SMPS_LEGACY_MODE			0x00
>  
>  /**
>   * struct pmic8xxx_pwrkey - pmic8xxx pwrkey information
>   * @key_press_irq: key press irq number
> + * @regmap: device regmap
> + * @shutdown_fn: shutdown configuration function
>   */
>  struct pmic8xxx_pwrkey {
>  	int key_press_irq;
> +	struct regmap *regmap;
> +	int (*shutdown_fn)(struct pmic8xxx_pwrkey *, bool);
>  };
>  
>  static irqreturn_t pwrkey_press_irq(int irq, void *_pwr)
> @@ -76,6 +131,220 @@ static int __maybe_unused pmic8xxx_pwrkey_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(pm8xxx_pwr_key_pm_ops,
>  		pmic8xxx_pwrkey_suspend, pmic8xxx_pwrkey_resume);
>  
> +static void pmic8xxx_pwrkey_shutdown(struct platform_device *pdev)
> +{
> +	struct pmic8xxx_pwrkey *pwrkey = platform_get_drvdata(pdev);
> +	int ret;
> +	u8 mask, val;
> +	bool reset = system_state == SYSTEM_RESTART;
> +
> +	if (pwrkey->shutdown_fn) {
> +		ret = pwrkey->shutdown_fn(pwrkey, reset);
> +		if (ret)
> +			return;

Can we call this variable "error" please?

> +	}
> +
> +	/*
> +	 * Select action to perform (reset or shutdown) when PS_HOLD goes low.
> +	 * Also ensure that KPD, CBL0, and CBL1 pull ups are enabled and that
> +	 * USB charging is enabled.
> +	 */
> +	mask = PON_CNTL_1_PULL_UP_EN | PON_CNTL_1_USB_PWR_EN;
> +	mask |= PON_CNTL_1_WD_EN_RESET;
> +	val = mask;
> +	if (!reset)
> +		val &= ~PON_CNTL_1_WD_EN_RESET;
> +
> +	regmap_update_bits(pwrkey->regmap, PON_CNTL_1, mask, val);
> +}
> +
> +/*
> + * Set an SMPS regulator to be disabled in its CTRL register, but enabled
> + * in the master enable register.  Also set it's pull down enable bit.
> + * Take care to make sure that the output voltage doesn't change if switching
> + * from advanced mode to legacy mode.
> + */
> +static int pm8058_disable_smps_locally_set_pull_down(struct regmap *regmap,
> +	u16 ctrl_addr, u16 test2_addr, u16 master_enable_addr,
> +	u8 master_enable_bit)
> +{
> +	int ret = 0;

Why does it need to be initialized? And "error" too please.

> +	u8 vref_sel, vlow_sel, band, vprog, bank;
> +	unsigned int reg;
> +
> +	bank = PM8058_REGULATOR_BANK_SEL(7);
> +	ret = regmap_write(regmap, test2_addr, bank);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(regmap, test2_addr, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg &= PM8058_SMPS_ADVANCED_MODE_MASK;
> +	/* Check if in advanced mode. */
> +	if (reg == PM8058_SMPS_ADVANCED_MODE) {
> +		/* Determine current output voltage. */
> +		ret = regmap_read(regmap, ctrl_addr, &reg);
> +		if (ret)
> +			return ret;
> +
> +		band = reg & PM8058_SMPS_ADVANCED_BAND_MASK;
> +		band >>= PM8058_SMPS_ADVANCED_BAND_SHIFT;
> +		switch (band) {
> +		case 3:
> +			vref_sel = 0;
> +			vlow_sel = 0;
> +			break;
> +		case 2:
> +			vref_sel = PM8058_SMPS_LEGACY_VREF_SEL;
> +			vlow_sel = 0;
> +			break;
> +		case 1:
> +			vref_sel = PM8058_SMPS_LEGACY_VREF_SEL;
> +			vlow_sel = PM8058_SMPS_LEGACY_VLOW_SEL;
> +			break;
> +		default:
> +			pr_err("%s: regulator already disabled\n", __func__);
> +			return -EPERM;
> +		}
> +		vprog = reg & PM8058_SMPS_ADVANCED_VPROG_MASK;
> +		/* Round up if fine step is in use. */
> +		vprog = (vprog + 1) >> 1;
> +		if (vprog > PM8058_SMPS_LEGACY_VPROG_MASK)
> +			vprog = PM8058_SMPS_LEGACY_VPROG_MASK;
> +
> +		/* Set VLOW_SEL bit. */
> +		bank = PM8058_REGULATOR_BANK_SEL(1);
> +		ret = regmap_write(regmap, test2_addr, bank);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(regmap, test2_addr,
> +			PM8058_REGULATOR_BANK_WRITE | PM8058_REGULATOR_BANK_MASK
> +				| PM8058_SMPS_LEGACY_VLOW_SEL,
> +			PM8058_REGULATOR_BANK_WRITE |
> +			PM8058_REGULATOR_BANK_SEL(1) | vlow_sel);
> +		if (ret)
> +			return ret;
> +
> +		/* Switch to legacy mode */
> +		bank = PM8058_REGULATOR_BANK_SEL(7);
> +		ret = regmap_write(regmap, test2_addr, bank);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(regmap, test2_addr,
> +				PM8058_REGULATOR_BANK_WRITE |
> +				PM8058_REGULATOR_BANK_MASK |
> +				PM8058_SMPS_ADVANCED_MODE_MASK,
> +				PM8058_REGULATOR_BANK_WRITE |
> +				PM8058_REGULATOR_BANK_SEL(7) |
> +				PM8058_SMPS_LEGACY_MODE);
> +		if (ret)
> +			return ret;
> +
> +		/* Enable locally, enable pull down, keep voltage the same. */
> +		ret = regmap_update_bits(regmap, ctrl_addr,
> +			PM8058_REGULATOR_ENABLE_MASK |
> +			PM8058_REGULATOR_PULL_DOWN_MASK |
> +			PM8058_SMPS_LEGACY_VREF_SEL |
> +			PM8058_SMPS_LEGACY_VPROG_MASK,
> +			PM8058_REGULATOR_ENABLE | PM8058_REGULATOR_PULL_DOWN_EN
> +				| vref_sel | vprog);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Enable in master control register. */
> +	ret = regmap_update_bits(regmap, master_enable_addr,
> +			master_enable_bit, master_enable_bit);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable locally and enable pull down. */
> +	return regmap_update_bits(regmap, ctrl_addr,
> +		PM8058_REGULATOR_ENABLE_MASK | PM8058_REGULATOR_PULL_DOWN_MASK,
> +		PM8058_REGULATOR_DISABLE | PM8058_REGULATOR_PULL_DOWN_EN);
> +}
> +
> +static int pm8058_disable_ldo_locally_set_pull_down(struct regmap *regmap,
> +		u16 ctrl_addr, u16 master_enable_addr, u8 master_enable_bit)
> +{
> +	int ret;

Here too.

> +
> +	/* Enable LDO in master control register. */
> +	ret = regmap_update_bits(regmap, master_enable_addr,
> +			master_enable_bit, master_enable_bit);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable LDO in CTRL register and set pull down */
> +	return regmap_update_bits(regmap, ctrl_addr,
> +		PM8058_REGULATOR_ENABLE_MASK | PM8058_REGULATOR_PULL_DOWN_MASK,
> +		PM8058_REGULATOR_DISABLE | PM8058_REGULATOR_PULL_DOWN_EN);
> +}
> +
> +static int pm8058_pwrkey_shutdown(struct pmic8xxx_pwrkey *pwrkey, bool reset)
> +{
> +	int ret;

And here.

> +	struct regmap *regmap = pwrkey->regmap;
> +	u8 mask, val;
> +
> +	/* When shutting down, enable active pulldowns on important rails. */
> +	if (!reset) {
> +		/* Disable SMPS's 0,1,3 locally and set pulldown enable bits. */
> +		pm8058_disable_smps_locally_set_pull_down(regmap,
> +			PM8058_S0_CTRL, PM8058_S0_TEST2,
> +			REG_PM8058_VREG_EN_MSM, BIT(7));
> +		pm8058_disable_smps_locally_set_pull_down(regmap,
> +			PM8058_S1_CTRL, PM8058_S1_TEST2,
> +			REG_PM8058_VREG_EN_MSM, BIT(6));
> +		pm8058_disable_smps_locally_set_pull_down(regmap,
> +			PM8058_S3_CTRL, PM8058_S3_TEST2,
> +			REG_PM8058_VREG_EN_GRP_5_4, BIT(7) | BIT(4));
> +		/* Disable LDO 21 locally and set pulldown enable bit. */
> +		pm8058_disable_ldo_locally_set_pull_down(regmap,
> +			PM8058_L21_CTRL, REG_PM8058_VREG_EN_GRP_5_4,
> +			BIT(1));
> +	}
> +
> +	/*
> +	 * Fix-up: Set regulator LDO22 to 1.225 V in high power mode. Leave its
> +	 * pull-down state intact. This ensures a safe shutdown.
> +	 */
> +	ret = regmap_update_bits(regmap, PM8058_L22_CTRL, 0xbf, 0x93);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable SMPL if resetting is desired */
> +	mask = SLEEP_CTRL_SMPL_EN_RESET;
> +	val = 0;
> +	if (reset)
> +		val = mask;
> +	return regmap_update_bits(regmap, PM8058_SLEEP_CTRL, mask, val);
> +

Stray empty line.

> +}
> +
> +static int pm8921_pwrkey_shutdown(struct pmic8xxx_pwrkey *pwrkey, bool reset)
> +{
> +	struct regmap *regmap = pwrkey->regmap;
> +	u8 mask = SLEEP_CTRL_SMPL_EN_RESET;
> +	u8 val = 0;
> +
> +	/* Enable SMPL if resetting is desired */
> +	if (reset)
> +		val = mask;
> +	return regmap_update_bits(regmap, PM8921_SLEEP_CTRL, mask, val);
> +}
> +
> +static const struct of_device_id pm8xxx_pwr_key_id_table[] = {
> +	{ .compatible = "qcom,pm8058-pwrkey", .data = &pm8058_pwrkey_shutdown },
> +	{ .compatible = "qcom,pm8921-pwrkey", .data = &pm8921_pwrkey_shutdown },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pm8xxx_pwr_key_id_table);
> +

Can we please keep IDs and device table where it was, close to the
driver definition?

>  static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>  {
>  	struct input_dev *pwr;
> @@ -88,6 +357,11 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>  	struct pmic8xxx_pwrkey *pwrkey;
>  	u32 kpd_delay;
>  	bool pull_up;
> +	const struct of_device_id *match;
> +
> +	match = of_match_device(pm8xxx_pwr_key_id_table, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;
>  
>  	if (of_property_read_u32(pdev->dev.of_node, "debounce", &kpd_delay))
>  		kpd_delay = 15625;
> @@ -109,6 +383,8 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>  	if (!pwrkey)
>  		return -ENOMEM;
>  
> +	pwrkey->shutdown_fn = match->data;
> +	pwrkey->regmap = regmap;
>  	pwrkey->key_press_irq = key_press_irq;
>  
>  	pwr = devm_input_allocate_device(&pdev->dev);
> @@ -181,16 +457,10 @@ static int pmic8xxx_pwrkey_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id pm8xxx_pwr_key_id_table[] = {
> -	{ .compatible = "qcom,pm8058-pwrkey" },
> -	{ .compatible = "qcom,pm8921-pwrkey" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, pm8xxx_pwr_key_id_table);
> -
>  static struct platform_driver pmic8xxx_pwrkey_driver = {
>  	.probe		= pmic8xxx_pwrkey_probe,
>  	.remove		= pmic8xxx_pwrkey_remove,
> +	.shutdown	= pmic8xxx_pwrkey_shutdown,
>  	.driver		= {
>  		.name	= "pm8xxx-pwrkey",
>  		.pm	= &pm8xxx_pwr_key_pm_ops,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

Thanks.

-- 
Dmitry
