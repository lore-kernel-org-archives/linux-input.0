From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 07/15] HID: logitech-hidpp: return an error if the feature is not present
Date: Thu,  2 Feb 2017 15:12:21 +0100
Message-ID: <20170202141229.17322-8-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbdBBOMy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 09:12:54 -0500
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Or the device just answers a valid feature '0'.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ef7ef9e..f7b2589 100644
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

