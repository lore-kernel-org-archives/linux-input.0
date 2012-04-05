From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH 1/2] Input: elantech - reset touchpad before configuration
Date: Thu,  5 Apr 2012 15:46:20 +0800
Message-ID: <1333611981-8641-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:5693 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2DEHo4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Apr 2012 03:44:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org
Cc: JJ Ding <jj_ding@emc.com.tw>

I got a bug report saying for Acer VH40, there is a Fn key to toggle touchpad
on and off, but it's implemented in system firmware, and the EC chip has to
recieve reset command to activate this function. Also for this machine, when
it wakes up after resume, psmouse_reset is nesassary to bring the touchpad
back on.

With my testing this behavior should be OK on all machines, and synaptics.c
does the same thing.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
---
 drivers/input/mouse/elantech.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index d2c0db1..21c68a8 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1245,6 +1245,8 @@ static void elantech_disconnect(struct psmouse *psmouse)
  */
 static int elantech_reconnect(struct psmouse *psmouse)
 {
+	psmouse_reset(psmouse);
+
 	if (elantech_detect(psmouse, 0))
 		return -1;
 
@@ -1324,6 +1326,8 @@ int elantech_init(struct psmouse *psmouse)
 	if (!etd)
 		return -ENOMEM;
 
+	psmouse_reset(psmouse);
+
 	etd->parity[0] = 1;
 	for (i = 1; i < 256; i++)
 		etd->parity[i] = etd->parity[i & (i - 1)] ^ 1;
-- 
1.7.10.rc1

