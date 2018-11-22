From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 5/8] HID: logitech-hidpp: fix typo, hiddpp to hidpp
Date: Thu, 22 Nov 2018 16:34:06 +1000
Message-ID: <20181122063409.15816-6-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-logitech-hidpp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 19cc980eebce..22b37a3844d1 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1465,7 +1465,7 @@ struct hidpp_ff_work_data {
 	u8 size;
 };
 
-static const signed short hiddpp_ff_effects[] = {
+static const signed short hidpp_ff_effects[] = {
 	FF_CONSTANT,
 	FF_PERIODIC,
 	FF_SINE,
@@ -1480,7 +1480,7 @@ static const signed short hiddpp_ff_effects[] = {
 	-1
 };
 
-static const signed short hiddpp_ff_effects_v2[] = {
+static const signed short hidpp_ff_effects_v2[] = {
 	FF_RAMP,
 	FF_FRICTION,
 	FF_INERTIA,
@@ -1873,11 +1873,11 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	version = bcdDevice & 255;
 
 	/* Set supported force feedback capabilities */
-	for (j = 0; hiddpp_ff_effects[j] >= 0; j++)
-		set_bit(hiddpp_ff_effects[j], dev->ffbit);
+	for (j = 0; hidpp_ff_effects[j] >= 0; j++)
+		set_bit(hidpp_ff_effects[j], dev->ffbit);
 	if (version > 1)
-		for (j = 0; hiddpp_ff_effects_v2[j] >= 0; j++)
-			set_bit(hiddpp_ff_effects_v2[j], dev->ffbit);
+		for (j = 0; hidpp_ff_effects_v2[j] >= 0; j++)
+			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
 	/* Read number of slots available in device */
 	error = hidpp_send_fap_command_sync(hidpp, feature_index,
-- 
2.19.1
