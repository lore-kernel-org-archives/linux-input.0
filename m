From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: Transport layer renaming.
Date: Tue, 17 Dec 2013 13:31:30 -0800
Message-ID: <1387315890-21681-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:19601 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3LQVbe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 16:31:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

The current RMI4 driver uses the term "physical" for two different logical
entities: the communications transport layer (I2C, SPI, and so on), and the
actual RMI4 device that is being communicated with.  Such usage makes the
code harder to understand due to confusion as to just which elements are
being referred to.

This patch renames the transport layer elements in order to eliminate this
confusion.  Much of the renaming was accomplished by the following Bash script

  #!/bin/bash
  #
  # Update RMI4 driver transport layer naming.
  #

  files="rmi_bus.c rmi_bus.h rmi_driver.c rmi_driver.h rmi_f01.c rmi_i2c.c"
  cd drivers/input/rmi4

  for f in $files ; do
    echo $f
    sed -i.bak s/rmi_phys_device/rmi_transport_dev/g $f
    sed -i.bak s/rmi_phys_info/rmi_transport_info/g $f
    sed -i.bak "s/rmi_transport_dev \*phys/rmi_transport_dev \*xport/g" $f
    sed -i.bak "s/rmi_transport_dev \*rmi_phys/rmi_transport_dev \*xport/g" $f
    sed -i.bak "s/phys\([^i]\)/xport\1/g" $f
    sed -i.bak "s/->phys/->xport/g" $f
    sed -i.bak "s/register_physical_device/register_transport_device/g" $f
    sed -i.bak "s/physical_device_count/transport_device_count/g" $f
  done

although some changes proved easier to simply do by hand, particularly in the
comments.  Changes are confined strictly to the renaming, to keep the patch
relatively simple.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_bus.c    | 38 ++++++++---------
 drivers/input/rmi4/rmi_bus.h    | 54 ++++++++++++-------------
 drivers/input/rmi4/rmi_driver.c | 32 +++++++--------
 drivers/input/rmi4/rmi_driver.h |  2 +-
 drivers/input/rmi4/rmi_i2c.c    | 90 ++++++++++++++++++++---------------------
 5 files changed, 108 insertions(+), 108 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 173f6be..96a76e7 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -76,38 +76,38 @@ static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
 #endif
 
 /**
- * rmi_register_physical_device - register a physical device connection on the RMI
- * bus.  Physical drivers provide communication from the devices on the bus to
- * the RMI4 sensor on a bus such as SPI, I2C, and so on.
+ * rmi_register_transport_device - register a transport device connection
+ * on the RMI bus.  Transport drivers provide communication from the devices
+ * on a bus (such as SPI, I2C, and so on) to the RMI4 sensor.
  *
- * @phys: the physical device to register
+ * @xport: the transport device to register
  */
