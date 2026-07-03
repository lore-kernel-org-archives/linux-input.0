Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076ED36F8EE;
	Fri,  3 Jul 2026 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065522; cv=none; b=MFq7/HP9vXJyzd+o2yWItWJ0e4z1jeS/dHUelngBPMmiFjtGMPXs3+Xz7dQZemR2i8lE5oUgBPhOi6AKBb4EQprlF7rh+2JeefYqkJGKIk74Y0BGsemNIbnUbqoJyHnfug4X6W8izgSSLUJ9yTscLblI78WIToRXxsLQa/GSBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065522; c=relaxed/simple;
	bh=GeornsTVGlNVKH4tqYrhV5+T+l+uGA2OObJBRBmTNr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYM8zqXgdnoPQJEEvSwmPlZWPIcje7bgFOvKlT02NomZ1wjOAqjjzYcytcRcgun6NL2A7dNy/3296lnGYwO+6B2uuscWZTcSoRn7Ys66Wh0WTTdRlQ6roPjYtN5pzP/NsQ8qG9EOYTJR6QmyXGCKbgLC2i1QYAVbyIvMZAcgcLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F18HCZGj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F18HCZGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783065521; x=1814601521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GeornsTVGlNVKH4tqYrhV5+T+l+uGA2OObJBRBmTNr0=;
  b=F18HCZGj8RF9A3Y3/uwbPvBVWCxRN5tu3qInmUVAiEvW6hHd3/PVtgqS
   aAPuHpvUF8jaGS5iYjt+e+6YE0gRXNAnadEMG0vKDlUICsyLVT/DmW4ea
   Qw2Pqif1VheqCkmpTR4V2mQFwULZO40pNMBq6AbUSLgbZzbfMstU/nc6e
   QjJOZjMFLrds0mh8V7s3TQfFMKyagBkdZmyLn4c35sJ/4pGsdwJgt3dmm
   bxQ50yGhYfXMLahrvrKJo8ARAo52LKeSiWXv4F2KpSQZ+nM1e6b59YYjI
   d7klvv5B5cOyunQgmdQtf3m3zsAJ5C26/vfNA++DS3+CzykwkB7/U9vU+
   A==;
X-CSE-ConnectionGUID: 2IAQ/ZPyTn+Vyh+mjEvxcg==
X-CSE-MsgGUID: PKOk7U1HSTWmOBmm+vsijA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83682804"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83682804"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 00:58:40 -0700
X-CSE-ConnectionGUID: CrBXO+B5RHG14V2exdgmTQ==
X-CSE-MsgGUID: 73O5JrLDT5+b4qBICdSYlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="257946053"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa005.fm.intel.com with ESMTP; 03 Jul 2026 00:58:38 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v2 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback
Date: Fri,  3 Jul 2026 15:58:57 +0800
Message-ID: <20260703075858.2780398-3-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703075858.2780398-1-even.xu@intel.com>
References: <20260703075858.2780398-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refine recover flow:
1. Use workqueue to handle recover flow instead of processing in irq
   handler.
2. Call thc_rxdma_reset() API to simplify the recover operation.
3. Disable interrupt during whole recover flow.
4. If recover fails, disable interrupt to avoid interrupt storm.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 .../intel-quicki2c/pci-quicki2c.c             | 42 ++++++++++---------
 .../intel-quicki2c/quicki2c-dev.h             |  2 +
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 46d3e9a01999..11e0e129b44c 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -245,28 +245,28 @@ static irqreturn_t quicki2c_irq_quick_handler(int irq, void *dev_id)
 }
 
 /**
- * try_recover - Try to recovery THC and Device
- * @qcdev: Pointer to quicki2c_device structure
+ * try_recover - Recover callback to recover THC
+ * @work: pointer to work_struct
  *
  * This function is an error handler, called when fatal error happens.
- * It try to reset touch device and re-configure THC to recovery
- * communication between touch device and THC.
- *
- * Return: 0 if successful or error code on failure
+ * It try to reset Touch Device and re-configure THC to recover
+ * transferring between Device and THC.
  */
-static int try_recover(struct quicki2c_device *qcdev)
+static void try_recover(struct work_struct *work)
 {
-	int ret;
+	struct quicki2c_device *qcdev = container_of(work, struct quicki2c_device, recover_work);
 
-	thc_dma_unconfigure(qcdev->thc_hw);
+	if (pm_runtime_resume_and_get(qcdev->dev))
+		return;
 
-	ret = thc_dma_configure(qcdev->thc_hw);
-	if (ret) {
-		dev_err(qcdev->dev, "Reconfig DMA failed\n");
-		return ret;
-	}
+	thc_interrupt_enable(qcdev->thc_hw, false);
 
-	return 0;
+	if (thc_rxdma_reset(qcdev->thc_hw))
+		qcdev->state = QUICKI2C_DISABLED;
+	else
+		thc_interrupt_enable(qcdev->thc_hw, true);
+
+	pm_runtime_put_autosuspend(qcdev->dev);
 }
 
 static int handle_input_report(struct quicki2c_device *qcdev)
@@ -343,11 +343,10 @@ static irqreturn_t quicki2c_irq_thread_handler(int irq, void *dev_id)
 	}
 
 exit:
-	thc_interrupt_enable(qcdev->thc_hw, true);
-
 	if (err_recover)
-		if (try_recover(qcdev))
-			qcdev->state = QUICKI2C_DISABLED;
+		schedule_work(&qcdev->recover_work);
+	else
+		thc_interrupt_enable(qcdev->thc_hw, true);
 
 	pm_runtime_put_autosuspend(qcdev->dev);
 
@@ -386,6 +385,7 @@ static struct quicki2c_device *quicki2c_dev_init(struct pci_dev *pdev, void __io
 	qcdev->ddata = ddata;
 
 	init_waitqueue_head(&qcdev->reset_ack_wq);
+	INIT_WORK(&qcdev->recover_work, try_recover);
 
 	/* THC hardware init */
 	qcdev->thc_hw = thc_dev_init(qcdev->dev, qcdev->mem_addr);
@@ -771,6 +771,8 @@ static void quicki2c_remove(struct pci_dev *pdev)
 	if (!qcdev)
 		return;
 
+	cancel_work_sync(&qcdev->recover_work);
+
 	quicki2c_hid_remove(qcdev);
 	quicki2c_dma_deinit(qcdev);
 
@@ -796,6 +798,8 @@ static void quicki2c_shutdown(struct pci_dev *pdev)
 	if (!qcdev)
 		return;
 
+	cancel_work_sync(&qcdev->recover_work);
+
 	/* Must stop DMA before reboot to avoid DMA entering into unknown state */
 	quicki2c_dma_deinit(qcdev);
 
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
index 61dbdece59a1..aedf85291e60 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
@@ -222,6 +222,8 @@ struct quicki2c_device {
 	wait_queue_head_t reset_ack_wq;
 	bool reset_ack;
 
+	struct work_struct recover_work;
+
 	u32 i2c_max_frame_size_enable;
 	u32 i2c_max_frame_size;
 	u32 i2c_int_delay_enable;
-- 
2.43.0

