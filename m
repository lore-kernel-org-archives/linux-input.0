From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 6/8] i2c: use an IRQ to report Host Notify events, not alert
Date: Mon, 10 Oct 2016 18:42:33 +0200
Message-ID: <1476117755-8113-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, KT Liao <kt.liao@emc.com.tw>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The current SMBus Host Notify implementation relies on .alert() to
relay its notifications. However, the use cases where SMBus Host
Notify is needed currently is to signal data ready on touchpads.

This is closer to an IRQ than a custom API through .alert().
Given that the 2 touchpad manufacturers (Synaptics and Elan) that
use SMBus Host Notify don't put any data in the SMBus payload, the
concept actually matches one to one.

Benefits are multiple:
- simpler code and API: the client just needs to get the IRQ through
  i2c_smbus_host_notify_to_irq(), nothing needs to be added in the
  adapter beside internally enabling it.
- no more specific workqueue, the threading is handled by IRQ core
  directly (when required)
- no more races when removing the device (the drivers are already
  required to disable irq on remove)
- simpler handling for drivers: use plain regular IRQs
- no more dependency on i2c-smbus for i2c-i801 (and any other adapter)
- the IRQ domain is created automatically when the adapter exports
  the Host Notify capability, but the IRQ are allocated on demand
- the domain is automatically destroyed on remove
- fewer lines of code (minus 20, yeah!)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v4
---
 Documentation/i2c/smbus-protocol |  10 ++--
 drivers/i2c/busses/i2c-i801.c    |  31 +++--------
 drivers/i2c/i2c-core.c           | 117 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-smbus.c          | 102 ----------------------------------
 include/linux/i2c-smbus.h        |  27 ---------
 include/linux/i2c.h              |   5 ++
 6 files changed, 135 insertions(+), 157 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol b/Documentation/i2c/smbus-protocol
index 14d4ec1..8a29ba3 100644
--- a/Documentation/i2c/smbus-protocol
+++ b/Documentation/i2c/smbus-protocol
@@ -200,10 +200,12 @@ alerting device's address.
 [S] [HostAddr] [Wr] A [DevAddr] A [DataLow] A [DataHigh] A [P]
 
 This is implemented in the following way in the Linux kernel:
-* I2C bus drivers which support SMBus Host Notify should call
-  i2c_setup_smbus_host_notify() to setup SMBus Host Notify support.
-* I2C drivers for devices which can trigger SMBus Host Notify should implement
-  the optional alert() callback.
+* I2C bus drivers which support SMBus Host Notify should report
+  I2C_FUNC_SMBUS_HOST_NOTIFY.
+* I2C drivers for devices which can trigger SMBus Host Notify should request
+  a Host Notify IRQ through i2c_smbus_host_notify_to_irq().
+
+There is currently no way to retrieve the data parameter from the client.
 
 
 Packet Error Checking (PEC)
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 42a6a89..a016b48 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -266,7 +266,6 @@ struct i801_priv {
 	 */
 	bool acpi_reserved;
 	struct mutex acpi_lock;
-	struct smbus_host_notify *host_notify;
 };
 
 #define FEATURE_SMBUS_PEC	BIT(0)
@@ -582,10 +581,10 @@ static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
 
 	/*
 	 * With the tested platforms, reading SMBNTFDDAT (22 + (p)->smba)
-	 * always returns 0 and is safe to read.
-	 * We just use 0 given we have no use of the data right now.
+	 * always returns 0. Our current implementation doesn't provide
+	 * data, so we just ignore it.
 	 */
-	i2c_handle_smbus_host_notify(priv->host_notify, addr, 0);
+	i2c_handle_smbus_host_notify(&priv->adapter, addr);
 
 	/* clear Host Notify bit and return */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
@@ -941,17 +940,12 @@ static u32 i801_func(struct i2c_adapter *adapter)
 		I2C_FUNC_SMBUS_HOST_NOTIFY : 0);
 }
 
