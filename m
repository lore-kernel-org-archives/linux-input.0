From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v6 2/4] i2c-smbus: add SMBus Host Notify support
Date: Wed, 16 Mar 2016 17:39:06 +0100
Message-ID: <1458146348-17171-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1458146348-17171-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1458146348-17171-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

SMBus Host Notify allows a slave device to act as a master on a bus to
notify the host of an interrupt. On Intel chipsets, the functionality
is directly implemented in the firmware. We just need to export a
function to call .alert() on the proper device driver.

i2c_handle_smbus_host_notify() behaves like i2c_handle_smbus_alert().
When called, it schedules a task that will be able to sleep to go through
the list of devices attached to the adapter.

The current implementation allows one Host Notification to be scheduled
while an other is running.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

changes in v2:
- do the actual processing of finding the device in i2c-smbus.c
- remove the i2c-core implementations
- remove the manual toggle of SMBus Host Notify

no changes in v3

changes in v4:
- schedule the worker in i2c_handle_smbus_host_notify() -> it can now be called
  in an interrupt context.
- introduce i2c_setup_smbus_host_notify()

no changes in v5

changes in v6:
- fix the parameters of the inlined functions when the module is not compiled

 Documentation/i2c/smbus-protocol |   3 ++
 drivers/i2c/i2c-smbus.c          | 113 +++++++++++++++++++++++++++++++++++++--
 include/linux/i2c-smbus.h        |  44 +++++++++++++++
 include/linux/i2c.h              |   3 ++
 include/uapi/linux/i2c.h         |   1 +
 5 files changed, 159 insertions(+), 5 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol b/Documentation/i2c/smbus-protocol
index 6012b12..4e07848 100644
--- a/Documentation/i2c/smbus-protocol
+++ b/Documentation/i2c/smbus-protocol
@@ -199,6 +199,9 @@ alerting device's address.
 
 [S] [HostAddr] [Wr] A [DevAddr] A [DataLow] A [DataHigh] A [P]
 
+I2C drivers for devices which can trigger SMBus Host Notify should implement
+the optional alert() callback.
+
 
 Packet Error Checking (PEC)
 ===========================
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 3b6765a..1de7ee5 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -33,7 +33,8 @@ struct i2c_smbus_alert {
 
 struct alert_data {
 	unsigned short		addr;
-	u8			flag:1;
+	enum i2c_alert_protocol	type;
+	unsigned int		data;
 };
 
 /* If this is the alerting device, notify its driver */
@@ -56,8 +57,7 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	if (client->dev.driver) {
 		driver = to_i2c_driver(client->dev.driver);
 		if (driver->alert)
-			driver->alert(client, I2C_PROTOCOL_SMBUS_ALERT,
-				      data->flag);
+			driver->alert(client, data->type, data->data);
 		else
 			dev_warn(&client->dev, "no driver alert()!\n");
 	} else
@@ -97,8 +97,9 @@ static void smbus_alert(struct work_struct *work)
 		if (status < 0)
 			break;
 
-		data.flag = status & 1;
+		data.data = status & 1;
 		data.addr = status >> 1;
+		data.type = I2C_PROTOCOL_SMBUS_ALERT;
 
 		if (data.addr == prev_addr) {
 			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
@@ -106,7 +107,7 @@ static void smbus_alert(struct work_struct *work)
 			break;
 		}
 		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
-			data.addr, data.flag);
+			data.addr, data.data);
 
 		/* Notify driver for the device which issued the alert */
 		device_for_each_child(&ara->adapter->dev, &data,
@@ -240,6 +241,108 @@ int i2c_handle_smbus_alert(struct i2c_client *ara)
 }
 EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
 
