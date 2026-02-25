Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018353A1A33
	for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039896; cv=none; b=btDpb1+qxBGAIfNdLeIJGeqQNZrpTCBQj20xTtY/iEmDzolhqoq35pbm5ATiwNxscM7MjWQALJSx0w1N2KNJbo+skbgBCvCTRT0/wY+9H8+ylUGjwOoTGOKyrn7bLL3JyWAugsmC3Er7DqZGCznrRbPcRFFcHC/y2BA4NcRmwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039896; c=relaxed/simple;
	bh=yphSVi1AA58JsC+6toVk16duw9YU/WyCdXpEdsS5A00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type:Content-Disposition; b=RCIW1lBXrDfN9gjnltm1JpAqvblZpSmre4aiBValAvNoofpkOL4lyo9fQmqNQ9LhhXpi8DRbFy956U8+3TqCtTQOzH8dP19cDR9eFj3elhVCBgNUu0xCzP51a74U6abXsINswUaeIL1SPSkxJhdO8d8EFoKotrNK4O2DO+0SsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021087.outbound.protection.outlook.com [52.101.100.87])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-322-KVQWMpgsNZeauRK7-CawRA-1; Wed,
 25 Feb 2026 17:11:31 +0000
X-MC-Unique: KVQWMpgsNZeauRK7-CawRA-1
X-Mimecast-MFC-AGG-ID: KVQWMpgsNZeauRK7-CawRA_1772039490
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO0P123MB7778.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:42c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.23; Wed, 25 Feb 2026 17:11:28 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b%2]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 17:11:28 +0000
Date: Wed, 25 Feb 2026 17:11:23 +0000
From: Andrew Thomas <andrew.thomas@touchnetix.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Marco Felsch <kernel@pengutronix.de>, 
	Henrik Rydberg <rydberg@bitmath.org>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <qoelgb5k77a4c4jodn622a6wauotzkeygy5fj54cjjnobb5g6c@ysxkou6nhkop>
References: <20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de>
 <20260111-v6-10-topic-touchscreen-axiom-v5-4-f94e0ae266cb@pengutronix.de>
In-Reply-To: <20260111-v6-10-topic-touchscreen-axiom-v5-4-f94e0ae266cb@pengutronix.de>
X-ClientProxiedBy: LO4P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::14) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LO0P123MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: b91159cb-1ec2-4efd-4ea8-08de7490ea0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|13003099007|7053199007
X-Microsoft-Antispam-Message-Info: PN+8k9UJ+IPy3fIqKLT23CLyXYcWo68ioEm1HmtjzdKOOjNDFEwrOq3Wip58/JYw6xOAEapUXpo/7MetQCwZM6onqb3ULhHortM6AG/zPe1kP9CuRbZRDlJrRR2AZHckPTpEfcnC7tQqoHFRKQ74gcM5YTyNklmKpJocB8YxLuw6aKKBlb9rKUiGSN1laGXcyEvE9QdGehwGIJL8oNM1XXhpP+dyuwH2QiAW3xtZhNrjFwsKjic0RRghXlo3IscWkr9acGA4pSWwtegrdYQ0xmeTpeh7CmOmRxIoK4+oOyfQSm4nvIphBD/3ujvtoLoXnsuJVINGSFgp9AtWK/JcQO9wb9waz/pJt8xLsnYE09rMSugtc3q84FWcf5+kjJC1I6+1NvGoVyZ+52vXvn2ZOWH00adm28MaUI87NCZ1rTstrh0BVfUANsQRkmckxECwCcKDFUDeesD384in9yiJYJx3ZQUUsr/Bg8UIJBDBCGWbYuOSMzmbDbrEaZa7pa68U8kV20o5pzJHN8BSN73HQoRPHHbEGUIqXhFXj5RsGu3iFVyOi2AkMJOWWb5kHmTpfCZA3tDB8URczQAVr+fH7mviT0rNh3gUoTWykOaU2wEQ27B3h/L1vdPywXAh4KbmfoAIvpk4FeykT82HnepY6YjE88a4LIiGTGfUAkN5MYnc712imWakwmgglf0nXxnJyyIjSMjnwI/MptrGI5QHKcPYHWduasvM0y/XyNaFyPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEtGdzlSOXpHL2dWRUxGZm15TTZyajR3Q1ZhUVlCV2hneGlEL25WTkErODRN?=
 =?utf-8?B?MWMxMVA2ZVlQVDN4Ykp1QU5GZHY1Z3I5TGZwVWlMWnVCR2lkY1JmTnlhbmM0?=
 =?utf-8?B?ZXBMSjcwRUdudmRSMVBOQmxpSWQ3REZhVzRCeWo3NS84Tzc0WCt1eC8yYjll?=
 =?utf-8?B?U0MxYVc1ZzVSWVJldjV3cnl5WDhKY0tpaFpkbkkvUGRmOTZNQU5xSFVVM05C?=
 =?utf-8?B?Q3hNUWZoblR1YnRNT3lRUXBveWFYMHBxWVY3YmJIRG40SHU2eHl3OG4xdU9S?=
 =?utf-8?B?Vm1oU2dxOUtYKytxcnNqa1g5UjFZVU1PWmxZQ3VxNGxoN3pkSmlTd2VObjY1?=
 =?utf-8?B?QXFXM1hqMEVTeFFvY21obERJVXhVZ2FBSG13VHJtb0RwUm94ZzB1UFJkMm5P?=
 =?utf-8?B?S0FITUs0RFlkaHlneEFLbzluS25Sc1NhbllNSUZIbnozTUZCVlBod3RBM0N0?=
 =?utf-8?B?b0hwVUYxY2NER1JSeTRiUUxtMmxNcnVPak5CSkl5MVBNQUJLcGR0RWRKcDg4?=
 =?utf-8?B?V0MzaWtFTkFnWTIvNzVKUnZOTmF0TkNtWjBsWXkzK3dGdnlhb2dyam9Rdkx4?=
 =?utf-8?B?TDBWQjZmemM2V2NLNk9tMExOYmMrdE1DWjg1cklNRFVUNHR6WTZSSU5vYWxx?=
 =?utf-8?B?VUM1KzlCbUZYVFNuc1BkRHhPdllwaGE0S0krL2JRYktOQytZbmJKU2tQcVds?=
 =?utf-8?B?VDVVYmt2K2RiaGFRT0VFckdrVWxWZmpLOUJRRXpLMXZJSENiMmpSQXEzWCtz?=
 =?utf-8?B?MkFEUXpyUGxPdzNYOVNTaEowNVkvVjlaMlB6K29WRzJpN0hGR0hzcjVHMFJC?=
 =?utf-8?B?VE9lR3c3WEZvZDVVY0lkNFFmTGRUU05XTDlQb29BdlNUaGYwTkd6VVdXNStW?=
 =?utf-8?B?RFJOYk4wcHQzNXFsUy9paHByUFBaVjRBc0xTdG4wZGRwNWQvUk5zTi94bERQ?=
 =?utf-8?B?TUtjWTRXRU9qcVd3QnhpZHNsbkhpTFk4eUhPNVVheHVmNmMraTFaUFByS0Uz?=
 =?utf-8?B?a0NoTlAzT3d5MWVRS2hRcjZRZElnay9qNmgvM2FOemVSWE0vdFllL0hnMDJU?=
 =?utf-8?B?bUs1cWQ1T09aVEZOajdSbEZKVVRVamExYkl0bVVsWVE4YjVhY2JzQWpjMTRH?=
 =?utf-8?B?ZU9KZ2tDaVUyR3htaHZkVEg5RUJscHBuL1RaSkxadGJDY1Aya0p3Q0RBL3Qy?=
 =?utf-8?B?SE1qQysrTXdyRnJyNW5GYXMxVUtGUTRaWmNQK2VZOUVTemViSHI4UnJqa09P?=
 =?utf-8?B?Y2FOYkEyMEJrNEJMKzJzL3VxZjdzYVEvNjRJYWw3ekhhdm13a2prYUxESWhn?=
 =?utf-8?B?cUFDWVZuUko2MWtyQU1QaVhaV0llQ1hqd2pTcTdFWXA4L25hbktNdW9JMkVG?=
 =?utf-8?B?RE1kZThPRGhBUnNnRzdwd3FsRWJ3ZEgwdzIvWG41NXcvZVpyVEl5TmwrSWJ0?=
 =?utf-8?B?OFpVZHV5aDBBenovb1UycUZlMnE4N2pPVXBQdEdBTzRwWDd2Zm53UWJLbVpj?=
 =?utf-8?B?c0RCM2F4NkZROXpualhqK2hadjV6ek1FQmlKRTAxRll2aDN1SHVySXFQank2?=
 =?utf-8?B?WDV5MHliR0VmNGJoZG5FTmdsa2VBV0JrYTB5ZUdsaDBycTJZNE45Qnl4THg4?=
 =?utf-8?B?TkFmR1lWUFFjY3pONTFtb2VmREwweHpTWEIrbklHWUNyemtuZVh4WlJJYjJB?=
 =?utf-8?B?VGlGZmNjMzZmdTlnZ0tSUlZzb0xxenpPZ3hXMVAzUGhsM2VleHh0VFZGb29E?=
 =?utf-8?B?SmdnSDZQcGVza2R5N0ZDeG1YdnpYQ3VmOHpOUnhNLzZSb083OVV6WUFIU3Ar?=
 =?utf-8?B?Wjl6Qjk2MDlFV253bFRzTGUwbEhhWTJ5VGZhNWVHdDUxdHJzMXFKYW1ZYk4y?=
 =?utf-8?B?eUpOeURXRzVVUWdHbDBzZ0tuajdScGNldFhELzhNZU92dnQ0MGdhd0dFUnRH?=
 =?utf-8?B?MWg5d1NmUHEwTGlqVE40cC9yUWtpQUw1ZGxoaWxpVjNYWlZ1eG1PZUdONDlM?=
 =?utf-8?B?R0o2T25pN1VIK240SEp3RlFvc3U1alVVR29tTjRESkluaE0vV1pmRGQ1TVk0?=
 =?utf-8?B?QTdEU2l6SnE5V2FVUlJIR1BCZkUxZXpkMHBQdVkvOGVCVElRY0pONEFBcTFn?=
 =?utf-8?B?cnJ5SHN2dklBMEFGdTZIbUFxSk5acnc5aVIvQXRoekRjd1lVem8yQTlhMzh4?=
 =?utf-8?B?djdBQTliMUNvYjlxUHNVYzlWZEJocGFjdkpmZmZuN2tzc2FSdThQS2VnTUtM?=
 =?utf-8?B?L2hHSFp1R3NaNkZvb012RGZ1MmhDOHpzQXBtczFwRVRyanBuYzNRK3I2RkNV?=
 =?utf-8?B?SWdNMENSWGhac2N6SCt6ZDhtMkJhNHRjTWZoUmwwWnR0WUh1Zi8rKzBkOFRW?=
 =?utf-8?Q?N/mKSVhNimhSzsRo=3D?=
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91159cb-1ec2-4efd-4ea8-08de7490ea0f
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:11:28.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdSHzJ06Eai16fuaHNri2zRS+haHJiW4eVXO7+cr2NhRk8bsNudbE3S7o+0WmG+CVylLNeRvQqiy9G1FiGpVszehaCKbxUZ2P7kqSV37hcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7778
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sEOSHy74m80Yu9hi5BXaXC1feANxfwVTjkzFQdRWZuI_1772039490
X-Mimecast-Originator: touchnetix.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 04:05:47PM +0100, Marco Felsch wrote:
>This adds the initial support for the TouchNetix AX54A touchcontroller
>which is part of TouchNetix's aXiom touchscreen controller family.
>
>The TouchNetix aXiom family provides two physical interfaces: SPI and
>I2C. This patch covers only the I2C interface.
>
>Apart the input event handling the driver supports firmware updates too.
>One firmware interface handles the touchcontroller firmware (AXFW and
>ALC) update the other handles the touchcontroller configuration
>(TH2CFGBIN) update.
>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>---
> .../testing/sysfs-driver-input-touchnetix-axiom    |   81 +
> drivers/input/touchscreen/Kconfig                  |   17 +
> drivers/input/touchscreen/Makefile                 |    1 +
> drivers/input/touchscreen/touchnetix_axiom.c       | 2974 +++++++++++++++=
+++++
> 4 files changed, 3073 insertions(+)
>
>diff --git a/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom=
 b/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom
