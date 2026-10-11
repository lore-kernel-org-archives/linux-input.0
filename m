Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1E449B0C;
	Sun, 11 Oct 2026 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722890; cv=none; b=jeea8pDkCb/J63GJG+83SuX9T0v6P4Nb9t8ArlPFnLdv7US1978r1V8rP6TsoOusak9ox7XEfrUvIMtqc0En3TzKgy2yIIg6eg5Rw3uBYt9JtZR5quMJcrxlk5OG19g8RAL94b9/G1X6ZW/yHR7+/mrpnvTqBncMVBsFMti/qVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722890; c=relaxed/simple;
	bh=xxdun+jpC6Nu2v4NmzhP63P51sO5rlgib9jNwzCfulY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIbPTaS5eyrbAjazyDjPrkFn4W2pG2KbWouShJ29OzFRHYG9Cj+EvYNkrbFxIt5xGalwsgwbjIzbg/LEm8rvyyTUKtaKuq5IIK8j91AchnFOcbk5PF3eMcdjQgCveZi6XMMelhGbcKohHUDXP7eNcbjgrNdRrmOnxseaT/kWIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space; spf=pass smtp.mailfrom=timmermann.space; dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b=cdNrqHwc; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timmermann.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b="cdNrqHwc"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j2gPK6jV0zKpd6;
	Sun, 11 Oct 2026 14:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
	s=MBO0001; t=1791722885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k/Z2xwl+3btNwSPJmc5tsS1sCA2p1AE9AkNGzp8/kQ=;
	b=cdNrqHwcV9s7r8wl1x9EM6FVNesps5ew3i4HRmYRCfEFaH4MLXf4OOib3pFXVrOpziLzal
	jbv1NmsE/giObucb1t+7xGUgvOuK/Gfa1c2r0UEsR7/eD7KMfUIGKj1g1OIcK4pdniZeGp
	8MXRfbryc8ek4ijOJQKp61fuR7siL5NDVwst4n98PiBUL1klRBLlTrIHCNqhuUFzUmMPg/
	GLmjZisZ7P1sEw15XBOmPvetlOi4sqsGGilVOPcLDUhJup+zst0uk7DKRuPnmJN3VaxnIj
	r7RxeikjY+2ox+9cVRAxd6pHKE8taSFCSsBBFG6d2XckIEeCv4C/t9Smc4rVhw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of foss@timmermann.space designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=foss@timmermann.space
From: Lukas Timmermann <foss@timmermann.space>
Date: Sun, 11 Oct 2026 14:45:01 +0200
Subject: [PATCH 6/7] arm64: dts: exynos: gs101-raven: add S6SY791
 touchscreen
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-lat3st-google-raven-touch-upstream-v1-6-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
To: Lukas Timmermann <foss@timmermann.space>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 4j2gPK6jV0zKpd6

Configure USI11 as SPI controller and add the S6SY791 touchscreen with
its supplies, reset and interrupt lines.

The touch SPI bus can be muxed between the AP and the AOC coprocessor
via TS_SPI_SEL (gpp26-1). Hog it low so the AP owns the bus.

Signed-off-by: Lukas Timmermann <foss@timmermann.space>
---
 arch/arm64/boot/dts/exynos/google/gs101-raven.dts | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-raven.dts b/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
index 7c4273796a22..02b19e39055a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
@@ -47,3 +47,53 @@ &framebuffer0 {
 
 	status = "okay";
 };
+
+&gpp26 {
+	/* TS_SPI_SEL: low = AP owns the touch SPI bus, high = AOC */
+	ts-spi-sel-hog {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "ts-spi-sel";
+	};
+};
+
+&pinctrl_gpio_alive {
+	ts_irq: ts-irq-pins {
+		samsung,pins = "gpa9-0";
+		samsung,pin-function = <GS101_PIN_FUNC_EINT>;
+		samsung,pin-pud = <GS101_PIN_PULL_NONE>;
+		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
+	};
+};
+
+&spi_11 {
+	cs-gpios = <&gpp23 3 GPIO_ACTIVE_LOW>;
+	num-cs = <1>;
+	pinctrl-0 = <&spi11_bus &spi11_cs>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	touchscreen@0 {
+		compatible = "samsung,s6sy791";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		spi-cpol;
+		spi-cpha;
+
+		interrupt-parent = <&gpa9>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&ts_irq>;
+		pinctrl-names = "default";
+
+		reset-gpios = <&gpp26 0 GPIO_ACTIVE_LOW>;
+
+		vdd-supply = <&s2mpg10_ldo25m>;
+		avdd-supply = <&s2mpg10_ldo26m>;
+	};
+};
+
+&usi11 {
+	samsung,mode = <USI_MODE_SPI>;
+	status = "okay";
+};

-- 
2.56.0

