Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572597;
	b=qz7WnTpgGvU6b+r89Trh93cpcc1cJ+aCJI3iIfT5AIKNoMVS5I03stcLRaRqiLVui1HX
	 08SDagOeVamJ76t8F3vCcHZ/w0Fmbkv6v38WDYnycCp24LJFscGc06EHX/LqpyZUhTi0u
	 r/wz/RU7NuZ7uUIMl06xvcIC0RIG5QT8v+Eu0u9qx3mI3T3hysfUkpPROT9tptghEkClY
	 WFRMIeKtAAiHZT2PZQZSODAlwGgQ3tlE3cat3tpfoJUeXLsl2ZVW5o7FCuf+HGe4J1jog
	 /giCDLUBizM2soqxORXbM900uQ7fzRbZt7z6vgfRanxLtS9qH0GWGzrfiBJxnxv63hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572597;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/A0I+wcpan45woMkX4uzJ2M3TWJAazOrEZzPzUulK+k=;
	b=dcpm9TGCS81RGnba1jfaRZM+3ECOY2LyYQxaGzPIhTEizN/yS0qQCrbqaYTgazvRSVsv
	 Mh1UqKt9FGLOZV1VzlggE2uoROkCg1OTUeBWYjZL1mctLW4LSRORb1SIP0RF/TXWpqwgy
	 Vr5sKvnqRLekkBsZIRCyTmTqm/DURviUPNO4nAF3K7jDwFgqHTQgWYZXJ0gGoEUCPun8h
	 vxTOcgMTGwCs9hk8EiySuawE75Fx5g8P6UQvW5JKUJlztIz1piOZW3cUfkwKLb7jfdpO+
	 JvPnZghitJ6u24ZqGyYZIlPo653BHcvwKEl7fVvvhDpmiTr8okxVFMqJnPMcEq6nsUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RC4YZoBe;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E7606A31E;
	Wed, 25 Nov 2026 02:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 597E7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RC4YZoBe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795572591; bh=/A0I+wcpan45woMkX4uzJ2M3TWJAazOrEZzPzUulK+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RC4YZoBemSC8mZ9BpcvSSeOF3i85o+BWYpJT3x7P3b4zGy6EQxd2farfZaNhnFEJO
	 M4m3YhVUBqBbBiPDPTE5rQ7abhZr7zaQOUnOyV9EsHFhochgreniNl7tjLYoB2vK3g
	 DELDRO6HpGOZeTF/qlOzTiH3PzS4gwZiNCp0WqG8=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 26DABE38; Wed, 25 Nov 2026 10:09:45 +0800
X-QQ-mid: xmsmtpt1795572589t5v6awu4d
Message-ID: <tencent_655009C68D3E3EAD3EBE65084B9F9A7FE509@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTkI0+805OqHIGAezfjnZq1H9mqkTXt89sUnhYaqzb7AUYtqu3JJ7
	 jWJQf7kBb5YOh5mPUHxoJG8lz0brx+PsvWpmRzEk0pDN1bJQFBkA0uXbsCVXFq5Bp+ADBTBPZZgZ
	 vTwOHCcmBy7sa4U+PygK+J89cb9R2f0GDrpRdfRD7jUeqNZoY5DbOmZfXKHFrKtFEpVLsLjs5QwU
	 EfeXEUDzFBpP9GRtNLl/TbAKlEXwOfUpLiBtaeqlbR7IQd8uZjYtUA8NRqlyh0tBYp/ROz8FvYLf
	 GekVblTqAQ4r3JHJqyqjZpXcasjZswHiovkfiYp5turwy5LJiQByNEYL3jW5tLLPfBwErgaRR4lb
	 LnyC75/5t0qdC9BPhrPUfsciwJZIsISKeA0zXzxgv8x2BvsFXYpChLvHrpGJLu+fHKeForFv4rCD
	 PO5RONyw7tDPNpXqb4LnopqDgqSSfPOsEhaHuODWKZ8wspOQTtavltfhgwB2zWgm0JEG31r64Flz
	 1SRIrb+4ri2gxbb3kCUpXasRnmGM9C8mEfmKSUtT7W0jDwA08+ggdIVPlgnCkIclchNofVsonnwP
	 +5tgrxEy78ILTvLLC7VE4VDTSXdG6rX1Qyk78DuPMrAcRbScojf/ED4qzDSJd6Xzr0qNLEoHIpMO
	 zb/mZFA46ud/X2kOsEZ2K+gPLc05tWif5Km1ZWpjdveDBsEx7iJq6tr+bRIlc89SaLujhJkRSDvZ
	 T7e0ajF33J8rSlTH6h+Gwv7AerXU2538hxGpiwxlJ0xImtK7OL4z3xmQBx4V83lrgAeRT2D4SL+u
	 TPWF7olLC8L121AhWZcogurPYYp8GjEFHOXHRv+hqfIXUpo205zho7v3CZHqLDXmuIRM79Rq0vD3
	 9LE+ishs5k4tpOF1/+j0fTM5gw59Uqjrewo04Qvm4+0+1BZXfWA7RgbSWzh9hvacp+GL/b1Evuxy
	 7kXBPj/sZiZNnlzMkuMWzBo9p+OTDhiH2yWctN0X3q3waUEWmg6enwQf0eA66cGZkcXHFTBqgSNy
	 V/tAAY0kXwTkExbE3fBstVGmeHWd9BgL3j/r/ukpfcA6uD6WUOnq7zdXnWbgfOhD3FkkbTn7drQ3
	 IdH5Sd
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>,
	Cursor <cursoragent@cursor.com>
Subject: [PATCH v2 3/6] dt-bindings: backlight: add VIEWE I2C backlight binding
Date: Wed, 25 Nov 2026 10:09:41 +0800
X-OQ-MSGID: <20261125020944.137-4-3066883572@qq.com>
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
 .../leds/backlight/viewe,i2c-backlight.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
new file mode 100644
index 0000000..9be4bc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.yaml#
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

