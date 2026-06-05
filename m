Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6393047A0B4
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643409; cv=none; b=DfytyFe3HjAYO2m9XSb3OslzygfhhKrcw3PM2oyo+tXK4rNvvyUIMC33dt1i5oW+hYS8Ks9V0ShSVU57rNlXs7FyNzi/asVSGuSADkpKFmXHwcdN1zR9y81UmR+WDN4RKA5ntzbc3sLWorVdAwdpMIR6NG7gcCDy9VPnvvJOgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643409; c=relaxed/simple;
	bh=GBzyizyPv+xra61B+Vq9gjaajVwxBgMvkwqgSZplbY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTNCOjaeOjyEnWL76WKMM4TtlZHcOMCjVeH4bYHHmS+MQR4Dr7qWFL3NTMDMhbyn/d3Xat+ENAcqMfkdn49K7qbihcYOYaMGWIsAaSVoBTI32RslRuwsQuXYx+hNpRpT/QFmNbaJWgvWHwuE4K30adIcmEAXn/3+bk0xJcNxe0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vuo5E6EA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuo5E6EA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eee266c6cso1219068f8f.1
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 00:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643405; x=1781248205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMKMXYkNxydSpTz7ZRDCxG2wY5Cxqn9vnpLFwt0ezvo=;
        b=Vuo5E6EAK4v38a+swgTIT8rImIXJrw4+wTnDO4sNWHk/lowq8xMvONyE2fZ5SIhUU9
         v/Sqky2Q3NPamCt/kLRXBWbRTihr9m8AO7KtqYFCskOnCbBGQ1CGZTNFhHWqUuPnckqm
         iPUwLWPJB3xBTFGN1k0gafsj98Rd5iTAvJsRC2w+t/VGgVOyPphSxKQK0OaSHEV/8Jyu
         NtOYvbLxTpi/ugtaJd1Mpa2PZNnxGqfMJZO2mPhlzuNMb66nWP2CHwBeBBBKXtRQ+z25
         tF196E4TECl82t5WsgmBWMVJmtLbeSLG1st7A5fxSwp+fZY/cJuemCx3L4UBvvt0s76w
         orxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643405; x=1781248205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMKMXYkNxydSpTz7ZRDCxG2wY5Cxqn9vnpLFwt0ezvo=;
        b=Kh6r/XpNVEAhIOeJiHrWJ0wHYqt8RZ1XxUxz+2koSok1HPw4od9aRzfMvtO/o77SCK
         SNzoUaVOhcBVdS/7I+KTAV7rcqjnP0PtaiNS2LraQn1UF0vK1hcq1mfuAKi/KFZpmEt6
         uoNSwzz33DK45d3u7Cd3h/hgseCzkaCjdXQCq1e/icEgQr+ofmh+pkxT6oc7o9yKpJIr
         tduK5GCTtetklnx9F0wN3NmVgCR/dtI+kk1xzPGK30TFWid/yeQ5ltL3XNNDWEQlzpDk
         F61JXSs2tE7rnltjFRFE5C7lKEIgxRGobaghZ5jGhGhH8k4b5x4B0WlD9W5enOVRDEwN
         c4yQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DoLHfn7acpLr5Az9VSMT0ItptaLqnq+RZH9qShvDm6a0w4KNYSN0HOUficd2dksRDWeXBl+tXTE0Isg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNi2/a/0tF9PEu3rhoQdsJRdA3S8RRLwIHLNUTAAlR3oILxat4
	RVJlY674AOFTm996x7Ho0JZQY9VS28fLrAA4tZ4yAs3+DCiZ/QSSM5hU
X-Gm-Gg: Acq92OFpc4o9a1chubiywILdE94RPv3dlK6gWKijEqZuoGqb3JOp8hAo2xTFw81TluD
	yucRR2tQ08kkxzjOb7Lin3JKTOc+auULjOW3FXEhONvo5093sIoJVyW9LSj+vc9pxfwSgYYV9iE
	E0eou/j+io4NhbESEXGNFcOzif97wbflN8zWZwHHuhem8LdcAF6cBwBNQq4SsfksvBAhu+YOBi2
	CUVnZlf+X48+8i9editzG+p+0MSsbap8rXIJrP4l+roHSaS5HEpuKqyT9CF2t6qZ2EfWawAajPn
	wvEeyTHnKxhJvOaeH9P6ibPz0qh8c2VrG8ZbX5oq3yknZJFkmH81tJo9BLWQZIUkyrOxTbuZlBI
	z8ethYO2gpAEbjtIDHhZ2YW+q7gQz1aLGmVJW31ae+zmr5wVdsTCDNc5yjifAjpxfSotQtTqJEW
	cEiX58vHJp04M9vpCUBqONWs7b0i9C8mmBrKN6Crl3qfFho0CbCh1jYi5VkEJL3jFUT/tPxTyb9
	Bo1OfA8kzOqSYGdPK8U2g==
X-Received: by 2002:a5d:40c8:0:b0:45e:eec6:5020 with SMTP id ffacd0b85a97d-4603063ff2dmr2697534f8f.38.1780643404687;
        Fri, 05 Jun 2026 00:10:04 -0700 (PDT)
Received: from localhost.localdomain (72.92.4.85.dynamic.cust.swisscom.net. [85.4.92.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm25132882f8f.5.2026.06.05.00.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:10:04 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	=?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Luca Weiss <luca@lucaweiss.eu>,
	Sven Peter <sven@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 6/7] arm64: dts: allwinner: a100: reserve RAM for ATF
Date: Fri,  5 Jun 2026 09:09:20 +0200
Message-ID: <20260605070923.3045073-7-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
References: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reserved-memory node carving out Trusted Firmware-A region spanning
fixed 256K from physical address 0x40000000. Even though Allwinner ATF
itself passes the address range in the fdt to U-Boot, U-Boot currently
only reserves this memory internally, but doesn't carve out the region
in the fdt passed to Linux.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v4:
- new patch

 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 7cb06b19b5a5..d8391663fd1d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -87,6 +87,22 @@ osc32k: osc32k-clk {
 		#clock-cells = <0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * 256 KiB reserved for Trusted Firmware-A (BL31).
+		 * This is added by BL31 itself, but some bootloaders fail
+		 * to propagate this into the DTB handed to kernels.
+		 */
+		secmon@40000000 {
+			reg = <0x0 0x40000000 0x0 0x40000>;
+			no-map;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.54.0

