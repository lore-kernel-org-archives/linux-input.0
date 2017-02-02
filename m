From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 03/15] HID: logitech-hidpp: make sure we only register one battery per device
Date: Thu,  2 Feb 2017 15:12:17 +0100
Message-ID: <20170202141229.17322-4-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Simple check to add, huge improvement :)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4aaf237..1cda29e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -828,6 +828,9 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 {
 	int ret;
 
+	if (hidpp->battery.ps)
+		return 0;
+
 	if (hidpp->protocol_major >= 2) {
 		ret = hidpp20_initialize_battery(hidpp);
 		if (ret == 0)
-- 
2.9.3
