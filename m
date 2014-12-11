From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH 2/4] HID: logitech-hidpp: check name retrieval return code
Date: Thu, 11 Dec 2014 13:51:18 +0100
Message-ID: <1418302280-14794-3-git-send-email-peter@lekensteyn.nl>
References: <1418302280-14794-1-git-send-email-peter@lekensteyn.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418302280-14794-1-git-send-email-peter@lekensteyn.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

hidpp_devicenametype_get_device_name() may return a negative value on
protocol errors (for example, when the device is powered off).
Explicitly check this condition to avoid a long-running loop.

(0 cannot be returned as __name_length - index > 0, but check for it
anyway as it would otherwise result in an infinite loop.)

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/hid/hid-logitech-hidpp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5066df8..4d72c20 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -484,10 +484,16 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 	if (!name)
 		return NULL;
 
-	while (index < __name_length)
-		index += hidpp_devicenametype_get_device_name(hidpp,
+	while (index < __name_length) {
+		ret = hidpp_devicenametype_get_device_name(hidpp,
 			feature_index, index, name + index,
 			__name_length - index);
+		if (ret <= 0) {
+			kfree(name);
+			return NULL;
+		}
+		index += ret;
+	}
 
 	return name;
 }
-- 
2.1.3
