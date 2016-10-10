From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 5/8] i2c: i801: remove SMBNTFDDAT reads as they always seem to return 0
Date: Mon, 10 Oct 2016 18:42:32 +0200
Message-ID: <1476117755-8113-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, KT Liao <kt.liao@emc.com.tw>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On the platform tested, reading SMBNTFDDAT always returns 0 (using 1 read
of a word or 2 of 2 bytes). Given that we are not sure why and that we
don't need to rely on the data parameter in the current users of Host
Notify, remove this part of the code.

If someone wants to re-enable it, just revert this commit and data should
be available.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v4

no changes in v3

new in v2
---
 drivers/i2c/busses/i2c-i801.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 88b2e31..42a6a89 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -117,7 +117,6 @@
 #define SMBSLVSTS(p)	(16 + (p)->smba)	/* ICH3 and later */
 #define SMBSLVCMD(p)	(17 + (p)->smba)	/* ICH3 and later */
 #define SMBNTFDADD(p)	(20 + (p)->smba)	/* ICH3 and later */
-#define SMBNTFDDAT(p)	(22 + (p)->smba)	/* ICH3 and later */
 
 /* PCI Address Constants */
 #define SMBBAR		4
@@ -578,12 +577,15 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 static irqreturn_t i801_host_notify_isr(struct i801_priv *priv)
 {
 	unsigned short addr;
-	unsigned int data;
 
 	addr = inb_p(SMBNTFDADD(priv)) >> 1;
-	data = inw_p(SMBNTFDDAT(priv));
 
-	i2c_handle_smbus_host_notify(priv->host_notify, addr, data);
+	/*
+	 * With the tested platforms, reading SMBNTFDDAT (22 + (p)->smba)
+	 * always returns 0 and is safe to read.
+	 * We just use 0 given we have no use of the data right now.
+	 */
+	i2c_handle_smbus_host_notify(priv->host_notify, addr, 0);
 
 	/* clear Host Notify bit and return */
 	outb_p(SMBSLVSTS_HST_NTFY_STS, SMBSLVSTS(priv));
-- 
2.7.4
