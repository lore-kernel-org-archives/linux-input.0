Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB914B04BD
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065832; cv=none; b=tWROabrXR+iglStWhS58FRuodO73UA3Nm9f1zv9yhm0pDmwW5Y8Jxyhamfvf4F6GvEwuHAxhx0ZsAl5bVTaUSQPoyzDMv8ceCwizlifsQBhhJPOjy8uNtg9XbfDng5VqpaQ8NKfjEfNSU6Js0QZ6RezG688jPpj6cHEsSVVe2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065832; c=relaxed/simple;
	bh=rTqf+5tkz4kpPPXcuoh+t//CAQNB2mCXuMUsxqGO+DI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgzY4pL6bQ5Vt0ozKHnVagJ8W2OMEw6Qb2y+8RqLeOKanMZKzro6h7HLfktgX8LLxi04jExyNEFdDn2U4cIHWUAjryzr4ZjhGteswbRHN1a31otQtULY4ntpruzNoI4SaKdrEePpaLwaRltlNL0VsROyjTYjqn4rrX/MEEOd9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L6ZG0iHu; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L6ZG0iHu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786065828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vShJs0v0zY7etFOzKTHBXozOQf4tAh0Z24a1tYSyoRU=;
	b=L6ZG0iHuTrGIDSyPhnLnAW8/n0CwqmX/cTec93M+PPWXGWLCNOdOxza7a7QMjtwYRER92Q
	hOCPhedbY/81zeG9EZEElxxgoBajU7ZUmYduTjJhEBenuYJwddew0ZBYVO1d3R+ckcQDrf
	SQJsC3Mi1W5Dk6gzpE6TmGiXRtLS6ao=
From: Denis Benato <denis.benato@linux.dev>
To: 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
	'Dmitry Torokho v' <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 0/2] HID: flydigi: add support for vader 5 pro
Date: Fri,  7 Aug 2026 01:23:32 +0000
Message-ID: <20260807012334.58737-1-denis.benato@linux.dev>
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

Denis Benato (2):
  HID: flydigi: add support for vader 5 pro
  Input: xpad - introduce a static table to ignore devices

 drivers/hid/Kconfig           |   8 +
 drivers/hid/Makefile          |   1 +
 drivers/hid/hid-flydigi.c     | 887 ++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h         |   3 +
 drivers/input/joystick/xpad.c |  24 +
 5 files changed, 923 insertions(+)
 create mode 100644 drivers/hid/hid-flydigi.c

-- 
2.47.3