>new file mode 100644
>index 0000000000000000000000000000000000000000..31c1c6510c55da80659ddf7bea=
2d0ce681fde323
>--- /dev/null
>+++ b/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom
>@@ -0,0 +1,81 @@
>+What:=09=09/sys/bus/i2c/devices/xxx/fw_major
>+Date:=09=09Jan 2026
>+Contact:=09linux-input@vger.kernel.org
>+Description:
>+=09=09Reports the firmware major version provided by the touchscreen.
>+
>+=09=09Access: Read
>+
>+=09=09Valid values: Represented as string
>+
>+What:=09=09/sys/bus/i2c/devices/xxx/fw_minor
>+Date:=09=09Jan 2026
>+Contact:=09linux-input@vger.kernel.org
>+Description:
>+=09=09Reports the firmware minor version provided by the touchscreen.
>+
>+=09=09Access: Read
>+
>+=09=09Valid values: Represented as string
>+
>+What:=09=09/sys/bus/i2c/devices/xxx/fw_rc
>+Date:=09=09Jan 2026
>+Contact:=09linux-input@vger.kernel.org
>+Description:
>+=09=09Reports the firmware release canidate version provided by the touch=
screen.
>+
>+=09=09Access: Read
>+
>+=09=09Valid values: Represented as string
>+
>+What:=09=09/sys/bus/i2c/devices/xxx/fw_status
>+Date:=09=09Jan 2026
>+Contact:=09linux-input@vger.kernel.org
>+Description:
>+=09=09Reports the firmware status provided by the touchscreen. It may
>+=09=09be either "release" or "engineering".
>+
>+=09=09Access: Read
>+
>+=09=09Valid values: Represented as string
>+
>+What:=09=09/sys/bus/i2c/devices/xxx/fw_variant
>+Date:=09=09Jan 2026
>+Contact:=09linux-input@vger.kernel.org
>+Description:
>+=09=09Reports the firmware variant provided by the touchscreen. It may
>+=09=09be either: "3d", "2d", "force" or "unknown".
>+
>+=09=09Access: Read
>+
>+=09=09Valid values: Represented as string
>+
>+What:=09=09/sys/bus/i2c/devices/xxx/device_id
>+Date:=09=09Jan 2026
>+Contact:=09linux-input@vger.kernel.org
>+Description:
>+=09=09Reports the touchscreen device id, for example: "54" for the AX54A.
>+
>+=09=09Access: Read
>+
>+=09=09Valid values: Represented as string
>+
>+What:=09=09/sys/bus/i2c/devices/xxx/device_state
>+Date:=09=09Jan 2026
>+Contact:=09linux-input@vger.kernel.org
>+Description:
>+=09=09Reports the touchscreen device current runtime state. The
>+=09=09following values are reported:
>+
>+=09=09discovery: Device is in discovery mode.
>+=09=09tcp:  Device is in touch-control-protocol (tcp) mode. This is
>+=09=09      the normal working mode.
>+=09=09th2cfg-update: Device is in configuration update mode.
>+=09=09bootloader-pre: Device bootloader mode enter was triggered
>+=09=09bootloader: Device is in bootloader mode, used for firmware
>+=09=09=09    updates.
>+=09=09unknown: Device mode is unknown.
>+
>+=09=09Access: Read
>+
>+=09=09Valid values: Represented as string
>diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen=
/Kconfig
>index 7d5b72ee07fa1313da39a625b5129a0459720865..449ae5e29cb4bb1f5335afdee8=
2e91f0aa30a209 100644
>--- a/drivers/input/touchscreen/Kconfig
>+++ b/drivers/input/touchscreen/Kconfig
>@@ -828,6 +828,23 @@ config TOUCHSCREEN_MIGOR
> =09  To compile this driver as a module, choose M here: the
> =09  module will be called migor_ts.
>
>+config TOUCHSCREEN_TOUCHNETIX_AXIOM
>+=09tristate "TouchNetix aXiom based touchscreen controllers"
>+=09# We need to call into panel code so if DRM=3Dm, this can't be 'y'
>+=09depends on DRM || !DRM
>+=09depends on I2C
>+=09select CRC16
>+=09select CRC32
>+=09select REGMAP_I2C
>+=09help
>+=09  Say Y here if you have a axiom touchscreen connected to
>+=09  your system.
>+
>+=09  If unsure, say N.
>+
>+=09  To compile this driver as a module, choose M here: the
>+=09  module will be called touchnetix_axiom.
>+
> config TOUCHSCREEN_TOUCHRIGHT
> =09tristate "Touchright serial touchscreen"
> =09select SERIO
>diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscree=
n/Makefile
>index ab9abd151078831a4b22d6998e00ef74fe01c356..540df3ada4b2b6ad05ffeba67f=
44ff262f93c11f 100644
>--- a/drivers/input/touchscreen/Makefile
>+++ b/drivers/input/touchscreen/Makefile
>@@ -90,6 +90,7 @@ obj-$(CONFIG_TOUCHSCREEN_SUR40)=09=09+=3D sur40.o
> obj-$(CONFIG_TOUCHSCREEN_SURFACE3_SPI)=09+=3D surface3_spi.o
> obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)=09+=3D ti_am335x_tsc.o
> obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)=09+=3D touchit213.o
>+obj-$(CONFIG_TOUCHSCREEN_TOUCHNETIX_AXIOM)=09+=3D touchnetix_axiom.o
> obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)=09+=3D touchright.o
> obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)=09+=3D touchwin.o
> obj-$(CONFIG_TOUCHSCREEN_TS4800)=09+=3D ts4800-ts.o
>diff --git a/drivers/input/touchscreen/touchnetix_axiom.c b/drivers/input/=
touchscreen/touchnetix_axiom.c
>new file mode 100644
>index 0000000000000000000000000000000000000000..e8f56a8f7e8a83361b04bb858c=
aadf9658fb7e05
>--- /dev/null
>+++ b/drivers/input/touchscreen/touchnetix_axiom.c
>@@ -0,0 +1,2974 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * TouchNetix aXiom Touchscreen Driver
>+ *
>+ * Copyright (C) 2024 Pengutronix
>+ *
>+ * Marco Felsch <kernel@pengutronix.de>
>+ */
>+
>+#include <drm/drm_panel.h>
>+#include <linux/bitfield.h>
>+#include <linux/bits.h>
>+#include <linux/completion.h>
>+#include <linux/crc16.h>
>+#include <linux/crc32.h>
>+#include <linux/delay.h>
>+#include <linux/device.h>
>+#include <linux/firmware.h>
>+#include <linux/gpio/consumer.h>
>+#include <linux/i2c.h>
>+#include <linux/input.h>
>+#include <linux/input/mt.h>
>+#include <linux/input/touchscreen.h>
>+#include <linux/interrupt.h>
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/mod_devicetable.h>
>+#include <linux/pm_runtime.h>
>+#include <linux/property.h>
>+#include <linux/regmap.h>
>+#include <linux/regulator/consumer.h>
>+#include <linux/time.h>
>+#include <linux/unaligned.h>
>+
>+/*
>+ * Short introduction for developers:
>+ *  The programming manual is written based on u(sages):
>+ *   - Max. 0xff usages possible
>+ *   - A usage is a group of registers (0x00 ... 0xff)
>+ *   - The usage base address must be discovered (FW dependent)
>+ *   - Partial RW usage access is allowed
>+ *   - Each usage has a revision (FW dependent)
>+ *   - Only u31 is always at address 0x0 (used for discovery)
>+ *
>+ *  E.x. Reading register 0x01 for usage u03 with baseaddr 0x20 results i=
n the
>+ *  following physical 16bit I2C address: 0x2001.
>+ *
>+ * Note the datasheet specifies the usage numbers in hex and the internal
>+ * offsets in decimal. Keep it that way to make it more developer friendl=
y.
>+ */
>+#define AXIOM_U01=09=09=09=090x01
>+#define AXIOM_U01_REV1_REPORTTYPE_REG=09=090
>+#define   AXIOM_U01_REV1_REPORTTYPE_HELLO=090
>+#define   AXIOM_U01_REV1_REPORTTYPE_HEARTBEAT=091
>+#define   AXIOM_U01_REV1_REPORTTYPE_OPCOMPLETE=093
>+
>+#define AXIOM_U02=09=09=09=09=090x02
>+#define AXIOM_U02_REV1_COMMAND_REG=09=09=090
>+#define   AXIOM_U02_REV1_CMD_HARDRESET=09=09=090x0001
>+#define   AXIOM_U02_REV1_CMD_SOFTRESET=09=09=090x0002
>+#define   AXIOM_U02_REV1_CMD_STOP=09=09=090x0005
>+#define   AXIOM_U02_REV1_CMD_SAVEVLTLCFG2NVM=09=090x0007
>+#define   AXIOM_U02_REV1_PARAM1_SAVEVLTLCFG2NVM=09=090xb10c
>+#define   AXIOM_U02_REV1_PARAM2_SAVEVLTLCFG2NVM=09=090xc0de
>+#define   AXIOM_U02_REV1_CMD_HANDSHAKENVM=09=090x0008
>+#define   AXIOM_U02_REV1_CMD_COMPUTECRCS=09=090x0009
>+#define   AXIOM_U02_REV1_CMD_FILLCONFIG=09=09=090x000a
>+#define   AXIOM_U02_REV1_PARAM0_FILLCONFIG=09=090x5555
>+#define   AXIOM_U02_REV1_PARAM1_FILLCONFIG=09=090xaaaa
>+#define   AXIOM_U02_REV1_PARAM2_FILLCONFIG_ZERO=09=090xa55a
>+#define   AXIOM_U02_REV1_CMD_ENTERBOOTLOADER=09=090x000b
>+#define   AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY1=090x5555
>+#define   AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY2=090xaaaa
>+#define   AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY3=090xa55a
>+#define   AXIOM_U02_REV1_RESP_SUCCESS=09=09=090x0000
>+
>+struct axiom_u02_rev1_system_manager_msg {
>+=09union {
>+=09=09__le16 command;
>+=09=09__le16 response;
>+=09};
>+=09__le16 parameters[3];
>+};
>+
>+#define AXIOM_U04=09=09=09=090x04
>+#define   AXIOM_U04_REV1_SIZE_BYTES=09=09128
>+
>+#define AXIOM_U05=09=09=09=090x05=09/* CDU */
>+
>+#define AXIOM_U22=09=09=09=090x22=09/* CDU */
>+
>+#define AXIOM_U31=09=09=09=090x31
>+#define AXIOM_U31_REV1_PAGE0=09=09=090x0000
>+#define AXIOM_U31_REV1_DEVICE_ID_LOW_REG=09(AXIOM_U31_REV1_PAGE0 + 0)
>+#define AXIOM_U31_REV1_DEVICE_ID_HIGH_REG=09(AXIOM_U31_REV1_PAGE0 + 1)
>+#define   AXIOM_U31_REV1_MODE_MASK=09=09BIT(7)
>+#define   AXIOM_U31_REV1_MODE_BLP=09=091
>+#define   AXIOM_U31_REV1_DEVICE_ID_HIGH_MASK=09GENMASK(6, 0)
>+#define AXIOM_U31_REV1_RUNTIME_FW_MIN_REG=09(AXIOM_U31_REV1_PAGE0 + 2)
>+#define AXIOM_U31_REV1_RUNTIME_FW_MAJ_REG=09(AXIOM_U31_REV1_PAGE0 + 3)
>+#define AXIOM_U31_REV1_RUNTIME_FW_STATUS_REG=09(AXIOM_U31_REV1_PAGE0 + 4)
>+#define   AXIOM_U31_REV1_RUNTIME_FW_STATUS=09BIT(7)
>+#define   AXIOM_U31_REV1_RUNTIME_FW_VARIANT=09GENMASK(6, 0)
>+#define AXIOM_U31_REV1_JEDEC_ID_LOW_REG=09=09(AXIOM_U31_REV1_PAGE0 + 8)
>+#define AXIOM_U31_REV1_JEDEC_ID_HIGH_REG=09(AXIOM_U31_REV1_PAGE0 + 9)
>+#define AXIOM_U31_REV1_NUM_USAGES_REG=09=09(AXIOM_U31_REV1_PAGE0 + 10)
>+#define AXIOM_U31_REV1_RUNTIME_FW_RC_REG=09(AXIOM_U31_REV1_PAGE0 + 11)
>+#define   AXIOM_U31_REV1_RUNTIME_FW_RC_MASK=09GENMASK(7, 4)
>+#define   AXIOM_U31_REV1_SILICON_REV_MASK=09GENMASK(3, 0)
>+
>+#define AXIOM_U31_REV1_PAGE1=09=09=090x0100
>+#define   AXIOM_U31_REV1_OFFSET_TYPE_MASK=09BIT(7)
>+#define   AXIOM_U31_REV1_MAX_OFFSET_MASK=09GENMASK(6, 0)
>+
>+#define AXIOM_U32=09=09=09=090x32
>+
>+struct axiom_u31_usage_table_entry {
>+=09u8 usage_num;
>+=09u8 start_page;
>+=09u8 num_pages;
>+=09u8 max_offset;
>+=09u8 uifrevision;
>+=09u8 reserved;
>+} __packed;
>+
>+#define AXIOM_U33=09=09=09=090x33
>+
>+struct axiom_u33_rev2 {
>+=09__le32 runtime_crc;
>+=09__le32 runtime_nvm_crc;
>+=09__le32 bootloader_crc;
>+=09__le32 nvltlusageconfig_crc;
>+=09__le32 vltusageconfig_crc;
>+=09__le32 u22_sequencedata_crc;
>+=09__le32 u43_hotspots_crc;
>+=09__le32 u93_profiles_crc;
>+=09__le32 u94_deltascalemap_crc;
>+=09__le32 runtimehash_crc;
>+};
>+
>+struct axiom_u33_rev3 {
>+=09__le32 runtime_crc;
>+=09__le32 runtime_nvm_crc;
>+=09__le32 bootloader_crc;
>+=09__le32 nvltlusageconfig_crc;
>+=09__le32 vltusageconfig_crc;
>+=09__le32 u22_sequencedata_crc;
>+=09__le32 u43_hotspots_crc;
>+=09__le32 u77_dod_data_crc;
>+=09__le32 u93_profiles_crc;
>+=09__le32 u94_deltascalemap_crc;
>+=09__le32 runtimehash_crc;
>+};
>+

I think revision handling should be kept in unpacking where possible.
Currently there are 10 revisions of u33, so adding support for many
revisions and usages would add alot of code.

>+#define AXIOM_U34=09=09=09=090x34
>+#define   AXIOM_U34_REV1_OVERFLOW_MASK=09=09BIT(7)
>+#define   AXIOM_U34_REV1_REPORTLENGTH_MASK=09GENMASK(6, 0)
>+#define   AXIOM_U34_REV1_PREAMBLE_BYTES=09=092
>+#define   AXIOM_U34_REV1_POSTAMBLE_BYTES=094
>+
>+#define AXIOM_U36=09=09=09=090x36
>+
>+#define AXIOM_U41=09=09=09=090x41
>+#define AXIOM_U41_REV2_TARGETSTATUS_REG=09=090
>+#define AXIOM_U41_REV2_X_REG(id)=09=09((4 * (id)) + 2)
>+#define AXIOM_U41_REV2_Y_REG(id)=09=09((4 * (id)) + 4)
>+#define AXIOM_U41_REV2_Z_REG(id)=09=09((id) + 42)
>+
>+#define AXIOM_U42=09=09=09=090x42
>+#define AXIOM_U42_REV1_REPORT_ID_CONTAINS(id)=09((id) + 2)
>+#define   AXIOM_U42_REV1_REPORT_ID_TOUCH=091=09/* Touch, Proximity, Hover=
 */
>+
>+#define AXIOM_U42_REV4_REPORT_ID_CONTAINS(id)   ((id) + 8)
>+#define   AXIOM_U42_REV4_REPORT_ID_TOUCH=091=09/* Touch, Proximity, Hover=
 */
>+
>+#define AXIOM_U43=09=09=09=090x43=09/* CDU */
>+
>+#define AXIOM_U64=09=09=09=09=090x64
>+#define   AXIOM_U64_REV2_ENABLECDSPROCESSING_REG=090
>+#define   AXIOM_U64_REV2_ENABLECDSPROCESSING_MASK=09BIT(0)
>+
>+#define AXIOM_U77=09=09=09=090x77=09/* CDU */
>+#define AXIOM_U82=09=09=09=090x82
>+#define AXIOM_U93=09=09=09=090x93=09/* CDU */
>+#define AXIOM_U94=09=09=09=090x94=09/* CDU */
>+
>+/*
>+ * Axiom CDU usage structure copied from downstream CDU_Common.py. Downst=
ream
>+ * doesn't mention any revision. According downstream all CDU register wi=
ndows
>+ * are 56 byte wide (8 byte header + 48 byte data).
>+ */
>+#define AXIOM_CDU_CMD_STORE=09=09=090x0002
>+#define AXIOM_CDU_CMD_COMMIT=09=09=090x0003
>+#define AXIOM_CDU_PARAM0_COMMIT=09=09=090xb10c
>+#define AXIOM_CDU_PARAM1_COMMIT=09=09=090xc0de
>+
>+#define AXIOM_CDU_RESP_SUCCESS=09=09=090x0000
>+#define AXIOM_CDU_MAX_DATA_BYTES=09=0948
>+
>+struct axiom_cdu_usage {
>+=09union {
>+=09=09__le16 command;
>+=09=09__le16 response;
>+=09};
>+=09__le16 parameters[3];
>+=09u8 data[AXIOM_CDU_MAX_DATA_BYTES];
>+};
>+
>+/*
>+ * u01 for the bootloader protocol (BLP)
>+ *
>+ * Values taken from http://Bootloader.py [1] which had a comment that do=
cumentation
>+ * values are out dated. The BLP does not have different versions accordi=
ng the
>+ * documentation python helper.
>+ *
>+ * [1] https://github.com/TouchNetix/axiom_pylib
>+ */
>+#define AXIOM_U01_BLP_COMMAND_REG=09=090x0100
>+#define   AXIOM_U01_BLP_COMMAND_RESET=09=09BIT(1)
>+#define AXIOM_U01_BLP_SATUS_REG=09=09=090x0100
>+#define   AXIOM_U01_BLP_STATUS_BUSY=09=09BIT(0)
>+#define AXIOM_U01_BLP_FIFO_REG=09=09=090x0102
>+#define   AXIOM_U01_BLP_FIFO_CHK_SIZE_BYTES=09255
>+
>+#define AXIOM_PROX_LEVEL=09=09=09-128
>+#define AXIOM_STARTUP_TIME_MS=09=09=09110
>+
>+#define AXIOM_USAGE_BASEADDR_MASK=09=09GENMASK(15, 8)
>+#define AXIOM_MAX_USAGES=09=09=09256=09/* u00 - uFF */
>+/*
>+ * The devices have a 16bit ADC but Touchnetix used the lower two bits fo=
r other
>+ * information.
>+ */
>+#define AXIOM_MAX_XY=09=09=09=09(65535 - 3)
>+#define AXIOM_DEFAULT_POLL_INTERVAL_MS=09=0910
>+#define AXIOM_PAGE_BYTE_LEN=09=09=09256
>+#define AXIOM_MAX_XFERLEN=09=09=090x7fff
>+#define AXIOM_MAX_TOUCHSLOTS=09=09=0910
>+#define AXIOM_MAX_TOUCHSLOTS_MASK=09=09GENMASK(9, 0)
>+
>+/* aXiom firmware (.axfw) */
>+#define AXIOM_FW_AXFW_SIGNATURE=09=09=09"AXFW"
>+#define AXIOM_FW_AXFW_FILE_FMT_VER=09=090x0200
>+
>+struct axiom_fw_axfw_hdr {
>+=09u8 signature[4];
>+=09__le32 file_crc32;
>+=09__le16 file_format_ver;
>+=09__le16 device_id;
>+=09u8 variant;
>+=09u8 minor_ver;
>+=09u8 major_ver;
>+=09u8 rc_ver;
>+=09u8 status;
>+=09__le16 silicon_ver;
>+=09u8 silicon_rev;
>+=09__le32 fw_crc32;
>+} __packed;
>+
>+struct axiom_fw_axfw_chunk_hdr {
>+=09u8 internal[6]; /* no description */
>+=09__be16 payload_length;
>+};
>+
>+/* aXiom config (.th2cfgbin) */
>+#define AXIOM_FW_CFG_SIGNATURE=09=09=090x20071969
>+
>+struct axiom_fw_cfg_hdr {
>+=09__be32 signature;
>+=09__le16 file_format_ver;
>+=09__le16 tcp_file_rev_major;
>+=09__le16 tcp_file_rev_minor;
>+=09__le16 tcp_file_rev_patch;
>+=09u8 tcp_version;
>+} __packed;
>+
>+struct axiom_fw_cfg_chunk_hdr {
>+=09u8 usage_num;
>+=09u8 usage_rev;
>+=09u8 reserved;
>+=09__le16 usage_length;
>+} __packed;
>+
>+struct axiom_fw_cfg_chunk {
>+=09u8 usage_num;
>+=09u8 usage_rev;
>+=09u16 usage_length;
>+=09const u8 *usage_content;
>+};
>+
>+enum axiom_fw_type {
>+=09AXIOM_FW_AXFW,
>+=09AXIOM_FW_CFG,
>+=09AXIOM_FW_NUM
>+};
>+
>+enum axiom_crc_type {
>+=09AXIOM_CRC_CUR,
>+=09AXIOM_CRC_NEW,
>+=09AXIOM_CRC_NUM
>+};
>+
>+struct axiom_data;
>+
>+struct axiom_usage_info {
>+=09unsigned char usage_num;=09/* uXX number (XX in hex) */
>+=09unsigned int rev_num;=09=09/* rev.X (X in dec) */
>+=09bool is_cdu;
>+=09bool is_ro;
>+
>+=09/* Optional hooks */
>+=09int (*process_report)(struct axiom_data *ts, const u8 *buf, size_t buf=
size);
>+};
>+
>+enum axiom_runmode {
>+=09AXIOM_DISCOVERY_MODE,
>+=09AXIOM_TCP_MODE,
>+=09AXIOM_TCP_CFG_UPDATE_MODE,
>+=09AXIOM_BLP_PRE_MODE,
>+=09AXIOM_BLP_MODE,
>+};

There are only two actual axiom states, bootloader and runtime (TCP).
This is more of a driver state rather than an axiom state.
Could you label it as such?=20

