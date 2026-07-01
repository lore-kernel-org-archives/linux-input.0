Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067938DD3;
	Wed,  1 Jul 2026 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871475; cv=none; b=rh/rvAcC+qlN1sExzUZRPHZMGmgaAjmCSqOHOe7XGXoFtZ3YHSydoROqpWpXBG7UQnuFj1sjzwa+2w0Nzjz5SkOymkKwgjHt8G2F120hxCWQstMWSjSSUuk0v8ST8Lqec7Im3IFw93IEMWy7b3OZu5w0SN9+jDKBY98A/1+lQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871475; c=relaxed/simple;
	bh=AbuJ48fdd0R4rU4nBhIgwq2Ek8s6Nn8U1llByqhL8bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7V5ly3/dx8Vy0jrxbxplLWsF5fBLTay3CJiXqaNaxSThynRcoSfWxTq6s7gXoD1ycjLTSScaW1CpyzdcRFZnHLCrz0hqbxx5MhVH4NVj8/1OEJT7a2mU2nCocVHXh7Y4ZU3w2GgCc9MC43rMvRH99pDtaJV+JTyUzkgzBQV9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlacPCHk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlacPCHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782871472; x=1814407472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AbuJ48fdd0R4rU4nBhIgwq2Ek8s6Nn8U1llByqhL8bE=;
  b=FlacPCHkOcnNmfeuNyIADGsHor/P5tDHXmJ2pm52jS0OGCtEHxxeaz95
   TCuBd5yhQbkMP8UyiAyr4Y8CcvC3D3FruIL4LKWNiAENSnC4oXRVkPHwC
   9F/2hWA1tO6hWWcDN3Cut2+q7/kpiPgnPuttkoRYtEpwN1HP05rWiLuke
   wDZJjRVs9t2HwF/ImpbfUFmsvhHOMXJ3RMnTA4+VpY//oa99xQojd9nBn
   dEfV9dQwobJ7v2z1y0OofwMKaNRwdVGCBfPFE+vqPh6P61An99w0sP9GS
   FaiCgoFeeZgWETNgCa6LEj3lXoEICE3Kr/W/E+sp8m7EjwZSbh3pYG/kz
   A==;
X-CSE-ConnectionGUID: mhR4R4PyT5G1qD0Dp/nJLA==
X-CSE-MsgGUID: lFvbmaFPSJuqOvjYpuO6wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="106386328"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="106386328"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 19:04:31 -0700
X-CSE-ConnectionGUID: PPIpoyVFTsCVW0UjFj2q5g==
X-CSE-MsgGUID: yGBKYIvYQKC4i1iTGMQHCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="251997842"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa008.jf.intel.com with ESMTP; 30 Jun 2026 19:04:29 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback
Date: Wed,  1 Jul 2026 10:04:31 +0800
Message-ID: <20260701020432.3774514-3-even.xu@intel.com>
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
 .../intel-quicki2c/pci-quicki2c.c             | 31 ++++++++-----------
 .../intel-quicki2c/quicki2c-dev.h             |  2 ++
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 46d3e9a01999..411d7a0ab90e 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -245,28 +245,23 @@ static irqreturn_t quicki2c_irq_quick_handler(int irq, void *dev_id)
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
-
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
 }
 
 static int handle_input_report(struct quicki2c_device *qcdev)
@@ -346,8 +341,7 @@ static irqreturn_t quicki2c_irq_thread_handler(int irq, void *dev_id)
 	thc_interrupt_enable(qcdev->thc_hw, true);
 
 	if (err_recover)
-		if (try_recover(qcdev))
-			qcdev->state = QUICKI2C_DISABLED;
+		schedule_work(&qcdev->recover_work);
 
 	pm_runtime_put_autosuspend(qcdev->dev);
 
@@ -386,6 +380,7 @@ static struct quicki2c_device *quicki2c_dev_init(struct pci_dev *pdev, void __io
 	qcdev->ddata = ddata;
 
 	init_waitqueue_head(&qcdev->reset_ack_wq);
+	INIT_WORK(&qcdev->recover_work, try_recover);
 
 	/* THC hardware init */
 	qcdev->thc_hw = thc_dev_init(qcdev->dev, qcdev->mem_addr);
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

