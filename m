Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919193;
	b=JAR7ir01VTxEkuhORSEK+tXcnOjl4sPR7ILcqjcILBPpjvwM5jJLmzXRqrT/0cNATXZS
	 hP/TWVrwqDQ8jYMe8186H11KDVWmErE04Sqi7qAS7iFIHAcSHTAw/t4jn1UFG4I5bhVJn
	 Y7ZUFLolqt4Ktr3zUjcZdV7R070/L3iQyL0ZkbWXE4FkSOsiAiqH4bwDV7jG3+3MLxb81
	 aApy8sou/C2ZkSIt/k7/0Tp0iIqbI2+yLxJwUZ03raRT6hiMNhnMP/mE+v9N9LO0DcCyQ
	 h+xM5ny59tKKSpDm6jLqwUT5Y5nEEvoiWOZ+7yROZjafFhkncw7wyZp9TySUird/uZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nJ5hpYg4Cc8VUEITkJRPygPQ3lscK1+CbDfUcnWlRxY=;
	b=tY4wVbDd5OROoiPC6ZbUgEInhBuJ0DziPmfrIx3y3eWn7WG+jcU75imi8UdF7KJN+xDv
	 JvYCZnVbN70yxDdyKFMbAzFoDSs45SdCt3n0B3EWDg1mVsNMWRH+R7v4mEAkAgfgMsHus
	 eg+s/g/NZ1Aadg/9ixJiJSzHYa5CMAh4vAaF7Tkq9jd8wXYl5Xp6O2xJ1XAM6nCGiyiPt
	 44VPaHB3cf12/gOYX+j242c7mXesEld2VpZzaV7q8owyDDDRVEHGA6TwwICx9OB4hYdaH
	 WsbYsKce3aofg2Fppr5BoWE+ugp2dsByGVDs3GTWeIo3zeFbK8ag+ekA4JXkG3fgKMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZAPvjrZd;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84592606A8B7
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84592606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZAPvjrZd
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so29740195e9.3
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919192; x=1795523992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJ5hpYg4Cc8VUEITkJRPygPQ3lscK1+CbDfUcnWlRxY=;
        b=ZAPvjrZdH1ynZ+1SyLLA7fkPQLbJu+W5/CYb3xFMiRsX+eCwe9ddKdOWDabHt+iY4G
         +HtXRZ3spDtEKFbhce0su6DIkz+zJr9mH34jwRBqKZQifrzqKUpzUZzK4Qsjrlpew9hY
         S8ScAM0TZ8pxv7mh5O6GQ3z/zgbVXbsvheONAFloIyexMycUscFo7jH/7Id7mwhDjU7W
         Zr0w8TuBRtt9GzmZv+OJGIsWNnnxbwXeUlzZ/NeGcA4n2o5BOehtlgNnTwJZrprPz0Tc
         sufr04gVrm/JQxjMKdq4B4ovdOQGZak/ePM9smlMh7Z9/FVSI3UQPxJVTVdcZQMMlCCf
         Ja3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919192; x=1795523992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJ5hpYg4Cc8VUEITkJRPygPQ3lscK1+CbDfUcnWlRxY=;
        b=P/el0ra/liKErMoku2JxBrThR1sx0BruKjs/0WdmLMxBrxeKiy86s6St6R8hW5N7M/
         KvpmO5kYIE4qlZ7CrT6SmC18GWezhfR/Tz69RVUi1R0brQ9F3uhlb+1a1knuRyZ7ePxE
         0PZN44g22w1TL1nUDctfTciUCA3yQDHqtJGNXGKSnOxe25qKdsoW9qinpldsE4132AvR
         Ra1fhoFF6Ewm2SOGiO3N5jvwEe2P+U8Etojmg2QtcKZsoDTa+8B3H+j5YERRR62Zydg8
         KY/JDdLEx6apGvAE+6jqgWhB9QBdOm3QovQtxih9UsrBaWLlChKsqYntN/RS237ACwUH
         5NXg==
