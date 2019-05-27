From: XiaoXiao Liu <sliuuxiaonxiao@gmail.com>
Subject: [PATCH] input: alps-fix the issue alps cs19 trackstick do not work.
Date: Mon, 27 May 2019 05:44:22 -0400
Message-ID: <20190527094422.7558-1-sliuuxiaonxiao@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, pali.rohar@gmail.com
Cc: peter.hutterer@who-t.net, hui.wang@canonical.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, xiaojian.cao@cn.alps.com, zhangfp1@lenovo.com, xiaoxiao.liu-1@cn.alps.com, XiaoXiao Liu <sliuuxiaonxiao@gmail.com>
List-Id: linux-input@vger.kernel.org

The alps devices which detected to use the ALPS_PROTO_V8 procotol contains
ALPS touchpad and ALPS trackstick.The ALPS_PROTO_V8 procotol do not
support the trackstick device process by default.

When the trackstick was detected to use ALPS_PROTO_V8 procotol,
the v8 process_packet method alps_process_packet_ss4_v2 will reject to
report the data when the device using ALPS_PROTO_V8 procotol is not set
the ALPS_DUALPOINT flag.

The alps cs19 trackstick is detected to use the ALPS_PROTO_V8 procotol
but without ALPS_DUALPOINT flag, the alps driver will not report the
input data. so the trackstick will not work.

solution: when the alps cs19 device detected, set the device
ALPS_DUALPOINT flag,then the input data will be processed.

Signed-off-by: XiaoXiao Liu <sliuuxiaonxiao@gmail.com>
---
 drivers/input/mouse/alps.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 0a6f7ca883e7..a54677cf7474 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -24,7 +24,7 @@
 
 #include "psmouse.h"
 #include "alps.h"
-
+#include "trackpoint.h"
 /*
  * Definitions for ALPS version 3 and 4 command mode protocol
  */
@@ -220,6 +220,23 @@ static bool alps_is_valid_first_byte(struct alps_data *priv,
 	return (data & priv->mask0) == priv->byte0;
 }
 
+static int alps_check_cs19_trackstick(struct psmouse *psmouse)
+{
+	u8 param[2] = { 0 };
+	int error;
+
+	error = ps2_command(&psmouse->ps2dev,
+			    param, MAKE_PS2_CMD(0, 2, TP_READ_ID));
+	if (error)
+		return error;
+
+	if (param[0] == TP_VARIANT_ALPS && param[1] & 0x20) {
+		psmouse_warn(psmouse, "It is alps cs19 trackstick");
+		return 0;
+	}
+	return -1;
+}
+
 static void alps_report_buttons(struct input_dev *dev1, struct input_dev *dev2,
 				int left, int right, int middle)
 {
@@ -2568,8 +2585,12 @@ static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
 			alps_exit_command_mode(psmouse);
 			ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 
-			if (reg_val == 0x0C || reg_val == 0x1D)
+			if (reg_val == 0x0C || reg_val == 0x1D) {
+				is_dual = true;
+			} else if (alps_check_cs19_trackstick(psmouse) == 0) {
+				//For support Thinkpad CS19 TrackStick
 				is_dual = true;
+			}
 		}
 	}
 
-- 
2.20.1
