From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH] Input: synaptics - Add PNP ID for ThinkPad P50 to SMBus
Date: Wed, 21 Nov 2018 15:16:20 -0500
Message-ID: <20181121201622.20815-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, KT Liao <kt.liao@emc.com.tw>, Peter Hutterer <peter.hutterer@who-t.net>, Edvard Holst <edvard.holst@gmail.com>, Arkadiusz Hiler <arkadiusz.hiler@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Noticed the other day the trackpoint felt different on my P50, then
realized it was because rmi4 wasn't loading for this machine
automatically. Suspend/resume, hibernate, and everything else seem to
work perfectly fine on here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 5e85f3cca867..c42813d50591 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -170,6 +170,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
+	"LEN005b", /* P50 */
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
-- 
2.19.1
