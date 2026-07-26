Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C533D6FC;
	Sun, 26 Jul 2026 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047940; cv=none; b=Mp8fQ2YS+a/PCYlg1fDRb5hUYUoefQrDzvc7xd6EDRNEnGkNeEm1BHwmRw1lh/P5lWvWL8u3tLufWlJTfmDrDC+g5VOB74zSJuHhnJFcp+POJ4J1GxpE8osPZi7Wbl+n/g9E4AVZCXXA4bakca0WA8pACp1irTY/akxUMhwQ87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047940; c=relaxed/simple;
	bh=ccWQ5f7CXtSGJ6qKQkHdoz4LI1e5kXAR6L75o+YE2YE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AU0PFw7KykF9g/rRidKGIQQ+dQgs4Ln/s9L91T5rDZLtYCF8rlGaP/FM7nKESQIX1rQPSEtM5RJtyQ9cvjATTd4cKZhWs+CgZKkpMeOg5n25Bi9Ea6aTk3BikJbQcN7mrCWun1vlSMHuN+1YuZxdk+UsMctA1fcG94r6JWwdVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YnJW9vpG; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YnJW9vpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785047938; x=1816583938;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SMiveELrJ65lB2MwLXjygCgEyGxPmyjGo1Xt3qgKNns=;
  b=YnJW9vpGFXIqJCAc+fAOYQ/cigPocToQ8zcw4I5rf/DviPLeWd7x6L8+
   PfX8Hq135IDhWSc8NVMyfwLJPZk8mUw2d/ux6R0C01bKg14opwLZ3MPaJ
   0EX6O0TVkgxM1ktAW7oexJM6bLd/B8jmZl0GZNwTfgc0eD0qjK9LjI41B
   qi2sqyP3NROnI3DPbbvzsM20WcMSavzy4pTZ70w4czoT6QA63cuD0FXQS
   9wgsk1eY9EOn0a77um99HyOh4fV0zu2J/74IQktjpeSTTwRK+pZmqqnA2
   tkNg7R2Y8wWmZQv37voK8xMt+6ByEPU6MTSbiDsDXc/DfAVWkFEalgcIf
   w==;
X-CSE-ConnectionGUID: MejHVhjUQ9qzvEjMPUzodA==
X-CSE-MsgGUID: H+vt/wO0RKKqysw795heGw==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24153052"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:38:54 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:17170]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id cbfca8ba-d706-4357-b36c-90f1d8260aa9; Sun, 26 Jul 2026 06:38:54 +0000 (UTC)
X-Farcaster-Flow-ID: cbfca8ba-d706-4357-b36c-90f1d8260aa9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:38:53 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:38:48 +0000
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
Subject: [PATCH v3 06/12] platform/x86: bitland-mifs-wmi: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:21 +0000
Message-ID: <20260726063727.19111-7-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726063727.19111-1-farbere@amazon.com>
References: <20260726063727.19111-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
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