>+
>+struct axiom_data {
>+=09struct input_dev *input;
>+=09struct device *dev;
>+
>+=09struct gpio_desc *reset_gpio;
>+=09struct regulator_bulk_data supplies[2];
>+=09unsigned int num_supplies;
>+
>+=09struct regmap *regmap;
>+=09struct touchscreen_properties prop;
>+=09bool irq_setup_done;
>+=09u32 poll_interval;
>+
>+=09struct drm_panel_follower panel_follower;
>+=09bool is_panel_follower;
>+
>+=09enum axiom_runmode mode;
>+=09/*
>+=09 * Two completion types to support firmware updates
>+=09 * in irq and poll mode.
>+=09 */
>+=09struct axiom_completion {
>+=09=09struct completion completion;
>+=09=09bool poll_done;
>+=09} nvm_write, boot_complete;
>+
>+=09/* Lock to protect both firmware interfaces */
>+=09struct mutex fwupdate_lock;
>+=09struct axiom_firmware {
>+=09=09/* Lock to protect cancel */
>+=09=09struct mutex lock;
>+=09=09bool cancel;
>+=09=09struct fw_upload *fwl;
>+=09} fw[AXIOM_FW_NUM];
>+
>+=09unsigned int fw_major;
>+=09unsigned int fw_minor;
>+=09unsigned int fw_rc;
>+=09unsigned int fw_status;
>+=09unsigned int fw_variant;
>+=09u16 device_id;
>+=09u16 jedec_id;
>+=09u8 silicon_rev;
>+
>+=09/* CRCs we need to check during a config update */
>+=09struct axiom_crc {
>+=09=09u32 runtime;
>+=09=09u32 vltusageconfig;
>+=09=09u32 nvltlusageconfig;
>+=09=09u32 u22_sequencedata;
>+=09=09u32 u43_hotspots;
>+=09=09u32 u77_dod_data;
>+=09=09u32 u93_profiles;
>+=09=09u32 u94_deltascalemap;
>+=09} crc[AXIOM_CRC_NUM];

I think this structure should hold all possible u33 CRCs and then invalid o=
nes
can be ignored for the given u33 revision.

>+
>+=09bool cds_enabled;
>+=09unsigned long enabled_slots;
>+=09unsigned int num_slots;
>+
>+=09unsigned int max_report_byte_len;
>+=09struct axiom_usage_table_entry {
>+=09=09bool populated;
>+=09=09unsigned int baseaddr;
>+=09=09unsigned int size_bytes;
>+=09=09const struct axiom_usage_info *info;
>+=09} usage_table[AXIOM_MAX_USAGES];
>+};
>+
>+static int axiom_u01_rev1_process_report(struct axiom_data *ts, const u8 =
*buf,
>+=09=09=09=09=09 size_t bufsize);
>+static int axiom_u34_rev1_process_report(struct axiom_data *ts, const u8 =
*_buf,
>+=09=09=09=09=09 size_t bufsize);
>+static int axiom_u41_rev2_process_report(struct axiom_data *ts, const u8 =
*buf,
>+=09=09=09=09=09 size_t bufsize);
>+
>+#define AXIOM_USAGE(num, rev)=09=09\
>+=09{=09=09=09=09\
>+=09=09.usage_num =3D num,=09\
>+=09=09.rev_num =3D rev,=09=09\
>+=09}
>+
>+#define AXIOM_RO_USAGE(num, rev)=09\
>+=09{=09=09=09=09\
>+=09=09.usage_num =3D num,=09\
>+=09=09.rev_num =3D rev,=09=09\
>+=09=09.is_ro =3D true,=09=09\
>+=09}
>+
>+#define AXIOM_CDU_USAGE(num, rev)=09\
>+=09{=09=09=09=09\
>+=09=09.usage_num =3D num,=09\
>+=09=09.rev_num =3D rev,=09=09\
>+=09=09.is_cdu =3D true,=09=09\
>+=09}
>+
>+#define AXIOM_REPORT_USAGE(num, rev, func)=09\
>+=09{=09=09=09=09=09\
>+=09=09.usage_num =3D num,=09=09\
>+=09=09.rev_num =3D rev,=09=09=09\
>+=09=09.process_report =3D func,=09=09\
>+=09}
>+
>+#define AXIOM_USAGE_REV_UNUSED=09(-1)
>+
>+/*
>+ * All usages used by driver must be added to this list to ensure the cor=
rect
>+ * communictation with the devices. The list can contain multiple entries=
 of the
>+ * same usage to handle different usage revisions.
>+ *
>+ * Note:
>+ * During a th2cfgbin update the driver may use usages not listed here.
>+ * Therefore the th2cfgbin update compares the current running FW again t=
he
>+ * th2cfgbin targets FW.
>+ */
>+static const struct axiom_usage_info driver_required_usages[] =3D {
>+=09AXIOM_REPORT_USAGE(AXIOM_U01, 1, axiom_u01_rev1_process_report),
>+=09AXIOM_REPORT_USAGE(AXIOM_U01, 3, axiom_u01_rev1_process_report),
>+=09AXIOM_USAGE(AXIOM_U02, 1),
>+=09AXIOM_USAGE(AXIOM_U02, 2),
>+=09AXIOM_USAGE(AXIOM_U04, 1),
>+=09AXIOM_RO_USAGE(AXIOM_U33, 2),
>+=09AXIOM_RO_USAGE(AXIOM_U33, 3),
>+=09AXIOM_REPORT_USAGE(AXIOM_U34, 1, axiom_u34_rev1_process_report),
>+=09AXIOM_REPORT_USAGE(AXIOM_U41, 2, axiom_u41_rev2_process_report),
>+=09AXIOM_REPORT_USAGE(AXIOM_U41, 4, axiom_u41_rev2_process_report),
>+=09AXIOM_USAGE(AXIOM_U42, 1),
>+=09AXIOM_USAGE(AXIOM_U42, 4),
>+=09AXIOM_USAGE(AXIOM_U64, 2),
>+=09AXIOM_USAGE(AXIOM_U64, 4),
>+=09{ /* sentinel */ }
>+};
>+
>+/*
>+ * All usages below are unused but the driver needs to know the type (ro,=
 cdu)
>+ * to handle them correctly. Unfortunately the type is not discoverable. =
Once
>+ * a usage is actually used, it must be shifted to driver_required_usages=
 and
>+ * the revision must be set accordingly.
>+ */
>+static const struct axiom_usage_info driver_additional_usages[] =3D {
>+=09AXIOM_CDU_USAGE(AXIOM_U05, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_CDU_USAGE(AXIOM_U22, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_RO_USAGE(AXIOM_U31, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_RO_USAGE(AXIOM_U32, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_RO_USAGE(AXIOM_U36, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_CDU_USAGE(AXIOM_U43, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_CDU_USAGE(AXIOM_U77, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_RO_USAGE(AXIOM_U82, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_CDU_USAGE(AXIOM_U93, AXIOM_USAGE_REV_UNUSED),
>+=09AXIOM_CDU_USAGE(AXIOM_U94, AXIOM_USAGE_REV_UNUSED),
>+=09{ /* sentinel */ }
>+};
>+
>+/************************ Common helpers ********************************=
******/
>+
>+static void axiom_set_runmode(struct axiom_data *ts, enum axiom_runmode m=
ode)
>+{
>+=09ts->mode =3D mode;
>+}
>+
>+static enum axiom_runmode axiom_get_runmode(struct axiom_data *ts)
>+{
>+=09return ts->mode;
>+}
>+
>+static const char *axiom_runmode_to_string(struct axiom_data *ts)
>+{
>+=09switch (ts->mode) {
>+=09case AXIOM_DISCOVERY_MODE:=09return "discovery";
>+=09case AXIOM_TCP_MODE:=09=09return "tcp";
>+=09case AXIOM_TCP_CFG_UPDATE_MODE:=09return "th2cfg-update";
>+=09case AXIOM_BLP_PRE_MODE:=09return "bootloader-pre";
>+=09case AXIOM_BLP_MODE:=09=09return "bootlaoder";
>+=09default:=09=09=09return "unknown";
>+=09}
>+}
>+
>+static bool axiom_skip_usage_check(struct axiom_data *ts)
>+{
>+=09switch (ts->mode) {
>+=09case AXIOM_TCP_CFG_UPDATE_MODE:
>+=09case AXIOM_DISCOVERY_MODE:
>+=09case AXIOM_BLP_MODE:
>+=09=09return true;
>+=09case AXIOM_BLP_PRE_MODE:
>+=09case AXIOM_TCP_MODE:
>+=09default:
>+=09=09return false;
>+=09}
>+}
>+
>+static unsigned int
>+axiom_usage_baseaddr(struct axiom_data *ts, unsigned char usage_num)
>+{
>+=09return ts->usage_table[usage_num].baseaddr;
>+}
>+
>+static unsigned int
>+axiom_usage_size(struct axiom_data *ts, unsigned char usage_num)
>+{
>+=09return ts->usage_table[usage_num].size_bytes;
>+}
>+
>+static int
>+axiom_usage_rev(struct axiom_data *ts, unsigned char usage_num)
>+{
>+=09struct axiom_usage_table_entry *entry =3D &ts->usage_table[usage_num];
>+
>+=09if (!entry->info)
>+=09=09return -EINVAL;
>+
>+=09return entry->info->rev_num;
>+}
>+
>+static bool
>+axiom_driver_supports_usage(struct axiom_data *ts, unsigned char usage_nu=
m)
>+{
>+=09const struct axiom_usage_info *iter =3D driver_required_usages;
>+=09struct device *dev =3D ts->dev;
>+=09int rev;
>+
>+=09/*
>+=09 * Some features depend on the current running firmware. Don't print a=
n
>+=09 * error if the usage for an optional feature is missing.
>+=09 */
>+=09if (!ts->usage_table[usage_num].populated) {
>+=09=09dev_dbg(dev, "u%02X is not supported by the current firmware\n",
>+=09=09=09usage_num);
>+=09=09return false;
>+=09}
>+
>+=09rev =3D axiom_usage_rev(ts, usage_num);
>+=09if (rev < 0) {
>+=09=09dev_warn(dev, "Driver doesn't support u%02X yet\n", usage_num);
>+=09=09return false;
>+=09}
>+
>+=09for (; iter; iter++) {
>+=09=09if (iter->usage_num !=3D usage_num)
>+=09=09=09continue;
>+
>+=09=09if (iter->rev_num =3D=3D rev)
>+=09=09=09return true;
>+=09}
>+
>+=09dev_warn(dev, "Driver doesn't support u%02X rev.%d yet\n",
>+=09=09 usage_num, rev);
>+
>+=09return false;
>+}
>+
>+static bool
>+axiom_usage_entry_is_report(struct axiom_u31_usage_table_entry *entry)
>+{
>+=09return entry->num_pages =3D=3D 0;
>+}
>+
>+static unsigned int
>+axiom_get_usage_size_bytes(struct axiom_u31_usage_table_entry *entry)
>+{
>+=09unsigned char max_offset;
>+
>+=09max_offset =3D FIELD_GET(AXIOM_U31_REV1_MAX_OFFSET_MASK,
>+=09=09=09       entry->max_offset) + 1;
>+=09max_offset *=3D 2;
>+
>+=09if (axiom_usage_entry_is_report(entry))
>+=09=09return max_offset;
>+
>+=09if (FIELD_GET(AXIOM_U31_REV1_OFFSET_TYPE_MASK, entry->max_offset))
>+=09=09return (entry->num_pages - 1) * AXIOM_PAGE_BYTE_LEN + max_offset;
>+
>+=09return max_offset;
>+}
>+
>+static void axiom_dump_usage_entry(struct device *dev,
>+=09=09=09=09   struct axiom_u31_usage_table_entry *entry)
>+{
>+=09unsigned int page_len, total_len;
>+
>+=09total_len =3D axiom_get_usage_size_bytes(entry);
>+
>+=09if (total_len > AXIOM_PAGE_BYTE_LEN)
>+=09=09page_len =3D AXIOM_PAGE_BYTE_LEN;
>+=09else
>+=09=09page_len =3D total_len;
>+
>+=09if (axiom_usage_entry_is_report(entry))
>+=09=09dev_dbg(dev,
>+=09=09=09"u%02X rev.%d total-len:%u [REPORT]\n",
>+=09=09=09entry->usage_num, entry->uifrevision, total_len);
>+=09else
>+=09=09dev_dbg(dev,
>+=09=09=09"u%02X rev.%d first-page:%#02x page-len:%u num-pages:%u total-le=
n:%u\n",
>+=09=09=09entry->usage_num, entry->uifrevision, entry->start_page, page_le=
n,
>+=09=09=09entry->num_pages, total_len);
>+}
>+
>+static const struct axiom_usage_info *
>+axiom_get_usage_info(struct axiom_u31_usage_table_entry *query)
>+{
>+=09const struct axiom_usage_info *info =3D driver_required_usages;
>+=09bool required =3D false;
>+=09bool found =3D false;
>+
>+=09for (; info->usage_num; info++) {
>+=09=09/* Skip all usages not used by the driver */
>+=09=09if (query->usage_num !=3D info->usage_num)
>+=09=09=09continue;
>+
>+=09=09/* The usage is used so we need to mark it as required */
>+=09=09required =3D true;
>+
>+=09=09/* Continue with the next usage if the revision doesn't match */
>+=09=09if (query->uifrevision !=3D info->rev_num)
>+=09=09=09continue;
>+
>+=09=09found =3D true;
>+=09=09break;
>+=09}
>+
>+=09if (found)
>+=09=09return info;
>+
>+=09/* Return an error if not found but required */
>+=09if (required)
>+=09=09return ERR_PTR(-EINVAL);
>+
>+=09info =3D driver_additional_usages;
>+=09for (; info->usage_num; info++) {
>+=09=09if (query->usage_num !=3D info->usage_num)
>+=09=09=09continue;
>+
>+=09=09/*
>+=09=09 * No need to check the revision since these usages are not
>+=09=09 * used actually but the driver needs the type information.
>+=09=09 */
>+=09=09return info;
>+=09}
>+
>+=09/* No info found */
>+=09return NULL;
>+}
>+
>+static bool axiom_usage_supported(struct axiom_data *ts, unsigned int bas=
eaddr)
>+{
>+=09struct axiom_usage_table_entry *entry;
>+=09unsigned int i;
>+
>+=09if (axiom_skip_usage_check(ts))
>+=09=09return true;
>+
>+=09dev_dbg(ts->dev, "Checking support for baseaddr: %#x\n", baseaddr);
>+
>+=09for (i =3D 0; i < ARRAY_SIZE(ts->usage_table); i++) {
>+=09=09entry =3D &ts->usage_table[i];
>+
>+=09=09if (!entry->populated)
>+=09=09=09continue;
>+
>+=09=09if (entry->baseaddr !=3D baseaddr)
>+=09=09=09continue;
>+
>+=09=09break;
>+=09}
>+
>+=09if (i =3D=3D ARRAY_SIZE(ts->usage_table)) {
>+=09=09dev_warn(ts->dev, "Usage not found\n");
>+=09=09return false;
>+=09}
>+
>+=09if (!entry->info)
>+=09=09dev_warn(ts->dev, "Unsupported usage u%02X used, driver bug!", i);
>+
>+=09return !!entry->info;
>+}
>+
>+static void axiom_poll(struct input_dev *input);
>+
>+static unsigned long
>+axiom_wait_for_completion_timeout(struct axiom_data *ts, struct axiom_com=
pletion *x,
>+=09=09=09=09  long timeout)
>+{
>+=09struct i2c_client *client =3D to_i2c_client(ts->dev);
>+=09unsigned long poll_timeout;
>+
>+=09if (client->irq)
>+=09=09return wait_for_completion_timeout(&x->completion, timeout);
>+
>+=09/*
>+=09 * Only firmware update cases do wait for completion. Since they requi=
re
>+=09 * the input device to be closed, the poller is not running. So we nee=
d
>+=09 * to do the polling manually.
>+=09 */
>+=09poll_timeout =3D timeout / 10;
>+
>+=09/*
>+=09 * Very basic and not very accurate but it does the job because there
>+=09 * are no known timeout constraints.
>+=09 */
>+=09do {
>+=09=09axiom_poll(ts->input);
>+=09=09fsleep(jiffies_to_usecs(poll_timeout));
>+=09=09if (x->poll_done)
>+=09=09=09break;
>+=09=09timeout -=3D poll_timeout;
>+=09} while (timeout > 0);
>+
>+=09x->poll_done =3D false;
>+
>+=09return timeout > 0 ? timeout : 0;
>+}
>+
>+static void axiom_complete(struct axiom_data *ts, struct axiom_completion=
 *x)
>+{
>+=09struct i2c_client *client =3D to_i2c_client(ts->dev);
>+
>+=09if (client->irq)
>+=09=09complete(&x->completion);
>+=09else
>+=09=09x->poll_done =3D true;
>+}
>+
>+/*************************** Usage handling *****************************=
******/
>+/*
>+ * Wrapper functions to handle the usage access. Wrappers are used to add
>+ * different revision handling later on more easily.
>+ */
>+static int axiom_u02_wait_idle(struct axiom_data *ts)
>+{
>+=09unsigned int reg;
>+=09int ret, _ret;
>+=09u16 cmd;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>+=09=09return -EINVAL;
>+
>+=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U02);
>+=09reg +=3D AXIOM_U02_REV1_COMMAND_REG;
>+
>+=09/*
>+=09 * Missing regmap_raw_read_poll_timeout for now. RESP_SUCCESS means th=
at
>+=09 * the last command successfully completed and the device is idle.
>+=09 */
>+=09ret =3D read_poll_timeout(regmap_raw_read, _ret,
>+=09=09=09=09_ret || cmd =3D=3D AXIOM_U02_REV1_RESP_SUCCESS,
>+=09=09=09=0910 * USEC_PER_MSEC, 1 * USEC_PER_SEC, false,
>+=09=09=09=09ts->regmap, reg, &cmd, 2);
>+=09if (ret)
>+=09=09dev_err(ts->dev, "Poll u02 timedout with: %#x\n", cmd);
>+
>+=09return ret;
>+}
>+
>+static int
>+axiom_u02_send_msg(struct axiom_data *ts,
>+=09=09   const struct axiom_u02_rev1_system_manager_msg *msg,
>+=09=09   bool validate_response)
>+{
>+=09unsigned int reg;
>+=09int ret;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>+=09=09return -EINVAL;
>+
>+=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U02);
>+=09reg +=3D AXIOM_U02_REV1_COMMAND_REG;
>+
>+=09ret =3D regmap_raw_write(ts->regmap, reg, msg, sizeof(*msg));
>+=09if (ret)
>+=09=09return ret;
>+
>+=09if (!validate_response)
>+=09=09return 0;
>+
>+=09return axiom_u02_wait_idle(ts);
>+}
>+
>+static int
>+axiom_u02_rev1_send_single_cmd(struct axiom_data *ts, u16 cmd)
>+{
>+=09struct axiom_u02_rev1_system_manager_msg msg =3D {
>+=09=09.command =3D cpu_to_le16(cmd)
>+=09};
>+
>+=09return axiom_u02_send_msg(ts, &msg, true);
>+}
>+
>+static int axiom_u02_handshakenvm(struct axiom_data *ts)
>+{
>+=09return axiom_u02_rev1_send_single_cmd(ts, AXIOM_U02_REV1_CMD_HANDSHAKE=
NVM);
>+}
>+
>+static int axiom_u02_computecrc(struct axiom_data *ts)
>+{
>+=09return axiom_u02_rev1_send_single_cmd(ts, AXIOM_U02_REV1_CMD_COMPUTECR=
CS);
>+}
>+
>+static int axiom_u02_stop(struct axiom_data *ts)
>+{
>+=09return axiom_u02_rev1_send_single_cmd(ts, AXIOM_U02_REV1_CMD_STOP);
>+}
>+
>+static int axiom_u02_save_config(struct axiom_data *ts)
>+{
>+=09struct axiom_u02_rev1_system_manager_msg msg;
>+=09int ret;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>+=09=09return -EINVAL;
>+
>+=09msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_SAVEVLTLCFG2NVM);
>+=09msg.parameters[0] =3D 0; /* Don't care */
>+=09msg.parameters[1] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM1_SAVEVLTLCFG2NV=
M);
>+=09msg.parameters[2] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM2_SAVEVLTLCFG2NV=
M);
>+
>+=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09/* Downstream http://axcfg.py waits for 2sec without checking U01 resp=
onse */
>+=09ret =3D axiom_wait_for_completion_timeout(ts, &ts->nvm_write,
>+=09=09=09=09=09msecs_to_jiffies(2 * MSEC_PER_SEC));
>+=09if (!ret)
>+=09=09dev_err(ts->dev, "Error save volatile config timedout\n");
>+
>+=09return ret ? 0 : -ETIMEDOUT;
>+}
>+
>+static int axiom_u02_swreset(struct axiom_data *ts)
>+{
>+=09struct axiom_u02_rev1_system_manager_msg msg =3D { };
>+=09int ret;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>+=09=09return -EINVAL;
>+
>+=09msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_SOFTRESET);
>+=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09/*
>+=09 * Downstream http://axcfg.py waits for 1sec without checking U01 hell=
o. Tests
>+=09 * showed that waiting for the hello message isn't enough therefore we
>+=09 * need both to make it robuster.
>+=09 */
>+=09ret =3D axiom_wait_for_completion_timeout(ts, &ts->boot_complete,
>+=09=09=09=09=09msecs_to_jiffies(1 * MSEC_PER_SEC));

Boot can take up to 2s with all selftests enabled.

>+=09if (!ret)
>+=09=09dev_err(ts->dev, "Error swreset timedout\n");
>+
>+=09fsleep(USEC_PER_SEC);
>+
>+=09return ret ? 0 : -ETIMEDOUT;
>+}
>+
>+static int axiom_u02_fillconfig(struct axiom_data *ts)
>+{
>+=09struct axiom_u02_rev1_system_manager_msg msg;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>+=09=09return -EINVAL;
>+
>+=09msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_FILLCONFIG);
>+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_FILLCONFIG);
>+=09msg.parameters[1] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM1_FILLCONFIG);
>+=09msg.parameters[2] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM2_FILLCONFIG_ZER=
O);
>+
>+=09return axiom_u02_send_msg(ts, &msg, true);
>+}
>+
>+static int axiom_u02_enter_bootloader(struct axiom_data *ts)
>+{
>+=09struct axiom_u02_rev1_system_manager_msg msg =3D { };
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int val;
>+=09int ret;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>+=09=09return -EINVAL;
>+
>+=09/*
>+=09 * Enter the bootloader mode requires 3 consecutive messages so we can=
't
>+=09 * check for the response.
>+=09 */
>+=09msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_ENTERBOOTLOADER);
>+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER=
_KEY1);
>+=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to send bootloader-key1: %d\n", ret);
>+=09=09return ret;
>+=09}

