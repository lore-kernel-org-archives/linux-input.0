From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 30/31] input: mouse: use parity8 in elantech
Date: Sun, 27 Mar 2016 15:48:08 +0800
Message-ID: <56F79038.3030405@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36442 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbcC0Hsu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2016 03:48:50 -0400
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ulrik De Bie <ulrik.debie-os@e2big.org>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?B?5rSq5LiA56u5?= <sam.hung@emc.com.tw>, Peter Hutterer <peter.hutterer@who-t.net>, Duson Lin <dusonlin@emc.com.tw>, Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 drivers/input/mouse/elantech.c | 10 +++-------
 drivers/input/mouse/elantech.h |  1 -
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 78f93cf..778b5d1 100644
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
2.5.5

