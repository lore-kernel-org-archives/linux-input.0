Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A47248F64
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066513; cv=none; b=jPyQRtZJ7RWyH4ULoxfgUUHlrqwWmHuXn8exHqwu61gL3wLlQq0kOEXuYHHB53ILhe/pWGEbEd6u7uAeha7OybHFKOGaurj76A2QRoMCXLfI8FJoRcuK53M7Sq/e0G7hHvm5npmbn1kkgbw7GSrqOjf7mrs1c8j5LULxUxO3k28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066513; c=relaxed/simple;
	bh=KDA/b2aTZjGk2woTun5t3qc8gJCcrN9qi0tBQucG6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzNFt4Htl4Zy9sEMBzVluD28YwFXouSdxrU0kkz4pbA4G9ggNRnn2B9FNlAIKA9zUmLWbQMOJ5XZHKgfKaDWGF5lJE9TJdsqNJnW/gmHhFCVVDiTnCqeQvF/6DUZhG/2B7ZxRh4aBt+7xqRV0d94fZpRAiUP2TvWfCCLtBOUCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=gq+U4nI7; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="gq+U4nI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786066499; bh=KDA/b2aTZjGk2woTun5t3qc8gJCcrN9qi0tBQucG6DA=;
	h=From:To:Cc:Subject:Date:From;
	b=gq+U4nI77L5OPMWIG4hrFb5dIipOQqkWDM0Xg6OVTZts1QUepy/SFpy154UolcH/1
	 KbRn7g7Bx2Eupdp8mjg2bmYWfq/pCG/E58qZAwAMDV32fhqcsYav9t7Hk8cezwVIoz
	 9Snf/UZ3+kzLdlvbip7zU9dPWsaq17TZ/CYgAcyA89PAmTqXUASoZYBWijDMoWuS8y
	 4uEYoP0q9rby0byLgGTnUH+Ot8weye48w9zanOIoE8T8ZmNMIgnsYqSMEQN8DThG7I
	 4nuJMubH/yZPSY5g/4Jsop7e7FUZZ6aleMXfgS/W5smEOjG0Bmw6mr2eorVyUEUhb/
	 kaw5RDdNleTWg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id A5C4EA058;
	Thu, 06 Aug 2026 18:34:59 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 0/6] HID: steam: Add 2026 Steam Controller support
Date: Thu,  6 Aug 2026 18:33:24 -0700
Message-ID: <20260807013334.2109386-1-vi@endrift.com>
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

This fixes up a few things from the last version, including more potential
deadlocks. It also cleans up the registration flow so it doesn't rely on
having a serial number to tell if it's registered.

Vicki Pfau (6):
  HID: steam: Unregister battery on partial registration error
  HID: steam: Initial 2026 Steam Controller support
  HID: steam: Fix wording of connect/disconnect logs
  HID: steam: Don't set feature reports when disconnecting
  HID: steam: Clean up locking
  HID: steam: Zero out inputs when disabling gamepad mode

 drivers/hid/hid-ids.h   |    4 +
 drivers/hid/hid-steam.c | 1024 ++++++++++++++++++++++++++++++++-------
 2 files changed, 843 insertions(+), 185 deletions(-)

-- 
2.54.0

