From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v4 1/4] input: synaptics - fix pressure values calculation on image sensors
Date: Fri,  1 Apr 2016 15:06:49 +0200
Message-ID: <1459516012-8060-2-git-send-email-gabriele.mzt@gmail.com>
References: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32958 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbcDANHM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2016 09:07:12 -0400
In-Reply-To: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>

The pressure values retrieved from secondary packets was incorrectly
shifted, making them lower than what they actually were.
Since this only happened with secondary packets, the values reported
when only one finger was present on the touchpad were correct.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a41d832..01fccca 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -677,7 +677,7 @@ static void synaptics_parse_agm(const unsigned char buf[],
 		agm->w = hw->w;
 		agm->x = (((buf[4] & 0x0f) << 8) | buf[1]) << 1;
 		agm->y = (((buf[4] & 0xf0) << 4) | buf[2]) << 1;
-		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0f)) << 1;
+		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0f)) << 2;
 		break;
 
 	case 2:
-- 
2.8.0.rc3

