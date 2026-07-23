Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295853C108B;
	Thu, 23 Jul 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834669; cv=none; b=FrCjRDNbyvtz6BgIsPUu7VzhCy1HycpleTgP0SRSy/HtA2faYg4mQUY0DOw+03J0REnGKazxv0BM3RDbMsLRw3JrlMAdh4Zc49i3bZ0Jz7mTwVQGlWVd7Q6UOO36JQHCmAqekQeql/HPTBDS4wJ2dP8HjMOMgut3bs1ZCcVCGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834669; c=relaxed/simple;
	bh=0IyY3WD1+waTTaaDTZVwe6gg2HdaKZ9OBT8RRjdbj1s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jKKlJ8ycVCXYp0T19eC9cMhfd3PucEWJ/ng31FLCFRloTU2nMo0KF6FJuTGMJ0i7pLV/I5HG5ZhV7ilxxYzjAvzFWgr3l3OegDEZ5HP/CJdELrucR/3tMwtEP2cg29HOmHJpmqZ3UQTtbQQ+KnmawhGcDVytiiCEoO0z1Lh/+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NUtEnkGW; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NUtEnkGW"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 767938444E;
	Thu, 23 Jul 2026 21:24:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ok0EQX9YxwfW; Thu, 23 Jul 2026 21:24:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784834658; bh=0IyY3WD1+waTTaaDTZVwe6gg2HdaKZ9OBT8RRjdbj1s=;
	h=From:Subject:Date:To:Cc;
	b=NUtEnkGWLMDuU/4EXZJvE5m5wo/pV5Xqombi8N+R+Y/V2ulyrC/TSSGFfsDPkYoXG
	 +HGp6+g+EXljg6sWaFkVIfFS14mXkuBafwJx8h6lpnlwlJP+Bm91qO4tAEiN0tIMBU
	 pFJa3SVNbqQOdp01I8H39FUomaJpum9pNZ9rIkk+lG+kmXT0A1fnxAmepBLqxZr4Ji
	 BoRh8zoTZ0Qesn2Lmq5nh/J5UgVvbiKi14UfZkWr0YQE+QhpMf+ehOyEEps95hAai/
	 xqeL6M/s9t/I8eIgoOBFks5CI6YQJ0CWbyuQ7g+DiKxlDNj09mRGWM1qaLSG2gl2gR
	 Q98H6bmhGbK8w==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/5] Support zinitix touch modes 0 and 1, dt changes to
 Galaxy J6 (j6lte)
Date: Fri, 24 Jul 2026 00:54:02 +0530
Message-Id: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrBtIoyjpVaQLTf7qCEbJqIji3
 U3b5bd47yRBZAi9spMiNhaeQsLzkZHrm9BBsU8mo02pK5OrgwMvvKtx8hBlXeELbVsL5JSaOeL
 D++9Xv/+WtR3glu+ErusG7RyfkHEAAAA=
X-Change-ID: 20260723-zinitix-modes-9c4d409b9ee3
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Srba <Michael.Srba@seznam.cz>, 
 Linus Walleij <linusw@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

The zinitix family of touchscreens support at least three modes, called
0, 1, and 2. At least some digitizers (including, but not limited to
ZT7548) are able to support multiple modes. Currently, the driver in
linux supports mode 2 only. This series aims to add support for modes 0
and 1, accompanied with necessary architectural changes.

Among other things, perhaps the biggest difference between multiple
modes is how the touch report schema is laid out. Modes may skip
reporting certain properties such as touch width and pressure. For more
implementation details, the android driver [1] can be referred to, which
was also the primary reference material for these changes.

The last patch is for the Samsung Galaxy J6 (samsung-j6lte), which has a
zinitix touchscreen digitizer. By default, mode 2 is assumed for the
touchscreen, however the downstream kernel driver [1] for this device
uses mode 0 by default. This creates an issue with aftermarket
digitizers where mode 2 implementation isn't available simply because
it's not required by the driver downstream.

This last patch needs to be accepted into next only when the former
patches are in next.  

[1] https://github.com/samsungexynos7870/android_kernel_samsung_exynos7870/blob/master/drivers/input/touchscreen/zinitix/zinitix_zt75xx_ts.c

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (5):
      Input: zinitix - check all available fingers for every touch event
      Input: zinitix - do not ignore non-moving fingers
      Input: zinitix - add support for modes 0 and 1
      dt-bindings: input/ts/zinitix: document mode 0
      arm64: dts: exynos7870-j6lte: set mode 0 as default for zinitix touchscreen

 .../bindings/input/touchscreen/zinitix,bt400.yaml  |   4 +-
 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts    |   2 +
 drivers/input/touchscreen/zinitix.c                | 144 +++++++++++++++++++--
 3 files changed, 136 insertions(+), 14 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260723-zinitix-modes-9c4d409b9ee3

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

