Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6161C2324;
	Tue, 22 Sep 2026 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045202; cv=none; b=LK8y76xgQ1U/n+AAybICUkaB+jE0gv6OjD2XJI3c7OX51ys5/GYnf0Zi7MrYG98/8jsk1hhU7fMKB5lHuude8v5U7j4r4stniLtxiocNpbiu73KmK0/rT9432MQzRc9k+YZN7Q0o2ECgregaHzeCZZwUwBgo0nQq/kO8ovjq4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045202; c=relaxed/simple;
	bh=2xPztAbb3KsCJosIzDYd1oDAJQMeeQFNK1FvyeLq6qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZgYIHEWwQgLyOSD0gJ6ljLsKhsfODbPkg8mGCpA0Dz7Agqlt22KwkipevuwnxQaM450LFv1CpmSZW3HP2I/AwBI7SXLsy2vhWexsygzVJmb0ngTYIRQ5E2JbgaSaGN2oSKhjhdgBeMOYVZj3lbP0j8aacOzsIl3sK/EGAl5l4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GndPlDNq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GndPlDNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790045200; x=1821581200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2xPztAbb3KsCJosIzDYd1oDAJQMeeQFNK1FvyeLq6qk=;
  b=GndPlDNq3FIU6FysvOyc6z68dJq32MaoEFfefLfu50qdpMFShf9IK8Zn
   xG1gmKRpoDp6yEK645NbgbcfDT/LLbULZPJP/MgmJummoWl4xi7Km8F60
   +F6GUNR+IPcqK7qX7dgGvFAG8PHPLxYhia7DgNS/sVxTG3YaGl3U0LKER
   ffqPfHrkdS3I5XLfYnmb6k0IKXK4vfllHZPdNNJ4WxYMzcY5wXq78hQ6D
   gZOxBOGkMw9EpgpqX7qrUyhX8mQxQ9/Bkqcxov2fuV3HeSrTdtqtA0W4L
   KQVqMcD0kx/8rx8fdtR/8KfO9e33ht5Ko+9aYWqxF3m6EUiHIKft2iVal
   Q==;
X-CSE-ConnectionGUID: 8Tv6YscsRAuAVBzGEW+Gug==
X-CSE-MsgGUID: ANMcafs/RGO7w/Dkr+FiyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90476388"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90476388"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:46:40 -0700
X-CSE-ConnectionGUID: ThbA6oCwQG+Ggp0Jj4J5aw==
X-CSE-MsgGUID: BBqKLkYaR1ONQkkKXNq0aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272123874"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 19:46:39 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 2/2] HID: Intel-thc-hid: Intel-quickspi: Fix buffer overflow
Date: Tue, 22 Sep 2026 10:46:38 +0800
Message-ID: <20260922024638.932865-3-even.xu@intel.com>
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

The input buffers are used to store complete HID-over-SPI packets,
including their protocol headers. However, their sizes are
currently calculated from the payload length only.

Allocate enough space for both the payload and the packet header to
prevent a buffer overflow when the payload reaches its maximum size.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 89226f5ce45e..ad676fde211b 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -552,7 +552,8 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 	max_input_len = max(le16_to_cpu(qsdev->dev_desc.rep_desc_len),
 			    le16_to_cpu(qsdev->dev_desc.max_input_len));
 
-	qsdev->input_buf = devm_kzalloc(qsdev->dev, max_input_len, GFP_KERNEL);
+	qsdev->input_buf = devm_kzalloc(qsdev->dev,
+					HIDSPI_INPUT_BODY_SIZE(max_input_len), GFP_KERNEL);
 	if (!qsdev->input_buf)
 		return -ENOMEM;
 
-- 
2.43.0

