Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F733AD9B
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311065; cv=none; b=IHy9qdjwAVbzPv32wI2cPERsPg72Z5fgyqFko4CHK/f6Hu9SAvNQTcZG1SsPUv8jw9A8uKyxmx22lY7ohH7es5a7p9F2N6NGQgHXUTa0Vm7hav2DxlzIFFaSvi3fbMA2mgsA7aFdTyIpEvIvuV0vq1zGjoHspzNGlei1DQw8qaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311065; c=relaxed/simple;
	bh=DwALhm85x+2Apt7zD3gA9N8PWCiCWCl1ElwD2xJ0JVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGhjSiFyt/EJ3LQFVL7kXlmSgU6hfViJDw6TuDabBcFBtM9L9N+EahmhHYjPtJlRlUk/OMSBHecuYJhHY/+6LDMFgz8tkNtFdU8oj/cUMC8MY77O1sY41ayveYDis4C/k11lXEOOa11NxnA8w6fHr2uywA6iUrPxx+GH4hSPZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=FbJTmk7L; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="FbJTmk7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788311057; bh=DwALhm85x+2Apt7zD3gA9N8PWCiCWCl1ElwD2xJ0JVg=;
	h=From:To:Cc:Subject:Date:From;
	b=FbJTmk7L6qXzCDe9e6/kRde4/J2skS3aBxIHIyaVoxRLNF0b32SYcsJn1tRce6UFY
	 RYZry5IRFRyvsCbu8INXA6F+tUrUCavtt3PwnA9yrOX4weFsTruzz1e9XU01WvKG0p
	 BCUgdSQhpewCvfDU9wSISsNeOGiov9grIbAKHT8L5z7oIisBg8iGS9w3zeV6djbkb3
	 ZrSuF5BIV1ea6FzkQLGWEM0pQCWxADez9ECNVgHmGmb/lBVdksTparFL9VWfe/C83h
	 SRqDHoy+AeojfoG3QtES46m1ExFWgw/Fcmds2Wj3ZMKHCjzLlZNgtqY645Z/I5K1th
	 /yLd5PA89GwSw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 0D1C7A010;
	Tue, 01 Sep 2026 18:04:17 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 00/12] Input: xbox_gip - Add new driver for Xbox GIP
Date: Tue,  1 Sep 2026 18:02:21 -0700
Message-ID: <20260902010237.865772-1-vi@endrift.com>
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

This version cleans up issues found by sashiko as well as some smaller
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
 drivers/input/joystick/gip/Kconfig            |   21 +
 drivers/input/joystick/gip/Makefile           |    8 +
 drivers/input/joystick/gip/gip-arcade-stick.c |  173 +
 drivers/input/joystick/gip/gip-core.c         | 3234 +++++++++++++++++
 drivers/input/joystick/gip/gip-drivers.c      |  222 ++
 drivers/input/joystick/gip/gip-pdp-jaguar.c   |  129 +
 drivers/input/joystick/gip/gip-security.c     |  795 ++++
 drivers/input/joystick/gip/gip-wheel.c        |  349 ++
 drivers/input/joystick/gip/gip.h              |  431 +++
 drivers/input/joystick/xpad.c                 |  684 +---
 include/uapi/linux/input-event-codes.h        |    3 +
 include/uapi/linux/input.h                    |    1 +
 18 files changed, 5397 insertions(+), 697 deletions(-)
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

