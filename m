From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH 2/2] Input: synaptics - remove X240 from the topbuttonpad list
Date: Sun, 19 May 2019 15:27:11 +0800
Message-ID: <20190519072711.2592-2-aaron.ma@canonical.com>
References: <20190519072711.2592-1-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190519072711.2592-1-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: aaron.ma@canonical.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

Lenovo ThinkPad X240 does not have the top software button.
When this wrong ID in top button list, smbus mode will fail to probe,
so keep it working at PS2 mode.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/synaptics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index b6da0c1267e3..6ae7bc92476b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -140,7 +140,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN002E",
 	"LEN0033", /* Helix */
 	"LEN0034", /* T431s, L440, L540, T540, W540, X1 Carbon 2nd */
-	"LEN0035", /* X240 */
 	"LEN0036", /* T440 */
 	"LEN0037", /* X1 Carbon 2nd */
 	"LEN0038",
-- 
2.17.1
