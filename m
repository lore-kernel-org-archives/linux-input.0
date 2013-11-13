From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 02/04] input synaptics-rmi4: I2C transport layer
Date: Wed, 13 Nov 2013 15:39:30 -0800
Message-ID: <1384385972-1686-3-git-send-email-cheiny@synaptics.com>
References: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:16061 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab3KMXjw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Nov 2013 18:39:52 -0500
In-Reply-To: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

Implements renaming from "physical" to "transport", as described in part 00/05
of this patch set.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joeri de Gram <j.de.gram@gmail.com>
Acked-by: Jean Delvare <khali@linux-fr.org>

---

 drivers/input/rmi4/rmi_i2c.c | 133 ++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 71 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index f3bef04..4299a60 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -28,7 +28,7 @@
  *
  * @page_mutex: Locks current page to avoid changing pages in unexpected ways.
  * @page: Keeps track of the current virtual page
- * @phys: Pointer to the physical interface
+ * @xport: Pointer to the transport interface
  *
  * @tx_buf: Buffer used for transmitting data to the sensor over i2c.
  * @tx_buf_size: Size of the buffer
@@ -37,11 +37,12 @@
  *
  * @comms_debug: Latest data read/written for debugging I2C communications
  * @debugfs_comms: Debugfs file for debugging I2C communications
+ *
  */
 struct rmi_i2c_data {
 	struct mutex page_mutex;
 	int page;
-	struct rmi_phys_device *phys;
+	struct rmi_transport_device *xport;
 
 	u8 *tx_buf;
 	int tx_buf_size;
@@ -64,8 +65,7 @@ static int setup_debugfs(struct rmi_device *rmi_dev, struct rmi_i2c_data *data)
 	data->debugfs_comms = debugfs_create_bool("comms_debug", RMI_RW_ATTR,
 			rmi_dev->debugfs_root, &data->comms_debug);
 	if (!data->debugfs_comms || IS_ERR(data->debugfs_comms)) {
-		dev_warn(&rmi_dev->dev,
-			 "Failed to create debugfs comms_debug.\n");
+		dev_warn(&rmi_dev->dev, "Failed to create debugfs comms_debug.\n");
 		data->debugfs_comms = NULL;
 	}
 
@@ -77,19 +77,9 @@ static void teardown_debugfs(struct rmi_i2c_data *data)
 	if (data->debugfs_comms)
 		debugfs_remove(data->debugfs_comms);
 }
-
 #else
-
-static inline int setup_debugfs(struct rmi_device *rmi_dev,
-				struct rmi_i2c_data *data)
-{
-	return 0;
-}
-
-static inline void teardown_debugfs(struct rmi_i2c_data *data)
-{
-}
-
+#define setup_debugfs(rmi_dev, data) 0
+#define teardown_debugfs(data)
 #endif
 
 #define COMMS_DEBUG(data) (IS_ENABLED(CONFIG_RMI4_DEBUG) && data->comms_debug)
@@ -97,14 +87,14 @@ static inline void teardown_debugfs(struct rmi_i2c_data *data)
 #define RMI_PAGE_SELECT_REGISTER 0xff
 #define RMI_I2C_PAGE(addr) (((addr) >> 8) & 0xff)
 
-static char *phys_proto_name = "i2c";
+static char *transport_protocol_name = "i2c";
 
 /*
  * rmi_set_page - Set RMI page
- * @phys: The pointer to the rmi_phys_device struct
+ * @xport: The pointer to the rmi_transport_device struct
  * @page: The new page address.
  *
- * RMI devices have 16-bit addressing, but some of the physical
+ * RMI devices have 16-bit addressing, but some of the transport
  * implementations (like SMBus) only have 8-bit addressing. So RMI implements
  * a page address at 0xff of every page so we can reliable page addresses
  * every 256 registers.
@@ -113,21 +103,21 @@ static char *phys_proto_name = "i2c";
  *
  * Returns zero on success, non-zero on failure.
  */
