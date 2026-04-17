Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011018D636
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776392358; cv=none; b=OZ1HlqF72O+NCoOmt/ejp6Pnt5vOv6rBcV6J540eeRZbmuc3k1tkfQ5mjiaXTG6sBAm4PmkDW2r8MvNnETUhMmY7fUGRXVO5ag2pdf8a+jBqoGliMOUJzSav3jnzjCR0Tpd7FtmgWpQz5TLP7lvZCFgZ5/Exk2AoYUPQwOhB97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776392358; c=relaxed/simple;
	bh=BO2i1/v+gTWrIcLiVciQV3wUwpKBs4fxw7jV5qK2atc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLbuqIZQN5liVdqesyMDYdIZUB3e8MxVwoNtDeMo4/W1CNmDonDF+PYIiynCgSlp99gLiDwmaXHdLhQQnU54BqRslH61dXZkEgctsmwg9T/DhwmNxe7m4gNILT2NlhP3KmeOoUuK/5rg1DsXtE9mTwPlm8708FOzQAOFOipVFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1wXakc9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1wXakc9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so678480a91.0
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 19:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776392357; x=1776997157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UG8pXz+YVfOJAlLhN292spUHd5vpocuDHEllV74RzpA=;
        b=J1wXakc9nowN9rQu/XyKbQemkmtz+NmL6BxgMjFC3Eq0/GTnFicO01cMReBfL4fVEK
         zVsB5Gc59QBSu4TOuZzSrUgitzcIS8IsbLUQAENU0cwImck/pX1X70/DUMkBeaR6qDLw
         fyHbmkc46RensyacCpopXoy5mokxepy6ihcJ/FAFzpjPO99kmMNA9x9rvi/PA27aqdOn
         nGhvGSSWUaAOMmGU2O3bdhMA0swW21AdGsoy4FsQfVXH/7eAFUG8vcTvcvgWdd/Tbq+O
         akztTWmhSNiN5+bCdd2sjbSbcRL+5GbpmWOvsk0uuj0d6/W8SSIZhHVPMs979m7MwzYw
         vS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776392357; x=1776997157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG8pXz+YVfOJAlLhN292spUHd5vpocuDHEllV74RzpA=;
        b=E2bEbYFGCT8MIHkNVNKmoLG/6glSYtneXCpH6tjbT2OCjZo9sEA4jDl2f6abJtkzt5
         aDnFbVfBZiUAoSDNquahy+qCkiRHWR24Ji49EEMrUL43QNzE6FrkwRMF13bfQzFj3Hi1
         ufRejgvomM6lraJsqUdWt7HpdsQT7tj4N+wd48baTpiWmhhIE10L/SraxBKsR7fpkuWc
         ng3pUp8lZBOnuNbbBbMCeMcRgjdoPhsKM74omQpmdUv5/DplPKskbRKJ7h03oHTWAZco
         +ubtblGO89GT9bHtYwMNk03VBAZlExzN/8Jw+TCFRaV6CJnS1GYRgQAA/eUWreBs+bDw
         MYYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CrTfduzp2gte2pWS4StpWfhWHLTygQ8RjljtFGmohKmhS21s3uJPp6N63WL2tGz1mZj7Xc7zsCe/iyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9WuMCmY351aXdJ/UsQD/uTVaxsKY1U+NgniCDaRiAsfFrSWK
	ydMOq2FkPcwM2Xron+RgMAA0dvlXE2IH7LAUwe71LkuD4Eftjas2jMi1AN+Pzw==
X-Gm-Gg: AeBDiesSyo/cN7FifCbFtdyCLQBmXb3U8Has0zreewzccj+KwX/o/A3tosDjEBKK8z3
	AGVOVQyEiiyMh5eVLvNr7+SCjUpC3P1qAMzOZsfPTqmSKmMAFG9L6b02bmc8m1LX1f0McsxV4EH
	+o+pHSMiXfrgqX5HaRGprfsceKIKEChWBD5xEfQcC9ciNXGytIrqM+YcRhpu6C60Uy6BMK+hvsW
	mWLFN+By/vAsNX720uwJUQzdJGbXnN4ZJdXD/0yX05cV1jqREjjWxXK5Q35Fas8TiXmn1awQS/k
	hcpOLeoDocRwVoqw2k+OTpcbh1tcT8sTx/YXjV5PgL2HiJ9hBBnLoGyhSBJv/W1CRJi2OPzjtyK
	RGkymODbDDy6TW72xJh4E2RST9FbCWy6D3GpmtIDf9JAbGjW/wMSaT8nqBStchVjZXavGx3EY2O
	uxjevDa0J4LuVDtWSkOEYAObIRlMW0RneTQN699OgG7tpwpLrjEdqp2FeRzfa+c8iiM20p
X-Received: by 2002:a17:902:bb96:b0:2b2:5168:2f82 with SMTP id d9443c01a7336-2b5f9ed4d0cmr4664685ad.24.1776392356836;
        Thu, 16 Apr 2026 19:19:16 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa4f092sm2755845ad.36.2026.04.16.19.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 19:19:16 -0700 (PDT)
From: phucduc.bui@gmail.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	lee@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	linusw@kernel.org,
	zyw@rock-chips.com,
	zhangqing@rock-chips.com,
	gene_chen@richtek.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] dt-bindings: Remove the redundant 'type: boolean'
Date: Fri, 17 Apr 2026 09:18:58 +0700
Message-ID: <20260417021858.6582-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The 'wakeup-source' property already has its type defined in the core
schema. Remove the redundant 'type: boolean' from the binding file to
clean up the binding files.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.yaml | 3 +--
 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml   | 3 +--
 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
index 9bf07acea599..26ea78df27c4 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
@@ -88,8 +88,7 @@ properties:
       - 2 # ATMEL_MXT_WAKEUP_GPIO
     default: 0
 
-  wakeup-source:
-    type: boolean
+  wakeup-source: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
index 0676890f101e..a58d9455a1a5 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
@@ -44,8 +44,7 @@ properties:
     description:
       Telling whether or not this PMIC is controlling the system power.
 
-  wakeup-source:
-    type: boolean
+  wakeup-source: true
 
   vcc1-supply:
     description:
diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
index ae611f7e57ca..ec0d83220527 100644
--- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
@@ -33,8 +33,7 @@ properties:
   vbus-supply:
     description: VBUS power supply
 
-  wakeup-source:
-    type: boolean
+  wakeup-source: true
 
   connector:
     type: object
-- 
2.43.0

