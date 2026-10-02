Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B12C3768
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900985; cv=none; b=gaoSyf97b3xRN8t7ojwP1rOmNQknhBvVeb3UQWaVOdZ8EhYOT87cBI8gRtsfIcAopyxHVFqVum0CBDLzmHuep6trz6qj7X10x/o/HMM7J47kDmKZ355MdHcbFXhdJWvSIyBM3nhMFB/CKX4uUG8Befl34/7zwaZMKddRXzk74mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900985; c=relaxed/simple;
	bh=nbwa4HIlJ2XmBHLckian7tHHoEtIylPpXiDcEIr27kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNk+JdRdBVtJiUbch8YOixgzgQYJn32xFTI6/ELarRkvjGpcoW5uDxhYoa0NJH+bH3j4IBYJuqKXge47OTk+vLh9bPUTrLvVBWfJNHbkQDThSbUxnDTyERCjf9puiHSgoAN0X8mjNN4b3TEvZBJGOo1e0hDoJ3G7gyy4OnOZaY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=ATNC9v0B; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="ATNC9v0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1790900977; bh=nbwa4HIlJ2XmBHLckian7tHHoEtIylPpXiDcEIr27kQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ATNC9v0B/ZrCyQGD1t/Rb5QdPdUyl562zmvGN5RiK1uaAm/8DoAN2ZEi2lhPm+duM
	 6aVaUQvQde6P3Jmwx89Yc+WwNbmHkNfwH3SKkp7NGH4NSgi5GvFlsVwtngNx/SlvVZ
	 +9d26Nzqkpr1h9keAG9Gcoxm3jdqy3czW183J+irKAIcwp3FynrAS/oGBuhbnF2E1o
	 25LDqTuMQoDssrr3P31vaN1X5gYLTj51KLYg/dFBTU+d6TchdLhb1kqm2Iadvmg3HH
	 aTrPa36JIqQBIQPv+8eRRl+NHZhZ/IlDKXNzbulL0zMRB8MuZpejTAJWQCOStHiVFB
	 iCC0SI75UBB0g==
Received: from microtis.vulpes.eutheria.net (71-212-64-84.tukw.qwest.net [71.212.64.84])
	by endrift.com (Postfix) with ESMTPSA id CA713A03F;
	Thu, 01 Oct 2026 17:29:36 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v15 0/4] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Thu,  1 Oct 2026 17:29:22 -0700
Message-ID: <20261002002929.1578115-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new driver for the Switch 2 controllers. The Switch 2 uses an
unusual split-interface design such that input and rumble occur on the main
HID interface, but all other communication occurs over a "configuration"
interface. This is the case on both USB and Bluetooth, so this new driver
uses a split-driver design with the HID interface being the "main" driver
and the configuration interface is a secondary driver that looks up to the
HID interface, sharing resources on a common struct.

Due to using a non-standard pairing interface as well as Bluetooth
communications being extremely limited in the kernel, a custom interface
between userspace and the kernel will need to be designed, along with
bringup in BlueZ. That is beyond the scope of this initial patch, which
only contains the generic HID and USB configuration interface drivers.

This initial work supports general input for the Joy-Con 2, Pro Controller
2, and GameCube NSO controllers. IMU, rumble and battery support is not yet
present.

There are a few minor changes over v14: better handling of -EPIPE,
switching to using kzalloc_obj where applicable, and renaming the config
option for the hid-nintendo-switch2-usb driver from
CONFIG_HID_NINTENDO_SWITCH2_USB to CONFIG_NINTENDO_SWITCH2_USB to match
other hid driver "suboptions."

Vicki Pfau (4):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support
  HID: nintendo: Patch NYXI Hyperion 3 descriptor

 MAINTAINERS                            |    1 +
 drivers/hid/Kconfig                    |   30 +-
 drivers/hid/Makefile                   |    1 +
 drivers/hid/hid-ids.h                  |    4 +
 drivers/hid/hid-nintendo-switch2-usb.c |  474 +++++++
 drivers/hid/hid-nintendo.c             | 1701 +++++++++++++++++++++++-
 drivers/hid/hid-nintendo.h             |   72 +
 7 files changed, 2240 insertions(+), 43 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo-switch2-usb.c
 create mode 100644 drivers/hid/hid-nintendo.h

-- 
2.54.0

