From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2] input: mouse: use %*ph to dump small buffer
Date: Wed,  5 Sep 2012 15:11:06 +0300
Message-ID: <1346847066-27895-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16174 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab2IEMKx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Sep 2012 08:10:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/mouse/hgpk.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 575f880..62be888 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -334,11 +334,8 @@ static bool hgpk_is_byte_valid(struct psmouse *psmouse, unsigned char *packet)
 
 	if (!valid)
 		psmouse_dbg(psmouse,
-			    "bad data, mode %d (%d) %02x %02x %02x %02x %02x %02x\n",
-			    priv->mode, pktcnt,
-			    psmouse->packet[0], psmouse->packet[1],
-			    psmouse->packet[2], psmouse->packet[3],
-			    psmouse->packet[4], psmouse->packet[5]);
+			    "bad data, mode %d (%d) %*ph\n",
+			    priv->mode, pktcnt, 6, psmouse->packet);
 
 	return valid;
 }
@@ -1030,7 +1027,7 @@ static enum hgpk_model_t hgpk_get_model(struct psmouse *psmouse)
 		return -EIO;
 	}
 
-	psmouse_dbg(psmouse, "ID: %02x %02x %02x\n", param[0], param[1], param[2]);
+	psmouse_dbg(psmouse, "ID: %*ph\n", 3, param);
 
 	/* HGPK signature: 0x67, 0x00, 0x<model> */
 	if (param[0] != 0x67 || param[1] != 0x00)
-- 
1.7.10.4

