Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C0372B55
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623778; cv=none; b=eugZ6K/7V+j8nLvFsG51z0lNqWUBL2pm+Z+hL5gXKqVOqQQgBX+LmA6hVzGK3SNP2EZl0fbM8etYse8xvPuct+3YzBnMKjEc0Ymq4SMzWR3twLZk2WBDCw8iHBK9l1pd1P62byHt9sHkE7zyr4oO3y96RFnAXhjPmdZ2A5HGoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623778; c=relaxed/simple;
	bh=8ihxTxJqsJ1ifXw0Al8EDy7sQ1ObGa79PrV204/6pj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Fv3kn/4P7IH5MZR08tqYri26p0kUe4HVRYlo8DD+K1h5gHbaDt/2875Ut5jmwBRp8vOtKn4dGe9xUQNkTcnVehcqFElK/t8NIXsHru+X/UBMeE5hrzkG1p21sP35xlL/qoOnY9Wzf1PXF/8b8JCxdBhj2VfVLwBdtUeIuMgKb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020105.outbound.protection.outlook.com [52.101.195.105])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-233-jkhfxm9WNx2kZNz6TcaG8w-1; Wed,
 28 Jan 2026 18:09:22 +0000
X-MC-Unique: jkhfxm9WNx2kZNz6TcaG8w-1
X-Mimecast-MFC-AGG-ID: jkhfxm9WNx2kZNz6TcaG8w_1769623762
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 CWXP123MB5737.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Wed, 28 Jan 2026 18:09:17 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 18:09:17 +0000
From: Andrew Thomas <andrew.thomas@touchnetix.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Luis Chamberlain
	<mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, "kamel.bouhara@bootlin.com"
	<kamel.bouhara@bootlin.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"rydberg@bitmath.org" <rydberg@bitmath.org>, Danilo Krummrich
	<dakr@kernel.org>
