From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input - elantech: fix debug dump of the current packet
Date: Thu, 28 Jul 2016 11:58:55 +0200
Message-ID: <1469699935-23056-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43595 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbcG1J67 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 05:58:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The use of mixed psmouse_printk() and printk creates 2 lines in the log,
while the use of %*ph solves everything.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 615d23e..3461d04 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -222,12 +222,8 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
  */
 static void elantech_packet_dump(struct psmouse *psmouse)
 {
-	int	i;
-
-	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [");
-	for (i = 0; i < psmouse->pktsize; i++)
-		printk("%s0x%02x ", i ? ", " : " ", psmouse->packet[i]);
-	printk("]\n");
+	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [%*ph]",
+		       psmouse->pktsize, psmouse->packet);
 }
 
 /*
-- 
2.5.5

