Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80347CA6E
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396681; cv=none; b=NkuAVgXRMiTc/xv6Q4aPmf97IlC4SooSsVaSA9LrOMA0Bc7DWf5JTcZYYaDdZFERf6rrmEHPrPkQc5M99lvqDQnPx8jK+Zco/6kNmqb8aAr9oH9k13Eqw6Y5iU4A/ybjHjRO7pZSHEPG9QAVb1cQlCzosWE15wgGFFIyd6iH2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396681; c=relaxed/simple;
	bh=Xii6+5i2RWZ67oguwNdM+TArT/XjMPtr0J/Bo/t/+aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyInQzb+BdNjl9qGSWuQcNt0u9SLZ2gm/l7s9pT7P0wRjYeSdjGZTSu/8YIB3I8gmCgKGFG4Rx8czfcoMaTc/tY4T3qCU5rROPD6YbdJ8PoppLlImrV7K/8RzLpOSZBeOs+PfBcNKXqMEZLtDdtM98UuV4MwQmtAfBelBMqm8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=C4E34uey; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="C4E34uey"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so498480166b.1
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789396677; x=1790001477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UmWbIrFCJbcoOz/Ivl18PXQXGPM1nMkA71Dhun2P/WA=;
        b=C4E34ueygueQD2bAjMENdbgz/JdsKfVN6y4eP6zyCaDbg8rw4MmJEGiSvd8BDE+VSd
         a1GbcA1Y68Fp/Rz7fU+1nalqNDbF8OpsJM1DvAzHq88mi7iHeCuaBjQ+0+Q7sx3N/I8X
         qsvpAA8otrvpJmAXdDexEFck/F88J1upu3tCHdHHBqhjYPjPINtWD+1qi8gmf95OyVMH
         oQ4is0YQfEUVA95UK/BbZ3woeq4AkMpxPtRNswcOcMo62hfRXVbGF6OpOg5WyvkI4fls
         D18j2pgAJnM08bP93IUFT5minSI9Gf307NijwytlSCXz+vuRBHlVe5UM6shgRBIw1/yf
         BXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396677; x=1790001477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmWbIrFCJbcoOz/Ivl18PXQXGPM1nMkA71Dhun2P/WA=;
        b=IjRJsqEx7wlPhAWUkVrNY/6qwEjT8Q6DKEiD0sYtzaKYag3Muo0rpgErKaLJuSfWZQ
         FsdVX98Q0LfR+wVMLmYC8XOIy2S/fiQgtj8QiHJDzNZs6YmpQ8/P2+ijWrk/ZA4fqXGb
         D9Oxjoz+Tm9xdGgofp8Kji9dedr9cZD/D4ShQdaqT/c/8kGcFPUmXM9V2eUhWjhdNbnn
         ju3XKSv6nIHK8RA7DQ05NrnXBFzBtSPW/PTvK2KQrqqp1v+TdvoTWOT+OVJYJwSKP6LP
         hOLLtyFXNSTDWb7Tmc9ncESuvxPHhbc6MKNimd+IWA1MblCi/I8padm8Lojo87o1BB0K
         TOyg==
X-Gm-Message-State: AFuF++mjwbMSSNiKRgjxjtWn8iFoy+1mxes7ZVqGbffTK23SgPnXUYSO
	6V68iE6zMuZN/7B2JCNJgQEK4qpJM24J3LGpVY4LcF3WddKihjrSkKwub3yBR7bT9Yg=
X-Gm-Gg: AYBFou0s/fZCBIeK/ywTMiXbQcyJGy6H33QwgOh5tCSsqtlfxAI4BTd7oShBY18FM33
	4yIo4UbSJz/+xXrA9D5gmfZF5smqPThmjnu/DYYXWNwvEt52jbvpA+WYmVguOyy7QPfqcB1CVEu
	6nqSz/jvYoMFD+Q4zqaeXpt5kbGKRovvguNA0OzegpfbN0fp0DZkWBJCmj5+nLRnvATrvAU21ZK
	PZbyxYmL9KuhhB6IYs1vsm2CYvMN2bbUiYyokwvVo67YUBhxwzBUz/wpgJk/ylMjG3l5VwEl2Ly
	kGTX2c0peunxHZxUTt2PhU/tVFqhVNIkab8E0KWjMSz8GV3KkrZ3udA6TA4qbrdfznRocIu/VNl
	jaOYD0DqglE4CctpniMPBqbtSD7kwyav/062beQ7PDp5ttOuFfuVN9K6erS6vCIh0DFLXsQzD/5
	IAY0L1MZni46J7U4+13gKnQxAIx92PRtHEn/cmaXJjuDYiMwh5/z0V0vU2qst9y7G5WgqXtvs3l
	KIXbmQg91KxWz8zPIRQ6PmFgwdCOMo8V2NtauVauDnpT+08U9tcJK0GXA==
X-Received: by 2002:a17:906:6a04:b0:c29:6de8:d143 with SMTP id a640c23a62f3a-c29b865bb71mr184948966b.19.1789396676843;
        Mon, 14 Sep 2026 07:37:56 -0700 (PDT)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660b29a7sm449634266b.43.2026.09.14.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:37:56 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 14 Sep 2026 16:37:47 +0200
Subject: [PATCH 1/3] dt-bindings: input: Add compatibility for Awinic
 AW8695
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-aw8695_haptic_fp4_driver-v1-1-156f7549149a@fairphone.com>
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
In-Reply-To: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789396675; l=987;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=Xii6+5i2RWZ67oguwNdM+TArT/XjMPtr0J/Bo/t/+aM=;
 b=2s+aTG38QL/Spn6daVe9Zasok8uq+7dTkNp9krZfUHNNP+/5qMsAvuyY1kBqrIeztV+2URR38
 7g8kDaxU9xzBWIqs5SScJYV3ShRWxo8+oJ889JkjyAMPq12p3MpXVuh
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add the AW8695 haptic driver to the binding documentation for the
AW86927 and AW86938, as this binding needs the same properties.

They are not compatible though, because the chip identification works
differently compared to the 86927/86938

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index bd74b81488f61d72b675b5701b321b30b3430be0..d9da85499cda4d62f14f36f1ce77627e37e348d7 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -17,6 +17,7 @@ properties:
           - enum:
               - awinic,aw86938
           - const: awinic,aw86927
+      - const: awinic,aw8695
 
   reg:
     maxItems: 1

-- 
2.43.0

