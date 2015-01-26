From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] HID: i2c-hid: The interrupt should be level sensitive
Date: Mon, 26 Jan 2015 16:29:32 +0200
Message-ID: <1422282573-18215-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Microsoft HID over I2C specification says two things regarding the
interrupt:

 1) The interrupt should be level sensitive
 2) The device keeps the interrupt asserted as long as it has more reports
    available.

We've seen that at least some Atmel and N-Trig panels keep the line low as
long as they have something to send. The current version of the driver only
detects the first edge but then fails to read rest of the reports (as the
line is still asserted).

Make the driver follow the specification and configure the HID interrupt to
be level sensitive.

The Windows HID over I2C driver also seems to do the same.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index d43e967e7533..8f1dfc5c5d9c 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -785,7 +785,7 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 	dev_dbg(&client->dev, "Requesting IRQ: %d\n", client->irq);
 
 	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
-			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 			client->name, ihid);
 	if (ret < 0) {
 		dev_warn(&client->dev,
-- 
2.1.4