A delay is required between commands. 10ms is fine.

>+
>+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER=
_KEY2);
>+=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to send bootloader-key2: %d\n", ret);
>+=09=09return ret;
>+=09}

And here.

>+
>+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER=
_KEY3);
>+=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to send bootloader-key3: %d\n", ret);
>+=09=09return ret;
>+=09}
>+
>+=09/* Sleep before the first read to give the device time */
>+=09fsleep(250 * USEC_PER_MSEC);
>+
>+=09/* Wait till the device reports it is in bootloader mode */
>+=09return regmap_read_poll_timeout(ts->regmap,
>+=09=09=09AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, val,
>+=09=09=09FIELD_GET(AXIOM_U31_REV1_MODE_MASK, val) =3D=3D
>+=09=09=09AXIOM_U31_REV1_MODE_BLP, 250 * USEC_PER_MSEC,
>+=09=09=09USEC_PER_SEC);
>+}

Just to note if we cannot enter bootloader with u02 due to a corrupted firm=
ware,
you can enter bootloader if the nRESET line is toggled 5 times without comm=
s.

>+
>+static int axiom_u04_get(struct axiom_data *ts, u8 **_buf)
>+{
>+=09u8 buf[AXIOM_U04_REV1_SIZE_BYTES];
>+=09unsigned int reg;
>+=09int ret;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U04))
>+=09=09return -EINVAL;
>+
>+=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U04);
>+=09ret =3D regmap_raw_read(ts->regmap, reg, buf, sizeof(buf));
>+=09if (ret)
>+=09=09return ret;
>+
>+=09*_buf =3D kmemdup(buf, sizeof(buf), GFP_KERNEL);
>+
>+=09return sizeof(buf);
>+}
>+
>+static int axiom_u04_set(struct axiom_data *ts, u8 *buf, unsigned int buf=
size)
>+{
>+=09unsigned int reg;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U04))
>+=09=09return -EINVAL;
>+
>+=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U04);
>+=09return regmap_raw_write(ts->regmap, reg, buf, bufsize);
>+}
>+
>+/*
>+ * U31 revision must be always rev.1 else the whole self discovery mechan=
ism
>+ * fall apart.
>+ */
>+static int axiom_u31_parse_device_info(struct axiom_data *ts)
>+{
>+=09struct regmap *regmap =3D ts->regmap;
>+=09unsigned int id_low, id_high, val;
>+=09int ret;
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, &id_hig=
h);
>+=09if (ret)
>+=09=09return ret;
>+=09id_high =3D FIELD_GET(AXIOM_U31_REV1_DEVICE_ID_HIGH_MASK, id_high);
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_DEVICE_ID_LOW_REG, &id_low)=
;
>+=09if (ret)
>+=09=09return ret;
>+=09ts->device_id =3D id_high << 8 | id_low;
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_RUNTIME_FW_MAJ_REG, &val);
>+=09if (ret)
>+=09=09return ret;
>+=09ts->fw_major =3D val;
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_RUNTIME_FW_MIN_REG, &val);
>+=09if (ret)
>+=09=09return ret;
>+=09ts->fw_minor =3D val;
>+
>+=09/* All other fields are not allowed to be read in BLP mode */
>+=09if (axiom_get_runmode(ts) =3D=3D AXIOM_BLP_MODE)
>+=09=09return 0;
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_RUNTIME_FW_RC_REG, &val);
>+=09if (ret)
>+=09=09return ret;
>+=09ts->fw_rc =3D FIELD_GET(AXIOM_U31_REV1_RUNTIME_FW_RC_MASK, val);
>+=09ts->silicon_rev =3D FIELD_GET(AXIOM_U31_REV1_SILICON_REV_MASK, val);
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_RUNTIME_FW_STATUS_REG, &val=
);
>+=09if (ret)
>+=09=09return ret;
>+=09ts->fw_status =3D FIELD_GET(AXIOM_U31_REV1_RUNTIME_FW_STATUS, val);
>+=09ts->fw_variant =3D FIELD_GET(AXIOM_U31_REV1_RUNTIME_FW_VARIANT, val);
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_JEDEC_ID_HIGH_REG, &val);
>+=09if (ret)
>+=09=09return ret;
>+=09ts->jedec_id =3D val << 8;
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_JEDEC_ID_LOW_REG, &val);
>+=09if (ret)
>+=09=09return ret;
>+=09ts->jedec_id |=3D val;
>+
>+=09return 0;
>+}
>+
>+static int axiom_u33_read(struct axiom_data *ts, struct axiom_crc *crc);
>+
>+static int axiom_u31_device_discover(struct axiom_data *ts)
>+{
>+=09struct axiom_u31_usage_table_entry *u31_usage_table __free(kfree) =3D =
NULL;
>+=09struct axiom_u31_usage_table_entry *entry;
>+=09struct regmap *regmap =3D ts->regmap;
>+=09unsigned int mode, num_usages;
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int i;
>+=09int ret;
>+
>+=09axiom_set_runmode(ts, AXIOM_DISCOVERY_MODE);
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, &mode);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to read MODE\n");
>+=09=09return ret;
>+=09}
>+
>+=09/* Abort if the device is in bootloader protocol mode */
>+=09mode =3D FIELD_GET(AXIOM_U31_REV1_MODE_MASK, mode);
>+=09if (mode =3D=3D AXIOM_U31_REV1_MODE_BLP)
>+=09=09axiom_set_runmode(ts, AXIOM_BLP_MODE);
>+
>+=09/* Since we are not in bootloader mode we can parse the device info */
>+=09ret =3D axiom_u31_parse_device_info(ts);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to parse device info\n");
>+=09=09return ret;
>+=09}
>+
>+=09/* All other fields are not allowed to be read in BLP mode */
>+=09if (axiom_get_runmode(ts) =3D=3D AXIOM_BLP_MODE) {
>+=09=09dev_info(dev, "Device in Bootloader mode, firmware upload required\=
n");
>+=09=09return -EACCES;
>+=09}
>+
>+=09ret =3D regmap_read(regmap, AXIOM_U31_REV1_NUM_USAGES_REG, &num_usages=
);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to read NUM_USAGES\n");
>+=09=09return ret;
>+=09}
>+
>+=09u31_usage_table =3D kcalloc(num_usages, sizeof(*u31_usage_table),
>+=09=09=09=09  GFP_KERNEL);
>+=09if (!u31_usage_table)
>+=09=09return -ENOMEM;
>+
>+=09ret =3D regmap_raw_read(regmap, AXIOM_U31_REV1_PAGE1, u31_usage_table,
>+=09=09=09      array_size(num_usages, sizeof(*u31_usage_table)));
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to read NUM_USAGES\n");
>+=09=09return ret;
>+=09}
>+
>+=09/*
>+=09 * axiom_u31_device_discover() is call after fw update too, so ensure
>+=09 * that the usage_table is cleared.
>+=09 */
>+=09memset(ts->usage_table, 0, sizeof(ts->usage_table));
>+
>+=09for (i =3D 0, entry =3D u31_usage_table; i < num_usages; i++, entry++)=
 {
>+=09=09unsigned char idx =3D entry->usage_num;
>+=09=09const struct axiom_usage_info *info;
>+=09=09unsigned int size_bytes;
>+
>+=09=09axiom_dump_usage_entry(dev, entry);
>+
>+=09=09/*
>+=09=09 * Verify that the driver used usages are supported. Don't abort
>+=09=09 * yet if a usage isn't supported to allow the user to dump the
>+=09=09 * actual usage table.
>+=09=09 */
>+=09=09info =3D axiom_get_usage_info(entry);
>+=09=09if (IS_ERR(info)) {
>+=09=09=09dev_info(dev, "Required usage u%02X isn't supported for rev.%u\n=
",
>+=09=09=09=09 entry->usage_num, entry->uifrevision);
>+=09=09=09ret =3D -EACCES;
>+=09=09}
>+
>+=09=09size_bytes =3D axiom_get_usage_size_bytes(entry);
>+
>+=09=09ts->usage_table[idx].baseaddr =3D entry->start_page << 8;
>+=09=09ts->usage_table[idx].size_bytes =3D size_bytes;
>+=09=09ts->usage_table[idx].populated =3D true;
>+=09=09ts->usage_table[idx].info =3D info;
>+
>+=09=09if (axiom_usage_entry_is_report(entry) &&
>+=09=09    ts->max_report_byte_len < size_bytes)
>+=09=09=09ts->max_report_byte_len =3D size_bytes;
>+=09}
>+
>+=09if (ret)
>+=09=09return ret;
>+
>+=09/* From now on we are in TCP mode to include usage revision checks */
>+=09axiom_set_runmode(ts, AXIOM_TCP_MODE);
>+
>+=09return axiom_u33_read(ts, &ts->crc[AXIOM_CRC_CUR]);
>+}
>+
>+static int axiom_u33_read(struct axiom_data *ts, struct axiom_crc *crc)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int reg;
>+=09int ret;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U33))
>+=09=09return -EINVAL;
>+
>+=09if (axiom_usage_rev(ts, AXIOM_U33) =3D=3D 2) {
>+=09=09struct axiom_u33_rev2 val;
>+
>+=09=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U33);
>+=09=09ret =3D regmap_raw_read(ts->regmap, reg, &val, sizeof(val));

Could we read into a raw buffer to save having to define a little endian=20
version of the CRCs?

