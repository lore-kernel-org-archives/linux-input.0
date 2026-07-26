Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B3278156;
	Sun, 26 Jul 2026 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047861; cv=none; b=pPYGt3wBF0e64pR3Un7hHN2O0eWgbY5JDMznpQiqZJU2GFc8wBLToX6rt3GM0m3FOSEde/VionzSp/JQSU359SGUcNqO348ZPt6MV+lZ4SZv9HFJC0rkTm6aQEo2hu8sPxf+RExu+k/XBZDNqz1UEMiFBXCeLlRLv7Hd2yJt5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047861; c=relaxed/simple;
	bh=1Qs2wWMwJUr9j8bNP+RgYns7YFbExL08xk7hzyKgvEg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bDSfPni2+jIWUsmL4Ogve7iWfltj57fQyjNA36ekABV70+hplQ3ginYWhZ8Qk+b4ANkvgD1O2LRyJarMG4y+sIwHTZ8Ri1FY5t3nP2ZUcdxgOdazDo0Dy/fQAetXW3rtj7pk+dINhu+2q7gradMUnIDGCnhbAepm+mlRuECdIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=B2NfvmXC; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="B2NfvmXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785047860; x=1816583860;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=owcoDRff2nDMDpJPFadRxxjD5xbcpo2+CJKJT664ki8=;
  b=B2NfvmXCG58U6Nceg9Komm38s2Eg2yuJhLCbdP1fvyBLXOUhAshwnzx9
   m6o8oei1FkcNBZwH0vPlX2liJrAPE/fD5SJ9G/SVIimbYst7hz0jgVkjd
   Op691w5rGto6ORf6SGcM1aaMIUyspjoWthg7d+L8MarucShhNDQn6F7n7
   voaVT2lUMGfb0Zp0LiwlSsZZGsGECAr4Y+FP48emhb7Kq8QHnzqTn1IFg
   2MeXMwyexeG2w/HJhfODQ7L3oRlOPmbr/kHkfZL9VLvTxz8Wh4IDfBXds
   DUKtFfjTNcCVe5FbSRHELFqf+EeViDfxJGSYLaMZ1Ywlm++YRDnBY5WVi
   g==;
X-CSE-ConnectionGUID: uz6uBF1YSqKWdFBqw/MBYw==
X-CSE-MsgGUID: s2vNsIE3Rd+s3e4aFqRMwQ==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24356973"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:37:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:10701]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id 46cc83f2-9707-4228-8a24-460cd5e2033e; Sun, 26 Jul 2026 06:37:38 +0000 (UTC)
X-Farcaster-Flow-ID: 46cc83f2-9707-4228-8a24-460cd5e2033e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:37:38 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:37:33 +0000
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
Subject: [PATCH v3 00/12] notifier: add device-managed registration APIs and convert drivers
Date: Sun, 26 Jul 2026 06:37:15 +0000
Message-ID: <20260726063727.19111-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Many drivers repeat the same boilerplate when registering notifiers with
device lifetime:

  1. Register the notifier with *_notifier_chain_register()
  2. Check for error
  3. Register a devm action to unregister on teardown
  4. Implement a per-driver static unregister callback

This series adds devm_atomic_notifier_chain_register() and
devm_blocking_notifier_chain_register() that automatically unregister
the notifier when the device is unbound, then converts 11 drivers to use
them.

Each conversion eliminates a per-driver unregister callback and the
associated devm_add_action_or_reset() call, reducing code by ~15 lines
per driver.

The implementation follows the established devres pattern used by other
device-managed kernel APIs.

Changes in v3:
- Patch 1: drop devm_raw_notifier_chain_register() since raw notifiers
  require caller-provided locking which is incompatible with the devres
  teardown callback (Sashiko)
- Patch 12: fix commit message to accurately describe the old code as
  using devres_alloc() + register_reboot_notifier(), not
  devm_add_action_or_reset() (Sashiko)

Changes in v2:
- Patch 1: drop 'extern' from new function prototypes (Bart Van Assche)
- Patch 1: fix kerneldoc to use 'Return:' format (Bart Van Assche)
- Patch 1: use <linux/device/devres.h> instead of <linux/device.h>
  (Andy Shevchenko)
- Patch 8: also remove unused ghes_register_vendor_record_notifier() and
  ghes_unregister_vendor_record_notifier() along with their exports and
  ghes.h declarations (Jonathan Cameron)

Eliav Farber (12):
  notifier: add device-managed registration APIs
  pwm: iqs620a: use devm_blocking_notifier_chain_register()
  iio: light: iqs621-als: use devm_blocking_notifier_chain_register()
  iio: position: iqs624: use devm_blocking_notifier_chain_register()
  gpio: adp5585: use devm_blocking_notifier_chain_register()
  platform/x86: bitland-mifs-wmi: use
    devm_blocking_notifier_chain_register()
  Input: adp5585: use devm_blocking_notifier_chain_register()
  ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
  platform/x86: uniwill-wmi: use devm_blocking_notifier_chain_register()
  gpio: eic-sprd: use devm_atomic_notifier_chain_register()
  gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
  reboot: use devm_blocking_notifier_chain_register()

 drivers/acpi/apei/ghes.c                   |  27 +-----
 drivers/gpio/gpio-adp5585.c                |  20 +---
 drivers/gpio/gpio-eic-sprd.c               |  17 +---
 drivers/gpio/gpiolib-kunit.c               |  14 +--
 drivers/iio/light/iqs621-als.c             |  24 +----
 drivers/iio/position/iqs624-pos.c          |  24 +----
 drivers/input/keyboard/adp5585-keys.c      |  18 +---
 drivers/platform/x86/bitland-mifs-wmi.c    |  17 +---
 drivers/platform/x86/uniwill/uniwill-wmi.c |  17 +---
 drivers/pwm/pwm-iqs620a.c                  |  21 +----
 include/acpi/ghes.h                        |  16 ----
 include/linux/notifier.h                   |   7 ++
 kernel/notifier.c                          | 103 +++++++++++++++++++++
 kernel/reboot.c                            |  24 +----
 14 files changed, 140 insertions(+), 209 deletions(-)

-- 
2.47.3

