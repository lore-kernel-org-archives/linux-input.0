Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022073.outbound.protection.outlook.com [52.101.126.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B04E781A;
	Fri,  9 Oct 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557270; cv=fail; b=McX5k+xpHGHyABbRll3/r0VzWrpzn0DPXUA8wh2dDI91BCA5+k5P9cXg56Kq47XZb7wQUTljWm+wTLE9mz86VCY1kMS3s6AIYXLX8ebxkj7tPC9dVuN0VfIw7Y85pIyXktJBwAVD0wqPwcv66kIt0fwB2k9auq6cdAim8M0rEaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557270; c=relaxed/simple;
	bh=4T9Tes49iGIpuIewsLLeEbSWiMY7GPgkldbYmpFwDmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s+kWIf+c5uzU8fRclSNOh0Uf+m+/0TBhqvpW1xntYZx1YsXrHhxyI0WjsuhB83I+Q2OOvVQ1Fd44HgDzv/NuO2s7ZyPSaR7GiX/TuPmX0gFtV3NfJgO2bzMLlzpNAeSkDYjDcQc/RMnh7u96MB2B/9ppartXIC+H0zPjEb/joAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=k87XtXQx; arc=fail smtp.client-ip=52.101.126.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="k87XtXQx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oub/nEA/baTcjoS6nb12Ztb7JFqmDJUhx4VboWqASp7s6SpRvOsBlj4FMTirKJavWvRYlgWcnfZf5qWfhZCrpjcq06iWro/CRNBC29ZobtMngKRx4cZjQ3I3hO6rSciEYDjDRyI6+m1GI5WJt5STIKKmpUAU/nsa0Zt5Rcfd3bWJvvFhUfFhszgPtWJMRoDmOc0/rQqez9tXLOlIeFqSOkXiK/Y2A/EZVfs6W+VjZU8f6sniFZLWIcjr895wi2V8O8wv1TWpYBa1FBWJvp+QS9eWhHbbm8LXJUAYmJD6RwLbA3n/nFV9sKgd/CELBPdSxo5wqoe8c5jNkYU+XRMBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MLgkBVPx57doncMkn0o+LrGzkQ5K3DRtPCUUxhHKvs=;
 b=a1OKhq/KphyUFklQFRba9dRU55exMPivPzA2YHnTGd5qLDGWnhVk5i2Y/6vWcTo1ULnsDVFa6BakUtI3TunjFYnc2CMwv9DvKMGPUcOnXrV2j9WE99DZIW1w0zwE09U2CzLEyXaNi603FotCYrtkK5UFm3Ef01yH1GkO73PVUdloMcJFSASXTAJYHzkUfnzzzBQTgvu5WtfXLQYQnDx3aASShbSuUd/OV4PSIDrllANx3aWizXpjzI83bhTIj4D7pvQ6/g6623+OQHWrkMHqGdAVfMTcaO8c0ZkdANKex2NokmAL0ww7++ZhMGqm//wDY34Qb4qohnueddS71QThVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MLgkBVPx57doncMkn0o+LrGzkQ5K3DRtPCUUxhHKvs=;
 b=k87XtXQxn76QzALyY4julIZqPXDyh5z/nyr/f8pM80xOf1gqwOFeFUaj+jS+4AOZJxbE/qKElb8rPQmWS/qeUOurHaPNRHfhab4LEVIoPYtvWcseH4mtz7z0oKIF5wJHjvkT6GKnQ/IfhjsJNeBouYZYRRM5LRO9hUcGqllH3rLHuNzECrZA0XaFlTC/g9Key8xQF7WUEBzh7V4pbPcUBsICyN2A+x2iB5lroNy2y1aH6/hNHyLR4J+GW4ndLaGwgubVfDsDKV0Z1xO7pxz/4tjgZE9BzUqgiX3hCQxZUc0ZNeSsGI0pNQkmUwynVEVuAGpq6fL46hC+uD+tXINOaA==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by KUXPR01MB8095.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:9d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:47:43 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:47:43 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
Thread-Topic: [PATCH 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
Thread-Index: AQHdV/0jNYlr2St/uE+HXBk2R9Gz2A==
Date: Fri, 9 Oct 2026 14:47:43 +0000
Message-ID: <20261009144729.85832-3-founder@crepuse.com>
References: <20261009144729.85832-1-founder@crepuse.com>
In-Reply-To: <20261009144729.85832-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|KUXPR01MB8095:EE_
x-ms-office365-filtering-correlation-id: 8ad29200-a930-4ebe-4450-08df26144659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 8mhJoCLZMqh4MgpHiREnfqDL68CPmaGEl02rkqplS22F/7z8FDB8h+yXV9EXvU/CzdMREeVG48lHBuKzvWghzJRJOtbCR3sHjpiRhj64Jeojuqx/6DO4wuuS95BZnFmmdMYvI5ZGyeW26NOKhC/RFvTbJOrLM/j8s8eZMGAPQ3mdWJMENKoMJJi3F91GmBeMgxYKTxDRAmmWZ2eTC0HoPs9PkyT40xRFiI6UTyO388lR79hP2zLkluyoTY7i1xK08u6fQfI1uJggK6eVSdIJXS/4OAlKHSgzLQWJQEjI69YhXWc/Noq+dXY0d6XhLiUrhp7Rs75W9E3wIe8+dBvcr5BhjHt49umEG2VaFrbpw/XR7grewQxnWhk98gwcBuLqu5V/JAAgUDM7IwYZf9xk9as6NGJ081X7GgLWmGlEhS/OhAp6YgbBPUMtvvk+H9ONaKJ7rbwGYYagfkZ/BLNpevYOzC8jU7T9RyMdIOJ84RenwQi/9932GYE6vboOQr6Iy4fDmER7T4Rw4HuS4bqIiCo7JmZJ7dalXVP0SKZUoASUrtVwHyVaHveqntY4n4G1L51FFWUToaxmD2yKTAIrLN3uFXQ2rwxukP6Chre+VBr5z2pd4N2Kxf0B/T5KMoHE2N2/5C4TujzW96l5kBY1+xXwGyKpcFRsJl9bisK28uE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?65JbhL4pJrfcD/4ekUaW2F1wXJcMt8Cc4lOwLHF2rd5jfVMcVg0uVDUZmb?=
 =?iso-8859-1?Q?8gozLHH6OxKK3+xH1TyraKVHYEvaQKn7HT+1cohIKBMGsZ2yDAHhh8fdBS?=
 =?iso-8859-1?Q?K+cQe1LLHngoV072JRZBhbNNodza2YF/13vbGCKKVk/JauyRWU8dzAozS4?=
 =?iso-8859-1?Q?o3SbSqhrbkF4iTfOFLm1QTxyX1ZBq4qZW7nKZJIiRvCmETXIg5ULMcHIeo?=
 =?iso-8859-1?Q?ODPJeCB5Inz35BXLeizNLARR+YVUV3PTHbk4LT9/Ic5rZ+yZaktINPC4zg?=
 =?iso-8859-1?Q?66aTmXtEElbP0T1d1JL15yIhc43qJeNS2g2nFJawPqcXGW7Iw1UnxFbd3r?=
 =?iso-8859-1?Q?ZY6niMCqm1iwPHRvT2nsfTf/CvOzp2N6yvqmuM/AnX4dPBsjk7f2/P5YJq?=
 =?iso-8859-1?Q?/R2D9fZxuWxVNR7TXH7kvP7PeVSvdhqtsujCgwSwHmhiOsouawkpMvjk+m?=
 =?iso-8859-1?Q?zCpuM5Y0pDGQaH4/qVqjnDfYSkTg+XFgEeNBuAXfyXledb3S8g7yrJQOlh?=
 =?iso-8859-1?Q?j7NIPre2UTeJHNra8x1QhhdX3fCzOIrkRBjJ7VvQdC09aT70xuzZoVrQk/?=
 =?iso-8859-1?Q?+ES1pNwS4s3EK1tWzpZ95YQWB00Nb0NMXPLrMahXBj9ZRClUnnUWbeORKG?=
 =?iso-8859-1?Q?gjlHm4kEMK60oOk5zCm6re/aJz10T3CXBahDsmn2RVM1w3kwkgkVteKOiq?=
 =?iso-8859-1?Q?3Ppqx1pp9JtVnWiV8VNd19/WslgNX3KFE3PzTNpOhuIyniZM3FvQwmSbds?=
 =?iso-8859-1?Q?TxRrBNbOK5ZUK9vtCU+8sD4Khj9CqXNveBH/jxby1ioDeZyqSlA0MW+9Yz?=
 =?iso-8859-1?Q?qaQeIDj8jfdt82um0uRxgGuYPyEbJhTEuC0C5aNw4eeOw3+uSBJmbfr8Jt?=
 =?iso-8859-1?Q?51dIFhc4dOXuqryMBJrjayok5cQUQV0bkNcowzB00s7H0rBPdelCPRv/0e?=
 =?iso-8859-1?Q?fHgHghzVHu+oGmpcpCPHQxaCqPdGYO1dSjMWALjRtp7aMH5UfRg8a91Nk7?=
 =?iso-8859-1?Q?uzB5ncY5pBGzxAGdMezahdpQy2ZTAILSO6oIgOcMhwKVD+BWVfI0YCSKOe?=
 =?iso-8859-1?Q?E0WbjAN0kbz3oat7iokhJKhBHvZ8b9xITFL3d/2vhCwPxNGaJA3HGlhzmP?=
 =?iso-8859-1?Q?AVnwZ3Bm06GOUF7YjUtSlxItWAVlJJJRsLzcQJslaveu2d4N3a+dqR1Who?=
 =?iso-8859-1?Q?eHq0lA6kktZw2IjNjWvEwNNmQyoN1dBifEp6iq6yw6OgqkIob3MfT/QnO7?=
 =?iso-8859-1?Q?YVM8rJiTqEiatGah2t14N40WprWjgAWSwIwr8y/4Bz0elegtnb7WSjhJr1?=
 =?iso-8859-1?Q?HZ4VLdEmgO5Amlyl4dKRA+GTKhHhCtndAZIZQCkH+/mSX0FNG1vnazRZBk?=
 =?iso-8859-1?Q?JslAFPu47PV+apULLb4MbxT/ZjEAs5ghwIGjbjnX6TOhplcP40G99jXd6k?=
 =?iso-8859-1?Q?K/7vygaqD4aXKCFlTu8CeDAJqVF/k78zS9zGcPOlXAmyThs2LNyIgSN1JS?=
 =?iso-8859-1?Q?QxJVu5A1EaBk+rSpymSCPRxLjDbUFltQc5S7hG5soaOtCve8BTaT4poz/h?=
 =?iso-8859-1?Q?V7o0k1qPTilhl9JRjiyyM75Ms2FKk8xWI0MQXGumsyx87mI4x5n8pwVuqk?=
 =?iso-8859-1?Q?jlv9aaawdkv+K2H7aoU+Sa5vz8axSRkCQqHQulWHcARFNe4P5WlPn2Ws8I?=
 =?iso-8859-1?Q?yC+0LqtD3F4kQO159VQphGxUOMksj/irqiJze/9BxzQjsV0ht/pufNVhnf?=
 =?iso-8859-1?Q?BUhEQ8wsvFrVKdjqV3UX/5YbEITDB9fkKZO124jDUupYD1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: crepuse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR01MB8186.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad29200-a930-4ebe-4450-08df26144659
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 14:47:43.1339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ih8rX2AENp31SJMf/CWEdGifrvCVLKsOO3xeJqhd8/mKs2dxwrPlXnViAcT8voh80P4qftj6E3RM58Tyw7KUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8095

Describe the Nsiway NS2009 four-wire resistive touchscreen controller=0A=
and the properties used by its polling driver.=0A=
=0A=
The controller returns 12-bit ADC coordinates. Use the common touchscreen=
=0A=
properties for coordinate ranges and orientation, and allow boards to set=
=0A=
the raw Z1 contact threshold through touchscreen-min-pressure. Limit that=
=0A=
threshold to 1..4095 because zero cannot distinguish a released contact.=0A=
=0A=
Document the historical default of 80 and a board override of 150 in the=0A=
example. The Z1 threshold is for contact detection, not calibrated=0A=
pressure.=0A=
=0A=
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>=0A=
---=0A=
 .../input/touchscreen/nsiway,ns2009.yaml      | 64 +++++++++++++++++++=0A=
 MAINTAINERS                                   |  6 ++=0A=
 2 files changed, 70 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nsi=
way,ns2009.yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2=
009.yaml b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns200=
9.yaml=0A=
new file mode 100644=0A=
index 000000000000..04df7ba66a4a=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yam=
l=0A=
@@ -0,0 +1,64 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/input/touchscreen/nsiway,ns2009.yaml#=
=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: Nsiway NS2009 resistive touchscreen controller=0A=
+=0A=
+maintainers:=0A=
+  - Mizuno Miotsuki <founder@crepuse.com>=0A=
+=0A=
+description: |=0A=
+  The NS2009 is a four-wire resistive touchscreen controller connected ove=
r=0A=
+  I2C. This binding describes polling operation without a pen interrupt.=
=0A=
+  Coordinates are 12-bit ADC readings, not display pixel coordinates.=0A=
+=0A=
+allOf:=0A=
+  - $ref: touchscreen.yaml#=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    const: nsiway,ns2009=0A=
+=0A=
+  reg:=0A=
+    maxItems: 1=0A=
+=0A=
+  touchscreen-min-pressure:=0A=
+    minimum: 1=0A=
+    maximum: 4095=0A=
+    default: 80=0A=
+    description:=0A=
+      Minimum raw Z1 reading considered a touch. This is a contact detecti=
on=0A=
+      threshold, not a calibrated pressure value. Boards may require a hig=
her=0A=
+      empirically determined threshold than the historical driver default.=
=0A=
+=0A=
+  touchscreen-min-x: true=0A=
+  touchscreen-min-y: true=0A=
+  touchscreen-size-x: true=0A=
+  touchscreen-size-y: true=0A=
+  touchscreen-fuzz-x: true=0A=
+  touchscreen-fuzz-y: true=0A=
+  touchscreen-inverted-x: true=0A=
+  touchscreen-inverted-y: true=0A=
+  touchscreen-swapped-x-y: true=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+additionalProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        touchscreen@48 {=0A=
+            compatible =3D "nsiway,ns2009";=0A=
+            reg =3D <0x48>;=0A=
+            touchscreen-min-pressure =3D <150>;=0A=
+            touchscreen-inverted-y;=0A=
+        };=0A=
+    };=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index f53047aa8d3c..696f2badc49c 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -19467,6 +19467,12 @@ S:	Maintained=0A=
 F:	Documentation/core-api/symbol-namespaces.rst=0A=
 F:	scripts/nsdeps=0A=
 =0A=
+NSIWAY NS2009 TOUCHSCREEN CONTROLLER=0A=
+M:	Mizuno Miotsuki <founder@crepuse.com>=0A=
+L:	linux-input@vger.kernel.org=0A=
+S:	Maintained=0A=
+F:	Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml=
=0A=
+=0A=
 NTB AMD DRIVER=0A=
 M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>=0A=
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>=0A=
