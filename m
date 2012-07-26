From: Tai-hwa Liang <avatar@sentelic.com>
Subject: [PATCH 1/2] Input: sentelic - filtering out erratic movement
Date: Thu, 26 Jul 2012 12:11:06 +0800
Message-ID: <1343275867-5179-1-git-send-email-avatar@sentelic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:25566 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab2GZELR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Jul 2012 00:11:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

It turns out that certain hardware sometime generates unexpected movement
during normal operation. This patch tries to filter out these erratic
movements which will cause unexpected cursor jumping to the top-left corner.

Bugzilla:	https://bugzilla.kernel.org/show_bug.cgi?id=43197
Reported-and-tested-by:	Aleksey Spiridonov <leks13@leks13.ru>
Tested-by:	Eddie Dunn <eddie.dunn@gmail.com>
Tested-by:	Jakub Luzny <limoto94@gmail.com>
Tested-by:	Olivier Goffart <olivier@woboq.com>
Signed-off-by: Tai-hwa Liang <avatar@sentelic.com>
---
 drivers/input/mouse/sentelic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 3f5649f..060edef 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -721,6 +721,14 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
 
 	switch (psmouse->packet[0] >> FSP_PKT_TYPE_SHIFT) {
 	case FSP_PKT_TYPE_ABS:
+		if ((packet[0] == 0x48 || packet[0] == 0x49) &&
+		    packet[1] == 0 && packet[2] == 0) {
+			/*
+			 * filtering out erratic movement which will cause
+			 * unexpected cursor jumping to the top-left corner
+			 */
+			return PSMOUSE_FULL_PACKET;
+		}
 		abs_x = GET_ABS_X(packet);
 		abs_y = GET_ABS_Y(packet);
 
-- 
1.7.9.5

