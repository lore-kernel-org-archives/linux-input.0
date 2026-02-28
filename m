Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289134EF17
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305826; cv=none; b=VY2zYCjHXBsgeH9X4qnKsz9xVw0Wb3Lb7UxnfMVKPJnQzw9k5G4KUaPZV8Nt1WV5zgwgGaAG0jsWhJwDugLJo4bIsbZCUIwItBvwjizjwQBZ0WakQ5ezVy4dRqEIFlB3AFDGUsxlracAhJVRYzqY7QQcO9zPSPMoBi3tNc6jhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305826; c=relaxed/simple;
	bh=rU6tPBJy8cdQUE1oYIBwIfS6S+qtgjndX6Mrk7N9iKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+NpZoJlR594penIoaAEDhkkOq9z3rQBy0JL3ck3FqxELhog8ftsvwmnIMaeTvn4Zll8c0HdJfD77kYiHGWYL2SCcCv80oqRbQSuMK7c4xpQRZ6hNaAyDqhnJhrOUgL692X5YdmgqyUsstF4jzWrJjN3oD9TJa4xwwZaarVFMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EsfiSPzx; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EsfiSPzx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772305820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6z6A8GfKDdwXcRziwxbboclFvxXTUsTKZ5mbukJF80o=;
	b=EsfiSPzxTdP8wfYrHMQ45mOIMlaYSjdd7nkZ4Qif/DMe471iO00HLPZTgEXP0Mucu1LEfe
	qlb4+SYjHisjyxcDTM5D5nAXUZK3K32URJ1rXtaZBj7kb9rqjybJX57Yfx92qOAJ22tbCI
	XeS4pTHNq8Xs8TXSEBU4y5V3GQ5ltkI=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH v2 0/7] HID: asus: increase robustness of the driver
Date: Sat, 28 Feb 2026 20:10:03 +0100
Message-ID: <20260228191010.3830758-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

Previous asus-wmi maintainer and asus-linux developer has become less
active in the project and left me in charge of advancing the support
for ASUS equipement on Linux.

I am preparing to send a patchset of his revised work to support ASUS
ROG Ally handhelds devices and since that work is also useful in
expanding support for 2025 models it is important to improve the
hid-asus driver as future patches will build on top of these changes.

Cheers,
Denis

Changelog:
- v1
  - Initial submission
- v2
  - Remove another warning about a now unused int ret.
  - Fix a regression (already in for-next) about leds not working anymore.

Denis Benato (7):
  HID: asus: fix code style of comments and brackets
  HID: asus: add xg mobile 2022 external hardware support
  HID: asus: fix compiler warning about unused variables
  HID: asus: make asus_resume adhere to linux kernel coding standards
  HID: asus: simplify and improve asus_kbd_set_report()
  HID: asus: do not abort probe when not necessary
  HID: asus: do not try to initialize the backlight if the enpoint
    doesn't support it

 drivers/hid/hid-asus.c | 74 +++++++++++++++++-------------------------
 drivers/hid/hid-ids.h  |  1 +
 2 files changed, 30 insertions(+), 45 deletions(-)

-- 
2.53.0

