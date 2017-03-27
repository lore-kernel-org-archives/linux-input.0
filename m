From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 04/19] HID: logitech-hidpp: do not query the name through HID++ for 1.0 devices
Date: Mon, 27 Mar 2017 16:59:24 +0200
Message-ID: <20170327145939.29824-5-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Unless they are connected through unifying, they don't support it,
so remove one error in the logs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- moved up in the series

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1cda29e..4031405 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2309,6 +2309,8 @@ static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
 		 * Ask the receiver for its name.
 		 */
 		name = hidpp_get_unifying_name(hidpp);
+	else if (hidpp->protocol_major < 2)
+		return;
 	else
 		name = hidpp_get_device_name(hidpp);
 
-- 
2.9.3
