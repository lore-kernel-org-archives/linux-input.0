From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH] Input: elantech - enable middle button of touchpad on ThinkPad P72
Date: Fri,  7 Sep 2018 15:06:51 +0800
Message-ID: <20180907070651.6916-1-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aaron.ma@canonical.com
List-Id: linux-input@vger.kernel.org

Adding 2 new touchpad IDs to support middle button support.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 44f57cf6675b..2d95e8d93cc7 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1178,6 +1178,8 @@ static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
 static const char * const middle_button_pnp_ids[] = {
 	"LEN2131", /* ThinkPad P52 w/ NFC */
 	"LEN2132", /* ThinkPad P52 */
+	"LEN2133", /* ThinkPad P72 w/ NFC */
+	"LEN2134", /* ThinkPad P72 */
 	NULL
 };
 
-- 
2.17.1
