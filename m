Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107274;
	b=CSg5LFSYYqIbidsQGh6mFSM3FgDRdMTHHOySSq2lR7QWWIEAn8s+b7JE2y+NlRNAWUEX
	 EA74+N5nsL4X93D3r+41Sd+8vMzdbmwvDnMk5sDhuyv5G0cMZiIs4AEi3vMvrwTVEfKKy
	 5jK4u5XjQao1javLq/Z4KrGtoZOrT3vggSH2gtOR6Z1+ikMs6Arz02BPbCHPvND88ymnc
	 Djg8atr6wk0mKf4J0rAj799WioGN3LEJIcLqujCGzYU6hxK9t0wjboQnxA7TpKNEjrTnw
	 sJuQ69RJCbcR7dGA1Tf8XEdyvo433jcyVtB7D5dk4EpQiQRezdQfoZUx+FGAeRvatpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F0J2OIIkJQaAc8JC0X1XpyF+PM+4498+YyFt2tkAI9I=;
	b=OJ62XLs6zRSP9wppdjwF3go5JpEZArIM37bLIQQeijmvFsCOf+UGb7VBo+FNnUxSIQ9W
	 +CiyUBkp7t7bsyfrGcpfdprRpK7z8gdT7C9yzAHuHL4gWC4NvqAe1E/Piv/QBdommyRPi
	 XzwYYPRGd5uTXe0YAtj0SKgjF5JpsHjQynnauEvh1owv7noiiassXfqQX4/CwUcjZ+224
	 8vQUwjZCFRFdA0C/bg3W6kkxykE5RXs0rNGQA0blt69bX3tE/ON1Zjm3XIu/Gl8vwt/SF
	 yWZhdBPwm/3zsVFPV/229XoZ/TF2gmW4VFWLhz5ejUOGrqWAFJOCHFo3O3UC4a3Ly5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=juhEOwGF;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DA60A5BFE
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A17DA60A5BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=juhEOwGF
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so20325445e9.2
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107272; x=1795712072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0J2OIIkJQaAc8JC0X1XpyF+PM+4498+YyFt2tkAI9I=;
        b=juhEOwGF2GOjxoXtmjs2wXb9+vc1RddKdvLf/LxnA0U+tZF2dd0cGF0s07L5ffEOWJ
         h4LKn62uiKSoqVEeqMnvaD+aMjk40J3zn0ctuFQISREnxJV0NphasYOXXvBl35yMvtey
         mwHSYKhcUkiHIIGinJfvjQuMHKufDYa8tpA/QGGslQhw/IaeX+ZzQUTPn9ICizxOENbf
         oPA8kDxf0gZqOt0n18v8pvMKVxK7TpJKlFNPOYjOfxWlrp0ngsZCoYs/cdgXK7uKEklF
         WiflhUjEAc83kAny5N5Y9O5ZfB1i5Z9B1GgXYh5RP0Ho9VQpIi7+POg/jvs3ZMpdWNfI
         49Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107272; x=1795712072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0J2OIIkJQaAc8JC0X1XpyF+PM+4498+YyFt2tkAI9I=;
        b=0uSzB8qCNrYv433Is+1FzcRAMc7IU8D/ZRjYPdlPzj69B+bS8FBrZtLXNzRHA/rBCk
         W9C+A16ScfsG1pjaW/1qv8kLTL0rBdsSpOublVsQPf+B5disLdCbe3cKRsU8sor4mqzP
         gbGLz7io/EbMLPOZUIWNXwnl8c0JfVsolQ7uaYxyiqg7vek+1bTwWNFZZXqd12UaE/p+
         Lc4PddRq9HqizJsvVN91aQLguegbTJxOSawqnoo8+mndhR1Rl3snpkouNMI6Tvl7zZjF
         lFNQ8IyeHahD0wIszUSyAyZlsdZux+qn1cmjcYRKhR5ZpAgQEveNq8pO3W438R5taOsb
         O4Vw==
X-Forwarded-Encrypted: i=1; AL+hErF48erfJMHN66XVFRj+B7sxJUj5bPgpecTZ0eT5lc+CAch5wdOTqabmb6IUF6r9zxtuZ9v1bM4hk2QGYg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9q1m6MwGbnz/v2Lz7gOWqbFtgJagqGNXbeG9HxDnZuhn5l0v2v
	CJdcqiVXPEUFIbQyu4tGLmGk8Y5jQBOUP+eAVEOOiAMt3nL/bBIP8GZcpBAs4kNjGIs=
X-Gm-Gg: AYBFou1BZjaB8ZtZiC1QN+0fgPHWCbYPxQOMy/+O5bN+CiygYmyYV92nL1muSpWVPOK
	pCJNqiKcY7b/gALzR8aKR/QXQvaHHa17FVgEwrGY55NANrL6Q442agHMHY8jnAbUlKtmc/Ss1pL
	VN7DSSNgwrMYViA+ReDZ3cAFrczlWf6MIovFSf2t1VgaWofzHN+iKRUlxQbWVcAzQB9lZ2rvog/
	vsHlOZUf/AwVOyqAuC5YT87dpiNGvN0PlnHghVOuWT9mtyzzggSeaZ904NX8E2v4x9ezz99430d
	HNzWu6h1tMVXpUvr+uw0lr6NBvzv/klI2ycfqV11Pzzb8VdG0v8nJKNufw/SzoaYxeSKuQxn0x7
	BGy9moGu5KSOGUbWuo4+yOMwGdiu1ppYUoeQ0NIlZP6wdskJDxlatyji/AF9D+KbNGnGfr0UVtQ
	YjOJmP5kJL/cofvBkTrEBaBlNYv4IdFJF/5pgGhSd/aKzQWnexNgcc3dvqbO4BYznV9ztnfuqQD
	wZrQB5cZjoJwNoGOytkfV4KIwegBtGd3dJwsPtLi1435aQao6Z4hATq51DDFQy01ncG+IL97Sd7
	AC9evbVnjqD5bdstogsGwIrseTrR3U+nTaBtxCRX1E008NSswWxk9WhyJZW2aI+vC/BnR2WBiTo
	=
X-Received: by 2002:a05:600c:5303:b0:4ba:495c:2f5d with SMTP id 5b1f17b1804b1-4bb8880767amr1755525e9.9.1795107271789;
        Thu, 19 Nov 2026 08:54:31 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:31 -0800 (PST)
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
	Ivon Argel <ivonargel13@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v3 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902 touchscreen
Date: Thu, 19 Nov 2026 17:54:18 +0100
Message-Id: <20261119165420.24466-9-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
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
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 59d6c1518a469..160b6f4c98b17 100644
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
@@ -461,6 +479,29 @@ &gpu_zap_shader {
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
+		interrupt-parent = <&tlmm>;
+		interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
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
@@ -580,6 +621,13 @@ sdc2_card_det_n: sd-card-det-n-state {
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

