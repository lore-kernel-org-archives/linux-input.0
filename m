From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: psmouse - rearrange Focaltech init code
Date: Sat, 28 Nov 2015 21:13:53 -0800
Message-ID: <1448774036-39040-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The fact that we were calling focaltech_init() even when Focaltech support
is disabled was confusing. Rearrange the code so that if support is
disabled we continue to fall through the rest of protocol probing code
until we get to full reset that Focaltech devices need to work properly.

Also, replace focaltech_init() with a stub now that it is only called when
protocol is enabled.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

I know I originally requested doing reset in focaltech_init() even when
focaltech support is disabled, but as I was working with the code I found
it confusing.

 drivers/input/mouse/focaltech.c    | 22 ++++++----------------
 drivers/input/mouse/focaltech.h    |  8 ++++++++
 drivers/input/mouse/psmouse-base.c | 23 ++++++++++++-----------
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 4d5576d..c8c6a8c 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -49,12 +49,6 @@ int focaltech_detect(struct psmouse *psmouse, bool set_properties)
 	return 0;
 }
 
-static void focaltech_reset(struct psmouse *psmouse)
-{
-	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
-	psmouse_reset(psmouse);
-}
-
 #ifdef CONFIG_MOUSE_PS2_FOCALTECH
 
 /*
@@ -300,6 +294,12 @@ static int focaltech_switch_protocol(struct psmouse *psmouse)
 	return 0;
 }
 
+static void focaltech_reset(struct psmouse *psmouse)
+{
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+	psmouse_reset(psmouse);
+}
+
 static void focaltech_disconnect(struct psmouse *psmouse)
 {
 	focaltech_reset(psmouse);
@@ -456,14 +456,4 @@ fail:
 	kfree(priv);
 	return error;
 }
-
-#else /* CONFIG_MOUSE_PS2_FOCALTECH */
-
-int focaltech_init(struct psmouse *psmouse)
-{
-	focaltech_reset(psmouse);
-
-	return 0;
-}
-
 #endif /* CONFIG_MOUSE_PS2_FOCALTECH */
diff --git a/drivers/input/mouse/focaltech.h b/drivers/input/mouse/focaltech.h
index ca61ebf..783b28e 100644
--- a/drivers/input/mouse/focaltech.h
+++ b/drivers/input/mouse/focaltech.h
@@ -18,6 +18,14 @@
 #define _FOCALTECH_H
 
 int focaltech_detect(struct psmouse *psmouse, bool set_properties);
+
+#ifdef CONFIG_MOUSE_PS2_FOCALTECH
 int focaltech_init(struct psmouse *psmouse);
+#else
+static inline int focaltech_init(struct psmouse *psmouse)
+{
+	return -ENOSYS;
+}
+#endif
 
 #endif
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 525de2e..c2bd866 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -750,19 +750,20 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 */
 	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
 		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || focaltech_init(psmouse) == 0) {
-				if (IS_ENABLED(CONFIG_MOUSE_PS2_FOCALTECH))
-					return PSMOUSE_FOCALTECH;
-				/*
-				 * Note that we need to also restrict
-				 * psmouse_max_proto so that psmouse_initialize()
-				 * does not try to reset rate and resolution,
-				 * because even that upsets the device.
-				 */
-				psmouse_max_proto = PSMOUSE_PS2;
-				return PSMOUSE_PS2;
+			if (IS_ENABLED(CONFIG_MOUSE_PS2_FOCALTECH) &&
+			    (!set_properties || focaltech_init(psmouse) == 0)) {
+				return PSMOUSE_FOCALTECH;
 			}
 		}
+		/*
+		 * Restrict psmouse_max_proto so that psmouse_initialize()
+		 * does not try to reset rate and resolution, because even
+		 * that upsets the device.
+		 * This also causes us to basically fall through to basic
+		 * protocol detection, where we fully reset the mouse,
+		 * and set it up as bare PS/2 protocol device.
+		 */
+		psmouse_max_proto = max_proto = PSMOUSE_PS2;
 	}
 
 	/*
-- 
2.6.0.rc2.230.g3dd15c0
