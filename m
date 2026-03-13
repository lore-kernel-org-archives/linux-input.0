Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82C35BDA8
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422044; cv=none; b=OTFwAt7fX7312Em4aSjxiGxZznnmkEASf68lHWnqMcjRd8+pVXZTZAkiFHB2/dQxMyoftRmD0jEOS1vvR9X7xkBYyHiSuHByI9x8L1xJ/YJ1RuQx5/zm79lY3RN6mqXDR8k3iL1b96szDliNvVK3J4PNu8CkOaN2M1rcZohafg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422044; c=relaxed/simple;
	bh=Lo39Kw5SuT58RJSgUxlVy8iyavm87UqFbDcKrqeQRw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition; b=HtBfk2Q4ZlQZ0GlqwdtxfORXhiKa2cKaY+fumRWiSc10HtIEMPTQL+/nVCZz5yUbVA9qTT8hvWli89/KOXXILWfhKOqPOS9w1LWDulbqot+80KeSfJAqdqnIz/Z7QSDB/eSuJS72S/1qsbDU6k/w2X9haRXPVAOCy2XQJnQfzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022074.outbound.protection.outlook.com [52.101.96.74])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-196-tWMjkSvoOj-wBFuxmgA8BQ-1; Fri,
 13 Mar 2026 17:07:20 +0000