X-Forwarded-Encrypted: i=1; AL+hErFnpGjTnOFM8RZb7eQOik0YAwfHKeo5cCLlJ0Y244UegXzQEQ+toWBmt4m2g7g8Nf4vROhktVzH23qMkQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+smnQ+M/YfApwwkHLg9nTBEeYlPLt2E5YQ+L708DWkywhabpKi
	JNNBiN2t7aGd6eO3A+o77ROqPmUrU+abI3Jcm4omQ2cJMq8I5QhhPcFl
X-Gm-Gg: AYBFou1XaMp1o2uZGCGYbO68g6JV38XO8b0VO/YfVLjZiagPjH78DNXgWKYYyHUxqRm
	vSaQ22IT7NKOezo/tRWn6Edlja8XTX4ewBeVyWDk5so9AZwgGu8SSAQh8NeJUnIMix6whuJtZnc
	0dNKqp0aiZbDam9Sgs+vLfJuUmAxQir9O6TRh6tguR6rhTdBbGJf+p4PpAYXdGDQ6LPoRVKfG/t
	WjknU9MfjniBl4rZYhE3XcBUB/aH4QXp7Uqydm3k3wQdK40owroj4Sk9teywYP7e0yydWI/A0gZ
	ncfZdYRMIDSYXDQO18/h51DRu3akDmxIiVlHSmdanQSzn88PRleq9fTLFeIkQmXcIyTBas1KneD
	aArD+OX7aVBKhwNsgWnrNCiUadzAeAHQP6flqwwtpaRFoC/D08V2XspxtGcvJNCXX12fcsU1Xh1
	yTnhF+D1IQF/bgKIDRl0zVeexKYzhwngz5jhxHMkplnmY23rU/zoGiVQcUnUtAk+/pz3mgw4rPh
	oYVFSqnCZ1xAEHYiqVIKt5ipVVdYXIzBtmVFRhxy6Mv4xNPODgSH1E1QgVTGF39hDL4TrpjHLKB
	fsLGCECUKMN0Ln0R0K+XklPchAQA4/DUGxjZhr6QdMG+DMfSRQQXB43arA5wCzeJAk5Cjg==
X-Received: by 2002:a05:600c:6096:b0:4bb:5de1:e923 with SMTP id 5b1f17b1804b1-4bb5de1f26dmr222829735e9.4.1794919191912;
        Tue, 17 Nov 2026 04:39:51 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:51 -0800 (PST)
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
Subject: [PATCH v1 03/11] arm64: dts: qcom: sm8250-lge-timelm: add reserved memory regions
Date: Tue, 17 Nov 2026 13:39:38 +0100
Message-Id: <20261117123946.668557-4-rofikcoga@gmail.com>
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

Reserve the XBL/UEFI log and DFPS data regions used by the firmware.
Keep these regions protected from kernel reuse.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index 74b673ebbeb9d..ecbff27976fc2 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -103,6 +103,12 @@ ramoops: ramoops@b0000000 {
 			console-size = <0x40000>;
 			ftrace-size = <0x40000>;
 			pmsg-size = <0x200000>;
+			no-map;
+		};
+
+		res_xbl_uefi_log_region: memory@80880000 {
+			reg = <0x0 0x80880000 0x0 0x14000>;
+			no-map;
 		};
 
 		adsp_mem: memory@8a100000 {
@@ -119,6 +125,16 @@ cdsp_secure_heap: memory@8c700000 {
 			reg = <0x0 0x8c700000 0x0 0x4600000>;
 			no-map;
 		};
+
+		cont_splash_mem: memory@9c000000 {
+			reg = <0x0 0x9c000000 0x0 0x1200000>;
+			no-map;
+		};
+
+		dfps_data_mem: memory@9e300000 {
+			reg = <0x0 0x9e300000 0x0 0x100000>;
+			no-map;
+		};
 	};
 
 	vph_pwr: vph-pwr-regulator {
-- 
2.39.5

