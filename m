Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574562;
	b=UD0kV6hNp9FobbyYebUf1mKiCDDP61EyZ0/Ubr/NQzngS1Ur7P5GVTxIr4fqe1khm/mh
	 9gRSuC1dvX1SB4GPWEzM7CJklJWJEGOJoGI9VBQ28Sg1+fmuDjGFYAW4akMsArN0LhqrG
	 cfwKVeSqx+C/8IuqteHPv54lKILS5KJiQqzMM+0KVQL2eY6Mive4UTa/z64xvTtu5yphX
	 m+m3/xL8XrdiSajj/slTcEVcQFYMvcoa98BoFVq2an8BtWCSE78a68Qvwc0pCibRyQqUD
	 1koUQTC5dSkNKSUDdkfBajqsBaSYVwAQbS7MQlaoD/p09SSNikUE70a9XDvqgXIXSWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574562;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IzcclkVTG1KnK0341G5dFq2gzXEaIhA/6RUSjtt6e5w=;
	b=LzbwHG3vPtcaSFk2Hc8jDLiYCSXOlqg7bqEGhqIr3C4GHC3qvmVExWNrXP8l8OVgQH8O
	 2P9e2lEA11SlXHQw4gVKgt4C6KCGf4xfbXc8ufcB3kBpmXuHE4P29n0ubBN+i/nztcuiE
	 RN+e6gVNzxlL+TrujdQ51+spSSzrdVMw8FWQEY9/5TwA2jW14aM7CCGAUaATuPhc7qwn/
	 Uya1Zuib97ruhh91M18hzHBpJdZo92TSIHbm4mmv+0M9CHL5hNnJ7lxPB8nsGoueZH6RT
	 hgfDrau6PmrlO4+xh7xnn/4xaH6jXkZmLLd9w5tJF+FcVayqm04OJeZQWbMG9lSq39A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FIEOWiWo;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD0606A6BB;
	Wed, 25 Nov 2026 02:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06AD0606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FIEOWiWo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795574551; bh=IzcclkVTG1KnK0341G5dFq2gzXEaIhA/6RUSjtt6e5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FIEOWiWoj5hIUz82R9dCcuO3zoHLnn3qDdDksuzw3kfh4SPtaThJrK3BnY36OFKZZ
	 RFXDfhdZmOe96EWeRp4PmSSqqJKP5Jq0bWPRVoDbppEqTyk1MqkOpdMVnD+NTOleUc
	 qpXeHKnY5jNCiOFHVbyl0ezOQdE2Pb+dtPUhmiYw=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574549tjxyx0iab
Message-ID: <tencent_091F19565BDF5D847E4F80BFC3A86DE36608@qq.com>
X-QQ-XMAILINFO: OaNVrcLgj+8PuYxdXA9bFLAW3kQAz/0gi/RjhTReY3xcbO97F0AOdXlx07qXuk
	 rv2EYfG+8DPpO3uHtYYhLjYwa3j3/0/FtW8SYht1pjIDEfC1A3xqcZ38eWUD9TJ35g6VqMu8hTPO
	 jPL6aAQ3OL0l836J6Q8+cH2sjbs4gg1yxZBO1uuXazN5b7gaP6newZBy9+ZWtiGodnw4TsY/ck9w
	 IeDQnSTBr+gI2J+4+Vr6UkcLbf52I1hIlwlZIY2FmAR0l36yr6ugtmMUhbl460ncRDdmm9M00c//
	 yxlYsdCCcN9zxn+wUkAQC4GVqBF6SQPsZuSn2EBN5hO+zePASnUjUjznmJIP2iBQ0Qey/Y6d/bw1
	 HVlmyaWon15+0SLXbrPKqyTkoDtpE/3iVYhwb2L3e0F66TmrYfY3XYAmtVVwc8uOwA+zXi+TjpnP
	 aIDkFn9G3/EzDwTF2Kyk7JHCRfkj733YwNFWRnGupjWeEFoDWAKXjxc18Pw5nAn5YZONRkm3UizP
	 XgSzwRU2otpJgeRaYBbEFKKYyKMtD2hEWwD4ne034F45PhJ9kPpqSLaUuO+Pu+9Ioqq3BnJ3stQ/
	 Ze6rgn0un9CxXJoYqjODK+YiJPRVz2KdBq2IhdKMu3rwlLAxN7YbLyCCAupAeaLv4wbj5ua8vPF9
	 QF8WiwH1ElSXmxsoDHTKSv6YZF4b69r/5QRpSXpfSx1POd7o5YVJnSBcUt0Fhkqj/2zwTY076isN
	 zOI5wfL+lZh0EccYyxA1dxgNijjrUmO2WN30KIvsLIzwgH66B4hXqp9WJKrvRL+J3Z7XPToOv4+L
	 vNt/L4K5x/jxeQgpRvfX+XtVg2faAoGWbWjXHvsRtIU95XEAxdDLEKl4XcM7sBibLpG/xotM2xYV
	 VoBN65DdF/cZQpIY7bM6IL9BNFTgf2SRBRDOYemysmPjJzbVD3GfJbzka2+0k8oWEeACJgqHO6Cy
	 xZWQgKgKKWrE7mqxxfYd1plC/qzlN7108R2Ki6TLAo3h4KxtAapKye/WbNwDLXAMIv474zF8YYjw
	 of2wN61mDuqoXOi87qe4wt1+SB5+GIjTtgI6FX04vnX21vulCTmw0DZT8sgUTs0ElbYMmQzTem8s
	 EAQVHOGhcVWj70gol578x4ZqrvnPO+xZRgxpKnDajFZ/g13mlzN6MucXCGbTVr/XBOITOjPqYJbf
	 RtvHCUulv0lzIGk9FEh4VJb21XVbALpQmnr+ZhxvNPzwMyYA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v4 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
Date: Wed, 25 Nov 2026 10:42:22 +0800
X-OQ-MSGID: <20261125024226.1293-3-3066883572@qq.com>
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

Document the in-cell I2C touch companion used on JD9365TX modules.
Many FPCs omit the interrupt line; boards may still wire one.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../input/touchscreen/jadard,jd9365tx.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
new file mode 100644
index 0000000..a49a558
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/jadard,jd9365tx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Jadard JD9365TX in-cell touchscreen
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  In-cell touch integrated with Jadard JD9365TX DSI panels. Many module FPCs
+  expose only the I2C bus; some boards also wire an interrupt GPIO. The
+  touch controller is commonly powered from the same rails as the panel.
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: jadard,jd9365tx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  poll-interval: true
+
+  vdd-supply:
+    description: Analog / touch power supply
+
+  iovcc-supply:
+    description: Digital I/O power supply
+
+  reset-gpios:
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
+        touchscreen@68 {
+            compatible = "jadard,jd9365tx";
+            reg = <0x68>;
+            vdd-supply = <&reg_vdd>;
+            iovcc-supply = <&reg_iovcc>;
+            touchscreen-size-x = <720>;
+            touchscreen-size-y = <1280>;
+            poll-interval = <16>;
+        };
+    };
+...
-- 
2.55.0.windows.5

