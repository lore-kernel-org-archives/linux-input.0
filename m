Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C132B113;
	Wed, 29 Jul 2026 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301281; cv=none; b=Yyl63Qy+vLsYd5r0Wz0d5ajEj9o2Fyg7o9zS7HXQipyQEnK4DOH5dqnSKv/WOMzzqE89uJJlkMxFpMmQMZsDcRSDByIc/yRjgRaSeGT+xqn61nwDGhPr5qiISXWkx/k1bHyDYVPzlQh5l88XDWmb++sL740PiofahcJwE6lKQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301281; c=relaxed/simple;
	bh=MKSP3EwTXix3jhISInbUdGtddMHZf53kQz5o3kDduv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2Kwdrn9kpXhM34COFVVkkvoyYf/7Dy2Xu/V9bBrRQSdowyvHDVXrnXCEs9/RWM9IedrvBQI5JgkJ5gjQCz3/1d77CtFdMcVYAoJqRcORbY6f0Kzl9Bv3yfEH1j73hC/pD2FH2p2NkoAQqKAGosSpa1CsR7A6PJUHu5Q4iRHgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCNPORLQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCNPORLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785301279; x=1816837279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MKSP3EwTXix3jhISInbUdGtddMHZf53kQz5o3kDduv0=;
  b=TCNPORLQOjAr6gc6x9nHjnH2708bBopeAJnV2aebFLJei8geogICd+2C
   z7LMTW7bIPbgOzaixv2wl8LTByKX9Vh+FE4QecpmZDMfX/XA7a8Ty1dTt
   tDqNXkQyvmsEWvv/NMjbg1/Hxhqif6ohEpNIZNFkn3WC8fqp6vZPqthlQ
   NsYDq/Te1jceSB363Wkcz70iVk1zexRyUYN4/CEv0bUVhmDJDDDP+XSos
   Pwh1ARmhV2AU/QvFDsk2CMmV130b2n6bhwmizJO1V9jcObnNO0qLMGczz
   4+RckldOR1b5Yax7ofHMyDqwFDNo4ApEagziryP2S152p8rsr8oOYdSb+
   A==;
X-CSE-ConnectionGUID: DdW3dYp/RuuRKP5zNXGGdw==
X-CSE-MsgGUID: HKKHzkNkSX2HRzyq8+s8fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85842158"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85842158"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 22:01:18 -0700
X-CSE-ConnectionGUID: moC6M3kARZeURejyxdMelw==
X-CSE-MsgGUID: yRcRdsS+Qqe7o7UQNwXZBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="284447546"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa001.fm.intel.com with ESMTP; 28 Jul 2026 22:01:16 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hbarnor@chromium.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v5 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine recover callback
Date: Wed, 29 Jul 2026 13:01:45 +0800
Message-ID: <20260729050145.2272597-4-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729050145.2272597-1-even.xu@intel.com>
References: <20260729050145.2272597-1-even.xu@intel.com>
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
 .../intel-quickspi/pci-quickspi.c             | 71 ++++++++++++-------
 .../intel-quickspi/quickspi-dev.h             |  6 ++
 2 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 4ae2e1718b30..404f0d2f1b9d 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -252,34 +252,33 @@ static irqreturn_t quickspi_irq_quick_handler(int irq, void *dev_id)
 }
 
 /**
- * try_recover - Try to recovery THC and Device
- * @qsdev: pointer to quickspi device
+ * try_recover - Recover callback to recover THC
+ * @work: pointer to work_struct
  *
- * This function is a error handler, called when fatal error happens.
- * It try to reset Touch Device and re-configure THC to recovery
+ * This function is an error handler, called when fatal error happens.
+ * It try to reset Touch Device and re-configure THC to recover
  * transferring between Device and THC.
- *
- * Return: 0 if successful or error code on failed.
  */
