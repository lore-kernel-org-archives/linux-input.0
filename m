Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416536F900;
	Fri,  3 Jul 2026 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065526; cv=none; b=UNvzWG1RkglYe2+4sou93HaBfD81FL/F6uS6Vl4Z7v2oaIi3FPu0/o0otSo1zFjXzOReMOMEbJ2aGUw/oI7oab2Axt2lAMZPLTpv0OHwBBU/MkSAZRby3MWeT6OP+vwdcJLKlToGS4us/4WAcsSAb3mrEZ/Phkjc/u2M6CLE+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065526; c=relaxed/simple;
	bh=AGb2skjw6mXSWf9Um9AbNAvc4P13bs9+ez+g3T5jiDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcFuZFskrs2GyR5X1xlDeMRKKBc337ASxVyucTcu7T+hWNBTSuEK5P6uFdUou/rGm2GfkvN/TU4Hp0FNyqALTdKn2HB7KoH2Ev82FHaL5wpCQ3/bfcUcJLHOPyb3thTC65RNMTCJxPF6/1hvGf3o95FN+FEwsS38tqvR0SdLqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtngdLAv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtngdLAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783065525; x=1814601525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AGb2skjw6mXSWf9Um9AbNAvc4P13bs9+ez+g3T5jiDI=;
  b=OtngdLAvidMq+DUbK+J/6ld8vzyI1+eJ1ekB7QvMGjv1iYqTX4t/MOVi
   GxkeQGbkudWuO4Pc/fdxhSksr2sUo4ZGFN3GTmJ9CAH6qC5T0G3+C5gaC
   HsL/lUirNKLvWnYvQDmJxR9qO7YKVKe/Daz0rNJutYoAN83aGqVT0kzDR
   l9Nv+9NIpgHws/fDKEOo+79gufmTrNxajrTYTZT9HlZPV9Kp24aIqJwZi
   0+lMHKfk9sueCqPAobWfV2L6NFaCTyc9rZmhQzkFfzOFgcltbUCqwQ9U7
   iO/1pFV8eQIigbFsvv7ePaPyjoXyL+GEOi1t5AuAlouZyy9ULWq4eBLau
   g==;
X-CSE-ConnectionGUID: +9mt8aA/TzGUOAOMrWOWhw==
X-CSE-MsgGUID: zPy26WxpSbuQV8SSG89hMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83682810"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83682810"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 00:58:45 -0700
X-CSE-ConnectionGUID: DZM4AubeR+2lfc05h2i0Og==
X-CSE-MsgGUID: WNIpsKEETUG0O4dO3rqcFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="257946070"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa005.fm.intel.com with ESMTP; 03 Jul 2026 00:58:43 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v2 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine recover callback
Date: Fri,  3 Jul 2026 15:58:58 +0800
Message-ID: <20260703075858.2780398-4-even.xu@intel.com>
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
 .../intel-quickspi/pci-quickspi.c             | 46 +++++++++----------
 .../intel-quickspi/quickspi-dev.h             |  3 ++
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index f669235f1883..bc9eead77562 100644
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
@@ -710,6 +704,8 @@ static void quickspi_remove(struct pci_dev *pdev)
 	if (!qsdev)
 		return;
 
+	cancel_work_sync(&qsdev->recover_work);
+
 	quickspi_hid_remove(qsdev);
 	quickspi_dma_deinit(qsdev);
 
@@ -737,6 +733,8 @@ static void quickspi_shutdown(struct pci_dev *pdev)
 	if (!qsdev)
 		return;
 
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

