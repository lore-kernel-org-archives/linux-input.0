Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B33839AD
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274221; cv=none; b=OqF1CC6J6dDVUs41oRyZyCJsAH+C4U9IzccG3cQlN3/jP3grIO8qyVLvAikUPT4hwOCgwX9+9+Ypug0zlwhXoUJz0RotbOdM2LKnA+HYZbnAzpG2xlr8/1kDezuzVsohZ0PRKsjA3K9kkev11wL5sXZSjMqg1QZ95zTyHxSSZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274221; c=relaxed/simple;
	bh=wwJbFpRnfJwmyi+Amde310Ymc0asNFE8qTf9VXlfjXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbiiaE2UzhwQ50z3G49fUylybTiKJBkPkOAXUNVq37fOKzkLEHIpQ66FsuVnDPjpL4foOPOLm7IM6cGFb1oKMHSMOiAOsqLlzzWXRglGeo6MGxdGe0+VsNjija6w5gEaINzfYMdSdWDsQSFgDJhLVypI5czo2b19F15+/E7IHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wM90jJ5I; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wM90jJ5I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781274217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JUUsbNEnGnRR/oDpZbfWaPi9TkrdORr5VEtSRinBLqg=;
	b=wM90jJ5I/e/ObJ37xUcAEOzzoVPCrRngHFYnztwbUtUze+G8bbo617HeeQIaUtS/Q769US
	bX2yTgmOCZ0pi2BUTRWFssuEJ9OrQYNLZ/AfHaCkyqpfqdxOUrx/v9UPs4W6fxS0RMp6bm
	Wvr5Q4+uU1psVX8ssn+3LZes+oimvEs=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>
Subject: [PATCH v2 0/4] HID: asus: security fixes and more hardware support
Date: Fri, 12 Jun 2026 14:23:22 +0000
Message-ID: <20260612142326.1704858-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

I have added support for controlling the (way too bright) XG mobile
LEDs in hid-asus and added the i2c version of already supported
hardware that was probed only when it's a USB.

Auto-review bot has spotted two pre-existing possible security problems
alongside problems in my own code therefore I am producing a V2 including
those fixes and improvements.

Link: https://lore.kernel.org/all/20260612124830.984592-1-denis.benato@linux.dev/
Link: https://lore.kernel.org/all/30258f28-4036-4e99-9494-031212544dc2@linux.dev/

Best regards,
Denis Benato

Changelog:
  - v1
    - Initial submission (as separate patches)
  - v2
    - HID: asus: add i2c entry for FA808UM and other TUFs
      - Joined to the patchset
    - HID: asus: add support for xgm led
      - Use the correct callback set_brightness_blocking
      - Stop hardcoding the cled name
    - HID: asus: prevent wrong pointer cast
      - Added
    - HID: asus: mitigate possible use-after-free
      - Added

Denis Benato (4):
  HID: asus: mitigate possible use-after-free
  HID: asus: prevent wrong pointer cast
  HID: asus: add support for xgm led
  HID: asus: add i2c entry for FA808UM and other TUFs

 drivers/hid/hid-asus.c | 76 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

-- 
2.47.3

