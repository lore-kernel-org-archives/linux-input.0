From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2] HID: i2c-hid: force the IRQ level trigger only when not set
Date: Mon, 21 Nov 2016 15:21:27 +0100
Message-ID: <1479738087-3123-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of forcing the level trigger of the IRQ, we can count
on ACPI or OF to set it up for us.

The first release of the HID over I2C specification mentioned
that the level trigger needed to be active low. In the latest
version of the specification, there is no such explicit mention,
so it's better to not assume one.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
- reword a little the commit message (and mention that the new spec
  doesn't requires active low anymore)
- add missing irq.h include as per kbuild bot raised

So after the kbuild bot warning and a search in my email folder, I realised
that the commit message should be amended too. So here is a v2 :)

Cheers,
Benjamin

---
 drivers/hid/i2c-hid/i2c-hid.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index ce51879..8d53efe 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -22,6 +22,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
@@ -858,13 +859,16 @@ static struct hid_ll_driver i2c_hid_ll_driver = {
 static int i2c_hid_init_irq(struct i2c_client *client)
 {
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
+	unsigned long irqflags = 0;
 	int ret;
 
 	dev_dbg(&client->dev, "Requesting IRQ: %d\n", client->irq);
 
+	if (!irq_get_trigger_type(client->irq))
+		irqflags = IRQF_TRIGGER_LOW;
+
 	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
-			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-			client->name, ihid);
+				   irqflags | IRQF_ONESHOT, client->name, ihid);
 	if (ret < 0) {
 		dev_warn(&client->dev,
 			"Could not register for %s interrupt, irq = %d,"
-- 
2.7.4
