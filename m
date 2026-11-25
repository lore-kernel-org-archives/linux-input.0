Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572601;
	b=gWTwd7KE2NNduIGdL7dw9WIIgUGZBxld+7QA1rCdWkE0wdh8xDYXlxGhHpNph8Qy9N9c
	 DIpnS1zLOTW55uaB0relOCyYN0G/+yu2af+UwW8bf455asuleM1k8aYaFc4Jo0skTPSMo
	 LKjGDUAQutHqJJlMsCpfGKELPrvwg1F3bEdvqitGaJPTRQBq7rmhWCE+BUMxEt3i838ei
	 wQbMiTt+oAv+W/N/KkwvyLE7q28w+ffbD9vTWLqCY11j2cb0iaaXmB+ktGrVhASVIIsxM
	 vc1/oZ16J+u2/kEbFjclKr1csgE5TlCgTZIyA+yVHaekS2LPgIA7QmtyK/NI1/FLI8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572601;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TGjEVOz9fVueef26xErA2ggw1zdVMrWWFGbmy67BUbU=;
	b=rNE+5NNFiCUWyqAo9qI8Ua0oEGu1eVFuGu9E7ExP9iHwgcrXY9tE890l78Gb7uaxndI3
	 aqKZIGQ6K8ED1shM8oEBmSEzSGYieNkYQ8aRdFOEtFkJYJ/JkswKpI81BTokb8NVxvCzs
	 Yu7/cYhQQetWtrYNad7oh4Rc8HkHKDUnKerr+9xzvQsfD69DxZDk+k9gEIFatfbXZZwYW
	 u22AJ0yCnS71rQEvPUt0PVe9Sd1sFwc9kDz0AjlzOWIa+QsbzEI3TxDEKNuurgcFY8OKu
	 Cy9sv6PJR8dOGk39uNXWh6G20wxeY3/TnTaczNs1FV1VXs/aB/1FUtjyLgtrytjlZNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fHPMgEOl;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96F606A338;
	Wed, 25 Nov 2026 02:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C96F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fHPMgEOl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795572589; bh=TGjEVOz9fVueef26xErA2ggw1zdVMrWWFGbmy67BUbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fHPMgEOlsmnQhXv6kCV+L8I6fqsVWGJ/geL6a+AZybVEfQxIadH6osf7gMCVCtn6V
	 VXLRAXhQrog4JMNHN8nrZEEBGIDRTE2gaYJnisLKbGjE5KYQQTw2MTKxN1TmWMeuut
	 /EKKMxySpVtxW/4F8XvlGvsW5pgzvNgJYTxW1Mqw=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 26DABE38; Wed, 25 Nov 2026 10:09:45 +0800
X-QQ-mid: xmsmtpt1795572587t47wv4hn7
Message-ID: <tencent_EE81D0ED29E97716D56BDCF1A3C5AAE35B05@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7WDllietk6AzjKROc/mp7qE+lSzxrrc65AKKEBm5KCb469sDzHh
	 izgMo5uqOhpLmlLvfFjqPWrkjIV1VlwUR0b74uSvaDOPVJjyNjaMlAz+zPo+UHcQF7L5EKvSxE9x
	 +oKiu1k7Gge+R9Uu8UlR8P5+g1F9goq6126Ukns9LmGu077yj61eZcozdleUKwJOX73+EyJY0cS8
	 zuXnVRxz+hXZ9K9SkIqYmC+XvmTT7y8z9LD4OzmAQ7cizePdqe/QuDIaVQr46JvF9CojjKbduCUd
	 z7fMeERdibhbcUkDzfKlyixZrmZlGVruOkdRRrjkvmoab3y2qx/OxWLZ/1busQUdZp5MsSpgwToX
	 pDGMzCmj3Knzps2AEM6SZE98jfktW9ldsJmV7fmVt3r04z7DniLgcSwmActi8gU6io5DDUt+JLyc
	 yCdwKSKjHjwaFp+EAqn8mkVZzyb758vLkMY6hPIV+2v4BofEMjctqFC3Z5bea42L4gxdxNAd3ET/
	 F2dqJpzKvmeAa9bna5l+XTIPu8wvvFG1bXTAwg9k5oubMqiFxf9+8LqCIc83ubxy43pjy4vLntiz
	 9KOWp21PZKILBbc625bqRplFzA1JA/rcvvJ6eUj3mUSv+2rj6tP5vBmzNb3yUPxzYEOmKfijRuzj
	 dJcFP5gWUL+t+0+6k7CuxU1KmAlZNnXg9fxXClQWhxlBvN1JGrxfWpiaqrFUAIqAAlRaPItlJ8Si
	 zt+6dOY25gE/CRlzUFdJzCSdmuu/JT/q/71eD68R9yFbBNSmvIjk+dXfr5JmuvOrFeQV/tdkZku9
	 QKcX5UKu9P0OCR6cGUhMm5vSoh7Y9WCgDLQtnb1cPHnuuoQewoer4oVONmyr/vWsE9s2+w8RBq2x
	 DiRweVVFVaxTQvPStmqpDBk8O0HK+0+l5sVY722XHxXsMRt3A+IpkOlyRDa10Qj65qZuIxivncdc
	 JPqFD7eDn0EdAM/8uYo4WpPNYb0/zK41TAMvaofnk7vCORmEvz78IPn3zfcymiPUcQ7R3WI8JU3p
	 J1uQvo8qUiHyWboScWAU7J+U66GjeeR0CLf0C0cytTwyp85PO3Ctbs48Y6v17e/D+NHa66tA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>,
	Cursor <cursoragent@cursor.com>
Subject: [PATCH v2 1/6] dt-bindings: display: add VIEWE JD9365TX panel binding
Date: Wed, 25 Nov 2026 10:09:39 +0800
X-OQ-MSGID: <20261125020944.137-2-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125020944.137-1-3066883572@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
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

Signed-off-by: Hefei <3066883572@qq.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 .../display/panel/viewe,jd9365tx.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
new file mode 100644
index 0000000..1043f93
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/viewe,jd9365tx.yaml#
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
+  reset-gpios:
+    description: Optional panel reset GPIO (omit if board uses POR only).
+    maxItems: 1
+
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
+unevaluatedProperties: false
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
-- 
2.55.0.windows.5

