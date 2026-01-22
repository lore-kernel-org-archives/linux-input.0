Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC01D5CEA
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092977; cv=none; b=eZ49SS77LY/hPzeEb3lc4hmPXVnhsIvgbL4OVkC1utbURn6PzMtXvCorKQoLj+O6v5LNiGj/X/JHqxbWRQBkwjMgbUVM/00pQhUr88IolKBiqpBxpe67+hVq0poTZkh1vmyFvOuWwbWK1ggOUb1F23PC20fiFuIriVAHXiZ6R/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092977; c=relaxed/simple;
	bh=Cw0skZtBCGqWfjheUXINhljgkQzJdlf8/iK6PXySs60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZBu0noRI7uh/XLNHkBbyxcX+eaIJLpDM0Xjcwfl9o1/6DBGC0/dHT9hnC8chTzHNx0Zhv2umt6zB0rctNKPJAE1Twi2i/ZXy9rkqpBZg3FwNA8Qdr85Pzjt0Phg8Iyu4YsKu41gmgpkoE4SSg8G68qHv0hJcVzTgN5A+FX1XUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021139.outbound.protection.outlook.com [52.101.100.139])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-125-gL_8azeVNS60PX5GeFm7jg-1; Thu,
 22 Jan 2026 14:42:51 +0000
X-MC-Unique: gL_8azeVNS60PX5GeFm7jg-1
X-Mimecast-MFC-AGG-ID: gL_8azeVNS60PX5GeFm7jg_1769092971
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO6P123MB6721.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2d9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Thu, 22 Jan 2026 14:42:49 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:42:49 +0000
From: AThomas63 <andrew.thomas@touchnetix.com>
To: dmitry.torokhov@gmail.com
CC: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mark.satterthwaite@touchnetix.com,
	andrew.thomas@touchnetix.com,
	m.felsch@pengutronix.de,
	kamel.bouhara@bootlin.com
