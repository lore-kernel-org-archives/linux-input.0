Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944536606A;
	Fri, 17 Jul 2026 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259453; cv=none; b=oq8HjKW43bRxuDpzgP0GvTJTbA/u4F0pqYsaxSHQt4gog2D4MA4P4JK+bX2W0yOxaiVNSocHa1iJY+pVu1MkmOvP8jK5Risr6tvZpIayRBbAI3lJu9E4uxvyHfDCPN8mgSfM0QxgKvokmDwXx4RT5V7y9Mbvyb5QZJM0gyQreUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259453; c=relaxed/simple;
	bh=LATK8OS19UxRPjq3bFe3mQh25meaqw6STkll97LEDG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDKqHHOCxcnNf3YLLn6a5bu9zdZV7zY9e0y/PeCAep1LZnRIBuYttPVyGoxjwOX8j8nhOHq3jBkq8YJjYCBME4EtxRqljX8O5XSTqze0HC0N2wgcuXeCArmVJDZO+XGyTj5Bg8hlhHEnxyxEdfhpuoTt063qB8suvhn9FneXfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kun5i5dL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kun5i5dL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784259451; x=1815795451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LATK8OS19UxRPjq3bFe3mQh25meaqw6STkll97LEDG0=;
  b=Kun5i5dLlVX0kvQL+6A+6TRXld72KKGCXJzxDHPayIaiHFRXdu80KKP/
   6HLgnhKW35BmZYUyJ3yyfg0KdDXS0gr+Hq/lIDQ/8xwWLLafUR0GPlX9D
   HgHeOufIl7uTg7BGPvQSERkpDrIr0B+O21w63MhCcjmaSvkSb0k97wMCY
   Ck2XPR8ILwZQB+t+ZC6/uQ8D5pGUrIHkz73GDu/+eOXGvLc+t7kl0Bj0V
   TRHoBdshvj3gHTQLC3ZfL8LT4eaIr7NNRxuWzIcU8xoOkyqn8bnq2ObM8
   rK1a9MmT/ccUPyYn6sVAWj2Sof+Bq4bHuH1SpIzOXockkZZ/2BR6DF0aR
   w==;
X-CSE-ConnectionGUID: t6PIW1+HS9KoRSfg8d5l+A==
X-CSE-MsgGUID: ZsOHn5tFSimep/KG58R+4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95584105"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="95584105"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:37:30 -0700
X-CSE-ConnectionGUID: m9M0C5zkReCRxh1/Ushcrw==
X-CSE-MsgGUID: fxmX+lXoRs+zrVwxBLrUUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="260965949"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa005.jf.intel.com with ESMTP; 16 Jul 2026 20:37:28 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v4 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback
Date: Fri, 17 Jul 2026 11:37:53 +0800
Message-ID: <20260717033754.3689055-3-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717033754.3689055-1-even.xu@intel.com>
References: <20260717033754.3689055-1-even.xu@intel.com>
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
 .../intel-quicki2c/pci-quicki2c.c             | 66 ++++++++++++-------
 .../intel-quicki2c/quicki2c-dev.h             |  5 ++
 2 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 46d3e9a01999..3ccbddfe8e5e 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -245,28 +245,31 @@ static irqreturn_t quicki2c_irq_quick_handler(int irq, void *dev_id)
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
+	if (READ_ONCE(qcdev->recovery_disabled))
+		return;
 
-	ret = thc_dma_configure(qcdev->thc_hw);
-	if (ret) {
-		dev_err(qcdev->dev, "Reconfig DMA failed\n");
-		return ret;
-	}
+	if (pm_runtime_resume_and_get(qcdev->dev))
+		return;
 
-	return 0;
+	thc_interrupt_enable(qcdev->thc_hw, false);
+
+	if (thc_rxdma_reset(qcdev->thc_hw))
+		qcdev->state = QUICKI2C_DISABLED;
+	else
+		thc_interrupt_enable(qcdev->thc_hw, true);
+
+	pm_runtime_put_autosuspend(qcdev->dev);
 }
 
 static int handle_input_report(struct quicki2c_device *qcdev)
@@ -343,11 +346,10 @@ static irqreturn_t quicki2c_irq_thread_handler(int irq, void *dev_id)
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
 
