From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 42/63] Input: atmel_mxt_ts: Limit the max bytes transferred in an i2c transaction
Date: Fri, 16 Aug 2019 17:35:37 +0900
Message-ID: <20190816083558.19189-3-jiada_wang@mentor.com>
References: <20190816083558.19189-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083558.19189-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>

In mxt_process_messages_until_invalid() function, driver tries to read
all possible reportid in a single i2c transaction. Number of bytes read
is limited by the max_reportid parameter.
If the max_reportid is a very large value, then a large chunk of bytes
will be requested from the controller in a single i2c transaction.
This transaction can fail due to timeout. This is visible when the
Atmel controller is connected to the SOC via a i2c mux hardware.
New property 'atmel,mtu' is created. This property limits the maximum
number of bytes that can read/transferred in an i2c transcation

Signed-off-by: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 .../bindings/input/atmel,maxtouch.txt         |  3 +++
 drivers/input/touchscreen/atmel_mxt_ts.c      | 26 +++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index 7afe12a93202..a7f9a8e551f7 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -45,6 +45,8 @@ Optional properties for main touchpad device:
 - atmel,gpios: Specify the GPIO input pins whose status will be read via the
     /sys/class/input/input<n>/backlight_error<x> sysfs entries.
 
+- atmel,mtu: Maximum number of bytes that can read/transferred in an i2c transaction
+
 Example:
 
 	touch@4b {
@@ -52,6 +54,7 @@ Example:
 		reg = <0x4b>;
 		interrupt-parent = <&gpio>;
 		interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
+		atmel,mtu = <200>
 
 		atmel,gpios {
 			backlight_error1 {
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c6ba061098c0..e315ad3a8d2a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -421,6 +421,7 @@ struct mxt_data {
 	unsigned long gpio_input_pin_status;
 	struct attribute_group gpio_attrs;
 	unsigned long gpio_input_pin_status_default;
+	unsigned int mtu;
 
 	bool t25_status;
 };
@@ -1522,13 +1523,30 @@ static irqreturn_t mxt_process_messages_t44(struct mxt_data *data)
 	return IRQ_HANDLED;
 }
 
+static u8 mxt_max_msg_read_count(struct mxt_data *data)
+{
+	u8 count_limit = data->mtu / data->T5_msg_size;
+
+	if (!data->mtu)
+		return data->max_reportid;
+
+	if (data->mtu < data->T5_msg_size) {
+		WARN(1, "mtu set is lesser than the T5 message size\n");
+		/* Return count of 1, as fallback */
+		return 1;
+	}
+
+	return min(count_limit, data->max_reportid);
+}
+
 static int mxt_process_messages_until_invalid(struct mxt_data *data)
 {
 	struct device *dev = &data->client->dev;
 	int count, read;
-	u8 tries = 2;
+	int tries;
 
-	count = data->max_reportid;
+	count = mxt_max_msg_read_count(data);
+	tries = (data->max_reportid / count) + 1;
 
 	/* Read messages until we force an invalid */
 	do {
@@ -4290,6 +4308,10 @@ static int mxt_parse_device_properties(struct mxt_data *data)
 			of_node_put(np_gpio);
 	}
 
+	device_property_read_u32(dev, "atmel,mtu", &data->mtu);
+	if (data->mtu)
+		dev_dbg(dev, "mtu is set as %d\n", data->mtu);
+
 	return 0;
 
 err_gpios_property_put:
-- 
2.19.2
