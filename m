From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input: synaptics - handle spurious release of trackstick buttons, again
Date: Tue, 15 Mar 2016 11:18:17 +0100
Message-ID: <1458037097-6444-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50123 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932225AbcCOKSW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 06:18:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Looks like the fimware 8.2 stall has the extra buttons spurious release
bug.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=114321
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 6025eb4..9f3b83f 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -862,8 +862,9 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
 	if (!SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
 		return;
 
-	/* Bug in FW 8.1, buttons are reported only when ExtBit is 1 */
-	if (SYN_ID_FULL(priv->identity) == 0x801 &&
+	/* Bug in FW 8.1 & 8.2, buttons are reported only when ExtBit is 1 */
+	if (((SYN_ID_FULL(priv->identity) == 0x801) ||
+	     (SYN_ID_FULL(priv->identity) == 0x802)) &&
 	    !((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02))
 		return;
 
-- 
2.5.0

