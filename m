Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844D14883F;
	Thu, 23 Jul 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829220; cv=none; b=GipYwANZIMFcauOSoMWjn2WzQR6N81UBePsQfnu7Ef3+V/oVdlisSrlGpivrwnbWbJFM+tpJgiwNHs455oYOzjijRlBIrg66gri0cBDkxzHkyZZfHikF5StD7+nJmu8rG7hAcEwZ5bbFaXmt7ldul3ocHZozuonyKke4LxBEfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829220; c=relaxed/simple;
	bh=uoZoVwOPdmdlUK8IwvU+L50ZgJrmKaIJlodOtkreFrc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GfmOh/0xXWSierIBZyHSlANwFsoUjGOZSkGMP0qDAeS0/RRhMsggVIXfdOYvulM2TvQhpSsWZ3Hd32hzCoMHSfRSrf1A95+ZvKd2+5HeZAUFxUdkXnbn4mKlhVWzQ+TpAcqP1f0ESbHtzxDO6dEoGrT8MtPIcmEuMO4PgL93Dlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dC6kr7E0; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="dC6kr7E0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829219; x=1816365219;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VRR830S5Crc5qLMak5M08xcwDHqS7wix0djaEazdHfc=;
  b=dC6kr7E0n/VMEE6xMPkyZeNAmTvIE6MJVjUKR/5Xc0suOaR31qgAi4gl
   pd+eQZ9SyQROOgZdrqjRmMPWOJco0C5cfupPlnT7JqYEddw+MERIQAsqC
   2QnM7S9x3D4q3ZHtbr4aApWwWHlE9L65S3zzj0uk9AXgBQE1loKqQ05uZ
   /A1VOz7vOLm2iZzwqObYTnHseppTxF1vD7W3b6H+DhLWJI7loyCBpnktg
   1YHQjWxMJpUsatzVjW8bzMklVkuPJ8W0G9DBGSD8zGAjCBNA0UWIVHILl
   GAT7V7W6e3rn7V6Ixhw+wLhT8sgbysst5SbRRup/kXxLqpSg+PSJM0JZn
   w==;
X-CSE-ConnectionGUID: hQH62+quTTKqUPCe8dab8g==
X-CSE-MsgGUID: 5eTgeY77QKWhwQVb6PB5Nw==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="23748203"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:53:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:5323]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.152:2525] with esmtp (Farcaster)
 id 630eda6d-2947-4491-9f8d-3b91b305424a; Thu, 23 Jul 2026 17:53:36 +0000 (UTC)
X-Farcaster-Flow-ID: 630eda6d-2947-4491-9f8d-3b91b305424a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:53:36 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:53:31 +0000
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
Subject: [PATCH 00/12] notifier: add device-managed registration APIs and convert drivers
Date: Thu, 23 Jul 2026 17:53:13 +0000
Message-ID: <20260723175325.37397-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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

Checkpatch reports 6 CHECKs (0 errors, 0 warnings) on patch 1:
- "extern prototypes should be avoided in .h files"
- "Alignment should match open parenthesis"

Both are intentional to match the existing coding style in notifier.h,
where all declarations use 'extern' and tab-indented continuation lines.

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

 drivers/acpi/apei/ghes.c                   |  15 +-
 drivers/gpio/gpio-adp5585.c                |  20 +--
 drivers/gpio/gpio-eic-sprd.c               |  17 +--
 drivers/gpio/gpiolib-kunit.c               |  14 +-
 drivers/iio/light/iqs621-als.c             |  24 +---
 drivers/iio/position/iqs624-pos.c          |  24 +---
 drivers/input/keyboard/adp5585-keys.c      |  18 +--
 drivers/platform/x86/bitland-mifs-wmi.c    |  17 +--
 drivers/platform/x86/uniwill/uniwill-wmi.c |  17 +--
 drivers/pwm/pwm-iqs620a.c                  |  21 +--
 include/linux/notifier.h                   |  10 ++
 kernel/notifier.c                          | 151 +++++++++++++++++++++
 kernel/reboot.c                            |  24 +---
 13 files changed, 191 insertions(+), 181 deletions(-)

-- 
2.47.3

