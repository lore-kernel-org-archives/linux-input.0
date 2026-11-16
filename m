Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817641;
	b=wEjmlTkME/8olmlCaRT5PMhOb5hymiPbGIJakCHwzcSpCfPxp0opYUM63n2pDrlVDKsA
	 acmrOlhRAwxkFtqUHPdzno8TFp1oTTfzp5T8MPHwhlcATcToIQM+yEuf/VQHkTm8iUiUT
	 i9d7mxQTpJqRhH6hQDvdnXI75dcAiMid8uFk9+L/BFk9OHem+GlumoUC4TPCFRi80XO8E
	 7rG1tfOuL5z0z7k/sQEWOQpVcYQg80f9O7GU5Z0LSHm2FW/OkBJa8uGpSP5qRmJh95o8X
	 Y/a17Sbdlh2toEkf2dgptM1I+wxQHJL5xn1Yf5yp/DyZrjblxhtrjUt9ztVT4fDxDEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817641;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GFw3U8Bd+OtR5vH4CllQ/QamxV5duSdgL+vSBRZ0ODA=;
	b=ziFMwN925OepaBnk5+KclEL16vhVFOT4H9KVs910Ls2P2Y2rQeboukYll9taIevT/rit
	 OAnxBtJnaWYyGkTfpk+5968Zh4KedrXdcW+GIh1phyORXuLGkay3I9bv4NRn3q8FzhiyZ
	 8m2eeYDvSeMH6AVwCpm2NgER9gsbUsz6J5FSo3+k/Z2AwAnqjCkrCfdYXLt2a7gcfrnio
	 TsAmFP2rUqrgElwez3L1i6fcMxAA4pPO+1v++fXScfcIZXeJIsJoLCIgUblAtuzdH/ib9
	 G72w9Py0H+Tl+KE83LlW2f25hyB18rwBuB3FTFfaIFU8s1kzGcn2qZxAVfF+IdRlLfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lfGyu7rr;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8706606A330;
	Mon, 16 Nov 2026 08:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8706606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lfGyu7rr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794817641; x=1826353641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GwTMfIZWZG9Cg3O2oJKoSVHTCiKHDa0jwqgpIdtjfSI=;
  b=lfGyu7rrwZn6euSU2yEDuWbeC95zteAoqw8ih+9Tp9pBXTPBN/zZoUfw
   54sJ9bqtJsDBQEtBxn8rrbqMXNAq2LmoWlJouyOIUR1tVJOMev8FEMNwt
   hrniLCey1L348fhyXMrgwZj5sUMMlJ6tc/7ftR8GMGmA4S3wuq4skFTAJ
   gTqVPs6nuztSrUOsfRfzH9L4XmW6vSaSSjwSXETTH9pAmAdVRzgSq8A2h
   khUyhx15XT8vNYX317AtRdilfOgmGmbGnb/HMWl7JVGsGJDoFWyt9MNKN
   c9xadP2JvzySkoEVeNWEY4uhVtgyRS1v9dad/axfci8S6jwJggXsxMsN1
   Q==;
X-CSE-ConnectionGUID: BzhgAW0uRpu3/EDAnsT6TA==
X-CSE-MsgGUID: AidSt+0dRMK8TTR9/8YghA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3436341"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3436341"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 00:27:19 -0800
X-CSE-ConnectionGUID: ARE+CHOCRi+4gIoyVWDaTA==
X-CSE-MsgGUID: rxk2iqpYSzaH8pdN91ABuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9293464"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by orviesa008.jf.intel.com with ESMTP; 16 Nov 2026 00:27:17 -0800
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>
Subject: [PATCH 1/4] HID: Intel-thc-hid: Intel-thc: Add safe DMA read interfaces
Date: Mon, 16 Nov 2026 16:27:57 +0800
Message-ID: <20261116082805.3986615-2-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116082805.3986615-1-even.xu@intel.com>
References: <20261116082805.3986615-1-even.xu@intel.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

THC DMA buffers are rounded up to a 4 KB boundary, but callers may
allocate smaller receive buffers. Checking a frame against the DMA
capacity alone does not protect the destination when do DMA buffer
copying.

Add thc_rxdma_read_safe() and thc_swdma_read_safe() with an explicit
destination capacity to check both the DMA capacity and the supplied
size before copying.

