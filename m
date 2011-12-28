From: Paul Fox <pgf@laptop.org>
Subject: [PATCH] only assign psmouse handlers on successful return from fsp_init()
Date: Wed, 28 Dec 2011 15:11:46 -0500
Message-ID: <2424.1325103106@foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from colo.foxharp.net ([166.84.7.52]:51489 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754207Ab1L1USn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Dec 2011 15:18:43 -0500
Content-ID: <2421.1325103106.1@foxharp.boston.ma.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tai-hwa Liang <avatar@sentelic.com>

the psmouse action routines were being initialized before all
possible error conditions had been considered.  a subsequent
failure would leave these handlers set, and later touchpad
traffic or psmouse driver actions could cause them to be called,
even though fsp_init() had failed.

Signed-off-by: Paul Fox <pgf@laptop.org>

---
 drivers/input/mouse/sentelic.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 2fc887a..3539ca6 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -842,12 +842,6 @@ int fsp_init(struct psmouse *psmouse)
 	__set_bit(REL_WHEEL, psmouse->dev->relbit);
 	__set_bit(REL_HWHEEL, psmouse->dev->relbit);
 
-	psmouse->protocol_handler = fsp_process_byte;
-	psmouse->disconnect = fsp_disconnect;
-	psmouse->reconnect = fsp_reconnect;
-	psmouse->cleanup = fsp_reset;
-	psmouse->pktsize = 4;
-
 	/* set default packet output based on number of buttons we found */
 	error = fsp_activate_protocol(psmouse);
 	if (error)
@@ -861,6 +855,12 @@ int fsp_init(struct psmouse *psmouse)
 		goto err_out;
 	}
 
+	psmouse->protocol_handler = fsp_process_byte;
+	psmouse->disconnect = fsp_disconnect;
+	psmouse->reconnect = fsp_reconnect;
+	psmouse->cleanup = fsp_reset;
+	psmouse->pktsize = 4;
+
 	return 0;
 
  err_out:
-- 
1.7.1



=---------------------
 paul fox, pgf@laptop.org
