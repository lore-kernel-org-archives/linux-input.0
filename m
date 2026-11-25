Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602105;
	b=13UeiXZAvUASPdRUPFQhweVcWYgKUYTxVL6d/vkBgOTtX5s0AhAlCy/VLgWywSYRMSdX
	 uZxBbtE8uQxK3oLPt2TAPxGh65dpX3ChZkLxJmt5APlI97FjttXTmviDuhDfO6+QwUGxp
	 uiSKcMCLuQRSRaXnKllEaoFxHOIIX4XeYSFyziu6EPYsxJYWmqWzRqDJFdU3QYg/NYbyx
	 7QsHlTzqjMacGcpfrqc7juzWf2gZMxOsgBInPgH/QgTOH5lzHLS53SB0WgPnxD+b8G3Ii
	 nkf/E7u6FH/N4iDjZ1uvfQMpbJ438WwJtPmX165mI8WUPV476+idSSVUC/hcPH0qX7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602105;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aIpeZjTArpTO9hBQW2ZRDB+FyscOXf3k2X7KmsTeoNI=;
	b=nUp9a7oKIhPeQAjb924SrMrAycKQPssFpohfgFYvZVAVX5R2214+kEFqbPeSfC6jzo2a
	 LufD8NX6kvRxxV8uqPYQ65qObj6gPZCAbzuKYRHjg9HJVa13FMTs98A0mNHN+na02Uk5q
	 B6aeSVEI44LohQJh3RR1hqFF9uSbx1Z8Jcn3Y6ay6R8NQ+yHtf4B55O9s3z3C22lgElBo
	 WCjkJzsCRLDXJYOl1ikp4cd7lVnfnEA/waBUwSLQwdBWcjq9ADSWZ1kHOB85En+XaUhCo
	 euSPi4b2PeI/S6DYGfQWEP4G+LvDrsyenGx+zhQz8VoGb/LWuf2l4ETR3RzBHr4y/bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FL8mOuh5;
	arc=none smtp.remote-ip=203.205.221.209
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B927606A326;
	Wed, 25 Nov 2026 10:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B927606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FL8mOuh5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795602096; bh=aIpeZjTArpTO9hBQW2ZRDB+FyscOXf3k2X7KmsTeoNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FL8mOuh55BsBSQa4RfKqyefEeAvFgfxLyXyoYHsGfNavZi24BLhLUce5I6uC7mPpv
	 OgOa9wyGdz/fLaZmuY1kvjOgh4mJ9wy+847qmV85ny/jRbyZA4G3o0uK2htf7CuXEi
	 7GjSmJ6lYIITWcSYMWz43jbK7XOm3qu421RBP3c4=
