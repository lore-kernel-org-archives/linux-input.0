Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970B3CF1E7;
	Sun, 16 Aug 2026 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860545; cv=none; b=sR0jmP9fA4RNcs+OOtYokjXU8SlNu0pma+/Wc5eAWPz3+XmBtvXvi5pNzDZlQH2B/jCJlqkFSQQpY3CpaNS8AmytdMlqSKi5lNgS7cYSraAGviFS0kRR9HfiXnQ8pNxsGJT0DxQWWYCUzG6l3nPMvY/blltu6CwrYaCMitSssg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860545; c=relaxed/simple;
	bh=j4UpJ76OIzsIDW6GWYb1SRnKtYPJEv6yT360/9ZdNUY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ig/bXy7VxHLFg2R0xyyO/tZiNTfPyXsYqiF8AbHBpPwTtLZYIfJVTWc7LT1nRsoYXbUx8cFQ+7asEFylHLE1zflEqoapojAna2BaHPRX111HwYFbTSt2+vnyaXSbvcOSl/q2pxmEF+BQVByKtEFnuXEszqsNMb3HlHsPg728xyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hHZ+berD; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hHZ+berD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860543; x=1818396543;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=di98LHVqqC68671Zg5i9c2evIHi7Mg5rip5VLHRMfVw=;
  b=hHZ+berDkgK8zRI7LgbvhFx2a3N22fKf+61VrA/wEqqepD0lFQB3LTw6
   LrmJbLLhqA6aCsTaIqq5iJSOaKNiN5EJ8TMvJwQ/E4PSosJ7B9tbaZCpn
   CNumRHjTFkYyq7F0h3ZbG/N7CNOXpmCw/PG88rllrykNH1KQxaoMIrgxQ
   fl8ObOEpMZDXuYwL8hlGBjJFOmb67r0V90SSLQ1FXnyVqBmR3sP6tFbuI
   ZJbiYGGkvUFweXYdAaQghY8CGVS2cJ2EfiIqu3A1NvzKuEPq489XOdOrv
   guONUJIUSjPKCmtRX2s31g1JRFt9kQsYesptH3wwowbVqiIK3p4m+xCCA
   w==;
X-CSE-ConnectionGUID: NN8jFoi6TcmPAi/yQkmPnQ==
X-CSE-MsgGUID: sPA203uyRB2fjcrseZMazw==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25957855"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:09:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:30260]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.46:2525] with esmtp (Farcaster)
 id 00934dab-2024-4461-82d2-484111070a0b; Sun, 16 Aug 2026 06:09:03 +0000 (UTC)
X-Farcaster-Flow-ID: 00934dab-2024-4461-82d2-484111070a0b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:09:02 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:08:57 +0000
From: Eliav Farber <farbere@amazon.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<lenb@kernel.org>, <laurent.pinchart@ideasonboard.com>, <linusw@kernel.org>,
	<brgl@kernel.org>, <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <dmitry.torokhov@gmail.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>, <W_Armin@gmx.de>,
	<ukleinek@kernel.org>, <fabio.m.de.francesco@linux.intel.com>,
	<kaihengf@nvidia.com>, <ankita@nvidia.com>, <leitao@debian.org>,
	<farbere@amazon.com>, <pedro.pbg@usp.br>, <paulmck@kernel.org>,
	<frederic@kernel.org>, <kees@kernel.org>, <saket.dumbre@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: [PATCH v5 10/13] platform/x86: uniwill-wmi: use devm_blocking_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:09 +0000
Message-ID: <20260816060648.4030-11-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
devm_uniwill_wmi_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
 drivers/platform/x86/uniwill/uniwill-wmi.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/uniwill/uniwill-wmi.c b/drivers/platform/x86/uniwill/uniwill-wmi.c
index afcbfa4f7552..2ffa29a829ee 100644
--- a/drivers/platform/x86/uniwill/uniwill-wmi.c
+++ b/drivers/platform/x86/uniwill/uniwill-wmi.c
@@ -26,22 +26,11 @@
 
 static BLOCKING_NOTIFIER_HEAD(uniwill_wmi_chain_head);
 
-static void devm_uniwill_wmi_unregister_notifier(void *data)
-{
-	struct notifier_block *nb = data;
-
-	blocking_notifier_chain_unregister(&uniwill_wmi_chain_head, nb);
-}
-
 int devm_uniwill_wmi_register_notifier(struct device *dev, struct notifier_block *nb)
 {
-	int ret;
-
-	ret = blocking_notifier_chain_register(&uniwill_wmi_chain_head, nb);
-	if (ret < 0)
-		return ret;
-
-	return devm_add_action_or_reset(dev, devm_uniwill_wmi_unregister_notifier, nb);
+	return devm_blocking_notifier_chain_register(dev,
+						     &uniwill_wmi_chain_head,
+						     nb);
 }
 
 static void uniwill_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
-- 
2.47.3

