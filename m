Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BD2DCC1F
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365238; cv=none; b=IFHo1Xld9OZkZ9ghFyba5PjBkNBhP9YpB2lGfEsQ4kaDhJXwhv0QgNvG3iEaytIDlkd0HqjrQInsdVm7L7DWLVbFKOWrZ9tq6F9klvCGSMXwKhdUHnrGWOYsjOz5uHAN9O1sp6NBBYepm52JdOx1ZBzsskpHcLGiw4Bhi9/vDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365238; c=relaxed/simple;
	bh=/sWj44+Oufqsr1zBz2U63fC6mrJ3TgfzHWH9rlrw/2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rb7Z5li4ExxyGZVWPjZ1QtdSQecxFwahDgPdv/KtxgeC+32TjeL1U7UykPKrDaPKeGhFPIhNLTL2SQtBzdEE2Hwyt8kCBUCWEDoxAszevX86S9nhU5IzpPrUgPTpL0BgUKRvPkTJovCLQFXrt/v5FG5GN8RkI+ss3C9zxzdsUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=H8yGHobR; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="H8yGHobR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787364798; bh=/sWj44+Oufqsr1zBz2U63fC6mrJ3TgfzHWH9rlrw/2U=;
	h=From:To:Cc:Subject:Date:From;
	b=H8yGHobRuHgP59kGWvIftsfHz+JKYEvv3mfSoOdjsd15LwrgN57XZQ5M/WFBPBV5a
	 +LhcZIbPq908wrZ5/76R98sG16VIxx41GDQFZk0escV5EleDcVRnA86P3SPv03HeNO
	 rTZDjsvNuN4hGTnQpFlwXtf2RnZ8YJu/mZ7T2A8esEzwBxEY+Dhw+7w+J9gueksBtU
	 XM5f/H6MsWz4Nu2T9VwNxq/6m71JmUdpUqqb6onuuSA3wqg+U8zp5WWjv0EA5fwh3M
	 Ix7GLd/z07ikEozjiXK8HvE/h2oWARStRou/ShlUdCUmn6OLaS2xPpFpII9kbEYJgZ
	 1Oz3XSa7NkUaQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id DA3E7A051;
	Fri, 21 Aug 2026 19:13:17 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 00/12] Input: xbox_gip - Add new driver for Xbox GIP
Date: Fri, 21 Aug 2026 19:11:24 -0700
Message-ID: <20260822021140.1149546-1-vi@endrift.com>
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

Since the last version this has included several minor bugfixes as adding
support for sending ACME messages and porting the security flow from xone
to allow for use with wireless controllers with their own dongles. It also
adds support for PDP guitar controllers like the RiffMaster.

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
 drivers/input/joystick/gip/gip-core.c         | 3173 +++++++++++++++++
 drivers/input/joystick/gip/gip-drivers.c      |  222 ++
 drivers/input/joystick/gip/gip-pdp-jaguar.c   |  129 +
 drivers/input/joystick/gip/gip-security.c     |  867 +++++
 drivers/input/joystick/gip/gip-wheel.c        |  349 ++
 drivers/input/joystick/gip/gip.h              |  423 +++
 drivers/input/joystick/xpad.c                 |  636 +---
 include/uapi/linux/input-event-codes.h        |    3 +
 17 files changed, 5399 insertions(+), 649 deletions(-)
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

