Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160043;
	b=ufIslGQsQ7My6RJAdJ364YJ3XH6fS/BbmQHcqONK5y1yfSEg2iIeNuoeCVtLKFZiVwtb
	 uKVWHhOEW8keEtj/i6gooDvyBqeCHLRJSTijGR6+c5S7QQe35Y8sim27pXzzy4IramXEm
	 oVxbtWDd41/lH36xLAKG/VtJYE8mCseFl5tmr0OIKV7T20mgN6zTeyud0ZrEA9jEWzQGy
	 knXMuBZ7RclgfHwAqy4Qk4c6oGf8fF13Q6hQi5px2OG+bq5OsWXQALuUyOfO8XvpX9TNG
	 PceGoVXyJDi2TBd1W3XksciCyz1MwYfX+mH2augBB8SLx92lLJ3aAII3nM1h8FXBzRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
	b=tUWunEV8ikUmuSdYiox+ryAYNKp+dWcS+x6lmScoQdKXbpE+KUq13tMlvslI8WosQix1
	 kOjnJSCaeViT6G1FihvdllCcriV3zJSCPwJWgaN9ytn5WRYzNl92adreQETPTB8MwFhBy
	 hCjzkf7ZwwYkVQmauJAOFNNFoYg5sjfFlSQrj69H8Y7BxZBR2e7hyifak3UUAcC8ShUkR
	 KLt37fsWcZ7n1nKroIBUBJlv/dgtkmYEUUkwrIc1u2eLUfF2tP6cqfVRZXprT0+eZFrCW
	 iCkk8GdpNiWSotJsoL2hCC5hIgPlrl0QYEx6pXCgwi8+jm9Fi7yOCTJWLkGXujg6kAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ac2qP8kZ;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA360A2629
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDBA360A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ac2qP8kZ
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e47347279so295224f8f.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 23:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160041; x=1795764841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
        b=Ac2qP8kZtgMyE/fP0ZMJG+N+JUCH4QENZ/z1bfsgbihnepp8xs5U1n2OVY2dfM1Ybz
         8eL9nbD8ajZ4xAXX5Jyxp7gYiy00V65DPd4lvr1WAsKMEeB98T6LxXPRvnVJk04PidcD
         BMspLbHPsfTy2TciIM1ZHJ7Uu5HfkTkWM3A2FQpA9P4UW0Q85AQTlAkl6SUwwhB9HWp8
         weJ5Yjufokz1DfRsoI1HB09H/j4MHX83XDecIRETVHcTbm0Flzp30A28S4b52j3aC72u
         dZSBlUbcdaT92aiYk5uXidatSk2144fZfZpYQDrsaNhNQWNUGI7xQ0QTjNAeAlB5X3a5
         9nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160041; x=1795764841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
        b=YJuxi5jZsMkWpmqt/3tnswXjS9PoF6+BOwOQC3l+g5ceO6osciyELJjq+aye6LyDvo
         EAIhpldDSDiqO/Wn+wb3Jl7c7+9/ccfXMHDVwPjb+WcsFSRt7ny6Bqo+G6hvQjfTLEta
         leCuGLTxS8JWVom2b3Epe6vyY9WaJ5yZ7MkLUynHRhcY+R/F6exdIaFFGuD6qYDBvlab
         RC4FxWYqaq30/5ixccvt56v0pbJD1Q4wmF80FfhkFV69eeNSlFFBLjH09rvcCFLLJ+1c
         26zghbOXgqIAlBZH+0D+qe+tjpTV7w1nHHZJaNXyFYLzKVh8dkfR118KyGFqa2f92WWf
         X3fw==
X-Forwarded-Encrypted: i=1; AL+hErE1z+FmGsA583H6QXmBV5ln6Ov5BnikUtRdjV/hxFuJpEgTArqMAevqXo4vo6wkcXgCb+PsVsIKOZe64A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CqW9IxNme7J9V9BHIc3+B0jcKL+VIBDwB4dPWIwHiAp8MtPk9
	6MJ/45BiaG8vaLnovFhi4BeREEI62oka4pj2byZL9zLWF0lWI9I2VE7c
X-Gm-Gg: AYBFou2r1G2NV+9uVn7OBt75VDrHOjHNWAvTbHkY3XFtc2HV0tNrGmgN6bkJBN3EPT0
	IL69ioXbo57tpV+0LMlGqTDHYXOdw68kCWtXpAIxigXiDX0MtU1fYSEwVs52XKqLygTgjvUNyoM
	2WBXLM/uVVMJ5Q2JPg0sNS1mQUyaA6/62ODz8RPlt0/RwcXiZHCbe8c3berF7GBQPT36h0rjF0R
	HoItP/FeEN8dC6u+NNUPMY2rFRcUlEdtAfTqvMJ8BurRQC8kHo59QER5vnPGjgn2FEYnnd/qpt9
	NwmqkxgOuV1LfSjNA2enahiBAybWEWSP0UoPa/qQ5g4sPuhJR8IvHGoDvuW2cQXS5/1BDZqReXj
	hQHP9wQhALZuQXFUtiIku76jSAz+kwgyJufDUU6tXFTsN22NW4ZobXF+Jaq9BeRvk5BkuPWOKDQ
	nfrCXe3Rq0vaEUQ6dQJnHdsHeOyBUr/40nUrcTKueHZPBDa1w1lLSbxcHKsSecAFsYplRX0TXAk
	KE5XR4s4OmL++usRb8gpdTYS/uSeH1g4nUxXS4NwTjxdaynTeL+eLKpLRXgGtUtFrg2uOTy9PCs
	KBYSUfJxm1BpjX9Ybz4GZQQVzGvMDsIlQV1HOCF5P7jBROAI5EtXa2WGeGsjrH66ei+YKN07tGI
	=
X-Received: by 2002:a05:600c:b90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb8892cb02mr41369415e9.21.1795160041183;
        Thu, 19 Nov 2026 23:34:01 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:34:00 -0800 (PST)
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
Subject: [PATCH v4 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Fri, 20 Nov 2026 08:33:49 +0100
Message-Id: <20261120073358.10267-2-rofikcoga@gmail.com>
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

Document the compatible for the LG V60 ThinQ 5G (timelm), based on
the Qualcomm SM8250 platform.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1ef..85635a871e7f3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1139,6 +1139,7 @@ properties:
 
       - items:
           - enum:
+              - lg,timelm
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
-- 
2.39.5

