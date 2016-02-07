From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] Input: Colibri VF50 - Add missing #include <linux/of.h>
Date: Sun,  7 Feb 2016 15:18:06 +0100
Message-ID: <1454854687-21114-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

drivers/input/touchscreen/colibri-vf50-ts.c: In function =E2=80=98vf50_=
ts_probe=E2=80=99:
drivers/input/touchscreen/colibri-vf50-ts.c:302: error: implicit declar=
ation of function =E2=80=98of_property_read_u32=E2=80=99

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Seen with "[PATCH 2/2] Input: Allow compile test of Goodix and Colibri
VF50 if !GPIOLIB" on m68k/allmodconfig

 drivers/input/touchscreen/colibri-vf50-ts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/inpu=
t/touchscreen/colibri-vf50-ts.c
index 5d4903a402cc6a5f..69828d015d45ffa4 100644
--- a/drivers/input/touchscreen/colibri-vf50-ts.c
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
