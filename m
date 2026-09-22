Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769321C2324;
	Tue, 22 Sep 2026 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045197; cv=none; b=e4D2FCDZy+ZELC0EzBba3hTsWplmHO8z2HkFS0uMmRurTbfs66tlSgJS/CKtGgocjNWlKM77P6GQVhZtxtwlL2EqZV69fFKSiAsjBtDXtfBh0pxpExsUZ87ik5GUubhnvYtlj1YKVJjrdQOO05g5SV/GXUY++HBCxbqN/s4Fndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045197; c=relaxed/simple;
	bh=HBSMBVrH87G5BIwDIbS3yFOy1uX5Q5p4l8S2WvWO7Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hplKi0dyrlBCLyad7OF/xEwF+M8giZLx8lluYXBbfjgWHmAzulox7FURB+bW57SMbO8L+lXXAEOPnJpbkeAw2KIwl2wBrcKpDDUcAOBzfX4amwZwYoMCNPoEKoY678yRBjWtNx7q8TIjrxhpDfw6sjI8nRcgKHBtBNLmVvIw0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCKP6JIp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCKP6JIp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790045195; x=1821581195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HBSMBVrH87G5BIwDIbS3yFOy1uX5Q5p4l8S2WvWO7Eg=;
  b=mCKP6JIpw/lUlrTTbY+oDCm1Rrm5PRo8acJBbL8RZlLUEuAAxEFZkebB
   o6Z0zp0rz0ZCVSLP0SVxOO29h28CdJyzAHxyTTPM5oQ1cZYk3VdEutIue
   56GbQTGUfEpXgqcFzvSfe56pMxNQM0tRN2i0UxrvYGtrc3euTanLH5gHo
   688EnCzMB9Rkegsr47BUji07Z/xiZTjx+UiyKz44IgfmZ/LFCNxDmMVCN
   IIENi+cx0815JNBovhQ0hpM6BeNvLqIKN44ITVhnHE6eIU0+IIYinZqQ4
   5YiZu/hcqWeycwHOysRrKU9G6ptqj8zQVvRM0VZsP/hUdlQeUhOqHqZqs
   Q==;
X-CSE-ConnectionGUID: CmcMT6OxS9qeLwFXMEJdLg==
X-CSE-MsgGUID: ZuN7aOtGTR+NxiTu1bTdSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90476380"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90476380"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:46:35 -0700
X-CSE-ConnectionGUID: iyzdWSYHQ+a68BcaG83gKA==
X-CSE-MsgGUID: 2+sDQoC7SNGqRmI6FYYXkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272123812"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 19:46:33 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 1/2] HID: Intel-thc-hid: Intel-quicki2c: Fix buffer overflow
Date: Tue, 22 Sep 2026 10:46:37 +0800
Message-ID: <20260922024638.932865-2-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922024638.932865-1-even.xu@intel.com>
References: <20260922024638.932865-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The input and output buffers are used to store complete HID-over-I2C
packets, including their protocol headers. However, their sizes are
currently calculated from the payload length only.

Allocate enough space for both the payload and the packet header to
prevent a buffer overflow when the payload reaches its maximum size.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 0d2ad7bc3648..2537288b5026 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -606,7 +606,8 @@ static int quicki2c_alloc_report_buf(struct quicki2c_device *qcdev)
 	 */
 	max_report_len = max(le16_to_cpu(qcdev->dev_desc.max_input_len), SZ_4K);
 
-	qcdev->input_buf = devm_kzalloc(qcdev->dev, max_report_len, GFP_KERNEL);
+	qcdev->input_buf = devm_kzalloc(qcdev->dev,
+					HIDI2C_PACKET_LEN(max_report_len), GFP_KERNEL);
 	if (!qcdev->input_buf)
 		return -ENOMEM;
 
@@ -616,7 +617,8 @@ static int quicki2c_alloc_report_buf(struct quicki2c_device *qcdev)
 	max_report_len = max(le16_to_cpu(qcdev->dev_desc.max_output_len),
 			     max_report_len);
 
-	qcdev->report_buf = devm_kzalloc(qcdev->dev, max_report_len, GFP_KERNEL);
+	qcdev->report_buf = devm_kzalloc(qcdev->dev,
+					 HIDI2C_PACKET_LEN(max_report_len), GFP_KERNEL);
 	if (!qcdev->report_buf)
 		return -ENOMEM;
 
-- 
2.43.0

