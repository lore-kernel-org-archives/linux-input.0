Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022073.outbound.protection.outlook.com [52.101.126.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3E4E8DE4;
	Fri,  9 Oct 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557272; cv=fail; b=abloEH8xSn8mWw42qXi8G/WYndkSHN248oXXV4QTWKLWgoqew4Gpg/Wgzo9wkAzAbFKvgwDdNHiAPfBKo1IT6Z2SifaDwtNZyCMnI5yMtvg9vQiBvNhEm85KWMH/Rrc0R+xnry3XeM0R/+CZM56W7v6v61r8nbfqSC/h0YMiDrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557272; c=relaxed/simple;
	bh=eIHLBAO3f5C3GXMhVtvoaXlr0BzwLbp2wNuulpEuT0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oVDkWkwAuxJdr05MvMlsyYm52mtav4hiawqlr10iZc/a5Y9hu1y2EHLfmV6d0hQMZTYGymJBrm65tvKCZUHofkK2TgPHKrqJXquS6QvMcLCecHS9aLv1K0KTyX2bhtqrNo1qhoc9kCdV9rc3kNwQhyTEVJIkVgep3dlvcKZDxYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=dEQcorTV; arc=fail smtp.client-ip=52.101.126.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="dEQcorTV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlzOWWDQeJrVO9mUONBgMVpXdP0LG7G6j+OdbOK9pS//HI7O13FDw3EJKQAFIaCY5id+GcPmoooNyoVLgNKlcV+LHtwpbrT7xuk3fENxeM8MErojSjx6KKUFgJKkWXZjajiv/34annHqESKV/5XzP9Kswj3AGyLZGHYrr3zSj/ih5G+SKjoQJrk4OocYubpQ86lXZvbOYcmkJ1JFNYXqS/LYBF7kawq3Yn6y7l4HHGp19qT9q/7vbLaV+yScIl/lytcId5zvK4m9EwCYOfIEtSk9Tb4OCJlU9znYEfwB1xk9aPkDq0h+7SyS9Ljn50lUidf262B98HZOW9mpj6xC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgbFjKnPGXiTpjbxWH4n8CdjVICWW7hn21ggd7sjg9Q=;
 b=j2TQOYWYR4rrQPopqO5pwuMYwMUrHJuaIVzwjfJsHpTGVUQig2B5e6JpgDFfEtZD4yQA/5ZDcob8JVmdqm+bGsV5oINECOtgIoFiEyKZu4nk0eYIYkKmOZHhp2eybwMgKjBV8qEIoAKs0bLYEbX1clzg5veWoH82F2JxlppZpkzU7SPotDiwq1CDFOSYPvF9TlomXJG3frzdVip46GwM1+SXkSEJlglR4A5rEt/qgITtsH/pDBaYexmURKD86OKaBFuAF05e9NQhPpp6uvRrMmKIiu1FV/RWuOgQfVz/vEIw7YydewK5tibwZ7Dn3HJEnKr5MwoqcNvJngmlRuaiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgbFjKnPGXiTpjbxWH4n8CdjVICWW7hn21ggd7sjg9Q=;
 b=dEQcorTVXD/1TLKRdbE8NaHFTFTgGQWMBxAUuMedUCeo8Od4vMuSFN9jz3/WCyNjkTYMkvLwJcIbD8syMPRWHq+QgWoubOm9mAq/+E2KZLs9dMXAHNoOh3w6iHPLS+MjcTDu9T2koMdnKtZflenhiDLmnbFTl1TCgAN5IoeTYmhEgznO3Q6cKUMrOsOUlr4l24ngSddzWLjHgviJuzyQbY2boILyB2KosaJfb1BVcpkxz4sSaOnAywX9MeSQI2OKb/BvclA54fuxtD6hrQOsOxRjP2rsJ1Ye/UPmBeHlrbabnghOzbihJvqBo2bTqdpGZkl/hHt72TX93L/hdDg4rA==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by KUXPR01MB8095.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:9d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:47:44 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:47:44 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] Input: add Nsiway NS2009 resistive touchscreen driver
