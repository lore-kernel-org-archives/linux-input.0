Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566554;
	b=f5+nhjxH0o/jua6j+dpJNMSvVnW7tYv/ACtX+/aI+4RWrcXrnF5x63pJO2/uZgESnPtW
	 mOvRpGl+LSYH5kk6MjseZV9c9qVRBDz3jGWUNf0YNbt7hEaZ1Hie2TrrE7znUbKxo0bGJ
	 jvblKcNLEt+eS/r/jfBOxHIFchp8qJo0Mmwdrx2WqvtI8/VhbiJrUnZ3xyNa3LtAQNo5W
	 uBm54Xuj5FOkiFTWbjG6zGS01VMnih+92kYUG2IhaT9ByGYSyqFzx7OLeBy7u+WBpSkDG
	 1s0bxafTntsiKOzVXH8Pl2zUeOemoA3NRd2qFvKcF6OBfdl+XAGObNGgA5d0D8E1/aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566554;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=iwVrLn83MPrbZJeKNsyzK4OIPmdNALDYg4Cp5xss/IE=;
	b=X6TskMY3EvPnvqDGc1sq13MkowGhpEcT0sL2FHWzQg0gAYDa9uu47UcMquti15Tzh8Ba
	 hEtfe8s+/MeMceKnDIOB6bfAafGqthHqy2ZWqk2Le79FqrO9yrYmvb8+LHgw4jBhmFWx+
	 qFK06UX72F6wyhbgaF/KKkqpML/oSkewkWFKOdgeELbIo9CnQZx5rrG/8hWyqO+Zs3zZC
	 5tR4YlZ2w4LWiJ2p5sQ/IKSCo5qBBtj7mwtpyqDexuKrteU+dArj+QDc4O0kYraWHtMmo
	 Dd+Ap5vuM/BG39LHMUMjz84Lsog3OxtnmZ+zsDL5iQtBU1gy4pHm+DzfbZIDFoXhkqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="pwp/UTT2";
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6A606A339;
	Fri, 13 Nov 2026 10:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A6A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=pwp/UTT2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794566554; x=1826102554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwVrLn83MPrbZJeKNsyzK4OIPmdNALDYg4Cp5xss/IE=;
  b=pwp/UTT2ru9panVRJrLDI7Zp8snTSO/1Aoir4sWpve/1egKDxZJQJjsN
   w11mPIfnccaObEbsqnoc2WE6T6XL7ImLiIToXnolSCYYI7zhaA/HbKNpz
   j6n02YfRu9wak371NFQxvHOCNlBdeP50uwDOnqzu5evJllgKztabkNgn6
   dZe2LvBDzLFjnsmdehm5/CVt1vGVbrB9yTwS4qIuujLCBp35wxBZ6SezB
   2BOT4P30i+D6JhkoPX1umaVa2LHOMq9keqb1RFDFC5eFs62LZtJpSfSgn
   oSqp+ExzRmE9oAnBBqqEl3JRcbQmTT/QWIdPQuUxkjIbZZvaqBNltT2J0
   A==;
X-CSE-ConnectionGUID: Vyfm9+A1T8uvqe39JVdUYQ==
X-CSE-MsgGUID: Jrjow0SyQqenurMtQ06aHg==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33745490"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:42:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:28832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id cc4102fc-f5a0-4b43-9f9f-8f8d0ffba648; Fri, 13 Nov 2026 10:42:31 +0000 (UTC)
X-Farcaster-Flow-ID: cc4102fc-f5a0-4b43-9f9f-8f8d0ffba648
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 10:42:30 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 10:42:28 +0000
From: Eliav Farber <farbere@amazon.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf
	<W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Eliav Farber <farbere@amazon.com>, <linux-gpio@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/7] Input: adp5585: use devm_blocking_notifier_chain_register()
Date: Fri, 13 Nov 2026 10:42:04 +0000
Message-ID: <20261113104218.32566-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113104218.32566-1-farbere@amazon.com>
References: <20261113104218.32566-1-farbere@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
adp5585_keys_unreg_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v6:
- Rebased onto v7.4-rc1. No functional change since v5.
- Dmitry Torokhov's Acked-by retained; the patch is unchanged since v1,
  when it was given.

 drivers/input/keyboard/adp5585-keys.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/input/keyboard/adp5585-keys.c b/drivers/input/keyboard/adp5585-keys.c
index ee2c3cb0445f..b27390d0e706 100644
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

