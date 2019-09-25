From: You-Sheng Yang <vicamo.yang@canonical.com>
Subject: [PATCH 1/2] HID: i2c-hid: allow delay after SET_POWER
Date: Wed, 25 Sep 2019 17:43:25 +0800
Message-ID: <20190925094326.41693-2-vicamo.yang@canonical.com>
References: <20190925094326.41693-1-vicamo.yang@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190925094326.41693-1-vicamo.yang@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Hui Wang <hui.wang@canonical.com>, Julian Sax <jsbc@gmx.de>, HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

According to HID over I2C specification v1.0 section 7.2.8, a device is
allowed to take at most 1 second to make the transition to the specified
power state. On some touchpad devices implements Microsoft Precision
Touchpad, it may fail to execute following set PTP mode command without
the delay and leaves the device in an unsupported Mouse mode.

This change adds a post-setpower-delay-ms device property that allows
specifying the delay after a SET_POWER command is issued.

References: https://bugzilla.kernel.org/show_bug.cgi?id=204991
Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
---
 .../bindings/input/hid-over-i2c.txt           |  2 +
 drivers/hid/i2c-hid/i2c-hid-core.c            | 46 +++++++++++--------
 include/linux/platform_data/i2c-hid.h         |  3 ++
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index c76bafaf98d2f..d82faae335da0 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -32,6 +32,8 @@ device-specific compatible properties, which should be used in addition to the
 - vdd-supply: phandle of the regulator that provides the supply voltage.
 - post-power-on-delay-ms: time required by the device after enabling its regulators
   or powering it on, before it is ready for communication.
+- post-setpower-delay-ms: time required by the device after a SET_POWER command
+  before it finished the state transition.
 
 Example:
 
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 2a7c6e33bb1c4..a5bc2786dc440 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -168,6 +168,7 @@ static const struct i2c_hid_quirks {
 	__u16 idVendor;
 	__u16 idProduct;
 	__u32 quirks;
+	__u32 post_setpower_delay_ms;
 } i2c_hid_quirks[] = {
 	{ USB_VENDOR_ID_WEIDA, HID_ANY_ID,
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
@@ -189,21 +190,20 @@ static const struct i2c_hid_quirks {
  * i2c_hid_lookup_quirk: return any quirks associated with a I2C HID device
  * @idVendor: the 16-bit vendor ID
  * @idProduct: the 16-bit product ID
- *
- * Returns: a u32 quirks value.
  */
-static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
+static void i2c_hid_set_quirk(struct i2c_hid *ihid,
+		const u16 idVendor, const u16 idProduct)
 {
-	u32 quirks = 0;
 	int n;
 
 	for (n = 0; i2c_hid_quirks[n].idVendor; n++)
 		if (i2c_hid_quirks[n].idVendor == idVendor &&
 		    (i2c_hid_quirks[n].idProduct == (__u16)HID_ANY_ID ||
-		     i2c_hid_quirks[n].idProduct == idProduct))
-			quirks = i2c_hid_quirks[n].quirks;
-
-	return quirks;
+		     i2c_hid_quirks[n].idProduct == idProduct)) {
+			ihid->quirks = i2c_hid_quirks[n].quirks;
+			ihid->pdata.post_setpower_delay_ms =
+				i2c_hid_quirks[n].post_setpower_delay_ms;
+		}
 }
 
 static int __i2c_hid_command(struct i2c_client *client,
@@ -431,8 +431,22 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 	    power_state == I2C_HID_PWR_SLEEP)
 		ihid->sleep_delay = jiffies + msecs_to_jiffies(20);
 
-	if (ret)
+	if (ret) {
 		dev_err(&client->dev, "failed to change power setting.\n");
+		goto set_pwr_exit;
+	}
+
+	/*
+	 * The HID over I2C specification states that if a DEVICE needs time
+	 * after the PWR_ON request, it should utilise CLOCK stretching.
+	 * However, it has been observered that the Windows driver provides a
+	 * 1ms sleep between the PWR_ON and RESET requests and that some devices
+	 * rely on this.
+	 */
+	if (ihid->pdata.post_setpower_delay_ms)
+		msleep(ihid->pdata.post_setpower_delay_ms);
+	else
+		usleep_range(1000, 5000);
 
 set_pwr_exit:
 	return ret;
@@ -456,15 +470,6 @@ static int i2c_hid_hwreset(struct i2c_client *client)
 	if (ret)
 		goto out_unlock;
 
-	/*
-	 * The HID over I2C specification states that if a DEVICE needs time
-	 * after the PWR_ON request, it should utilise CLOCK stretching.
-	 * However, it has been observered that the Windows driver provides a
-	 * 1ms sleep between the PWR_ON and RESET requests and that some devices
-	 * rely on this.
-	 */
-	usleep_range(1000, 5000);
-
 	i2c_hid_dbg(ihid, "resetting...\n");
 
 	ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
@@ -1023,6 +1028,9 @@ static void i2c_hid_fwnode_probe(struct i2c_client *client,
 	if (!device_property_read_u32(&client->dev, "post-power-on-delay-ms",
 				      &val))
 		pdata->post_power_delay_ms = val;
+	if (!device_property_read_u32(&client->dev, "post-setpower-delay-ms",
+				      &val))
+		pdata->post_setpower_delay_ms = val;
 }
 
 static int i2c_hid_probe(struct i2c_client *client,
@@ -1145,7 +1153,7 @@ static int i2c_hid_probe(struct i2c_client *client,
 		 client->name, hid->vendor, hid->product);
 	strlcpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
 
-	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
+	i2c_hid_set_quirk(ihid, hid->vendor, hid->product);
 
 	ret = hid_add_device(hid);
 	if (ret) {
diff --git a/include/linux/platform_data/i2c-hid.h b/include/linux/platform_data/i2c-hid.h
index c628bb5e10610..71682f2ad8a53 100644
--- a/include/linux/platform_data/i2c-hid.h
+++ b/include/linux/platform_data/i2c-hid.h
@@ -20,6 +20,8 @@
  * @hid_descriptor_address: i2c register where the HID descriptor is stored.
  * @supplies: regulators for powering on the device.
  * @post_power_delay_ms: delay after powering on before device is usable.
+ * @post_setpower_delay_ms: delay after SET_POWER command before device
+ *                          completes state transition.
  *
  * Note that it is the responsibility of the platform driver (or the acpi 5.0
  * driver, or the flattened device tree) to setup the irq related to the gpio in
@@ -36,6 +38,7 @@ struct i2c_hid_platform_data {
 	u16 hid_descriptor_address;
 	struct regulator_bulk_data supplies[2];
 	int post_power_delay_ms;
+	int post_setpower_delay_ms;
 };
 
 #endif /* __LINUX_I2C_HID_H */
-- 
2.23.0
