Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922263AE18D
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983308; cv=none; b=helhx3OFFpaXo0M8/scvXxkh0oNcwsxbcEo7bNLEGoOYBPbxo4ccBwKE7And9qfDaEuzzIsKOZMYIi8wigB3Z3KrY3SZBSM+NBNH+5ozKMhHIX58GuHWQaLyHfYpsMIfkRqIlC2E3s81tfcYscx0mFJ5XyB6bRkollPLxWV797I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983308; c=relaxed/simple;
	bh=NXD3srIapAkQl6CmxUB2joj+MItIU5IwdrR+f2NmL4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQwWR0QU5YaVSErJvJ6x5nvHUMRlzs07d17Htm4XWNpi/Fdy4H09vZqfnhh4mFROuSx63iN1AQbi1rvH5oXMyJn0crirLc0Ruan5eYIBBopq38JBmvuotTwkkboIRg2EYSf7SpB5E7pV2xiEC93+zu7nFRFsnhHstHBHORQTNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=pezF3Jt0; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="pezF3Jt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785983300; bh=NXD3srIapAkQl6CmxUB2joj+MItIU5IwdrR+f2NmL4o=;
	h=From:To:Cc:Subject:Date:From;
	b=pezF3Jt0VecFMchi6b8CqEDff4kTNTeBkT+/SaBfhJyumdCPWI3PIXPedgimVzrqi
	 l9cCvtmg3sydQEfurwfebqjV3ABNAhHPHSaRN+jnkPQvUwH48fu3Yo2SgJ8thuAfsd
	 U4rgVXMjkxfszfLZb7bTNxMCBtyZcUHycMzI4GL/oo8rgrIxjnlvgx5xIycjF8rW06
	 mBF+hKV2aMBdN3WajaRCJ3hpFw2pcT4f/H/eCB4w6R4LgYkGrRO8XYKptp7SzYZZs/
	 6WzcAJucWY0q2fwgg4hit46QdXvmr4Hv1qwtIKY/AJNKD30YusMUM9BWNkes5DmcIP
	 Z2mGNHkgpYXjA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 29D57A03F;
	Wed, 05 Aug 2026 19:28:20 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v2 0/6] HID: steam: Add 2026 Steam Controller support
Date: Wed,  5 Aug 2026 19:26:39 -0700
Message-ID: <20260806022653.93939-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second half of a series that modernizes the hid-steam
controller. It adds support for the new 2026 Steam Controller, with feature
parity compared to the 2015 model and the Steam Deck drivers, as well as
some smaller cleanup. The biggest cleanup is cleaning up the somewhat lax
locking practices, but a few more minor things exposed to userspace include
logging improvements and zeroing inputs when switching from gamepad mode to
lizard mode.

This fixes up a few things from the last version, including some potential
deadlocks and adding a missing battery unregistration that made it through
the last series.

Vicki Pfau (6):
  HID: steam: Unregister battery on partial registration error
  HID: steam: Initial 2026 Steam Controller support
  HID: steam: Fix wording of connect/disconnect logs
  HID: steam: Don't set feature reports when disconnecting
  HID: steam: Clean up locking
  HID: steam: Zero out inputs when disabling gamepad mode

 drivers/hid/hid-ids.h   |    4 +
 drivers/hid/hid-steam.c | 1008 ++++++++++++++++++++++++++++++++-------
 2 files changed, 831 insertions(+), 181 deletions(-)

-- 
2.54.0

