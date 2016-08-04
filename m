From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3 4/4] regulator: qcom_rpm-regulator: Add
 support for pm8018 rpm regulator
Date: Thu, 4 Aug 2016 15:04:56 -0700
Message-ID: <6eb6d742-eca4-a442-cff1-0a26601b362d@codeaurora.org>
References: <1468936286-2710-1-git-send-email-narmstrong@baylibre.com>
 <1468936286-2710-5-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDHZXHXDRAMBBC7YR26QKGQECDOFA3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1468936286-2710-5-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/19/2016 06:51 AM, Neil Armstrong wrote:
> In order to support eh Qualcomm MDM9615 SoC, add support for the

s/eh/the/

> PM8018 RPM regulator in the qcom_rpm-regulator driver.
>
> Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>
> diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
> index e254272..0734a5f 100644
> --- a/drivers/regulator/qcom_rpm-regulator.c
> +++ b/drivers/regulator/qcom_rpm-regulator.c
> @@ -70,6 +70,40 @@ struct qcom_rpm_reg {
>  	bool supports_force_mode_bypass;
>  };
>  
> +static struct rpm_reg_parts rpm8018_ldo_parts = {
> +	.request_len	= 2,
> +	.uV		= { 0, 0x007FFFFF,  0},
> +	.pd		= { 0, 0x00800000, 23},
> +	.pc		= { 0, 0x0F000000, 24},
> +	.pf		= { 0, 0xF0000000, 28},
> +	.ip		= { 1, 0x000003FF,  0},
> +	.ia		= { 1, 0x000FFC00, 10},
> +	.fm		= { 1, 0x00700000, 20},
> +};
> +
> +static struct rpm_reg_parts rpm8018_smps_parts = {
> +	.request_len	= 2,
> +	.uV		= {  0, 0x007FFFFF,  0},
> +	.pd		= {  0, 0x00800000, 23},
> +	.pc		= {  0, 0x0F000000, 24},
> +	.pf		= {  0, 0xF0000000, 28},
> +	.ip		= {  1, 0x000003FF,  0},
> +	.ia		= {  1, 0x000FFC00, 10},
> +	.fm		= {  1, 0x00700000, 20},
> +	.pm		= {  1, 0x00800000, 23},
> +	.freq		= {  1, 0x1F000000, 24},
> +	.freq_clk_src	= {  1, 0x60000000, 29},
> +};
> +
> +static struct rpm_reg_parts rpm8018_switch_parts = {
> +	.request_len	= 1,
> +	.enable_state	= {  0, 0x00000001,  0},
> +	.pd		= {  0, 0x00000002,  1},
> +	.pc		= {  0, 0x0000003C,  2},
> +	.pf		= {  0, 0x000003C0,  6},
> +	.hpm		= {  0, 0x00000C00, 10},
> +};
> +

These are all the same as the rpm8960 ones, so why don't we reuse those
structures?

>  static const struct rpm_reg_parts rpm8660_ldo_parts = {
>  	.request_len    = 2,
>  	.mV             = { 0, 0x00000FFF,  0 },
> @@ -448,6 +482,44 @@ static struct regulator_ops switch_ops = {
>  };
>  
>  /*
> + * PM8018 regulators
> + */
> +static const struct qcom_rpm_reg pm8018_pldo = {
> +	.desc.linear_ranges = pldo_ranges,
> +	.desc.n_linear_ranges = ARRAY_SIZE(pldo_ranges),
> +	.desc.n_voltages = 161,
> +	.desc.ops = &uV_ops,
> +	.parts = &rpm8018_ldo_parts,
> +	.supports_force_mode_auto = false,
> +	.supports_force_mode_bypass = false,
> +};
> +
> +static const struct qcom_rpm_reg pm8018_nldo = {
> +	.desc.linear_ranges = nldo_ranges,
> +	.desc.n_linear_ranges = ARRAY_SIZE(nldo_ranges),
> +	.desc.n_voltages = 64,
> +	.desc.ops = &uV_ops,
> +	.parts = &rpm8018_ldo_parts,
> +	.supports_force_mode_auto = false,
> +	.supports_force_mode_bypass = false,
> +};
> +
> +static const struct qcom_rpm_reg pm8018_smps = {
> +	.desc.linear_ranges = smps_ranges,
> +	.desc.n_linear_ranges = ARRAY_SIZE(smps_ranges),
> +	.desc.n_voltages = 154,
> +	.desc.ops = &uV_ops,
> +	.parts = &rpm8018_smps_parts,
> +	.supports_force_mode_auto = false,
> +	.supports_force_mode_bypass = false,
> +};
> +
> +static const struct qcom_rpm_reg pm8018_switch = {
> +	.desc.ops = &switch_ops,
> +	.parts = &rpm8018_switch_parts,
> +};
> +

These are all the same as the pm8921 ones too? So just use those instead?

We should probably rethink this design and have these structures based
on PMIC derivatives instead of SoCs because things are quite similar
across many PMICs.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
