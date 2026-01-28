Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0E30CDBE
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615486; cv=none; b=CfpFrmom4c4L501oEFnJf2jHJQ/g3FC/AYdmpGWuYKRHGD43K0d5PPxCZV2OKbvLav+YW9toVgh/KFUJq7tuSURMaYGq1dLisXeI/+BcoDYF5y7rH7wb8BhBLUsKYQNvjEDJFU6ocRGk1mQWpLXGo4J2fF5r2soGOzMRFBFyp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615486; c=relaxed/simple;
	bh=UL7oG9FT+R61+JPV9a6SqQpi6w6GPW9Vnjs6JNCt/og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EY/TCO9A/VMjD1WpKoootFKYlHEGXrZ7PCTW37oyLU0+O7cOQGgObviUSaK/87bIqIhFWhFL0GucfWK95tFbT7JySQo05wXAUYulMkVV1FDuwL4+rX5G0TYkoAhIn13TjrU0anNZiB/LUgIqGGLEwzCTZdTIm44Gk1Rlm+RnfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=M1Z3iG+N; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="M1Z3iG+N"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b87677a8abeso1062754866b.1
        for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1769615483; x=1770220283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxosYBC+jkycfgMD0yZ2twi1arJ37bFp4Lz2LJNYscE=;
        b=M1Z3iG+Nh+1QJG9YjegV3mDd0y2f/eABfzlHa4JUUHLmNc8JEDchlSBY0/cP8BPl6P
         /qQyxh7zaszqn57GTbUaunqRuPbcNiCFDtT4P96XPmFesRMiL/gmsGOFmUP+ra/JwM5N
         iiepMFobOHMtFJcSpSB31uEKjE5aEr/rcyeJCe8Gr4nLAArM0HaTJQ7FHX1w5M5vziHP
         e42qKj4qVOt1p2KBmWiES5WeQsGyENQHzaNF8OqE7KG/wZQAEroovDHiT006YBvkIqQF
         Daa0kcTyZLiVqOT5a/ia5/gKr8H5dWGFl3Shqs3wgSw2KvKPs+W3cVR3QGxEG/0SFpo/
         5BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769615483; x=1770220283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bxosYBC+jkycfgMD0yZ2twi1arJ37bFp4Lz2LJNYscE=;
        b=rz3XD99ec0Dj4mR6/FjY9kMoYOkOyFAF71mOUeH/04CmsnQ6FhpqvngR8zUsZZDMLF
         njY8TKs90zELR9SjwbsHgV+YFQAhfzZs+m94twYDDUxjPAFhR0TLl5QIx9eCt6SNdVwt
         G+/S0PqhpOIhsZ3FB61nNno+IiJe2pbGI6T1k7AURJwVBslgDIORgf8y/8iKvKPLP6ST
         GGFkh+c/qwp6DjGOlzVaOIBoT87fkd96D4o2uEwRyYmZ6dOqhXcqZyHgkP2QE+Cn5STc
         jPPjbHArns0jqsLYiC2s29mVItpj/OjLlRlRn8USvCh2Ykd498YMhvIDWvrJHWZC/KDr
         kkDQ==
X-Gm-Message-State: AOJu0YwVdB82pB/+pktj6tH/rZiKMUqnuWG23N/b+Oca4PNXFuZrMGem
	+oaUFBf1crkLkRc5hknOMwdGPEGAZPpF+CvsA+Js2mfnfoYio3i6V8M+0SyL5LHgoUk=
X-Gm-Gg: AZuq6aLcASeWoItmPbCNIQISbRiRdETSYfuQzxQnbGl0lvuii+H5cPbbjN7sagJF8vD
	rda69JLpARq6oUIVGJqqZZc2fkdR58Q9tYMupQllHXn1Y/cDVJtTYITPncAdP9H1QvYOguPHdmh
	i7B4C4XqMZvvZ4F/4g8xWfnBT9KI+m1Y1daaAYjtt7kDg3YK9mPuXaZipHlL5A95/dnIJe7lsrK
	ziXjVHwHeFUSO9w/cdN4JdlHJ7sdWhZApU4SvpO6AXn+P/C+kIthgPwprUsKc6sZHTIw6trb0Kb
	3g0MQXKj0PcDkcJm03Z+n+D9oqt+7SWt+YaPIIeUzbvRtOe++awXkPa1QHfeUZsvctq9k4hNBl1
	xDNNvetIEuK8Dk1e6Qh/D/sfTX7zi4MpSDuUUBVZmH7UlJuEPRjw7c+PTwBXXMqOlSUzNaeZ98d
	rXrMywBG37AaSWn3hJVysDrmoHVh6vmkSt7vCwsm0h4fopg9WKDst2RGlNESMZ/lvWczmy
X-Received: by 2002:a17:906:2083:b0:b8d:c364:5e28 with SMTP id a640c23a62f3a-b8dc3646fc5mr124941966b.63.1769615483312;
        Wed, 28 Jan 2026 07:51:23 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b469eb9fsm1727223a12.28.2026.01.28.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:51:22 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Wed, 28 Jan 2026 16:51:13 +0100
Subject: [PATCH v2 1/3] dt-bindings: input: awinic,aw86927: Add Awinic
 AW86938
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-aw86938-driver-v2-1-b51ee086aaf5@fairphone.com>
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
In-Reply-To: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769615481; l=1012;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=UL7oG9FT+R61+JPV9a6SqQpi6w6GPW9Vnjs6JNCt/og=;
 b=aKHTzT/lhB2bB2KgRAkb3dRYwVVJH10iCeA7sSYkoE3JdKHSQdw8kEiu1ul6PCRgbkNBJqsXZ
 A2S2CW4LHrwAxFJgRisWsUq1kJQKHfvZogbAIpcZgIyfxI9T8OLfGx4
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add bindings for the Awinic AW86938 haptic chip which can be found in
smartphones. These two chips require a similar devicetree configuration,
but have a register layout that's not 100% compatible.
Still, we can document them in the same file.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index b7252916bd727486c1a98913d4ec3ef12422e4bd..c3dee660422192720da3cf63851cea27db819742 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: awinic,aw86927
+    enum:
+      - awinic,aw86927
+      - awinic,aw86938
 
   reg:
     maxItems: 1

-- 
2.43.0

