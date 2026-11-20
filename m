Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190101;
	b=mPO06n8c4Wezthd7gQ1d7fkB5a2xcI+JHqpREq+VupoumMGKNgB7VBJTHNI/M4zL+gi1
	 dE3kVmA7o/l7glU14i9vlb9aaDqyT5ej0uzFaWiIwBZP6GnH3x7IdM4lYahUvSBnTgAY+
	 khsp7jKoiGGz8s9QOXdqdTsWQQyD8aBOxZ1QH9Fte1AzHcEq43QgRmygq6p0FOeC/D6Fn
	 ukpsQZdXPoh3nY9LqJu1ThGBBE9bZcMwyRrcWdTM5AQrnlofAZPXO1H75/8vczKpv02G7
	 xbrKZ4g0YXRCEsTtaTIA4Wpl/xT9Zvm1w9Wyk+Xp0ISuQffG4LkYw9E2zfGk2XNo0hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
	b=H3COVy3lFbIWg1gqk+cNlcXj/us0ykL0jFn6up8ohKJIwDPWx4Fzja7CfGEknmf0qXTL
	 /bBnWIrlcQT/IDKNZA0lVbW1mtUmgupOAqdmgDwWUsuNtZjt8XFKtKFmGfUhMCxNcp6tU
	 0uRpG+6pTxsJ0yub3MPVSHEfbsWSyLnuGuZ6CWIT2zhSVQmH302XWNYhG3aQOt8e5nPv+
	 LJ00hCUL+3FpY/g/hw8JMQWj9VBmBogys/f1EAxbUMLMOL+0csUmXM0lv9y4MxGqoYNCD
	 3CEwnTkVHCjIabc8K0eqfdUvt0hdtVeYbsc8iCtQUsLMhrnhDlqVS1X2TKl6/JL1mpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LAyWppn+;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414060A3837
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F414060A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LAyWppn+
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so10769085e9.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190099; x=1795794899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
        b=LAyWppn+jN42g5ue/7dWHD/Z8Rwq1gOzYhPpyTTLG+WF02MlqFwSGIxO0B+wQgN5ld
         hIz6rg73oHcqjK7Vag/IpGzqWwwnzY/a/cCaADa5Z0V90oK6ejnhzwJEENTZciKdwXoP
         Gt0WphRiPIhG+iIlFesuiTZ7Yc/Qzbu7EKR0vX3yAE4INm9y5QN1WgMyh2PsHUZaE/xU
         e9OHMF9JkVbKGROqvTn5JYcKeLjhqOTFPEgmKnN1uzVYgJTol12wujkvy1XkgiaY6LYS
         Uu+rFittCfRVMAEKrwKhOvXb3AKOuXRR72c+on0w2EsBbPbTHL4/WTrKT+K+ZJKGswEL
         Osng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190099; x=1795794899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
        b=sWwhKhHj+0uY4J8f2JGUU3SvadXVOMsxn9VuM4q3zVhD0rVK7qhNZC+6+gV7RwvKvd
         QYo+SXku3LQ3R7eqRH1xYk4HltaMjqeT83kJq9aiwILC7yQ/yXGa52aXFiGm+zv+H9BN
         N7qBs0vLWzEOG8iaY6LYYZYj9JiyargiB9UQb+9x+ls6MAxnqJOs+0yYLT/H84wx78TT
         NCryFVLiDoTa98fTXnzH3J6+JQB9nSwhBNsCI/2aJ88u0q7M/8tMWlmuCFeXlODbJc4g
         WbUO2aB2xlcDF4fp4URE0S2MEqusaDmzE8gGi7jIj3w7H+rc7/lYyep7oE0/8aNg+/R2
         Rb+Q==
X-Forwarded-Encrypted: i=1; AL+hErGbH7ANq5QMNFfGUTFQZVVI6yfhkUZLNyGFA9N5XJ5+yrvXf/7LVsDNLStdQ2ag5zRaQtAJXXnmgjTRQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2mvxhwOTm0Tn7lc49D2BhwiRxsVg3vnLFDYc0FvSfX6Q+E2dY
	o6htCY75W21js4xble6OnAjhSv4zKFxzEh37n5dJAWMkl3VXc/L9fBVg
X-Gm-Gg: AYBFou1Be6zywKJAPq70LPYo7pn85j8jlNWZ5oCPfdwliVXlGgYfwFqzUJ+IwrOhSqs
	bm8dVTisdibQeiCN7kbXPNAdPVnHXV5arm7GGNtA21DyfEDncp4zbctnuiyPoLYtPPe/33W9Uon
	qvTXb+KoUY9cY/m9VV6dLL9pIPzFSVLek2PUiOc/h03pz8Cue8K2+7G353BhWj03wVS2jQvyCj2
	omFQv5hPhWs1xAsr4loLAaeEwsQwv1prYA+jxYJTPxXr58c9ftIWBci/S8NzzLuRP1Nw6XHxSA1
	esK8skZmGmX2BcJVdC6kK336wn3D3mzHpHjOrZXZWZMiXjd/DGDEjjO+/4XMc8K5dbDdjmez50j
	AA5Tcz+lLhNgNkKuLB7z9EGQduWazga9Aoe/FfNQvtNBBhpNi3/bp2MeDJL2UORCqnpgr7CzIS/
	bvi+H/YXmsTWi8pLBc1UO2lgwXPExiJet7L/B8FGBuOHRNocbFZXHMNj3Ip0UuxED0T68NsPNbg
	EiIBdnugjaX6u2l97xmiRXeHCAZswvqYXshxh8sHvzErpbJFQSplfQ8PVHeAYUPczaX4mH0hvsM
	Acy4xmnfLPMyHvrK8gdl/5o27ipHJp1GIlq3wAWc9yTMORefmyh/Lwr5JopNt6X4RGLFEGq9Qw4
	=
X-Received: by 2002:a05:600c:638f:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb8881a2bbmr71997325e9.17.1795190099296;
        Fri, 20 Nov 2026 07:54:59 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.58
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
Subject: [PATCH v5 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable SW43103 panel
Date: Fri, 20 Nov 2026 16:54:46 +0100
Message-Id: <20261120155450.7719-8-rofikcoga@gmail.com>
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

Enable MDSS, DSI0, and its PHY. Attach the SW43103 panel with its power
rails, enable and reset GPIOs, and four-lane DSI link.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 20aaf70355158..709cf9674e2d4 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -461,6 +461,42 @@ &gpu_zap_shader {
 	firmware-name = "qcom/sm8250/LG/timelm/a650_zap.mbn";
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
 	assist_state: assist-state {
 		pins = "gpio1";
-- 
2.39.5

