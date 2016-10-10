From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 3/8] i2c: i801: use BIT() macro for bits definition
Date: Mon, 10 Oct 2016 18:42:30 +0200
Message-ID: <1476117755-8113-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, KT Liao <kt.liao@emc.com.tw>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

i801 mixes hexadecimal and decimal values for defining bits. However,
we have a nice BIT() macro for this exact purpose.

No functional changes, cleanup only.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v4

no changes in v3

no changes in v2
---
 drivers/i2c/busses/i2c-i801.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index cfb74fc..5928ee2 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -136,26 +136,26 @@
 #define SBREG_SMBCTRL		0xc6000c
 
 /* Host status bits for SMBPCISTS */
-#define SMBPCISTS_INTS		0x08
+#define SMBPCISTS_INTS		BIT(3)
 
 /* Control bits for SMBPCICTL */
-#define SMBPCICTL_INTDIS	0x0400
+#define SMBPCICTL_INTDIS	BIT(10)
 
 /* Host configuration bits for SMBHSTCFG */
-#define SMBHSTCFG_HST_EN	1
-#define SMBHSTCFG_SMB_SMI_EN	2
-#define SMBHSTCFG_I2C_EN	4
+#define SMBHSTCFG_HST_EN	BIT(0)
+#define SMBHSTCFG_SMB_SMI_EN	BIT(1)
+#define SMBHSTCFG_I2C_EN	BIT(2)
 
 /* TCO configuration bits for TCOCTL */
-#define TCOCTL_EN		0x0100
+#define TCOCTL_EN		BIT(8)
 
 /* Auxiliary status register bits, ICH4+ only */
-#define SMBAUXSTS_CRCE		1
-#define SMBAUXSTS_STCO		2
+#define SMBAUXSTS_CRCE		BIT(0)
+#define SMBAUXSTS_STCO		BIT(1)
 
 /* Auxiliary control register bits, ICH4+ only */
-#define SMBAUXCTL_CRC		1
-#define SMBAUXCTL_E32B		2
+#define SMBAUXCTL_CRC		BIT(0)
+#define SMBAUXCTL_E32B		BIT(1)
 
 /* Other settings */
 #define MAX_RETRIES		400
@@ -170,27 +170,27 @@
 #define I801_I2C_BLOCK_DATA	0x18	/* ICH5 and later */
 
 /* I801 Host Control register bits */
-#define SMBHSTCNT_INTREN	0x01
-#define SMBHSTCNT_KILL		0x02
-#define SMBHSTCNT_LAST_BYTE	0x20
-#define SMBHSTCNT_START		0x40
-#define SMBHSTCNT_PEC_EN	0x80	/* ICH3 and later */
+#define SMBHSTCNT_INTREN	BIT(0)
+#define SMBHSTCNT_KILL		BIT(1)
+#define SMBHSTCNT_LAST_BYTE	BIT(5)
+#define SMBHSTCNT_START		BIT(6)
+#define SMBHSTCNT_PEC_EN	BIT(7)	/* ICH3 and later */
 
 /* I801 Hosts Status register bits */
-#define SMBHSTSTS_BYTE_DONE	0x80
-#define SMBHSTSTS_INUSE_STS	0x40
-#define SMBHSTSTS_SMBALERT_STS	0x20
-#define SMBHSTSTS_FAILED	0x10
-#define SMBHSTSTS_BUS_ERR	0x08
-#define SMBHSTSTS_DEV_ERR	0x04
-#define SMBHSTSTS_INTR		0x02
-#define SMBHSTSTS_HOST_BUSY	0x01
+#define SMBHSTSTS_BYTE_DONE	BIT(7)
+#define SMBHSTSTS_INUSE_STS	BIT(6)
+#define SMBHSTSTS_SMBALERT_STS	BIT(5)
+#define SMBHSTSTS_FAILED	BIT(4)
+#define SMBHSTSTS_BUS_ERR	BIT(3)
+#define SMBHSTSTS_DEV_ERR	BIT(2)
+#define SMBHSTSTS_INTR		BIT(1)
+#define SMBHSTSTS_HOST_BUSY	BIT(0)
 
 /* Host Notify Status register bits */
-#define SMBSLVSTS_HST_NTFY_STS	1
+#define SMBSLVSTS_HST_NTFY_STS	BIT(0)
 
 /* Host Notify Command register bits */
-#define SMBSLVCMD_HST_NTFY_INTREN	0x01
+#define SMBSLVCMD_HST_NTFY_INTREN	BIT(0)
 
 #define STATUS_ERROR_FLAGS	(SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | \
 				 SMBHSTSTS_DEV_ERR)
-- 
2.7.4
