From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [RESEND PATCH V7 7/7] MAINTAINERS: da9062/61 updates to the Dialog
 Semiconductor search terms
Date: Tue, 23 May 2017 14:40:45 +0100
Message-ID: <d1c3ceda19be1363cd37bb52fd7fae5b1b9a164e.1495546845.git.stwiss.opensource@diasemi.com>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1495546845.git.stwiss.opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Additions to search terms for files supported by Dialog Semiconductor.
This update will allow Dialog support to follow files for device tree
bindings (onkey, thermal and watchdog) and source code for chip thermal
monitoring drivers.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Hi all,

Is there anybody willing to take this patch through their tree please?

Dialog Semiconductor support would like to add to the MAINTAINERS search
terms. This update will allow us to follow all of our files for device
tree bindings and the source code relating to chip thermal monitoring
described in this patch set.

All dependencies for this patch have been accepted into linux-next:

bindings/input/da90??-onkey.txt     -> linux-next.git/commit/?id=406d5a2de0718622241eff35831f6fed0316a7d4
bindings/thermal/da90??-thermal.txt -> linux-next.git/commit/?id=28c1b08d2a156ef16e912a4c618a529e586e5dbc
bindings/watchdog/da92??-wdt.txt    -> linux-next.git/commit/?id=be62f363a8d5b1703c08d2cb462786a68215bcca
drivers/thermal/da90??-thermal.c    -> linux-next.git/commit/?id=608567aac3206ae886c79688fbb8a62c473b55ef

Regards,
Steve Twiss, Dialog Semiconductor


This patch applies against linux-next and v4.12-rc2

v6 -> v7
 - NO CODE CHANGE
 - Rebased from v4.11-rc3 to v4.11-rc11
 - Updated the commit message
 - Moved the following names from CC: to TO: e-mail fields
   - Lee Jones
   - Liam Girdwood
   - Mark Brown

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


 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e98464..a580bed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3988,7 +3988,10 @@ W:	http://www.dialog-semiconductor.com/products
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
@@ -4003,6 +4006,7 @@ F:	drivers/power/supply/da9052-battery.c
 F:	drivers/power/supply/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
+F:	drivers/thermal/da90??-thermal.c
 F:	drivers/rtc/rtc-da90??.c
 F:	drivers/video/backlight/da90??_bl.c
 F:	drivers/watchdog/da90??_wdt.c
-- 
end-of-patch for RESEND PATCH V7
