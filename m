From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: wacom: remove the extra Pen interface for Wacom Bamboo PAD
Date: Thu, 18 Jun 2015 15:58:44 -0400
Message-ID: <1434657524-5374-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

As mentioned in the comment in the code, both the pen and touch data
come from the interface tagged as BAMBOO_PAD. The driver re-routes the
events for the Pen to the generic HID interface and keeps the ones for
the touch through this current interface.

Clearing the WACOM_DEVICETYPE_PEN bit removes the extra unused interface
and makes the Bamboo PAD to behave like in 4.1.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

well, the fix was definitively easy to restore the Bamboo PAD interface.

Thanks Jason for the good cleanup and sorry for not having the time to review
the previous series.

Cheers,
Benjamin

 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 232da89..d260528 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2223,7 +2223,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	 * so rewrite this one to be of type BTN_TOOL_FINGER.
 	 */
 	if (features->type == BAMBOO_PAD)
-		features->device_type |= WACOM_DEVICETYPE_TOUCH;
+		features->device_type = WACOM_DEVICETYPE_TOUCH;
 
 	if (wacom->hdev->bus == BUS_BLUETOOTH)
 		features->quirks |= WACOM_QUIRK_BATTERY;
-- 
2.4.2
