From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 2/2] Fix the issue that V8 Button pad Stick button does not work
Date: Mon, 13 Mar 2017 16:04:10 +0900
Message-ID: <20170313070410.4710-2-masaki.ota@jp.alps.com>
References: <20170313070410.4710-1-masaki.ota@jp.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35669 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdCMHEW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 03:04:22 -0400
In-Reply-To: <20170313070410.4710-1-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-kernel@paulsd.com, nick.m.fletcher@gmail.com
Cc: joseph.salisbury@canonical.com, ben@smart-cactus.org, mhocko@suse.com, pali.rohar@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

From: Masaki Ota <masaki.ota@jp.alps.com>
- V8 Button pad Stick Right and Middle button don't work.
- Alps stick devices have physical buttons absolutely, so delete "ALPS_BUTTONPAD" check Flag from Stick button process.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/input/mouse/alps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a70c860..a13404f 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1287,10 +1287,8 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 	/* handle buttons */
 	if (pkt_id == SS4_PACKET_ID_STICK) {
 		f->ts_left = !!(SS4_BTN_V2(p) & 0x01);
-		if (!(priv->flags & ALPS_BUTTONPAD)) {
-			f->ts_right = !!(SS4_BTN_V2(p) & 0x02);
-			f->ts_middle = !!(SS4_BTN_V2(p) & 0x04);
-		}
+		f->ts_right = !!(SS4_BTN_V2(p) & 0x02);
+		f->ts_middle = !!(SS4_BTN_V2(p) & 0x04);
 	} else {
 		f->left = !!(SS4_BTN_V2(p) & 0x01);
 		if (!(priv->flags & ALPS_BUTTONPAD)) {
-- 
2.9.3