>+=09=09if (ret) {
>+=09=09=09dev_err(dev, "Failed to read u33\n");
>+=09=09=09return ret;
>+=09=09}
>+
>+=09=09crc->runtime =3D le32_to_cpu(val.runtime_crc);
>+=09=09crc->vltusageconfig =3D le32_to_cpu(val.vltusageconfig_crc);
>+=09=09crc->nvltlusageconfig =3D le32_to_cpu(val.nvltlusageconfig_crc);
>+=09=09crc->u22_sequencedata =3D le32_to_cpu(val.u22_sequencedata_crc);
>+=09=09crc->u43_hotspots =3D le32_to_cpu(val.u43_hotspots_crc);
>+=09=09crc->u93_profiles =3D le32_to_cpu(val.u93_profiles_crc);
>+=09=09crc->u94_deltascalemap =3D le32_to_cpu(val.u94_deltascalemap_crc);
>+=09} else if (axiom_usage_rev(ts, AXIOM_U33) =3D=3D 3) {
>+=09=09struct axiom_u33_rev3 val;
>+
>+=09=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U33);
>+=09=09ret =3D regmap_raw_read(ts->regmap, reg, &val, sizeof(val));
>+=09=09if (ret) {
>+=09=09=09dev_err(dev, "Failed to read u33\n");
>+=09=09=09return ret;
>+=09=09}
>+
>+=09=09crc->runtime =3D le32_to_cpu(val.runtime_crc);
>+=09=09crc->vltusageconfig =3D le32_to_cpu(val.vltusageconfig_crc);
>+=09=09crc->nvltlusageconfig =3D le32_to_cpu(val.nvltlusageconfig_crc);
>+=09=09crc->u22_sequencedata =3D le32_to_cpu(val.u22_sequencedata_crc);
>+=09=09crc->u43_hotspots =3D le32_to_cpu(val.u43_hotspots_crc);
>+=09=09crc->u77_dod_data =3D le32_to_cpu(val.u77_dod_data_crc);
>+=09=09crc->u93_profiles =3D le32_to_cpu(val.u93_profiles_crc);
>+=09=09crc->u94_deltascalemap =3D le32_to_cpu(val.u94_deltascalemap_crc);
>+=09}
>+
>+=09return 0;
>+}
>+
>+static bool axiom_u42_touch_enabled(struct axiom_data *ts, const u8 *buf,
>+=09=09=09=09    unsigned int touch_num)
>+{
>+=09switch (axiom_usage_rev(ts, AXIOM_U42)) {
>+=09case 1:
>+=09=09return buf[AXIOM_U42_REV1_REPORT_ID_CONTAINS(touch_num)] =3D=3D
>+=09=09       AXIOM_U42_REV1_REPORT_ID_TOUCH;
>+=09case 4:
>+=09=09return buf[AXIOM_U42_REV4_REPORT_ID_CONTAINS(touch_num)] =3D=3D
>+=09=09       AXIOM_U42_REV4_REPORT_ID_TOUCH;
>+=09default:
>+=09=09/* Should never happen */
>+=09=09return false;
>+=09}
>+}
>+
>+static void axiom_u42_get_touchslots(struct axiom_data *ts)
>+{
>+=09u8 *buf __free(kfree) =3D NULL;
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int bufsize;
>+=09unsigned int reg;
>+=09int ret, i;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U42)) {
>+=09=09dev_warn(dev, "Use default touchslots num\n");
>+=09=09goto fallback;
>+=09}
>+
>+=09bufsize =3D axiom_usage_size(ts, AXIOM_U42);
>+=09buf =3D kzalloc(bufsize, GFP_KERNEL);
>+=09if (!buf) {
>+=09=09dev_warn(dev, "Failed to alloc u42 read buffer, use default value\n=
");
>+=09=09goto fallback;
>+=09}
>+
>+=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U42);
>+=09ret =3D regmap_raw_read(ts->regmap, reg, buf, bufsize);
>+=09if (ret) {
>+=09=09dev_warn(dev, "Failed to read u42, use default value\n");
>+=09=09goto fallback;
>+=09}
>+
>+=09ts->enabled_slots =3D 0;
>+=09ts->num_slots =3D 0;
>+
>+=09for (i =3D 0; i < AXIOM_MAX_TOUCHSLOTS; i++) {
>+=09=09if (axiom_u42_touch_enabled(ts, buf, i)) {
>+=09=09=09ts->enabled_slots |=3D BIT(i);
>+=09=09=09ts->num_slots++;
>+=09=09}
>+=09}
>+
>+=09return;
>+
>+fallback:
>+=09ts->enabled_slots =3D AXIOM_MAX_TOUCHSLOTS_MASK;
>+=09ts->num_slots =3D AXIOM_MAX_TOUCHSLOTS;
>+}
>+
>+static void axiom_u64_cds_enabled(struct axiom_data *ts)
>+{
>+=09unsigned int reg, val;
>+=09int ret;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U64))
>+=09=09goto fallback_out;
>+
>+=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U64);
>+=09reg +=3D AXIOM_U64_REV2_ENABLECDSPROCESSING_REG;
>+
>+=09ret =3D regmap_read(ts->regmap, reg, &val);
>+=09if (ret)
>+=09=09goto fallback_out;
>+
>+=09val =3D FIELD_GET(AXIOM_U64_REV2_ENABLECDSPROCESSING_MASK, val);
>+=09ts->cds_enabled =3D val ? true : false;
>+
>+=09return;
>+
>+fallback_out:
>+=09ts->cds_enabled =3D false;
>+}
>+
>+static int axiom_cdu_wait_idle(struct axiom_data *ts, u8 cdu_usage_num)
>+{
>+=09unsigned int reg;
>+=09int ret, _ret;
>+=09u16 cmd;
>+
>+=09reg =3D axiom_usage_baseaddr(ts, cdu_usage_num);
>+
>+=09/*
>+=09 * Missing regmap_raw_read_poll_timeout for now. RESP_SUCCESS means th=
at
>+=09 * the last command successfully completed and the device is idle.
>+=09 */
>+=09ret =3D read_poll_timeout(regmap_raw_read, _ret,
>+=09=09=09=09_ret || cmd =3D=3D AXIOM_CDU_RESP_SUCCESS,
>+=09=09=09=0910 * USEC_PER_MSEC, 1 * USEC_PER_SEC, false,
>+=09=09=09=09ts->regmap, reg, &cmd, 2);
>+=09if (ret)
>+=09=09dev_err(ts->dev, "Poll CDU u%02X timedout with: %#x\n",
>+=09=09=09cdu_usage_num, cmd);
>+
>+=09return ret;
>+}
>+
>+/*********************** Report usage handling **************************=
******/
>+
>+static int axiom_process_report(struct axiom_data *ts, unsigned char usag=
e_num,
>+=09=09=09=09const u8 *buf, size_t buflen)
>+{
>+=09struct axiom_usage_table_entry *entry =3D &ts->usage_table[usage_num];
>+
>+=09/* Skip processing if not in TCP mode */
>+=09if ((axiom_get_runmode(ts) !=3D AXIOM_TCP_MODE) &&
>+=09    (axiom_get_runmode(ts) !=3D AXIOM_TCP_CFG_UPDATE_MODE))
>+=09=09return 0;
>+
>+=09/* May happen if an unsupported usage was requested */
>+=09if (!entry) {
>+=09=09dev_info(ts->dev, "Unsupported usage U%x request\n", usage_num);
>+=09=09return 0;
>+=09}
>+
>+=09/* Supported report usages need to have a process_report hook */
>+=09if (!entry->info || !entry->info->process_report)
>+=09=09return -EINVAL;
>+
>+=09return entry->info->process_report(ts, buf, buflen);
>+}
>+
>+/* Make use of datasheet method 1 - single transfer read */
>+static int
>+axiom_u34_rev1_process_report(struct axiom_data *ts, const u8 *_buf, size=
_t bufsize)
>+{
>+=09unsigned int reg =3D axiom_usage_baseaddr(ts, AXIOM_U34);
>+=09struct regmap *regmap =3D ts->regmap;
>+=09u8 buf[AXIOM_PAGE_BYTE_LEN] =3D { };
>+=09struct device *dev =3D ts->dev;
>+=09unsigned char report_usage;
>+=09u16 crc_report, crc_calc;
>+=09unsigned int len;
>+=09u8 *payload;
>+=09int ret;
>+
>+=09ret =3D regmap_raw_read(regmap, reg, buf, ts->max_report_byte_len);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09/* TODO: Add overflow statistics */
>+
>+=09/* REPORTLENGTH is in uint16 */
>+=09len =3D FIELD_GET(AXIOM_U34_REV1_REPORTLENGTH_MASK, buf[0]);
>+=09len *=3D 2;
>+
>+=09/*
>+=09 * Downstream ignores zero length reports, extend the check to validat=
e
>+=09 * the upper bound too.
>+=09 */
>+=09if (len =3D=3D 0 || len > AXIOM_PAGE_BYTE_LEN) {
>+=09=09dev_dbg_ratelimited(dev, "Invalid report length: %u\n", len);
>+=09=09return -EINVAL;
>+=09}
>+
>+=09/*
>+=09 * The CRC16 value can be queried at the last two bytes of the report.
>+=09 * The value itself is covering the complete report excluding the CRC1=
6
>+=09 * value at the end.
>+=09 */
>+=09crc_report =3D get_unaligned_le16(&buf[len - 2]);
>+=09crc_calc =3D crc16(0, buf, (len - 2));
>+
>+=09if (crc_calc !=3D crc_report) {
>+=09=09dev_err_ratelimited(dev, "CRC16 mismatch!\n");
>+=09=09return -EINVAL;
>+=09}
>+
>+=09report_usage =3D buf[1];
>+=09payload =3D &buf[AXIOM_U34_REV1_PREAMBLE_BYTES];
>+=09len -=3D AXIOM_U34_REV1_PREAMBLE_BYTES - AXIOM_U34_REV1_POSTAMBLE_BYTE=
S;
>+
>+=09switch (report_usage) {
>+=09case AXIOM_U01:
>+=09case AXIOM_U41:
>+=09=09return axiom_process_report(ts, report_usage, payload, len);
>+=09default:
>+=09=09dev_dbg(dev, "Unsupported report u%02X received\n",
>+=09=09=09report_usage);
>+=09}
>+
>+=09return 0;
>+}
>+
>+static void
>+axiom_u41_rev2_decode_target(const u8 *buf, u8 id, u16 *x, u16 *y, s8 *z)
>+{
>+=09u16 val;
>+
>+=09val =3D get_unaligned_le16(&buf[AXIOM_U41_REV2_X_REG(id)]);
>+=09val &=3D AXIOM_MAX_XY;
>+=09*x =3D val;
>+
>+=09val =3D get_unaligned_le16(&buf[AXIOM_U41_REV2_Y_REG(id)]);
>+=09val &=3D AXIOM_MAX_XY;
>+=09*y =3D val;
>+
>+=09*z =3D buf[AXIOM_U41_REV2_Z_REG(id)];
>+}
>+
>+static int
>+axiom_u41_rev2_process_report(struct axiom_data *ts, const u8 *buf, size_=
t bufsize)
>+{
>+=09struct input_dev *input =3D ts->input;
>+=09unsigned char id;
>+=09u16 targets;
>+
>+=09/*
>+=09 * The input registration can be postponed but the touchscreen FW is
>+=09 * sending u41 reports regardless.
>+=09 */
>+=09if (!input)
>+=09=09return 0;
>+
>+=09targets =3D get_unaligned_le16(&buf[AXIOM_U41_REV2_TARGETSTATUS_REG]);
>+
>+=09for_each_set_bit(id, &ts->enabled_slots, AXIOM_MAX_TOUCHSLOTS) {
>+=09=09bool present;
>+=09=09u16 x, y;
>+=09=09s8 z;
>+
>+=09=09axiom_u41_rev2_decode_target(buf, id, &x, &y, &z);
>+
>+=09=09present =3D targets & BIT(id);
>+=09=09/* Ignore possible jitters */
>+=09=09if (z =3D=3D AXIOM_PROX_LEVEL)
>+=09=09=09present =3D false;
>+
>+=09=09dev_dbg(ts->dev, "id:%u x:%u y:%u z:%d present:%u",
>+=09=09=09id, x, y, z, present);
>+
>+=09=09input_mt_slot(input, id);
>+=09=09if (input_mt_report_slot_state(input, MT_TOOL_FINGER, present))
>+=09=09=09touchscreen_report_pos(input, &ts->prop, x, y, true);
>+
>+=09=09if (!present)
>+=09=09=09continue;
>+
>+=09=09input_report_abs(input, ABS_MT_DISTANCE, z < 0 ? -z : 0);
>+=09=09if (ts->cds_enabled)
>+=09=09=09input_report_abs(input, ABS_MT_PRESSURE, z >=3D 0 ? z : 0);
>+=09}
>+
>+=09input_sync(input);
>+
>+=09return 0;
>+}
>+
>+static int
>+axiom_u01_rev1_process_report(struct axiom_data *ts, const u8 *buf, size_=
t bufsize)
>+{
>+=09switch (buf[AXIOM_U01_REV1_REPORTTYPE_REG]) {
>+=09case AXIOM_U01_REV1_REPORTTYPE_HELLO:
>+=09=09dev_dbg(ts->dev, "u01 HELLO received\n");
>+=09=09axiom_complete(ts, &ts->boot_complete);
>+=09=09return 0;
>+=09case AXIOM_U01_REV1_REPORTTYPE_HEARTBEAT:
>+=09=09dev_dbg_ratelimited(ts->dev, "u01 HEARTBEAT received\n");
>+=09=09return 0;
>+=09case AXIOM_U01_REV1_REPORTTYPE_OPCOMPLETE:
>+=09=09dev_dbg(ts->dev, "u01 OPCOMPLETE received\n");
>+=09=09axiom_u02_handshakenvm(ts);
>+=09=09axiom_complete(ts, &ts->nvm_write);
>+=09=09return 0;
>+=09default:
>+=09=09return -EINVAL;
>+=09}
>+}
>+
>+/**************************** Regmap handling ***************************=
******/
>+
>+#define AXIOM_CMD_HDR_DIR_MASK=09BIT(15)
>+#define   AXIOM_CMD_HDR_READ=091
>+#define=09  AXIOM_CMD_HDR_WRITE=090
>+#define AXIOM_CMD_HDR_LEN_MASK=09GENMASK(14, 0)
>+
>+struct axiom_cmd_header {
>+=09__le16 target_address;
>+=09__le16 xferlen;
>+};
>+
>+/* Custom regmap read/write handling is required due to the aXiom protoco=
l */
>+static int axiom_regmap_read(void *context, const void *reg_buf, size_t r=
eg_size,
>+=09=09=09     void *val_buf, size_t val_size)
>+{
>+=09struct device *dev =3D context;
>+=09struct i2c_client *i2c =3D to_i2c_client(dev);
>+=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);
>+=09struct axiom_cmd_header hdr;
>+=09u16 xferlen, addr, baseaddr;
>+=09struct i2c_msg xfer[2];
>+=09int ret;
>+
>+=09if (val_size > AXIOM_MAX_XFERLEN) {
>+=09=09dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
>+=09=09=09val_size, AXIOM_MAX_XFERLEN);
>+=09=09return -EINVAL;
>+=09}
>+
>+=09addr =3D *((u16 *)reg_buf);
>+=09hdr.target_address =3D cpu_to_le16(addr);
>+=09xferlen =3D FIELD_PREP(AXIOM_CMD_HDR_DIR_MASK, AXIOM_CMD_HDR_READ) |
>+=09=09  FIELD_PREP(AXIOM_CMD_HDR_LEN_MASK, val_size);
>+=09hdr.xferlen =3D cpu_to_le16(xferlen);
>+
>+=09/* Verify that usage including the usage rev is supported */
>+=09baseaddr =3D addr & AXIOM_USAGE_BASEADDR_MASK;
>+=09if (!axiom_usage_supported(ts, baseaddr))
>+=09=09return -EINVAL;
>+
>+=09xfer[0].addr =3D i2c->addr;
>+=09xfer[0].flags =3D 0;
>+=09xfer[0].len =3D sizeof(hdr);
>+=09xfer[0].buf =3D (u8 *)&hdr;
>+
>+=09xfer[1].addr =3D i2c->addr;
>+=09xfer[1].flags =3D I2C_M_RD;
>+=09xfer[1].len =3D val_size;
>+=09xfer[1].buf =3D val_buf;
>+
>+=09ret =3D i2c_transfer(i2c->adapter, xfer, 2);
>+=09if (ret =3D=3D 2)
>+=09=09return 0;
>+=09else if (ret < 0)
>+=09=09return ret;
>+=09else
>+=09=09return -EIO;
>+}

There needs to be atleast 40us holdoff between axiom bus transfers.
I am not sure that has been considered here.

