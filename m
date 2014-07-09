From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/14] alps: process_bitmap: Fix counting of high point bits
Date: Wed,  9 Jul 2014 17:24:10 +0200
Message-ID: <1404919459-23561-6-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555AbaGIPYe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:34 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

alps_process_bitmap was resetting the point bit-count as soon as it saw
2 0 bits in a row. This means that unless the high point actually is at
the end of the bitmap, it would always get its num_bits set to 0.

Instead reset num_bits to 0 on a 0-1 transition, so that with > 2 fingers
we only count the number of bits occupied by the highest finger.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 00c735d..ebf8187 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -342,14 +342,13 @@ static void alps_get_bitmap_points(unsigned int map,
 		if (bit) {
 			if (!prev_bit) {
 				point->start_bit = i;
+				point->num_bits = 0;
 				(*fingers)++;
 			}
 			point->num_bits++;
 		} else {
 			if (prev_bit)
 				point = high;
-			else
-				point->num_bits = 0;
 		}
 		prev_bit = bit;
 	}
-- 
2.0.0

