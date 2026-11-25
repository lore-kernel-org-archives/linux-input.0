Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575408;
	b=SZIpSaa7V5/VxqcnIpIFEu4wJMTsKEZkYGPzk11SYFdMYkCTq3qLN2gPW4ZryvvLDWWO
	 BUwk6hTaq7LjKuqp9N3jx/QCCDsvXo6huC+FDXxjCY6PVr7y3ne7f8wloVnnm1RvRrRx2
	 6Qtu2xULHnLWK6rzfM9rlvb3xQxVwdV9ztzWEgbhQ7RgtusHkEUnfzg/1a7QTFwFeEqf9
	 8imqrnL1cBctaQfMmDz1pz09qyWMSep8p1hrtMepAMjTWmxs9U3f5GNvXxblkeNtgoHrY
	 mzz6rBk/pjiwaoJUh5GlrOz5EJjY/0jcJh6s3KS4kCX2pVFn6VvC+jAlU09cuMfloMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575408;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IzcclkVTG1KnK0341G5dFq2gzXEaIhA/6RUSjtt6e5w=;
	b=A09y87xnNc7DwUi6rh64Ni6QA5H9EO4HG3GHO3UhST0dVszs8DnpzRTPIfIQr4EEQJEH
	 ufGpMVALqLhS1VsK2AtpnF8gtJZutIDymnFBM7alKit+MYtdFHsH3TKv2vUFLMSownrpT
	 uHvmyBosk8lnpTBovy2JV7yBNHVi8ruQJ/qXRNvrGQ4n2ex6fDK1ovpfwN8Osu36am6SA
	 5q2r8Zd+VVwFiqDuCZuMYsTD9u8Y3dv9IQmRCDVfBOiU2cJCmVc/L+TWKT6/l9BbQESXC
	 wy8J8sgcBP+FELxfI/OozlPa7BvJSAAMnMbQJyOXe4PU7x9CDDYPCu79LZg9E0wMabw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KKoklFj3;
	arc=none smtp.remote-ip=43.163.128.54
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FFA606A31E;
	Wed, 25 Nov 2026 02:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7FFA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KKoklFj3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795575403; bh=IzcclkVTG1KnK0341G5dFq2gzXEaIhA/6RUSjtt6e5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KKoklFj3ba2YHQz8E9iy3TCLREPDzS1z9bLXTvlerLkXDkIEfH2KT4XcK2ry+Rp7o
	 o4ZUtR0S9rQf4Oql8Yo3c217OAFyA9vJoOCv0SxnYtyZFwTelz3alKWnn6ofKFXK0J
	 daibW3Yt5MUPWJ1mdUCmmMMdmOeR3GerXAkSr2q8=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575401t1ofa0oh0
Message-ID: <tencent_EE0B84FE4F17BF28A85BE33E1FA05603DF08@qq.com>
X-QQ-XMAILINFO: NtvpdyJXE1j9AcsIWqBfKSaqwV3mhCyz0IYMCCdVAMs+ZCRSkz1RVvEHQy7j9j
	 bJkw+I7SJL9J0FoSoqvfIN7T2hoAVRcueuGCTw0jGNwr2UBRnqDL8HlXtVs0is5wNQlFHHd1uY0m
	 KYGm/Lx90eGxg7sV5NPnBks1vRhW8ueQ79zVhFneqE/1wAcMrJSzwAh/+5JXhU5cPNvbpFhE5YrB
	 xR1poKH7XzV9b3YvuQP1lYJUtL+A6SiehiiJCEOCisy78GImXi+oxbjT7sjYkZBsUH0LaGTp6KEu
	 4eWjU1wI/kbrhFEh2LKS809NcM8Vcx5X3luouc0hSncHgFeytc8sOMrOXql0qI7haNTQksDm82BO
	 wU8hN6rCPx5E11FNgQlmDEEktFxBFYtItkOtUueCAqOCWwWxEyYCAErph0+o9GfxQdlEqTOzBqKJ
	 k9Cck5buzkqmdSStDd8INxjS4ErZzD13iHseMQ8jdc2JZCm2AVolAsgQjzGCkPOePhLsQn5VIH4I
	 J3krwdJzljgv5fs6DsPJSNUi9FUjeBXGmwp8pFCVR76eyasSGOOFuaM3RTbNwizzQo8y4wg0AZcG
	 szHImF+uun1ZuLRR8ydo+5qhc0YwYvtEdG5HDaiXh+H0jtx42Nv4LyuCk0ursoAc9n2L9LR5vk+x
	 s4MCsDCSU32qYmiFDcYFk65kVL+skZ+9zK6AipqG7aXrdppRfix1vhA/9OxY+C4ELtUIKC0yPK3k
	 3lZJbe+wqRipaOBHZ1mt1H6Lrtfo5lXl7YgJs72+p1nx60x71oVT54/eoPNoYVN48y2aEfl4IhtL
	 p7cWSIYyIgwBvFo62Z3L5bI8uGs+85sX1FUoTvwLiadbOucAVFs0C/QG0VU0AxNAo58Cd/GEFMZ0
	 TjJGLlO3wWaakOXz5f5Wa1/LdVsbDS9tvL2QVr/YtWj37HVpe+wazNji7RuL+3L5OOsKwfmTzbs6
	 ntb7ZvMa4OzoaNjRki6IniMfYuAbsfxSOeqDA1nh53O575QgAMCuItAxdf6Cg6l/nep8ToaRmLfd
	 0XIXa53SU8gi037KKBIMzqmLpiHg3I0ypmCEEjJW1CQn9pRs8IVfQS/lVYPdDBROH64J8WJldSC3
	 zZam0+ILBe2oUsvSM+jwuVHxAkl2reUxr2+JP8P0EOnVnfcpyil2P4JjZprruavCZW5zN78kCLFn
	 dcpDNbeAZPWfNGHQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v5 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
Date: Wed, 25 Nov 2026 10:56:34 +0800
X-OQ-MSGID: <20261125025638.1171-3-3066883572@qq.com>
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

Document the in-cell I2C touch companion used on JD9365TX modules.
Many FPCs omit the interrupt line; boards may still wire one.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../input/touchscreen/jadard,jd9365tx.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
new file mode 100644
index 0000000..a49a558
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

