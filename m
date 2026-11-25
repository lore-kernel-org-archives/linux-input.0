Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574564;
	b=1MkJ1sLmkPKeWd/pdFdNQ2I1pCaWxEdOImsxZTuqJ4J3vMY1WNeit4/9OeMYBHtvFg4p
	 2QogIckXU77yts0PqUQL8ve02AoSdOn2sHVuHa8etineNedHAKA2OEAUao1/ZpjpLRIeo
	 FfpN5Jl9Kga1wG3z4cSJgejjQGThFFs86GibQ8S6uruQ57s7SrX/dplUcx1y3uL3z5LG/
	 r+9/m1l1UcF6+JrPxz5mNBLxp/OmoQ0v1QZezqsOh/cjPXLRefQ8IR00UQVC+J+r4+pvm
	 fdJrPxaaxCUM5p6Uu1UFhYB9JSLZc8yc5yewvb3ZsozXbScllgiwz3BUHPEx2j73v+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574564;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o2ZBOBSK4J6IpmVXYBOJZpEDX+16cuL5L8cVT4NeqK0=;
	b=PGBTcg8SlkcfUcHUtwQSDMzveuou/iJUQ6G9nJc7hXFFIyEa72lacxqy2mocD+lg4EH7
	 EngrRn4mB1Wh4ZBk5T3WWWLD11YPntlCubzj9Zmsw7uS2Tc42ltfvDyVRsRTwueGRnTv8
	 TIbS5OtWvxkfaeBTHCDc1SQfrQfuYCn3V1vdRtpS6oEZEUkXvYltPUxRwPAfjuCCqqtRW
	 XxZXaSsVH7ZNPOI5yF8CDEosMQHUsyx4jEOczVMNZ0GZoRBHAqyLzr1Li3MSRWqK6ymdX
	 SzQQkCYV3rVIWMa0OmcgiRRoRqj4HRy05sCNoTngAqSpAkTf6DTncCMuVAAF8lvpSqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="OfmTAq/h";
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE9606A33A;
	Wed, 25 Nov 2026 02:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FE9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OfmTAq/h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795574552; bh=o2ZBOBSK4J6IpmVXYBOJZpEDX+16cuL5L8cVT4NeqK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OfmTAq/hSZktBWJJmk23Z6EkJvP4bDGrZj5BydV9eVSJ7QJyPqxxCKWfqP292eYQ7
	 BfuMexWS15UrZIDkywllQKX9Wer9/lqb9kJiR22yNMAUhbTjL5tKHLQgoRnEPrjPnV
	 aZ8Vzavf/oZh54XSpXui6YDMryy5ZdvF1v7THy4E=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574550t42d4g49m
Message-ID: <tencent_65A800E3961F185694DF3284554F14BFAD08@qq.com>
X-QQ-XMAILINFO: OZ2MtRmBbS53QTDtoG5ja4yZCowRkSPMV0ca++xAPCZicfMbsGLt0mtfiHI0l0
	 P8fziz7431EAbSkLp3CkSId1EGarw1icPIYsvmAIneV6NrB/r2uIZHog7eSWglwKDSHQJxiOouVU
	 CZgF5WBXuFv+WUOOPOzkY3zL2JAFDwXpqnkydbNOEBJOedEFXMlLayOgnyK9jTGKZCZYmwvCbFrl
	 Wu9Ct9Ko092srZiSUrK4pJgmvnohLlznQivhwTy9SfMQmblhWwwbNooiz4v3YDjLWgEJjQidBmXA
	 rX4j7+a3j2p25Vv9e3gvpIvx4kZLlIU5NPW07kDfWNR/+pUwomgfO64xRuIGHINuV4/xoi8JZcTR
	 foOi+9Xlzfz4lgOJFzV5QJWpWAuQVAgK71yL/7C6C1GDE6bBHCp4M+DVP2WEiTFkeXeRvklN66NX
	 lZcVQcl3RTGwLsOvQZcvKHRuB/9PAx1wrbZhYC4IBmKTDgzBQOdwppYfUiW7edN/UFk6hZq8cZ2u
	 EmxxsDljrsd0aHP+UXk4RQHNbTuZAzmwFV0fY4szBF0K+2rTWRhSTH5MVlkpscfRaBjUTaMwi86X
	 9IX8be6W/8XTsZRmOdmWvdOxbVxhM8e2i4lgPNG8ZFviajMYyUKAaKKzDlmxCjO9rRBwgFsIFiHA
	 q5WlIstrNeKXiAtAc0DrAi6okPhGTJNalAnA05UL5+bNahJhHQaj/vC9FhxtVZHr6YEAHVi8fuWd
	 L8we/qPa/uur2mhIVj3ZgI86CN8dbBRBNkkcIi7UKf6abVZsFsAXyWNxW/99cB3rTEDE/UzddrWX
	 +gh8010csdFoo6V6y960DkDcSUEOXuS6HLs+wC08uc+FRd3+vKIXq3ItfwgvtCOJ2GCQ400jIx1L
	 2XZg/7aSbaseGBk/bMqBfFf8p4OftaQH5ghWxS5f5B9yaKq7Uei8cnlr48B/IGZ64k+fpx/4B3p0
	 WrsAcr3iX0Fv2LYQh0AvqUe1B74UJS7aAMxOh0HMSLNimHkRq0cAwq2IIU4oQSE+39FUpbgE1p/1
	 TvUy2LTh86e+GsujQ2yCBV0aYNrWsrQtgAa+Biq3cSJeh/9gOvBoOqpxpFVYFbDmZ94PUbsDQ0Eb
	 jZlRPECH4oWH8SuaFwaSWvL64AVqH8dPdc3tiN7mPJQVPF+TzOGrgFHUVWpN6x5jg0O2MaGWWsNs
	 egAyr525SVseM7Fg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v4 3/6] dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
Date: Wed, 25 Nov 2026 10:42:23 +0800
X-OQ-MSGID: <20261125024226.1293-4-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125024226.1293-1-3066883572@qq.com>
References: <20261125024226.1293-1-3066883572@qq.com>
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

Document the I2C backlight MCU on the VIEWE 7KF82 module
(address 0x45, register 0x86, brightness 0..255).

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../leds/backlight/viewe,7kf82-backlight.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
new file mode 100644
index 0000000..e65aa4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/viewe,7kf82-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIEWE 7KF82 I2C panel backlight
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  I2C backlight MCU used on the VIEWE 7KF82 DSI module. Protocol is device
+  address 0x45, register 0x86, brightness 0..255. A discrete MCU part number
+  is not exposed on the FPC silk; the binding is therefore keyed to the
+  module.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: viewe,7kf82-backlight
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@45 {
+            compatible = "viewe,7kf82-backlight";
+            reg = <0x45>;
+            default-brightness = <200>;
+        };
+    };
+...
-- 
2.55.0.windows.5

