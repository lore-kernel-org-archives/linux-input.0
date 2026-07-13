Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D43659EE;
	Mon, 13 Jul 2026 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911844; cv=none; b=m0FT4YqOeAerJrhDumrlfAaBwrvd8OokDWDCqd2beiOQUhvWCn7+hVLCWWBEXZ+TUenDH1aDXd2czdPHPBX9C++nUPLG1EcTE9spvbTxEfwvIEnaQUJ8ycFNucTDvlIowij9B/ocBIrLsik2bIfrgDnZkslKPlbnRZNVty6JdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911844; c=relaxed/simple;
	bh=+MZfPOhHbiQAz1xTm7BEysp1GdJDTeoVZHJ8pRZDYDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3VNGn3q4rEvM8phxiSaWqIolSeV200kiN/Ki8YUmSqGe2gYQUCa+D2QhtwcTVC5VcJcag5zLPJCjjCegxXUIRxbuHaGE1B6WvKk+r7bSKwGQ15GvQvzOe2V58vGjO4EOG736u47ZMu2bvibK8EKnrDbONA79O08IHgGz6ukiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Znm0Oir3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Znm0Oir3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783911843; x=1815447843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MZfPOhHbiQAz1xTm7BEysp1GdJDTeoVZHJ8pRZDYDc=;
  b=Znm0Oir3D0PLzlEGKEp2BLVQB4+liNYQp0Cn1KZnDAcvYGMo7QOEQaCv
   ZkF2U0tb/EVcEFlEDvbpokY/SkjwhmAYI7wm3ESLfw/gfrD/HNuI4Zvqq
   rl9maLfdxBxnTY9JFWtBcsbwyzMXV+30CVee+M9yitnJeIqtIMpwlS8Z+
   MtlkzlMV0SMp7csm/opk2g8Io92b6svwB+cAYLXmLt7+AiWf5umZ8GrQF
   TAwp/N0d3zvkQwkfDdQjxz2AdRK2i1lsjhVdzigGDSTa/DabtomloncoT
   gP5GwPNJnbWIA66TqnWWEFS9KPzjI2FapP9nqAnlE3M+ZCRKyR0G9g3xp
   w==;
X-CSE-ConnectionGUID: /g/rcHWPSImSuaSnzMJBEA==
X-CSE-MsgGUID: 99omtO9QTq6ek+ubjI0/Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87060329"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87060329"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 20:04:02 -0700
X-CSE-ConnectionGUID: eoTbaNC0SMe0k96+xP7KIQ==
X-CSE-MsgGUID: /2giQ0HZTECMuQTiWD505Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255499366"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2026 20:03:56 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v3 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine recover callback
Date: Mon, 13 Jul 2026 11:04:12 +0800
Message-ID: <20260713030412.2531933-4-even.xu@intel.com>
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
 .../intel-quickspi/pci-quickspi.c             | 53 ++++++++++---------
 .../intel-quickspi/quickspi-dev.h             |  3 ++
 2 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index f669235f1883..3690ddd061e1 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -252,34 +252,28 @@ static irqreturn_t quickspi_irq_quick_handler(int irq, void *dev_id)
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
+	if (pm_runtime_resume_and_get(qsdev->dev))
+		return;
 
-	thc_dma_unconfigure(qsdev->thc_hw);
+	thc_interrupt_enable(qsdev->thc_hw, false);
 
-	ret = thc_dma_configure(qsdev->thc_hw);
-	if (ret) {
-		dev_err(qsdev->dev, "Re-configure THC DMA failed, ret = %d\n", ret);
-		return ret;
-	}
+	if (thc_rxdma_reset(qsdev->thc_hw))
+		qsdev->state = QUICKSPI_DISABLED;
+	else
+		thc_interrupt_enable(qsdev->thc_hw, true);
 
-	return 0;
+	pm_runtime_put_autosuspend(qsdev->dev);
 }
 
 /**
@@ -337,11 +331,10 @@ static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
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
 
@@ -385,6 +378,7 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
 	init_waitqueue_head(&qsdev->report_desc_got_wq);
 	init_waitqueue_head(&qsdev->get_report_cmpl_wq);
 	init_waitqueue_head(&qsdev->set_report_cmpl_wq);
+	INIT_WORK(&qsdev->recover_work, try_recover);
 
 	/* thc hw init */
 	qsdev->thc_hw = thc_dev_init(qsdev->dev, qsdev->mem_addr);
@@ -711,6 +705,12 @@ static void quickspi_remove(struct pci_dev *pdev)
 		return;
 
 	quickspi_hid_remove(qsdev);
+
+	thc_interrupt_quiesce(qsdev->thc_hw, true);
+	thc_interrupt_enable(qsdev->thc_hw, false);
+
+	cancel_work_sync(&qsdev->recover_work);
+
 	quickspi_dma_deinit(qsdev);
 
 	pm_runtime_get_noresume(qsdev->dev);
@@ -737,6 +737,11 @@ static void quickspi_shutdown(struct pci_dev *pdev)
 	if (!qsdev)
 		return;
 
+	thc_interrupt_quiesce(qsdev->thc_hw, true);
+	thc_interrupt_enable(qsdev->thc_hw, false);
+
+	cancel_work_sync(&qsdev->recover_work);
+
 	/* Must stop DMA before reboot to avoid DMA entering into unknown state */
 	quickspi_dma_deinit(qsdev);
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index bf5e18f5a5f4..363e589b0bde 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -8,6 +8,7 @@
 #include <linux/hid-over-spi.h>
 #include <linux/sizes.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include "quickspi-protocol.h"
 
@@ -173,6 +174,8 @@ struct quickspi_device {
 
 	wait_queue_head_t set_report_cmpl_wq;
 	bool set_report_cmpl;
+
+	struct work_struct recover_work;
 };
 
 #endif /* _QUICKSPI_DEV_H_ */
-- 
2.43.0

