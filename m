From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] Input: joystick - enable interrupts
Date: Wed, 31 Aug 2016 21:04:22 +0530
Message-ID: <1472657662-539-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35400 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933887AbcHaPen (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 31 Aug 2016 11:34:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The irq was disabled before reading from the gameport. After reading
we should enable it. Instead we were restoring it back to the previous
state before starting the do-while loop.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/input/joystick/analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3d8ff09..faa90bc 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -275,7 +275,7 @@ static int analog_cooked_read(struct analog_port *port)
 		local_irq_disable();
 		this = gameport_read(gameport) & port->mask;
 		now = get_time();
-		local_irq_restore(flags);
+		local_irq_enable();
 
 		if ((last ^ this) && (delta(loop, now) < loopout)) {
 			data[i] = last ^ this;
-- 
1.9.1