Subject: Re: [PATCH v5 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Thread-Topic: [PATCH v5 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Thread-Index: AQHcgwyVLinI8ZLgp0GubVPd7sGdw7Vn8TF0
Date: Wed, 28 Jan 2026 18:09:17 +0000
Message-ID: <LOYP123MB2701885B266AE2CC319CD9D49791A@LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM>
References: <20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de>
 <20260111-v6-10-topic-touchscreen-axiom-v5-4-f94e0ae266cb@pengutronix.de>
In-Reply-To: <20260111-v6-10-topic-touchscreen-axiom-v5-4-f94e0ae266cb@pengutronix.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOYP123MB2701:EE_|CWXP123MB5737:EE_
x-ms-office365-filtering-correlation-id: 5bd1b702-d415-46e0-ee48-08de5e9859fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|13003099007|38070700021
x-microsoft-antispam-message-info: =?us-ascii?Q?j0mbhcoicJYLgF2BI2RiIVjlBk/JrdGwj/XI0QAcCc6yV0/mJiFT+5TzXpbL?=
 =?us-ascii?Q?v2wedkOYdCdhWyzldX85w7F2tMHHhJuyYpn+jQSPZ1Eh+JNSvaA5qi0xBD9T?=
 =?us-ascii?Q?OfH8BcDnOmq1xFgmuOXvMYue7ZQMYkKsLH3LmK86nnyjadS4EssPlPfvrH8V?=
 =?us-ascii?Q?zQngtfTxz5dZMnv06QXiYQd2Cid2xkuWCx7NpWvUD89wU07oEo8mtig6U0Z7?=
 =?us-ascii?Q?j3QYtMWf3MaANsOjs/Geiqyd6wm/I+ZRKRdc0ii4oZb7AqjBrDkfy06c0j6z?=
 =?us-ascii?Q?qpfy/5GaOIdad8cPBdGRgNShtPFjT5x/ejeUssJGRd5Eq7kEA8b4QDYYghh9?=
 =?us-ascii?Q?wCDCk4ngSxFMwNZ1O19r10I8E+nOiVQfy4FE/1vIDNrDkcqyGIlDOIUPS4TW?=
 =?us-ascii?Q?FqGV0c0n6BZ2t3Pb7/y3coUyuCB2MSAa7qn5QnJ9cnY0tKJQM7eI8//i7rPS?=
 =?us-ascii?Q?+bkWvXgdzDKzuTP3pWqUGqb8KaLxOB422ie8Ola7MbtxrJv/3eD4xfBp7He6?=
 =?us-ascii?Q?lpAUmaPnoUVF2IF1HC3n6eaBNfd5b96kAwmZqOuxpwiycduP4Vd9amNpQnSn?=
 =?us-ascii?Q?cDkDnN/AqRqnSSuHZNe0UZeB0mYFOTnCv/fjxV7M8hW5Paz+agzcaKhFlD0y?=
 =?us-ascii?Q?mw+FfqrmrfsQrWX5TJ9R3kJ5OnVYCqqSS0AroBmLUhl/RWndfvzgESs/n+XS?=
 =?us-ascii?Q?T8FfFhPngttivBIFo/VTMZ05psiJIb4/5+oLdWmpKHp1L4/2G8mwYDFlBTub?=
 =?us-ascii?Q?Zx/waI34uEmURva4+7IjYYwh+rdXl/wwqbVv+F6vrjZA1Iz7yyBvaK9byxny?=
 =?us-ascii?Q?2gQc/ujjiO7yuwtjPtdJUYnbmNtseJ7HCdPpGHocD8/FNxJ3v5IBGbnhgOTn?=
 =?us-ascii?Q?RTzi7uZhC26j6y/qYl/U7pH7QbDm1Gs2nJkN8UiYOI5wpj9Qz5KZahHh55/0?=
 =?us-ascii?Q?UN2d0kmU1x9DxdrPIe7litOSUHvk2F44lBvjqdGgpyOOcp3aemirl+FtAVxM?=
 =?us-ascii?Q?CkP8IJpWM9DI0OKluPDyqHfNOVxOeB77fdRBeNG6mBPWKHo88JSw/3XkBhKu?=
 =?us-ascii?Q?7apaeT3jbbfeM/+xvDvhl8JpgdHjWZfaMcyZ/vOtXw5DnRSoQvOyFuBy2fJY?=
 =?us-ascii?Q?Ec/g3ubsbUtUD0w7p7KK/+n2/B5Ssp9GN4WhSUFPEg1mtvPHmXKp6kfY0GWw?=
 =?us-ascii?Q?eMatr2AUPSr8pAp0NHL/rnl4c/4OnARWvOqlML5+2UChQoBou1pH/4mSneRX?=
 =?us-ascii?Q?UiAffGTLcElkJH82RpcDfrVZzefkXTdpIk+cOuiiJ1gK3uSkjAtPbSpJnLue?=
 =?us-ascii?Q?49cZi0CAw9atO7pyoqeOq/7KAErq9p2KIs6jWYebWW6sEiKnVXkicFc+gmtr?=
 =?us-ascii?Q?nDvx5tpmM5os6QoMLtEe98lqfyeBz/EsSFF8S6+nZeGZzQGSgHq5cpt6VfqP?=
 =?us-ascii?Q?vl85FKPzfk9YSktS3X07XwgitP6zTbiSRemWRnpN7jcxV04Tzk5PVkKU+QHj?=
 =?us-ascii?Q?o+Q7aa8wKMABnMsGPgJqqoRXwmKzWOO1jPES1NIBFdoVQ/f3TaM+j/pTucL2?=
 =?us-ascii?Q?Tlk4iBHcmEOhRiffyF63EBK5zgsOko9F++6LOhYyPXVxCL6bGpnmqGOAmU02?=
 =?us-ascii?Q?KnbkiNnijEVOOej4bA7/jz4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(13003099007)(38070700021);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n9ClRPpXz3qMvCMIw6VcNinZzgKqE1wdX4bznPmzC18U164uXZI9yAs1sC43?=
 =?us-ascii?Q?41Ci0JDOSRs4rmrkU01SHLhr4U7pQwvLFMOtLBU7+E0bRkZNBYg+H79hk2wp?=
 =?us-ascii?Q?cmMMTlG48aykmNWWK8aHvXHXOet3C2A4lr0E7lMfp8ATjBj0IDkmtijtH6vD?=
 =?us-ascii?Q?HUuAgKikuvdE/ahwoWW2qUfa5DD0cjO2s8h+bVljmXyDdqx/2KwKEClGPof7?=
 =?us-ascii?Q?mXdBJqDnns7wuUPtzdSm65MhyjqN74ThhtvpDedos16V0kaVnfLEdmZh7zuL?=
 =?us-ascii?Q?zgPqZToyOPspPHP3sfHlYSlGABhfzytrtjtTOI0VFjChsZB/kYCoJ9jcnpHw?=
 =?us-ascii?Q?tDpytgoz1gEluP7teSw0ODI6zXZvGpSpIHJmyyOEinNfLsWx2MsPNVE4YvPD?=
 =?us-ascii?Q?dteA10JB490hgZBDPpgRdlu5vRWlvP4+iMLjKcWbtRPBTAytVqJ8ia1nMriJ?=
 =?us-ascii?Q?ZF4LLkOUjiylItQmcYFEi4TDEseeLWWFAJJcbKjwbKOituMbwMe/jEBU9Asp?=
 =?us-ascii?Q?ZT+uFY+rgQyTE9OfW9XlJI/D9rY8K6XC63LU7e3OdwmSKSi9cEZIP7rD6lf4?=
 =?us-ascii?Q?ahBOD2qICPN4aL0ZKh9Gn4ijDTQWY17l+8goNbhx6xUNpo9Ky251iYsiZ2NV?=
 =?us-ascii?Q?BbHNM/zsXWuyL5KwBqzvwse25WOS0HLvgGCgOFQz3gnUf1F0FzlmvXjyCHYi?=
 =?us-ascii?Q?QlhCvsC3fv1IImUwSbIm+bgPvxMnqYe8JAKqDMxcFJBDbptexsCh3e6AkYiJ?=
 =?us-ascii?Q?4gJyOn3YNOtenR9tAcIv7oDvECqb1ivdE8Sg78M3ytkaaQWMFaBH/0upvAQf?=
 =?us-ascii?Q?vblsAFEUaRXoWioyurKPJBEFqML/4+7K3DBtMlickq0RySas8sdsJgc005qB?=
 =?us-ascii?Q?Q4Dqn2kiODZ7/VDPa/Yh+muq9ZHgcKTsiDvHRHYQAL9t2vj2bLxshR0DA0ha?=
 =?us-ascii?Q?NzHy1w5rtMtvDOS9a06K8ZJmNmpco4GaHpTtdtNgTk8Ywgs3RgXr50OIlWtg?=
 =?us-ascii?Q?uiE2thauB+rcU7ZVEKLouC0qJ04v8m175PCeEelozLdypqbdm36fhk01S6BJ?=
 =?us-ascii?Q?QSaEZlhJhGEMoGX/RahmWWwLbbobj3X8U1vv9QlTs2/xItuYhncW2bhuovWO?=
 =?us-ascii?Q?buEMzZzNZQvbv654mhb1rJx9zy1PFO/ySVYOXHs0tc5p7mHdlvLEenGykuT5?=
 =?us-ascii?Q?49SDa31KSWLpIkoQci5a6emVsOVdEOcgFqqXSbIdX+BoaqIqzAzwhTeVYD66?=
 =?us-ascii?Q?7ehtenvfoxWUQeFRBmlokrPxEgXEwpH8lMk0ChFvFSF8Li/qJBwBasJ1Y1S4?=
 =?us-ascii?Q?n1YpCwaBebuNTeNVEQRr7GLeF1Ki1PmORuGQajzw5NA2pcwnxGryvMdWlTAY?=
 =?us-ascii?Q?pgCB/FIsPs0qpVouJj2dNJmvEM0hmSYkNHZH5PWuKtipJrx96rVHhuCxZsw5?=
 =?us-ascii?Q?smKdoaKYSPJC5clok+/CWpTfW0oJ4a998Bvy/PJqxCMiNUheoxZkkyYSQNs8?=
 =?us-ascii?Q?o3rA1zqt6011ryyl9J9T4+fgMOJxxVXtUXWTpg3FF4+lmRKRDjOOLskx5v64?=
 =?us-ascii?Q?8ysqlNv/kwffH8H7danCy3lR2UeTP1TnulArGDRcfKi21ThnEq3fxWkh+OAB?=
 =?us-ascii?Q?WIJmOABWfTqH5ZjYg2j1Rree+ctojMziiY7GfFezXiv8xCASXVWBVQBzlaE0?=
 =?us-ascii?Q?A+NyJK0o8DD2kf4abpluRFOpMOVQYv+dVszvgtDT3IiHvWjSZm/5b3rLuZPs?=
 =?us-ascii?Q?yoYg/OVPiw=3D=3D?=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd1b702-d415-46e0-ee48-08de5e9859fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 18:09:17.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QtxgiVwk3cCDVzKdCFAbJsG77AlOFMS7FmcJBGG49z0/7iQdkJh0wnmZ6bnd2MAlOf4WBSr4OqZy4lXZzUXcds1PN5/+qGdvG0MOpp27YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5737
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W9zn8qu_VwitTS-wX3Gyw-sX6d2OitL-iVWRmrfB1-Y_1769623762
X-Mimecast-Originator: touchnetix.com
Content-Language: en-GB
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi Marco,

Thank you for your work on this patch in helping support TouchNetix devices=
.
Currently we have quite similar patches, yours supporting firmware and conf=
ig download, while mine supports SPI.
Would you be happy if I went ahead and started implementing your work on to=
p of mine to support firmware download over SPI?
I would strive to maintain all the features you have included since it is c=
lear much of your driver is well thought out.

My hope was to include basic support for I2C and SPI then move onto the mor=
e substantial task of firmware and config download.
Since I have most of the aXiom range of devices available to me I will be a=
ble to test the firmware/config download with many of them.

I have done a brief review below, however I have not yet tried firmware and=
 config download through your driver, which I shall get onto soon.

> #define AXIOM_U34                             0x34
> #define   AXIOM_U34_REV1_OVERFLOW_MASK                BIT(7)
> #define   AXIOM_U34_REV1_REPORTLENGTH_MASK    GENMASK(6, 0)
> #define   AXIOM_U34_REV1_PREAMBLE_BYTES               2
> #define   AXIOM_U34_REV1_POSTAMBLE_BYTES      4

The indentation is not aligned on all the defines. And below.

> #define AXIOM_U42                             0x42
> #define AXIOM_U42_REV1_REPORT_ID_CONTAINS(id) ((id) + 2)
> #define   AXIOM_U42_REV1_REPORT_ID_TOUCH      1       /* Touch, Proximity=
, Hover */
>
> #define AXIOM_U42_REV4_REPORT_ID_CONTAINS(id)   ((id) + 8)
> #define   AXIOM_U42_REV4_REPORT_ID_TOUCH      1       /* Touch, Proximity=
, Hover */

Could this be done with BIT and GENMASK? Since there may be many revisions =
to support, is there a cleaner way we can generalise revision handling?

>       /* Skip processing if not in TCP mode */
>       if ((axiom_get_runmode(ts) !=3D AXIOM_TCP_MODE) &&
>           (axiom_get_runmode(ts) !=3D AXIOM_TCP_CFG_UPDATE_MODE))
>               return 0;

Should the IRQ/POLL not be completely disabled if axiom is in either of the=
se modes?

Many Thanks,
Andrew

________________________________________
From: Marco Felsch <m.felsch@pengutronix.de>
Sent: 11 January 2026 3:05 PM
To: Luis Chamberlain; Russ Weight; Greg Kroah-Hartman; Rafael J. Wysocki; A=
ndrew Morton; Rob Herring; Krzysztof Kozlowski; Conor Dooley; Dmitry Torokh=
ov; Kamel Bouhara; Marco Felsch; Henrik Rydberg; Danilo Krummrich; Danilo K=
rummrich
Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-input@v=
ger.kernel.org; kernel@pengutronix.de; Marco Felsch
Subject: [PATCH v5 4/4] Input: Add TouchNetix aXiom I2C Touchscreen support

This adds the initial support for the TouchNetix AX54A touchcontroller
which is part of TouchNetix's aXiom touchscreen controller family.

The TouchNetix aXiom family provides two physical interfaces: SPI and
I2C. This patch covers only the I2C interface.

Apart the input event handling the driver supports firmware updates too.
One firmware interface handles the touchcontroller firmware (AXFW and
ALC) update the other handles the touchcontroller configuration
(TH2CFGBIN) update.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
.../testing/sysfs-driver-input-touchnetix-axiom | 81 +
drivers/input/touchscreen/Kconfig | 17 +
drivers/input/touchscreen/Makefile | 1 +
drivers/input/touchscreen/touchnetix_axiom.c | 2974 ++++++++++++++++++++
4 files changed, 3073 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom =
b/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom
new file mode 100644
index 0000000000000000000000000000000000000000..31c1c6510c55da80659ddf7bea2=
d0ce681fde323
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom
@@ -0,0 +1,81 @@
+What: /sys/bus/i2c/devices/xxx/fw_major
+Date: Jan 2026
+Contact: linux-input@vger.kernel.org
+Description:
+ Reports the firmware major version provided by the touchscreen.
+
+ Access: Read
+
+ Valid values: Represented as string
+
+What: /sys/bus/i2c/devices/xxx/fw_minor
+Date: Jan 2026
+Contact: linux-input@vger.kernel.org
+Description:
+ Reports the firmware minor version provided by the touchscreen.
+
+ Access: Read
+
+ Valid values: Represented as string
+
+What: /sys/bus/i2c/devices/xxx/fw_rc
+Date: Jan 2026
+Contact: linux-input@vger.kernel.org
+Description:
+ Reports the firmware release canidate version provided by the touchscreen=
.
+
+ Access: Read
+
+ Valid values: Represented as string
+
+What: /sys/bus/i2c/devices/xxx/fw_status
+Date: Jan 2026
+Contact: linux-input@vger.kernel.org
+Description:
+ Reports the firmware status provided by the touchscreen. It may
+ be either "release" or "engineering".
+
+ Access: Read
+
+ Valid values: Represented as string
+
+What: /sys/bus/i2c/devices/xxx/fw_variant
+Date: Jan 2026
+Contact: linux-input@vger.kernel.org
+Description:
+ Reports the firmware variant provided by the touchscreen. It may
+ be either: "3d", "2d", "force" or "unknown".
+
+ Access: Read
+
+ Valid values: Represented as string
+
+What: /sys/bus/i2c/devices/xxx/device_id
+Date: Jan 2026
+Contact: linux-input@vger.kernel.org
+Description:
+ Reports the touchscreen device id, for example: "54" for the AX54A.
+
+ Access: Read
+
+ Valid values: Represented as string
+
+What: /sys/bus/i2c/devices/xxx/device_state
+Date: Jan 2026
+Contact: linux-input@vger.kernel.org
+Description:
+ Reports the touchscreen device current runtime state. The
+ following values are reported:
+
+ discovery: Device is in discovery mode.
+ tcp: Device is in touch-control-protocol (tcp) mode. This is
+ the normal working mode.
+ th2cfg-update: Device is in configuration update mode.
+ bootloader-pre: Device bootloader mode enter was triggered
+ bootloader: Device is in bootloader mode, used for firmware
+ updates.
+ unknown: Device mode is unknown.
+
+ Access: Read
+
+ Valid values: Represented as string
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index 7d5b72ee07fa1313da39a625b5129a0459720865..449ae5e29cb4bb1f5335afdee82=
e91f0aa30a209 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -828,6 +828,23 @@ config TOUCHSCREEN_MIGOR
To compile this driver as a module, choose M here: the
module will be called migor_ts.

+config TOUCHSCREEN_TOUCHNETIX_AXIOM
+ tristate "TouchNetix aXiom based touchscreen controllers"
+ # We need to call into panel code so if DRM=3Dm, this can't be 'y'
+ depends on DRM || !DRM
+ depends on I2C
+ select CRC16
+ select CRC32
+ select REGMAP_I2C
+ help
+ Say Y here if you have a axiom touchscreen connected to
+ your system.
+
+ If unsure, say N.
+
+ To compile this driver as a module, choose M here: the
+ module will be called touchnetix_axiom.
+
config TOUCHSCREEN_TOUCHRIGHT
tristate "Touchright serial touchscreen"
select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen=
/Makefile
index ab9abd151078831a4b22d6998e00ef74fe01c356..540df3ada4b2b6ad05ffeba67f4=
4ff262f93c11f 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_TOUCHSCREEN_SUR40) +=3D sur40.o
obj-$(CONFIG_TOUCHSCREEN_SURFACE3_SPI) +=3D surface3_spi.o
obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC) +=3D ti_am335x_tsc.o
obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213) +=3D touchit213.o
+obj-$(CONFIG_TOUCHSCREEN_TOUCHNETIX_AXIOM) +=3D touchnetix_axiom.o
obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT) +=3D touchright.o
obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN) +=3D touchwin.o
obj-$(CONFIG_TOUCHSCREEN_TS4800) +=3D ts4800-ts.o
diff --git a/drivers/input/touchscreen/touchnetix_axiom.c b/drivers/input/t=
ouchscreen/touchnetix_axiom.c
new file mode 100644
index 0000000000000000000000000000000000000000..e8f56a8f7e8a83361b04bb858ca=
adf9658fb7e05
--- /dev/null
+++ b/drivers/input/touchscreen/touchnetix_axiom.c
@@ -0,0 +1,2974 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2024 Pengutronix
+ *
+ * Marco Felsch <kernel@pengutronix.de>
+ */
+
+#include <drm/drm_panel.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/completion.h>
+#include <linux/crc16.h>
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/time.h>
+#include <linux/unaligned.h>
+
+/*
+ * Short introduction for developers:
+ * The programming manual is written based on u(sages):
+ * - Max. 0xff usages possible
+ * - A usage is a group of registers (0x00 ... 0xff)
+ * - The usage base address must be discovered (FW dependent)
+ * - Partial RW usage access is allowed
+ * - Each usage has a revision (FW dependent)
+ * - Only u31 is always at address 0x0 (used for discovery)
+ *
+ * E.x. Reading register 0x01 for usage u03 with baseaddr 0x20 results in =
the
+ * following physical 16bit I2C address: 0x2001.
+ *
+ * Note the datasheet specifies the usage numbers in hex and the internal
+ * offsets in decimal. Keep it that way to make it more developer friendly=
.
+ */
+#define AXIOM_U01 0x01
+#define AXIOM_U01_REV1_REPORTTYPE_REG 0
+#define AXIOM_U01_REV1_REPORTTYPE_HELLO 0
+#define AXIOM_U01_REV1_REPORTTYPE_HEARTBEAT 1
+#define AXIOM_U01_REV1_REPORTTYPE_OPCOMPLETE 3
+
+#define AXIOM_U02 0x02
+#define AXIOM_U02_REV1_COMMAND_REG 0
+#define AXIOM_U02_REV1_CMD_HARDRESET 0x0001
+#define AXIOM_U02_REV1_CMD_SOFTRESET 0x0002
+#define AXIOM_U02_REV1_CMD_STOP 0x0005
+#define AXIOM_U02_REV1_CMD_SAVEVLTLCFG2NVM 0x0007
+#define AXIOM_U02_REV1_PARAM1_SAVEVLTLCFG2NVM 0xb10c
+#define AXIOM_U02_REV1_PARAM2_SAVEVLTLCFG2NVM 0xc0de
+#define AXIOM_U02_REV1_CMD_HANDSHAKENVM 0x0008
+#define AXIOM_U02_REV1_CMD_COMPUTECRCS 0x0009
+#define AXIOM_U02_REV1_CMD_FILLCONFIG 0x000a
+#define AXIOM_U02_REV1_PARAM0_FILLCONFIG 0x5555
+#define AXIOM_U02_REV1_PARAM1_FILLCONFIG 0xaaaa
+#define AXIOM_U02_REV1_PARAM2_FILLCONFIG_ZERO 0xa55a
+#define AXIOM_U02_REV1_CMD_ENTERBOOTLOADER 0x000b
+#define AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY1 0x5555
+#define AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY2 0xaaaa
+#define AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY3 0xa55a
+#define AXIOM_U02_REV1_RESP_SUCCESS 0x0000
+
+struct axiom_u02_rev1_system_manager_msg {
+ union {
+ __le16 command;
+ __le16 response;
+ };
+ __le16 parameters[3];
+};
+
+#define AXIOM_U04 0x04
+#define AXIOM_U04_REV1_SIZE_BYTES 128
+
+#define AXIOM_U05 0x05 /* CDU */
+
+#define AXIOM_U22 0x22 /* CDU */
+
+#define AXIOM_U31 0x31
+#define AXIOM_U31_REV1_PAGE0 0x0000
+#define AXIOM_U31_REV1_DEVICE_ID_LOW_REG (AXIOM_U31_REV1_PAGE0 + 0)
+#define AXIOM_U31_REV1_DEVICE_ID_HIGH_REG (AXIOM_U31_REV1_PAGE0 + 1)
+#define AXIOM_U31_REV1_MODE_MASK BIT(7)
+#define AXIOM_U31_REV1_MODE_BLP 1
+#define AXIOM_U31_REV1_DEVICE_ID_HIGH_MASK GENMASK(6, 0)
+#define AXIOM_U31_REV1_RUNTIME_FW_MIN_REG (AXIOM_U31_REV1_PAGE0 + 2)
+#define AXIOM_U31_REV1_RUNTIME_FW_MAJ_REG (AXIOM_U31_REV1_PAGE0 + 3)
+#define AXIOM_U31_REV1_RUNTIME_FW_STATUS_REG (AXIOM_U31_REV1_PAGE0 + 4)
+#define AXIOM_U31_REV1_RUNTIME_FW_STATUS BIT(7)
+#define AXIOM_U31_REV1_RUNTIME_FW_VARIANT GENMASK(6, 0)
+#define AXIOM_U31_REV1_JEDEC_ID_LOW_REG (AXIOM_U31_REV1_PAGE0 + 8)
+#define AXIOM_U31_REV1_JEDEC_ID_HIGH_REG (AXIOM_U31_REV1_PAGE0 + 9)
+#define AXIOM_U31_REV1_NUM_USAGES_REG (AXIOM_U31_REV1_PAGE0 + 10)
+#define AXIOM_U31_REV1_RUNTIME_FW_RC_REG (AXIOM_U31_REV1_PAGE0 + 11)
+#define AXIOM_U31_REV1_RUNTIME_FW_RC_MASK GENMASK(7, 4)
+#define AXIOM_U31_REV1_SILICON_REV_MASK GENMASK(3, 0)
+
+#define AXIOM_U31_REV1_PAGE1 0x0100
+#define AXIOM_U31_REV1_OFFSET_TYPE_MASK BIT(7)
+#define AXIOM_U31_REV1_MAX_OFFSET_MASK GENMASK(6, 0)
+
+#define AXIOM_U32 0x32
+
+struct axiom_u31_usage_table_entry {
+ u8 usage_num;
+ u8 start_page;
+ u8 num_pages;
+ u8 max_offset;
+ u8 uifrevision;
+ u8 reserved;
+} __packed;
+
+#define AXIOM_U33 0x33
+
+struct axiom_u33_rev2 {
+ __le32 runtime_crc;
+ __le32 runtime_nvm_crc;
+ __le32 bootloader_crc;
+ __le32 nvltlusageconfig_crc;
+ __le32 vltusageconfig_crc;
+ __le32 u22_sequencedata_crc;
+ __le32 u43_hotspots_crc;
+ __le32 u93_profiles_crc;
+ __le32 u94_deltascalemap_crc;
+ __le32 runtimehash_crc;
+};
+
+struct axiom_u33_rev3 {
+ __le32 runtime_crc;
+ __le32 runtime_nvm_crc;
+ __le32 bootloader_crc;
+ __le32 nvltlusageconfig_crc;
+ __le32 vltusageconfig_crc;
+ __le32 u22_sequencedata_crc;
+ __le32 u43_hotspots_crc;
+ __le32 u77_dod_data_crc;
+ __le32 u93_profiles_crc;
+ __le32 u94_deltascalemap_crc;
+ __le32 runtimehash_crc;
+};
+
+#define AXIOM_U34 0x34
+#define AXIOM_U34_REV1_OVERFLOW_MASK BIT(7)
+#define AXIOM_U34_REV1_REPORTLENGTH_MASK GENMASK(6, 0)
+#define AXIOM_U34_REV1_PREAMBLE_BYTES 2
+#define AXIOM_U34_REV1_POSTAMBLE_BYTES 4
+
+#define AXIOM_U36 0x36
+
+#define AXIOM_U41 0x41
+#define AXIOM_U41_REV2_TARGETSTATUS_REG 0
+#define AXIOM_U41_REV2_X_REG(id) ((4 * (id)) + 2)
+#define AXIOM_U41_REV2_Y_REG(id) ((4 * (id)) + 4)
+#define AXIOM_U41_REV2_Z_REG(id) ((id) + 42)
+
+#define AXIOM_U42 0x42
+#define AXIOM_U42_REV1_REPORT_ID_CONTAINS(id) ((id) + 2)
+#define AXIOM_U42_REV1_REPORT_ID_TOUCH 1 /* Touch, Proximity, Hover */
+
+#define AXIOM_U42_REV4_REPORT_ID_CONTAINS(id) ((id) + 8)
+#define AXIOM_U42_REV4_REPORT_ID_TOUCH 1 /* Touch, Proximity, Hover */
+
+#define AXIOM_U43 0x43 /* CDU */
+
+#define AXIOM_U64 0x64
+#define AXIOM_U64_REV2_ENABLECDSPROCESSING_REG 0
+#define AXIOM_U64_REV2_ENABLECDSPROCESSING_MASK BIT(0)
+
+#define AXIOM_U77 0x77 /* CDU */
+#define AXIOM_U82 0x82
+#define AXIOM_U93 0x93 /* CDU */
+#define AXIOM_U94 0x94 /* CDU */
+
+/*
+ * Axiom CDU usage structure copied from downstream CDU_Common.py. Downstr=
eam
+ * doesn't mention any revision. According downstream all CDU register win=
dows
+ * are 56 byte wide (8 byte header + 48 byte data).
+ */
+#define AXIOM_CDU_CMD_STORE 0x0002
+#define AXIOM_CDU_CMD_COMMIT 0x0003
+#define AXIOM_CDU_PARAM0_COMMIT 0xb10c
+#define AXIOM_CDU_PARAM1_COMMIT 0xc0de
+
+#define AXIOM_CDU_RESP_SUCCESS 0x0000
+#define AXIOM_CDU_MAX_DATA_BYTES 48
+
+struct axiom_cdu_usage {
+ union {
+ __le16 command;
+ __le16 response;
+ };
+ __le16 parameters[3];
+ u8 data[AXIOM_CDU_MAX_DATA_BYTES];
+};
+
+/*
+ * u01 for the bootloader protocol (BLP)
+ *
+ * Values taken from Bootloader.py<http://Bootloader.py> [1] which had a c=
omment that documentation
+ * values are out dated. The BLP does not have different versions accordin=
g the
+ * documentation python helper.
+ *
+ * [1] https://github.com/TouchNetix/axiom_pylib<https://github.com/TouchN=
etix/axiom_pylib>
+ */
+#define AXIOM_U01_BLP_COMMAND_REG 0x0100
+#define AXIOM_U01_BLP_COMMAND_RESET BIT(1)
+#define AXIOM_U01_BLP_SATUS_REG 0x0100
+#define AXIOM_U01_BLP_STATUS_BUSY BIT(0)
+#define AXIOM_U01_BLP_FIFO_REG 0x0102
+#define AXIOM_U01_BLP_FIFO_CHK_SIZE_BYTES 255
+
+#define AXIOM_PROX_LEVEL -128
+#define AXIOM_STARTUP_TIME_MS 110
+
+#define AXIOM_USAGE_BASEADDR_MASK GENMASK(15, 8)
+#define AXIOM_MAX_USAGES 256 /* u00 - uFF */
+/*
+ * The devices have a 16bit ADC but Touchnetix used the lower two bits for=
 other
+ * information.
+ */
+#define AXIOM_MAX_XY (65535 - 3)
+#define AXIOM_DEFAULT_POLL_INTERVAL_MS 10
+#define AXIOM_PAGE_BYTE_LEN 256
+#define AXIOM_MAX_XFERLEN 0x7fff
+#define AXIOM_MAX_TOUCHSLOTS 10
+#define AXIOM_MAX_TOUCHSLOTS_MASK GENMASK(9, 0)
+
+/* aXiom firmware (.axfw) */
+#define AXIOM_FW_AXFW_SIGNATURE "AXFW"
+#define AXIOM_FW_AXFW_FILE_FMT_VER 0x0200
+
+struct axiom_fw_axfw_hdr {
+ u8 signature[4];
+ __le32 file_crc32;
+ __le16 file_format_ver;
+ __le16 device_id;
+ u8 variant;
+ u8 minor_ver;
+ u8 major_ver;
+ u8 rc_ver;
+ u8 status;
+ __le16 silicon_ver;
+ u8 silicon_rev;
+ __le32 fw_crc32;
+} __packed;
+
+struct axiom_fw_axfw_chunk_hdr {
+ u8 internal[6]; /* no description */
+ __be16 payload_length;
+};
+
+/* aXiom config (.th2cfgbin) */
+#define AXIOM_FW_CFG_SIGNATURE 0x20071969
+
+struct axiom_fw_cfg_hdr {
+ __be32 signature;
+ __le16 file_format_ver;
+ __le16 tcp_file_rev_major;
+ __le16 tcp_file_rev_minor;
+ __le16 tcp_file_rev_patch;
+ u8 tcp_version;
+} __packed;
+
+struct axiom_fw_cfg_chunk_hdr {
+ u8 usage_num;
+ u8 usage_rev;
+ u8 reserved;
+ __le16 usage_length;
+} __packed;
+
+struct axiom_fw_cfg_chunk {
+ u8 usage_num;
+ u8 usage_rev;
+ u16 usage_length;
+ const u8 *usage_content;
+};
+
+enum axiom_fw_type {
+ AXIOM_FW_AXFW,
+ AXIOM_FW_CFG,
+ AXIOM_FW_NUM
+};
+
+enum axiom_crc_type {
+ AXIOM_CRC_CUR,
+ AXIOM_CRC_NEW,
+ AXIOM_CRC_NUM
+};
+
+struct axiom_data;
+
+struct axiom_usage_info {
+ unsigned char usage_num; /* uXX number (XX in hex) */
+ unsigned int rev_num; /* rev.X (X in dec) */
+ bool is_cdu;
+ bool is_ro;
+
+ /* Optional hooks */
+ int (*process_report)(struct axiom_data *ts, const u8 *buf, size_t bufsiz=
e);
+};
+
+enum axiom_runmode {
+ AXIOM_DISCOVERY_MODE,
+ AXIOM_TCP_MODE,
+ AXIOM_TCP_CFG_UPDATE_MODE,
+ AXIOM_BLP_PRE_MODE,
+ AXIOM_BLP_MODE,
+};
+
+struct axiom_data {
+ struct input_dev *input;
+ struct device *dev;
+
+ struct gpio_desc *reset_gpio;
+ struct regulator_bulk_data supplies[2];
+ unsigned int num_supplies;
+
+ struct regmap *regmap;
+ struct touchscreen_properties prop;
+ bool irq_setup_done;
+ u32 poll_interval;
+
+ struct drm_panel_follower panel_follower;
+ bool is_panel_follower;
+
+ enum axiom_runmode mode;
+ /*
+ * Two completion types to support firmware updates
+ * in irq and poll mode.
+ */
+ struct axiom_completion {
+ struct completion completion;
+ bool poll_done;
+ } nvm_write, boot_complete;
+
+ /* Lock to protect both firmware interfaces */
+ struct mutex fwupdate_lock;
+ struct axiom_firmware {
+ /* Lock to protect cancel */
+ struct mutex lock;
+ bool cancel;
+ struct fw_upload *fwl;
+ } fw[AXIOM_FW_NUM];
+
+ unsigned int fw_major;
+ unsigned int fw_minor;
+ unsigned int fw_rc;
+ unsigned int fw_status;
+ unsigned int fw_variant;
+ u16 device_id;
+ u16 jedec_id;
+ u8 silicon_rev;
+
+ /* CRCs we need to check during a config update */
+ struct axiom_crc {
+ u32 runtime;
+ u32 vltusageconfig;
+ u32 nvltlusageconfig;
+ u32 u22_sequencedata;
+ u32 u43_hotspots;
+ u32 u77_dod_data;
+ u32 u93_profiles;
+ u32 u94_deltascalemap;
+ } crc[AXIOM_CRC_NUM];
+
+ bool cds_enabled;
+ unsigned long enabled_slots;
+ unsigned int num_slots;
+
+ unsigned int max_report_byte_len;
+ struct axiom_usage_table_entry {
+ bool populated;
+ unsigned int baseaddr;
+ unsigned int size_bytes;
+ const struct axiom_usage_info *info;
+ } usage_table[AXIOM_MAX_USAGES];
+};
+
+static int axiom_u01_rev1_process_report(struct axiom_data *ts, const u8 *=
buf,
+ size_t bufsize);
+static int axiom_u34_rev1_process_report(struct axiom_data *ts, const u8 *=
_buf,
+ size_t bufsize);
+static int axiom_u41_rev2_process_report(struct axiom_data *ts, const u8 *=
buf,
+ size_t bufsize);
+
+#define AXIOM_USAGE(num, rev) \
+ { \
+ .usage_num =3D num, \
+ .rev_num =3D rev, \
+ }
+
+#define AXIOM_RO_USAGE(num, rev) \
+ { \
+ .usage_num =3D num, \
+ .rev_num =3D rev, \
+ .is_ro =3D true, \
+ }
+
+#define AXIOM_CDU_USAGE(num, rev) \
+ { \
+ .usage_num =3D num, \
+ .rev_num =3D rev, \
+ .is_cdu =3D true, \
+ }
+
+#define AXIOM_REPORT_USAGE(num, rev, func) \
+ { \
+ .usage_num =3D num, \
+ .rev_num =3D rev, \
+ .process_report =3D func, \
+ }
+
+#define AXIOM_USAGE_REV_UNUSED (-1)
+
+/*
+ * All usages used by driver must be added to this list to ensure the corr=
ect
+ * communictation with the devices. The list can contain multiple entries =
of the
+ * same usage to handle different usage revisions.
+ *
+ * Note:
+ * During a th2cfgbin update the driver may use usages not listed here.
+ * Therefore the th2cfgbin update compares the current running FW again th=
e
+ * th2cfgbin targets FW.
+ */
+static const struct axiom_usage_info driver_required_usages[] =3D {
+ AXIOM_REPORT_USAGE(AXIOM_U01, 1, axiom_u01_rev1_process_report),
+ AXIOM_REPORT_USAGE(AXIOM_U01, 3, axiom_u01_rev1_process_report),
+ AXIOM_USAGE(AXIOM_U02, 1),
+ AXIOM_USAGE(AXIOM_U02, 2),
+ AXIOM_USAGE(AXIOM_U04, 1),
+ AXIOM_RO_USAGE(AXIOM_U33, 2),
+ AXIOM_RO_USAGE(AXIOM_U33, 3),
+ AXIOM_REPORT_USAGE(AXIOM_U34, 1, axiom_u34_rev1_process_report),
+ AXIOM_REPORT_USAGE(AXIOM_U41, 2, axiom_u41_rev2_process_report),
+ AXIOM_REPORT_USAGE(AXIOM_U41, 4, axiom_u41_rev2_process_report),
+ AXIOM_USAGE(AXIOM_U42, 1),
+ AXIOM_USAGE(AXIOM_U42, 4),
+ AXIOM_USAGE(AXIOM_U64, 2),
+ AXIOM_USAGE(AXIOM_U64, 4),
+ { /* sentinel */ }
+};
+
+/*
+ * All usages below are unused but the driver needs to know the type (ro, =
cdu)
+ * to handle them correctly. Unfortunately the type is not discoverable. O=
nce
+ * a usage is actually used, it must be shifted to driver_required_usages =
and
+ * the revision must be set accordingly.
+ */
+static const struct axiom_usage_info driver_additional_usages[] =3D {
+ AXIOM_CDU_USAGE(AXIOM_U05, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_CDU_USAGE(AXIOM_U22, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_RO_USAGE(AXIOM_U31, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_RO_USAGE(AXIOM_U32, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_RO_USAGE(AXIOM_U36, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_CDU_USAGE(AXIOM_U43, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_CDU_USAGE(AXIOM_U77, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_RO_USAGE(AXIOM_U82, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_CDU_USAGE(AXIOM_U93, AXIOM_USAGE_REV_UNUSED),
+ AXIOM_CDU_USAGE(AXIOM_U94, AXIOM_USAGE_REV_UNUSED),
+ { /* sentinel */ }
+};
+
+/************************ Common helpers *********************************=
*****/
+
+static void axiom_set_runmode(struct axiom_data *ts, enum axiom_runmode mo=
de)
+{
+ ts->mode =3D mode;
+}
+
+static enum axiom_runmode axiom_get_runmode(struct axiom_data *ts)
+{
+ return ts->mode;
+}
+
+static const char *axiom_runmode_to_string(struct axiom_data *ts)
+{
+ switch (ts->mode) {
+ case AXIOM_DISCOVERY_MODE: return "discovery";
+ case AXIOM_TCP_MODE: return "tcp";
+ case AXIOM_TCP_CFG_UPDATE_MODE: return "th2cfg-update";
+ case AXIOM_BLP_PRE_MODE: return "bootloader-pre";
+ case AXIOM_BLP_MODE: return "bootlaoder";
+ default: return "unknown";
+ }
+}
+
+static bool axiom_skip_usage_check(struct axiom_data *ts)
+{
+ switch (ts->mode) {
+ case AXIOM_TCP_CFG_UPDATE_MODE:
+ case AXIOM_DISCOVERY_MODE:
+ case AXIOM_BLP_MODE:
+ return true;
+ case AXIOM_BLP_PRE_MODE:
+ case AXIOM_TCP_MODE:
+ default:
+ return false;
+ }
+}
+
+static unsigned int
+axiom_usage_baseaddr(struct axiom_data *ts, unsigned char usage_num)
+{
+ return ts->usage_table[usage_num].baseaddr;
+}
+
+static unsigned int
+axiom_usage_size(struct axiom_data *ts, unsigned char usage_num)
+{
+ return ts->usage_table[usage_num].size_bytes;
+}
+
+static int
+axiom_usage_rev(struct axiom_data *ts, unsigned char usage_num)
+{
+ struct axiom_usage_table_entry *entry =3D &ts->usage_table[usage_num];
+
+ if (!entry->info)
+ return -EINVAL;
+
+ return entry->info->rev_num;
+}
+
+static bool
+axiom_driver_supports_usage(struct axiom_data *ts, unsigned char usage_num=
)
+{
+ const struct axiom_usage_info *iter =3D driver_required_usages;
+ struct device *dev =3D ts->dev;
+ int rev;
+
+ /*
+ * Some features depend on the current running firmware. Don't print an
+ * error if the usage for an optional feature is missing.
+ */
+ if (!ts->usage_table[usage_num].populated) {
+ dev_dbg(dev, "u%02X is not supported by the current firmware\n",
+ usage_num);
+ return false;
+ }
+
+ rev =3D axiom_usage_rev(ts, usage_num);
+ if (rev < 0) {
+ dev_warn(dev, "Driver doesn't support u%02X yet\n", usage_num);
+ return false;
+ }
+
+ for (; iter; iter++) {
+ if (iter->usage_num !=3D usage_num)
+ continue;
+
+ if (iter->rev_num =3D=3D rev)
+ return true;
+ }
+
+ dev_warn(dev, "Driver doesn't support u%02X rev.%d yet\n",
+ usage_num, rev);
+
+ return false;
+}
+
+static bool
+axiom_usage_entry_is_report(struct axiom_u31_usage_table_entry *entry)
+{
+ return entry->num_pages =3D=3D 0;
+}
+
+static unsigned int
+axiom_get_usage_size_bytes(struct axiom_u31_usage_table_entry *entry)
+{
+ unsigned char max_offset;
+
+ max_offset =3D FIELD_GET(AXIOM_U31_REV1_MAX_OFFSET_MASK,
+ entry->max_offset) + 1;
+ max_offset *=3D 2;
+
+ if (axiom_usage_entry_is_report(entry))
+ return max_offset;
+
+ if (FIELD_GET(AXIOM_U31_REV1_OFFSET_TYPE_MASK, entry->max_offset))
+ return (entry->num_pages - 1) * AXIOM_PAGE_BYTE_LEN + max_offset;
+
+ return max_offset;
+}
+
+static void axiom_dump_usage_entry(struct device *dev,
+ struct axiom_u31_usage_table_entry *entry)
+{
+ unsigned int page_len, total_len;
+
+ total_len =3D axiom_get_usage_size_bytes(entry);
+
+ if (total_len > AXIOM_PAGE_BYTE_LEN)
+ page_len =3D AXIOM_PAGE_BYTE_LEN;
+ else
+ page_len =3D total_len;
+
+ if (axiom_usage_entry_is_report(entry))
+ dev_dbg(dev,
+ "u%02X rev.%d total-len:%u [REPORT]\n",
+ entry->usage_num, entry->uifrevision, total_len);
+ else
+ dev_dbg(dev,
+ "u%02X rev.%d first-page:%#02x page-len:%u num-pages:%u total-len:%u\n",
+ entry->usage_num, entry->uifrevision, entry->start_page, page_len,
+ entry->num_pages, total_len);
+}
+
+static const struct axiom_usage_info *
+axiom_get_usage_info(struct axiom_u31_usage_table_entry *query)
+{
+ const struct axiom_usage_info *info =3D driver_required_usages;
+ bool required =3D false;
+ bool found =3D false;
+
+ for (; info->usage_num; info++) {
+ /* Skip all usages not used by the driver */
+ if (query->usage_num !=3D info->usage_num)
+ continue;
+
+ /* The usage is used so we need to mark it as required */
+ required =3D true;
+
+ /* Continue with the next usage if the revision doesn't match */
+ if (query->uifrevision !=3D info->rev_num)
+ continue;
+
+ found =3D true;
+ break;
+ }
+
+ if (found)
+ return info;
+
+ /* Return an error if not found but required */
+ if (required)
+ return ERR_PTR(-EINVAL);
+
+ info =3D driver_additional_usages;
+ for (; info->usage_num; info++) {
+ if (query->usage_num !=3D info->usage_num)
+ continue;
+
+ /*
+ * No need to check the revision since these usages are not
+ * used actually but the driver needs the type information.
+ */
+ return info;
+ }
+
+ /* No info found */
+ return NULL;
+}
+
+static bool axiom_usage_supported(struct axiom_data *ts, unsigned int base=
addr)
+{
+ struct axiom_usage_table_entry *entry;
+ unsigned int i;
+
+ if (axiom_skip_usage_check(ts))
+ return true;
+
+ dev_dbg(ts->dev, "Checking support for baseaddr: %#x\n", baseaddr);
+
+ for (i =3D 0; i < ARRAY_SIZE(ts->usage_table); i++) {
+ entry =3D &ts->usage_table[i];
+
+ if (!entry->populated)
+ continue;
+
+ if (entry->baseaddr !=3D baseaddr)
+ continue;
+
+ break;
+ }
+
+ if (i =3D=3D ARRAY_SIZE(ts->usage_table)) {
+ dev_warn(ts->dev, "Usage not found\n");
+ return false;
+ }
+
+ if (!entry->info)
+ dev_warn(ts->dev, "Unsupported usage u%02X used, driver bug!", i);
+
+ return !!entry->info;
+}
+
+static void axiom_poll(struct input_dev *input);
+
+static unsigned long
+axiom_wait_for_completion_timeout(struct axiom_data *ts, struct axiom_comp=
letion *x,
+ long timeout)
+{
+ struct i2c_client *client =3D to_i2c_client(ts->dev);
+ unsigned long poll_timeout;
+
+ if (client->irq)
+ return wait_for_completion_timeout(&x->completion, timeout);
+
+ /*
+ * Only firmware update cases do wait for completion. Since they require
+ * the input device to be closed, the poller is not running. So we need
+ * to do the polling manually.
+ */
+ poll_timeout =3D timeout / 10;
+
+ /*
+ * Very basic and not very accurate but it does the job because there
+ * are no known timeout constraints.
+ */
+ do {
+ axiom_poll(ts->input);
+ fsleep(jiffies_to_usecs(poll_timeout));
+ if (x->poll_done)
+ break;
+ timeout -=3D poll_timeout;
+ } while (timeout > 0);
+
+ x->poll_done =3D false;
+
+ return timeout > 0 ? timeout : 0;
+}
+
+static void axiom_complete(struct axiom_data *ts, struct axiom_completion =
*x)
+{
+ struct i2c_client *client =3D to_i2c_client(ts->dev);
+
+ if (client->irq)
+ complete(&x->completion);
+ else
+ x->poll_done =3D true;
+}
+
+/*************************** Usage handling ******************************=
*****/
+/*
+ * Wrapper functions to handle the usage access. Wrappers are used to add
+ * different revision handling later on more easily.
+ */
+static int axiom_u02_wait_idle(struct axiom_data *ts)
+{
+ unsigned int reg;
+ int ret, _ret;
+ u16 cmd;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U02))
+ return -EINVAL;
+
+ reg =3D axiom_usage_baseaddr(ts, AXIOM_U02);
+ reg +=3D AXIOM_U02_REV1_COMMAND_REG;
+
+ /*
+ * Missing regmap_raw_read_poll_timeout for now. RESP_SUCCESS means that
+ * the last command successfully completed and the device is idle.
+ */
+ ret =3D read_poll_timeout(regmap_raw_read, _ret,
+ _ret || cmd =3D=3D AXIOM_U02_REV1_RESP_SUCCESS,
+ 10 * USEC_PER_MSEC, 1 * USEC_PER_SEC, false,
+ ts->regmap, reg, &cmd, 2);
+ if (ret)
+ dev_err(ts->dev, "Poll u02 timedout with: %#x\n", cmd);
+
+ return ret;
+}
+
+static int
+axiom_u02_send_msg(struct axiom_data *ts,
+ const struct axiom_u02_rev1_system_manager_msg *msg,
+ bool validate_response)
+{
+ unsigned int reg;
+ int ret;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U02))
+ return -EINVAL;
+
+ reg =3D axiom_usage_baseaddr(ts, AXIOM_U02);
+ reg +=3D AXIOM_U02_REV1_COMMAND_REG;
+
+ ret =3D regmap_raw_write(ts->regmap, reg, msg, sizeof(*msg));
+ if (ret)
+ return ret;
+
+ if (!validate_response)
+ return 0;
+
+ return axiom_u02_wait_idle(ts);
+}
+
+static int
+axiom_u02_rev1_send_single_cmd(struct axiom_data *ts, u16 cmd)
+{
+ struct axiom_u02_rev1_system_manager_msg msg =3D {
+ .command =3D cpu_to_le16(cmd)
+ };
+
+ return axiom_u02_send_msg(ts, &msg, true);
+}
+
+static int axiom_u02_handshakenvm(struct axiom_data *ts)
+{
+ return axiom_u02_rev1_send_single_cmd(ts, AXIOM_U02_REV1_CMD_HANDSHAKENVM=
);
+}
+
+static int axiom_u02_computecrc(struct axiom_data *ts)
+{
+ return axiom_u02_rev1_send_single_cmd(ts, AXIOM_U02_REV1_CMD_COMPUTECRCS)=
;
+}
+
+static int axiom_u02_stop(struct axiom_data *ts)
+{
+ return axiom_u02_rev1_send_single_cmd(ts, AXIOM_U02_REV1_CMD_STOP);
+}
+
+static int axiom_u02_save_config(struct axiom_data *ts)
+{
+ struct axiom_u02_rev1_system_manager_msg msg;
+ int ret;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U02))
+ return -EINVAL;
+
+ msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_SAVEVLTLCFG2NVM);
+ msg.parameters[0] =3D 0; /* Don't care */
+ msg.parameters[1] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM1_SAVEVLTLCFG2NVM);
+ msg.parameters[2] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM2_SAVEVLTLCFG2NVM);
+
+ ret =3D axiom_u02_send_msg(ts, &msg, false);
+ if (ret)
+ return ret;
+
+ /* Downstream axcfg.py<http://axcfg.py> waits for 2sec without checking U=
01 response */
+ ret =3D axiom_wait_for_completion_timeout(ts, &ts->nvm_write,
+ msecs_to_jiffies(2 * MSEC_PER_SEC));
+ if (!ret)
+ dev_err(ts->dev, "Error save volatile config timedout\n");
+
+ return ret ? 0 : -ETIMEDOUT;
+}
+
+static int axiom_u02_swreset(struct axiom_data *ts)
+{
+ struct axiom_u02_rev1_system_manager_msg msg =3D { };
+ int ret;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U02))
+ return -EINVAL;
+
+ msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_SOFTRESET);
+ ret =3D axiom_u02_send_msg(ts, &msg, false);
+ if (ret)
+ return ret;
+
+ /*
+ * Downstream axcfg.py<http://axcfg.py> waits for 1sec without checking U0=
1 hello. Tests
+ * showed that waiting for the hello message isn't enough therefore we
+ * need both to make it robuster.
+ */
+ ret =3D axiom_wait_for_completion_timeout(ts, &ts->boot_complete,
+ msecs_to_jiffies(1 * MSEC_PER_SEC));
+ if (!ret)
+ dev_err(ts->dev, "Error swreset timedout\n");
+
+ fsleep(USEC_PER_SEC);
+
+ return ret ? 0 : -ETIMEDOUT;
+}
+
+static int axiom_u02_fillconfig(struct axiom_data *ts)
+{
+ struct axiom_u02_rev1_system_manager_msg msg;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U02))
+ return -EINVAL;
+
+ msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_FILLCONFIG);
+ msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_FILLCONFIG);
+ msg.parameters[1] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM1_FILLCONFIG);
+ msg.parameters[2] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM2_FILLCONFIG_ZERO);
+
+ return axiom_u02_send_msg(ts, &msg, true);
+}
+
+static int axiom_u02_enter_bootloader(struct axiom_data *ts)
+{
+ struct axiom_u02_rev1_system_manager_msg msg =3D { };
+ struct device *dev =3D ts->dev;
+ unsigned int val;
+ int ret;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U02))
+ return -EINVAL;
+
+ /*
+ * Enter the bootloader mode requires 3 consecutive messages so we can't
+ * check for the response.
+ */
+ msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_ENTERBOOTLOADER);
+ msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KE=
Y1);
+ ret =3D axiom_u02_send_msg(ts, &msg, false);
+ if (ret) {
+ dev_err(dev, "Failed to send bootloader-key1: %d\n", ret);
+ return ret;
+ }
+
+ msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KE=
Y2);
+ ret =3D axiom_u02_send_msg(ts, &msg, false);
+ if (ret) {
+ dev_err(dev, "Failed to send bootloader-key2: %d\n", ret);
+ return ret;
+ }
+
+ msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KE=
Y3);
+ ret =3D axiom_u02_send_msg(ts, &msg, false);
+ if (ret) {
+ dev_err(dev, "Failed to send bootloader-key3: %d\n", ret);
+ return ret;
+ }
+
+ /* Sleep before the first read to give the device time */
+ fsleep(250 * USEC_PER_MSEC);
+
+ /* Wait till the device reports it is in bootloader mode */
+ return regmap_read_poll_timeout(ts->regmap,
+ AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, val,
+ FIELD_GET(AXIOM_U31_REV1_MODE_MASK, val) =3D=3D
+ AXIOM_U31_REV1_MODE_BLP, 250 * USEC_PER_MSEC,
+ USEC_PER_SEC);
+}
+
+static int axiom_u04_get(struct axiom_data *ts, u8 **_buf)
+{
+ u8 buf[AXIOM_U04_REV1_SIZE_BYTES];
+ unsigned int reg;
+ int ret;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U04))
+ return -EINVAL;
+
+ reg =3D axiom_usage_baseaddr(ts, AXIOM_U04);
+ ret =3D regmap_raw_read(ts->regmap, reg, buf, sizeof(buf));
+ if (ret)
+ return ret;
+
+ *_buf =3D kmemdup(buf, sizeof(buf), GFP_KERNEL);
+
+ return sizeof(buf);
+}
+
+static int axiom_u04_set(struct axiom_data *ts, u8 *buf, unsigned int bufs=
ize)
+{
+ unsigned int reg;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U04))
+ return -EINVAL;
+
+ reg =3D axiom_usage_baseaddr(ts, AXIOM_U04);
+ return regmap_raw_write(ts->regmap, reg, buf, bufsize);
+}
+
+/*
+ * U31 revision must be always rev.1 else the whole self discovery mechani=
sm
+ * fall apart.
+ */
+static int axiom_u31_parse_device_info(struct axiom_data *ts)
+{
+ struct regmap *regmap =3D ts->regmap;
+ unsigned int id_low, id_high, val;
+ int ret;
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, &id_high);
+ if (ret)
+ return ret;
+ id_high =3D FIELD_GET(AXIOM_U31_REV1_DEVICE_ID_HIGH_MASK, id_high);
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_DEVICE_ID_LOW_REG, &id_low);
+ if (ret)
+ return ret;
+ ts->device_id =3D id_high << 8 | id_low;
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_RUNTIME_FW_MAJ_REG, &val);
+ if (ret)
+ return ret;
+ ts->fw_major =3D val;
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_RUNTIME_FW_MIN_REG, &val);
+ if (ret)
+ return ret;
+ ts->fw_minor =3D val;
+
+ /* All other fields are not allowed to be read in BLP mode */
+ if (axiom_get_runmode(ts) =3D=3D AXIOM_BLP_MODE)
+ return 0;
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_RUNTIME_FW_RC_REG, &val);
+ if (ret)
+ return ret;
+ ts->fw_rc =3D FIELD_GET(AXIOM_U31_REV1_RUNTIME_FW_RC_MASK, val);
+ ts->silicon_rev =3D FIELD_GET(AXIOM_U31_REV1_SILICON_REV_MASK, val);
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_RUNTIME_FW_STATUS_REG, &val);
+ if (ret)
+ return ret;
+ ts->fw_status =3D FIELD_GET(AXIOM_U31_REV1_RUNTIME_FW_STATUS, val);
+ ts->fw_variant =3D FIELD_GET(AXIOM_U31_REV1_RUNTIME_FW_VARIANT, val);
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_JEDEC_ID_HIGH_REG, &val);
+ if (ret)
+ return ret;
+ ts->jedec_id =3D val << 8;
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_JEDEC_ID_LOW_REG, &val);
+ if (ret)
+ return ret;
+ ts->jedec_id |=3D val;
+
+ return 0;
+}
+
+static int axiom_u33_read(struct axiom_data *ts, struct axiom_crc *crc);
+
+static int axiom_u31_device_discover(struct axiom_data *ts)
+{
+ struct axiom_u31_usage_table_entry *u31_usage_table __free(kfree) =3D NUL=
L;
+ struct axiom_u31_usage_table_entry *entry;
+ struct regmap *regmap =3D ts->regmap;
+ unsigned int mode, num_usages;
+ struct device *dev =3D ts->dev;
+ unsigned int i;
+ int ret;
+
+ axiom_set_runmode(ts, AXIOM_DISCOVERY_MODE);
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, &mode);
+ if (ret) {
+ dev_err(dev, "Failed to read MODE\n");
+ return ret;
+ }
+
+ /* Abort if the device is in bootloader protocol mode */
+ mode =3D FIELD_GET(AXIOM_U31_REV1_MODE_MASK, mode);
+ if (mode =3D=3D AXIOM_U31_REV1_MODE_BLP)
+ axiom_set_runmode(ts, AXIOM_BLP_MODE);
+
+ /* Since we are not in bootloader mode we can parse the device info */
+ ret =3D axiom_u31_parse_device_info(ts);
+ if (ret) {
+ dev_err(dev, "Failed to parse device info\n");
+ return ret;
+ }
+
+ /* All other fields are not allowed to be read in BLP mode */
+ if (axiom_get_runmode(ts) =3D=3D AXIOM_BLP_MODE) {
+ dev_info(dev, "Device in Bootloader mode, firmware upload required\n");
+ return -EACCES;
+ }
+
+ ret =3D regmap_read(regmap, AXIOM_U31_REV1_NUM_USAGES_REG, &num_usages);
+ if (ret) {
+ dev_err(dev, "Failed to read NUM_USAGES\n");
+ return ret;
+ }
+
+ u31_usage_table =3D kcalloc(num_usages, sizeof(*u31_usage_table),
+ GFP_KERNEL);
+ if (!u31_usage_table)
+ return -ENOMEM;
+
+ ret =3D regmap_raw_read(regmap, AXIOM_U31_REV1_PAGE1, u31_usage_table,
+ array_size(num_usages, sizeof(*u31_usage_table)));
+ if (ret) {
+ dev_err(dev, "Failed to read NUM_USAGES\n");
+ return ret;
+ }
+
+ /*
+ * axiom_u31_device_discover() is call after fw update too, so ensure
+ * that the usage_table is cleared.
+ */
+ memset(ts->usage_table, 0, sizeof(ts->usage_table));
+
+ for (i =3D 0, entry =3D u31_usage_table; i < num_usages; i++, entry++) {
+ unsigned char idx =3D entry->usage_num;
+ const struct axiom_usage_info *info;
+ unsigned int size_bytes;
+
+ axiom_dump_usage_entry(dev, entry);
+
+ /*
+ * Verify that the driver used usages are supported. Don't abort
+ * yet if a usage isn't supported to allow the user to dump the
+ * actual usage table.
+ */
+ info =3D axiom_get_usage_info(entry);
+ if (IS_ERR(info)) {
+ dev_info(dev, "Required usage u%02X isn't supported for rev.%u\n",
+ entry->usage_num, entry->uifrevision);
+ ret =3D -EACCES;
+ }
+
+ size_bytes =3D axiom_get_usage_size_bytes(entry);
+
+ ts->usage_table[idx].baseaddr =3D entry->start_page << 8;
+ ts->usage_table[idx].size_bytes =3D size_bytes;
+ ts->usage_table[idx].populated =3D true;
+ ts->usage_table[idx].info =3D info;
+
+ if (axiom_usage_entry_is_report(entry) &&
+ ts->max_report_byte_len < size_bytes)
+ ts->max_report_byte_len =3D size_bytes;
+ }
+
+ if (ret)
+ return ret;
+
+ /* From now on we are in TCP mode to include usage revision checks */
+ axiom_set_runmode(ts, AXIOM_TCP_MODE);
+
+ return axiom_u33_read(ts, &ts->crc[AXIOM_CRC_CUR]);
+}
+
+static int axiom_u33_read(struct axiom_data *ts, struct axiom_crc *crc)
+{
+ struct device *dev =3D ts->dev;
+ unsigned int reg;
+ int ret;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U33))
+ return -EINVAL;
+
+ if (axiom_usage_rev(ts, AXIOM_U33) =3D=3D 2) {
+ struct axiom_u33_rev2 val;
+
+ reg =3D axiom_usage_baseaddr(ts, AXIOM_U33);
+ ret =3D regmap_raw_read(ts->regmap, reg, &val, sizeof(val));
+ if (ret) {
+ dev_err(dev, "Failed to read u33\n");
+ return ret;
+ }
+
+ crc->runtime =3D le32_to_cpu(val.runtime_crc);
+ crc->vltusageconfig =3D le32_to_cpu(val.vltusageconfig_crc);
+ crc->nvltlusageconfig =3D le32_to_cpu(val.nvltlusageconfig_crc);
+ crc->u22_sequencedata =3D le32_to_cpu(val.u22_sequencedata_crc);
+ crc->u43_hotspots =3D le32_to_cpu(val.u43_hotspots_crc);
+ crc->u93_profiles =3D le32_to_cpu(val.u93_profiles_crc);
+ crc->u94_deltascalemap =3D le32_to_cpu(val.u94_deltascalemap_crc);
+ } else if (axiom_usage_rev(ts, AXIOM_U33) =3D=3D 3) {
+ struct axiom_u33_rev3 val;
+
+ reg =3D axiom_usage_baseaddr(ts, AXIOM_U33);
+ ret =3D regmap_raw_read(ts->regmap, reg, &val, sizeof(val));
+ if (ret) {
+ dev_err(dev, "Failed to read u33\n");
+ return ret;
+ }
+
+ crc->runtime =3D le32_to_cpu(val.runtime_crc);
+ crc->vltusageconfig =3D le32_to_cpu(val.vltusageconfig_crc);
+ crc->nvltlusageconfig =3D le32_to_cpu(val.nvltlusageconfig_crc);
+ crc->u22_sequencedata =3D le32_to_cpu(val.u22_sequencedata_crc);
+ crc->u43_hotspots =3D le32_to_cpu(val.u43_hotspots_crc);
+ crc->u77_dod_data =3D le32_to_cpu(val.u77_dod_data_crc);
+ crc->u93_profiles =3D le32_to_cpu(val.u93_profiles_crc);
+ crc->u94_deltascalemap =3D le32_to_cpu(val.u94_deltascalemap_crc);
+ }
+
+ return 0;
+}
+
+static bool axiom_u42_touch_enabled(struct axiom_data *ts, const u8 *buf,
+ unsigned int touch_num)
+{
+ switch (axiom_usage_rev(ts, AXIOM_U42)) {
+ case 1:
+ return buf[AXIOM_U42_REV1_REPORT_ID_CONTAINS(touch_num)] =3D=3D
+ AXIOM_U42_REV1_REPORT_ID_TOUCH;
+ case 4:
+ return buf[AXIOM_U42_REV4_REPORT_ID_CONTAINS(touch_num)] =3D=3D
+ AXIOM_U42_REV4_REPORT_ID_TOUCH;
+ default:
+ /* Should never happen */
+ return false;
+ }
+}
+
+static void axiom_u42_get_touchslots(struct axiom_data *ts)
+{
+ u8 *buf __free(kfree) =3D NULL;
+ struct device *dev =3D ts->dev;
+ unsigned int bufsize;
+ unsigned int reg;
+ int ret, i;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U42)) {
+ dev_warn(dev, "Use default touchslots num\n");
+ goto fallback;
+ }
+
+ bufsize =3D axiom_usage_size(ts, AXIOM_U42);
+ buf =3D kzalloc(bufsize, GFP_KERNEL);
+ if (!buf) {
+ dev_warn(dev, "Failed to alloc u42 read buffer, use default value\n");
+ goto fallback;
+ }
+
+ reg =3D axiom_usage_baseaddr(ts, AXIOM_U42);
+ ret =3D regmap_raw_read(ts->regmap, reg, buf, bufsize);
+ if (ret) {
+ dev_warn(dev, "Failed to read u42, use default value\n");
+ goto fallback;
+ }
+
+ ts->enabled_slots =3D 0;
+ ts->num_slots =3D 0;
+
+ for (i =3D 0; i < AXIOM_MAX_TOUCHSLOTS; i++) {
+ if (axiom_u42_touch_enabled(ts, buf, i)) {
+ ts->enabled_slots |=3D BIT(i);
+ ts->num_slots++;
+ }
+ }
+
+ return;
+
+fallback:
+ ts->enabled_slots =3D AXIOM_MAX_TOUCHSLOTS_MASK;
+ ts->num_slots =3D AXIOM_MAX_TOUCHSLOTS;
+}
+
+static void axiom_u64_cds_enabled(struct axiom_data *ts)
+{
+ unsigned int reg, val;
+ int ret;
+
+ if (!axiom_driver_supports_usage(ts, AXIOM_U64))
+ goto fallback_out;
+
+ reg =3D axiom_usage_baseaddr(ts, AXIOM_U64);
+ reg +=3D AXIOM_U64_REV2_ENABLECDSPROCESSING_REG;
+
+ ret =3D regmap_read(ts->regmap, reg, &val);
+ if (ret)
+ goto fallback_out;
+
+ val =3D FIELD_GET(AXIOM_U64_REV2_ENABLECDSPROCESSING_MASK, val);
+ ts->cds_enabled =3D val ? true : false;
+
+ return;
+
+fallback_out:
+ ts->cds_enabled =3D false;
+}
+
+static int axiom_cdu_wait_idle(struct axiom_data *ts, u8 cdu_usage_num)
+{
+ unsigned int reg;
+ int ret, _ret;
+ u16 cmd;
+
+ reg =3D axiom_usage_baseaddr(ts, cdu_usage_num);
+
+ /*
+ * Missing regmap_raw_read_poll_timeout for now. RESP_SUCCESS means that
+ * the last command successfully completed and the device is idle.
+ */
+ ret =3D read_poll_timeout(regmap_raw_read, _ret,
+ _ret || cmd =3D=3D AXIOM_CDU_RESP_SUCCESS,
+ 10 * USEC_PER_MSEC, 1 * USEC_PER_SEC, false,
+ ts->regmap, reg, &cmd, 2);
+ if (ret)
+ dev_err(ts->dev, "Poll CDU u%02X timedout with: %#x\n",
+ cdu_usage_num, cmd);
+
+ return ret;
+}
+
+/*********************** Report usage handling ***************************=
*****/
+
+static int axiom_process_report(struct axiom_data *ts, unsigned char usage=
_num,
+ const u8 *buf, size_t buflen)
+{
+ struct axiom_usage_table_entry *entry =3D &ts->usage_table[usage_num];
+
+ /* Skip processing if not in TCP mode */
+ if ((axiom_get_runmode(ts) !=3D AXIOM_TCP_MODE) &&
+ (axiom_get_runmode(ts) !=3D AXIOM_TCP_CFG_UPDATE_MODE))
+ return 0;
+
+ /* May happen if an unsupported usage was requested */
+ if (!entry) {
+ dev_info(ts->dev, "Unsupported usage U%x request\n", usage_num);
+ return 0;
+ }
+
+ /* Supported report usages need to have a process_report hook */
+ if (!entry->info || !entry->info->process_report)
+ return -EINVAL;
+
+ return entry->info->process_report(ts, buf, buflen);
+}
+
+/* Make use of datasheet method 1 - single transfer read */
+static int
+axiom_u34_rev1_process_report(struct axiom_data *ts, const u8 *_buf, size_=
t bufsize)
+{
+ unsigned int reg =3D axiom_usage_baseaddr(ts, AXIOM_U34);
+ struct regmap *regmap =3D ts->regmap;
+ u8 buf[AXIOM_PAGE_BYTE_LEN] =3D { };
+ struct device *dev =3D ts->dev;
+ unsigned char report_usage;
+ u16 crc_report, crc_calc;
+ unsigned int len;
+ u8 *payload;
+ int ret;
+
+ ret =3D regmap_raw_read(regmap, reg, buf, ts->max_report_byte_len);
+ if (ret)
+ return ret;
+
+ /* TODO: Add overflow statistics */
+
+ /* REPORTLENGTH is in uint16 */
+ len =3D FIELD_GET(AXIOM_U34_REV1_REPORTLENGTH_MASK, buf[0]);
+ len *=3D 2;
+
+ /*
+ * Downstream ignores zero length reports, extend the check to validate
+ * the upper bound too.
+ */
+ if (len =3D=3D 0 || len > AXIOM_PAGE_BYTE_LEN) {
+ dev_dbg_ratelimited(dev, "Invalid report length: %u\n", len);
+ return -EINVAL;
+ }
+
+ /*
+ * The CRC16 value can be queried at the last two bytes of the report.
+ * The value itself is covering the complete report excluding the CRC16
+ * value at the end.
+ */
+ crc_report =3D get_unaligned_le16(&buf[len - 2]);
+ crc_calc =3D crc16(0, buf, (len - 2));
+
+ if (crc_calc !=3D crc_report) {
+ dev_err_ratelimited(dev, "CRC16 mismatch!\n");
+ return -EINVAL;
+ }
+
+ report_usage =3D buf[1];
+ payload =3D &buf[AXIOM_U34_REV1_PREAMBLE_BYTES];
+ len -=3D AXIOM_U34_REV1_PREAMBLE_BYTES - AXIOM_U34_REV1_POSTAMBLE_BYTES;
+
+ switch (report_usage) {
+ case AXIOM_U01:
+ case AXIOM_U41:
+ return axiom_process_report(ts, report_usage, payload, len);
+ default:
+ dev_dbg(dev, "Unsupported report u%02X received\n",
+ report_usage);
+ }
+
+ return 0;
+}
+
+static void
+axiom_u41_rev2_decode_target(const u8 *buf, u8 id, u16 *x, u16 *y, s8 *z)
+{
+ u16 val;
+
+ val =3D get_unaligned_le16(&buf[AXIOM_U41_REV2_X_REG(id)]);
+ val &=3D AXIOM_MAX_XY;
+ *x =3D val;
+
+ val =3D get_unaligned_le16(&buf[AXIOM_U41_REV2_Y_REG(id)]);
+ val &=3D AXIOM_MAX_XY;
+ *y =3D val;
+
+ *z =3D buf[AXIOM_U41_REV2_Z_REG(id)];
+}
+
+static int
+axiom_u41_rev2_process_report(struct axiom_data *ts, const u8 *buf, size_t=
 bufsize)