Subject: [PATCH v1] dt-bindings: input: Add TouchNetix aXiom touchscreen driver
Date: Thu, 22 Jan 2026 14:40:52 +0000
Message-ID: <20260122144052.358956-1-andrew.thomas@touchnetix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
X-ClientProxiedBy: LO6P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::18) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LO6P123MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc73aa3-baa0-417f-7172-08de59c483d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?//marZ7Xl37GZ36Cv6MR0gcu1/RM5tF1Hzcijyb3lfAvGEekYrg0V6IHFvIa?=
 =?us-ascii?Q?9fhIDnrmWo7MquMVPbZxp49ZihFXzpPsBTF28ChqVVGQ10RcMMQNpUCi/coV?=
 =?us-ascii?Q?5FlLOXpdPUiMZGUw2aJOHMNTBB1kIoW+Ltj7hffNzW7tt+P1NQw8I10Hk77g?=
 =?us-ascii?Q?kOT7xTiS1kecPG9KD62SUfojx7Xiu1ETnXzcaB0nVrrWQoS49dx/YWp9mBBA?=
 =?us-ascii?Q?oriX4NSwBqvDDakDgjMt4lYltSUIKV3ru7mRN/hRtTUbg9bCYcNbMfra8bCB?=
 =?us-ascii?Q?AzdtX2w4/WcFqYij0sASB4NyPo4AOtF/Cly7nqZBoMfXu8UXRAXXTnO0yF7M?=
 =?us-ascii?Q?vF8/sTwirtFJ4+nw5WMtDIYklWVXar9200RqCLdyfAvKGOgoASa6CGKmE8FY?=
 =?us-ascii?Q?h+AV3kCd/H9YSfbT4W42zSOgVa+r+mguHjHA/uA7Yj76PpSr9wEbPZ27WF9A?=
 =?us-ascii?Q?Mru5ozlhdTig4B2v+O2GfCmHjT0keUZwkul1a5Tqbui5o05hDU1lsGA+kc2c?=
 =?us-ascii?Q?mv1jMoN+4XL+bkq/vvAFiUPyTSMiaGfpoeE5qOj7+N6dtaES77/Kq4KVXBgx?=
 =?us-ascii?Q?fcpJs3ypli8wZkzoMBvScc/P5/aqyIAfEAMg8wWJ4sBGFUKGLa4JpsLD+w+g?=
 =?us-ascii?Q?OAQfijKXOvl+zUkbsMdpIgJmgBKD5JjpdCrq8eb6dBAwjzaRsfATnTjezOjW?=
 =?us-ascii?Q?yNsKkRdBRQfEZUhALLZ9HknxcUYHnWgnVSVfxmpJsLX8uCJnLG9wUhclOLz4?=
 =?us-ascii?Q?K+Nk63DuUCFll24lgVFSkCSRYBzkgTmnE5203icrivRTx8T2rGrRMnhKvOmf?=
 =?us-ascii?Q?PL2lGFhYnNbQ7MUFqdeXNlxMdp24+5LHfIanY8MO+B3iwEED3m78Go+G3AxB?=
 =?us-ascii?Q?XwNjPOHhhMBkvvd6G0Vs3p3yq7IvY0gnpmexs6ETS4orAwf3kIc/6sEeihiQ?=
 =?us-ascii?Q?QZq5Rtr+CUC83wiAIuqyVBhfyxWQl84x2m7sjKqngG1uV/1I9V3a61HkhjAN?=
 =?us-ascii?Q?DKqQt0px0bqSf3zHnGdN4P2Df8QKcec/dr8fmOovD621PjNwm8F5Nski4xpA?=
 =?us-ascii?Q?r08VcqPNDBXiNe64wsinK7/KwLGvVA6hYDHAu80fo1angruVlDR/lM8YZEH6?=
 =?us-ascii?Q?+AYqtIqZU6gua7CIVenBb6Gljo5sWEmI01PP8kl0/I9LN2ZdHpGMf3FCjqfk?=
 =?us-ascii?Q?WxEOu78C29ZQaNK0KWiEsSZV6oPdlcpos78+f//0t8SJ7+0R65wbqXev+Nf1?=
 =?us-ascii?Q?PqwHU1haTOZNCR7RMTaF9hixz61QLTEwxnab1IPx4Vn9IRv6RKODAdjNKRSp?=
 =?us-ascii?Q?wbDJPk/bdfioFgzGzuFLGLiYUiSMG+WFxCgecIIA03ie3EUnctVseDEvMuTR?=
 =?us-ascii?Q?ktEGq1twpaG5Rsh4oqUnANN9QcrGKJaKrPP5wy2PU/a5jhNgWHRj/2MEr1R1?=
 =?us-ascii?Q?SqlKmUUb/PIPsBvREu0mVQcAC8dc1+dLe5Dtxz4nQ24oQmhhdcd2nFs5Ulwq?=
 =?us-ascii?Q?T9OlhDzsd7at/ti4U8CHstLGK1FIG5Jc8Vk/1Z5N7UAZcUndn4mq/z/VKmsx?=
 =?us-ascii?Q?xO1W8ByTBw9x2cPE8+zTgU+4Z/TlFIveUXhuzQzO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ao/EeRtgtZNrfoQ7o9Ary38zbkKMtZ5O2x7+A+wyOcGyCTe/l4XnWV0Udzgn?=
 =?us-ascii?Q?JAGh7UOgEsJsxg+Ky44TkMxYopjd2b4+lBVVe6UMv26F1xTdgyujgz4QiUsu?=
 =?us-ascii?Q?JTEhBX0uva3t8ZVnyZmr4ZrwPHRGMfV8Dn/sKTSc/oRP9c1AYqQmVUyJrqMa?=
 =?us-ascii?Q?hPjKUzmGeMw7BCr0DgqbW9ZZOhpSb80S/f4pc6RE2fAdCiY0vUIEtSIO+50v?=
 =?us-ascii?Q?g9tmmrmVrcsFyKmXpTryP6rSfTHahNdhX3Aa2ck6q/nd0GJqeL8fCeKOq91i?=
 =?us-ascii?Q?Bn5O1n6QEK4UqI0I+MxteTopuyVSRe9Fjk7l86NVeI9SacjY60DIW9+WowaK?=
 =?us-ascii?Q?/EvSRe3YsK0x1pImOYA9JAKpFZCJXuQT/r28plzMpDmb4vn4F7vxsYtBWck/?=
 =?us-ascii?Q?Nyu7n9qMsygo7hVGwwnVTDEXm+S1B2COGqHyTl/rqWRmmXFW+2llRgDyV5Vp?=
 =?us-ascii?Q?LJ7Y6T6s6wF1+A1fRm68ljii+XIFKE2tCy6NrzGVnqOulanpDWHJP1WLrknf?=
 =?us-ascii?Q?60Pu5DuFMsQrXv3CP6SReWKR/v/xp9eBp6drvWZUhBYBbfL6LRhk+Ck5MsZV?=
 =?us-ascii?Q?VQeb3c6AzdoAG1lEvEnqWIrlMgQSlWM5OOryc3CJqcaXVEQEIuzNuohNI7Kk?=
 =?us-ascii?Q?2ncVrJlUyd/DWJYO6ju56FUvEwyUlFYL8Z31kesu11W/s+feQ0hBptuXj4Cf?=
 =?us-ascii?Q?W+KID0I854EHKUK5dd49NExOgJF2JpZuTEW1OHygXMods8jvW+HimIVS3g7U?=
 =?us-ascii?Q?JFMHssErycTsEYqo28lkRgrODUXo/CYs9uqfBJ7Ap4abspFOq89PdHaM7KU8?=
 =?us-ascii?Q?7uOxWHMwc4jLGNBRKlWYUqcZFOIXHvmI4dt5NCwyNzwUMimt+Dlqd2Obugke?=
 =?us-ascii?Q?9JjSGRmrQTIztQjMLiBdSQpPSdOo4sGIc8VOHcVzu2aoODgrrKH8xnVQaOVL?=
 =?us-ascii?Q?ASDcOnDHdasZnBXhpNfgFm24gKsNPpyO3FFU8oex/DRzSM5320FbOoFgvf63?=
 =?us-ascii?Q?Yu3TCWBqcSS110G99WyFffSvLLyYpRg1BQ7s80ZEO6m5q1EgM8wRYuif2R81?=
 =?us-ascii?Q?ooWFKjq3o5bsoErpDy6On/4mbDZVtKSEKBFEZ8DKrFnxwqH1XYlTIlNqNcbs?=
 =?us-ascii?Q?gy3vA062Jh8epcgChPUkwOaSv0JFGXVLn5CgycCSWCq51mH/nkpB2THphE4c?=
 =?us-ascii?Q?Y7bhkwIL3sh/OZGT3yUYQqqHl4aJkovkUnBjSKAAOZMiYjquRTkN+j1YpTGn?=
 =?us-ascii?Q?NFqZ382eBlDYFbUBxaMJB8HXyaqLzz3Zl6CUJgCDuo9tZC/ZPD5bDb3MitTZ?=
 =?us-ascii?Q?oyPdz+DdyyHsLyiuI/juD4ZIFYG6dW19pvdAW63Bk6oeLgk8xOA11wE+3x+x?=
 =?us-ascii?Q?k41v/kRi86kyiI/kc19yblqopWUu7cwag/8ilh5ZXmottQ+SPkLyNt6oWuYg?=
 =?us-ascii?Q?glSWs2kk2yd8/+fdJF7hzKncjYGNX+zsy62fCawU9m/FZeZSPg+wrA7Il8rZ?=
 =?us-ascii?Q?qVGHiNFMfRFzdoumEcvpyuopLFDRe+/KXn4SN4Rm0B5sM+a0fsf2/4sYbK/I?=
 =?us-ascii?Q?jsOG+Jeabx3uFpLpCo0UEBLk0AWI0pe16Ucg90Qx0SurzSnSqX2S9O+GQTnz?=
 =?us-ascii?Q?YK8cr3Hf3PHijkWDtgqEcDLM9ZyTKhHU21byTc1WXW7sjb0elPVok8VCZPiG?=
 =?us-ascii?Q?1SY1M6YB7L65m5SS/JgoLnWEB4nfCBwfMYsKgV93r9f1TTebSgCEKlsORxof?=
 =?us-ascii?Q?l1/unW1QaVqUg2PiPjVF/FAezFU+ZFU=3D?=
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc73aa3-baa0-417f-7172-08de59c483d7
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:42:49.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kN/0znctceNBbol91EHrTBSHNBXfyQDupqufud4BLbtRlM0OLZvKl6uZuP70JnveFUcFAtMLEI2ku4JVCqD2avv9eUOcCAGfAuCMFgfSm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6721
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jxU07UceKEakHBucx3u0t0aOCuOLS5sILfo5sgtpxZY_1769092971
X-Mimecast-Originator: touchnetix.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252

