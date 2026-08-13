Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842D1B4257
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632462; cv=none; b=NEGdfUMlpRz7S4T5AhLeauwUCed0bHpo3XH4K0yh/1yXjl7YVHFWL3zOZq8wWGkPgFmTtYyA82sZSj8VwjL3tSNeagq1PjJ/wGiKnwPCoHA7Z9AFt2iwbMYpk2iEOSgMMZK5O578PZWwaGET1xsVwUdbiebp70qNM5A0zbONZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632462; c=relaxed/simple;
	bh=ErUK27ZKuh4RBpU8ScH4PAnu2SRot97tCbSEW7MR9xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzVRZZhPCi+3UkXgk3ykTu17PHSY2rcmin4nKbWrxsfZd7FyC2Rzpa2HGnRP8nIi6a3fkif6f2DYG5E7vNPKMoRfdacEMPZR6uOTHc3KBg3HbLvCGZXyegJz9655lJLXdkhHZi6Qi/hy8LKm7QV90ChSnnrRuJnteRQUcXL0NOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T2MowDEQ; arc=none smtp.client-ip=95.215.58.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T2MowDEQ"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ErUK27ZKuh4RBpU8ScH4PAnu2SRot97tCbSEW7MR9xo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632458; v=1; x=1787237258;
 b=T2MowDEQXHhtXJbP7xeA0dtOw/ojOo1f3un5lNDhDLP92EjXUjZQ0E9TUPrCxJKQ5BMb6cBm
 x2r31W8BDMjIwnGRv+atre4mF1pSp3S31GU7Air25oorFoYCcjaPSL8SbsvE4uwlxMDlVORmzIC
 4rEwtCWvqBDF9WNX5iB41eUg=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 1552dcd3cf750794;
	Thu, 13 Aug 2026 14:47:38 +0000
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 00/12] HID: asus: add support for ROG Ally handhelds
Date: Thu, 13 Aug 2026 14:47:24 +0000
Message-ID: <20260813144736.2477941-1-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds support for ROG Ally handhelds in the HID driver for ASUS devices.

The changes include reinitialization of the device after exiting a sleep state,
gamepad configuration, vibration strength configuration, joysticks and triggers
range configuration, anti-deadzone configuration, response curve support,
force feedback support, gamepad mode support, turbo buttons support,
and button remapping support.

This driver is based on the original Luke's work, which was a great starting point
and I have reworked it to be upstreamable, while keeping the original functionality
intact and extending hid-asus to avoid regressions in functionality such as the
backlight control.

The ally support has been a surprisingly long task, spanning multiple years and
being used in Steam OS and well as other distributions for quite a while,
and I am happy to finally be submitting it.

At this time LEDs are not part of the patch series as I have work in progress to
unify LEDs handling across all ASUS devices, and I will submit that in a separate
patch series when the userspace interface will be ready to express capabilities
of these devices, but that will take some more time.

This driver is the culmination of a lot of work, from many different people,
and I want to thank Luke for his original work, as well as the many people that have
helped me test and provide feedback on the driver: Khamunetri, Jonathan, Derek,
Matthew and others that have helped during these years.

Best regards,
Denis Benato

Denis Benato (12):
  HID: asus: reinitialize the device after exiting a sleep state
  HID: asus: add support for ROG Ally handhelds
  HID: asus: add gamepad configuration
  HID: asus: add vibration strength configuration
  HID: asus: add joysticks inner and outer range configuration
  HID: asus: add triggers inner and outer range configuration
  HID: asus: add joysticks anti-deadzone configuration
  HID: asus: add support for response curve
  HID: asus: add support to force feedback
  HID: asus: add support for gamepad mode
  HID: asus: add support for turbo buttons
  HID: asus: add support for btn remapping

 drivers/hid/hid-asus.c | 4171 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 4011 insertions(+), 160 deletions(-)

-- 
2.47.3

