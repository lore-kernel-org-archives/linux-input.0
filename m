From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/6] Input: psmouse - factor out common protocol probing code
Date: Sat, 28 Nov 2015 21:13:55 -0800
Message-ID: <1448774036-39040-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In preparation of limiting protocols that we try on pass-through ports,
let's rework initialization code and factor common code into
psmouse_try_protocol() that accepts protocol type (instead of detec()
function pointer) and can, for most protocols, perform both detection and
initialization.

Note that this removes option of forcing Lifebook protocol on devices that
are not recognized by lifebook_detect() as having the hardware, but I do
not recall anyone using this option.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 159 +++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 77 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index b92c1bd..ee59b0e 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -767,6 +767,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.type		= PSMOUSE_LIFEBOOK,
 		.name		= "LBPS/2",
 		.alias		= "lifebook",
+		.detect		= lifebook_detect,
 		.init		= lifebook_init,
 	},
 #endif
@@ -844,7 +845,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 	},
 };
 
-static const struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type type)
+static const struct psmouse_protocol *__psmouse_protocol_by_type(enum psmouse_type type)
 {
 	int i;
 
@@ -852,6 +853,17 @@ static const struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type
 		if (psmouse_protocols[i].type == type)
 			return &psmouse_protocols[i];
 
+	return NULL;
+}
+
+static const struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type type)
+{
+	const struct psmouse_protocol *proto;
+
+	proto = __psmouse_protocol_by_type(type);
+	if (proto)
+		return proto;
+
 	WARN_ON(1);
 	return &psmouse_protocols[0];
 }
@@ -910,18 +922,37 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
 	psmouse->pt_deactivate = NULL;
 }
 
-/*
- * Apply default settings to the psmouse structure and call specified
- * protocol detection or initialization routine.
- */
-static int psmouse_do_detect(int (*detect)(struct psmouse *psmouse,
-					   bool set_properties),
-			     struct psmouse *psmouse, bool set_properties)
+static bool psmouse_try_protocol(struct psmouse *psmouse,
+				 enum psmouse_type type,
+				 unsigned int *max_proto,
+				 bool set_properties, bool do_init)
 {
+	const struct psmouse_protocol *proto;
+
+	proto = __psmouse_protocol_by_type(type);
+	if (!proto)
+		return false;
+
 	if (set_properties)
 		psmouse_apply_defaults(psmouse);
 
-	return detect(psmouse, set_properties);
+	if (proto->detect(psmouse, set_properties) != 0)
+		return false;
+
+	if (set_properties && do_init && proto->init) {
+		if (proto->init(psmouse) != 0) {
+			/*
+			 * We detected device, but init failed. Adjust
+			 * max_proto so we only try standard protocols.
+			 */
+			if (*max_proto > PSMOUSE_IMEX)
+				*max_proto = PSMOUSE_IMEX;
+
+			return false;
+		}
+	}
+
+	return true;
 }
 
 /*
@@ -937,7 +968,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * Always check for focaltech, this is safe as it uses pnp-id
 	 * matching.
 	 */
-	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
+	if (psmouse_try_protocol(psmouse, PSMOUSE_FOCALTECH,
+				 &max_proto, set_properties, false)) {
 		if (max_proto > PSMOUSE_IMEX) {
 			if (IS_ENABLED(CONFIG_MOUSE_PS2_FOCALTECH) &&
 			    (!set_properties || focaltech_init(psmouse) == 0)) {
@@ -959,26 +991,21 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * We always check for LifeBook because it does not disturb mouse
 	 * (it only checks DMI information).
 	 */
-	if (psmouse_do_detect(lifebook_detect, psmouse, set_properties) == 0) {
-		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || lifebook_init(psmouse) == 0)
-				return PSMOUSE_LIFEBOOK;
-		}
-	}
+	if (psmouse_try_protocol(psmouse, PSMOUSE_LIFEBOOK, &max_proto,
+				 set_properties, max_proto > PSMOUSE_IMEX))
+		return PSMOUSE_LIFEBOOK;
 
-	if (psmouse_do_detect(vmmouse_detect, psmouse, set_properties) == 0) {
-		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || vmmouse_init(psmouse) == 0)
-				return PSMOUSE_VMMOUSE;
-		}
-	}
+	if (psmouse_try_protocol(psmouse, PSMOUSE_VMMOUSE, &max_proto,
+				 set_properties, max_proto > PSMOUSE_IMEX))
+		return PSMOUSE_VMMOUSE;
 
 	/*
 	 * Try Kensington ThinkingMouse (we try first, because Synaptics
 	 * probe upsets the ThinkingMouse).
 	 */
 	if (max_proto > PSMOUSE_IMEX &&
-	    psmouse_do_detect(thinking_detect, psmouse, set_properties) == 0) {
+	    psmouse_try_protocol(psmouse, PSMOUSE_THINKPS, &max_proto,
+				 set_properties, true)) {
 		return PSMOUSE_THINKPS;
 	}
 
