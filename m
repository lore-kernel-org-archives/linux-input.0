From: Chris Diamand <chris@diamand.org>
Subject: [PATCH] Input: ALPS - Recognise "Dolphin V2" touchpads
Date: Mon,  6 Jan 2014 20:10:34 +0000
Message-ID: <1389039034-14040-1-git-send-email-chris@diamand.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:59625 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaAFULk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jan 2014 15:11:40 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so16015531wes.2
        for <linux-input@vger.kernel.org>; Mon, 06 Jan 2014 12:11:39 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, cernekee@gmail.com, yunkang.tang@cn.alps.com, dturvene@dahetral.com
Cc: linux-input@vger.kernel.org, Chris Diamand <chris@diamand.org>

This is the touchpad used on the Dell Vostro 3360. Without
this change, the driver reports this as follows:

psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 50, EC=73 02 02

It seems to use the ALPS V5 protocol, so identify it
as such by allowing ec[1] == 0x02.

This is based on src/alps.c from the DKMS driver here:
http://www.dahetral.com/public-download/alps-psmouse-dlkm-for-3-2-and-3-5/

Signed-off-by: Chris Diamand <chris@diamand.org>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 5cf62e3..d5d15eb 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1845,7 +1845,7 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 	if (alps_match_table(psmouse, priv, e7, ec) == 0) {
 		return 0;
 	} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
-		   ec[0] == 0x73 && ec[1] == 0x01) {
+		   ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
 		priv->proto_version = ALPS_PROTO_V5;
 		alps_set_defaults(priv);
 
-- 
1.8.5.2

