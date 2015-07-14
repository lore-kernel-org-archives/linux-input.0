From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: pmic8xxx-pwrkey - Support shutdown
Date: Mon, 13 Jul 2015 17:46:38 -0700
Message-ID: <20150714004638.GD7945@dtor-ws>
References: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org>
 <20150714002504.GC7945@dtor-ws>
 <55A45931.4010509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33233 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbGNAqn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 20:46:43 -0400
Content-Disposition: inline
In-Reply-To: <55A45931.4010509@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Bjorn Andersson <bjorn.andersson@sonymobile.com>

On Mon, Jul 13, 2015 at 05:34:57PM -0700, Stephen Boyd wrote:
> On 07/13/2015 05:25 PM, Dmitry Torokhov wrote:
> 
> >>@@ -76,6 +131,220 @@ static int __maybe_unused pmic8xxx_pwrkey_resume(struct device *dev)
> >>  static SIMPLE_DEV_PM_OPS(pm8xxx_pwr_key_pm_ops,
> >>  		pmic8xxx_pwrkey_suspend, pmic8xxx_pwrkey_resume);
> >>+static void pmic8xxx_pwrkey_shutdown(struct platform_device *pdev)
> >>+{
> >>+	struct pmic8xxx_pwrkey *pwrkey = platform_get_drvdata(pdev);
> >>+	int ret;
> >>+	u8 mask, val;
> >>+	bool reset = system_state == SYSTEM_RESTART;
> >>+
> >>+	if (pwrkey->shutdown_fn) {
> >>+		ret = pwrkey->shutdown_fn(pwrkey, reset);
> >>+		if (ret)
> >>+			return;
> >Can we call this variable "error" please?
> 
> Ok.
> 
> >
> >>+	}
> >>+
> >>+	/*
> >>+	 * Select action to perform (reset or shutdown) when PS_HOLD goes low.
> >>+	 * Also ensure that KPD, CBL0, and CBL1 pull ups are enabled and that
> >>+	 * USB charging is enabled.
> >>+	 */
> >>+	mask = PON_CNTL_1_PULL_UP_EN | PON_CNTL_1_USB_PWR_EN;
> >>+	mask |= PON_CNTL_1_WD_EN_RESET;
> >>+	val = mask;
> >>+	if (!reset)
> >>+		val &= ~PON_CNTL_1_WD_EN_RESET;
> >>+
> >>+	regmap_update_bits(pwrkey->regmap, PON_CNTL_1, mask, val);
> >>+}
> >>+
> >>+/*
> >>+ * Set an SMPS regulator to be disabled in its CTRL register, but enabled
> >>+ * in the master enable register.  Also set it's pull down enable bit.
> >>+ * Take care to make sure that the output voltage doesn't change if switching
> >>+ * from advanced mode to legacy mode.
> >>+ */
> >>+static int pm8058_disable_smps_locally_set_pull_down(struct regmap *regmap,
> >>+	u16 ctrl_addr, u16 test2_addr, u16 master_enable_addr,
> >>+	u8 master_enable_bit)
> >>+{
> >>+	int ret = 0;
> >Why does it need to be initialized? And "error" too please.
> 
> Doesn't need to be.
> 
> >
> >>+
> >>+	/* Enable LDO in master control register. */
> >>+	ret = regmap_update_bits(regmap, master_enable_addr,
> >>+			master_enable_bit, master_enable_bit);
> >>+	if (ret)
> >>+		return ret;
> >>+
> >>+	/* Disable LDO in CTRL register and set pull down */
> >>+	return regmap_update_bits(regmap, ctrl_addr,
> >>+		PM8058_REGULATOR_ENABLE_MASK | PM8058_REGULATOR_PULL_DOWN_MASK,
> >>+		PM8058_REGULATOR_DISABLE | PM8058_REGULATOR_PULL_DOWN_EN);
> >>+}
> >>+
> >>+static int pm8058_pwrkey_shutdown(struct pmic8xxx_pwrkey *pwrkey, bool reset)
> >>+{
> >>+	int ret;
> >And here.
> 
> Ok.
> 
> >
> >>+	struct regmap *regmap = pwrkey->regmap;
> >>+	u8 mask, val;
> >>+
> >>+	/* When shutting down, enable active pulldowns on important rails. */
> >>+	if (!reset) {
> >>+		/* Disable SMPS's 0,1,3 locally and set pulldown enable bits. */
> >>+		pm8058_disable_smps_locally_set_pull_down(regmap,
> >>+			PM8058_S0_CTRL, PM8058_S0_TEST2,
> >>+			REG_PM8058_VREG_EN_MSM, BIT(7));
> >>+		pm8058_disable_smps_locally_set_pull_down(regmap,
> >>+			PM8058_S1_CTRL, PM8058_S1_TEST2,
> >>+			REG_PM8058_VREG_EN_MSM, BIT(6));
> >>+		pm8058_disable_smps_locally_set_pull_down(regmap,
> >>+			PM8058_S3_CTRL, PM8058_S3_TEST2,
> >>+			REG_PM8058_VREG_EN_GRP_5_4, BIT(7) | BIT(4));
> >>+		/* Disable LDO 21 locally and set pulldown enable bit. */
> >>+		pm8058_disable_ldo_locally_set_pull_down(regmap,
> >>+			PM8058_L21_CTRL, REG_PM8058_VREG_EN_GRP_5_4,
> >>+			BIT(1));
> >>+	}
> >>+
> >>+	/*
> >>+	 * Fix-up: Set regulator LDO22 to 1.225 V in high power mode. Leave its
> >>+	 * pull-down state intact. This ensures a safe shutdown.
> >>+	 */
> >>+	ret = regmap_update_bits(regmap, PM8058_L22_CTRL, 0xbf, 0x93);
> >>+	if (ret)
> >>+		return ret;
> >>+
> >>+	/* Enable SMPL if resetting is desired */
> >>+	mask = SLEEP_CTRL_SMPL_EN_RESET;
> >>+	val = 0;
> >>+	if (reset)
> >>+		val = mask;
> >>+	return regmap_update_bits(regmap, PM8058_SLEEP_CTRL, mask, val);
> >>+
> >Stray empty line.
> 
> Ok.
> 
> >
> >>+}
> >>+
> >>+static int pm8921_pwrkey_shutdown(struct pmic8xxx_pwrkey *pwrkey, bool reset)
> >>+{
> >>+	struct regmap *regmap = pwrkey->regmap;
> >>+	u8 mask = SLEEP_CTRL_SMPL_EN_RESET;
> >>+	u8 val = 0;
> >>+
> >>+	/* Enable SMPL if resetting is desired */
> >>+	if (reset)
> >>+		val = mask;
> >>+	return regmap_update_bits(regmap, PM8921_SLEEP_CTRL, mask, val);
> >>+}
> >>+
> >>+static const struct of_device_id pm8xxx_pwr_key_id_table[] = {
> >>+	{ .compatible = "qcom,pm8058-pwrkey", .data = &pm8058_pwrkey_shutdown },
> >>+	{ .compatible = "qcom,pm8921-pwrkey", .data = &pm8921_pwrkey_shutdown },
> >>+	{ }
> >>+};
> >>+MODULE_DEVICE_TABLE(of, pm8xxx_pwr_key_id_table);
> >>+
> >Can we please keep IDs and device table where it was, close to the
> >driver definition?
> 
> That would require forward declaring the array here. Is that
> desired? I moved it so that I could use it in the probe function.

Ah, yes, OF data is not passed into probe() :(... But we can always do:

	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);

Maybe we could have a helper for this like:

const struct of_device_id *of_get_current_match(struct device *dev)
{
	return dev->drv ?
		of_match_device(dev->driver->of_match_table, dev) :
		NULL;
}

Thanks.

-- 
Dmitry
