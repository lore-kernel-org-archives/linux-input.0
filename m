Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817681;
	b=B8KAJI/lGn3yUGmQUtUEM1KjvcQ7ixyvGUXOmnQsjnTshuunPabGCqUPPngFCYBNNzJM
	 oW3N3POgZ71dviDaEpqNikPc5j/AcQB11TUZF5EQTc94R47+bpdl1Fs9OspX3wAbEq2ak
	 sKakKtTYLe1zFG7UJG6+6LiMkYYCjVm+ATmcIfw1qJH/1rp1hkrxFp/ELXoB4UZlSkquj
	 IPlAaeUBF40dyQzNd0Ypl3ur3ldezdxnrmgjMq5bwemTMRmd6zm4mnAaU/jPm2uYlqbIK
	 HMP3MZ/4pTydIxAjUpL1464X6cjQHd1av3jc9sw0N8uqkuyKGlR81hPoRv7xu8VqyDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817681;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yjkL79qbgx1RcVh92Ok4UeomTYQI487EiTDK3+DMMiA=;
	b=SBwEQGvLKU6w1XARNV+oxzyanU4D5YyGyRxdGNeolAJ6ZN8cUyG5BPz/vfQfwFVZAUeg
	 8yHf/uQjAmNFhGfEv7kq7YaIAm9nzA/QfPiTe2oP3I3eoj0sID6V3wJaMNbXo/544Fkvx
	 8iCFOu372RNh8nS91xrbuj0+QJZPgbsVOy0ccA9UNGwcKBX+jsaZTI1oy+s2DtdZIpQEU
	 5+H5k1VMR65s1S/WM9DoZmDewAB7447Dhf8FvGM4X0yopKWVOQZDDXeTrrXswnTCajoP2
	 csi76cqUCAIBUYmSzN27/hw9jAYIbwZs/LrsOiWzgOhYYS9R5wxkw0r91aOcEn6RgNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PTvDIZAb;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C35606A323;
	Mon, 16 Nov 2026 08:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C35606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PTvDIZAb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794817681; x=1826353681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4sIZXJzXOMqGBwQlmS3gd/5uz+7dGEuRXqX4orYgfWQ=;
  b=PTvDIZAb2MrF7R6pvzX4kOWAYpdBf5LcFV672TjCNZQym/o6zbAOUJi/
   lv3qxN5AmVLiIaOflRezGItRJHH2X9olKKaXGeyanE68Eic0N1XH0+5Dj
   8wCNUzxEajiTh2v8qQC/DCksYbVIy6mqbqmsu/pn0FXppdDmORJp3WH00
   3M/bR63d14fBCVfj8VbOMHTqq/fd+2lOd8uoOud5Zdgsr9ImTOMNcFdPk
   aD82mEHVwe2woxhCCjeeQiThYdKzvZtlBsbtonI91uVKY+NjdcQEVa//R
   7lKlMPqJB+Iex37T1zrgH9Cf2Rm36QZDWXclRr7npVOFa3Kghfsa39+Sw
   g==;
X-CSE-ConnectionGUID: U1xO60PLR56iPhlGH8HTkw==
X-CSE-MsgGUID: Y1MWGPPGRbmRM7OTwn7l6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3436443"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3436443"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 00:28:00 -0800
X-CSE-ConnectionGUID: B4Oz/kbySsOWupWng78nXg==
X-CSE-MsgGUID: kyBWsgbEQ0u/3xN2mxxZOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9293568"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by orviesa008.jf.intel.com with ESMTP; 16 Nov 2026 00:27:57 -0800
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>
Subject: [PATCH 4/4] HID: Intel-thc-hid: Intel-thc: Restore RXDMA after SWDMA operation errors
Date: Mon, 16 Nov 2026 16:28:00 +0800
Message-ID: <20261116082805.3986615-5-even.xu@intel.com>
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

thc_swdma_read_start() quiesces device interrupts, stops RXDMA and
temporarily disables the I2C special controls. If reading the response
of a completed SWDMA transfer fails, thc_swdma_read_safe() skips
thc_swdma_read_completion(), leaving RXDMA stopped and the saved I2C
controls unrestored. Normal input processing can no longer resume.

Call thc_swdma_read_completion() even when reading the completed
response fails, so RXDMA and the saved I2C controls can be restored.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index 11d29c8daebe..7f9c9017049c 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -911,6 +911,7 @@ static int thc_swdma_read_completion(struct thc_device *dev)
  * @read_len: The pointer of the read data length
  *
  * Oversized frames are discarded without copying data and @read_len is zero.
+ * The completed transaction is restored before returning the read error.
  *
  * Return: 0 on success, other error codes on failed.
  */
@@ -949,12 +950,11 @@ int thc_swdma_read_safe(struct thc_device *dev, void *write_buff, size_t write_l
 
 	ret = thc_dma_read(dev, &dev->dma_ctx->dma_config[THC_SWDMA],
 			   read_buff, read_buff_len, read_len, NULL);
-	if (ret)
-		goto end;
-
-	ret = thc_swdma_read_completion(dev);
 
 end:
+	if (thc_swdma_read_completion(dev))
+		dev_err(dev->dev, "Failed to restore DMA after SWDMA read\n");
+
 	mutex_unlock(&dev->thc_bus_lock);
 	return ret;
 }
-- 
2.43.0

