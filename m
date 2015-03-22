From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v3 2/5] input: synaptics - change default width value of cr48 sensors
Date: Sun, 22 Mar 2015 15:43:53 +0100
Message-ID: <1427035436-2168-3-git-send-email-gabriele.mzt@gmail.com>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38108 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbCVOo0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Mar 2015 10:44:26 -0400
In-Reply-To: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>

The minimum value these sensors can report is 4, so this should be the
value used when W is not reporting the width.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 133e488..a7a0e73 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1018,7 +1018,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 
 	if (hw.z > 0 && hw.x > 1) {
 		num_fingers = 1;
-		finger_width = 5;
+		finger_width = 4;
 		if (SYN_CAP_EXTENDED(priv->capabilities)) {
 			switch (hw.w) {
 			case 0 ... 1:
-- 
2.1.4