X-MC-Unique: tWMjkSvoOj-wBFuxmgA8BQ-1
X-Mimecast-MFC-AGG-ID: tWMjkSvoOj-wBFuxmgA8BQ_1773421639
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO8P123MB7704.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3d7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.15; Fri, 13 Mar 2026 17:07:07 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b%2]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 17:07:13 +0000
Date: Fri, 13 Mar 2026 17:07:16 +0000
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
Subject: Re: [PATCH v6 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <rnbwxsdiwjojk7354c6k4us6xxl3qpbyt2lrbhgqz77avrdwga@tqb6voucuysi>
In-Reply-To: <20260303-v6-10-topic-touchscreen-axiom-v6-4-8ac755add12b@pengutronix.de>
X-ClientProxiedBy: LO2P265CA0328.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::28) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LO8P123MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 93992942-1f29-4b81-245a-08de8122f8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|18002099003|56012099003|22082099003
X-Microsoft-Antispam-Message-Info: 0k8R05hujJl5qa1EGVHxhI+U/1OD5558kgqCXZxX636BKsgIZsMK+DXGQi56X9GoWeu5oTWTbRuy+Es0UYOpY82eLpf/cdVJBzeCEw6BcMIMeSkgJYHdlgNiRLQ442T5c9BaTjMmRYv7R9Dm3w0B8LQ0CWN+KSulSy4QS118wFdh40IqxlQW2acPiLoYLvSBC3q13goOVWJ6SKkibPte4SksTID3nEGRUzWCgymUByxUDpuVwBrAD1z5oZrRNnMV37LJqOUm3CoqaYS/kTAIz2/l+kQCk0cPncviEJlOT99ja09ITcvIEaeTvZdhIGCq82DgTFHdTJ1Fcj4tnC8RoEfP+R9qqjS1R/tUKSICvqj1ubUDjXauFHgshdbtL+OKwfqzkCvIAEaUa6yZqwFd+mhI10HXG5Wl5Whp2+D0RSpBG5HnsU7PIFxjfrwK1rybM0PuYtUALQQ8MQIGITFP/O3ksIUrJvJVkFUPyQT2k0sgDvLW+xDLldnwM0egM/2nmvcrCl46IinV7kOqH9gjE3sRVpsXJ8OeWi+UmsXYdsIur93J9d0/VtsQFVQNDLe7vYnjncRk2RZAIEOCzx1xg46PjU0y3LbqYG3qPRTc5LzcI3uM3uhZCGBBuuQffvRmtTyi7Lb4s7Ysw9YMwFRKtTa17Z/T0ZObA/ARK0CLP9Kk1wuAmrcVW+e+zHjjYGbjGK5mfa6UP/af1alh6St4etddo2cOgtiIF5k9IkjScyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmF3MHBzS0MwQTJFdG5BVXhUSk9qcUdRbElTK0JFcUVoejROaUFpamhKTFVB?=
 =?utf-8?B?c3M2N25Rdi93U0VmK1VoQzdkWWYyRFgreEFIeVQxVzArclFta2lIc0RLNzZs?=
 =?utf-8?B?ekNPdHlrbVdlNUUvNCtDYUw2ZDRqSWdMRWpEZUFZZVVoVzQreVBFdE05R3Ft?=
 =?utf-8?B?ZXJFTTRORzF0V2R5b1gzaEc4QkVLR2tocGtudmRUU3haRlFtK3gxOVJMUWs1?=
 =?utf-8?B?WkVaZC80eGVlbWYrelpCOTc2M3VBYmQrcTR6Ry9rc3lnQmtrUEMxVWdUWVFo?=
 =?utf-8?B?dENGQ0dVSUsxR0dHUFpVMmRGUjFLbmZqV0hyOW1NQm5HN0c4dms2ZDYxeXQy?=
 =?utf-8?B?dE5hOU50bzd2TWxZOUdvNHJOVk8zK0pCMTVTUlFEZ2RCanZGRVpQcnNYbXNP?=
 =?utf-8?B?REpiVjFER1ZvVW1Vd2VMUnF3a3NnOW1uM1dNVG9KY0tQZFFWNXlXSTZBd3dz?=
 =?utf-8?B?VlpHMzZhVURtY1VhV3hNS1pPcHdmSUwvcElaRTcralNrMlhRMllSUE0rWUlB?=
 =?utf-8?B?UVhIWDJoV3pXOVNVM05mYnlnaXVWUVZOQ0p0WFlWWnk0MFJTNHdNOFJHRXlB?=
 =?utf-8?B?VlFNU0lDYlFBSnZ4RDY3WnR1Skd2dDYvWmVrSkhhTEZPbFlDS1dYWlorblFa?=
 =?utf-8?B?eDMzK0pjUCtGc3RhQUhXM3NiR05WaHBYd3FSL1VoSW9IWFdYQk5xai8yVEJ4?=
 =?utf-8?B?ZXdXUmFiRjVBSkJUREVONVNXaHhZRVhpMUthR2Y0UVRsTTlyM3d4L3VIZzU1?=
 =?utf-8?B?bUxsMnlKa0owNS9mbExVUWZxV3pVK2w5eVRyNkp6NEhVVldreXh1WE8xclRK?=
 =?utf-8?B?NFpib3RGSjREMVQ0ME40NDF6dkFKYWd4N1E0SERsbWIxWXhPOFhkaE9MWFdJ?=
 =?utf-8?B?UmdVUmNpdGhlVldjQndOaHdiZUk5RTFFNVh2MmJPVE41cnN3VVFJNTFoMUZI?=
 =?utf-8?B?VitOb1lOZ3JIclVHV2MrRmVQbkRUUFU0aFRZdDI3eWZGc3JieldCVkYzTXZ6?=
 =?utf-8?B?My9IbFRsWWFraG1xWUxOQThYQVI4eE85emR0SnNlZ1hkUFBSVzFIMEtEaFR6?=
 =?utf-8?B?ZS94dFZYU3lpSklQMnp3NmtZSUdLa2syZ1E3SmVPODlWQmhSVGl0dHZsaGxo?=
 =?utf-8?B?cUc0c0o3UzY5S1Bldlc0RVgyemdGbE1BTXQ5QjdoeXZoVzNmMngxbnVZQ0FS?=
 =?utf-8?B?QTM3enE5ZlpJbzlrWmNuUnhtbnNrbEJ4YlV5ZURDZTdDUDFRN2IyYXRTRTNT?=
 =?utf-8?B?RjNFd0tPbFg2NFlmWEJNOXBKbU51VWJOUEpHWHU4a1dONzRTMjBEWWZNNTg4?=
 =?utf-8?B?SVBQeUNKajV6REFPT0orNDBzWk5DYVdTZjF0SEtodEVRRjd2d2VkRnB5UDJi?=
 =?utf-8?B?NlNlWEFMS0RRd2Q1enNRbVd1MGxqc1VuQ0l4cGxsUktRS0hScUt5djV2SG5m?=
 =?utf-8?B?ZS9OTmg5bjJvd3h5TDNRZlpzdDhKQ0hUbmF2VVNGZzRTMDAxN3RmaW5qaytF?=
 =?utf-8?B?K1VCRlN0MGQ4dzRLeXF3NFc0d2ZBckljcFFjV2ZXaHM4VlhacFhzRzhML05W?=
 =?utf-8?B?RG1CTkw1eDV1akNaZzE5eEozS2piZi80emIzUVVHcGdpZDArRW5VT0ltMFBF?=
 =?utf-8?B?WmNPemxJRXQwYnRSWXNYeFZiYkI1TUE3Y2J4cXV3NG9IVjY1NWxnUkFnYklt?=
 =?utf-8?B?QkNvUzdWVGlGNjMvZndBdTRvb3RRV2c2UVpqK1RRc1FjK0tIb0VxNCs2NG9h?=
 =?utf-8?B?dG1PRHZqRXNjazlqdHZ2NTY4WkU4T0NEaDhPNmUzR0hPaXVvSDJ6enIvUFk0?=
 =?utf-8?B?NEIxUFVBYjh4NzJTYTBqbHEyL0MvL2VIUjEvOG05MTZpZHJGUTlpbnJjYm5z?=
 =?utf-8?B?bGU4ZnVNVy9QZU1YY0ZHVzc2aG1OSEtUQUxYdEJOWWhoYnJ2c3VGNk15ZnRB?=
 =?utf-8?B?K29nbUFDa2FjZFpYcnlsZGtRdEx5Q1lpRnliT0VyQW1aeUVkcUlmdk5jdUU2?=
 =?utf-8?B?TFJPTmh1czdGbUs4eklXcXR6bmlsTkNoejdQbGNIMTBOeHZobVBTVTJJSzh0?=
 =?utf-8?B?YnNicEhHTUxQSTh5cXRVb0wxQWFtT2cwVlM0dG1GVktQQkZPZk9obXJJVlBs?=
 =?utf-8?B?cThhWnNsUkR4ZlVCdUkyb0taajhFV25FamQ1UXlydklhWlJiNmZwOFpFbkFG?=
 =?utf-8?B?NHlxY08rRGpUckVoS3NJckFiVjA3RWtjbnFQcTdwcWJrUk9yZk9FWWwrbkpz?=
 =?utf-8?B?TDlIUWdaelFkc3owTHVPL0VLZ0JjeFZyRTZ1RE83YzQ0ZzZ6UFhZNVZCajF1?=
 =?utf-8?B?VmJQKzlyTFBQVDF1QktENS91eE5sYm9yOHZRYkwweXFudUtBMHp0RXhoTS9S?=
 =?utf-8?Q?JHu7uHKuwCwmc3c8=3D?=
