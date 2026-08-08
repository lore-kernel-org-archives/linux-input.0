Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACF3CF670
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191900; cv=none; b=PUMXeVJWYBPQ9WbxATNtnD+tdiwz4Da8+4vIHaLg7+E0ScqjsGaZ512FGG21XDnfK77d1pV2x2VXZuqszl18H4CnXo1IpS5ZBx8o1DFzMeDEUyk6X8GhdIgGcDYvHsRmXTthVsJ5aCFoSsRxwxblm9s6hpTzCaOhqdEd+h6umLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191900; c=relaxed/simple;
	bh=q7cCMqVuu5NNa4Et/ZKMaFoSIq5SdCCqd6kSNRx91+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLtbHrtiqShNEP3eSW+l3kAYwVJqHHY4UfbM/tahJIDK7Qd+/kWg8qBtEaRixeBHxRuDYdEauE9HmppL0LFNoBwAZ1CO2oGrs6+fCvtjQ0kVCRGDAONOQkh88IqRJ7bsE2K+8ALiKnRVHVS6dybQ8g5mr37e1HRgdMVjX/1bto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O1Le5Xgf; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O1Le5Xgf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786191883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WB4Mue+tg13gXV4TePbsCJ/6IHcoSwnkRpa0ur09XyU=;
	b=O1Le5XgfuMWpYLXi9SZl8QA3s984sK+N3tUQ053DELNbI4e6ASLi6zgrPPO1nsxwPdkCOw
	5se2akYfYekiErtsHlD+mayRUReYGeeS/mY5Qg+gPD7U6qh3JKrlITJzo6Xr+H3QaxVhpk
	YY/djsOfjXBiWen3ORl5bOXbAM2rNr4=
From: Denis Benato <denis.benato@linux.dev>
To: 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
	'Dmitry Torokho v' <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v2 0/2] HID: flydigi: add support for vader 5 pro
Date: Sat,  8 Aug 2026 12:24:37 +0000
Message-ID: <20260808122439.69159-1-denis.benato@linux.dev>
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

v2:
  - HID: flydigi: add support for vader 5 pro
    - Solve flagged vulnerabilities

Denis Benato (2):
  HID: flydigi: add support for vader 5 pro
  Input: xpad - introduce a static table to ignore devices

 drivers/hid/Kconfig           |   8 +
 drivers/hid/Makefile          |   1 +
 drivers/hid/hid-flydigi.c     | 914 ++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h         |   3 +
 drivers/input/joystick/xpad.c |  24 +
 5 files changed, 950 insertions(+)
 create mode 100644 drivers/hid/hid-flydigi.c

-- 
2.47.3

