From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH TRIVIAL] Input: logips2pp - Spelling s/reciver/receiver/
Date: Sun, 12 Jan 2014 14:01:48 +0100
Message-ID: <1389531708-6095-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:43593 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbaALNBu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jan 2014 08:01:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux-input@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/input/mouse/logips2pp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index 84de2fc6acc1..136e222e2a16 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -220,7 +220,7 @@ static const struct ps2pp_info *get_model_info(unsigned char model)
 		{ 61,	PS2PP_KIND_MX,					/* MX700 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
-		{ 66,	PS2PP_KIND_MX,					/* MX3100 reciver */
+		{ 66,	PS2PP_KIND_MX,					/* MX3100 receiver */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN | PS2PP_HWHEEL },
 		{ 72,	PS2PP_KIND_TRACKMAN,	0 },			/* T-CH11: TrackMan Marble */
-- 
1.7.9.5

