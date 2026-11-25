Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572599;
	b=MStV7Qyoy1oLdQ44i9CUOMEHUrIEiABquvSm9ZWCD3sYVOscw0klRmHHzxhiXkT5NyW4
	 NgFI8ltFfGV7Q0aXmeIfOx1SAaFNAUxcqJAC7n+bau/S0bhX73ntCmQvT/a6pdlgfOffU
	 1MlzcN3t48sUYn9uLejFJfSCPFxlwZGielLs25a70s/awUdMnzKckGbZrEMhNRKiu2t0x
	 DGu6CK4UStYOEThbnCBOVnGuvkUTS+qIwEXnbT1plvvFiGVvW2GOBEPtyiXeJ2gqZltDa
	 0L3i3aGDP/Ee5jZSyZiEDcS+Y0vJHfVQ7yc2/pMdUgF0KS5xnYfCYWZTAvnJIj4dpMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572599;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iU4bt9I6tvLuPr0m1wXBvMhKTWSJm8h+jdD8taXbWE0=;
	b=ODrlYoTB0fN7/eXAk3gdZMR1QZiU6MF0QGf4/zxjE8y4/JYhhTe0mLSx4Op5mT621D/P
	 sytRPTp0Fhts14maGNn+B9Cjhy6JFScjGDh9UsUgxjw1zCCsWJCSBEcbmkhWCQCDzjjha
	 Lk2tATkNsr59PANyTFeK0EAB4r9taouil/QOlWdXuRLFUhCIsHaEvQctN87ngxHhGqdOJ
	 Q1g82qWcZeg+x2orVqi/hLbcy9E4SfxbXO+SNU0BBb7c+HXPm3RulpeuiaCzcJl0CX69y
	 0z4dL+w1di8t0eKDwzTYAO4fCp38XrhUfoi4W8YoCYvjCDcK82C/4r76yuLLLiO9VUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=YGPBvLTy;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3585606A33A;
	Wed, 25 Nov 2026 02:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3585606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=YGPBvLTy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795572590; bh=iU4bt9I6tvLuPr0m1wXBvMhKTWSJm8h+jdD8taXbWE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YGPBvLTyFUTyUWSx/Bnda4BEpNsweHZZNtOUG6g0WHdRpxzxQTDUYWQOyaQvQEQr8
	 QegXG0pUwARcn/SCdCtfMFaXx0bb4FCKkxHwpmo5tT8bPknvoWRpYS1yElQnjNr3hS
	 4x75vjXPhm3yZNrOdzzzeDFKTger/s1OSMdklOwM=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 26DABE38; Wed, 25 Nov 2026 10:09:45 +0800
X-QQ-mid: xmsmtpt1795572588thjwzxjvg
Message-ID: <tencent_4AB695D7B71661EC93DAAF0E2AEDF8EEC706@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJh37UI3SCyZVOhYIoF8DLaCBGKA535Jk4cbIMwuz5ir2AYXCcqW
	 pBARt/q9UvxgDAV44DA/CWJTFaxJY4Rzbq3g4V8HJzYm252Ufd907zw3QTSrk0KKp5LlIIXnnyil
	 w0shYHbTe/XzcsNWGp/Md2miiFiUgLFi40ReppQkKnBWVmX79syU7ZXB+k+IZ7VX4UrnrVUf1EbD
	 zoldF98DqYcnuZ5lvT0VJbgy4d6d3HT+aapCX1QT8dRa/HR4zXi8RYNc/dpBjcOWCq2aqhT4QCYr
	 U3lF2EcgzlK3X9OUihyFmvnyZ9CK9fxIR18Q7QQFBYKqcGJ37BLyEfpnuwEjOCSsCpoMUrPo4SJD
	 AjNSvNMX1RBvEJ2lvet2JKIH2TIPEE8nyeRiq1tP5/SHM9KopjeSGSgSSEEDgCndxpAHmb+ZnjVV
	 iFwK/SE9xsP6YNR7L6GFl6bKXip5yFOSEwYWNQHlZ2UxFKJ4jTIuZK5xOiNHJoWIuAfbVDScr/pN
	 RDn5p6iDPzWpRJGKIL+zCVzjROmX4i8eyw5F3RSoesKfPmLTtSZmAF6lOqHryHLiNgcL5wsDh6RG
	 i9FIiIfqauZTPr07OLifym8PhxvB/fobO8hwObJiZkT92jlxI7qHn27/7Ac9j27bV6UOGwr0Y8/X
	 XC86UktD9IyhrZQOLJMpiLTpNXLiw7DaR4lFrfcU0oMjD3JLyMhqso3YiqyMVdlIAtir44nT/ua7
	 rwhFwzuPk97/PhL4oO1a1fnZHzPbquYZxxfFMdZvGf2xaeL4S7u41s0tJBoS+x3yPi17sG+pWtLY
	 u1jUV6w/2BEMu+Hvrp3hsGPyttE9ZqpQf1F1yc+6S3HC0LixP3zxMF5pYaSzJcxcv6crAwm0IT1t
	 ScOb4+32ZkyY1fwCX3Mno8l8CK0tDpHwQnvzT2tNrmiRmwIM+3w1MSM7pKXmDBDFJA9ck67k/ZHm
	 rpdx4SnSnULjHpW0p8ZRv4hkJeBfW0N1gMRZPE31vPgt2/hW7Gu+jWdk5eu3qU3hnyHsJ/reHIn3
	 oySmTQMLbGLCeFeg+xtTe0BFoM4ETkSFzOncdkVa7X0drDLM6uffZYSCAg4vZy1NnNc6vWbg==
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
Subject: [PATCH v2 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen binding
Date: Wed, 25 Nov 2026 10:09:40 +0800
X-OQ-MSGID: <20261125020944.137-3-3066883572@qq.com>
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
 .../input/touchscreen/jadard,jd9365tx.yaml    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
new file mode 100644
index 0000000..aaf2a7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
@@ -0,0 +1,64 @@
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
+  In-cell touch integrated with Jadard JD9365TX DSI panels. The module FPC
+  often exposes only I2C (no interrupt GPIO); the driver polls coordinate
+  reports. The touch controller is commonly powered from the same rails as
+  the panel; those supplies should still be described here when dedicated
+  regulators exist.
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
+  - vdd-supply
+  - iovcc-supply
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

