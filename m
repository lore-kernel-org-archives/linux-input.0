From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 08/14] Input: ALPS - Rework detection of Pinnacle AGx touchpads
Date: Sun,  3 Feb 2013 15:56:48 -0800
Message-ID: <1359935815-13507-9-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:55485 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab3BCX5b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:31 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj3so1837676pad.34
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:31 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

The official ALPS driver uses the EC report, not the E7 report, to detect
these devices.  Also, they check for a range of values; the original
table-based code only checked for two specific ones.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 6b0b2b9..de82339 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -109,8 +109,6 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x73, 0x02, 0x50 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },		/* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },				/* Toshiba Tecra A11-11L */
-	{ { 0x73, 0x02, 0x64 },	0x9b, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT },
-	{ { 0x73, 0x02, 0x64 },	0x9d, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT },
 	{ { 0x73, 0x02, 0x64 },	0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
 };
 
@@ -1412,6 +1410,10 @@ error:
 
 static void alps_set_defaults(struct alps_data *priv)
 {
+	priv->byte0 = 0x8f;
+	priv->mask0 = 0x8f;
+	priv->flags = ALPS_DUALPOINT;
+
 	switch (priv->proto_version) {
 	case ALPS_PROTO_V1:
 	case ALPS_PROTO_V2:
@@ -1492,8 +1494,15 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 	    alps_exit_command_mode(psmouse))
 		return -EIO;
 
-	if (alps_match_table(psmouse, priv, e7, ec) == 0)
+	if (alps_match_table(psmouse, priv, e7, ec) == 0) {
+		return 0;
+	} else if (ec[0] == 0x88 && ec[1] == 0x07 &&
+		   ec[2] >= 0x90 && ec[2] <= 0x9d) {
+		priv->proto_version = ALPS_PROTO_V3;
+		alps_set_defaults(priv);
+
 		return 0;
+	}
 
 	psmouse_info(psmouse,
 		"Unknown ALPS touchpad: E7=%2.2x %2.2x %2.2x, EC=%2.2x %2.2x %2.2x\n",
-- 
1.7.10.4

