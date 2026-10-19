Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C664CDA12;
	Mon, 19 Oct 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404917; cv=none; b=EiGfzudoECiOBUoHEd3ziT0B3aMdl5enkVgUSkaFn8i2lJjbOv/TlcNjR1cvRFLEtI6Q2Kghbxdk2pYnH7albHI/iKW+wxeDIuFeycE2p0mFqiLWkfZPWJHiGo3Fsu3Cfo0l6+IPghrdxGdBBQF6KhPPVG9Db1AYMO0BJ7JBxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404917; c=relaxed/simple;
	bh=CJMAljo0X31hlMad6DtVRHhCz1R6PGcQSDqEL079Z7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DMdi+e+XCH5I7krPtAPUNndVcambfHr0Ka8qrU0Zzz4oKuYoipRrD21pBlAEcZ0JErtZgGZhLNCST9dlXPArOt0gbA/2qTrsDXjkZwoBQdfirz1vxE/FnTy4/N6zK5KiwgZEP71B70ElknKu96+YayXUVGBMvP/OXCwCy8zXQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKAvXeJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKAvXeJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686B31F000C4;
	Mon, 19 Oct 2026 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792404916;
	bh=3CCX+DaSs1pjY8XV3Zfxi3t/2gVCoMre+USCiaGeH1A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=BKAvXeJPwvIUiHc8BNzaNoul3dOLneuLcOwHRQ3ZiDEol15awywaFOOjK/PTvgMM6
	 lKTnAagHBC0yQ/zD3YjXFt1qJOMw1D01GnqzkVM9STdxN1wia4LscI4IaS9XkEEg6V
	 ybPZjmDzOeSBjsDpEpiqqwc9CpoEQBXRDZrFId2S0LqyZiYyY7qVFB49L2swxTpDz1
	 geXrqIsjKuosU0dsqK4gkVI+oljRhwYZoCQg0ovRQxiFp7mERrcwhGlD9/eojV0ZJw
	 Kd4WGAjEr1e1506DCbNQwasasWV6QeYWT8ewus5KIs3YzNbshUo/Dl1A5kFHBKoXMV
	 YagNuGuAtEveg==
Date: Mon, 19 Oct 2026 12:15:13 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Silvan Jegen <s.jegen@gmail.com>
cc: kernel test robot <lkp@intel.com>, Vicki Pfau <vi@endrift.com>, 
    oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org
Subject: [PATCH] HID: nintendo: introduce dependency in USB_HID
In-Reply-To: <999rr212-sp54-sr2n-6pp7-rq9o69463677@xreary.bet>
Message-ID: <2qs9085o-r962-r57s-16r0-4rp34o81726q@xreary.bet>
References: <202610171559.gZ0QBMFv-lkp@intel.com> <3HN3VLNWTGRM8.2HVANQO7V2MPM@homearch.localdomain> <8q2ss5so-r679-247p-o8q3-pror0844p3nr@xreary.bet> <224MMXDV49Y20.3OGRUP8M1CBFH@homearch.localdomain> <999rr212-sp54-sr2n-6pp7-rq9o69463677@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Jiri Kosina <jkosina@suse.com>

hid-nintendo does depend on USB_HID. Reflect that in Kconfig.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610171559.gZ0QBMFv-lkp@intel.com/
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f06263ddfbfe..f88ec97f3976 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -867,6 +867,7 @@ config HID_NINTENDO
 	tristate "Nintendo Joy-Con, NSO, and Pro Controller support"
 	depends on NEW_LEDS
 	depends on LEDS_CLASS
+	depends on USB_HID
 	select POWER_SUPPLY
 	help
 	Adds support for the Nintendo Switch Joy-Cons, NSO, Pro Controller, as
-- 
2.51.0

