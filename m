From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] HID: i2c-hid: Fill in physical device providing HID functionality
Date: Mon, 28 Sep 2015 15:15:08 +0300
Message-ID: <1443442508-94971-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1443442508-94971-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40968 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756727AbbI1MPM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 08:15:12 -0400
In-Reply-To: <1443442508-94971-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org

Currently hid_connect() prints out following when I2C connected HID devices
is connected:

  hid-multitouch 0018:03EB:2136.0001: ... [ATML3432:00 03EB:2136] on

After "on " should read physical device name but it is left empty by the
driver.

Make it look better and fill in the physical device name.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 2871f3c81a4c..10bd8e6e4c9c 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1028,6 +1028,7 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
 		 client->name, hid->vendor, hid->product);
+	strlcpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
 
 	ret = hid_add_device(hid);
 	if (ret) {
-- 
2.5.1

