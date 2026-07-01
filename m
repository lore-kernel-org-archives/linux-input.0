Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6C2DB795
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 03:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875780; cv=none; b=JC+q4i4tEb7BDnP1qYb8Qx6KXq3yhzBPtq4/REcYZpZPNy337FXVmHr2J7Nq7SD7G2+rk/hEpspPVyQJ8zZNoWjYm2ZU6RYGbTJoKkazE7xjk8QDY+k7EC5/xJWiQsV1avuK71luzR983xGmlv3xKLuwFF/75lnoJ/CmqJsPccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875780; c=relaxed/simple;
	bh=vT0lbOli2rrGbn5LqvKtJYR93NVE54sX3VGmMmqTu7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+A+1H1u+9/UJkCiZJLciwNyv2qRinvFyS9qZP+GamFpCE67dbwetnfKnTRjvj2hXMBrKh3AvsOj09kN8gZ4GdIOFMRqc0z5NpqEHw+osc2TX1/Xr0AVIXwiBjK/nNTBA0PfDk4Li+4qsdC/FCR+FjoyDc+CBlC8QgATNe/iXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=XGw+YhvL; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="XGw+YhvL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782875777; bh=vT0lbOli2rrGbn5LqvKtJYR93NVE54sX3VGmMmqTu7g=;
	h=From:To:Cc:Subject:Date:From;
	b=XGw+YhvLBRoGWxqAzjEV5+FqeY5fU4uOtQIKsdLIl7+NrUKI+BtSBvSuCdbfidWQP
	 4KJ7s2XozxdQ6xn9XabOuR9dHF64oyXaos3nH7vhM1wFtumMeEYixF4Nj6zf9PExX3
	 Gxt4zfv7/EChkAbISRf8F+gee1LUt6HT9/d4u+y4LXGD1jDSmFX6IEVBxRS6L33XtS
	 1Fg4rrGgKE2riTRk2i1L+4GaDmjdGNLCYH2/WCT5dcfpvhDqPuCpNLRrMhCmtIKoYC
	 po4O443VsXMFIFX8wwt932J/3gI6hZEzsBVuxoJhxSTodtnuof21YgVvkmwbw6eZAR
	 TVdo6SFjHD86g==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 97829A010;
	Tue, 30 Jun 2026 20:16:17 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v8 0/3] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Tue, 30 Jun 2026 20:15:08 -0700
Message-ID: <20260701031513.3068035-1-vi@endrift.com>
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
v7, fixing errors pointed out by sashiko as well as trying to clean up
unplug somewhat further beyond what it pointed out.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1668 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  453 +++++
 8 files changed, 2188 insertions(+), 41 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

