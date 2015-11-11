From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH v2 2/2] hid: sony: Save and restore the controller state on suspend and resume
Date: Wed, 11 Nov 2015 09:49:38 -0500
Message-ID: <1447253378-13939-3-git-send-email-frank.praznik@gmail.com>
References: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36692 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbbKKOtt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2015 09:49:49 -0500
Received: by ykdr82 with SMTP id r82so51434740ykd.3
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2015 06:49:48 -0800 (PST)
In-Reply-To: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, ao2@ao2.it, Frank Praznik <frank.praznik@gmail.com>

On hardware which provides standby power for charging devices the state of the
LEDs and force-feedback on controllers can persist even when the system is in
standby.  Additionally, the state of the controllers on resume may be different
from the state they were in at the time when they were suspended (ie. LEDs are
cleared on resume).

This implements the suspend and resume callbacks which saves and clears the
state of the LEDs on suspend and restores them on resume.  Force-feedback is
stopped on suspend but not automatically restored on resume until a new event is
received to avoid potentially damaging hardware.

USB Sixaxis and navigation controllers must be reinitialized when the hardware
is reset on resume or they won't send any input reports.

Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
---

 v2: Add reinitialization for the USB Sixaxis and navigation controllers in the
     resume function.

 drivers/hid/hid-sony.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index fb67839..04e328d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1045,6 +1045,7 @@ struct sony_sc {
 	__u8 battery_charging;
 	__u8 battery_capacity;
 	__u8 led_state[MAX_LEDS];
+	__u8 resume_led_state[MAX_LEDS];
 	__u8 led_delay_on[MAX_LEDS];
 	__u8 led_delay_off[MAX_LEDS];
 	__u8 led_count;
@@ -1905,6 +1906,12 @@ static void motion_send_output_report(struct sony_sc *sc)
 	hid_hw_output_report(hdev, (__u8 *)report, MOTION_REPORT_0x02_SIZE);
 }
 
+static inline void sony_send_output_report(struct sony_sc *sc)
+{
+	if (sc->send_output_report)
+		sc->send_output_report(sc);
+}
+
 static void sony_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
@@ -2420,6 +2427,56 @@ static void sony_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+#ifdef CONFIG_PM
+
+static int sony_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	/*
+	 * On suspend save the current LED state,
+	 * stop running force-feedback and blank the LEDS.
+         */
+	if (SONY_LED_SUPPORT || SONY_FF_SUPPORT) {
+		struct sony_sc *sc = hid_get_drvdata(hdev);
+
+#ifdef CONFIG_SONY_FF
+		sc->left = sc->right = 0;
+#endif
+
+		memcpy(sc->resume_led_state, sc->led_state,
+			sizeof(sc->resume_led_state));
+		memset(sc->led_state, 0, sizeof(sc->led_state));
+
+		sony_send_output_report(sc);
+	}
+
+	return 0;
+}
+
+static int sony_resume(struct hid_device *hdev)
+{
+	/* Restore the state of controller LEDs on resume */
+	if (SONY_LED_SUPPORT) {
+		struct sony_sc *sc = hid_get_drvdata(hdev);
+
+		memcpy(sc->led_state, sc->resume_led_state,
+			sizeof(sc->led_state));
+
+		/*
+		 * The Sixaxis and navigation controllers on USB need to be
+		 * reinitialized on resume or they won't behave properly.
+		 */
+		if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
+			(sc->quirks & NAVIGATION_CONTROLLER_USB))
+			sixaxis_set_operational_usb(sc->hdev);
+
+		sony_set_leds(sc);
+	}
+
+	return 0;
+}
+
+#endif
+
 static const struct hid_device_id sony_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB },
@@ -2469,7 +2526,13 @@ static struct hid_driver sony_driver = {
 	.probe            = sony_probe,
 	.remove           = sony_remove,
 	.report_fixup     = sony_report_fixup,
-	.raw_event        = sony_raw_event
+	.raw_event        = sony_raw_event,
+
+#ifdef CONFIG_PM
+	.suspend          = sony_suspend,
+	.resume	          = sony_resume,
+	.reset_resume     = sony_resume,
+#endif
 };
 
 static int __init sony_init(void)
-- 
2.4.3

