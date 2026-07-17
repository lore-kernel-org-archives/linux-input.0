Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14867367B90;
	Fri, 17 Jul 2026 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259458; cv=none; b=ah8gD5KzU+bjZrfx5/3YdIfX8lQ1foE4KvUJBtbU4fpiSwule3nM+XfPN1jO1vVPEbjgX8CW2OauvaJiFvhZ7TqeWux3mjMDjL8+eKGtj5QggQU3gzSzms3nni+pZkDmITmi+GSpgIBSALnsMA3fOayIQxjVa5G+oJQG12qtxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259458; c=relaxed/simple;
	bh=Tcas+8z5u6LhwPS3uvHqmyB0+jwZvzQ+q6RtXTjOgyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAQ6EOPME4bheGQKxkxB8yMn/mby740FHL+Fa3H0w6JszS/SQn2M6W8iLC8M5n4XbBRPX3lVedpQR873ncQ7O5J3n2wh04znI8ZSylwzMCS1UQXTBs5akBpk5i1XAsbZ9DC853ZT96meZ2rOijLJVNTU3kBjbnQfCEQAJpQeSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajVSqo+S; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajVSqo+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784259457; x=1815795457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tcas+8z5u6LhwPS3uvHqmyB0+jwZvzQ+q6RtXTjOgyI=;
  b=ajVSqo+SJtGo9J6wza/KSu2P6NLMmRvgSKdy56bBDt2VNwz2kOodo+49
   qaaZSn+gHzmPv3iRwTjZ3T6MYozYl3TebCCwBpbha87eaejydq+pIjc6z
   HaosoQSMBQAcxH/orB6fu7LM4dz2HErqrJ/dPyaIWqBgkSx2x/9JAt25C
   F+Y8MwnKQVicWvZF+lPVRwCICuyta9iNHzX48NcS8Ll4IZtsmgafNA4Vw
   0ImYm2XIk5mOmcwNaewTirdsvciuAaD4q9sLy07FiRfd4eNLInmYR6GCP
   XeauPTuZTwsZ0wMk5PxSpMH6AudY/r5YHS8r3hoEx0YS+rCCQvjMCtJsN
   A==;
X-CSE-ConnectionGUID: VN3PYeJ8T2uvHRbTeuZJcw==
X-CSE-MsgGUID: IPPH2IMFSRuIiWtGNWy2/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95584111"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="95584111"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:37:37 -0700
X-CSE-ConnectionGUID: Wcx0yB5QS328/wM6qjxTew==
X-CSE-MsgGUID: Z26+xMvnS/y/bRwUA8LvBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="260965955"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa005.jf.intel.com with ESMTP; 16 Jul 2026 20:37:35 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v4 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine recover callback
Date: Fri, 17 Jul 2026 11:37:54 +0800
Message-ID: <20260717033754.3689055-4-even.xu@intel.com>
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
 .../intel-quickspi/pci-quickspi.c             | 71 +++++++++++--------
 .../intel-quickspi/quickspi-dev.h             |  6 ++
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index f669235f1883..f048f5b1f7eb 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -252,34 +252,31 @@ static irqreturn_t quickspi_irq_quick_handler(int irq, void *dev_id)
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
-	}
+	thc_interrupt_enable(qsdev->thc_hw, false);
 
-	return 0;
+	if (thc_rxdma_reset(qsdev->thc_hw))
+		qsdev->state = QUICKSPI_DISABLED;
+	else
+		thc_interrupt_enable(qsdev->thc_hw, true);
+
+	pm_runtime_put_autosuspend(qsdev->dev);
 }
 
 /**
@@ -337,11 +334,10 @@ static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
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
 
@@ -385,6 +381,8 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
 	init_waitqueue_head(&qsdev->report_desc_got_wq);
 	init_waitqueue_head(&qsdev->get_report_cmpl_wq);
 	init_waitqueue_head(&qsdev->set_report_cmpl_wq);
+	WRITE_ONCE(qsdev->recovery_disabled, false);
+	INIT_WORK(&qsdev->recover_work, try_recover);
 
 	/* thc hw init */
 	qsdev->thc_hw = thc_dev_init(qsdev->dev, qsdev->mem_addr);
@@ -461,6 +459,10 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
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
@@ -711,12 +713,13 @@ static void quickspi_remove(struct pci_dev *pdev)
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
 
@@ -737,10 +740,10 @@ static void quickspi_shutdown(struct pci_dev *pdev)
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
@@ -759,6 +762,9 @@ static int quickspi_suspend(struct device *device)
 			return ret;
 	}
 
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	cancel_work_sync(&qsdev->recover_work);
+
 	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
 	if (ret)
 		return ret;
@@ -796,6 +802,8 @@ static int quickspi_resume(struct device *device)
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(qsdev->recovery_disabled, false);
+
 	if (!device_may_wakeup(qsdev->dev))
 		return quickspi_set_power(qsdev, HIDSPI_ON);
 
@@ -812,6 +820,9 @@ static int quickspi_freeze(struct device *device)
 	if (!qsdev)
 		return -ENODEV;
 
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	cancel_work_sync(&qsdev->recover_work);
+
 	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
 	if (ret)
 		return ret;
@@ -843,6 +854,8 @@ static int quickspi_thaw(struct device *device)
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(qsdev->recovery_disabled, false);
+
 	return 0;
 }
 
@@ -867,6 +880,8 @@ static int quickspi_poweroff(struct device *device)
 
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

