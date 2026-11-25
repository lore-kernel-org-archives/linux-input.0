Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572699;
	b=D2Q52H0oECsKwq7c3AtwiY/1m6H32qfnd7XSJrt45SS9mclqKVhF/pGgJ3CPkOAmAYXG
	 3CchIsKONJMtj2rcOfuxGcjCYV3tZ4EZfKU4nxLnn9R6RwT84cehqnI2BVyNKkRLhnuWC
	 6P6pwnJXvSRuMHnF9wRkj1s6TEskgkmXD2BVy5sxbprZzQLAbUPrmvpLZBaq0j5ZZO0Qp
	 FUIqN2MEIn5k19hmGly6CwC5dL4dMhadNkYnZQ1WLarHUeuKUJLQKEIUCfjWkDEVihijp
	 4VZdQWI+AF7yHYSXhA0Sw7lQE0oEh8o5+Zn5anP4g3Dx6jstxgZyUtRxA2Dxef7NUUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572699;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a/snpFbNdr1tfobEJG2lyvIve+2mrzvf7klSCYbBiHc=;
	b=G3qTS9e1n6soCIicNuJot62c2XgcBPdO49Q07lXAemfA6maaEqOz5Sa0Vw9AHM9Cbc7B
	 ZJyBGK/cy0kH6IyZHpO2mNuDk+xHflPNKf4rkGs+7/oESKQyCf2s7xOMdUblCuvHYTiUA
	 9klq1Kk7bQrlujKok1SyOYPS/1AO0z+qd1s8ULfVITPgwxifeRo+KmgbHFp28BYOBggQG
	 l3T21Ie8/X/qWZlaYQFRr/ZLPYfgA3eZa6pS0Q4IfcIGh/eYKAH6lJySw/cmX+m9vH9NC
	 LhTpbGmRn2Ve7SGOkO8WtuenGlSwHA/GfJCkVhUS/FabPii8SJX8IIf0xndCDf/lhFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CH4SIria;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A3606A329;
	Wed, 25 Nov 2026 02:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F25A3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CH4SIria
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795572692; bh=a/snpFbNdr1tfobEJG2lyvIve+2mrzvf7klSCYbBiHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CH4SIria4z5WX7MuhNuc7NbhXwD/ASRIm7yb6n1e4I5pYPiHgnG5FPvy0drkBTGwS
	 DcoSZp9zf7oTWgG2Oy+1w/v5XZjrNtPWpcqFEEQuxw3n+Zh44awL0Dxl7b3Gc1qsTU
	 n5l7YJ9Yqxyk19L8ybiOk4v/MJ0ZKURe4IysVD2s=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 2DCBA053; Wed, 25 Nov 2026 10:11:28 +0800
X-QQ-mid: xmsmtpt1795572690tk8rnimmp
Message-ID: <tencent_50B2DF6754BBF1EA8F2CABA66F0342A8A707@qq.com>
X-QQ-XMAILINFO: NxF5De9alh3H0sRypGcR+qCy92NicxhVYIX9nl5dmS6VCj4pDgu3InqiEr1kx5
	 qmAzWBM2QgUizJSnQZ6Vm68O+uXkCeeSca6O/1wNqJ0pyTaduIjJRVTUK3zwQAgvcGTO+s+YuIaP
	 Oqp9BXYS1Xn05d/uxJwOV8cxCMLSMiNOikYtxg7u6r0bPGbj5JVAY+ecH469R3fWuf2hvMTn+2//
	 i6whtQuSQo6NKE02yW1l+ltZWnsh2U9WCRSg8IOp2jxSJxjYOhYMD9dIT/xrJ4YYFgiuCNxa4QfE
	 /bzBDiDEthyo2fcxQQl9tYt3QMj30KQv8rquiUwZo6VlEq9413pXr8umqoeTG9n/NR0FLeZw6EVp
	 oh+gaR0QqmeCn0WzKcPiG3aRBELtvFxWoQZNPqzf0A07E0h/fOPGvRMoWqYHdMeVYiBukoqdPOwX
	 EsBLJorSg2X1AiyHvIo//vZ5N472Gbz8qh5VuI9cVbVLfW481rOHOpovJQuGTY30koAedJk8fWwW
	 gTvook/rgRQvVv22xIE3gWHdXvkotVspHHQ1Ph0kyR5Ua4dmOXaygKTPTmzuTK1dgQXiLZduVyab
	 sI6+GI727+reTfGMQoHnu51oZ7F2FI0gOR8GGx07gBVhkPFmROmpM3r3lYxHc76LNJM3t+GxmzBJ
	 OHei1WQ/lshPiWvTzRIfUJkR3lpnXlH+5K4jcb7UI903rp/Ai2ghP6xuaUY37rqpZKagwiMHTths
	 9LkgLnBwSdl9kYNDpuUz8/UY3kqN0eQWRoI4sHpr8qsS7LovVGvaEGwrMQMFhFhYV9il4d9+AQBK
	 +036M/gUeZeedx2k3ZZ1Hb42dGrUx+f7r/KQ6LLnYdRarqY+gYz54lEvFj8Fb9f22Mpybr5KNDYJ
	 cAqFdTpnEgSdNwJS1XdlcSW7/m0gEqNTMzouyoIKYCfZAl+CPMRgjZaDtgO1bbttW1uxPLjHLFG8
	 3wBWBLCJUwAsXyVOhf7LaIUvB5i4Gln1zcXo1t+ulbkeOTHrN0vienhqnV0k5fxHbW9r2JjKQpSL
	 mtAmesopFzL6BaHITmsC4104mqLPWHgHWCpYt342x7QCbCEPkiGPWuKhvkxn8W36FQZ04sSH0JB2
	 hLiUiWpBUTpnztTVv/vIyeLIyXAkIQywsBGBUAucrQ4djhSTK++s1k+LRkKL5eM/hpGu6XVKmF+n
	 zgfLg=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v3 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen binding
Date: Wed, 25 Nov 2026 10:11:23 +0800
X-OQ-MSGID: <20261125021127.1430-3-3066883572@qq.com>
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

