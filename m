From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 2/5] input/alps: Handle 0-pressure 1F events
Date: Mon,  3 Oct 2016 08:16:27 -0400
Message-ID: <20161003121630.5285-2-ben@smart-cactus.org>
References: <20161003121630.5285-1-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from turtle.smart-cactus.org ([163.172.166.228]:55544 "EHLO
        mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbcJCMZo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2016 08:25:44 -0400
In-Reply-To: <20161003121630.5285-1-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Ben Gamari <ben@smart-cactus.org>

While a button is held SS5 hardware will give us single-finger packets
with x, y, and pressure equal to zero. This causes annoying jumps in
pointer position if a touch is released while the button is held. Handle
this by claiming zero contacts to ensure that no position events are
provided to the user.

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Tested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
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
2.9.3

