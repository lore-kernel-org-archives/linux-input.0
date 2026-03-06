Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094335B653
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795992; cv=none; b=RPY2OvKwutzkH4GMXu+7+a2pQORjZIwTH1iycCzNxxnTMi7IeYnUky9R3qtV/DpLSGbDTyY6O8m5cRLlZUGlxT0sj5m1FUCzskgCXF9X7dyKxeUSxLgI3liGla/F8RTZk948tzznK1aUwLJqZXcH22soF/Fj+42W0YVQaBGGPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795992; c=relaxed/simple;
	bh=wPZiFdqCiDOOFye8FKOQoufL7cyIaxgiXa67+xHsn0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxIn5RhqtQ081tyIzLuSKHK7Amg/izTOZpq5Jrs7l5Dx6pxE5BNa2gsmc9etFQzKuvUPeefFBvdn+Zy5oIIQ6M1iNXpbAWB903/jrvq0VjL0SnsYE05RnW3cMJolUN5UWIg49yKvVkwN8Sf0furX5XRCp+w+VpN4NcH3prgmtfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drbKAYCt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drbKAYCt"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823c56765fdso4749301b3a.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 03:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772795990; x=1773400790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkTY0vM9EzW6XUSGNuKIJpMIFfDu1qpzZf7r+qP4u6M=;
        b=drbKAYCt4uW2h6ub9Ae8LCUScPvaqqaG24jMY6TPtg4ab0XPTqr0AomrM5XLWgGGuW
         ocXQTkFqxcESx7Eq4IIeENfkY0AmCL6uqVyA7Td65PE2g5WTotRw2twpgth/eJMiSF81
         aYXlWfKSw22UbNczqIa3LcrmVynUBoUnAD6+gpK2HVhX+oQKKx73PWcbG+RJALPVPbR6
         1KyxRjtjLdxpC5m7vvh4pcY3klbuNBgaR/QNc8gejDLiX/aPkbNwDrq6YSeV5egKaDn6
         qinICQ0StFtQ0sD1vxZGHhCu4uQEn0yWCVpBfYnHGrl44JtrulHJ2iRcT+W3rl6zY4eb
         hmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772795990; x=1773400790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkTY0vM9EzW6XUSGNuKIJpMIFfDu1qpzZf7r+qP4u6M=;
        b=M+sFw8Jq6pLL/WDcr5R5HmwH1Dd+pj6NC/POCRPbvaHA/LBTjwbZCqReGotvSjCfHK
         qigp6htETLDSCcicpIAN0yVFiFqYTMBi06DiTi3CotTHnS3xXgN4szJ8V9aBW/uVBFou
         62ybEeWEw6wwqEjCf+aYt7/Mps05wbp/Jhfs+ovMnCpzO+QEi6a6uCW8jZHJ57NQGq8F
         dtrzWTyYBKELcEEzFau0Or604g5cW5S1ztfhP75sk2eZl9DlDXrPgGQNuwW97sJHfWwx
         +MUhuxAjnKAyIGqkl/FT/mDhcteKtpiTSljWd89SUd4IbcOfXfcUDK0GtuL7l2om2MED
         q78A==
X-Forwarded-Encrypted: i=1; AJvYcCXIpYHUPm3leX/zO7MK8Ok9ltQED695HaDHIMBPUO5rRi0y+MlRhdaJ+neWutK2s8e4FLp9hoyyJnnSPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzatrsMUkpFVLggxCGRCgmegDqKcXEoqLggt7WZ5E5yigleAXWS
	h8A3rwJ9FYLZ2WfD2FeFkqex44UO2x0+G7oDGZrnHHLYp2ZJqzZbtP1s
X-Gm-Gg: ATEYQzx7mnZdnFECY9XLk6RNfePpiRr6X+5kOuDsXs6anueYnIkFQGwHizx4JPK/qda
	Or3MB5t2PKTbkG6lWpgRAu4HdOTeNlpXJEyBGX2uvkWSiL4izg1LLhIMEw9jC123HEWTkg2yb+J
	vqVMHOTxtTTaWzTpsWoTocTs67O0VrIJnVxcChRtCJLB7c3RpaHr+hF3RLONFjZpi0aJDDq3fyX
	ZwsZ20cZDQnuOnIg4QorhDiB4j5P4EqLVIZnKf1M4k+8glUDLloA13FRQQ3v0UZyrrWrhUsFpK8
	lIQjGHsm815R/bnqFlvwrkW55YVzVwDbo4efhX3FGmLOs+vgvtApk0Ybo3YzlSZBzZ20jNeFEnP
	cPbdC+3q9ERnETKBF7EYRQPvQKHOlt+C4GsZHrQLgfrtOpqDroRF0ZQHaaTY5YkmNJi/Wt0mZpX
	pxkzYa/JaZGQQzsOmP4oB2Xeh5zb4WOYW87SiPumGqYKmEKghVxfGaZ3vBzA==
X-Received: by 2002:a05:6a00:1ace:b0:823:3078:f684 with SMTP id d2e1a72fcca58-829a2f425e5mr1584387b3a.32.1772795990480;
        Fri, 06 Mar 2026 03:19:50 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636cfbsm1475973b3a.13.2026.03.06.03.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:19:50 -0800 (PST)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jeff LaBundy <jeff@labundy.com>,
	Bastian Hecht <hechtb@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v3 2/3] arm: dts: renesas: r8a7740-armadillo800eva: Add wakeup-source to st1232
Date: Fri,  6 Mar 2026 18:19:11 +0700
Message-ID: <20260306111912.58388-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306111912.58388-1-phucduc.bui@gmail.com>
References: <20260306104025.43970-1-phucduc.bui@gmail.com>
 <20260306111912.58388-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Add the wakeup-source property to the ST1232 touchscreen node
in the device tree so that the touchscreen interrupt can wake
the system from suspend when the panel is touched.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
index 04d24b6d8056..d47a6cc3e756 100644
--- a/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
@@ -228,6 +228,7 @@ touchscreen@55 {
 		pinctrl-0 = <&st1232_pins>;
 		pinctrl-names = "default";
 		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
+		wakeup-source;
 	};
 };
 
-- 
2.43.0

