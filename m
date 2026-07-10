Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC81DA60D
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648929; cv=none; b=Vfk4g69aFl8xEMtZunNQgkQy5NdGrrAmRz7D+CykaCEhEvYBzzsn5mNlXXi0YSBHUf1uyvkowpDa6Sr3p3upEwPHlSE6CONrp96FmthcuRM2Ssj8M9uNuxhNhaxhy5Rfj/YEgQpHsc4eqmNFy/ClqhofD2rIvUSaHDE7OV5/Qfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648929; c=relaxed/simple;
	bh=2JbiaQ42Z8v/qYSS550h4s2g8YQac0/BjC+nLuniR20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHKWVnow5V60LIBwWJ/+/yhKNuh+QHkS+7bcblIo60ust1eVC60KmohM3hSl1C/vqf5iQ1yl0npwHA35G9jdCCkkx0N9hXY8x/wOO1gO4iJCf3Ym/t4X1fANZ/zUJPoyxJWmqnDrZG2K7KG+bKv9vISPY3Pe7dqDWm6XqMRYiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=OHi79xVO; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="OHi79xVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783648915; bh=2JbiaQ42Z8v/qYSS550h4s2g8YQac0/BjC+nLuniR20=;
	h=From:To:Cc:Subject:Date:From;
	b=OHi79xVOiZV7CP9f3lkEiYhVXpxumkSDvKP6T7c87g7mP26mIe0/oNw9FIywjcEGd
	 H3DgomHjvdw/ay2YinlDBNnwgr9ThOeXwRuMbnjlRmIHVjsB4+DEefzCaht/eajcOt
	 FwEd1caWzNwRNeQdwrK5cj8/bz+b2lTd+BveXq4WX4Kynvl0sMHqcwhNdl3xbWrv+c
	 DwqcBs9UnVBO4rXzf7Uwmbn5xV34PceNg+Rx6sAjpIGPtVyYMK53naJfV8zc/WUMaU
	 nUlAkbdS0kKUU/SfTFWvhYC+yKlVCAvxqIUQ85cxX9yWy5RFtdfF29jFBu9By4WtbM
	 CUXg+o39ZxSIg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 99D3DA02D;
	Thu, 09 Jul 2026 19:01:55 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v3 00/10] HID: steam: General cleanup and improvements
Date: Thu,  9 Jul 2026 19:00:35 -0700
Message-ID: <20260710020048.2337655-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first half of a patch series improving the hid-steam driver.

This series contains a few notable changes:
- As I've been maintaining it downstream in SteamOS as well as writing
  general improvements, I'm marking myself as the maintainer of the driver.
- Renames some stuff, notably marking the original Steam Controller as
  Steam Controller (2015) in preparation of adding support for the Steam
  Controller (2026), which will be in the second half of this series once
  it's ready for submission.
- Adds IMU support for the Steam Controller (2015).
- Some reliability improvements, especially surrounding edge cases
  regarding scheduled work during teardown.
- Fixes a short read issue reported by syzkaller.

Hopefully the second half of the series will be ready soon, but I am
waiting on more testing by SteamOS users before I submit it.

This is a minor interation on v2 that fixes a few issues that came up
during review of v2.

Vicki Pfau (10):
  HID: steam: Update documentation
  HID: steam: Refactor and clean up report parsing
  HID: steam: Rename some constants that got renamed upstream
  HID: steam: Add support for sensor events on the Steam Controller
    (2015)
  HID: steam: Coalesce rumble packets
  HID: steam: Fully unregister controller when hidraw is opened
  HID: steam: Rearrange teardown sequences
  HID: steam: Improve logging and other cleanup
  HID: steam: Reject short reads
  HID: steam: Retry send/recv reports if stale

 MAINTAINERS             |   6 +
 drivers/hid/hid-steam.c | 720 +++++++++++++++++++++++++++-------------
 2 files changed, 490 insertions(+), 236 deletions(-)

-- 
2.54.0

