Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022132.outbound.protection.outlook.com [52.101.126.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555917A303;
	Sun, 11 Oct 2026 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697353; cv=fail; b=sLUj4bzQDhHv+iNRmkoCM+zVnIdK0QLoq/uFsktLdheW2Nu18jC0UtKy/LN0JfCExCynxTDSwcbR02GeFWaYNcMGnoM6juacvZF9Yle2yss7VyyhtPjrzCHK9AydKmvKTh7QtNa/w3+ebJyVfe08uPmcgfgAZd1p/tJ1d4K34j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697353; c=relaxed/simple;
	bh=Ij9cCMRFATgjk0+XaGyhRvcvB+k1pgMA63b4qoS/DCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOY66TMInBG2BTqmK7WOS1JCfD0kb+iooJgDlkn8vIEHSI6zZKcDKQQ/uvzlyQWZve6IE458lLnj+BzLoZBTajqjRejLDmy3E019YEYCfLDrgu5PbPwIzgkZOhT9vauMNgu2ca2yMbay3V6c2mJwU8vi2iN1fVK00xj8z+jA6/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=nfkEslrj; arc=fail smtp.client-ip=52.101.126.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="nfkEslrj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0xNF19JpODwdVYoUpKRJ7SLZ27N1P0XWg5HFcOzMG58+1g73T3t7tGq8pX13T+NP6Pk4KinCu4mHJXQ5N0ozI2ktN6JKder05cZ+UiRvRMDejFArNQjTfSTdYf38Tx3f4ym60GanieP2ctlYm11jZosWGpXCq5M80jEFZK2FAFXpriFFLaqoDUTzuG1f8b4k0tMj9BsY0CiQO7k+iYsRgbAvz2HYcRijO+jSWQJySC7cw+WVPX4N7lqKqEf6P3r16t2jdw0FW8E+XYm9zMG3PM3+D8H/y2HCYtdfDnPZizqjshCLknApNdlEw3bQgQ2Khaiwtt/bxjopWVvByo57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLzfPJbAXRXosLtdD069eQuTV2dDrDw6ruqPMM65Ivg=;
 b=YczMxMq+/1iSjVBxQCzulPggWYVzTnnN2PYW46TtV9tsVbKl+fXopbZevGJ8tOY3HXXTR/444gHmzAWHmagYv5qUhSXW5wV0grv7U40PqrRkKwhKGygQwCVdyS6A/4sdDZ6Dul60G9ycDk0O6RH2KXT2vMCdtzM/FmF4Q0d7PugWuoZptSzapfMkGvNWb/mHcoyZkE4sr6ASa/lZBiIs0V7bY2wDFzyTJk83z5AlGBoAv2R1am3C1fu7G1/4glmme87UM8xPBh8Wq2kDZcewQCYNOyrHDBs7Z7/pznW6Gb96fh4MQuTjDBgBZX/Cj0qxj1jFtflwMbnG4xj2sd84jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLzfPJbAXRXosLtdD069eQuTV2dDrDw6ruqPMM65Ivg=;
 b=nfkEslrjaYCsoQfZkBKEbg5PXB8b0/nesfZ+dhpIvMY5ugdmdvm37c+97+VZJhuYWRbIBG+UDr2qHHH30EXzocJ/HprzYcS2ap2QIk6PiIqpgfF5YGKz1/IPAnvYwldtbN2430g/RkH2mmF2paODLvsNVStrNyTPAiA4gLblN9OMuN69DMV5GARF/uFpOISxKt50PoY/SqznenwqT6zVC5T7S7VEjcN13fF4zc8+AGAw9hpsAs5w8W3oQbGs+UNLu51MVejZm1HTM70WTlbyDBE+hv7e8QEpInaQi3PsiP7G52Dq8mUcSZAfTGK+5E0j0xrD5MFRAfZEPQxtPsih4A==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TYSPR01MB5702.apcprd01.prod.exchangelabs.com
 (2603:1096:400:42e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 05:42:27 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 05:42:27 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"icenowy@aosc.io" <icenowy@aosc.io>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] Add Nsiway NS2009 touchscreen support
Thread-Topic: [PATCH v2 0/3] Add Nsiway NS2009 touchscreen support
Thread-Index: AQHdWUNMBJ+fFoE1y0m5WZKkgcvtDQ==
Date: Sun, 11 Oct 2026 05:42:26 +0000
Message-ID: <20261011054223.93396-1-founder@crepuse.com>
References: <20261009144729.85832-1-founder@crepuse.com>
In-Reply-To: <20261009144729.85832-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|TYSPR01MB5702:EE_
x-ms-office365-filtering-correlation-id: 324e80b8-6d5a-467c-5d46-08df275a6edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|18002099003|22082099003|3023799007|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 ruHDpQ2Rl/+Vi9Sw/ENL8mrQuDweE9FG+oFXyGDRN+/Uot/lB4rFx3wHXUppeAFSdcA+vVdHLJiVfGVG5PjGVGWgzxrOuJ7XzNvyhKkwpGne1Fl18fvaVUWBqghQp0LO65Nr7oRubxayxXwJkR6HmGh5XPCENtugQyPEfxw+7fXdHgXgLj3eIrIlzMQdyA7jQ6JkXP41sUwVP36wwMmUj3UWNCAnXTnysml/gSMNLUlIo3kAEazMtGy/3StbUtQyueptDjSQ0ov2tJZB5mv4Acx1KbYPST5bESse+c6D5hOd3oFJVmb1kjZmZ6qeiT1YMmekAbTi8+xyULQ6In9XvEZQxXSGsKyUN1ShS5M9fttIX7lKdDJY25boUPHSsLtCSG1nwlXbXNMJ402YPylkKhF/ZOWeQ6dGP8LIM5UBsr8AevRNXU27wfabcsBWKnSGOsWjxu9Pev/WcUxmVbWz8AjSBQQBF5Rg4Y02kpP92VBE7Rw9fQARbHd8X/bhzNXO00X21tyvsRWZwZx9ZOzD/+9wbosXWG0QU2DcLORbjTeObfFnta7BTQYAEhjKvw8nB4DX0XuD+wC7j38BDkHcOQJ5Cjwo1Qvr5ljeY1D1Z7jYmd8aBHlPAWjsJ2zit4lbOBDT++n75AXBijFBms+A6VijYIPMdnDNJ/8L9lcBc7FlAF823AGWv5wiUBw5tLRcy9CEGk/L/sGJtI//3NPZbw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(38070700021)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?392w0ogpAuObHVx3jbK9iK7tlKsuBN72N7hLtpUzBRSD0j4KGWS/rZloZZ?=
 =?iso-8859-1?Q?VUMhW2sjBH1ZMNUTjs9WzbdgKHsKQlRiDgGuQoK3tkVPNJF982LoYfyzF0?=
 =?iso-8859-1?Q?40UtKAnXc8pupzyhzIdnRwQY00wWr3eGnAjmZ17zstpuQ/BdgjaQSWom8+?=
 =?iso-8859-1?Q?Dtod1dq8eqJ+ggcu3ZkuWzdxmofTtHBnSIPssPxwbAGVg1PoRwo3PAi7wO?=
 =?iso-8859-1?Q?5n2i1Qo8oK59sDQy/8GRpD1Df7BsiXU6PXg6hq3gijutH1HrJi4ubn4tf6?=
 =?iso-8859-1?Q?FCDTJN27AxteM/7UxMs4tyIMCxwa2EA7rat7phArI3TPrt4LU8/WSrSpaO?=
 =?iso-8859-1?Q?7URYRfdV6iY6Kq+bbhHevC2Jutu/VW+oWUNCqIqATqFOP/NxGkzDFiezzA?=
 =?iso-8859-1?Q?dZ7mxzEzxKMevN0fnXLGv+1Xhno+yXNeyvWPPJ8ecGE3ujA/vkuCfx8fEF?=
 =?iso-8859-1?Q?PnDS6osEcv8DIYwcC5WK3UnZyKSdb/SBfL9PNbPQ0WR+dE5llNtB7FkSPy?=
 =?iso-8859-1?Q?wf7rwmM0bmDFZuqXlvDlIqHmDkO9Xm8v1S1WvtSQolaZ0ev+VJ6WUnZZ3N?=
 =?iso-8859-1?Q?p2hjFw7z7upts8AZQxMm+tCoJzSM/pw2Hzvs0zoB+Mn9e1+nIVeAYWob8x?=
 =?iso-8859-1?Q?ox0h0uK3dbJnvqv4XInfhYWLFAy6Sqh9LJIDn90CqolIgIJ+6SrTbWy8aB?=
 =?iso-8859-1?Q?TDv5Af9bzDF0R9+/o7nwHzN1CC1qepl2A0di81VhnO9FK2NMDeNfbpNP+O?=
 =?iso-8859-1?Q?Q10UBtw3r105Io4tUZKluxN4aSuWaDrD/ohml0Kgcn30Lk367vqZ+FqWsV?=
 =?iso-8859-1?Q?o3MIqZ5/A29k7AYOti7NgK/BYpN0KiRQmwphErwhsIu20GVfn5HM9loGiy?=
 =?iso-8859-1?Q?x8OMSzY4bC9cOx9qU1HjtIh1cYlLkr1uwF+WDimDlqQG1yEhe1gsvSHA+B?=
 =?iso-8859-1?Q?1QEkjoMSacAEPzpWEjuCY3SqtYLMXNrPkR+lv7yc2TtQEB9CWbE/5u3XVa?=
 =?iso-8859-1?Q?VnvEmIzCM5ah9n7sZrd6/1lDceCEuQgnZyRRV4za8RA4YlUxt6AdfLl1yO?=
 =?iso-8859-1?Q?wdfiKnZbD0FuLsH005vL+OQmR0QQlefiKnc+Sda8UPHwn+/Xo6TKeb/Et3?=
 =?iso-8859-1?Q?SlPtDWlIV0rv9sue+YjnvAOcXmDMy5lUDX5uQ2c7LycmUd3emPqB3PMPLc?=
 =?iso-8859-1?Q?nPMc5k8AP0SXMjkKG1KwiI0JASwvJi9ljIDrgo68NmfpEOHBNOw2zkA3kj?=
 =?iso-8859-1?Q?OZZUhhhnagRQsvYom0l/kAD6KMoSEFDGO95xVL8tsd1omkL7YERMmLbZnQ?=
 =?iso-8859-1?Q?IUICcjIX37TUAmT4SF3L3Jf23iU42EYQWvU4pjm8HHMydsScXkRgVN/T8K?=
 =?iso-8859-1?Q?yhh9uEK1cLhwfDaKN562698GZTNPW4pR8EIFTg7mL8qQmgeCxMu93ewuNq?=
 =?iso-8859-1?Q?5dwYBBUKcbNB4A1Qh69WOUrKx16LmYkdnN5jeiTCMHKWCNdy9NcKyZ0yOw?=
 =?iso-8859-1?Q?4AVKaIqyJNiVFvPAn4fK2uLx7+Qs+L4u/rxcRAhknISx12nmE24XZqBlSf?=
 =?iso-8859-1?Q?fXWalMZjQc7+AP8x5vVv1mmUiwFMkflh1PyqBbkBYWAI8OiAnJrwKGZpWG?=
 =?iso-8859-1?Q?aQZ9YJNZbeYFyaO9qPcvWnMKqy2iv3oYzD0ZT08E6pPY7PO3fQRQDHIPPu?=
 =?iso-8859-1?Q?p3yQSh87A77w9CuK9rlZoJ+WMtMA0qt4jfoHelKi0C1T4ko5M5DSzSgF/i?=
 =?iso-8859-1?Q?RPyrpkyb9h5xmbi9aqTbS9AuaQpeWvqhDHlxDb62LCEHHV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 324e80b8-6d5a-467c-5d46-08df275a6edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 05:42:26.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5n6Izxa+7acAkEFPeBYUBeP1ldxMb0wNrGr03LE8Pi0ENt8gxwLJLafiKAV7erazN9OZPV1Pi0Lt3F7RTZNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5702

Add the Nsiway vendor prefix, an NS2009 hardware binding and an initial=0A=
polling driver for the four-wire resistive touchscreen controller.=0A=
=0A=
Changes in v2:=0A=
- Address Dmitry Torokhov's review by describing NS2009 hardware=0A=
  capabilities independently of the initial polling implementation.=0A=
- Add optional interrupts, wakeup-source, vdd-supply and vref-supply.=0A=
- Allow touchscreen-x-plate-ohms, touchscreen-max-pressure and=0A=
  touchscreen-fuzz-pressure via the common touchscreen schema.=0A=
- Add a second example showing an active-low pen interrupt and supplies;=0A=
  retain the no-interrupt example.=0A=
=0A=
The driver and vendor-prefix changes are unchanged from v1. IRQ-based=0A=
operation, wakeup handling and Z1/Z2 touch resistance calculation will=0A=
be implemented separately. These features are not claimed to work in=0A=
the current polling driver. The existing raw Z1 minimum contact threshold=
=0A=
is unchanged, including the tested M10 value of 150.=0A=
=0A=
Validation:=0A=
- dt_binding_check for both NS2009 examples: PASS.=0A=
- M10 DTS rebuild and CHECK_DTBS=3Dy: PASS.=0A=
- Full-schema direct validation of the rebuilt combined M10 DTB and=0A=
  the existing independent touchscreen DTB: PASS, no diagnostics.=0A=
- The combined DTB is byte-identical to the previously hardware-tested=0A=
  DTB. No new runtime IRQ or pressure test was performed.=0A=
NS2009 dependencies are imported only in the independent M10 validation=0A=
branch; no claim that they are merged.=0A=
=0A=
Mizuno Miotsuki (3):=0A=
  dt-bindings: vendor-prefixes: add Nsiway=0A=
  dt-bindings: input: touchscreen: add Nsiway NS2009=0A=
  Input: add Nsiway NS2009 resistive touchscreen driver=0A=
=0A=
 .../input/touchscreen/nsiway,ns2009.yaml      | 104 +++++++++++=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +=0A=
 MAINTAINERS                                   |   7 +=0A=
 drivers/input/touchscreen/Kconfig             |  10 +=0A=
 drivers/input/touchscreen/Makefile            |   1 +=0A=
 drivers/input/touchscreen/ns2009.c            | 175 ++++++++++++++++++=0A=
 6 files changed, 299 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nsi=
way,ns2009.yaml=0A=
 create mode 100644 drivers/input/touchscreen/ns2009.c=0A=
=0A=
=0A=
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e=0A=
-- =0A=
2.56.0=0A=
=0A=
