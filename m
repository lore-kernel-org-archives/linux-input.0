Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0F37996B;
	Fri, 17 Jul 2026 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259442; cv=none; b=RoJpRjlehN2PzBmKQ7bCdCIff/V0/VMzmVkDrPsTudW65zl2FFZpGNiiyUA9oquC+e3XTCt+TR+HsuHkGWeIO7r9MrxEz6Z4I51kY0rQ/t0h5xumxnf1M2n/S1qkprjPS+bPcqYrbmgTBODqCuf9XB5EVATxjJWeHbs4oc9O6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259442; c=relaxed/simple;
	bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QODQQxr8gA92UwHAuy+7ISdLCUQmd8RoJXSWCW/6/PaqogkfeKPaB+YK0kPfqRy24Pq+xXl8EewZQXJCU8Pz6zstBnt2i5VydpH+pSYJA1x3qI7h9Vmdr+gMlFlOeqBMztU3MWWT1bqhzGb+mtEnpaZ5khycqoH95ofBpndnkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFoEJpBX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFoEJpBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784259441; x=1815795441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
  b=AFoEJpBXBwsQwlNA38zu4sx1zl4xQ3WfLJ8hafSUsT8oC9ZXgSu6zabf
   nlkuqXBZhmWvSyKjibwukjPHHDKPF6ddw8oHj9EBN6uu0pMIi1wucIoiM
   f2tP4JPeSPCBG6TNW/xF/PYzVROW+fxsGvH0I7BBgaPy1+3J3QblSa8Qx
   +QoBcmYR27514BGCp0+U+azho7lY7xRjUry3vdTwBcdsWxHtIJBgPKvS0
   RsmhdZA0rlxJHCMjhMuYW3cD9yz/nudB4m4hgRiYeeBdBugHdKxGHB9Wp
   96J7iUr6GBDZw2y32XQ2j1q5DFTMhyfW2sBt0mcXO2Cmt/2qCtbdvu++6
   w==;
X-CSE-ConnectionGUID: CQRss7gWSzOPHvw8hU+mWw==
X-CSE-MsgGUID: B54KuoHDTCWUVSHzFy6VKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95584094"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="95584094"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:37:21 -0700
X-CSE-ConnectionGUID: RSz1dKvwSs2w9Luasb21JA==
X-CSE-MsgGUID: RX7UD84RQDetpX1zzK73Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="260965942"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa005.jf.intel.com with ESMTP; 16 Jul 2026 20:37:19 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v4 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA
Date: Fri, 17 Jul 2026 11:37:52 +0800
Message-ID: <20260717033754.3689055-2-even.xu@intel.com>
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

