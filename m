Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CA2D5C68;
	Fri,  3 Jul 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065512; cv=none; b=FRos+R9rhs5wdDqKSKxWz5PpsJ0bpKOJKqOTtLVbbLV15tS6jt/gudmcouQYlSjYf35Of7e57HjL02D+LJ16wh2BekK01TC0Y3xLOpQyVHdqI2Drx+hdAuL/hlOMtCOqWENvfrxTL7pz7d6M9/XGrIAZZuENyzA951lKjZOb12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065512; c=relaxed/simple;
	bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmMpZqbvSyfkd79eLqq+vUkjbEeIjkLrSNR9JYTQr9tDWXcR8cxgh51h9yWBx8LwndQk+KIZA6b2fhrhR89oW8lotv5EF1CLpkDGTW8GnVICiGbAUbuujRR6DPwFZRgwXTvMVLIg2YKPlXi/wdMI0jivc0fKsQgydA9zx3V6Lpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFHcS/KQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFHcS/KQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783065511; x=1814601511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX5vbVH5k+ZNjlDmhVGDDrAmZC4b0h2BMEuA3PVPYc8=;
  b=mFHcS/KQhM2742XPbMKTN7kQGAfLdJSxeur95i/rewWWSNBQiFL7UNJL
   SYt9H/FtoGrXBcubFjY9X+hlqFmL0ZeXVngq5o1SqErMkNXCv6Laetmqr
   AVtxncL5k5CrPLuHtGfeRhvss1cKCAChZNz9XfjOXLxpWBTckTGhGVZcM
   JSYaMD5B62Ar5Ez6/4j9YQ2TFwKRNnBNQi027YsTz/eBO7jg5zvAl1Y7x
   OUqniiVRGWHXLpmFYKuLNBflxukW5TI0qmvYWN1wcwASXrBep9V5LBf2G
   Lvtmc7TIjfFYQiCPioDV1a+GpxvEd3YB+PJ11tZxhzZqdHz9XOiE4R8VB
   g==;
X-CSE-ConnectionGUID: b+daeh2YQbuwsB486iCClw==
X-CSE-MsgGUID: TSb/BFK7SMi57SwkYHt5AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83682797"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83682797"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 00:58:31 -0700
X-CSE-ConnectionGUID: ZdZ8i+USRACSgdllWbuuCg==
X-CSE-MsgGUID: ZNcPfVBHRoeAK8eQF9NLMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="257946021"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa005.fm.intel.com with ESMTP; 03 Jul 2026 00:58:29 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v2 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA
Date: Fri,  3 Jul 2026 15:58:56 +0800
Message-ID: <20260703075858.2780398-2-even.xu@intel.com>
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

