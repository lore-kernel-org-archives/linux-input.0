Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022073.outbound.protection.outlook.com [52.101.126.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FB4E7809;
	Fri,  9 Oct 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557268; cv=fail; b=HQIy1YVLQfYZ1FULPsnfLFLLfPQB3IKvbw28cn58IpcHbMpq4K/jPAqPE1w2TEiqqhIqbZdW5zd+n501Cpo6qeK/DjyY+sUK0FOR36xaUbslNZqCrPrF78dGG7aEdpnD1nxL7ZHe1llYtjx1ilTAv+gpy0WAHd73ogKxre0T0Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557268; c=relaxed/simple;
	bh=8qczvNugv0pn9abK98x0Xn15CX3RXvaoZ25AwbTN2NM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pgMny9FpIMt+0dEMmKrZaV/UnXgOX53AKYVcNO3daOoNaPI/UOhXs1qGA5B5QCBK0PB5quupTPRnL/jKZFEIzdxm8Ct+mbrf2wH27WZbd4+jXV7iGgfcBrieLJC6Gw0L984Xl3FYKN9ni0ve2rbX5EzrlHZNSZhfiT27tlJgY6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=QmjLKzSo; arc=fail smtp.client-ip=52.101.126.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="QmjLKzSo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9ZVdXb7/RZI8brTfQ3bgDUa8rhU+qdwHGmyWROAyBpIUKoqW2iRwIFexG8U8FebhL1kaMZsG8DyOclquk2c/K91nDKKfgSUCfsl3KxQeJZcCmHGJrmUjoQQ0ZB26nYKTTcmLuxdaY1CrwS5reXVMQEgRFdqOyeK1A/7oEQc/umnqQvw7lObTmJlitxt1K9FSLqa+oDXZ+L6J1bAin26BrNKNepZhtV8IYI0SOjJb6eawuzlUGIMRAe4UrzK4ACBs2yowph/l0/yd29ehHRL9ixkAAt9075ldIaGfZTVvq0Ttn2JDV0lxL/0PSnnF/QRQH4o72sXfiNvdWb3CiY2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6BmGdGi71A84oPOnFWe6pQYtfsk9m+hnl8Q6p8coOM=;
 b=yZVzHtIKE56axjQumVfUqwWESZKZ72ZBiwwPv4AlMw2ggm6evw1Hi8plAYQ4ds0V+iZ+MR84/KG1UWSWoELWD6pgCRGUaNSyjqteyvgM3EixQci5q/1nMw+x0rsM2mmvq0XHhWBXSRz0WJkhmCiQAqHRJHXkdECC71woAvO1QvpVjswqpXrcxb0FCK3zSmwOvF63zwmpOqZLSiYIzbZC1pEZt+ltV0qvOQmTetyjMuTuWNr7Iq8CGVl2Yi0VPH3rjM+Tam3QWU3ZTsex75/8Tpqf6JfhMlHMO0ot023CDxLZx/1HnbvmP3cO8P5Mt+lZwEOBFKyB8Ugy5hqGOSYNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6BmGdGi71A84oPOnFWe6pQYtfsk9m+hnl8Q6p8coOM=;
 b=QmjLKzSoSot9apX9dAVqZKWVCaBv4mrv32NBy82uXQOW/EeV9MMY8yxCUOwKw+YnA/R5bzNFJZIF6cf6IAjmjzwJn+aTPgOaB0tR9AJcR8gr9amFkQJnb4jFA+QW5HaJ5XNV1Q5uFP34My0z+PxDKiZwSH6EY6XXRbyeKTsue1AsI6EBXuiZ0qFyq3IQhqfGmDwK9ukvexOu4OSk/2c7ImH2zEppueF7KnZE30RMNAYuoKsgh/oQuqEq8lZ4EvlN/3P+H65gjHHPnO/JgzGUyFtrEuNIaiSgewRERkTPzeepfEkkGEY+fDHki8TXLZRwV9b1LTVgFDdknlFYIVKkVQ==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by KUXPR01MB8095.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:9d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:47:42 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:47:42 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add Nsiway
Thread-Topic: [PATCH 1/3] dt-bindings: vendor-prefixes: add Nsiway
Thread-Index: AQHdV/0jvYTdfh2PJ0620dWmyGCWbw==
Date: Fri, 9 Oct 2026 14:47:41 +0000
Message-ID: <20261009144729.85832-2-founder@crepuse.com>
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
x-ms-office365-filtering-correlation-id: e214a257-c403-4893-9148-08df261445a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|260925022911599003|260925021311599003|56012099006|260925021911599003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 ZTTvAD+g2t+jN6ko40aiIha0j97nCVIuZYN6TuRi+spCZATbbSVYy8i8IDRJIacULBItmBQP4p9e2hFavVjsEiYUuAaZezKQ9t5MiBQCl4yOP/tz39vhEbRpvRg4qr4gpTmaeoBml4/WNssa5uN1h0ab4xYYtR0knOALxtNUTVtpz6LBaING16miUm2q2X/8NROVDPQ/l9blve2M93UgPB0waUGDDvB4oPDygg2DYkV01spxz/131Kje0lahuFmFuccGFu230pGt/5vu6olhodrpwI0PSiF/KrhCePutyU2DldDI1NFlFcud1/Tf1vG6wklOWbeNAGsnwO3h4CV6ArJxSLr+WwR/QFIRz5V2uKSwF+BBOfho+j1TFQSVsxh9M8vC1GbAAYFBdWVnlNc7FBHXvxNCWZCTPCcBzPXzrd9oy+kPrZX76Ph3N5ksSvScFZH51n0d+RwYkxL+d/rpzuB0FHApcj/lqyVxwMOJX1tlDFa3FBVLdFnpNqiQ2y+kStHEcL2bmysb7bnFZgzscvm5tlQSgeUl7jqQ6XmBUtBTbQmKNqdjLZvlPZkD03RXMVvM5kBwasU9lKs6afWsAQOegnTdm3DNwe1fAJvz7o7U18NSyrj3cAxZjTyb06kPJETVo1VBFYSvgDww1Iu1W2BG3VqvV0BZj3fUPP+g36rxLKQyJSmaiaSO5MF+GVPS6T18XXTow0WGMxGOLaUooAoC5Jb5eXxoFcSukVBdmT0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(260925022911599003)(260925021311599003)(56012099006)(260925021911599003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rKtRSc9tZrdPKY/FWGXl0O3aQ8SS1hmdGURtduKNixja5PFy/6Zof0lqL5?=
 =?iso-8859-1?Q?/ecPln3gOzhTYDO5P+VuPvgWaleIAQV8aoa7mKoUwzC2vwP7zKi9TQ6qeb?=
 =?iso-8859-1?Q?bjmBcf+kVnwF633Rf+IeDLgzChHNQGk1kKlnKe7o3MLcFZt8RK2bU4sAZm?=
 =?iso-8859-1?Q?W3ffiMBB++fnCeXKtVf83wd610cFeHDR20iK6GMZ1gfCCVRB5SUDgNySiT?=
 =?iso-8859-1?Q?XrLwEkkWQKMoNedr9QwwCpi80qm32Hi2TKZFqBYRRdvlab/tigebYqr9oJ?=
 =?iso-8859-1?Q?YbIzIj1o8TA1IJI28vnC7j2VXuQJ3U8ic3W9n3JyXop7igPFymcm+lAiHK?=
 =?iso-8859-1?Q?JGIegn4Kmxq7wO2yzEKK06UKDph2ScMxG0ZTNOh2/ir8YN75PiTlCAp3Cn?=
 =?iso-8859-1?Q?T+6pGiY0kk1vZSOH3GlsI0JVwR6HkVhk1j3FzZvEkeyUI1CU+hOQDBGRZ6?=
 =?iso-8859-1?Q?e3obUTSix4YzM62vcmoVKISd0mIyEGAED7eNk2k9I3iEBh1HkXaO2oFidD?=
 =?iso-8859-1?Q?20YtCeemDC0+bHb4noGpgB19ckJlXTH1mPmZ7ikyqsiX4hvbXorAwFUxnL?=
 =?iso-8859-1?Q?WygLdqun0H/fN6F7LyCVkIF5a5RczKnJA64GEWuhJSz/BOV8eZuodxrsRo?=
 =?iso-8859-1?Q?7WV7yBw/y0FXExJxCz7yLG73KzCYcCTkXgKvVFtMaqAAqfBRF3ZyFrOi1M?=
 =?iso-8859-1?Q?wKrQNV2+S6RYdiI2l5laSMIICnCPxndHuqmViYEilaQoJ2aDLfpragr1N3?=
 =?iso-8859-1?Q?NpjhZRPnrvz10PoA01HiRk7AIdLm4iC5FisDlSOZ9KtaoK349WR15KeNZO?=
 =?iso-8859-1?Q?XAE0jt7JxLlZkY74aqk9XsDFlTFPRh7u7vrlcLIm8cPwqO2/cooIVRWmXr?=
 =?iso-8859-1?Q?Qk4kWx22Cis4BNxlwDKBMajhIitRqlI/i89jL+0XfZWQUwUf5rUb32oO7z?=
 =?iso-8859-1?Q?5sDVhmgvgbsdbDJj8JLMElPLaw/BdDSNJbV6mhUtIhCub57W9xEsgVfZCY?=
 =?iso-8859-1?Q?0yt6J1MjW3a6xBum48khv4azEyPSCLpULY4Et2D17WaVvl5RTA4nv65ee6?=
 =?iso-8859-1?Q?AsCxyq0XgZyeriUDrTtwMTDklAYLKE2F+/skRA89i+q2gUN5yfSwu1fSoe?=
 =?iso-8859-1?Q?8ybwL9OfS5WM9/cq6p5ykLOI/MxHRboUz+Fg3F1tj8rTRX1QueN0bmSJKS?=
 =?iso-8859-1?Q?M9CToQIU00+o86U+Fru/1gJ3K/aT9Bc8deJd35kgVkhdwJUoHJEUE8dEDE?=
 =?iso-8859-1?Q?bZdQ3yGtw4S/QwAypaHwZ7IVMG0AS3M0+4WNG9eN/3NaoL288VCzUsNx8B?=
 =?iso-8859-1?Q?sIYXz5opdRDpNlsqP3fyElwmdIYSU/QSGObpwj5VY8eSQ+innMGI2VaeyY?=
 =?iso-8859-1?Q?EuQIiEd14OQMTWMAOfznF2WagzfxIZAxNBd+WackGu7zEIDtuWOONZQLJs?=
 =?iso-8859-1?Q?NZjARaTyIQnBtCeWNA3UD1pqriN35FnMSJIvNY1WeIoYNwFgu8uo9IaDzB?=
 =?iso-8859-1?Q?X96XX7rMiz393yUG6N6JV1Fl3S4D9Q+TC8A+0p7GhKULUPAFpkOmRNn6Ki?=
 =?iso-8859-1?Q?O28dZUWuY5YZwIh/wOIHV2DQ/8xm8+HDgGOtsg83JFe9CJzo82YG9ANeq9?=
 =?iso-8859-1?Q?ItaENa/Kd37oBJEY7iAeNdtQs1CMhVFA382Ho+XMgvy8EfbfJ9fVjTxGkj?=
 =?iso-8859-1?Q?mUPpuuIcgQ/XImcjt+C19mdaFRp2agspzzl+OnV8fDgwwRF+xrg6rSrh57?=
 =?iso-8859-1?Q?XeuxuRr0jqPwOBlp+yHgjUTW51VJw0acaYFBrtYA72fLt5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e214a257-c403-4893-9148-08df261445a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 14:47:41.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cac0u+N8XH6B7s+kp6G8nNYU6Uj2FLzqz4ia3hrF2LZke5GVEb5OzD6NwDahEjAocG/TkFUnLEQx1k7dfjlI3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8095

Nsiway manufactures the NS2009 I2C resistive touchscreen controller.=0A=
Add its vendor prefix for the touchscreen binding.=0A=
=0A=
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>=0A=
---=0A=
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml=0A=
index ba2002969373..a180012054c9 100644=0A=
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
@@ -1214,6 +1214,8 @@ patternProperties:=0A=
     description: Novatek=0A=
   "^novtech,.*":=0A=
     description: NovTech, Inc.=0A=
+  "^nsiway,.*":=0A=
+    description: Shenzhen Nsiway Technology Co., Ltd.=0A=
   "^nuclei,.*":=0A=
     description: Nuclei System Technology=0A=
   "^numonyx,.*":=0A=
