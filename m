Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8732695F;
	Sun, 26 Jul 2026 04:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041954; cv=none; b=qD3oalnXhQSu9CGQxE7P5wwoQxeKz1zRqy97E9rdOqm71qqC7s3xjdxzMfGwNY7Udd9QfOzKC+stsFxh8QJSmTiTNYUgk+fptJeJ3kFEqb0nM+TTUdQ5UvYlr3rXbek3dzAw87Z/k0JRuMxiqsR01rK2eOh4aU9hjk5rolTiels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041954; c=relaxed/simple;
	bh=Au2jGWBQN/i2YaPgSzikwkAxqaVP4qGTpVegc2n7t+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExjbcjxW8waZoZYml2Qt1QWVlWjcWxoyWvPqnZmXEKoVnlnd2goZ0wntkRR8/qpHUWmkIxY+DvrcHh7FR+Q3+9uuWbhgXr3rYtILGnuirSHINvPBn4iM+x/hzDWwLGIVQPVIc1Lp53sxRq2WvopqUjeuX8rACy8iXHTBWRvgYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TLSXcYLf; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TLSXcYLf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041953; x=1816577953;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yps4lBc/RYwlxTR0dmczc+YOvWPbhS0zT2kuXNnrCAk=;
  b=TLSXcYLfm/Kk8hquovh8Q1XTmSSkJHCwZR5kEZp0DIqBfqEdpUgv1Xch
   Xu7eXzxA3R3IsiJ5lgPOl0l5XQzy5JDHO5odqgqYGNXst9vaKEcdpPLxq
   dwPlRig7sXmjQtgyb0WLW/78COlUJA+PKyJBh6RvDt8fyolWSR/79XGrP
   k9tvwpguNfUxML8h0h/5kjGHax12+SSn6eB+qHjSLWtgArX8MHJLjqYPV
   fT1GbJXXFktZI7SSQvCpH6zyNuPpgGB3xK+GcK7tFcsuSarUxOTKW/xsV
   yRmlTGjjlDkAAVifauRsYJRj4JOIbaFB/aZJ5gx4Qmi/bfxFARPYIWLTE
   Q==;
X-CSE-ConnectionGUID: L3YVKN+VQMyeqfbRR5kuUQ==
X-CSE-MsgGUID: rm3FU5++RJ+RUCR3f2ewbw==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24162318"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:59:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:23059]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.142:2525] with esmtp (Farcaster)
 id e47d8e12-c38d-4b80-a9fb-0ad17b72cf9f; Sun, 26 Jul 2026 04:59:09 +0000 (UTC)
X-Farcaster-Flow-ID: e47d8e12-c38d-4b80-a9fb-0ad17b72cf9f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:59:09 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:59:04 +0000
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
Subject: [PATCH v2 09/12] platform/x86: uniwill-wmi: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:57:03 +0000
Message-ID: <20260726045706.8169-10-farbere@amazon.com>
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

