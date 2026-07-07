Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808E2349CD1
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467233; cv=none; b=X7OsS5fFPDDoeG9z3AUCLGzfeo+K1vchh2kYbrpPtoC7hzGakhmaeIFn/3FPg7nJE+e2CFPrasY7xNpVwhbwDsmf+oFac1mPBroV5wAFVe2DOgPSJqx9Z4BQvkvvayq2RVpavX3hCctWgApCcG7gfEQIdzJK3gjShRCzuPRYO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467233; c=relaxed/simple;
	bh=5DDnmiW46C7GO6yye3bpgUmGBx2mygmLBfibF3AJdyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tx42seCJzGLCT/sMzmFbE/7pKQ044Tthot2fA9SXVulkhJWq9tE2AoFx7Fy01imUQKYy91NmDkwqLCN9m1eW3etZE2PTWo+008jjRaYbLQk4jQsB7b7suXFagfpachstFatCPF1pcv/OoPtTfO2nOwMbOkAyZHzcfT5690XtKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=rcXUICME; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="rcXUICME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783467230; bh=5DDnmiW46C7GO6yye3bpgUmGBx2mygmLBfibF3AJdyY=;
	h=From:To:Cc:Subject:Date:From;
	b=rcXUICME6xnTA3mpXSTIQ0npd4yVJ+qxZhqS6Ltk5ls6D9EjugMPdQQmaX9u1BRku
	 OT0Cw8qedb1W4U9Bd06GLa/5GECs2pj7OQkloK0cYpMf1T+hlgx6QHcuZ6KRz9DzNo
	 yP27l17LjHC0lJ4jGWQNTD0MMQI4Kw2+Ot0X8fTMs5csQMaLcAS51yEo1+JctCvswg
	 JcqPl5qY/W1dBBE95tCIt7k1GYvHfgHF/wgXz1mS6aJ1hVzr58mpVs6bEQm5trDFbP
	 oZ2WxW7LRKOJUvTExeT6oZyaSnlVu/myo4N0bXL7N0v9yFD3LH2u2W/pRka+T10RDK
	 8wa5Tg7RaCQrA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 56759A05C;
	Tue, 07 Jul 2026 16:33:50 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2 00/10] HID: steam: General cleanup and improvements
Date: Tue,  7 Jul 2026 16:32:20 -0700
Message-ID: <20260707233241.2644971-1-vi@endrift.com>
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
- Some reliability improvements.
- Fixes a short read issue reported by syzkaller.

Hopefully the second half of the series will be ready soon, but I am
waiting on more testing by SteamOS users before I submit it.

This is a minor interation on v1 that fixes the short read check as well as
some miscellaneous issues found by sashiko.

Vicki Pfau (10):
  HID: steam: Update documentation
  HID: steam: Refactor and clean up report parsing
  HID: steam: Rename some constants that got renamed upstream
  HID: steam: Add support for sensor events on the Steam Controller
    (2015)
  HID: steam: Coalesce rumble packets
  HID: steam: Fully unregister controller when hidraw is opened
  HID: steam: Rearrange deinitialization sequence
  HID: steam: Improve logging and other cleanup
  HID: steam: Reject short reads
  HID: steam: Retry send/recv reports if stale

 MAINTAINERS             |   6 +
 drivers/hid/hid-steam.c | 669 +++++++++++++++++++++++++++-------------
 2 files changed, 463 insertions(+), 212 deletions(-)

-- 
2.54.0

