From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: psmouse - limit protocols that we try on passthrough
 ports
Date: Tue, 24 Nov 2015 18:16:31 -0800
Message-ID: <20151125021631.GA22384@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33253 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbbKYCQe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 21:16:34 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mathias Gottschlag <mgottschlag@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org

PS/2 protocol is slow, and using it with pass-through port (where we
encapsulate PS/2 into PS/2) is slower yet so it takes quite a bit of time
to do full protocol discovery for device attached to a pass-through port.
However, so far we have not see anything but tackpoint or basic PS/2 device
on pass-through ports, so let's limit protocols that we probe there to
Trackpoint, IntelliMouse Explorer, IntelliMouse, and bare PS/2 protocol,
and avoid other extended protocols, such as Synaptics, ALPS, etc.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/focaltech.c    |   4 +-
 drivers/input/mouse/psmouse-base.c | 575 +++++++++++++++++++------------------
 2 files changed, 297 insertions(+), 282 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 4d5576d..d03f916 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -461,9 +461,7 @@ fail:
 
 int focaltech_init(struct psmouse *psmouse)
 {
-	focaltech_reset(psmouse);
-
-	return 0;
+	return -ENOSYS;
 }
 
 #endif /* CONFIG_MOUSE_PS2_FOCALTECH */
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index ad18dab..9610017 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -119,6 +119,7 @@ struct psmouse_protocol {
 	enum psmouse_type type;
 	bool maxproto;
 	bool ignore_parity; /* Protocol should ignore parity errors from KBC */
+	bool try_passthru; /* Try protocol also on passthrough ports */
 	const char *name;
 	const char *alias;
 	int (*detect)(struct psmouse *, bool);
@@ -699,284 +700,6 @@ static int cortron_detect(struct psmouse *psmouse, bool set_properties)
 	return 0;
 }
 
