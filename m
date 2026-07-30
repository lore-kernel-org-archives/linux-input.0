Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD0388E7A;
	Thu, 30 Jul 2026 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442737; cv=none; b=NzWpVLIapaPs1YoBS1diNKYXvi8WGvxtO3e1UZbRRBRVfvitQQyPIe2xhm4foUlqJO9QZ6XRsJMpNdmzVpjSrxa1JMoZ713bR0OKZ10MbydEKFUH8AyWTqBwgYwnEvIudptYnJIWK1ACExInR22h/2p9l3Kt6MHcq1aN+X+MEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442737; c=relaxed/simple;
	bh=kS07rs8jAWlfe7B/LvYSaMcoT0php0+PprTpBsh9mz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lCmucU7asLVq3cZCfwasS03FC+yjyO/+RKDMt9sn9J5DYHbHk6Klokwbcp/Rw8n2tpjaRATtP3xtZUDjcnL5VQylrV/VTs1CBBmK0ElxDGKLfvJP3inYQHOeVh+/hGqJvO1lioJV8tp3q5BbwZojdh6keKEMtQ3T93Wtegkr3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VyGQHtVQ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VyGQHtVQ"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 014BD41C0E;
	Thu, 30 Jul 2026 22:18:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DWGMjAyJ6sSe; Thu, 30 Jul 2026 22:18:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785442733; bh=kS07rs8jAWlfe7B/LvYSaMcoT0php0+PprTpBsh9mz0=;
	h=From:Subject:Date:To:Cc;
	b=VyGQHtVQCiAKAqO4qzEvPg4T0GQUPVQUbWPMcarK+8avEWPCr75UxxvuP6C998Wdb
	 W61i0LO9yuaEiQds3TeRc9CYPJwTP1zxQcK3OZ/Lj6pVu8itIYWfO8s0J52MGhckls
	 iDiz6E32M9U7VE3Lh4xckLVFhvwg/IGaIy8lRZdWje5HbFsAxp9HzE89tV6z5iu9Px
	 6e5CdaucoEMwtmA1KgV9cX4VIxIXF6S5Ld1AgxXX+Z/mPFgXmsbazXDL1Ig1Dxa5OZ
	 4c1QESLRRV227ZvttJfhZAN4z7IltOaxMfyyAF2USnoAOQM/l9y+0kjZYliLwqHh0A
	 /YzlVWCnHXwRg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 0/5] Support zinitix touch modes 0 and 1, dt changes to
 Galaxy J6 (j6lte)
Date: Fri, 31 Jul 2026 01:48:33 +0530
Message-Id: <20260731-zinitix-modes-v3-0-2c8de712997a@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw6CMBQFf8V0bU0fBKgr/8O4gPYWronUtLVBC
 f8uxZgoy0nOzJlIAI8QyHE3EQ8JA7phAbnfEd03QwcUzcJEMFGySkj6wgEjjvTmDASqdGEKplo
 FIMni3D1YHNfe+fLh8GivoGOO5EWPITr/XA8Tz7tvu9i0E6eM2tLYytRlU1f1yWDwzsWD8x3J9
 SR+fMm3vsi+BQFaNYpJ/u/P8/wG/jIQ4P4AAAA=
X-Change-ID: 20260723-zinitix-modes-9c4d409b9ee3
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Srba <Michael.Srba@seznam.cz>, 
 Linus Walleij <linusw@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

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
Changes in v3:
- Add missing review trailers from v1
- Link to v2: https://patch.msgid.link/20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org

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

