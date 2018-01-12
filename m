From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH] Input: trackpoint - force 3 buttons if 0 button is reported
Date: Fri, 12 Jan 2018 14:46:58 +0800
Message-ID: <20180112064658.25019-1-aaron.ma@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51372 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeALGri (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 Jan 2018 01:47:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Lenovo introduced trackpoint compatible sticks with minimum PS/2 commands.
Some of these sticks with 3 buttons always return 0 when reading
extended button info, set it as 3 buttons to enable middle button.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/trackpoint.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 0871010f18d5..00c0d1706567 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -383,6 +383,10 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 	if (trackpoint_read(ps2dev, TP_EXT_BTN, &button_info)) {
 		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons\n");
 		button_info = 0x33;
+	} else if (!button_info) {
+		psmouse_warn(psmouse,
+			"got no extended button data, assuming 3 buttons\n");
+		button_info = 0x33;
 	}
 
 	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
-- 
2.14.3

