From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] regulator: qcom_rpm-regulator: Add
 support for pm8018 rpm regulator
Date: Fri, 17 Jun 2016 09:53:52 -0700
Message-ID: <20160617165352.GA1256@tuxbot>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-6-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBC2JZN6WSAHRBJGWSC5QKGQEPUOLHOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1466158929-19524-6-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:

> In order to support eh Qualcomm MDM9615 SoC, add support for the
> PM8018 RPM regulator in the qcom_rpm-regulator driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
[..]
> diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
[..]
> +/**
> + * enum rpm_vreg_voltage_corner - possible voltage corner values
> + *
> + * These should be used in regulator_set_voltage and rpm_vreg_set_voltage calls
> + * for corner type regulators as if they had units of uV.
> + */
> +enum rpm_vreg_voltage_corner {
> +	RPM_VREG_CORNER_NONE = 1,
> +	RPM_VREG_CORNER_LOW,
> +	RPM_VREG_CORNER_NOMINAL,
> +	RPM_VREG_CORNER_HIGH,
> +};
> +
> +static struct regulator_linear_range corner_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(RPM_VREG_CORNER_NONE, 0,
> +				RPM_VREG_CORNER_HIGH, 1),
> +};
> +
>  static int rpm_reg_write(struct qcom_rpm_reg *vreg,
[..]
> +
> +static const struct qcom_rpm_reg pm8018_corner = {
> +	.desc.linear_ranges = corner_ranges,
> +	.desc.n_linear_ranges = ARRAY_SIZE(corner_ranges),
> +	.desc.n_voltages = 4,
> +	.desc.ops = &uV_ops,
> +	.parts = &rpm8018_corner_parts,
> +};
> +
[..]
> +static const struct rpm_regulator_data rpm_pm8018_regulators[] = {
[..]
> +	{ "dig_corner", QCOM_RPM_VOLTAGE_CORNER, &pm8018_corner,
> +						      "vdd_dig_corner" },
> +
> +	{ }
> +};

We have discussed the corners for a long time and I think we've
concluded that they should be exposed as something like an OPP. What we
have agreed on is that they should not be exposed as a regulator with
voltages 1-4uV.

So please drop the corner for now.

Regards,
Bjorn

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
