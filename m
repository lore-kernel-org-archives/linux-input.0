Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919192;
	b=NZhODuH8b0/6ArCLq+H5Y4+JHEl5G6avepSKhtX8DezoVzJpKVDMkvhuOEbZxYKB93WM
	 JW6cLrZ2/BYLzH0VWZhJbI8WEzNmLcoMQz0cuZawW7sb2QXtv3CajYURzuEkqo6TXu0jF
	 ADUEnh6UEurbNH0hAPzi5mgzPlyYdcPr0gGMhHvhURbtM1XpPkpFzKUPGYkqWvMkw55WR
	 v7q059lyPiX5otD+BfuUTwApIwfoEzCrBGAFnl650UuR2d1Refhnd/fpPHfoLTCUz0IZL
	 OEy3AtSFhYvJuAi65z1IVKcF+5SEIvjk5mMCCHTFHbqEMrtSEeg37sBZ8oV2yRvfewA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rwJM/btZEuTlA5fjq2BpjxzgulZAXHvNDImvE1z8MG8=;
	b=EjBnYSO7kNAxVg8IbiKk8b56RUXyniRBe0UD3I0tf4n36dlZKhrQrs/1+6O2CJSng/Zq
	 1R1xCVAyyxHEM1Q/nbVLU5geE48rCFsdj/hR1gH45CxK2fm+Qh4OppqonpdAkILxyzkDt
	 EQrX44J1TrXiN04/zyfKUvxubkrbeMoqL90G2GMC0kuQnXhKQgZ2i3laNVKsA21ma8Lfb
	 XWCpfJ6fV1Llo0xIpU5X581DlnO9cr35GAtwiu4ESvlh1+sQsfXb7D9k3KbApQ0qjTRtM
	 hP4mmxGI8oIFB23aqdec+S4mGDCCkYAxrYtXNBmXl9GJ/c5MDz5A+az6d6+eV/LGwzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p2QL0sBf;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A36606A881
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A36606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p2QL0sBf
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so6325235e9.0
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919190; x=1795523990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwJM/btZEuTlA5fjq2BpjxzgulZAXHvNDImvE1z8MG8=;
        b=p2QL0sBfCSrXZK7z69n/Xb5ZdxxmzCyFRVDFk9wG3bCxvJeWlHMSFo5kACNIcbQFgc
         AGUGL9NwLq2UbaN39WK9LRWGrJy9A9jWBfhVlV7JIIVmIyrjHqDqIYzWNpo9+doUSEE/
         b2op19hmatQWsUEaoBJuZk0hAotqj4jEHwBiDmVlsq4qOmZ49EdcctCVV8pQzjYeuD6+
         Ls3mkpF1ZAoJpETbTHVANgq7VQfCXs/Yv54qoOF3Z6ImNn88EGN7MDc1SU0RHRWLKE4q
         GVe86wbn+mRFXQQteW/6yy/qNXoWf0sHWfr//IuZMSJlc+K44K9rVevgEP2urq3qYHwf
         c8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919190; x=1795523990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwJM/btZEuTlA5fjq2BpjxzgulZAXHvNDImvE1z8MG8=;
        b=qjGCDEEYHIZms/FGuSg06M75b1Zadl8r9oRIC0ppcZJ1IKQUlhcW4pv6DqSv2/P3hv
         w+uHmGNzgi1k52utyB/D4nESIJjVCuY6KF3x+oaHxucp8EZ4RA8ZnjslEVo/xFl0NFfg
         Mg3LW0TpBG04BQ/qRQYX1wNAjZCnowcLLeG6CjiPtT4Wx0zoRfcq8ujYlpgxOfaaq6Ul
         yREALIFEpHbkLGmSknWuP8kSG312+Rs/eOy4JaWN2BhBpgL0Hd0Z2V3fsaxXnHnC9goC
         giH+9QE3KKuqu0Hcf+Xv5OEwtZoMaavuCi87Ds6kAOXUYbxcvVdTKXHp0BGM7f97JJ8v
         JjCQ==
X-Forwarded-Encrypted: i=1; AL+hErF/boFRL7/l4M1PKpaABcF+PuPSPALsdyp8sbhgWFTiEwmkHq2BdZo9DsnYSWAmvQ5Fy2BacvrOI5Gmow==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dhzwKR5zVyowxLwkrCSJJYuJ+KfZE0GqOlgeNLbQlk9iGoKz+
	LEmZnzWwLpSavdUc47Euy+xTOnkosTStOaa7AoSTQc1z78ZIcMX/FTO5
X-Gm-Gg: AYBFou3yQrwQVDrV7u596wP9d4SXIuBBElHiIxhm4LLyaHNHwMYW96WMWgf7VVcIyMx
	tvO+kL9jzWr2fqAZNPakbwHxKu9sBcJQGMmZPHBzr2N844ltgl7HMyo8x05Oj4q2e+ux07MhKip
	wbMFI+KavnwyF6kFT0BIOpkhY3MyuWkj3+bb+YCjwXFdq5De1DBMfswWDE10EFzrHhn/dilER13
	l/ObGYpRg/Pjul3pbgvae0l7N4zQM7sPKZpyvotDmc3c5CU7IWlS7ZznQNXC3GtYLtjFho5i6u1
	/yojK2S2D7u9haTTMH6tQWRo8V/Le3WfOlwRYZB8r9FlwFO3UCBboSvFB1eHUDQN4UhPLOF+OPL
	1l9SNKhfTE5gq/QNyTx4VE/SByh45vl+yWqLBbb/Z19wyGPlr84eRHeS5lJPS/AHFRdK4zT2ons
	lEYD5YTRdmpnKlEPqKlShNwsKNQU3uKsB6JS+3HVIb0Dsv80XG8jB/N5KlJyBD8iKfbQR0sfnus
	W/Kmt3eXk1UbizQNdI2J3LpZj1hPb+f0rtUu0BoLAnBxZ8HHziHx0TxTyMJIX8M2oQDCljlIgU7
	1h/ECPhjqAEvDWyeEsva7/Dqm3bkJuEZ8BEltzuo+UlAzJ4593fGB9VUX0mv8w6Z3S7okZ4MTET
	gbHoqDI+bh8pUn/0=
X-Received: by 2002:a05:600c:4513:b0:4bb:687c:4fbe with SMTP id 5b1f17b1804b1-4bb7837c4e5mr56003575e9.8.1794919189862;
        Tue, 17 Nov 2026 04:39:49 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:49 -0800 (PST)
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
Subject: [PATCH v1 01/11] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Tue, 17 Nov 2026 13:39:36 +0100
Message-Id: <20261117123946.668557-2-rofikcoga@gmail.com>
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

Document the compatible for the LG V60 ThinQ 5G (timelm), based on
SM8250, and register the LG Electronics vendor prefix.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml        | 1 +
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1ef..f8b34109171d0 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1139,6 +1139,7 @@ properties:
 
       - items:
           - enum:
+              - lge,timelm
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f10..fa50a81880f0b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -971,6 +971,8 @@ patternProperties:
     description: Lenovo Group Ltd.
   "^lg,.*":
     description: LG Corporation
+  "^lge,.*":
+    description: LG Electronics
   "^lgphilips,.*":
     description: LG Display
   "^libretech,.*":
-- 
2.39.5

