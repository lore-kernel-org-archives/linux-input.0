Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A036166A;
	Wed,  1 Jul 2026 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871461; cv=none; b=ekgsZGoXq5I53DyxWtbNf0RY8QZarbuYfy5jndfiKrD2zJMmsjqISGPt9Tr0WPHvxX/Fh+tOQYAyY6V7wCZ7uPXKipiSs9M1n7VWs/nPDebso7xuLohGE2+KxwSv59rh3V5dtDsLDTzXqLYSQ6ml5gqYuQMSpAhIV2cv6zE2nto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871461; c=relaxed/simple;
	bh=PtEGzrAXDuFgue0F9QOPkcs6zViGIW9gK0/+aEpjuUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT4ND81HfSLMohYiUp7d5D/IwQVkb+xwDhKkETi3L89gIlr5LLTDQu/oBVdZRwOrHjD/jCYkT9TEuxBa/r53zMB+rlo0kchnsFBmXXUPZzd6e92OdVkA/OXkFCAN9/2q0I9zeJY2KmGHCiY0muRNiY7+H9xGY5W1TKgdFiosWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHJB7QSZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHJB7QSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782871459; x=1814407459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PtEGzrAXDuFgue0F9QOPkcs6zViGIW9gK0/+aEpjuUU=;
  b=hHJB7QSZgkL/UwlNmrtQo10dJqlUtoTibeM34NkkgIOJWyjJlqpI7Frc
   W0h0DQnBwEclSHcDyz4i/GNsbEfe1JLHuaFdUbjqMciJLiRedlU0ANCBP
   noFCGiFJ8IKpSDp7epKD/v7KcEwzlgTszioMyllVUmjMMJbWXAzCzLemU
   kJwpT+vI9rRebil7v4d5zEJ82VK7qYiTnxTAbW2hCm2aS/AoY2f8QWo3P
   Lx7jFLwKqAu7nXC+qrpaeCvV9uOe2ABqE3cHnEmuKtkMHVmALRtul20rS
   gmcEuELg6bUWNnwfDgWtawEa2h9BjH4mfyWGihJhWNsZsaJh0SgdwEZ9r
   w==;
X-CSE-ConnectionGUID: 92cM5V+iSsWRvNfrBha6Ww==
X-CSE-MsgGUID: E7KhvqLBRaGD1XSksBcPjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="106386316"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="106386316"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 19:04:19 -0700
X-CSE-ConnectionGUID: SsQ2846KSZukZ6ZD9ZuNxQ==
X-CSE-MsgGUID: cQ6EDudQTNuEyxzGRfQGIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="251997818"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa008.jf.intel.com with ESMTP; 30 Jun 2026 19:04:17 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA
Date: Wed,  1 Jul 2026 10:04:30 +0800
Message-ID: <20260701020432.3774514-2-even.xu@intel.com>
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

Add a helper function thc_rxdam_reset() to do read DMA reset, it can be
called when fatal DMA error happens.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 37 +++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index 6ee675e0a738..d771c85dff28 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -532,6 +532,43 @@ void thc_dma_unconfigure(struct thc_device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(thc_dma_unconfigure, "INTEL_THC");
 
+/**
+ * thc_rxdma_reset - Reset all read DMA engines
+ *
+ * @dev: The pointer of THC private device context
+ *
+ * This is a helper function to reset RxDMA configure. It's typically used
+ * for RxDMA recovery when fatal error happens.
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
+		dev_err_once(dev->dev, "Quiesce interrupt failed during RxDMA reset\n");
+		goto end;
+	}
+
+	thc_dma_unconfigure(dev);
+
+	ret = thc_dma_configure(dev);
+	if (ret) {
+		dev_err_once(dev->dev, "Re-config DMA failed during RxDMA reset\n");
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
 static int thc_wait_for_dma_pause(struct thc_device *dev, enum thc_dma_channel channel)
 {
 	u32 ctrl_reg, sts_reg, sts;
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

