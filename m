Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572705;
	b=Uijj7FxxgV3Fs9ec3BEu3IQClFwEs1XJVqoDTFaTgbZdr2eWYFw2sMGy51VTdC7FeplS
	 DgYkk+keUOWlR08dxCizW9Bb8R9iYngSCSqhWfJK5JS3Es4pEkuLsurcqGj51jo5XbxsS
	 KPTKNMaJhiv+LJWH5mBQd0SuwnI8qGI9TYesY4JWVT2cAg6VkOccRo80itmD0VSyOd1Ey
	 FuswPDKTOiy0BV0mD8iNGidY1xTN5XWTxJCIIes0B+XJ9dZCazD2uFn5xEVEcZl2eYQHV
	 tJyBaakTlNkBGyB4bKX4Q24cbONoWVKNBxXgpjtOodpdbwDskTTGbaWVgPYoeedngrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572705;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8o2eFM0hEp3bckqxilWkip4AP0ZcM1uxjRx6JW35CV4=;
	b=BTgjzKRJCmWyMtKMH63HaPs5CDXFMPYWN1L8oOyuIzlDjOtK53eNSduoc0i+FZM51Srw
	 3lNk1hSd93vEK24WCtfOVejke8wZ14uJMGa9uX4AOYSza+mOZSV7wpnRMm8WvLo/tFVRt
	 NnEenF4XRjpi/AYBdaxTgJ8Bxynu4/nRrR5mtfpLRVSglYbCDOwOLH+8ZPX4ppKMlkqCT
	 SesR30W6jtze8UVlxiUZz8VWjcawIWDbUIrfkvHckTd2zZGIcklJe8HAFEvUVXYq4OgZb
	 l7Zjua0BCgkSRzH80tHyOv3XYi9Z6/XRFluMGH0uO+mG379qy5Ny5x1Xxbf5GY3meLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LwSqyR9F;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEC606A321;
	Wed, 25 Nov 2026 02:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02AEC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LwSqyR9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795572693; bh=8o2eFM0hEp3bckqxilWkip4AP0ZcM1uxjRx6JW35CV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LwSqyR9FinMF2GqLFeKIfBJawu578qDXFqpgOGpNAcDThJfsxf92O0FYdsnBnOb8k
	 MSjP7oa+ODnuauiMmafW3eGsDyo1Htbh706/HmjWEEDbhGEHOvL9bgxptJNl2Ks3D7
	 UuV2tCULHEX+ZQmPZ6+UAfMFheDLW4Nhhe7XAegc=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 2DCBA053; Wed, 25 Nov 2026 10:11:28 +0800
X-QQ-mid: xmsmtpt1795572691tyvcjf7qq
Message-ID: <tencent_33047574BCFD03DA2AE57B9890EB09FE7705@qq.com>
X-QQ-XMAILINFO: NzySSbD1GC1pcVD57Xnya8DhHHMG1EvHVQuHE+tByQDsplbVpFv95635k00Tx6
	 7Ltk46lYiNJjMJQ/Ae2T4zbFSjdvflu4hZZw2yjkaJalpKIWFu7ctbPPuR0zBnKwG9gsEjwtdvck
	 w/xajG1/trkDFoGPA8wCRSh90pSm9jja+dsd9HwTlwT7q8GF3PtRdGThvbAAUCMvNJYIYSYlUJuZ
	 qy0x8fmw8qX3UzBCQQQxaL1pA0VwB/JxRgcjW8flpxqolpFL7IZ0+jAQrDs/0dzmT0EcyQSlBAb4
	 rdD1J/Nbdgv084WH5iV5QrnxvJOK4VVPocaIig6hFMSDx/Qf54StdnBEKpNd2xWrWHXnm9Elnk70
	 vKLVD8mQ0XWZBy4TAiS0NJiVDZIUQ002D7GNCnXcslTw+7WXnjkCASjpooBcPln1w7NefcRNVjZm
	 1IgHYryL48cLNOIkFJEP6dHQh/KPrNW2GzePUjwKeQmfUZpHPz2MGGjCqmPuDw5VeGq35B7KMcpt
	 nkgPiOikl5Co87qBylIWwr63iDY5XAdj6Rfni5mR9+eupGsf1ifUM/U75HSIIvE46SkbL0irPRJf
	 ZdOXJt7bTHuDM9Ke31Jxh9ibCkmhfR1kh+py1tL1YjOdLD9QuYW3lxrywLS3ZTO5FEtPi0JUf42J
	 eezdUs5vKAtIov20MTZa1w+5g0X6Zi/VqeKhX0V9F1rNsSRmLjK8Bxdq16cx9GFazSf29NkfjgDY
	 vPVd/L6uOTuP/JnV7qmJPyjvY/9lAAS8Z4wjL8ehtwuGGC7t/IhjJppiU3/Gh26DEQYjiDo4pHpJ
	 m7hUA6IjoZqJoF3HxIftRe3roqFOUXmKHUr+43twyoEGzOwOHQFIyZyRU+ooRtfbvWMnzbkSEU8X
	 V2QAv7+BBZeD8Ikbnlbu6hACFx+HkOtDNbbmQwJs9Iwi/7N5oCrSMGR3pTQhxCvCTBFoKsWXcQtl
	 tzbpl7o/C5Idoxrs44Cw+VzJxsUJiF08UCL9LDQ7AN8UXPvC+FvFOuETwJzgiWyJmo8EWIzl3wee
	 0R2CY01c6gI+SvtLSyZJ5G/RSxJQGfxCJimwS/03tuAbdr/HobcYlxRlWE7q+r1wcrDTlNi9nJRW
	 ByVq1kBwUkDhwOk4p9/FWDMTJo8kJlVtunB8uZVtFKwcZqsQYLawDXc4vSt8ww2YUrUMXHIRa+JH
	 VDKEtlYoiyQVi6Ew==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v3 3/6] dt-bindings: backlight: add VIEWE I2C backlight binding
Date: Wed, 25 Nov 2026 10:11:24 +0800
X-OQ-MSGID: <20261125021127.1430-4-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125021127.1430-1-3066883572@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
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