-int rmi_register_physical_device(struct rmi_phys_device *phys)
+int rmi_register_transport_device(struct rmi_transport_dev *xport)
 {
-	static atomic_t physical_device_count = ATOMIC_INIT(0);
-	struct rmi_device_platform_data *pdata = phys->dev->platform_data;
+	static atomic_t transport_device_count = ATOMIC_INIT(0);
+	struct rmi_device_platform_data *pdata = xport->dev->platform_data;
 	struct rmi_device *rmi_dev;
 	int error;
 
 	if (!pdata) {
-		dev_err(phys->dev, "no platform data!\n");
+		dev_err(xport->dev, "no platform data!\n");
 		return -EINVAL;
 	}
 
-	rmi_dev = devm_kzalloc(phys->dev,
+	rmi_dev = devm_kzalloc(xport->dev,
 				sizeof(struct rmi_device), GFP_KERNEL);
 	if (!rmi_dev)
 		return -ENOMEM;
 
-	rmi_dev->phys = phys;
-	rmi_dev->number = atomic_inc_return(&physical_device_count) - 1;
+	rmi_dev->xport = xport;
+	rmi_dev->number = atomic_inc_return(&transport_device_count) - 1;
 
 	dev_set_name(&rmi_dev->dev, "sensor%02d", rmi_dev->number);
 
 	rmi_dev->dev.bus = &rmi_bus_type;
 	rmi_dev->dev.type = &rmi_device_type;
 
-	phys->rmi_dev = rmi_dev;
+	xport->rmi_dev = rmi_dev;
 
 	rmi_physical_setup_debugfs(rmi_dev);
 
@@ -115,26 +115,26 @@ int rmi_register_physical_device(struct rmi_phys_device *phys)
 	if (error)
 		return error;
 
-	dev_dbg(phys->dev, "%s: Registered %s as %s.\n", __func__,
+	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
 		pdata->sensor_name, dev_name(&rmi_dev->dev));
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rmi_register_physical_device);
+EXPORT_SYMBOL_GPL(rmi_register_transport_device);
 
 /**
- * rmi_unregister_physical_device - unregister a physical device connection
- * @phys: the physical driver to unregister
+ * rmi_unregister_transport_device - unregister a transport device connection
+ * @xport: the transport driver to unregister
  *
  */
-void rmi_unregister_physical_device(struct rmi_phys_device *phys)
+void rmi_unregister_transport_device(struct rmi_transport_dev *xport)
 {
-	struct rmi_device *rmi_dev = phys->rmi_dev;
+	struct rmi_device *rmi_dev = xport->rmi_dev;
 
 	rmi_physical_teardown_debugfs(rmi_dev);
 	device_unregister(&rmi_dev->dev);
 }
-EXPORT_SYMBOL(rmi_unregister_physical_device);
+EXPORT_SYMBOL(rmi_unregister_transport_device);
 
 
 /* Function specific stuff */
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index e2a3dc6..65dd934 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -38,7 +38,7 @@ struct rmi_device;
  * interrupt handling.
  * @data: Private data pointer
  *
- * @node: entry in physical device list of functions
+ * @node: entry in device's list of functions
  * @debugfs_root: used during debugging
  */
 struct rmi_function {
@@ -135,8 +135,8 @@ struct rmi_driver {
 #define to_rmi_driver(d) \
 	container_of(d, struct rmi_driver, driver);
 
-/** struct rmi_phys_info - diagnostic information about the RMI physical
- * device, used in the phys debugfs file.
+/** struct rmi_transport_info - diagnostic information about the RMI transport
+ * device, used in the xport_info debugfs file.
  *
  * @proto String indicating the protocol being used.
  * @tx_count Number of transmit operations.
@@ -147,7 +147,7 @@ struct rmi_driver {
  * @rx_errs  Number of errors encountered during receive operations.
  * @att_count Number of times ATTN assertions have been handled.
  */
-struct rmi_phys_info {
+struct rmi_transport_info {
 	char *proto;
 	long tx_count;
 	long tx_bytes;
@@ -158,7 +158,7 @@ struct rmi_phys_info {
 };
 
 /**
- * struct rmi_phys_device - represent an RMI physical device
+ * struct rmi_transport_dev - represent an RMI transport device
  *
  * @dev: Pointer to the communication device, e.g. i2c or spi
  * @rmi_dev: Pointer to the RMI device
@@ -170,28 +170,28 @@ struct rmi_phys_info {
  * handling
  * @data: Private data pointer
  *
- * The RMI physical device implements the glue between different communication
+ * The RMI transport device implements the glue between different communication
  * buses such as I2C and SPI.
  *
  */
-struct rmi_phys_device {
+struct rmi_transport_dev {
 	struct device *dev;
 	struct rmi_device *rmi_dev;
 
-	int (*write_block)(struct rmi_phys_device *phys, u16 addr,
+	int (*write_block)(struct rmi_transport_dev *xport, u16 addr,
 			   const void *buf, const int len);
-	int (*read_block)(struct rmi_phys_device *phys, u16 addr,
+	int (*read_block)(struct rmi_transport_dev *xport, u16 addr,
 			  void *buf, const int len);
 
-	int (*enable_device) (struct rmi_phys_device *phys);
-	void (*disable_device) (struct rmi_phys_device *phys);
+	int (*enable_device) (struct rmi_transport_dev *xport);
+	void (*disable_device) (struct rmi_transport_dev *xport);
 
 	irqreturn_t (*irq_thread)(int irq, void *p);
 	irqreturn_t (*hard_irq)(int irq, void *p);
 
 	void *data;
 
-	struct rmi_phys_info info;
+	struct rmi_transport_info info;
 };
 
 /**
@@ -200,7 +200,7 @@ struct rmi_phys_device {
  * @dev: The device created for the RMI bus
  * @number: Unique number for the device on the bus.
  * @driver: Pointer to associated driver
- * @phys: Pointer to the physical interface
+ * @xport: Pointer to the transport interface
  * @debugfs_root: base for this particular sensor device.
  *
  */
@@ -209,7 +209,7 @@ struct rmi_device {
 	int number;
 
 	struct rmi_driver *driver;
-	struct rmi_phys_device *phys;
+	struct rmi_transport_dev *xport;
 
 #ifdef CONFIG_RMI4_DEBUG
 	struct dentry *debugfs_root;
@@ -217,7 +217,7 @@ struct rmi_device {
 };
 
 #define to_rmi_device(d) container_of(d, struct rmi_device, dev)
-#define to_rmi_platform_data(d) ((d)->phys->dev->platform_data)
+#define to_rmi_platform_data(d) ((d)->xport->dev->platform_data)
 
 bool rmi_is_physical_device(struct device *dev);
 
@@ -227,12 +227,12 @@ bool rmi_is_physical_device(struct device *dev);
  * @addr: The address to read from
  * @buf: The read buffer
  *
- * Reads a byte of data using the underlaying physical protocol in to buf. It
+ * Reads a byte of data using the underlaying transport protocol in to buf. It
  * returns zero or a negative error code.
  */
 static inline int rmi_read(struct rmi_device *d, u16 addr, void *buf)
 {
-	return d->phys->read_block(d->phys, addr, buf, 1);
+	return d->xport->read_block(d->xport, addr, buf, 1);
 }
 
 /**
@@ -242,13 +242,13 @@ static inline int rmi_read(struct rmi_device *d, u16 addr, void *buf)
  * @buf: The read buffer
  * @len: Length of the read buffer
  *
- * Reads a block of byte data using the underlaying physical protocol in to buf.
- * It returns the amount of bytes read or a negative error code.
+ * Reads a block of byte data using the underlaying transport protocol in
+ * to buf.  It returns the amount of bytes read or a negative error code.
  */
 static inline int rmi_read_block(struct rmi_device *d, u16 addr, void *buf,
 				 const int len)
 {
-	return d->phys->read_block(d->phys, addr, buf, len);
+	return d->xport->read_block(d->xport, addr, buf, len);
 }
 
 /**
@@ -257,12 +257,12 @@ static inline int rmi_read_block(struct rmi_device *d, u16 addr, void *buf,
  * @addr: The address to write to
  * @data: The data to write
  *
- * Writes a byte from buf using the underlaying physical protocol. It
+ * Writes a byte from buf using the underlaying transport protocol. It
  * returns zero or a negative error code.
  */
 static inline int rmi_write(struct rmi_device *d, u16 addr, const u8 data)
 {
-	return d->phys->write_block(d->phys, addr, &data, 1);
+	return d->xport->write_block(d->xport, addr, &data, 1);
 }
 
 /**
@@ -272,17 +272,17 @@ static inline int rmi_write(struct rmi_device *d, u16 addr, const u8 data)
  * @buf: The write buffer
  * @len: Length of the write buffer
  *
- * Writes a block of byte data from buf using the underlaying physical protocol.
- * It returns the amount of bytes written or a negative error code.
+ * Writes a block of byte data from buf using the underlaying transport
+ * protocol.  It returns the amount of bytes written or a negative error code.
  */
 static inline int rmi_write_block(struct rmi_device *d, u16 addr,
 				  const void *buf, const int len)
 {
-	return d->phys->write_block(d->phys, addr, buf, len);
+	return d->xport->write_block(d->xport, addr, buf, len);
 }
 
-int rmi_register_physical_device(struct rmi_phys_device *phys);
-void rmi_unregister_physical_device(struct rmi_phys_device *phys);
+int rmi_register_transport_device(struct rmi_transport_dev *xport);
+void rmi_unregister_transport_device(struct rmi_transport_dev *xport);
 int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void *data));
 
 /**
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index a30c7d3..2ae9af9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -45,16 +45,16 @@
 
 static irqreturn_t rmi_irq_thread(int irq, void *p)
 {
-	struct rmi_phys_device *phys = p;
-	struct rmi_device *rmi_dev = phys->rmi_dev;
+	struct rmi_transport_dev *xport = p;
+	struct rmi_device *rmi_dev = xport->rmi_dev;
 	struct rmi_driver *driver = rmi_dev->driver;
-	struct rmi_device_platform_data *pdata = phys->dev->platform_data;
+	struct rmi_device_platform_data *pdata = xport->dev->platform_data;
 	struct rmi_driver_data *data;
 
 	data = dev_get_drvdata(&rmi_dev->dev);
 
 	if (IRQ_DEBUG(data))
-		dev_dbg(phys->dev, "ATTN gpio, value: %d.\n",
+		dev_dbg(xport->dev, "ATTN gpio, value: %d.\n",
 				gpio_get_value(pdata->attn_gpio));
 
 	if (gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity) {
@@ -124,12 +124,12 @@ static void disable_sensor(struct rmi_device *rmi_dev)
 	if (!data->irq)
 		disable_polling(rmi_dev);
 
-	if (rmi_dev->phys->disable_device)
-		rmi_dev->phys->disable_device(rmi_dev->phys);
+	if (rmi_dev->xport->disable_device)
+		rmi_dev->xport->disable_device(rmi_dev->xport);
 
 	if (data->irq) {
 		disable_irq(data->irq);
-		free_irq(data->irq, rmi_dev->phys);
+		free_irq(data->irq, rmi_dev->xport);
 	}
 
 	data->enabled = false;
@@ -138,27 +138,27 @@ static void disable_sensor(struct rmi_device *rmi_dev)
 static int enable_sensor(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi_phys_device *rmi_phys;
+	struct rmi_transport_dev *xport;
 	int retval = 0;
 	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
 
 	if (data->enabled)
 		return 0;
 
-	if (rmi_dev->phys->enable_device) {
-		retval = rmi_dev->phys->enable_device(rmi_dev->phys);
+	if (rmi_dev->xport->enable_device) {
+		retval = rmi_dev->xport->enable_device(rmi_dev->xport);
 		if (retval)
 			return retval;
 	}
 
-	rmi_phys = rmi_dev->phys;
+	xport = rmi_dev->xport;
 	if (data->irq) {
 		retval = request_threaded_irq(data->irq,
-				rmi_phys->hard_irq ? rmi_phys->hard_irq : NULL,
-				rmi_phys->irq_thread ?
-					rmi_phys->irq_thread : rmi_irq_thread,
+				xport->hard_irq ? xport->hard_irq : NULL,
+				xport->irq_thread ?
+					xport->irq_thread : rmi_irq_thread,
 				data->irq_flags,
-				dev_name(&rmi_dev->dev), rmi_phys);
+				dev_name(&rmi_dev->dev), xport);
 		if (retval)
 			return retval;
 	} else {
@@ -819,7 +819,7 @@ static int rmi_driver_probe(struct device *dev)
 	dev_dbg(dev, "%s: Starting probe.\n", __func__);
 
 	if (!rmi_is_physical_device(dev)) {
-		dev_dbg(dev, "Not a sensor device.\n");
+		dev_dbg(dev, "Not a physical device.\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 5e3c4d4..0d57700 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -74,7 +74,7 @@ struct rmi_driver_data {
 
 #ifdef CONFIG_RMI4_DEBUG
 	struct dentry *debugfs_delay;
-	struct dentry *debugfs_phys;
+	struct dentry *debugfs_xport;
 	struct dentry *debugfs_reg_ctl;
 	struct dentry *debugfs_reg;
 	struct dentry *debugfs_irq;
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 62351c4..b33074c 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -27,7 +27,7 @@
  *
  * @page_mutex: Locks current page to avoid changing pages in unexpected ways.
  * @page: Keeps track of the current virtual page
- * @phys: Pointer to the physical interface
+ * @xport: Pointer to the transport interface
  *
  * @tx_buf: Buffer used for transmitting data to the sensor over i2c.
  * @tx_buf_size: Size of the buffer
@@ -40,7 +40,7 @@
 struct rmi_i2c_data {
 	struct mutex page_mutex;
 	int page;
-	struct rmi_phys_device *phys;
+	struct rmi_transport_dev *xport;
 
 	u8 *tx_buf;
 	int tx_buf_size;
@@ -97,14 +97,14 @@ static inline void teardown_debugfs(struct rmi_i2c_data *data)
 #define RMI_PAGE_SELECT_REGISTER 0xff
 #define RMI_I2C_PAGE(addr) (((addr) >> 8) & 0xff)
 
-static char *phys_proto_name = "i2c";
+static char *xport_proto_name = "i2c";
 
 /*
  * rmi_set_page - Set RMI page
- * @phys: The pointer to the rmi_phys_device struct
+ * @xport: The pointer to the rmi_transport_dev struct
  * @page: The new page address.
  *
- * RMI devices have 16-bit addressing, but some of the physical
+ * RMI devices have 16-bit addressing, but some of the transport
  * implementations (like SMBus) only have 8-bit addressing. So RMI implements
  * a page address at 0xff of every page so we can reliable page addresses
  * every 256 registers.
@@ -113,21 +113,21 @@ static char *phys_proto_name = "i2c";
  *
  * Returns zero on success, non-zero on failure.
  */
-static int rmi_set_page(struct rmi_phys_device *phys, u8 page)
+static int rmi_set_page(struct rmi_transport_dev *xport, u8 page)
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
@@ -164,11 +164,11 @@ static int copy_to_debug_buf(struct device *dev, struct rmi_i2c_data *data,
 	return 0;
 }
 
-static int rmi_i2c_write_block(struct rmi_phys_device *phys, u16 addr,
+static int rmi_i2c_write_block(struct rmi_transport_dev *xport, u16 addr,
 			       const void *buf, const int len)
 {
-	struct i2c_client *client = to_i2c_client(phys->dev);
-	struct rmi_i2c_data *data = phys->data;
+	struct i2c_client *client = to_i2c_client(xport->dev);
+	struct rmi_i2c_data *data = xport->data;
 	int retval;
 	int tx_size = len + 1;
 
@@ -190,7 +190,7 @@ static int rmi_i2c_write_block(struct rmi_phys_device *phys, u16 addr,
 	memcpy(data->tx_buf + 1, buf, len);
 
 	if (RMI_I2C_PAGE(addr) != data->page) {
-		retval = rmi_set_page(phys, RMI_I2C_PAGE(addr));
+		retval = rmi_set_page(xport, RMI_I2C_PAGE(addr));
 		if (retval < 0)
 			goto exit;
 	}
@@ -202,11 +202,11 @@ static int rmi_i2c_write_block(struct rmi_phys_device *phys, u16 addr,
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
 
@@ -216,18 +216,18 @@ exit:
 }
 
 
-static int rmi_i2c_read_block(struct rmi_phys_device *phys, u16 addr,
+static int rmi_i2c_read_block(struct rmi_transport_dev *xport, u16 addr,
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
@@ -235,21 +235,21 @@ static int rmi_i2c_read_block(struct rmi_phys_device *phys, u16 addr,
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
@@ -265,7 +265,7 @@ exit:
 static int rmi_i2c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct rmi_phys_device *rmi_phys;
+	struct rmi_transport_dev *xport;
 	struct rmi_i2c_data *data;
 	struct rmi_device_platform_data *pdata = client->dev.platform_data;
 	int retval;
@@ -296,10 +296,10 @@ static int rmi_i2c_probe(struct i2c_client *client,
 		return retval;
 	}
 
-	rmi_phys = devm_kzalloc(&client->dev, sizeof(struct rmi_phys_device),
+	xport = devm_kzalloc(&client->dev, sizeof(struct rmi_transport_dev),
 				GFP_KERNEL);
 
-	if (!rmi_phys)
+	if (!xport)
 		return -ENOMEM;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct rmi_i2c_data),
@@ -307,35 +307,35 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
-	data->phys = rmi_phys;
+	data->xport = xport;
 
-	rmi_phys->data = data;
-	rmi_phys->dev = &client->dev;
+	xport->data = data;
+	xport->dev = &client->dev;
 
-	rmi_phys->write_block = rmi_i2c_write_block;
-	rmi_phys->read_block = rmi_i2c_read_block;
-	rmi_phys->info.proto = phys_proto_name;
+	xport->write_block = rmi_i2c_write_block;
+	xport->read_block = rmi_i2c_read_block;
+	xport->info.proto = xport_proto_name;
 
 	mutex_init(&data->page_mutex);
 
 	/* Setting the page to zero will (a) make sure the PSR is in a
 	 * known state, and (b) make sure we can talk to the device.
 	 */
-	retval = rmi_set_page(rmi_phys, 0);
+	retval = rmi_set_page(xport, 0);
 	if (retval) {
 		dev_err(&client->dev, "Failed to set page select to 0.\n");
 		return retval;
 	}
 
-	retval = rmi_register_physical_device(rmi_phys);
+	retval = rmi_register_transport_device(xport);
 	if (retval) {
-		dev_err(&client->dev, "Failed to register physical driver at 0x%.2X.\n",
+		dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
 			client->addr);
 		goto err_gpio;
 	}
-	i2c_set_clientdata(client, rmi_phys);
+	i2c_set_clientdata(client, xport);
 
-	retval = setup_debugfs(rmi_phys->rmi_dev, data);
+	retval = setup_debugfs(xport->rmi_dev, data);
 	if (retval < 0)
 		dev_warn(&client->dev, "Failed to setup debugfs. Code: %d.\n",
 			 retval);
@@ -352,12 +352,12 @@ err_gpio:
 
 static int rmi_i2c_remove(struct i2c_client *client)
 {
-	struct rmi_phys_device *phys = i2c_get_clientdata(client);
+	struct rmi_transport_dev *xport = i2c_get_clientdata(client);
 	struct rmi_device_platform_data *pd = client->dev.platform_data;
 
-	teardown_debugfs(phys->data);
+	teardown_debugfs(xport->data);
 
-	rmi_unregister_physical_device(phys);
+	rmi_unregister_transport_device(xport);
 
 	if (pd->gpio_config)
 		pd->gpio_config(&pd->gpio_data, false);
