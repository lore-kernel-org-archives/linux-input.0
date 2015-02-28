From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: psmouse - when comparing PNP IDs ignore case
Date: Fri, 27 Feb 2015 16:18:52 -0800
Message-ID: <20150228001852.GA18983@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36499 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbB1AS5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 19:18:57 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

PNP IDs are supposed to be case-insensitive and so we should compare
them as such.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 39 +++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 4ccd01d..a175496 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -463,19 +463,44 @@ static int psmouse_poll(struct psmouse *psmouse)
 			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
 }
 
+static bool psmouse_check_pnp_id(const char *id, const char * const ids[])
+{
+	int i;
+
+	for (i = 0; ids[i]; i++)
+		if (!strcasecmp(id, ids[i]))
+			return true;
+
+	return false;
+}
+
 /*
  * psmouse_matches_pnp_id - check if psmouse matches one of the passed in ids.
  */
 bool psmouse_matches_pnp_id(struct psmouse *psmouse, const char * const ids[])
 {
-	int i;
-
-	if (!strncmp(psmouse->ps2dev.serio->firmware_id, "PNP:", 4))
-		for (i = 0; ids[i]; i++)
-			if (strstr(psmouse->ps2dev.serio->firmware_id, ids[i]))
-				return true;
+	struct serio *serio = psmouse->ps2dev.serio;
+	char *p, *fw_id_copy, *save_ptr;
+	bool found = false;
+
+	if (!strncmp(serio->firmware_id, "PNP:", 4))
+		return false;
+
+	fw_id_copy = kstrndup(&serio->firmware_id[4],
+			      sizeof(serio->firmware_id) - 4,
+			      GFP_KERNEL);
+	if (!fw_id_copy)
+		return false;
+
+	save_ptr = fw_id_copy;
+	while ((p = strsep(&fw_id_copy, " ")) != NULL) {
+		if (psmouse_check_pnp_id(p, ids))
+			found = true;
+			break;
+	}
 
-	return false;
+	kfree(save_ptr);
+	return found;
 }
 
 /*
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
