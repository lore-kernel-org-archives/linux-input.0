Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A777330650;
	Wed, 29 Jul 2026 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301266; cv=none; b=aOsb8F6nizs+dztjx/t37nl2TFj9u74xRQQEYl1iq3l3cYRGhsfMEn5KFHXoYis/ugXZn4JqpND1CJZ2guFoKWpK5LwHuGY/SH+2757JLfYza4/VhQic3XYAPfFG8uYtHSECJEEVs9F0VbtcyTtV/QWa5BHdVss8/TyJ0nAP8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301266; c=relaxed/simple;
	bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehp8u9JMex69zuK5W7uX6/+A9WdULLD6WDU5dxOd4U78y7gmST73fD9aEURs3Q6NH5xYjT4xHT7k/tbsBmNUNuyQeQOfCrhO+xA1uaCkbR/9gFvRLwnejCpFqiqxuOTM6EDEwzGgHCkVKX/Hs2N8fSOoMA8E7MY7XnGQmPc6mHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4jmVPKm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4jmVPKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785301263; x=1816837263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
  b=L4jmVPKmONHbH+jm596Z+c7XhHZpZH0Zxyhc2B1to6wIeqPhfqf/eKAM
   cj1by8QcpNnxNIZrC0ufNHJHKXEFekcftwkFmDBm5KpF6FFeE+fso4z2W
   Zg05MLp+e+z4VDCugATgCjRHua/IyWLHeU4FTPbZTOhbm0qC7P42/r4eF
   O1t9C6O0Fmhy/lh12kYDf05CqKXwXXvNMDWubA1a5ffaKINwy4TtX8GVT
   jz5gOEd7qlVqIWNyrPJIEu3qBsAFey50zBJPq2vQKexYHAQC0nKQg12Ym
   bxqP5ARqweamX32Adfekb1N8NcR65m8uixPSv4UGWEVcQK70Ez0W5z4+E
   w==;
X-CSE-ConnectionGUID: 3d+VH1XOR/qWOaWSoUKjLQ==
X-CSE-MsgGUID: pm8eUC6tQmuX2HeXpB05ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85842133"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85842133"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 22:01:02 -0700
X-CSE-ConnectionGUID: /NkEl5T/SyKsD8vc/YGKpQ==
X-CSE-MsgGUID: PaQj41acQGKTYQyTakGgTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="284447499"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa001.fm.intel.com with ESMTP; 28 Jul 2026 22:01:00 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hbarnor@chromium.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v5 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA
Date: Wed, 29 Jul 2026 13:01:43 +0800
Message-ID: <20260729050145.2272597-2-even.xu@intel.com>
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

Add a helper function thc_rxdma_reset() to do read DMA reset, it can be
called when fatal DMA error happens.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 51 +++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  1 +
 2 files changed, 52 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index 6ee675e0a738..7ceb8aeeccd3 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -561,6 +561,57 @@ static int thc_wait_for_dma_pause(struct thc_device *dev, enum thc_dma_channel c
 	return 0;
 }
 
+/**
+ * thc_rxdma_reset - Reset all read DMA engines
+ *
+ * @dev: The pointer of THC private device context
+ *
+ * This is a helper function to reset RxDMA configure. It's typically used
+ * for RxDMA recovery when fatal error happens.
+ *
+ * Return: 0 if successful or error code on failure.
+ */
+int thc_rxdma_reset(struct thc_device *dev)
+{
+	int ret;
+
+	if (mutex_lock_interruptible(&dev->thc_bus_lock))
+		return -EINTR;
+
+	ret = thc_interrupt_quiesce(dev, true);
+	if (ret) {
+		dev_err(dev->dev, "Quiesce interrupt failed during RxDMA reset\n");
+		goto end;
+	}
+
+	ret = thc_wait_for_dma_pause(dev, THC_RXDMA1);
+	if (ret) {
+		dev_err(dev->dev, "Wait for RxDMA1 pause failed during RxDMA reset\n");
+		goto end;
+	}
+
+	ret = thc_wait_for_dma_pause(dev, THC_RXDMA2);
+	if (ret) {
+		dev_err(dev->dev, "Wait for RxDMA2 pause failed during RxDMA reset\n");
+		goto end;
+	}
+
+	thc_dma_unconfigure(dev);
+
+	ret = thc_dma_configure(dev);
+	if (ret) {
+		dev_err(dev->dev, "Re-config DMA failed during RxDMA reset\n");
+		goto end;
+	}
+
+	thc_interrupt_quiesce(dev, false);
+
+end:
+	mutex_unlock(&dev->thc_bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(thc_rxdma_reset, "INTEL_THC");
+
 static int read_dma_buffer(struct thc_device *dev,
 			   struct thc_dma_configuration *read_config,
 			   u8 prd_table_index, void *read_buff)
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index 541d33995baf..715423453a9d 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
@@ -145,6 +145,7 @@ int  thc_dma_allocate(struct thc_device *dev);
 int  thc_dma_configure(struct thc_device *dev);
 void thc_dma_unconfigure(struct thc_device *dev);
 void thc_dma_release(struct thc_device *dev);
+int  thc_rxdma_reset(struct thc_device *dev);
 int  thc_rxdma_read(struct thc_device *dev, enum thc_dma_channel dma_channel,
 		    void *read_buff, size_t *read_len, int *read_finished);
 int  thc_swdma_read(struct thc_device *dev, void *write_buff, size_t write_len,
-- 
2.43.0

