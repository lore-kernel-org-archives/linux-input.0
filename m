Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C966B38DD3;
	Wed,  1 Jul 2026 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871487; cv=none; b=ISs8+xCsG5OxTst+l9fsN02WXkQpSlyZaTkg0m2WAWcD55U3oFqVzDz0v6OPKbCQiktEVWBX7N4vUVdvY8jov7A4p0FLfxy1K+7fYFomhTEtPAAPGgiSmwNWE9jk+KRXxXDPPx7l9hRLxnlbmtOA/vl7r7xHXgihPXQTBFNrLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871487; c=relaxed/simple;
	bh=LYQGVQstyifGqqrEodatEPvAL1V+WNOvr4XAIO4sJ38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRfu9EWq4LukysHaOjm0yP2tN3M07e35Jk1MZxnbg6AQ/BAbQva4+BMR3pR73NImytHUqfKuQqcb2vv3FNrOCM1pVJrip585P1E0ujVv/a+54aKtUHksKj9OuiVcaFJCX+PkQMY/v8nVc2iJBDR1ya3VogMfLmQ/TDuhoegfLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLSvXNuk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLSvXNuk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782871484; x=1814407484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LYQGVQstyifGqqrEodatEPvAL1V+WNOvr4XAIO4sJ38=;
  b=hLSvXNukKA4vGvXUVDfFy13IbEiYQYxtUtrj6wmf/XCbyMG2NFDwOzlV
   xdXFPjzGoFl/AMGED4aewOfJ1jMAYJESpFH1Skj7oGR5NqEJz1cxrPXWm
   UrmOP49Zx2IaW8d2wdj1RB55w/U/8IKpIWkGGJwQo5C8zUxO7nm4nLOxg
   SseT2Z84yEdpTt/I9YAd5mdAMRfIEaYsWoiVmN2s9aM/WvFaOKq6nDTOv
   TRNwnzkc0cUCHWngnUbzCFD9aKD9hRjq/wvLmf5UUCGv/oObmNNq/1y/z
   AqHz3y9BC39NdxablSyMciCnQ33f3IIUknNls9Wtvt7SB97hRVws3mT8O
   w==;
X-CSE-ConnectionGUID: FsUzME4tQzu3Sa2oio0KXg==
X-CSE-MsgGUID: 7TinRPuzTeOBZfO1o92yiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="106386344"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="106386344"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 19:04:44 -0700
X-CSE-ConnectionGUID: +OaLDVZvRnS7a9MTPOtfKA==
X-CSE-MsgGUID: rsfSZZvJQ/eeMWoyX3ih6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="251997868"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa008.jf.intel.com with ESMTP; 30 Jun 2026 19:04:41 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine recover callback
Date: Wed,  1 Jul 2026 10:04:32 +0800
Message-ID: <20260701020432.3774514-4-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701020432.3774514-1-even.xu@intel.com>
References: <20260701020432.3774514-1-even.xu@intel.com>
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
 .../intel-quickspi/pci-quickspi.c             | 37 +++++++------------
 .../intel-quickspi/quickspi-dev.h             |  2 +
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index f669235f1883..1e63b183b3b1 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -252,34 +252,23 @@ static irqreturn_t quickspi_irq_quick_handler(int irq, void *dev_id)
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
-
-	thc_dma_unconfigure(qsdev->thc_hw);
-
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
 }
 
 /**
@@ -340,8 +329,7 @@ static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
 	thc_interrupt_enable(qsdev->thc_hw, true);
 
 	if (err_recover)
-		if (try_recover(qsdev))
-			qsdev->state = QUICKSPI_DISABLED;
+		schedule_work(&qsdev->recover_work);
 
 	pm_runtime_put_autosuspend(qsdev->dev);
 
@@ -385,6 +373,7 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
 	init_waitqueue_head(&qsdev->report_desc_got_wq);
 	init_waitqueue_head(&qsdev->get_report_cmpl_wq);
 	init_waitqueue_head(&qsdev->set_report_cmpl_wq);
+	INIT_WORK(&qsdev->recover_work, try_recover);
 
 	/* thc hw init */
 	qsdev->thc_hw = thc_dev_init(qsdev->dev, qsdev->mem_addr);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index bf5e18f5a5f4..b0c1219866a4 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -173,6 +173,8 @@ struct quickspi_device {
 
 	wait_queue_head_t set_report_cmpl_wq;
 	bool set_report_cmpl;
+
+	struct work_struct recover_work;
 };
 
 #endif /* _QUICKSPI_DEV_H_ */
-- 
2.43.0

