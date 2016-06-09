From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v8 3/4] i2c: i801: add support of Host Notify
Date: Thu,  9 Jun 2016 16:53:49 +0200
Message-ID: <1465484030-28838-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The i801 chip can handle the Host Notify feature since ICH 3 as mentioned
in http://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-hub-3-datasheet.pdf

Enable the functionality unconditionally and propagate the alert
on each notification.

With a T440s and a Synaptics touchpad that implements Host Notify, the
payload data is always 0x0000, so I am not sure if the device actually
sends the payload or if there is a problem regarding the implementation.

Tested-by: Andrew Duggan <aduggan@synaptics.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
changes in v2:
- removed the description of the Slave functionality support in the chip table
  (the table shows what is supported, not what the hardware is capable of)
- use i2c-smbus to forward the notification
- remove the fifo, and directly retrieve the address and payload in the worker
- do not check for Host Notification is the feature is not enabled
- use inw_p() to read the payload instead of 2 inb_p() calls
- add /* fall-through */ comment
- unconditionally enable Host Notify if the hardware supports it (can be
  disabled by the user)
 
no changes in v3

changes in v4:
- make use of the new API -> no more worker spawning here
- solved a race between the access of the Host Notify registers and the actual
  I2C transfers.

changes in v5:
- added SKL Host Notify support

changes in v6:
- select I2C_SMBUS in Kconfig to prevent an undefined reference when I2C_I801
  is set to 'Y' while I2C_SMBUS is set to 'M'

no changes in v7

changes in v8:
- reapplied after http://patchwork.ozlabs.org/patch/632768/ and merged the
  conflict (minor conflict in the struct i801_priv).
- removed the .resume hook as upstream changed suspend/resume hooks and there
  is no need in the end to re-enable host notify on resume (tested on Lenovo
  t440 and t450).
- kept Wolfram's Acked-by as the changes were minor

 drivers/i2c/busses/Kconfig    |  1 +
 drivers/i2c/busses/i2c-i801.c | 79 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f167021..ad95376 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -91,6 +91,7 @@ config I2C_I801
 	tristate "Intel 82801 (ICH/PCH)"
 	depends on PCI
 	select CHECK_SIGNATURE if X86 && DMI
+	select I2C_SMBUS
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b436963..169772e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -72,6 +72,7 @@
  * Block process call transaction	no
  * I2C block read transaction		yes (doesn't use the block buffer)
  * Slave mode				no
+ * SMBus Host Notify			yes
  * Interrupt processing			yes
  *
  * See the file Documentation/i2c/busses/i2c-i801 for details.
@@ -86,6 +87,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/dmi.h>
@@ -113,6 +115,10 @@
 #define SMBPEC(p)	(8 + (p)->smba)		/* ICH3 and later */
 #define SMBAUXSTS(p)	(12 + (p)->smba)	/* ICH4 and later */
 #define SMBAUXCTL(p)	(13 + (p)->smba)	/* ICH4 and later */
+#define SMBSLVSTS(p)	(16 + (p)->smba)	/* ICH3 and later */
+#define SMBSLVCMD(p)	(17 + (p)->smba)	/* ICH3 and later */
+#define SMBNTFDADD(p)	(20 + (p)->smba)	/* ICH3 and later */
+#define SMBNTFDDAT(p)	(22 + (p)->smba)	/* ICH3 and later */
 
 /* PCI Address Constants */
 #define SMBBAR		4
@@ -177,6 +183,12 @@
 #define SMBHSTSTS_INTR		0x02
 #define SMBHSTSTS_HOST_BUSY	0x01
 
+/* Host Notify Status registers bits */
+#define SMBSLVSTS_HST_NTFY_STS	1
+
+/* Host Notify Command registers bits */
+#define SMBSLVCMD_HST_NTFY_INTREN	0x01
+
 #define STATUS_ERROR_FLAGS	(SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | \
 				 SMBHSTSTS_DEV_ERR)
 
@@ -252,13 +264,17 @@ struct i801_priv {
 	 */
 	bool acpi_reserved;
 	struct mutex acpi_lock;
+	struct smbus_host_notify *host_notify;
 };
 
+#define SMBHSTNTFY_SIZE		8
+
 #define FEATURE_SMBUS_PEC	(1 << 0)
 #define FEATURE_BLOCK_BUFFER	(1 << 1)
 #define FEATURE_BLOCK_PROC	(1 << 2)
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
 #define FEATURE_IRQ		(1 << 4)
+#define FEATURE_HOST_NOTIFY	(1 << 5)
 /* Not really a feature, but it's convenient to handle it as such */
 #define FEATURE_IDF		(1 << 15)
 #define FEATURE_TCO		(1 << 16)
