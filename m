Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575408;
	b=5WdLKHilNy/tKLD41oKqdhxdESvxiyo0xUSfelZPcCaprCGD7h6YL34KfIFvgYK6rDJw
	 drxQVv+d4cZzxHrnJJN2dB4ro6LQ8XKgyCWOlcuuhA6Asjo6QNO/R4708uEFHKGWhP0DY
	 suNTc72T0CcVd17lCUbgNlWIskwrcdJj2/OiUy2PsL+rW/LofEX811mMyTJOtMUoe9Fef
	 EJ1XMUc6/FlmAdPWHRAUZ6ZMRLRKC2on+IDsQWGVXSEfz9xvV/hWzIkYFRJaMsXrVg7gf
	 mLOwCaLrEfLx+3Z17PvO/eCQ+w0K6zn5IFtmIq5KvFb9lpg8ONnE3JcAscBxD14UJOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575408;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o2ZBOBSK4J6IpmVXYBOJZpEDX+16cuL5L8cVT4NeqK0=;
	b=DeCrQUyRs1vnjbDD6iYkhuMeOorR1akGlDZhGRn0t+2RzLcMte1mPPQ0pVPAma6snS7U
	 980dZAgKzCBg9OZ7H+QY8w9OII2XIaVx+cA7k90e4Jdyk5kOFajpHYKVLFb/iwHjGW1rk
	 SioeZZWcTT1oPNBVQy1Sc2ZCLxQ+EHPp6J4qppFEDmxSubUvFLrToLgIlaLCqwrFFNkh0
	 NZLSTGUqGICjeLttCa7g/SKGiex04IeVp4VTp07wsQL8L1fzINoa3v7+6wALj2aFPg89l
	 Lm2elxUBygXNoA+4y69LSY26VdbGBhm2txysU1EQDfwmAQiElUdP529jLMwuT9+HWZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zSMz9xnA;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B6606A321;
	Wed, 25 Nov 2026 02:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 067B6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zSMz9xnA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795575404; bh=o2ZBOBSK4J6IpmVXYBOJZpEDX+16cuL5L8cVT4NeqK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zSMz9xnAGJlhxBLwFxKPL+emy1iLCHJFdYRLOtMGpMa94mO3mDlM1IKLI1W6v8Egw
	 u57RT0gIwqDP2CZAiYAZNX4ZpN3MOxEDoldo2nZL91EFbNGTn7mmY+11GNWNGgiKuK
	 O4Lo084hDwB9BMJKnntci9V3C8nPIQ/COiBEvPQs=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575402tya4smuws
Message-ID: <tencent_2485513DC7293EAEAC68BFBD08159F067E09@qq.com>
X-QQ-XMAILINFO: MKE0p0laDlulEU8jKJ9WA0tvJUiv1Z8UyaeMLqPKpR8ObWI1Gq1h7Ojm90UuOR
	 2tzSitwrOpLmC/Fi26w6rXGUNX0CmmDSlbDwZFBRNIfKqIyEkGeurLViPDC2NCXK6CKeSLoWFNLE
	 ykJ3Fl49AUB/8D3KYWR07X+9C9Zd4SrtRI+HqA732SGmg5b2h3kbnTu7XDAQczlANPT3qJjvHuJR
	 07IRiZQQIC1EgJxY/bW5vXtLBcPZIFd6cwbreX//8tEAwG7yn0yJANcm3mUTvgcgyOGu8QyUEgWu
	 UFFSLofTUJKFKUdjeUtF+rDlgYHTv88UeV7XVNQ/Kc0RGTUVVmy21MFU9BwbqOUNIqsktXGUidWV
	 KXL6NRwb7T7UXbi7GgI6hNwqiGp7gKdMGTuNPrMMLzyknTsNUWCY+5RKPCc8rP6K/B4LvfnmUFYK
	 ek5UnGTHcOXVa7lbjdys4Dmtwh30ch1Lni4e7hsW8IpI0/Gg+ABNyODI8U7adsBqloe35/enADNk
	 YgpU8VUx+YPj0CDS0zQF+AZfQEofOP145KyPWFfxYFQ3fog4j5iNWHQPuvTn3h/iaCJMcqPkBg45
	 7yiaOZG/Sky4mp+UJeW71G8bfy3aeM3yjSp9kmBpWCl4JbnBlM9RmomNNZ/pSO5O/l8I9xBhT63b
	 rSRwo9Hm4YtLpfa1YJswl33N98CyoL0YwnTkEEz6mMBcLK1+DOu3SKWI77ZS+ipi9b4q0J67SGzX
	 m8lBQWkJeSggpfteKx7/tgqpwTmY/RXNTskwAO5Nz33HEMAezHhTCo3BnwgO/czqN1ar2o9Q86Ni
	 hq7ENTqKk46fmmLxKdJvm9ME8gCqGIFyTI7FUB73vF3u8US9oBi4DTO6r29/p0oUQN6yHKVmCXWN
	 GZuKdS4dV5ZxiLs+CV8taMVMZ4z9trqfIPvkRVC68R5TuOHBjMfrEeitBFtXJCVI740nnfOGq23p
	 re3YGKFxVHWfeae96yAsAkAQpTBlPMIvA66A4fvqNDz8Yf2eduWjMr1fFCUk3XK/IbQxC0mWg+QX
	 0s52bTRd2IzoCs+PZnZpQQf8RZibSTtFp0ckC64+h7SyY10yTHixCCLJLIVjV0hL/9/NSW+/7NiM
	 2gS/jyiDkiTFSfj/NfK8PCYnO/Q8Odl0L4eQtRR/aw92PtS9h4zC6Sfl5f8s3pJt4S8DOOIHv38d
	 VlEv4+qesHS9+m3QkhDMFpDj9bQvkSQcN+NOhhErj5vkS6zg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v5 3/6] dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
Date: Wed, 25 Nov 2026 10:56:35 +0800
X-OQ-MSGID: <20261125025638.1171-4-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125025638.1171-1-3066883572@qq.com>
References: <20261125025638.1171-1-3066883572@qq.com>
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

