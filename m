Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023119.outbound.protection.outlook.com [40.107.44.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B14749F2;
	Mon, 12 Oct 2026 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807432; cv=fail; b=rb/f/INfrbPvv5L87aP7d6wjAhGPblUzT2L9hFDLAQ9qdswdKUFiZQRuC28zdNMJ6S33maMq9Vf1Woov+RlBJoIZgqf2dw4lT3MQyHU6U9162pVTR0AZpylnyXjI313sBDP/ttkXDyvkTob/R6OY3bN3djdNXzTqbhTJMET+lhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807432; c=relaxed/simple;
	bh=aC4YZhJspnUhjrXcS4aV6G5URo+J7AM4ehcuRGcEkE8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vGZfXtckpdvi/G+pbp8HyitCJCF54gqfIehzvUnx9/HkPBa3gHYXM6VPlH27UEV305fZyB5S8a9jfC1CIebzHbgeAY7L9RmVSYmFonederhaaFJP841kyRGD/l7ie+2MIV+q4NSOdSg0gJEWPJoT87qRwTNI8gY6e8sZRp7d6DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=R6DKj3Bb; arc=fail smtp.client-ip=40.107.44.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="R6DKj3Bb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE/9g5QHHtVt/jWZQeH/l8xGa9sAQhQFSr6m/RMeDSShmpgIHNvNafp1mRMMX4O3BuEW6L42vW2DTPY9sgx1MkJxigM2NniTGaootgaOIPQPch5g4Frj0D3/NXC8fFcY9xqRPKiQKGTtVsW/VJYjHl0wUVGL2UtpCORimtuQk/y9Vqje4Ek9akSQiTSyDhAWNsEmxW1WrjDuDShe+oG+9Jfv5Fj2cynhCqZ2bpSAlUQO6xdGUned3b+bCEMJ/wQQJ4dyXTJu3mO88i4hwE/Lcx+v8+UyzBGcdbEGW0XIAxSnpoAuQ2rgKVdRY/atdcU1BpgkJBXuzUvfjRaGpwoxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpOTk7ksGUooYtt4UPphItsjFSQ9XuMkGXXp90Q+d2k=;
 b=WNDj7WouB/f1U9YiU5HZvrmfcMXxo9M3XkNXaMi9E/9EJe/SBsYF8bcvJhOIWW20LhfyUqIscobQtFTjCqTMzVZWKXqHOwNv/3qvsA6lfGzG+I4JPte9n36l9ZVkU2wF2fkd2dAUrbFXsIJOE6ngrl2hZa+e0un/txZn9uHCtGJ7WMBd5VsE8YYOwLj8lYOocppDEb/TuEVsTHWxBcdIlqlEgoMBd3ul5Zp5EEnPMjBW0uo6B5rUtHIn0nkIHZ09Jrpg2o+GugTXF7iLadBQC6lm06BFhBB7UbCyZHSilNOp/OmKFBg/b564pq+uNE+fqJlvNVO1pi6ULzVzT+TVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpOTk7ksGUooYtt4UPphItsjFSQ9XuMkGXXp90Q+d2k=;
 b=R6DKj3BbfGiTjZ56WNkvOBcnQpvU3w8bd73uwmDJOX4KzGA9uPv/0mCGL9sPPQJKla9BTd8fwzs171YlSKBx8jce2tjMFg1u3QXtiLY0GQrK152JudxaFtnNoOA2t9NEC5gmIYKJWqyejmSdecq3z4d9TN2j9ndzTHrc5rkfW3Ysykk41mCvoHQosB93MjSQpmbzxweqcNE/0aibAWW9mBkqAvMufJV0Hnp1AGjV2C1aXq+414OrPnjxfb5LLvngYAhcAwJ8vRu6OH6EqXOatt+FnsG1nJ3GAWDv4vuDrfCV0n74JznEbM8wsaG2gOUBLzLl9cibBhb/vOE/Jh753g==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TY2PPF1753F85B8.apcprd01.prod.exchangelabs.com
 (2603:1096:408::389) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 12:17:06 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 12:17:06 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "icenowy@aosc.io" <icenowy@aosc.io>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>
Subject: [PATCH v3 0/3] Add Nsiway NS2009 touchscreen support
Thread-Topic: [PATCH v3 0/3] Add Nsiway NS2009 touchscreen support
Thread-Index: AQHdWkOYZj0Kb/+zjk+osJ7j4j31kg==
Date: Mon, 12 Oct 2026 12:17:06 +0000
Message-ID: <20261012121705.53396-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|TY2PPF1753F85B8:EE_
x-ms-office365-filtering-correlation-id: 025fbd9c-e3fd-4eb9-8f9e-08df285abb3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|261009223027099003|10067099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 r6iAT39u8eTTC2vZ1ZGqUvMZ1m6/w73qjvpitZFwios0IRsKGyJRn46U83zNu2Uh6vpWg0EJRDjtlNtQryJtJck6qL2M+Ig5PVX4G+0JOjmd1ktFeZTW8WPTk8dZ/rdZnH1Z/8oIvqJD6MpieM8Z+EovAFrqs6FB/ZXrcEcoEnX+Kc0VKQO24jzs4CpUv6MeC5EjA3QSCToNvK9Uj9Jr46zMswG54yKec63tsQl/avbuoC0X7chUOYRPxcToF+EG1pido7wScSSDETgnzSiaQU/g5YwB2Et+JbBKCASTss0bnIRHakKI+QakwwfejfnEIit1kZxbM1nZ4LGJ6w+V57R78r+khFHUbW406xpuz+HtCC6P8S7h2WIC9xn9vSrvsiEtJWVHPCn9rg83xWddKBR6C7ZSVhDkiRzsEwt6Vni73lA4S+1DipITz8HLAOPFkffG+JTaBOqj8EFq0siG0tN0R+5OwvU6Hrqbsja63W69A6SvHFbD/ls4Y8otYZCdbhLkIBNXRhUCEVxk73gomDfSIcF/Ao91Deq4kVSDBTjI8oAz2J2hW9FvYKad3bMHLR1VUQLzWrcbIDZQMEcQULlPdY5gz//xUA/Mbuvtznhq5Z+Ei0TniBLqRCkTrrTjIkQthdPQ1YjNXYb4q2aQDVbVl5eFSbuL0OOirNeCIu1kAhcVMUECFx5qD0KZTg8jBzqbOuBpi/Lm9psUXvGmhg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Y8XZshwlN6OUrGAQd2HABkbLo7QFuuWLbviTuT/PrBqtRA1fWOE/FSR2C8?=
 =?iso-8859-1?Q?kfKm6p2YK8m5KuiYEFtYBr92gA9cvIuTjSrDocs2kF1jvRu3D4Dw1pznYl?=
 =?iso-8859-1?Q?4ZhV0OEyMVC4+x409UCgI5J6FB066BGen2JMV/WJA/qMseqrvd9HOUGmxv?=
 =?iso-8859-1?Q?Js8w0DXGRstKsmJRN6WLAu7Gq2PcQWw29l9nRG7Ov6knGFREW5MGjqxqk8?=
 =?iso-8859-1?Q?paM87ix9uFiajZtf1K8k5oB3TyMpIduuUvXG73P/JIRfYZfl/2BoYMU6aQ?=
 =?iso-8859-1?Q?rYGfptT0LLdhTyBIC/LuTt6Pn5sibsOQU1v1NSaDTu3RJT2g5mzhGTw8/U?=
 =?iso-8859-1?Q?RvDG9nVJMzCp7ITEK6Pl1xqqdUdRVTXVhDdPTlX7wvecKWGhle34hFkA5F?=
 =?iso-8859-1?Q?2VLF+H4d0R0nxjN1Xk/GKs7IaFQlNmIIKdBcnCn8niOJgBeCFe/5MMFn7q?=
 =?iso-8859-1?Q?UkV2eUe/HerfuBnNQjHoSHLyckwyO4QNx1NvV8PbUn7eQhvtunTqpN+u8X?=
 =?iso-8859-1?Q?kOABqks3wOcA7cTBdyf/vGLVcLMI3QdLHOAyXz5a12Thc5SS4dKh3ALueh?=
 =?iso-8859-1?Q?JElqAfgUg1gbTSrnPRkSPLfFmU2q8+YEkWf8o0tZ2y1LGer6n+5o7p/WWh?=
 =?iso-8859-1?Q?b5uxN60mT9mLNamF9hLBm8rmH0odgEFyTZsoEVcqWKfwXNV1esTJmJ9DP+?=
 =?iso-8859-1?Q?C2fkGpd9yiFSRlQmxnVVdW6FTgjMJ0DFSkk9cgRp1ccDxuJfxbd5rXmRUq?=
 =?iso-8859-1?Q?eFNzuaMg0aTJvfvju7AU/v04G4MMkyay13/BdvYNbxwiF1yFsWQziNPA+c?=
 =?iso-8859-1?Q?Nz/w8uqv8GitM7Kb54ciIgKkGbbT7d5m0WSjJq+F7JsO605qOIvse3TDIg?=
 =?iso-8859-1?Q?fDmNWjz7Wn6/Na0pxY/I3PMHFXUuk89YqmNhxuagRW8JzKMdZi63m/Eyvz?=
 =?iso-8859-1?Q?dDqfS7TBEuOrq35L73Zp2ASn3dQ3fWslUqs7FodiKbiujwNVEl//KcwCmb?=
 =?iso-8859-1?Q?9PLNqYpQ4XySV6nNLukVHIyZ6J8A7bEvikXjGEJ425p/hSvbb/gYGowYH4?=
 =?iso-8859-1?Q?coFskfbEEMPCEUojyc/r05isSxvf6DOoSPZXHnr0afOGN+7XsRXnQIEFXE?=
 =?iso-8859-1?Q?nUHzqZ8hazpISotQV2NyfzJABta3/5xSXWDyqN0jKqALSca4sKkit2avjg?=
 =?iso-8859-1?Q?7ZnHMso4tglmgQ+OE+BhkMCdV5HWGfbahwK4Vdc5J7dPLqm8FxmVNUpmXr?=
 =?iso-8859-1?Q?RiKwTD99d1o8DW9qe26rkP+PKaNiKt5JdRhM8ZOwS1z7mp6pIAJBWwBCPi?=
 =?iso-8859-1?Q?SknjsbqUt3xmnCHDlBlyS6Z8ehhCMospJZdGZgacNisw0burr97CQJihVq?=
 =?iso-8859-1?Q?RWxQI5OHcoBHCoAmISFBUDzEm10yCuWSmsjJC89g2nKvlaF2QiOHPCeloP?=
 =?iso-8859-1?Q?4bhiOw5MrqgCxXIGmhUiRUNV2mDEfPyLKoBE9bGft5VY8pz6Ua/SCvObvx?=
 =?iso-8859-1?Q?uIuAIeazU2UheWlkrRc2gTD5lkzfEvF072ZatFInzPPBAcHR6zEk5x7eyO?=
 =?iso-8859-1?Q?e6MX2HoR7b/TS2eL88F7ToTkVaDgn6O6mPXn5cDXHyApzfhSdSAFLXX2LJ?=
 =?iso-8859-1?Q?AXKyGulEVShBlb0fvpxVZhxzdUPKjSo8uAQ0bHo767mHmgydI59jdEm56t?=
 =?iso-8859-1?Q?e8RS82TUCO9fkPH53S5nlM8XdhvF6R9eS8CP0AW3o4WNtlENHsGGEQkPi4?=
 =?iso-8859-1?Q?e2umNtQ3F8bKCJXmzV6Mf6JekSV+rFGaP0DEo3Bqtg18UQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 025fbd9c-e3fd-4eb9-8f9e-08df285abb3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 12:17:06.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heaNzZZx+t2SBl92YY/Okjjb31XN8G4QNppBMlxafAU55XTZEJ1YqxVgoWSDO7Epgxy8X7QbWz9/Ne4URcwOgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1753F85B8

Add the vendor prefix, hardware binding and initial polling driver for=0A=
the four-wire resistive touchscreen controller.=0A=
=0A=
Changes since v2:=0A=
- Use unevaluatedProperties: false and inherit the common touchscreen=0A=
  properties without redundant declarations.=0A=
- Simplify description without a literal block marker and keep one=0A=
  complete interrupt/supply example.=0A=
- Drop the inappropriate Suggested-by trailer.=0A=
- Use consistent author and sender names; include an explicit in-body=0A=
  author line in each patch to preserve authorship through mail relays.=0A=
=0A=
The polling driver and vendor-prefix content are unchanged from v2.=0A=
IRQ operation, wakeup handling and touch resistance calculation remain=0A=
separate future driver work.=0A=
=0A=
Based on current mainline 24a19b953e2a. Binding checks and a W=3D1 driver=
=0A=
object build were performed locally; M10 schema validation uses an=0A=
independent combination tree with the still-unmerged NS2009 dependencies.=
=0A=
=0A=
Mizuno Miotsuki (3):=0A=
  dt-bindings: vendor-prefixes: add Nsiway=0A=
  dt-bindings: input: touchscreen: add Nsiway NS2009=0A=
  Input: add Nsiway NS2009 resistive touchscreen driver=0A=
=0A=
 .../input/touchscreen/nsiway,ns2009.yaml      |  78 ++++++++=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +=0A=
 MAINTAINERS                                   |   7 +=0A=
 drivers/input/touchscreen/Kconfig             |  10 +=0A=
 drivers/input/touchscreen/Makefile            |   1 +=0A=
 drivers/input/touchscreen/ns2009.c            | 175 ++++++++++++++++++=0A=
 6 files changed, 273 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nsi=
way,ns2009.yaml=0A=
 create mode 100644 drivers/input/touchscreen/ns2009.c=0A=
=0A=
=0A=
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907=0A=
-- =0A=
2.56.0=0A=
=0A=
