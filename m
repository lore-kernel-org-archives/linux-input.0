Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB33AE1A8;
	Tue, 22 Sep 2026 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045673; cv=none; b=q+5sXvsSEjjZQDjkLHqaDWaqiJt3H93AqOPV5+ff3F0FeT7rU3CjjRbhHbaw3TYxn7SvAovl/pKeFLrDcFR9S05hA38ivLzb3zFwFayxGBWvGKXTifHq/9qEZWaqYuyC2EVbhKQomtavKjh9unYNHlrHc4BHyTGs3mxSjX7DCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045673; c=relaxed/simple;
	bh=+NMprTodPYYceed69doFtnRlHd/P5PBXBUr5x+/FrX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1B7P9g8sHSwS7Vg5E6pRKKSxRoWmvjIGgHDc9vfCdifmUWZWdFzrtdG8Jwe49FtBSgePethwswZ0GaxMFHgOR0Zuwbn9NoiVtY82K5q7rL9aOUjkRzL9j22cQjKVfO7TcVAMguvdUWhx3qptp/EVhZfidvEoVivsqXk+Pd4EUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZyx51kE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZyx51kE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790045671; x=1821581671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+NMprTodPYYceed69doFtnRlHd/P5PBXBUr5x+/FrX0=;
  b=jZyx51kE2KOSHtELURTuRAoruagFUQpkCHz+lbNbOMK7UTE3ltzy33A9
   PYgy6f2FjmK+xXU++SdkHVvARNPA9naDKdw8XLkNpFzx53kOKhL1SMp1N
   HfS5UkV3DhMR816h+ToGJYu6bIdVOZJLMRGzJsKlmJk2yA6LpXM9AlsZ3
   ZRaS0mC6FHvvK/r058MDhZbvMcXTF2APMJGNs5zvmu8m7OxT18927PyYQ
   MkaxxqsyI4Y3444qEVFDF9VphCp4+eTLCE6TP+0Pog42oFwhdDZ7fQg7M
   JX99miINy/RvpyjiOVAhbMWf+w7rjYo07GtcWqGdh8vyfB/jPnoHo+mKs
   A==;
X-CSE-ConnectionGUID: 9eZgqxxXSpWaUQVL8WnBJg==
X-CSE-MsgGUID: sGqgUGJJRdmi9sZE0okOaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93114163"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="93114163"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:54:28 -0700
X-CSE-ConnectionGUID: LBCccofoTo+ETUQwpecoUQ==
X-CSE-MsgGUID: 7xSPBbi4SIKqX2ssCQrS2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280995800"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by fmviesa005.fm.intel.com with ESMTP; 21 Sep 2026 19:54:26 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 1/2] HID: Intel-thc-hid: Intel-quicki2c: Use hid_safe_input_report()
Date: Tue, 22 Sep 2026 10:54:36 +0800
Message-ID: <20260922025437.940072-2-even.xu@intel.com>
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

Track the allocated size of qcdev->input_buf in the new input_len
field and pass it through quicki2c_hid_send_report() to
hid_safe_input_report() to prevent potential out-of-bounds reads.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 4 +++-
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h | 2 ++
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c | 6 ++++--
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 2537288b5026..7a913f717efa 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -315,7 +315,7 @@ static int handle_input_report(struct quicki2c_device *qcdev)
 		if (qcdev->state != QUICKI2C_ENABLED)
 			continue;
 
-		quicki2c_hid_send_report(qcdev, pkt->data,
+		quicki2c_hid_send_report(qcdev, pkt->data, qcdev->input_len,
 					 HIDI2C_DATA_LEN(le16_to_cpu(pkt->len)));
 	}
 
@@ -611,6 +611,8 @@ static int quicki2c_alloc_report_buf(struct quicki2c_device *qcdev)
 	if (!qcdev->input_buf)
 		return -ENOMEM;
 
+	qcdev->input_len = max_report_len;
+
 	if (!le16_to_cpu(qcdev->dev_desc.max_output_len))
 		qcdev->dev_desc.max_output_len = cpu_to_le16(SZ_4K);
 
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
index 6d25a846153e..e9ff0440fb54 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
@@ -181,6 +181,7 @@ struct acpi_device;
  * @low_power_ltr_val: THC low power LTR value
  * @report_descriptor: Store a copy of device report descriptor
  * @input_buf: Store a copy of latest input report data
+ * @input_len: The data size of the input report buffer
  * @report_buf: Store a copy of latest input/output report packet from set/get feature
  * @report_len: The length of input/output report packet
  * @reset_ack_wq: Workqueue for waiting reset response from device
@@ -212,6 +213,7 @@ struct quicki2c_device {
 
 	u8 *report_descriptor;
 	u8 *input_buf;
+	size_t input_len;
 	u8 *report_buf;
 	size_t report_len;
 
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
index 8075992e8732..1a220a50d934 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
@@ -157,16 +157,18 @@ void quicki2c_hid_remove(struct quicki2c_device *qcdev)
  *
  * @qcdev: point to quicki2c device
  * @data: point to input report data buffer
+ * @buf_size: the allocated size of the input report data buffer
  * @data_len: the length of input report data
  *
  * Return: 0 on success, non zero on error.
  */
 int quicki2c_hid_send_report(struct quicki2c_device *qcdev,
-			     void *data, size_t data_len)
+			     void *data, size_t buf_size, size_t data_len)
 {
 	int ret;
 
-	ret = hid_input_report(qcdev->hid_dev, HID_INPUT_REPORT, data, data_len, 1);
+	ret = hid_safe_input_report(qcdev->hid_dev, HID_INPUT_REPORT, data,
+				    buf_size, data_len, 1);
 	if (ret)
 		dev_err(qcdev->dev, "Failed to send HID input report, ret = %d.\n", ret);
 
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h
index e80df5f339fe..4c6757eca18e 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h
@@ -7,7 +7,7 @@
 struct quicki2c_device;
 
 int quicki2c_hid_send_report(struct quicki2c_device *qcdev,
-			     void *data, size_t data_size);
+			     void *data, size_t buf_size, size_t data_size);
 int quicki2c_hid_probe(struct quicki2c_device *qcdev);
 void quicki2c_hid_remove(struct quicki2c_device *qcdev);
 
-- 
2.43.0

