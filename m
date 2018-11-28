From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - quirk all PDP Xbox One gamepads
Date: Tue, 27 Nov 2018 18:47:10 -0800
Message-ID: <20181128024710.10932-1-aicommander@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: mark@furneaux.ca, ramzeto@gmail.com
List-Id: linux-input@vger.kernel.org

Since we continue to find tons of new variants [0,1,2,3,4,5,6] that
need the PDP quirk, let's just quirk all devices from PDP.

[0]: https://github.com/paroj/xpad/pull/104
[1]: https://github.com/paroj/xpad/pull/105
[2]: https://github.com/paroj/xpad/pull/108
[3]: https://github.com/paroj/xpad/pull/109
[4]: https://github.com/paroj/xpad/pull/112
[5]: https://github.com/paroj/xpad/pull/115
[6]: https://github.com/paroj/xpad/pull/116

Fixes: e5c9c6a885fa ("Input: xpad - add support for PDP Xbox One controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
Dmitry,

This patch applies to your for-linus branch, since another PDP
quirked device was added there.


Regards,
Cameron
---
 drivers/input/joystick/xpad.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d4b9db487b16..cfc8b94527b9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -480,18 +480,18 @@ static const u8 xboxone_hori_init[] = {
 };
 
 /*
- * This packet is required for some of the PDP pads to start
+ * This packet is required for most (all?) of the PDP pads to start
  * sending input reports. These pads include: (0x0e6f:0x02ab),
- * (0x0e6f:0x02a4).
+ * (0x0e6f:0x02a4), (0x0e6f:0x02a6).
  */
 static const u8 xboxone_pdp_init1[] = {
 	0x0a, 0x20, 0x00, 0x03, 0x00, 0x01, 0x14
 };
 
 /*
- * This packet is required for some of the PDP pads to start
+ * This packet is required for most (all?) of the PDP pads to start
  * sending input reports. These pads include: (0x0e6f:0x02ab),
- * (0x0e6f:0x02a4).
+ * (0x0e6f:0x02a4), (0x0e6f:0x02a6).
  */
 static const u8 xboxone_pdp_init2[] = {
 	0x06, 0x20, 0x00, 0x02, 0x01, 0x00
@@ -527,12 +527,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init2),
+	XBOXONE_INIT_PKT(0x0e6f, 0x0000, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x0000, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
-- 
2.19.1
