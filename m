Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A591DE8AE
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782363666; cv=none; b=dQF2Nbki6NRsTcidYfvstM1UPfGmrlKF2lzOMf06nJ9m4Ds3u4rnIOh8VzS7JiS1klsDIf+CxZ0lcAZC4Q1rEkUoJusmClVu0FJ8XOQPjduCvz1cnLImD3D3BIscybgRRMQocvWgDYAE4z2Dhng4kdCG28Z5ONZvVKzUH9MwiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782363666; c=relaxed/simple;
	bh=nhXTcmmupLcNWo6ucXl3EUDfwH3IE+c9UvSar5v3dMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvP9+eNn/xro+0Fl5UStJzFxQGe+IBUkzGHayIyj1NOG8d+HKKgceJTLzBPViFK4I/34Dx/zmPTxp0CAf2FdlJSyXyVbg52usmpfrLSRoGUdr6/5z0DsBJ829XHT0pgeGBTpXZ30CDgrUT80dvxtb0e4MSn7XtkB7vVCC7vF/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=0Ph3/5XA; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="0Ph3/5XA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782363658; bh=nhXTcmmupLcNWo6ucXl3EUDfwH3IE+c9UvSar5v3dMM=;
	h=From:To:Cc:Subject:Date:From;
	b=0Ph3/5XAqTcgWqWWuoHiZQbz91G+KcWLv1QEe5MMsDYrpofHozuv5DwA42znTVyaJ
	 K71lE0QNPfAFEdBoA0A0QmQUnW/gSsJ4NIhfM/8/To0gz7GGoQc5qMMWE69Ie6R6SP
	 iYMI8PcEITX0fd30yZV4gWd7PbNQTxbTbYt15A5+QJNGwn/Oj/8WlZLPaRsAZfKYd/
	 eS0vAuBsHKYdiNe7wSwvX0z7NQ+2AOSphydDz/q4lNfxLjvnjk8zMAu/4JHTZprUmx
	 umh9rMZj7kUMQ7taLC3y+L2CCaioY88U2++B7LGicRxQuvcRgXyPQtMNrXsx5LV7Co
	 RQUCx1ow6POJQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 47ACBA02D;
	Wed, 24 Jun 2026 22:00:58 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v6 0/3] HID: nintendo: Add preliminary Switch 2 controller driver
Date: Wed, 24 Jun 2026 21:59:42 -0700
Message-ID: <20260625045948.2343168-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds preliminary support for Switch 2 controllers using the
same split-driver model as previous versions. This is an iteration on v6,
fixing errors pointed out by sashiko and others, as well as adding an
additional packet for the rumble initialization that seemed to be necessary
in some instances.

It also adds retry-throttling that had been previously discussed, but I had
called unnecessary. It will leave devices in a partially-initialized state
and log and error. While it should be unnecessary for first-party
controllers, once third-party controllers start shipping it may prove
necessary.

I've removed the Reviewed-by and Tested-by as enough has changed that I
think it could use a fresh review/test as needed.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1552 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  396 +++++
 8 files changed, 2042 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

