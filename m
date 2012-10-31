From: Chung-yih Wang <cywang@chromium.org>
Subject: [PATCH] Input: psmouse - retry getid command in psmouse_probe()
Date: Wed, 31 Oct 2012 18:11:19 +0800
Message-ID: <1351678279-32615-1-git-send-email-cywang@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:39025 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932975Ab2JaKMJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 06:12:09 -0400
Received: by mail-ee0-f74.google.com with SMTP id b57so83583eek.1
        for <linux-input@vger.kernel.org>; Wed, 31 Oct 2012 03:12:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tai-hwa Liang <avatar@sentelic.com>, Rusty Russell <rusty@rustcorp.com.au>, Paul Fox <pgf@laptop.org>, Chung-yih Wang <cywang@chromium.org>, linux-kernel@vger.kernel.org

As the synaptics device may not respond to the first command in psmouse_probe
when a machine is booting up, the patch gives a second probe if the first
one fails.

Signed-off-by: Chung-yih Wang <cywang@chromium.org>
---
 drivers/input/mouse/psmouse-base.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 22fe254..c4fc5ad 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1053,8 +1053,17 @@ static int psmouse_probe(struct psmouse *psmouse)
  */
 
 	param[0] = 0xa5;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
-		return -1;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID)) {
+		/*
+		 * Reprobe the device if it did not respond to the GETID
+		 * command. Before retry, additional dummy command is sent
+		 * to clear the 'RESEND' response if exists.
+		 */
+		psmouse_warn(psmouse, "GETID probe failed, retrying...\n");
+		ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+		if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
+			return -1;
+	}
 
 	if (param[0] != 0x00 && param[0] != 0x03 &&
 	    param[0] != 0x04 && param[0] != 0xff)
-- 
1.7.7.3