-/*
- * Apply default settings to the psmouse structure. Most of them will
- * be overridden by individual protocol initialization routines.
- */
-
-static void psmouse_apply_defaults(struct psmouse *psmouse)
-{
-	struct input_dev *input_dev = psmouse->dev;
-
-	memset(input_dev->evbit, 0, sizeof(input_dev->evbit));
-	memset(input_dev->keybit, 0, sizeof(input_dev->keybit));
-	memset(input_dev->relbit, 0, sizeof(input_dev->relbit));
-	memset(input_dev->absbit, 0, sizeof(input_dev->absbit));
-	memset(input_dev->mscbit, 0, sizeof(input_dev->mscbit));
-
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(EV_REL, input_dev->evbit);
-
-	__set_bit(BTN_LEFT, input_dev->keybit);
-	__set_bit(BTN_RIGHT, input_dev->keybit);
-
-	__set_bit(REL_X, input_dev->relbit);
-	__set_bit(REL_Y, input_dev->relbit);
-
-	__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
-	psmouse->set_rate = psmouse_set_rate;
-	psmouse->set_resolution = psmouse_set_resolution;
-	psmouse->set_scale = psmouse_set_scale;
-	psmouse->poll = psmouse_poll;
-	psmouse->protocol_handler = psmouse_process_byte;
-	psmouse->pktsize = 3;
-	psmouse->reconnect = NULL;
-	psmouse->disconnect = NULL;
-	psmouse->cleanup = NULL;
-	psmouse->pt_activate = NULL;
-	psmouse->pt_deactivate = NULL;
-}
-
-/*
- * Apply default settings to the psmouse structure and call specified
- * protocol detection or initialization routine.
- */
-static int psmouse_do_detect(int (*detect)(struct psmouse *psmouse,
-					   bool set_properties),
-			     struct psmouse *psmouse, bool set_properties)
-{
-	if (set_properties)
-		psmouse_apply_defaults(psmouse);
-
-	return detect(psmouse, set_properties);
-}
-
-/*
- * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
- * the mouse may have.
- */
-
-static int psmouse_extensions(struct psmouse *psmouse,
-			      unsigned int max_proto, bool set_properties)
-{
-	bool synaptics_hardware = false;
-
-/* Always check for focaltech, this is safe as it uses pnp-id matching */
-	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
-		if (max_proto > PSMOUSE_IMEX) {
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
-			}
-		}
-	}
-
-/*
- * We always check for lifebook because it does not disturb mouse
- * (it only checks DMI information).
- */
-	if (psmouse_do_detect(lifebook_detect, psmouse, set_properties) == 0) {
-		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || lifebook_init(psmouse) == 0)
-				return PSMOUSE_LIFEBOOK;
-		}
-	}
-
-	if (psmouse_do_detect(vmmouse_detect, psmouse, set_properties) == 0) {
-		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || vmmouse_init(psmouse) == 0)
-				return PSMOUSE_VMMOUSE;
-		}
-	}
-
-/*
- * Try Kensington ThinkingMouse (we try first, because synaptics probe
- * upsets the thinkingmouse).
- */
-
-	if (max_proto > PSMOUSE_IMEX &&
-	    psmouse_do_detect(thinking_detect, psmouse, set_properties) == 0) {
-		return PSMOUSE_THINKPS;
-	}
-
-/*
- * Try Synaptics TouchPad. Note that probing is done even if Synaptics protocol
- * support is disabled in config - we need to know if it is synaptics so we
- * can reset it properly after probing for intellimouse.
- */
-	if (max_proto > PSMOUSE_PS2 &&
-	    psmouse_do_detect(synaptics_detect, psmouse, set_properties) == 0) {
-		synaptics_hardware = true;
-
-		if (max_proto > PSMOUSE_IMEX) {
-/*
- * Try activating protocol, but check if support is enabled first, since
- * we try detecting Synaptics even when protocol is disabled.
- */
-			if (IS_ENABLED(CONFIG_MOUSE_PS2_SYNAPTICS) &&
-			    (!set_properties || synaptics_init(psmouse) == 0)) {
-				return PSMOUSE_SYNAPTICS;
-			}
-
-/*
- * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
- * Unfortunately Logitech/Genius probes confuse some firmware versions so
- * we'll have to skip them.
- */
-			max_proto = PSMOUSE_IMEX;
-		}
-/*
- * Make sure that touchpad is in relative mode, gestures (taps) are enabled
- */
-		synaptics_reset(psmouse);
-	}
-
-/*
- * Try Cypress Trackpad.
- * Must try it before Finger Sensing Pad because Finger Sensing Pad probe
- * upsets some modules of Cypress Trackpads.
- */
-	if (max_proto > PSMOUSE_IMEX &&
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
-	}
-
-/*
- * Try ALPS TouchPad
- */
-	if (max_proto > PSMOUSE_IMEX) {
-		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
-		if (psmouse_do_detect(alps_detect,
-				      psmouse, set_properties) == 0) {
-			if (!set_properties || alps_init(psmouse) == 0)
-				return PSMOUSE_ALPS;
-/*
- * Init failed, try basic relative protocols
- */
-			max_proto = PSMOUSE_IMEX;
-		}
-	}
-
-/*
- * Try OLPC HGPK touchpad.
- */
-	if (max_proto > PSMOUSE_IMEX &&
-	    psmouse_do_detect(hgpk_detect, psmouse, set_properties) == 0) {
-		if (!set_properties || hgpk_init(psmouse) == 0)
-			return PSMOUSE_HGPK;
-/*
- * Init failed, try basic relative protocols
- */
-		max_proto = PSMOUSE_IMEX;
-	}
-
-/*
- * Try Elantech touchpad.
- */
-	if (max_proto > PSMOUSE_IMEX &&
-	    psmouse_do_detect(elantech_detect, psmouse, set_properties) == 0) {
-		if (!set_properties || elantech_init(psmouse) == 0)
-			return PSMOUSE_ELANTECH;
-/*
- * Init failed, try basic relative protocols
- */
-		max_proto = PSMOUSE_IMEX;
-	}
-
-	if (max_proto > PSMOUSE_IMEX) {
-		if (psmouse_do_detect(genius_detect,
-				      psmouse, set_properties) == 0)
-			return PSMOUSE_GENPS;
-
-		if (psmouse_do_detect(ps2pp_init,
-				      psmouse, set_properties) == 0)
-			return PSMOUSE_PS2PP;
-
-		if (psmouse_do_detect(trackpoint_detect,
-				      psmouse, set_properties) == 0)
-			return PSMOUSE_TRACKPOINT;
-
-		if (psmouse_do_detect(touchkit_ps2_detect,
-				      psmouse, set_properties) == 0)
-			return PSMOUSE_TOUCHKIT_PS2;
-	}
-
-/*
- * Try Finger Sensing Pad. We do it here because its probe upsets
- * Trackpoint devices (causing TP_READ_ID command to time out).
- */
-	if (max_proto > PSMOUSE_IMEX) {
-		if (psmouse_do_detect(fsp_detect,
-				      psmouse, set_properties) == 0) {
-			if (!set_properties || fsp_init(psmouse) == 0)
-				return PSMOUSE_FSP;
-/*
- * Init failed, try basic relative protocols
- */
-			max_proto = PSMOUSE_IMEX;
-		}
-	}
-
-/*
- * Reset to defaults in case the device got confused by extended
- * protocol probes. Note that we follow up with full reset because
- * some mice put themselves to sleep when they see PSMOUSE_RESET_DIS.
- */
-	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
-	psmouse_reset(psmouse);
-
-	if (max_proto >= PSMOUSE_IMEX &&
-	    psmouse_do_detect(im_explorer_detect,
-			      psmouse, set_properties) == 0) {
-		return PSMOUSE_IMEX;
-	}
-
-	if (max_proto >= PSMOUSE_IMPS &&
-	    psmouse_do_detect(intellimouse_detect,
-			      psmouse, set_properties) == 0) {
-		return PSMOUSE_IMPS;
-	}
-
-/*
- * Okay, all failed, we have a standard mouse here. The number of the buttons
- * is still a question, though. We assume 3.
- */
-	psmouse_do_detect(ps2bare_detect, psmouse, set_properties);
-
-	if (synaptics_hardware) {
-/*
- * We detected Synaptics hardware but it did not respond to IMPS/2 probes.
- * We need to reset the touchpad because if there is a track point on the
- * pass through port it could get disabled while probing for protocol
- * extensions.
- */
-		psmouse_reset(psmouse);
-	}
-
-	return PSMOUSE_PS2;
-}
-
 static const struct psmouse_protocol psmouse_protocols[] = {
 	{
 		.type		= PSMOUSE_PS2,
@@ -985,6 +708,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.maxproto	= true,
 		.ignore_parity	= true,
 		.detect		= ps2bare_detect,
+		.try_passthru	= true,
 	},
 #ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
 	{
@@ -1022,6 +746,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.maxproto	= true,
 		.ignore_parity	= true,
 		.detect		= intellimouse_detect,
+		.try_passthru	= true,
 	},
 	{
 		.type		= PSMOUSE_IMEX,
@@ -1030,6 +755,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.maxproto	= true,
 		.ignore_parity	= true,
 		.detect		= im_explorer_detect,
+		.try_passthru	= true,
 	},
 #ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 	{
@@ -1061,6 +787,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.type		= PSMOUSE_LIFEBOOK,
 		.name		= "LBPS/2",
 		.alias		= "lifebook",
+		.detect		= lifebook_detect,
 		.init		= lifebook_init,
 	},
 #endif
