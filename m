Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C517A309
	for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773632791; cv=none; b=p0XwL/3Y/EGOBspl9u2lDkl6BuNDysY7dddjFCOFYn1gWquQGCgnsGVaq2+m2kxvnVj3820lXDwtC+iIflEgQbggcMrgMFFAZoyELA3V6aNH5PJ7W2UoKh0s/AqW06dFYtgzFeULNUsR2DM9ppmwtn5ryOVrNbgnMn8eZL2yVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773632791; c=relaxed/simple;
	bh=YZkTcOEjWtuGRM6CYLskTVAFZsX4Ijie5CUy5nq8B2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/LK/7wYRx4uLGQAx1NiPfvrNmuyKAaJzzpGHDcRThc+QoM9tA8Rqy5DbdvfFwYQEiVQRCEKmTyLOt2saQJ5f54QDCA1XduNlpsSHlLdRd6qpM4gMKSPdJUO+0MC0vXg1Hpflzu/wey0BKgrVMcwBSXxD7OKDRDryY2PZggcfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efGR1Mx6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efGR1Mx6"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c739561f0d3so2525721a12.3
        for <linux-input@vger.kernel.org>; Sun, 15 Mar 2026 20:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773632789; x=1774237589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiRDluLCPaW8AudHXl/ylAi6akXx9V35HuCJ2UwCo+c=;
        b=efGR1Mx6Gh6peBzd4+rovnfWhcQ08DdITGWoEATAOnmfiSAIjyJHdWLTWMUIyKyT6o
         KD5GIfD0rgYa2yYofAqfhdVSWJ7wnDtUZdGb4hsTFDPqVFn8HPt+PdEaZxiV0G858WN2
         /Fgr62WddyJQjZZsx0P6uW0SiaGHIhPfwOxObLs5htEsGmi5pyVUGd79SQt4qkWhjn4T
         UWfOmXvWRVzWFZRAgjlfUVEiMHb6Ci18VlCmO+XmazPnfjeTQPh8HkI46NeCQSK1YSq0
         hIRMAdMoQK+aEPQEP3aDv0C9Y0XYPEkCGkJqllVn5C2EqXyRr39MRvGeOiC2pdILubHq
         GdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773632789; x=1774237589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiRDluLCPaW8AudHXl/ylAi6akXx9V35HuCJ2UwCo+c=;
        b=OKtfrfwlyUvZh5Qj8uOxRSmrv5LDvpiuLpPtoOT/K7Q4dqhxzUSIvrt2kYBD09faPO
         fK6pW1CMlGSquIuGsj5zC+jnZFdEPjtu6+8BYGrqo2nKwpuK5MhvEfqEzk36eDnylMEb
         MxfbzRNQ2L+V1wRJsF9VP1uxQqIVZsqcxt63ouGM72Q5p2UZXhS5l91wwJRSFFQ6d6MZ
         maZV0iuCFYtmU10ENCqbjPlk0cPXpeprE4HuQNBMroESIoG++Uh6HcXtj1v8oF52pC7b
         ThNdQuoGoP/zeV1Pg3SwOkVc/4Z+2wHecW9etRMvA2AXYMfhQQsuXEh/F1B7HC8nvx7n
         EoMg==
X-Forwarded-Encrypted: i=1; AJvYcCXYZueW5Ko8qzqsas+JDmeMtxMWre5iNQCu9tN1uFG+niRNuSv9n6QDyNOq7oaZphd02w+vWf1P4Xh39g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3Fq1mSG1TXdvtDsqLH7j1qp9WGJXl7KDywe368JGdj2qNchW
	n/kY+VAZSLjJy4gVN5bzuC/uSYF7aSGcLPNPWOnoys8nHWEYrfBMo+vm
X-Gm-Gg: ATEYQzzZh9PqYpEgpRCCGEOyDBQuU5CqWaZPoiqZ6ZVHHYLNASGoNTScn2B+l0V3Htw
	1JscK8QavvXTBFrPYx7XtbazeNO6Hhlqh+yiY5V7MkOTa/f2dkVCoXjOVVQW2AQ+Jaw5cXhy0+m
	i/s2xijcW4e3AYlHR9RNVdA+d2Oh3He+REaLF4S2fB89iqPNerk/bkuFDExc9/Z9arTC63qZ6LG
	6RnJHSIQk3hSA4gRlMiiO3u6Q2RXmv+WZnBfhfB/4ihMelhCjKn5j0GgWMBMUsYzRgiyuKPI1dv
	8xPdt7thAteceVkPB21ff2ulLQ1fiY/zrE1zy25SbQM8RsQSvb2qAlFWWRH3QTMMERAsC4Q4h1j
	H9aYpPp7bU8dLoxVcihtYOzhCYaGfw29T/ePSuCC9aTBDtclfOJ9Yjpy4dz7In7fTGSMAPluwp3
	WWB6mCIpyDpIBNaLu8JPn3UoImqtSnZu48ti2OHDPsrJV16/n4MpmpKMfMk+yRf/9lMXxx
X-Received: by 2002:a17:903:3905:b0:2ae:5464:7a4b with SMTP id d9443c01a7336-2aeca9ffe54mr131666095ad.14.1773632789343;
        Sun, 15 Mar 2026 20:46:29 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56ea5bsm116068155ad.5.2026.03.15.20.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 20:46:28 -0700 (PDT)
From: phucduc.bui@gmail.com
To: robh@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	krzk+dt@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	mingo@kernel.org,
	phucduc.bui@gmail.com,
	tglx@kernel.org
Subject: [PATCH v2] dt-bindings: input: touchscreen: ti,tsc2005: Add wakeup-source
Date: Mon, 16 Mar 2026 10:46:06 +0700
Message-ID: <20260316034606.11304-1-phucduc.bui@gmail.com>
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
 .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
index 7187c390b2f5..c0aae044d7d4 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
@@ -55,6 +55,9 @@ properties:
   touchscreen-size-x: true
   touchscreen-size-y: true
 
+  wakeup-source:
+    type: boolean
+
 allOf:
   - $ref: touchscreen.yaml#
   - if:
@@ -97,6 +100,8 @@ examples:
 
             ti,x-plate-ohms = <280>;
             ti,esd-recovery-timeout-ms = <8000>;
+
+            wakeup-source;
         };
     };
   - |
@@ -124,5 +129,7 @@ examples:
 
             ti,x-plate-ohms = <280>;
             ti,esd-recovery-timeout-ms = <8000>;
+
+            wakeup-source;
         };
     };
-- 
2.43.0

