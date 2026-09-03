Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7D415B6A;
	Thu,  3 Sep 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420976; cv=none; b=FLXqi/FUs1JiJ5ldPCy0o9BUbR5z08aI3QN0WEq/J/4A2PQ7V6Hpgk9miRAjEA9U3pUU8Tti2DTvLzX7GlJfET8qF92vcH7iNqKiboVRMP22U4PmetNj4UD7jvGQtuHXantubepKoJoImXbk8G8wDwp878zyBOyhmYtJLJbH5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420976; c=relaxed/simple;
	bh=vOc+JwjRR6tI+WSQ3JtANgEVfvSQqg65Z1akmvCZm6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2ExWZcnTOsgb7Zda/Ekkv/o/nrtG5VogQhdVODyiosz3P+2QKWR9Xp2AHeHnllHNNYDx71HJK8pFOrMDkrDjvUbRshGKfnzKgrRiuXhjeZhktPMHNZmnmiHSZS5G7IJqjdKky8CjPcUfjNRuVyBFjcf6NKeBj1+IZm7jG/dy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=a5hctA6M; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="a5hctA6M"
Received: from aerhardt-tuxedo.. (dynamic-176-002-009-249.176.2.pool.telefonica.de [176.2.9.249])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 678DE2FC0079;
	Thu,  3 Sep 2026 09:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1788420965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jhdp4nopPfzNM0EXqyYe/+2900WOXntdvyvEjrP1i+E=;
	b=a5hctA6MYv9e6BB90rtubCs87A2P9PogJ9+c4pSktqy6xzm5bHbZhISQaKWGJVzkr22m0J
	BgWIBXvAwRnvlIhg3wDJpQ3RxhK0hpOSYpjCbdfzMkebXUe2kcDwjPWEZDbV8xaFZ0TRka
	kgSXn6aMb1RBk+DZJFQjzQLhsh44HrE=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Aaron Erhardt <aer@tuxedocomputers.com>,
	wse@tuxedocomputers.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] HID: generic: add LampArray support via hid-lamparray helper
Date: Thu,  3 Sep 2026 09:35:44 +0200
Message-ID: <20260903073602.3815258-1-aer@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new hid-lamparray helper module and integrate it with the
hid-generic driver.

While more complex lamparray handling should be done in userspace via
hidraw, providing a small module to add basic lamparray support makes it
possible for userspace software to interact with lamparrays by simply
using well-known APIs of the LED subsystem. One use-case would be to
enable desktop environments to support keyboard backlight control out of
the box for HID lamparray devices without having to implement the whole
HID protocol themselves.

This patch is based on previous discussions:
https://lore.kernel.org/all/1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com/

The helper provides basic support for devices exposing a
Lighting/LampArray application collection (usage page 0x59) and
registers a single-zone RGB LED representation via the LED
subsystem.

hid-generic now checks for LampArray support after hid_parse() and
optionally registers a lamparray instance. Failures in the helper
do not abort device probe to keep the driver logic otherwise unchanged.

LampArray resources are released on driver remove.

This commit was successfully tested on the Microsoft MacroPad reference
implementation (https://github.com/microsoft/RP2040MacropadHidSample
1d6c3ad) and in combination with the tuxedo_nb04_wmi driver, albeit
only fully functional with a recent fix posted to the LKML
(https://lore.kernel.org/all/20260826081149.235487-2-aer@tuxedocomputers.com).

v5:
- Proper hardware detection (no quirks necessary anymore)
- Add documentation for new sysfs knob
- Pass limits of the device to sysfs (intesities & brightness)
- More flexible Kconfig (use tristate)
- Improved locking
- Several memory leak and (de-)initialization fixes
- Don't read current color values from hardware (the HID spec does not
  offer this option)
- Remove redundant report dump functionality
v4:
- Restrict CONFIG_HID_LAMPARRAY to built-in configurations only to fix
  additional randconfig build errors
v3:
- Squash V1 and V2 into one patch
v2:
- Fix Kconfig to avoid build errors when LEDS_CLASS_MULTICOLOR is
  disabled

Aaron Erhardt (2):
  HID: lamparray: add new LampArray helper module
  HID: generic: add LampArray support via hid-lamparray helper

 .../ABI/testing/sysfs-driver-hid-lamparray    |  16 +
 drivers/hid/Kconfig                           |  18 +
 drivers/hid/Makefile                          |   2 +
 drivers/hid/hid-generic.c                     |  38 +
 drivers/hid/hid-lamparray.c                   | 812 ++++++++++++++++++
 include/linux/hid-lamparray.h                 |  88 ++
 6 files changed, 974 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lamparray
 create mode 100644 drivers/hid/hid-lamparray.c
 create mode 100644 include/linux/hid-lamparray.h

-- 
2.43.0

