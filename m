Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A252566D3;
	Sun, 26 Jul 2026 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041841; cv=none; b=hjXF04ein+zxbdPzTG4Ao/Ej98k/mDmbaTgTx2T6zYPkDxqYDTX3bDd//n6t76CC+i1sh77JyYWCJxxNir0I8WRbAhw5VQR5vtMwfaPXrcqr77nYgPb4wu+IuQJ/bK1oS1+eKOF/wbd5KGTcarkVSUOcQJPmP+2awleu5Rr4hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041841; c=relaxed/simple;
	bh=LdC9V2C4ZuIOwyUmxkv1p82BCvbETzaZNXiGmlECT6U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwvCNh/MHtZMn6LRjc5hQBT9ERD4zXJAKKG0D3VBPSJmPm0AtiTGm0gDbNSAb62hZJeom29lOlRPzPYprzekLK2PtQR8EzP38MZtft+dvIzNIIkwxqmK46syWaepnjKFsuFeDc5IPx1zng0B0U678yWj1q7Zwn0/ui4gquCyFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=t1Wzn/vP; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="t1Wzn/vP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041840; x=1816577840;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bJDMUcUHPNBf6BR/wpYBoP8vGH0np4DWmz+zQEDCd3Y=;
  b=t1Wzn/vPNVn8IpRbrmwdRFSArVndUCLMNoiLwIuLqWfJThSVO42nby2m
   4S+XyQf6Uy2wUhRVe8zOhxzE7CCrUGXzDtyHM3G26hePuzv2I0JfOwe1P
   R486cetj2bin5F7mp1UTwYk/7o0xNgOq+YxIJysWou65QHCRlb5St03Qz
   8Xqu8W23JWGUHtjKUrjWQXenLBCzGBlXVculVSD3vDBXaCMaUcA0sV8lC
   1hqhgnnSSWO0+kghgI54q4tJ2chikidYhNNx7B/CpxX3gf/IwzHnT9zeA
   gKV7osvOihSApzFLJxbAhlMqgqmO38ie7vZt2XIBBaZWJGQqBW0db2KXT
   w==;
X-CSE-ConnectionGUID: 4uAnmXglRMeedCEp/h3UxQ==
X-CSE-MsgGUID: VzHEYbKRTX+CRw+KXXhoWg==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24340313"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:57:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:13467]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id 361d920a-7bcb-4133-aeff-55382c6ece46; Sun, 26 Jul 2026 04:57:17 +0000 (UTC)
X-Farcaster-Flow-ID: 361d920a-7bcb-4133-aeff-55382c6ece46
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:57:16 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:57:11 +0000
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
Subject: [PATCH v2 00/12] notifier: add device-managed registration APIs and convert drivers
Date: Sun, 26 Jul 2026 04:56:54 +0000
Message-ID: <20260726045706.8169-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Many drivers repeat the same boilerplate when registering notifiers with
device lifetime:

  1. Register the notifier with *_notifier_chain_register()
  2. Check for error
  3. Register a devm action to unregister on teardown
  4. Implement a per-driver static unregister callback

This series adds devm_atomic_notifier_chain_register(),
devm_blocking_notifier_chain_register(), and
devm_raw_notifier_chain_register() that automatically unregister the
notifier when the device is unbound, then converts 11 drivers to use
them.

Each conversion eliminates a per-driver unregister callback and the
associated devm_add_action_or_reset() call, reducing code by ~15 lines
per driver.

The implementation follows the established devres pattern used by other
device-managed kernel APIs.

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

 drivers/acpi/apei/ghes.c                   |  27 +---
 drivers/gpio/gpio-adp5585.c                |  20 +--
 drivers/gpio/gpio-eic-sprd.c               |  17 +--
 drivers/gpio/gpiolib-kunit.c               |  14 +-
 drivers/iio/light/iqs621-als.c             |  24 +---
 drivers/iio/position/iqs624-pos.c          |  24 +---
 drivers/input/keyboard/adp5585-keys.c      |  18 +--
 drivers/platform/x86/bitland-mifs-wmi.c    |  17 +--
 drivers/platform/x86/uniwill/uniwill-wmi.c |  17 +--
 drivers/pwm/pwm-iqs620a.c                  |  21 +--
 include/acpi/ghes.h                        |  16 ---
 include/linux/notifier.h                   |  10 ++
 kernel/notifier.c                          | 154 +++++++++++++++++++++
 kernel/reboot.c                            |  24 +---
 14 files changed, 194 insertions(+), 209 deletions(-)

-- 
2.47.3

