Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE663101A6
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782963742; cv=none; b=CCLW9A5HWqCLFqQwZ0EbvBHpd+XgLnp3lj+sNyi74lszNWhyPkBiheUzueI1Wm3074j4NzM+Q4ca/L3zwujj3GQLjxe6x/W03xOb8cuyqrecJ7QsMkrBI9YLGb6cb7PKJs1gOaWcTvedgi/rnM4LFv1/FFMYnq8MnlkKwVbTHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782963742; c=relaxed/simple;
	bh=eCazVq8dbtvNIPX7+Wtdd004hoxfyTle4lhQO+GxZyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anacqZPQVIiRAGiYUkr5MVUCOLSf/5YSeIa2Tr8Bdd8bem+OspJxl4AlGH+xUetQqyvOU0u275eHLe9z/K7EHa1MT2IR9uIWGKZ0GdrEESR6Krxi/oHApYuYmn45QnV8IHRG3vzWZm0ivdOYNklOVHPaKvkSq3P/rACsflnRsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=zuG79Xug; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="zuG79Xug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782963734; bh=eCazVq8dbtvNIPX7+Wtdd004hoxfyTle4lhQO+GxZyc=;
	h=From:To:Cc:Subject:Date:From;
	b=zuG79XugWbyS6COM6pINFpv3FXLd333W4ynbuUqcdumJigaFWGKUNig/hJoM7q+M+
	 NQQVh+GEXgritzRyg25PYATuPQJDCpf2mCRmoSVb+QmSnrtmqBIQ13CwEjNeaHbatx
	 BvuzgqdY0o1UaqQppW/neSIf3WVs2ybe2eCHKwyEGyc7rNSOh2ivYYtFECgL98tUXv
	 kRp/KxY/egQelrE1jAz/0bT0Ldp+yF5D3J1GQrsV/nnCGRl3MQjvCJoSDXYFZXPMSL
	 13w+Qbw6x4bDoNDQipFNqhuKuRSdsn2pT0sWQFPXmx9cEh524NJJm97/HurUhX+mdl
	 OIFjYB5B/A3lg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 32669A010;
	Wed, 01 Jul 2026 20:42:14 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v10 0/3] HID: nintendo: Add preliminary Switch 2 controller
Date: Wed,  1 Jul 2026 20:41:01 -0700
Message-ID: <20260702034106.1498056-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds preliminary support for Switch 2 controllers using the
same split-driver model as previous versions. This is a minor iteration on
v9, fixing errors pointed out by sashiko and moving both the led structs
and the rumble work to be devm-allocated based on the input device.

I think several of the concurrency issues pointed out by sashiko are
impossible (e.g. a HID device receiving events concurrently with the remove
handler), otherwise there are some major issues with lots and lots of
drivers.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1681 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  468 +++++
 8 files changed, 2216 insertions(+), 41 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