>+
>+static int axiom_regmap_write(void *context, const void *data, size_t cou=
nt)
>+{
>+=09struct device *dev =3D context;
>+=09struct i2c_client *i2c =3D to_i2c_client(dev);
>+=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);
>+=09char *buf __free(kfree) =3D NULL;
>+=09struct axiom_cmd_header hdr;
>+=09u16 xferlen, addr, baseaddr;
>+=09size_t val_size, msg_size;
>+=09int ret;
>+
>+=09val_size =3D count - sizeof(addr);
>+=09if (val_size > AXIOM_MAX_XFERLEN) {
>+=09=09dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
>+=09=09=09val_size, AXIOM_MAX_XFERLEN);
>+=09=09return -EINVAL;
>+=09}
>+
>+=09addr =3D *((u16 *)data);
>+=09hdr.target_address =3D cpu_to_le16(addr);
>+=09xferlen =3D FIELD_PREP(AXIOM_CMD_HDR_DIR_MASK, AXIOM_CMD_HDR_WRITE) |
>+=09=09  FIELD_PREP(AXIOM_CMD_HDR_LEN_MASK, val_size);
>+=09hdr.xferlen =3D cpu_to_le16(xferlen);
>+
>+=09/* Verify that usage including the usage rev is supported */
>+=09baseaddr =3D addr & AXIOM_USAGE_BASEADDR_MASK;
>+=09if (!axiom_usage_supported(ts, baseaddr))
>+=09=09return -EINVAL;
>+
>+=09msg_size =3D sizeof(hdr) + val_size;
>+=09buf =3D kzalloc(msg_size, GFP_KERNEL);
>+=09if (!buf)
>+=09=09return -ENOMEM;
>+
>+=09memcpy(buf, &hdr, sizeof(hdr));
>+=09memcpy(&buf[sizeof(hdr)], &((char *)data)[2], val_size);
>+
>+=09ret =3D i2c_master_send(i2c, buf, msg_size);
>+
>+=09return ret =3D=3D msg_size ? 0 : ret;
>+}
>+
>+static const struct regmap_config axiom_i2c_regmap_config =3D {
>+=09.reg_bits =3D 16,
>+=09.val_bits =3D 8,
>+=09.read =3D axiom_regmap_read,
>+=09.write =3D axiom_regmap_write,
>+};
>+
>+/************************ FW update handling ****************************=
******/
>+
>+static int axiom_update_input_dev(struct axiom_data *ts);
>+
>+static enum fw_upload_err
>+axiom_axfw_fw_prepare(struct fw_upload *fw_upload, const u8 *data, u32 si=
ze)
>+{
>+=09struct axiom_data *ts =3D fw_upload->dd_handle;
>+=09struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
>+=09u8 major_ver, minor_ver, rc_ver, status, variant;
>+=09u32 fw_file_crc32, crc32_calc;
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int signature_len;
>+=09enum fw_upload_err ret;
>+=09u16 fw_file_format_ver;
>+=09u16 fw_file_device_id;
>+
>+=09mutex_lock(&afw->lock);
>+=09afw->cancel =3D false;
>+=09mutex_unlock(&afw->lock);
>+
>+=09mutex_lock(&ts->fwupdate_lock);
>+
>+=09if (size < sizeof(struct axiom_fw_axfw_hdr)) {
>+=09=09dev_err(dev, "Invalid AXFW file size\n");
>+=09=09ret =3D FW_UPLOAD_ERR_INVALID_SIZE;
>+=09=09goto out;
>+=09}
>+
>+=09signature_len =3D strlen(AXIOM_FW_AXFW_SIGNATURE);
>+=09if (strncmp(data, AXIOM_FW_AXFW_SIGNATURE, signature_len)) {
>+=09=09/*
>+=09=09 * AXFW has a header which can be used to perform validations,
>+=09=09 * ALC don't. Therefore the AXFW format is preferred.
>+=09=09 */
>+=09=09dev_warn(dev, "No AXFW signature, assume ALC firmware\n");
>+=09=09ret =3D FW_UPLOAD_ERR_NONE;
>+=09=09goto out;
>+=09}
>+
>+=09fw_file_crc32 =3D get_unaligned_le32(&data[signature_len]);
>+=09crc32_calc =3D crc32(~0, &data[8], size - 8) ^ 0xffffffff;
>+=09if (fw_file_crc32 !=3D crc32_calc) {
>+=09=09dev_err(dev, "AXFW CRC32 doesn't match (fw:%#x calc:%#x)\n",
>+=09=09=09fw_file_crc32, crc32_calc);
>+=09=09ret =3D FW_UPLOAD_ERR_FW_INVALID;
>+=09=09goto out;
>+=09}
>+
>+=09data +=3D signature_len + sizeof(fw_file_crc32);
>+=09fw_file_format_ver =3D get_unaligned_le16(data);
>+=09if (fw_file_format_ver !=3D AXIOM_FW_AXFW_FILE_FMT_VER) {
>+=09=09dev_err(dev, "Invalid AXFW file format version: %04x",
>+=09=09=09fw_file_format_ver);
>+=09=09ret =3D FW_UPLOAD_ERR_FW_INVALID;
>+=09=09goto out;
>+=09}
>+
>+=09data +=3D sizeof(fw_file_format_ver);
>+=09fw_file_device_id =3D get_unaligned_le16(data);
>+=09if (fw_file_device_id !=3D ts->device_id) {
>+=09=09dev_err(dev, "Invalid AXFW target device (fw:%#04x dev:%#04x)\n",
>+=09=09=09fw_file_device_id, ts->device_id);
>+=09=09ret =3D FW_UPLOAD_ERR_FW_INVALID;
>+=09=09goto out;
>+=09}
>+
>+=09/*
>+=09 * This can happen if:
>+=09 *  * the device came up in bootloader mode, or
>+=09 *  * downloading the firmware failed in between, or
>+=09 *  * the following usage discovery failed.
>+=09 *
>+=09 *  All cases are crcitical and we need to use any firmware to
>+=09 *  bring the device back into a working state which is supported by t=
he
>+=09 *  host.
>+=09 */
>+=09if (axiom_get_runmode(ts) !=3D AXIOM_TCP_MODE)
>+=09=09return FW_UPLOAD_ERR_NONE;
>+
>+=09data +=3D sizeof(fw_file_device_id);
>+=09variant =3D *data++;
>+=09minor_ver =3D *data++;
>+=09major_ver =3D *data++;
>+=09rc_ver =3D *data++;
>+=09status =3D *data++;
>+
>+=09if (major_ver =3D=3D ts->fw_major && minor_ver =3D=3D ts->fw_minor &&
>+=09    rc_ver =3D=3D ts->fw_rc && status =3D=3D ts->fw_status &&
>+=09    variant =3D=3D ts->fw_variant) {
>+=09=09ret =3D FW_UPLOAD_ERR_DUPLICATE;
>+=09=09goto out;
>+=09}
>+
>+=09dev_info(dev, "Detected AXFW %02u.%02u.%02u (%s)\n",
>+=09=09 major_ver, minor_ver, rc_ver,
>+=09=09 status ? "production" : "engineering");
>+
>+=09mutex_lock(&afw->lock);
>+=09ret =3D afw->cancel ? FW_UPLOAD_ERR_CANCELED : FW_UPLOAD_ERR_NONE;
>+=09mutex_unlock(&afw->lock);
>+
>+out:
>+=09/*
>+=09 * In FW_UPLOAD_ERR_NONE case the complete handler will release the
>+=09 * lock.
>+=09 */
>+=09if (ret !=3D FW_UPLOAD_ERR_NONE)
>+=09=09mutex_unlock(&ts->fwupdate_lock);
>+
>+=09return ret;
>+}
>+
>+static int axiom_enter_bootloader_mode(struct axiom_data *ts)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09int ret;
>+
>+=09axiom_set_runmode(ts, AXIOM_BLP_PRE_MODE);
>+
>+=09ret =3D axiom_u02_wait_idle(ts);
>+=09if (ret)
>+=09=09goto err_out;
>+
>+=09ret =3D axiom_u02_enter_bootloader(ts);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to enter bootloader mode\n");
>+=09=09goto err_out;
>+=09}
>+
>+=09axiom_set_runmode(ts, AXIOM_BLP_MODE);
>+
>+=09return 0;
>+
>+err_out:
>+=09axiom_set_runmode(ts, AXIOM_TCP_MODE);
>+
>+=09return ret;
>+}
>+
>+static int axoim_blp_wait_ready(struct axiom_data *ts)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int reg;
>+=09int tmp, ret;
>+=09u8 buf[4];
>+
>+=09reg =3D AXIOM_U01_BLP_SATUS_REG;
>+
>+=09/* BLP busy poll requires to read 4 bytes! */
>+=09ret =3D read_poll_timeout(regmap_raw_read, tmp,
>+=09=09=09=09tmp || !(buf[2] & AXIOM_U01_BLP_STATUS_BUSY),
>+=09=09=09=0910 * USEC_PER_MSEC, 5 * USEC_PER_SEC, false,
>+=09=09=09=09ts->regmap, reg, &buf, 4);
>+=09if (ret)
>+=09=09dev_err(dev, "Bootloader wait processing packets failed %d\n", ret)=
;
>+
>+=09return ret;
>+}
>+
>+static int
>+axiom_blp_write_chunk(struct axiom_data *ts, const u8 *data, u16 length)
>+{
>+=09unsigned int chunk_size =3D AXIOM_U01_BLP_FIFO_CHK_SIZE_BYTES;
>+=09unsigned int reg =3D AXIOM_U01_BLP_FIFO_REG;
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int pos =3D 0;
>+=09int ret;
>+
>+=09ret =3D axoim_blp_wait_ready(ts);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09/*
>+=09 * TODO: Downstream does this chunk transfers. Verify if this is
>+=09 * required if one fw-chunk <=3D AXIOM_MAX_XFERLEN
>+=09 */
>+=09while (pos < length) {
>+=09=09u16 len;
>+
>+=09=09len =3D chunk_size;
>+=09=09if ((pos + chunk_size) > length)
>+=09=09=09len =3D length - pos;
>+
>+=09=09ret =3D regmap_raw_write(ts->regmap, reg, &data[pos], len);
>+=09=09if (ret) {
>+=09=09=09dev_err(dev, "Bootloader download AXFW chunk failed %d\n", ret);
>+=09=09=09return ret;
>+=09=09}
>+
>+=09=09pos +=3D len;
>+=09=09ret =3D axoim_blp_wait_ready(ts);
>+=09=09if (ret)
>+=09=09=09return ret;
>+=09}
>+
>+=09return 0;
>+}
>+
>+static int axiom_blp_reset(struct axiom_data *ts)
>+{
>+=09__le16 reset_cmd =3D cpu_to_le16(AXIOM_U01_BLP_COMMAND_RESET);
>+=09unsigned int reg =3D AXIOM_U01_BLP_COMMAND_REG;
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int attempts =3D 20;
>+=09unsigned int mode;
>+=09int ret;
>+
>+=09ret =3D axoim_blp_wait_ready(ts);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09/*
>+=09 * For some reason this write fail with -ENXIO. Skip checking the retu=
rn
>+=09 * code (which is also done by the downstream http://axfw.py tool and =
poll u31
>+=09 * instead.
>+=09 */
>+=09regmap_raw_write(ts->regmap, reg, &reset_cmd, sizeof(reset_cmd));
>+
>+=09do {
>+=09=09ret =3D regmap_read(ts->regmap, AXIOM_U31_REV1_DEVICE_ID_HIGH_REG,
>+=09=09=09=09  &mode);
>+=09=09if (!ret)
>+=09=09=09break;
>+
>+=09=09fsleep(250 * USEC_PER_MSEC);
>+=09} while (attempts--);
>+
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to read MODE after BLP reset: %d\n", ret);
>+=09=09return ret;
>+=09}
>+
>+=09mode =3D FIELD_GET(AXIOM_U31_REV1_MODE_MASK, mode);
>+=09if (mode =3D=3D AXIOM_U31_REV1_MODE_BLP) {
>+=09=09dev_err(dev, "Device still in BLP mode, abort\n");
>+=09=09return -EINVAL;
>+=09}
>+
>+=09return 0;
>+}
>+
>+static void axiom_lock_input_device(struct axiom_data *ts)
>+{
>+=09if (!ts->input)
>+=09=09return;
>+
>+=09mutex_lock(&ts->input->mutex);
>+}
>+
>+static void axiom_unlock_input_device(struct axiom_data *ts)
>+{
>+=09if (!ts->input)
>+=09=09return;
>+
>+=09mutex_unlock(&ts->input->mutex);
>+}
>+
>+static void axiom_unregister_input_dev(struct axiom_data *ts)
>+{
>+=09if (ts->input)
>+=09=09input_unregister_device(ts->input);
>+
>+=09ts->input =3D NULL;
>+}
>+
>+static enum fw_upload_err
>+axiom_axfw_fw_write(struct fw_upload *fw_upload, const u8 *data, u32 offs=
et,
>+=09=09    u32 size, u32 *written)
>+{
>+=09struct axiom_data *ts =3D fw_upload->dd_handle;
>+=09struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
>+=09struct device *dev =3D ts->dev;
>+=09bool cancel;
>+=09int ret;
>+
>+=09/* Done before cancel check due to cleanup based put */
>+=09ret =3D pm_runtime_resume_and_get(ts->dev);
>+=09if (ret)
>+=09=09return FW_UPLOAD_ERR_HW_ERROR;
>+
>+=09mutex_lock(&afw->lock);
>+=09cancel =3D afw->cancel;
>+=09mutex_unlock(&afw->lock);
>+
>+=09if (cancel)
>+=09=09return FW_UPLOAD_ERR_CANCELED;
>+
>+=09axiom_lock_input_device(ts);
>+
>+=09if (ts->input && input_device_enabled(ts->input)) {
>+=09=09dev_err(dev, "Input device not idle, abort AXFW/ALC update\n");
>+=09=09goto err;
>+=09}
>+
>+=09if (!strncmp(data, AXIOM_FW_AXFW_SIGNATURE,
>+=09=09     strlen(AXIOM_FW_AXFW_SIGNATURE))) {
>+=09=09/* Set the pointer to the first fw chunk */
>+=09=09data +=3D sizeof(struct axiom_fw_axfw_hdr);
>+=09=09size -=3D sizeof(struct axiom_fw_axfw_hdr);
>+=09=09*written +=3D sizeof(struct axiom_fw_axfw_hdr);
>+=09}
>+
>+=09if (axiom_enter_bootloader_mode(ts))
>+=09=09goto err;
>+
>+=09while (size) {
>+=09=09u16 chunk_len, len;
>+
>+=09=09chunk_len =3D get_unaligned_be16(&data[6]);
>+=09=09len =3D chunk_len + sizeof(struct axiom_fw_axfw_chunk_hdr);
>+
>+=09=09/*
>+=09=09 * The bootlaoder FW can handle the complete chunk incl. the
>+=09=09 * header.
>+=09=09 */
>+=09=09ret =3D axiom_blp_write_chunk(ts, data, len);
>+=09=09if (ret)
>+=09=09=09goto err;
>+
>+=09=09size -=3D len;
>+=09=09*written +=3D len;
>+=09=09data +=3D len;
>+=09}
>+
>+=09ret =3D axiom_blp_reset(ts);
>+=09if (ret)
>+=09=09dev_warn(dev, "BLP reset failed\n");
>+
>+=09ret =3D axiom_u31_device_discover(ts);
>+=09if (ret) {
>+=09=09/*
>+=09=09 * This is critical and we need to avoid that the user-space can
>+=09=09 * still use the input-dev.
>+=09=09 */
>+=09=09axiom_unlock_input_device(ts);
>+=09=09axiom_unregister_input_dev(ts);
>+=09=09dev_err(dev, "Device discovery failed after AXFW/ALC firmware updat=
e\n");
>+=09=09goto err;
>+=09}
>+
>+=09/* Unlock before the input device gets unregistered */
>+=09axiom_unlock_input_device(ts);
>+
>+=09ret =3D axiom_update_input_dev(ts);
>+=09if (ret) {
>+=09=09dev_err(dev, "Input device update failed after AXFW/ALC firmware up=
date\n");
>+=09=09return FW_UPLOAD_ERR_HW_ERROR;
>+=09}
>+
>+=09dev_info(dev, "AXFW update successful\n");
>+
>+=09return FW_UPLOAD_ERR_NONE;
>+
>+err:
>+=09axiom_unlock_input_device(ts);
>+=09return FW_UPLOAD_ERR_HW_ERROR;
>+}
>+
>+static enum fw_upload_err axiom_fw_poll_complete(struct fw_upload *fw_upl=
oad)
>+{
>+=09return FW_UPLOAD_ERR_NONE;
>+}
>+
>+static void axiom_axfw_fw_cancel(struct fw_upload *fw_upload)
>+{
>+=09struct axiom_data *ts =3D fw_upload->dd_handle;
>+=09struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
>+
>+=09mutex_lock(&afw->lock);
>+=09afw->cancel =3D true;
>+=09mutex_unlock(&afw->lock);
>+}
>+
>+static void axiom_axfw_fw_cleanup(struct fw_upload *fw_upload)
>+{
>+=09struct axiom_data *ts =3D fw_upload->dd_handle;
>+
>+=09mutex_unlock(&ts->fwupdate_lock);
>+=09pm_runtime_mark_last_busy(ts->dev);
>+=09pm_runtime_put_sync_autosuspend(ts->dev);
>+}
>+
>+static const struct fw_upload_ops axiom_axfw_fw_upload_ops =3D {
>+=09.prepare =3D axiom_axfw_fw_prepare,
>+=09.write =3D axiom_axfw_fw_write,
>+=09.poll_complete =3D axiom_fw_poll_complete,
>+=09.cancel =3D axiom_axfw_fw_cancel,
>+=09.cleanup =3D axiom_axfw_fw_cleanup,
>+};
>+
>+static int
>+axiom_set_new_crcs(struct axiom_data *ts, const struct axiom_fw_cfg_chunk=
 *cfg)
>+{
>+=09struct axiom_crc *crc =3D &ts->crc[AXIOM_CRC_NEW];
>+=09const u32 *u33_data =3D (const u32 *)cfg->usage_content;
>+
>+=09if (cfg->usage_rev !=3D 2 && cfg->usage_rev !=3D 3) {
>+=09=09dev_err(ts->dev, "The driver doesn't support u33 revision %u\n",
>+=09=09=09cfg->usage_rev);
>+=09=09return -EINVAL;
>+=09}
>+
>+=09crc->runtime =3D get_unaligned_le32(u33_data);
>+=09crc->nvltlusageconfig =3D get_unaligned_le32(&u33_data[3]);
>+=09crc->vltusageconfig =3D get_unaligned_le32(&u33_data[4]);
>+=09crc->u22_sequencedata =3D get_unaligned_le32(&u33_data[5]);
>+=09crc->u43_hotspots =3D get_unaligned_le32(&u33_data[6]);
>+=09if (cfg->usage_rev =3D=3D 2) {
>+=09=09crc->u93_profiles =3D get_unaligned_le32(&u33_data[7]);
>+=09=09crc->u94_deltascalemap =3D get_unaligned_le32(&u33_data[8]);
>+=09} else if (cfg->usage_rev =3D=3D 3) {
>+=09=09crc->u77_dod_data =3D get_unaligned_le32(&u33_data[7]);
>+=09=09crc->u93_profiles =3D get_unaligned_le32(&u33_data[8]);
>+=09=09crc->u94_deltascalemap =3D get_unaligned_le32(&u33_data[9]);
>+=09}
>+
>+=09return 0;
>+}
>+
>+static unsigned int
>+axiom_cfg_fw_prepare_chunk(struct axiom_fw_cfg_chunk *chunk, const u8 *da=
ta)
>+{
>+=09chunk->usage_num =3D data[0];
>+=09chunk->usage_rev =3D data[1];
>+=09chunk->usage_length =3D get_unaligned_le16(&data[3]);
>+=09chunk->usage_content =3D &data[5];
>+
>+=09return chunk->usage_length + sizeof(struct axiom_fw_cfg_chunk_hdr);
>+}
>+
>+/*
>+ * To overcome buggy firmware we need to check if a given usage is used b=
y the
>+ * current running firmware. Return true if the usage is unused/not popul=
ated
>+ * by the firmware since we can't perform the actual check.
>+ */
>+#define axiom_usage_crc_match(_ts, _usage_num, _cur, _new, _field) \
>+=09(!_ts->usage_table[_usage_num].populated || (_cur->_field =3D=3D _new-=
>_field))
>+
>+static bool axiom_cfg_fw_update_required(struct axiom_data *ts)
>+{
>+=09struct axiom_crc *cur, *new;
>+
>+=09cur =3D &ts->crc[AXIOM_CRC_CUR];
>+=09new =3D &ts->crc[AXIOM_CRC_NEW];
>+
>+=09if (cur->nvltlusageconfig !=3D new->nvltlusageconfig ||
>+=09    !axiom_usage_crc_match(ts, AXIOM_U22, cur, new, u22_sequencedata) =
||
>+=09    !axiom_usage_crc_match(ts, AXIOM_U43, cur, new, u43_hotspots) ||
>+=09    !axiom_usage_crc_match(ts, AXIOM_U93, cur, new, u93_profiles) ||
>+=09    !axiom_usage_crc_match(ts, AXIOM_U94, cur, new, u94_deltascalemap)=
)
>+=09=09return true;
>+
>+=09return false;
>+}
>+
>+static enum fw_upload_err
>+axiom_cfg_fw_prepare(struct fw_upload *fw_upload, const u8 *data, u32 siz=
e)
>+{
>+=09struct axiom_data *ts =3D fw_upload->dd_handle;
>+=09struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_CFG];
>+=09u32 cur_runtime_crc, fw_runtime_crc;
>+=09struct axiom_fw_cfg_chunk chunk;
>+=09struct device *dev =3D ts->dev;
>+=09enum fw_upload_err ret;
>+=09u32 signature;
>+
>+=09mutex_lock(&afw->lock);
>+=09afw->cancel =3D false;
>+=09mutex_unlock(&afw->lock);
>+
>+=09mutex_lock(&ts->fwupdate_lock);
>+
>+=09if (axiom_get_runmode(ts) !=3D AXIOM_TCP_MODE) {
>+=09=09dev_err(dev, "Device not in TCP mode, abort TH2CFG update\n");
>+=09=09ret =3D FW_UPLOAD_ERR_HW_ERROR;
>+=09=09goto out;
>+=09}
>+
>+=09if (size < sizeof(struct axiom_fw_cfg_hdr)) {
>+=09=09dev_err(dev, "Invalid TH2CFG file size\n");
>+=09=09ret =3D FW_UPLOAD_ERR_INVALID_SIZE;
>+=09=09goto out;
>+=09}
>+
>+=09signature =3D get_unaligned_be32(data);
>+=09if (signature !=3D AXIOM_FW_CFG_SIGNATURE) {
>+=09=09dev_err(dev, "Invalid TH2CFG signature\n");
>+=09=09ret =3D FW_UPLOAD_ERR_FW_INVALID;
>+=09=09goto out;
>+=09}
>+
>+=09/* Skip to the first fw chunk */
>+=09data +=3D sizeof(struct axiom_fw_cfg_hdr);
>+=09size -=3D sizeof(struct axiom_fw_cfg_hdr);
>+
>+=09/*
>+=09 * Search for u33 which contains the CRC information and perform only
>+=09 * the runtime-crc check.
>+=09 */
>+=09while (size) {
>+=09=09unsigned int chunk_len;
>+
>+=09=09chunk_len =3D axiom_cfg_fw_prepare_chunk(&chunk, data);
>+=09=09if (chunk.usage_num =3D=3D AXIOM_U33)
>+=09=09=09break;
>+
>+=09=09data +=3D chunk_len;
>+=09=09size -=3D chunk_len;
>+=09}
>+
>+=09if (size =3D=3D 0) {
>+=09=09dev_err(dev, "Failed to find the u33 entry in TH2CFG\n");
>+=09=09ret =3D FW_UPLOAD_ERR_FW_INVALID;
>+=09=09goto out;
>+=09}
>+
>+=09ret =3D axiom_set_new_crcs(ts, &chunk);
>+=09if (ret) {
>+=09=09ret =3D FW_UPLOAD_ERR_FW_INVALID;
>+=09=09goto out;
>+=09}
>+
>+=09/*
>+=09 * Nothing to do if the CRCs are the same. TODO: Must be extended once
>+=09 * the CDU update is added.
>+=09 */
>+=09if (!axiom_cfg_fw_update_required(ts)) {
>+=09=09ret =3D FW_UPLOAD_ERR_DUPLICATE;
>+=09=09goto out;
>+=09}
>+
>+=09cur_runtime_crc =3D ts->crc[AXIOM_CRC_CUR].runtime;
>+=09fw_runtime_crc =3D ts->crc[AXIOM_CRC_NEW].runtime;
>+=09if (cur_runtime_crc !=3D fw_runtime_crc) {
>+=09=09dev_err(dev, "TH2CFG and device runtime CRC doesn't match: %#x !=3D=
 %#x\n",
>+=09=09=09fw_runtime_crc, cur_runtime_crc);
>+=09=09ret =3D FW_UPLOAD_ERR_FW_INVALID;
>+=09=09goto out;
>+=09}

The firmware CRCs dont need to match for a config load, only the usage revi=
sion/length.

>+
>+=09mutex_lock(&afw->lock);
>+=09ret =3D afw->cancel ? FW_UPLOAD_ERR_CANCELED : FW_UPLOAD_ERR_NONE;
>+=09mutex_unlock(&afw->lock);
>+
>+out:
>+=09/*
>+=09 * In FW_UPLOAD_ERR_NONE case the complete handler will release the
>+=09 * lock.
>+=09 */
>+=09if (ret !=3D FW_UPLOAD_ERR_NONE)
>+=09=09mutex_unlock(&ts->fwupdate_lock);
>+
>+=09return ret;
>+}
>+
>+static int axiom_zero_volatile_mem(struct axiom_data *ts)
>+{
>+=09int ret, size;
>+=09u8 *buf;
>+
>+=09/* Zero out the volatile memory except for the user content in u04 */
>+=09ret =3D axiom_u04_get(ts, &buf);
>+=09if (ret < 0)
>+=09=09return ret;
>+=09size =3D ret;
>+
>+=09ret =3D axiom_u02_fillconfig(ts);
>+=09if (ret)
>+=09=09goto out;
>+
>+=09ret =3D axiom_u04_set(ts, buf, size);
>+out:
>+=09kfree(buf);
>+=09return ret;
>+}
>+
>+static bool
>+axiom_skip_cfg_chunk(struct axiom_data *ts, const struct axiom_fw_cfg_chu=
nk *chunk)
>+{
>+=09u8 usage_num =3D chunk->usage_num;
>+
>+=09if (!ts->usage_table[usage_num].populated) {
>+=09=09dev_warn(ts->dev, "Unknown usage chunk for u%02X\n", usage_num);
>+=09=09return true;
>+=09}
>+
>+=09/* Skip read-only usages */
>+=09if (ts->usage_table[usage_num].info &&
>+=09    ts->usage_table[usage_num].info->is_ro)
>+=09=09return true;
>+
>+=09return false;
>+}
>+
>+static int
>+axiom_write_cdu_usage(struct axiom_data *ts, const struct axiom_fw_cfg_ch=
unk *chunk)
>+{
>+=09struct axiom_cdu_usage cdu =3D { };
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int remaining;
>+=09unsigned int reg;
>+=09unsigned int pos;
>+=09int ret;
>+
>+=09pos =3D 0;
>+=09remaining =3D chunk->usage_length;
>+=09cdu.command =3D cpu_to_le16(AXIOM_CDU_CMD_STORE);
>+=09reg =3D axiom_usage_baseaddr(ts, chunk->usage_num);
>+
>+=09while (remaining) {
>+=09=09unsigned int size;
>+
>+=09=09cdu.parameters[1] =3D cpu_to_le16(pos);
>+
>+=09=09size =3D remaining;
>+=09=09if (size > AXIOM_CDU_MAX_DATA_BYTES)
>+=09=09=09size =3D AXIOM_CDU_MAX_DATA_BYTES;
>+
>+=09=09memset(cdu.data, 0, sizeof(cdu.data));
>+=09=09memcpy(cdu.data, &chunk->usage_content[pos], size);
>+
>+=09=09ret =3D regmap_raw_write(ts->regmap, reg, &cdu, sizeof(cdu));
>+=09=09if (ret) {
>+=09=09=09dev_err(dev, "Failed to write CDU u%02X\n",
>+=09=09=09=09chunk->usage_num);
>+=09=09=09return ret;
>+=09=09}
>+
>+=09=09ret =3D axiom_cdu_wait_idle(ts, chunk->usage_num);
>+=09=09if (ret) {
>+=09=09=09dev_err(dev, "CDU write wait-idle failed\n");
>+=09=09=09return ret;
>+=09=09}
>+
>+=09=09remaining -=3D size;
>+=09=09pos +=3D size;
>+=09}
>+
>+=09/*
>+=09 * TODO: Check if we really need to send 48 zero bytes of data like
>+=09 * downstream does.
>+=09 */
>+=09memset(&cdu, 0, sizeof(cdu));
>+=09cdu.command =3D cpu_to_le16(AXIOM_CDU_CMD_COMMIT);
>+=09cdu.parameters[0] =3D cpu_to_le16(AXIOM_CDU_PARAM0_COMMIT);
>+=09cdu.parameters[1] =3D cpu_to_le16(AXIOM_CDU_PARAM1_COMMIT);
>+
>+=09ret =3D regmap_raw_write(ts->regmap, reg, &cdu, sizeof(cdu));
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to commit CDU u%02X to NVM\n",
>+=09=09=09chunk->usage_num);
>+=09=09return ret;
>+=09}
>+
>+=09ret =3D axiom_wait_for_completion_timeout(ts, &ts->nvm_write,
>+=09=09=09=09=09msecs_to_jiffies(5 * MSEC_PER_SEC));
>+=09if (!ret) {
>+=09=09dev_err(ts->dev, "Error CDU u%02X commit timedout\n",
>+=09=09=09chunk->usage_num);
>+=09=09return -ETIMEDOUT;
>+=09}
>+
>+=09return axiom_cdu_wait_idle(ts, chunk->usage_num);
>+}
>+
>+static int
>+axiom_write_cfg_chunk(struct axiom_data *ts, const struct axiom_fw_cfg_ch=
unk *chunk)
>+{
>+=09unsigned int reg;
>+=09int ret;
>+
>+=09if (ts->usage_table[chunk->usage_num].info &&
>+=09    ts->usage_table[chunk->usage_num].info->is_cdu) {
>+=09=09ret =3D axiom_write_cdu_usage(ts, chunk);
>+=09=09if (ret)
>+=09=09=09return ret;
>+=09=09goto out;
>+=09}
>+
>+=09reg =3D axiom_usage_baseaddr(ts, chunk->usage_num);
>+=09ret =3D regmap_raw_write(ts->regmap, reg, chunk->usage_content, chunk-=
>usage_length);
>+=09if (ret)
>+=09=09return ret;
>+
>+out:
>+=09return axiom_u02_wait_idle(ts);
>+}
>+
>+static int axiom_verify_volatile_mem(struct axiom_data *ts)
>+{
>+=09int ret;
>+
>+=09ret =3D axiom_u02_computecrc(ts);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09/* Query the new CRCs after they are re-computed */
>+=09ret =3D axiom_u33_read(ts, &ts->crc[AXIOM_CRC_CUR]);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09return ts->crc[AXIOM_CRC_CUR].vltusageconfig =3D=3D
>+=09       ts->crc[AXIOM_CRC_NEW].vltusageconfig ? 0 : -EINVAL;
>+}
>+
>+static int axiom_verify_crcs(struct axiom_data *ts)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09struct axiom_crc *cur, *new;
>+
>+=09cur =3D &ts->crc[AXIOM_CRC_CUR];
>+=09new =3D &ts->crc[AXIOM_CRC_NEW];
>+
>+=09if (new->vltusageconfig !=3D cur->vltusageconfig) {
>+=09=09dev_err(dev, "VLTUSAGECONFIG CRC32 mismatch (dev:%#x !=3D fw:%#x)\n=
",
>+=09=09=09cur->vltusageconfig, new->vltusageconfig);
>+=09=09return -EINVAL;
>+=09} else if (new->nvltlusageconfig !=3D cur->nvltlusageconfig) {
>+=09=09dev_err(dev, "NVLTUSAGECONFIG CRC32 mismatch (dev:%#x !=3D fw:%#x)\=
n",
>+=09=09=09cur->nvltlusageconfig, new->nvltlusageconfig);
>+=09=09return -EINVAL;
>+=09} else if (!axiom_usage_crc_match(ts, AXIOM_U22, cur, new, u22_sequenc=
edata)) {
>+=09=09dev_err(dev, "U22_SEQUENCEDATA CRC32 mismatch (dev:%#x !=3D fw:%#x)=
\n",
>+=09=09=09cur->u22_sequencedata, new->u22_sequencedata);
>+=09=09return -EINVAL;
>+=09} else if (!axiom_usage_crc_match(ts, AXIOM_U43, cur, new, u43_hotspot=
s)) {
>+=09=09dev_err(dev, "U43_HOTSPOTS CRC32 mismatch (dev:%#x !=3D fw:%#x)\n",
>+=09=09=09cur->u43_hotspots, new->u43_hotspots);
>+=09=09return -EINVAL;
>+=09} else if (!axiom_usage_crc_match(ts, AXIOM_U93, cur, new, u93_profile=
s)) {
>+=09=09dev_err(dev, "U93_PROFILES CRC32 mismatch (dev:%#x !=3D fw:%#x)\n",
>+=09=09=09cur->u93_profiles, new->u93_profiles);
>+=09=09return -EINVAL;
>+=09} else if (!axiom_usage_crc_match(ts, AXIOM_U94, cur, new, u94_deltasc=
alemap)) {
>+=09=09dev_err(dev, "U94_DELTASCALEMAP CRC32 mismatch (dev:%#x !=3D fw:%#x=
)\n",
>+=09=09=09cur->u94_deltascalemap, new->u94_deltascalemap);
>+=09=09return -EINVAL;
>+=09}
>+
>+=09return 0;
>+}
>+
>+static enum fw_upload_err
>+axiom_cfg_fw_write(struct fw_upload *fw_upload, const u8 *data, u32 offse=
t,
>+=09=09   u32 size, u32 *written)
>+{
>+=09struct axiom_data *ts =3D fw_upload->dd_handle;
>+=09struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_CFG];
>+=09struct device *dev =3D ts->dev;
>+=09bool cancel;
>+=09int ret;
>+
>+=09/* Done before cancel check due to cleanup based put */
>+=09ret =3D pm_runtime_resume_and_get(ts->dev);
>+=09if (ret)
>+=09=09return FW_UPLOAD_ERR_HW_ERROR;
>+
>+=09mutex_lock(&afw->lock);
>+=09cancel =3D afw->cancel;
>+=09mutex_unlock(&afw->lock);
>+
>+=09if (cancel)
>+=09=09return FW_UPLOAD_ERR_CANCELED;
>+
>+=09axiom_lock_input_device(ts);
>+
>+=09if (ts->input && input_device_enabled(ts->input)) {
>+=09=09dev_err(dev, "Input device not idle, abort TH2CFG update\n");
>+=09=09axiom_unlock_input_device(ts);
>+=09=09return FW_UPLOAD_ERR_HW_ERROR;
>+=09}
>+
>+=09ret =3D axiom_u02_stop(ts);
>+=09if (ret)
>+=09=09goto err_swreset;
>+
>+=09ret =3D axiom_zero_volatile_mem(ts);
>+=09if (ret)
>+=09=09goto err_swreset;
>+
>+=09/* Skip to the first fw chunk */
>+=09data +=3D sizeof(struct axiom_fw_cfg_hdr);
>+=09size -=3D sizeof(struct axiom_fw_cfg_hdr);
>+=09*written +=3D sizeof(struct axiom_fw_cfg_hdr);
>+
>+=09axiom_set_runmode(ts, AXIOM_TCP_CFG_UPDATE_MODE);
>+
>+=09while (size) {
>+=09=09struct axiom_fw_cfg_chunk chunk;
>+=09=09unsigned int chunk_len;
>+
>+=09=09chunk_len =3D axiom_cfg_fw_prepare_chunk(&chunk, data);
>+=09=09if (axiom_skip_cfg_chunk(ts, &chunk)) {
>+=09=09=09dev_dbg(dev, "Skip TH2CFG usage u%02X\n", chunk.usage_num);
>+=09=09=09goto next_chunk;
>+=09=09}
>+
>+=09=09ret =3D axiom_write_cfg_chunk(ts, &chunk);
>+=09=09if (ret) {
>+=09=09=09axiom_set_runmode(ts, AXIOM_TCP_MODE);
>+=09=09=09goto err_swreset;
>+=09=09}
>+
>+next_chunk:
>+=09=09data +=3D chunk_len;
>+=09=09size -=3D chunk_len;
>+=09=09*written +=3D chunk_len;
>+=09}
>+
>+=09axiom_set_runmode(ts, AXIOM_TCP_MODE);
>+
>+=09/* Ensure that the chunks are written correctly */
>+=09ret =3D axiom_verify_volatile_mem(ts);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to verify written config, abort\n");
>+=09=09goto err_swreset;
>+=09}
>+
>+=09ret =3D axiom_u02_save_config(ts);
>+=09if (ret)
>+=09=09goto err_swreset;
>+
>+=09/*
>+=09 * TODO: Check if u02 start would be sufficient to load the new config
>+=09 * values
>+=09 */

