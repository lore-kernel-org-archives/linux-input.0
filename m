Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919199;
	b=yD5hs6NTpscrbZ23hrQqbrpt84dDOXFTXk6eYmmKtq5jMDo8HrJR4fjjojMqAH4MYFtU
	 Ff73ME19tiqZiZCYv4WYEIRLiXjvFhb9Ey/S8KWhE6XjEQhBz5vYaTbxqZKg6q7KPRvKy
	 Mkx8U/r9YS8yfiyP+6xDa9mCrPPUY8yI5iLDaR11u52H9CvE7NRmPPHloDdTY+sOsbEKe
	 DLDBtZ+7lFdUJlr71JlIPsjSBtoHEyjxBqlSpRhELeVLvmqJVTFOn4+5SSww/msQBVcxt
	 Bv5W9otVIA+iXIpLs4bI9Tf6Ld+Gar/4/X8jShctIT2Xhl9F/pyP8596cXxmVERuirg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/HMGwwhGC6wtM16fz47LMMhy0kaE1LvMkOQV7+Ogndc=;
	b=Otlfk3UxbXxkAPscCWY+PVFauxQDbVl+wuHZ072Q3Zo7WvbhxKL9fqj8Tevw/Aqub8Tl
	 NWQrrWp2x7TMmM7oUQAzjVPvioTaBLculoDmXMT4KK6JEe9Wn5qdxMa5OaTtLZafbN38b
	 rU4dc5IAexGQBWyZll3pyXgZC4S4OyW4CH8ITz1ulGZAbaTDm55NbOZP4urGAJDmyX/Mt
	 mdYK3XmYhWZrjK0Ir4+Uzp2GlJe72WBAqU+QFwncFq9p4312BLbLPAsybTC3o9nx+1yCt
	 h3f+gM6sfSj+zCtUyBa1h+BPS6rrRlLxzLgwLvwg1I24CR/h2oqsvAYGzv84ziIyEPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mYvJk5UD;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB260A5BC4
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9BB260A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mYvJk5UD
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so54760485e9.2
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919197; x=1795523997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HMGwwhGC6wtM16fz47LMMhy0kaE1LvMkOQV7+Ogndc=;
        b=mYvJk5UDb5fY1RAaiAbz1ZaR7v4hnh+Nf3dD2aEUknU7gJH+VMHD4pmvofPyt/7iZj
         c3YlOgiC2zKp/KFrRsgtPLolPLB3NBgB92GVn8ZJrwalll7AjrLdDslnMVXqyIpwSgME
         P7K3LvBrX+gC2C0UwdgkfyrrHkzSz0toEZq+kFu+4k0MEru+y1OFbhxFnQHZYbfCHR4j
         iEhtzr5ClE4SzLx1u4gAyG0Xmy0pWQtbzIy4BO/W+fRxMeviEY1MWGwx7TI30t9oQLv9
         oSI6sK/rUwLLvO2OEYNN0fWpaqEFqoS6bWRg0toUmL6VXaahvbx7xOa1VFK9gWumkcQZ
         baHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919197; x=1795523997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/HMGwwhGC6wtM16fz47LMMhy0kaE1LvMkOQV7+Ogndc=;
        b=vlBDZF1et7xwlYJXTBejzO0fiY001p8chxzXnSx6nmbe14nUaoocXLavCX+XCrhqvg
         Hwf/ZmGCUznn6FOb6vNR3/keVKn6gkZ7a9W8/d0qM1J0fsUnFdTqt38j3b8wg2XnMU9n
         82HTXNv1qwhDP5WwQEFDGlwYw1Pdye9bZRMH9LbDBnJYiUxe6p2kN1TYobJsWXoaTtja
         BSROEjWCaO0aBEZSCac1MHquu3PgBsADuE2UKe9jErgaMJ7WWpJHvaAPtBVhw/Hm5ljU
         kkyspfWxkpxuTQ/OFgG9rEmzGrOd6f4VEA0RbBWFqKbwsPz852G00qsIUUz/cGovWFqw
         zTqQ==
X-Forwarded-Encrypted: i=1; AL+hErE9rBROK9kXiChzsiyxFhj+WLl9WV1Y1LnJDQXWbBIAeB6xlcWFTdpkk3N99DrDaz/V9qYemq76CcLGCQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9EzDJLaT7Bg3mU0FjIBdmmkU1fE5rRqMJqedHqdAPOFHwPzhja
	C10XVHH4WI7Vxldez9z+rAtcepZmvbG2zG/u5hVyvXGL8y+guPpGVEKt
X-Gm-Gg: AYBFou07VmR0wwNJFT/DtmLwm3Rfe8sd1gRdtLZ6b6V2fhJ8maGKNUE17ChwfbWG8mU
	SYifke8nqdMPDdsDMjpDf7CBjefNIE6ELkrT+id5QVM8r/dyvgStMfL2Q4Mr3WWgmByZ6cgRiha
	nXbOD2luwGUcsAFUVHUkLRRGNSRGIxDKufMOeJVeveNMm/5f6TH8fu4BAyRtZywATP2ZsgD+IkX
	MU5y5+20Cr+u1O3x8UrBFaawW0zLA018G1+72f6H9nhmvq/h4aaM+Ai9IP5JyJMDrm+CBPAHS1k
	OLA1foFkmEXgcjLahtQwCDfMWgUwDwNiznKsRz5onj4JNkuwCwaVHbRQMXpisA6FDL7eqbPL5wi
	qSvemBasjLF7iYWLPSXJAWTCW3IqVvdtF+7g5N8JPIsD2zSGyM0sI9Z6Dp9tkWkSXu1sDr/+2vP
	sxB+v2NjQuCi8oBrU6tMTRyPDlBUtz3XsrB6mTGG5FJNupzL/Ha1rXWgE2L5JV2DTm7hrQsxQEF
	K2lvXx17+IHnagJoAwRQg3IVxkKRkEkNllby3QttzY1PhVagtDUggCdXbbX1U0MCfgJnBuyzGdD
	jG/KSq98H1D7K3m/ltmlxvuzagLXKtg0VuXcbw0SmBhBaB0468m89nxoDWgm4WP1fxCpKA==
X-Received: by 2002:a05:600c:670b:b0:4bb:7987:fbbc with SMTP id 5b1f17b1804b1-4bb7987fdc3mr32412055e9.1.1794919197198;
        Tue, 17 Nov 2026 04:39:57 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:56 -0800 (PST)
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
Subject: [PATCH v1 08/11] arm64: dts: qcom: sm8250-lge-timelm: enable SW43103 panel
Date: Tue, 17 Nov 2026 13:39:43 +0100
Message-Id: <20261117123946.668557-9-rofikcoga@gmail.com>
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

Enable DISPCC, MDSS, DSI0, and its PHY. Attach the SW43103 panel with
its power rails, reset GPIO, and four-lane DSI link.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index ecbff27976fc2..fca48472f5dfe 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -557,3 +557,42 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l9a_1p2>;
 	vdda-pll-supply = <&vreg_l18a_0p9>;
 };
+
+&dispcc {
+	status = "okay";
+};
+
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
+		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel_in_0: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in_0>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	phy-type = <PHY_TYPE_DPHY>;
+	status = "okay";
+};
-- 
2.39.5

