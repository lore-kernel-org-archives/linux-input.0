Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011062.outbound.protection.outlook.com [52.103.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8944AB8A;
	Thu,  8 Oct 2026 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498896; cv=fail; b=dffsdXQ+dy/ehkXRUrC9rw5PVrUaDNdn2t4oPLo46z6qGZiSz7l/QoJt8TKWVvYU1Uo96Tlm8lLob70s293qlvg9OOxfA6WBia7qbjQLR676EsQ+WFoJXw/frIlhpadQ8MATLeOR7qZURmE1rTkR9Fzrk2523d0HR+oEytHvAPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498896; c=relaxed/simple;
	bh=wBRtIAT2L+PZbp6eu7wPIFtx9ImY+8GJfQw4dJHaMtE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TysPydsJYLnsuCcazYIoL0fcZ/5sEFeeaWtTgtz0OhSZeVmJ4cXXngOsGPU4YlxvuqYbFw7RbaSyUym7PP6fuY9MkGn8QUH4PslGHBi5+JmaKrZ5rKvcFoyUbnYlSFfXnzjKrFT4ydk5vJOlj5ZsMu0pwkkj04i+45UNZlw3XEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cP6QM2a2; arc=fail smtp.client-ip=52.103.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cP6QM2a2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFiJdpvOJRc3iJSeXkPq1wzL54VOTo2EDNTL8TzXyGYUJoxTxOHg5RzyScOu0hAsL4rk62oAwsxEKfB0WuI6vTyyV8Jo9Q1fo4AAaU8jUW8keaxwachb5t+Fl2oXLHcmWt8n1bGgfHeQwrtFaUC6fwAOqnBB3QKr5OE02aaUWjuETkNC2Z0q7HcU2Dt2xLzWHArHd6hTLI3zh6nTdmFcZ0jbQIqrYSGBAOssP2dCmEQV+/kbGb+wcP/1YQ7uikkoFKtXZRkNRrdyq6KCroYsVh0qCZh8O3INWX7u7tLngyAXOMBpQt37W2SNpRaF3XmIc2vyA3rCFhZQaE1iKKpRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fQA0cHbgd3GpnDmJBFwwi7+Dnic5NVOPgvF6Ite2tM=;
 b=phV6NcdIdkpugCWxPzWsltlU/sUKKAtfQDoBd3QHVOPN2b+dQlBjk5e7Vy8ZKeiQQj0FEqUP8vZtoXIuIWDZdgWZyeWE3mapP6jyaxeATJKGuara26FFVrbim9CL/1D3vmlk7hl6UiZpRwr9iDNnkDm/QJU+Ue6CnXg4d2aHnQnaJgLVYz0lHcAtGuNYittvJLb5FJr5YPfFivt2LcCUcVNNhkICNhqiwIQ8luXumH8yR3F1rUFFX5phlxwmPjFCnnUxLxOanVpPEX0YP6z3tOkc8iehz3i0ktRj4DE8K73jGjg3EZ/29ZllmdTUlDEKZ3YZi3+GwZ3TSEsxgblwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fQA0cHbgd3GpnDmJBFwwi7+Dnic5NVOPgvF6Ite2tM=;
 b=cP6QM2a262sgcNbT24kP1kvP8upbBmtm+Vldqce1KJKQBTiBTzQfEANrcW7+NR8RtXQHCdpRtwhl1UO7+3AD4sjroR2FpAkdYYN3CN4B2rntGPXIrf3uWxpqutLJKReRrIBcNOYcJzbmx5hK+jL+lmIiy40cjZtMEnPQC50rDe+EURvPV6DqxwZj0xO1aBdNYyUmC/Va3nhH5/R9l+Dqr55JGBfI/5BUWWvXzUaSbTgUolv3RVN+m9CSpNT4YT4Tjpish+Jlgs1k4UeMvcTtYJwAsGzfcQT+EgKEWt8fNC404M6fGUES+3NmLRQVetJqfcrsHb1yLfSbuQROdPk/Gg==
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com (2603:10c6:10:32c::14)
 by SY3PPF346C5784E.ausprd01.prod.outlook.com (2603:10c6:18::40d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Thu, 8 Oct 2026
 22:34:45 +0000
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19]) by SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19%3]) with mapi id 15.21.0522.002; Thu, 8 Oct 2026
 22:34:45 +0000
From: Zhang Jiaxi <Z1529105815@outlook.com>
To: Hans de Goede <hansg@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] Input: goodix-berlin - validate the complete IC info misc
 block
Thread-Topic: [RFC PATCH] Input: goodix-berlin - validate the complete IC info
 misc block
