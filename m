Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680695;
	b=SkjOI3cICZsiSITZTz3u0EUMonjvhE0XjLbktifNfvzoeox9L/oa1CsS8f9wGN5uDLOI
	 LpWg738cVyQAmG+VNvPWgj4zWmzd09BiPv8a8uvnq3zzBu4QMkJ1LFgFx/3GZPfmIPUDT
	 0u7m5CurxWjydaWRFA1lHOPwHGtLqq3RFxk0dk+tMPnTflW8Z9NQmBiBaETMhDwRpESn6
	 4hzchrxnmnq5YkotWcc6pPc0eBySDPkwE3G0DIJvWHD79MSiolo+U/XpXvT0MG4MST7re
	 qWTH+udNZOLhC4UPghnZCyDTbsdLdtWAKZR9PHvOmvYb/miHQ+vOnR52A85DqPb62SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zgiOgJde8AO2Ant4XAq57iC2YxxS16EtAa2Unl+I3/g=;
	b=mK+WOSWqV6sows3RzIxziJ9q+K8O9E37Nh5x2B5Zcig/jWyqMlfNiBMgBqGWgybGB3wT
	 34tPqVi7wwZjWoMTddx5qjPJpGE+1wz26YoaxSRlfWdIl+kkM1r7+bm0aeCBa6BFDOyRz
	 xHk/pgRGzNhF7Silus3+AkcrlH40zDr3nGV+PoIj6AkYFo00WjGUTR9iC5QsO7nmy4BSZ
	 SNdY6LTEZ+LbfsOcG18gnNxvJW8KxTrd/yv41VMVXcWqO6MQPvm5eytAoqI+XS89PEAl8
	 /1GliUHAQBpE3fVfE+X/DFk5qbuJ46IIfN97vO1BFYzWAM3zZk6IMvvdRKWKn8Fyhhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RoNQqV9j;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20502606A32E
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20502606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RoNQqV9j
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2773741a91.3
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680694; x=1794285494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgiOgJde8AO2Ant4XAq57iC2YxxS16EtAa2Unl+I3/g=;
        b=RoNQqV9jBrmKq8aPFdUcTGbhVq76VWe87Mk0rL8irAkCHESNHOA4Uxwferz7yyQfJh
         SJWMN3tlTNiv8tPOeYP9r1CMapa9/kJJVIQpyaVj8d/rM5Joxn/TAlRqQpNSj5fXICvl
         EDvslT7pOQqwACyXNaamHO6m6jd1OzMy6DMpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680694; x=1794285494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgiOgJde8AO2Ant4XAq57iC2YxxS16EtAa2Unl+I3/g=;
        b=M8KWcYNdzGMuU/tMC7NsV4CsXU2hYcVqv8S6CvkCqlYiTdm8qLAjEG+KGu2/+IFy6j
         kXsYKvP8zGN53LOPtzuzlTSdCzEpJ9MxcDzWhXYOnG62eJmrOgNtjhhrcPvGiupeWseA
         qZ64KBclOQPX4+GElCYA6/p/siKeSn8LA0CWqncSsj3GWYRreRcKIBF9Wk2N6Va5js1N
         nXo99KP0+bN2KPc03QfTctHDoxUUVenNE3oZulO2cN0ZDlJgoZAtIcU5n5bcsu94ZXJB
         c833B5VQQgLHe5zgaT7x280ZTcCkw1gRlAZ8jIjqUmFYax66esAOILhDf9EJqq63eU8z
         xzkQ==
X-Forwarded-Encrypted: i=1; AKwUvByT2rJL4BP3FaOLNKPBQFu6BNQ8sse5r9Yv7svRcUsLjRxhV7f63NZ1MuY2yWnGXg6XxreLZWad4nORyg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gYt16cB6vAL5RcVm1IeoEoD3B9EV8f4ICoDl0NfIaxOUeRS8k
	NHRGm87lxfGa91TT58TtajmNCy+4jPahtFgQYzkNEJg5MsYBQdDHgtdhppeKpj8kmQ==
