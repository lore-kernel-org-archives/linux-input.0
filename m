From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] Input: psmouse - rename ps2pp_init() to ps2pp_detect()
Date: Wed, 2 Dec 2015 11:25:55 -0800
Message-ID: <20151202192555.GA25587@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35709 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbLBTZ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 14:25:58 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org

This makes Logitech PS2++ protocol implementation consistent with
the naming in other protocols. Also mark the stub as "static inline"

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

V2: add forgotten drivers/input/mouse/logips2pp.c file.

 drivers/input/mouse/logips2pp.c    | 2 +-
 drivers/input/mouse/logips2pp.h    | 4 ++--
 drivers/input/mouse/psmouse-base.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index 136e222..422da1c 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -325,7 +325,7 @@ static void ps2pp_set_model_properties(struct psmouse *psmouse,
  * that support it.
  */
 
-int ps2pp_init(struct psmouse *psmouse, bool set_properties)
+int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
diff --git a/drivers/input/mouse/logips2pp.h b/drivers/input/mouse/logips2pp.h
index 0c186f0..bf62945 100644
--- a/drivers/input/mouse/logips2pp.h
+++ b/drivers/input/mouse/logips2pp.h
@@ -12,9 +12,9 @@
 #define _LOGIPS2PP_H
 
 #ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
-int ps2pp_init(struct psmouse *psmouse, bool set_properties);
+int ps2pp_detect(struct psmouse *psmouse, bool set_properties);
 #else
-inline int ps2pp_init(struct psmouse *psmouse, bool set_properties)
+static inline int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
 {
 	return -ENOSYS;
 }
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index e909c6e..90d9218 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -699,7 +699,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.type		= PSMOUSE_PS2PP,
 		.name		= "PS2++",
 		.alias		= "logitech",
-		.detect		= ps2pp_init,
+		.detect		= ps2pp_detect,
 	},
 #endif
 	{
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
