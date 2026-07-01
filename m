Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43153299927
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889031; cv=none; b=ceY1/i/7lAZEjZIHRAN3tHjq5t9O1cNARrmVW4imE2OwcFGhkP59VObBmY6cNm1rZHsMZJxNf/hKDBBAgXns7+2QIrhTAuOjh4AyldTUKLvI+bhYg9D9Y+YyU2OPIKaUTH06NvJyRvUS2Lz9LN5wsW6BS9KBmaqvhBiO6cwzzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889031; c=relaxed/simple;
	bh=6sfVGAyWDhadP2tsZgK0mMZ+imuFcFyEkjyy8s73PHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsVUxvsDe4bFnhCnrKaLoJBGW5/pEneCzvo26j7sL29jaZe3u+esUjncEPFAq29fgxIYdVXoq2rXQG3xVvcLiTU/gCxxB9hT0e0L5gQg2kX2rwhhuWS4nMk3LrcEwS/Wo5szF12DFJ2a6lUyggRzvPz/xRUmdZ6QCTXmH+3NnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=E8cYORrH; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="E8cYORrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782889029; bh=6sfVGAyWDhadP2tsZgK0mMZ+imuFcFyEkjyy8s73PHk=;
	h=From:To:Cc:Subject:Date:From;
	b=E8cYORrHYSXbAXuwVlNYnYLjm2qfzxwMufajcLu1Es2mUwCYKgXdy+L/R0T0nDQlY
	 ASC3gCyLEcQ31hNoT1XjDZq+lFJ6IwgGGvdFavMc9lgQHHWIZi1vLlae96dCjMStBF
	 6NXiH3WUN9Z05yfCTxnvaBuiSzhDbKlB3f0kZgDV7F1zvuwqAZYmWvldpaiG+epuCU
	 Ptjm7qnWb8GbpbUmwAWwxlWGFeOTVP4rFxMZUzCukNPNr+bFhWTDXSnIv7mMM9ywD0
	 FTvErrQmUUA6BDMAUxnkpnZwm5/xMdHHk3POPTVluZLkf+W8vWpMYS8LR0lgUA3qXX
	 VjTXxhMrgGaGw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 05F01A073;
	Tue, 30 Jun 2026 23:57:08 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v9 0/3] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Tue, 30 Jun 2026 23:56:01 -0700
Message-ID: <20260701065606.4169999-1-vi@endrift.com>
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
v7, fixing errors pointed out by sashiko.

At this point I'm pretty sure that what's left are imagined errors. It has
a lot of ideas of what can be run concurrently that I'm no longer convinced
of. If nothing obvious stands out, I'd like a review from a human before
fixing more nothings from sashiko.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1670 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  464 +++++
 8 files changed, 2201 insertions(+), 41 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

