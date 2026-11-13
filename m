Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566550;
	b=EoS1Swo17jtQ5dwCbhqQOIoNhyhKkzy8UFzU9YOCI7odHUTevzw0PGnlM2LZmij6snPZ
	 E6Uc2Wt8G7aPIc1RTHUHXrYnf6tEwhSb37GuNM2KM8BpSU0nPKA/+Mh+9MnA0rbGheyLo
	 xRVuvTFD90lyWTP9cueWuQRf5m8MQRMrSnFyf6mXEBV+0b43jYD4ASumr5rKkHg7AmT2N
	 GEfRY5Q2GzBI1IOdwDqaZXISmfEyccTzI7/2gCE+eHMX1KLid1T/Js4/Z8ckHlvHynUP7
	 PADMdRJY8yGB/f8a7JR5R3GOpKrOenAZOTzVi/5J8KpgjQr6HFOpoqYoGFXmAwkILMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566550;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=Imm14NIi8H5Q16VyabkUWRdp71FBLi9E+jVS7X0zunk=;
	b=f5/xOPu1vdUWfnc+8Wq7aGTewmRgcHh56jxSL64zUZGI4gG0NP8pP4QiWTGGtx8qMwJS
	 R5uhYyO8APYf7AyZJIjqvg8q46DZIGSojzd+4P87vCKLzpmLgcI//5POw01QkgVdH1FVw
	 NHb9a0+bBVyAwMrgNpyDT5EsQD/bioaSsY5bsbjnx7eCTrEKMreJytEa7FD20wdXpwY7d
	 T+oGVqKNcZwQ0ZaX8lxR3/q7gGQpRJzWv/3+4x0KN7FDvH0glF9SOoSXpk6eJ2fG5qWRe
	 /B1k+KKfSS0LIR2CG18Tf7qz+Yq/SeWycZcdYBFPePP44r9w8l2hGJtMhyw72oiHwlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=reA+jITP;
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3119606A330;
	Fri, 13 Nov 2026 10:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3119606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=reA+jITP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794566549; x=1826102549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Imm14NIi8H5Q16VyabkUWRdp71FBLi9E+jVS7X0zunk=;
  b=reA+jITP9DjAZRJuSf7pnGSH1UnfFSovyqcnc+b8AirmkISaiq8t0lyR
   kHLyN5Zymfbv0KoeQwrHwB7H9AP1+/Y2cTw+d3uRiBug4qVmlCa8beQTD
   +x973psOm7QPBrnPPgI50GcxjIRJG1+5NmF6LN3k57zwXwHyqUfMQpdpJ
   /Ccnp3RJDSAv7ZZNPbfVevJpoxtPSnk7RE7Ci7iwTefhLv3ZfOmq6Xzv3
   TJHFAokyMlgpNIIjrzQUiVQAz0yBsKQ3yr8pofyPRnJHBDu+beQjj+6yp
   +XUoUb4SkBWINCvcfU7jTPOPAnGB3k6bOWU+zTZpXCCiaM76ADomDyyjp
   g==;
X-CSE-ConnectionGUID: 3vMfAQYVS5y5mJHrnHx35Q==
X-CSE-MsgGUID: Fl042saRRQq7q41xme99Ng==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33648523"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:42:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:3217]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 6d236261-7775-4822-b4c6-309f8ed89251; Fri, 13 Nov 2026 10:42:26 +0000 (UTC)
X-Farcaster-Flow-ID: 6d236261-7775-4822-b4c6-309f8ed89251
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 10:42:26 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 10:42:23 +0000
From: Eliav Farber <farbere@amazon.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf
	<W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Eliav Farber <farbere@amazon.com>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-input@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH v6 0/7] notifier: convert remaining drivers to device-managed registration
Date: Fri, 13 Nov 2026 10:42:02 +0000
Message-ID: <20261113104218.32566-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The devm_atomic_notifier_chain_register() and
devm_blocking_notifier_chain_register() helpers this series added in v5
are now in mainline, together with 6 of the 11 driver conversions. This
revision carries the 6 conversions that were never picked up, plus one
new conversion for a driver that grew the old pattern after v5 was
posted.

