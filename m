Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190102;
	b=I5oAqmSxhuSwp033bE8pwJhTqBbAxt6HVUY38EBl0vjY8OCzqy6JTqkQjLl4F1Vphz02
	 aJ79U5ZpGSKmwaoNWSVfWMuxOvtn5F0z5X32JVTyEyv1vigbrr1l0r53gTkixNSNhBjww
	 7zFY8hAplWYvcy9N+8mZZTUJPCvfAhBINbI1FF6HTmIB9FjLDls8404cNnwk0zb/KVl0/
	 FSaQWkNIpRWxbkiW4/Svxjg8MqtjDo6ziE+JGr11GyEwrflfVxncFzuW5EsnHPLkgWprM
	 0OAKc4SgLlQ/8+ycsyIxUg6yzgV/kFZjGx0HE5GkKdV9WUwfYjS4aCKeK1VLYqyq65A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Woi1KVVkXXGab1Y1GMu8DNbprDgDmJk8VMTl2ZFXeN4=;
	b=lNli3hDP+QHNynEZZU5qzzUaLZmMpgXEWt6DhCOjZ3HUr2YxEZ8PnDvNuS6b6CGBOoiW
	 nBaLs88b1RGaLpvyQb84KbYSfGPcyQSCQ+tT/4fDRmW18rgFFdwhhaT5lpF+jhTxDeGhX
	 9A5rOjgtwdQ7J95/F2SvCy9wibrsBeT/d+Apa1FGupFtmj05EJwEgbd7y72BeyboKJ/V+
	 Wu6KWnc4zPZNrD9aFq9ZVyTIVpu2ZySxkupyOuQfTFBiZE0vTrQvMShAAJBULd6W1SVnz
	 Zv9OrjIF0V0N7z7XVl/L7rw3eAMZ1Ls5PeLfTCWlb5gTYkeR0C9IKwaEnJYFCBcV9ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ou3nVCNG;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3260A5BD4
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF3260A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ou3nVCNG
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso10529595e9.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190100; x=1795794900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Woi1KVVkXXGab1Y1GMu8DNbprDgDmJk8VMTl2ZFXeN4=;
        b=Ou3nVCNGovNAGTLI5Nwsug7qGSZlbrE3hryXPA5GJ7IjDhlmZA49AZ3mAguJfyvnGE
         pjwKv4VoLuClOdAK76Ne2G6bhvUBXCmjbFmcR5AuU2pn6clNQJZOgF3UpbAqTyjUNMlB
         0PMZLtl9PpGLlDm36Maj3BdsWrNtw/LDg02+xMKorgNhrJMZ7p6ul2xFpXHjzf4UaB46
         +SffsUD9OLtVLXzvmDOAzoTjiLmvxKJjJnlCJCOyVEqz4EfRCeaqx6T2mhAz07jkMKTm
         10oD/FKG2vB02TnSqqU6AkMc+pcZt++wgsvV0MARfIAxwAGBKccB7E3tjMgVQFDz/bPt
         F+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190100; x=1795794900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Woi1KVVkXXGab1Y1GMu8DNbprDgDmJk8VMTl2ZFXeN4=;
        b=gwww/myK9ouojZXaRX59Y907NcH6PW6Sm1lDdZ6UbPGO4IB2VWGIF1F2vJaTuc0Okp
         6gCUU+UcACbm69bt3U8fEvpKE+aFsVOSRJKs1VOrtGBKycQJVlWucdvNJYSxnmJNJJOV
         OY9uRb4YV/lgtrv+was0haM5HrDt79eQMUdoPLG1MIwi/v30u/OQPThkvDdUZVGCQZDn
         g1yc+AdkVe12QHj2JGy02oVrTE7BakgK0Q93d4okJo/lQ8z7eTicHufPvcgSZkqPV/cT
         9GATwaZDXU3p7fFlWBGLVqAZb+WLKhRBpiHTVZYo/t9yDsZVOV6PEHZRk4XdqgUjnS7x
         L2ww==
X-Forwarded-Encrypted: i=1; AL+hErGck/tN2s2couPv2xyTr5t1cc6etYm2vlgRVyePUkWZ2UWFs/He+viy5O7mTC+/IZ9/6/MJWNVZRsXA7Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+VpkNLOvpfTxzG4uQQ4iFOWQHmoCtxLuDqd5rIbI9kZ3cUzode
	T0eeRcH0ERx6VvH8orpNaAo5UFJ7OuN4Ve29GVc/+w3Ekut2EOZ+OChc
X-Gm-Gg: AYBFou2C+3oxWXPO7NKOU8/Obcc6vi/BKLE0sNFajqOpJ/y8Z89UOCcEvxJAzIFooGW
	dAAIJ/Qmu+MGwQs+xyt9yOjumzGhp4be2r2c8KPNaoe60vpev4igXKADr2ljNYAahVGNkLVW0go
	3x7TSJIbCc1N8U3trrbxs/EYgbQ0j8nH9uWS7vvxoeu0bD8rEPf1Ao1OGDtsMgeGzOSJaOqMu0o
	lr50uwy93g+DsGSIzZ1xujLm+dnTxvpKL9Hp/2/zVnEtdtwxoh6lT/fh1fO5X5+14Rr2liAPIbo
	sbXCBMBjE/NJElTZVZewS0DnjR/0ICLOFoNzkhF6hcMX1ow9Bj3vNBpLEy6r0C8mrmP4InRXzim
	qJ7EcA+tCsparYlAiqYW4SYXtHzPvkrCLANkOFv4ziMCsAQRK56R/9xn7rZ4PJV4Q5Q+8NBoeQl
	MPdHyLRzk9T31kc38eOv1qIdWYsbVIbMC0t8DOB7Zkjv+Px+4JTaWzN2vQlQVELSd0uwqx4vf7U
	p0ZIApXgSDwQQOz1x7neCygH/GZow0zaRE6DidW+0ZCLhbWEXaQ4NqpW0aFQkgTMlWi3daEVf/t
	gNaoPcIi4vGYvBJwFoesX3cxjbUMpFBsMxxW6ed2dPi3mDgZeib05te8EESirc5220QCot9bf8o
	=
X-Received: by 2002:a05:600c:a085:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb88811c75mr88092485e9.19.1795190100244;
        Fri, 20 Nov 2026 07:55:00 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:54:59 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v5 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902 touchscreen
Date: Fri, 20 Nov 2026 16:54:47 +0100
Message-Id: <20261120155450.7719-9-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
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

Describe the SW42902 touchscreen on GENI I2C13 with its interrupt,
reset, regulator supplies, pinctrl, and native 1080x2460 touch area.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 709cf9674e2d4..6f00495d42467 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -107,6 +107,24 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	reg_ts_vcl: regulator-ts-vcl {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_ts_vcl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pm8150_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_ts_vdd: regulator-ts-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_ts_vdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&pm8150_gpios 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &apps_rsc {
@@ -461,6 +479,28 @@ &gpu_zap_shader {
 	firmware-name = "qcom/sm8250/LG/timelm/a650_zap.mbn";
 };
 
+&i2c13 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	touchscreen@48 {
+		compatible = "lg,sw42902";
+		reg = <0x48>;
+
+		interrupts-extended = <&tlmm 39 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_default>;
+
+		reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+		vcl-supply = <&reg_ts_vcl>;
+		vdd-supply = <&reg_ts_vdd>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2460>;
+	};
+};
+
 &mdss {
 	status = "okay";
 };
@@ -580,6 +620,13 @@ sdc2_card_det_n: sd-card-det-n-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio39";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
 };
 
 &uart12 {
-- 
2.39.5