-static int i801_enable_host_notify(struct i2c_adapter *adapter)
+static void i801_enable_host_notify(struct i2c_adapter *adapter)
 {
 	struct i801_priv *priv = i2c_get_adapdata(adapter);
 
 	if (!(priv->features & FEATURE_HOST_NOTIFY))
-		return -ENOTSUPP;
-
-	if (!priv->host_notify)
-		priv->host_notify = i2c_setup_smbus_host_notify(adapter);
-	if (!priv->host_notify)
-		return -ENOMEM;
+		return;
 
 	priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
 
@@ -961,8 +955,6 @@ static int i801_enable_host_notify(struct i2c_adapter *adapter)
 
 	/* clear Host Notify bit to allow a new notification */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
-
-	return 0;
 }
 
 static void i801_disable_host_notify(struct i801_priv *priv)
@@ -1631,14 +1623,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return err;
 	}
 
-	/*
-	 * Enable Host Notify for chips that supports it.
-	 * It is done after i2c_add_adapter() so that we are sure the work queue
-	 * is not used if i2c_add_adapter() fails.
-	 */
-	err = i801_enable_host_notify(&priv->adapter);
-	if (err && err != -ENOTSUPP)
-		dev_warn(&dev->dev, "Unable to enable SMBus Host Notify\n");
+	i801_enable_host_notify(&priv->adapter);
 
 	i801_probe_optional_slaves(priv);
 	/* We ignore errors - multiplexing is optional */
@@ -1691,9 +1676,7 @@ static int i801_resume(struct device *dev)
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
 	int err;
 
-	err = i801_enable_host_notify(&priv->adapter);
-	if (err && err != -ENOTSUPP)
-		dev_warn(dev, "Unable to enable SMBus Host Notify\n");
+	i801_enable_host_notify(&priv->adapter);
 
 	return 0;
 }
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 79ce9e1..9d5bcf9 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -65,6 +65,9 @@
 #define I2C_ADDR_OFFSET_TEN_BIT	0xa000
 #define I2C_ADDR_OFFSET_SLAVE	0x1000
 
+#define I2C_ADDR_7BITS_MAX	0x77
+#define I2C_ADDR_7BITS_COUNT	(I2C_ADDR_7BITS_MAX + 1)
+
 /* core_lock protects i2c_adapter_idr, and guarantees
    that device detection, deletion of detected devices, and attach_adapter
    calls are serialized */
@@ -1781,6 +1784,110 @@ static const struct i2c_lock_operations i2c_adapter_lock_ops = {
 	.unlock_bus =  i2c_adapter_unlock_bus,
 };
 
