Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4A126F3B
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120030; cv=none; b=BIC/jdGDK2ZTviGyDFtY9bQ63ZIHYUeoF19tBnpyMMZjBAL3VgHQHQ+SGogqVsUQT1uHNEKAvbHOEuIvhuFSwZ0qsKHdFLtO5pyHhL4CSJ9CsgO9Yg2+sk6fz20QPl4mEnz31nlfSS2krhhkdjT6oKXzBoU83YLbsWtn28al2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120030; c=relaxed/simple;
	bh=02g160JQK9Kswf4+8anawHQF4nWoSPwosODhHF1uwbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGlPHW/p9Kxq9dd/yWBfMN2313EY7B7xeTLj0KiXIt/Ld+H5mqX5qcSY6Z/noa3iVPx2eV8X2b+Ues4bVdhtIHBy6rPHhIXhE1+xS3LYdhIzCRhl1rF/HQacafAUbF+jjWWmm+3dnCImcEb2D9B4o0aB3FqZdM4fQzBn9z7qbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=CX/DtWEI; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="CX/DtWEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120029; bh=02g160JQK9Kswf4+8anawHQF4nWoSPwosODhHF1uwbU=;
	h=From:To:Cc:Subject:Date:From;
	b=CX/DtWEI5PwiikRuxfgRfOFScqTSjAxgO+OjNk9CfIn0MQKIo6xiP0csBAD6qxPKM
	 t7CqvtpKaeKLMdwt8v0+fFp3Zqmnh+IcC9FfJ1+YAE6IutuU6QhjyyNdCR7PmHt2ZL
	 1/fvw9MyEVnKsbgkRlGM13MCuVSY1vL67xJ/96Msl5JIiXjv2zfkR+zcUewX1okpPJ
	 WDLoWbQcjyFSbXpdsKHn0oTYMSqkLCC1zcHm5DGPxflji3arO/FWFeIAyRa69/tnyw
	 XS1LtDVi4CALgGZdS/0urgycQI+cpuVe0fzgAAyBGR4BxIGxNW7/NgRuKx5IKH1EgR
	 Rla4/oxYyEtyg==
Received: from microtis.vulpes.eutheria.net (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id C47D6A0AA;
	Mon, 09 Mar 2026 22:20:28 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 00/10] Input: xbox_gip - Add new driver for Xbox GIP
Date: Mon,  9 Mar 2026 22:19:54 -0700
Message-ID: <20260310052017.1289494-1-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
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
- Direct
- Controllable LED support
- HID passthrough for the Chatpad
- Battery information support
- Arcade stick support
- Racing wheel support

The framework set out in this driver also allows future expansion for
specialized device types and additional features more cleanly than xpad.

Future plans include:

- Adding support for more device types, such as flight sticks.
- Support for the security handshake, which is required for devices that
  use wireless dongles.
- Exposing a raw character device to enable sending vendor-specific
  commands from userspace.
- Event logging to either sysfs or dmesg.
- Support for the headphone jack.

Since the last series, this heavily refactors the logic with an eye towards
extensibility. Support for sepcific devices has been split out into
different files in the new input/joystick/gip directory, with a driver-like
interface for probing individual devices.

It also fixes some bugs,including shutdown logic with the input device
potentially freeing the led cdev before it's properly closed, and handling
of -ENOMEM in the led probe routine.

The series has also been split into several additional patches to make
reviewing it easier.

Vicki Pfau (10):
  Input: xbox_gip - Add new driver for Xbox GIP
  Input: xpad - Remove Xbox One support
  Input: xbox_gip - Add controllable LED support
  Input: xbox_gip - Add HID relaying
  Input: xbox_gip - Add battery support
  Input: xbox_gip - Add arcade stick support
  Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
  HID: Map more automobile simulation inputs
  Input: xbox_gip - Add wheel support
  Input: xbox_gip - Add flight stick support

 Documentation/input/devices/xpad.rst          |   17 +-
 MAINTAINERS                                   |    6 +
 drivers/hid/hid-debug.c                       |   16 +-
 drivers/hid/hid-input.c                       |    2 +
 drivers/input/joystick/Kconfig                |    2 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/gip/Kconfig            |   30 +
 drivers/input/joystick/gip/Makefile           |    3 +
 drivers/input/joystick/gip/gip-arcade-stick.c |  169 +
 drivers/input/joystick/gip/gip-core.c         | 2843 +++++++++++++++++
 drivers/input/joystick/gip/gip-drivers.c      |  220 ++
 drivers/input/joystick/gip/gip-flight-stick.c |  179 ++
 drivers/input/joystick/gip/gip-wheel.c        |  348 ++
 drivers/input/joystick/gip/gip.h              |  327 ++
 drivers/input/joystick/xpad.c                 |  634 +---
 include/uapi/linux/input-event-codes.h        |    3 +
 16 files changed, 4153 insertions(+), 647 deletions(-)
 create mode 100644 drivers/input/joystick/gip/Kconfig
 create mode 100644 drivers/input/joystick/gip/Makefile
 create mode 100644 drivers/input/joystick/gip/gip-arcade-stick.c
 create mode 100644 drivers/input/joystick/gip/gip-core.c
 create mode 100644 drivers/input/joystick/gip/gip-drivers.c
 create mode 100644 drivers/input/joystick/gip/gip-flight-stick.c
 create mode 100644 drivers/input/joystick/gip/gip-wheel.c
 create mode 100644 drivers/input/joystick/gip/gip.h

-- 
2.53.0

