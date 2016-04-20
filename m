From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 5/5] Input: zforce_ts: Fix dual touch recognition
Date: Wed, 20 Apr 2016 08:54:45 +0200
Message-ID: <1461135285-17582-5-git-send-email-dirk.behme@de.bosch.com>
References: <1461135285-17582-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:55486 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbcDTGyw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2016 02:54:52 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 35781D8022E
	for <linux-input@vger.kernel.org>; Wed, 20 Apr 2016 08:54:51 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id DCDBD23804D0
	for <linux-input@vger.kernel.org>; Wed, 20 Apr 2016 08:54:50 +0200 (CEST)
In-Reply-To: <1461135285-17582-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <linux@rempel-privat.de>, Dirk Behme <dirk.behme@de.bosch.com>

From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>

A wrong decoding of the touch coordinate message causes a wrong touch
ID. Touch ID for dual touch must be 0 or 1.

According to the actual Neonode nine byte touch coordinate coding,
the state is transported in the lower nibble and the touch ID in
the higher nibble of payload byte five.

Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index fd435fe..9790d7a 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -412,8 +412,8 @@ static int zforce_touch_event(struct zforce_ts *ts, u8 *payload)
 			point.coord_x = point.coord_y = 0;
 		}
 
-		point.state = payload[9 * i + 5] & 0x03;
-		point.id = (payload[9 * i + 5] & 0xfc) >> 2;
+		point.state = payload[9 * i + 5] & 0x0f;
+		point.id = (payload[9 * i + 5] & 0xf0) >> 4;
 
 		/* determine touch major, minor and orientation */
 		point.area_major = max(payload[9 * i + 6],
-- 
2.8.0

