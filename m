Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022073.outbound.protection.outlook.com [52.101.126.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239684E1C9B;
	Fri,  9 Oct 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557266; cv=fail; b=JQL5ElJMr8/57wG+WScJU2IYClWsuLXAY0HuGVewtB6dxz9ji11t4+NYd17vh9CHAovCYF5H2hLmlTVRloMy79QOITVkQ/jr0DoJwtNXprL6cyrVH9iFwbZFCrQujDt7vO4dOQ7A3nq3AkR7/G8TIphQHH4UrGtnYg/HwI4AGjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557266; c=relaxed/simple;
	bh=MRg+QUKbh0b78mWsgxLpStHMkDggJzXGRAazm4x0v5Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z5sMtQnA7BkrNGAUJjLj65ePIDR1dDwY7SvBvrM8iFm2REx6zGyBJm0YNzO+0U+iPynZiyECDJCOAYf0ByDOO08pQXsYCshD7CLvwEdFQ6KFevAED4VRNB3RyY/Tye9cowaSFQOyMu3zZaZg5nFlD8A9m3SgtKJ5Ucd20d4mcH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=SSS7MQFE; arc=fail smtp.client-ip=52.101.126.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="SSS7MQFE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqaCqmi2+lGFa6qkR9i9Fo0qRBoiBJATaHQD6xUpFJGRzdPWbPwmD7+FSzy/TW9Q6Dr67tTbKAn5gGR9kq8ZfUjsaEzPHrpZ2UrcwF8QEQy84DDXaCqLeIfrIxPjoqyZKlwDsjuaHtJmHVGNSp1KJW5vyp8cJ4ZDUu2tMDOf0Kcpl2CuGOD+zBgReZUYibo/bFT0wTUc1/JJi1rGGM+NvkQS3sARKjjCCk+U8K42+2bYoDjmhdEFEN6BrUhUd/4Vm4Ed0qDftH5Lbm/zhKyBychg0K9hfzbZ5h0kVeyVrNT5/YudddmIBa6p4iIvrMxpJoy80bTH8SNGitwQaqh9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wW4p6hwy3kLMfHFu9TMeEQGUKeZ8iU6iXWa0dL/cg0=;
 b=F5I4pW3YyRQg7zpFomxO2KevQ2s3+8TLfH56dzlUPaUglv5GC0a1Hxhi4dIWQNKuQ3KSc1f92BPv9eRZcj7UyTPPeBvF4rwNTDOFLdbjAj50Sbo1Y2i1XXBA62a69twCw7dRj1jC2BU2NV8s5U78wKM+PNa+R+K/iO8IkS14aaRh1zAruVghsgj4gVynOJyHWNUlNPKfocQWqdgf4N6nNN2lBxu+w8z2EjaHdCOsftthL/yAo156tZ7vsro+sEyRVzceFnI85+P54HwmKTW0uNury/WW26hSiVtE/rcBnPwURbvUQlZ6ZRVCHHtE9988RxfTcON57ojZCrr76HnnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wW4p6hwy3kLMfHFu9TMeEQGUKeZ8iU6iXWa0dL/cg0=;
 b=SSS7MQFErWSd+N8YZntRA4WzOB0dhVx3qMXV+lQ9tTI2sepq8bI2qAPAPKXEOs8sjF2npSF1KkFZFBxW6JgVppsOAdwcV3yAvcNFzDYe9j50ONNQZXr4t9zEm9+aG+8xIQsEhnc4TXH8xYSr5+YYgNoaDvAmhyXg9paAkxaoH3J1JVNJJzBvSUwyc0q16o/4OYhRkZxJueI1SyNkl0sN12ueaQf/NV6lJ6bzou/VgNeearykosD+Yxwb83tDATNK765T/ogPC8ZliFHSQeaiH+dLebSOR+/smlMNlYiAcIpWJxE7RvaaKroCtV48XFq2ED3WFHh7QuUOrM/cTfXt7g==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by KUXPR01MB8095.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:9d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:47:41 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:47:40 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add Nsiway NS2009 touchscreen support
Thread-Topic: [PATCH 0/3] Add Nsiway NS2009 touchscreen support
Thread-Index: AQHdV/0i2sZ9VtigXkKmzmGQESBo2g==
Date: Fri, 9 Oct 2026 14:47:40 +0000
Message-ID: <20261009144729.85832-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|KUXPR01MB8095:EE_
x-ms-office365-filtering-correlation-id: 4a202b88-eae8-4f99-5937-08df261444ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|56012099006|18002099003|3023799007;
x-microsoft-antispam-message-info:
 LT3NccEH8sP1TwZvrvE2U0CClcucjzsm9vlHMdZeCw4mUM8rsaw9OKcQqJIc/fBfje2oNxGgVPKvRwu/p/9eThI6Td6pEU5nmmcKXyKhzvjbsQOgk0rPGTBpf1KwenC3GxcvYqCuG/NmQiUFYjpFQ4oSTDny7r0m9b9eIPUG/CkGeI6SQbJ9hW3Vk0FSpWiE2Od+uU19nInbC9KU3H1CM9KHaGxeGMJwKvfDlcWnvoD7Mc/UXNc9r2IMZrBTv2VEAVq3TzFzlvIMpmPpmjZrRt6nTilDjOzCj0Dxn66RkwTVDaKa3/A7Wx0DCva+MPBIu+y1oOZ/+oY7WnYpJuNWY8hj4hctlgxHMNyqyPBhI1Ze0rJXosHLYf74KfDIkzYdGirfMJB5ioUFsG8I7D24SzRkJIFTcM6JyA9HIdcl08LO2cVT5RGHt8v4Rhtl96T5ewbZW5S2lZpYpn9o6+t7aZdeDpiAyloD4zV8OPvD29ClbJOBA/dZq435DylEFEYLacyxFnQ2wNt/ngTOj1Q3Z424garRfRUIvsQWBao2ebVWk0omoOfN0XJsjl2Zmtvxt2/dePxuaNcMTzaOUImz5b7QQdi5Q9mWy2MR0rsARWmiHHYtfN9re6tX8FVf1tsHGwYs5eKlGHB2FXLAWETNPUFamL8COoGNSq4qj3ts1j+Drao6qfgHHKSrT+8PKFM6sHS+NdrnDwDX9sN5ZhLf/5TAKClvQOIVWqxRaD2Zpxo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GlwmO+dHompKNsyIIKOjTiN+EKUbtzxgb9szHK0UAzRdYh/ApTDB3lRAut?=
 =?iso-8859-1?Q?3iyT9GVga7c1mMBeLa1WRHBDCicJFszVx7GMY5zEwLw4TeurlewmeTTP2g?=
 =?iso-8859-1?Q?76W+AUh5485J6ERM9vnqbSDUx1GqHc0/c0FaAxoK91hVFqsdTBcIUAxarw?=
 =?iso-8859-1?Q?y3mvPFqS3IztNMAArKETjyIR0hfZuZt5aaLdC7dGXWDn2dLhAuKvOWwJUj?=
 =?iso-8859-1?Q?inT9FcovT3/hEbaIogLk6NFADUP3H1tAWmQCgV1QAkBoY3PpnGBWsHoTyw?=
 =?iso-8859-1?Q?tnMUm2E+0ZESn86xGV7lVksJk/39YuI++nV3V5cdEq37zI/ZvKlTZRBRPh?=
 =?iso-8859-1?Q?14L7aO2IBUcPobdaYVnsI0rSZWpzCbP4VWSzxrA5THXsBI9eP6ZaMPxdDU?=
 =?iso-8859-1?Q?Rhj2xsxg9ABi0xCsZkVhR8oEbe3EHC1CI0WqiJgqqp4sM/yK41OAdTFNsX?=
 =?iso-8859-1?Q?7QwioZltyDbRvCLK2eNmu97MlKQSHhwXLePV8QuU9iB4PXUssCEzKOnGUE?=
 =?iso-8859-1?Q?ytGeZMSiyEDpCm7bqyVG1YwqIiMp17dbMhuWONP+391GK5ClDwRNEvK8Kv?=
 =?iso-8859-1?Q?i3bdZSZf7n3NcXA7MuVuK01YkBXySUJXYj8Kar4Kjz0OHdYCDQSbU4dkL7?=
 =?iso-8859-1?Q?VVRhhgob0oopHO49oaZyJmfdAkhhTQ8rAVJ67p6MSnjhyNP8AnyZJNwmzE?=
 =?iso-8859-1?Q?uEE6Ig7BRb4WW3z6JjfiVCSTG3g3SKe7vNJySHchFTmmrALXmNdBybeR7k?=
 =?iso-8859-1?Q?2pU/0+rlbKlOIjllMeEy3A9abpT8mwyjzmqQP6LrOzvC4J8zJIBWajTYBD?=
 =?iso-8859-1?Q?UxQxsSXZNBao2Lu+SH2HZlWpL48apgvujju+h5iqapj9ZAqlZBqGnVwuuz?=
 =?iso-8859-1?Q?OTbui8pIe/vWP2/CmYcCZzZvMt6yN+vvnzdmG3jxRxcHoA5fy4VCZmCBcU?=
 =?iso-8859-1?Q?nTT9Tx6EtbBKgS7mbhFcun1ehmRZuGRJxQhOgNPBAhPpYDUpjY2B6qqPlI?=
 =?iso-8859-1?Q?vEbsy4foTm95BIjmhybdVF3yphfVMgbMygKykl2Vh3NsJr2f72KStDaOPe?=
 =?iso-8859-1?Q?Y+BiSeVHX9gYplkxPHwFJPHvF0/R/1Md+mzN2YuVSF6QAtaRy8PsLJjnSD?=
 =?iso-8859-1?Q?3f5ABt6j2y8mO2zdOkJZpCg8Rw/FpgYVaByMVVYkkn9iWlxWLGJsOc/bvZ?=
 =?iso-8859-1?Q?lpAGHN9ZABr9GwouHQ/72v7mJRg5tJG6PDqXN6gaF48lF9uChmvlA/Q2NI?=
 =?iso-8859-1?Q?zxSZB1vZdeYLIYHljPWEx4JNyEbbZ5c4tPqG1XUJdX7606fHs/0zf0Bazs?=
 =?iso-8859-1?Q?om+4ARR1Y9vaXxk89DIVNtfQqxzeKmvzwmW2SKRGQAt4MIGG9+zUUliJAU?=
 =?iso-8859-1?Q?WpHRnTHRQq8hh03ZK+SE2/DrIz3EsXKTK2ikl9LTDhRrfVJAVUT3TbNaZJ?=
 =?iso-8859-1?Q?lNtpg+mqccteX6+1rhimWb7wd3l1sBKzl72rjAi67956KphmuDh+/h/v6F?=
 =?iso-8859-1?Q?6lT9H1N7fohrKx5/as1O71d1VYRpxT0j59XBCk1o+fucDNawua2mkO+LpE?=
 =?iso-8859-1?Q?hEwN038xWq2qVrtumB2LB3aM5ChqDMb/rfU0+ZgJfMfdIDPjpZloNyrTfy?=
 =?iso-8859-1?Q?9LaxqJ369UCu13DeC7XEGouO4FReMU4B1KoAhD7GL4776UenqcvA0oWJqO?=
 =?iso-8859-1?Q?gJpF3abSOJ/+pxNmkZmYkY12DdB9UxU/FGyNS5me4Tv4Nq9vwLuNffSi6C?=
 =?iso-8859-1?Q?ND5Q34ITGEnhWtmaRcXWg5c5DK5xyx/bXQG+FmTZaH5Xie?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a202b88-eae8-4f99-5937-08df261444ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 14:47:40.8276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cPbPI/Jw1YiR2sL5Cn0S3EStODsvyQRSQpv8M0Wvs9F3fLCFRxVPH+/WcqemnpgdYcPC2tRRvhtJxBmSOWzaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8095

Add polling support for the Nsiway NS2009 I2C resistive touchscreen=0A=
controller, together with its vendor prefix and DT binding. Coordinates=0A=
are 12-bit ADC readings; raw Z1 is used only to detect contact. The driver=
=0A=
uses a 30 ms polling interval and the common touchscreen transforms.=0A=
=0A=
The implementation derives from Icenowy Zheng's 2017 polling driver [1].=0A=
It uses the current input polling API and managed input allocation, with=0A=
no private copy of the input core's touch-key state. Failed, short or=0A=
malformed I2C reads release the current contact and discard coordinates;=0A=
a later valid sample can report a new contact. A transient read error can=
=0A=
therefore cause a pen-up rather than retain an indefinitely active contact.=
=0A=
=0A=
The driver checks the zero padding in the second byte of a 12-bit response,=
=0A=
as specified by the read-command format. Responses with nonzero padding=0A=
are rejected before the decoded value is assigned.=0A=
=0A=
The historical Z1 threshold of 80 remains the default. Boards can override=
=0A=
it with touchscreen-min-pressure; the tested UNIHIKER M10 V1.2 uses 150.=0A=
IRQ, wakeup and calibrated pressure reporting are outside this series.=0A=
Board DTS changes are also separate.=0A=
=0A=
Validation:=0A=
- Latest mainline base: ARM64 driver-object build with W=3D1, and in-tree=
=0A=
  dt_binding_check for the unchanged NS2009 binding.=0A=
- UNIHIKER M10 V1.2, Linux 6.18: clicks, long presses, directed drags,=0A=
  axis orientation, release, and three held-contact inhibit/uninhibit=0A=
  cycles. A validation module changed only the driver registration name=0A=
  to replace the existing built-in driver; the read/poll/probe code is=0A=
  the same as this series. The boot Image and DTB were retained.=0A=
- Two malformed Z1 responses were rejected during the physical run;=0A=
  subsequent contacts were reported normally without stuck key state.=0A=
- Controlled read/poll/probe tests with ASan/UBSan cover all 4096 valid=0A=
  ADC values, every nonzero padding nibble on Z1/X/Y, threshold bounds,=0A=
  malformed properties, core key resets, short/failed reads and recovery.=
=0A=
=0A=
Physical NACK/short-read fault injection and system suspend/resume were=0A=
not tested. This is a new three-patch series, not a continuation of the=0A=
board-specific BSP changes.=0A=
=0A=
[1] https://lore.kernel.org/all/20170315155140.54518-4-icenowy@aosc.xyz/=0A=
=0A=
Mizuno Miotsuki (3):=0A=
  dt-bindings: vendor-prefixes: add Nsiway=0A=
  dt-bindings: input: touchscreen: add Nsiway NS2009=0A=
  Input: add Nsiway NS2009 resistive touchscreen driver=0A=
=0A=
 .../input/touchscreen/nsiway,ns2009.yaml      |  64 +++++++=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +=0A=
 MAINTAINERS                                   |   7 +=0A=
 drivers/input/touchscreen/Kconfig             |  10 +=0A=
 drivers/input/touchscreen/Makefile            |   1 +=0A=
 drivers/input/touchscreen/ns2009.c            | 175 ++++++++++++++++++=0A=
 6 files changed, 259 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nsi=
way,ns2009.yaml=0A=
 create mode 100644 drivers/input/touchscreen/ns2009.c=0A=
=0A=
=0A=
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e=0A=
