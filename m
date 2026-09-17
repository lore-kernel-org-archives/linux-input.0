Received: from mail-ej2-f20.google.com (mail-ej2-f20.google.com [74.125.228.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0343305A
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633552; cv=none; b=u98LTDN3fgX0Oh7S4qBDaEIR3ceJif/fT5jmvbtJdB7nF6XWeWZ85W542Y+WkmSP7cSErt3d+LlNcgX3XdePXl1Jtjk+ZPTJ9UNjG49geJdDZLGOAp2fryUe7cV3dDdjWTBF1RaSvJRPjA0KCjJ+88ckZzdpicKQ07mDvAJAT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633552; c=relaxed/simple;
	bh=tKqz8WaA5fCf8zqxAuhb+KSHy9L2ioB7dBm28PChNnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iENSCC2e/8oY+LiGXgGWs8SbLdCNYh4k5ogMZEJVC7+VExaV7uqtI1A8ITOtGlHT2QXB2BVVZMZxguV66s44OuGhuw+ph8BzJvB6QRMgYlpNjgo/SHjK++rxWe6hkPj0JLX7jHXRQ1hikYRAfnPi6s0g8gT2wWuwlZz4CL87a8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=IDVJg5Aq; arc=none smtp.client-ip=74.125.228.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="IDVJg5Aq"
Received: by mail-ej2-f20.google.com with SMTP id a640c23a62f3a-c293c683202so87392566b.3
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789633529; x=1790238329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0+EbfIJEQi9Km2o4RWY1Oe967wA79enaext7ctyUJE=;
        b=IDVJg5AqZ5Y8c7H7zSYinlG5tIi5AwD653xe1nqKmyj7tZsrPP9eDHFCoxu5+v78XZ
         z7r//+jXaK1ItG7a4lVzO7wNdC8OvvPBW9rwzaghfbZRGCpL9OTTXT+bcu6z5nLUYjdJ
         yCOwUOpys8DQEkxk8s5PQcVfCbou9UeEz85BbUOsCx864wVz6ta7gT4ZNFL96mTKSDUi
         eRchZgctIDCvFsKTcHyJZdQSHo4jymsw3XwHlA5L29oFrH6slArNj5p73/AN3O3I+QYI
         1HhU7ixTJPSeHDAq8b2G57TiwRcAe+fmO95w8JTMSxTzivHi8kmnrlTAYQHLZU/jDnAy
         dzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633529; x=1790238329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0+EbfIJEQi9Km2o4RWY1Oe967wA79enaext7ctyUJE=;
        b=b4ni69H12yhus+ve+i1Og3lykEPan4laLJD2dmP0oL58jJ0F5j3PZ4wm6Xy0YOc9+X
         n6tHOtAwAfon0TPXARvfZJoigaX3gkLWDUTzjQsn+1vOHf/AywFqEYw9ahNh5Yg8u2Bi
         0MQJ2PdB95oFEJc/NWhQQyXdqS7VOFP8OE9Z2rlSn2v7nnFmfAPYgZnGBxCW1Em1O/jE
         DTFOoBvDlZDtvR7SRRZpycpSabaESzKHAVfTCNBMj1/8pecm1d3lg/YpZvQdjG9e/40H
         iwZgeKUpHkQqC2nJ58k1b+piczYCQvaB3pU55gW6RneDvCkHyiEe8w+fUtH3LuSO51Zk
         DVHw==
X-Forwarded-Encrypted: i=1; AKwUvBw0Fw/5ON4Y83SEDwEvn6F7wAmx9n3S+ZLYHIWY8DIgQMrmp5EL2bA/WSs4Jhey3z1YjHvcq9idxi8LrQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ngkrXFnfUbPRXVMeBFJbrrHvy19sTfJRokF22Kie7s4IjBQjxh
	S1HMLP4gb9paFNoaE3M0h5m13YCLNII9uf++hdW+aZYo6FYY13tdzdIsHlHec4E1mXXfJVuczrK
	KvhBw
X-Gm-Gg: AYBFou2QUdcAnvTVW9sY9DTPMo2kmPGzlVWABV5nGN5BJaIMmTCsjY7AHzbgRgZDd8U
	iDCWLJRyzKYt+zfP79NSTRbwlHCg7DE/Ex9fSaA6NSeyz1S79aFFyyqp7cQzOs5NVbo4Vmss+/w
	6I3PeWMHSJkutewjYjM14qnTp+X9+ZtHmyPdgHCg9gLosC5jDIwex1O2kl87nO+7bkJj6mCVSJX
	xu+RFsd9l50JD25vRGH81w73Hs7/o7YtijTAIOKo5JrMhCLtUDf0lGmyuWETHNxuZ+zRGRS3VBU
	+KC/yW9VAjIY7SPrz0OOmKXtt2Oo/TEAhYa9eBOpyLFbi0wPOlgJFWgGojxOqfwdNH33yn774yS
	AatDqIedS1EfpFIzY2koVXbW16DdzN6AGcsmTlHJuloDeIQLlt5paYCOopOJDePT7GKBADDF/nX
	38E89827hy963X+4loxtJeuAGwFENAmUgjFw5Ftq8mY3B6ldHxZTlh3HOEzA6diQb+UBaWQLML8
	OdmrpBQ2cm7RyOj2dfrpCOURT7ht3MqIobwhD9AEFEFE6Znp8cI2r6U3uQX0Yw=
X-Received: by 2002:a17:907:7205:b0:c29:59ea:5bf9 with SMTP id a640c23a62f3a-c29e52085bamr405665266b.14.1789633529521;
        Thu, 17 Sep 2026 01:25:29 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0851ebsm242943966b.4.2026.09.17.01.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:25:29 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 17 Sep 2026 10:25:25 +0200
Subject: [PATCH v2 3/3] arm64: dts: qcom: milos-fairphone-fp6: Add
 touchscreen
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-eswin-eph8621-v2-3-f534080a6338@fairphone.com>
References: <20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com>
In-Reply-To: <20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789633524; l=1602;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=tKqz8WaA5fCf8zqxAuhb+KSHy9L2ioB7dBm28PChNnM=;
 b=UXnL3U0l+wxPa6dEX/B0T61AEQAmzOv/3SA2eDzB+9GPdURRWB1b9TGmZdmBpcE0PZyPxTwsc
 j0/hz+WM++LBcUzDuhnIkvW3795KB3LK3CwcFy3Zl97BxeSBbPLw6ph
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a node for the ESWIN EPH8621 touchscreen connected via SPI and the
pinctrl state for the two GPIOs connected to the touchscreen.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 29 +++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index 4b7ae87270ac..498fde3d3d18 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -983,7 +983,27 @@ &sdhc_2 {
 };
 
 &spi0 {
-	/* Eswin EPH8621 touchscreen @ 0 */
+	status = "okay";
+
+	touchscreen@0 {
+		compatible = "eswin,eph8621";
+		reg = <0>;
+
+		avdd-supply = <&vreg_l22b>;
+		vddio-supply = <&vreg_l9b>;
+
+		interrupts-extended = <&tlmm 19 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 20 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-names = "default";
+
+		spi-max-frequency = <2000000>;
+
+		touchscreen-size-x = <1116>;
+		touchscreen-size-y = <2484>;
+		touchscreen-inverted-x;
+	};
 };
 
 &tlmm {
@@ -991,6 +1011,13 @@ &tlmm {
 			       <13 1>, /* NC */
 			       <63 2>; /* WLAN UART */
 
+	touchscreen_default: touchscreen-default-state {
+		pins = "gpio19", "gpio20";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio65";
 		function = "gpio";

-- 
2.55.0

