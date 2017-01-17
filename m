From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 14/17] HID: logitech-hidpp: do not query the name through HID++ for 1.0 devices
Date: Tue, 17 Jan 2017 15:35:44 +0100
Message-ID: <20170117143547.30488-15-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Unless they are connected through unifying, they don't support it,
so remove one error in the logs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f5889ff..17dd569 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2612,6 +2612,8 @@ static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
 		 * Ask the receiver for its name.
 		 */
 		name = hidpp_get_unifying_name(hidpp);
+	else if (hidpp->protocol_major < 2)
+		return;
 	else
 		name = hidpp_get_device_name(hidpp);
 
-- 
2.9.3
