Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DC36C0CD;
	Thu, 23 Jul 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829347; cv=none; b=MXjXYvxbb/vAbJfRgBzU9gsIyh+HVm0lygo/GuA2XjubENXcu8dmqTL3BrdIZe4H0Ne8FmG9TjuzaYH4AVfR6MyUcvrPMSIk1mMn/Y9bqkIcwU+A5Fmv3sw4QBYuX34wPs3Aqs01w7yy0/CTEx2mq3RzP5EpsVNndaLL8+PZQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829347; c=relaxed/simple;
	bh=D7C4ijrIEcgPKqsIHI3PjMv/YtDaEo/sN32rizhaVUs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0jMR9IPFSen+xO/CQKIFcnKW8D33LFE3YvwByYNJhsve/taKbDKtC175V3CkOk+zO+oN2kGOd+eyQ5QI5PPKrVxQT9Bry2MoGAyxlOZuaBY2gkLxktSDFa8XmeTH1V+DJcL0zx5nhPBrHPXJOZ0PTNIh4qHM+P3mZSNxbEPZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=O876dac4; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="O876dac4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829342; x=1816365342;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tWDgZfR8Wj4culrMtMpnrVTX0j1bkIU5yvI5e/k733E=;
  b=O876dac4VJ2zYaqZP7TFsNMS5dxU2UTAu+LYtvBCQD2lGJsWEuq0urK1
   dpmvVXOZCHkA9ubqHto6p4FJgCrgFrduGxmXRUrcVnD6Y97wQnygx3zdM
   xXg7lPztm5sw1H3wkzOMBSB2UX9gFWCWrO6YaNlaF5+/eRmoIhbrXguXO
   0ng28j4GkEKvZJ0H+Z3Js5YBVxXncvcFpOwanNFgabeLd2FytyBWNoFd6
   CNbpao77+0PS4PKcbHwnbR3EEz92p4Sgt4ym6bEO4KmYxrLZNFzGh046u
   axPU1n9uvbcyc8OdaJsWirPFZlRezOOar7GuZUIf1UE9cNtkIPxS8hrDp
   Q==;
X-CSE-ConnectionGUID: jeXdFjhDTnK5D1YJRsWizA==
X-CSE-MsgGUID: /MecVQVsQY63JDzJO94vqw==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24268171"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:55:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:12302]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id 40d245a8-c947-43ea-9132-410796a1a0c7; Thu, 23 Jul 2026 17:55:34 +0000 (UTC)
X-Farcaster-Flow-ID: 40d245a8-c947-43ea-9132-410796a1a0c7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:55:33 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:55:28 +0000
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
	<farbere@amazon.com>, <jason@os.amperecomputing.com>, <pedro.pbg@usp.br>,
	<paulmck@kernel.org>, <frederic@kernel.org>, <kees@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH 07/12] Input: adp5585: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:55:08 +0000
Message-ID: <20260723175513.39849-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723175513.39849-1-farbere@amazon.com>
References: <20260723175513.39849-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
adp5585_keys_unreg_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/input/keyboard/adp5585-keys.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/input/keyboard/adp5585-keys.c b/drivers/input/keyboard/adp5585-keys.c
index 017c95029180..0be4cc234c21 100644
--- a/drivers/input/keyboard/adp5585-keys.c
+++ b/drivers/input/keyboard/adp5585-keys.c
@@ -254,15 +254,6 @@ static int adp5585_keys_ev_handle(struct notifier_block *nb, unsigned long key,
 	return NOTIFY_STOP;
 }
 
-static void adp5585_keys_unreg_notifier(void *data)
-{
-	struct adp5585_kpad *kpad = data;
-	struct adp5585_dev *adp5585 = dev_get_drvdata(kpad->dev->parent);
-
-	blocking_notifier_chain_unregister(&adp5585->event_notifier,
-					   &kpad->nb);
-}
-
 static int adp5585_keys_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -318,12 +309,9 @@ static int adp5585_keys_probe(struct platform_device *pdev)
 		return error;
 
 	kpad->nb.notifier_call = adp5585_keys_ev_handle;
-	error = blocking_notifier_chain_register(&adp5585->event_notifier,
-						 &kpad->nb);
-	if (error)
-		return error;
-
-	error = devm_add_action_or_reset(dev, adp5585_keys_unreg_notifier, kpad);
+	error = devm_blocking_notifier_chain_register(dev,
+						      &adp5585->event_notifier,
+						      &kpad->nb);
 	if (error)
 		return error;
 
-- 
2.47.3

