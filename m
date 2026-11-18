Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003646;
	b=IBHWnAVUD6OxRvQE4tKxobr13F5+kqGaD2LMx1eKtTDSdGrfIFNvh1Jj15g9TIGD2Eqd
	 RpCIeszhrwHFDybrPG+Jbgve8I3zAmy8wogZxdRhEzIyYFsYa10ootgxoA/cjwx38ibn8
	 v0LKHkHIMSk8SyUaK9Jl4DKFum3zQ4AaGSOJL9PDZrnpkqjLD9+qJniGQ01Sd8D2qUzab
	 1ZqtKYJ2nlspK5STwwJ9nDiQmGgiRL240Uw8zXAc7RpuqvpAx73Adg/8kOqUHDHW6UPPw
	 AGh5UfFxL/z8k6JJhjZc0aOv6TGkTSl2ROmPTXn/Kfbx8+X+Clm5kRwHsv+y2qTbEIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vs9tJb/h6LJRO+aSwhkp7pdT6zxOETm4VTGXKNC7Dbs=;
	b=Lycu418xM7q0Zp2q+rHhGloJdv9P7hiCBv2zXcYOSZycRYqbYDOKJ+ug4Sp6pTutLx+/
	 rU+YwblKfymfVlDPWGRW8xo+JBBrvEw4kvgygGlvGMTqjMtFEEhla0q07I238D+k6Dhlz
	 goyOlijj3QNEhsUQgabGtN1w+hHKUF9YzyghCFUunxDaW526v7wa46IJA+/ywjigiP5PZ
	 eSQD09vdAJIqj5MJy+lOIoHPBRSOQE3YKti3IUruF2QpAcj9VIk/XxlfZ6gS1VimnAsXW
	 KUKDew0o7xTnb/x0oTgER8I1vcruBugXnvY4QeyeZZ4MxYJd3/w5CH7oD+UVOpDue2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fjBWl/Oi";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0A60A5BD0
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEB0A60A5BD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjBWl/Oi
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so9151835e9.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 04:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003644; x=1795608444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vs9tJb/h6LJRO+aSwhkp7pdT6zxOETm4VTGXKNC7Dbs=;
        b=fjBWl/Oi0VKXCaXt0gJoCoC+8oLAfwByWw3J4b/IF0xfbjhWrRnVrP9YO7cQFxn6Zx
         /O9tL82nFc7U70oE0uGKHUk0JZKSwaBoGthVZp2RSXE/iNvC7I+9gZ6mp4Rn6bKtAJ2M
         LEp6AFxdYoxF7BYKrjrYj3pRmjemV+DeeLgAbTFuH/zymhi7LYt3zXc2AhS1ZNuz4kBM
         T8wQhx5EhhECRFJpshxJyI/oLbyGX4CK4kr2hjy9UrUGbjgF1KUTR7faAvbwLMcYdBQC
         I4Qvzoyy/jgnIjrFw9gI36mbD8ooCFPOIKJ+0J2CrCWDUEWXzJpLPe8bQKNu6piLEFF4
         bjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003644; x=1795608444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vs9tJb/h6LJRO+aSwhkp7pdT6zxOETm4VTGXKNC7Dbs=;
        b=CR2t/MUosreYMoCfpTTRbA45PliqW323tikhLKUyvx9LabbM+tIMf4QUlf0ndroKmM
         +AxRX+mVHSSrG00jEGn9BpvDxrJmiA1An7MvFeAFhfpqvBGPxYekDC5ARbulhS2SkTWv
         4hSZns6mg17zs0dQ6vGnXvBiuYF/LhYbeTFDoojEJXvXz7EOqF0mad7wHGKkb9v2uN3/
         nlVOQ+d1mb/IPtQG987BdVfrPSpPeBnFI2Z1PB9N0oAYo06M06OgQXlufJVcBKGuMwzV
         0rWIE4BOheaR+bSjFmhYrSekn+9A9VeOw3DkcAiq5wE+08KPCz0HGJ2H6GTTnwHKY1Tn
         BDpw==
X-Forwarded-Encrypted: i=1; AL+hErECvS0U+t4fdf9rKIfGfC/OlLgRA81brvTPZ1nb0YvlLQ8F+V8hO9a8m2ctM6x3VNgElRmEF9+NjjMUhA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ui6ulNOvQtc0GgHRJFwmlwn3QmcseEsthe1/nmkhzY8PljEmb
	XbqKld4URmIrJzBQIhYqSg/CLPmTH/UxrrN4xefH09AyJhWlNZlzNFPG
X-Gm-Gg: AYBFou2DY6ObKjlYWB0igqcPH/8YT73lTYRiEZi/OvseC5Qb2aYSaquiqPbKY64NhX4
	yk7OD+G54G47ySFUukoXYUQxRfBSzvigCEcI5NBROS1nWIW3xFxbt3lsTLb54i8sMH2oG6Wur3B
	bAlvPtu2kPQRH9esUpFslUwYgroxXM6bKTTQ+X3nErd+lAqk8WXt6oJORyNIlMqvqASpgZsROus
	eXu/c4TLyWGodJnu4polGcikJfqKlSQLXGW/VQSn+NAGpecqdA/H7xUVMgpPQe06IGgJ+lAcqSJ
	gFpUK1lbSgir0Yz3Vr2roBlZciaxAu4JXMuMVJqG4Jp+8KujV5r2brJpbbUe6+UfxAZx8k39bMO
	iJyc3jPWgoOW34lJww6tDpZzDYcsn/bw+0d/C/Jr0dEDjF4AJDpdtxCjClD7hKtBqEzZRV5AfQA
	RVoOCsxEJt2kJmWvFMwSoLrrGsr8/IfN7uo1ESCarnMuwjRFh/CYQFBfpBE1HDc0LWLA2fDd1Qt
	3WP6MpMCx6noZY0opewyZqqX5p9wJk8u7OyubRFO3LZDVWYZnyezFSVx1iL/28oN8U8xfegd+t+
	udVftktmSerhWJqhzSVRzhYxkf4Ggokv8xTdFA5Iw3KeChoNFfYarZzx9WBNLQVS1WL2BqszngM
	=
X-Received: by 2002:a05:600c:1911:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4bb7d57bc33mr43616545e9.0.1795003644117;
        Wed, 18 Nov 2026 04:07:24 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:07:23 -0800 (PST)
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
Subject: [PATCH v2 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable SW43103 panel
Date: Wed, 18 Nov 2026 13:07:11 +0100
Message-Id: <20261118120714.31505-8-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
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

Enable MDSS, DSI0, and its PHY. Attach the SW43103 panel with its power
rails, enable and reset GPIOs, and four-lane DSI link.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 1b2b67486fee7..d307a52cd0e62 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
@@ -460,6 +461,42 @@ zap-shader {
 	};
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l9a_1p2>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "lg,sw43103";
+		reg = <0>;
+
+		vddi-supply = <&vreg_l14a_1p8>;
+		vpnl-supply = <&vreg_l11c_3p0>;
+
+		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&pm8150l_gpios 4 GPIO_ACTIVE_HIGH>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	status = "okay";
+};
+
 &pm8150_gpios {
 	google_assist_state: google-assist-state {
 		pins = "gpio1";
-- 
2.39.5

