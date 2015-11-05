From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 23/26] Input: synaptics-rmi4: move structures and definitions to rmi.h
Date: Thu, 5 Nov 2015 15:42:41 -0800
Message-ID: <1446766961-31259-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

Move all of the structures and function definitions needed by hid-rmi
into rmi.h so that they can be accessed by hid-rmi.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_bus.h    | 119 ---------------------------
 drivers/input/rmi4/rmi_driver.h |  47 -----------
 include/linux/rmi.h             | 172 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 166 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 71c9005..59016e0 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -99,128 +99,11 @@ int __must_check __rmi_register_function_handler(struct rmi_function_handler *,
 
 void rmi_unregister_function_handler(struct rmi_function_handler *);
 
-/**
- * struct rmi_driver - driver for an RMI4 sensor on the RMI bus.
- *
- * @driver: Device driver model driver
- * @irq_handler: Callback for handling irqs
- * @reset_handler: Called when a reset is detected.
- * @clear_irq_bits: Clear the specified bits in the current interrupt mask.
- * @set_irq_bist: Set the specified bits in the current interrupt mask.
- * @store_productid: Callback for cache product id from function 01
- * @data: Private data pointer
- *
- */
-struct rmi_driver {
-	struct device_driver driver;
 
-	int (*irq_handler)(struct rmi_device *rmi_dev, int irq);
-	int (*reset_handler)(struct rmi_device *rmi_dev);
-	int (*clear_irq_bits)(struct rmi_device *rmi_dev, unsigned long *mask);
-	int (*set_irq_bits)(struct rmi_device *rmi_dev, unsigned long *mask);
-	int (*store_productid)(struct rmi_device *rmi_dev);
-	int (*set_input_params)(struct rmi_device *rmi_dev,
-			struct input_dev *input);
-	void *data;
-};
 
 #define to_rmi_driver(d) \
 	container_of(d, struct rmi_driver, driver);
 
-/**
- * struct rmi_transport_stats - diagnostic information about the RMI transport
- * device, used in the xport_info debugfs file.
- *
- * @proto String indicating the protocol being used.
- * @tx_count Number of transmit operations.
- * @tx_errs  Number of errors encountered during transmit operations.
- * @tx_bytes Number of bytes transmitted.
- * @rx_count Number of receive operations.
- * @rx_errs  Number of errors encountered during receive operations.
- * @rx_bytes Number of bytes received.
- */
-struct rmi_transport_stats {
-	unsigned long tx_count;
-	unsigned long tx_errs;
-	size_t tx_bytes;
-	unsigned long rx_count;
-	unsigned long rx_errs;
-	size_t rx_bytes;
-};
-
-/**
- * struct rmi_transport_dev - represent an RMI transport device
- *
- * @dev: Pointer to the communication device, e.g. i2c or spi
- * @rmi_dev: Pointer to the RMI device
- * @irq_thread: if not NULL, the sensor driver will use this instead of the
- * default irq_thread implementation.
- * @hard_irq: if not NULL, the sensor driver will use this for the hard IRQ
- * handling
- * @proto_name: name of the transport protocol (SPI, i2c, etc)
- * @ops: pointer to transport operations implementation
- * @stats: transport statistics
- *
- * The RMI transport device implements the glue between different communication
- * buses such as I2C and SPI.
- *
- */
-struct rmi_transport_dev {
-	struct device *dev;
-	struct rmi_device *rmi_dev;
-
-	int irq;
-	int irq_flags;
-
-	irqreturn_t (*irq_thread)(int irq, void *p);
-	irqreturn_t (*hard_irq)(int irq, void *p);
-
-	const char *proto_name;
-	const struct rmi_transport_ops *ops;
-	struct rmi_transport_stats stats;
-
-	struct rmi_device_platform_data pdata;
-};
-
-/**
- * struct rmi_transport_ops - defines transport protocol operations.
- *
- * @write_block: Writing a block of data to the specified address
- * @read_block: Read a block of data from the specified address.
- */
-struct rmi_transport_ops {
-	int (*write_block)(struct rmi_transport_dev *xport, u16 addr,
-			   const void *buf, size_t len);
-	int (*read_block)(struct rmi_transport_dev *xport, u16 addr,
-			  void *buf, size_t len);
-
-	int (*enable_device) (struct rmi_transport_dev *xport);
-	void (*disable_device) (struct rmi_transport_dev *xport);
-	int (*reset)(struct rmi_transport_dev *xport, u16 reset_addr);
-};
-
-/**
- * struct rmi_device - represents an RMI4 sensor device on the RMI bus.
- *
- * @dev: The device created for the RMI bus
- * @number: Unique number for the device on the bus.
- * @driver: Pointer to associated driver
- * @xport: Pointer to the transport interface
- * @debugfs_root: base for this particular sensor device.
- *
- */
-struct rmi_device {
-	struct device dev;
-	int number;
-
-	struct rmi_driver *driver;
-	struct rmi_transport_dev *xport;
-
-#ifdef CONFIG_RMI4_DEBUG
-	struct dentry *debugfs_root;
-#endif
-};
-
 #define to_rmi_device(d) container_of(d, struct rmi_device, dev)
 
 static inline struct rmi_device_platform_data *
@@ -293,8 +176,6 @@ static inline int rmi_write_block(struct rmi_device *d, u16 addr,
 	return d->xport->ops->write_block(d->xport, addr, buf, len);
 }
 
-int rmi_register_transport_device(struct rmi_transport_dev *xport);
-void rmi_unregister_transport_device(struct rmi_transport_dev *xport);
 int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void *data));
 
 /**
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e710aee..73f6141 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -32,51 +32,6 @@
 
 #define NAME_BUFFER_SIZE 256
 
-struct rmi_driver_data {
-	struct list_head function_list;
-
-	struct rmi_device *rmi_dev;
-
-	struct rmi_function *f01_container;
-	bool f01_bootloader_mode;
-
-	u32 attn_count;
-	bool polling;
-	int irq;
-	int irq_flags;
-	int num_of_irq_regs;
-	int irq_count;
-	unsigned long *irq_status;
-	unsigned long *fn_irq_bits;
-	unsigned long *current_irq_mask;
-	unsigned long *new_irq_mask;
-	struct mutex irq_mutex;
-	struct input_dev *input;
-	char input_phys[NAME_BUFFER_SIZE];
-
-	/* Following are used when polling. */
-	struct hrtimer poll_timer;
-	struct work_struct poll_work;
-	ktime_t poll_interval;
-
-	u8 pdt_props;
-	u8 bsr;
-
-	bool enabled;
-#ifdef CONFIG_PM_SLEEP
-	bool suspended;
-	struct mutex suspend_mutex;
-
-	void *pm_data;
-	int (*pre_suspend) (const void *pm_data);
-	int (*post_suspend) (const void *pm_data);
-	int (*pre_resume) (const void *pm_data);
-	int (*post_resume) (const void *pm_data);
-#endif
-
-	void *data;
-};
-
 #define RMI_PDT_ENTRY_SIZE 6
 #define RMI_PDT_FUNCTION_VERSION_MASK   0x60
 #define RMI_PDT_INT_SOURCE_COUNT_MASK   0x07
