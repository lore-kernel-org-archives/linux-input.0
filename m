Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9557359A91
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448632; cv=none; b=u0W/DUKsUMcfYZ+JH2Y9rTI8L6FbWd1gT+iWLH7JdphoqFZYcTM1YRrAYhACrdJfYkaNf2tQIDZidKaE+plMveznp1aoHZxiJzgpGg+8c6sg1jBKW4jWjWDQoUofnd5unOXKA2eUN+0kAqXcL/h0QLI4z3n4hG6aORCi1VXlPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448632; c=relaxed/simple;
	bh=9bxMbM7mFlV9f4RAAhXlkjX34it3Khg4vmAogAbhbZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LH6JNMyUmYmzMM2E9o2/6ZDSLrf2TgzxleVNi4AGd3+iYb+VuvP++1F/lsdN8TB+DG2bUhKpfZye6Gl4WvXpS6DgQueoR8/sno+rJIP9RpOyHF2bHdBv49W9d4yb/FZv8fJVEK7vQWsn7sLxaHXIoNH2fAdxyV+4ZPaNNH1OiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jslYeGON; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jslYeGON"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b935b8dcab7so662531766b.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 02:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1772448629; x=1773053429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UXVi5KrGAHXfY9KZhVckbPLTWLOqhGUCqeRbt5GfFg=;
        b=jslYeGONl6vBw0Or2NFtX9gOwyiWY7DuM/R3Io28yHnmNC6aLjZ3e5pNv95BHtea+g
         fuOIhSHXXoyCTZWLt6Qdd04oDRo3O2Gwocz8ib7PhMe118BrWya5lbkMy+QUkOniNQE7
         LZgXOjDcdHXLS0EhCIbSoXywl124tOhG4OhNR8P09/mfQYMt69dyZFFV7GiXK3vb7ZB/
         cHrIM65UmvP2DnhO6wPqRJPO5MrAfjXZkbwQ0MBOKNBcp4RQofatr9xw4smFwcckfkgr
         IT7IOywN3wPjOIRWJfTAOL+mq95K9QYCPIeCCRe9A9Tor/T1tCoNRqi47A0VPICvxf6H
         We6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772448629; x=1773053429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UXVi5KrGAHXfY9KZhVckbPLTWLOqhGUCqeRbt5GfFg=;
        b=Mog+lV7SijMXTizfJafRUvPl4DlSDF17gtbnzHV+9c4B9BY6+DQjDgbFemylAQoQ2X
         wHAdEUVseVZ6L2o65/1cUh+IBJhXoBGQ7ZiA5lcBRWlmBtfp9QIn7UStJEBz0tdQ9O9m
         qwpOqdtX1zS/M1tnxI3sXd/5k0L2dcxcDKwBil372bOvm4pzyuo2/jw6kf+rf7odJRWC
         jlVvcnERZODoPtFFKha5bbDOYDEY3/YKumtfmjMAybVv6VBl15euC3g7jK8nSYLCfn5p
         R9FE1M6bFHzxiMFaxWt8uNdwwlfKwA7gldd+FB3GJbskqI7d6FZk5A2AYE4pN6SsRPeK
         +Oyw==
X-Gm-Message-State: AOJu0YyH0gVMdTjxWvkAdOJckdusY70USrFUjQlFK0Kc/VEiOcsfU2U8
	DVDpZEPFK3+h2B7wTx1FKu03kFjdB2WbeaPl3LG5ZARJRr/9mk8wPHUTW9yZfzqGC7Q=
X-Gm-Gg: ATEYQzwjq1HtLkgi/DS7RLW2Ky69PkXWNaLprxd12gUb9HPVHdr7okiN74kIxq7Ayhg
	JfgTsnLfYcH7IsizxQ1rQK4ljX4DiOewJvg1B72prPUpb2shPGOL/mW9PUfUbyDEyr18+wH4S2J
	fYKXXZG2QN3YyKD8iNsl1/if9klwkHxKUX17rOMEkdMtA67abShW9DoGe/LLQE/GYDOmlczEOOi
	+bw7iE6+cABnm2eiTuai3qdYSXEW7v3rbGiGnRPc0d0PU1bG7zZwNPgFiQdBvjBbMCs/tKfQ/mh
	4F7xn59tYGYn1ZFPd5PnyhykY+1zjXbCod5UJHQsWh0Om8R3IVFHQnhJTpAv44gFr8+jYwPUpiW
	tb+PVATpeHTUq4xROSunc3SNRzMbygMegNDOOzCo3yRyfp1AhrfojVfoaf7luS06GcB3U3gkoxN
	/hcQ6lktnfNjrfnWFgCgxUhhLWfbJIcryEqssQzPnasuUqntZgXeVSR5lYb0tGR12qXL4XcDECX
	QVMqTNbTQ==
X-Received: by 2002:a17:906:284c:b0:b8f:ae35:cbdf with SMTP id a640c23a62f3a-b9376554a26mr593398166b.48.1772448629103;
        Mon, 02 Mar 2026 02:50:29 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabbd98bcsm3511769a12.0.2026.03.02.02.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:50:28 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 02 Mar 2026 11:50:26 +0100
Subject: [PATCH v4 2/4] dt-bindings: input: awinic,aw86927: Add Awinic
 AW86938
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-aw86938-driver-v4-2-92c865df9cca@fairphone.com>
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
In-Reply-To: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772448626; l=1245;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=9bxMbM7mFlV9f4RAAhXlkjX34it3Khg4vmAogAbhbZo=;
 b=5AJIgaZcjs8SFi9VrDwLO0PSnG39onXqNSyDYMzkAUmALF7AjCnAqyCV6ybrB5ZPJyrm+dl1I
 fKjZReVm47/BoXuZYvdU46qqA90LpatPHk5pHPAEgYWYV8o459qyJTO
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add bindings for the Awinic AW86938 haptic chip which can be found in
smartphones. These two chips require a similar devicetree configuration,
but have a register layout that's not 100% compatible.
Still, because chip model is fully detectable via ID register, these
chips can be documnented in the same file.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

