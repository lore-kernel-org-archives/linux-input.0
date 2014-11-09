From: Jamie Lentin <jm@lentin.co.uk>
Subject: [PATCH 2/2] HID: lenovo: Don't set EV_REP to avoid repeating mice buttons
Date: Sun,  9 Nov 2014 07:54:30 +0000
Message-ID: <1415519670-24449-3-git-send-email-jm@lentin.co.uk>
References: <1415519670-24449-1-git-send-email-jm@lentin.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415519670-24449-1-git-send-email-jm@lentin.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jamie Lentin <jm@lentin.co.uk>
List-Id: linux-input@vger.kernel.org

On the USB keyboard, the VENDOR hotkeys share the same device as the
mouse. Setting EV_REP also affects mouse buttons, so leave it off.

The bluetooth keyboard still has autorepeating mouse buttons, as it
only has one device and is set by the KEYBOARD pages.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 drivers/hid/hid-lenovo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 4716f1e..4c55f4d 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -62,7 +62,6 @@ static int lenovo_input_mapping_cptkbd(struct hid_device *hdev,
 	/* HID_UP_LNVENDOR = USB, HID_UP_MSVENDOR = BT */
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR ||
 	    (usage->hid & HID_USAGE_PAGE) == HID_UP_LNVENDOR) {
-		set_bit(EV_REP, hi->input->evbit);
 		switch (usage->hid & HID_USAGE) {
 		case 0x00f1: /* Fn-F4: Mic mute */
 			map_key_clear(KEY_MICMUTE);
-- 
2.1.0
