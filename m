Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023119.outbound.protection.outlook.com [40.107.44.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2F47CA68;
	Mon, 12 Oct 2026 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807439; cv=fail; b=GziqX1Rlp/qGnZ+aga9qyK/JrgtbMrcImXfPy+pjpG3kPOVHf2zErFq7scuhv2XNM0mVz0Pwre4kuC2tJljSzqv0yLaOGfFwwKyoJFCSPkjytw3K0W4I75otFUG8JySyg/wa4p0FOIBGs9dPIqojMEyrYJxJ/eLnKvxnKXiflIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807439; c=relaxed/simple;
	bh=yYnHhSOozMWjs1tkbTmiuNCG2vuE4yUqYzwCxl8IE/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+zsozf8tznS4rkxryvgVJ62zQFLOlpjKugCbLh/xBVomlMor6q5wNXMfFnuvA/smiAgqr/z6+PbPtNXiBgDfmVadqUFARGCO6bya+vhfdbfeF4NXaraTA6cw7gNYX30duuG7EjQJIEGmAgeN75OF/txTG7L2d9hE5i1q2CiBU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=WsbquiDs; arc=fail smtp.client-ip=40.107.44.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="WsbquiDs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG6ICl1Q10gfnWgBC9GL7ve9SceCfkRG28MmQmAleFbvMu7ChJcHC8F8hKMHeGoIpqmqgVvxWdPg+CP0bNVodgiDSXKOP3I9sMMSs1V+NuxSo9dLiL6gqeTXJLyb0OvPzc5nVp+0gPpGyyK+3I0Li4jyBAQV2fT6qcPDRi8xY0R7KuFDL6JpIOr3JcAMOQzkqg4DFCR98mJJkxL8ZW05eeKd/jPtYSiPMymxLTehiB1DnrIAOMEDrsqcGjr5PIFCEkhjx8U8ij7tgz82Wfv9TDxuo2uhi8Vlql57eK63gZtODfpwsY2yvolz4FcIEizW5mppbmzmJa8lc5uUOwecJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTXNPTIiy2eC/jOzX2NOCoufouphib6NA3rllXsQU/w=;
 b=ZI+vK8mr3kgqyf8TbbWkKHIk9T6KsqgtcMk87sd5Z3Pv9jac1ulTvpLiFQCAbQxM9aB+nyc+ZWyT117kmCqI4KQD6FPCtlhuVRXR0LtHPCSL4s8cRKwv8z0p8aFueAPu2KKT2OybnN/eDON8+molk3WK+x8EGb6r/6xJZvklGVpU9rsdg3tHN60qHj8+xlWpCg9KBigNMb0pYTv5ylOQQAq+aLswws70MfcCNZ/SUbl7/hZoN7mQrzj/i7f7Nnui1PTTyXIHBv4Yv22nLnm6kSElxK/0nWpO/IjqDt0oCJj4dBTqVCrKzdZbGcX9AXFJFrb8CtuRYCTXww2Oz+qNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTXNPTIiy2eC/jOzX2NOCoufouphib6NA3rllXsQU/w=;
 b=WsbquiDsSfUJc36iIBCHe6wUuoxzNrzfN1SXKmXJZsY9K0NnseeUaHlbHPgZJOB9TOjina4UTfzjOrl53czvGtfizNQ/AwCH/KdFBb3AUg9ijDHDdIxGMbBo7lNujaXGODMbN4GYczsErfEWuKGfyIeqJF5CbIFmsw3URVhktvAj76DKFjv541a5nLmvps1Wap/KnU8+l6d4K1HkKTYkZ7Q6yqa2jNoLcuesAVqV+T353sbGw5F1ya3VL2ctR2+3k1HpfHQ4bRqoPPc6jsnlDtpVVfY+aP86pi3USOvAJentbEqarxOXEHtl3KmEJdrXXLTVzsZEv/5v+GFIR6q+oA==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TY2PPF1753F85B8.apcprd01.prod.exchangelabs.com
 (2603:1096:408::389) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 12:17:08 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 12:17:08 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "icenowy@aosc.io" <icenowy@aosc.io>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
Thread-Topic: [PATCH v3 2/3] dt-bindings: input: touchscreen: add Nsiway
 NS2009
Thread-Index: AQHdWkOalXj34gOswkeOPjbDMzfoxQ==
Date: Mon, 12 Oct 2026 12:17:08 +0000
Message-ID: <20261012121705.53396-3-founder@crepuse.com>
References: <20261012121705.53396-1-founder@crepuse.com>
In-Reply-To: <20261012121705.53396-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|TY2PPF1753F85B8:EE_
x-ms-office365-filtering-correlation-id: 8ed9bed5-2657-4fc0-3a1e-08df285abc94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 0DIHANKb+wEwyh5HI1qK1AeVXpecPLg3575iYleayD9mYIymOI5a9/YXaz4Ts/ecGDcczrwcaKSgC39pYt4YtTPZp5azR9hI34pPSQL1b4BeMjvJMRBkQBX0et7aUiy8ioT0YytRMHUxud+mYEicmF9//YEC0odEkLu14i44Kp3FMp45pJwuwRKQlgZ7F1q7iObrC7RKNfVkeWVqSdY+cm/7wHgAyvpQrAY+2W1z/I0r/x4NGXgvh6x25Uv+02YlU/Z4V/IiS8yr5OEpWB+rWMr4sPXv6xbB2WSflESTJjXhbKfSYhFiylqhPAey6519YGMGJBqyiFzxSw8rZerZJeyovMaccI+RMlqt9+C+nIelAZpPSkihErUXC9R5sjH2NymWjubrktdq/v29ibd0wYWaFj+PVjDclZtRtfNngM068cy0IiKT87OxhsoeYmHp8EqmZWH2Q91pR49GnzaRBPJ55l+QUBd3H7mOkUK/v8y1dK3TmCvY4FOz7N09j/zMSKDbkzh+Px2/BW95zmtTzLcZagd0NWCdqkHy0Mjjma+9dr51YFniK9aj/T9LA2flfPFceKHFEgV3c68czvy3vjqdgDng+PwJ2mEHj6xDp5sGlUSF4dRGBB3MdqkDzi7vZSNLI0ED0gphYnHaAo+ImXBUWlhIAlwF+37M1NTn90k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+AIGYxFwEtySz9ODFCr+aQkI214xwtGPN0uOwvXv8mncJ3tmtAO9NO/ZL6?=
 =?iso-8859-1?Q?77xTs5yeNqg+N+x6oU8UhcCJ5XB330QWgfpXbr4BU2j7HwnUqfO8jf9h/c?=
 =?iso-8859-1?Q?C+M5aeCO8BVDmHBRb2gN7dCRr/KtAx2GlasETxMe1S1wMWVkimXFcLhiuf?=
 =?iso-8859-1?Q?IQdvXmTTzGhWvn3MjzCJRX5QPpcjRHUgAVQ9jgplOB6ggSZE5vsCt5Kc9X?=
 =?iso-8859-1?Q?IOUx9hkvpjXWM5lg7qDakr/APn5ALhQlBCM8ube0Fkh6nZr4jnpmdnayEl?=
 =?iso-8859-1?Q?TOFOqrOGc2hpf3pmQxMGgk/Lx4QFBPHuA23yDy+0I7DbrOu6RxUw5XWuaS?=
 =?iso-8859-1?Q?clrT40gfcwumLBXwtSCwETL39H1kY88GmFS2IU15QfE4wiE4hbvYttMdbq?=
 =?iso-8859-1?Q?K4xeTUwt95PQoBkwYX50wwrwzyaMCpLwIEIPwybJEoxb73v/MyrjykT6c8?=
 =?iso-8859-1?Q?H7mDHxoTtDnLD3T/jOJYMK5YN7SzUOdPShJm0vJFqNAJsRe05ed/4ID8i4?=
 =?iso-8859-1?Q?BXfbgudkobEhcxxwg2M0qdoVSHyTb0anxrfPPes2hdTs/elY3A1cucQHbd?=
 =?iso-8859-1?Q?3t1azetFZM9zFAjmtvU+8kW7iG5x8UAgRacXUsejHVUm7neTlwjTzdOFca?=
 =?iso-8859-1?Q?FAipgIBaIm1J6E728SoKwKTmvVMR9ImZGnE2jASfqRdQXnQ/KzOk3hWJZI?=
 =?iso-8859-1?Q?IFzMnE8SoEIMk3Q56o37dpoHxzJx8NTOOKzSukmbYeaxOZGGNTPdfVEDVW?=
 =?iso-8859-1?Q?TGSAEd0J/VupW8vaF9+8hjK51PlJ4tQ/1U5UwamT29H5aBejp3wb8Enkr8?=
 =?iso-8859-1?Q?8LbieldKj4Xm9C2L6i4ZDfFRbxU08hgZsdxwTA+fDe/PBOC3Y6/Y8pqJj7?=
 =?iso-8859-1?Q?/ARlZLS8IZtK2pgiVNHhGQYz7p/pZl0YoTjHGErmhbDzpxMJeAlwftgDXV?=
 =?iso-8859-1?Q?42m1P0qfzSqz5QKCbiGKm39nFISGPLrvw2MNM4S+PR9q9NG4baeZGyaJwT?=
 =?iso-8859-1?Q?Qp+sjqOfaNoFcP/HKVlnRy3PDEhneBsqvp8X3ts6hBa4LXZ7OvsrXbfl+j?=
 =?iso-8859-1?Q?n1+Ur7fVV1Xd51XXukOTrl0YmCu4fQFxNDLvTm9rAWZxGmenzqmgOc511F?=
 =?iso-8859-1?Q?Q+XYSAmBctS3ag2zRK9ROGZ/v1IvKo2kigOuFDVtMy+fBvigCxY0egk7t4?=
 =?iso-8859-1?Q?6twdwb01nmgolS8UqxMn7U+PSt9ucWNYbW9aAi/NSWudLEGk5cEdkOTg2h?=
 =?iso-8859-1?Q?7TjK6thHti5w8czUurBGkzdUCQKtaShptSDfs4e1B0vfE5a373xXRQFMPB?=
 =?iso-8859-1?Q?K3zUKVexMxDZyHGp8omPGM6R48sEBqfugbwd44or3KZ25G1dt6Za4ASVct?=
 =?iso-8859-1?Q?wnNT6nKBQ5Chyk6d5HDbofQa9L4TMEEVavIPRbvRepFfKP5YdzCxi1qZE9?=
 =?iso-8859-1?Q?Iceyjzh+qq0XyIYbym5j2/cFuVlvHno0ew0TSSk1OAPX3Bphu0Ojw+udH1?=
 =?iso-8859-1?Q?2jcADrGHWUoCX+qw7noosuvSmYKWYfgoXYhEg4RbQn/9R2ERaQ1Lpfc2zs?=
 =?iso-8859-1?Q?pTDr2NaXDHEdngdZwMJCcDI2iPQ+O57/Ho0gi0KSPsko56ED6/Cr7DQkhv?=
 =?iso-8859-1?Q?Qy3qPao6t5buvxR1vt53OY31Ib0F9KlRA46I8rwcg1n6/uoUeY7pE9Vjvq?=
 =?iso-8859-1?Q?Mu8Y0IoBpBk9v0jYyKWWteZlx340wrZexwNKiW6NXln7iZZ7hQr1p5lr+E?=
 =?iso-8859-1?Q?XW/hZeosbb1JL/HM2h773w7DyEoTmWvxpBy9GN5CbVTduJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed9bed5-2657-4fc0-3a1e-08df285abc94
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 12:17:08.5716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9kTQmrt7+mZG6Kh79TkiGzM8POMYCU/Z956k2jOoyg5v6F46sr+PoaIdnJ8Oo6i3jWE7xys8rFfN9+Id/cZ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1753F85B8

From: Mizuno Miotsuki <founder@crepuse.com>=0A=
=0A=
Describe the Nsiway NS2009 four-wire resistive touchscreen controller=0A=
with optional pen interrupt, power and reference supplies, and touch=0A=
resistance measurement properties. Include one complete example.=0A=
=0A=
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>=0A=
---=0A=
 .../input/touchscreen/nsiway,ns2009.yaml      | 78 +++++++++++++++++++=0A=
 MAINTAINERS                                   |  6 ++=0A=
 2 files changed, 84 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nsi=
way,ns2009.yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2=
009.yaml b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns200=
9.yaml=0A=
new file mode 100644=0A=
index 000000000000..caea15b5c5a3=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yam=
l=0A=
@@ -0,0 +1,78 @@=0A=
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
+description:=0A=
+  Nsiway NS2009 is an I2C four-wire resistive touchscreen controller with=
=0A=
+  a 12-bit ADC, an active-low pen interrupt and touch resistance measureme=
nt.=0A=
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
+  wakeup-source:=0A=
+    type: boolean=0A=
+=0A=
+  vdd-supply:=0A=
+    description: Main power supply.=0A=
+=0A=
+  vref-supply:=0A=
+    description: External ADC reference voltage supply.=0A=
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
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+unevaluatedProperties: false=0A=
+=0A=
+examples:=0A=
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
+            touchscreen-min-pressure =3D <150>;=0A=
+            touchscreen-max-pressure =3D <4095>;=0A=
+            touchscreen-fuzz-pressure =3D <16>;=0A=
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
-- =0A=
2.56.0=0A=
=0A=
