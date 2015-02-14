From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCH 2/3] psmouse: Skip psmouse_initialize for FocalTech touchpads.
Date: Sat, 14 Feb 2015 20:01:41 +0100
Message-ID: <1423940502-12353-3-git-send-email-mgottschlag@gmail.com>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:38236 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbbBNTCY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Feb 2015 14:02:24 -0500
Received: by mail-qa0-f41.google.com with SMTP id x12so17065390qac.0
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2015 11:02:23 -0800 (PST)
In-Reply-To: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>

The driver used to skip all initialization code for FocalTech touchpads
because they stop responding when certain commands are sent. The new
driver failed reproduce this behaviour and psmouse_reconnect would still
cause standard initialization code to be executed.

This patch introduces a field "skip_standard_init" to struct psmouse. If
this field is set to true, psmouse_initialize will not do anything. This
solution is somewhat ugly, but I believe it is the least ugly way to
introduce this apparently required special case.

Also, the code is modified to not send PSMOUSE_CMD_ENABLE twice (once in
focaltech.c, once in the generic code in psmouse-base.c).

Signed-off-by: Mathias Gottschlag <mgottschlag@gmail.com>
---
 drivers/input/mouse/focaltech.c    | 5 ++---
 drivers/input/mouse/psmouse-base.c | 4 +++-
 drivers/input/mouse/psmouse.h      | 5 +++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 5d8cf98..05919cc 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -284,9 +284,6 @@ static int focaltech_switch_protocol(struct psmouse *psmouse)
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETSCALE11))
 		return -EIO;
 
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_ENABLE))
-		return -EIO;
-
 	return 0;
 }
 
@@ -413,6 +410,8 @@ int focaltech_init(struct psmouse *psmouse)
 	/* resync is not supported yet */
 	psmouse->resync_time = 0;
 
+	psmouse->skip_standard_init = true;
+
 	return 0;
 
 fail:
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 68469fe..b55a116 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -697,6 +697,8 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
 	psmouse->cleanup = NULL;
 	psmouse->pt_activate = NULL;
 	psmouse->pt_deactivate = NULL;
+
+	psmouse->skip_standard_init = false;
 }
 
 /*
@@ -1157,7 +1159,7 @@ static void psmouse_initialize(struct psmouse *psmouse)
  * We set the mouse report rate, resolution and scaling.
  */
 
-	if (psmouse_max_proto != PSMOUSE_PS2) {
+	if (psmouse_max_proto != PSMOUSE_PS2 && !psmouse->skip_standard_init) {
 		psmouse->set_rate(psmouse, psmouse->rate);
 		psmouse->set_resolution(psmouse, psmouse->resolution);
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index c2ff137..d1412ac 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -64,6 +64,11 @@ struct psmouse {
 	unsigned int resync_time;
 	bool smartscroll;	/* Logitech only */
 
+	/* FocalTech touchpads sometimes stop responding when standard commands
+	 * are sent after the custom protocol has been selected, so this flag
+	 * makes the code skip psmouse_initialize */
+	bool skip_standard_init;
+
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse);
 	void (*set_rate)(struct psmouse *psmouse, unsigned int rate);
 	void (*set_resolution)(struct psmouse *psmouse, unsigned int resolution);
-- 
2.1.0

