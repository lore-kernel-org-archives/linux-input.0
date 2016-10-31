From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V3 2/9] Documentation: devicetree: watchdog: da9062/61
 watchdog timer binding
Date: Mon, 31 Oct 2016 16:02:03 +0000
Message-ID: <35578f27515c2abc1780823829ebab467543548c.1477929725.git.stwiss.opensource@diasemi.com>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1477929725.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

Add binding information for DA9062 and DA9061 watchdog.

Example bindings for both DA9062 and DA9061 devices are added. For
the DA9061 device, a fallback compatible line is added as a valid
combination of compatible strings.

The original binding for DA9062 (only) used to reside inside the
Documentation/devicetree/bindings/mfd/da9062.txt MFD document.
The da9062-watchdog section was deleted in that file and replaced
with a link to the new DA9061/62 binding information stored in this
patch.

Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

---
This patch applies against linux-next and v4.8

v2 -> v3
 - Patch renamed from [PATCH V1 02/10] to [PATCH V3 2/9]
 - Each compatible line should be a valid combination of compatible
   strings, alter DA9061 line to include the fall back compatible string
 - Update the commit message to describe this change
 - Add information about associated patches from this set without
   describing them as being explicitly dependent on this binding

v1 -> v2
 - Patch renamed from [PATCH V1 07/10] to [PATCH V2 02/10] -- these
   changes were made to fix checkpatch warnings caused by the patch
   set dependency order
 - Updated the patch description to be explicit about where parts of
   this binding had originally been stored
 - A second example for DA9061 is provided to highlight the use of a
   fall-back compatible option for the DA9062 watchdog driver

Hi,

A previous [PATCH V1 07/10] was acked-by: Rob Herring, however changes
in the Linux device driver have meant an additional binding information
and an example is necessary to describe the use of DA9061.

The Linux device driver changes for DA9061 were rejected after
conversations with the watchdog maintainers, specifically about
compatibility between DA9061 and DA9062 watchdog hardware components. In
the case of the watchdog the DA9062 device driver is compatible with the
DA9061 and for this reason there is minimal change required to the DA9062
watchdog device driver and so the example for the DA9061 watchdog shows
the use of a fall-back compatible string.

Other information:
The device driver from this patch set (associated with this binding) is
  [PATCH V3 7/9] watchdog: da9061: watchdog driver
 
Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 .../devicetree/bindings/watchdog/da9062-wdt.txt    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
new file mode 100644
index 0000000..b935b52
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
@@ -0,0 +1,23 @@
+* Dialog Semiconductor DA9062/61 Watchdog Timer
+
+Required properties:
+
+- compatible: should be one of the following valid compatible string lines:
+	"dlg,da9061-watchdog", "dlg,da9062-watchdog"
+	"dlg,da9062-watchdog"
+
+Example: DA9062
+
+	pmic0: da9062@58 {
+		watchdog {
+			compatible = "dlg,da9062-watchdog";
+		};
+	};
+
+Example: DA9061 using a fall-back compatible for the DA9062 watchdog driver
+
+	pmic0: da9061@58 {
+		watchdog {
+			compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";
+		};
+	};
-- 
end-of-patch for PATCH V3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