+static void i2c_host_notify_irq_teardown(struct i2c_adapter *adap)
+{
+	struct irq_domain *domain = adap->host_notify_domain;
+	irq_hw_number_t hwirq;
+
+	if (!domain)
+		return;
+
+	for (hwirq = 0 ; hwirq < I2C_ADDR_7BITS_COUNT ; hwirq++)
+		irq_dispose_mapping(irq_find_mapping(domain, hwirq));
+
+	irq_domain_remove(domain);
+	adap->host_notify_domain = NULL;
+}
+
+static int i2c_host_notify_irq_map(struct irq_domain *h,
+					  unsigned int virq,
+					  irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+
+	return 0;
+}
+
+static struct irq_domain_ops i2c_host_notify_irq_ops = {
+	.map = i2c_host_notify_irq_map,
+};
+
+static int i2c_setup_host_notify_irq_domain(struct i2c_adapter *adap)
+{
+	struct irq_domain *domain;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_HOST_NOTIFY))
+		return 0;
+
+	domain = irq_domain_create_linear(adap->dev.fwnode,
+					  I2C_ADDR_7BITS_COUNT,
+					  &i2c_host_notify_irq_ops, adap);
+	if (!domain)
+		return -ENOMEM;
+
+	adap->host_notify_domain = domain;
+
+	return 0;
+}
+
+/**
+ * i2c_handle_smbus_host_notify - Forward a Host Notify event to the correct
+ * I2C client.
+ * @adap: the adapter
+ * @addr: the I2C address of the notifying device
+ * Context: can't sleep
+ *
+ * Helper function to be called from an I2C bus driver's interrupt
+ * handler. It will schedule the Host Notify IRQ.
+ */
+int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr)
+{
+	int irq;
+
+	if (!adap)
+		return -EINVAL;
+
+	irq = irq_find_mapping(adap->host_notify_domain, addr);
+	if (irq <= 0)
+		return -ENXIO;
+
+	generic_handle_irq(irq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
+
+/**
+ * i2c_smbus_host_notify_to_irq - Gets a Host Notify IRQ number associated to
+ * the I2C client.
+ * @client: the I2C client
+ *
+ * Will return a valid IRQ number or an error. The Host Notify interrupts
+ * only work currently with 7 bits addresses.
+ */
+int i2c_smbus_host_notify_to_irq(const struct i2c_client *client)
+{
+	struct i2c_adapter *adap = client->adapter;
+	unsigned int irq;
+
+	if (!adap->host_notify_domain)
+		return -ENXIO;
+
+	if (client->flags & I2C_CLIENT_TEN) {
+		dev_err(&client->dev,
+			"Host Notify not supported on 10 bits addresses.\n");
+		return -EINVAL;
+	}
+
+	irq = irq_find_mapping(adap->host_notify_domain, client->addr);
+	if (!irq)
+		irq = irq_create_mapping(adap->host_notify_domain,
+					 client->addr);
+
+	return irq > 0 ? irq : -ENXIO;
+}
+EXPORT_SYMBOL_GPL(i2c_smbus_host_notify_to_irq);
+
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
 	int res = -EINVAL;
@@ -1812,6 +1919,14 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (adap->timeout == 0)
 		adap->timeout = HZ;
 
+	/* register soft irqs for Host Notify */
+	res = i2c_setup_host_notify_irq_domain(adap);
+	if (res) {
+		pr_err("adapter '%s': can't create Host Notify IRQs (%d)\n",
+		       adap->name, res);
+		goto out_list;
+	}
+
 	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
@@ -2049,6 +2164,8 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 
 	pm_runtime_disable(&adap->dev);
 
+	i2c_host_notify_irq_teardown(adap);
+
 	/* wait until all references to the device are gone
 	 *
 	 * FIXME: This is old code and should ideally be replaced by an
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index b0d2679..f9271c7 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -241,108 +241,6 @@ int i2c_handle_smbus_alert(struct i2c_client *ara)
 }
 EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
 
-static void smbus_host_notify_work(struct work_struct *work)
-{
-	struct alert_data alert;
-	struct i2c_adapter *adapter;
-	unsigned long flags;
-	u16 payload;
-	u8 addr;
-	struct smbus_host_notify *data;
-
-	data = container_of(work, struct smbus_host_notify, work);
-
-	spin_lock_irqsave(&data->lock, flags);
-	payload = data->payload;
-	addr = data->addr;
-	adapter = data->adapter;
-
-	/* clear the pending bit and release the spinlock */
-	data->pending = false;
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	if (!adapter || !addr)
-		return;
-
-	alert.type = I2C_PROTOCOL_SMBUS_HOST_NOTIFY;
-	alert.addr = addr;
-	alert.data = payload;
-
-	device_for_each_child(&adapter->dev, &alert, smbus_do_alert);
-}
-
-/**
- * i2c_setup_smbus_host_notify - Allocate a new smbus_host_notify for the given
- * I2C adapter.
- * @adapter: the adapter we want to associate a Host Notify function
- *
- * Returns a struct smbus_host_notify pointer on success, and NULL on failure.
- * The resulting smbus_host_notify must not be freed afterwards, it is a
- * managed resource already.
- */
-struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
-{
-	struct smbus_host_notify *host_notify;
-
-	host_notify = devm_kzalloc(&adap->dev, sizeof(struct smbus_host_notify),
-				   GFP_KERNEL);
-	if (!host_notify)
-		return NULL;
-
-	host_notify->adapter = adap;
-
-	spin_lock_init(&host_notify->lock);
-	INIT_WORK(&host_notify->work, smbus_host_notify_work);
-
-	return host_notify;
-}
-EXPORT_SYMBOL_GPL(i2c_setup_smbus_host_notify);
-
-/**
- * i2c_handle_smbus_host_notify - Forward a Host Notify event to the correct
- * I2C client.
- * @host_notify: the struct host_notify attached to the relevant adapter
- * @addr: the I2C address of the notifying device
- * @data: the payload of the notification
- * Context: can't sleep
- *
- * Helper function to be called from an I2C bus driver's interrupt
- * handler. It will schedule the Host Notify work, in turn calling the
- * corresponding I2C device driver's alert function.
- *
- * host_notify should be a valid pointer previously returned by
- * i2c_setup_smbus_host_notify().
- */
-int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
-				 unsigned short addr, unsigned int data)
-{
-	unsigned long flags;
-	struct i2c_adapter *adapter;
-
-	if (!host_notify || !host_notify->adapter)
-		return -EINVAL;
-
-	adapter = host_notify->adapter;
-
-	spin_lock_irqsave(&host_notify->lock, flags);
-
-	if (host_notify->pending) {
-		spin_unlock_irqrestore(&host_notify->lock, flags);
-		dev_warn(&adapter->dev, "Host Notify already scheduled.\n");
-		return -EBUSY;
-	}
-
-	host_notify->payload = data;
-	host_notify->addr = addr;
-
-	/* Mark that there is a pending notification and release the lock */
-	host_notify->pending = true;
-	spin_unlock_irqrestore(&host_notify->lock, flags);
-
-	return schedule_work(&host_notify->work);
-}
-EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
-
 module_i2c_driver(smbalert_driver);
 
 MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index c2e3324..a138502 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -50,31 +50,4 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 					 struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