+{
+ struct input_dev *input =3D ts->input;
+ unsigned char id;
+ u16 targets;
+
+ /*
+ * The input registration can be postponed but the touchscreen FW is
+ * sending u41 reports regardless.
+ */
+ if (!input)
+ return 0;
+
+ targets =3D get_unaligned_le16(&buf[AXIOM_U41_REV2_TARGETSTATUS_REG]);
+
+ for_each_set_bit(id, &ts->enabled_slots, AXIOM_MAX_TOUCHSLOTS) {
+ bool present;
+ u16 x, y;
+ s8 z;
+
+ axiom_u41_rev2_decode_target(buf, id, &x, &y, &z);
+
+ present =3D targets & BIT(id);
+ /* Ignore possible jitters */
+ if (z =3D=3D AXIOM_PROX_LEVEL)
+ present =3D false;
+
+ dev_dbg(ts->dev, "id:%u x:%u y:%u z:%d present:%u",
+ id, x, y, z, present);
+
+ input_mt_slot(input, id);
+ if (input_mt_report_slot_state(input, MT_TOOL_FINGER, present))
+ touchscreen_report_pos(input, &ts->prop, x, y, true);
+
+ if (!present)
+ continue;
+
+ input_report_abs(input, ABS_MT_DISTANCE, z < 0 ? -z : 0);
+ if (ts->cds_enabled)
+ input_report_abs(input, ABS_MT_PRESSURE, z >=3D 0 ? z : 0);
+ }
+
+ input_sync(input);
+
+ return 0;
+}
+
+static int
+axiom_u01_rev1_process_report(struct axiom_data *ts, const u8 *buf, size_t=
 bufsize)