Thread-Index: AQHdV3U4a/0bjoP2k0S9iJFfundmQw==
Date: Thu, 8 Oct 2026 22:34:45 +0000
Message-ID:
 <SY5PR01MB106009B0C8D0A657BA9CC5D92A1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY5PR01MB10600:EE_|SY3PPF346C5784E:EE_
x-ms-office365-filtering-correlation-id: 3936996e-3495-4eb5-fafa-08df258c5ab8
x-microsoft-antispam:
 BCL:0;ARA:14566002|39105399006|8062599012|19110799012|4140399003|31061999003|8060799015|25010399006|22121099003|25031999004|15080799012|38102599003|24021099003|102099032|2607281247196008|440099028|26104999009|3412199025|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B/nj7Fidn10BwJ7cQe+0GFjdybdcOrWHEPqTl5NyVvWhoWBG/FgHCGd9EXo3?=
 =?us-ascii?Q?cmpX1clRaon4FZvIacFcjMB9zUNXgo4f+vOcoPAkQfs2cInTUarlDB84xGTC?=
 =?us-ascii?Q?q8QAf+v30IFNwdomKi6zM6MeE/yxHgjsgcPOKcIedOgsFF12h4ZQk2NrJ9uk?=
 =?us-ascii?Q?GcvGih5c1OJa2j1g2RIrvxzcB5pKmqb8P7dNU9UUG8vL1ES7jDh49CQYdqdy?=
 =?us-ascii?Q?eSwKtZQaU32PS3vTa80PLilhFE3I5rSs+whc0dm9oWHre0nwBPt4K+pMTyuX?=
 =?us-ascii?Q?5EtLS6elZa0gGaW87oG2pNuaf/iGq/s+DwjEbqCY4WD6nCZpihQZVSUbjjNs?=
 =?us-ascii?Q?n4xgvjSASQgRH7+wm7976l1hMwHPL86F2JzLaIEU1rulALlFGgnKvG0QkB8N?=
 =?us-ascii?Q?p2ZaUG371sJRRjn1PeSHVEicHZZJBTKwxJ/NvLzA3S5tHnbgPWK7hZsy1T8i?=
 =?us-ascii?Q?nnLP7THghJZ7P0eXp7kQ6/fH/9jk0fS+5DtEzvbXWK8U6L0I4dlG5xr4pfdS?=
 =?us-ascii?Q?fgWqe7aBhVx+ZSb5z2W66J/cX3u/WZl0KrdvH8hLf5wSZVzEiEANwmIHWPrG?=
 =?us-ascii?Q?CD1bZVjqKHXCp3Ne1/N5wJJG5Oo1Bxf1Tj+wVYzUnsdB3OeryI+QX0JOi8JV?=
 =?us-ascii?Q?Q50/b/zEO41jwJ17zxhlBOoOvzSBM9f0xgjdc5MA9ko6rnX31vgtljAblllU?=
 =?us-ascii?Q?RP7A6SWQXWFKltQWwiVF2QSXJObQQpj2GXgDRv9HJ2WYS9i1iqui50ckTfFq?=
 =?us-ascii?Q?G+tKIywQExJNgExmBqe0OQ4ij0EKb8nDvPmMIZinstzVATLXj+0STQ5EGrqu?=
 =?us-ascii?Q?i3vZRKjVp13PYvEBigPI0tS3nAHs5OBuhihPTZzQvlFvTQty4TjmQvWBlUci?=
 =?us-ascii?Q?EpkLYalEmX4mYxiGQFICq81KLjAE61hO0cggUnQhJxsYKRgx2cNTNuLsHm8b?=
 =?us-ascii?Q?G5zMlHltVp86HPtwU6h3F4d0WmHwwJhmLygwsFQcEZsXD0oZkGw17gRL5IjC?=
 =?us-ascii?Q?uJhe61FzWcOhRYxWbpe32yFlBFd//EkeparZQzpg7gIJOPw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pghyFez4Eqw55OXYoSWLbdL3az4fhQJJDJnGukV+6aiuUbclWNr7zw/k9tzr?=
 =?us-ascii?Q?8pI49YMqH2+DOEahtetGbrbLJU+HZp0AXfvXjJmQ2jHsgws9KJYUjKOgqvH0?=
 =?us-ascii?Q?nlUIi6XAmc2lHLUKJAqqrrxIZBkt+yGLwVR70/iR7oVFIcCeKPkPA24aZNS3?=
 =?us-ascii?Q?8dqGsf/LScRsmrHfAjGyWWpJoc4xw6hOI88bWNAcX4+dBDKKoZ/iEcs6l0p3?=
 =?us-ascii?Q?VMLsEfPq538t5DHakPdCIaU1QUbZSWucCvQ8AqqqKGl+ds6roaXwMh3hX+OI?=
 =?us-ascii?Q?3See2diWN2NaPwHrcBM5o+CLHb1jsATYbPQQE0y0xx4Udh1w3XTJknrPiHoI?=
 =?us-ascii?Q?HEv+jsoxZlaJvFzgFNVFQvXLuEt5EUy6v3+gqU4S3N16A1JL8l0kGizsuUmE?=
 =?us-ascii?Q?9FG3T5Q1LmTV5XIennJVZe+melObmNWzSNtWzsanHi3rFDTa6IFdVv2w2L1I?=
 =?us-ascii?Q?QpZ2Ezt7N0Bl0XQt4ATtxEu68ICpBPDesGM4KL61WOr22WQtPijoBW0J/zBN?=
 =?us-ascii?Q?FenYIvFPyg8CNWvLA0hXA+ajxX0C+FULyMjsv2AMdVK4IrxEPvwQ1PhBN5SD?=
 =?us-ascii?Q?cubZoSmVVc/HZnMjI1N1RLHXmYcQtx+yrEQhNXgq7XnOhhy43piQnJR3iXnR?=
 =?us-ascii?Q?3Rp7QzABjyN1V8ajoNxN6Pyi921PqUZr8TYgAiUq4+GgfI8YcFh+9iGwuPV5?=
 =?us-ascii?Q?Hlg7WTPyMFS/0ymoso2r7oVTyCAnt2JEp1aaLUqltS6ItwljfflR8tQXmm5H?=
 =?us-ascii?Q?yxRbPWOE6bNbBfeGOc9YL8J7y9YH9BkACgCjEONC08NRzPSBwggvSyh4BBbt?=
 =?us-ascii?Q?fJ6qFKt+froNyRf6R2YJjre7oPZKaQ2S8JbrucgsJJmDb0245+B4rSjSaK6z?=
 =?us-ascii?Q?DKwIvjzEha0IC8tMQhZze0ZOzk31T/xdHe50DATONF5MnhqhiNvCTMG4tmya?=
 =?us-ascii?Q?cMSteAtWZb/kk1LkSW7O0xfQFAbAHVLXUxp5PxFYYeR5s/tC+9iU7uOf0lUY?=
 =?us-ascii?Q?NFfOMLHO0vTxlO7NSaqoj2A4q4wOu/UmKY8OTFi2NUdr+XJ+MF1Bpcn1YyTb?=
 =?us-ascii?Q?D3I5ss/iiy2+9gtffxSrP5ANdxaBosMX4OSoSNST967WQ9uWLovPH9Gr0ePo?=
 =?us-ascii?Q?/MyhAy7ViprrvmCRS51EkVf3ScNRznCH0t5Xs0FLktpVSIKK+oSBqpqcJh1V?=
 =?us-ascii?Q?g2vOvQk9fgDkpHnithkKETAeiONapL7MLX2u5AIbZWUJE5zdy9cqYfnRSOZ+?=
 =?us-ascii?Q?AoC5oVJlFNBGtXnaURcUZk7jNCXSdQWotOgbESSscug9S2xnp0S7aVU5aL3U?=
 =?us-ascii?Q?OlTgKlVwIcxTAYDkItSN10hDHdrckIdb5XcPeXo7a5CiMsofBdHVVnbUU0vu?=
 =?us-ascii?Q?9FRBdc/UTIe1Bm//vH133h0MwERZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY5PR01MB10600.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3936996e-3495-4eb5-fafa-08df258c5ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 22:34:45.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF346C5784E

