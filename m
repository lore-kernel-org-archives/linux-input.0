From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 06/14] alps: process_bitmap: Round down when spreading adjescent fingers over 2 points
Date: Wed,  9 Jul 2014 17:24:11 +0200
Message-ID: <1404919459-23561-7-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932544AbaGIPYf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:35 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

This fixes 2 fingers at the same height or width on the touchpad getting
reported at different y / x coordinates.

Note num_bits is always at least 1.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index ebf8187..f8c04fc 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -391,13 +391,13 @@ static int alps_process_bitmap(struct alps_data *priv,
 	 * adjacent fingers. Divide the single contact between the two points.
 	 */
 	if (fingers_x == 1) {
-		i = x_low.num_bits / 2;
+		i = (x_low.num_bits - 1) / 2;
 		x_low.num_bits = x_low.num_bits - i;
 		x_high.start_bit = x_low.start_bit + i;
 		x_high.num_bits = max(i, 1);
 	}
 	if (fingers_y == 1) {
-		i = y_low.num_bits / 2;
+		i = (y_low.num_bits - 1) / 2;
 		y_low.num_bits = y_low.num_bits - i;
 		y_high.start_bit = y_low.start_bit + i;
 		y_high.num_bits = max(i, 1);
-- 
2.0.0