+{
+ switch (buf[AXIOM_U01_REV1_REPORTTYPE_REG]) {
+ case AXIOM_U01_REV1_REPORTTYPE_HELLO:
+ dev_dbg(ts->dev, "u01 HELLO received\n");
+ axiom_complete(ts, &ts->boot_complete);
+ return 0;
+ case AXIOM_U01_REV1_REPORTTYPE_HEARTBEAT:
+ dev_dbg_ratelimited(ts->dev, "u01 HEARTBEAT received\n");
+ return 0;
+ case AXIOM_U01_REV1_REPORTTYPE_OPCOMPLETE:
+ dev_dbg(ts->dev, "u01 OPCOMPLETE received\n");
+ axiom_u02_handshakenvm(ts);
+ axiom_complete(ts, &ts->nvm_write);
+ return 0;
+ default:
+ return -EINVAL;
+ }
+}
+
+/**************************** Regmap handling ****************************=
*****/
+
+#define AXIOM_CMD_HDR_DIR_MASK BIT(15)
+#define AXIOM_CMD_HDR_READ 1
+#define AXIOM_CMD_HDR_WRITE 0
+#define AXIOM_CMD_HDR_LEN_MASK GENMASK(14, 0)
+
+struct axiom_cmd_header {
+ __le16 target_address;
+ __le16 xferlen;
+};
+
+/* Custom regmap read/write handling is required due to the aXiom protocol=
 */
