From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] input : wacom - report resolution for pen devices
Date: Fri, 25 Mar 2011 17:29:36 -0700
Message-ID: <1301099376-5502-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40815 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163Ab1CZAbY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 20:31:24 -0400
Received: by iwn34 with SMTP id 34so1602231iwn.19
        for <linux-input@vger.kernel.org>; Fri, 25 Mar 2011 17:31:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Touch resolution is reported to the userland by retrieving
the value from the HID descriptor. But pen resolution is not
since it can not be retrieved. The current Wacom X driver
has a resolution table. To centralize the source of these
values, the resolution entries are added in the wacom_features
struct for x and y coordinates respectively. The values are
then reported to the userland.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |  271 +++++++++++++++++++++++++-------------
 drivers/input/tablet/wacom_wac.h |    2 +
 2 files changed, 181 insertions(+), 92 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index ba6e17c..6b527cb 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -12,6 +12,14 @@
  * (at your option) any later version.
  */
 
+/* resolution for penabled devices */
+#define WACOM_PL_RES		20
+#define WACOM_PENPRTN_RES	40
+#define WACOM_VOLITO_RES	50
+#define WACOM_GRAPHIRE_RES	80
+#define WACOM_INTUOS_RES	100
+#define WACOM_INTUOS3_RES	200
+
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
@@ -1055,6 +1063,19 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, features->pressure_max,
 			     features->pressure_fuzz, 0);
 
+	if (features->device_type == BTN_TOOL_PEN) {
+		/* penabled devices have fixed resolution for each model */
+		input_abs_set_res(input_dev, ABS_X, features->x_resolution);
+		input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
+	} else {
+		input_abs_set_res(input_dev, ABS_X,
+			wacom_calculate_touch_res(features->x_max,
+						features->x_phy));
+		input_abs_set_res(input_dev, ABS_Y,
+			wacom_calculate_touch_res(features->y_max,
+						features->y_phy));
+	}
+
 	__set_bit(ABS_MISC, input_dev->absbit);
 
 	switch (wacom_wac->features.type) {
@@ -1171,15 +1192,9 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case TABLETPC:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
-		if (features->device_type != BTN_TOOL_PEN) {
-			input_abs_set_res(input_dev, ABS_X,
-				wacom_calculate_touch_res(features->x_max,
-							features->x_phy));
-			input_abs_set_res(input_dev, ABS_Y,
-				wacom_calculate_touch_res(features->y_max,
-							features->y_phy));
+		if (features->device_type != BTN_TOOL_PEN)
 			break;  /* no need to process stylus stuff */
-		}
+
 		/* fall through */
 
 	case PL:
@@ -1216,12 +1231,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
 					     0, features->pressure_max,
 					     features->pressure_fuzz, 0);
-			input_abs_set_res(input_dev, ABS_X,
-				wacom_calculate_touch_res(features->x_max,
-							features->x_phy));
-			input_abs_set_res(input_dev, ABS_Y,
-				wacom_calculate_touch_res(features->y_max,
-							features->y_phy));
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
@@ -1233,161 +1242,239 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 }
 
 static const struct wacom_features wacom_features_0x00 =
-	{ "Wacom Penpartner",     WACOM_PKGLEN_PENPRTN,    5040,  3780,  255,  0, PENPARTNER };
+	{ "Wacom Penpartner",     WACOM_PKGLEN_PENPRTN,    5040,  3780,  255,
+	  0, PENPARTNER, WACOM_PENPRTN_RES, WACOM_PENPRTN_RES };
 static const struct wacom_features wacom_features_0x10 =
