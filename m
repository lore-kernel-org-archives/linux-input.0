Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB9C312834
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028892; cv=none; b=JbfU7n7hmA1T0EuD8F8V77Qt1O56whwBH8+2V+yXPN9RE7aqV/vtF7JBfAKulgJHETLD5slCwUBeI8VFIOSZ7SF2LlQH7igbWDRAyfXTfIiCqntLeZgnoojVpDMh7VbRkH/gr9102Kwv32CFzAIOUP/UbuwxbqoWTuKn9Kq+1wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028892; c=relaxed/simple;
	bh=L3MBisgJM5dcEuVWQ2WrPldR+MP7F0CpcGZpinxx1KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q29Tnojk2dwO8JaEbkAspCWFvBpICWUmzfNUvr0DV42038N8yHdv0uMRXpOaUSREAdSYfnZS5CAG7llhPfylzpINtx1mApYjriKW3VyEm/xsvv0p/HIsHMM990AzJo+2sHaq4Z7ulIjt3h0MD7yXZjw3OH1QPxGuRaM2wIbKlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=p/MbEhsD; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="p/MbEhsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783028890; bh=L3MBisgJM5dcEuVWQ2WrPldR+MP7F0CpcGZpinxx1KI=;
	h=From:To:Cc:Subject:Date:From;
	b=p/MbEhsDfxHMNcf5grEtJFWoc7jaQtktcijsR3dCaXJaQ3l2bfLULyvD82Tay4WkR
	 rIQR9Gm2zXLCS1c1yJpYAx92vzNqztUoRXY1xnLdQr22HJDawJyvOX1heq4yHsGRgC
	 4HWjUif5GjTm09CqVWTektlBE2gpqntXgChyQ2qNc89vLYo5Ygb1mMxOnh4Os39uST
	 X6ivNydfpW+SMslI73nu9bpQhVVBUGvcAinBOKx4AMlV4pR4qlMc9VRN+Xluv+eolW
	 mItoySdbeZLbBbul/GZjwB7IGdRJvq/Kvo8tpPOoqlSzZD76ts9dUVAmJbUXUxilam
	 3KESYrkPF42eg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 0D0F0A023;
	Thu, 02 Jul 2026 14:48:09 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v11 0/3] HID: nintendo: Add preliminary Switch 2 controller
Date: Thu,  2 Jul 2026 14:46:59 -0700
Message-ID: <20260702214704.1859350-1-vi@endrift.com>
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
v10, fixing some small errors pointed out by sashiko. The remaining issues
sashiko found in v10 appear to be purely imagined. Hopefully it doesn't
come up with new things this time.

Vicki Pfau (3):
  HID: nintendo: Add preliminary Switch 2 controller driver
  HID: nintendo: Add rumble support for Switch 2 controllers
  HID: nintendo: Add unified report format support

 MAINTAINERS                                   |    1 +
 drivers/hid/Kconfig                           |   19 +-
 drivers/hid/hid-ids.h                         |    4 +
 drivers/hid/hid-nintendo.c                    | 1680 ++++++++++++++++-
 drivers/hid/hid-nintendo.h                    |   72 +
 drivers/input/joystick/Kconfig                |   11 +
 drivers/input/joystick/Makefile               |    1 +
 drivers/input/joystick/nintendo-switch2-usb.c |  468 +++++
 8 files changed, 2215 insertions(+), 41 deletions(-)
 create mode 100644 drivers/hid/hid-nintendo.h
 create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

-- 
2.54.0

