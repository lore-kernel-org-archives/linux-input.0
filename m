Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601422C21F0
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497730; cv=none; b=ShxVei3w/iakHLp6x0b5UFTcIFPcnsOX0WTvzqRKiq+9m/xluIRoKt0mboL0PvPZ4Ty1JJxOPkxJ6z32FVZn4JMaQqkK6n8Wq3a7wQiKmSWYYcj9tl4B3S38sYnh/WNaMDM6ZnCISaLfD6EMvgHmnyBJsjh/auGhsACvfxZeQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497730; c=relaxed/simple;
	bh=FqgE2659GExm5B1E8PZSDwBXf547reyf/RL34tYVb40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GO69OqXXM6lsg7jzzDOYJpblHrEAw3khPUJ40INg3ObFUYC4Y+ieYLtkXQnjYhoatK+g2/+MVhWrjpcQtjUocfBBEQsgFSYJc4GalHFbKrIDAOuJ97LZl6oDVpM6buCvec56i5Qtvrrmsj9VvBqcVrGYoCc2SNkmhrvz2M9+rQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=MY4NzGzJ; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="MY4NzGzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786497728; bh=FqgE2659GExm5B1E8PZSDwBXf547reyf/RL34tYVb40=;
	h=From:To:Cc:Subject:Date:From;
	b=MY4NzGzJOLghq5ZjHjWuctZXgGGe9MyTi0CS1qUNwSwrZh/3Zc94EwGeX5hjV1RXj
	 SGJE1/w8KbZ32X7NVf90U7jX48GlSM0DYRB6K8NnD7z5D5epec2VPE+rIlrJgTC2gh
	 BxqDLkQm7XLbrq6Nr5f6pKOXekgMwIu2QtCdI9BI1gaYku6CaVDmM395vOy42o4KxN
	 IWa9UkADVT//rq0svn3/tTyrAIASV0HR8xmwegeX9c78w+jq7oEnN7hUK1D0DdrRG0
	 86LehnNbHVFylYb1V5GJtwCnKdN2z/hPvkBzK6qjJLjY57D19mHLz8DEpwutzmHKWw
	 mRqZRPc5JLQbQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 3747FA058;
	Tue, 11 Aug 2026 18:22:08 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v13 0/3] HID: nintendo: Add preliminary Switch 2 controller
Date: Tue, 11 Aug 2026 18:20:32 -0700
Message-ID: <20260812012037.3251614-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds preliminary support for Switch 2 controllers using the
same split-driver model as previous versions. The only difference between
v12 and this is moving the spinlock init for rumble_lock to avoid a
potential reinitialization. It's effectively just a resubmission otherwise.

Dmitry, we still need a review or ack from you.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1681 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  475 +++++
 8 files changed, 2223 insertions(+), 41 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

