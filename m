Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9133E0C68
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244812; cv=none; b=l/JJLJlZq9NjH3JuVTM4DHMOA0HlUzpByaBv/+ZwSYBl2Cg1iMf5E+hcjeZh+CDuhwG2clMGxMqCNV8egU8bnX2UoRda9B0yDUpjJqDzQ0GTFzo/rFQO3Z18Wt6fWibWPRLbXBzNx08AfG0qJhLevr4R/wdCY8EkvYsLeHKVPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244812; c=relaxed/simple;
	bh=tIDX7JUVBtImT75drxZOT43afatjq2eglYC9uyAHIeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pyus8CXRkJdhnNoWgYJn9A5CW7xv/XEk/59m6H0FDQdj7kqDwSgoSvhLG8AtlZU39FU4K5649zND4Z9v8yGNT9H9mK9xYRmuXFfblB+QxUQc7V4KNJVV6YOu01DRoEzDKl9bFp8pMYq+SzHea5KNchuPT45hXAyP9VMLhmLfcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=cEcX/+L+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="cEcX/+L+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bc2a455fd55so282164866b.2
        for <linux-input@vger.kernel.org>; Fri, 08 May 2026 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1778244810; x=1778849610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iH/xL0hFptFpdB14N/xJEwQzcQQr4/b2TTbHc4T4Jhk=;
        b=cEcX/+L+g5ORSMeyQLW6lp1Ef/OqGNZsYt0zrqfPkq5DXVDyRlKfHLii4fwVuawRtv
         NxLwffnwWNa5OssvUelV6bhOnVj0DLL+N7hLWvVz5/8RKLv2ZyByO82NvUYVnYrWlcx2
         Pl18QswAYqEME8d4zn5FaFdYL5BiqhC+oJ08Pmawl35ma9+nx2hYRAg2i+3574B8zXt4
         hdLKCgfwzlT1scygv5/gFVqobxxPo8c5jHBhqkUV8CU0ILfQiH487w88/d59VhnSkvIu
         eOz3cVwtupsqIAgf0QKD/ucDUnbWo7gcBMt87Gx5bCtrTG5UvqK5YUi8HIYUibu5uk29
         hkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244810; x=1778849610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iH/xL0hFptFpdB14N/xJEwQzcQQr4/b2TTbHc4T4Jhk=;
        b=j3N6IRZQyRvRB3+hkgGNXh2yugXOqHUCEYyzqF1RcEA9EO60yQLt76RngQy/95U83L
         7q6wApsRK/nDFWvmCy3tHmb2G5m/QqAeNu3C3wvmzN0+dsHWSJR14SEOsUurxDB6Xk2Z
         lC54QEjt/Q2YccgrkXYupMkgDAfXYwS6qUn8SXANAcuwaKcQ7/X8SKtjk04ONOMyUFHl
         yn8OfKLd1sO/PL4zA2++I8YCRHkMG+mnfoWp1UCvaPG0HrFRYhsXhLqUrBgwOOvlF9vF
         k5n/QGYg2XUxZhcXQwDmH1ehmY32PTL1IGHb0Dt4RvXEekOlhCF1sc84V8vxFtt9qQYG
         znhg==
X-Gm-Message-State: AOJu0YzPZTQuzraecV4xwX7FcBvy2jetOjJtp3w3u6uG2zDqMTUOuc49
	3K59GF+snuHPkI06dtYoLcXk2pgOpj3eVhNxFH155j1q7b1vpOuMcOJvR972kVgw6TE=
X-Gm-Gg: AeBDievjEfcpUUFbOnuDMKDUcvpH1zt7FrqAmGB3g6ZTD6iOmd/XzjTkQI2TRWpNToh
	D6f7Jlt7kaNId18zfg5PcgWWM6lgWWOV/wMB6cOCGG2spLGaNGs4o3BsOWVDuuzC2i3iZWpMGjo
	HD49X/mZNyci7O92obYt9FfmuByYLtMXJPJhGZIXys4omz1wTVZJzelwmI+D5KT+O6m2dE6qpXw
	r7ity/8jkFM3sV8mSTOHRRts/rcrrH0dO/eRfftMIg6wf07fgcLcNh/ryK5pzG5RNxRof/vtI9M
	HX2ZpksNID5GyrfWtpic8TGruYohS1uwyR64Q4xj4gAEbp/vfOlKBEVu0hXPNxeUTqfaou3yOBk
	bxd2Q965cITB5ubt2y+/wJl1hT3doSMDQKDWin6txfh/lnwLv5iDvUSeFhVn22AHMHT94vybFdk
	mPNBZ9cUzv0A/gYMULsejVOczlP/h6hPLrvWNlb4fIv0Sz1bQqzMoN7rMQdRxIzRFfZ0VT38C/d
	FL+5/RqKw==
X-Received: by 2002:a17:907:fd8a:b0:bba:3bd7:17c7 with SMTP id a640c23a62f3a-bc56ac3654amr669181666b.7.1778244809659;
        Fri, 08 May 2026 05:53:29 -0700 (PDT)
Received: from [172.16.220.224] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcb94415c94sm800266b.53.2026.05.08.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:53:29 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Fri, 08 May 2026 14:53:16 +0200
Subject: [PATCH RFC 4/4] arm64: dts: qcom: milos-fairphone-fp6: add supply
 for Hall Effect sensor
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-gpiokeys-vdd-supply-v1-4-0bb32e8e6428@fairphone.com>
References: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
In-Reply-To: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778244804; l=1397;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=tIDX7JUVBtImT75drxZOT43afatjq2eglYC9uyAHIeQ=;
 b=KT7bF/QDdLpdfF7n1XKRTlGsLTboMP/ClM4Ln/rj5O8mk+AT0De3KpscYOUGknrVFyaVp40Vd
 MR0dqPY85ufC++wlLpRWg937MPDzmsW/GsazLjn2qSNoZCrgHWb1vNG
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add vdd-supply for the Hall Effect sensor in gpio-keys so that power for
the sensor will be enabled when it's in use.

With this, we can drop the regulator-always-on for vreg_l10b.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index c1899db46e714137d7849b3b043062fe8b05cc42..ae6900c3f75c64ea5b4feadf38df101abb43c1ea 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -32,13 +32,13 @@ gpio-keys {
 		pinctrl-0 = <&volume_up_default>, <&hall_sensor_default>;
 		pinctrl-names = "default";
 
-		/* Powered by the always-on vreg_l10b */
 		event-hall-sensor {
 			label = "Hall Effect Sensor";
 			gpios = <&tlmm 70 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			linux,can-disable;
+			vdd-supply = <&vreg_l10b>;
 			wakeup-source;
 		};
 
@@ -326,8 +326,6 @@ vreg_l10b: ldo10 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			/* Hall sensor VDD */
-			regulator-always-on;
 		};
 
 		vreg_l11b: ldo11 {

-- 
2.43.0

