From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 2/4] Input: synaptics - ignore bogus mt packet
Date: Sat, 18 Dec 2010 15:52:59 +0100
Message-ID: <1292683981-6908-3-git-send-email-rydberg@euromail.se>
References: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57835 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756452Ab0LROyG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Dec 2010 09:54:06 -0500
In-Reply-To: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

In multitouch mode, at least one device (fw: 7.4 id: 0x1c0b1) sometimes
sends a final main packet with x == 1. Since the normal values are above
1472, this is clearly bogus. At the same time, a two-finger touch is
signaled, even though only one finger was on the pad to begin with. This
patch ignores the packet altogether, removing the problem.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/synaptics.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 8a769e9..4744064 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -526,7 +526,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 		return;
 	}
 
-	if (hw.z > 0) {
+	if (hw.z > 0 && hw.x > 1) {
 		num_fingers = 1;
 		finger_width = 5;
 		if (SYN_CAP_EXTENDED(priv->capabilities)) {
@@ -558,7 +558,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 	if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
 	if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
 
-	if (hw.z > 0) {
+	if (hw.z > 0 && hw.x > 1) {
 		input_report_abs(dev, ABS_X, hw.x);
 		input_report_abs(dev, ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
 	}
-- 
1.7.2.3