+static void smbus_host_notify_work(struct work_struct *work)
+{
+	struct alert_data alert;
+	struct i2c_adapter *adapter;
+	unsigned long flags;
+	u16 payload;
+	u8 addr;
+	struct smbus_host_notify *data;
+
+	data = container_of(work, struct smbus_host_notify, work);
+
+	spin_lock_irqsave(&data->lock, flags);
+	payload = data->payload;
+	addr = data->addr;
+	adapter = data->adapter;
+
+	/* clear the pending bit and release the spinlock */
+	data->pending = false;
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	if (!adapter || !addr)
+		return;
+
+	alert.type = I2C_PROTOCOL_SMBUS_HOST_NOTIFY;
+	alert.addr = addr;
+	alert.data = payload;
+
+	device_for_each_child(&adapter->dev, &alert, smbus_do_alert);
+}
+
+/**
+ * i2c_setup_smbus_host_notify - Allocate a new smbus_host_notify for the given
+ * I2C adapter.
+ * @adapter: the adapter we want to associate a Host Notify function
+ *
+ * Returns a struct smbus_host_notify pointer on success, and NULL on failure.
+ * The resulting smbus_host_notify must not be freed afterwards, it is a
+ * managed resource already.
+ */
+struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
+{
+	struct smbus_host_notify *host_notify;
+
+	host_notify = devm_kzalloc(&adap->dev, sizeof(struct smbus_host_notify),
+				   GFP_KERNEL);
+	if (!host_notify)
+		return NULL;
+
+	host_notify->adapter = adap;
+
+	spin_lock_init(&host_notify->lock);
+	INIT_WORK(&host_notify->work, smbus_host_notify_work);
+
+	return host_notify;
+}
+EXPORT_SYMBOL_GPL(i2c_setup_smbus_host_notify);
+
+/**
+ * i2c_handle_smbus_host_notify - Forward a Host Notify event to the correct
+ * I2C client.
+ * @host_notify: the struct host_notify attached to the relevant adapter
+ * @data: the Host Notify data which contains the payload and address of the
+ * client
+ * Context: can't sleep
+ *
+ * Helper function to be called from an I2C bus driver's interrupt
+ * handler. It will schedule the Host Notify work, in turn calling the
+ * corresponding I2C device driver's alert function.
+ *
+ * host_notify should be a valid pointer previously returned by
+ * i2c_setup_smbus_host_notify().
+ */
+int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
+				 unsigned short addr, unsigned int data)
+{
+	unsigned long flags;
+	struct i2c_adapter *adapter;
+
+	if (!host_notify || !host_notify->adapter)
+		return -EINVAL;
+
+	adapter = host_notify->adapter;
+
+	spin_lock_irqsave(&host_notify->lock, flags);
+
+	if (host_notify->pending) {
+		spin_unlock_irqrestore(&host_notify->lock, flags);
+		dev_warn(&adapter->dev, "Host Notify already scheduled\n.");
+		return -EFAULT;
+	}
+
+	host_notify->payload = data;
+	host_notify->addr = addr;
+
+	/* Mark that there is a pending notification and release the lock */
+	host_notify->pending = true;
+	spin_unlock_irqrestore(&host_notify->lock, flags);
+
+	return schedule_work(&host_notify->work);
+}
+EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
+
 module_i2c_driver(smbalert_driver);
 
 MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 8f1b086..3adeee3 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -23,6 +23,8 @@
 #define _LINUX_I2C_SMBUS_H
 
 #include <linux/i2c.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 
 /**
@@ -48,4 +50,46 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 					 struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
+/**
+ * smbus_host_notify - internal structure used by the Host Notify mechanism.
+ * @adapter: the I2C adapter associated with this struct
+ * @work: worker used to schedule the IRQ in the slave device
+ * @lock: spinlock to check if a notification is already pending
+ * @pending: flag set when a notification is pending (any new notification will
+ *		be rejected if pending is true)
+ * @payload: the actual payload of the Host Notify event
+ * @addr: the address of the slave device which raised the notification
+ *
+ * This struct needs to be allocated by i2c_setup_smbus_host_notify() and does
+ * not need to be freed. Internally, i2c_setup_smbus_host_notify() uses a
+ * managed resource to clean this up when the adapter get released.
+ */
+struct smbus_host_notify {
+	struct i2c_adapter	*adapter;
+	struct work_struct	work;
+	spinlock_t		lock;
+	bool			pending;
+	u16			payload;
+	u8			addr;
+};
+
+#if defined(CONFIG_I2C_SMBUS) || defined(CONFIG_I2C_SMBUS_MODULE)
+struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap);
+int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
+				 unsigned short addr, unsigned int data);
+#else
+static inline struct smbus_host_notify *
+i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
+{
+	return NULL;
+}
+
+static inline int
+i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
+			     unsigned short addr, unsigned int data)
+{
+	return 0;
+}
+#endif /* I2C_SMBUS */
+
 #endif /* _LINUX_I2C_SMBUS_H */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index baae02a..056f800 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -128,6 +128,7 @@ i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 
 enum i2c_alert_protocol {
 	I2C_PROTOCOL_SMBUS_ALERT,
+	I2C_PROTOCOL_SMBUS_HOST_NOTIFY,
 };
 
 /**
@@ -184,6 +185,8 @@ struct i2c_driver {
 	 * The format and meaning of the data value depends on the protocol.
 	 * For the SMBus alert protocol, there is a single bit of data passed
 	 * as the alert response's low bit ("event flag").
+	 * For the SMBus Host Notify protocol, the data corresponds to the
+	 * 16-bit payload data reported by the slave device acting as master.
 	 */
 	void (*alert)(struct i2c_client *, enum i2c_alert_protocol protocol,
 		      unsigned int data);
diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index b0a7dd6..83ec8ae 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -101,6 +101,7 @@ struct i2c_msg {
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
+#define I2C_FUNC_SMBUS_HOST_NOTIFY	0x10000000
 
 #define I2C_FUNC_SMBUS_BYTE		(I2C_FUNC_SMBUS_READ_BYTE | \
 					 I2C_FUNC_SMBUS_WRITE_BYTE)
-- 
2.5.0

