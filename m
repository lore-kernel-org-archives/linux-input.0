Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F133FE33
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809393; cv=none; b=TbSbca2+J2tfQkh9B14TUsriK0Yz9lBoe711O2SKpg4OPb2l+GpWbfszxvbqYilxCdJZGCUChM5xuLOmXGYJaCvipocL5kdyCGMWjZgT2aiqItKuZQdJqdnbutiDw5dGnjK6Ggy6Rv6lMknK4tZZq5w9ET4ELdwyhzixpm1aWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809393; c=relaxed/simple;
	bh=l8Jr+tIgtlo1cRPzRn0Zvs3RUbx2VmDB0rPNkbA84WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tn5dSL+/XB4vfRoDBQWQzk35TAKE3CwhKUwut2lPzmRrRQhlpW0KFHXBWQa4MxNjxiTjhUkEdDQDPouJOtD26A4EPa48OjQ/mDI86V6nrKohQ8gD37LJ0iAgkmXjbwjUHcNPrUnY+IVKTucgNzwJNGDjDd0q1u0YhhmID3oKWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=aV8TsFek; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="aV8TsFek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782809385; bh=l8Jr+tIgtlo1cRPzRn0Zvs3RUbx2VmDB0rPNkbA84WM=;
	h=From:To:Cc:Subject:Date:From;
	b=aV8TsFeks/R4ICQ/NJpxjqQ8UH/Avja+cRkRMJSbuZp14/GhU1VV/zzXNbsueJDKt
	 SVIJ6ULKNaWaJjpWn6ark/L+ylVzS7gQ8sP/nc3lQbJCtR9P3SI9+koiw8flTHSOcS
	 X3q2HwM38LP6USR7tjOi7ps/r9IiMGtaTCWLTykz6x+qbZm1xMWn2AQODWzk7Rah7O
	 VkbvJC5Um4wegcOaNKlUR/TLWQWEm3pbjF6H/fapcsHvNxSsGHEPypneYCb0HWe5q5
	 EZsoCjhyNkTXgagii8qE7N2O3ACYfCzkyCeLwLFgG2FHyssa+f1ZzWObmWBIhRlc7g
	 SnxKWPDe1eahw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 3C16CA073;
	Tue, 30 Jun 2026 01:49:45 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v7 0/3] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Tue, 30 Jun 2026 01:48:33 -0700
Message-ID: <20260630084838.2313379-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds preliminary support for Switch 2 controllers using the
same split-driver model as previous versions. This is an iteration on v6,
fixing errors pointed out by sashiko as well as cleaning up some other
things like lock handling and cleanup ordering.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1650 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  443 +++++
 8 files changed, 2160 insertions(+), 41 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