Received: from HF ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 56009AF2; Wed, 25 Nov 2026 18:21:32 +0800
X-QQ-mid: xmsmtpt1795602093t3w1n9ww0
Message-ID: <tencent_74A87DE3061F575671DF6384634FE4BFF908@qq.com>
X-QQ-XMAILINFO: OATpkVjS499ujgVPpIcRVvuwvlWYOY/GTb8oXkt2fA7rk5j/u/z9BJAcpbaqmP
	 jW1WwfKEw8rc2tdbQj/Dp7FrsjV2/GNcZ7FPTmvcTxzbjyv8uRXqjrZWVNiYd9m75McOcOz7UQGd
	 y+VJe6xlz0p1ssY7nENJl1olMwDd/uYDe4X/Is73HYD3BBSlL6DZEqzcruGf1VIeNnssHqqQ3KCR
	 d2XIk/EFx2Pg+WJzQaSSn4p1QlwJ7hwcagzNBgCPg60izUnz/Sp1XBZ/67Y60hPzBqp2RJ3/1N6Q
	 9Tmc70beCzG4sZJ/STl0WppJvobSxwrz4gC5j0p/J1BgsA2yyfdU9w1hKGCCs6c2fwNmKYLM+1zW
	 DWhzNZDfRiL9WgxA9ZhLQvUEGbJXgBkLuS4tvt87tv1UssNmdeZq+K59n4WbUqgMK5i9/rZqRxW7
	 UvGM1eyBC2ms/k16o1Wi8kUvH7vE2JfJYQ7ZjE5usGvG7P+lzMRUFfXQxA01o+ttXYvbklDxFl87
	 anqtfS9e0nWk3c99LVp2cvOiWBwfbz2qWePWO33LBSTOrS4fH/Tx8GvxIUv/vGPcGzU4KSs7BfAR
	 rLf3CFr1fDrkXxTm/oMFhMBple85Xjs2oUA4wRczalaHa2WteRmGuBrpKusQKVQpZ4ihMrkkxuEK
	 6Z/Dt43SyZZ48YEs4CheAwTkDYwqOSC6ZChPa9w6HmA2HyScz7MpN2p4f2PhT5pELQud+J23lsUn
	 Csnh5gV591nNM2ATU8HF6bb5kt2f8euQeD/P2z2xr5Ir5+lHRyFZ5r9MP+8HPgclQbC+Drdsn60R
	 KXQp7L7aemDu9leenhPrViNdDWTdlsYd12mMF7vk55Xjfx1ChVn/2Liu+YHFQjcnLV2+TAyGJ0tP
	 lAKOjJzU27noakT4XLJywzTjFsiJR8jkgNbhM4HHzlVw3cn2JWYhw/Lz+E09iGJbqTrONWlocj9w
	 dbNbyLZ6ah5v4P2QjVE1Nt+SnEyFwX9V8fg6v+NlMCkSSX2EtSxjsFtpftCf4LuYWydD4ywbXxyk
	 80yTck/Cd2fLdxXJ55wK9nbS8sV1xPcN+5LlNSUCGuvmpodFpA3MwyOa5RfS3j+soTWb32Zqk/6n
	 w0tf70MSDfLEEEAqzID3uDm/vp63860n5to991GVPVsjjIpUiKB4N5AbB4CgKAvu4Hq9Kf75YrWZ
	 uzXpo=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	Hefei <3066883572@qq.com>
Subject: [PATCH v6 1/6] dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
Date: Wed, 25 Nov 2026 18:21:25 +0800
X-OQ-MSGID: <20261125102130.256-2-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125102130.256-1-3066883572@qq.com>
References: <20261125102130.256-1-3066883572@qq.com>
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

Add the device tree binding for the VIEWE 7KF82 720x1280 Jadard
JD9365TX MIPI-DSI panel, and register the viewe vendor prefix.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../bindings/display/panel/viewe,7kf82.yaml   | 67 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml b/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
new file mode 100644
index 000000000..1ece39080
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/viewe,7kf82.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIEWE 7.0" 720x1280 Jadard JD9365TX MIPI-DSI in-cell panel
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  The VIEWE 7KF82 module is a 720x1280 RGB888 video-mode MIPI-DSI panel
+  based on Jadard JD9365TX. It uses two DSI data lanes and exposes in-cell
+  touch over I2C on the same FPC.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: viewe,7kf82
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Panel VDD supply, usually 3.3V
+
+  iovcc-supply:
+    description: Panel IO voltage supply, usually 3.3V
+
+  reset-gpios: true
+  backlight: true
+  rotation: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - iovcc-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "viewe,7kf82";
+            reg = <0>;
+            vdd-supply = <&reg_vdd>;
+            iovcc-supply = <&reg_iovcc>;
+            backlight = <&viewe_bl>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ac7e0bf7..9135da689 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1739,6 +1739,8 @@ patternProperties:
     description: Vicor Corporation
   "^videostrong,.*":
     description: Videostrong Technology Co., Ltd.
+  "^viewe,.*":
+    description: VIEWE Technology Co., Ltd.
   "^virtio,.*":
     description: Virtual I/O Device Specification, developed by the OASIS consortium
   "^virtual,.*":
-- 
2.55.0.windows.5

