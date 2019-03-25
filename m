From: Vladislav Dalechyn <vlad.dalechin@gmail.com>
Subject: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Mon, 25 Mar 2019 14:57:04 +0200
Message-ID: <20190325125704.6585-1-hotwater438@tutanota.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, jikos@kernel.org, kai.heng.feng@canonical.com, swboyd@chromium.org, bigeasy@linutronix.de, dtor@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, hotwater438@tutanota.com
Cc: Hans De Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Vladislav Dalechyn <hotwater438@tutanota.com>

Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
caused by an error setting the correct IRQ_TRIGGER flag:
- i2c_hid incoplete error flood in journalctl;
- Five finger tap kill's module so you have to restart it;
- Two finger scoll is working incorrect and sometimes even when you
raised one of two finger still thinks that you are scrolling.

Fix all of these with a new quirk that corrects the trigger flag
announced by the ACPI tables. (edge-falling).

Reason behind moving i2c_hid_init_irq section described below:
i2c_hid_init_irq now checks for a quirk, so we must setup the quirks
before we init the irq, and we cannot setup the quirk earlier, so we must
init the irq later.

Co-developed-by: Hans De Goede <hdegoede@redhat.com>
Signed-off-by: Vladislav Dalechyn <hotwater438@tutanota.com>
---
 drivers/hid/hid-ids.h              |  1 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b6d93f4ad037..660b4e0e912e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -389,6 +389,7 @@
 #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
+#define I2C_DEVICE_ID_ELAN_TOUCHPAD 0x303e
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 90164fed08d3..9b417914411f 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -51,6 +51,7 @@
 #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
 #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
 #define I2C_HID_QUIRK_BOGUS_IRQ			BIT(4)
+#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING	BIT(5)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ELAN_TOUCHPAD,
+		I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID,
-		 I2C_HID_QUIRK_BOGUS_IRQ },
+		I2C_HID_QUIRK_BOGUS_IRQ },
 	{ 0, 0 }
 };
 
@@ -854,6 +857,8 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 
 	if (!irq_get_trigger_type(client->irq))
 		irqflags = IRQF_TRIGGER_LOW;
+	if (ihid->quirks & I2C_HID_QUIRK_FORCE_TRIGGER_FALLING)
+		irqflags = IRQF_TRIGGER_FALLING;
 
 	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
 				   irqflags | IRQF_ONESHOT, client->name, ihid);
@@ -1123,14 +1128,10 @@ static int i2c_hid_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto err_pm;
 
-	ret = i2c_hid_init_irq(client);
-	if (ret < 0)
-		goto err_pm;
-
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
-		goto err_irq;
+		goto err_pm;
 	}
 
 	ihid->hid = hid;
@@ -1149,11 +1150,15 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
 
+	ret = i2c_hid_init_irq(client);
+	if (ret < 0)
+		goto err_mem_free;
+
 	ret = hid_add_device(hid);
 	if (ret) {
 		if (ret != -ENODEV)
 			hid_err(client, "can't add hid device: %d\n", ret);
-		goto err_mem_free;
+		goto err_irq;
 	}
 
 	if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
@@ -1161,12 +1166,12 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	return 0;
 
+err_irq:
+	free_irq(client->irq, ihid);
+
 err_mem_free:
 	hid_destroy_device(hid);
 
-err_irq:
-	free_irq(client->irq, ihid);
-
 err_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
-- 
2.20.1
