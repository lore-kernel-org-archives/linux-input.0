From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V1 06/10] Documentation: dt: input: temperature driver
Date: Thu, 6 Oct 2016 09:43:30 +0100
Message-ID: <313a15d14dd20a8cb8ac99a4cd423798343c5b65.1475743411.git.stwiss.opensource@diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1475743411.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

Add binding information for DA9061 onkey.

This patch updates the compatible string "dlg,da9061-onkey" to support
DA9061, removes ther reference to KEY_SLEEP (which the driver no longer
supports) and fixes a typo in the example.

Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

---
This patch applies against linux-next and v4.8

Hi,

This patch depends on the acceptance of the main code for the onkey:
  [PATCH V1 3/10] Input: da9061: onkey driver.

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 .../devicetree/bindings/input/da9062-onkey.txt        | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt b/Documentation/devicetree/bindings/input/da9062-onkey.txt
index ab0e048..ce45436 100644
--- a/Documentation/devicetree/bindings/input/da9062-onkey.txt
+++ b/Documentation/devicetree/bindings/input/da9062-onkey.txt
@@ -1,28 +1,27 @@
-* Dialog DA9062/63 OnKey Module
+* Dialog DA9061/62/63 OnKey Module
 
-This module is part of the DA9062/DA9063. For more details about entire
-chips see Documentation/devicetree/bindings/mfd/da9062.txt and
-Documentation/devicetree/bindings/mfd/da9063.txt
+This module is part of the DA9061/DA9062/DA9063. For more details about entire
+DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
+For DA9063 see Documentation/devicetree/bindings/mfd/da9063.txt
 
-This module provides KEY_POWER, KEY_SLEEP and events.
+This module provides the KEY_POWER event.
 
 Required properties:
 
 - compatible: should be one of:
+	dlg,da9061-onkey
 	dlg,da9062-onkey
 	dlg,da9063-onkey
 
 Optional properties:
 
-  - dlg,disable-key-power : Disable power-down using a long key-press. If this
+- dlg,disable-key-power : Disable power-down using a long key-press. If this
     entry exists the OnKey driver will remove support for the KEY_POWER key
-    press. If this entry does not exist then by default the key-press
-    triggered power down is enabled and the OnKey will support both KEY_POWER
-    and KEY_SLEEP.
+    press when triggered using a long press of the OnKey.
 
 Example:
 
-	pmic0: da9062@58 {
+	pmic0: da9063@58 {
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
-- 
end-of-patch for PATCH V1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
