From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 4/4] regulator: qcom_rpm-regulator: Add support
 for pm8018 rpm regulator
Date: Thu, 11 Aug 2016 15:16:46 +0200
Message-ID: <1470921406-18468-5-git-send-email-narmstrong@baylibre.com>
References: <1470921406-18468-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDAYD2P3QYGRBR7VWG6QKGQEFDNNSNI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1470921406-18468-1-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

In order to support the Qualcomm MDM9615 SoC, add support for the
PM8018 RPM regulator in the qcom_rpm-regulator driver.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 14 +++++
 drivers/regulator/qcom_rpm-regulator.c             | 66 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
index 72d68d4..485bc59 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
@@ -60,6 +60,7 @@ Regulator nodes are identified by their compatible:
 		    "qcom,rpm-pm8058-regulators"
 		    "qcom,rpm-pm8901-regulators"
 		    "qcom,rpm-pm8921-regulators"
+		    "qcom,rpm-pm8018-regulators"
 
 - vdd_l0_l1_lvs-supply:
 - vdd_l2_l11_l12-supply:
@@ -138,6 +139,15 @@ Regulator nodes are identified by their compatible:
 	Definition: reference to regulator supplying the input pin, as
 		    described in the data sheet
 
+- vin_lvs1-supply:
+- vdd_l7-supply:
+- vdd_l8-supply:
+- vdd_l9_l10_l11_l12-supply:
+	Usage: optional (pm8018 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
 The regulator node houses sub-nodes for each regulator within the device. Each
 sub-node is identified using the node's name, with valid values listed for each
 of the pmics below.
@@ -157,6 +167,10 @@ pm8921:
 	l29, lvs1, lvs2, lvs3, lvs4, lvs5, lvs6, lvs7, usb-switch, hdmi-switch,
 	ncp
 
+pm8018:
+	s1, s2, s3, s4, s5, , l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
+	l12, l14, lvs1
+
 The content of each sub-node is defined by the standard binding for regulators -
 see regulator.txt - with additional custom properties described below:
 
diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index e254272..1b2acc4 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -448,6 +448,44 @@ static struct regulator_ops switch_ops = {
 };
 
 /*
+ * PM8018 regulators
+ */
+static const struct qcom_rpm_reg pm8018_pldo = {
+	.desc.linear_ranges = pldo_ranges,
+	.desc.n_linear_ranges = ARRAY_SIZE(pldo_ranges),
+	.desc.n_voltages = 161,
+	.desc.ops = &uV_ops,
+	.parts = &rpm8960_ldo_parts,
+	.supports_force_mode_auto = false,
+	.supports_force_mode_bypass = false,
+};
+
+static const struct qcom_rpm_reg pm8018_nldo = {
+	.desc.linear_ranges = nldo_ranges,
+	.desc.n_linear_ranges = ARRAY_SIZE(nldo_ranges),
+	.desc.n_voltages = 64,
+	.desc.ops = &uV_ops,
+	.parts = &rpm8960_ldo_parts,
+	.supports_force_mode_auto = false,
+	.supports_force_mode_bypass = false,
+};
+
+static const struct qcom_rpm_reg pm8018_smps = {
+	.desc.linear_ranges = smps_ranges,
+	.desc.n_linear_ranges = ARRAY_SIZE(smps_ranges),
+	.desc.n_voltages = 154,
+	.desc.ops = &uV_ops,
+	.parts = &rpm8960_smps_parts,
+	.supports_force_mode_auto = false,
+	.supports_force_mode_bypass = false,
+};
+
+static const struct qcom_rpm_reg pm8018_switch = {
+	.desc.ops = &switch_ops,
+	.parts = &rpm8960_switch_parts,
+};
+
+/*
  * PM8058 regulators
  */
 static const struct qcom_rpm_reg pm8058_pldo = {
@@ -755,6 +793,32 @@ struct rpm_regulator_data {
 	const char *supply;
 };
 
+static const struct rpm_regulator_data rpm_pm8018_regulators[] = {
+	{ "s1",  QCOM_RPM_PM8018_SMPS1, &pm8018_smps, "vdd_s1" },
+	{ "s2",  QCOM_RPM_PM8018_SMPS2, &pm8018_smps, "vdd_s2" },
+	{ "s3",  QCOM_RPM_PM8018_SMPS3, &pm8018_smps, "vdd_s3" },
+	{ "s4",  QCOM_RPM_PM8018_SMPS4, &pm8018_smps, "vdd_s4" },
+	{ "s5",  QCOM_RPM_PM8018_SMPS5, &pm8018_smps, "vdd_s5" },
+
+	{ "l2",  QCOM_RPM_PM8018_LDO2,  &pm8018_pldo, "vdd_l2" },
+	{ "l3",  QCOM_RPM_PM8018_LDO3,  &pm8018_pldo, "vdd_l3" },
+	{ "l4",  QCOM_RPM_PM8018_LDO4,  &pm8018_pldo, "vdd_l4" },
+	{ "l5",  QCOM_RPM_PM8018_LDO5,  &pm8018_pldo, "vdd_l5" },
+	{ "l6",  QCOM_RPM_PM8018_LDO6,  &pm8018_pldo, "vdd_l7" },
+	{ "l7",  QCOM_RPM_PM8018_LDO7,  &pm8018_pldo, "vdd_l7" },
+	{ "l8",  QCOM_RPM_PM8018_LDO8,  &pm8018_nldo, "vdd_l8" },
+	{ "l9",  QCOM_RPM_PM8018_LDO9,  &pm8921_nldo1200,
+						      "vdd_l9_l10_l11_l12" },
+	{ "l10", QCOM_RPM_PM8018_LDO10, &pm8018_nldo, "vdd_l9_l10_l11_l12" },
+	{ "l11", QCOM_RPM_PM8018_LDO11, &pm8018_nldo, "vdd_l9_l10_l11_l12" },
+	{ "l12", QCOM_RPM_PM8018_LDO12, &pm8018_nldo, "vdd_l9_l10_l11_l12" },
+	{ "l14", QCOM_RPM_PM8018_LDO14, &pm8018_pldo, "vdd_l14" },
+
+	{ "lvs1", QCOM_RPM_PM8018_LVS1, &pm8018_switch, "lvs1_in" },
+
+	{ }
+};
+
 static const struct rpm_regulator_data rpm_pm8058_regulators[] = {
 	{ "l0",   QCOM_RPM_PM8058_LDO0,   &pm8058_nldo, "vdd_l0_l1_lvs"	},
 	{ "l1",   QCOM_RPM_PM8058_LDO1,   &pm8058_nldo, "vdd_l0_l1_lvs" },
@@ -870,6 +934,8 @@ static const struct rpm_regulator_data rpm_pm8921_regulators[] = {
 };
 
 static const struct of_device_id rpm_of_match[] = {
+	{ .compatible = "qcom,rpm-pm8018-regulators",
+		.data = &rpm_pm8018_regulators },
 	{ .compatible = "qcom,rpm-pm8058-regulators", .data = &rpm_pm8058_regulators },
 	{ .compatible = "qcom,rpm-pm8901-regulators", .data = &rpm_pm8901_regulators },
 	{ .compatible = "qcom,rpm-pm8921-regulators", .data = &rpm_pm8921_regulators },
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
