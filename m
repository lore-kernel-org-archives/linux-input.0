Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB501A23A6
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632439; cv=none; b=VHCcjUzO2rmPTOABJzJJZ745wA9BZqx4M8i73e6XRF9CQoxEZYOelNSswT/FRV8jg3xjitYBkAyMHfePttLW51DEOOqaljGAFCeEG0xiPkvcWTNBdH19uSePJiWTeYs5BDijd95b3CotDSeZ8xgRgZL0myOzSDr5DhMatfUWbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632439; c=relaxed/simple;
	bh=GMLwta5oNasseK5udjS+I9A6d+Krjq5yftEXv9H/4cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g93Dt3/iAiflfOTpbRjSRKiP9mHr19Ha4+ekgOXQxyFK+vYNcTjzrczERsQW8xtmwc2CwpQiCRiTqnKw6cAjcKZEcnWJDx6fM+Q20KVByhconW9PpK1weHhBCbtYrjSImaainRK4WetuoIVlGc/818YdXpIAmnHJ2K4wkrtJ/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e5kYiAs9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e5kYiAs9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso35014705ad.3
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 21:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787632438; x=1788237238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tEwhTxKNyJs3pF0LaNEucWWGIQ4rU4SyQWya7wYtjg=;
        b=e5kYiAs9AUEqkLYVl5q/MccLd0weqROGKSD27dA9zlsQVc5Y3WxaKxEEj6no8L5bUO
         PHJFA0L+IA2eb5kDD34qacx5HH3zsNvbf/XKqZCQDJkuObLi0bGC0I2hsejE7JkO3cuz
         dFeBjbaAopcVrjwBuaHwlCMt8jE7wFKltOnpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632438; x=1788237238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2tEwhTxKNyJs3pF0LaNEucWWGIQ4rU4SyQWya7wYtjg=;
        b=iDae5uGw4+N78TbRqe5kyGYIeZaLtIKdDAZkb06XZ+huYrv/69ZQ3ZbdiFC/OUSrad
         Qyt9ttuOOF6GGYk0rs/oULs6+SgQJE0YtoSFaGNZaQ0lsoQypPEGBCZ97VUcGQwEJRaq
         tQxuZdvLYTLvgTyDubyRd3vBFEIexHp9e7T4/FtK4w521bCaGp9scTgquXa4bdFn+TfL
         O1Z3VGb9IYdTCQNWJ8iw+sTC0OXsJvf1OaN3c+2fRgVbvfWbOpSFx6FNLeA5nCzrbON6
         vsDVvBOHQcVYy/0pxa7G8vy62QzSy7vXNelQUq2/x3RIU1y2P/WaR20zQSb1uPgS/BTq
         pZsA==
X-Forwarded-Encrypted: i=1; AHgh+RrA2UsjvAkUW4QzPYujd2pEd2ULNtfVW5U2JAqcSAU2v2WWL0ohU2U0Rahvh2C34XmyNIE14eNA7izQCw==@vger.kernel.org
X-Gm-Message-State: AFuF++kchMtdFieHk9mNqQlBu37TkeHqojaMtgaQF0cfptxjdKnqyM7Y
	9q0OfEt2VLvo+lw8OxHxcT8WaGIQx3ggPay2CbRAxsTI/ZYWYQLiDjdUbkSWJn1TCQ==
X-Gm-Gg: AR+sD11UMK2O32320tWODvHK8k+IdmCo5QTVyheGhMaEyra0Lnf8TZHztabBl2O3Z87
	fch3jKapuaPgsQBz27rWO5NtQpooRt6/RTuNf7wyKx8xZMRCEiFRZIbSdYWVHalWQdSL4YFSU6S
	RZhUUpRRk/9RJzQVK3JxUrAP4ewSQgBvbZ0A4iRz7GiPxotiYLiRUKU8DX2086JNq6z1GVIiSYB
	m9X6OZPff3BvdfqCHcRU6+0oGqjmVfLVXgb4x6DHPK6zuDrUkR4b8MTedYl5/FkQ5Y4qnmTS22R
	TUoOAXu7YQHNI3pgxlH/x6z4BaorEvbFdw+Z1PzcLLRg4kGi/D8gUqlkvX8tHX2gJGcsacWvAqs
	3QU2TVIjL/VMLTDpjzRSbCu9LsdeiDTaO28sgeCsGaX/zsZJT/ii85o//Aq8pB0herUeLhkJycF
	dm+SrWHcdqdFLYqk/zhw8ge7S6v9NMWDIry/M2Jnb+yYUhH7stnCEeR/gYQ6RQRdeNyCnQZsRXo
	bauotzedVeyPfKd+c2tB+JdvpDDyDajdIY14U1R6vM4dJk=
X-Received: by 2002:a17:90b:17c4:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-39646519363mr6944892a91.13.1787632437771;
        Mon, 24 Aug 2026 21:33:57 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:a442:9780:24da:cb4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396458212absm2187823a91.0.2026.08.24.21.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:33:57 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v5 7/7] arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics trackpad's supply
Date: Tue, 25 Aug 2026 12:16:25 +0800
Message-ID: <20260825041628.988369-8-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
In-Reply-To: <20260825041628.988369-1-wenst@chromium.org>
References: <20260825041628.988369-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synaptics trackpad, like the Elan trackpad option, is fed from the
system 3.3V power rail. Add it to the trackpad device node.

Also add the correct post-power-on delay, even though in practice it is
not required. The Synaptics trackpad requires 100ms after power-on (or
deasserting the reset, whichever comes later) to fully initialize. The
power is always on and the reset pin is not routed out, so the
implementation could try skipping the delay.

Cc: <stable+noautosel@kernel.org> # Without driver changes only lengthens probe time
Fixes: 925ebc0cd55c ("arm64: dts: mt8192-asurada-spherion: Add Synaptics trackpad support")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
I think this shouldn't be backported, as backporting it without the
driver enhancements just delays the trackpad probing with no real
gains.
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index 68caf4c58cfe..8adbfc307fca 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -94,6 +94,8 @@ trackpad@2c {
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
+		vdd-supply = <&pp3300_u>;
+		post-power-on-delay-ms = <100>;
 		status = "fail-needs-probe";
 	};
 };
-- 
2.55.0.860.g4b6b3295ed-goog