@@ -269,6 +285,7 @@ static const char *i801_feature_names[] = {
 	"Block process call",
 	"I2C block read",
 	"Interrupt",
+	"SMBus Host Notify",
 };
 
 static unsigned int disable_features;
@@ -277,7 +294,8 @@ MODULE_PARM_DESC(disable_features, "Disable selected driver features:\n"
 	"\t\t  0x01  disable SMBus PEC\n"
 	"\t\t  0x02  disable the block buffer\n"
 	"\t\t  0x08  disable the I2C block read functionality\n"
-	"\t\t  0x10  don't use interrupts ");
+	"\t\t  0x10  don't use interrupts\n"
+	"\t\t  0x20  disable SMBus Host Notify ");
 
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */
@@ -511,8 +529,23 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 	outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
 }
 
+static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
+{
+	unsigned short addr;
+	unsigned int data;
+
+	addr = inb_p(SMBNTFDADD(priv)) >> 1;
+	data = inw_p(SMBNTFDDAT(priv));
+
+	i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
+
+	/* clear Host Notify bit and return */
+	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
+	return IRQ_HANDLED;
+}
+
 /*
- * There are two kinds of interrupts:
+ * There are three kinds of interrupts:
  *
  * 1) i801 signals transaction completion with one of these interrupts:
  *      INTR - Success
@@ -524,6 +557,8 @@ static void i801_isr_byte_done(struct i801_priv *priv)
  *
  * 2) For byte-by-byte (I2C read/write) transactions, one BYTE_DONE interrupt
  *    occurs for each byte of a byte-by-byte to prepare the next byte.
+ *
+ * 3) Host Notify interrupts
  */
 static irqreturn_t i801_isr(int irq, void *dev_id)
 {
@@ -536,6 +571,12 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
 	if (!(pcists & SMBPCISTS_INTS))
 		return IRQ_NONE;
 
+	if (priv->features & FEATURE_HOST_NOTIFY) {
+		status = inb_p(SMBSLVSTS(priv));
+		if (status & SMBSLVSTS_HST_NTFY_STS)
+			return i801_host_notify_isr(priv);
+	}
+
 	status = inb_p(SMBHSTSTS(priv));
 	if (status & SMBHSTSTS_BYTE_DONE)
 		i801_isr_byte_done(priv);
@@ -847,7 +888,27 @@ static u32 i801_func(struct i2c_adapter *adapter)
 	       I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
 	       ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) |
 	       ((priv->features & FEATURE_I2C_BLOCK_READ) ?
-		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0);
+		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0) |
+	       ((priv->features & FEATURE_HOST_NOTIFY) ?
+		I2C_FUNC_SMBUS_HOST_NOTIFY : 0);
+}
+
+static int i801_enable_host_notify(struct i2c_adapter *adapter)
+{
+	struct i801_priv *priv = i2c_get_adapdata(adapter);
+
+	if (!(priv->features & FEATURE_HOST_NOTIFY))
+		return -ENOTSUPP;
+
+	priv->host_notify = i2c_setup_smbus_host_notify(adapter);
+	if (!priv->host_notify)
+		return -ENOMEM;
+
+	outb_p(SMBSLVCMD_HST_NTFY_INTREN, SMBSLVCMD(priv));
+	/* clear Host Notify bit to allow a new notification */
+	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
+
+	return 0;
 }
 
 static const struct i2c_algorithm smbus_algorithm = {
@@ -1379,6 +1440,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		priv->features |= FEATURE_SMBUS_PEC;
 		priv->features |= FEATURE_BLOCK_BUFFER;
 		priv->features |= FEATURE_TCO;
+		priv->features |= FEATURE_HOST_NOTIFY;
 		break;
 
 	case PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF0:
@@ -1398,6 +1460,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		priv->features |= FEATURE_BLOCK_BUFFER;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801CA_3:
+		priv->features |= FEATURE_HOST_NOTIFY;
+		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801BA_2:
 	case PCI_DEVICE_ID_INTEL_82801AB_3:
 	case PCI_DEVICE_ID_INTEL_82801AA_3:
@@ -1507,6 +1571,15 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return err;
 	}
 
+	/*
+	 * Enable Host Notify for chips that supports it.
+	 * It is done after i2c_add_adapter() so that we are sure the work queue
+	 * is not used if i2c_add_adapter() fails.
+	 */
+	err = i801_enable_host_notify(&priv->adapter);
+	if (err && err != -ENOTSUPP)
+		dev_warn(&dev->dev, "Unable to enable SMBus Host Notify\n");
+
 	i801_probe_optional_slaves(priv);
 	/* We ignore errors - multiplexing is optional */
 	i801_add_mux(priv);
-- 
2.5.0

