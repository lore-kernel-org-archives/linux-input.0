From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 2/4] input/alps: Handle 0-pressure 1F events
Date: Sat, 28 May 2016 14:01:00 +0200
Message-ID: <1464436862-2649-3-git-send-email-ben@smart-cactus.org>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56297 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbcE1MBQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 May 2016 08:01:16 -0400
In-Reply-To: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Ben Gamari <ben@smart-cactus.org>

While a button is held SS5 hardware will give us single-finger packets
with x, y, and pressure equal to zero. This causes annoying jumps in
pointer position if a touch is released while the button is held. Handle
this by claiming zero contacts to ensure that no position events are
provided to the user.
---
 drivers/input/mouse/alps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index b8454af..7874f4f 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1197,7 +1197,12 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 		f->mt[0].x = SS4_1F_X_V2(p);
 		f->mt[0].y = SS4_1F_Y_V2(p);
 		f->pressure = ((SS4_1F_Z_V2(p)) * 2) & 0x7f;
-		f->fingers = 1;
+		/*
+		 * When a button is held the device will give us events with x, y, and
+		 * pressure of 0. This causes annoying jumps if a touch is released while
+		 * the button is held. Handle this by claiming zero contacts.
+		 */
+		f->fingers = f->pressure > 0 ? 1 : 0;
 		f->first_mp = 0;
 		f->is_mp = 0;
 		break;
-- 
2.8.1

