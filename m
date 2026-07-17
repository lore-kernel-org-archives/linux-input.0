Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA83277C9E;
	Fri, 17 Jul 2026 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260533; cv=none; b=noeObmHkCCNJKxNGNahfdt26yK4Syt7IJPgMLVruYnwBDXdbgt/ss/gESMTKUxJ2rp+mAMlXMVfb1tbaJ1lUL9cY/G/6rSnFgX+JyeiIPChTzdYQFoBpWCytJQumqSnIeCZ7EoJXLZegqAUrPcYIdzJJM09OPkKUeMGa7KupP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260533; c=relaxed/simple;
	bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqiIHJ/oVG9fmLsIefAHZhFrEZE/vNnVQzXJ/zzPCNLWMBNvbN2W+eXQnDRCKiwghv/tyDXOT6Z7ziu3IvbtFtCFCMzL8N9wp7bk0XSNMVUSBnb+rQEulOaD6VLfARlF/jZ/98L0PSkTSDYF5C0NqO2HBoBXeIy3W7cv/9PuPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fl+4V52K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fl+4V52K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784260532; x=1815796532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
  b=Fl+4V52KE1nZ5RQ2AXkIDoA61JtM8pgU1eCymIWnCLqeDfcfDM93Fe4n
   nsg6piMFl+xopFTr18EVnWhG6RCCWUf5WeO+vo7pf6MFx9dzVHFiqDtIO
   P9wh8igvu9H3V1D4R+gYBscmryjtayfk5scoLyb49IBCzBUxGYbUEynw3
   hAa6y7/CDg58StXsZeMzVac/frJAIR3qLA5CYQ3722x5Z+eSZ1WJn7PFy
   o1qjm2ac4vw5BGRXdYeW54t5qZM3odZW6wGEFNRCkH47Vcz6Zb0tTMEYN
   2pvchk1PB6ap/jT5YaJwjk0Wmq6bvLH8lSwjNFSA7blxmIRcLiycGdsQr
   w==;
X-CSE-ConnectionGUID: nLqDtjWKSrW/xsY1g1ld1g==
X-CSE-MsgGUID: nEgb/2sgRpCX0iEC9htDNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84808738"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="84808738"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:55:31 -0700
X-CSE-ConnectionGUID: ksdxd0QZT0WKPF2vRgU5sw==
X-CSE-MsgGUID: u78UC3X3SqaQvPAypDfWkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="254029646"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa008.fm.intel.com with ESMTP; 16 Jul 2026 20:55:30 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v4 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA
Date: Fri, 17 Jul 2026 11:56:07 +0800
Message-ID: <20260717035609.3874015-2-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717035609.3874015-1-even.xu@intel.com>
References: <20260717035609.3874015-1-even.xu@intel.com>
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