It is not necessarily needed.

>+=09ret =3D axiom_u02_swreset(ts);
>+=09if (ret) {
>+=09=09dev_err(dev, "Soft reset failed\n");
>+=09=09goto err_unlock;
>+=09}
>+
>+=09ret =3D axiom_u33_read(ts, &ts->crc[AXIOM_CRC_CUR]);
>+=09if (ret)
>+=09=09goto err_unlock;
>+
>+=09if (axiom_verify_crcs(ts))
>+=09=09goto err_unlock;
>+
>+=09/* Unlock before the input device gets unregistered */
>+=09axiom_unlock_input_device(ts);
>+
>+=09ret =3D axiom_update_input_dev(ts);
>+=09if (ret) {
>+=09=09dev_err(dev, "Input device update failed after TH2CFG firmware upda=
te\n");
>+=09=09goto err_out;
>+=09}
>+
>+=09dev_info(dev, "TH2CFG update successful\n");
>+
>+=09return FW_UPLOAD_ERR_NONE;
>+
>+err_swreset:
>+=09axiom_u02_swreset(ts);
>+err_unlock:
>+=09axiom_unlock_input_device(ts);
>+err_out:
>+=09return ret =3D=3D -ETIMEDOUT ? FW_UPLOAD_ERR_TIMEOUT : FW_UPLOAD_ERR_H=
W_ERROR;
>+}
>+
>+static void axiom_cfg_fw_cancel(struct fw_upload *fw_upload)
>+{
>+=09struct axiom_data *ts =3D fw_upload->dd_handle;
>+=09struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_CFG];
>+
>+=09mutex_lock(&afw->lock);
>+=09afw->cancel =3D true;
>+=09mutex_unlock(&afw->lock);
>+}
>+
>+static void axiom_cfg_fw_cleanup(struct fw_upload *fw_upload)
>+{
>+=09struct axiom_data *ts =3D fw_upload->dd_handle;
>+
>+=09mutex_unlock(&ts->fwupdate_lock);
>+=09pm_runtime_mark_last_busy(ts->dev);
>+=09pm_runtime_put_sync_autosuspend(ts->dev);
>+}
>+
>+static const struct fw_upload_ops axiom_cfg_fw_upload_ops =3D {
>+=09.prepare =3D axiom_cfg_fw_prepare,
>+=09.write =3D axiom_cfg_fw_write,
>+=09.poll_complete =3D axiom_fw_poll_complete,
>+=09.cancel =3D axiom_cfg_fw_cancel,
>+=09.cleanup =3D axiom_cfg_fw_cleanup,
>+};
>+
>+static void axiom_remove_axfw_fwl_action(void *data)
>+{
>+=09struct axiom_data *ts =3D data;
>+
>+=09firmware_upload_unregister(ts->fw[AXIOM_FW_AXFW].fwl);
>+}
>+
>+static void axiom_remove_cfg_fwl_action(void *data)
>+{
>+=09struct axiom_data *ts =3D data;
>+
>+=09firmware_upload_unregister(ts->fw[AXIOM_FW_CFG].fwl);
>+}
>+
>+static int axiom_register_fwl(struct axiom_data *ts)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09struct fw_upload *fwl;
>+=09char *fw_name;
>+=09int ret;
>+
>+=09if (!IS_ENABLED(CONFIG_FW_UPLOAD)) {
>+=09=09dev_dbg(dev, "axfw and th2cfgbin update disabled\n");
>+=09=09return 0;
>+=09}
>+
>+=09mutex_init(&ts->fw[AXIOM_FW_AXFW].lock);
>+=09fw_name =3D kasprintf(GFP_KERNEL, "i2c:%s.axfw", dev_name(dev));
>+=09fwl =3D firmware_upload_register(THIS_MODULE, ts->dev, fw_name,
>+=09=09=09=09       &axiom_axfw_fw_upload_ops, ts);
>+=09kfree(fw_name);
>+=09if (IS_ERR(fwl))
>+=09=09return dev_err_probe(dev, PTR_ERR(fwl),
>+=09=09=09=09     "Failed to register firmware upload\n");
>+
>+=09ret =3D devm_add_action_or_reset(dev, axiom_remove_axfw_fwl_action, ts=
);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09ts->fw[AXIOM_FW_AXFW].fwl =3D fwl;
>+
>+=09mutex_init(&ts->fw[AXIOM_FW_CFG].lock);
>+=09fw_name =3D kasprintf(GFP_KERNEL, "i2c:%s.th2cfgbin", dev_name(dev));
>+=09fwl =3D firmware_upload_register(THIS_MODULE, ts->dev, fw_name,
>+=09=09=09=09       &axiom_cfg_fw_upload_ops, ts);
>+=09kfree(fw_name);
>+=09if (IS_ERR(fwl))
>+=09=09return dev_err_probe(dev, PTR_ERR(fwl),
>+=09=09=09=09     "Failed to register cfg firmware upload\n");
>+
>+=09ret =3D devm_add_action_or_reset(dev, axiom_remove_cfg_fwl_action, ts)=
;
>+=09if (ret)
>+=09=09return ret;
>+
>+=09ts->fw[AXIOM_FW_CFG].fwl =3D fwl;
>+
>+=09return 0;
>+}
>+
>+/************************* Device handlig *******************************=
******/
>+
>+#define AXIOM_SIMPLE_FW_DEVICE_ATTR(attr)=09=09=09=09=09\
>+=09static ssize_t=09=09=09=09=09=09=09=09\
>+=09fw_ ## attr ## _show(struct device *dev,=09=09=09=09\
>+=09=09=09     struct device_attribute *_attr, char *buf)=09=09\
>+=09{=09=09=09=09=09=09=09=09=09\
>+=09=09struct i2c_client *i2c =3D to_i2c_client(dev);=09=09=09\
>+=09=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);=09=09\
>+=09=09=09=09=09=09=09=09=09=09\
>+=09=09return sysfs_emit(buf, "%u\n", ts->fw_##attr);=09=09=09\
>+=09}=09=09=09=09=09=09=09=09=09\
>+=09static DEVICE_ATTR_RO(fw_##attr)
>+
>+AXIOM_SIMPLE_FW_DEVICE_ATTR(major);
>+AXIOM_SIMPLE_FW_DEVICE_ATTR(minor);
>+AXIOM_SIMPLE_FW_DEVICE_ATTR(rc);
>+
>+static ssize_t fw_status_show(struct device *dev,
>+=09=09=09      struct device_attribute *attr, char *buf)
>+{
>+=09struct i2c_client *i2c =3D to_i2c_client(dev);
>+=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);
>+=09const char *val;
>+
>+=09if (ts->fw_status)
>+=09=09val =3D "production";
>+=09else
>+=09=09val =3D "engineering";
>+
>+=09return sysfs_emit(buf, "%s\n", val);
>+}
>+static DEVICE_ATTR_RO(fw_status);
>+
>+static ssize_t fw_variant_show(struct device *dev,
>+=09=09=09       struct device_attribute *attr, char *buf)
>+{
>+=09struct i2c_client *i2c =3D to_i2c_client(dev);
>+=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);
>+=09const char *val;
>+
>+=09switch (ts->fw_variant) {
>+=09case 0:
>+=09=09val =3D "3d";
>+=09=09break;
>+=09case 1:
>+=09=09val =3D "2d";
>+=09=09break;
>+=09case 3:
>+=09=09val =3D "force";
>+=09=09break;
>+=09default:
>+=09=09val =3D "unknown";
>+=09=09break;
>+=09}

