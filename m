Received: from mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F942E40D
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492474; cv=none; b=J863fiCj5vLoN1FHYf28p7XpCG6UfP2F8leAFgVIEhW7glKoxMQlzHLPijsJgopPcbUJTAS+VcC4vFhoU6eUb2poTalYKe5wuKZuW3o9IhFl42yVo73ojbejsknY8JH984Ot8GJ6nVu9VZneSd4XvMaiygEEcHES0ICS6jnEbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492474; c=relaxed/simple;
	bh=P8MRoPLRKCGChVXPXdFRnf8HA6/3N+Nsw8UiofzsD5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHKQj9owttFPPBKWH7hEeMYRHbeNrLldhk/p9kwow1l0oL40mB9KGpFIkqBp4kg3sFTY5bfMfzURMgiok0qtIJYfbE8W7emwQUhceqb/PPX0ntBu7Elt1604Jke4IjbWeX3OoCnD1Ez96EMjd6UVnmKq6cg3LwZuRAR8JggJq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WpI2l32t; arc=none smtp.client-ip=91.218.175.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WpI2l32t"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P8MRoPLRKCGChVXPXdFRnf8HA6/3N+Nsw8UiofzsD5I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789492470; v=1; x=1790097270;
 b=WpI2l32tTW5Qz7Ne6DwzAXjVgv3CGPinz/crUarWTnuw5/6mYqtmLGqoHARtKT/VkyWCo/Mm
 6UdJiggGw5+8oKYg+YKnpJyOTnAMVsopKVFjrxhRY7K+OmGlXlIgXxYPm+/0GOsbPdHUWmsf3Wj
 NyQMxQwxYDcx4fg/5aHVWZkU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fc8e3f985608bf81;
	Tue, 15 Sep 2026 17:14:30 +0000
X-Mizu-Trace-ID: fc8e3f985608bf81
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
	'Dmitry Torokhov' <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v5 0/2] HID: flydigi: add support for vader 5 pro
Date: Tue, 15 Sep 2026 17:14:23 +0000
Message-ID: <20260915171425.11058-1-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

A few days ago I was contacted by a friend of mine who was having his
share of issues with his Flydigi Vader 5 Pro controller: specifically
the rumble didn't work correctly, alongside other issues that were
partially solved by using the linked project.

However at the current time his main interest is in Steam support
and the driver was working in everything but Steam, which insists
on using the controller in hid mode rather than evdev mode
by default, and when in evdev mode it is disregarding additional
buttons and the gyroscope.

So we ended up with a perfectly working driver for the controller,
that at the cost of gyroscope support and back buttons has
rumble working correctly in Steam.

Since the driver works in basically everything that is not Steam,
including the browser, I decided to submit it anyway as someone
else will surely be interested in using some other way that is not
the aforementioned program.

To make optimal use of this device the xpad driver should not
bind to the controller, and this is the case for more than just
this controller as Derek told me, so I added some basic infrastructure
to use the best available driver for the device.

I also want to thank the original authors that did the work
of implementing the controller the first time (in SDL).

Best regards,
Denis Benato

Link: https://github.com/DuncanTPerkins/vader5-pro-linux-fix

Link v1: https://lore.kernel.org/all/20260807012334.58737-1-denis.benato@linux.dev/
Link v2: https://lore.kernel.org/all/20260808122439.69159-1-denis.benato@linux.dev/
Link v3: https://lore.kernel.org/all/20260811125856.1692045-1-denis.benato@linux.dev/
Link v4: https://lore.kernel.org/all/20260912015926.230874-1-denis.benato@linux.dev/

v2:
  - HID: flydigi: add support for vader 5 pro
    - Solve flagged vulnerabilities
v3:
  - HID: flydigi: add support for vader 5 pro
    - Solve the flagged vulnerability

v4:
  - HID: flydigi: add support for vader 5 pro
    - Fix rumble possibly getting overwhelmed
    - Implement battery reporting
    - Improve imu reporting

v5:
  - HID: flydigi: add support for vader 5 pro
    - Fix reported security issues

Denis Benato (2):
  HID: flydigi: add support for vader 5 pro
  Input: xpad - introduce a static table to ignore devices

 drivers/hid/Kconfig           |    8 +
 drivers/hid/Makefile          |    1 +
 drivers/hid/hid-flydigi.c     | 1159 +++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h         |    3 +
 drivers/input/joystick/xpad.c |   24 +
 5 files changed, 1195 insertions(+)
 create mode 100644 drivers/hid/hid-flydigi.c

-- 
2.47.3

