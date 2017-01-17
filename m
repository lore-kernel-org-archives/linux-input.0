From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 07/17] HID: logitech-hidpp: return an error if the feature is not present
Date: Tue, 17 Jan 2017 15:35:37 +0100
Message-ID: <20170117143547.30488-8-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Or the device just answers a valid feature '0'.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0c7144f..404b3b8 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -452,6 +452,9 @@ static int hidpp_root_get_feature(struct hidpp_device *hidpp, u16 feature,
 	if (ret)
 		return ret;
 
+	if (response.fap.params[0] == 0)
+		return -ENOENT;
+
 	*feature_index = response.fap.params[0];
 	*feature_type = response.fap.params[1];
 
-- 
2.9.3
