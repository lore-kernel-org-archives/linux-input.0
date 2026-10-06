Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0523612EC
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267399; cv=none; b=dzbWw8+1nu9VOfhnnJZFFsPdVyhzQ31+WtLV2v26GPGr/Uu7Q9lDHt/VXeLJQ5leytXb6wOc3ULDOyoiHN2wXEAZ/390mnxTQ0T8TFPU17AqIVEFF9Kzu++QyXVS57dzG8zbqHFXnGvARwOVl49n4r2wk1pGXH2alezUA0PVV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267399; c=relaxed/simple;
	bh=AB15Qp9AlHcXYUd0Ko3b4GHZG/oefQWAAaxvrZQKcxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnWbou0x/up17Q5vocIW7K2YnLFTCOmYGT4euvyh3suZ0ohynd5yMpbtxhA2lQQ0J/mDjILm8ZZAACLz8aobdU9aOX0JFKGJ0YEWrHhTCiOaKyeAFY0gXYC7RNtbuDq+DgTObTZ/yACNiUrsPUxxelvH501IdHUwMDQaiJFsijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=oLxbCN2V; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="oLxbCN2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1791267391; bh=AB15Qp9AlHcXYUd0Ko3b4GHZG/oefQWAAaxvrZQKcxI=;
	h=From:To:Cc:Subject:Date:From;
	b=oLxbCN2VmAkkDh97YcmHLCOFEaTj2J6teb/wtKm/d8+rh0iuOGHKrwE0jkTfo9JDF
	 Yh2kt8A3tqLoHi7bxN5ZHC0gOs9ga3vEAlqweY519tmcn4udwhTjT1WFDHTECtkxIg
	 zF0pbTag95IPzGSfb6Mr2kpzISzKBCyGg70pyic0dbcziptKIbOnD9vtRjKWmiROHP
	 XVvZ5/xlxtN0CNCUKHukjwpnS0CkiuPoPK7R8qydqaeQX+F2O1XAMSJ9XJ72z4S9rE
	 l3fIgCINX3HC5qhkJv5bwxBiO3jM4YdicmRnEY9UflPK0jZWEfHyByQytNXRHrXgCx
	 OpDAjAfk+rvAg==
Received: from microtis.vulpes.eutheria.net (71-212-64-84.tukw.qwest.net [71.212.64.84])
	by endrift.com (Postfix) with ESMTPSA id 66161A018;
	Mon, 05 Oct 2026 23:16:31 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v16 0/4] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Mon,  5 Oct 2026 23:16:06 -0700
Message-ID: <20261006061619.2005967-1-vi@endrift.com>
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

This should fix the last thing sashiko has been reporting that isn't
complete and utter nonsense. Unless anything seriously bad comes through
the next round, or a maintainer tells me I need to fix it, I'm just done.

Vicki Pfau (4):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support
  HID: nintendo: Patch NYXI Hyperion 3 descriptor

 MAINTAINERS                            |    1 +
 drivers/hid/Kconfig                    |   30 +-
 drivers/hid/Makefile                   |    1 +
 drivers/hid/hid-ids.h                  |    4 +
 drivers/hid/hid-nintendo-switch2-usb.c |  493 +++++++
 drivers/hid/hid-nintendo.c             | 1704 +++++++++++++++++++++++-
 drivers/hid/hid-nintendo.h             |   73 +
 7 files changed, 2263 insertions(+), 43 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo-switch2-usb.c
 create mode 100644 drivers/hid/hid-nintendo.h

-- 
2.54.0

