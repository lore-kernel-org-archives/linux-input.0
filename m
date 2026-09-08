Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0B57C9F
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837824; cv=none; b=ZxLEH0Cpia53SxC4uwtONhpbL0zk3iRK6mvlLZgphvih+45cuWZrTyWV++fRKmfPFE8u1HY+sD9EbVULjK4NYXkjZr4wNd33jr+6ANubiPS4VmRK8TUpZt4wBaQZrJIzgY94kHA84cu7cqR2mq6wubKHCZ45kIli6cgseGSQtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837824; c=relaxed/simple;
	bh=0SAKF7/fR5SHGkYODvdJ8YEiJOE9xmDPd/km8nOOVpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/ru+yAh3wsizLlMFWpS3ZkF+B/cB8fO3PV3GUsFHE/65n/DKdXL7RdU15yJoycOICfLUeWGQtfEjDSJAwI9rDdfDNog/kjwFAEpeI0LL9WMhdS+DFJO9/rcDM3ziN4AKBw/US91j0Oa5rJUPZtIFNoMqUUnsGdmKiluLm7Eyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=VwRzWRbF; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="VwRzWRbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788837815; bh=0SAKF7/fR5SHGkYODvdJ8YEiJOE9xmDPd/km8nOOVpM=;
	h=From:To:Cc:Subject:Date:From;
	b=VwRzWRbFLZnKrVdDAJGAzVyBrFXyF3b3Z5avGKaOCTvXczD7Xe9mEye9rA4/ytnmL
	 e9kVZXuoYNxgrVcDSTKIvJ+evFhf9eSShwYgWKT+k+OGWK7ii3Do+YH4mqNrn6kf27
	 TUELbItyBRRNkvG2w78Zs83bR2w0O9eVCKMzKzuS+qbRAngemP13PJLegEHgbaRkY0
	 j/ch49RhbUnFiMn4Z9txoi+5ZOC6B0C7NnA0M3IkRWDYCDwKYlEyIblOrCm3C6d8kU
	 Li+p3qLjpp86mOnMFXdep3z4XLn4/H2VwinuaoUifWdscDtRyqb3KGWp744HgAgulI
	 M/ngek+wqjHbQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 96941A041;
	Mon, 07 Sep 2026 20:23:35 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v6 00/12] Input: xbox_gip - Add new driver for Xbox GIP
Date: Mon,  7 Sep 2026 20:21:31 -0700
Message-ID: <20260908032145.2118234-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new version of the previously submitted xbox-gip series.

This introduces a new driver for the Xbox One/Series controller protocol,
officially known as the Gaming Input Protocol, or GIP for short.

Microsoft released documentation on (some of) GIP in late 2024, upon which
this driver is based. Though the documentation was incomplete, it still
provided enough information to warrant a clean start over the previous,
incomplete implementation.

This driver is already at feature parity with the GIP support in xpad,
along with several more enhancements:

- Proper support for parsing message length and fragmented messages
- Metadata parsing, allowing for auto-detection on various parameters,
  including the presence and location in the message of the share button,
  as well as detection of specific device types
- Controllable LED support
- HID passthrough for the Chatpad
- Battery information support
- Arcade stick support
- Racing wheel support
- Support for the security flow, allowing use with wireless controllers
  that include their own dongles. (This does not include support for the
  first-party dongle yet.)

The framework set out in this driver also allows future expansion for
specialized device types and additional features more cleanly than xpad.

Future plans include:

- Adding support for more device types, such as flight sticks.
- Exposing a raw character device to enable sending vendor-specific
  commands from userspace.
- Event logging to either sysfs or dmesg.
- Support for the headphone jack.

This version cleans up more issues found by sashiko as well as some smaller
refactoring to clean up reused code.

Vicki Pfau (12):
  Input: xbox_gip - Add new driver for Xbox GIP
  Input: xpad - Remove Xbox One support
  Input: xbox_gip - Add controllable LED support
  Input: xbox_gip - Add HID relaying
  Input: xbox_gip - Add battery support
  Input: xbox_gip - Allow sending fragmented and ACME messages
  Input: xbox_gip - Add security implementation from xone
  Input: xbox_gip - Add arcade stick support
  Input: xbox_gip - Add support for PDP guitar controllers
  Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
  HID: Map more automobile simulation inputs
  Input: xbox_gip - Add wheel support

 Documentation/input/devices/xpad.rst          |   17 +-
 MAINTAINERS                                   |    6 +
 drivers/hid/hid-debug.c                       |   16 +-
 drivers/hid/hid-input.c                       |    2 +
 drivers/input/joystick/Kconfig                |    2 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/gip/Kconfig            |   22 +
 drivers/input/joystick/gip/Makefile           |    8 +
 drivers/input/joystick/gip/gip-arcade-stick.c |  173 +
 drivers/input/joystick/gip/gip-core.c         | 3281 +++++++++++++++++
 drivers/input/joystick/gip/gip-drivers.c      |  222 ++
 drivers/input/joystick/gip/gip-pdp-jaguar.c   |  129 +
 drivers/input/joystick/gip/gip-security.c     |  807 ++++
 drivers/input/joystick/gip/gip-wheel.c        |  350 ++
 drivers/input/joystick/gip/gip.h              |  434 +++
 drivers/input/joystick/xpad.c                 |  684 +---
 include/uapi/linux/input-event-codes.h        |    3 +
 include/uapi/linux/input.h                    |    1 +
 18 files changed, 5461 insertions(+), 697 deletions(-)
 create mode 100644 drivers/input/joystick/gip/Kconfig
 create mode 100644 drivers/input/joystick/gip/Makefile
 create mode 100644 drivers/input/joystick/gip/gip-arcade-stick.c
 create mode 100644 drivers/input/joystick/gip/gip-core.c
 create mode 100644 drivers/input/joystick/gip/gip-drivers.c
 create mode 100644 drivers/input/joystick/gip/gip-pdp-jaguar.c
 create mode 100644 drivers/input/joystick/gip/gip-security.c
 create mode 100644 drivers/input/joystick/gip/gip-wheel.c
 create mode 100644 drivers/input/joystick/gip/gip.h

-- 
2.54.0

