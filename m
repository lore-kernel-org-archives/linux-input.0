Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574556;
	b=czlg++ppttlJrXx3/fdxlIOPZPbysOxowzkLw2GsnCHCTmIR98vgWn2T7pt21SGM33f8
	 ejSbamlNvHtyEG2TE+s3/b947NdZqA4NmXZWzDZ6uFLWr2iB/y3TLlRgQC8E6csJQGyOW
	 xwD3ozyYwuKv00BW3F02Tt+9qv7DjdCz4aMetDcI6Wki08HpJqlyR8VLlqD1pzBWnAT2h
	 KikpewapMs0MdqkIWhKAj/T3bPVKj0FQoylfVUAMwUlYtttKH4QqQSi42VFsRiPkxBgIk
	 gDMKi58+huUXDzWjgjCOUV7BqD+zx/TwjzMEk3rDXJscBPo4PuqD+LSQB8yCcc0XX8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574556;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zley+tZa5UBCEuXBe2RxpLK6JVeG8RJlYwhvm31EGek=;
	b=ZfSN8kieNIMjF+5Ruh46fFcpaxRHrOkwYmCEL7b3lqRACD8GND0BdHJX8jrmfvpvabwb
	 cPbP7BsQWz5vnH4I0goRwpxNefwrC/hvP8AcwMrDtvu+QA9s/ql49qYSQEH5reai0pTd+
	 bpTVfyoOIu93m72ngr661u5RvymK5/aRQtf8h99xHh7KFR2Bc6UAzLEcbDpthzytCeweu
	 16JmgAlHPzVyzQpJDEZZtrdOLoFtgbiJJUVha+4eIQXBy0cTZyCtLJr1BVJOq8XABg8Zq
	 XNUytPnFgMKQJUIkgNJTiDp7OsQXrAHzs+mWQZYKEsycWn0W+XbSrz0IFdaEC3nWtkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PjNzkbEF;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A07606A327;
	Wed, 25 Nov 2026 02:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37A07606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PjNzkbEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795574550; bh=Zley+tZa5UBCEuXBe2RxpLK6JVeG8RJlYwhvm31EGek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjNzkbEFfNbZW/gb0km07ggchSJWfMI5Cag+ZRIjJKybUWEshc7TjVc6WjVppN5zd
	 USPoQcTpBAPRUpG8kU9ffVUbOgX3pB9V3GX8eF2XfH1eRNRZdnjdTamZ6OdOyDQLtF
	 PTim8vWj0njQFPRYoUM0mggcPb6+NIdpQT1+ujHY=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574548td0mvfelj
Message-ID: <tencent_7B5CDF8F84744FFBBFCFA89FE3651F675608@qq.com>
X-QQ-XMAILINFO: Nmh4/X5oQWzAbzI4i6Nu6Jkn8vWiOLtxmN4EoCBsQtDez56ZTnB/e9aveeDdAB
	 2eUUrqW6Gv6GaDkki5415CQnHIueLDUXA2JPI5/2+fbGu1Fv/Ly9S/BucaaulMY6yPCwFjtIN5o7
	 b7kptzI/iyhUWNsghjVTS8OsHGD+8sBSkpdiEtpowR7s+RlCsjjcRK46nqnoQhyCdNgC3pSiN9iN
	 TC4VzpA2s2o8CKBf8P/VY8NkxBqHmHIhrXZPhW/qyCDjMitOFr2ddUiTvAQqrjUB69akIluy+tBu
	 H/LpEZjlPCn3fKM7co3BAJ0sBRBEv49ajnSVQ1Yr6HS2PrM/BLDq38vHnLCGgqa9gG4OxcIpMGx2
	 pr+Uf5y+2/vOI7Svtu/DR+vICwy7LPpJtTqbgXACPNRyTZbaBQadGjaTv4MiXjGmyy92M44C/k1x
	 uHD9N86mGox8RUUAm0swNZ3cJdCyE7U6JvJvJvj+rrFUF5b0y0+mRO+qtqmzos19WOc7HI0GjH8P
	 J+GweOm5zNXMLEV27kWYznSCpz+Dp1m5dDLFgCpsSCYow0ZH7un9wTHRSh3gJ/V21LbaN4OWroBP
	 w0Nn+14Y2lclLFPnNFqYRF8VXnJ4CzhlzXRQz1AUvoCJ/oe0JUsiG3925Iap+Te8n/88dLBPteDh
	 hRceAFsn6F6ScBIDr7alg8YfEzzJn0zPS1FWF0qB1l28fxspzx/Hn8XdID1ITMfroGwruPeqCcv8
	 gWMUoVrPIQbCGgl2yH6Mctq4avOfaojXB2YHY3ZZY/v8KXtRCV666KBG2g8C+R5WZhbtN5sE6JRf
	 K8KEaUSNv9vnmMVof3tnOj/vYMuF/Y9MiuEpYSXYiGpR1uBTtW3FFHIJqpvA4Nh2fSY6kGDLr5pY
	 FtL3Po8eB1AGiEP4CNyG7R4X6v/ZIHbe7NuLZy9pSy7ESWl13b6uOxmuZHmPKwUPBN9u0a5LYB+G
	 /h/zfvOG66ustLjdd9MG6D+UXAIManrWaJZRCgdojv4aYNVeW/Z9qdXRgTQdhhVt3eott0UdV0tZ
	 2njKO31rTKNnOHkoM1LNbINkqKlkqYM+JICerUW+rHTEsA7sBuHEkei2YWs/c6J/SqeeiiNjLm66
	 QaZGCMxEczWZ4+mdKrCtCZ/0X3PZzyCVlNmGYIdVnFyDCoZIU7IukFpusfKA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v4 1/6] dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
Date: Wed, 25 Nov 2026 10:42:21 +0800
X-OQ-MSGID: <20261125024226.1293-2-3066883572@qq.com>
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
index 0000000..1ece390
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
index 9ac7e0b..9135da6 100644
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