@@ -386,6 +388,8 @@ static struct quicki2c_device *quicki2c_dev_init(struct pci_dev *pdev, void __io
 	qcdev->ddata = ddata;
 
 	init_waitqueue_head(&qcdev->reset_ack_wq);
+	WRITE_ONCE(qcdev->recovery_disabled, false);
+	INIT_WORK(&qcdev->recover_work, try_recover);
 
 	/* THC hardware init */
 	qcdev->thc_hw = thc_dev_init(qcdev->dev, qcdev->mem_addr);
@@ -439,6 +443,9 @@ static struct quicki2c_device *quicki2c_dev_init(struct pci_dev *pdev, void __io
  */
 static void quicki2c_dev_deinit(struct quicki2c_device *qcdev)
 {
+	WRITE_ONCE(qcdev->recovery_disabled, true);
+	cancel_work_sync(&qcdev->recover_work);
+
 	thc_interrupt_quiesce(qcdev->thc_hw, true);
 	thc_interrupt_enable(qcdev->thc_hw, false);
 	thc_ltr_unconfig(qcdev->thc_hw);
@@ -772,12 +779,13 @@ static void quicki2c_remove(struct pci_dev *pdev)
 		return;
 
 	quicki2c_hid_remove(qcdev);
+
+	quicki2c_dev_deinit(qcdev);
+
 	quicki2c_dma_deinit(qcdev);
 
 	pm_runtime_get_noresume(qcdev->dev);
 
-	quicki2c_dev_deinit(qcdev);
-
 	pci_clear_master(pdev);
 }
 
@@ -796,10 +804,10 @@ static void quicki2c_shutdown(struct pci_dev *pdev)
 	if (!qcdev)
 		return;
 
+	quicki2c_dev_deinit(qcdev);
+
 	/* Must stop DMA before reboot to avoid DMA entering into unknown state */
 	quicki2c_dma_deinit(qcdev);
-
-	quicki2c_dev_deinit(qcdev);
 }
 
 static int quicki2c_suspend(struct device *device)
@@ -826,6 +834,9 @@ static int quicki2c_suspend(struct device *device)
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(qcdev->recovery_disabled, true);
+	cancel_work_sync(&qcdev->recover_work);
+
 	ret = thc_interrupt_quiesce(qcdev->thc_hw, true);
 	if (ret)
 		return ret;
@@ -867,6 +878,8 @@ static int quicki2c_resume(struct device *device)
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(qcdev->recovery_disabled, false);
+
 	if (!device_may_wakeup(qcdev->dev))
 		return quicki2c_set_power(qcdev, HIDI2C_ON);
 
@@ -883,6 +896,9 @@ static int quicki2c_freeze(struct device *device)
 	if (!qcdev)
 		return -ENODEV;
 
+	WRITE_ONCE(qcdev->recovery_disabled, true);
+	cancel_work_sync(&qcdev->recover_work);
+
 	ret = thc_interrupt_quiesce(qcdev->thc_hw, true);
 	if (ret)
 		return ret;
@@ -914,6 +930,8 @@ static int quicki2c_thaw(struct device *device)
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(qcdev->recovery_disabled, false);
+
 	return 0;
 }
 
@@ -938,6 +956,8 @@ static int quicki2c_poweroff(struct device *device)
 
 	thc_ltr_unconfig(qcdev->thc_hw);
 
+	quicki2c_dev_deinit(qcdev);
+
 	quicki2c_dma_deinit(qcdev);
 
 	return 0;
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
index 61dbdece59a1..d72565de67b9 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
@@ -191,6 +191,8 @@ struct acpi_device;
  * @i2c_max_frame_size: Max RX frame size (unit in Bytes)
  * @i2c_int_delay_enable: Indicate interrupt delay feature enabled or not
  * @i2c_int_delay: Interrupt detection delay value (unit in 10 us)
+ * @recover_work: Work structure for recovery
+ * @recovery_disabled: Whether recovery work is blocked during teardown
  */
 struct quicki2c_device {
 	struct device *dev;
@@ -226,6 +228,9 @@ struct quicki2c_device {
 	u32 i2c_max_frame_size;
 	u32 i2c_int_delay_enable;
 	u32 i2c_int_delay;
+
+	struct work_struct recover_work;
+	bool recovery_disabled;
 };
 
 #endif /* _QUICKI2C_DEV_H_ */
-- 
2.43.0

