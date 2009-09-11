From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: atkbd - rely on input core to restore state on
	resume
Date: Thu, 10 Sep 2009 22:48:17 -0700
Message-ID: <20090911054817.27150.36441.stgit@localhost.localdomain>
References: <20090911054210.27150.93405.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:43458 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbZIKFsQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:48:16 -0400
Received: by mail-px0-f189.google.com with SMTP id 27so621346pxi.15
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:48:19 -0700 (PDT)
In-Reply-To: <20090911054210.27150.93405.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rjw@sisk.pl

Now that input core takes care of restoring state of input devices
upon resume we don't need to do anything special here.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/atkbd.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c9523e4..904d4c9 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -773,23 +773,6 @@ static int atkbd_select_set(struct atkbd *atkbd, int target_set, int allow_extra
 static int atkbd_activate(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
-	unsigned char param[1];
-
-/*
- * Set the LEDs to a defined state.
- */
-
-	param[0] = 0;
-	if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
-		return -1;
-
-/*
- * Set autorepeat to fastest possible.
- */
-
-	param[0] = 0;
-	if (ps2_command(ps2dev, param, ATKBD_CMD_SETREP))
-		return -1;
 
 /*
  * Enable the keyboard to receive keystrokes.
@@ -1158,14 +1141,6 @@ static int atkbd_reconnect(struct serio *serio)
 			return -1;
 
 		atkbd_activate(atkbd);
-
-/*
- * Restore repeat rate and LEDs (that were reset by atkbd_activate)
- * to pre-resume state
- */
-		if (!atkbd->softrepeat)
-			atkbd_set_repeat_rate(atkbd);
-		atkbd_set_leds(atkbd);
 	}
 
 	atkbd_enable(atkbd);

