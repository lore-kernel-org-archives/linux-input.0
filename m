Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F132692C;
	Sun, 26 Jul 2026 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041936; cv=none; b=p1Zw560l7QDh+0TqcgW3Z4I5KblYBaLEp5VFXWYt2U0ZCVvDeXuSZQ4d0GP8+/jTrEiyrpYCZNjLFBVsjYZunM83c6YOXRri28LBydLd3RIteYJnIL0jiQuCjNwaUeE29UwGZ1FMFTGJ9/FWKptERPMI3Kkp/Ud7px3kb7SLm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041936; c=relaxed/simple;
	bh=ccWQ5f7CXtSGJ6qKQkHdoz4LI1e5kXAR6L75o+YE2YE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZC/igDU/+EgF/8q4JWKIoJk8AlI2SAU6dnaFy0AQllGLh2NPrbGwulGMnvPG0r0AwKnw74m6TVFeiQIII6mxw1O3xeYsV+vLyykauaFgHJMA6+cYEXvGu9As92h8gcHWK6oCUlnM8nKLGtqhtSjPGlPrWCaNvwJu35jLsCO8joU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fNKuqdZ8; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fNKuqdZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041935; x=1816577935;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SMiveELrJ65lB2MwLXjygCgEyGxPmyjGo1Xt3qgKNns=;
  b=fNKuqdZ8O3A6MQD2C592fnfvPxQ8NasEv3upjRbX0Wy5Oq0otYXBlYLU
   pcys62ZD1mM7yGIPdJTFUwJSGNYnnvl2xegUXSkhkgP6znx8nlzyF/+vq
   IAzQ5h18vx0bQ0+5OltVbbSoY1OTxAY2VYp64b3t4Sl7XZ9F9wkf8um2L
   HpSicCQW7m8hig11O/jHPJYZK5u/hgM7YU6wJ6wFjwV9DBvq7E7wpBYKB
   hpFqE1cwV9fX7u0xvM7+RkdyKGJLWaHIp8BVOm4eiuUcl14pUs+ZdQUc+
   lOeu4YBPmduNFryF9EjpFYphcUxqo+R4KQD11LbpZkfFGlw+vaLAKgq7d
   g==;
X-CSE-ConnectionGUID: +dyPpKS3S2SAMqmdFAhOlw==
X-CSE-MsgGUID: am+fvo69Q1ijAwcC+he8GQ==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24340336"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:58:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:17614]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id fb58f88a-ca38-4503-9154-ddd587c3de77; Sun, 26 Jul 2026 04:58:54 +0000 (UTC)
X-Farcaster-Flow-ID: fb58f88a-ca38-4503-9154-ddd587c3de77
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:58:53 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:58:48 +0000
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
	<frederic@kernel.org>, <kees@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 06/12] platform/x86: bitland-mifs-wmi: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:57:00 +0000
Message-ID: <20260726045706.8169-7-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726045706.8169-1-farbere@amazon.com>
References: <20260726045706.8169-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
bitland_notifier_unregister() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/platform/x86/bitland-mifs-wmi.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/bitland-mifs-wmi.c b/drivers/platform/x86/bitland-mifs-wmi.c
index 3a373184519d..2bcd4f692a74 100644
--- a/drivers/platform/x86/bitland-mifs-wmi.c
+++ b/drivers/platform/x86/bitland-mifs-wmi.c
@@ -623,13 +623,6 @@ static const struct key_entry bitland_mifs_wmi_keymap[] = {
 	{ KE_END, 0 }
 };
 
-static void bitland_notifier_unregister(void *data)
-{
-	struct notifier_block *nb = data;
-
-	blocking_notifier_chain_unregister(&bitland_notifier_list, nb);
-}
-
 static int bitland_notifier_callback(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
@@ -729,13 +722,9 @@ static int bitland_mifs_wmi_probe(struct wmi_device *wdev, const void *context)
 		return ret;
 
 	drv_data->notifier.notifier_call = bitland_notifier_callback;
-	ret = blocking_notifier_chain_register(&bitland_notifier_list, &drv_data->notifier);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(&wdev->dev,
-				       bitland_notifier_unregister,
-				       &drv_data->notifier);
+	return devm_blocking_notifier_chain_register(&wdev->dev,
+						     &bitland_notifier_list,
+						     &drv_data->notifier);
 }
 
 static void bitland_mifs_wmi_notify(struct wmi_device *wdev,
-- 
2.47.3

