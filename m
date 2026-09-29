Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BB314A60
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790657897; cv=none; b=M4kiluGJqwPMY6dWp0ILWufwmh/wOv1qfL/4AgbTnvsUO8P8ZKrEzqpESY3x49tqNAmCPOyf62AaSP9iu2F2uWgBSVuU8wmpc/4vNJuldtrgSI+Nt5iW/HSkADDVeTkDsNwwneiWeD4n+ofhGrnjPx79tIqp8tBE3ELd2Pe5xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790657897; c=relaxed/simple;
	bh=l5wlJChseIuzRwhB7IaYGyezajSRq+xNymKX+7uBNuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+jsfCLWmV2aV40Q7NIrgaLLtsdCY4y6OEaldO1WGSZSt6mgipdwvaA+C6SuzzohbCxP2/8y8BIWrx7An0a+85ubkdwc/n2XrsmxmkzPdJemn/h+0vSAChwAYrWLHDBlzPEvVZ5TeiN4Sxf2q4Gz+WCW7Rwt1+IQPMsIgh94Plo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=CiNKfB+N; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="CiNKfB+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1790657889; bh=l5wlJChseIuzRwhB7IaYGyezajSRq+xNymKX+7uBNuo=;
	h=From:To:Cc:Subject:Date:From;
	b=CiNKfB+NDlVNE//aD468h6hF4xm+8CffSURX7vs2nN6MzJTvHYMbvGq9DaarSgyn8
	 iN9q5tHh6ySJHN4VvX6wPxqUKSZs32psJt2yZUKIklVf57NQy1uY1pTJdYYmE/0MpZ
	 zcPgLIFPwwJV/OONs43OPsRb9xWbjhLz8aJwNzxWdPj1RqF3zmRL+iU1hmTJ9hf3WB
	 Cz+ujzjPpLHqoQzjHlYFa3TCFXVebFEYujOOn3/xwdwSn/8cV1qy2Ujr08/cEvDDFN
	 mazMSp59crUTQhR3K4QIk0vpPV4dC98UTNa8q3YwWwnOGLCmyZuIE3SMB7KWHtVT/M
	 /p0tkLvPXIkVA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 186D2A00C;
	Mon, 28 Sep 2026 21:58:09 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v14 0/4] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Mon, 28 Sep 2026 21:56:00 -0700
Message-ID: <20260929045607.2106149-1-vi@endrift.com>
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

Since v13 two changes were made:
- The nintendo-switch2-usb supplementary driver was renamed to
  hid-nintendo-switch2-usb and moved into the drivers/hid directory.
- An additional patch was added, allowing the NYXI Hyperion 3 third-party
  controller to work properly, as it had a broken report descriptor.

Vicki Pfau (4):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support
  HID: nintendo: Patch NYXI Hyperion 3 descriptor

 MAINTAINERS                            |    1 +
 drivers/hid/Kconfig                    |   30 +-
 drivers/hid/Makefile                   |    1 +
 drivers/hid/hid-ids.h                  |    4 +
 drivers/hid/hid-nintendo-switch2-usb.c |  475 +++++++
 drivers/hid/hid-nintendo.c             | 1701 +++++++++++++++++++++++-
 drivers/hid/hid-nintendo.h             |   72 +
 7 files changed, 2241 insertions(+), 43 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo-switch2-usb.c
 create mode 100644 drivers/hid/hid-nintendo.h

-- 
2.54.0

