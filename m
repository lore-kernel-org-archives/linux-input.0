Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDE3CF207;
	Sun, 16 Aug 2026 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860552; cv=none; b=YLLJ+OQkUoIaPT8u6DzppAN5Mn/YHLgz20srBR3kzmMG1bl+CAoeG3XOI66WcTIr2+p+rzDCAtNXHx+iLY8f9eUk7gqTaflik5w75XwV+wHQ73SnY50FK8r45ykS5ewpgmFnKNZ0nlZj8aTAApz9gxTQSFSyhfgz5lPGuO/Jx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860552; c=relaxed/simple;
	bh=ajlXmeblGTrAWyT6gjIYLkVOOIoMXEJo2ycZbfvOhF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRSjY3DP+WtCbonqsw00oCU+jTY5HBSOTyVeaKMJWJ1ycq4mVC1AQGzInwXMBe9OV3mizOcJ5DL0EWuGWSEQfGx+B4B3qPaxgBnEh/ctkicq9tBOBn0TfP3Xa2PnQd+2whboAw+eb37s18oJvS13Vsntbk15k9RTRr9qoDNhZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cBMW7e0P; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cBMW7e0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860551; x=1818396551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnIHJPa4rsw+GRpoRlk7SycvZjiMhD5FjBTQ4kuxmrY=;
  b=cBMW7e0P5rOEaco4HqvAOzQNIsgAydzseQ2MqUfYMGmnIf0gmufMKhjT
   JIdsOVAtekMJuJiNL12X++mJIo0+tCQ5Kb0d7ABDH6wogAJaXduME10Ib
   /kKHqAZ1b3krHTQWAj1s/+eIfM2QYR0viGz4AyctieUJcq3UJS+xPe/nU
   hbZAN71V8N0R0rOPymuNt8KHrJ1UVBTGOawmztuiyb/odC4d6axMT0w+5
   rSKa9GTFarqLg0EnIrpQZixCtFRIZojdjTivcRcFrhR2UzKEwgvH2Evwp
   F4K0HIm8O4dOH/eVveOi6EfGYo0NGP1WxMGWya7Yp1FXbfc5fnD6bLGk1
   g==;
X-CSE-ConnectionGUID: mRa4OV4ZQvyKwTDEpZD3DQ==
X-CSE-MsgGUID: 6kl3aWLXQC+E9G8yYIcVwQ==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25976568"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:09:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:20238]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.84:2525] with esmtp (Farcaster)
 id 93a11804-b57e-4283-b632-87c7c22122a3; Sun, 16 Aug 2026 06:09:08 +0000 (UTC)
X-Farcaster-Flow-ID: 93a11804-b57e-4283-b632-87c7c22122a3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:09:08 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:09:02 +0000
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
CC: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 11/13] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:10 +0000
Message-ID: <20260816060648.4030-12-farbere@amazon.com>
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

Replace the atomic_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_atomic_notifier_chain_register(), removing the
sprd_eic_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/gpio/gpio-eic-sprd.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 3b7ebcf12fe7..86eb9624d38a 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -601,13 +601,6 @@ static const struct irq_chip sprd_eic_irq = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static void sprd_eic_unregister_notifier(void *data)
-{
-	struct notifier_block *nb = data;
-
-	atomic_notifier_chain_unregister(&sprd_eic_irq_notifier, nb);
-}
-
 static int sprd_eic_probe(struct platform_device *pdev)
 {
 	const struct sprd_eic_variant_data *pdata;
@@ -690,14 +683,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	}
 
 	sprd_eic->irq_nb.notifier_call = sprd_eic_irq_notify;
-	ret = atomic_notifier_chain_register(&sprd_eic_irq_notifier,
-					     &sprd_eic->irq_nb);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to register with the interrupt notifier");
-
-	return devm_add_action_or_reset(dev, sprd_eic_unregister_notifier,
-					&sprd_eic->irq_nb);
+	return devm_atomic_notifier_chain_register(dev, &sprd_eic_irq_notifier,
+						   &sprd_eic->irq_nb);
 }
 
 static const struct of_device_id sprd_eic_of_match[] = {
-- 
2.47.3

