Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B12DA749
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290352; cv=none; b=MdBi8FWynArhlZTGcAO9/LGUpI2z91ENxMqx73ot01TKmJ8YG//CN46yZyV7uahBVe0xuKSE8Q+m31sItRatkXr7KE7MEd5rGN4GQvutp0Yh2t1w3kiQoJuqOCkhk+tav3swUEdaHC4c1J+twk2jesOllY0WmoxXiL8wDTi0/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290352; c=relaxed/simple;
	bh=2shMBqiNw/lS3NOAt26hXnWc/99tmbFYIkUFhYc8rsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLUbM7FDSUTBkyWe7tqBXfFxTAMNB+QWWYyumWpOSTZIvztcsoSqEBeJMZa7HRlBLPeVcFuNy5Pa6RNZJAQ7xiz9Sb7nQh3x5m/4U0HFCmyIMUcySB2cxOsUUekYOsFST8S8dzDWQDp26yUCKvpkEZmCqViHFkV4CT/b6kdCDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=cL5L2Haa; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="cL5L2Haa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290043; bh=2shMBqiNw/lS3NOAt26hXnWc/99tmbFYIkUFhYc8rsU=;
	h=From:To:Cc:Subject:Date:From;
	b=cL5L2Haau4xChhPkd9ifLKl74IjjOeTlmhEmorDubfirI28OhHvvSb7fbVy+Z+jcF
	 F3UDgOBeGjYs7ccifkpze21TvRtI81yy+izCSuOQeAWTLIXOuMWRXN2825SacX7CTp
	 4614D6xlhKMzk6IOb4L4A+zi9pIL6nWCry1NPomPdoq8Llh8cYg8+lN3e8LR9dkDVY
	 SoXMg/zefVwKo/RD+P9vH/EOSr0TgZ2AuOVq6k9OR3qTS7d2aJRIi7/JFY7ElJ4GAl
	 z1STSwuAu0JgSbmPJ7uFlcdffYPWOmitCMEkNhHdrnh97McHeoUP6aR+cSVFOepgdB
	 3i+gL637DPMzw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 8B658A028;
	Tue, 28 Jul 2026 18:54:03 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 00/10] HID: steam: General cleanup and improvements
Date: Tue, 28 Jul 2026 18:52:22 -0700
Message-ID: <20260729015243.1170573-1-vi@endrift.com>
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

This is a minor interation on v3 that fixes a few issues that came up
during review of v3, as well as reverting a false positive from sashiko
that was added in v3.

Vicki Pfau (11):
  HID: steam: Update documentation
  HID: steam: Refactor and clean up report parsing
  HID: steam: Rename some constants that got renamed upstream
  HID: steam: Zero-initialize reply in serial lookup
  HID: steam: Add support for sensor events on the Steam Controller
    (2015)
  HID: steam: Coalesce rumble packets
  HID: steam: Fully unregister controller when hidraw is opened
  HID: steam: Rearrange teardown sequence
  HID: steam: Improve logging and other cleanup
  HID: steam: Reject short reads
  HID: steam: Retry send/recv reports if stale

 MAINTAINERS             |   6 +
 drivers/hid/hid-steam.c | 723 +++++++++++++++++++++++++++-------------
 2 files changed, 491 insertions(+), 238 deletions(-)

-- 
2.54.0