From: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
The variable-length parameter arrays are checked while advancing the=0A=
offset, but the final misc structure is dereferenced without checking that=
=0A=
the complete structure fits in the reported IC info length. Reject a=0A=
truncated misc block before reading its register addresses.=0A=
=0A=
Extracted from the v165 source; no firmware-mode change is included.=0A=
=0A=
Signed-off-by: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
---=0A=
The bounds payload is unchanged and reuses its successful exact-target=0A=
object compilation. No coordinate-mode or reset/resume change is included.=
=0A=
=0A=
diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input=
/touchscreen/goodix_berlin_core.c=0A=
--- a/drivers/input/touchscreen/goodix_berlin_core.c=0A=
+++ b/drivers/input/touchscreen/goodix_berlin_core.c=0A=
@@ -347,6 +347,9 @@=0A=
 	ADVANCE_LE16_PARAMS(); /* stylus_freq_num */=0A=
 #undef ADVANCE_LE16_PARAMS=0A=
 =0A=
+	if (offset + sizeof(*misc) > length)=0A=
+		goto invalid_offset;=0A=
+=0A=
 	misc =3D (struct goodix_berlin_ic_info_misc *)&data[offset];=0A=
 	cd->touch_data_addr =3D le32_to_cpu(misc->touch_data_addr);=0A=
 =0A=
