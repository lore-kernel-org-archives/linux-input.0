Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022132.outbound.protection.outlook.com [52.101.126.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADBE3CB2DC;
	Sun, 11 Oct 2026 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697356; cv=fail; b=GCVs7+gAgtEhtsEvTrbLOInYmEPbsOOdguPKLtN4R0ZI+k2X4BG7TF+mcKapwSO3I8ptQLj6jGuGTL0JllpT2Z2a5eTF/kLiYBOGSZcmLW+xpdbAwoofvpejeqLQ0hM8AvmewcOx/Ejj32wTwBZNzgWzhBOHNgrj/iAeGHUlpJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697356; c=relaxed/simple;
	bh=6yPNlaKYexgp3CFzVzylgIUKW9huk2YkvayZ3ngQdcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dH7+zfXHWDs/CQr74dukpQrzRZGjiPe/hh6LzBYMWIQP1PgIeUCyvdxauL3yRBtz1vjzqViEp7hZE9Ia6dI5gCBWRSsTxEQhh1yDuJ/evQ/REPZCqy6obrI/tL3uLoKAqwBRVRUTkBhnDsgGU8HMQEVGaTbwHdLIoSrxCQix1RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=e6U7tdW9; arc=fail smtp.client-ip=52.101.126.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="e6U7tdW9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrsFAOs0XwZVZmnpmeoXCpn0lbBpTSMxXLP3tqaiM6pwATJ/JhTghA0mnmV6sMjLhtVAh6h/t09QeDdxrA7P6MmM4q5JnzatWf9iHrprzc359irToGgut21SKWAIH6b5zh7Ii1Y4pGHYexJZok95vltqnBKnjTiy/6vCgaEULzZPTiojL6nEAlmhwNDQGnntIPekebm3ME1xXzzzx0H+Uzu4RQVC/YJuYH8dPnxUgNXBfLqNdn6U9CPcJa7Fw0oNtYgDMiK+oWlj7bqEnPIFcEYTZS4VA3Sp+CDOBMtLJVz8CykCHiF0g4Hd4aJsfCbb55Ki33pixGKPLN43pO7KMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg2tklBd5fIN8qKLh1DKu4uc2mZhAkskrfxUX2Mlfyk=;
 b=PChRuP0q7stb/4dhTv4kYGvCQzCQy11T3egHOArlXdoraJ5mriTxlex1fu7UZ2JN0dK72U3SIm1m9J6dBxVi2Lca7H2Kl3YB9trK1SvO/pEX+3xAwFnD7o3B3vOBrGJnizDLevTrOX2kvfckW4cy2OMUcjyQlDk4K98WjIv4HTE/fUhKg4egnW4HkJUYIOWT6utdmUfD6ZCCKYHAiDMi0AN54hXyrFP6JnHzLgJ2ug+HWJQTlznI2gicc0/Ox8FjMFGckB26z5j0FTNnIsYAR9m6V87++n0wUkaTKsbcj72SSsF5ll5gSBOMoZsUKq5V8TkKhvV/dETCFVcy53DWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg2tklBd5fIN8qKLh1DKu4uc2mZhAkskrfxUX2Mlfyk=;
 b=e6U7tdW9iFo2yTP/1SvS8sx4gnmakArsF2uwefiI8gWcoGcgl3tsNA++a/VA7+n5ApsvS8GYVXIQY8JdpC7y676I6KH0s6GVSTf5UC5OGugNi/XCSwGraisMXBv8EnYC4hw7wqAieYW3cNO5t8HLfd07XJ3scgJBUSAcKh9VcmyPmJD1uTVF4zwApya2QgeYOJQ+KnPEz32+MGmvtFgz2cn3l6IV//mir6mFuV8ZBpfRzkL2Bee6yZ4cWH++rgME42naHm35v0LNqLG735MvX617MdxEibnel7m3+mKd1TM/fkTu/+CYl/dDnBE/VzLQzldr3pbhn6RLCW2r9MJQog==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TYSPR01MB5702.apcprd01.prod.exchangelabs.com
 (2603:1096:400:42e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 05:42:29 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 05:42:29 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"icenowy@aosc.io" <icenowy@aosc.io>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
Thread-Topic: [PATCH v2 2/3] dt-bindings: input: touchscreen: add Nsiway
 NS2009
Thread-Index: AQHdWUNNxBqkehRCcUSRS4G0YOkUxA==
Date: Sun, 11 Oct 2026 05:42:29 +0000
Message-ID: <20261011054223.93396-3-founder@crepuse.com>
References: <20261009144729.85832-1-founder@crepuse.com>
 <20261011054223.93396-1-founder@crepuse.com>
In-Reply-To: <20261011054223.93396-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|TYSPR01MB5702:EE_
x-ms-office365-filtering-correlation-id: e3e73dad-2bb8-4a9e-bf10-08df275a7077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|18002099003|22082099003|3023799007|38070700021|261009223027099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 etjhQaLbrCgBMyIrWzFDI9ct7oLM6P9uyHprAaUdrAgT07LV6RD61OVwfYZSoaBZhznuDSmrTUJJLIenphXmL21hFrA0wDjZbDG/tu/xuNSLC1qL0iKGO84qIKDwzCDelNEBSi7gL5+zB8iio6TEUlJonXXSexjSAvj2HJatlb/Xk3gZmV4Hyr2nBWV07HSEZ73ki6mO0fwuKLARIPbqlaEWzkialPPa4CjcPIYdMfo4BXTZSCNuNtKklGERiwmUphWmPp7FEL2RRnZQt65dChZSnXUOdAFybh2mdA3Du4JWbXFx7ZP3CpfK/0QAv/UMc3cfMmlZTHpI7jy8ZWnocWiIev4iwEknfm4fH0ytAMpM1ptyCjxrNSSNbxqmJHmcMikZUmCdY/pb1KHdVrSZaixdRWbyc4nhhOJzEqSWYa6kNPqBIp3QwzFnmZmHk65gwtiH9fvkKZy0fg0Vq0g4KzlInQwFF6+oPn4mkkUmH5NhrKfazVtXhM3l7fuUD0GQNcub06tVegP+EzkHq6xn8EN9LGjWqtwYWc7ru7DJ11seCzW5/rL3k1oAZhOr5W+3PSmEqhjMGp3zqmhTmpbQV5/lDSKQ4axH7RKjOgt/5GCtWEljbSZTSjCH9iYMG9fvPdYbMe0DT7wyE2Ee50y6eE5f4XXgnnndJ3Pc/VZSqqg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(38070700021)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rBW6yNKNP0qMHyXft2DfRVhgaprfwBk41cykkkxG2rJrien5nZ4oFs/8ZX?=
 =?iso-8859-1?Q?Va5W18+s/89DmQ0FxOnhHSKz+N6Hbx5Y4Buv8o5AC/1j5SmJNvbz3uPAEf?=
 =?iso-8859-1?Q?YqwqgYjhhX24qtakMkqUB1YFajrGYsdawGc5Oc5Ip6muSi0iq+DSeJcWqq?=
 =?iso-8859-1?Q?AqA83UIoxaYkyfh0uISLYwh5z8TftTze6qUQhp7BtFwwZrHOs9wQwMEoSm?=
 =?iso-8859-1?Q?M+NNZodzXQMYJifZouQuptHmgo7649A1DdW5fAMAvRmyO/T3hMeK7gcXMc?=
 =?iso-8859-1?Q?vzdx85HF10soseZ9vNx4zmaD5J+VfZDJmF0HExRoupl9dBQ17mdi7ZKvrN?=
 =?iso-8859-1?Q?PZvTAUPpHFzGAJFTYYbrAFZxBWXnP6gOgGl5Bx5feR31nQqUalFyCP96rX?=
 =?iso-8859-1?Q?SWdoI9vAUcwYrIkzphi2FpkGuVQE6G8LOgU/Ji70sKmDjjVmc1u94HboEH?=
 =?iso-8859-1?Q?2Us3SIdfl9T6hYtgeZdncMQUrpJDh8ieiI9m8Onbyi0jAboxKB5UvcbI9+?=
 =?iso-8859-1?Q?gxMiSgZ7ba4HeZZnXs4UvREo+GgPmh+VGeD5JffBV+ESndMQwrI0+4dyTp?=
 =?iso-8859-1?Q?13evEpOgE965wFCV1IIQr6pEK2FGdjgujUpP5m8Xy0J80M5vNhBl56eNJ6?=
 =?iso-8859-1?Q?MS0mqsQDgokO8DI0ZrFZY7wFdbTlpKjMLQeJYkR7kE2XMEsSnch9TmK+3i?=
 =?iso-8859-1?Q?OJTBC98qng468nFkyjcEcadrAKJeD8f19yhVXO0OWp6Qi/n7bLxIog0gqN?=
 =?iso-8859-1?Q?uwp/aDs6zwFGdEfhQXZ2gbDsSPuoJp2B8It4WgOYmJkeq5YP8TF9bKBeFW?=
 =?iso-8859-1?Q?ZOherJbVJ3IWV7Ds32Yslkk8GE166SgMRK5vgH8BTFfhCZbbT3FZFfIeuX?=
 =?iso-8859-1?Q?OINQREfNH1u8ZqTo9D8DIIfrNdkYNv/9CSjezPF/19G+gQo+XiGOFqhRnU?=
 =?iso-8859-1?Q?s33gpXYJQNWSY2zfu/Xa/mIiVzriAPesi16C8jPIamNrSR7USzo/3oJ4E0?=
 =?iso-8859-1?Q?S8fz4042y+nT/PSnBvCb92QI8GALI43s9ap6NHkTFQF88olnVAEDR/Ncfl?=
 =?iso-8859-1?Q?H4uyv+yzOyZ/ve/iTtU17yLej6g6SZ8WwjEyM6SFBB6339/WVKSOFu2V6M?=
 =?iso-8859-1?Q?vdi6Lv3uqRO9AKQG5/VLmOwrOn/ztQBoIYHMSCT7iSUE/ZxbyAAMO4JW6A?=
 =?iso-8859-1?Q?64hLVRB6FyjbmzaYTXCvkDj1tQbO43JEH1vxFF3vrXGLwhWomB7GEANysd?=
 =?iso-8859-1?Q?K34MF7d+XWrWjNNE96NEuYtIFWfa4yHTtLV+Bvqwl/0JjRiI6V45A8Us8W?=
 =?iso-8859-1?Q?X/u0V0thovj8LBRMD+iPVw9ebb8l+7WG4lM5kRaQGyhMvHYTvb7QnRL7vN?=
 =?iso-8859-1?Q?6E0J+0B1H2GGb3AvenQsH7IH2OqOdRPDRCUJe4yYOslLnoWtuxvoDrirwa?=
 =?iso-8859-1?Q?hlhjIGe1KPGj4VDMr4sXVrWc/mrsmbl3oGtsrmW2LHfNcCfYYN7hXmGX4d?=
 =?iso-8859-1?Q?FuGPvBQPVidgE3Vh+M4bNwCSR6fCejh9gKK7qU1u6FMbmuFQXHXipO7mOs?=
 =?iso-8859-1?Q?qk1Hp9Kxr4dOewFqt+zioykP+hw5tOAFrZSOnwbA8pFNkYAXvZEnISFzui?=
 =?iso-8859-1?Q?SqehlZTheyWw5VlLLJAEQiTf+y6f9LdVcknJzOqkktaWIheNNv1ekMS/uV?=
 =?iso-8859-1?Q?MVVUMJ4KoMoGJFR/HgQxonOulJFtvtFtyJGb2FgS+wVihLxn2p5xw7Dbso?=
 =?iso-8859-1?Q?7eCUiZcwdU5p5+DwuJOCcevaJkDwHw32HOjp1FsLMEXES2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e73dad-2bb8-4a9e-bf10-08df275a7077
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 05:42:29.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+9gCKL0k8T0BdGlVFlK01QMnqyUoDE6LaUEvMUXC052cUeIXgK9O+atw6IXGci91ChY0R0GUGysS5rkxE2+lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5702

Describe the Nsiway NS2009 four-wire resistive touchscreen controller,=0A=
including its optional active-low pen interrupt, power and external=0A=
reference supplies, and touch resistance measurement capabilities.=0A=
=0A=
Allow the common X-plate resistance and pressure properties. Include=0A=
both an interrupt/supply example and a minimal example for a board with=0A=
an unconnected pen interrupt.=0A=
=0A=
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>=0A=
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>=0A=
---=0A=
 .../input/touchscreen/nsiway,ns2009.yaml      | 104 ++++++++++++++++++=0A=
 MAINTAINERS                                   |   6 +=0A=
 2 files changed, 110 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nsi=
way,ns2009.yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2=
009.yaml b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns200=
9.yaml=0A=
new file mode 100644=0A=
index 000000000000..43523f40dcb8=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yam=
l=0A=
@@ -0,0 +1,104 @@=0A=
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
+  I2C, with a 12-bit ADC, an active-low pen interrupt output, and support=
=0A=
+  for an external ADC reference voltage. Touch resistance can be calculate=
d=0A=
+  from the X coordinate, Z1 and Z2 measurements, and the X-plate resistanc=
e.=0A=
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
+  interrupts:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      Active-low pen interrupt output. Optional when the signal is not=0A=
+      connected.=0A=
+=0A=
+  wakeup-source: true=0A=
+=0A=
+  vdd-supply:=0A=
+    description: Main power supply.=0A=
+=0A=
+  vref-supply:=0A=
+    description: External ADC reference voltage supply.=0A=
+=0A=
+  touchscreen-x-plate-ohms: true=0A=
+  touchscreen-max-pressure: true=0A=
+  touchscreen-fuzz-pressure: true=0A=
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
+  - |=0A=
+    #include <dt-bindings/interrupt-controller/irq.h>=0A=
+=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        touchscreen@48 {=0A=
+            compatible =3D "nsiway,ns2009";=0A=
+            reg =3D <0x48>;=0A=
+            interrupt-parent =3D <&gpio1>;=0A=
+            interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;=0A=
+            wakeup-source;=0A=
+            vdd-supply =3D <&vdd>;=0A=
+            vref-supply =3D <&vref>;=0A=
+            touchscreen-x-plate-ohms =3D <400>;=0A=
+            touchscreen-max-pressure =3D <4095>;=0A=
+            touchscreen-fuzz-pressure =3D <16>;=0A=
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
-- =0A=
2.56.0=0A=
=0A=
