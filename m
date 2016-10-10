From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 1/8] i2c: i801: store and restore the SLVCMD register at load and unload
Date: Mon, 10 Oct 2016 18:42:28 +0200
Message-ID: <1476117755-8113-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, KT Liao <kt.liao@emc.com.tw>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Also do not override any other configuration in this register.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v4:
- add the i801_disable_host_notify function here as this gets the
  first in the series

no changes in v3

new in v2
---
 drivers/i2c/busses/i2c-i801.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 22a0ed4..3a2fdf5 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -240,6 +240,7 @@ struct i801_priv {
 	struct i2c_adapter adapter;
 	unsigned long smba;
 	unsigned char original_hstcfg;
+	unsigned char original_slvcmd;
 	struct pci_dev *pci_dev;
 	unsigned int features;
 
@@ -952,13 +953,26 @@ static int i801_enable_host_notify(struct i2c_adapter *adapter)
 	if (!priv->host_notify)
 		return -ENOMEM;
 
-	outb_p(SMBSLVCMD_HST_NTFY_INTREN, SMBSLVCMD(priv));
+	priv->original_slvcmd = inb_p(SMBSLVCMD(priv));
+
+	if (!(SMBSLVCMD_HST_NTFY_INTREN & priv->original_slvcmd))
+		outb_p(SMBSLVCMD_HST_NTFY_INTREN | priv->original_slvcmd,
+		       SMBSLVCMD(priv));
+
 	/* clear Host Notify bit to allow a new notification */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
 
 	return 0;
 }
 
+static void i801_disable_host_notify(struct i801_priv *priv)
+{
+	if (!(priv->features & FEATURE_HOST_NOTIFY))
+		return;
+
+	outb_p(priv->original_slvcmd, SMBSLVCMD(priv));
+}
+
 static const struct i2c_algorithm smbus_algorithm = {
 	.smbus_xfer	= i801_access,
 	.functionality	= i801_func,
@@ -1647,6 +1661,7 @@ static void i801_remove(struct pci_dev *dev)
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_get_noresume(&dev->dev);
 
+	i801_disable_host_notify(priv);
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	i801_acpi_remove(priv);
-- 
2.7.4
