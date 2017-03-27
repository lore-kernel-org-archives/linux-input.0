From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V6 7/7] MAINTAINERS: da9062/61 updates to the Dialog
 Semiconductor search terms
Date: Mon, 27 Mar 2017 10:51:33 +0100
Message-ID: <bc97dce603b717f40cc5a4983d0a19d2b6eb6a65.1490608293.git.stwiss.opensource@diasemi.com>
References: <cover.1490608293.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1490608293.git.stwiss.opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
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
This patch applies against linux-next and v4.11-rc3

v5 -> v6
 - NO CODE CHANGE
 - Rebased from v4.8 to v4.11-rc3
 - Patch renamed from [PATCH V5 8/8] to [PATCH V5 7/7]

v4 -> v5
 - NO CODE CHANGE
 - Rebased from v4.8 to v4.9

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

- [PATCH V5 7/8] PMIC temperature monitoring

and also from the following binding file changes:

- Binding for onkey (already applied by Dmitry Torokhov)
- [PATCH V5 1/8] Binding for watchdog
- [PATCH V5 2/8] Binding for thermal

Regards,
Steve Twiss, Dialog Semiconductor


 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c776906..bab1e77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3926,7 +3926,10 @@ W:	http://www.dialog-semiconductor.com/products
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
@@ -3941,6 +3944,7 @@ F:	drivers/power/supply/da9052-battery.c
 F:	drivers/power/supply/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
+F:	drivers/thermal/da90??-thermal.c
 F:	drivers/rtc/rtc-da90??.c
 F:	drivers/video/backlight/da90??_bl.c
 F:	drivers/watchdog/da90??_wdt.c
-- 
end-of-patch for PATCH V6