Thread-Topic: [PATCH 3/3] Input: add Nsiway NS2009 resistive touchscreen
 driver
Thread-Index: AQHdV/0kzKz23qjRWEymikiGYCLGrQ==
Date: Fri, 9 Oct 2026 14:47:44 +0000
Message-ID: <20261009144729.85832-4-founder@crepuse.com>
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
x-ms-office365-filtering-correlation-id: 890eea87-49f0-47ea-c2d4-08df2614472c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 no1BmjoGVDrBtjfU6K4s/MiNytqG4Y30NoAqY7L/nOP+ij184iPQGoXKAwrymiqQ1SR6DB9cW0Un6vhoIhr8yu3UKT9iTjWaaITGMoE1TW5/CxvWSpNqRTqOVn5ewTEThst47XIaxpX0ptqGS4xPnFLSTFpU+8ce05dU7q8oYBKe+rDAZ1wJKPRlflYfNyOknhRaYChNl+0qQCe4wYgg89bAuX/O9u18HFJqDuPY5WRHaaFWv7mmWY373nxzdrO0xQlrggr8O0KMWpJmn2ZaIFhqwH4SZbEGEWfCZIOHb9dvkfxepNR1u1HNjw87C8YPhyEDDJghac2xS0m9GbZBX8/ULbRVB8P7RNn9WMCw9J+V/PGe5U0iTUfGp3i0zejp5YCcjR4qbppY5uq/+GsXxEO7riU512xomFRKgkwpYf7oPznkW5jUwGTs/X0GcTqPm9B8slua69lEXIvw3a757J0TKCHY6D2UxfqSFIVu0pHnwHxZgBvmYFIjjZgg+FwF/NMh4DTC5DV4MpZYkDKw6Q3jkg209FkXggoP647EchWeONvKcohulXqyYfchVCJ4N7DvPzcOgrorWePrH0gnK6E9pdrfbU9dnboFKCyMqia0VTmc/JFkAi9OKkEYt/+8Qc150/77pq7utjoYlr05FyafJ+3ZzJd4BwtvONI9Y5DwhJ5KviqHbi/g2ad9QHG2BEgbwMZIFRsQxqtcIzX7uayUD5MXc8LYwaU7HSDKGFM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kM1NSuI2XP/KuWqfKdfodsjo2aS+BJurQsqH7QRPTtTEJkB6WhCuL0AxYH?=
 =?iso-8859-1?Q?jjY8xmz7ZuLXQNPosDmzlLBnRpTMHtZ30xLWJw4NPr1+VZOSojE9jP95TX?=
 =?iso-8859-1?Q?n6l0/Yj3ZwkVFFmnO3IGfXALcdSDlFYz82gxrs5C9/wXliGpFni/KQmO0W?=
 =?iso-8859-1?Q?0h1fHSXiurhROU8S6TWgj/FgTNOtoGxQ5m38X5dsKlvb7gnw804CWVghkg?=
 =?iso-8859-1?Q?JaW3/PS474aCuf6o/ZAtI3rgeMDxBtyMmtV9Ae6umhWnsRgc09hrQ5dsNx?=
 =?iso-8859-1?Q?wi2WvamDc3t3+GK/xCpojhZNPvFFrUuES5GDw10XpmcR6nDzm4NWl5V4zu?=
 =?iso-8859-1?Q?3su3N0SBddjNGfJiqlPIkSO+qGPM0GPQkuQs0aA8e4XoHOY6OofeDBVOIN?=
 =?iso-8859-1?Q?pjtfjkeC4VU+YymLQznQ0BKnxFUB2Rd50+FcSLS2kwenCZ9LiiDbTz2vwN?=
 =?iso-8859-1?Q?26s68XLBGgXhwPityqIJ9jRGctMwGw3LUBjiVeTXX1elWQszjiuK/Jti77?=
 =?iso-8859-1?Q?J5UK2zVr/zkXEEZwvvmJ9fkjboaoT2fcgXfGSQw11oCHaL9rIseX9qQs1e?=
 =?iso-8859-1?Q?unT3cQvTeZK3aRimduKUp0jdxaY4H47nBEtydDwTnCV8pIs6MzJziGiQG+?=
 =?iso-8859-1?Q?cCV4xT8pkcHpBI9L3MUnyAPxlzKy+kVLtroZtxFJ+YbWBbjHb1DxCMR+3O?=
 =?iso-8859-1?Q?8CAPlwel0b6Z6QwEmiirZ4NgWzAXC0a9r17LIwk9hlkgaFWGnpov8bXRwb?=
 =?iso-8859-1?Q?GHvNOmToy8UQSV8TGJZjDQ9xP5ksc2o1V8wiKHT02emVuZ58CDKpyUiu+X?=
 =?iso-8859-1?Q?DcXGA3XrcR3zJDRqRy3OjBuGUFP67vWQMju+6/6i2YzmjVXiUlT5mY+UTL?=
 =?iso-8859-1?Q?O0gxqueoQAX4slmSawW4GUUugGEscPVOr+5ac3QlCqPR5QMmyJNtE2y8VV?=
 =?iso-8859-1?Q?pCdds8WZLhC8ptxu/zxiHKc+7IffwaFCiauBn1uzzT4PfxJCFSqftaSqyu?=
 =?iso-8859-1?Q?HVfimJrnxN0WYXckkMhev5qeZpft/8SaXUojYI6nZQMWFLOpqLVrdGZiS1?=
 =?iso-8859-1?Q?AakVH+YYDFN0kiA/pcpgiF8GeARv5bn1cyS4Lc4EFhJm7RHB/FELfvpz3w?=
 =?iso-8859-1?Q?v+63agAkozPUxEgrY7DrSJjnLQMLHfmaEJK0hJeGXu0QyS+Ej9m5NnCqjO?=
 =?iso-8859-1?Q?pEQF40ChTNSBqzaODRRpJGWwFqult2plT4H/osiwFzH9sy2F0jC1zJdmDu?=
 =?iso-8859-1?Q?EISCYM9VWEyhtURD9ma/PrYcd8QhcNsnyF+qepTIQDr/kV6ns1cRoYQde2?=
 =?iso-8859-1?Q?wvWeVSYeJz1xMIbzF5w+lPWptvpidqeS7Xf+aO/nV8g7WowHdKBkzA5TOu?=
 =?iso-8859-1?Q?UJcu9vCA4uIo/v3+dWIUOuKtGcEec7MYwsALN4IL33FxXroPOLYJRRHj6d?=
 =?iso-8859-1?Q?56FADYRRmGaYPgWSewMSvQHEas4RsWUFM2HiuHImyOXYUEZhyG79Byb7O4?=
 =?iso-8859-1?Q?kiOUDWbjScMlxpMFpWQQkb7S1vYWZVtIHES/tIdlZhS7WawV6WQwOLf1OO?=
 =?iso-8859-1?Q?qbA2KpJAAicpnhjbUMHSorVflbkMp1UkRoZRPt2LB9hQlniS01mvlQtiPS?=
 =?iso-8859-1?Q?3NEKkjTcUwPl7rodgyycCtky+p6u1di2sQKjbrxOYGbVB+Tb6JUv1RRed9?=
 =?iso-8859-1?Q?l2Wzi2d+hHT4fFTvUaDJTfLKNrXde4SfWshvgopG2jm6OG3slMW2FdStW6?=
 =?iso-8859-1?Q?XwjLBIczbLvJqadkZpA5pTSDsQ63tjvid6fk721e0Oixxg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 890eea87-49f0-47ea-c2d4-08df2614472c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 14:47:44.4702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WIM3rYcjYrrk7e4JGZ29TlXRWTiHi+d0rRjMw45mu+rn7Ub6+bUDKLJnVBQ9c9qniBmVHZN+J0PdmsYkal3Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8095

