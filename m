From: Daniel Drake <drake@endlessm.com>
Subject: psmouse: reset during probe?
Date: Wed, 17 May 2017 14:59:50 -0600
Message-ID: <20170517205950.27449-1-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35522 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdEQVHX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 May 2017 17:07:23 -0400
Received: by mail-ua0-f175.google.com with SMTP id e55so425651uaa.2
        for <linux-input@vger.kernel.org>; Wed, 17 May 2017 14:07:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: chiu@endlessm.com, linux@endlessm.com

Hi,

A bunch of new Acer laptops have an EC which expects the PS/2 reset command
before the touchpad is initialized.

On Linux, that means that currently the touchpad is unresponsive until
suspend/resume, when psmouse_reconnect() resets the device.

It appears that Windows sends the reset command during boot. Should Linux
do the same for all mice here?

Thanks
Daniel

---
 drivers/input/mouse/psmouse-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 9f6203c8577c..0e506427ae91 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1546,6 +1546,7 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	psmouse->resync_time = parent ? 0 : psmouse_resync_time;
 	psmouse->smartscroll = psmouse_smartscroll;
 
+	psmouse_reset(psmouse);
 	psmouse_switch_protocol(psmouse, NULL);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
-- 
2.11.0

