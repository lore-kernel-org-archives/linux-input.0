From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 20/20] Input: iforce - use unaligned accessors, where appropriate
Date: Mon, 17 Sep 2018 17:47:32 -0700
Message-ID: <20180918004732.9875-20-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of open-coding conversion from/to little-endian, let's
use proper accessors.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c    |  7 ++++---
 drivers/input/joystick/iforce/iforce-packets.c | 12 ++++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 5cb3e80f4e0d..d696b0b653b6 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <asm/unaligned.h>
 #include "iforce.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
@@ -286,17 +287,17 @@ int iforce_init_device(struct device *parent, u16 bustype,
  */
 
 	if (!iforce_get_id_packet(iforce, 'M', buf, &len) || len < 3)
-		input_dev->id.vendor = (buf[2] << 8) | buf[1];
+		input_dev->id.vendor = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet M\n");
 
 	if (!iforce_get_id_packet(iforce, 'P', buf, &len) || len < 3)
-		input_dev->id.product = (buf[2] << 8) | buf[1];
+		input_dev->id.product = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet P\n");
 
 	if (!iforce_get_id_packet(iforce, 'B', buf, &len) || len < 3)
-		iforce->device_memory.end = (buf[2] << 8) | buf[1];
+		iforce->device_memory.end = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet B\n");
 
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 976ec1c7cf15..76c4475740ab 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <asm/unaligned.h>
 #include "iforce.h"
 
 static struct {
@@ -175,8 +176,10 @@ void iforce_process_packet(struct iforce *iforce,
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
-		input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-		input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+		input_report_abs(dev, ABS_X,
+				 (__s16) get_unaligned_le16(data));
+		input_report_abs(dev, ABS_Y,
+				 (__s16) get_unaligned_le16(data + 2));
 		input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
 
 		if (len >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
@@ -188,7 +191,8 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x03:	/* wheel position data */
-		input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
+		input_report_abs(dev, ABS_WHEEL,
+				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_GAS,   255 - data[2]);
 		input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
 
@@ -214,7 +218,7 @@ void iforce_process_packet(struct iforce *iforce,
 		}
 
 		for (j = 3; j < len; j += 2)
-			mark_core_as_ready(iforce, data[j] | (data[j + 1] << 8));
+			mark_core_as_ready(iforce, get_unaligned_le16(data + j));
 
 		break;
 	}
-- 
2.19.0.397.gdd90340f6a-goog
