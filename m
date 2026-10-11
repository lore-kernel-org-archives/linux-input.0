Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022132.outbound.protection.outlook.com [52.101.126.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25913C1D52;
	Sun, 11 Oct 2026 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697365; cv=fail; b=mZ8YycCnC9DGYLrnnsObvyy6p91LHMhQZLdtpm5anVCmiMozITCb/k/SFQROCWY4Q0lsW3n01a8cTUSg1x0rWiUQNueGilLJZEKcLwn7ME+L6KR0RCIb5pu/ODjg48ntw0J/hvoagJE9i3zYLnVSA6JmuAh96Yxzt5R5GM8hLqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697365; c=relaxed/simple;
	bh=6yrdMOrpjC8D+RZ34AKPAlGAWC8iZ3QM3bvVkCGDP5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMjzLTxsT0B5pRL4VWx6WrxbPSkKHQXmkpVeu+uMVZ5Uq/FBId5q4JsESKWiuRER7ewE6IrdU2BWJfDghlNYpRPaOQ4fSRJaGTN3J9FhfT0z5qbEzXaksGBQLiI1Xv/zN1QrDuZSP/7V2sxIxNsmjeBugobayAwNJwwZOpZoMrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=D5PxDw+V; arc=fail smtp.client-ip=52.101.126.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="D5PxDw+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3djY6YxT2wDIkxxVRbsDkB2OPTU668r3hmb0FpUNBJX2y9M5+lNP2ryXsbYv9pA5NfNvn2MXzaQQeioU61NB/UrkFHY7cHqRelJqlGdnhD5CDXoWWCpDGHV2ZDi+XVf7v6plsr2cJc/7MQPcR6f+XdgX6xgaeO/Azf1nQdTQpQE25foxpG4gNvnQcqNCwVYhuc8v/eWDwoeesP+Ue24WJ1qL67sVHUX9k4+lKl1s/LFvVQ1ejQVBwiqkl4vY8yCB1exaQdx4uVpfp49KzCHWuj/R1dM9Ls+jooaUHlgkESe6a+KrLkckxuZJ+DRu8KI07Rlpnq2h5BuhDasavfjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7++Lqx7l+VsgKJio4drB22AAaYIxlVfl7OTQ6i4Omm0=;
 b=N5+AS2rlyhLtFcAGqPHAFUmi1cKJ6Tj1GJCQPVyb3tzDkRMEI3eXkhuXuhTyfrkZj7G6ncHnaoeYe5GdwzhBuYFZMA08SsvwCVjghrHKqJppfnvYhL4/xsAATrv/tPiCygvNIpHOB7cQYCL1slbFBBx6rKHzja+RAvYodK5amhQVoMHifCQ95OKJ+GcoXpVS4TwjSjyw5i66eLUk+ipkcxCSUrRRuO7ppg1z8p/Ym+saFlA37ZrcZiXVHTfJhLIgb/hT+WbkqpC3WlC8qSiDZpnWEgQ9i9tduj4x/YAcFn0HIpvEmncauPl//YTXIgA2sHhViuvtEFiHdMLJJNGXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7++Lqx7l+VsgKJio4drB22AAaYIxlVfl7OTQ6i4Omm0=;
 b=D5PxDw+VkNCHYSbqNFwJiIBSicrOISBGOepHJ9/sak+3wTIvh2wxjg3AlmwlwzZH13xrgeUhsqNwSPHEHWgcFQ8WtuXFRpHa2kbErmwhdlv7SfaUNALzaF+CEyJJ0CakP/f0Ld05dnvtBxYwrqMARqpf4RvGxOJGoUnAgxPFQhz6POr1fPSSlIQqr2hHfNhmYD4iaW/6Kne/TSfekG3hHvA/K/M47cBkgqtVx6Co3LcGxrWBmHMlP+wQZv5KLbMnfgBC3uADX7SFTV8qxXkd0N7ZFBEpPIG4X1cFbCnTfwolfIvsYA9QuLWUxrKaTgrK/yP2xqh3Wsrw/Jp+Qg34lA==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TYSPR01MB5702.apcprd01.prod.exchangelabs.com
 (2603:1096:400:42e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 05:42:30 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 05:42:30 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"icenowy@aosc.io" <icenowy@aosc.io>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] Input: add Nsiway NS2009 resistive touchscreen driver
Thread-Topic: [PATCH v2 3/3] Input: add Nsiway NS2009 resistive touchscreen
 driver
Thread-Index: AQHdWUNO7LjYtCvS1k6Pjjr3RBS6dA==
Date: Sun, 11 Oct 2026 05:42:30 +0000
Message-ID: <20261011054223.93396-4-founder@crepuse.com>
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
x-ms-office365-filtering-correlation-id: a451363d-085f-4b37-7682-08df275a7111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|3023799007|38070700021|261009223027099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 eiV1RPnUjMVnQ0rpofRkSs9DgjBZ0ymhyjp7UovFYqSobcd708MCM11XrO7fGfSjhYoDW9HbEoFW82NIBJDJphmN/xHATRcofRvI6SBPnj2kZelhVJ7dg0AfnyP2tq02/atn+ZM8Fpu3YRU+bdvipnh7AlNsUsdiehZaWD7Bm231Sp6G1zKoV0qi15jx0c2d5jed0E9YHOX6x6TOKaslXqG9jN/O+HiS1vEc8kjW3LcHzqCHisQPREuJ4VUmZpHdJhxiVz069NVLCs7UvI8+aEBsTENhA2niI02ieojTOJ1ASfjedUBO4F9lTtPEiNoTmN2bNdjMQ5S6W7bdkTYV8xoEzd44cGrwT8PDTDndu6KPM1tR3lltyqHuYPBjlpstdJzONAh7eSjicz1pO2NuCEdJwVvcyqgmLkmDgGyrygwvmJizcqDgx7n/+oQ9rI3xvfB/kHeSPNne5w7/lYFHCZnZb1RhiuSbmf5bMc1WnHv5TBl8rj7K0r2XRqd6tcKDGtxZh8m0s1qSU4XIkG8Gx3IeEHbPyfuA0jjtqQTjSBbC07q0ROi5cWaAmj/0w2376O2+cS572k+1caeQiatnXTdrha5V7VqPbVi6uKHTeGGYLnN0YQocvd/TVFOiMBJBIQ7ObDoK023YfmsaPdSMbYOvXtMfxmIxwudoRgXyK54srkZbvP981UaVHrsWR2NuqB8hPoWW7E83T0fWagcFbcUwR7bhRtl7pz4697RhiWQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(3023799007)(38070700021)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?P4MM7DW424dFcLmztfHEYW5xf0phsJ5PkUk6snI0LAd8F0/pi4OeIvj0Fx?=
 =?iso-8859-1?Q?oNMyHBNEouGbSzIDfItuMjgSUJ2zMoiyaDgO5SRewv5e8ztjHPKEIys5nh?=
 =?iso-8859-1?Q?Z2TjdwLww96mNIVy6SXQpt/uCAqKqly66ssuqZXHjgYpxc9rgDVLTsYfz7?=
 =?iso-8859-1?Q?j7IENp8RcZEo2zyAeqlDk29AeVGTVS6voX+KKp8ZbKX2nFVwRIDt21eR3W?=
 =?iso-8859-1?Q?uU3uhfaN2VdLR5nPor8YI0BV80gEqOoZBsWCHgsD6ji6Kic/C/BQeL2DHc?=
 =?iso-8859-1?Q?g/6el2tKVTBXVVugVfsCsukqRTBY4e4Pri67rsUrNWDSzgtGjSmcLhWWQG?=
 =?iso-8859-1?Q?URzAIoRJZ1d0w+Ke7iCj/AUCo5b+giz8LgZwlWUKQfb1ckf8DqULj9ZmfP?=
 =?iso-8859-1?Q?cbSmNjJODi+UNec0soGkBBZmU+7SUSNI6gS6BhQnHD5GhAbwxwZ6NLrftB?=
 =?iso-8859-1?Q?v68oSEKk07jfwoSEyZ8O4bPTfmnnQQ7RChPS2TpD6T/KG+HjGDTv3lRRlb?=
 =?iso-8859-1?Q?6Yk1jINBnPCJZ0ABWtCmBf5MNbOGb+SyGtaEwEjITZzuyTQh17eCcNPNyq?=
 =?iso-8859-1?Q?mmMXguei0RJ3dIZsJbNzjELvoJPQEhERgy2Wry4TXe8d15tFcpveZCyQIo?=
 =?iso-8859-1?Q?iFoNmyc1b/PckyZblpinLViFfAxqv7Dy4UdpA3bsDPezmmn/AIHhzWYZKz?=
 =?iso-8859-1?Q?j7MLSngX+EaIyRKxPO4XQ1vfaIBCUVDdp+qg9SUG/e98tVZfSZfrcUa6F3?=
 =?iso-8859-1?Q?FCtFZRey7FXAknzuhsyt2SerQ2mkhx1nkG8mUdzh5inTl2neIWvT40b+Xw?=
 =?iso-8859-1?Q?WpUkMYvP5yscB8nmgP+4cWjjDmlnHX5Z+eJDeXgStFKVYW0Mha5d0gv6wE?=
 =?iso-8859-1?Q?75s39QOj2XA63/HXFKN4eURdUs05kKareBBmFK9mmatp8D3/GnayAz1eiq?=
 =?iso-8859-1?Q?SGEvhEM3HdWWENfyzzf8VbCnXekkndOFEW4slIFDTM+XiTY6U6sq2QQJeC?=
 =?iso-8859-1?Q?IDb0EMJyblOPAZ7MSLWo5uxsKw2prXTZ8Evek4dAE7xTJol8laA1Vul1+x?=
 =?iso-8859-1?Q?+wXC5NuPp5oMjEdJFJcGE98UKyom2paW1/iF2nJ82GOHIMqxChKy/rAFPX?=
 =?iso-8859-1?Q?DxA4MjBb1oSlZwde6IuhT6tgSc1P1WbSlJOvTDyilFhA7kMWFDbJedl6fh?=
 =?iso-8859-1?Q?Vz1xHuh7HNhoNS5SFNE+1N9Zonyz6nAAmx/G3jbJDFVuv2BJy1Ld0Tqh8S?=
 =?iso-8859-1?Q?Yjl32hK8qXm2AVzNqJqwyrVOE909A4GkS5bFIqf9vWVYHX29O3gXfbW6gN?=
 =?iso-8859-1?Q?keNokFKMvPhoddy41RmP5kvOm+pwp48rcA/ubLQmjabE++tVgQTULEtJn4?=
 =?iso-8859-1?Q?D8mbxvTjIs18t2bX2EjYQgX5bXu89M1GNMFx00tiynnO0MvMWwHOwyoGNS?=
 =?iso-8859-1?Q?R3TzRtyGi3xLrpZ0jHdim8W2D27JoNZCWvOjeyLMMUaeuCqu/ro2tnTKI3?=
 =?iso-8859-1?Q?EVLq8EwlVaA+ky0QkG6HmtNjS0E6c/TFR9Yb8iOHIaL/Cpi9oTdeV3F9AA?=
 =?iso-8859-1?Q?fGQlgt3czK+LW1wn440rRA1CEv9QrfbBmQ/X8cWxfc3d6e1jzDaMBEnrxV?=
 =?iso-8859-1?Q?fEVWo0zS5o2b/pN7Af5/4mG7MHikLsj+uxc+2pDyrJwNaxHL/BrE0t+EtQ?=
 =?iso-8859-1?Q?jo/ITePpQU8J7WRMlmeOwMn1og/My4RxABdyfQotbuuXS/ZImzB+gBi2tP?=
 =?iso-8859-1?Q?HiEtN68qBC9qqoiYfoi6h1Y5NndWRO++wphzlz7CSpYl5V?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a451363d-085f-4b37-7682-08df275a7111
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 05:42:30.6834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /T+qoHaZulva66Csw30SM6BhNzlroBADG9ciAAcx/jLv9bwgR/RGwX9DnqWiKllJKfM2cFEfMeQOTX9nWsa0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5702

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
-- =0A=
2.56.0=0A=
=0A=