@@ -1070,6 +797,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.name		= "TPPS/2",
 		.alias		= "trackpoint",
 		.detect		= trackpoint_detect,
+		.try_passthru	= true,
 	},
 #endif
 #ifdef CONFIG_MOUSE_PS2_TOUCHKIT
@@ -1138,7 +866,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 	},
 };
 
-static const struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type type)
+static const struct psmouse_protocol *__psmouse_protocol_by_type(enum psmouse_type type)
 {
 	int i;
 
@@ -1146,6 +874,17 @@ static const struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type
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
@@ -1166,6 +905,284 @@ static const struct psmouse_protocol *psmouse_protocol_by_name(const char *name,
 	return NULL;
 }
 
+/*
+ * Apply default settings to the psmouse structure. Most of them will
+ * be overridden by individual protocol initialization routines.
+ */
+
+static void psmouse_apply_defaults(struct psmouse *psmouse)
+{
+	struct input_dev *input_dev = psmouse->dev;
+
+	memset(input_dev->evbit, 0, sizeof(input_dev->evbit));
+	memset(input_dev->keybit, 0, sizeof(input_dev->keybit));
+	memset(input_dev->relbit, 0, sizeof(input_dev->relbit));
+	memset(input_dev->absbit, 0, sizeof(input_dev->absbit));
+	memset(input_dev->mscbit, 0, sizeof(input_dev->mscbit));
+
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(EV_REL, input_dev->evbit);
+
+	__set_bit(BTN_LEFT, input_dev->keybit);
+	__set_bit(BTN_RIGHT, input_dev->keybit);
+
+	__set_bit(REL_X, input_dev->relbit);
+	__set_bit(REL_Y, input_dev->relbit);
+
+	__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
+	psmouse->set_rate = psmouse_set_rate;
+	psmouse->set_resolution = psmouse_set_resolution;
+	psmouse->set_scale = psmouse_set_scale;
+	psmouse->poll = psmouse_poll;
+	psmouse->protocol_handler = psmouse_process_byte;
+	psmouse->pktsize = 3;
+	psmouse->reconnect = NULL;
+	psmouse->disconnect = NULL;
+	psmouse->cleanup = NULL;
+	psmouse->pt_activate = NULL;
+	psmouse->pt_deactivate = NULL;
+}
+
+static bool psmouse_try_protocol(struct psmouse *psmouse,
+				 enum psmouse_type type,
+				 unsigned int *max_proto,
+				 bool set_properties, bool do_init)
+{
+	const struct psmouse_protocol *proto;
+
+	proto = __psmouse_protocol_by_type(type);
+	if (!proto)
+		return false;
+
+	if (psmouse->ps2dev.serio->id.type == SERIO_PS_PSTHRU &&
+	    !proto->try_passthru) {
+		return false;
+	}
+
+	if (set_properties)
+		psmouse_apply_defaults(psmouse);
+
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
+}
+
+/*
+ * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
+ * the mouse may have.
+ */
+
+static int psmouse_extensions(struct psmouse *psmouse,
+			      unsigned int max_proto, bool set_properties)
+{
+	bool synaptics_hardware = false;
+
+	/*
+	 * Always check for focaltech, this is safe as it uses pnp-id
+	 * matching
+	 */
+	if (psmouse_try_protocol(psmouse, PSMOUSE_FOCALTECH,
+				 &max_proto, set_properties, false)) {
+		if (max_proto > PSMOUSE_IMEX) {
+			if (IS_ENABLED(CONFIG_MOUSE_PS2_FOCALTECH) &&
+			    (!set_properties || focaltech_init(psmouse) == 0)) {
+				return PSMOUSE_FOCALTECH;
+			}
+		}
+
+		/*
+		 * Restrict psmouse_max_proto so that psmouse_initialize()
+		 * does not try to reset rate and resolution, because even
+		 * that upsets the device.
+		 * This also causes us to basically fall through to basic
+		 * protocol detection, where we fully reset the mouse,
+		 * and set it up as bare PS/2 protocol device.
+		 */
+		psmouse_max_proto = PSMOUSE_PS2;
+	}
+
+	/*
+	 * We always check for lifebook because it does not disturb mouse
+	 * (it only checks DMI information).
+	 */
+	if (psmouse_try_protocol(psmouse, PSMOUSE_LIFEBOOK, &max_proto,
+				 set_properties, max_proto > PSMOUSE_IMEX))
+		return PSMOUSE_LIFEBOOK;
+
+	if (psmouse_try_protocol(psmouse, PSMOUSE_VMMOUSE, &max_proto,
+				 set_properties, max_proto > PSMOUSE_IMEX))
+		return PSMOUSE_VMMOUSE;
+
+	/*
+	 * Try Kensington ThinkingMouse (we try first, because Synaptics
+	 * probe upsets the thinkingmouse).
+	 */
+	if (max_proto > PSMOUSE_IMEX &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_THINKPS, &max_proto,
+				 set_properties, true)) {
+		return PSMOUSE_THINKPS;
+	}
+
+	/*
+	 * Try Synaptics TouchPad. Note that probing is done even if
+	 * Synaptics protocol support is disabled in config - we need to
+	 * know if it is Synaptics so we can reset it properly after
+	 * probing for IntelliMouse.
+	 */
+	if (max_proto > PSMOUSE_PS2 &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_SYNAPTICS, &max_proto,
+				 set_properties, false)) {
+		synaptics_hardware = true;
+
+		if (max_proto > PSMOUSE_IMEX) {
+			/*
+			 * Try activating protocol, but check if support is
+			 * enabled first, since we try detecting Synaptics
+			 * even when protocol is disabled.
+			 */
+			if (IS_ENABLED(CONFIG_MOUSE_PS2_SYNAPTICS) &&
+			    (!set_properties || synaptics_init(psmouse) == 0)) {
+				return PSMOUSE_SYNAPTICS;
+			}
+
+			/*
+			 * Some Synaptics touchpads can emulate extended
+			 * protocols (like IMPS/2).  Unfortunately
+			 * Logitech/Genius probes confuse some firmware
+			 * versions so we'll have to skip them.
+			 */
+			max_proto = PSMOUSE_IMEX;
+		}
+
+		/*
+		 * Make sure that touchpad is in relative mode, gestures
+		 * (taps) are enabled.
+		 */
+		synaptics_reset(psmouse);
+	}
+
+	/*
+	 * Try Cypress Trackpad.  Must try it before Finger Sensing Pad
+	 * because Finger Sensing Pad probe upsets some modules of Cypress
+	 * Trackpads.
+	 */
+	if (max_proto > PSMOUSE_IMEX &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_CYPRESS, &max_proto,
+				 set_properties, true)) {
+		return PSMOUSE_CYPRESS;
+	}
+
+	/*
+	 * Try ALPS TouchPad
+	 */
+	if (max_proto > PSMOUSE_IMEX) {
+		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+		if (psmouse_try_protocol(psmouse, PSMOUSE_ALPS,
+					 &max_proto, set_properties, true))
+			return PSMOUSE_ALPS;
+	}
+
+	/*
+	 * Try OLPC HGPK touchpad.
+	 */
+	if (max_proto > PSMOUSE_IMEX &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_HGPK, &max_proto,
+				 set_properties, true)) {
+		return PSMOUSE_HGPK;
+	}
+
+	/*
+	 * Try Elantech touchpad.
+	 */
+	if (max_proto > PSMOUSE_IMEX &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_ELANTECH,
+				 &max_proto, set_properties, true)) {
+		return PSMOUSE_ELANTECH;
+	}
+
+	if (max_proto > PSMOUSE_IMEX) {
+		if (psmouse_try_protocol(psmouse, PSMOUSE_GENPS,
+					 &max_proto, set_properties, true))
+			return PSMOUSE_GENPS;
+
+		if (psmouse_try_protocol(psmouse, PSMOUSE_PS2PP,
+					 &max_proto, set_properties, true))
+			return PSMOUSE_PS2PP;
+
+		if (psmouse_try_protocol(psmouse, PSMOUSE_TRACKPOINT,
+					 &max_proto, set_properties, true))
+			return PSMOUSE_TRACKPOINT;
+
+		if (psmouse_try_protocol(psmouse, PSMOUSE_TOUCHKIT_PS2,
+					 &max_proto, set_properties, true))
+			return PSMOUSE_TOUCHKIT_PS2;
+	}
+
+	/*
+	 * Try Finger Sensing Pad. We do it here because its probe upsets
+	 * Trackpoint devices (causing TP_READ_ID command to time out).
+	 */
+	if (max_proto > PSMOUSE_IMEX &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_FSP,
+				 &max_proto, set_properties, true)) {
+		return PSMOUSE_FSP;
+	}
+
+	/*
+	 * Reset to defaults in case the device got confused by extended
+	 * protocol probes. Note that we follow up with full reset because
+	 * some mice put themselves to sleep when they see
+	 * PSMOUSE_RESET_DIS.
+	 */
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+	psmouse_reset(psmouse);
+
+	if (max_proto >= PSMOUSE_IMEX &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_IMEX,
+				 &max_proto, set_properties, true)) {
+		return PSMOUSE_IMEX;
+	}
+
+	if (max_proto >= PSMOUSE_IMPS &&
+	    psmouse_try_protocol(psmouse, PSMOUSE_IMPS,
+				 &max_proto, set_properties, true)) {
+		return PSMOUSE_IMPS;
+	}
+
+	/*
+	 * Okay, all failed, we have a standard mouse here. The number of
+	 * the buttons is still a question, though. We assume 3.
+	 */
+	psmouse_try_protocol(psmouse, PSMOUSE_PS2,
+			     &max_proto, set_properties, true);
+
+	if (synaptics_hardware) {
+		/*
+		 * We detected Synaptics hardware but it did not respond to
+		 * IMPS/2 probes.  We need to reset the touchpad because if
+		 * there is a track point on the pass through port it could
+		 * get disabled while probing for protocol extensions.
+		 */
+		psmouse_reset(psmouse);
+	}
+
+	return PSMOUSE_PS2;
+}
 
 /*
  * psmouse_probe() probes for a PS/2 mouse.
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
