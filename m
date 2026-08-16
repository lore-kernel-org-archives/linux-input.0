Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B122EC0A4;
	Sun, 16 Aug 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860423; cv=none; b=kZIq+wGP9kAKwuD9GNEHgulTlxyeN7TQx8sKjKcypg0cFugoheFKjDQShmlGX6Jk0R1aKLwtDpPA2lv73f5NJEHyU/acwwhbD2lzGmt4lqcZYnuPfokY3aTBp4q13Wyt274K2McNrIu3yac6htsFHu5i2WOodrfGEzstWeGPcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860423; c=relaxed/simple;
	bh=HxafYqtgG7/GaiUhYdXspzcNdlhVyAko+xEiezFUqyE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L29nut2oUi6M++pEi/HO6dWpNdHKTvXb/cultJGIj+9U38MKmp4KqprJuI3o+UFXoN+OkFDb4TcyRXAoEO6CX8Gw5D6VSsNLJXInD/WWw/wDa914C/YAwOV/dE0ICufONImDZHq7sokxRXFl9RjdokYRMuSbxhbcpie6jeMSYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DADQIC72; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DADQIC72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860422; x=1818396422;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1pDwgsn3Zd80VU4fgwCZEWyn8GyO4XKB8QZHKsTuv1U=;
  b=DADQIC72S57K9Yog6UDjGwp2ggAfR64HUuu8Q2/r32Jix9MNlND1ltFd
   H0OrLc1yP8RLhjKcOhwIJrofc6+NcWqDBiG68JMOPxoRNtYYmyA6ohfEL
   t1Ulk71ceEdrj5AomvSD2Kwinb0JMe+nVEgNMaw/OZxmTFFeWPJqzaCPW
   iz0alBM84W4R4qrKhKyTivrQ7gQljIM2QMSEiwXxInzy9sFm+Zy5yjYw8
   +OqLZIlOY5XGHY5rej5mpYqwMRI10FNvlMnYDbcng5dH4GDIr6Dimuj+E
   2XEOnArHUnaEOkFx+JFqboVYXk7BDup1AD+EuuAQifpwvKXTLw5Fn1cQm
   g==;
X-CSE-ConnectionGUID: Qj9tZpv7SG2OVbw2g6u8Rw==
X-CSE-MsgGUID: 7Y96VhwuSWK2sGX+9E+ovw==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25878582"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:06:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:2804]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.160:2525] with esmtp (Farcaster)
 id 258b264e-d0d7-4745-9adb-746dfae7c9d3; Sun, 16 Aug 2026 06:06:59 +0000 (UTC)
X-Farcaster-Flow-ID: 258b264e-d0d7-4745-9adb-746dfae7c9d3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:06:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:06:53 +0000
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
Subject: [PATCH v5 00/13] notifier: add device-managed registration APIs and convert drivers
Date: Sun, 16 Aug 2026 06:05:59 +0000
Message-ID: <20260816060648.4030-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
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

Changes in v5:
- Patch 1: rename notifier_block parameter from 'n' to 'nb' to match
  the devres struct field name (Uwe Kleine-König)
- Patch 2: remove extra blank line left after deleting the unregister
  callback (Uwe Kleine-König)

Changes in v4:
- Patch 8: split the removal of unused
  ghes_register_vendor_record_notifier() and
  ghes_unregister_vendor_record_notifier() into a separate preceding
  patch (Andy Shevchenko)

Changes in v3:
- Patch 1: drop devm_raw_notifier_chain_register() since raw notifiers
  require caller-provided locking which is incompatible with the devres
  teardown callback (Sashiko)
- Patch 12: fix commit message to accurately describe the old code as
  using devres_alloc() + register_reboot_notifier() (Sashiko)

Changes in v2:
- Patch 1: drop 'extern' from new function prototypes (Bart Van Assche)
- Patch 1: fix kerneldoc to use 'Return:' format (Bart Van Assche)
- Patch 1: use <linux/device/devres.h> instead of <linux/device.h>
  (Andy Shevchenko)
- Patch 8: also remove unused ghes_register_vendor_record_notifier() and
  ghes_unregister_vendor_record_notifier() along with their exports and
  ghes.h declarations (Jonathan Cameron)

Eliav Farber (13):
  notifier: add device-managed registration APIs
  pwm: iqs620a: use devm_blocking_notifier_chain_register()
  iio: light: iqs621-als: use devm_blocking_notifier_chain_register()
  iio: position: iqs624: use devm_blocking_notifier_chain_register()
  gpio: adp5585: use devm_blocking_notifier_chain_register()
  platform/x86: bitland-mifs-wmi: use
    devm_blocking_notifier_chain_register()
  Input: adp5585: use devm_blocking_notifier_chain_register()
  ACPI: APEI: GHES: remove unused
    ghes_{,un}register_vendor_record_notifier()
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
 drivers/pwm/pwm-iqs620a.c                  |  23 +----
 include/acpi/ghes.h                        |  16 ----
 include/linux/notifier.h                   |   7 ++
 kernel/notifier.c                          | 103 +++++++++++++++++++++
 kernel/reboot.c                            |  24 +----
 14 files changed, 140 insertions(+), 211 deletions(-)

-- 
2.47.3

