Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ECA397691;
	Thu, 23 Jul 2026 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829340; cv=none; b=ij6Ff8TH3O/6R3rP6HH/5nm9r7y6ht9outB/2FEg7WddWtQdAZsjw430lge1o8fn7TX4AEH9wH70ihnx9gelj2QdyUPnjROMO7S4DoEGd12ySN0KfYjyVIzTHLe7cri29QfL2Wo2lvpxK+4BA7C+Vuq8xR2iFqVLiTboiFdIow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829340; c=relaxed/simple;
	bh=ccWQ5f7CXtSGJ6qKQkHdoz4LI1e5kXAR6L75o+YE2YE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr765UIveE/AuJOL4/NgRPMnNlZne5/Ej4mrMRtPdXWqL1PgS4BocVv1Y87NU/2K2ObDTcQIpsxg5bXIMkgHSYAhCoVN9xfheuIxeqCFqwkKDZebmjfykTovPGzgL/89o6ge7d9YXQxAu+bBp+0UYjEv2eivln/O3Cwvnd9DY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=i42wxVL9; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="i42wxVL9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829337; x=1816365337;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SMiveELrJ65lB2MwLXjygCgEyGxPmyjGo1Xt3qgKNns=;
  b=i42wxVL96xeGkzWr3mxlPqQ9eCjLSzyRwXK07eESA2rXpkAKACvYL723
   k9PPaUM8+Nb0w6h7UI8hANKN7u7eb+2wkD2Ow+tBmOOC5/RHX7KlvFzto
   XoERh0RAUwch9mCPyXUMn+l4kHuEjOuIg8V2CLp1Apr8A/irRXVzExB4C
   uAIrbufDatGjMqu5T7nr9wL8cJo0he1EJfvZLcPrxcQy5aJ1gnqQajYzl
   4mcO9YyAE8bunjQsZFCgfk4o6wLRH720+0SI5tAUQNj8Pg3aErytaMBEP
   Od9NmEAXsUn79NBZagIxRu7ZPzfbm/asDq4GOGSuI0Z/F7vB9wzqlkj9C
   w==;
X-CSE-ConnectionGUID: IfEBReULTeWWIxLi+9HFFg==
X-CSE-MsgGUID: woTUUb9NTuSsa5dcfpbyNQ==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24050101"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:55:29 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:14530]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id ebd65c7c-5326-4738-af43-810a3f359087; Thu, 23 Jul 2026 17:55:28 +0000 (UTC)
X-Farcaster-Flow-ID: ebd65c7c-5326-4738-af43-810a3f359087
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:55:28 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:55:23 +0000
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
Subject: [PATCH 06/12] platform/x86: bitland-mifs-wmi: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:55:07 +0000
Message-ID: <20260723175513.39849-2-farbere@amazon.com>
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

