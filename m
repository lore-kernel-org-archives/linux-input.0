Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919200;
	b=ZqC5tOWTY3Az97vBtu3LvinSKDk7YAt3sJI5gfj4kUArdmlydOMVtPWa9YBZ3LKiqXaO
	 9dvBduMH9VlgHjTsLx3jcB8hXTKNTsGAArQxl69YUZqi0vXOIqEQcsQEe/tbxZ8188lYY
	 5Efa2+evUwompHQ01uGKalVJWckhab/bA9x19puJEkY05msIFyfvOcRByGhUQ0850Sl36
	 7Eq1YQH264Y2cQEhnBzYro352hXT1i9NLTly5BATqOGEW1xJI8JVkrWtN88WB3AgscMkC
	 HHsyneehDECVX3OdKyNxDT8nPI+cbc079vtflsrHTqVtX0N2d7udRMKICGMeCm3noUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qFNx2PFwju3GpZX8sb85V+O1VlouegAUrn4ULDGVae0=;
	b=V3WtTpHFHbXQyKWFLC2Ip4x/AmM7ENQq9DcqO1ZZRUGQLzeFmpBsGgSZLJlFoeljcD6c
	 F2P7D9vaE6v+JqZTGepYd50xEIsDjjfvaPP8E+9pN4hbq5k7tCdCVVuA5e+cEd3iNSN11
	 RQwQOw0d3IIGHcg6UEaQw1u2/Buax4jgCVLf9EGJKczTBbB0+ynD7tRHzOORr+W9pj4iK
	 C/h+xuro2Wb/PC5fhcHYe5C+4FTFU8SWm+pzhUQLdFgWa6skZvIcjbcuF+0423iytBwFz
	 5KubGnLAy1TOMEu9xz47R/qIkHQZ5hHOSXmCE8Va1O4GoL1d488PxcrRkqBdMC0+6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="V/lyBsh6";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4960A5BFE
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D4960A5BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V/lyBsh6
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so19247375e9.3
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919198; x=1795523998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qFNx2PFwju3GpZX8sb85V+O1VlouegAUrn4ULDGVae0=;
        b=V/lyBsh6gxkoHD6nVXKA0TPVLKWRTocRRXjqbnr2UjPo3cTBWHTO1g+x2t0GJeWYtf
         OU6mnapdKuQQkEYZXdAa480Ab04nrv2nsuotmGGR/B8AaB1BF3P0Tvuwvf1I/bmAkAQ5
         knX0u9WEflKM814SXPtCWZ2DIYNtcp696loqmMdM4PwxMnhhneNpIFF/1ZO24hEtBmWh
         BxQ5oBDjpZihX2IPVo/C+sdINcMhL8oFFagr9WxGoMB2Pzlz0En+6QEp/TGmpR7Tu35n
         JwAzYpk0Au5oKmDb607M7ruAzarlKLI0jrfnU4ljGPXNcGpB3phlNdF9y/OkaGEEGfw2
         eP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919198; x=1795523998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFNx2PFwju3GpZX8sb85V+O1VlouegAUrn4ULDGVae0=;
        b=yrNG1YciO7DZND9l6DxbtOoreco2RF8pRLhOAOVjjf0zs+sxlKlq4Uh1VNby8gFNVc
         9MwEchQQSiv8zT4XwfzFKQAdrurcg3AMqdgip1xKsNehNfG7W2tvsTXsdVVy80fkjvqh
         XeBGOh94z/pZi3cke5GIEdeEa7OmrJMUvyapuhLzFQRB8Xx2TISbAZfnkk4RkW7j2+Sn
         JvtRteNz8A2mhtcrphzvFtO7lUuZr8q/M2wIoQgCTXxtijvb3CQPPcGapwPq1b+89MbJ
         LXH4QUWvucsjPXjJKEwYCVWWsdYL7rc8d31K3dNn+YyF/tNRZcaQew622kt1UqfFlCAa
         nZUA==
X-Forwarded-Encrypted: i=1; AL+hErEI8TbLI0dllyjUrhdtSNFowmAlHKG7OK/9/ebnEGl0U1rZS1bBPi0M6bbbBnil73EioNxp2pOx0rYy5w==@vger.kernel.org
X-Gm-Message-State: APuU4Z81xY7OyZUmo53WfljlO9020aWQMn5UnFMzAL+VmSCFYCP9R86h
	j1Ga+qP4vWZWBm5PB8GEtNGqvGQfBICKh7peDD3UBT5eTeMdCu0RDQ3S
X-Gm-Gg: AYBFou06c7mN/1ZllY+qT5jxITzcLfoHQ+RsxcbqSocrfLHbXxI4uji7+L9SZt4EOOa
	b/46M7Z8FoMYQX1b0CuhrxvM3EMXYtEmxsAxQvnmHmxXjAdYZ2jvNMFcTQl0v+XMq/PitsvBLWb
	p7G3WIz2pZ/9vZtTZExi2hay1cqiDGqS7775CxaBNbHGZl2PhBLGD3gflm7wkZeysj5AzO7vc4b
	NRutrN62nmSnDiDxqNPi1tqnaCA+vVuybHkNDDQdUqQVTTwFf2p7TWUHLc4Ho1O0OnjgBqn8bq5
	nSF/8WAwweAm5OZWjRHVLYtU3t7bWJvmbPkhPWVBRh2DCdcPkCjxvUjqxw/dvCIyIjN3aLjlced
	oFVjcwdesoQbAj7CHdaxRf43VpYYvOiNSO5G2840d8S1YiokfkLpMgz/lpo8yKJ0Qlz31+uK6MI
	Y2fPj+qCJjYugrn4KqDQ8cXOqmFtjrSiwzuT4+CMCz6iI/835ExNwkbxtDTAoAhWroHI55BpuwL
	7rp+Jmwh0RXjzM6aHipbaefvEHS3dbmMh/x/ClLJgITkSDJFnOVnLmAOAflZLBqiJq+ZlpgCY15
	u2bWoib8eQkwc6t76Rf+WIw9uUDYsiZP8HnwrpaKSzxDMd8gcNMOtmUdIKzWpeNoyRvbtg==
X-Received: by 2002:a05:600c:354a:b0:4a2:18d4:f9e0 with SMTP id 5b1f17b1804b1-4bb55abaedcmr286510265e9.25.1794919198290;
        Tue, 17 Nov 2026 04:39:58 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:57 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
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
	rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 09/11] arm64: dts: qcom: sm8250-lge-timelm: add SW42902 touchscreen
Date: Tue, 17 Nov 2026 13:39:44 +0100
Message-Id: <20261117123946.668557-10-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
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

Describe the SW42902 on GENI I2C13 with its interrupt, reset,
power-enable GPIOs, pinctrl, and native 1080x2460 touch area.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index fca48472f5dfe..a094aa81ad225 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -596,3 +596,39 @@ &mdss_dsi0_phy {
 	phy-type = <PHY_TYPE_DPHY>;
 	status = "okay";
 };
+
+&i2c13 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@28 {
+		compatible = "lg,sw42902";
+		reg = <0x28>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_reset_default &touch_irq_default>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+		vcl-gpios = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+		vdd-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2460>;
+	};
+};
+
+&tlmm {
+	touch_reset_default: touch-reset-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	touch_irq_default: touch-irq-default-state {
+		pins = "gpio39";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
-- 
2.39.5