Add polling support for the Nsiway NS2009 I2C touchscreen controller using=
=0A=
the input polling API and managed input allocation. Read 12-bit X/Y ADC=0A=
values and report BTN_TOUCH from the raw Z1 contact threshold. Apply=0A=
coordinate transforms through the common touchscreen helpers.=0A=
=0A=
This implementation derives from Icenowy Zheng's 2017 polling driver.=0A=
Keep its historical threshold default while allowing a firmware override,=
=0A=
and retain the original copyright and author attribution.=0A=
=0A=
Report the touch key on every successful sample and let the input core=0A=
filter repeated values. A private pen-down flag would become stale when=0A=
the core clears key state during inhibit or reset. On a failed, short or=0A=
malformed I2C read, discard the coordinates and release the contact so a=0A=
failed bus cannot leave it stuck down. A later valid sample reports a new=
=0A=
contact.=0A=
=0A=
Validate the zero padding in the low nibble of the second byte as specified=
=0A=
by the 12-bit read-command format. Reject malformed responses before=0A=
assigning the decoded value, and rate-limit the diagnostic output.=0A=
=0A=
Tested on UNIHIKER M10 V1.2 with a Linux 6.18 validation module: clicks,=0A=
long presses, drags, release, axis orientation and three held-contact=0A=
inhibit/uninhibit cycles. The validation module only changes the driver=0A=
registration name to replace the existing built-in driver. Physical=0A=
NACK/short-read fault injection and system suspend/resume have not been=0A=
exercised.=0A=
=0A=
Link: https://lore.kernel.org/all/20170315155140.54518-4-icenowy@aosc.xyz/=
=0A=
=0A=
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>=0A=
---=0A=
 MAINTAINERS                        |   1 +=0A=
 drivers/input/touchscreen/Kconfig  |  10 ++=0A=
 drivers/input/touchscreen/Makefile |   1 +=0A=
 drivers/input/touchscreen/ns2009.c | 175 +++++++++++++++++++++++++++++=0A=
 4 files changed, 187 insertions(+)=0A=
 create mode 100644 drivers/input/touchscreen/ns2009.c=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 696f2badc49c..e282c02ec13f 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -19472,6 +19472,7 @@ M:	Mizuno Miotsuki <founder@crepuse.com>=0A=
 L:	linux-input@vger.kernel.org=0A=
 S:	Maintained=0A=
 F:	Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml=
