From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 4/5] mfd: qcom-rpm: Add support for pm8018 RPM Regulator
Date: Fri, 24 Jun 2016 11:18:06 +0200
Message-ID: <1466759887-25394-5-git-send-email-narmstrong@baylibre.com>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDAYD2P3QYGRBWPVWO5QKGQE637P4HA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1466759887-25394-1-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

In order to support the Qualcomm MDM9615 SoC, add support for the
RPM regulator entries in the qcom-rpm driver.

Acked-by: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  1 +
 drivers/mfd/qcom_rpm.c                             | 51 ++++++++++++++++++++++
 include/dt-bindings/mfd/qcom-rpm.h                 | 22 ++++++++++
 3 files changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
index b98b291..72d68d4 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
@@ -13,6 +13,7 @@ frequencies.
 		    "qcom,rpm-msm8660"
 		    "qcom,rpm-msm8960"
 		    "qcom,rpm-ipq8064"
+		    "qcom,rpm-mdm9615"
 
 - reg:
 	Usage: required
diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 880d469..c309ebe 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -390,11 +390,62 @@ static const struct qcom_rpm_data ipq806x_template = {
 	.ack_sel_size = 7,
 };
 
+static const struct qcom_rpm_resource mdm9615_rpm_resource_table[] = {
+	[QCOM_RPM_CXO_CLK] =			{ 25, 9, 5, 1 },
+	[QCOM_RPM_SYS_FABRIC_CLK] =		{ 26, 10, 9, 1 },
+	[QCOM_RPM_DAYTONA_FABRIC_CLK] =		{ 27, 11, 11, 1 },
+	[QCOM_RPM_SFPB_CLK] =			{ 28, 12, 12, 1 },
+	[QCOM_RPM_CFPB_CLK] =			{ 29, 13, 13, 1 },
+	[QCOM_RPM_EBI1_CLK] =			{ 30, 14, 16, 1 },
+	[QCOM_RPM_APPS_FABRIC_HALT] =		{ 31, 15, 22, 2 },
+	[QCOM_RPM_APPS_FABRIC_MODE] =		{ 33, 16, 23, 3 },
+	[QCOM_RPM_APPS_FABRIC_IOCTL] =		{ 36, 17, 24, 1 },
+	[QCOM_RPM_APPS_FABRIC_ARB] =		{ 37, 18, 25, 27 },
+	[QCOM_RPM_PM8018_SMPS1] =		{ 64, 19, 30, 2 },
+	[QCOM_RPM_PM8018_SMPS2] =		{ 66, 21, 31, 2 },
+	[QCOM_RPM_PM8018_SMPS3] =		{ 68, 23, 32, 2 },
+	[QCOM_RPM_PM8018_SMPS4] =		{ 70, 25, 33, 2 },
+	[QCOM_RPM_PM8018_SMPS5] =		{ 72, 27, 34, 2 },
+	[QCOM_RPM_PM8018_LDO1] =		{ 74, 29, 35, 2 },
+	[QCOM_RPM_PM8018_LDO2] =		{ 76, 31, 36, 2 },
+	[QCOM_RPM_PM8018_LDO3] =		{ 78, 33, 37, 2 },
+	[QCOM_RPM_PM8018_LDO4] =		{ 80, 35, 38, 2 },
+	[QCOM_RPM_PM8018_LDO5] =		{ 82, 37, 39, 2 },
+	[QCOM_RPM_PM8018_LDO6] =		{ 84, 39, 40, 2 },
+	[QCOM_RPM_PM8018_LDO7] =		{ 86, 41, 41, 2 },
+	[QCOM_RPM_PM8018_LDO8] =		{ 88, 43, 42, 2 },
+	[QCOM_RPM_PM8018_LDO9] =		{ 90, 45, 43, 2 },
+	[QCOM_RPM_PM8018_LDO10] =		{ 92, 47, 44, 2 },
+	[QCOM_RPM_PM8018_LDO11] =		{ 94, 49, 45, 2 },
+	[QCOM_RPM_PM8018_LDO12] =		{ 96, 51, 46, 2 },
+	[QCOM_RPM_PM8018_LDO13] =		{ 98, 53, 47, 2 },
+	[QCOM_RPM_PM8018_LDO14] =		{ 100, 55, 48, 2 },
+	[QCOM_RPM_PM8018_LVS1] =		{ 102, 57, 49, 1 },
+	[QCOM_RPM_PM8018_NCP] =			{ 103, 58, 80, 2 },
+	[QCOM_RPM_CXO_BUFFERS] =		{ 105, 60, 81, 1 },
+	[QCOM_RPM_USB_OTG_SWITCH] =		{ 106, 61, 82, 1 },
+	[QCOM_RPM_HDMI_SWITCH] =		{ 107, 62, 83, 1 },
+	[QCOM_RPM_VOLTAGE_CORNER] =		{ 109, 64, 87, 1 },
+};
+
+static const struct qcom_rpm_data mdm9615_template = {
+	.version = 3,
+	.resource_table = mdm9615_rpm_resource_table,
+	.n_resources = ARRAY_SIZE(mdm9615_rpm_resource_table),
+	.req_ctx_off = 3,
+	.req_sel_off = 11,
+	.ack_ctx_off = 15,
+	.ack_sel_off = 23,
+	.req_sel_size = 4,
+	.ack_sel_size = 7,
+};
+
 static const struct of_device_id qcom_rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-apq8064", .data = &apq8064_template },
 	{ .compatible = "qcom,rpm-msm8660", .data = &msm8660_template },
 	{ .compatible = "qcom,rpm-msm8960", .data = &msm8960_template },
 	{ .compatible = "qcom,rpm-ipq8064", .data = &ipq806x_template },
