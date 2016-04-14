From: zengzhaoxiu@163.com
Subject: [PATCH V3 28/29] input: use parity8 in elantech
Date: Thu, 14 Apr 2016 11:12:30 +0800
Message-ID: <1460603554-5854-1-git-send-email-zengzhaoxiu@163.com>
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, Ulrik De Bie <ulrik.debie-os@e2big.org>, Takashi Iwai <tiwai@suse.de>, Duson Lin <dusonlin@emc.com.tw>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Remove the even parity table, use parity8 instead.

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