=0A=
+F:	drivers/input/touchscreen/ns2009.c=0A=
 =0A=
 NTB AMD DRIVER=0A=
 M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>=0A=
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig=0A=
index 9b9ae8ac3f7f..d4cdf1a7e057 100644=0A=
--- a/drivers/input/touchscreen/Kconfig=0A=
+++ b/drivers/input/touchscreen/Kconfig=0A=
@@ -691,6 +691,16 @@ config TOUCHSCREEN_MTOUCH=0A=
 	  To compile this driver as a module, choose M here: the=0A=
 	  module will be called mtouch.=0A=
 =0A=
+config TOUCHSCREEN_NS2009=0A=
+	tristate "Nsiway NS2009 touchscreen controller"=0A=
+	depends on I2C=0A=
+	help=0A=
+	  Say Y here if you have a resistive touchscreen using the Nsiway=0A=
+	  NS2009 controller connected over I2C.=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the module will be=
=0A=
+	  called ns2009.=0A=
+=0A=
 config TOUCHSCREEN_NOVATEK_NVT_TS=0A=
 	tristate "Novatek NT11205 touchscreen support"=0A=
 	depends on I2C=0A=
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen=
/Makefile=0A=
index bfd9de83389d..c5fc2062d7cf 100644=0A=
--- a/drivers/input/touchscreen/Makefile=0A=
+++ b/drivers/input/touchscreen/Makefile=0A=
@@ -68,6 +68,7 @@ obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+=3D migor_ts.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_MMS114)	+=3D mms114.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_MSG2638)	+=3D msg2638.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+=3D mtouch.o=0A=
+obj-$(CONFIG_TOUCHSCREEN_NS2009)	+=3D ns2009.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS)	+=3D novatek-nvt-ts.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_HP600)		+=3D hp680_ts_input.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+=3D jornada720_ts.o=0A=
diff --git a/drivers/input/touchscreen/ns2009.c b/drivers/input/touchscreen=
/ns2009.c=0A=
new file mode 100644=0A=
index 000000000000..d5c1f9f96bb6=0A=
--- /dev/null=0A=
+++ b/drivers/input/touchscreen/ns2009.c=0A=
@@ -0,0 +1,175 @@=0A=
+// SPDX-License-Identifier: GPL-2.0-or-later=0A=
+/*=0A=
+ * Nsiway NS2009 resistive touchscreen controller=0A=
+ *=0A=
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>=0A=
+ * Portions derived from silead.c:=0A=
+ * Copyright (C) 2014-2015 Intel Corporation=0A=
+ */=0A=
+=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/input.h>=0A=
+#include <linux/input/touchscreen.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/property.h>=0A=
+=0A=
+#define NS2009_POLL_INTERVAL_MS		30=0A=
+#define NS2009_MAX_12BIT		0xfff=0A=
+=0A=
+#define NS2009_READ_X_LOW_POWER_12BIT	0xc0=0A=
+#define NS2009_READ_Y_LOW_POWER_12BIT	0xd0=0A=
+#define NS2009_READ_Z1_LOW_POWER_12BIT	0xe0=0A=
+=0A=
+/* Historical driver default; boards may override via firmware properties.=
 */=0A=