Add extra changes referenced in the previous patch:
 - Add device tree documentation for axiom giving examples for SPI and I2C.
 - Add tnx vendor prefix.

---
 .../bindings/input/touchscreen/tnx,axiom.yaml | 90 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tnx=
,axiom.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.=
yaml b/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
new file mode 100644
index 000000000000..dc2ea62999b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/tnx,axiom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TouchNetix aXiom Touchscreen Controller
+
+maintainers:
+  - Andrew Thomas <andrew.thomas@touchnetix.com>
+
+description: |
+  The TouchNetix aXiom series are high-performance touchscreen controllers
+  supporting various interface methods including I2C and SPI.
+
+properties:
+  compatible:
+    enum:
+      - tnx,axiom-i2c
+      - tnx,axiom-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  axiom,poll-enable:
+    type: boolean
+    description: Enable aXiom polling mode instead of interrupt-driven=20
+      reporting.
+
+  axiom,poll-period:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 10
+    description: Set the polling period in milliseconds.
+
+  # Required for SPI
+  spi-max-frequency: true
+
+  # Common touchscreen properties
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        touchscreen@66 {
+            compatible =3D "touchnetix,axiom-i2c";
+            reg =3D <0x66>;
+            interrupt-parent =3D <&gpio>;
+            interrupts =3D <24 IRQ_TYPE_LEVEL_LOW>;
+            axiom,poll-enable;
+            axiom,poll-period =3D <15>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        touchscreen@0 {
+            compatible =3D "touchnetix,axiom-spi";
+            reg =3D <0>;
+            spi-max-frequency =3D <4000000>;
+            interrupt-parent =3D <&gpio>;
+            interrupts =3D <24 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba..dadfc7036ed7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1636,6 +1636,8 @@ patternProperties:
     description: Trusted Logic Mobility
   "^tmt,.*":
     description: Tecon Microprocessor Technologies, LLC.
+  "^tnx,.*":
+    description: TouchNetix
   "^topeet,.*":
     description: Topeet
   "^topic,.*":
--=20
2.43.0

