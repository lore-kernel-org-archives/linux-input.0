From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 09/14] alps: Use single touch data when v3 mt data contains only one finger
Date: Wed,  9 Jul 2014 17:24:14 +0200
Message-ID: <1404919459-23561-10-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12292 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554AbaGIPYj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:39 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

For v3 protocol devices, use the more accurate single touch data when the
mt data contains only one finger. Note the mt data reporting a finger count
of 1 should never happen, but better safe then sorry.

This brings the v3 bitmap handling in line with what the v4 code does,
allowing to factor out the common bits into a helper function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 9bebeb4..c9991b4 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -669,7 +669,7 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 	 * If we don't have MT data or the bitmaps were empty, we have
 	 * to rely on ST data.
 	 */
-	if (!fingers) {
+	if (fingers < 2) {
 		f->mt[0].x = f->st.x;
 		f->mt[0].y = f->st.y;
 		fingers = f->pressure > 0 ? 1 : 0;
-- 
2.0.0

