From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 6/6] Simplify en/disable of interrupts for NEC.
Date: Fri, 23 Jul 2010 14:52:38 +0100
Message-ID: <20100723135237.19151.43534.stgit@localhost.localdomain>
References: <20100723134852.19151.6999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3200 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760181Ab0GWOZF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 10:25:05 -0400
In-Reply-To: <20100723134852.19151.6999.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg@kroah.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

From: Andy Ross <andy.ross@windriver.com>

Use 8 bit update commands instead of a 16 bit unaligned read/write
pair which fails after the first few calls; the voodoo in the original
doesn't seem to be required with this mechanism.

Tested-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Andy Ross <andy.ross@windriver.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/staging/mrst-touchscreen/intel-mid-touch.c |   65 ++------------------
 1 files changed, 7 insertions(+), 58 deletions(-)


diff --git a/drivers/staging/mrst-touchscreen/intel-mid-touch.c b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
index 760bc7b..4d27d6c 100644
--- a/drivers/staging/mrst-touchscreen/intel-mid-touch.c
+++ b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
@@ -113,17 +113,7 @@ struct mrstouch_dev {
 
 static int mrstouch_nec_adc_read_prepare(struct mrstouch_dev *tsdev)
 {
-	u16 reg;
-	int err;
-
-	err = intel_scu_ipc_ioread16(PMIC_REG_MADCINT, &reg);
-	if (err)
-		return err;
-
-	reg &= 0xDFFF; /* Disable pendet */
-
-	/* Set MADCINT and update ADCCNTL1 (next reg byte) */
-	return intel_scu_ipc_iowrite16(PMIC_REG_MADCINT, reg);
+	return intel_scu_ipc_update_register(PMIC_REG_MADCINT, 0, 0x20);
 }
 
 /*
@@ -131,53 +121,12 @@ static int mrstouch_nec_adc_read_prepare(struct mrstouch_dev *tsdev)
  */
 static int mrstouch_nec_adc_read_finish(struct mrstouch_dev *tsdev)
 {
-	u16 reg;
-	u8 r;
-	u8 pendet_enabled;
-	int retry = 0;
-	int err;
-
-	err = intel_scu_ipc_ioread16(PMIC_REG_MADCINT, &reg);
-	if (err)
-		return err;
-
-	reg &= ~0x0005;
-	reg |= 0x2000; /* Enable pendet */
-
-	/* Set MADCINT and update ADCCNTL1 (next reg byte) */
-	err = intel_scu_ipc_iowrite16(PMIC_REG_MADCINT, reg);
-	if (err)
-		return err;
-
-	/*
-	 * Sometimes even after the register write succeeds
-	 * the PMIC register value is not updated. Retry few iterations
-	 * to enable pendet.
-	 */
-	do {
-		err = intel_scu_ipc_ioread8(PMIC_REG_ADCCNTL1, &r);
-		if (err)
-			return err;
-
-		pendet_enabled = (r >> 5) & 0x01;
-
-		if (!pendet_enabled) {
-			if (++retry >= 10) {
-				dev_err(tsdev->dev,
-					"Touch screen disabled.\n");
-				return -EIO;
-			}
-
-			msleep(10);
-
-			err = intel_scu_ipc_iowrite8(PMIC_REG_ADCCNTL1,
-						     reg >> 8);
-			if (err)
-				return err;
-		}
-	} while (!pendet_enabled);
-
-	return 0;
+	int err = 0;
+	u8 madc = 0x20;
+	err = intel_scu_ipc_update_register(PMIC_REG_MADCINT, 0x20, 0x20);
+	if (!err)
+		err = intel_scu_ipc_update_register(PMIC_REG_ADCCNTL1, 0, 0x05);
+	return err;
 }
 
 /*

