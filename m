Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817663;
	b=E59Hw4AEFs/qQRAaYbkqc28JTZjtUOICGufYynIvk4OCWGLSBXjrTvo9D2XfZQU4yFYR
	 lGzWvSFT820wxO+JRjl0GqAm2dOqlNtG1vvZnmbQgnzS46bW660qdlwJLMuJ/NIIseT+g
	 uHzkprZhzxDkU15w9F0Z6iNoLzIUDRGowxECK1w//dIE7FBV1neY4z595Vgoagw/fW8SC
	 itZ20Js09/b1z9ueCa7q/L5z4L+A77L1B52f4MyesFq46ifT0MpTsSen0GZwFktphDHm5
	 Hbg9S4UPhQGaEz8HlXkE3lAfR9WcxMScQHSl6VmlKkL0QJIUpez/PAbbbvaIUL1eLpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817663;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hd2Csajs6QatLjzeHDvmKsZYjSymBjV2lsfaQ+GJTao=;
	b=ghcIuTrrVOq+AF0BWXjqti5bQ+BU3KnagbiTNpcJBnNYC3i/VY6CmDC95miKkwfGfqIA
	 HAXd+GOH8qKFZDRlgj9LqJsOdTKYYMExFkHnZ8/Yme997LIZ3dCxzM5FJvrN3D9QihLi6
	 HR5kxnKL36LkDJ2wwXuwPvWAL3PkLZlsVy08Bis2XnmNo5luYdmBjfkah7UPi+dfzcmzh
	 lruUFYboye5zYLcT+Vfq3ltHyFjcvkvJahQm5tNqZT5hynkeLdjt6M+NT/zqfp7/6xrNA
	 wk9bR6vMpCqkZ9vppNsy29Nkl/Ymh6nuEKOye06D0+9T5+oOU4ECXoss9vOIg3+iMUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZggPQoTr;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA8606A336;
	Mon, 16 Nov 2026 08:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51EA8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZggPQoTr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794817664; x=1826353664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gBVZ2VY2XYLOo6xK93Mzf1jW2dGoKpsCUqo6aSQIbs=;
  b=ZggPQoTr1KXHBb4dPsWA3tw4/LZEkecJ48jp+JXohvNPYyGZuoF82dmu
   51hiwUnYKJgwVQvgDawLlxuAFPGqNupVd0h+0/16bBLsbnqd/dMQFgWPu
   wH9HBnbCiEhItAAHPRwdHhC/SbKxjJlQ8Q+RcqpiOU42/1U7grMwjyUrX
   PRPKPyXpRj8f6JOE7LnKI3UAvomkfOQDQASLCD5F70cTc82kFTrgjIBhn
   r2xkAVFl09iAaXgfToQqC9IrPV1bKIlLYTpmMpuDXXNYLufOoegbmfcLp
   9kh56X/byo97LPwgbZWDTlTXM2QbL+6cfPF88/y5o/nPEIux6n2bN9Skw
   g==;
X-CSE-ConnectionGUID: KVxJs7fcQF6LU2CzcCKlig==
X-CSE-MsgGUID: WxsVI5UcRFqocsCSxMJBhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3436372"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3436372"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 00:27:43 -0800
X-CSE-ConnectionGUID: 7RiNxRwIS+G2xDQaGk9m+w==
X-CSE-MsgGUID: jqghDoisTnOHiP+rmjrYJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9293543"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by orviesa008.jf.intel.com with ESMTP; 16 Nov 2026 00:27:41 -0800
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>
Subject: [PATCH 3/4] HID: Intel-thc-hid: Intel-quicki2c: Use safe DMA reads
Date: Mon, 16 Nov 2026 16:27:59 +0800
Message-ID: <20261116082805.3986615-4-even.xu@intel.com>
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

Use thc_rxdma_read_safe() and thc_swdma_read_safe(). Pass
HIDI2C_PACKET_LEN(input_len) as the destination capacity for RXDMA input
reports and SWDMA GET_REPORT responses. Handle -EMSGSIZE in the receive
loop by continuing pending reports instead of scheduling full RXDMA
recovery.

Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC QuickI2C driver")
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c  | 9 ++++++---
 .../hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c | 7 ++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 29319b6227f3..f87f33f61d34 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -292,9 +292,12 @@ static int handle_input_report(struct quicki2c_device *qcdev)
 	int ret;
 
 	while (!rx_dma_finished) {
-		ret = thc_rxdma_read(qcdev->thc_hw, THC_RXDMA2,
-				     (u8 *)pkt, &report_len,
-				     &rx_dma_finished);
+		ret = thc_rxdma_read_safe(qcdev->thc_hw, THC_RXDMA2, (u8 *)pkt,
+					  HIDI2C_PACKET_LEN(qcdev->input_len), &report_len,
+					  &rx_dma_finished);
+		if (ret == -EMSGSIZE)
+			continue;
+
 		if (ret)
 			return ret;
 
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
index 41271301215a..aab17c4aaca8 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
@@ -122,8 +122,8 @@ int quicki2c_get_report_descriptor(struct quicki2c_device *qcdev)
 	size_t read_len = le16_to_cpu(qcdev->dev_desc.report_desc_len);
 	u32 prd_len = read_len;
 
-	return thc_swdma_read(qcdev->thc_hw, (u8 *)&desc_reg, HIDI2C_REG_LEN,
-			      &prd_len, qcdev->report_descriptor, &read_len);
+	return thc_swdma_read_safe(qcdev->thc_hw, (u8 *)&desc_reg, HIDI2C_REG_LEN,
+				   &prd_len, qcdev->report_descriptor, read_len, &read_len);
 }
 
 int quicki2c_get_report(struct quicki2c_device *qcdev, u8 report_type,
@@ -153,7 +153,8 @@ int quicki2c_get_report(struct quicki2c_device *qcdev, u8 report_type,
 
 	rpt = (struct hidi2c_report_packet *)qcdev->input_buf;
 
-	ret = thc_swdma_read(qcdev->thc_hw, qcdev->report_buf, len, NULL, rpt, &read_len);
+	ret = thc_swdma_read_safe(qcdev->thc_hw, qcdev->report_buf, len, NULL, rpt,
+				  HIDI2C_PACKET_LEN(qcdev->input_len), &read_len);
 	if (ret) {
 		dev_err_once(qcdev->dev, "Get report failed, ret %d, read len (%zu vs %zu)\n",
 			     ret, read_len, buf_len);
-- 
2.43.0

