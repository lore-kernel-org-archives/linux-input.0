Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056492;
	b=W2UmsPkb4rIBegiQPlzt/rbHi5nF7HMGP1oB4JmgOewVEa3plV66138pJ8tVYNZCLzL/
	 OhKU6nnfssKkzWF4Hbfd+ESeX1QF6FZ1/b9rdRK6SX1BWg7hDdaJO1exjemLsY4nAUvkQ
	 f/1awKLyjjpy6KJ9N6gHJWEzWhhlZE19rO+RRdmaEq7FVduDVpwIeJgttvhEZ4yiDBD+A
	 SE+lDQrcrEHWDa9PcF5iXieKFtLoMCZfJh9rwcTfFbMqCWbu3LQD6I8/yjXNbl0R+xvUp
	 05EDCpt1xQHF/L3SICZ11nhI3jNQz0/uHixSmWsSHNG/TjkU0BiasrNWozx04scgUrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056492;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=ORu0WgjqNvSeA6eIhRHMpYXThT/LB+K5eegV4icd3cQ=;
	b=U4Z9vXlouEIAnEOlr2UGz8TSWm6Dpqr306cbT+3z705zSFjDzwlqNmOOQ8Hn/wpWOo9M
	 z02cOGH01HwA1fz+s5/IsbIOsBn4pLnHiM699h7Mh5S1D2CWpRTVLqNapcQA9DmGP5QBv
	 M5SBvZ6wlm3Z3slFgcuZZ65u5Yl3JIsOO6Du/OZl9NanpCueCugib4cYi/CKBUPGxeSKm
	 P837ZqzCg5qBHj7TIAI6wBslpMDj6ezYtXwN2ydmMFCZ24d+1AyQ8cfuLuA9aq6c3ynIq
	 QpRQbcuNmuFb6MrdoARlrV8/biunYLoUpTwa+xcFoWh8ouUpCpgHDVV+rQUP64Xdhzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="fPHSuZ/i";
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92458606A333;
	Thu, 19 Nov 2026 02:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92458606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fPHSuZ/i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795056486; bh=ORu0WgjqNvSeA6eIhRHMpYXThT/LB+K5eegV4icd3cQ=;
	h=From:To:Cc:Subject:Date;
	b=fPHSuZ/iboMXGBujy63MsgybwcqvGgf4GnGQ9YwiYwJCScFqgiVjQmahUZowYT52l
	 5vNZl4Xvv4cIcEPZZEALMBufXIpj9hcy9YZ+sTfI/qfa6TX6nFoONMxYKRXvmMAV4n
	 eqNtP6hjXR5jNjgPMFPzgcNTm6wF7Hd1QWJiIVv8=
Received: from [192.168.2.135] ([113.90.236.90])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056483t4iyzkuqr
Message-ID: <tencent_093E92ACAABFAB09F39EC07F4350A5C7BD09@qq.com>
X-QQ-XMAILINFO: MvUAcPkRmFBfYCwSOLBcyjSEkhAGI5fuwc4Yaq86G5JdHKCisGEBYB6ox+1j8s
	 awf3yppDg9VQn7P5V2PCr62BFlJc5F4AHkDL3i9uddjQQo/4ttti3JHe/BKtH7QhP5TCoxANijM8
	 xeprRk6Xc6x8nwMymwQD+4S7CsoJf+NFfaZL2fqQ2pFHJ45l/IxD6J3wUIx5CwlG+S9PNwjeyJte
	 HqXveBGl4ezZ1mS1DwudbjTJZOs7I6sdoVg7yAGlHNECYMBV7JdAoMGxkmKg88MiADRxqXmi7CPG
	 8pflKT/XNBF6J7yQAWid7B3xHmbZBcA/JiGptXiKj8tbc5KgAwSmLtoQyHdBdGWsYgmD2VLpKHQ7
	 o/oyVH9OSY3HIB8OPjuu3Z4j/Pl+Lm9pfu061N6x1uTj1lgYDJ+1o/Lfyq3X2hKO7P41qfvc108v
	 tjls64dIOjUwAq5U6X2AcJ+ZLHrcCagB4HurTHBHtxsWArtTwfOmnJ6jIs6tQ+SSEhgpWjQtRyBu
	 bvCnvPoHP03KIy/5HhLcE0WBk8XB0m6fIBJkIKWtX+yT+hrIfSxxLxxZO6My45zvrT1qGuB4XGqh
	 WThq9irq7IP7KkhtQVt4DCO4wwJ0GwrGuB71hgCycz/+N23tag6XP2wI6mcbyMeT/g3PClF2WF/B
	 prAJedxUfQe939KZUwECzLUZKGRfbHWR2OBSPAMLz99ltq2PEQkx8RCCr3p1kmYn4QyQgoiEGMe0
	 FoYwPS7qu1Ew+Sqd0XPFnfhfvYrE+wX0RUMWr6RuDUkpEKjL0vtQQgKRMNiuIWOl+zaTcsW9A/dt
	 j6CdGWgiMAIN60IKb5r23Yxra2mJpU7PXXJftFH+Ol2JTbI9mMnQExIV8C5UMaBbGLSfk39LEE5R
	 cN9uPDbk3FdNdIHf6oJiJxdBLNX3fL9EANcQb4xrqAzCJHTG8thTLr2IqETbivknM20F04fG8XU6
	 SMDE2amLGkKM/GpOFlx8EUzarxHPXkIMtO9/rQcFQ3HYsDipBdaA1e+5wLJDjrjjVuqfto01JbL4
	 2gJmchsp1+kMPBwGcJTRC0NWIG1b0au0uXLYulKEdt4yqioHXIMfKeu83BwrQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: backlight: add VIEWE I2C backlight binding
Date: Thu, 19 Nov 2026 10:48:05 +0800
X-OQ-MSGID: <179505648555.50956.3731361690188155189@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Add the binding for the VIEWE panel backlight MCU on I2C.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../leds/backlight/viewe,i2c-backlight.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
new file mode 100644
index 0000000..ab60c2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIEWE I2C panel backlight
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  Simple I2C backlight used on VIEWE DSI modules. Default protocol is device
+  address 0x45, register 0x86, brightness 0..255.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: viewe,i2c-backlight
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
+            compatible = "viewe,i2c-backlight";
+            reg = <0x45>;
+            default-brightness = <200>;
+        };
+    };
+...
-- 
2.55.0.windows.5

