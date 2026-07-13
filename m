Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E39377566;
	Mon, 13 Jul 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911831; cv=none; b=d7rXOrpgcUiTaK/Oj1lYx4Dt9borjkuGr4tAzfuL+trphqzyDpoYGflltrm4qW0rXiHgahLe+VOTt9ymksOPeKFqeJ/8Dz3yLIzlUZJPrzgz6Id6CRLAiuV1ZzN1WGRszaVlQV9cJT7VBr1AxRuJcn4wUfjk7c/Un7qvmJdj0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911831; c=relaxed/simple;
	bh=hhvzDt0ri+2rDs0cuzlxvY4QswvY4YED74zXdTHiL9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi8lPeXwbbpHSPhlwO451dxt9FXhjQdv6eehi5eU//S2+BEcNvO3BQMZT4nutbNvg8mRI9zf6nmEjnVV0WGlXo23yFYoO/Q2KNS+zfgfS6HnTluZh/0nnaFAkzoffN+9+C3c+6+ihI5EXzDRLdtQlCVPCBtF+q+iiSEEbWpQ0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdUFXQSx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdUFXQSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783911828; x=1815447828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhvzDt0ri+2rDs0cuzlxvY4QswvY4YED74zXdTHiL9Y=;
  b=JdUFXQSxuygC8ajvWgGwilTYFcBEAOyEaDmZFr06vdEf4L2TLy2jo1gr
   l9RhpIR/1Y7RDfPKlqKqrZLiX8wiObuISL69BWAYmmeOQsNJfQjTRU4bF
   p0hO+oVU5f5rOXa6eAMKwaMf+8Pr6ZjnfLd/RHwQUYjL9gnPxK8S6cvY6
   WHpanpe8zGDcnL2NL6SjF9zvySnAMkgv7aZh8oFJcgCEKZFYKIEcC3g4v
   cXyR/kJ8A5FByF4fE1lFajtxpjZO2jRwGivf/wVYbtyqDK1dLFIrAtDBs
   ReHYThr+dZ+l80enyIybLAfOtOdKPoJjfPrOMFVUidn4TO07JvwEHDnAC
   w==;
X-CSE-ConnectionGUID: 4E6jfatqQfiJ0wvyf4XH1A==
X-CSE-MsgGUID: q7+/GiDETACrMdC9tlYzcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87060315"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87060315"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 20:03:48 -0700
X-CSE-ConnectionGUID: 4dm52/tmT0yndLfMR0dunw==
X-CSE-MsgGUID: ZCqCQccVSFGuwwtxtuo3FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255499293"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2026 20:03:47 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v3 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback
Date: Mon, 13 Jul 2026 11:04:11 +0800
Message-ID: <20260713030412.2531933-3-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713030412.2531933-1-even.xu@intel.com>
References: <20260713030412.2531933-1-even.xu@intel.com>
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
 .../intel-quicki2c/pci-quicki2c.c             | 49 ++++++++++++-------
 .../intel-quicki2c/quicki2c-dev.h             |  2 +
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 46d3e9a01999..2b586d0635b6 100644
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
@@ -772,6 +772,12 @@ static void quicki2c_remove(struct pci_dev *pdev)
 		return;
 
 	quicki2c_hid_remove(qcdev);
+
+	thc_interrupt_quiesce(qcdev->thc_hw, true);
+	thc_interrupt_enable(qcdev->thc_hw, false);
+
+	cancel_work_sync(&qcdev->recover_work);
+
 	quicki2c_dma_deinit(qcdev);
 
 	pm_runtime_get_noresume(qcdev->dev);
@@ -796,6 +802,11 @@ static void quicki2c_shutdown(struct pci_dev *pdev)
 	if (!qcdev)
 		return;
 
+	thc_interrupt_quiesce(qcdev->thc_hw, true);
+	thc_interrupt_enable(qcdev->thc_hw, false);
+
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

