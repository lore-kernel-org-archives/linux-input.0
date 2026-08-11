Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709B43E067
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453179; cv=none; b=HgJAKHx7ddA7TxcK2yJDwRxLm7y3hXsu1CVXAxscH4ASEyR654RnoMLGMk34oqF5z6ZofI/zs5b28Z07fhR4kyFVTkpDzwlbKUW66zO7eKIu3BnqpD/UFWtsZikmVEG/njjZxrBFEg7GEQUMX8y/HW7Z79enYCDDTuyV1xINId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453179; c=relaxed/simple;
	bh=jovZhYuNqYh+wIaCWT77NoM8sC6pJlQ79xf9SYuzBao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyR+4w5FuhIYypWJnLH90NQze8puI4UFusRPMpyptM+hQeGLTf2MUBxZiLMl/9exyrP8nBKpcPKUxwhjtZ3mno3j7LBaWjxxOF06sSbuk8mhAMn+gzquNPwzIyTbOksCG940IEF+oFIb/ZFlLQlv9fip+TF6wIf3Y4OdNygFTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WfenxJkj; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WfenxJkj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786453174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V66WnS7L5FcxUfBITwlPiEP0UzaJdhM34KmBLtk+708=;
	b=WfenxJkjqSO5NgLF6L2XrJ3AriOGJWZm/imCGX2YG0FrWmYMBNNBubqnOFn44DiUaIpdvV
	AdkYJIBK49oSMeyZvNFKVE2BdFt9jESmEoEfcAhoSAdML9QeyeMr8BgdAizs2e+79+77iw
	OIm/VLjPVfzCiJqkmsjlM1psYHmxaZc=
From: Denis Benato <denis.benato@linux.dev>
To: 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
	'Dmitry Torokhov' <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v3 0/2] HID: flydigi: add support for vader 5 pro
Date: Tue, 11 Aug 2026 12:58:54 +0000
Message-ID: <20260811125856.1692045-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

v2:
  - HID: flydigi: add support for vader 5 pro
    - Solve flagged vulnerabilities
v3:
  - HID: flydigi: add support for vader 5 pro
    - Solve the flagged vulnerability

Denis Benato (2):
  HID: flydigi: add support for vader 5 pro
  Input: xpad - introduce a static table to ignore devices

 drivers/hid/Kconfig           |   8 +
 drivers/hid/Makefile          |   1 +
 drivers/hid/hid-flydigi.c     | 921 ++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h         |   3 +
 drivers/input/joystick/xpad.c |  24 +
 5 files changed, 957 insertions(+)
 create mode 100644 drivers/hid/hid-flydigi.c

-- 
2.47.3

