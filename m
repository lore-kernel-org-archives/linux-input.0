From: zengzhaoxiu@163.com
Subject: [PATCH v2 29/30] input: use parity8 in elantech
Date: Wed,  6 Apr 2016 18:20:14 +0800
Message-ID: <1459938014-8603-1-git-send-email-zengzhaoxiu@163.com>
References: <57031D9D.801@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-133.163.com ([123.125.50.133]:38736 "EHLO m50-133.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbcDFKVa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Apr 2016 06:21:30 -0400
In-Reply-To: <57031D9D.801@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, ulrik.debie-os@e2big.org, hdegoede@redhat.com, peter.hutterer@who-t.net, tiwai@suse.de, dusonlin@emc.com.tw
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Remove even parity table, use parity8 instead.

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 drivers/input/mouse/elantech.c | 10 +++-------
 drivers/input/mouse/elantech.h |  1 -
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 78f93cf..bbb4aa6 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -693,9 +693,9 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
 
 	p3 = (packet[0] & 0x04) >> 2;
 
-	return etd->parity[packet[1]] == p1 &&
-	       etd->parity[packet[2]] == p2 &&
-	       etd->parity[packet[3]] == p3;
+	return parity8(packet[1]) != p1 &&
+	       parity8(packet[2]) != p2 &&
+	       parity8(packet[3]) != p3;
 }
 
 static int elantech_debounce_check_v2(struct psmouse *psmouse)
@@ -1635,10 +1635,6 @@ int elantech_init(struct psmouse *psmouse)
 
 	psmouse_reset(psmouse);
 
-	etd->parity[0] = 1;
-	for (i = 1; i < 256; i++)
-		etd->parity[i] = etd->parity[i & (i - 1)] ^ 1;
-
 	/*
 	 * Do the version query again so we can store the result
 	 */
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index e1cbf40..542c5d9 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -141,7 +141,6 @@ struct elantech_data {
 	unsigned int y_max;
 	unsigned int width;
 	struct finger_pos mt[ETP_MAX_FINGERS];
-	unsigned char parity[256];
 	int (*send_cmd)(struct psmouse *psmouse, unsigned char c, unsigned char *param);
 	void (*original_set_rate)(struct psmouse *psmouse, unsigned int rate);
 };
-- 
2.5.0


