Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A883403E8;
	Tue, 22 Sep 2026 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045689; cv=none; b=L28B4zvCZJHqtqu9MK6Fys/URhrOji9VGXxCzgqTVJYN5ZsmDAQYhL/P7rd2wQVbBbEuDrK5VSNGO/2IuYSqSvUsVHZmqRPrrd1bmWz+N7/D7Xutv5Ml0M4samaJ/FmlPqZ4lry82c5J69mQB6O4PbS9a+5rsSv6BD6aESGWXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045689; c=relaxed/simple;
	bh=2yQ8NZ4heVV0YfOIgkc1jYBNEqaxq6uo4GTxNXlVmKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhZJhOOqLFhSy7OVaXWLrVV/VnLTCtF5dlvsXLpG6EgA6u/nBnd9dDMobXU+24VaRnT6+2vCTj1Svft9cd6oWpNXS556E9/oLHcXdHrFADupKzSDXEVBYRQaF/BBs18vhNBFPtsJ7PND94fyCPUGJd8Wa2bdkbgK0XfNaXM7mZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTd+b4JY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTd+b4JY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790045673; x=1821581673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2yQ8NZ4heVV0YfOIgkc1jYBNEqaxq6uo4GTxNXlVmKA=;
  b=WTd+b4JY1pGAskpxy+luqY+71CNoXVIjz5Bhwm7p+XCZnVj/crBvRlVW
   cZbVGVqpYWmBjRlXAukPCdLelTt6821pvG73Sz3jJDyIu9Ib1zAyAImbF
   2AP4OLq2+mEYxSBCujeUhnKvQdXr93crIvAz/9r9FUMC1OCbjS/BFWXeo
   6rHtpbeb2+DKJaa15oLQBjkhznswZEfw2DUFYFz/GH/OZBlKHh5PeXXw+
   qf+hJtdGT/uNMJ1X4NadszODvtLLqUenw6YCs/zuqpHa2W0K5pqPD50Ve
   NZXWx9JZjNaCcEOWGo6XrU47P6t83JgU4Otmxw1uIkNbjlIm3H38rEUvn
   A==;
X-CSE-ConnectionGUID: 7xSYHyeYRnqhIVtEUWtsDQ==
X-CSE-MsgGUID: CYy89dx5Q+ygNVdu82HGig==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93114171"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="93114171"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:54:32 -0700
X-CSE-ConnectionGUID: pEAIFUxlSaCnFcrEzbAn9Q==
X-CSE-MsgGUID: 61YjMDMlRcC/quQh++/kNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280995808"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by fmviesa005.fm.intel.com with ESMTP; 21 Sep 2026 19:54:30 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 2/2] HID: Intel-thc-hid: Intel-quickspi: Use hid_safe_input_report()
Date: Tue, 22 Sep 2026 10:54:37 +0800
Message-ID: <20260922025437.940072-3-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922025437.940072-1-even.xu@intel.com>
References: <20260922025437.940072-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated hid_input_report() with
hid_safe_input_report(), which takes the allocated size of the input
report buffer and allows hid-core to validate the reported data length
against the actual buffer size.

Track the allocated size of qsdev->input_buf in the new input_len
field and pass it through quickspi_hid_send_report() to
hid_safe_input_report() to prevent potential out-of-bounds reads.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c     | 2 ++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h     | 2 ++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c     | 6 ++++--
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h     | 2 +-
 .../hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c    | 2 +-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index ad676fde211b..53023e30cf8d 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -557,6 +557,8 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 	if (!qsdev->input_buf)
 		return -ENOMEM;
 
+	qsdev->input_len = max_input_len;
+
 	max_report_len = max(le16_to_cpu(qsdev->dev_desc.max_output_len),
 			     le16_to_cpu(qsdev->dev_desc.max_input_len));
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index dc67a39ad546..fe51ff51d8c0 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -113,6 +113,7 @@ struct acpi_device;
  * @low_power_ltr_val: THC low power LTR value
  * @report_descriptor: store a copy of device report descriptor
  * @input_buf: store a copy of latest input report data
+ * @input_len: the data size of the input report buffer
  * @report_buf: store a copy of latest input/output report packet from set/get feature
  * @report_len: the length of input/output report packet
  * @reset_ack_wq: workqueue for waiting reset response from device
@@ -159,6 +160,7 @@ struct quickspi_device {
 
 	u8 *report_descriptor;
 	u8 *input_buf;
+	u32 input_len;
 	u8 *report_buf;
 	u32 report_buf_size;
 	u32 report_len;
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
index a60a0a7f16aa..ed1c40b8c4fa 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
@@ -148,16 +148,18 @@ void quickspi_hid_remove(struct quickspi_device *qsdev)
  *
  * @qsdev: point to quickspi device
  * @data: point to input report data buffer
+ * @buf_size: the allocated size of the input report data buffer
  * @data_len: the length of input report data
  *
  * Return: 0 on success, non zero on error.
  */
 int quickspi_hid_send_report(struct quickspi_device *qsdev,
-			     void *data, size_t data_len)
+			     void *data, size_t buf_size, size_t data_len)
 {
 	int ret;
 
-	ret = hid_input_report(qsdev->hid_dev, HID_INPUT_REPORT, data, data_len, 1);
+	ret = hid_safe_input_report(qsdev->hid_dev, HID_INPUT_REPORT, data,
+				    buf_size, data_len, 1);
 	if (ret)
 		dev_err(qsdev->dev, "Failed to send HID input report, ret = %d.\n", ret);
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h
index f640fa876a40..61b7c6be6c51 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h
@@ -7,7 +7,7 @@
 struct quickspi_device;
 
 int quickspi_hid_send_report(struct quickspi_device *qsdev,
-			     void *data, size_t data_size);
+			     void *data, size_t buf_size, size_t data_size);
 int quickspi_hid_probe(struct quickspi_device *qsdev);
 void quickspi_hid_remove(struct quickspi_device *qsdev);
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index 847c5ec55569..0df33c44fbff 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -240,7 +240,7 @@ void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len)
 		input_len = sizeof(body_hdr->content_id) + input_len;
 		input_report = input_body->content - sizeof(body_hdr->content_id);
 
-		ret = quickspi_hid_send_report(qsdev, input_report, input_len);
+		ret = quickspi_hid_send_report(qsdev, input_report, qsdev->input_len, input_len);
 		if (ret)
 			dev_err_once(qsdev->dev, "Failed to send HID input report: %d\n", ret);
 
-- 
2.43.0

