From: Antonio Ospite <ao2@ao2.it>
Subject: [RESEND PATCH 5/6] HID: sony: fix some warnings from scripts/checkpatch.pl
Date: Tue,  9 Feb 2016 13:55:07 +0100
Message-ID: <1455022508-20041-6-git-send-email-ao2@ao2.it>
References: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:3837 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628AbcBIMzd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 07:55:33 -0500
In-Reply-To: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Antonio Ospite <ao2@ao2.it>

  WARNING: Block comments use a trailing */ on a separate line
  #822: FILE: drivers/hid/hid-sony.c:822:
  +	   * number but it's not needed for correct operation */

  WARNING: Block comments use a trailing */ on a separate line
  #828: FILE: drivers/hid/hid-sony.c:828:
  +	   * buttons multiple keypresses are allowed */

  WARNING: Block comments use a trailing */ on a separate line
  #854: FILE: drivers/hid/hid-sony.c:854:
  +	   * 0xff and 11th is for press indication */

  WARNING: Missing a blank line after declarations
  #1930: FILE: drivers/hid/hid-sony.c:1930:
  +	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
  +	sc->send_output_report(sc);

  WARNING: Block comments use a trailing */ on a separate line
  #2510: FILE: drivers/hid/hid-sony.c:2510:
  +	 * Logitech joystick from the device descriptor. */

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Acked-by: Frank Praznik <frank.praznik@gmail.com>
---
 drivers/hid/hid-sony.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ce516f3..eeea87e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -818,14 +818,18 @@ static __u8 ps3remote_rdesc[] = {
 	 /* Use collection 1 for joypad buttons */
 	 0xA1, 0x02,         /* MCollection Logical (interrelated data) */
 
-	  /* Ignore the 1st byte, maybe it is used for a controller
-	   * number but it's not needed for correct operation */
+	  /*
+	   * Ignore the 1st byte, maybe it is used for a controller
+	   * number but it's not needed for correct operation
+	   */
 	  0x75, 0x08,        /* GReportSize 0x08 [8] */
 	  0x95, 0x01,        /* GReportCount 0x01 [1] */
 	  0x81, 0x01,        /* MInput 0x01 (Const[0] Arr[1] Abs[2]) */
 
-	  /* Bytes from 2nd to 4th are a bitmap for joypad buttons, for these
-	   * buttons multiple keypresses are allowed */
+	  /*
+	   * Bytes from 2nd to 4th are a bitmap for joypad buttons, for these
+	   * buttons multiple keypresses are allowed
+	   */
 	  0x05, 0x09,        /* GUsagePage Button */
 	  0x19, 0x01,        /* LUsageMinimum 0x01 [Button 1 (primary/trigger)] */
 	  0x29, 0x18,        /* LUsageMaximum 0x18 [Button 24] */
@@ -850,8 +854,10 @@ static __u8 ps3remote_rdesc[] = {
 	  0x95, 0x01,        /* GReportCount 0x01 [1] */
 	  0x80,              /* MInput  */
 
-	  /* Ignore bytes from 6th to 11th, 6th to 10th are always constant at
-	   * 0xff and 11th is for press indication */
+	  /*
+	   * Ignore bytes from 6th to 11th, 6th to 10th are always constant at
+	   * 0xff and 11th is for press indication
+	   */
 	  0x75, 0x08,        /* GReportSize 0x08 [8] */
 	  0x95, 0x06,        /* GReportCount 0x06 [6] */
 	  0x81, 0x01,        /* MInput 0x01 (Const[0] Arr[1] Abs[2]) */
@@ -1928,6 +1934,7 @@ static inline void sony_send_output_report(struct sony_sc *sc)
 static void sony_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+
 	sc->send_output_report(sc);
 }
 
@@ -2507,8 +2514,10 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = VAIO_RDESC_CONSTANT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE),
 		.driver_data = VAIO_RDESC_CONSTANT },
-	/* Wired Buzz Controller. Reported as Sony Hub from its USB ID and as
-	 * Logitech joystick from the device descriptor. */
+	/*
+	 * Wired Buzz Controller. Reported as Sony Hub from its USB ID and as
+	 * Logitech joystick from the device descriptor.
+	 */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER),
 		.driver_data = BUZZ_CONTROLLER },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER),
-- 
2.7.0

