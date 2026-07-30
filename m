Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D439A048
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384874; cv=none; b=GbJPpPCvCma6cXPt9RZTL1hHp3GytciLbLP0Vv0vTvioT0nC5x93P0IPecbqRqCX1RFUYmkxKzh3mtkbUgcKObmP9NbwFH95bvR30OjPl6xW/CE0p45MPY5ECQAuuG5gS/PzxU6GGL6X5QWcB9HyYVIcm1oxTcB+ekx9BP1AnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384874; c=relaxed/simple;
	bh=Y0wK3UXwYtr7dbUhiJUwfnjBJl8wfoc1fRIU8e4Ez1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QA+U/4fLUm0uvPL3KRhWJsdt8dUdT7Al1FTg6HE+aQXdQBhuO+Ui/xK3ao7QN6Cu3XwXUP9qTBbrOO+lG7Nzqg9Ex/iGjpYFKRKOu1va8vHAB45+cDHa9niTxUvS8wmeSPCmPQiCEQrHnbf/lkap4KbnHb0YjU26pprOXJAY9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=AIWfe2WE; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="AIWfe2WE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384865; bh=Y0wK3UXwYtr7dbUhiJUwfnjBJl8wfoc1fRIU8e4Ez1w=;
	h=From:To:Cc:Subject:Date:From;
	b=AIWfe2WER/e44jq9KeavLUmtGvaep1IA9UGKIB9NJ9zeYVEM5Ns14vdzdCpYxOUwn
	 tT0rJD5aFjVgWrGxa9ExL2HYGLww/MNuqpwHKz8m4ZSbCxSuM/EtSWw1Y2F7KVY+ec
	 zzvSvo82qQsq+LjcQGagtgMKK/RNwJxW42zLDLuJyWkI+a6Xt1wVeeCOCtmR9i86gE
	 tXLpYUyf/H05iYzyg9omkdit+fWqUdT2CHBXoOm54aGv6VLQ9RpWWVRv+OrhRiK1O6
	 ic1vkp5d88Y5HC7qf3+voBLX7tX29f8CBzYhZ3ofmDbyWzhBc0DdoohBg6stOqSh00
	 YjL4sivNDzn6A==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 66DCCA06C;
	Wed, 29 Jul 2026 21:14:25 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 00/10] HID: steam: General cleanup and improvements
Date: Wed, 29 Jul 2026 21:12:23 -0700
Message-ID: <20260730041251.1659029-1-vi@endrift.com>
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

v4 introduced failed to properly revert a patch from v3, which is fixed
here, as well as a completely random other bug that sashiko brought up for
some reason.

I am pretty exhausted from sashiko jerking me around. It has several issues
that I think are entirely imagined, in this series mostly invovling HID
startup and teardown. It seems to believe that HID interrupts will get
serviced during startup and teardown, but I'm pretty sure that isn't the
case if hid_device_io_start isn't called. I've wasted a lot of hours trying
to fix theoretical issues regarding this in this and other patch series.
And that's only one of the classes of bugs it's hallucinated. This thing is
very clearly not ready to be taken seriously, especially if we don't want
to burn out maintainers.

Vicki Pfau (11):
  HID: steam: Update documentation
  HID: steam: Refactor and clean up report parsing
  HID: steam: Rename some constants that got renamed upstream
  HID: steam: Add support for sensor events on the Steam Controller
    (2015)
  HID: steam: Coalesce rumble packets
  HID: steam: Fully unregister controller when hidraw is opened
  HID: steam: Rearrange teardown sequence
  HID: steam: Improve logging and other cleanup
  HID: steam: Zero-initialize reply in serial lookup
  HID: steam: Reject short reads
  HID: steam: Retry send/recv reports if stale

 MAINTAINERS             |   6 +
 drivers/hid/hid-steam.c | 685 +++++++++++++++++++++++++++-------------
 2 files changed, 473 insertions(+), 218 deletions(-)

-- 
2.54.0