X-Exchange-RoutingPolicyChecked: GSFkg4reG1YATI2GkT/+3FZpsBiEbypdWLRK4Uzu/w77Ni4SIT7FGaqL2AtLOrO3uMz+xplNh1jdI/kz4XYCw+YE3EKQiGYuJlkePr/at/XaoZ7u5bloPa9o5xE8NRYW7YXDSATaBkq/8jl41G+434V4Giu2B5il5NZw3YQlndQyhFsuDkT4la39CTE/NwXFpU4zop7uQa3yC9CZJdyiUSPVc/G5jzcoqnQsjfuoRMYRDuoWZ5ETdP1ejt+hsZDaz9bpKR62GdvcxyekuKDRDPLAVWLLZxfnbm+/pOVRfRfw8zp4IhLu6MWJ9A5C5WHEawrk4RSR2BghwloJgqFWgQ==
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93992942-1f29-4b81-245a-08de8122f8ad
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 17:07:13.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lrn2fCzkYxvh2Pt+UrlWYzf75+RMQKTqiPMdrnGouEQsMJgbsePSnx3JLWlmWjtBMZqsVe9fwfygt7c8maNggW2ED0Mgf1lwH+atpPd8Hgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7704
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9VCJKAHdS4HxTWX0X9lERlEff5U83UN5TjHhYB4AGWo_1773421639
X-Mimecast-Originator: touchnetix.com
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 11:41:22PM +0100, Marco Felsch wrote:
>This adds the initial support for the TouchNetix AX54A touchcontroller
>which is part of TouchNetix's aXiom touchscreen controller family.
>
>The TouchNetix aXiom family provides two physical interfaces: SPI and
>I2C. This patch covers only the I2C interface.
>
>Apart the input event handling the driver supports firmware updates too.
>One firmware interface handles the touchcontroller firmware (AXFW)
>update the other handles the touchcontroller configuration (TH2CFGBIN)
>update.
>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>---
> .../testing/sysfs-driver-input-touchnetix-axiom    |   80 +
> drivers/input/touchscreen/Kconfig                  |   17 +
> drivers/input/touchscreen/Makefile                 |    1 +
> drivers/input/touchscreen/touchnetix_axiom.c       | 3084 +++++++++++++++=
+++++
> 4 files changed, 3182 insertions(+)
>
>diff --git a/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom=
 b/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom
