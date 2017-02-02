From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 12/15] HID: logitech-hidpp: do not query the name through HID++ for 1.0 devices
Date: Thu,  2 Feb 2017 15:12:26 +0100
Message-ID: <20170202141229.17322-13-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Unless they are connected through unifying, they don't support it,
so remove one error in the logs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f62cf5f..225cf96 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2614,6 +2614,8 @@ static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
 		 * Ask the receiver for its name.
 		 */
 		name = hidpp_get_unifying_name(hidpp);
+	else if (hidpp->protocol_major < 2)
+		return;
 	else
 		name = hidpp_get_device_name(hidpp);
 
-- 
2.9.3
