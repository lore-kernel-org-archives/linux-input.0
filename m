From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2] HID: wacom: remove the extra Pen interface for Wacom Bamboo PAD
Date: Thu,  9 Jul 2015 14:11:51 -0400
Message-ID: <1436465511-5680-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbbGISLx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jul 2015 14:11:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

As mentioned in the comment in the code, both the pen and touch data
come from the interface tagged as BAMBOO_PAD. The driver re-routes the
events for the Pen to the generic HID interface and keeps the ones for
the touch through this current interface.

Clearing the WACOM_DEVICETYPE_PEN bit removes the extra unused interface
added in 2a6cdbd ("HID: wacom: Introduce new 'touch_input' device") and
makes the Bamboo PAD to behave like in 4.1.

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0d24423..baba9a0 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2223,10 +2223,10 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	 * 0, whose HID descriptor has an application usage of 0xFF0D
 	 * (i.e., WACOM_VENDORDEFINED_PEN). We route pen packets back
 	 * out through the HID_GENERIC device created for interface 1,
-	 * so rewrite this one to be of type BTN_TOOL_FINGER.
+	 * so rewrite this one to be of type WACOM_DEVICETYPE_TOUCH.
 	 */
 	if (features->type == BAMBOO_PAD)
-		features->device_type |= WACOM_DEVICETYPE_TOUCH;
+		features->device_type = WACOM_DEVICETYPE_TOUCH;
 
 	if (wacom->hdev->bus == BUS_BLUETOOTH)
 		features->quirks |= WACOM_QUIRK_BATTERY;
-- 
2.4.3

