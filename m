Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602107;
	b=yM3EQKm6eCFMzznUjHhbyq8z2CuNbUC/CVlv6vmjTenkIRizUdeS5a5t1+mZMILWI1gm
	 huznPzXgLMAK8D/kFo0s2Qm9ZhD3rmY/QxvSIQkuuRQFpAfnqrjKSDxh8dW4sSJqNlREW
	 GbP14gBguwb3Uz/YZ6rJ1Dw9sxME5BJLHA0+plyVL6ZLsxoZZ/pOq8DInHln4JU9V3cvS
	 kDh55g8pfawx8+HwpS72sJAxiAkTZpIxFZ4+9qgfi1noaGc9DC/Jd02VMUD2uxDaclj3X
	 oB7wUZyAuRtuK8hDmm8YpWNRKnIlYhMAtt4ign51ehjCFb0aZM6MGuq2Cxh2EUjPPSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602107;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IVcXtSmROoYy8ewp3anjYu9r3jyBrtQp7UnyRqwDipk=;
	b=RJZuxIwG87/F15HQxlHhsYNA47T8s3YRU8lG7O7dKpjWXu9FXBmpEQfarVQ/FQ+gjfSn
	 tpYyhfkGI49+ZrdpJfRUz6oTnWALW4m4tEhzdjhOd8y2NSOkkJoypm1LfFQmrqvPuGAuH
	 jNFbNWNk5vaoyeWgBazlUt0rbEYLpejiSE2QhMLHQyvAzko1xQX+eShmJbOXn9NklPx0G
	 RgDKRo1XIv29Foq3JJLPvsdpr7H+qFfvXXuNKdstvao4WPseZsUH9C2KhKHTVZGWWkqk/
	 9al3SLsbyene4sNKhGgjFaYUS1kfjMqBQLrX4KF5XiwAR6yANRuKiVY7Q28edKYF2CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Ni2qR9Z8;
	arc=none smtp.remote-ip=203.205.221.155
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F4606A331;
	Wed, 25 Nov 2026 10:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1F4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Ni2qR9Z8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795602096; bh=IVcXtSmROoYy8ewp3anjYu9r3jyBrtQp7UnyRqwDipk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ni2qR9Z8Sip0W34bM418e8vcc29r0xPdTklrq3xdVKbn4rszEuZk6p0YrxfGHWoSF
	 gEQLquNzZWOrvGNhsgfBVe6uOthafQnGr0H7vXtTJcxpx70hn0Rx5EUtNA9M2ntcAH
	 QAreajyA/jF5m7Jp6gEbb8QJV6RbQKlltzDdpZO8=
Received: from HF ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 56009AF2; Wed, 25 Nov 2026 18:21:32 +0800
X-QQ-mid: xmsmtpt1795602095tgl4d3zfb
Message-ID: <tencent_956F9CEBE3C22AF19B9450F6A9E1B71AD505@qq.com>
X-QQ-XMAILINFO: NhmQchj2HcYZWNfMfMNDtljOM1PDPBuN/QeNjxDzr/po8tY82Dj3qgcYwsyG7n
	 odr0QRS2BsMQySal7tDgkfY0umpXFyAsHOPltxNNriaeQOvHItAj/7S1RrYD0JlsNQGd3gHJ6fNW
	 e1eCRLjK3zkX1fLuwDWFycZZHGXh8eCKbvIxV3qQCxNnwf0NIZWxP5da7QPTHWKaVPmyRNnwDIXB
	 a2FZM1HiRmgiwqiknmuNpzl8juf408nOgXyvjSC05qDAe0aPofNSBz6BjsCWhsC4B0fWbCsLnqdY
	 EtiBBT/DvrSAHQuPjBq1gwLBuGYrNB+0r107AifLQfvOBv2mvo3QPmVCuHtzWJNiopdYaZV6SSN6
	 qblTcQOQGgXl43tZm0omzKseVCIozGkU1/MvUOS61PEFsV3c84R8H2nKEHj90H2ovEl2MC1rHLSU
	 /ywRk4PdrggQH9qSU0iVHyhe8OpToWbrlDFSlMNq2xH8TrQe2e2cTciy83e1mzjiVOm91ORRgwhs
	 Of09dyE4f3bajGUYB9Yw5Il1csHOn8j16zP6jXGCkXs32VkWV4rfcu68UkNx8BgGhf6MwYV+m+nf
	 hcArR8mB0Ww+yoUTHuW5iz0Ess0M2WcI1YHKqKgAs/OKx+WRvggEKnJkdRL3R4ww5I4k5u+enOus
	 WG0Znx5y7t/qScnbQegy2rZJ3OLlEU1WPBLcSl1cTX/I79XMO4ZUbBb8cpg3bvAE3SZWk+aqrgYK
	 vpx+O83Np25vSa5yXsbK6QixH72GT/lymtiKu5IjoZlQprr23UciciAqeGH/D3Y7XGcjtqQEEKQn
	 poYy8dSlmKrq6xK6RG0L/6onKbWH1qfGpTpsemowrsKEjk/NqrgQGqAkEIUr9v0F1TBRGwu45yHC
	 2dWmr5mLPgHJR/mn3zjV1bx2tz9JHkfRDsWgsW89ivN1FmDqC4byuYtu3GtgPWgN5VUd+VGccJ6z
	 zer/r0sTVBiq7Z8QL4VVx7WA/x/1CCyQOtaH+CUsxa03BnDwpGx+MWwelWjdt3evnU8tz0i03tkO
	 JjA/omuetRjmc4wqxkCxH9tjy3mYNTPQOeHYoJRdcPFvzrgE9XNBctoWyphdaCNDH+TrzYJ6pd9e
	 R50O9+zI7YtgjS8vQ047SbGBIMawQLiKg3olT0K7s3sWC+SOWlGh1kSyXp4QImxenoGaI5wrYes7
	 U+PhY=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Subject: [PATCH v6 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
Date: Wed, 25 Nov 2026 18:21:26 +0800
X-OQ-MSGID: <20261125102130.256-3-3066883572@qq.com>
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

Document the in-cell I2C touch companion used on JD9365TX modules.
Many FPCs omit the interrupt line; boards may still wire one.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../input/touchscreen/jadard,jd9365tx.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
new file mode 100644
index 000000000..a49a55815
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

