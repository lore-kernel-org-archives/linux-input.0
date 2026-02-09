Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD1372B38
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642001; cv=none; b=Vo2p9lvmQ+Tj6z4xThpN6oW3DuGl/pTkMcENPJhESYJfssC8RMk37WwKQ9lyY0Rn2vc43oFNZSQOtRdXxi6ew72TJSQ5OkNSo+xS2Pd1n6t43JPaxbrL3yc2PmqWiXr1j5L7bTfpzzt/6xmsPT3GSulQRoV/jR2EbR61ASQXBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642001; c=relaxed/simple;
	bh=878uUL8qoZSSKPLmPkqGsNRZPfYYSiCLIPK1SBRiT9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTE7wPzD4rVGyNL9jzFeBdcCFgCGbbTHdZx6rZXXHwhnXaxiSCsEwQPoFwVhFR+lxNMm1iJx1nO65srytPwTdJDMz5hD3SuC0JkG01NvRZEImLbN+KNT/5LZgCC5C/uiSWNGAn+5sT7uoADG1X3400pZfIs2100qNMaTKQrMA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=RLJboq0y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="RLJboq0y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so5828909a12.1
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 05:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1770642000; x=1771246800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5neBturV3EQdGbZuvQGl2q6cuvsiRZLWzYgmw9mfdM=;
        b=RLJboq0y41+2NSTxiy+QmmYHLGs6TgwthMnjSGBvhE/vWpuICLBtF5VpFyBpEf4+4q
         18zMTbXolo9yAfYlzQgwXh2auO3ab3TCcxqsjnyCBoMrayJjJLECwXTU/k0LFCwxYQgm
         gr0vKEYVm8pC5q23Mj7oDI4WN/7v2Ei9GBm/UmoDErVgvtYdIX54VHlHwF9o90f/0Upk
         cBpWXAEvf5dHmGN8PprUtwCqdsZIBM0MAqQMesaCgOxLc1BT8HkmFRj96dc5uLpiacOO
         7sQl/IjULIhDMLZDD80yjoo9qP/wm4AZjPh1bO11VqICVhPwd9gz2e9mYlktz3iKpvMA
         bghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642000; x=1771246800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c5neBturV3EQdGbZuvQGl2q6cuvsiRZLWzYgmw9mfdM=;
        b=Rmj1Xo6hRsHT58OxupRcmzvrf9F3GGwZ0kknktL/CXPZahxOu/lZHOq3sLTJHPuPfb
         vJlcE4Rtg6y33NKXVPkZKP/d+9LPO/jqJC5hFFXUSybwgT/iRE9Bzt2TPaDeqRMpTxzW
         dZxbAwsmnwiQFAYf9/painR8d6TDFI1J5gZiwwFWpi30PK6ZLSLuf7PleQ8fsm7PbXUy
         lFTUdTE6s+P9dwwP9yca0p8I0iV0woPZLV3szbNLOgI/hjeDgLMM6kapfjgyUgzLzW1T
         vLFEJCKIvpSDXq7GZVqbTUJoiQIA8UFGE5vksmxNBKt5gAoK4mUNtGKkuTbEA/fxRdIl
         BPJg==
X-Gm-Message-State: AOJu0Yy6IiGc6sZOTzdZNkIB53/ToHKxwK9it+1lyeZpc1L7CIvrt/N0
	+w9sjrWv7QboyNAgBpZKk5eVzEAYeZM9HB7JMouoH0dIKez6QmNG7i7mKKcivz9uJB8=
X-Gm-Gg: AZuq6aJ+wOP5C1s7/unhgJ0Llffsv3/hjI4rLFS5IfGDc5/91TNfCvCHbd6pBZsiIHx
	udTms+cXYvgo2Gnu1ml1FE/rBVguUFwbtE/Gw7x5UpWVeqxEPCsoHZsLhG6tE09VyrumzTbdVvx
	FMp2nxSuc1clRuBBeldYcqPLMoXiQJqJ0GTaQdFRf4FgibTfYQOQssWyrIlv+z75HG47LT30Ymr
	eAYZMDCy0V1RRmQutLCVkUINyucxNzu2w8MCOitsoiujyyNjDyop8wbHKNMAfOmMbQbQQLKwc6N
	P/7vJmk7Fd+lmZmKAx9/xhrSvZuO9V4mG/Bh0XUhjxdYcfyDEm5rgaVq9CvgDQ40AGmb8wbkvUo
	q9mTXGzI7lMiY7kh2EDNCTG/R5SL7tEqXeBrQTCJNAVLC1bYrdDr9H4td6oQYykKmbQTqECoYHt
	ZtemsMIvJOq3CSOb0TA5/o8oFKY5PHSbAtfvz+r8zdGT43Oi+JYPmyRBZ0aOWyOEX6A2wQIg==
X-Received: by 2002:a05:6402:2688:b0:659:387b:cc32 with SMTP id 4fb4d7f45d1cf-659840ba158mr6302350a12.0.1770641999875;
        Mon, 09 Feb 2026 04:59:59 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65983ec70fdsm2803040a12.15.2026.02.09.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 04:59:59 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 09 Feb 2026 13:59:45 +0100
Subject: [PATCH v3 1/3] dt-bindings: input: awinic,aw86927: Add Awinic
 AW86938
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-aw86938-driver-v3-1-5c79cff30492@fairphone.com>
References: <20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com>
In-Reply-To: <20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770641998; l=1105;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=878uUL8qoZSSKPLmPkqGsNRZPfYYSiCLIPK1SBRiT9g=;
 b=sBbu18kdDcIqMf3K4PzPfTpAGwv5KBM7oxxjJvJeiCRFPcMSsMq9Y+G1WHeYw7/eW3C/OzIev
 FeueiQtJR8dC2lrXDF0kvVjOT/YBuPCWPuoHoztCtPsz2IGPzEv62Ah
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add bindings for the Awinic AW86938 haptic chip which can be found in
smartphones. These two chips require a similar devicetree configuration,
but have a register layout that's not 100% compatible.
Still, we can document them in the same file.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index b7252916bd727486c1a98913d4ec3ef12422e4bd..bd74b81488f61d72b675b5701b321b30b3430be0 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -11,7 +11,12 @@ maintainers:
 
 properties:
   compatible:
-    const: awinic,aw86927
+    oneOf:
+      - const: awinic,aw86927
+      - items:
+          - enum:
+              - awinic,aw86938
+          - const: awinic,aw86927
 
   reg:
     maxItems: 1

-- 
2.43.0

