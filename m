From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 12/19] HID: logitech-hidpp: return an error if the queried feature is not present
Date: Mon, 27 Mar 2017 16:59:32 +0200
Message-ID: <20170327145939.29824-13-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753483AbdC0PAG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:06 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Or the device just answers a valid feature '0'.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- moved up in the series

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9a9771a..22129dd 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -503,6 +503,9 @@ static int hidpp_root_get_feature(struct hidpp_device *hidpp, u16 feature,
 	if (ret)
 		return ret;
 
+	if (response.fap.params[0] == 0)
+		return -ENOENT;
+
 	*feature_index = response.fap.params[0];
 	*feature_type = response.fap.params[1];
 
-- 
2.9.3

