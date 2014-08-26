From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH 1/1] Input: elantech: Correct the sign of the x/y movement for trackpoint
Date: Tue, 26 Aug 2014 21:30:23 +0200
Message-ID: <1409081423-2259-1-git-send-email-ulrik.debie-os@e2big.org>
References: <20140824221424.GA15090@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:46033 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbaHZTbK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2014 15:31:10 -0400
In-Reply-To: <20140824221424.GA15090@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

Hi Dmitry,

Thank you for your feedback !

The x/y movement calculation was wrong, probably caused by my wrong documentation at the beginning of the elantech_report_trackpoint function.
When applying this patch to your patch, it works.

Thanks !
--
Ulrik

Input: elantech: Correct the sign of the x/y movement for trackpoint

From: Ulrik De Bie <ulrik.debie-os@e2big.org>

The sign bit in the documentation of the trackpoint x/y movement is corrected.
The sign bit in the calculation of the x/y movement for trackpoint is corrected.

Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index b4d645a..63533e5 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -408,10 +408,10 @@ static void elantech_report_trackpoint(struct psmouse *psmouse,
 				       int packet_type)
 {
 	/*
-	 * byte 0:  0   0 ~sx ~sy   0   M   R   L
-	 * byte 1: sx   0   0   0   0   0   0   0
-	 * byte 2: sy   0   0   0   0   0   0   0
-	 * byte 3:  0   0  sy  sx   0   1   1   0
+	 * byte 0:  0   0  sx  sy   0   M   R   L
+	 * byte 1:~sx   0   0   0   0   0   0   0
+	 * byte 2:~sy   0   0   0   0   0   0   0
+	 * byte 3:  0   0 ~sy ~sx   0   1   1   0
 	 * byte 4: x7  x6  x5  x4  x3  x2  x1  x0
 	 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
 	 *
@@ -443,8 +443,8 @@ static void elantech_report_trackpoint(struct psmouse *psmouse,
 	case 0x16008020U:
 	case 0x26800010U:
 	case 0x36808000U:
-		x = packet[4] - (int)(packet[1] << 1);
-		y = (int)(packet[2] << 1) - packet[5];
+		x = packet[4] - (int)((packet[1]^0x80) << 1);
+		y = (int)((packet[2]^0x80) << 1) - packet[5];
 
 		input_report_key(tp_dev, BTN_LEFT, packet[0] & 0x01);
 		input_report_key(tp_dev, BTN_RIGHT, packet[0] & 0x02);
-- 
2.1.0.rc1

