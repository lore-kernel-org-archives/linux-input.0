Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561F1A268
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182380; cv=none; b=kPTWtF4EnCpC0pDQ3aHAVydYrp6BA+jt0ztyJpTc0g00MTdvtjjjiq2WUzLUUWzrkSvWej8Td43UIgC0DPssv1w8RY3ZabpUwiqDniW1jFkkG/U57I04XYHyck7PbH+czkj4aBDbrHIVwNts9kBd0rKSpLXf8OOByCHLmRXEYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182380; c=relaxed/simple;
	bh=yideE9Y+mZmROqOcqqBJdOAh4pNjYmLipbBdSpx9hhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lup64Z/b9rLWnYSbgjtgwmgRc2tn14DSVcDUm5U7HZ03dJ0F2iJUgNSXR83u/tETYj75j2YygINOojDcgcUHBswRgrcbLeaFd57Fu2UcRkBPh7FTHKqmGVfqA4i1fwtkrJcPydtq7zPK80xjciTmvc7Oyh6Xm3tz/8ZQGddCjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=snNISp1m; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="snNISp1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1789182372; bh=yideE9Y+mZmROqOcqqBJdOAh4pNjYmLipbBdSpx9hhs=;
	h=From:To:Cc:Subject:Date:From;
	b=snNISp1mkLn57rpdUqXJ6NjzFSsv8bGjSQCU6G5vy5mSGpfJp4t9OQzPVcm8Hq9YE
	 dny9ncLb4K3pUZdkmy19/xqga2mHgbDNU7utN2qVm0C3VptPhS5w4ZYfp0vD+VqSYs
	 4J0hETR9EaDbhQ+at28av3HDfUWAN+Lb2DqIR73qpUnQd84mkqWoUCbUnrMqe09bFm
	 eNfYE2p43AoD5eZXeiujfK/XWuOlUCLW/VhcpbdV3RZAukMWG5Zce3xqrRZxBJNwX7
	 CkIMAwRTQXaQdfC6Rnt9KjGLbOnNoJkQBdOzixp3puglVMOmvnnU8sbK5unYGV76Qa
	 1cxMhUYsuT1GA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 3DEF3A010;
	Fri, 11 Sep 2026 20:06:12 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v7 00/12] Input: xbox_gip - Add new driver for Xbox GIP
Date: Fri, 11 Sep 2026 20:04:11 -0700
Message-ID: <20260912030426.2997003-1-vi@endrift.com>
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

This version cleans up more issues found by sashiko.

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
 drivers/input/joystick/gip/Kconfig            |   24 +
 drivers/input/joystick/gip/Makefile           |    8 +
 drivers/input/joystick/gip/gip-arcade-stick.c |  173 +
 drivers/input/joystick/gip/gip-core.c         | 3320 +++++++++++++++++
 drivers/input/joystick/gip/gip-drivers.c      |  222 ++
 drivers/input/joystick/gip/gip-pdp-jaguar.c   |  129 +
 drivers/input/joystick/gip/gip-security.c     |  810 ++++
 drivers/input/joystick/gip/gip-wheel.c        |  351 ++
 drivers/input/joystick/gip/gip.h              |  441 +++
 drivers/input/joystick/xpad.c                 |  684 +---
 include/uapi/linux/input-event-codes.h        |    3 +
 include/uapi/linux/input.h                    |    1 +
 18 files changed, 5513 insertions(+), 697 deletions(-)
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