X-Gm-Gg: AYBFou1RGuEuDFG0wwhQlu3lDhfptMXf/2yABDq0bHaztwytBm1K5Qenvj+/hI6H+E7
	r3frSIB5/yjSVtkCVLjZNNyNlFuRoSHMM+GmrmcXih8Det7uepCG6PJZYAUcNVBeLOg3X/yfzVp
	vNdaCbJMRqkJkHrNARLMYGH4uM6W5LCnqZrc5YzOXYoKPR39Dm3mu8ahhaxN/XQmO0/+hrPPKug
	bshkMzT9ul9/lhVRflPkGcS91Kxrb0rDZOqmqEz0DuFd+pjzSPYHbABgwJ8Y+Eo+qJ7haCTppy9
	/nWoHLcpIwwKBB0kXOBMp1RQwwDqzsJOKeYh4OWa0iiKRRUAznnjQM9Pq876zlQgmOnnNiziVTh
	WZA63PFs4U1PVX/Z325WIjDY5MHJkKCoEVvAg4wpVzlYbB3xyiU6HwhDCWANJXVx/mMi9+ERtLS
	9Ax0wF19MXtmykMCKthqFVz5DCOa5xsJLGnMI1OiBmbY2Q/mCz09MkWqVD9CVw8KpJPSzgtaKFX
	bSIIpd3IuG7F9NCP41Bapx9Dl097esypJ/YpJSYU7KKSv4BmG6wqytTZOAb5sE6qWWUgYfYB5YF
	APtpAcnsAruLNBNkPsyrN3VhN/CHxi3y60OvIKjrC4mkoZH/9TeIHcl6YSlp5aOlEad9t8FTfc1
	D3rPvmpab9KRZ
X-Received: by 2002:a17:90b:4b10:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3ae89724b06mr9920661a91.10.1793680694591;
        Mon, 02 Nov 2026 20:38:14 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:14 -0800 (PST)
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
Subject: [PATCH v7 7/8] arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as always-on
Date: Tue,  3 Nov 2026 12:37:31 +0800
Message-ID: <20261103043734.2179858-8-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up until now, the MT8173 elm/hana device tree has set the dedicated
regulator supplying the trackpad as always-on, simply because the Elan
driver was missing proper delays. As a result the delay for the
Synaptics trackpad was also omitted, as it was not strictly required
under such a model and delayed the availability of the trackpad to the
user.

The Elan driver recently gained proper delays after power up, with
opportunistic skipping of the delay when the regulator was originally
on. The I2C HID driver gained similar opportunistic delay skipping.
So has the I2C OF component prober library.

Now fix the device tree to have the regulator not be always on, and
let the I2C HID device have the correct post-power-on delay time.

Cc: <stable+noautosel@kernel.org> # needs matching driver changes
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- Added noautosel tag
---
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 8 +-------
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi      | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
index 1004eb8ea52c..b9e311fcd9a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
@@ -62,13 +62,7 @@ trackpad2: trackpad@2c {
 		pinctrl-0 = <&trackpad_irq>;
 		reg = <0x2c>;
 		hid-descr-addr = <0x0020>;
-		/*
-		 * The trackpad needs a post-power-on delay of 100ms,
-		 * but at time of writing, the power supply for it on
-		 * this board is always on. The delay is therefore not
-		 * added to avoid impacting the readiness of the
-		 * trackpad.
-		 */
+		post-power-on-delay-ms = <100>;
 		vdd-supply = <&mt6397_vgp6_reg>;
 		wakeup-source;
 		status = "fail-needs-probe";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 777da2129e77..2c6ec714e117 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -1098,7 +1098,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-enable-ramp-delay = <218>;
-				regulator-always-on;
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-- 
2.56.0.385.gac671c819a-goog