>new file mode 100644
>index 0000000000000000000000000000000000000000..8262673630557bf1e595a97ec2=
3e66c1c5370f71
>--- /dev/null
>+++ b/Documentation/ABI/testing/sysfs-driver-input-touchnetix-axiom
>@@ -0,0 +1,80 @@
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
>+=09=09be either: "0d", "2d", "3d", "force", "xl" or "unknown".
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
>+=09=09bootloader: Device is in bootloader mode, used for firmware
>+=09=09=09    updates.
>+=09=09unknown: Device mode is unknown.
>+
>+=09=09Access: Read
>+
>+=09=09Valid values: Represented as string
>diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen=
/Kconfig
>index 196905162945d59e775c3e0bff6540a82842229a..9263dd79dab7e518e27af35364=
fcebbff0ba706e 100644
>--- a/drivers/input/touchscreen/Kconfig
>+++ b/drivers/input/touchscreen/Kconfig
>@@ -806,6 +806,23 @@ config TOUCHSCREEN_MIGOR
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
>index 97a025c6a3770fb80255246eb63c11688ebd79eb..0591cb304784699bf2a8bda204=
461ac5f4532bb1 100644
>--- a/drivers/input/touchscreen/Makefile
>+++ b/drivers/input/touchscreen/Makefile
>@@ -88,6 +88,7 @@ obj-$(CONFIG_TOUCHSCREEN_SUR40)=09=09+=3D sur40.o
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
>index 0000000000000000000000000000000000000000..d909b108ee24dfc5a56b0ba735=
cb8a7882612d34
>--- /dev/null
>+++ b/drivers/input/touchscreen/touchnetix_axiom.c
>@@ -0,0 +1,3084 @@
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

...

>+static int axiom_u02_enter_bootloader(struct axiom_data *ts)
>+{
>+=09struct axiom_u02_rev1_system_manager_msg msg =3D { };
>+=09struct device *dev =3D ts->dev;
>+=09unsigned int val;
>+=09int error;
>+
>+=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>+=09=09return -EINVAL;
>+
>+=09/*
>+=09 * Enter the bootloader mode requires 3 consecutive messages so we can=
't
>+=09 * check for the response.
>+=09 * TODO: Check if it's required to add a delay between the consecutive
>+=09 * CMD_ENTERBOOTLOADER cmds.
>+=09 */
>+=09msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_ENTERBOOTLOADER);
>+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER=
_KEY1);
>+=09error =3D axiom_u02_send_msg(ts, &msg, false);

As mentioned before the delay between commands is too short and the next co=
mmand is sent
before u02 is ready, which means the driver fails to put axiom into the boo=
tloader.
Have you tested with an i2c speed of 400KHz?
All you need is to put true in above to wait for the bootloader command.
error =3D axiom_u02_send_msg(ts, &msg, true);

Just dont do it for the last command.

I am not too sure why you are having issues with this, this is how we do it=
 for all our devices.

>+=09if (error) {
>+=09=09dev_err(dev, "Failed to send bootloader-key1: %d\n", error);
>+=09=09return error;
>+=09}
>+
>+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER=
_KEY2);
>+=09error =3D axiom_u02_send_msg(ts, &msg, false);

Here also.

>+=09if (error) {
>+=09=09dev_err(dev, "Failed to send bootloader-key2: %d\n", error);
>+=09=09return error;
>+=09}
>+
>+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER=
_KEY3);
>+=09error =3D axiom_u02_send_msg(ts, &msg, false);
>+=09if (error) {
>+=09=09dev_err(dev, "Failed to send bootloader-key3: %d\n", error);
>+=09=09return error;
>+=09}
>+
>+=09/* Sleep before the first read to give the device time */
>+=09fsleep(250 * USEC_PER_MSEC);
>+
>+=09/* Wait till the device reports it is in bootloader mode */
>+=09error =3D regmap_read_poll_timeout(ts->regmap,
>+=09=09=09=09=09 AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, val,
>+=09=09=09=09=09 FIELD_GET(AXIOM_U31_REV1_MODE_MASK, val) =3D=3D
>+=09=09=09=09=09=09AXIOM_U31_REV1_MODE_BLP,
>+=09=09=09=09=09 250 * USEC_PER_MSEC, USEC_PER_SEC);
>+=09if (error)
>+=09=09return error;
>+
>+=09return 0;
>+}
>+

...


Other than the above comments I have no issues with the driver.
We can support more usages in a later patch.

Many Thanks,
Andrew