-/**
- * smbus_host_notify - internal structure used by the Host Notify mechanism.
- * @adapter: the I2C adapter associated with this struct
- * @work: worker used to schedule the IRQ in the slave device
- * @lock: spinlock to check if a notification is already pending
- * @pending: flag set when a notification is pending (any new notification will
- *		be rejected if pending is true)
- * @payload: the actual payload of the Host Notify event
- * @addr: the address of the slave device which raised the notification
- *
- * This struct needs to be allocated by i2c_setup_smbus_host_notify() and does
- * not need to be freed. Internally, i2c_setup_smbus_host_notify() uses a
- * managed resource to clean this up when the adapter get released.
- */
-struct smbus_host_notify {
-	struct i2c_adapter	*adapter;
-	struct work_struct	work;
-	spinlock_t		lock;
-	bool			pending;
-	u16			payload;
-	u8			addr;
-};
-
-struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap);
-int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
-				 unsigned short addr, unsigned int data);
-
 #endif /* _LINUX_I2C_SMBUS_H */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 4a4099d..5fbef64 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -30,6 +30,7 @@
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
 #include <linux/mutex.h>
+#include <linux/irqdomain.h>		/* for Host Notify IRQ */
 #include <linux/of.h>		/* for struct device_node */
 #include <linux/swab.h>		/* for swab16 */
 #include <uapi/linux/i2c.h>
@@ -567,6 +568,8 @@ struct i2c_adapter {
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
 	const struct i2c_adapter_quirks *quirks;
+
+	struct irq_domain *host_notify_domain;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
@@ -738,6 +741,8 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
 	return (msg->addr << 1) | (msg->flags & I2C_M_RD ? 1 : 0);
 }
 
+int i2c_smbus_host_notify_to_irq(const struct i2c_client *client);
+int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 /**
  * module_i2c_driver() - Helper macro for registering a modular I2C driver
  * @__i2c_driver: i2c_driver struct
-- 
2.7.4
