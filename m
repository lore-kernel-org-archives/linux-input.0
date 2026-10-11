Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022132.outbound.protection.outlook.com [52.101.126.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC263BF689;
	Sun, 11 Oct 2026 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697354; cv=fail; b=omxESyN7t2TfX0DPcKtlQyzNwJ5hXC/fFi1O2mI0y7mAL33NrD2sfPpKLMDizPYEJomUtsrBijifUuh/Pr8bPNMRmvgv754X6dp7yRA7yzU0FOFrPsF0W03pSJDrKWp3HzfOup/lpVbbw/tyvhiIPXFCHBfl/kvYumMhppCt138=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697354; c=relaxed/simple;
	bh=GCZR4C1fyaWAyf/seAwWQE4BHxMvLfEhternxGaBLSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Svd20hZKVbmLMdCzI6jPePCVDbRuiVWWXXwD2hSS+5e6NEWOpiOkTj2VKnq4k3eNwOrv0Nv7bIIJFtv+NdT2Sx57oBjU7TNfEE2wxQzn81M4FDqPna0IGmgkpNi+NeKYbqEMarTxPzM6BMZ1BtZOEjIYte9OcwKTSz+VwMg1aQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=J0KLzoSv; arc=fail smtp.client-ip=52.101.126.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="J0KLzoSv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYsTl+1b5eFHcLO+UudVLCrZN7GX21ojhFYu4t0ST4RrSMqhS8nwDU29HsEUkamYhB84/r07lyiZouwGbYjwGuQNpieJtukLwlS3rVuYtkw4qlVAsD9UJ8qilEGtVqkD9o7N+oMu2IilOMDgHuOHXYCKQE6xfm1qf2/0ogqO4tP9w83Nj0R2A8fq+ajUtZs4U4Efl3dMDdaqwXI5Xke938C34rYcDrew8z8a2RRxXPc6anWyiCkKDMbpNNoNHnNN4Ud14ijEIPdf8CefSlT0fm7QJrH1tg2B+6RAzmmq/RoZEyN+pCwTugpzgDC1BtdcW0yd/IoxuHYuCW55QKkN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ6aj6BQisNQkjolbV4CsgQb5+pfJdCBbdzvrYCfI9w=;
 b=yHXnKRqOOJa3e7xzLZf5UC1Z9B/ZjjvxOILgTDafexR75Atnt8lzswUcinitsB752ELMkL7WKs0ZUDYHmwz7BpmEWD6AJ3gAzdKCr4G/LgQpLHLNsqdMO+bDB+nys9ql4DSRNwnq5Jh2TuRArQ/ma+iHznqv3EAk8Y/xyJ3qxc0VlQ46zhZVUBQaShSDUZZLPKyBTLGEVtqMYNExkyugWHXGQFntzSDKzDXaPmm+pVPCXoAb2K0scdhpgGiwPbAN3gH10fDhXfcClkPwNksccEqLWd4dgxGpLfGdkoT42JvOrKYgFHTK5P/9M+IP6kNUFD4Aj3DKHUlxhjq1JjR1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ6aj6BQisNQkjolbV4CsgQb5+pfJdCBbdzvrYCfI9w=;
 b=J0KLzoSvAJwaEGo3Om7YQe3VSbA5qiiD7zxiqCizeqe8wEkCeZWnUCqVj/NnNT9uweUfEhhD3i3DGE/ellkfjXGdECUQ/T25DRB92ztbQq2y3sAY1sd0bupf6EeFwjvBzkqNk8/fZZpNkC4MTD+xzZOcRVWPSg7Q//9KVIvRaEHZ3C+769r1TeXVSeRD+ban4uMrYNu2AyWQSsutUIPM5bEOqq6Z/IvTBx7caNazfxh50QGuwalHRFqj6RSPXHcIzIMsC8ffZI9c2NRdnnwEz9miA20GrnvYREkP1y572UYadJSNAamMCXkdW+sGDIwDXrRTA5jiy5fYe+wXc1jExA==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TYSPR01MB5702.apcprd01.prod.exchangelabs.com
 (2603:1096:400:42e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 05:42:28 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 05:42:28 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"icenowy@aosc.io" <icenowy@aosc.io>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add Nsiway
Thread-Topic: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add Nsiway
Thread-Index: AQHdWUNNWrkNPpe1TUerAUgvOOsjww==
Date: Sun, 11 Oct 2026 05:42:28 +0000
Message-ID: <20261011054223.93396-2-founder@crepuse.com>
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
x-ms-office365-filtering-correlation-id: 942de805-ef11-491c-4670-08df275a6fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|260925021311599003|260925021911599003|260925022911599003|38070700021|261009223027099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 EO1L3qiNt1s5vfsMk55ZHJdWROBPkYuglfoMHwBV4S3L4gNmsZfKwflSQKUVY2oW0JLPu7xXnpHkqJjXKlEexDz3pkw9LgNgrlysWch2jQoYiy2VnFD7vHpTfk+p2CklOvAKSSN0q2GX59ymtZ0floIqD3HboqWpC46ETNhMGCiW7BRIf4/TCp4+5Nq8n2t0L6ZLpQnIAX5Rs3+UuVXYb3rtthGTn7IXApNHxnyGDRh6uFgmarNNnjNIQLRHvRHJZbKLtarsaeANg5R+Ri4MIQeiUTteMZ8vMyMG9keVqEXhGKCnHL97lnISXkf2TZst9kms54Q16AAOTaxWg8eeuzPESe2cJatABjG2T+Ejq+Ox2mpMujDQeykv+uAuOY4JtGumaKqY9/YFITyab0D/HOnAYksfcHN0Abvk9V3jN6VTgixfmJy84gcCWgZNvA40cQtyUkF3PveyMU/Q6nXDsmUH5YiDORp5XlZZTj00lxVYsoMPVwITgnkAhSRTX7URLKPmgyP9gHZvRUex+SljldxEMAULa/DVMB5m3i1VoHvpyZhnsipqgKjv59c/yf0d6jMbYgJlMqfB+2j5TCBAuYy9Cx6l4xx6NBM/A8K63U6mVF6sKaSC4/Z1eebyqyVPVOIhqFwP5QvCBwN/bqvpJDIo5lkrvg4CC0ktgAALHBDUSYnYqpJ4+tOUjz8gqtkJmMQoTO0Yz6QkUBlDXG3Zs3wrBcvGgNJ2VQUYJo+3oRc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(260925021311599003)(260925021911599003)(260925022911599003)(38070700021)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kmlSbN2ouG0t7K2dT1hj0jzyYlZynNMySCF7wD2S0CZa+nn2Bh48ALHe6H?=
 =?iso-8859-1?Q?b+oss0dqu7jJ0WJw2cDVweO0BpiRzbCDeGBjYObg5tjwu0MJIQpnB4K+OG?=
 =?iso-8859-1?Q?ofTWcLUdAmSw9ho40Dj4UiKCJXxDJlSDXhUzW9bx+/XT7hM7JtKUb7qfud?=
 =?iso-8859-1?Q?SrLZLA/8/GsyIfWh91Wu3s3ZdGfud7NAwcSyra6yCZvSTBelX2+IjhJirX?=
 =?iso-8859-1?Q?0cnw1ZWvREVBMO9e2Uk1m+FJf4f7YuZTRhFEEbdPbEsYEdwvMDKeSZ0Nrq?=
 =?iso-8859-1?Q?5pq7l7qqc7j28XaWy0IyVdb8oxxBEYzUcbFM7Y3wgTP91Z9Z2qT1bTw3P5?=
 =?iso-8859-1?Q?8QPquD0ChpGnBVgcY6trTqVWm+KVXNcFo9iBMKksgPFx2AO41AHG+cbkA+?=
 =?iso-8859-1?Q?muqak1G9VnbwA1kU0OfPaV4KaonP72jGtboHTUjMOEBQ46EMCORx/T37KV?=
 =?iso-8859-1?Q?Fxjt2//pfJShPKyFx0kaoBVJK4UKEdamEMK69jDWjUr1dZbG+BjAuFlR4Y?=
 =?iso-8859-1?Q?xGVK8n9Zsa/QkBE/9EZ5SNgw47XuJiTSYdCPAk2hHUFdezQGG4+22BsZ92?=
 =?iso-8859-1?Q?PGuZ9WGfUG0BgrC8WjpKEWKDz2nfz+b3P5Aku4wEVpcbYEBrQYSq3lBQPr?=
 =?iso-8859-1?Q?rJrjYuxJBu/8ktnd3P5EHo80NDHutfUmC2nAtt0AxwNsbTbpcKLUYmFSRg?=
 =?iso-8859-1?Q?wM1pqyuZu9eD0L/yN9cu5nwLk6MXP7oLHn1mKzFwjoeL1m2Y8Wum1vzqwP?=
 =?iso-8859-1?Q?si3EBZijD0PHKxrz8HCco3SO+CVp4xGOgcyaFt7BoLDJf3AGgpx0kNewgB?=
 =?iso-8859-1?Q?YIRHCIdzL1kpQOmM6l8FTQLXqmkA5Ymzr1mqXsVYDZ4Oj4udnjWtrQNt5z?=
 =?iso-8859-1?Q?ZGWaeomz8l0fKC9GLg4m/g6483pZ//3jMeYKbMkzZ2LyPrXMRnIUe4KCC0?=
 =?iso-8859-1?Q?M+q6xcl4AiI4/1gMF/Z9kAdu0QJ1PuF28B+yg0nqVfdQkn9wVo6VS6xLRT?=
 =?iso-8859-1?Q?hBwRzLEslqBOEq4ywLAsbcvmom2S79PV1LBkI9LIcbtEIe/ySlmTiUsXmz?=
 =?iso-8859-1?Q?08Fe/5U21dMKJYmsEjOnBzPsK4S+N6+8VlhjY0xjepjSzwow/hYjFZG2DZ?=
 =?iso-8859-1?Q?VrhSbvkQY3YMfty05NaWmEXLqqE/bQ6LpYDzS3n0W24+MFgba6SH6xe+1m?=
 =?iso-8859-1?Q?gH8F4O09dw2wxwcYf+jvZjGSxuTKlJeO2v7Qv8YIuHhA4l75Q/3JeRG5bO?=
 =?iso-8859-1?Q?UFzSEqKN6Va8HxwXmz7P8NCJT1Xqa+tU1AK2sW1ptYWplT+FuoZciLjrV8?=
 =?iso-8859-1?Q?PCg9Ev2VeF3DrIJ0z8FsZ7LZnn2XxvAJfaou8TcJKxJTMES7U0TZ8/OZ51?=
 =?iso-8859-1?Q?bYXyaXrQvh7v5xonYXtDDQ7V532p5n5DKBsbor8U6PFsNKkKJhV9mvHb77?=
 =?iso-8859-1?Q?cNHHd9Q30jno7RrwpKDvipjolHoZyoA+tWQl/NBnMm70OM3WR50e6jcYOR?=
 =?iso-8859-1?Q?7Y1rQmmwJZQFTZ2X9y1uy6VxZCNu9J8Ey42EYbRIyaniOLPRxPyqT1VopF?=
 =?iso-8859-1?Q?x80desHnBfjzo3nFui+WcmuqVx32/1SoQyvFTPCUZNq2GINDIWWu1pxU6v?=
 =?iso-8859-1?Q?jKQStqKHqvxQ2yXzju5ux9gq0ykbvNsq+4BZA1poz2jR157qIVfrOM9G3y?=
 =?iso-8859-1?Q?7HYR70aCwIASqoY9NI8aT3vuXaoKKBhUbRPeBD6+WC+8P/+oLNkLuv86cj?=
 =?iso-8859-1?Q?EZiTSP4Q6g3lqBF7/MiGPzbgxCBEJuSJBT1UmFsvTBWv4Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 942de805-ef11-491c-4670-08df275a6fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 05:42:28.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmTj1i6eqLEsp96r2Vb8y1KLt80yGNmXNRJhu6jCcFZBp8kbtKXmbCeg5XmXHDhArS68awLs0haW8DsUUivsmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5702

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
-- =0A=
2.56.0=0A=
=0A=
