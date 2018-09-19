From: Roy Im <roy.im.opensource@diasemi.com>
Subject: [RESEND PATCH V6 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
Date: Wed, 19 Sep 2018 19:35:04 +0900
Message-ID: <4a7f9f7c97298c88a99fdfed02b82db9b83115d8.1537353304.git.Roy.Im@diasemi.com>
References: <cover.1537353304.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537353304.git.Roy.Im@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb5..6244a7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4313,6 +4313,7 @@ S:	Supported
 F:	Documentation/hwmon/da90??
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
@@ -4321,6 +4322,7 @@ F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
-- 
end-of-patch for RESEND PATCH V6
