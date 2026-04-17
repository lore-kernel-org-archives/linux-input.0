Received: from sonic301-20.consmr.mail.gq1.yahoo.com (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C33358388
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403554; cv=none; b=YCFnSvse411qTI4rSxdO3CEd4zPpkSjD4f/P5Z+VN4y8n1mYJzxL7vKBo2/sXlRZZkMCo67u1KfNvoHmQzwO0K7b3h7hPZIn3FHN1cKSwOCVJG80OEo62lIKpR3++2bhZs40rQfsiDrHW0gKRw5W0ykU+PlQn5kvylECTNIY/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403554; c=relaxed/simple;
	bh=1J7MwF8rPlG88VoS8a0IxHCnCg1K6SzG/2NtEPqqUWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH+dwPaNbve+n5gSIi+0cQAQ9oQOBKo76IJpyiuzydMoDsSzBO+AaHT54Lstyiyq4mmJsL/OpvQ81lFTFHJEPP/HEvxZmAUoLJvSkihL0nXp+Fedb0qY/KaPgJPo8yMHALzy2bCg4iLKyZeIhARP6wVyT0Ac90U6jWVtaYs7Yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sVCE+UFr; arc=none smtp.client-ip=98.137.64.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sVCE+UFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776403553; bh=9vTObqX85QaCEXwY5LKFK7LitXf1Ajy/mqo2ml1SXtY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sVCE+UFrYTsrzMNQz6kMSQclQf+DWIUwkPqENgTM1wmNmTcnOkF0e2+ofa8l+oTgkYb98TD2Jw5dYKJSTmXZthobDcx1LLrTZwPsdWXedczulZuxwOS/8JLPmt64UeltrBJmhSIP+U+jV+l0tzqpl59uhr49EYavfBqLKlRUhV2Naj+qzJWpdAqZT7Yl4bQplulW9HiuQsRZT4B7zFttK216agUdfxHF6s50ImWZ+2XTGTJ+zmgW+G1gi0YFG8aQxbj0l27znMGVF6vUQaGW3dZ2ivW9lDLDETRm0LgqFqAZlyizpbbySply7ACsGyQ3yPiS/8v9VbM9VwauzDFCzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776403553; bh=wnzQedxQPKCytp+vrnLr7BNFX2ZzBhw6+mSBAfRSbXI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dk9twg/VZ1fsteZzhsafEGj/5aFTzWK1WZ16/0HpRuTkRHx74rVm26Uho0DhIiYGZ5PkBqenPAOuaxOUEXVqBYX5JVbmVHkJ9uH+Vs5uFtv0LLl5KFsiiVbR9q2b8fHxyhcJepUMEXFbM6FI4oEHWKDmacUiXtQdNM+srZfyzEQjk8HrsHEaji76z5UEmab8k5rYiE41AbULjbUwLezPf0rQ4xiSIXx0X4Gqp9t4E//xcPef09ozQrdEuENiP8x2Ye8gfsR4xWqLaEmmisE5nFDvgSj2I5Gxd45eFHNOThYjS6ZbiGwWsBy3cH93Lh0KA1f/zy0mZowW/WfhdiblLw==
X-YMail-OSG: ki2x4k8VM1mGyvGkuUOl3vQaC3My0fRbHGspnr1i6ybHJw2GQMdV7ah8qihgiK8
 MDn_8nknJbHvHf_FdYaYhBQr.6np7zukT9_nuHM.pJPdp8vuRaP5zV7uCZgxOPpK2v_XHeDqzqVw
 itRQW9KkV9Z8NjvxxMt5sBIP4vZioTJEqgv3VNXUkvajsPUsc.DKsrSios9ln_qvcYEEvo8QWjO7
 GIKIvtBLUvezghjolWhuvx5wDag2AoF8kIZWU2c9lDjvjKh3_j5lBndxObwX9Y26ojw1Hy6_dEPR
 JdNpEZqzDkavRrxoafVEH0Y99IE2mpoyN1Dwze1j01firUd2FMiCbO.6ogRfq0a6hhl2vGcRethS
 xJjyoDAlVECpCM.QaICciJtW3Va8UfYUAS2ro41Dx5er2tQ2MB7tZ7c9WoVwBFSE7dtxm0HU0pFG
 wM_AAyMWUmyH7O79KKWiHb727Qdm1J9vNbPM4KokQaPl2uOzJzyPHgHgOWpL1eJa70FfCBEFXdRh
 327SSVzhZzIKEIfI0RkqfllLwwgasKA0_QIZYKD.iLqxrZnoarT3gTWWVx8Fm3E1YAdwv.A9zuvr
 uyyQKzbCSHwcUvN37UBr0Ze1iJBHeITTjCrptgouK86TK3jz3SipA11CDZz6wSGOs2XGRsvr1ngI
 0wxyJG6sGdY9AQRm.5YNBczmuSC4ZiVr2_zngI9VKKXQG08CYSgAq9GF4KiPE8_aQe9lBqI3Jh02
 jL3UbbZjd1sy3v2tpgG5YetKpK.04y5nOKxu4zacRbqpUsHT4xNb_3yqzPCHGnDVfG1Id9USmZoY
 xPLPjT4uGoQpl46aIvjTYnhO0ijPMe8TA_ruYzvEO1kjk7JLJpW5WBizX60voGOOehLDxeVWMttT
 hPCG6ItX0PGbdHxKBw0G4R_y3pYRjWPK.f7jSG4UUECQauByWkPc9xMAViucTjI9KLLgFKPI7dpE
 5VEgOjlINGWwkIRQ2gDlfmuMGfLmJOjr4ojNnywmGdACWWHitScV.ObJkjVvvkATRKU8HKe4jnvJ
 5IZJyYpezv_vc7hC2bIju8MtpRoztVcX4zlF5fPtpcr9QADzKxNlbQvDTbia3QmMhtvUYd6xa99R
 3zxIdHRRiZLCHz3ClU2U3BF4DBIwA0ZcnlCKewINJDo2kaMPoGNjm3sGzgIhp.XPpsVv93di9.gu
 vwplwG462qiCIx7LOqgPxgKZhRHw_bHxho6gmFTCDkkPkXqMlgOPq7eJqOiNoEkP5TJ16fFbmTC4
 ra4Acn_7WXIINEfZCYEtvjaDNMfQkEpll5gaD17nX6h1irUJhbIZ_NxAscQ6mbu0XGR3HrFHAsMj
 n.PCd9SqFIsL7hx.gT4p.CeSvLkmnr9sNKLBrCGP8.BoAHlmTuwyQa5KYKRqxEekbDQiXV5TAplQ
 xVNovlmjlbDOuoTBeVWjckR34emVqVKsEdyJpoFhUBINq6LBBjeAtGYHACbn.qZLI5qdB0LUMI2H
 UVLjGMtPoTmsbvWCiD4kiyZ28VCid2KLfyCwl9weXTQkqgkbq2ekf6aU1qKJwIxj0im._pXtVmGp
 i9QYmmN2ctsLV2wh13HAfndq8rEIke.EsAPR4H4T94jVD_KMzv3Bvwd92w9kQvrAVwCbgFbrD.gh
 gmQhyKABwXaI6v.GS.hWNURmQelPP99N.xEvqocBydmvhA_1RyJa6kawHz__kiKsDT5hgZpJ0J9w
 THs5toU3maQt71LuUVt3W7C6iNrayvoGsMKTKQ1hiw0TN4XVO43a8Z6Uyncdr0gYA78VhD0Cv_6e
 gnhv7JkYR63NVZK1JNZG_t4Z41ouEZZrtAXqqg1jLVi2uLGD6y3sNepdOMbJVl0nUkoq_rDoVg77
 Su1eT7n8f0jWZFMraayxwq3So30wR4WA_7SrcUMKSiVmitE7mdMF8edLEMtt_R755KcMl85pbTgT
 OgpJwILA4AJGK7fKeKVOFxJwqXRp3hgaVs0N7QMNCGoAJE_wBG2CT4MQFv1EJGFeKzuoLJTXKnP.
 hDSB61Ga1pjdaLsFlUaolvPb0C22XuS8cRgGjpoubeWCoWzIvq6MIl5HB8LFfLLb7cFysvH5NEgE
 txjBxrvXlPWiWqc7ROLC76FRDQLKf7Uzh2Xb0lwzlgp.aQJ7KiQqeZ884fOqs0D_67jkCxzYaNXs
 SO0HQNr73xDiaKiRyblti7gdLr9B_wXBwikw4ddWsJbqwJQ101FUz6p2JhWDzpPnYUovbbdKRmi0
 f.qMXsay2ftfqs_j0i2leeNVm2kcZfFAGGY_yKkSpjtCHvPX9_8hzwqFX0iasgfTpWcOxfs0gWZh
 c3tY-
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: f7439bbd-de34-4375-9a4d-aa8b8bec4a41
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Fri, 17 Apr 2026 05:25:53 +0000
Received: by hermes--production-ne1-555c74f9db-j2jxh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 05d4cf41444c4727275ccaeea87724bf;
          Fri, 17 Apr 2026 05:25:48 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <david@lechnology.com>,
	Harpreet Saini <sainiharpreet29@yahoo.com>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: input: Add PixArt PAJ7620 gesture sensor
Date: Fri, 17 Apr 2026 01:25:26 -0400
Message-ID: <20260417052527.62535-2-sainiharpreet29@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417052527.62535-1-sainiharpreet29@yahoo.com>
References: <20260417052527.62535-1-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
---
 .../bindings/input/pixart,paj7620.yaml        | 70 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pixart,paj7620.yaml

diff --git a/Documentation/devicetree/bindings/input/pixart,paj7620.yaml b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
new file mode 100644
index 000000000000..d4f58b712810
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org
+$schema: http://devicetree.org
+
+title: PixArt PAJ7620 Gesture Sensor
+
+maintainers:
+  - Harpreet Saini <sainiharpreet29@yahoo.com>
+
+description: |
+  The PixArt PAJ7620 is a gesture recognition sensor with an integrated
+  infrared LED and CMOS array. It communicates over an I2C interface and
+  provides gesture data via a dedicated interrupt pin.
+
+properties:
+  compatible:
+    const: pixart,paj7620
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply.
+
+  vbus-supply:
+    description: I/O and I2C bus power supply.
+
+  vled-supply:
+    description: Power for the integrated IR LED.
+
+  # Added per reviewer request for completeness
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+  - vbus-supply
+  - vled-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gesture@73 {
+            compatible = "pixart,paj7620";
+            reg = <0x73>;
+            interrupt-parent = <&gpio>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&reg_3v3>;
+            vbus-supply = <&reg_1v8>;
+            vled-supply = <&reg_3v3>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe203..d73a0bf62b62 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1273,6 +1273,8 @@ patternProperties:
     description: Pine64
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":
-- 
2.43.0

