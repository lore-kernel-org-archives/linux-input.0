From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/6] Input: psmouse - fix comment style
Date: Sat, 28 Nov 2015 21:13:52 -0800
Message-ID: <1448774036-39040-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The module was using non-standard comment style with comment blocks often
starting at the very beginning of a line instead of being aligned with the
code. Let's switch to standard formatting.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 279 +++++++++++++++++--------------------
 1 file changed, 124 insertions(+), 155 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 4e43e7e..525de2e 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -129,7 +129,6 @@ struct psmouse_protocol {
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
  * relevant events to the input module once full packet has arrived.
  */
-
 psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
@@ -219,7 +218,6 @@ void psmouse_queue_work(struct psmouse *psmouse, struct delayed_work *work,
 /*
  * __psmouse_set_state() sets new psmouse state and resets all flags.
  */
-
 static inline void __psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
 {
 	psmouse->state = new_state;
@@ -228,13 +226,11 @@ static inline void __psmouse_set_state(struct psmouse *psmouse, enum psmouse_sta
 	psmouse->last = jiffies;
 }
 
-
 /*
  * psmouse_set_state() sets new psmouse state and resets all flags and
  * counters while holding serio lock so fighting with interrupt handler
  * is not a concern.
  */
-
 void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
 {
 	serio_pause_rx(psmouse->ps2dev.serio);
@@ -246,7 +242,6 @@ void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
  * psmouse_handle_byte() processes one byte of the input data stream
  * by calling corresponding protocol handler.
  */
-
 static int psmouse_handle_byte(struct psmouse *psmouse)
 {
 	psmouse_ret_t rc = psmouse->protocol_handler(psmouse);
@@ -289,7 +284,6 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
  * psmouse_interrupt() handles incoming characters, either passing them
  * for normal processing or gathering them as command response.
  */
-
 static irqreturn_t psmouse_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
@@ -332,9 +326,8 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 	}
 
 	psmouse->packet[psmouse->pktcnt++] = data;
-/*
- * Check if this is a new device announcement (0xAA 0x00)
- */
+
+	/* Check if this is a new device announcement (0xAA 0x00) */
 	if (unlikely(psmouse->packet[0] == PSMOUSE_RET_BAT && psmouse->pktcnt <= 2)) {
 		if (psmouse->pktcnt == 1) {
 			psmouse->last = jiffies;
@@ -348,9 +341,8 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 			serio_reconnect(serio);
 			goto out;
 		}
-/*
- * Not a new device, try processing first byte normally
- */
+
+		/* Not a new device, try processing first byte normally */
 		psmouse->pktcnt = 1;
 		if (psmouse_handle_byte(psmouse))
 			goto out;
@@ -358,9 +350,10 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		psmouse->packet[psmouse->pktcnt++] = data;
 	}
 
-/*
- * See if we need to force resync because mouse was idle for too long
- */
+	/*
+	 * See if we need to force resync because mouse was idle for
+	 * too long.
+	 */
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
 	    psmouse->pktcnt == 1 && psmouse->resync_time &&
 	    time_after(jiffies, psmouse->last + psmouse->resync_time * HZ)) {
@@ -377,7 +370,6 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 	return IRQ_HANDLED;
 }
 
-
 /*
  * psmouse_sliced_command() sends an extended PS/2 command to the mouse
  * using sliced syntax, understood by advanced devices, such as Logitech
@@ -401,7 +393,6 @@ int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command)
 	return 0;
 }
 
-
 /*
  * psmouse_reset() resets the mouse into power-on state.
  */
@@ -421,7 +412,6 @@ int psmouse_reset(struct psmouse *psmouse)
 /*
  * Here we set the mouse resolution.
  */
-
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution)
 {
 	static const unsigned char params[] = { 0, 1, 2, 2, 3 };
@@ -438,7 +428,6 @@ void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution)
 /*
  * Here we set the mouse report rate.
  */
-
 static void psmouse_set_rate(struct psmouse *psmouse, unsigned int rate)
 {
 	static const unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
@@ -454,7 +443,6 @@ static void psmouse_set_rate(struct psmouse *psmouse, unsigned int rate)
 /*
  * Here we set the mouse scaling.
  */
-
 static void psmouse_set_scale(struct psmouse *psmouse, enum psmouse_scale scale)
 {
 	ps2_command(&psmouse->ps2dev, NULL,
@@ -465,7 +453,6 @@ static void psmouse_set_scale(struct psmouse *psmouse, enum psmouse_scale scale)
 /*
  * psmouse_poll() - default poll handler. Everyone except for ALPS uses it.
  */
-
 static int psmouse_poll(struct psmouse *psmouse)
 {
 	return ps2_command(&psmouse->ps2dev, psmouse->packet,
@@ -599,7 +586,7 @@ static int im_explorer_detect(struct psmouse *psmouse, bool set_properties)
 	if (param[0] != 4)
 		return -1;
 
-/* Magic to enable horizontal scrolling on IntelliMouse 4.0 */
+	/* Magic to enable horizontal scrolling on IntelliMouse 4.0 */
 	param[0] = 200;
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
 	param[0] =  80;
@@ -669,10 +656,10 @@ static int ps2bare_detect(struct psmouse *psmouse, bool set_properties)
 		if (!psmouse->name)
 			psmouse->name = "Mouse";
 
-/*
- * We have no way of figuring true number of buttons so let's
- * assume that the device has 3.
- */
+		/*
+		 * We have no way of figuring true number of buttons so let's
+		 * assume that the device has 3.
+		 */
 		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
 	}
 
@@ -700,7 +687,6 @@ static int cortron_detect(struct psmouse *psmouse, bool set_properties)
  * Apply default settings to the psmouse structure. Most of them will
  * be overridden by individual protocol initialization routines.
  */
-
 static void psmouse_apply_defaults(struct psmouse *psmouse)
 {
 	struct input_dev *input_dev = psmouse->dev;
@@ -753,13 +739,15 @@ static int psmouse_do_detect(int (*detect)(struct psmouse *psmouse,
  * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
  * the mouse may have.
  */
-
 static int psmouse_extensions(struct psmouse *psmouse,
 			      unsigned int max_proto, bool set_properties)
 {
 	bool synaptics_hardware = false;
 
-/* Always check for focaltech, this is safe as it uses pnp-id matching */
+	/*
+	 * Always check for focaltech, this is safe as it uses pnp-id
+	 * matching.
+	 */
 	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
 		if (max_proto > PSMOUSE_IMEX) {
 			if (!set_properties || focaltech_init(psmouse) == 0) {
@@ -777,10 +765,10 @@ static int psmouse_extensions(struct psmouse *psmouse,
 		}
 	}
 
-/*
- * We always check for lifebook because it does not disturb mouse
- * (it only checks DMI information).
- */
+	/*
+	 * We always check for LifeBook because it does not disturb mouse
+	 * (it only checks DMI information).
+	 */
 	if (psmouse_do_detect(lifebook_detect, psmouse, set_properties) == 0) {
 		if (max_proto > PSMOUSE_IMEX) {
 			if (!set_properties || lifebook_init(psmouse) == 0)
@@ -795,53 +783,57 @@ static int psmouse_extensions(struct psmouse *psmouse,
 		}
 	}
 
-/*
- * Try Kensington ThinkingMouse (we try first, because synaptics probe
- * upsets the thinkingmouse).
- */
-
+	/*
+	 * Try Kensington ThinkingMouse (we try first, because Synaptics
+	 * probe upsets the ThinkingMouse).
+	 */
 	if (max_proto > PSMOUSE_IMEX &&
 	    psmouse_do_detect(thinking_detect, psmouse, set_properties) == 0) {
 		return PSMOUSE_THINKPS;
 	}
 
-/*
- * Try Synaptics TouchPad. Note that probing is done even if Synaptics protocol
- * support is disabled in config - we need to know if it is synaptics so we
- * can reset it properly after probing for intellimouse.
- */
+	/*
+	 * Try Synaptics TouchPad. Note that probing is done even if
+	 * Synaptics protocol support is disabled in config - we need to
+	 * know if it is Synaptics so we can reset it properly after
+	 * probing for IntelliMouse.
+	 */
 	if (max_proto > PSMOUSE_PS2 &&
 	    psmouse_do_detect(synaptics_detect, psmouse, set_properties) == 0) {
 		synaptics_hardware = true;
 
 		if (max_proto > PSMOUSE_IMEX) {
-/*
- * Try activating protocol, but check if support is enabled first, since
- * we try detecting Synaptics even when protocol is disabled.
- */
+			/*
+			 * Try activating protocol, but check if support is
+			 * enabled first, since we try detecting Synaptics
+			 * even when protocol is disabled.
+			 */
 			if (IS_ENABLED(CONFIG_MOUSE_PS2_SYNAPTICS) &&
 			    (!set_properties || synaptics_init(psmouse) == 0)) {
 				return PSMOUSE_SYNAPTICS;
 			}
 
-/*
- * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
- * Unfortunately Logitech/Genius probes confuse some firmware versions so
- * we'll have to skip them.
- */
+			/*
+			 * Some Synaptics touchpads can emulate extended
+			 * protocols (like IMPS/2).  Unfortunately
+			 * Logitech/Genius probes confuse some firmware
+			 * versions so we'll have to skip them.
+			 */
 			max_proto = PSMOUSE_IMEX;
 		}
-/*
- * Make sure that touchpad is in relative mode, gestures (taps) are enabled
- */
+
+		/*
+		 * Make sure that touchpad is in relative mode, gestures
+		 * (taps) are enabled.
+		 */
 		synaptics_reset(psmouse);
 	}
 
-/*
- * Try Cypress Trackpad.
- * Must try it before Finger Sensing Pad because Finger Sensing Pad probe
- * upsets some modules of Cypress Trackpads.
- */
+	/*
+	 * Try Cypress Trackpad. We must try it before Finger Sensing Pad
+	 * because Finger Sensing Pad probe upsets some modules of Cypress
+	 * Trackpads.
+	 */
 	if (max_proto > PSMOUSE_IMEX &&
 			cypress_detect(psmouse, set_properties) == 0) {
 		if (IS_ENABLED(CONFIG_MOUSE_PS2_CYPRESS)) {
@@ -859,45 +851,34 @@ static int psmouse_extensions(struct psmouse *psmouse,
 		max_proto = PSMOUSE_IMEX;
 	}
 
-/*
- * Try ALPS TouchPad
- */
+	/* Try ALPS TouchPad */
 	if (max_proto > PSMOUSE_IMEX) {
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 		if (psmouse_do_detect(alps_detect,
 				      psmouse, set_properties) == 0) {
 			if (!set_properties || alps_init(psmouse) == 0)
 				return PSMOUSE_ALPS;
-/*
- * Init failed, try basic relative protocols
- */
+
+			/* Init failed, try basic relative protocols */
 			max_proto = PSMOUSE_IMEX;
 		}
 	}
 
-/*
- * Try OLPC HGPK touchpad.
- */
+	/* Try OLPC HGPK touchpad */
 	if (max_proto > PSMOUSE_IMEX &&
 	    psmouse_do_detect(hgpk_detect, psmouse, set_properties) == 0) {
 		if (!set_properties || hgpk_init(psmouse) == 0)
 			return PSMOUSE_HGPK;
-/*
- * Init failed, try basic relative protocols
- */
+			/* Init failed, try basic relative protocols */
 		max_proto = PSMOUSE_IMEX;
 	}
 
-/*
- * Try Elantech touchpad.
- */
+	/* Try Elantech touchpad */
 	if (max_proto > PSMOUSE_IMEX &&
 	    psmouse_do_detect(elantech_detect, psmouse, set_properties) == 0) {
 		if (!set_properties || elantech_init(psmouse) == 0)
 			return PSMOUSE_ELANTECH;
-/*
- * Init failed, try basic relative protocols
- */
+		/* Init failed, try basic relative protocols */
 		max_proto = PSMOUSE_IMEX;
 	}
 
@@ -919,27 +900,25 @@ static int psmouse_extensions(struct psmouse *psmouse,
 			return PSMOUSE_TOUCHKIT_PS2;
 	}
 
-/*
- * Try Finger Sensing Pad. We do it here because its probe upsets
- * Trackpoint devices (causing TP_READ_ID command to time out).
- */
+	/*
+	 * Try Finger Sensing Pad. We do it here because its probe upsets
+	 * Trackpoint devices (causing TP_READ_ID command to time out).
+	 */
 	if (max_proto > PSMOUSE_IMEX) {
 		if (psmouse_do_detect(fsp_detect,
 				      psmouse, set_properties) == 0) {
 			if (!set_properties || fsp_init(psmouse) == 0)
 				return PSMOUSE_FSP;
-/*
- * Init failed, try basic relative protocols
- */
+			/* Init failed, try basic relative protocols */
 			max_proto = PSMOUSE_IMEX;
 		}
 	}
 
-/*
- * Reset to defaults in case the device got confused by extended
- * protocol probes. Note that we follow up with full reset because
- * some mice put themselves to sleep when they see PSMOUSE_RESET_DIS.
- */
+	/*
+	 * Reset to defaults in case the device got confused by extended
+	 * protocol probes. Note that we follow up with full reset because
+	 * some mice put themselves to sleep when they see PSMOUSE_RESET_DIS.
+	 */
 	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 	psmouse_reset(psmouse);
 
@@ -955,19 +934,19 @@ static int psmouse_extensions(struct psmouse *psmouse,
 		return PSMOUSE_IMPS;
 	}
 
-/*
- * Okay, all failed, we have a standard mouse here. The number of the buttons
- * is still a question, though. We assume 3.
- */
+	/*
+	 * Okay, all failed, we have a standard mouse here. The number of
+	 * the buttons is still a question, though. We assume 3.
+	 */
 	psmouse_do_detect(ps2bare_detect, psmouse, set_properties);
 
 	if (synaptics_hardware) {
-/*
- * We detected Synaptics hardware but it did not respond to IMPS/2 probes.
- * We need to reset the touchpad because if there is a track point on the
- * pass through port it could get disabled while probing for protocol
- * extensions.
- */
+		/*
+		 * We detected Synaptics hardware but it did not respond to
+		 * IMPS/2 probes.  We need to reset the touchpad because if
+		 * there is a track point on the pass through port it could
+		 * get disabled while probing for protocol extensions.
+		 */
 		psmouse_reset(psmouse);
 	}
 
@@ -1167,19 +1146,17 @@ static const struct psmouse_protocol *psmouse_protocol_by_name(const char *name,
 /*
  * psmouse_probe() probes for a PS/2 mouse.
  */
-
 static int psmouse_probe(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[2];
 
-/*
- * First, we check if it's a mouse. It should send 0x00 or 0x03
- * in case of an IntelliMouse in 4-byte mode or 0x04 for IM Explorer.
- * Sunrex K8561 IR Keyboard/Mouse reports 0xff on second and subsequent
- * ID queries, probably due to a firmware bug.
- */
-
+	/*
+	 * First, we check if it's a mouse. It should send 0x00 or 0x03 in
+	 * case of an IntelliMouse in 4-byte mode or 0x04 for IM Explorer.
+	 * Sunrex K8561 IR Keyboard/Mouse reports 0xff on second and
+	 * subsequent ID queries, probably due to a firmware bug.
+	 */
 	param[0] = 0xa5;
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
 		return -1;
@@ -1188,10 +1165,10 @@ static int psmouse_probe(struct psmouse *psmouse)
 	    param[0] != 0x04 && param[0] != 0xff)
 		return -1;
 
-/*
- * Then we reset and disable the mouse so that it doesn't generate events.
- */
-
+	/*
+	 * Then we reset and disable the mouse so that it doesn't generate
+	 * events.
+	 */
 	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_DIS))
 		psmouse_warn(psmouse, "Failed to reset mouse on %s\n",
 			     ps2dev->serio->phys);
@@ -1202,13 +1179,11 @@ static int psmouse_probe(struct psmouse *psmouse)
 /*
  * psmouse_initialize() initializes the mouse to a sane state.
  */
-
 static void psmouse_initialize(struct psmouse *psmouse)
 {
-/*
- * We set the mouse report rate, resolution and scaling.
- */
-
+	/*
+	 * We set the mouse report rate, resolution and scaling.
+	 */
 	if (psmouse_max_proto != PSMOUSE_PS2) {
 		psmouse->set_rate(psmouse, psmouse->rate);
 		psmouse->set_resolution(psmouse, psmouse->resolution);
@@ -1219,7 +1194,6 @@ static void psmouse_initialize(struct psmouse *psmouse)
 /*
  * psmouse_activate() enables the mouse so that we get motion reports from it.
  */
-
 int psmouse_activate(struct psmouse *psmouse)
 {
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE)) {
@@ -1233,10 +1207,9 @@ int psmouse_activate(struct psmouse *psmouse)
 }
 
 /*
- * psmouse_deactivate() puts the mouse into poll mode so that we don't get motion
- * reports from it unless we explicitly request it.
+ * psmouse_deactivate() puts the mouse into poll mode so that we don't get
+ * motion reports from it unless we explicitly request it.
  */
-
 int psmouse_deactivate(struct psmouse *psmouse)
 {
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE)) {
@@ -1249,11 +1222,9 @@ int psmouse_deactivate(struct psmouse *psmouse)
 	return 0;
 }
 
-
 /*
  * psmouse_resync() attempts to re-validate current protocol.
  */
-
 static void psmouse_resync(struct work_struct *work)
 {
 	struct psmouse *parent = NULL, *psmouse =
@@ -1273,16 +1244,16 @@ static void psmouse_resync(struct work_struct *work)
 		psmouse_deactivate(parent);
 	}
 
-/*
- * Some mice don't ACK commands sent while they are in the middle of
- * transmitting motion packet. To avoid delay we use ps2_sendbyte()
- * instead of ps2_command() which would wait for 200ms for an ACK
- * that may never come.
- * As an additional quirk ALPS touchpads may not only forget to ACK
- * disable command but will stop reporting taps, so if we see that
- * mouse at least once ACKs disable we will do full reconnect if ACK
- * is missing.
- */
+	/*
+	 * Some mice don't ACK commands sent while they are in the middle of
+	 * transmitting motion packet. To avoid delay we use ps2_sendbyte()
+	 * instead of ps2_command() which would wait for 200ms for an ACK
+	 * that may never come.
+	 * As an additional quirk ALPS touchpads may not only forget to ACK
+	 * disable command but will stop reporting taps, so if we see that
+	 * mouse at least once ACKs disable we will do full reconnect if ACK
+	 * is missing.
+	 */
 	psmouse->num_resyncs++;
 
 	if (ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, 20)) {
@@ -1291,13 +1262,13 @@ static void psmouse_resync(struct work_struct *work)
 	} else
 		psmouse->acks_disable_command = true;
 
-/*
- * Poll the mouse. If it was reset the packet will be shorter than
- * psmouse->pktsize and ps2_command will fail. We do not expect and
- * do not handle scenario when mouse "upgrades" its protocol while
- * disconnected since it would require additional delay. If we ever
- * see a mouse that does it we'll adjust the code.
- */
+	/*
+	 * Poll the mouse. If it was reset the packet will be shorter than
+	 * psmouse->pktsize and ps2_command will fail. We do not expect and
+	 * do not handle scenario when mouse "upgrades" its protocol while
+	 * disconnected since it would require additional delay. If we ever
+	 * see a mouse that does it we'll adjust the code.
+	 */
 	if (!failed) {
 		if (psmouse->poll(psmouse))
 			failed = true;
@@ -1314,11 +1285,12 @@ static void psmouse_resync(struct work_struct *work)
 			psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
 		}
 	}
-/*
- * Now try to enable mouse. We try to do that even if poll failed and also
- * repeat our attempts 5 times, otherwise we may be left out with disabled
- * mouse.
- */
+
+	/*
+	 * Now try to enable mouse. We try to do that even if poll failed
+	 * and also repeat our attempts 5 times, otherwise we may be left
+	 * out with disabled mouse.
+	 */
 	for (i = 0; i < 5; i++) {
 		if (!ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE)) {
 			enabled = true;
@@ -1350,7 +1322,6 @@ static void psmouse_resync(struct work_struct *work)
 /*
  * psmouse_cleanup() resets the mouse into power-on state.
  */
-
 static void psmouse_cleanup(struct serio *serio)
 {
 	struct psmouse *psmouse = serio_get_drvdata(serio);
@@ -1375,15 +1346,15 @@ static void psmouse_cleanup(struct serio *serio)
 	if (psmouse->cleanup)
 		psmouse->cleanup(psmouse);
 
-/*
- * Reset the mouse to defaults (bare PS/2 protocol).
- */
+	/*
+	 * Reset the mouse to defaults (bare PS/2 protocol).
+	 */
 	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 
-/*
- * Some boxes, such as HP nx7400, get terribly confused if mouse
- * is not fully enabled before suspending/shutting down.
- */
+	/*
+	 * Some boxes, such as HP nx7400, get terribly confused if mouse
+	 * is not fully enabled before suspending/shutting down.
+	 */
 	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 
 	if (parent) {
@@ -1399,7 +1370,6 @@ static void psmouse_cleanup(struct serio *serio)
 /*
  * psmouse_disconnect() closes and frees.
  */
-
 static void psmouse_disconnect(struct serio *serio)
 {
 	struct psmouse *psmouse, *parent = NULL;
@@ -1599,7 +1569,6 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	goto out;
 }
 
-
 static int psmouse_reconnect(struct serio *serio)
 {
 	struct psmouse *psmouse = serio_get_drvdata(serio);
-- 
2.6.0.rc2.230.g3dd15c0
