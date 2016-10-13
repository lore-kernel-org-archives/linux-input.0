From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: i2c-hid: exit if the IRQ is not valid
Date: Thu, 13 Oct 2016 11:30:45 +0200
Message-ID: <1476351045-8829-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753244AbcJMJbR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 05:31:17 -0400
In-Reply-To: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Arcari <darcari@redhat.com>

When i2c-core doesn't find the IRQ associated to the GPIO because
the gpiochip is not available, it assigns -EPROBE_DEFER to the irq.
We need to bail out there and on any other error in an IRQ.

Signed-off-by: David Arcari <darcari@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 4cd606c..fe6b4e0 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -956,6 +956,13 @@ static int i2c_hid_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	if (client->irq < 0) {
+		if (client->irq != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"HID over i2c doesn't have a valid IRQ\n");
+		return client->irq;
+	}
+
 	ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
 	if (!ihid)
 		return -ENOMEM;
-- 
2.7.4

