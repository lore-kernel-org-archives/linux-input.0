From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V4 8/8] MAINTAINERS: da9062/61 updates to the Dialog
 Semiconductor search terms
Date: Mon, 14 Nov 2016 08:22:46 +0000
Message-ID: <f7a705b1e1041efb77a2e4204db5d5222cea5702.1479111766.git.stwiss.opensource@diasemi.com>
References: <cover.1479111766.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.176]:28762 "EHLO
        mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753169AbcKNI1t (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Nov 2016 03:27:49 -0500
In-Reply-To: <cover.1479111766.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>

From: Steve Twiss <stwiss.opensource@diasemi.com>

Hi,

Dialog Semiconductor support would like to add to the MAINTAINERS search
terms. This update will allow us to follow files for device tree bindings
and source code relating to input onkey drivers, chip thermal monitoring
and watchdog timers.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

v3 -> v4
 - NO CODE CHANGE
 - Patch renamed from [PATCH V3 9/9] to [PATCH V4 8/8]

v2 -> v3
 - NO CODE CHANGE
 - Patch renamed from [PATCH V2 10/10] to [PATCH V3 9/9]

v1 -> v2
 - NO CODE CHANGE

Hi,

This patch depends on acceptance of the following from this patch set:

- [PATCH V4 7/8] PMIC temperature monitoring

and also from the following binding file changes:

- Binding for onkey (already applied by Dmitry Torokhov)
- [PATCH V4 1/8] Binding for watchdog
- [PATCH V4 2/8] Binding for thermal

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f593300..a7fd809 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3752,7 +3752,10 @@ W:	http://www.dialog-semiconductor.com/products
 S:	Supported
 F:	Documentation/hwmon/da90??
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
+F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
+F:	Documentation/devicetree/bindings/watchdog/da92??-wdt.txt
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
@@ -3767,6 +3770,7 @@ F:	drivers/power/da9052-battery.c
 F:	drivers/power/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
+F:	drivers/thermal/da90??-thermal.c
 F:	drivers/rtc/rtc-da90??.c
 F:	drivers/video/backlight/da90??_bl.c
 F:	drivers/watchdog/da90??_wdt.c
-- 
end-of-patch for PATCH V4

