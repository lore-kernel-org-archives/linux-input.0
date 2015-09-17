From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH] HID: Make I2C a known bus in hid_connect()
Date: Thu, 17 Sep 2015 17:02:22 +0200
Message-ID: <1442502142-21116-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:42591 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbbIQPCb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 11:02:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Martin <daniel.martin@secunet.com>, Daniel Martin <consume.noise@gmail.com>

Just to prettify the log message. Otherwise it would be <UNKNOWN>.

Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e6fce23..2636fac 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1658,6 +1658,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_BLUETOOTH:
 		bus = "BLUETOOTH";
 		break;
+	case BUS_I2C:
+		bus = "I2C";
+		break;
 	default:
 		bus = "<UNKNOWN>";
 	}
-- 
2.1.4

