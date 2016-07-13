From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 02/30] HID: wacom: store the type in wacom->shared for INTUOSHT and INTUOSHT2
Date: Wed, 13 Jul 2016 18:05:49 +0200
Message-ID: <1468425977-4819-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The type is never set but we check for it in wacom_wireless_irq().
It looks like this is a big hack from the beginning, so fill in the gap
only.

Untested.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

No changes in v2
---
 drivers/hid/wacom_sys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 499cc82..9e283aa 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1720,9 +1720,10 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		error = hid_hw_open(hdev);
 
 	if ((wacom_wac->features.type == INTUOSHT ||
-	    wacom_wac->features.type == INTUOSHT2) &&
+	     wacom_wac->features.type == INTUOSHT2) &&
 	    (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)) {
-			wacom_wac->shared->touch_input = wacom_wac->touch_input;
+		wacom_wac->shared->type = wacom_wac->features.type;
+		wacom_wac->shared->touch_input = wacom_wac->touch_input;
 	}
 
 	return 0;
-- 
2.5.5