Keep the original interfaces as compatibility wrappers.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 95 ++++++++++++++++---
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  6 ++
 2 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index c80ef8c20574..11d29c8daebe 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -614,7 +614,7 @@ EXPORT_SYMBOL_NS_GPL(thc_rxdma_reset, "INTEL_THC");
 
 static int read_dma_buffer(struct thc_device *dev,
 			   struct thc_dma_configuration *read_config,
-			   u8 prd_table_index, void *read_buff)
+			   u8 prd_table_index, void *read_buff, size_t read_buff_len)
 {
 	struct thc_prd_table *prd_tbl;
 	struct scatterlist *sg;
@@ -640,6 +640,13 @@ static int read_dma_buffer(struct thc_device *dev,
 		return -EMSGSIZE;
 	}
 
+	if (mes_len > read_buff_len) {
+		dev_err(dev->dev,
+			"Message length %zu is bigger than destination buffer length %zu\n",
+			mes_len, read_buff_len);
+		return -EMSGSIZE;
+	}
+
 	sg = read_config->sgls[prd_table_index];
 	ret = sg_copy_to_buffer(sg, nent, read_buff, mes_len);
 	if (ret != mes_len) {
@@ -680,21 +687,26 @@ static int is_dma_buf_empty(struct thc_device *dev,
 
 static int thc_dma_read(struct thc_device *dev,
 			struct thc_dma_configuration *read_config,
-			void *read_buff, size_t *read_len, int *read_finished)
+			void *read_buff, size_t read_buff_len,
+			size_t *read_len, int *read_finished)
 {
 	u8 read_ptr, write_ptr, prd_table_index;
-	int status;
+	int status = 0;
+
+	*read_len = 0;
 
 	if (!is_dma_buf_empty(dev, read_config, &read_ptr, &write_ptr)) {
 		prd_table_index = write_ptr & THC_POINTER_MASK;
 
-		status = read_dma_buffer(dev, read_config, prd_table_index, read_buff);
-		if (status <= 0) {
+		status = read_dma_buffer(dev, read_config, prd_table_index,
+					 read_buff, read_buff_len);
+		if (status <= 0 && status != -EMSGSIZE) {
 			dev_err_once(dev->dev, "read DMA buffer failed %d\n", status);
 			return -EIO;
 		}
 
-		*read_len = status;
+		if (status > 0)
+			*read_len = status;
 
 		/* Clear the relevant PRD table */
 		thc_copy_one_sgl_to_prd(dev, read_config, prd_table_index);
@@ -711,22 +723,27 @@ static int thc_dma_read(struct thc_device *dev,
 	if (read_finished)
 		*read_finished = is_dma_buf_empty(dev, read_config, &read_ptr, &write_ptr) ? 1 : 0;
 
-	return 0;
+	return status < 0 ? status : 0;
 }
 
 /**
- * thc_rxdma_read - Read data from RXDMA buffer
+ * thc_rxdma_read_safe - Read data from RXDMA buffer with a destination size limit
  *
  * @dev: The pointer of THC private device context
  * @dma_channel: The RXDMA engine of read data source
  * @read_buff: The pointer of the read data buffer
+ * @read_buff_len: The allocated size of the read data buffer in bytes
  * @read_len: The pointer of the read data length
  * @read_finished: The pointer of the flag indicating if all pending data has been read out
  *
+ * Oversized frames are discarded and their PRD table is recycled without
+ * copying data. In this case, @read_len is zero and @read_finished is updated.
+ *
  * Return: 0 on success, other error codes on failed.
  */
-int thc_rxdma_read(struct thc_device *dev, enum thc_dma_channel dma_channel,
-		   void *read_buff, size_t *read_len, int *read_finished)
+int thc_rxdma_read_safe(struct thc_device *dev, enum thc_dma_channel dma_channel,
+			void *read_buff, size_t read_buff_len,
+			size_t *read_len, int *read_finished)
 {
 	struct thc_dma_configuration *dma_config;
 	int ret;
@@ -749,10 +766,31 @@ int thc_rxdma_read(struct thc_device *dev, enum thc_dma_channel dma_channel,
 		return -EINVAL;
 	}
 
-	ret = thc_dma_read(dev, dma_config, read_buff, read_len, read_finished);
+	ret = thc_dma_read(dev, dma_config, read_buff, read_buff_len, read_len, read_finished);
 
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(thc_rxdma_read_safe, "INTEL_THC");
+
+/**
+ * thc_rxdma_read - Read data from RXDMA buffer
+ *
+ * @dev: The pointer of THC private device context
+ * @dma_channel: The RXDMA engine of read data source
+ * @read_buff: The pointer of the read data buffer
+ * @read_len: The pointer of the read data length
+ * @read_finished: The pointer of the flag indicating if all pending data has been read out
+ *
+ * Legacy callers do not provide a destination capacity.
+ *
+ * Return: 0 on success, other error codes on failed.
+ */
+int thc_rxdma_read(struct thc_device *dev, enum thc_dma_channel dma_channel,
+		   void *read_buff, size_t *read_len, int *read_finished)
+{
+	return thc_rxdma_read_safe(dev, dma_channel, read_buff, SIZE_MAX,
+				   read_len, read_finished);
+}
 EXPORT_SYMBOL_NS_GPL(thc_rxdma_read, "INTEL_THC");
 
 static int thc_swdma_read_start(struct thc_device *dev, void *write_buff,
@@ -862,19 +900,23 @@ static int thc_swdma_read_completion(struct thc_device *dev)
 }
 
 /**
- * thc_swdma_read - Use software DMA to read data from touch device
+ * thc_swdma_read_safe - Read touch device data with a destination size limit
  *
  * @dev: The pointer of THC private device context
  * @write_buff: The pointer of write buffer for SWDMA sequence
  * @write_len: The write data length for SWDMA sequence
  * @prd_tbl_len: The prd table length of SWDMA engine, can be set to NULL
  * @read_buff: The pointer of the read data buffer
+ * @read_buff_len: The allocated size of the read data buffer in bytes
  * @read_len: The pointer of the read data length
  *
+ * Oversized frames are discarded without copying data and @read_len is zero.
+ *
  * Return: 0 on success, other error codes on failed.
  */
-int thc_swdma_read(struct thc_device *dev, void *write_buff, size_t write_len,
-		   u32 *prd_tbl_len, void *read_buff, size_t *read_len)
+int thc_swdma_read_safe(struct thc_device *dev, void *write_buff, size_t write_len,
+			u32 *prd_tbl_len, void *read_buff, size_t read_buff_len,
+			size_t *read_len)
 {
 	int ret;
 
@@ -905,7 +947,8 @@ int thc_swdma_read(struct thc_device *dev, void *write_buff, size_t write_len,
 		goto end;
 	}
 
-	ret = thc_dma_read(dev, &dev->dma_ctx->dma_config[THC_SWDMA], read_buff, read_len, NULL);
+	ret = thc_dma_read(dev, &dev->dma_ctx->dma_config[THC_SWDMA],
+			   read_buff, read_buff_len, read_len, NULL);
 	if (ret)
 		goto end;
 
@@ -915,6 +958,28 @@ int thc_swdma_read(struct thc_device *dev, void *write_buff, size_t write_len,
 	mutex_unlock(&dev->thc_bus_lock);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(thc_swdma_read_safe, "INTEL_THC");
+
+/**
+ * thc_swdma_read - Use software DMA to read data from touch device
+ *
+ * @dev: The pointer of THC private device context
+ * @write_buff: The pointer of write buffer for SWDMA sequence
+ * @write_len: The write data length for SWDMA sequence
+ * @prd_tbl_len: The prd table length of SWDMA engine, can be set to NULL
+ * @read_buff: The pointer of the read data buffer
+ * @read_len: The pointer of the read data length
+ *
+ * Legacy callers do not provide a destination capacity.
+ *
+ * Return: 0 on success, other error codes on failed.
+ */
+int thc_swdma_read(struct thc_device *dev, void *write_buff, size_t write_len,
+		   u32 *prd_tbl_len, void *read_buff, size_t *read_len)
+{
+	return thc_swdma_read_safe(dev, write_buff, write_len, prd_tbl_len,
+				   read_buff, SIZE_MAX, read_len);
+}
 EXPORT_SYMBOL_NS_GPL(thc_swdma_read, "INTEL_THC");
 
 static int write_dma_buffer(struct thc_device *dev,
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index 715423453a9d..f6152b4209f7 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
@@ -150,6 +150,12 @@ int  thc_rxdma_read(struct thc_device *dev, enum thc_dma_channel dma_channel,
 		    void *read_buff, size_t *read_len, int *read_finished);
 int  thc_swdma_read(struct thc_device *dev, void *write_buff, size_t write_len,
 		    u32 *prd_tbl_len, void *read_buff, size_t *read_len);
+int  thc_rxdma_read_safe(struct thc_device *dev, enum thc_dma_channel dma_channel,
+			 void *read_buff, size_t read_buff_len,
+			 size_t *read_len, int *read_finished);
+int  thc_swdma_read_safe(struct thc_device *dev, void *write_buff, size_t write_len,
+			 u32 *prd_tbl_len, void *read_buff, size_t read_buff_len,
+			 size_t *read_len);
 int  thc_dma_write(struct thc_device *dev, void *buffer, size_t buf_len);
 
 struct thc_dma_context *thc_dma_init(struct thc_device *dev);
-- 
2.43.0

