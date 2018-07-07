From: kitsunyan <kitsunyan@inbox.ru>
Subject: [PATCH] Input: synaptics - Lenovo ThinkPad T25 and T480 devices should use RMI
Date: Sat,  7 Jul 2018 08:19:12 +0300
Message-ID: <20180707051913.24035-1-kitsunyan@inbox.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kitsunyan <kitsunyan@inbox.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The touchpads on both T25 and T480 are accessible over SMBUS/RMI.

Signed-off-by: kitsunyan <kitsunyan@inbox.ru>
---
 drivers/input/mouse/synaptics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 55d33500d55e..be934a082424 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -175,7 +175,9 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
+	"LEN008e", /* T25 */
 	"LEN0092", /* X1 Carbon 6 */
+	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
-- 
2.18.0
