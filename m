From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V2 10/10] MAINTAINERS: da9062/61 updates to the Dialog
 Semiconductor search terms
Date: Wed, 26 Oct 2016 17:56:40 +0100
Message-ID: <b9a05a63ed2bbc2a874a873a2c5897b5cf50d501.1477501000.git.stwiss.opensource@diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1477501000.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Hi,

Dialog Semiconductor support would like to add to the MAINTAINERS search
terms. This update will allow us to follow files for device tree bindings
and source code relating to input onkey drivers, chip thermal monitoring
and watchdog timers.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

v1 -> v2
 NO CHANGE

Hi,

This patch depends on acceptance of the following from this patch set:

- [PATCH V2 09/10] PMIC temperature monitoring

and also from the following binding file changes:

- [PATCH V2 01/10] Binding for onkey
- [PATCH V2 02/10] Binding for watchdog
- [PATCH V2 03/10] Binding for thermal

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
end-of-patch for PATCH V2
