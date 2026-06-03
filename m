Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCA370AE5;
	Wed,  3 Jun 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475294; cv=none; b=H+VIQSFQOvdwxBcNeNZHfhryvHdyH1MxyOfAQ/BqMQ0XQ9byMUsPZtDzfXZYjgEwcBmwMsRr+/T189neyX2uVQHjreYR1f073YLQZi/4znY6AkF7IkU0dhlXaUn1f61pw934zfGWs2oFMkRHXRvFS+JjnxPo8g8X7h9h0H0TPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475294; c=relaxed/simple;
	bh=oQ1JN1LApaaZyvc7zghORD483qAHTIG+BIf2SxAUwL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCExitbQQYpFjOIhJRxXwk2xHqy2QP/r0Hy3B4JnXTpHFQhQjUUW9ypZT19WviDBgDavt3nfITuLrKLfhyi7c3y/+UIHmIG5k5kZn9NTFSWCPqGuSDgy2RioO2IyEbR4RepTkyVcbL7u0qXKZiVdF2cZCt48hFysl3p70wpx4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXf5vlZK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXf5vlZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780475293; x=1812011293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oQ1JN1LApaaZyvc7zghORD483qAHTIG+BIf2SxAUwL0=;
  b=RXf5vlZKmmyogqPfVNPeyvaPg+u6+wEbnQyZJOy69DfCBI///Y7qlwjX
   VtIfQj8giDgW+FmwK7F1MXUvFctgr7lM5g+iZBOJLBngzPBwcsmiRD+d0
   wesOSidadWSWEdOfTuBaDpPFTVplahVzs5M/shUpA6aNGojt6y5P2swRY
   kk8HPCi4DMph6TcaLICzkq6Nkqwlqi+Cpzlg56QBMF193N8RZwKVysppG
   Unb8IQMsnuFeK/zfFQvO6TY9810/g8CkfKgI+lOTwhPQOt19ip0MnbLTm
   MYD5du3YojM35CZ4qWAcYfLw4Cd2uhlEJxwTRqf236cjSKG8P1ZfQR7Bw
   g==;
X-CSE-ConnectionGUID: YTNGQPG2T0C056OMMQO2wA==
X-CSE-MsgGUID: WbuaYXLoRn2GJw4UBVe3iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91588121"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="91588121"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 01:28:12 -0700
X-CSE-ConnectionGUID: hQP/h55KSMyMynUKne0t5g==
X-CSE-MsgGUID: RgERN4U2QsWxYGpyKaLYvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="245976389"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 01:28:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A4F7495; Wed, 03 Jun 2026 10:28:09 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Kosina <jikos@kernel.org>,
	"Daniel J. Ogorchock" <djogorchock@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] HID: nintendo: Use %pM format specifier for MAC addresses
Date: Wed,  3 Jun 2026 10:28:08 +0200
Message-ID: <20260603082808.119958-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to %pM instead of using custom code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-nintendo.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 29008c2cc530..77b14dfdae86 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2431,14 +2431,8 @@ static int joycon_read_info(struct joycon_ctlr *ctlr)
 	for (i = 4, j = 0; j < 6; i++, j++)
 		ctlr->mac_addr[j] = report->subcmd_reply.data[i];
 
-	ctlr->mac_addr_str = devm_kasprintf(&ctlr->hdev->dev, GFP_KERNEL,
-					    "%02X:%02X:%02X:%02X:%02X:%02X",
-					    ctlr->mac_addr[0],
-					    ctlr->mac_addr[1],
-					    ctlr->mac_addr[2],
-					    ctlr->mac_addr[3],
-					    ctlr->mac_addr[4],
-					    ctlr->mac_addr[5]);
+	ctlr->mac_addr_str = devm_kasprintf(&ctlr->hdev->dev, GFP_KERNEL, "%pM",
+					    ctlr->mac_addr);
 	if (!ctlr->mac_addr_str)
 		return -ENOMEM;
 	hid_info(ctlr->hdev, "controller MAC = %s\n", ctlr->mac_addr_str);
-- 
2.50.1

