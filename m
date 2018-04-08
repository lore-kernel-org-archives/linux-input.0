From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] Input: alps - Fix reporting pressure of v3 trackstick
Date: Sun,  8 Apr 2018 17:53:21 +0200
Message-ID: <20180408155321.10433-1-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

According to documentation, all 7 lower bits represents trackpoint pressure.

Fixes: 4621c9660459 ("Input: alps - report pressure of v3 and v7 trackstick")
Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 0a9e6a3a2f9f..1e28d9fc5492 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -583,7 +583,7 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
 
 	x = (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
 	y = (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
-	z = packet[4] & 0x7c;
+	z = packet[4] & 0x7f;
 
 	/*
 	 * The x and y values tend to be quite large, and when used
-- 
2.11.0
