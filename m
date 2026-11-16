Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817651;
	b=VJqkwdslRx1Rrx7x1tX9ZNsUBF99cx4DzRmQXDWNA17SpcOaHmPugBpZs74hx1kUF1I8
	 ghytZ1fDnr+xekfYuBKFb71K3Te6QzTV/YkTdpfYlS/HUFL2w7F4GL4NFoytGCFfutqrv
	 WfafjKuZoYS3YK6q4ZTllAtfKosY2+Iq0pcW9tJEbPYT/dHIsRV30fjLTaOqXVj3v6q3W
	 1PrZJzWdValVQGrZ7nFJBhqek6OiQYympk8e8kIAmGVjPDfj+jNm+t0TEyA3m1w3wWMZN
	 TxJ20gF5APlz/bNTFbOUa8axDG4Gl79OmpQOaQ0L4ln1HFdh8I6H3kF1EZ1AyMRoPRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817651;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=tJu9TQrkJE41m7xIuOZEib42pEfQDhSvJ0z1DNA7otM=;
	b=xS3AF5j2JvcMZFyMdHsRjzVGH/CKHBhxrHB4qAZpq9s+isDw+G0Y4fbjTxmb/t17z/36
	 x9Qh5tPNkqFWBHqD0RLfyMOrojKJtKmlQvNy08fjvwoSNXlIVDZjtmjeE4R/F54Y1KygG
	 I2Y8f1RrNAfyhz32pQTbXjWQwcR5ysPmknZr/UMh5ljwcRQ/qYyqftq37dykwjSpGBfa5
	 ANWoaJAT/E5nB2AuI/I0QlWp8KdS7pmT2xDxzYaFN96KwSiUe1fU31+4VYWMwFFJYCee2
	 wqN+fiyYsvbg7byJ5TGjvS+OC4/OxU4uV/0/WCxu+zhVCrGjbremLwb8wnhfhypZPmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=niPNp3pD;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4776F606A32A;
	Mon, 16 Nov 2026 08:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4776F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=niPNp3pD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794817652; x=1826353652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nr+deOJ7QI8Mb+35h7T4aAVV0Lifth98GQF/Gv5X//U=;
  b=niPNp3pD+9yXVE8iTITYhPplM2QRw91NgkKLvT0lnDsNwCfzUa+Z31RF
   wj1b9bq9Thd47JGOCV7BrzkxjciUZ5JNXnOp3Ww64R17cHqzKaSByU5aA
   Fuvfe5ioE0JnVb2tHLcuWov05klMsAjCsNrJ7ngba3SY2yXQklMaSicik
   mS2CyezEsKVyF1LWM5/ZatVjHr56OyJAisvDnq6qE41gMWMA4ijir/yo6
   gsYjc7m6t5RGZyrFI1MoK3r/iO2drN7sYU3Y2yz+nVkcDsMDVHIOM7zxy
   rjidwvbTTB8UZBlM5b7VCzJAqtgaP08YQbGaLJoPrXb03FYV9a6gWy4/p
   Q==;
X-CSE-ConnectionGUID: 3auv3wOORTSA0l3tof/xrg==
X-CSE-MsgGUID: rPbzSXaZSS+Tn5oFRM67eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3436351"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3436351"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 00:27:31 -0800
X-CSE-ConnectionGUID: zpWICxxkSnikJbvwderwgw==
X-CSE-MsgGUID: zZ9alPVIT/akL2i14WyvIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9293500"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by orviesa008.jf.intel.com with ESMTP; 16 Nov 2026 00:27:29 -0800
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>
Subject: [PATCH 2/4] HID: Intel-thc-hid: Intel-quickspi: Use safe RXDMA reads
Date: Mon, 16 Nov 2026 16:27:58 +0800
Message-ID: <20261116082805.3986615-3-even.xu@intel.com>
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
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Use thc_rxdma_read_safe() and pass the full input_buf allocation,
including the body header. Handle -EMSGSIZE in the receive loop by
skipping the discarded frame and continuing pending reports instead
of scheduling a full RXDMA recovery.

Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver")
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
---
 .../hid/intel-thc-hid/intel-quickspi/pci-quickspi.c  | 12 ++++++++----
 .../hid/intel-thc-hid/intel-quickspi/quickspi-dev.h  |  7 +++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index ec974d549a92..703ba238c02a 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -324,8 +324,12 @@ static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
 
 	if (int_mask & BIT(THC_RXDMA2_INT)) {
 		while (!read_finished) {
-			ret = thc_rxdma_read(qsdev->thc_hw, THC_RXDMA2, qsdev->input_buf,
-					     &input_len, &read_finished);
+			ret = thc_rxdma_read_safe(qsdev->thc_hw, THC_RXDMA2, qsdev->input_buf,
+						  HIDSPI_INPUT_BODY_SIZE(qsdev->input_len),
+						  &input_len, &read_finished);
+			if (ret == -EMSGSIZE)
+				continue;
+
 			if (ret) {
 				err_recover = 1;
 				goto end;
@@ -550,7 +554,7 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 		return -ENOMEM;
 
 	max_input_len = max(le16_to_cpu(qsdev->dev_desc.rep_desc_len),
-			    le16_to_cpu(qsdev->dev_desc.max_input_len));
+			    le16_to_cpu(qsdev->dev_desc.max_input_len)) + QUICKSPI_DMA_EXTRA_BYTE;
 
 	qsdev->input_buf = devm_kzalloc(qsdev->dev,
 					HIDSPI_INPUT_BODY_SIZE(max_input_len), GFP_KERNEL);
@@ -560,7 +564,7 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 	qsdev->input_len = max_input_len;
 
 	max_report_len = max(le16_to_cpu(qsdev->dev_desc.max_output_len),
-			     le16_to_cpu(qsdev->dev_desc.max_input_len));
+			     le16_to_cpu(qsdev->dev_desc.max_input_len)) + QUICKSPI_DMA_EXTRA_BYTE;
 
 	qsdev->report_buf = devm_kzalloc(qsdev->dev,
 					 HIDSPI_OUTPUT_REPORT_SIZE(max_report_len), GFP_KERNEL);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index 4362ac568bda..e8ddb504ccc7 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -54,6 +54,13 @@
 #define MAX_PACKET_SIZE_VALUE_MTL			128
 #define MAX_PACKET_SIZE_VALUE_LNL			256
 
+/*
+ * During HID-over-SPI transfers, THC DMA may also read bytes that aren’t
+ * part of the actual data, such as a placeholder byte used for timing
+ * control (8 clock cycles).
+ */
+#define QUICKSPI_DMA_EXTRA_BYTE				1
+
 /*
  * THC uses runtime auto suspend to dynamically switch between THC active LTR
  * and low power LTR to save CPU power.
-- 
2.43.0

