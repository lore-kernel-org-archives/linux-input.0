Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6334AAF2
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189262; cv=none; b=ZfLaPOLFb3ovLb+wQK2e6/pn4tmSzeaYE20OaqU/7qEYMiASC0aVa1mMEX1JN4T4qsA68/8uNqRFiHVxc0Ml2k3ouKsMmGtCK1c+k5fRoSBBf7+cibGb+MTz8I1tU2WJ9V/5qzE0QVLF9FQ10yAM5Tj2bM7cXxz6HqKVrd+sR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189262; c=relaxed/simple;
	bh=Pid7hTafOZC+LLrMLIawjf+RXr0bKIf4ja36qYzJILw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgBarEFma5SD+qpy2vuKUszgSndj29lehJpPccMruLPYw5PNxHbX7vOcQuzdF56GyHlCUS4VE15yZg8SrYvPA25eOHEJLI9RhWsHrcc9bSbVYJrNCwlQXaO1gbgpqfvtNIysS1Im/VgBsI9Y5fMj28ToCESkks05yC3XRMhh4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q538iIiJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q538iIiJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so961138a91.1
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2026 21:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775189260; x=1775794060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DEYIJvEIn0om0NJGkMkijlcVIHQGMYf7Ieidykk7GMQ=;
        b=Q538iIiJ2tRsFhidb9CGbVK2HmPi2OxOEZx7kirEqbVcjdWqhXucZMVYUwEACN2cMD
         voEJjzJhCal2W7VySnNXdUKE5DcQD1PT1L+eday+AOAmRWY1KOrFGiDCQ/BCUT00KEWs
         tQM4mRb7/40pIc3wUMGKH3os5ZTV0bB5kTvXfP+AEUz17zHgw37THlVD7h+ud598IPD8
         NEUO5ef3zscsUA5mRFQKdlVKTKAsTcQJQj+j98QPQNIl8iEDOOXevFPr3yXhP5OTpDZE
         ddmftGZbt8Qy+JFJDnG8E98FX1F0Twu3kyulXYSIgbGLRwF2Ac8W/q8k81AwQFW584F0
         U0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775189260; x=1775794060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEYIJvEIn0om0NJGkMkijlcVIHQGMYf7Ieidykk7GMQ=;
        b=A7G5uTLQdHH5y0yiiI0SllEW3a4EUOxW0ilBABqoVBzfV0pIcUE3spixcUnhivDhSI
         H/ZyTVF2YtTvkf/4uEY3aCKr8vryOBmI3gJ5PkE/q1xWtXAe7PAKepcDrbQznunwYKBW
         t1pB0bdqBXUMtpVQzj7vey+2tgGxfiRfQDM861Fg3hckXEIOOdsB2wYEKGeTMkw+6GH4
         AQ2xT3X4jTl+1pDxVVgpXP/LFs92ZndtVwrRQhSywbagqh6KatB4mCphYIEHYj7xmRJA
         s1ZywuYuTDmBIEnsALBsIUi6ICI3zwzwL2mUSELiNbL0S8mzrn3qFAEqGZwd4Bd0wc3t
         9hcA==
X-Forwarded-Encrypted: i=1; AJvYcCVw/BDoUIvlpE4Ses1ykXnRu5B4461jV1SSQziORURj/nZyyL2dlnSGpFWP9uc3suJQnTuV/mymTYQfrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YSpYWAhwVlPQ03E3DcKH0ULERHkoj3Q1d5Ep5ZAKBVxMVdWU
	WsO1OsIiXWpwlUxi3yowiYzl4ODcKGOi5esIEw390mRc+Orn/iaNP2Vc
X-Gm-Gg: AeBDietgY1+t6DtGEyUXKlOxHUlBiRIXGsZeXKRP4f5TbLim0i89nYxoSj/JT1NAZ0q
	aZEDrnK03skNYYh/KeoeBoD43b/4Svm4URgyRnvAp6/aSgZk0yCYMsx12MzaSGptEZpcJIaYZth
	CJtkuiLCz8X+45g5mz7JSDwuzXHwt061xiWeela12hxmH9xAc/EPymkOWGKp6Fw3Qg4yfMzAeDc
	MeKp9/8bQuGOk/LvCvYFSdBhigioNEApkP/N4g30i0ORYOLHOLspv+GXReqb2jC5wy1pHXNAavO
	67ajHL0F1tFMZ75s3IYkHbkRi4JOy8Yi0S21OYnShhEdl7nrSo6xpiSpPSaN2rhTd4aPkBZ3tjJ
	htu/IxZ585J9TmqiFdn1PwXqAreYgmPbZNhvjKDk2eurRYY0cyWy+F4ihH6vRJS8SuHjHYK5lGb
	FVHZ47+6qWyYDFBk+lpEtICTUmnBt4gCXA3Gf3Q0VKVcUrW5th/vvdtREVRA==
X-Received: by 2002:a17:90b:47:b0:35a:24f3:2c8e with SMTP id 98e67ed59e1d1-35de6894809mr1218653a91.9.1775189260493;
        Thu, 02 Apr 2026 21:07:40 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe977031sm9483779a91.17.2026.04.02.21.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:07:40 -0700 (PDT)
From: phucduc.bui@gmail.com
To: robh@kernel.org
Cc: conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	mingo@kernel.org,
	phucduc.bui@gmail.com,
	tglx@kernel.org
Subject: [PATCH v4] dt-bindings: input: touchscreen: ti,tsc2005: Add wakeup-source
Date: Fri,  3 Apr 2026 11:07:14 +0700
Message-ID: <20260403040714.106093-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Document the "wakeup-source" property for the ti,tsc2005 touchscreen
controllers to allow the device to wake the system from suspend.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

changes:
v4: Drop redundant "type: boolean" for wakeup-source to use the core 
    definition from dt-schema (as suggested by Rob Herring).
v3: Remove blank lines (suggested by Conor).
v2: Revise the commit content and remove patch1 related to I2C and SPI 
wakeup handling
 .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
index 7187c390b2f5..c06a85b74533 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
@@ -55,6 +55,8 @@ properties:
   touchscreen-size-x: true
   touchscreen-size-y: true
 
+  wakeup-source: true
+
 allOf:
   - $ref: touchscreen.yaml#
   - if:
@@ -97,6 +99,7 @@ examples:
 
             ti,x-plate-ohms = <280>;
             ti,esd-recovery-timeout-ms = <8000>;
+            wakeup-source;
         };
     };
   - |
@@ -124,5 +127,6 @@ examples:
 
             ti,x-plate-ohms = <280>;
             ti,esd-recovery-timeout-ms = <8000>;
+            wakeup-source;
         };
     };
-- 
2.43.0