+#define NS2009_DEFAULT_PEN_DOWN_Z1	80=0A=
+=0A=
+struct ns2009_data {=0A=
+	struct i2c_client *client;=0A=
+	struct touchscreen_properties prop;=0A=
+	u16 pen_down_z1;=0A=
+};=0A=
+=0A=
+static int ns2009_read_data(struct ns2009_data *data, u8 command, u16 *val=
ue)=0A=
+{=0A=
+	u8 raw[2];=0A=
+	int error;=0A=
+=0A=
+	error =3D i2c_smbus_read_i2c_block_data(data->client, command,=0A=
+					      sizeof(raw), raw);=0A=
+	if (error < 0)=0A=
+		return error;=0A=
+	if (error !=3D sizeof(raw))=0A=
+		return -EIO;=0A=
+	/* The 12-bit result is left-aligned; the remaining bits must be zero. */=
=0A=
+	if (raw[1] & 0x0f) {=0A=
+		dev_err_ratelimited(&data->client->dev,=0A=
+				    "invalid sample for command %#02x: %02x %02x\n",=0A=
+				    command, raw[0], raw[1]);=0A=
+		return -EIO;=0A=
+	}=0A=
+=0A=
+	*value =3D (raw[0] << 4) | (raw[1] >> 4);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void ns2009_poll(struct input_dev *input)=0A=
+{=0A=
+	struct ns2009_data *data =3D input_get_drvdata(input);=0A=
+	u16 x, y, z1;=0A=
+	int error;=0A=
+=0A=
+	error =3D ns2009_read_data(data, NS2009_READ_Z1_LOW_POWER_12BIT, &z1);=0A=
+	if (error)=0A=
+		goto read_error;=0A=
+=0A=
+	if (z1 < data->pen_down_z1)=0A=
+		goto release;=0A=
+=0A=
+	error =3D ns2009_read_data(data, NS2009_READ_X_LOW_POWER_12BIT, &x);=0A=
+	if (error)=0A=
+		goto read_error;=0A=
+=0A=
+	error =3D ns2009_read_data(data, NS2009_READ_Y_LOW_POWER_12BIT, &y);=0A=
+	if (error)=0A=
+		goto read_error;=0A=
+=0A=
+	/* The input core filters repeats and may independently clear key state. =
*/=0A=
+	input_report_key(input, BTN_TOUCH, 1);=0A=
+	touchscreen_report_pos(input, &data->prop, x, y, false);=0A=
+	input_sync(input);=0A=
+	return;=0A=
+=0A=
+read_error:=0A=
+	dev_err_ratelimited(&data->client->dev,=0A=
+			    "failed to poll touch data: %d\n", error);=0A=
+	/* An unreadable sample must not leave an active touch stuck down. */=0A=
+release:=0A=
+	input_report_key(input, BTN_TOUCH, 0);=0A=
+	input_sync(input);=0A=
+}=0A=
+=0A=
+static int ns2009_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct device *dev =3D &client->dev;=0A=
+	struct ns2009_data *data;=0A=
+	struct input_dev *input;=0A=
+	u32 value;=0A=
+	int error;=0A=
+=0A=
+	if (!i2c_check_functionality(client->adapter,=0A=
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK))=0A=
+		return dev_err_probe(dev, -EOPNOTSUPP,=0A=
+				     "required SMBus block read is unavailable\n");=0A=
+=0A=
+	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);=0A=
+	if (!data)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	input =3D devm_input_allocate_device(dev);=0A=
+	if (!input)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	data->client =3D client;=0A=
+	data->pen_down_z1 =3D NS2009_DEFAULT_PEN_DOWN_Z1;=0A=
+	if (device_property_present(dev, "touchscreen-min-pressure")) {=0A=
+		error =3D device_property_read_u32(dev, "touchscreen-min-pressure",=0A=
+						 &value);=0A=
+		if (error)=0A=
+			return dev_err_probe(dev, error,=0A=
+					     "failed to read touchscreen-min-pressure\n");=0A=
+		if (!value || value > NS2009_MAX_12BIT)=0A=
+			return dev_err_probe(dev, -EINVAL,=0A=
+					     "touchscreen-min-pressure must be 1..4095\n");=0A=
+		data->pen_down_z1 =3D value;=0A=
+	}=0A=
+	input_set_drvdata(input, data);=0A=
+=0A=
+	input->name =3D "ns2009_ts";=0A=
+	input->phys =3D "input/ts";=0A=
+	input->id.bustype =3D BUS_I2C;=0A=
+=0A=
+	__set_bit(INPUT_PROP_DIRECT, input->propbit);=0A=
+	input_set_capability(input, EV_KEY, BTN_TOUCH);=0A=
+	input_set_abs_params(input, ABS_X, 0, NS2009_MAX_12BIT, 32, 0);=0A=
+	input_set_abs_params(input, ABS_Y, 0, NS2009_MAX_12BIT, 16, 0);=0A=
+	touchscreen_parse_properties(input, false, &data->prop);=0A=
+=0A=
+	error =3D input_setup_polling(input, ns2009_poll);=0A=
+	if (error)=0A=
+		return dev_err_probe(dev, error, "failed to set up polling\n");=0A=
+=0A=
+	input_set_poll_interval(input, NS2009_POLL_INTERVAL_MS);=0A=
+=0A=
+	error =3D input_register_device(input);=0A=
+	if (error)=0A=
+		return dev_err_probe(dev, error,=0A=
+				     "failed to register input device\n");=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct i2c_device_id ns2009_id[] =3D {=0A=
+	{ "ns2009" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(i2c, ns2009_id);=0A=
+=0A=
+static const struct of_device_id ns2009_of_match[] =3D {=0A=
+	{ .compatible =3D "nsiway,ns2009" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, ns2009_of_match);=0A=
+=0A=
+static struct i2c_driver ns2009_driver =3D {=0A=
+	.driver =3D {=0A=
+		.name =3D "ns2009",=0A=
+		.of_match_table =3D ns2009_of_match,=0A=
+	},=0A=
+	.probe =3D ns2009_probe,=0A=
+	.id_table =3D ns2009_id,=0A=
+};=0A=
+module_i2c_driver(ns2009_driver);=0A=
+=0A=
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.xyz>");=0A=
+MODULE_DESCRIPTION("Nsiway NS2009 resistive touchscreen controller");=0A=
+MODULE_LICENSE("GPL");=0A=
