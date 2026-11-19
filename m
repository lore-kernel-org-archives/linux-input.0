Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056493;
	b=fdbqfrhDf2nCmBd3IbyAkdFQvLemBhToqQ3sDtIiL6tRN0KdzDK4s+XDWwWft8v//Pjq
	 +z4Gesy3xmrfHUjy4jwROT7dxTm+5Zn/V/3W/F9ZEP4sHrjQ89jJ3h2MCSLZYhCtmVzCn
	 4Zwp6jx8tkrZh81DuYyOTAbyzt3zzCFZHJpAiarGwXUQExaW7tVlTZJ9rNOXvVqRs/meb
	 OxVnN0nAnJZzqHJi0rySHgCv3EKq3hyI9IbJqIpVGviYeLu9h4nOh9Z5HduhlWS9xf1aX
	 oMxKbUkFpPZHmWwhSFuUD0pPTVZ+WGZLLNR3/Rqb/rHFcluVsLBP4Nyq7SpxjaMDBMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056493;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=F+GznQ5ehmpoHn7y2B3eJjh+AK3O+EAWYdgljwNw4HM=;
	b=OzZTPjwTD+/PWjncmsqWMc3zvszN8aRdqCBsH/TgTu++rWRrqKWDJ4BsChLuxmUm0kPE
	 Skj8sddwIYwrSl9S2+uzeW1CdB3vjP1G9nG7+SDIIwWtV3Ej4ULh7SmmxrOrAtgml3bU/
	 QoI3UZfUs4IUufNXkS8wfb0v33JdP6uN+1WgShH4FB+MXP0osZpMi3biOM8IEGgKWCG0P
	 LxNBbuwKFADnkrnqx7DJjQKAeP8bOAL7hH2ATLhBmkL7sCHqG6UP2ypIWFxDEWJb39NCe
	 GiHELlOJ7I2ZTficey+pfWfnnIXGFovjmJXLDwvSW7l9iWIpqLSOmwN26vDYK2Ayeog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="B7w7G8n/";
	arc=none smtp.remote-ip=43.163.128.50
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1117606A32C;
	Thu, 19 Nov 2026 02:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1117606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=B7w7G8n/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795056483; bh=F+GznQ5ehmpoHn7y2B3eJjh+AK3O+EAWYdgljwNw4HM=;
	h=From:To:Cc:Subject:Date;
	b=B7w7G8n/jTBFUs5Y8WvO5w+F7JspS0RECAPjhqNNCjKqZpb8R4XWAXkF7sw2PSV5C
	 +nL3UH3WbM3ZYv/L32UXjlAbZ7FMLb0CJmTHhA1y2cxcuVZ3jyJ9S6odPBPsaBB6rn
	 ueO9NRjyp+Y3cxQlnChhuGNFl8N6GG2PP2USxziE=
Received: from [192.168.2.135] ([113.90.236.90])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056481t6yqslami
Message-ID: <tencent_BF0B9E6C7E95501FC63D3F98AD08BEF70909@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u9yaGSSvTsV+kFTq2x4uOhZlnqKky1YHpBZLwIyZYdRyE6qUjRE
	 J2ePGTtcHEPE9tfQAMpjoWKU2It+X9Gpwt6Lu6yMQS1WpG8dBLfUN4oJxA4jEBZglrOUEcnRJada
	 meP8LSuPqLNUxOXdxd1Xp7j5tykP2MCTbFODxFf81pD69+kkMVEPzKVdUpWI/s0H3vgvKRgIaMKQ
	 5hvybxn7rtFkJlF7gk2xKcql+Kz82puJmkWF1HYmAtGET/DpRI8bO5+G7xEqbh3O9xlLDVr3gniD
	 cNZ9FEK+22xv03d1tiwC0eanMjv+774MLCBXkEgbQdwYVQ3THML2yJl7zKTKTIaPyah1ReyschbN
	 vQOeF+tNaYWThK3a/MjHptp1VXK1ZAkL4NaFLQe0Q1U11maM2ZcFjusHjsnN+vGF8reaXHC+pPv7
	 7RamsyuNK+5+/tTXkl+ar+22OFW0PCkKfCJ/4j0nJSZXEt6cYHfRrX2pzLFMdS7ry2aPRiYzY8gg
	 1eVdAikoU17JjSxUbB3z7JKwbcfBeN9Yq5LvaiNPG5IBxxkLeJcZnSPuwZpiD+cwTJUewaKCl59h
	 cFwmQky2YXYx8xG6yN4k2SEdI9gR7jT6M2fIPA/uioGh6sZlsCJbKoq6dwkovjQrKMYDEIbydxW3
	 f+J8Mo1/oFqyyFJ9A8B4qVqalxXlGbMHnZvlnfH5KvDcD7TVGSSJbeBkHR+Z1RKxCm1wXgVs5KFQ
	 63k++AAtDtO9BMPAAxOhm+TxJnACxRBZMmx/qJGMdniRLBqumWcABR9A8ozkGYEuPGlQMnLI8NVk
	 jZxgTLGwJwIivdjZeRVJDca69yYNUWjBSz1N2hFlCbBhjV7FlhfiUMTpAucHPLdDdpJaqUiltZZ6
	 xYccieB9Zs1yGZKSSBR96Scj/FEY8wl2sdLViJWtRdU4EIHJVBRjZfAUDcvPdhWXSQ/RKXOqQmFw
	 bXbwVgyakC2GxC0hg5V2mmo250sx5e5g7YhCOhI/IlBUenvKd0gGtY97X3enl1HsG9NR5akrvd2C
	 zkQC9+9GY4sAX7jeC/n3Sqj+lesFREwagmWWh8ZLxfd6IcYiyt4df7O+tMwbU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen binding
Date: Thu, 19 Nov 2026 10:48:03 +0800
X-OQ-MSGID: <179505648351.50956.5246326877700027656@qq.com>
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

Add the binding for the Jadard JD9365TX in-cell touchscreen used on
the VIEWE 7KF82 module.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../input/touchscreen/jadard,jd9365tx.yaml    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
new file mode 100644
index 0000000..23696a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
@@ -0,0 +1,53 @@
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
+  reports.
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
+  jadard,coord-addr:
+    description: Optional fixed coordinate SRAM address override
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+            touchscreen-size-x = <720>;
+            touchscreen-size-y = <1280>;
+            poll-interval = <16>;
+        };
+    };
+...
-- 
2.55.0.windows.5

