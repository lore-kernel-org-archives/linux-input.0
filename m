Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160050;
	b=222WPjnh6dn3YjCvwAZaRRbA4EG5ee6NPOam/w48Zy5YIfZUnD8V8M0o/E5RR+ycAeok
	 uleb5/c9i4zgdErCTC5erugxiTzsUlJZchFyUR6mzCbhEvviBTfI02GQhQ3p0u21rsBFY
	 6dryrYs2pNATIxqGT5lw3l1DXjkw1LFqxS97j0lKSzPN+bzvw2Bu0c0bVGTc+TqDETIU0
	 3tXSksOSJ1fcjBK7CIhPANfSKzJwHnW522O532KHSrNnDThJSM2zEjd7jS/QGCt3IcRxp
	 0PyqaWYtXnKPIZyWQZIB0i1dznYjZdP4e3rQRbXXZFtMxMN1gutKbgX7D1Iitboct2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
	b=0B2b7C5C8lcTEFJzoEGOt517FtLktW4CFDS8g/pKx8ft6vnb0AXDRB/HhylVn0sSnEgh
	 d2H+MV46pHH6UB/OdUIGuEaaeAR6Q6NwBTpCoQ1bOs+fJsdvJssjc56Uaz3SgXhrIvrAV
	 VWbNW6iQ5c+8hEKo9yOdy5IbJp+90eey1Asm7L4EiFXT0tW8cjo+XPDcLPmxfHc4CkaSh
	 pv0VukdvgfwAxsbCuCQQvxYLGODxFDNe91PA2kb1Pi5Zb9ZR/iH5+Eyw/xyf0YqTwKC1h
	 R1lXrdErq48rd+dVbTL4D5FIv2Vza+JFMqid/LiD+9xZa0anqnsSNk+cqF+fJx0phMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sk3PdhS6;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E560A2608
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4E560A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sk3PdhS6
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so5480375e9.2
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 23:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160048; x=1795764848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
        b=Sk3PdhS6u6GXkbXWDqXN4JbGbmCkBpKSZInRKLGFgBkhxX9mXxArpFf+rNaPZCwxU3
         3CGUvU9V68SAPRRct0FFpaEiOvp0VW5tPkqFGZ43AG+z/prjGacZajMS1sC4yXfIceeE
         hrWO2FrbS/V76SVw4FPSbKRpvuim+GphReaxGH/r8zDBT5Oonid7RGlEX4MWZ5+t0ZgK
         oZ5bq4BfqdAMXHwVrJfBOEzKNDUUUHf3rvuyMejdrknr1/79kCKrIWrW/GqOwQ2ZMz0W
         eSlgH3ZQGqwuba/uOXHZZemAE2ZhC/awGcVUrPBI7kiXZtNMa328GJ7IYVu8rq1KSraM
         loJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160048; x=1795764848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
        b=jS/Cr84EIYQcfSjCwsPf2WJqsw/8Y4XUk2+s55elGy1LEJ9fDtsraHGng2+xI7Yi11
         y85yBbydf2E/JJpz1656R6auzPqCrcCWX3ozEY2+pjzb5i9K1io01UrHamkABf+Dlcm6
         IjVqSxRVjxvDyo7aCvjXXotp3w41BtqNm3nyGPO3l4Lg7oEKYDI/Yzf85A9v4AGrpn8L
         oQUD5vCM7LtI7upzFgUacib1mT8qSTujkLvWfEWG8ZiGZKmy+66gPAEMqnrxSs2l38aU
         s52Y6vtozL/3k3ZSVL1yshpJG8BjHFmLzgm8No1K5SFlD9zDD0MGQ1Ct8NhDt5NSj2E0
         CG4g==
X-Forwarded-Encrypted: i=1; AL+hErGO1Y7GJv/ObeW56TDUsoHFX8dR39JiqLkZI4uFpsiut2vC5NcgI+HCUjLFLZlnjJKQx1XeH6kg18bm3w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+cfVrWzjpFq/lVVicwJw3B7wMnffx1NieCC6/U2RzLuRBCy7tj
	JbN0h01l6vCROGrG2FjuX60oH4I7w+EGG7KQmn8DgrG1CnsW7sCOCGa6
X-Gm-Gg: AYBFou0aKipySkS3pqrF0iCBFy6AT8tHOP9bsP15byHWNUJWgNhWKjCPh6A7XorCUCD
	vFYbDYITbIgWNVYYW4+gNoArv3Ei6yrqDp7gOpNmY8LQGzQ1t+CIpwBY0B/dYS3P5wV+9iDb/JI
	vORnv4Y+qAG91hqZeScDsEWSwpXoQC5munCJCM0eg1JccfdVcpT0RYmCrc5FEXTN7GvjCjMjbUH
	K+XqyiibmDWwCPI7YpPYHfk4+sl3lYtAkp9h5FBEOIYWDspaEr2fArSOKj0kjGSMbkM5y/mPBN9
	28BNlYBT0SoU/q/QmSgiW3u8yLiwtLmwwnOrjyyTaf5/A6naB3uC8NWN/uZsa0kbqFuJY3ebNbI
	IYMzQFmhBpw/O5hyyo9GNOvCl+KEBNpmiNTpxbI80H+6yK1ydO4/RTP9KQVheKkyOf+QPiSq4uS
	xiv/jJVUDVLpt+YW9di6w2vTmApV3IkTAjylQE3ve6N5zGMplMe6BGNQ/5ukme5y68LKHoisCV3
	u5F7SAsVEgZxkZvjuYIWGi4jZ1uoCeuhI98xhoTjRWl8uFveb8nB1ehO6XEMV/n0JeTyCLnJmHH
	+iz3BjYkVAaetXDlbGgKJzRX4KpySvJ+1UsclZf/FFURq6JR9akvWs4ysc7tHFUMijcavXwySQ4
	=
X-Received: by 2002:a05:600c:3b99:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4bb8880b984mr52971675e9.14.1795160048060;
        Thu, 19 Nov 2026 23:34:08 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:34:07 -0800 (PST)
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
Subject: [PATCH v4 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable SW43103 panel
Date: Fri, 20 Nov 2026 08:33:55 +0100
Message-Id: <20261120073358.10267-8-rofikcoga@gmail.com>
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

