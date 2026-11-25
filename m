Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602126;
	b=EAB/e5LkgDoSRes4QqW+FbZiEJ8/yWsCJwrKnrvkOU0a4PfkPy2EMAPEkNPQASTGXKtn
	 Kk3vaPSBJ6oOO5l6DTrMeOtvA6bppAnjYKXhe3zpi0EpDb0YCu+u2HHlqDYWaQCnBtQa2
	 t8240dKC+f7iEqQZo2F2m/KROsFkG+xo7NYNLJD1qdRb7HgdqEANkK9pINfcXhrrQgL6L
	 qCCSj36WzB9KhB8c2bBtvLZLDiHfn8Diut1ADgox7/55ehGpp96mNAO4P11rM2Q1QYby/
	 oYPMf+ELznpMSZYAWRRMiLz13fMP+2GstSbJj3fzDhOzF+7FxCIT+56FWKe8Lpbal7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602126;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dg+oSNwX/7p+WyYwZc5+e2rGm/goQ4owkA+4LHREogs=;
	b=1eaRUI2ai1L/poXYOPQjv85lAvc4rCRduqPV6ShWJQyMR681YHmm6YVkVMapVqd/oDm8
	 tpF43ju2xMNYHpxj1hMM4VguwYiIDPBtIBnU4l8TTUnZKxCGR2FWyG01Xgwsks0vIwWV3
	 hMHirFkni/62IIpXUMK3P8sArZ/QfEM+bqPBGfuF1JYI9t2fzy6ciDZtHF72ZoHNo0IWU
	 kYyUYqFJMgKTpcc82aZNJtGetuLw6dS5uNNGqkNgsDdRClJoBNOsbzK0/NbXO0MflR56G
	 /MvXSdiFZkw27rDw6sDVyS3+rHxWXPC3qRYP1bq/qZ0MuJOSIGWloEMVHBo7Aal3nWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=wcJtjNZb;
	arc=none smtp.remote-ip=203.205.221.239
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53965606A321;
	Wed, 25 Nov 2026 10:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53965606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=wcJtjNZb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795602098; bh=dg+oSNwX/7p+WyYwZc5+e2rGm/goQ4owkA+4LHREogs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wcJtjNZb0xk4Cr48Pk6IJauvMleHAtAjWLaOCwAfQsgeeJ8PUq/+ItMyUXluulDYg
	 f7RF0zI/RGn6snx51BKt5Q4w3+IyenbH47MVdNdjHKWHpJiVS6cwnzOmbk7jG59qrl
	 xyT1CAJK0KYaEWFOSc7VhSNGEFbxcxNDJ2B9hr2U=
Received: from HF ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 56009AF2; Wed, 25 Nov 2026 18:21:32 +0800
X-QQ-mid: xmsmtpt1795602096tbloeeaqw
Message-ID: <tencent_5FFF9F0A7E8550A3C6AB3F8AADF2BEBF0809@qq.com>
X-QQ-XMAILINFO: OTR3aNS6beOJbSfoYyCM72//7Yplyq+8+11gkEOvAcqmyqeb7gv7aGw4Jx2wvn
	 OqhWbWgpohuwmibYZTPTsLJVIKDuTY19QtCjzjaFEcTYpVf+8kdVhliso48MCajC9jXo+SnsLxK0
	 3tm3RuWXsjMBRIpy9pNcQj7/Lo/syren3Ce9myneQYjFjx/WaEIpKpGvsi9zchGh+UEqpJ8mWu+6
	 FvbCAd9W91JNUJGIlicwkZZkCjRZ0lj1ymLqzYW67VC3CDEruErzrd421/eajlG/yGxjFE9kF7Ya
	 C+pWlPwsmevTpAFYnNRzG95ZK9ZHFRfG/ruRzJ0qVUloIauq6/ly+hKfv33aE7ltTJlTzg/Yd5wb
	 yfCwwGETV0k+JVcR08TGhkHozNv5lA/zFHWDCirxuic3f/tK1ThoJijgnAY/6exSVbc+GaK4naZN
	 8HDtcqALdlafBc7UHuzkUpUEb8A9eSWGsvTMVwbL+b+h2B7Wll5oRMe2f+E0vRboWq2GeBi2Zvz3
	 Qnd/gFTZutMT2pFmNrvlZbeJnP+09i0jO7IrPXWQZBzGTeL6uLCMoHRlYCCK4EIhWdCuaJJX225b
	 TwK6uNq5Wix1Ne3M4oKofdV29z8m2CWy6e7kWJGKC6FOeR18iB/Ct4jwnXUC/awakb+G0BdDGeXZ
	 dh8vheM5EPvYWTt+xFmQoct2RxLAUk541bSU5nGtzEsEiSumGDIZcEjzpfFv3x4Cr98ZgpgNQmuf
	 PUHm2kjwfgWdm/+gzNTHWKgPTjuD/6ykmv5FACoZAUWkf72JnBhJIw3PsTukGKvrb5Ci1N6S9rf2
	 D5K0WrxdavraqVP6SusqF+HMidtU+RgY39uBgI7QWCLOMnejEEP+TWKY88boezBEnJDIYyQJSvCm
	 poacN8alshbxABtzCvY4T36YVo8kZRpVlhzQ6LjSUvnuZqjWBlg+eWbHyW3rd/aSzggyRm95x+fh
	 YHbhesIFyS5mYlEkOJ2MrmCwZLHzWYuDVbfycnd/4w6JZlOOG09ISbm/39ypDE48zMUUqfYsAtkx
	 qUYTBIUitTKwB/a3KVI1FJsBA+fMMI69Y26a5epFr0oBANxl6JQhMb12Ta8SWc2n/05IvxKXszXM
	 A71ZZ+j6lRFSvlh2jYQRbxfsrd5YfZOy6eOlc1VyVDk2vNJP3syplLxullvwWz35hse4ZhWjXDq3
	 ODWR6bhkqrhNt0Cu4/Fyf0CDRR7uarfPZ8iLo=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
Subject: [PATCH v6 3/6] dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
Date: Wed, 25 Nov 2026 18:21:27 +0800
X-OQ-MSGID: <20261125102130.256-4-3066883572@qq.com>
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

Document the I2C backlight MCU on the VIEWE 7KF82 module
(address 0x45, register 0x86, brightness 0..255).

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../leds/backlight/viewe,7kf82-backlight.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
new file mode 100644
index 000000000..e65aa4c22
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

