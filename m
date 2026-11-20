Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160051;
	b=K+smbVyP/aE8AIC+bK5KHtx+daICGZRniiC9zRHp9reNV2L1mzkMIbIgqyDul7WZevs3
	 FH95LlbZpW9zH1EdUhzyeAsSDO9FE+QFIxdwvx5hSNVgP8KrSyeEZXoXmwJMkZvmKLMfl
	 GcxUoMzbHjpa5ftNhaK1EhyQN8h+u0S/8VatQ1GLOb7OEIqI3CRHei6qb+9Gi68vGOwpc
	 pyeuLlCWNUzQcsoqcOvzAa6JWtuHYUcdKLfhyR2RS5lOm6SX+6NVRenvg9+anpi80zpDe
	 JW2cPnOUXCJdPMemTRtsIdmwYjUdCiqytBew3voereQXky8n6XYN8iubCNgeuPZxqiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zaM+gH/dN44KPfMZjWOtQikePy6isicudqZk6D3g/BU=;
	b=iJelAoKWhKFuRNMdFssHgwttM9dpzgtGa9pLu/Ih9D71yLzJWitdiHKZj2uhblY9o8dP
	 xSGiuOvFHAs2t3WxH11hY9LMTDwCO4XTeRE34vQbeyBiIWNmxwY7TuWJJgA434KYXjIb7
	 cn4OZRuM1WIynwBF2mm/IvFeI4AJBp2cTr5qLA4ko7c+TX2N5yrArdEc/PmKCwP+s9iQx
	 fITtDv9IEQt95+VuD4W7B5doJ4gB0Zrz3Idz3X5ABYQ4hWBybO6VIMngq+R9wZdKgYn5d
	 j4tZdRaIfbd96rawv4O9iEtNPvp0UKuIvU14WP+OZN5AKluv5A153DFAt0HuL2bZgEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uM4EwaUG;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770F60A381D
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C770F60A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uM4EwaUG
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb606491faso2555115e9.3
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 23:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160049; x=1795764849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zaM+gH/dN44KPfMZjWOtQikePy6isicudqZk6D3g/BU=;
        b=uM4EwaUGJ3db/pFbwtIa1AwHXGzh7FRaXsI3Exn9B+X7Y+75sVIT5aImQsYlqQAktP
         DgaBTApC542QL9npLpxxeTVf74R7zjkF0/m3xwM7xwescjyqHBWPycRakWxowLsZb6pX
         cGrY63UXSZ2H2NfsxAY4yq/X+S/iYRF3tiEce/necRond/IuTh8tOFzJDbtLj6fzPK1U
         MAKzBfqdFT2WqL8jMV4JsznILSHyDzkawPS8nssGskfTjuT9GGB1tNE4y1fIaSqBcyk9
         SX9S2XOPB7yHp8jDZF2G4cOaKS8o12dwoejRkN2VyyrPktVoqeYV8KlFIkSASm0WmVT6
         aKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160049; x=1795764849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zaM+gH/dN44KPfMZjWOtQikePy6isicudqZk6D3g/BU=;
        b=q6n2MVDqbHAPspuRlEI+E+miCi0k2KVSUix1v5knys8dTdtvqHDb68KpH4lrulOWvN
         +b/sCX6zv6Nmobfla6+5BOjT5PTEiUiC+qRY9k12OKVv1BYud5XwFVErq8m6PnN2yvHX
         JotkGQUpf+14J2jvtYtvg+xqewYQGf817Ci4Jqq8AWLJZqo3hYgvq3ScKRhih6B8xzn7
         viIs8b5GdcKOhuZgs05J/UBELGHwfTR+OViYxX50fdRopOFjnr2+RjQTX9aLche03bhq
         njRA0lanMWZ7CN2gMkwG70lMFbamQbunOiWAUzCuVaJXjk6cJAigRrHdHcTc8ueF66VG
         WZ4A==
X-Forwarded-Encrypted: i=1; AL+hErE2ItuvffefNFVf2K7NfoDAwKz3o7O1d1A1BnJnbfcZof+00rUf0rMHvhdHNZPWFqiYEueRd8OjnMip/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8hhKTKR0nZRzE5IHgYwRY0Eo+nZLx36ANtkJlswzrefXOMr35s
	N+orLyJLlNc3pt/KZc4gGerndEeoAG9rZXiLAF069u5sHo6SYToVqx+N
X-Gm-Gg: AYBFou02kYlJPJ0Dc4KFlREu+k9KTbK/vIfRPdZ4h3GDaX0xFI4d3OAV/bDaBwbyBsC
	yh/dHauwp/XqAqx8WxvuWA8pYdTPJaHWIxysy2kL9UqKk74W2oQY3p+oZ0grHfZflpiMedDNVSW
	nwwsPleUyPw0Be/4hjbW64OJmyNFxRkbaseXA/ctlGqQquTgiq6R4EpVrYgDQ5vFfJY7+fMhuUG
	zY+9MjJDFknLjK6ptZ6G4zIgLg7G9o7qZKMDq4tWeRoAB11pY+DhFOYO44iJ50VckxjkMP0AdDr
	g3Y7zpBsB2aRrI5fq880MDxeLDd5rfr25H+/PewoBgCjHQubC9hiRJSffmyKlZyDbYZrXKsVfNX
	UmErZ7Og761mIv6LFaD/RhGwAbAVGk8cqyfkASZxO1+J2XAEQU78ZuplwE+Ro1o+nwsJco3HZvg
	EhX3SzZzr3R5pvFlghFSKvzQtPIBbhbNVSTtFkHXKifytYDXYFTNh+0+DRGSviVTsNFKur3ztWI
	dNnKhjEw1EuLzYW5j9nmJPyR3j0xlw3PQ5HpgblbcAKGNEmQYyghQX2gjgudJ1gTBmtYuUmzb2S
	88meWmzC2j7Bfmig7GCjeFnztBe0io72OKSJdl8Yttzej7WLYwdtMLt4XqApGFQHzVjOFqLcSS4
	=
X-Received: by 2002:a05:600c:4515:b0:4bb:659c:b8db with SMTP id 5b1f17b1804b1-4bb88813b27mr44615435e9.12.1795160049029;
        Thu, 19 Nov 2026 23:34:09 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:34:08 -0800 (PST)
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
Subject: [PATCH v4 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902 touchscreen
Date: Fri, 20 Nov 2026 08:33:56 +0100
Message-Id: <20261120073358.10267-9-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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
index 709cf9674e2d4..16014df9c087a 100644
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