-static int try_recover(struct quickspi_device *qsdev)
+static void try_recover(struct work_struct *work)
 {
-	int ret;
+	struct quickspi_device *qsdev = container_of(work, struct quickspi_device, recover_work);
 
-	ret = reset_tic(qsdev);
-	if (ret) {
-		dev_err(qsdev->dev, "Reset touch device failed, ret = %d\n", ret);
-		return ret;
-	}
+	if (READ_ONCE(qsdev->recovery_disabled))
+		return;
 
-	thc_dma_unconfigure(qsdev->thc_hw);
+	if (pm_runtime_resume_and_get(qsdev->dev))
+		return;
 
-	ret = thc_dma_configure(qsdev->thc_hw);
-	if (ret) {
-		dev_err(qsdev->dev, "Re-configure THC DMA failed, ret = %d\n", ret);
-		return ret;
+	thc_interrupt_enable(qsdev->thc_hw, false);
+
+	if (thc_rxdma_reset(qsdev->thc_hw)) {
+		qsdev->state = QUICKSPI_DISABLED;
+		dev_err(qsdev->dev, "RxDMA reset failed during recover, disable QuickSPI\n");
+	} else {
+		thc_interrupt_enable(qsdev->thc_hw, true);
 	}
 
-	return 0;
+	pm_runtime_put_autosuspend(qsdev->dev);
 }
 
 /**
@@ -337,11 +336,10 @@ static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
 	}
 
 end:
-	thc_interrupt_enable(qsdev->thc_hw, true);
-
 	if (err_recover)
-		if (try_recover(qsdev))
-			qsdev->state = QUICKSPI_DISABLED;
+		schedule_work(&qsdev->recover_work);
+	else
+		thc_interrupt_enable(qsdev->thc_hw, true);
 
 	pm_runtime_put_autosuspend(qsdev->dev);
 
@@ -385,6 +383,8 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
 	init_waitqueue_head(&qsdev->report_desc_got_wq);
 	init_waitqueue_head(&qsdev->get_report_cmpl_wq);
 	init_waitqueue_head(&qsdev->set_report_cmpl_wq);
+	WRITE_ONCE(qsdev->recovery_disabled, false);
+	INIT_WORK(&qsdev->recover_work, try_recover);
 
 	/* thc hw init */
 	qsdev->thc_hw = thc_dev_init(qsdev->dev, qsdev->mem_addr);
@@ -461,6 +461,10 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
  */
 static void quickspi_dev_deinit(struct quickspi_device *qsdev)
 {
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	cancel_work_sync(&qsdev->recover_work);
+
+	thc_interrupt_quiesce(qsdev->thc_hw, true);
 	thc_interrupt_enable(qsdev->thc_hw, false);
 	thc_ltr_unconfig(qsdev->thc_hw);
 	thc_wot_unconfig(qsdev->thc_hw);
@@ -711,12 +715,13 @@ static void quickspi_remove(struct pci_dev *pdev)
 		return;
 
 	quickspi_hid_remove(qsdev);
+
+	quickspi_dev_deinit(qsdev);
+
 	quickspi_dma_deinit(qsdev);
 
 	pm_runtime_get_noresume(qsdev->dev);
 
-	quickspi_dev_deinit(qsdev);
-
 	pci_clear_master(pdev);
 }
 
@@ -737,10 +742,10 @@ static void quickspi_shutdown(struct pci_dev *pdev)
 	if (!qsdev)
 		return;
 
+	quickspi_dev_deinit(qsdev);
+
 	/* Must stop DMA before reboot to avoid DMA entering into unknown state */
 	quickspi_dma_deinit(qsdev);
-
-	quickspi_dev_deinit(qsdev);
 }
 
 static int quickspi_suspend(struct device *device)
@@ -759,6 +764,9 @@ static int quickspi_suspend(struct device *device)
 			return ret;
 	}
 
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	cancel_work_sync(&qsdev->recover_work);
+
 	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
 	if (ret)
 		return ret;
@@ -784,6 +792,8 @@ static int quickspi_resume(struct device *device)
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(qsdev->recovery_disabled, false);
+
 	/*
 	 * A wake-enabled device keeps its power and state across suspend, so
 	 * only restore the THC context. Resetting it here would discard a
@@ -864,6 +874,9 @@ static int quickspi_freeze(struct device *device)
 	if (!qsdev)
 		return -ENODEV;
 
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	cancel_work_sync(&qsdev->recover_work);
+
 	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
 	if (ret)
 		return ret;
@@ -895,6 +908,8 @@ static int quickspi_thaw(struct device *device)
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(qsdev->recovery_disabled, false);
+
 	return 0;
 }
 
@@ -919,6 +934,8 @@ static int quickspi_poweroff(struct device *device)
 
 	thc_ltr_unconfig(qsdev->thc_hw);
 
+	quickspi_dev_deinit(qsdev);
+
 	quickspi_dma_deinit(qsdev);
 
 	return 0;
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index bf5e18f5a5f4..2936c8b1532c 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -8,6 +8,7 @@
 #include <linux/hid-over-spi.h>
 #include <linux/sizes.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include "quickspi-protocol.h"
 
@@ -126,6 +127,8 @@ struct acpi_device;
  * @get_feature_cmpl: indicate get feature received or not
  * @set_feature_cmpl_wq: workqueue for waiting set feature to device
  * @set_feature_cmpl: indicate set feature send complete or not
+ * @recover_work: Work structure for recovery
+ * @recovery_disabled: Whether recovery work is blocked during teardown
  */
 struct quickspi_device {
 	struct device *dev;
@@ -173,6 +176,9 @@ struct quickspi_device {
 
 	wait_queue_head_t set_report_cmpl_wq;
 	bool set_report_cmpl;
+
+	struct work_struct recover_work;
+	bool recovery_disabled;
 };
 
 #endif /* _QUICKSPI_DEV_H_ */
-- 
2.43.0

