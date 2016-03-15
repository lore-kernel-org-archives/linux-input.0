From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] Input: synaptics - checking Extbit when passing ext_buttons to pt_port
Date: Tue, 15 Mar 2016 11:45:22 +0800
Message-ID: <1458013522-8139-1-git-send-email-hui.wang@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48620 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbcCODra (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 23:47:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, hui.wang@canonical.com

We found a problem on couples of Lenovo laptop models, when we press
down the extend button of trackstick (IBM trackpoint), the driver will
report both key_down and key_up events to the userspace, while we
release that button, the driver won't report any events to the
userspace.

Through debugging, we found when we press down or release the extend
button, the hardware will report more than one packets to the driver,
only one packet is valid (Extbit is set to 1), the rest of the
packets only contain zero. The current driver won't drop those
invalid packets but regard them as ext_button packets and pass them
to the pt_port, unfortunately the zero means key release, as a
result the userspace get the key_up event immediately following the
key_down event.

Adding an Extbit check before passing ext_buttons to pt_port can
drop all invalid packets and fix this problem.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/input/mouse/synaptics.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 6025eb4..ad81140 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -880,9 +880,11 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
 	/*
 	 * This generation of touchpads has the trackstick buttons
 	 * physically wired to the touchpad. Re-route them through
-	 * the pass-through interface.
+	 * the pass-through interface. And only pass extend button
+	 * events to pt_port when ExtBit is 1.
 	 */
-	if (!priv->pt_port)
+	if (!priv->pt_port ||
+	    !((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02))
 		return;
 
 	/* The trackstick expects at most 3 buttons */
-- 
1.9.1

