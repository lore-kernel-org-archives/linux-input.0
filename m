Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64515360EED
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616089; cv=none; b=gaFGenIrwx5O571flvNm+8B6LwkXSQYHPtvkvt95Q0+53Zw+Ht+tf7DfWzRi6if5kZNkMbJxPmPXDEW4TssyhxBkgWk7m8PpnxRbeT6MRDijd37pos2Xx4vEtiU9OFDkYXKbrtcRzB1cmw5BubCWj0pf9ZH9/nE5UR4sjqIaz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616089; c=relaxed/simple;
	bh=zpN6P/NDREaV45xCCPo1vrCUOjNHpsbThSeFNERn/W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApfZLp2U09h2IAAgrbwgUDRV/H+KNx4TvjaR8U/y4MtLP5mABtxSmD8s/OmBwg7OxDe2Oskr8l33qb8in5JF4fp94foOzocjM4YsAUwOi7C+qk8R0PaBI4XlH62EkMNZqu+0mjiJjcoQhK24GfWvHjQdQvfRIj1zMJc4EK0bmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=jhPs6EkH; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="jhPs6EkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1778616087; bh=zpN6P/NDREaV45xCCPo1vrCUOjNHpsbThSeFNERn/W4=;
	h=From:To:Cc:Subject:Date:From;
	b=jhPs6EkHwlDOTuqOl/a57N0xpWSIuH/+3q2ICXDl+OJkpZyfq3y/QTy4+Ve4aryQw
	 /p3Cwbr3eTdJW7/6ACExyRjC5pZEHxu9KkIEwiNZMguyUgOiCaV6MebbwSEFvcdLQq
	 UAVtND2zi20Y2Nu5z+g+IQPYsq7zJ1CywOYI5Zx1wthLyNqIZ62dgluQ7fYRBxboUw
	 akOSAR1G/snflOKKuHxjmTisvw3sIKvDHQeJQC0g7ygdGQHJF51eP7t52Xu3ZtDFjH
	 +6dKFqm6YTYSToBU23fGCZ9pBVhJYPNMp/JNSYIy15WRaMCol+1g54kKbP2Rcv2JcS
	 zzVAYFPyjG8BQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 7B503A01E;
	Tue, 12 May 2026 13:01:27 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 0/3] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Tue, 12 May 2026 13:00:46 -0700
Message-ID: <20260512200051.2534081-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds preliminary support for Switch 2 controllers using the
same split-driver model as previous versions. This is a minor iteration on
v4, fixing some leaked input_dev objects in error paths as well as fixing a
merge/rebase error when CONFIG_PM ifdefs got removed in 7.0.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1504 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  353 ++++
 8 files changed, 1951 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