+	{ .compatible = "qcom,rpm-mdm9615", .data = &mdm9615_template },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_rpm_of_match);
diff --git a/include/dt-bindings/mfd/qcom-rpm.h b/include/dt-bindings/mfd/qcom-rpm.h
index 13a9d4b..54aef5e 100644
--- a/include/dt-bindings/mfd/qcom-rpm.h
+++ b/include/dt-bindings/mfd/qcom-rpm.h
@@ -147,6 +147,28 @@
 #define QCOM_RPM_SMB208_S1b			137
 #define QCOM_RPM_SMB208_S2a			138
 #define QCOM_RPM_SMB208_S2b			139
+#define QCOM_RPM_PM8018_SMPS1			140
+#define QCOM_RPM_PM8018_SMPS2			141
+#define QCOM_RPM_PM8018_SMPS3			142
+#define QCOM_RPM_PM8018_SMPS4			143
+#define QCOM_RPM_PM8018_SMPS5			144
+#define QCOM_RPM_PM8018_LDO1			145
+#define QCOM_RPM_PM8018_LDO2			146
+#define QCOM_RPM_PM8018_LDO3			147
+#define QCOM_RPM_PM8018_LDO4			148
+#define QCOM_RPM_PM8018_LDO5			149
+#define QCOM_RPM_PM8018_LDO6			150
+#define QCOM_RPM_PM8018_LDO7			151
+#define QCOM_RPM_PM8018_LDO8			152
+#define QCOM_RPM_PM8018_LDO9			153
+#define QCOM_RPM_PM8018_LDO10			154
+#define QCOM_RPM_PM8018_LDO11			155
+#define QCOM_RPM_PM8018_LDO12			156
+#define QCOM_RPM_PM8018_LDO13			157
+#define QCOM_RPM_PM8018_LDO14			158
+#define QCOM_RPM_PM8018_LVS1			159
+#define QCOM_RPM_PM8018_NCP			160
+#define QCOM_RPM_VOLTAGE_CORNER			161
 
 /*
  * Constants used to select force mode for regulators.
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
