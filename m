From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/4] Input: pmic8xxx-keypad - add support keypad found in pm8941
Date: Tue,  7 Oct 2014 12:50:47 +0300
Message-ID: <1412675448-11990-4-git-send-email-iivanov@mm-sol.com>
References: <1412675448-11990-1-git-send-email-iivanov@mm-sol.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412675448-11990-1-git-send-email-iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Controller seems to be the same. Just access to it is over SPMI bus
and registers and bits are reshuffled. Hopefully this is nicely
abstracted by regmap helpers.

Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/input/qcom,pm8xxx-keypad.txt          |  1 +
 drivers/input/keyboard/pmic8xxx-keypad.c           | 27 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
index 7d8cb92..2b60f8a 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
@@ -8,6 +8,7 @@ PROPERTIES
 	Definition: must be one of:
 		    "qcom,pm8058-keypad"
 		    "qcom,pm8921-keypad"
+		    "qcom,pm8941-keypad"
 
 - reg:
 	Usage: required
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index b82d161..2d4fa07 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -136,6 +136,32 @@ static const struct pmic8xxx_kp_info ssbi_kp = {
 	.row_hold	= REG_FIELD(0x149, 6, 7),
 };
 
+static const struct pmic8xxx_kp_info spmi_kp = {
+	.max_rows	= 10,
+	.min_rows	= 2,
+	.max_cols	= 8,
+	.min_cols	= 1,
+
+	.rows_select = {
+		1, 2, 3, 4, 5, 6, 7,
+		8, 9, 10
+	},
+
+	.recent_data	= 0xa87c,
+	.old_data	= 0xa85c,
+	.read_stride	= 2,
+
+	.events		= REG_FIELD(0xa808, 0, 1),
+	.scan_rows	= REG_FIELD(0xa840, 0, 3),
+	.scan_cols	= REG_FIELD(0xa840, 4, 6),
+	.enable		= REG_FIELD(0xa846, 7, 7),
+
+	.read_state	= REG_FIELD(0xa844, 0, 0),
+	.dbonce		= REG_FIELD(0xa842, 0, 1),
+	.pause		= REG_FIELD(0xa842, 3, 5),
+	.row_hold	= REG_FIELD(0xa842, 6, 7),
+};
+
 static u8 pmic8xxx_col_state(struct pmic8xxx_kp *kp, u8 col)
 {
 	/* all keys pressed on that particular row? */
@@ -715,6 +741,7 @@ static SIMPLE_DEV_PM_OPS(pm8xxx_kp_pm_ops,
 static const struct of_device_id pm8xxx_match_table[] = {
 	{ .compatible = "qcom,pm8058-keypad", .data = (void *)&ssbi_kp },
 	{ .compatible = "qcom,pm8921-keypad", .data = (void *)&ssbi_kp },
+	{ .compatible = "qcom,pm8941-keypad", .data = (void *)&spmi_kp },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_match_table);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