Background, unchanged from v5. Many drivers repeat the same boilerplate
when registering notifiers with device lifetime:

  1. Register the notifier with *_notifier_chain_register()
  2. Check for error
  3. Register a devm action to unregister on teardown
  4. Implement a per-driver static unregister callback

The devm_*_notifier_chain_register() helpers reduce that to a single
call with one error path, eliminating the per-driver unregister
callback. Each conversion drops ~15 lines; this revision removes 117
lines and adds 18.

Already in mainline, so dropped from this revision:

  v5       commit        subject
  1/13     e38b9eda475f  notifier: add device-managed registration APIs
  2/13     6b0c6ff76795  pwm: iqs620a
  3/13     8c77589a7274  iio: light: iqs621-als
  4/13     c9f54ead5793  iio: position: iqs624
  5/13     870f46a42afd  gpio: adp5585
  11/13    323906906101  gpio: eic-sprd
  12/13    df6501bf6fc4  gpio: gpiolib-kunit

What is left, with the v5 numbering for anyone who reviewed it then:

  v6   v5      subject
  1/7  6/13    platform/x86: bitland-mifs-wmi
  2/7  7/13    Input: adp5585
  3/7  8/13    ACPI: APEI: GHES: remove unused ghes_{,un}register_...
  4/7  9/13    ACPI: APEI: GHES: use devm_...
  5/7  10/13   platform/x86: uniwill-wmi
  6/7  13/13   reboot
  7/7  -       power: supply: cros_pchg (new in v6)

The patches are independent and can go through their own trees. The only
ordering constraint is that patch 3 must precede patch 4: patch 3 removes
the unused exports, patch 4 converts what is left. The devm helpers are
already upstream, so unlike v5 this revision needs no base commit or
pull request to build.

Suggested routing, since the series now spans five trees:

  1/7, 5/7  platform-drivers-x86
  2/7       input
  3/7, 4/7  acpi, in this order
  6/7       kernel/reboot.c has no MAINTAINERS entry, so it falls to
            THE REST
  7/7       power-supply

Each patch is Cc'd to its own subsystem lists only, so no list receives
patches it does not own. linux-kernel receives all of them.

v5: https://lore.kernel.org/all/20260816060648.4030-1-farbere@amazon.com/

Changes in v6:
- Dropped the 7 patches now in mainline, listed above.
- Rebased onto v7.4-rc1. No conflicts; the 6 carried patches are
  functionally unchanged from v5.
- Patch 3: replaced an em dash in the commit message with an ASCII
  hyphen. No change to the code.
- Patch 6: the commit message now records that the removed callback's
  WARN_ON() on a failed unregister goes away, because
  devm_blocking_notifier_chain_register() ignores the unregister return
  value. No in-tree caller can trigger it. No change to the code.
- Patch 7: new. cros_pchg grew the
  blocking_notifier_chain_register() + devm_add_action_or_reset()
  pattern in 631adfa03595 ("power: supply: cros_pchg: unregister EC
  notifier"), which reached mainline in v7.3-rc1, five days after v5
  was posted.
- Carried forward the Acked-by and Reviewed-by tags given on v1 and v4.
  Each was checked against the patch it was given for: all four are
  byte-identical to the version here.

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

Eliav Farber (7):
  platform/x86: bitland-mifs-wmi: use
    devm_blocking_notifier_chain_register()
  Input: adp5585: use devm_blocking_notifier_chain_register()
  ACPI: APEI: GHES: remove unused
    ghes_{,un}register_vendor_record_notifier()
  ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
  platform/x86: uniwill-wmi: use devm_blocking_notifier_chain_register()
  reboot: use devm_blocking_notifier_chain_register()
  power: supply: cros_pchg: use devm_blocking_notifier_chain_register()

 drivers/acpi/apei/ghes.c                      | 27 +++----------------
 drivers/input/keyboard/adp5585-keys.c         | 18 +++----------
 drivers/platform/x86/bitland-mifs-wmi.c       | 17 +++---------
 drivers/platform/x86/uniwill/uniwill-wmi.c    | 17 +++---------
 .../power/supply/cros_peripheral_charger.c    | 16 +++--------
 include/acpi/ghes.h                           | 16 -----------
 kernel/reboot.c                               | 24 ++---------------
 7 files changed, 18 insertions(+), 117 deletions(-)


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.47.3

