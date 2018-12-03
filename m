From: Chris Chiu <chiu@endlessm.com>
Subject: [PATCH 2/2] HID: input: support Microsoft wireless radio control hotkey
Date: Mon,  3 Dec 2018 14:46:21 +0800
Message-ID: <20181203064621.69876-2-chiu@endlessm.com>
References: <20181203064621.69876-1-chiu@endlessm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203064621.69876-1-chiu@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com
List-Id: linux-input@vger.kernel.org

The ASUS laptops start to support the airplane mode radio management
to replace the original mechanism of airplane mode toggle hotkey.
On the ASUS P5440FF, it presents as a HID device connecting via
I2C, named i2c-AMPD0001. When pressing it, the Embedded Controller
send hid report via I2C and switch the airplane mode indicator LED
based on the status.

However, it's not working because it fails to be identified as a
hidinput device. It fails in hidinput_connect() due to the macro
IS_INPUT_APPLICATION doesn't have HID_GD_WIRELESS_RADIO_CTLS as
a legit application code.

It's easy to add the HID I2C vendor and product id to the quirk
list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
makes more sense to support it as a generic input application.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 include/linux/hid.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index ce5f996c8d3d..42079116fb61 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -840,7 +840,8 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
 #define IS_INPUT_APPLICATION(a) \
 		(((a >= HID_UP_GENDESK) && (a <= HID_GD_MULTIAXIS)) \
 		|| ((a >= HID_DG_PEN) && (a <= HID_DG_WHITEBOARD)) \
-		|| (a == HID_GD_SYSTEM_CONTROL) || (a == HID_CP_CONSUMER_CONTROL))
+		|| (a == HID_GD_SYSTEM_CONTROL) || (a == HID_CP_CONSUMER_CONTROL) \
+		|| (a == HID_GD_WIRELESS_RADIO_CTLS))
 
 /* HID core API */
 
-- 
2.19.1
