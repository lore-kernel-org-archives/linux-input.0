From: akpm@linux-foundation.org
Subject: [patch 19/19] input: elantech touchpad driver miss-recognising logitech mice
Date: Wed, 11 Feb 2009 13:23:57 -0800
Message-ID: <200902112123.n1BLNvbc026899@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43120 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759053AbZBKV3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 16:29:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, arjan@opmeer.net, apw@shadowen.org

From: Arjan Opmeer <arjan@opmeer.net>

Some Logitech mice react to the magic knock like an Elantech touchpad would.
This leads to those mice being misdetected as Elantech touchpads.  Add a
version query to elantech_detect() to distinguish the two.

Signed-off-by: Arjan Opmeer <arjan@opmeer.net>
Cc: Andy Whitcroft <apw@shadowen.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/mouse/elantech.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff -puN drivers/input/mouse/elantech.c~input-elantech-touchpad-driver-miss-recognising-logitech-mice drivers/input/mouse/elantech.c
--- a/drivers/input/mouse/elantech.c~input-elantech-touchpad-driver-miss-recognising-logitech-mice
+++ a/drivers/input/mouse/elantech.c
@@ -556,6 +556,22 @@ int elantech_detect(struct psmouse *psmo
 		return -1;
 	}
 
+	/*
+	 * There are Logitech mice that react to the magic knock exactly
+	 * like an Elantech touchpad would, so do a version query here to
+	 * try to distinguish the two
+	 */
+	if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, param)) {
+		pr_err("elantech.c: failed to query firmware version.\n");
+		return -1;
+	}
+	pr_info("elantech.c: Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
+		param[0], param[1], param[2]);
+	if (param[0] == 0 || param[1] != 0) {
+		pr_info("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
+		return -1;
+	}
+
 	if (set_properties) {
 		psmouse->vendor = "Elantech";
 		psmouse->name = "Touchpad";
@@ -610,14 +626,12 @@ int elantech_init(struct psmouse *psmous
 		etd->parity[i] = etd->parity[i & (i - 1)] ^ 1;
 
 	/*
-	 * Find out what version hardware this is
+	 * Do the version query again so we can store the result
 	 */
 	if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, param)) {
 		pr_err("elantech.c: failed to query firmware version.\n");
 		goto init_fail;
 	}
-	pr_info("elantech.c: Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
-		param[0], param[1], param[2]);
 	etd->fw_version_maj = param[0];
 	etd->fw_version_min = param[2];
 
_
