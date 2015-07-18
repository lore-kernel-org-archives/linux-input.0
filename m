From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] Input: pmic8xxx-keypad - change name of wakeup property
Date: Fri, 17 Jul 2015 17:36:18 -0700
Message-ID: <1437179781-21124-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437179781-21124-1-git-send-email-dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Wakeup property of device is not Linux-specific, it describes intended
system behavior regardless of the OS being used. Therefore let's drop
"linux," prefix, and, while at it, use the same name as I2C bus does:
"wakeup-source".

We keep parsing old name to keep compatibility with old DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt |  2 +-
 drivers/input/keyboard/pmic8xxx-keypad.c                       | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
index 7d8cb92..ee62156 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
@@ -33,7 +33,7 @@ PROPERTIES
 	Value type: <bool>
 	Definition: don't enable autorepeat feature.
 
-- linux,keypad-wakeup:
+- wakeup-source:
 	Usage: optional
 	Value type: <bool>
 	Definition: use any event on keypad as wakeup event.
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 32580af..5c68e3f 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -507,6 +507,7 @@ static void pmic8xxx_kp_close(struct input_dev *dev)
  */
 static int pmic8xxx_kp_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	unsigned int rows, cols;
 	bool repeat;
 	bool wakeup;
@@ -524,10 +525,11 @@ static int pmic8xxx_kp_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	repeat = !of_property_read_bool(pdev->dev.of_node,
-					"linux,input-no-autorepeat");
-	wakeup = of_property_read_bool(pdev->dev.of_node,
-					"linux,keypad-wakeup");
+	repeat = !of_property_read_bool(np, "linux,input-no-autorepeat");
+
+	wakeup = of_property_read_bool(np, "wakeup-source") ||
+		 /* legacy name */
+		 of_property_read_bool(np, "linux,keypad-wakeup");
 
 	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
 	if (!kp)
-- 
2.4.3.573.g4eafbef

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
