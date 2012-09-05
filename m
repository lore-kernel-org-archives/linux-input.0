From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] input: mouse: use %*ph to dump small buffer
Date: Wed,  5 Sep 2012 15:08:38 +0300
Message-ID: <1346846918-27728-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51661 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab2IEMIM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Sep 2012 08:08:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/mouse/hgpk.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 575f880..5b17cc6 100644
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
-- 
1.7.10.4

