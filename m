From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH] Input: elantech - add Fujitsu Lifebook E547 to force
 crc_enabled
Date: Thu, 9 Mar 2017 09:19:41 +0100
Message-ID: <c194d33b-9918-7514-d662-00d0688a7dfd@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:54158 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752621AbdCIIgv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 03:36:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Temporary got a Fujitsu Lifebook E547 into my hands and noticed 
the touchpad only works after running

echo "1" > /sys/devices/platform/i8042/serio2/crc_enabled

Add it to the list of Fujitsu machines that need this workaround.

Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 drivers/input/mouse/elantech.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index efc8ec3..c5e513b 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1524,6 +1524,13 @@ static int elantech_reconnect(struct psmouse *psmouse)
 		},
 	},
 	{
+		/* Fujitsu LIFEBOOK E547  does not work with crc_enabled == 0 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E547"),
+		},
+	},
+	{
 		/* Fujitsu LIFEBOOK E554  does not work with crc_enabled == 0 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-- 
1.8.3.1
