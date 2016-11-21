From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: i2c-hid: retrieve the GPIO parameters only when unset
Date: Mon, 21 Nov 2016 12:50:16 +0100
Message-ID: <1479729016-32307-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753457AbcKULuS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Nov 2016 06:50:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of forcing the level triggers of the IRQ,
we can count on ACPI or OF to set it up for us.

This way, if some vendor decides to not follow the spec, well
we can handle those case (I have been requested this once already).

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Jiri,

I have been requested this once. I was not sure whether it was doable at the
time, but it actually appears that both ACPI and OF sets the irqflags for us.

So I think it would be good to trust the device description instead of
blindly overwriting it.

Cheers,
Benjamin

 drivers/hid/i2c-hid/i2c-hid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index ce51879..0630499 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -858,13 +858,16 @@ static struct hid_ll_driver i2c_hid_ll_driver = {
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