-static int rmi_set_page(struct rmi_phys_device *phys, u8 page)
+static int rmi_set_page(struct rmi_transport_device *xport, u8 page)
 {
-	struct i2c_client *client = to_i2c_client(phys->dev);
-	struct rmi_i2c_data *data = phys->data;
+	struct i2c_client *client = to_i2c_client(xport->dev);
+	struct rmi_i2c_data *data = xport->data;
 	u8 txbuf[2] = {RMI_PAGE_SELECT_REGISTER, page};
 	int retval;
 
 	if (COMMS_DEBUG(data))
 		dev_dbg(&client->dev, "writes 3 bytes: %02x %02x\n",
 			txbuf[0], txbuf[1]);
-	phys->info.tx_count++;
-	phys->info.tx_bytes += sizeof(txbuf);
+	xport->info.tx_count++;
+	xport->info.tx_bytes += sizeof(txbuf);
 	retval = i2c_master_send(client, txbuf, sizeof(txbuf));
 	if (retval != sizeof(txbuf)) {
-		phys->info.tx_errs++;
+		xport->info.tx_errs++;
 		dev_err(&client->dev,
 			"%s: set page failed: %d.", __func__, retval);
 		return (retval < 0) ? retval : -EIO;
@@ -157,18 +147,18 @@ static int copy_to_debug_buf(struct device *dev, struct rmi_i2c_data *data,
 	temp = data->debug_buf;
 
 	for (i = 0; i < len; i++) {
-		n = sprintf(temp, " %02x", buf[i]);
+		n = snprintf(temp, 3, " %02x", buf[i]);
 		temp += n;
 	}
 
 	return 0;
 }
 
-static int rmi_i2c_write_block(struct rmi_phys_device *phys, u16 addr,
+static int rmi_i2c_write_block(struct rmi_transport_device *xport, u16 addr,
 			       const void *buf, const int len)
 {
-	struct i2c_client *client = to_i2c_client(phys->dev);
-	struct rmi_i2c_data *data = phys->data;
+	struct i2c_client *client = to_i2c_client(xport->dev);
+	struct rmi_i2c_data *data = xport->data;
 	int retval;
 	int tx_size = len + 1;
 
@@ -190,7 +180,7 @@ static int rmi_i2c_write_block(struct rmi_phys_device *phys, u16 addr,
 	memcpy(data->tx_buf + 1, buf, len);
 
 	if (RMI_I2C_PAGE(addr) != data->page) {
-		retval = rmi_set_page(phys, RMI_I2C_PAGE(addr));
+		retval = rmi_set_page(xport, RMI_I2C_PAGE(addr));
 		if (retval < 0)
 			goto exit;
 	}
@@ -202,11 +192,11 @@ static int rmi_i2c_write_block(struct rmi_phys_device *phys, u16 addr,
 				len, addr, data->debug_buf);
 	}
 
-	phys->info.tx_count++;
-	phys->info.tx_bytes += tx_size;
+	xport->info.tx_count++;
+	xport->info.tx_bytes += tx_size;
 	retval = i2c_master_send(client, data->tx_buf, tx_size);
 	if (retval < 0)
-		phys->info.tx_errs++;
+		xport->info.tx_errs++;
 	else
 		retval--; /* don't count the address byte */
 
@@ -216,18 +206,18 @@ exit:
 }
 
 
-static int rmi_i2c_read_block(struct rmi_phys_device *phys, u16 addr,
+static int rmi_i2c_read_block(struct rmi_transport_device *xport, u16 addr,
 			      void *buf, const int len)
 {
-	struct i2c_client *client = to_i2c_client(phys->dev);
-	struct rmi_i2c_data *data = phys->data;
+	struct i2c_client *client = to_i2c_client(xport->dev);
+	struct rmi_i2c_data *data = xport->data;
 	u8 txbuf[1] = {addr & 0xff};
 	int retval;
 
 	mutex_lock(&data->page_mutex);
 
 	if (RMI_I2C_PAGE(addr) != data->page) {
-		retval = rmi_set_page(phys, RMI_I2C_PAGE(addr));
+		retval = rmi_set_page(xport, RMI_I2C_PAGE(addr));
 		if (retval < 0)
 			goto exit;
 	}
@@ -235,21 +225,21 @@ static int rmi_i2c_read_block(struct rmi_phys_device *phys, u16 addr,
 	if (COMMS_DEBUG(data))
 		dev_dbg(&client->dev, "writes 1 bytes: %02x\n", txbuf[0]);
 
-	phys->info.tx_count++;
-	phys->info.tx_bytes += sizeof(txbuf);
+	xport->info.tx_count++;
+	xport->info.tx_bytes += sizeof(txbuf);
 	retval = i2c_master_send(client, txbuf, sizeof(txbuf));
 	if (retval != sizeof(txbuf)) {
-		phys->info.tx_errs++;
+		xport->info.tx_errs++;
 		retval = (retval < 0) ? retval : -EIO;
 		goto exit;
 	}
 
 	retval = i2c_master_recv(client, (u8 *) buf, len);
 
-	phys->info.rx_count++;
-	phys->info.rx_bytes += len;
+	xport->info.rx_count++;
+	xport->info.rx_bytes += len;
 	if (retval < 0)
-		phys->info.rx_errs++;
+		xport->info.rx_errs++;
 	else if (COMMS_DEBUG(data)) {
 		int rc = copy_to_debug_buf(&client->dev, data, (u8 *) buf, len);
 		if (!rc)
@@ -263,9 +253,9 @@ exit:
 }
 
 static int rmi_i2c_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+				  const struct i2c_device_id *id)
 {
-	struct rmi_phys_device *rmi_phys;
+	struct rmi_transport_device *rmi_transport;
 	struct rmi_i2c_data *data;
 	struct rmi_device_platform_data *pdata = client->dev.platform_data;
 	int retval;
@@ -274,32 +264,33 @@ static int rmi_i2c_probe(struct i2c_client *client,
 		dev_err(&client->dev, "no platform data\n");
 		return -EINVAL;
 	}
-	dev_info(&client->dev, "Probing %s at %#02x (IRQ %d).\n",
+	dev_dbg(&client->dev, "Probing %s at %#02x (GPIO %d).\n",
 		pdata->sensor_name ? pdata->sensor_name : "-no name-",
 		client->addr, pdata->attn_gpio);
 
+	retval = i2c_check_functionality(client->adapter, I2C_FUNC_I2C);
+	if (!retval) {
+		dev_err(&client->dev, "i2c_check_functionality error %d.\n",
+			retval);
+		return retval;
+	}
+
 	if (pdata->gpio_config) {
-		dev_dbg(&client->dev, "Configuring GPIOs.\n");
 		retval = pdata->gpio_config(pdata->gpio_data, true);
 		if (retval < 0) {
 			dev_err(&client->dev, "Failed to configure GPIOs, code: %d.\n",
 				retval);
 			return retval;
 		}
+		msleep(pdata->reset_delay_ms ?
+				pdata->reset_delay_ms : DEFAULT_RESET_DELAY_MS);
 		dev_info(&client->dev, "Done with GPIO configuration.\n");
 	}
 
-	retval = i2c_check_functionality(client->adapter, I2C_FUNC_I2C);
-	if (!retval) {
-		dev_err(&client->dev, "i2c_check_functionality error %d.\n",
-			retval);
-		return retval;
-	}
-
-	rmi_phys = devm_kzalloc(&client->dev, sizeof(struct rmi_phys_device),
-				GFP_KERNEL);
+	rmi_transport = devm_kzalloc(&client->dev,
+			sizeof(struct rmi_transport_device), GFP_KERNEL);
 
-	if (!rmi_phys)
+	if (!rmi_transport)
 		return -ENOMEM;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct rmi_i2c_data),
@@ -307,35 +298,35 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
-	data->phys = rmi_phys;
+	data->xport = rmi_transport;
 
-	rmi_phys->data = data;
-	rmi_phys->dev = &client->dev;
+	rmi_transport->data = data;
+	rmi_transport->dev = &client->dev;
 
-	rmi_phys->write_block = rmi_i2c_write_block;
-	rmi_phys->read_block = rmi_i2c_read_block;
-	rmi_phys->info.proto = phys_proto_name;
+	rmi_transport->write_block = rmi_i2c_write_block;
+	rmi_transport->read_block = rmi_i2c_read_block;
+	rmi_transport->info.proto = transport_protocol_name;
 
 	mutex_init(&data->page_mutex);
 
 	/* Setting the page to zero will (a) make sure the PSR is in a
 	 * known state, and (b) make sure we can talk to the device.
 	 */
-	retval = rmi_set_page(rmi_phys, 0);
+	retval = rmi_set_page(rmi_transport, 0);
 	if (retval) {
 		dev_err(&client->dev, "Failed to set page select to 0.\n");
 		return retval;
 	}
 
-	retval = rmi_register_physical_device(rmi_phys);
+	retval = rmi_register_transport_device(rmi_transport);
 	if (retval) {
-		dev_err(&client->dev, "Failed to register physical driver at 0x%.2X.\n",
+		dev_err(&client->dev, "Failed to register transport at 0x%.2X.\n",
 			client->addr);
 		goto err_gpio;
 	}
-	i2c_set_clientdata(client, rmi_phys);
+	i2c_set_clientdata(client, rmi_transport);
 
-	retval = setup_debugfs(rmi_phys->rmi_dev, data);
+	retval = setup_debugfs(rmi_transport->rmi_dev, data);
 	if (retval < 0)
 		dev_warn(&client->dev, "Failed to setup debugfs. Code: %d.\n",
 			 retval);
@@ -352,12 +343,12 @@ err_gpio:
 
 static int rmi_i2c_remove(struct i2c_client *client)
 {
-	struct rmi_phys_device *phys = i2c_get_clientdata(client);
+	struct rmi_transport_device *xport = i2c_get_clientdata(client);
 	struct rmi_device_platform_data *pd = client->dev.platform_data;
 
-	teardown_debugfs(phys->data);
+	teardown_debugfs(xport->data);
 
-	rmi_unregister_physical_device(phys);
+	rmi_unregister_transport_device(xport);
 
 	if (pd->gpio_config)
 		pd->gpio_config(&pd->gpio_data, false);
