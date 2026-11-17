Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919201;
	b=ST8gCxoIG314I5nHNafyHELZWO0MdqzxEutbKIlyNdMjHQdmPE8gko71IQvAI1UbBZH/
	 AXJiu/f7DLaII27XweAs7bqBSZ/5iXrlouCl+IraE4rZ0Lwn/XE63EZgzB/jibLeIWFgo
	 Gm2z3DfkZiYehv3P+83LhP1xGNvNtl8i4deEaMWDdhndKJ4ja7VEZOkswnolMeA45P/ZR
	 CF6eROO/Bu46SDG/I8ft1lufN2o/8WV2advwKBHa42kndCKRF2VqbI3Yt2ZOjQaYWNaK3
	 NYXROKjNL+DIoSxpFQS7PQhg9iAGnsjbT4g1kRS50VgV7+CTGkOZJbLxdzeRc2Ems+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vjrAJfQ30bNb0haiNW552/JsaDvfxHWTHWoJPW/T5QY=;
	b=D4Wr3si3SxBmAJl/X4XfCee57qLtBxtFulV6zSjAuKV8/04XVq4CGlhlv/LV9iwJxwZ9
	 4CWx1dxdK486ufSc5Fm+xQNw5Hqr89p3/QaBfxeCynmo/7qkSTxx5XfCH/B4MgQ1MlZyu
	 9ZyppeoXt0aYWxWLQ4AMeem+T6aMcFKfHt9glxF0iyfENhQMckZSAAHz4pXKet/2DtGEm
	 W17qC400cfOGJK/BiOXrz/nR7s6rGvIhnd0pUhrAF+NmGMNk2bShbfqna3EOEZa4o6rEp
	 OCDy5l5O235/dDh2Ia6SZ4i5GyQL/Po8tk3nFilwBtb39YIOuVNX2b2UrBxuzhd/8KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=amuFs9ok;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283CB60A260E
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 283CB60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=amuFs9ok
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so54760975e9.2
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919199; x=1795523999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjrAJfQ30bNb0haiNW552/JsaDvfxHWTHWoJPW/T5QY=;
        b=amuFs9okLI2wRGNauxrep+gGsL+WgJninSyaPDOkEbfMWHi10AqUav2FKNgAwERcf8
         V7IB6M42D0ens0gIQNIPkVtXA+GlgitgDE/T7rM6Dlc97u7gzS4hyS4gFH6X8HoHIKB3
         Y0ExhX0hVl9YGII2y2SZVK/0Z81ZNZ7/S/1DAXzPo4mmNwD02YDsVjM7OXvof6xjax9b
         RxNowgKMcyVGzB24AobXPCvssYOu/F/FgK/lg8M5j/hPa7llwNTv73eKS71OEYgmdOjh
         6fYLD9cmVDCn/h8rw7RPMmeo+yAV7i0mpGYKAXXAHZMV+EpEJqIPNadAlkBDgh5j5J4f
         Vgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919199; x=1795523999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vjrAJfQ30bNb0haiNW552/JsaDvfxHWTHWoJPW/T5QY=;
        b=svpu5JddKTMx02jQEXhfQnHS7+hZIg03PMq5M786M7tecbuaGbAAvZeAaidVjfKZzt
         dsPoobBbyCsqpI8B3pVxRNnX0B0KljgccZSIbBe9l4/WxdNO98ASQomBICqLpgCO6PQi
         MMu8bQqN5E3oUHhdrAsxiUN0i5vkRuIRM9fIu/Zryq7SIxn6Creg63p6EYywQumn+HiE
         MWcfZs32iw/RI7XHkEAPCgnwIO3hlvwlki4vkzdnuPxaIArYzGnJUzPlDYNfFuD23GZU
         nxSKZWykfsdzw3bBFWTtZZiSu4zRy6BbwnL3y+7o44jirNijlhlDi8Wu/EmltV6thDao
         Vy9A==
X-Forwarded-Encrypted: i=1; AL+hErEX/z+avTT02HNvtUWvvM+a3TwvSHOaGTJvtoKNZtX41C4a95ShxslVjz9s2Zh5+r+6W3adKOuPWAjtBQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9caRtEdSCm7zgiqjdZcpH3QzyaFY+1ZXALZFbQlhZYwGrV/RhF
	GL6wfyASqaNWvWels126dW3R0S8yxNm6aiu81sop93EVl/vermqNFitL
X-Gm-Gg: AYBFou3AsP2p+cu10mvGd55l3TVtR24a+guR/w3cIAD1duEngiJfZKqGs3SlxL7cJOB
	a2NylHYixxcqqxaRucs/a1n9vPDRCY1oDWYCQiqsqM3i+PR3bPx4PriAOwLtgzvcNoF4tTrdqlp
	3onh9F0oiwWZMbeFNsPYxLMzHMIsD7JmC5C/YSKSft8Su4xaQ/UeSvAU85X6/MrO6UG3VEUVk/q
	2IGwnSSFgUFSTk8T4XAg4PaC7zUm1mhvn/Mp6eaRRzt/kquXZ8G2io8ADFNwMC4D0UGBQHcYT5S
	7v7UR1gVzYJ+lhMBoJ+/1CujJozGkovxh9lkn+PqFIoxUhUWNoU+DMXzU2GuFPvUb9RxQFRjbhE
	UP0hjmBDCPpTvRqbWSSL09hTr271BvexD8hNyicz1Q8q1DLvBWnRsGFAmE3DmvJfee63seSVIau
	kx7QexcBf8+9LcyaIPF6zDjDv8Zz1oiZ2WePCY45WQ8MzVMbdZRnRiznviR+ggSX8NdooXLQ9Jq
	mG2ql47fSM0dUVdeKzKbVxKReCE/eFUeXUd9FlY9BS9pa7yogGFUW6nCBIauWinNg1j8AlYsQE+
	DF/4Z7rFNM6qNSAPmLRQofqGUVG/VyCauHrd8hDknqQ4QnM8qOaF6BakfxGlYp6blQPURA==
X-Received: by 2002:a05:600c:4e45:b0:4bb:56bb:1196 with SMTP id 5b1f17b1804b1-4bb56bb49f3mr279082685e9.23.1794919199526;
        Tue, 17 Nov 2026 04:39:59 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:59 -0800 (PST)
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
Subject: [PATCH v1 10/11] arm64: dts: qcom: sm8250-lge-timelm: enable USB Type-C
Date: Tue, 17 Nov 2026 13:39:45 +0100
Message-Id: <20261117123946.668557-11-rofikcoga@gmail.com>
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

Enable the PM8150B Type-C controller as a sink-only port. Keep the
primary DWC3 controller in peripheral mode for now; host mode and VBUS
sourcing can be enabled after OTG power delivery is validated.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index a094aa81ad225..6b57c658cf918 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -535,6 +535,24 @@ &sdhc_2 {
 	no-mmc;
 };
 
+&pm8150b_typec {
+	status = "okay";
+
+	vdd-pdphy-supply = <&vreg_l2a_3p1>;
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "sink";
+		data-role = "device";
+		self-powered;
+
+		op-sink-microwatt = <15000000>;
+		sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+			     PDO_BATT(5000, 9000, 15000)>;
+	};
+};
+
 &usb_1 {
 	status = "okay";
 };
-- 
2.39.5