-	{ "Wacom Graphire",       WACOM_PKGLEN_GRAPHIRE,  10206,  7422,  511, 63, GRAPHIRE };
+	{ "Wacom Graphire",       WACOM_PKGLEN_GRAPHIRE,  10206,  7422,  511,
+	  63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x11 =
-	{ "Wacom Graphire2 4x5",  WACOM_PKGLEN_GRAPHIRE,  10206,  7422,  511, 63, GRAPHIRE };
+	{ "Wacom Graphire2 4x5",  WACOM_PKGLEN_GRAPHIRE,  10206,  7422,  511,
+	  63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x12 =
-	{ "Wacom Graphire2 5x7",  WACOM_PKGLEN_GRAPHIRE,  13918, 10206,  511, 63, GRAPHIRE };
+	{ "Wacom Graphire2 5x7",  WACOM_PKGLEN_GRAPHIRE,  13918, 10206,  511,
+	  63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x13 =
-	{ "Wacom Graphire3",      WACOM_PKGLEN_GRAPHIRE,  10208,  7424,  511, 63, GRAPHIRE };
+	{ "Wacom Graphire3",      WACOM_PKGLEN_GRAPHIRE,  10208,  7424,  511,
+	  63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x14 =
-	{ "Wacom Graphire3 6x8",  WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511, 63, GRAPHIRE };
+	{ "Wacom Graphire3 6x8",  WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511,
+	  63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x15 =
-	{ "Wacom Graphire4 4x5",  WACOM_PKGLEN_GRAPHIRE,  10208,  7424,  511, 63, WACOM_G4 };
+	{ "Wacom Graphire4 4x5",  WACOM_PKGLEN_GRAPHIRE,  10208,  7424,  511,
+	  63, WACOM_G4, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x16 =
-	{ "Wacom Graphire4 6x8",  WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511, 63, WACOM_G4 };
+	{ "Wacom Graphire4 6x8",  WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511,
+	  63, WACOM_G4, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x17 =
-	{ "Wacom BambooFun 4x5",  WACOM_PKGLEN_BBFUN,     14760,  9225,  511, 63, WACOM_MO };
+	{ "Wacom BambooFun 4x5",  WACOM_PKGLEN_BBFUN,     14760,  9225,  511,
+	  63, WACOM_MO, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x18 =
-	{ "Wacom BambooFun 6x8",  WACOM_PKGLEN_BBFUN,     21648, 13530,  511, 63, WACOM_MO };
+	{ "Wacom BambooFun 6x8",  WACOM_PKGLEN_BBFUN,     21648, 13530,  511,
+	  63, WACOM_MO, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x19 =
-	{ "Wacom Bamboo1 Medium", WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511, 63, GRAPHIRE };
+	{ "Wacom Bamboo1 Medium", WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511,
+	  63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x60 =
-	{ "Wacom Volito",         WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511, 63, GRAPHIRE };
+	{ "Wacom Volito",         WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511,
+	  63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
 static const struct wacom_features wacom_features_0x61 =
-	{ "Wacom PenStation2",    WACOM_PKGLEN_GRAPHIRE,   3250,  2320,  255, 63, GRAPHIRE };
+	{ "Wacom PenStation2",    WACOM_PKGLEN_GRAPHIRE,   3250,  2320,  255,
+	  63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
 static const struct wacom_features wacom_features_0x62 =
-	{ "Wacom Volito2 4x5",    WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511, 63, GRAPHIRE };
+	{ "Wacom Volito2 4x5",    WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511,
+	  63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
 static const struct wacom_features wacom_features_0x63 =
-	{ "Wacom Volito2 2x3",    WACOM_PKGLEN_GRAPHIRE,   3248,  2320,  511, 63, GRAPHIRE };
+	{ "Wacom Volito2 2x3",    WACOM_PKGLEN_GRAPHIRE,   3248,  2320,  511,
+	  63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
 static const struct wacom_features wacom_features_0x64 =
-	{ "Wacom PenPartner2",    WACOM_PKGLEN_GRAPHIRE,   3250,  2320,  511, 63, GRAPHIRE };
+	{ "Wacom PenPartner2",    WACOM_PKGLEN_GRAPHIRE,   3250,  2320,  511,
+	  63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
 static const struct wacom_features wacom_features_0x65 =
-	{ "Wacom Bamboo",         WACOM_PKGLEN_BBFUN,     14760,  9225,  511, 63, WACOM_MO };
+	{ "Wacom Bamboo",         WACOM_PKGLEN_BBFUN,     14760,  9225,  511,
+	  63, WACOM_MO, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x69 =
-	{ "Wacom Bamboo1",        WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511, 63, GRAPHIRE };
+	{ "Wacom Bamboo1",        WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511,
+	  63, GRAPHIRE, WACOM_PENPRTN_RES, WACOM_PENPRTN_RES };
 static const struct wacom_features wacom_features_0x20 =
-	{ "Wacom Intuos 4x5",     WACOM_PKGLEN_INTUOS,    12700, 10600, 1023, 31, INTUOS };
+	{ "Wacom Intuos 4x5",     WACOM_PKGLEN_INTUOS,    12700, 10600, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x21 =
-	{ "Wacom Intuos 6x8",     WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS };
+	{ "Wacom Intuos 6x8",     WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x22 =
-	{ "Wacom Intuos 9x12",    WACOM_PKGLEN_INTUOS,    30480, 24060, 1023, 31, INTUOS };
+	{ "Wacom Intuos 9x12",    WACOM_PKGLEN_INTUOS,    30480, 24060, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x23 =
-	{ "Wacom Intuos 12x12",   WACOM_PKGLEN_INTUOS,    30480, 31680, 1023, 31, INTUOS };
+	{ "Wacom Intuos 12x12",   WACOM_PKGLEN_INTUOS,    30480, 31680, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x24 =
-	{ "Wacom Intuos 12x18",   WACOM_PKGLEN_INTUOS,    45720, 31680, 1023, 31, INTUOS };
+	{ "Wacom Intuos 12x18",   WACOM_PKGLEN_INTUOS,    45720, 31680, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x30 =
-	{ "Wacom PL400",          WACOM_PKGLEN_GRAPHIRE,   5408,  4056,  255,  0, PL };
+	{ "Wacom PL400",          WACOM_PKGLEN_GRAPHIRE,   5408,  4056,  255,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x31 =
-	{ "Wacom PL500",          WACOM_PKGLEN_GRAPHIRE,   6144,  4608,  255,  0, PL };
+	{ "Wacom PL500",          WACOM_PKGLEN_GRAPHIRE,   6144,  4608,  255,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x32 =
-	{ "Wacom PL600",          WACOM_PKGLEN_GRAPHIRE,   6126,  4604,  255,  0, PL };
+	{ "Wacom PL600",          WACOM_PKGLEN_GRAPHIRE,   6126,  4604,  255,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x33 =
-	{ "Wacom PL600SX",        WACOM_PKGLEN_GRAPHIRE,   6260,  5016,  255,  0, PL };
+	{ "Wacom PL600SX",        WACOM_PKGLEN_GRAPHIRE,   6260,  5016,  255,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x34 =
-	{ "Wacom PL550",          WACOM_PKGLEN_GRAPHIRE,   6144,  4608,  511,  0, PL };
+	{ "Wacom PL550",          WACOM_PKGLEN_GRAPHIRE,   6144,  4608,  511,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x35 =
-	{ "Wacom PL800",          WACOM_PKGLEN_GRAPHIRE,   7220,  5780,  511,  0, PL };
+	{ "Wacom PL800",          WACOM_PKGLEN_GRAPHIRE,   7220,  5780,  511,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x37 =
-	{ "Wacom PL700",          WACOM_PKGLEN_GRAPHIRE,   6758,  5406,  511,  0, PL };
+	{ "Wacom PL700",          WACOM_PKGLEN_GRAPHIRE,   6758,  5406,  511,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x38 =
-	{ "Wacom PL510",          WACOM_PKGLEN_GRAPHIRE,   6282,  4762,  511,  0, PL };
+	{ "Wacom PL510",          WACOM_PKGLEN_GRAPHIRE,   6282,  4762,  511,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x39 =
-	{ "Wacom DTU710",         WACOM_PKGLEN_GRAPHIRE,  34080, 27660,  511,  0, PL };
+	{ "Wacom DTU710",         WACOM_PKGLEN_GRAPHIRE,  34080, 27660,  511,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0xC4 =
-	{ "Wacom DTF521",         WACOM_PKGLEN_GRAPHIRE,   6282,  4762,  511,  0, PL };
+	{ "Wacom DTF521",         WACOM_PKGLEN_GRAPHIRE,   6282,  4762,  511,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0xC0 =
-	{ "Wacom DTF720",         WACOM_PKGLEN_GRAPHIRE,   6858,  5506,  511,  0, PL };
+	{ "Wacom DTF720",         WACOM_PKGLEN_GRAPHIRE,   6858,  5506,  511,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0xC2 =
-	{ "Wacom DTF720a",        WACOM_PKGLEN_GRAPHIRE,   6858,  5506,  511,  0, PL };
+	{ "Wacom DTF720a",        WACOM_PKGLEN_GRAPHIRE,   6858,  5506,  511,
+	  0, PL, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x03 =
-	{ "Wacom Cintiq Partner", WACOM_PKGLEN_GRAPHIRE,  20480, 15360,  511,  0, PTU };
+	{ "Wacom Cintiq Partner", WACOM_PKGLEN_GRAPHIRE,  20480, 15360,  511,
+	  0, PTU, WACOM_PL_RES, WACOM_PL_RES };
 static const struct wacom_features wacom_features_0x41 =
-	{ "Wacom Intuos2 4x5",    WACOM_PKGLEN_INTUOS,    12700, 10600, 1023, 31, INTUOS };
+	{ "Wacom Intuos2 4x5",    WACOM_PKGLEN_INTUOS,    12700, 10600, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x42 =
-	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS };
+	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x43 =
-	{ "Wacom Intuos2 9x12",   WACOM_PKGLEN_INTUOS,    30480, 24060, 1023, 31, INTUOS };
+	{ "Wacom Intuos2 9x12",   WACOM_PKGLEN_INTUOS,    30480, 24060, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x44 =
-	{ "Wacom Intuos2 12x12",  WACOM_PKGLEN_INTUOS,    30480, 31680, 1023, 31, INTUOS };
+	{ "Wacom Intuos2 12x12",  WACOM_PKGLEN_INTUOS,    30480, 31680, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x45 =
-	{ "Wacom Intuos2 12x18",  WACOM_PKGLEN_INTUOS,    45720, 31680, 1023, 31, INTUOS };
+	{ "Wacom Intuos2 12x18",  WACOM_PKGLEN_INTUOS,    45720, 31680, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xB0 =
-	{ "Wacom Intuos3 4x5",    WACOM_PKGLEN_INTUOS,    25400, 20320, 1023, 63, INTUOS3S };
+	{ "Wacom Intuos3 4x5",    WACOM_PKGLEN_INTUOS,    25400, 20320, 1023,
+	  63, INTUOS3S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xB1 =
-	{ "Wacom Intuos3 6x8",    WACOM_PKGLEN_INTUOS,    40640, 30480, 1023, 63, INTUOS3 };
+	{ "Wacom Intuos3 6x8",    WACOM_PKGLEN_INTUOS,    40640, 30480, 1023,
+	  63, INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xB2 =
-	{ "Wacom Intuos3 9x12",   WACOM_PKGLEN_INTUOS,    60960, 45720, 1023, 63, INTUOS3 };
+	{ "Wacom Intuos3 9x12",   WACOM_PKGLEN_INTUOS,    60960, 45720, 1023,
+	  63, INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xB3 =
-	{ "Wacom Intuos3 12x12",  WACOM_PKGLEN_INTUOS,    60960, 60960, 1023, 63, INTUOS3L };
+	{ "Wacom Intuos3 12x12",  WACOM_PKGLEN_INTUOS,    60960, 60960, 1023,
+	  63, INTUOS3L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xB4 =
-	{ "Wacom Intuos3 12x19",  WACOM_PKGLEN_INTUOS,    97536, 60960, 1023, 63, INTUOS3L };
+	{ "Wacom Intuos3 12x19",  WACOM_PKGLEN_INTUOS,    97536, 60960, 1023,
+	  63, INTUOS3L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xB5 =
-	{ "Wacom Intuos3 6x11",   WACOM_PKGLEN_INTUOS,    54204, 31750, 1023, 63, INTUOS3 };
+	{ "Wacom Intuos3 6x11",   WACOM_PKGLEN_INTUOS,    54204, 31750, 1023,
+	  63, INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xB7 =
-	{ "Wacom Intuos3 4x6",    WACOM_PKGLEN_INTUOS,    31496, 19685, 1023, 63, INTUOS3S };
+	{ "Wacom Intuos3 4x6",    WACOM_PKGLEN_INTUOS,    31496, 19685, 1023,
+	  63, INTUOS3S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xB8 =
-	{ "Wacom Intuos4 4x6",    WACOM_PKGLEN_INTUOS,    31496, 19685, 2047, 63, INTUOS4S };
+	{ "Wacom Intuos4 4x6",    WACOM_PKGLEN_INTUOS,    31496, 19685, 2047,
+	  63, INTUOS4S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xB9 =
-	{ "Wacom Intuos4 6x9",    WACOM_PKGLEN_INTUOS,    44704, 27940, 2047, 63, INTUOS4 };
+	{ "Wacom Intuos4 6x9",    WACOM_PKGLEN_INTUOS,    44704, 27940, 2047,
+	  63, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xBA =
-	{ "Wacom Intuos4 8x13",   WACOM_PKGLEN_INTUOS,    65024, 40640, 2047, 63, INTUOS4L };
+	{ "Wacom Intuos4 8x13",   WACOM_PKGLEN_INTUOS,    65024, 40640, 2047,
+	  63, INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xBB =
-	{ "Wacom Intuos4 12x19",  WACOM_PKGLEN_INTUOS,    97536, 60960, 2047, 63, INTUOS4L };
+	{ "Wacom Intuos4 12x19",  WACOM_PKGLEN_INTUOS,    97536, 60960, 2047,
+	  63, INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xBC =
-	{ "Wacom Intuos4 WL",     WACOM_PKGLEN_INTUOS,    40840, 25400, 2047, 63, INTUOS4 };
+	{ "Wacom Intuos4 WL",     WACOM_PKGLEN_INTUOS,    40840, 25400, 2047,
+	  63, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x3F =
-	{ "Wacom Cintiq 21UX",    WACOM_PKGLEN_INTUOS,    87200, 65600, 1023, 63, CINTIQ };
+	{ "Wacom Cintiq 21UX",    WACOM_PKGLEN_INTUOS,    87200, 65600, 1023,
+	  63, CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xC5 =
-	{ "Wacom Cintiq 20WSX",   WACOM_PKGLEN_INTUOS,    86680, 54180, 1023, 63, WACOM_BEE };
+	{ "Wacom Cintiq 20WSX",   WACOM_PKGLEN_INTUOS,    86680, 54180, 1023,
+	  63, WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xC6 =
-	{ "Wacom Cintiq 12WX",    WACOM_PKGLEN_INTUOS,    53020, 33440, 1023, 63, WACOM_BEE };
+	{ "Wacom Cintiq 12WX",    WACOM_PKGLEN_INTUOS,    53020, 33440, 1023,
+	  63, WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xC7 =
-	{ "Wacom DTU1931",        WACOM_PKGLEN_GRAPHIRE,  37832, 30305,  511,  0, PL };
+	{ "Wacom DTU1931",        WACOM_PKGLEN_GRAPHIRE,  37832, 30305,  511,
+	  0, PL, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xCE =
-	{ "Wacom DTU2231",        WACOM_PKGLEN_GRAPHIRE,  47864, 27011,  511,  0, DTU };
+	{ "Wacom DTU2231",        WACOM_PKGLEN_GRAPHIRE,  47864, 27011,  511,
+	  0, DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xF0 =
-	{ "Wacom DTU1631",        WACOM_PKGLEN_GRAPHIRE,  34623, 19553,  511,  0, DTU };
+	{ "Wacom DTU1631",        WACOM_PKGLEN_GRAPHIRE,  34623, 19553,  511,
+	  0, DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xCC =
-	{ "Wacom Cintiq 21UX2",   WACOM_PKGLEN_INTUOS,    87200, 65600, 2047, 63, WACOM_21UX2 };
+	{ "Wacom Cintiq 21UX2",   WACOM_PKGLEN_INTUOS,    87200, 65600, 2047,
+	  63, WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x90 =
-	{ "Wacom ISDv4 90",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC };
+	{ "Wacom ISDv4 90",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x93 =
-	{ "Wacom ISDv4 93",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC };
+	{ "Wacom ISDv4 93",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x9A =
-	{ "Wacom ISDv4 9A",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC };
+	{ "Wacom ISDv4 9A",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x9F =
-	{ "Wacom ISDv4 9F",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC };
+	{ "Wacom ISDv4 9F",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xE2 =
-	{ "Wacom ISDv4 E2",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG };
+	{ "Wacom ISDv4 E2",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,
+	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xE3 =
-	{ "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG };
+	{ "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,
+	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x47 =
-	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS };
+	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
+	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD0 =
-	{ "Wacom Bamboo 2FG",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
+	{ "Wacom Bamboo 2FG",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD1 =
-	{ "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
+	{ "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD2 =
-	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
+	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD3 =
-	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023, 63, BAMBOO_PT };
+	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD4 =
-	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255, 63, BAMBOO_PT };
+	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD6 =
-	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023, 63, BAMBOO_PT };
+	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD7 =
-	{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720,  9200, 1023, 63, BAMBOO_PT };
+	{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720,  9200, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD8 =
-	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13530, 1023, 63, BAMBOO_PT };
+	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13530, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xDA =
-	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200, 1023, 63, BAMBOO_PT };
+	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static struct wacom_features wacom_features_0xDB =
-	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13530, 1023, 63, BAMBOO_PT };
+	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13530, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x6004 =
-	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800, 8000, 255, 0, TABLETPC };
+	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 
 #define USB_DEVICE_WACOM(prod)					\
 	USB_DEVICE(USB_VENDOR_ID_WACOM, prod),			\
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 835f756..53eb71b 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -74,6 +74,8 @@ struct wacom_features {
 	int pressure_max;
 	int distance_max;
 	int type;
+	int x_resolution;
+	int y_resolution;
 	int device_type;
 	int x_phy;
 	int y_phy;
-- 
1.7.4

