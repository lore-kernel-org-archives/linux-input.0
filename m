Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11520361666;
	Wed, 16 Sep 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570146; cv=none; b=HXH26c7RT+omA76gJo4G1avqYy3cJD1ERfR1Zvu9OoFsb9j9Abx8ApKmpgT9ar3+rnFeji5YhEaRtytSckCpOcMGblhMONAhppo4qHHHScgnQcGiNLEA36c+EHsLmTVmEUcig5rylNY7pbIzzsfzmAvKta2zL+wkSCsS383H3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570146; c=relaxed/simple;
	bh=v00yz0tIo1ahwuZSRS/kb6QbJTP+Ru1ioddeQuj9bPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dipxIQku8o3tJY67AzU06lashx4LDt2uRzKrzmmvxS8RmkFojb1M95ViJt+CkQyTGggdBM2X32JINMfswQEZXrMu9gML9k/bGT7RJRKPJGirQCGKRsIB3TEY/SPyjBlwaOKcZ40hBrmAi+5uv5mO/CqnAIrONVw177/2GCB0MxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=dWoOHh0s; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="dWoOHh0s"
Received: from aerhardt-tuxedo.fritz.box (p57b95085.dip0.t-ipconnect.de [87.185.80.133])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id CCCC62FC0059;
	Wed, 16 Sep 2026 16:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1789570135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=80xqlOIAKRUDfKYggN59FlsXMfpmvws1iwR8iLGZfjY=;
	b=dWoOHh0s4Ox+gxNySGxuLB8/ltMo2ejScRMni9eMORgo5HLfMWTM4XwsQhuGZXqSQXcBmY
	EJShZtKrtzJxlPpUml2xlW4LnTnAcMCyacUXt8Lkw3pT5xoErZkuB4Ez95le1LtPHmS29i
	2OP0v15F1cOLCCDBM56zdp/gXIq5Cpo=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Aaron Erhardt <aer@tuxedocomputers.com>,
	wse@tuxedocomputers.com,
	Cristian Mazzotta <cmmazzo@icloud.com>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] HID: generic: add LampArray support via hid-lamparray helper
Date: Wed, 16 Sep 2026 16:48:30 +0200
Message-ID: <20260916144838.456239-1-aer@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new hid-lamparray helper module and integrate it with the hid-generic
driver.

While more complex lamparray handling should be done in userspace via hidraw,
providing a small module to add basic lamparray support makes it possible for
userspace software to interact with lamparrays by simply using well-known APIs
of the LED subsystem. One use-case would be to enable desktop environments to
support keyboard backlight control out of the box for HID lamparray devices
without having to implement the whole HID protocol themselves.

This patch is based on previous discussions:
https://lore.kernel.org/all/1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com/

The helper provides basic support for devices exposing a Lighting/LampArray
application collection (usage page 0x59) and registers a single-zone RGB LED
representation via the LED subsystem.

hid-generic now checks for LampArray support after hid_parse() and optionally
registers a lamparray instance. Failures in the helper do not abort device probe
to keep the driver logic otherwise unchanged.

LampArray resources are released on driver remove.

This commit was successfully tested on the Microsoft MacroPad reference
implementation (https://github.com/microsoft/RP2040MacropadHidSample 1d6c3ad)
and in combination with the tuxedo_nb04_wmi driver, albeit only fully functional
with a recent fix posted to the LKML
(https://lore.kernel.org/all/20260826081149.235487-2-aer@tuxedocomputers.com).

Others reported the driver to work on the Acer Predator PT14-52T and the ASUS
Prime B650-Plus, with the former requiring some patches on top of v5, which
should now be included in v6.

v6:
- Read attribute reports synchronously (by Cristian Mazotta)
- Raise log level of fatal probe errors (by Cristian Mazotta)
- Transfer control when use_leds_uapi changes (by Cristian Mazotta)
- Blank lamps across suspend and restore on resume (by Cristian Mazotta)
- Add quirk for devices that ignore intensities (reported by Armin Wolf)
- Better locking, fixing rare races in uapi registration
- Use scope guards for locking and allocations where possible
- Remove obsolete calls to led_mc_calc_color_components and
  hid_device_io_start/stop
- Updated and slightly improved documentation
v5:
- Proper hardware detection (no quirks necessary anymore)
- Add documentation for new sysfs knob
- Pass limits of the device to sysfs (intensities & brightness)
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

Cristian Mazzotta (1):
  HID: lamparray: blank lamps across suspend and restore on resume

 .../ABI/testing/sysfs-driver-hid-lamparray    |  15 +
 drivers/hid/Kconfig                           |  18 +
 drivers/hid/Makefile                          |   2 +
 drivers/hid/hid-generic.c                     |  70 +-
 drivers/hid/hid-lamparray.c                   | 907 ++++++++++++++++++
 include/linux/hid-lamparray.h                 | 117 +++
 6 files changed, 1128 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lamparray
 create mode 100644 drivers/hid/hid-lamparray.c
 create mode 100644 include/linux/hid-lamparray.h

-- 
2.43.0

