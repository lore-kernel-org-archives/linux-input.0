From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] Input: mouse: alps: print small buffers via %*ph
Date: Fri, 26 Oct 2012 16:42:58 +0300
Message-ID: <1351258978-18656-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21660 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932903Ab2JZNnH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Oct 2012 09:43:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/mouse/alps.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index cf5af1f..b4a3faf 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -766,10 +766,9 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 		      psmouse->packet[4] |
 		      psmouse->packet[5]) & 0x80) ||
 		    (!alps_is_valid_first_byte(priv->i, psmouse->packet[6]))) {
-			psmouse_dbg(psmouse,
-				    "refusing packet %x %x %x %x (suspected interleaved ps/2)\n",
-				    psmouse->packet[3], psmouse->packet[4],
-				    psmouse->packet[5], psmouse->packet[6]);
+			psmouse_dbg(psmouse, "refusing packet %4ph "
+				    "(suspected interleaved ps/2)\n",
+				    psmouse->packet + 3);
 			return PSMOUSE_BAD_DATA;
 		}
 
@@ -830,10 +829,9 @@ static void alps_flush_packet(unsigned long data)
 		if ((psmouse->packet[3] |
 		     psmouse->packet[4] |
 		     psmouse->packet[5]) & 0x80) {
-			psmouse_dbg(psmouse,
-				    "refusing packet %x %x %x (suspected interleaved ps/2)\n",
-				    psmouse->packet[3], psmouse->packet[4],
-				    psmouse->packet[5]);
+			psmouse_dbg(psmouse, "refusing packet %3ph "
+				    "(suspected interleaved ps/2)\n",
+				    psmouse->packet + 3);
 		} else {
 			alps_process_packet(psmouse);
 		}
-- 
1.7.10.4

