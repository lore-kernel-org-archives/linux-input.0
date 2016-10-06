From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elantech - add Fujitsu Lifebook E556 to force
 crc_enabled
Date: Wed, 5 Oct 2016 22:55:00 -0700
Message-ID: <20161006055500.GA9017@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Takashi Iwai <tiwai@suse.de>, Ulrik De Bie <ulrik.debie-os@e2big.org>, William Linna <william.linna@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Another Lifebook machine that needs the same quirk as other similar
models to make the driver working.

Also let's reorder elantech_dmi_force_crc_enabled list so LIfebook enries
are in alphabetical order.

Reported-by: William Linna <william.linna@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elantech.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 37b52f1..db7d1d6 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1517,6 +1517,13 @@ static const struct dmi_system_id elantech_dmi_force_crc_enabled[] = {
 		},
 	},
 	{
+		/* Fujitsu LIFEBOOK E544  does not work with crc_enabled == 0 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
+		},
+	},
+	{
 		/* Fujitsu LIFEBOOK E554  does not work with crc_enabled == 0 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
@@ -1524,10 +1531,10 @@ static const struct dmi_system_id elantech_dmi_force_crc_enabled[] = {
 		},
 	},
 	{
-		/* Fujitsu LIFEBOOK E544  does not work with crc_enabled == 0 */
+		/* Fujitsu LIFEBOOK E556 does not work with crc_enabled == 0 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E556"),
 		},
 	},
 	{
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
