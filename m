Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89A3A6412;
	Thu, 30 Jul 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440930; cv=none; b=D+JnVo8nuqyUAK6T9pbAFbo/8aUyCwSNkpDlW7B22j1Ta0G/TpJFi8DBwOUZ1Tu6YkoFj5+tR13uPn7EoTVWlP5JFKHxR+mtutcR2z7FBZUAQgwG2rv1zLW2rC23utGqqSO7i/zr31FlUUOdefN0xEKNDUEUdctRf85X2rUFmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440930; c=relaxed/simple;
	bh=PpQVb8pOQOYjNyqKeq+veae0We3CXyLCN2DcwEItMdY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZvGtVWqGfRJXMWuORsqtAu88tn2jluSwZs5OgIftYx2T7xGVePdstCMDbTPqlZa+URQLQQdpFGyOrdPopkihItysWlQj69jGNEBQ+fEIyw4LnCE4jcB83+KtPPiaKPKwrHIlbrsRoyZIQZdI4eP9o9xjGmtZZt/cVE3EE1rlypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FcQXTNET; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FcQXTNET"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 573408498F;
	Thu, 30 Jul 2026 21:48:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXOYjAxLIJqj; Thu, 30 Jul 2026 21:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785440916; bh=PpQVb8pOQOYjNyqKeq+veae0We3CXyLCN2DcwEItMdY=;
	h=From:Subject:Date:To:Cc;
	b=FcQXTNETUXh/vagHDrt7ljIdIUxM//fKV5XyrRr+oPOwJKQ76oZ3yorHCTsPGBess
	 d40+1Wc4YJCeEuRRQcBey1Vhr//6savdJfP4FormbNOWZQq8v82DMZYDIlIOsNgIBU
	 JiVS4eMBaNTrqPcCHI2hrd9WCOXH6GaM4aaeaZhOGi2SC8V1ESWWaKPuV1UuHZkZbZ
	 DcFGXbt4R1T1t0ZjZkcqPOb2H6+wIyduOTcfEV90tLhb3UBwTIZXWQ/BJHZy/JiJKG
	 rnTXtriqAyFdwiOhwfS3V+TLIhjnpVAX3FvgPGsZQVmYWfLEBOIXLZVDoCNkQon1k5
	 BZb9qftg5hnfw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/5] Support zinitix touch modes 0 and 1, dt changes to
 Galaxy J6 (j6lte)
Date: Fri, 31 Jul 2026 01:18:20 +0530
Message-Id: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ6CMBBFr0JmbU0phBZX3sOwADrAmEhJpxKUc
 HcLxo3Ll7z//gqMnpDhkqzgcSYmN0ZQpwTaoR57FGQjg5KqkFpl4k0jBVrEw1lkUba5zWXZlIg
 ZxM3ksaPl6N2qL/OzuWMb9shuDMTB+ddxOKe792vnf+05FVJ0he20NUVttLlaYu9cODvfQ7Vt2
 wfPyaIBvgAAAA==
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
Changes in v2:
- Change condition for calling zinitix_report_finger() (Dmitry Torokhov)
- Use function pointer for read_status_mode* switching (Dmitry Torokhov)
- Link to v1: https://patch.msgid.link/20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org

---
Kaustabh Chakraborty (5):
      Input: zinitix - check all available fingers for every touch event
      Input: zinitix - do not ignore non-moving fingers
      Input: zinitix - add support for modes 0 and 1
      dt-bindings: input/ts/zinitix: document mode 0
      arm64: dts: exynos7870-j6lte: set mode 0 as default for zinitix touchscreen

 .../bindings/input/touchscreen/zinitix,bt400.yaml  |   4 +-
 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts    |   2 +
 drivers/input/touchscreen/zinitix.c                | 141 +++++++++++++++++++--
 3 files changed, 132 insertions(+), 15 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260723-zinitix-modes-9c4d409b9ee3

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