@@ -141,8 +96,6 @@ bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
 void rmi_unregister_physical_driver(void);
 
-int rmi_process_interrupt_requests(struct rmi_device *rmi_dev);
-
 int rmi_register_f01_handler(void);
 void rmi_unregister_f01_handler(void);
 char *rmi_f01_get_product_ID(struct rmi_function *fn);
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 8de6581..2e4c658 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -23,6 +23,8 @@
 #include <linux/wait.h>
 #include <linux/debugfs.h>
 
+#define NAME_BUFFER_SIZE 256
+
 #define RMI_POLLING	-1
 #define RMI_CUSTOM_IRQ	-2
 
@@ -318,4 +320,174 @@ struct rmi_function_descriptor {
 	u8 function_version;
 };
 
+struct rmi_device;
+
+/**
+ * struct rmi_transport_stats - diagnostic information about the RMI transport
+ * device, used in the xport_info debugfs file.
+ *
+ * @proto String indicating the protocol being used.
+ * @tx_count Number of transmit operations.
+ * @tx_errs  Number of errors encountered during transmit operations.
+ * @tx_bytes Number of bytes transmitted.
+ * @rx_count Number of receive operations.
+ * @rx_errs  Number of errors encountered during receive operations.
+ * @rx_bytes Number of bytes received.
+ */
+struct rmi_transport_stats {
+	unsigned long tx_count;
+	unsigned long tx_errs;
+	size_t tx_bytes;
+	unsigned long rx_count;
+	unsigned long rx_errs;
+	size_t rx_bytes;
+};
+
+/**
+ * struct rmi_transport_dev - represent an RMI transport device
+ *
+ * @dev: Pointer to the communication device, e.g. i2c or spi
+ * @rmi_dev: Pointer to the RMI device
+ * @irq_thread: if not NULL, the sensor driver will use this instead of the
+ * default irq_thread implementation.
+ * @hard_irq: if not NULL, the sensor driver will use this for the hard IRQ
+ * handling
+ * @proto_name: name of the transport protocol (SPI, i2c, etc)
+ * @ops: pointer to transport operations implementation
+ * @stats: transport statistics
+ *
+ * The RMI transport device implements the glue between different communication
+ * buses such as I2C and SPI.
+ *
+ */
+struct rmi_transport_dev {
+	struct device *dev;
+	struct rmi_device *rmi_dev;
+
+	int irq;
+	int irq_flags;
+
+	irqreturn_t (*irq_thread)(int irq, void *p);
+	irqreturn_t (*hard_irq)(int irq, void *p);
+
+	const char *proto_name;
+	const struct rmi_transport_ops *ops;
+	struct rmi_transport_stats stats;
+
+	struct rmi_device_platform_data pdata;
+};
+
+/**
+ * struct rmi_transport_ops - defines transport protocol operations.
+ *
+ * @write_block: Writing a block of data to the specified address
+ * @read_block: Read a block of data from the specified address.
+ */
+struct rmi_transport_ops {
+	int (*write_block)(struct rmi_transport_dev *xport, u16 addr,
+			   const void *buf, size_t len);
+	int (*read_block)(struct rmi_transport_dev *xport, u16 addr,
+			  void *buf, size_t len);
+
+	int (*enable_device)(struct rmi_transport_dev *xport);
+	void (*disable_device)(struct rmi_transport_dev *xport);
+	int (*reset)(struct rmi_transport_dev *xport, u16 reset_addr);
+};
+
+/**
+ * struct rmi_driver - driver for an RMI4 sensor on the RMI bus.
+ *
+ * @driver: Device driver model driver
+ * @irq_handler: Callback for handling irqs
+ * @reset_handler: Called when a reset is detected.
+ * @clear_irq_bits: Clear the specified bits in the current interrupt mask.
+ * @set_irq_bist: Set the specified bits in the current interrupt mask.
+ * @store_productid: Callback for cache product id from function 01
+ * @data: Private data pointer
+ *
+ */
+struct rmi_driver {
+	struct device_driver driver;
+
+	int (*irq_handler)(struct rmi_device *rmi_dev, int irq);
+	int (*reset_handler)(struct rmi_device *rmi_dev);
+	int (*clear_irq_bits)(struct rmi_device *rmi_dev, unsigned long *mask);
+	int (*set_irq_bits)(struct rmi_device *rmi_dev, unsigned long *mask);
+	int (*store_productid)(struct rmi_device *rmi_dev);
+	int (*set_input_params)(struct rmi_device *rmi_dev,
+			struct input_dev *input);
+	void *data;
+};
+
+/**
+ * struct rmi_device - represents an RMI4 sensor device on the RMI bus.
+ *
+ * @dev: The device created for the RMI bus
+ * @number: Unique number for the device on the bus.
+ * @driver: Pointer to associated driver
+ * @xport: Pointer to the transport interface
+ * @debugfs_root: base for this particular sensor device.
+ *
+ */
+struct rmi_device {
+	struct device dev;
+	int number;
+
+	struct rmi_driver *driver;
+	struct rmi_transport_dev *xport;
+
+#ifdef CONFIG_RMI4_DEBUG
+	struct dentry *debugfs_root;
+#endif
+};
+
+struct rmi_driver_data {
+	struct list_head function_list;
+
+	struct rmi_device *rmi_dev;
+
+	struct rmi_function *f01_container;
+	bool f01_bootloader_mode;
+
+	u32 attn_count;
+	bool polling;
+	int irq;
+	int irq_flags;
+	int num_of_irq_regs;
+	int irq_count;
+	unsigned long *irq_status;
+	unsigned long *fn_irq_bits;
+	unsigned long *current_irq_mask;
+	unsigned long *new_irq_mask;
+	struct mutex irq_mutex;
+	struct input_dev *input;
+	char input_phys[NAME_BUFFER_SIZE];
+
+	/* Following are used when polling. */
+	struct hrtimer poll_timer;
+	struct work_struct poll_work;
+	ktime_t poll_interval;
+
+	u8 pdt_props;
+	u8 bsr;
+
+	bool enabled;
+#ifdef CONFIG_PM_SLEEP
+	bool suspended;
+	struct mutex suspend_mutex;
+
+	void *pm_data;
+	int (*pre_suspend)(const void *pm_data);
+	int (*post_suspend)(const void *pm_data);
+	int (*pre_resume)(const void *pm_data);
+	int (*post_resume)(const void *pm_data);
+#endif
+
+	void *data;
+};
+
+int rmi_register_transport_device(struct rmi_transport_dev *xport);
+void rmi_unregister_transport_device(struct rmi_transport_dev *xport);
+int rmi_process_interrupt_requests(struct rmi_device *rmi_dev);
+
 #endif
-- 
2.1.4
