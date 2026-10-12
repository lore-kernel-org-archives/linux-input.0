Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023119.outbound.protection.outlook.com [40.107.44.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A7486409;
	Mon, 12 Oct 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807441; cv=fail; b=Oli5nMQ71snrZ5Pw/4cQDDg4PmhWg5IbiEG0IM9vkcToOOG8a6jkueRmfgy7c6SDJ4/jkC21KUA7ccehYMHdOmgcOTV6ZTdRakCZOVxv7Elp5KbhOZ0Xvtj41HCpJJ4ocFnSI4IFybRJEkoJKE5lmqMRRunkufVeu3ZykDZZrp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807441; c=relaxed/simple;
	bh=YwWICq9ltEzGP0khTY2KqGL7yydkcLH3WWj6ba5P9Rs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=me2F1lZ1pFZarKWBNwknkiiYFo12y8u3ITsg9UoAfI+H3ytJ1+ZRVR0uEXZbL+RtqBWM+UNj7Uq6jWmNhBURCUOyh4g1IR1tMeXCjorCP7DKhuYgnAOcJbQzYew71USCSByMVYKpjztxoFUxH3RQzvKz1QTH/TFSeqCwYNslL/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com; spf=pass smtp.mailfrom=crepuse.com; dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b=JwjJRv7v; arc=fail smtp.client-ip=40.107.44.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crepuse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crepuse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crepuse.com header.i=@crepuse.com header.b="JwjJRv7v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+COzYtWffQ2kFGEbjHyzxaTL5qmGYDgL/E0ZHZp7en8KFGSB7k8URZPSM6LSqubqNeoA+jEMVHtY22mrJ4FUrXSEZHcud+B4c640P5usPyXA3S8m5ZjFhy7Fx1YkT7ROxCfcD358UIl/mnUppy0Hk/PfrglTGTPvc3e986qH2V71SAeeMG7/6F53PY/bPfzF+3dB4/qvI7JTUoq+D4udcgfoyntMZcGW3wsC2SoTCpr0LuGJZI2odphWZ/mBjahuL9/LOZl3BlSOl9QKoK2ROIgL0xPO+e8nxmwFK22kUAN8/8T3NzuCf65kYlCLfHvQRpunBtvLR77y4c60lJuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj+x/WqC3QSG0d/3W9ieDeFEGKeprDJyElyybmEbQwY=;
 b=hHG/aXiBj5CIlhNZy+eWWN7RhcZQp9nAO4rMnZqmX2OQza0kmuI9QQQF771Yo3wAfuIOA5KxyIxnWA9A3iIxl+4Za9sBLJoFrrR9ydHYzsbW4zv6pfVQxUwHa0o8pCouk+CWnPjowgYju5moWhdZOMCrhveJDD8/iCNNx+LK1vrDwPf3tlOPzeDmqA8OjxKtUs9NaG5tk9CT2JEPM/8xhZVE/D+778k+xOe2od9O85G1rkiNYIPCCIubcSAN6hiPtDJ5E6YisxeQ7i4ttM9rmNwoOqyAjeJjYE/5Ph56FwSsUJmJBMHSkY8IMfALE/OqIhlU9kocZ4PshiFdS0DxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj+x/WqC3QSG0d/3W9ieDeFEGKeprDJyElyybmEbQwY=;
 b=JwjJRv7vnNIjn9NOjQdRS4QXfgFvOgHW3I3T6NX/8HhEBwUD7kjEIpX89n2NNklGxLUkyzVHSy1L7J504tMPgF5Zms09X9rSAW3KYrUDaeXyLB/uvzFN0Y6FCUzHp6SyLCospY8vklhGTiyS2HP5fkN7VSgs9Ynmcf5fH2RhporNG5jJB9er/RcfyWTAKockKUCjqf7hvCON10FoVKOadT99WlSwW1zPavfDdJ7GFkq6HsUriL/i0g2Zh1cfMhcn6b1cjADHUia+HdF8STkRcJCyZ37PwdQGkvnaP343OCR/8sX2flAh6ohOLNq0mnF6ivCGQTaRox9QiVU2THf/UQ==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TY2PPF1753F85B8.apcprd01.prod.exchangelabs.com
 (2603:1096:408::389) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 12:17:09 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 12:17:09 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "icenowy@aosc.io" <icenowy@aosc.io>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>
Subject: [PATCH v3 3/3] Input: add Nsiway NS2009 resistive touchscreen driver
Thread-Topic: [PATCH v3 3/3] Input: add Nsiway NS2009 resistive touchscreen
 driver
Thread-Index: AQHdWkOaegWaNj9HckypHytzI06+cw==
Date: Mon, 12 Oct 2026 12:17:09 +0000
Message-ID: <20261012121705.53396-4-founder@crepuse.com>
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
x-ms-office365-filtering-correlation-id: f6f07df7-d538-41a6-e1dd-08df285abd53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 NfZfGUTOKnIDA6yGYMTGvZqCXi/euXpgJ9cdqZblghrK0YQqS7XxOk/+pQxAlfgPmMm5B/pXkuZikHQTrchcix1UEMnkMUXBaIzKi7BSmV/woYLLD7qEa1MRqLs+0L6IUrHUjdtOgsIUuYK/o6A4Mc/Pb26BsyheGt/I1emCtMm0iO9AkIJDTuaG/BGNgPm7mH0XF4qRRJRjZ6yhCoIkkxeFrjTq5I+i5NPPlzzD65F5q4OjjB2Gc0H+rmBSW2CL6G/5qH+uDjzMb8XJqbLVM3NvsZBc2v6tfXPCR7l1JOxEn/STMab+8pMJlueimWo3wqE6jvVTTKXEEuoBQPWXGQr1LgiurPjzl72mVKdLjOFyO79uDnlIbcxrsScicK2YJkgn9nPM8TB8e25tGcpn5tJUr6BBDLjFQNbBxu/owOn09zpIon/FFg/7xTRMdC65zRFbKB2kLWRrOPWbAlCSxn5ZM9irjUkLJX4CyY/vI87MOtvKBf3C8NQzzI7UVFDgvo8cl8ukmGG690invsrqGDVgpvXrvdGFQwmEq+Ftd2FlXuUrDlYX3NsrEI/PPtnwfCuUSSHzatCeMQKJiVGGYt5XGsBq/fR213RIemM4acAPMd4aoj/8U89PtJT47latHJvXCIXZN57Y3/SWaWERQ0BfaRgfYWsr7ENEaEGLvZ+psQw4zTHPsccooiUOuWLQRKXPuyg2eSXkgOpnBckn/pT68dlQhsRcpzDrFFa0ktQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wdt24B5kjtdRAMcvCskqrtk89DzVpFKxl22OCTLiUk5fqvg4566ytBAtVu?=
 =?iso-8859-1?Q?JOF8c7Sn5EwKLy7at0yAUrUVQDDXwBAmCX4kQnC40LuLVbXgD9qPU4bulA?=
 =?iso-8859-1?Q?ppzlEXxW6xw3kx3wKga5K3xLDYS44MIaG6215Uk6g+Coied4RXK7pE05Ky?=
 =?iso-8859-1?Q?1NcKHLuRgDqqxzBqgdI584PbodaAUt51h/KtD0Ze9yiLtOQzq2KbQ4XsMx?=
 =?iso-8859-1?Q?Ji0g281tQ3vnfYKwYLgyRZmI2tz8hWU2Cxd8Exc5sD1FqYLqd12mvBeUFV?=
 =?iso-8859-1?Q?9hguHumJRar++Hd/odtpqIp8E1SYpMRoKTf4lEtfWqNi/xpJB3bMvEAS3z?=
 =?iso-8859-1?Q?frTlLWn1b5S9szMGsalKh3iqxA3wQGSF6XctkfQVu3UHC5ks2xXffMgH1O?=
 =?iso-8859-1?Q?kiJIUmKK53ClJPbO36tHA9kvEXCwEEoDP88CrCci4F5kBd8BJyD7/xPq79?=
 =?iso-8859-1?Q?c/EXdulkB1FuqqlCsdmrS+DWKiN6QyHh8pZmPUpEwv5DrxT/JBuVEDgyN7?=
 =?iso-8859-1?Q?XjI4VRXsG99QH0uSFK6VlqUGyIbdHU5tUogvJ0vCtJ61zKfaJx1OlKGUWM?=
 =?iso-8859-1?Q?9fIm+Q4CRGdCzY9JpWOFnaCpl4ntrjsaeY1oCh/TsFVuOHQ2Ro6plIIczq?=
 =?iso-8859-1?Q?Z6stqUY+TxV8kEjcEal13mqGkYPD+kUUV5aQv0uOdakwdYewBXhUPYLK8/?=
 =?iso-8859-1?Q?rPkSSxRfqeN6Qs7ixz+X3mObai+1cS3a+cvlxqdpb5IMDWxXXYOUZqVANJ?=
 =?iso-8859-1?Q?59TAnc4YTkw7WTsQTApMNM4d/TLzZlt8lEnfdqV1ewaMgSfqflMwUd4Tot?=
 =?iso-8859-1?Q?cEkG5Ss3LGM5YK/+xMnCD/MOm+AiOqj7BtpMmfD7tyXwjRIF4PI+aNLGES?=
 =?iso-8859-1?Q?5rgiAr1EzzQjlOHip7NDE+hJIsFTJdhKcuJ09ebcSckFOcbDS3c+Ncx3Dr?=
 =?iso-8859-1?Q?QEfIeSPo+X9f0ltFTS1KdJ5UF/3bo+iA07g01a8teFYw3pSAyVIcD4fK6P?=
 =?iso-8859-1?Q?pPO5ceIidOoF2N9j4bTnpB2jeAY0CudSeK1+CuQRZ993JFj9HEeoAGITld?=
 =?iso-8859-1?Q?Y6axXUZRseqPwWbJZJcl5tjEwXLpw1ub2NXbsQeOByn7L4V/BGa3G0itZm?=
 =?iso-8859-1?Q?gZDGkJBIX/2HXpox50HinKGSKnt4VO+A/T4zL8gZLc/4sP5K44k+Gd5nec?=
 =?iso-8859-1?Q?hZadYjoe4lR2y3kxT4mGp3gJXdQBe8onjPMMru4xVmejatbddeXtvFQQ7O?=
 =?iso-8859-1?Q?VdTpGkXCP/A32BURcAJKoOl+5nYKFcqqb7hDrk/A+o7K7ZReZIi4TM2Juw?=
 =?iso-8859-1?Q?0evvYCq4JdtCiysvgAbQLtI2eLgA+jmpTzyUXLVdhos6M1yQ6QH9DhVeyO?=
 =?iso-8859-1?Q?B6mK23s4bWBlVA1aAk07Qk6FNzDEVw2lKdRAxkeowpk8wYQAmWq81W2Mky?=
 =?iso-8859-1?Q?NU1cQaPNv2HvHh+IqmFEVF2ezN6NB44D8g+ndOMQ6RIvxEwEZOb0vqMjVF?=
 =?iso-8859-1?Q?SQv+4jHuXHtUT6YHQ3nduXGyhYlGOcJfgBxHKFBuh4fxDc0Gfs72PrO2xl?=
 =?iso-8859-1?Q?5llKEw0+VL60I3mzIX9ZUhhUn5m+zXLWxyc6JqxrZ1X8Vmh3Svdn7/8j8d?=
 =?iso-8859-1?Q?HNJ0BgMdGPtFcFB7COiFI0KIEIK6BAxPYn3DHSoSQYVeRuo25pM2pom9nJ?=
 =?iso-8859-1?Q?DrsYp/I1vZmDVgN2/FDSsy7L/a1gWAtprXIF2AQZpSeN0j9bguhODtrUvp?=
 =?iso-8859-1?Q?vdbM+WpjMRwwlUhBRkF1fH+TnV1gUK9UvSN9GA2rQzWeFd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f07df7-d538-41a6-e1dd-08df285abd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 12:17:09.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+vRo9kpzc5pGTTM1IBkPIzpVWQjqRx8NH4lLvYnpKcqhSJCoSCrLyr3x3iLXZ0D4rPJLFL7CCRG3l19JbkxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1753F85B8

From: Mizuno Miotsuki <founder@crepuse.com>=0A=
=0A=
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
registration name to replace the existing built-in driver.=0A=
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