@@ -989,7 +1016,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * probing for IntelliMouse.
 	 */
 	if (max_proto > PSMOUSE_PS2 &&
-	    psmouse_do_detect(synaptics_detect, psmouse, set_properties) == 0) {
+	    psmouse_try_protocol(psmouse, PSMOUSE_SYNAPTICS, &max_proto,
+				 set_properties, false)) {
 		synaptics_hardware = true;
 
 		if (max_proto > PSMOUSE_IMEX) {
@@ -1025,68 +1053,48 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * Trackpads.
 	 */
 	if (max_proto > PSMOUSE_IMEX &&
-			cypress_detect(psmouse, set_properties) == 0) {
-		if (IS_ENABLED(CONFIG_MOUSE_PS2_CYPRESS)) {
-			if (cypress_init(psmouse) == 0)
-				return PSMOUSE_CYPRESS;
-
-			/*
-			 * Finger Sensing Pad probe upsets some modules of
-			 * Cypress Trackpad, must avoid Finger Sensing Pad
-			 * probe if Cypress Trackpad device detected.
-			 */
-			return PSMOUSE_PS2;
-		}
-
-		max_proto = PSMOUSE_IMEX;
+	    psmouse_try_protocol(psmouse, PSMOUSE_CYPRESS, &max_proto,
+				 set_properties, true)) {
+		return PSMOUSE_CYPRESS;
 	}
 
 	/* Try ALPS TouchPad */
 	if (max_proto > PSMOUSE_IMEX) {
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
-		if (psmouse_do_detect(alps_detect,
-				      psmouse, set_properties) == 0) {
-			if (!set_properties || alps_init(psmouse) == 0)
-				return PSMOUSE_ALPS;
-
-			/* Init failed, try basic relative protocols */
-			max_proto = PSMOUSE_IMEX;
-		}
+		if (psmouse_try_protocol(psmouse, PSMOUSE_ALPS,
+					 &max_proto, set_properties, true))
+			return PSMOUSE_ALPS;
 	}
 
 	/* Try OLPC HGPK touchpad */
 	if (max_proto > PSMOUSE_IMEX &&
-	    psmouse_do_detect(hgpk_detect, psmouse, set_properties) == 0) {
-		if (!set_properties || hgpk_init(psmouse) == 0)
-			return PSMOUSE_HGPK;
-			/* Init failed, try basic relative protocols */
-		max_proto = PSMOUSE_IMEX;
+	    psmouse_try_protocol(psmouse, PSMOUSE_HGPK, &max_proto,
+				 set_properties, true)) {
+		return PSMOUSE_HGPK;
 	}
 
 	/* Try Elantech touchpad */
 	if (max_proto > PSMOUSE_IMEX &&
-	    psmouse_do_detect(elantech_detect, psmouse, set_properties) == 0) {
-		if (!set_properties || elantech_init(psmouse) == 0)
-			return PSMOUSE_ELANTECH;
-		/* Init failed, try basic relative protocols */
-		max_proto = PSMOUSE_IMEX;
+	    psmouse_try_protocol(psmouse, PSMOUSE_ELANTECH,
+				 &max_proto, set_properties, true)) {
+		return PSMOUSE_ELANTECH;
 	}
 
 	if (max_proto > PSMOUSE_IMEX) {
-		if (psmouse_do_detect(genius_detect,
-				      psmouse, set_properties) == 0)
+		if (psmouse_try_protocol(psmouse, PSMOUSE_GENPS,
+					 &max_proto, set_properties, true))
 			return PSMOUSE_GENPS;
 
-		if (psmouse_do_detect(ps2pp_init,
-				      psmouse, set_properties) == 0)
+		if (psmouse_try_protocol(psmouse, PSMOUSE_PS2PP,
+					 &max_proto, set_properties, true))
 			return PSMOUSE_PS2PP;
 
-		if (psmouse_do_detect(trackpoint_detect,
-				      psmouse, set_properties) == 0)
+		if (psmouse_try_protocol(psmouse, PSMOUSE_TRACKPOINT,
+					 &max_proto, set_properties, true))
 			return PSMOUSE_TRACKPOINT;
 
-		if (psmouse_do_detect(touchkit_ps2_detect,
-				      psmouse, set_properties) == 0)
+		if (psmouse_try_protocol(psmouse, PSMOUSE_TOUCHKIT_PS2,
+					 &max_proto, set_properties, true))
 			return PSMOUSE_TOUCHKIT_PS2;
 	}
 
@@ -1094,14 +1102,10 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * Try Finger Sensing Pad. We do it here because its probe upsets
 	 * Trackpoint devices (causing TP_READ_ID command to time out).
 	 */
-	if (max_proto > PSMOUSE_IMEX) {
-		if (psmouse_do_detect(fsp_detect,
-				      psmouse, set_properties) == 0) {
-			if (!set_properties || fsp_init(psmouse) == 0)
-				return PSMOUSE_FSP;
-			/* Init failed, try basic relative protocols */
-			max_proto = PSMOUSE_IMEX;
-		}
+	if (max_proto > PSMOUSE_IMEX &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_FSP,
+				 &max_proto, set_properties, true)) {
+		return PSMOUSE_FSP;
 	}
 
 	/*
@@ -1113,14 +1117,14 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	psmouse_reset(psmouse);
 
 	if (max_proto >= PSMOUSE_IMEX &&
-	    psmouse_do_detect(im_explorer_detect,
-			      psmouse, set_properties) == 0) {
+	    psmouse_try_protocol(psmouse, PSMOUSE_IMEX,
+				 &max_proto, set_properties, true)) {
 		return PSMOUSE_IMEX;
 	}
 
 	if (max_proto >= PSMOUSE_IMPS &&
-	    psmouse_do_detect(intellimouse_detect,
-			      psmouse, set_properties) == 0) {
+	    psmouse_try_protocol(psmouse, PSMOUSE_IMPS,
+				 &max_proto, set_properties, true)) {
 		return PSMOUSE_IMPS;
 	}
 
@@ -1128,7 +1132,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * Okay, all failed, we have a standard mouse here. The number of
 	 * the buttons is still a question, though. We assume 3.
 	 */
-	psmouse_do_detect(ps2bare_detect, psmouse, set_properties);
+	psmouse_try_protocol(psmouse, PSMOUSE_PS2,
+			     &max_proto, set_properties, true);
 
 	if (synaptics_hardware) {
 		/*
-- 
2.6.0.rc2.230.g3dd15c0
