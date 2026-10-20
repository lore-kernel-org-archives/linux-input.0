Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.90.84.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489995;
	b=gLg49d45uUElf8py22OeHvmdqO9cnXDCFl5epmmpQnKVCemXC9IVk6IV79uh0UxLouPr
	 kkEAQfelVUHaEWRINkISKAdzWNPOgvLFhCaxg9OeGL0M4CWnSIsrRJR9+LWa8FLYXl9Fm
	 GT8f7WFzqxfOX/YVdJN9qgiGy3wwrLZAe5vy1KbBZhah+7iQT5H1jfyqRjTtEGM5+TD7b
	 xyMSapK7E6YSBfPcSo9z5nWDhAGjYbHVIdtLw3LGf2VYT0Li7mTh1d+NKILTvLsZsKopB
	 owdBazTSVbHbRbDW4WniR5Y81etVwitSbjFRw2DhUs1BIxd1UXlbmrC/LTB52fSyMcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489995;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=iBm7nKcdxGcP2XmL/BoyALjoY1B+1zyhy13dnFLpCCM=;
	b=HsitXjFlE3KCsg6RILVxCtd6j+t8qLbE9kNC3fiaha4+jo1s3BpqinGFsRVUXYXcWQEN
	 1GAhW4aA+pn0yoUL7SOrUJZ4Ltt/uWJGQom+KTWaPownu8TY1+Nyy0xRmzpu0LogDz88l
	 Kny/DNu0UUaITqi98wlDy2Rmd4dVltAy857sgKRXYIqqXj0GysxK9N7JqDg33OebXWhl/
	 xGza9SWEzODMGAdGRxUjh5tMJ8G+li37YuvMTWevtDscO2vCkW2Cbi5ebMYofmdDClj+8
	 Vj7fyNJUm5acVISy5tx1aGMANnDEe31uncX1rZ9YO3prt/7fSzTOPoneAd8v2Fv2/Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tuxedocomputers.com;
	spf=pass smtp.mailfrom=tuxedocomputers.com;
	dkim=pass header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.a=rsa-sha256 header.s=default header.b=q8HDHaCv;
	arc=none smtp.remote-ip=157.90.84.7
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0340606A31F;
	Tue, 20 Oct 2026 09:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0340606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.a=rsa-sha256 header.s=default header.b=q8HDHaCv
Received: from [127.0.1.1] (business-024-134-105-141.24.134.pools.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 60AA22FC005D;
	Tue, 20 Oct 2026 11:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1792489985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iBm7nKcdxGcP2XmL/BoyALjoY1B+1zyhy13dnFLpCCM=;
	b=q8HDHaCvpSkU3eX4vZF5O5zZcU2Fd/So/mHLsaZ4yfo3tsdH7dNHy35xRXRYzhP/+JWU7K
	HXyQP9pL2vKLZObsGfEP0PMx/P11zPjb4U6BO9XkpTi9H9emIfLyNH4STzRZI2SGsA80hp
	gDPmzC4HoRIfACRHzUXgspfrZ0zGAKI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
Subject: [PATCH v7 0/3] HID: generic: add LampArray support via
 hid-lamparray helper
Date: Tue, 20 Oct 2026 11:51:46 +0200
Message-Id: <20261020-hid-lamparray-v7-0-47418b667b47@tuxedocomputers.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALI512oC/z3MQQ6CMBCF4auQWTukLbWAK+9hXIwwlSZCyRQMh
 nB3Gxfu3rd4/w6JJXCCS7GD8DukEKeM+lRAN9D0ZAx9NhhlnFZG4RB6fNE4kwh90Pnakalbzc0
 D8mcW9mH79W73bC9xxGUQpn9Ftdppa5uqKe3ZmapFjcRyXdaN+9jFcV4XllTmBcfxBZMMLlShA
 AAA
X-Change-ID: 20261020-hid-lamparray-6f76a2791e8b
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Cristian Mazzotta <cmmazzo@icloud.com>, 
 Werner Sembach <wse@tuxedocomputers.com>, Armin Wolf <W_Armin@gmx.de>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Tim Guttzeit <tgu@tuxedocomputers.com>, 
 Aaron Erhardt <aer@tuxedocomputers.com>
X-Mailer: b4 0.15.2

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
registers a single-zone RGB LED representation via the LED subsystem.

hid-generic now checks for LampArray support after hid_parse() and
optionally registers a lamparray instance. Failures in the helper do not
abort device probe to keep the driver logic otherwise unchanged.

LampArray resources are released on driver remove.

This commit was successfully tested on the Microsoft MacroPad reference
implementation (https://github.com/microsoft/RP2040MacropadHidSample
1d6c3ad) and in combination with the tuxedo_nb04_wmi driver, albeit only
fully functional with a recent fix already on
platform-drivers-x86/for-next
(https://lore.kernel.org/all/20261007080202.81694-1-aer@tuxedocomputers.com).

Others reported the driver to work on the Acer Predator PT14-52T and the
ASUS Prime B650-Plus, with the former requiring some patches on top of
v5, which should now be included in v6.

v7:
- Use white with zero brightness as new default
- Fix measurements in comments and commit message
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

---
Aaron Erhardt (2):
      HID: lamparray: add new LampArray helper module
      HID: generic: add LampArray support via hid-lamparray helper

Cristian Mazzotta (1):
      HID: lamparray: blank lamps across suspend and restore on resume

 .../ABI/testing/sysfs-driver-hid-lamparray         |  15 +
 drivers/hid/Kconfig                                |  18 +
 drivers/hid/Makefile                               |   2 +
 drivers/hid/hid-generic.c                          |  70 +-
 drivers/hid/hid-lamparray.c                        | 912 +++++++++++++++++++++
 include/linux/hid-lamparray.h                      | 118 +++
 6 files changed, 1134 insertions(+), 1 deletion(-)
---
base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
change-id: 20261020-hid-lamparray-6f76a2791e8b

Best regards,
--  
Aaron Erhardt <aer@tuxedocomputers.com>

