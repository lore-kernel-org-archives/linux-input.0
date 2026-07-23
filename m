Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1A3A1A54;
	Thu, 23 Jul 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829355; cv=none; b=c7Jkm1xOuDreeR0ggN1JalGyuZwwPJ26bHp4JJsCrdInQDQUp9JbfOjweUJ+XgZAGuIE+GiG2Rlfg4jzOF309ij8vQdVvLTdRxNTiK0re/ab2NRtwJevTF7ICQwJOL+bGcKWOO1IF6NnVhhURhfOkWasAmvS41aGrn61t5Flk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829355; c=relaxed/simple;
	bh=Au2jGWBQN/i2YaPgSzikwkAxqaVP4qGTpVegc2n7t+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI2zScH6LlC5y76u9ZkkVia9BxyePniOJAOjvFbTrKXfSNIpQkdzIClVc4CsiiTOyUrjTdPzewgYQzjz9Ll2v0TsOX2WLxBT0aZp/cddWkuzre68yT79jnLH5u9sE4EIXlY7Bij7WXogCgeBcF9/k6M+SkUjTgpMetfGVn/qUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KFy9y5NV; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KFy9y5NV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829351; x=1816365351;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yps4lBc/RYwlxTR0dmczc+YOvWPbhS0zT2kuXNnrCAk=;
  b=KFy9y5NV9cHw2rrgQWYGngYlYRljMJvEKVb2dEHJwWYgBT+moxHPjj3E
   U81UKk/mvAU/PIGvmB7BuaOWzvIvMSQaCSok9c3T/uzDmjq+qpB1s8bYC
   jOmSTxS0kfz4zDon/WZugVa2JQ7O/PvAj6EYPLTvpikFGbSZq8jsGO5rR
   FDjNDDDQXXWNo2PStrkg3K9pyr5vMWJ8cNYCQc7axlkrnHmw3TEg6L8xY
   5BSM+PP+8X7doJGpHrs0tr/xoV2YJtPFOuYau5ynNao0a7pDlDmuq6snv
   wOnGLs1KqLeIo1HeCsSJJsY3w4NBOsegISSCPZ0djV9ndWeSSd4xIqurU
   g==;
X-CSE-ConnectionGUID: G0Fvq0k6RziCEtAh9TEp/w==
X-CSE-MsgGUID: MI66TUnQQOyL1GMvBtXR9A==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24266842"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:55:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:31079]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.152:2525] with esmtp (Farcaster)
 id 336fd071-9e0f-4389-ada8-c07f55bf0190; Thu, 23 Jul 2026 17:55:44 +0000 (UTC)
X-Farcaster-Flow-ID: 336fd071-9e0f-4389-ada8-c07f55bf0190
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:55:44 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:55:39 +0000
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
Subject: [PATCH 09/12] platform/x86: uniwill-wmi: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:55:10 +0000
Message-ID: <20260723175513.39849-5-farbere@amazon.com>
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
devm_uniwill_wmi_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
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

