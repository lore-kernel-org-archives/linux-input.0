From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] Input: psmouse - reset device during probe
Date: Mon,  5 Jun 2017 14:27:52 -0600
Message-ID: <20170605202752.8061-1-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35853 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEU2A (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Jun 2017 16:28:00 -0400
Received: by mail-vk0-f48.google.com with SMTP id p85so72292097vkd.3
        for <linux-input@vger.kernel.org>; Mon, 05 Jun 2017 13:28:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux@endlessm.com, chiu@endlessm.com

New Acer laptops (Aspire A315-31 and several others) have an EC which
expects the PS/2 reset command to happen during boot.

On Linux, that means that currently the touchpad is unresponsive until
suspend/resume, when psmouse_reconnect() resets the device.

We observe that Windows sends a PS/2 reset command during boot.
Make Linux do the same here, making the touchpad usable on these
new products.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/input/mouse/psmouse-base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index f73b47b8c578..8f3c903db7b9 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1591,6 +1591,12 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	psmouse->resync_time = parent ? 0 : psmouse_resync_time;
 	psmouse->smartscroll = psmouse_smartscroll;
 
+	/* Reset the device, even though we would ordinarily expect it to
+	 * already be in the reset state. This matches Windows behaviour,
+	 * which some ECs require.
+	 */
+	psmouse_reset(psmouse);
+
 	psmouse_switch_protocol(psmouse, NULL);
 
 	if (!psmouse->protocol->smbus_companion) {
-- 
2.11.0