The following are all the variants we currently support in order:
FW_VARIANTS =3D ["3D", "2D", "FORCE", "0D", "XL"]

>+
>+=09return sysfs_emit(buf, "%s\n", val);
>+}
>+static DEVICE_ATTR_RO(fw_variant);
>+
>+static ssize_t device_id_show(struct device *dev,
>+=09=09=09      struct device_attribute *attr, char *buf)
>+{
>+=09struct i2c_client *i2c =3D to_i2c_client(dev);
>+=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);
>+
>+=09return sysfs_emit(buf, "%u\n", ts->device_id);
>+}
>+static DEVICE_ATTR_RO(device_id);
>+
>+static ssize_t device_state_show(struct device *dev,
>+=09=09=09=09 struct device_attribute *attr, char *buf)
>+{
>+=09struct i2c_client *i2c =3D to_i2c_client(dev);
>+=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);
>+
>+=09return sysfs_emit(buf, "%s\n", axiom_runmode_to_string(ts));
>+}
>+static DEVICE_ATTR_RO(device_state);
>+
>+static struct attribute *axiom_attrs[] =3D {
>+=09&dev_attr_fw_major.attr,
>+=09&dev_attr_fw_minor.attr,
>+=09&dev_attr_fw_rc.attr,
>+=09&dev_attr_fw_status.attr,
>+=09&dev_attr_fw_variant.attr,
>+=09&dev_attr_device_id.attr,
>+=09&dev_attr_device_state.attr,
>+=09NULL
>+};
>+ATTRIBUTE_GROUPS(axiom);
>+
>+static void axiom_poll(struct input_dev *input)
>+{
>+=09struct axiom_data *ts =3D input_get_drvdata(input);
>+
>+=09axiom_process_report(ts, AXIOM_U34, NULL, 0);
>+}
>+
>+static irqreturn_t axiom_irq(int irq, void *dev_id)
>+{
>+=09struct axiom_data *ts =3D dev_id;
>+
>+=09axiom_process_report(ts, AXIOM_U34, NULL, 0);
>+
>+=09return IRQ_HANDLED;
>+}
>+
>+static int axiom_input_open(struct input_dev *dev)
>+{
>+=09struct axiom_data *ts =3D input_get_drvdata(dev);
>+
>+=09return pm_runtime_resume_and_get(ts->dev);
>+}
>+
>+static void axiom_input_close(struct input_dev *dev)
>+{
>+=09struct axiom_data *ts =3D input_get_drvdata(dev);
>+
>+=09pm_runtime_mark_last_busy(ts->dev);
>+=09pm_runtime_put_sync_autosuspend(ts->dev);
>+}
>+
>+static int axiom_register_input_dev(struct axiom_data *ts,
>+=09=09=09=09    bool update_in_process)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09struct i2c_client *client =3D to_i2c_client(dev);
>+=09struct input_dev *input;
>+=09int ret;
>+
>+=09input =3D input_allocate_device();
>+=09if (!input) {
>+=09=09dev_err(dev, "Failed to allocate input driver data\n");
>+=09=09return -ENOMEM;
>+=09}
>+
>+=09input->dev.parent =3D dev;
>+=09input->name =3D "TouchNetix aXiom Touchscreen";
>+=09input->id.bustype =3D BUS_I2C;
>+=09input->id.vendor =3D ts->jedec_id;
>+=09input->id.product =3D ts->device_id;
>+=09input->id.version =3D ts->silicon_rev;
>+
>+=09/* Either follow the panel or the open user count, not both */
>+=09if (!ts->is_panel_follower) {
>+=09=09input->open =3D axiom_input_open;
>+=09=09input->close =3D axiom_input_close;
>+=09}
>+
>+=09axiom_u64_cds_enabled(ts);
>+=09input_set_abs_params(input, ABS_MT_POSITION_X, 0, AXIOM_MAX_XY - 1, 0,=
 0);
>+=09input_set_abs_params(input, ABS_MT_POSITION_Y, 0, AXIOM_MAX_XY - 1, 0,=
 0);
>+=09input_set_abs_params(input, ABS_MT_DISTANCE, 0, 127, 0, 0);
>+=09if (ts->cds_enabled)
>+=09=09input_set_abs_params(input, ABS_MT_PRESSURE, 0, 127, 0, 0);
>+
>+=09touchscreen_parse_properties(input, true, &ts->prop);
>+
>+=09axiom_u42_get_touchslots(ts);
>+=09if (!ts->num_slots && update_in_process) {
>+=09=09input_free_device(input);
>+=09=09/*
>+=09=09 * Skip input device registration but don't throw an error to
>+=09=09 * not abort the update since some FW updates require a
>+=09=09 * following CFG update to re-initialize the touchslot handling.
>+=09=09 */
>+=09=09if (update_in_process) {
>+=09=09=09dev_info(dev, "No touchslots found after FW or CFG update, skip =
registering input device\n");
>+=09=09=09return 0;
>+=09=09}
>+
>+=09=09dev_err(dev, "Error firmware has no touchslots enabled\n");
>+=09=09return -EINVAL;
>+=09}
>+
>+=09ret =3D input_mt_init_slots(input, ts->num_slots, INPUT_MT_DIRECT);
>+=09if (ret) {
>+=09=09input_free_device(input);
>+=09=09dev_err(dev, "Failed to init mt slots\n");
>+=09=09return ret;
>+=09}
>+
>+=09/*
>+=09 * Ensure that the IRQ setup is done only once since the handler belon=
g
>+=09 * to the i2c-dev whereas the input-poller belong to the input-dev. Th=
e
>+=09 * input-dev can get unregistered during a firmware update to reflect
>+=09 * the new firmware state. Therefore the input-poller setup must be do=
ne
>+=09 * always.
>+=09 */
>+=09if (!ts->irq_setup_done && client->irq) {
>+=09=09ret =3D devm_request_threaded_irq(dev, client->irq, NULL, axiom_irq=
,
>+=09=09=09=09=09=09IRQF_ONESHOT, dev_name(dev), ts);
>+=09=09if (ret) {
>+=09=09=09dev_err(dev, "Failed to request IRQ\n");
>+=09=09=09return ret;
>+=09=09}
>+=09=09ts->irq_setup_done =3D true;
>+=09} else {
>+=09=09ret =3D input_setup_polling(input, axiom_poll);
>+=09=09if (ret) {
>+=09=09=09input_free_device(input);
>+=09=09=09dev_err(dev, "Setup polling mode failed\n");
>+=09=09=09return ret;
>+=09=09}
>+
>+=09=09input_set_poll_interval(input, ts->poll_interval);
>+=09}
>+
>+=09input_set_drvdata(input, ts);
>+=09ts->input =3D input;
>+
>+=09ret =3D input_register_device(input);
>+=09if (ret) {
>+=09=09input_free_device(input);
>+=09=09ts->input =3D NULL;
>+=09=09dev_err(dev, "Failed to register input device\n");
>+=09};
>+
>+=09return ret;
>+}
>+
>+static int axiom_update_input_dev(struct axiom_data *ts)
>+{
>+=09axiom_unregister_input_dev(ts);
>+
>+=09return axiom_register_input_dev(ts, true);
>+}
>+
>+static int axiom_parse_firmware(struct axiom_data *ts)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09struct gpio_desc *gpio;
>+=09int ret;
>+
>+=09ts->supplies[0].supply =3D "vddi";
>+=09ts->supplies[1].supply =3D "vdda";
>+=09ts->num_supplies =3D ARRAY_SIZE(ts->supplies);
>+
>+=09ret =3D devm_regulator_bulk_get(dev, ts->num_supplies, ts->supplies);
>+=09if (ret)
>+=09=09return dev_err_probe(dev, ret,
>+=09=09=09=09     "Failed to get power supplies\n");
>+
>+=09gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>+=09if (IS_ERR(gpio))
>+=09=09return dev_err_probe(dev, PTR_ERR(gpio),
>+=09=09=09=09     "Failed to get reset GPIO\n");
>+=09ts->reset_gpio =3D gpio;
>+
>+=09ts->poll_interval =3D AXIOM_DEFAULT_POLL_INTERVAL_MS;
>+=09device_property_read_u32(dev, "poll-interval", &ts->poll_interval);
>+
>+=09return 0;
>+}
>+
>+static int axiom_power_device(struct axiom_data *ts, unsigned int enable)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09int ret;
>+
>+=09if (!enable) {
>+=09=09regulator_bulk_disable(ts->num_supplies, ts->supplies);
>+=09=09return 0;
>+=09}
>+
>+=09ret =3D regulator_bulk_enable(ts->num_supplies, ts->supplies);
>+=09if (ret) {
>+=09=09dev_err(dev, "Failed to enable power supplies\n");
>+=09=09return ret;
>+=09}
>+
>+=09gpiod_set_value_cansleep(ts->reset_gpio, 1);
>+=09fsleep(2000);
>+=09gpiod_set_value_cansleep(ts->reset_gpio, 0);
>+
>+=09fsleep(AXIOM_STARTUP_TIME_MS);
>+
>+=09return 0;
>+}
>+
>+static int axiom_panel_prepared(struct drm_panel_follower *follower)
>+{
>+=09struct axiom_data *ts =3D container_of(follower, struct axiom_data,
>+=09=09=09=09=09     panel_follower);
>+
>+=09return pm_runtime_resume_and_get(ts->dev);
>+}
>+
>+static int axiom_panel_unpreparing(struct drm_panel_follower *follower)
>+{
>+=09struct axiom_data *ts =3D container_of(follower, struct axiom_data,
>+=09=09=09=09=09     panel_follower);
>+
>+=09return pm_runtime_put_sync_suspend(ts->dev);
>+}
>+
>+static const struct drm_panel_follower_funcs axiom_panel_follower_funcs =
=3D {
>+=09.panel_prepared =3D axiom_panel_prepared,
>+=09.panel_unpreparing =3D axiom_panel_unpreparing,
>+};
>+
>+static int axiom_register_panel_follower(struct axiom_data *ts)
>+{
>+=09struct device *dev =3D ts->dev;
>+
>+=09if (!drm_is_panel_follower(dev))
>+=09=09return 0;
>+
>+=09if (device_can_wakeup(dev)) {
>+=09=09dev_warn(dev, "Can't follow panel if marked as wakup device\n");
>+=09=09return 0;
>+=09}
>+
>+=09ts->panel_follower.funcs =3D &axiom_panel_follower_funcs;
>+=09ts->is_panel_follower =3D true;
>+
>+=09return devm_drm_panel_add_follower(dev, &ts->panel_follower);
>+}
>+
>+static int axiom_i2c_probe(struct i2c_client *client)
>+{
>+=09struct device *dev =3D &client->dev;
>+=09struct axiom_data *ts;
>+=09int ret;
>+
>+=09ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
>+=09if (!ts)
>+=09=09return dev_err_probe(dev, -ENOMEM,
>+=09=09=09=09     "Failed to allocate driver data\n");
>+
>+=09ts->regmap =3D devm_regmap_init_i2c(client, &axiom_i2c_regmap_config);
>+=09if (IS_ERR(ts->regmap))
>+=09=09return dev_err_probe(dev, PTR_ERR(ts->regmap),
>+=09=09=09=09     "Failed to initialize regmap\n");
>+
>+=09i2c_set_clientdata(client, ts);
>+=09ts->dev =3D dev;
>+
>+=09init_completion(&ts->boot_complete.completion);
>+=09init_completion(&ts->nvm_write.completion);
>+=09mutex_init(&ts->fwupdate_lock);
>+
>+=09ret =3D axiom_register_fwl(ts);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09ret =3D axiom_parse_firmware(ts);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09ret =3D axiom_power_device(ts, 1);
>+=09if (ret)
>+=09=09return dev_err_probe(dev, ret, "Failed to power-on device\n");
>+
>+=09pm_runtime_set_autosuspend_delay(dev, 10 * MSEC_PER_SEC);
>+=09pm_runtime_use_autosuspend(dev);
>+=09pm_runtime_set_active(dev);
>+=09pm_runtime_get_noresume(dev);
>+=09ret =3D devm_pm_runtime_enable(dev);
>+=09if (ret)
>+=09=09return dev_err_probe(dev, ret, "Failed to enable pm-runtime\n");
>+
>+=09ret =3D axiom_register_panel_follower(ts);
>+=09if (ret)
>+=09=09return dev_err_probe(dev, ret, "Failed to register panel follower\n=
");
>+
>+=09ret =3D axiom_u31_device_discover(ts);
>+=09/*
>+=09 * Register the device to allow FW updates in case that the current FW
>+=09 * doesn't support the required driver usages or if the device is in
>+=09 * bootloader mode.
>+=09 */
>+=09if (ret && ret =3D=3D -EACCES && IS_ENABLED(CONFIG_FW_UPLOAD)) {
>+=09=09dev_warn(dev, "Device discovery failed, wait for user fw update\n")=
;
>+=09=09pm_runtime_mark_last_busy(dev);
>+=09=09pm_runtime_put_sync_autosuspend(dev);
>+=09=09return 0;
>+=09} else if (ret) {
>+=09=09pm_runtime_put_sync(dev);
>+=09=09return dev_err_probe(dev, ret, "Device discovery failed\n");
>+=09}
>+
>+=09ret =3D axiom_register_input_dev(ts, false);
>+=09pm_runtime_mark_last_busy(dev);
>+=09pm_runtime_put_sync_autosuspend(dev);
>+=09if (ret && IS_ENABLED(CONFIG_FW_UPLOAD))
>+=09=09dev_warn(dev, "Failed to register the input device, wait for user f=
w update\n");
>+=09else if (ret)
>+=09=09return dev_err_probe(dev, ret, "Failed to register input device\n")=
;
>+
>+=09return 0;
>+}
>+
>+static void axiom_i2c_remove(struct i2c_client *client)
>+{
>+=09struct axiom_data *ts =3D i2c_get_clientdata(client);
>+
>+=09axiom_unregister_input_dev(ts);
>+}
>+
>+static int axiom_runtime_suspend(struct device *dev)
>+{
>+=09struct axiom_data *ts =3D dev_get_drvdata(dev);
>+=09struct i2c_client *client =3D to_i2c_client(dev);
>+
>+=09if (client->irq && ts->irq_setup_done)
>+=09=09disable_irq(client->irq);
>+
>+=09return axiom_power_device(ts, 0);
>+}
>+
>+static int axiom_runtime_resume(struct device *dev)
>+{
>+=09struct axiom_data *ts =3D dev_get_drvdata(dev);
>+=09struct i2c_client *client =3D to_i2c_client(dev);
>+=09int ret;
>+
>+=09ret =3D axiom_power_device(ts, 1);
>+=09if (ret)
>+=09=09return ret;
>+
>+=09if (client->irq && ts->irq_setup_done)
>+=09=09enable_irq(client->irq);
>+
>+=09return 0;
>+}
>+
>+static DEFINE_RUNTIME_DEV_PM_OPS(axiom_pm_ops, axiom_runtime_suspend,
>+=09=09=09=09 axiom_runtime_resume, NULL);
>+
>+static const struct i2c_device_id axiom_i2c_id_table[] =3D {
>+=09{ "ax54a" },
>+=09{ },
>+};
>+MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
>+
>+static const struct of_device_id axiom_of_match[] =3D {
>+=09{ .compatible =3D "touchnetix,ax54a", },
>+=09{ }
>+};
>+MODULE_DEVICE_TABLE(of, axiom_of_match);
>+
>+static struct i2c_driver axiom_i2c_driver =3D {
>+=09.driver =3D {
>+=09=09   .name =3D KBUILD_MODNAME,
>+=09=09   .dev_groups =3D axiom_groups,
>+=09=09   .pm =3D pm_ptr(&axiom_pm_ops),
>+=09=09   .of_match_table =3D axiom_of_match,
>+=09},
>+=09.id_table =3D axiom_i2c_id_table,
>+=09.probe =3D axiom_i2c_probe,
>+=09.remove =3D axiom_i2c_remove,
>+};
>+module_i2c_driver(axiom_i2c_driver);
>+
>+MODULE_DESCRIPTION("TouchNetix aXiom touchscreen I2C bus driver");
>+MODULE_LICENSE("GPL");
>
>--=20
>2.47.3
>