+static int axiom_regmap_read(void *context, const void *reg_buf, size_t re=
g_size,
+ void *val_buf, size_t val_size)
+{
+ struct device *dev =3D context;
+ struct i2c_client *i2c =3D to_i2c_client(dev);
+ struct axiom_data *ts =3D i2c_get_clientdata(i2c);
+ struct axiom_cmd_header hdr;
+ u16 xferlen, addr, baseaddr;
+ struct i2c_msg xfer[2];
+ int ret;
+
+ if (val_size > AXIOM_MAX_XFERLEN) {
+ dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
+ val_size, AXIOM_MAX_XFERLEN);
+ return -EINVAL;
+ }
+
+ addr =3D *((u16 *)reg_buf);
+ hdr.target_address =3D cpu_to_le16(addr);
+ xferlen =3D FIELD_PREP(AXIOM_CMD_HDR_DIR_MASK, AXIOM_CMD_HDR_READ) |
+ FIELD_PREP(AXIOM_CMD_HDR_LEN_MASK, val_size);
+ hdr.xferlen =3D cpu_to_le16(xferlen);
+
+ /* Verify that usage including the usage rev is supported */
+ baseaddr =3D addr & AXIOM_USAGE_BASEADDR_MASK;
+ if (!axiom_usage_supported(ts, baseaddr))
+ return -EINVAL;
+
+ xfer[0].addr =3D i2c->addr;
+ xfer[0].flags =3D 0;
+ xfer[0].len =3D sizeof(hdr);
+ xfer[0].buf =3D (u8 *)&hdr;
+
+ xfer[1].addr =3D i2c->addr;
+ xfer[1].flags =3D I2C_M_RD;
+ xfer[1].len =3D val_size;
+ xfer[1].buf =3D val_buf;
+
+ ret =3D i2c_transfer(i2c->adapter, xfer, 2);
+ if (ret =3D=3D 2)
+ return 0;
+ else if (ret < 0)
+ return ret;
+ else
+ return -EIO;
+}
+
+static int axiom_regmap_write(void *context, const void *data, size_t coun=
t)
+{
+ struct device *dev =3D context;
+ struct i2c_client *i2c =3D to_i2c_client(dev);
+ struct axiom_data *ts =3D i2c_get_clientdata(i2c);
+ char *buf __free(kfree) =3D NULL;
+ struct axiom_cmd_header hdr;
+ u16 xferlen, addr, baseaddr;
+ size_t val_size, msg_size;
+ int ret;
+
+ val_size =3D count - sizeof(addr);
+ if (val_size > AXIOM_MAX_XFERLEN) {
+ dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
+ val_size, AXIOM_MAX_XFERLEN);
+ return -EINVAL;
+ }
+
+ addr =3D *((u16 *)data);
+ hdr.target_address =3D cpu_to_le16(addr);
+ xferlen =3D FIELD_PREP(AXIOM_CMD_HDR_DIR_MASK, AXIOM_CMD_HDR_WRITE) |
+ FIELD_PREP(AXIOM_CMD_HDR_LEN_MASK, val_size);
+ hdr.xferlen =3D cpu_to_le16(xferlen);
+
+ /* Verify that usage including the usage rev is supported */
+ baseaddr =3D addr & AXIOM_USAGE_BASEADDR_MASK;
+ if (!axiom_usage_supported(ts, baseaddr))
+ return -EINVAL;
+
+ msg_size =3D sizeof(hdr) + val_size;
+ buf =3D kzalloc(msg_size, GFP_KERNEL);
+ if (!buf)
+ return -ENOMEM;
+
+ memcpy(buf, &hdr, sizeof(hdr));
+ memcpy(&buf[sizeof(hdr)], &((char *)data)[2], val_size);
+
+ ret =3D i2c_master_send(i2c, buf, msg_size);
+
+ return ret =3D=3D msg_size ? 0 : ret;
+}
+
+static const struct regmap_config axiom_i2c_regmap_config =3D {
+ .reg_bits =3D 16,
+ .val_bits =3D 8,
+ .read =3D axiom_regmap_read,
+ .write =3D axiom_regmap_write,
+};
+
+/************************ FW update handling *****************************=
*****/
+
+static int axiom_update_input_dev(struct axiom_data *ts);
+
+static enum fw_upload_err
+axiom_axfw_fw_prepare(struct fw_upload *fw_upload, const u8 *data, u32 siz=
e)
+{
+ struct axiom_data *ts =3D fw_upload->dd_handle;
+ struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
+ u8 major_ver, minor_ver, rc_ver, status, variant;
+ u32 fw_file_crc32, crc32_calc;
+ struct device *dev =3D ts->dev;
+ unsigned int signature_len;
+ enum fw_upload_err ret;
+ u16 fw_file_format_ver;
+ u16 fw_file_device_id;
+
+ mutex_lock(&afw->lock);
+ afw->cancel =3D false;
+ mutex_unlock(&afw->lock);
+
+ mutex_lock(&ts->fwupdate_lock);
+
+ if (size < sizeof(struct axiom_fw_axfw_hdr)) {
+ dev_err(dev, "Invalid AXFW file size\n");
+ ret =3D FW_UPLOAD_ERR_INVALID_SIZE;
+ goto out;
+ }
+
+ signature_len =3D strlen(AXIOM_FW_AXFW_SIGNATURE);
+ if (strncmp(data, AXIOM_FW_AXFW_SIGNATURE, signature_len)) {
+ /*
+ * AXFW has a header which can be used to perform validations,
+ * ALC don't. Therefore the AXFW format is preferred.
+ */
+ dev_warn(dev, "No AXFW signature, assume ALC firmware\n");
+ ret =3D FW_UPLOAD_ERR_NONE;
+ goto out;
+ }
+
+ fw_file_crc32 =3D get_unaligned_le32(&data[signature_len]);
+ crc32_calc =3D crc32(~0, &data[8], size - 8) ^ 0xffffffff;
+ if (fw_file_crc32 !=3D crc32_calc) {
+ dev_err(dev, "AXFW CRC32 doesn't match (fw:%#x calc:%#x)\n",
+ fw_file_crc32, crc32_calc);
+ ret =3D FW_UPLOAD_ERR_FW_INVALID;
+ goto out;
+ }
+
+ data +=3D signature_len + sizeof(fw_file_crc32);
+ fw_file_format_ver =3D get_unaligned_le16(data);
+ if (fw_file_format_ver !=3D AXIOM_FW_AXFW_FILE_FMT_VER) {
+ dev_err(dev, "Invalid AXFW file format version: %04x",
+ fw_file_format_ver);
+ ret =3D FW_UPLOAD_ERR_FW_INVALID;
+ goto out;
+ }
+
+ data +=3D sizeof(fw_file_format_ver);
+ fw_file_device_id =3D get_unaligned_le16(data);
+ if (fw_file_device_id !=3D ts->device_id) {
+ dev_err(dev, "Invalid AXFW target device (fw:%#04x dev:%#04x)\n",
+ fw_file_device_id, ts->device_id);
+ ret =3D FW_UPLOAD_ERR_FW_INVALID;
+ goto out;
+ }
+
+ /*
+ * This can happen if:
+ * * the device came up in bootloader mode, or
+ * * downloading the firmware failed in between, or
+ * * the following usage discovery failed.
+ *
+ * All cases are crcitical and we need to use any firmware to
+ * bring the device back into a working state which is supported by the
+ * host.
+ */
+ if (axiom_get_runmode(ts) !=3D AXIOM_TCP_MODE)
+ return FW_UPLOAD_ERR_NONE;
+
+ data +=3D sizeof(fw_file_device_id);
+ variant =3D *data++;
+ minor_ver =3D *data++;
+ major_ver =3D *data++;
+ rc_ver =3D *data++;
+ status =3D *data++;
+
+ if (major_ver =3D=3D ts->fw_major && minor_ver =3D=3D ts->fw_minor &&
+ rc_ver =3D=3D ts->fw_rc && status =3D=3D ts->fw_status &&
+ variant =3D=3D ts->fw_variant) {
+ ret =3D FW_UPLOAD_ERR_DUPLICATE;
+ goto out;
+ }
+
+ dev_info(dev, "Detected AXFW %02u.%02u.%02u (%s)\n",
+ major_ver, minor_ver, rc_ver,
+ status ? "production" : "engineering");
+
+ mutex_lock(&afw->lock);
+ ret =3D afw->cancel ? FW_UPLOAD_ERR_CANCELED : FW_UPLOAD_ERR_NONE;
+ mutex_unlock(&afw->lock);
+
+out:
+ /*
+ * In FW_UPLOAD_ERR_NONE case the complete handler will release the
+ * lock.
+ */
+ if (ret !=3D FW_UPLOAD_ERR_NONE)
+ mutex_unlock(&ts->fwupdate_lock);
+
+ return ret;
+}
+
+static int axiom_enter_bootloader_mode(struct axiom_data *ts)
+{
+ struct device *dev =3D ts->dev;
+ int ret;
+
+ axiom_set_runmode(ts, AXIOM_BLP_PRE_MODE);
+
+ ret =3D axiom_u02_wait_idle(ts);
+ if (ret)
+ goto err_out;
+
+ ret =3D axiom_u02_enter_bootloader(ts);
+ if (ret) {
+ dev_err(dev, "Failed to enter bootloader mode\n");
+ goto err_out;
+ }
+
+ axiom_set_runmode(ts, AXIOM_BLP_MODE);
+
+ return 0;
+
+err_out:
+ axiom_set_runmode(ts, AXIOM_TCP_MODE);
+
+ return ret;
+}
+
+static int axoim_blp_wait_ready(struct axiom_data *ts)
+{
+ struct device *dev =3D ts->dev;
+ unsigned int reg;
+ int tmp, ret;
+ u8 buf[4];
+
+ reg =3D AXIOM_U01_BLP_SATUS_REG;
+
+ /* BLP busy poll requires to read 4 bytes! */
+ ret =3D read_poll_timeout(regmap_raw_read, tmp,
+ tmp || !(buf[2] & AXIOM_U01_BLP_STATUS_BUSY),
+ 10 * USEC_PER_MSEC, 5 * USEC_PER_SEC, false,
+ ts->regmap, reg, &buf, 4);
+ if (ret)
+ dev_err(dev, "Bootloader wait processing packets failed %d\n", ret);
+
+ return ret;
+}
+
+static int
+axiom_blp_write_chunk(struct axiom_data *ts, const u8 *data, u16 length)
+{
+ unsigned int chunk_size =3D AXIOM_U01_BLP_FIFO_CHK_SIZE_BYTES;
+ unsigned int reg =3D AXIOM_U01_BLP_FIFO_REG;
+ struct device *dev =3D ts->dev;
+ unsigned int pos =3D 0;
+ int ret;
+
+ ret =3D axoim_blp_wait_ready(ts);
+ if (ret)
+ return ret;
+
+ /*
+ * TODO: Downstream does this chunk transfers. Verify if this is
+ * required if one fw-chunk <=3D AXIOM_MAX_XFERLEN
+ */
+ while (pos < length) {
+ u16 len;
+
+ len =3D chunk_size;
+ if ((pos + chunk_size) > length)
+ len =3D length - pos;
+
+ ret =3D regmap_raw_write(ts->regmap, reg, &data[pos], len);
+ if (ret) {
+ dev_err(dev, "Bootloader download AXFW chunk failed %d\n", ret);
+ return ret;
+ }
+
+ pos +=3D len;
+ ret =3D axoim_blp_wait_ready(ts);
+ if (ret)
+ return ret;
+ }
+
+ return 0;
+}
+
+static int axiom_blp_reset(struct axiom_data *ts)
+{
+ __le16 reset_cmd =3D cpu_to_le16(AXIOM_U01_BLP_COMMAND_RESET);
+ unsigned int reg =3D AXIOM_U01_BLP_COMMAND_REG;
+ struct device *dev =3D ts->dev;
+ unsigned int attempts =3D 20;
+ unsigned int mode;
+ int ret;
+
+ ret =3D axoim_blp_wait_ready(ts);
+ if (ret)
+ return ret;
+
+ /*
+ * For some reason this write fail with -ENXIO. Skip checking the return
+ * code (which is also done by the downstream axfw.py<http://axfw.py> tool=
 and poll u31
+ * instead.
+ */
+ regmap_raw_write(ts->regmap, reg, &reset_cmd, sizeof(reset_cmd));
+
+ do {
+ ret =3D regmap_read(ts->regmap, AXIOM_U31_REV1_DEVICE_ID_HIGH_REG,
+ &mode);
+ if (!ret)
+ break;
+
+ fsleep(250 * USEC_PER_MSEC);
+ } while (attempts--);
+
+ if (ret) {
+ dev_err(dev, "Failed to read MODE after BLP reset: %d\n", ret);
+ return ret;
+ }
+
+ mode =3D FIELD_GET(AXIOM_U31_REV1_MODE_MASK, mode);
+ if (mode =3D=3D AXIOM_U31_REV1_MODE_BLP) {
+ dev_err(dev, "Device still in BLP mode, abort\n");
+ return -EINVAL;
+ }
+
+ return 0;
+}
+
+static void axiom_lock_input_device(struct axiom_data *ts)
+{
+ if (!ts->input)
+ return;
+
+ mutex_lock(&ts->input->mutex);
+}
+
+static void axiom_unlock_input_device(struct axiom_data *ts)
+{
+ if (!ts->input)
+ return;
+
+ mutex_unlock(&ts->input->mutex);
+}
+
+static void axiom_unregister_input_dev(struct axiom_data *ts)
+{
+ if (ts->input)
+ input_unregister_device(ts->input);
+
+ ts->input =3D NULL;
+}
+
+static enum fw_upload_err
+axiom_axfw_fw_write(struct fw_upload *fw_upload, const u8 *data, u32 offse=
t,
+ u32 size, u32 *written)
+{
+ struct axiom_data *ts =3D fw_upload->dd_handle;
+ struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
+ struct device *dev =3D ts->dev;
+ bool cancel;
+ int ret;
+
+ /* Done before cancel check due to cleanup based put */
+ ret =3D pm_runtime_resume_and_get(ts->dev);
+ if (ret)
+ return FW_UPLOAD_ERR_HW_ERROR;
+
+ mutex_lock(&afw->lock);
+ cancel =3D afw->cancel;
+ mutex_unlock(&afw->lock);
+
+ if (cancel)
+ return FW_UPLOAD_ERR_CANCELED;
+
+ axiom_lock_input_device(ts);
+
+ if (ts->input && input_device_enabled(ts->input)) {
+ dev_err(dev, "Input device not idle, abort AXFW/ALC update\n");
+ goto err;
+ }
+
+ if (!strncmp(data, AXIOM_FW_AXFW_SIGNATURE,
+ strlen(AXIOM_FW_AXFW_SIGNATURE))) {
+ /* Set the pointer to the first fw chunk */
+ data +=3D sizeof(struct axiom_fw_axfw_hdr);
+ size -=3D sizeof(struct axiom_fw_axfw_hdr);
+ *written +=3D sizeof(struct axiom_fw_axfw_hdr);
+ }
+
+ if (axiom_enter_bootloader_mode(ts))
+ goto err;
+
+ while (size) {
+ u16 chunk_len, len;
+
+ chunk_len =3D get_unaligned_be16(&data[6]);
+ len =3D chunk_len + sizeof(struct axiom_fw_axfw_chunk_hdr);
+
+ /*
+ * The bootlaoder FW can handle the complete chunk incl. the
+ * header.
+ */
+ ret =3D axiom_blp_write_chunk(ts, data, len);
+ if (ret)
+ goto err;
+
+ size -=3D len;
+ *written +=3D len;
+ data +=3D len;
+ }
+
+ ret =3D axiom_blp_reset(ts);
+ if (ret)
+ dev_warn(dev, "BLP reset failed\n");
+
+ ret =3D axiom_u31_device_discover(ts);
+ if (ret) {
+ /*
+ * This is critical and we need to avoid that the user-space can
+ * still use the input-dev.
+ */
+ axiom_unlock_input_device(ts);
+ axiom_unregister_input_dev(ts);
+ dev_err(dev, "Device discovery failed after AXFW/ALC firmware update\n");
+ goto err;
+ }
+
+ /* Unlock before the input device gets unregistered */
+ axiom_unlock_input_device(ts);
+
+ ret =3D axiom_update_input_dev(ts);
+ if (ret) {
+ dev_err(dev, "Input device update failed after AXFW/ALC firmware update\n=
");
+ return FW_UPLOAD_ERR_HW_ERROR;
+ }
+
+ dev_info(dev, "AXFW update successful\n");
+
+ return FW_UPLOAD_ERR_NONE;
+
+err:
+ axiom_unlock_input_device(ts);
+ return FW_UPLOAD_ERR_HW_ERROR;
+}
+
+static enum fw_upload_err axiom_fw_poll_complete(struct fw_upload *fw_uplo=
ad)
+{
+ return FW_UPLOAD_ERR_NONE;
+}
+
+static void axiom_axfw_fw_cancel(struct fw_upload *fw_upload)
+{
+ struct axiom_data *ts =3D fw_upload->dd_handle;
+ struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
+
+ mutex_lock(&afw->lock);
+ afw->cancel =3D true;
+ mutex_unlock(&afw->lock);
+}
+
+static void axiom_axfw_fw_cleanup(struct fw_upload *fw_upload)
+{
+ struct axiom_data *ts =3D fw_upload->dd_handle;
+
+ mutex_unlock(&ts->fwupdate_lock);
+ pm_runtime_mark_last_busy(ts->dev);
+ pm_runtime_put_sync_autosuspend(ts->dev);
+}
+
+static const struct fw_upload_ops axiom_axfw_fw_upload_ops =3D {
+ .prepare =3D axiom_axfw_fw_prepare,
+ .write =3D axiom_axfw_fw_write,
+ .poll_complete =3D axiom_fw_poll_complete,
+ .cancel =3D axiom_axfw_fw_cancel,
+ .cleanup =3D axiom_axfw_fw_cleanup,
+};
+
+static int
+axiom_set_new_crcs(struct axiom_data *ts, const struct axiom_fw_cfg_chunk =
*cfg)
+{
+ struct axiom_crc *crc =3D &ts->crc[AXIOM_CRC_NEW];
+ const u32 *u33_data =3D (const u32 *)cfg->usage_content;
+
+ if (cfg->usage_rev !=3D 2 && cfg->usage_rev !=3D 3) {
+ dev_err(ts->dev, "The driver doesn't support u33 revision %u\n",
+ cfg->usage_rev);
+ return -EINVAL;
+ }
+
+ crc->runtime =3D get_unaligned_le32(u33_data);
+ crc->nvltlusageconfig =3D get_unaligned_le32(&u33_data[3]);
+ crc->vltusageconfig =3D get_unaligned_le32(&u33_data[4]);
+ crc->u22_sequencedata =3D get_unaligned_le32(&u33_data[5]);
+ crc->u43_hotspots =3D get_unaligned_le32(&u33_data[6]);
+ if (cfg->usage_rev =3D=3D 2) {
+ crc->u93_profiles =3D get_unaligned_le32(&u33_data[7]);
+ crc->u94_deltascalemap =3D get_unaligned_le32(&u33_data[8]);
+ } else if (cfg->usage_rev =3D=3D 3) {
+ crc->u77_dod_data =3D get_unaligned_le32(&u33_data[7]);
+ crc->u93_profiles =3D get_unaligned_le32(&u33_data[8]);
+ crc->u94_deltascalemap =3D get_unaligned_le32(&u33_data[9]);
+ }
+
+ return 0;
+}
+
+static unsigned int
+axiom_cfg_fw_prepare_chunk(struct axiom_fw_cfg_chunk *chunk, const u8 *dat=
a)
+{
+ chunk->usage_num =3D data[0];
+ chunk->usage_rev =3D data[1];
+ chunk->usage_length =3D get_unaligned_le16(&data[3]);
+ chunk->usage_content =3D &data[5];
+
+ return chunk->usage_length + sizeof(struct axiom_fw_cfg_chunk_hdr);
+}
+
+/*
+ * To overcome buggy firmware we need to check if a given usage is used by=
 the
+ * current running firmware. Return true if the usage is unused/not popula=
ted
+ * by the firmware since we can't perform the actual check.
+ */
+#define axiom_usage_crc_match(_ts, _usage_num, _cur, _new, _field) \
+ (!_ts->usage_table[_usage_num].populated || (_cur->_field =3D=3D _new->_f=
ield))
+
+static bool axiom_cfg_fw_update_required(struct axiom_data *ts)
+{
+ struct axiom_crc *cur, *new;
+
+ cur =3D &ts->crc[AXIOM_CRC_CUR];
+ new =3D &ts->crc[AXIOM_CRC_NEW];
+
+ if (cur->nvltlusageconfig !=3D new->nvltlusageconfig ||
+ !axiom_usage_crc_match(ts, AXIOM_U22, cur, new, u22_sequencedata) ||
+ !axiom_usage_crc_match(ts, AXIOM_U43, cur, new, u43_hotspots) ||
+ !axiom_usage_crc_match(ts, AXIOM_U93, cur, new, u93_profiles) ||
+ !axiom_usage_crc_match(ts, AXIOM_U94, cur, new, u94_deltascalemap))
+ return true;
+
+ return false;
+}
+
+static enum fw_upload_err
+axiom_cfg_fw_prepare(struct fw_upload *fw_upload, const u8 *data, u32 size=
)
+{
+ struct axiom_data *ts =3D fw_upload->dd_handle;
+ struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_CFG];
+ u32 cur_runtime_crc, fw_runtime_crc;
+ struct axiom_fw_cfg_chunk chunk;
+ struct device *dev =3D ts->dev;
+ enum fw_upload_err ret;
+ u32 signature;
+
+ mutex_lock(&afw->lock);
+ afw->cancel =3D false;
+ mutex_unlock(&afw->lock);
+
+ mutex_lock(&ts->fwupdate_lock);
+
+ if (axiom_get_runmode(ts) !=3D AXIOM_TCP_MODE) {
+ dev_err(dev, "Device not in TCP mode, abort TH2CFG update\n");
+ ret =3D FW_UPLOAD_ERR_HW_ERROR;
+ goto out;
+ }
+
+ if (size < sizeof(struct axiom_fw_cfg_hdr)) {
+ dev_err(dev, "Invalid TH2CFG file size\n");
+ ret =3D FW_UPLOAD_ERR_INVALID_SIZE;
+ goto out;
+ }
+
+ signature =3D get_unaligned_be32(data);
+ if (signature !=3D AXIOM_FW_CFG_SIGNATURE) {
+ dev_err(dev, "Invalid TH2CFG signature\n");
+ ret =3D FW_UPLOAD_ERR_FW_INVALID;
+ goto out;
+ }
+
+ /* Skip to the first fw chunk */
+ data +=3D sizeof(struct axiom_fw_cfg_hdr);
+ size -=3D sizeof(struct axiom_fw_cfg_hdr);
+
+ /*
+ * Search for u33 which contains the CRC information and perform only
+ * the runtime-crc check.
+ */
+ while (size) {
+ unsigned int chunk_len;
+
+ chunk_len =3D axiom_cfg_fw_prepare_chunk(&chunk, data);
+ if (chunk.usage_num =3D=3D AXIOM_U33)
+ break;
+
+ data +=3D chunk_len;
+ size -=3D chunk_len;
+ }
+
+ if (size =3D=3D 0) {
+ dev_err(dev, "Failed to find the u33 entry in TH2CFG\n");
+ ret =3D FW_UPLOAD_ERR_FW_INVALID;
+ goto out;
+ }
+
+ ret =3D axiom_set_new_crcs(ts, &chunk);
+ if (ret) {
+ ret =3D FW_UPLOAD_ERR_FW_INVALID;
+ goto out;
+ }
+
+ /*
+ * Nothing to do if the CRCs are the same. TODO: Must be extended once
+ * the CDU update is added.
+ */
+ if (!axiom_cfg_fw_update_required(ts)) {
+ ret =3D FW_UPLOAD_ERR_DUPLICATE;
+ goto out;
+ }
+
+ cur_runtime_crc =3D ts->crc[AXIOM_CRC_CUR].runtime;
+ fw_runtime_crc =3D ts->crc[AXIOM_CRC_NEW].runtime;
+ if (cur_runtime_crc !=3D fw_runtime_crc) {
+ dev_err(dev, "TH2CFG and device runtime CRC doesn't match: %#x !=3D %#x\n=
",
+ fw_runtime_crc, cur_runtime_crc);
+ ret =3D FW_UPLOAD_ERR_FW_INVALID;
+ goto out;
+ }
+
+ mutex_lock(&afw->lock);
+ ret =3D afw->cancel ? FW_UPLOAD_ERR_CANCELED : FW_UPLOAD_ERR_NONE;
+ mutex_unlock(&afw->lock);
+
+out:
+ /*
+ * In FW_UPLOAD_ERR_NONE case the complete handler will release the
+ * lock.
+ */
+ if (ret !=3D FW_UPLOAD_ERR_NONE)
+ mutex_unlock(&ts->fwupdate_lock);
+
+ return ret;
+}
+
+static int axiom_zero_volatile_mem(struct axiom_data *ts)
+{
+ int ret, size;
+ u8 *buf;
+
+ /* Zero out the volatile memory except for the user content in u04 */
+ ret =3D axiom_u04_get(ts, &buf);
+ if (ret < 0)
+ return ret;
+ size =3D ret;
+
+ ret =3D axiom_u02_fillconfig(ts);
+ if (ret)
+ goto out;
+
+ ret =3D axiom_u04_set(ts, buf, size);
+out:
+ kfree(buf);
+ return ret;
+}
+
+static bool
+axiom_skip_cfg_chunk(struct axiom_data *ts, const struct axiom_fw_cfg_chun=
k *chunk)
+{
+ u8 usage_num =3D chunk->usage_num;
+
+ if (!ts->usage_table[usage_num].populated) {
+ dev_warn(ts->dev, "Unknown usage chunk for u%02X\n", usage_num);
+ return true;
+ }
+
+ /* Skip read-only usages */
+ if (ts->usage_table[usage_num].info &&
+ ts->usage_table[usage_num].info->is_ro)
+ return true;
+
+ return false;
+}
+
+static int
+axiom_write_cdu_usage(struct axiom_data *ts, const struct axiom_fw_cfg_chu=
nk *chunk)
+{
+ struct axiom_cdu_usage cdu =3D { };
+ struct device *dev =3D ts->dev;
+ unsigned int remaining;
+ unsigned int reg;
+ unsigned int pos;
+ int ret;
+
+ pos =3D 0;
+ remaining =3D chunk->usage_length;
+ cdu.command =3D cpu_to_le16(AXIOM_CDU_CMD_STORE);
+ reg =3D axiom_usage_baseaddr(ts, chunk->usage_num);
+
+ while (remaining) {
+ unsigned int size;
+
+ cdu.parameters[1] =3D cpu_to_le16(pos);
+
+ size =3D remaining;
+ if (size > AXIOM_CDU_MAX_DATA_BYTES)
+ size =3D AXIOM_CDU_MAX_DATA_BYTES;
+
+ memset(cdu.data<http://cdu.data>, 0, sizeof(cdu.data));
+ memcpy(cdu.data<http://cdu.data>, &chunk->usage_content[pos], size);
+
+ ret =3D regmap_raw_write(ts->regmap, reg, &cdu, sizeof(cdu));
+ if (ret) {
+ dev_err(dev, "Failed to write CDU u%02X\n",
+ chunk->usage_num);
+ return ret;
+ }
+
+ ret =3D axiom_cdu_wait_idle(ts, chunk->usage_num);
+ if (ret) {
+ dev_err(dev, "CDU write wait-idle failed\n");
+ return ret;
+ }
+
+ remaining -=3D size;
+ pos +=3D size;
+ }
+
+ /*
+ * TODO: Check if we really need to send 48 zero bytes of data like
+ * downstream does.
+ */
+ memset(&cdu, 0, sizeof(cdu));
+ cdu.command =3D cpu_to_le16(AXIOM_CDU_CMD_COMMIT);
+ cdu.parameters[0] =3D cpu_to_le16(AXIOM_CDU_PARAM0_COMMIT);
+ cdu.parameters[1] =3D cpu_to_le16(AXIOM_CDU_PARAM1_COMMIT);
+
+ ret =3D regmap_raw_write(ts->regmap, reg, &cdu, sizeof(cdu));
+ if (ret) {
+ dev_err(dev, "Failed to commit CDU u%02X to NVM\n",
+ chunk->usage_num);
+ return ret;
+ }
+
+ ret =3D axiom_wait_for_completion_timeout(ts, &ts->nvm_write,
+ msecs_to_jiffies(5 * MSEC_PER_SEC));
+ if (!ret) {
+ dev_err(ts->dev, "Error CDU u%02X commit timedout\n",
+ chunk->usage_num);
+ return -ETIMEDOUT;
+ }
+
+ return axiom_cdu_wait_idle(ts, chunk->usage_num);
+}
+
+static int
+axiom_write_cfg_chunk(struct axiom_data *ts, const struct axiom_fw_cfg_chu=
nk *chunk)
+{
+ unsigned int reg;
+ int ret;
+
+ if (ts->usage_table[chunk->usage_num].info &&
+ ts->usage_table[chunk->usage_num].info->is_cdu) {
+ ret =3D axiom_write_cdu_usage(ts, chunk);
+ if (ret)
+ return ret;
+ goto out;
+ }
+
+ reg =3D axiom_usage_baseaddr(ts, chunk->usage_num);
+ ret =3D regmap_raw_write(ts->regmap, reg, chunk->usage_content, chunk->us=
age_length);
+ if (ret)
+ return ret;
+
+out:
+ return axiom_u02_wait_idle(ts);
+}
+
+static int axiom_verify_volatile_mem(struct axiom_data *ts)
+{
+ int ret;
+
+ ret =3D axiom_u02_computecrc(ts);
+ if (ret)
+ return ret;
+
+ /* Query the new CRCs after they are re-computed */
+ ret =3D axiom_u33_read(ts, &ts->crc[AXIOM_CRC_CUR]);
+ if (ret)
+ return ret;
+
+ return ts->crc[AXIOM_CRC_CUR].vltusageconfig =3D=3D
+ ts->crc[AXIOM_CRC_NEW].vltusageconfig ? 0 : -EINVAL;
+}
+
+static int axiom_verify_crcs(struct axiom_data *ts)
+{
+ struct device *dev =3D ts->dev;
+ struct axiom_crc *cur, *new;
+
+ cur =3D &ts->crc[AXIOM_CRC_CUR];
+ new =3D &ts->crc[AXIOM_CRC_NEW];
+
+ if (new->vltusageconfig !=3D cur->vltusageconfig) {
+ dev_err(dev, "VLTUSAGECONFIG CRC32 mismatch (dev:%#x !=3D fw:%#x)\n",
+ cur->vltusageconfig, new->vltusageconfig);
+ return -EINVAL;
+ } else if (new->nvltlusageconfig !=3D cur->nvltlusageconfig) {
+ dev_err(dev, "NVLTUSAGECONFIG CRC32 mismatch (dev:%#x !=3D fw:%#x)\n",
+ cur->nvltlusageconfig, new->nvltlusageconfig);
+ return -EINVAL;
+ } else if (!axiom_usage_crc_match(ts, AXIOM_U22, cur, new, u22_sequenceda=
ta)) {
+ dev_err(dev, "U22_SEQUENCEDATA CRC32 mismatch (dev:%#x !=3D fw:%#x)\n",
+ cur->u22_sequencedata, new->u22_sequencedata);
+ return -EINVAL;
+ } else if (!axiom_usage_crc_match(ts, AXIOM_U43, cur, new, u43_hotspots))=
 {
+ dev_err(dev, "U43_HOTSPOTS CRC32 mismatch (dev:%#x !=3D fw:%#x)\n",
+ cur->u43_hotspots, new->u43_hotspots);
+ return -EINVAL;
+ } else if (!axiom_usage_crc_match(ts, AXIOM_U93, cur, new, u93_profiles))=
 {
+ dev_err(dev, "U93_PROFILES CRC32 mismatch (dev:%#x !=3D fw:%#x)\n",
+ cur->u93_profiles, new->u93_profiles);
+ return -EINVAL;
+ } else if (!axiom_usage_crc_match(ts, AXIOM_U94, cur, new, u94_deltascale=
map)) {
+ dev_err(dev, "U94_DELTASCALEMAP CRC32 mismatch (dev:%#x !=3D fw:%#x)\n",
+ cur->u94_deltascalemap, new->u94_deltascalemap);
+ return -EINVAL;
+ }
+
+ return 0;
+}
+
+static enum fw_upload_err
+axiom_cfg_fw_write(struct fw_upload *fw_upload, const u8 *data, u32 offset=
,
+ u32 size, u32 *written)
+{
+ struct axiom_data *ts =3D fw_upload->dd_handle;
+ struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_CFG];
+ struct device *dev =3D ts->dev;
+ bool cancel;
+ int ret;
+
+ /* Done before cancel check due to cleanup based put */
+ ret =3D pm_runtime_resume_and_get(ts->dev);
+ if (ret)
+ return FW_UPLOAD_ERR_HW_ERROR;
+
+ mutex_lock(&afw->lock);
+ cancel =3D afw->cancel;
+ mutex_unlock(&afw->lock);
+
+ if (cancel)
+ return FW_UPLOAD_ERR_CANCELED;
+
+ axiom_lock_input_device(ts);
+
+ if (ts->input && input_device_enabled(ts->input)) {
+ dev_err(dev, "Input device not idle, abort TH2CFG update\n");
+ axiom_unlock_input_device(ts);
+ return FW_UPLOAD_ERR_HW_ERROR;
+ }
+
+ ret =3D axiom_u02_stop(ts);
+ if (ret)
+ goto err_swreset;
+
+ ret =3D axiom_zero_volatile_mem(ts);
+ if (ret)
+ goto err_swreset;
+
+ /* Skip to the first fw chunk */
+ data +=3D sizeof(struct axiom_fw_cfg_hdr);
+ size -=3D sizeof(struct axiom_fw_cfg_hdr);
+ *written +=3D sizeof(struct axiom_fw_cfg_hdr);
+
+ axiom_set_runmode(ts, AXIOM_TCP_CFG_UPDATE_MODE);
+
+ while (size) {
+ struct axiom_fw_cfg_chunk chunk;
+ unsigned int chunk_len;
+
+ chunk_len =3D axiom_cfg_fw_prepare_chunk(&chunk, data);
+ if (axiom_skip_cfg_chunk(ts, &chunk)) {
+ dev_dbg(dev, "Skip TH2CFG usage u%02X\n", chunk.usage_num);
+ goto next_chunk;
+ }
+
+ ret =3D axiom_write_cfg_chunk(ts, &chunk);
+ if (ret) {
+ axiom_set_runmode(ts, AXIOM_TCP_MODE);
+ goto err_swreset;
+ }
+
+next_chunk:
+ data +=3D chunk_len;
+ size -=3D chunk_len;
+ *written +=3D chunk_len;
+ }
+
+ axiom_set_runmode(ts, AXIOM_TCP_MODE);
+
+ /* Ensure that the chunks are written correctly */
+ ret =3D axiom_verify_volatile_mem(ts);
+ if (ret) {
+ dev_err(dev, "Failed to verify written config, abort\n");
+ goto err_swreset;
+ }
+
+ ret =3D axiom_u02_save_config(ts);
+ if (ret)
+ goto err_swreset;
+
+ /*
+ * TODO: Check if u02 start would be sufficient to load the new config
+ * values
+ */
+ ret =3D axiom_u02_swreset(ts);
+ if (ret) {
+ dev_err(dev, "Soft reset failed\n");
+ goto err_unlock;
+ }
+
+ ret =3D axiom_u33_read(ts, &ts->crc[AXIOM_CRC_CUR]);
+ if (ret)
+ goto err_unlock;
+
+ if (axiom_verify_crcs(ts))
+ goto err_unlock;
+
+ /* Unlock before the input device gets unregistered */
+ axiom_unlock_input_device(ts);
+
+ ret =3D axiom_update_input_dev(ts);
+ if (ret) {
+ dev_err(dev, "Input device update failed after TH2CFG firmware update\n")=
;
+ goto err_out;
+ }
+
+ dev_info(dev, "TH2CFG update successful\n");
+
+ return FW_UPLOAD_ERR_NONE;
+
+err_swreset:
+ axiom_u02_swreset(ts);
+err_unlock:
+ axiom_unlock_input_device(ts);
+err_out:
+ return ret =3D=3D -ETIMEDOUT ? FW_UPLOAD_ERR_TIMEOUT : FW_UPLOAD_ERR_HW_E=
RROR;
+}
+
+static void axiom_cfg_fw_cancel(struct fw_upload *fw_upload)
+{
+ struct axiom_data *ts =3D fw_upload->dd_handle;
+ struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_CFG];
+
+ mutex_lock(&afw->lock);
+ afw->cancel =3D true;
+ mutex_unlock(&afw->lock);
+}
+
+static void axiom_cfg_fw_cleanup(struct fw_upload *fw_upload)
+{
+ struct axiom_data *ts =3D fw_upload->dd_handle;
+
+ mutex_unlock(&ts->fwupdate_lock);
+ pm_runtime_mark_last_busy(ts->dev);
+ pm_runtime_put_sync_autosuspend(ts->dev);
+}
+
+static const struct fw_upload_ops axiom_cfg_fw_upload_ops =3D {
+ .prepare =3D axiom_cfg_fw_prepare,
+ .write =3D axiom_cfg_fw_write,
+ .poll_complete =3D axiom_fw_poll_complete,
+ .cancel =3D axiom_cfg_fw_cancel,
+ .cleanup =3D axiom_cfg_fw_cleanup,
+};
+
+static void axiom_remove_axfw_fwl_action(void *data)
+{
+ struct axiom_data *ts =3D data;
+
+ firmware_upload_unregister(ts->fw[AXIOM_FW_AXFW].fwl);
+}
+
+static void axiom_remove_cfg_fwl_action(void *data)
+{
+ struct axiom_data *ts =3D data;
+
+ firmware_upload_unregister(ts->fw[AXIOM_FW_CFG].fwl);
+}
+
+static int axiom_register_fwl(struct axiom_data *ts)
+{
+ struct device *dev =3D ts->dev;
+ struct fw_upload *fwl;
+ char *fw_name;
+ int ret;
+
+ if (!IS_ENABLED(CONFIG_FW_UPLOAD)) {
+ dev_dbg(dev, "axfw and th2cfgbin update disabled\n");
+ return 0;
+ }
+
+ mutex_init(&ts->fw[AXIOM_FW_AXFW].lock);
+ fw_name =3D kasprintf(GFP_KERNEL, "i2c:%s.axfw", dev_name(dev));
+ fwl =3D firmware_upload_register(THIS_MODULE, ts->dev, fw_name,
+ &axiom_axfw_fw_upload_ops, ts);
+ kfree(fw_name);
+ if (IS_ERR(fwl))
+ return dev_err_probe(dev, PTR_ERR(fwl),
+ "Failed to register firmware upload\n");
+
+ ret =3D devm_add_action_or_reset(dev, axiom_remove_axfw_fwl_action, ts);
+ if (ret)
+ return ret;
+
+ ts->fw[AXIOM_FW_AXFW].fwl =3D fwl;
+
+ mutex_init(&ts->fw[AXIOM_FW_CFG].lock);
+ fw_name =3D kasprintf(GFP_KERNEL, "i2c:%s.th2cfgbin", dev_name(dev));
+ fwl =3D firmware_upload_register(THIS_MODULE, ts->dev, fw_name,
+ &axiom_cfg_fw_upload_ops, ts);
+ kfree(fw_name);
+ if (IS_ERR(fwl))
+ return dev_err_probe(dev, PTR_ERR(fwl),
+ "Failed to register cfg firmware upload\n");
+
+ ret =3D devm_add_action_or_reset(dev, axiom_remove_cfg_fwl_action, ts);
+ if (ret)
+ return ret;
+
+ ts->fw[AXIOM_FW_CFG].fwl =3D fwl;
+
+ return 0;
+}
+
+/************************* Device handlig ********************************=
*****/
+
+#define AXIOM_SIMPLE_FW_DEVICE_ATTR(attr) \
+ static ssize_t \
+ fw_ ## attr ## _show(struct device *dev, \
+ struct device_attribute *_attr, char *buf) \
+ { \
+ struct i2c_client *i2c =3D to_i2c_client(dev); \
+ struct axiom_data *ts =3D i2c_get_clientdata(i2c); \
+ \
+ return sysfs_emit(buf, "%u\n", ts->fw_##attr); \
+ } \
+ static DEVICE_ATTR_RO(fw_##attr)
+
+AXIOM_SIMPLE_FW_DEVICE_ATTR(major);
+AXIOM_SIMPLE_FW_DEVICE_ATTR(minor);
+AXIOM_SIMPLE_FW_DEVICE_ATTR(rc);
+
+static ssize_t fw_status_show(struct device *dev,
+ struct device_attribute *attr, char *buf)
+{
+ struct i2c_client *i2c =3D to_i2c_client(dev);
+ struct axiom_data *ts =3D i2c_get_clientdata(i2c);
+ const char *val;
+
+ if (ts->fw_status)
+ val =3D "production";
+ else
+ val =3D "engineering";
+
+ return sysfs_emit(buf, "%s\n", val);
+}
+static DEVICE_ATTR_RO(fw_status);
+
+static ssize_t fw_variant_show(struct device *dev,
+ struct device_attribute *attr, char *buf)
+{
+ struct i2c_client *i2c =3D to_i2c_client(dev);
+ struct axiom_data *ts =3D i2c_get_clientdata(i2c);
+ const char *val;
+
+ switch (ts->fw_variant) {
+ case 0:
+ val =3D "3d";
+ break;
+ case 1:
+ val =3D "2d";
+ break;
+ case 3:
+ val =3D "force";
+ break;
+ default:
+ val =3D "unknown";
+ break;
+ }
+
+ return sysfs_emit(buf, "%s\n", val);
+}
+static DEVICE_ATTR_RO(fw_variant);
+
+static ssize_t device_id_show(struct device *dev,
+ struct device_attribute *attr, char *buf)
+{
+ struct i2c_client *i2c =3D to_i2c_client(dev);
+ struct axiom_data *ts =3D i2c_get_clientdata(i2c);
+
+ return sysfs_emit(buf, "%u\n", ts->device_id);
+}
+static DEVICE_ATTR_RO(device_id);
+
+static ssize_t device_state_show(struct device *dev,
+ struct device_attribute *attr, char *buf)
+{
+ struct i2c_client *i2c =3D to_i2c_client(dev);
+ struct axiom_data *ts =3D i2c_get_clientdata(i2c);
+
+ return sysfs_emit(buf, "%s\n", axiom_runmode_to_string(ts));
+}
+static DEVICE_ATTR_RO(device_state);
+
+static struct attribute *axiom_attrs[] =3D {
+ &dev_attr_fw_major.attr,
+ &dev_attr_fw_minor.attr,
+ &dev_attr_fw_rc.attr,
+ &dev_attr_fw_status.attr,
+ &dev_attr_fw_variant.attr,
+ &dev_attr_device_id.attr,
+ &dev_attr_device_state.attr,
+ NULL
+};
+ATTRIBUTE_GROUPS(axiom);
+
+static void axiom_poll(struct input_dev *input)
+{
+ struct axiom_data *ts =3D input_get_drvdata(input);
+
+ axiom_process_report(ts, AXIOM_U34, NULL, 0);
+}
+
+static irqreturn_t axiom_irq(int irq, void *dev_id)
+{
+ struct axiom_data *ts =3D dev_id;
+
+ axiom_process_report(ts, AXIOM_U34, NULL, 0);
+
+ return IRQ_HANDLED;
+}
+
+static int axiom_input_open(struct input_dev *dev)
+{
+ struct axiom_data *ts =3D input_get_drvdata(dev);
+
+ return pm_runtime_resume_and_get(ts->dev);
+}
+
+static void axiom_input_close(struct input_dev *dev)
+{
+ struct axiom_data *ts =3D input_get_drvdata(dev);
+
+ pm_runtime_mark_last_busy(ts->dev);
+ pm_runtime_put_sync_autosuspend(ts->dev);
+}
+
+static int axiom_register_input_dev(struct axiom_data *ts,
+ bool update_in_process)
+{
+ struct device *dev =3D ts->dev;
+ struct i2c_client *client =3D to_i2c_client(dev);
+ struct input_dev *input;
+ int ret;
+
+ input =3D input_allocate_device();
+ if (!input) {
+ dev_err(dev, "Failed to allocate input driver data\n");
+ return -ENOMEM;
+ }
+
+ input->dev.parent =3D dev;
+ input->name =3D "TouchNetix aXiom Touchscreen";
+ input->id.bustype =3D BUS_I2C;
+ input->id.vendor =3D ts->jedec_id;
+ input->id.product =3D ts->device_id;
+ input->id.version =3D ts->silicon_rev;
+
+ /* Either follow the panel or the open user count, not both */
+ if (!ts->is_panel_follower) {
+ input->open =3D axiom_input_open;
+ input->close =3D axiom_input_close;
+ }
+
+ axiom_u64_cds_enabled(ts);
+ input_set_abs_params(input, ABS_MT_POSITION_X, 0, AXIOM_MAX_XY - 1, 0, 0)=
;
+ input_set_abs_params(input, ABS_MT_POSITION_Y, 0, AXIOM_MAX_XY - 1, 0, 0)=
;
+ input_set_abs_params(input, ABS_MT_DISTANCE, 0, 127, 0, 0);
+ if (ts->cds_enabled)
+ input_set_abs_params(input, ABS_MT_PRESSURE, 0, 127, 0, 0);
+
+ touchscreen_parse_properties(input, true, &ts->prop);
+
+ axiom_u42_get_touchslots(ts);
+ if (!ts->num_slots && update_in_process) {
+ input_free_device(input);
+ /*
+ * Skip input device registration but don't throw an error to
+ * not abort the update since some FW updates require a
+ * following CFG update to re-initialize the touchslot handling.
+ */
+ if (update_in_process) {
+ dev_info(dev, "No touchslots found after FW or CFG update, skip registeri=
ng input device\n");
+ return 0;
+ }
+
+ dev_err(dev, "Error firmware has no touchslots enabled\n");
+ return -EINVAL;
+ }
+
+ ret =3D input_mt_init_slots(input, ts->num_slots, INPUT_MT_DIRECT);
+ if (ret) {
+ input_free_device(input);
+ dev_err(dev, "Failed to init mt slots\n");
+ return ret;
+ }
+
+ /*
+ * Ensure that the IRQ setup is done only once since the handler belong
+ * to the i2c-dev whereas the input-poller belong to the input-dev. The
+ * input-dev can get unregistered during a firmware update to reflect
+ * the new firmware state. Therefore the input-poller setup must be done
+ * always.
+ */
+ if (!ts->irq_setup_done && client->irq) {
+ ret =3D devm_request_threaded_irq(dev, client->irq, NULL, axiom_irq,
+ IRQF_ONESHOT, dev_name(dev), ts);
+ if (ret) {
+ dev_err(dev, "Failed to request IRQ\n");
+ return ret;
+ }
+ ts->irq_setup_done =3D true;
+ } else {
+ ret =3D input_setup_polling(input, axiom_poll);
+ if (ret) {
+ input_free_device(input);
+ dev_err(dev, "Setup polling mode failed\n");
+ return ret;
+ }
+
+ input_set_poll_interval(input, ts->poll_interval);
+ }
+
+ input_set_drvdata(input, ts);
+ ts->input =3D input;
+
+ ret =3D input_register_device(input);
+ if (ret) {
+ input_free_device(input);
+ ts->input =3D NULL;
+ dev_err(dev, "Failed to register input device\n");
+ };
+
+ return ret;
+}
+
+static int axiom_update_input_dev(struct axiom_data *ts)
+{
+ axiom_unregister_input_dev(ts);
+
+ return axiom_register_input_dev(ts, true);
+}
+
+static int axiom_parse_firmware(struct axiom_data *ts)
+{
+ struct device *dev =3D ts->dev;
+ struct gpio_desc *gpio;
+ int ret;
+
+ ts->supplies[0].supply =3D "vddi";
+ ts->supplies[1].supply =3D "vdda";
+ ts->num_supplies =3D ARRAY_SIZE(ts->supplies);
+
+ ret =3D devm_regulator_bulk_get(dev, ts->num_supplies, ts->supplies);
+ if (ret)
+ return dev_err_probe(dev, ret,
+ "Failed to get power supplies\n");
+
+ gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+ if (IS_ERR(gpio))
+ return dev_err_probe(dev, PTR_ERR(gpio),
+ "Failed to get reset GPIO\n");
+ ts->reset_gpio =3D gpio;
+
+ ts->poll_interval =3D AXIOM_DEFAULT_POLL_INTERVAL_MS;
+ device_property_read_u32(dev, "poll-interval", &ts->poll_interval);
+
+ return 0;
+}
+
+static int axiom_power_device(struct axiom_data *ts, unsigned int enable)
+{
+ struct device *dev =3D ts->dev;
+ int ret;
+
+ if (!enable) {
+ regulator_bulk_disable(ts->num_supplies, ts->supplies);
+ return 0;
+ }
+
+ ret =3D regulator_bulk_enable(ts->num_supplies, ts->supplies);
+ if (ret) {
+ dev_err(dev, "Failed to enable power supplies\n");
+ return ret;
+ }
+
+ gpiod_set_value_cansleep(ts->reset_gpio, 1);
+ fsleep(2000);
+ gpiod_set_value_cansleep(ts->reset_gpio, 0);
+
+ fsleep(AXIOM_STARTUP_TIME_MS);
+
+ return 0;
+}
+
+static int axiom_panel_prepared(struct drm_panel_follower *follower)
+{
+ struct axiom_data *ts =3D container_of(follower, struct axiom_data,
+ panel_follower);
+
+ return pm_runtime_resume_and_get(ts->dev);
+}
+
+static int axiom_panel_unpreparing(struct drm_panel_follower *follower)
+{
+ struct axiom_data *ts =3D container_of(follower, struct axiom_data,
+ panel_follower);
+
+ return pm_runtime_put_sync_suspend(ts->dev);
+}
+
+static const struct drm_panel_follower_funcs axiom_panel_follower_funcs =
=3D {
+ .panel_prepared =3D axiom_panel_prepared,
+ .panel_unpreparing =3D axiom_panel_unpreparing,
+};
+
+static int axiom_register_panel_follower(struct axiom_data *ts)
+{
+ struct device *dev =3D ts->dev;
+
+ if (!drm_is_panel_follower(dev))
+ return 0;
+
+ if (device_can_wakeup(dev)) {
+ dev_warn(dev, "Can't follow panel if marked as wakup device\n");
+ return 0;
+ }
+
+ ts->panel_follower.funcs =3D &axiom_panel_follower_funcs;
+ ts->is_panel_follower =3D true;
+
+ return devm_drm_panel_add_follower(dev, &ts->panel_follower);
+}
+
+static int axiom_i2c_probe(struct i2c_client *client)
+{
+ struct device *dev =3D &client->dev;
+ struct axiom_data *ts;
+ int ret;
+
+ ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+ if (!ts)
+ return dev_err_probe(dev, -ENOMEM,
+ "Failed to allocate driver data\n");
+
+ ts->regmap =3D devm_regmap_init_i2c(client, &axiom_i2c_regmap_config);
+ if (IS_ERR(ts->regmap))
+ return dev_err_probe(dev, PTR_ERR(ts->regmap),
+ "Failed to initialize regmap\n");
+
+ i2c_set_clientdata(client, ts);
+ ts->dev =3D dev;
+
+ init_completion(&ts->boot_complete.completion);
+ init_completion(&ts->nvm_write.completion);
+ mutex_init(&ts->fwupdate_lock);
+
+ ret =3D axiom_register_fwl(ts);
+ if (ret)
+ return ret;
+
+ ret =3D axiom_parse_firmware(ts);
+ if (ret)
+ return ret;
+
+ ret =3D axiom_power_device(ts, 1);
+ if (ret)
+ return dev_err_probe(dev, ret, "Failed to power-on device\n");
+
+ pm_runtime_set_autosuspend_delay(dev, 10 * MSEC_PER_SEC);
+ pm_runtime_use_autosuspend(dev);
+ pm_runtime_set_active(dev);
+ pm_runtime_get_noresume(dev);
+ ret =3D devm_pm_runtime_enable(dev);
+ if (ret)
+ return dev_err_probe(dev, ret, "Failed to enable pm-runtime\n");
+
+ ret =3D axiom_register_panel_follower(ts);
+ if (ret)
+ return dev_err_probe(dev, ret, "Failed to register panel follower\n");
+
+ ret =3D axiom_u31_device_discover(ts);
+ /*
+ * Register the device to allow FW updates in case that the current FW
+ * doesn't support the required driver usages or if the device is in
+ * bootloader mode.
+ */
+ if (ret && ret =3D=3D -EACCES && IS_ENABLED(CONFIG_FW_UPLOAD)) {
+ dev_warn(dev, "Device discovery failed, wait for user fw update\n");
+ pm_runtime_mark_last_busy(dev);
+ pm_runtime_put_sync_autosuspend(dev);
+ return 0;
+ } else if (ret) {
+ pm_runtime_put_sync(dev);
+ return dev_err_probe(dev, ret, "Device discovery failed\n");
+ }
+
+ ret =3D axiom_register_input_dev(ts, false);
+ pm_runtime_mark_last_busy(dev);
+ pm_runtime_put_sync_autosuspend(dev);
+ if (ret && IS_ENABLED(CONFIG_FW_UPLOAD))
+ dev_warn(dev, "Failed to register the input device, wait for user fw upda=
te\n");
+ else if (ret)
+ return dev_err_probe(dev, ret, "Failed to register input device\n");
+
+ return 0;
+}
+
+static void axiom_i2c_remove(struct i2c_client *client)
+{
+ struct axiom_data *ts =3D i2c_get_clientdata(client);
+
+ axiom_unregister_input_dev(ts);
+}
+
+static int axiom_runtime_suspend(struct device *dev)
+{
+ struct axiom_data *ts =3D dev_get_drvdata(dev);
+ struct i2c_client *client =3D to_i2c_client(dev);
+
+ if (client->irq && ts->irq_setup_done)
+ disable_irq(client->irq);
+
+ return axiom_power_device(ts, 0);
+}
+
+static int axiom_runtime_resume(struct device *dev)
+{
+ struct axiom_data *ts =3D dev_get_drvdata(dev);
+ struct i2c_client *client =3D to_i2c_client(dev);
+ int ret;
+
+ ret =3D axiom_power_device(ts, 1);
+ if (ret)
+ return ret;
+
+ if (client->irq && ts->irq_setup_done)
+ enable_irq(client->irq);
+
+ return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(axiom_pm_ops, axiom_runtime_suspend,
+ axiom_runtime_resume, NULL);
+
+static const struct i2c_device_id axiom_i2c_id_table[] =3D {
+ { "ax54a" },
+ { },
+};
+MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
+
+static const struct of_device_id axiom_of_match[] =3D {
+ { .compatible =3D "touchnetix,ax54a", },
+ { }
+};
+MODULE_DEVICE_TABLE(of, axiom_of_match);
+
+static struct i2c_driver axiom_i2c_driver =3D {
+ .driver =3D {
+ .name =3D KBUILD_MODNAME,
+ .dev_groups =3D axiom_groups,
+ .pm =3D pm_ptr(&axiom_pm_ops),
+ .of_match_table =3D axiom_of_match,
+ },
+ .id_table =3D axiom_i2c_id_table,
+ .probe =3D axiom_i2c_probe,
+ .remove =3D axiom_i2c_remove,
+};
+module_i2c_driver(axiom_i2c_driver);
+
+MODULE_DESCRIPTION("TouchNetix aXiom touchscreen I2C bus driver");
+MODULE_LICENSE("GPL");

--
2.47.3

