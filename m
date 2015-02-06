From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/7] Input: synaptics - do not retrieve the board id on old firmwares
Date: Fri,  6 Feb 2015 15:04:31 -0500
Message-ID: <1423253075-23469-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38776 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381AbbBFUEq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 15:04:46 -0500
In-Reply-To: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The board id capability has been added in firmware 7.5.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

v2:
- brand new

 drivers/input/mouse/synaptics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a033fc7..d7b2e93 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -253,6 +253,10 @@ static int synaptics_board_id(struct psmouse *psmouse)
 	struct synaptics_data *priv = psmouse->private;
 	unsigned char bid[3];
 
+	/* firmwares prior 7.5 have no board_id encoded */
+	if (SYN_ID_FULL(priv->identity) < 0x705)
+		return 0;
+
 	if (synaptics_send_cmd(psmouse, SYN_QUE_MODES, bid))
 		return -1;
 	priv->board_id = ((bid[0] & 0xfc) << 6) | bid[1];
-- 
2.1.0

