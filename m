Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47048217F33;
	Mon, 13 Jul 2026 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911827; cv=none; b=mT8Xgh2YI4YJUN8ls1WqWaUkSmj23bg4htyjWxjFFOXlKNWFgeBfm60762VFzyiYY7BwRLs6wDPKIZaGeZskksjkB5n4J/UxfhMr3AlOeG3XWIvrzTsq3owr4683rcLP9CnvD/kscz1rFLADVxWuefnD5Pc7ieYrbWOGYvIHxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911827; c=relaxed/simple;
	bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhvJQgezecRUdGZDCuMWlRQciuSryeWxblUsyv49e9OjgZ2ZkiJlebH2RSrnbS4+acUV7Vt5NZ6qxeCi/sw83F2rxPZY9wkZe8JkaJWegpCFLxrDXJzpx3gKeECJLreqWg3WAzcTF95DMC78B9smVp10GK9YP+nRZRFaXNAt7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENelD9St; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENelD9St"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783911825; x=1815447825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
  b=ENelD9Sthiw0t3wQ26Y8d3kdIdvoN9WNLRK67GALRd8KCOAjyx2C/UUu
   N9DntFfccAe9yg3gS1hFon+sYJUbAtyCDAvxXQ2paNpJ9qWGO42zpWWNP
   pPRQvcyVs9TyascvtEGtv6PTTAc5wqZ08Hv+6272ol+3+TvbJAKAcczqA
   GaNm6kdEXj5/Wfwu6ID7kiyCqlR9aq/+dBAVodrM9xVHJ1SBGoROFjfaq
   7INvALD/YzKmFskxDtqOwORKU4j/2sz9ZDPQ9GddcQNPlQms0t0fPeS8i
   9aOL939RCmiQa96R4yJG7ZjHUyK0sadukCcdGabIMnjPAdbxVkXoQXYB4
   Q==;
X-CSE-ConnectionGUID: hBQ4VMPNT3yUpBJPBTTIhA==
X-CSE-MsgGUID: LMaSougxRvmetsjQ/On1Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87060313"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87060313"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 20:03:44 -0700
X-CSE-ConnectionGUID: XMTnmTU4Sku/sMlyZQQZjA==
X-CSE-MsgGUID: 2dgLfHyVTRuO7zMuj59ehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255499271"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2026 20:03:43 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v3 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA
Date: Mon, 13 Jul 2026 11:04:10 +0800
Message-ID: <20260713030412.2531933-2-even.xu@intel.com>
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

