From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH 1/2] Input: elantech - enable middle button support on 2 ThinkPads
Date: Sun, 19 May 2019 15:27:10 +0800
Message-ID: <20190519072711.2592-1-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: aaron.ma@canonical.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

Adding 2 new touchpad PNPIDs to enable middle button support.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index a7f8b1614559..530142b5a115 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1189,6 +1189,8 @@ static const char * const middle_button_pnp_ids[] = {
 	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
+	"LEN0407",
+	"LEN0408",
 	NULL
 };
 
-- 
2.17.1
