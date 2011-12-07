From: JJ Ding <jj_ding@emc.com.tw>
Subject: [RFC PATCH 1/2] Input: psmouse - work around EC buffer
Date: Wed,  7 Dec 2011 19:38:43 +0800
Message-ID: <1323257924-12773-2-git-send-email-jj_ding@emc.com.tw>
References: <1323257924-12773-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:15410 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab1LGLkY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 06:40:24 -0500
In-Reply-To: <1323257924-12773-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <jj_ding@emc.com.tw>, JJ Ding <dgdunix@gmail.com>

From: JJ Ding <dgdunix@gmail.com>

With some EC chips, when we resync due to bad packets, those bad bytes would
still remain in EC's buffer area. That makes us always get bad data back,
no matter what.

So shift packet for 1 byte when encounter bad packet, until we get rid of
those bytes.

Signed-off-by: JJ Ding <dgdunix@gmail.com>
---
 drivers/input/mouse/psmouse-base.c |    5 +++++
 drivers/input/mouse/psmouse.h      |    3 ++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 200be9c..b849cec 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -279,6 +279,11 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
 		}
 		break;
 
+	case PSMOUSE_SHIFT_PACKET:
+		memmove(psmouse->packet, psmouse->packet + 1, psmouse->pktsize - 1);
+		psmouse->pktcnt--;
+		break;
+
 	case PSMOUSE_GOOD_DATA:
 		break;
 	}
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 6a41709..1742c1b 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -33,7 +33,8 @@ enum psmouse_state {
 typedef enum {
 	PSMOUSE_BAD_DATA,
 	PSMOUSE_GOOD_DATA,
-	PSMOUSE_FULL_PACKET
+	PSMOUSE_FULL_PACKET,
+	PSMOUSE_SHIFT_PACKET
 } psmouse_ret_t;
 
 struct psmouse {
-- 
1.7.8

