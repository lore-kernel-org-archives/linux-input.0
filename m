Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D5381B1A
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239274; cv=none; b=LMQ1PNisb+eX929NhSS35hG/MmVCKUqsqFr39AclydJdKfhTz1ai0PuZpcNQdi5fP+ENS9qDXduAL1xGLGGDgMfMF1cqoqKuvKhgdYqpCuOgLs+MZGjUpdf7VXOFSCL77aoizUxUJJ/zRnTfEd9bwXJgbKLtr8fiaZ/s4M5RIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239274; c=relaxed/simple;
	bh=BZAXICoL53M4XMSKK6JlyVV/FBSzTdq+p9nCVZjGLUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type:Content-Disposition; b=qqRQ0qm8+jvTgQR/XFDvnglEALa58cX5JmiJwVFeQ1BnOdOOomEiR6qenUUdGO8ajG53NlQBv+EGYE5BLxx7WD7tB36t3gnjH7PA2VOLCFh2Rf8F6YNNtTHN7MJtgUR9i7EEUcWvbQhN5/A6jUfnFHH/fk+O037ZIs8evB6YbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021124.outbound.protection.outlook.com [52.101.95.124])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-122-9EhnY2_FPHmCgp3XASCnVw-1; Thu,
 20 Aug 2026 16:14:12 +0100
X-MC-Unique: 9EhnY2_FPHmCgp3XASCnVw-1
X-Mimecast-MFC-AGG-ID: 9EhnY2_FPHmCgp3XASCnVw_1787238851
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO9P123MB7653.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3b9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.9; Thu, 20 Aug 2026 15:14:09 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b%2]) with mapi id 15.21.0315.014; Thu, 20 Aug 2026
 15:14:09 +0000
Date: Thu, 20 Aug 2026 16:14:04 +0100
From: Andrew Thomas <andrew.thomas@touchnetix.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Marco Felsch <kernel@pengutronix.de>, 
	Henrik Rydberg <rydberg@bitmath.org>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: Re: [PATCH v7 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <cf3nlougoxwlenjacl3ij2d5d5iqeqdd2whcrnnpr67qlzg6xj@p6c3bebapu7s>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>
X-ClientProxiedBy: LO4P123CA0451.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::6) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LO9P123MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: c98bc5fd-fc18-4f60-3e9d-08defecdaf00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|5023799004|4143699003|3023799007|10067099003|18002099003|22082099003|6133799003
X-Microsoft-Antispam-Message-Info: RjZmgXljIjpZr36VkYkVYfhfTohvh+e7Z9IoDMSp7WmZ/0od5Spa9xioX78zkNuW1waLl77iq3JPBKMLSGyc/3SaIw0ZTTXa/E0M6ZOgDOOClIDZocmuDUzQx1SfoG/xHEGFU85G2sPtgGM/2uOe4SBPyJaMjmtbvywGw5SDR0mXOZKn/PHZHK2XVZ4DanGd2GaTxGttUsvVi4w2MUU96Ssg1Qwj7EO/A7/cv5Hn6iItfRM8QN2U1eiDe8azNz0Bzao1yToDXt5ksqKdywK4dduJONXlK141IAm745VQEO0Jvxzy/thbTvsF12LT9YDhzAFbK2bJ8FZ/smv87u0X/3LkicdHaQsl8vJC93UHNEP1houpm2dyBzBsIhVjS/fKyaue9l5eE+aitku8G2kIZDXFD0IqF0d6/IYyt0Ig1fvw3Hf1f05+M0gjnD9zXvmhIcp7q5UWoF6ttJcaeQwI96zjyQzF9M8EMKhD2vmDJxf0XHYcRfmu30WsNDFMndN5mFdDSyGd0eZNwUmOMLb7FtBu/cLM92LlKTLLcN1yHEsLGbdxFiUZ7f7gLZYdHXfOFTaAktddFPkg9To3SSsRDrk+kKtVkROI9OXZz2U+10iKBdwQ3GNEv9msKGnrgGKqBNtyUq5jNBjj/knLu7xv+lPQQF3O6V2dtOgYBa/+LLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(5023799004)(4143699003)(3023799007)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtYRHQxeEwrYTRvVC85U0tnMnBkYk1Zakxpb2hWajQzVytwNGx3OTd4SFJ3?=
 =?utf-8?B?TVo0QTRvenVCWFJpTjN0ejVNK29LVmt2SlNZYjY5LytXTTFWbGYwT3l2QTNs?=
 =?utf-8?B?M2NjaWJuUDlHOFhWZjZRQUJSOVY4THMraElPeEViZGVtbFFhNHo0UnRYUmFX?=
 =?utf-8?B?bmJuWWdMbWVVOWV4dVU5SWZJcXdZUG1Kc3JnZDR3eVk1RFFuVlluTTJiN1B3?=
 =?utf-8?B?aDFyQ01yZFIxQnhHeU55NDd2RWlMcDRBWCtPOWFwbUZaMW9Wb0dFMXQ2UVpv?=
 =?utf-8?B?SlMySkd6akN6NWh2MXNoSG1xditRYVo2S0hEOEIrSmhWdHJOWW5maVc3b1U2?=
 =?utf-8?B?RTNQYUpjNDY5SjEvK3I4UU54c1F0ZGtINlpaQS8vVjB2T2l6SGNLeXVKVDc3?=
 =?utf-8?B?SjRjaUJRRTlEY0phTmNOTWdtNndycnh1TmZ0OWJiaGxxY1B1aEZmTUFmSGd4?=
 =?utf-8?B?SjZkbFZ3UWtIVjhRVDJnK2o4UDlUdEhrQ0NFZ0lJaDRpTnUzVGlxOURRaFBO?=
 =?utf-8?B?Zmc1MVhwNDc2am82TXoybitZNng5Y1lPaGxJM0drZjN0Z1luNjZzdkJlaFNJ?=
 =?utf-8?B?ZTdHQ0pQN2RaVDM5TEFkbWxGZEt0aytQUXp1SDU1NzJ2dWdpekxtazNwZ1N2?=
 =?utf-8?B?NlJ6VjRaeWhRV1hZY093dllCTUVpVlFQalBSQkp2T3ZXV0h5bEVVVEJTWEZF?=
 =?utf-8?B?bEx2cktYbkhDbXJiUUlJZ2x3QnJyaDBpcHdBaVJVYVhtN0pEbG1FQnpLUFhM?=
 =?utf-8?B?cVh3VmFUWGhXajNXYjNmQ1VWTGlLQTh0RDdTS2ZLUlFCS0ZYTmVYK3FSL1l1?=
 =?utf-8?B?bEh4RE55Rkt5dUpRcVE4VVFLRm5IV3g3T1RYVmp4Q0I3R2dKakpEdEN4L1do?=
 =?utf-8?B?LzY3OGJzRFBRUlhWRWpycWUwNDEyTEF1Qi9oUXhweTdQQytSSEVTT2lKMzNj?=
 =?utf-8?B?dG1SNklxYm1iaUhlZmtsZE8yNk9nSnM2SHhYK1ZpSmJQRkQ2WVVaRERzaHZY?=
 =?utf-8?B?emdnaVQ4bWVhUkJucGNxUjdzSER5MGRmYUR2NEszZFR1ZkwvR1YyWEZBSW53?=
 =?utf-8?B?T1lYVDFrU1lISmErS24vL0p3TXA1a2ZXZ1VMV2plc0VlT2tyUEQ2OHc2TDYz?=
 =?utf-8?B?aDIyMGNqNlVURmlOQWgvWFhHWmFndjdtanZpU2dlS3N0NXRFdkJOMGdFcXJ3?=
 =?utf-8?B?UzA3TVVDTGdUOXUxQ1BRT3V1OHJOYVhSK25FeGdVSCs1SWI0Z1A0TXlVaGlH?=
 =?utf-8?B?cndnbGExeTFVR0k5MTE1OHJuOVJqMFhGU0U0b3RrK3o2LzdoQmpoRHlKdzlC?=
 =?utf-8?B?L1F6TVRoTDhhTTM3QjNzRDdDTHBGdDdCVGtyVGF4YjkyeEQzNVZmdGZqYWZt?=
 =?utf-8?B?enpUd1J0cnEwNWdvTU5XMk4wT2xJY0FPelNJTFNkc1ByQWRaVnU5SFpRdDdH?=
 =?utf-8?B?SWRJcXp5TFk4T3pMMFRqczlyUXZFdTJEVlQ5cHlKODRINWRudUxQWXJReFRu?=
 =?utf-8?B?NmI3WG5IZkZyN2xsaUxpOW5qc2Flb0s4NmxGQUhFaHEwM1NYdjhpRWVrRXl3?=
 =?utf-8?B?aXN5Q0FMR1NEblhoa2lKeldibkhpTnNWZTA3QndpQStDSUVVNkhsQUZvQzRj?=
 =?utf-8?B?dHF0dncrcUJLREJQT3hTUzFMMUpGckY0alByTnF4QW1BMytoMGphcW0wSE81?=
 =?utf-8?B?MGI2ckZIb3UzTGZoUnNQOVB4RDRYZzdoQ0N2TEoydXNnWmw5OER6RTIrNWtV?=
 =?utf-8?B?VmZySHQwQzlXT01LSmdFN2tHTmVMYm1DUU9wRG5ZR3UxOUJrTjdUbHFpbEd5?=
 =?utf-8?B?TEZRRlB3SHN3RVVObXhBeHErQXR2TUxpVmFaNXdDSGd4TnQ3by9mTXRjdEtG?=
 =?utf-8?B?UVc3S29oY0pGd0VZcHJnK0loT1E0b1dCTXR3blhPYUNxSWdRTjQ5bVBQNUVS?=
 =?utf-8?B?bFBWQjBYeDF6a0RwM0hlVytRTW9lL1NRb3RNTnEvMDQxdU1ZWlZMVHMwcjhr?=
 =?utf-8?B?WU1zVlJFVWFHYjMrbVVuc0ZaemIwaUxycVJ0UFI5aVNIR0FpamJFaWxKTXZH?=
 =?utf-8?B?Vm1sNW1vRis4U0JuaW5XTWdacWo1eEZJQ3R6Y1VSa0VRZzJXQklwT2lSaXht?=
 =?utf-8?B?Z0J3S3BSR3NLUlQxYXg3TGlPM1ZRYisyckJjN1FkWlZ3SEJ3aStHaVVyWkpZ?=
 =?utf-8?B?eFJ0ZEszc0lLWHRCckZSZWMwUkZEbGx2dlg5cWhRaGNJWTdCY2hyZ2w1SUls?=
 =?utf-8?B?LzZmQktvQllyTGhtUVZ2eWU0Y3doeDdIek0wSVluUXlDUmtEamRMQlBNWmg1?=
 =?utf-8?B?YzZsYzlWcDZ3czNyaExmNjlGaHkyRWs1Vnh2U2tnUWpaMHBOOTJTMGdoVHVD?=
 =?utf-8?Q?rH2223vQQAjrnqDo=3D?=
X-Exchange-RoutingPolicyChecked: K4fZsI1qWuictKFjT4/aIWiawFnpxv88UNQ5FNc3vZANLcpIQRCFFdFafa8xve5OY0YaWU1/ruYq3SbUyh0ESzM8u6qMhWOywVmB2cDvUBd0KiPtg/5MKBbndx3/yg6STy7r0PHkAJIQPQ3mhvRTYAyFk4o89T5PnQOM831yjx3hfVZYKCTVZ3dMG/ts6JaEGu14wNXAT8mWPwxdWpGhfzSCnUakYbvSWZDiA/HMs4uXXJbyu0VYicJkrSQMWg5IIe0DpRR5+XR6HKqMpDvV7Awm/qlL8MiU0XTxst6pNvvIfY/0DaCsOIUGjH2Xsq2axC8TFw1PuorRHOMMXUdbgg==
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98bc5fd-fc18-4f60-3e9d-08defecdaf00
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:14:09.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUv/5kR9cUvJH6CrgJV2MPNf3xLRtWG+bYSg5MX7KuJknw1HlZHnxVts13iANytoxCq6VHTOLA/G57jPm5kziI3uD3sRGGd0Z5oIsTgGfJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7653
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n3lZQF70R6OJmnab6pnRSNbV_iFttMQhT_upQZ1EowY_1787238851
X-Mimecast-Originator: touchnetix.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Fri, Jul 03, 2026 at 12:32:25AM +0200, Marco Felsch wrote:
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
>Co-developed-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
>Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>---
> .../testing/sysfs-driver-input-touchnetix-axiom    |   80 +
> drivers/input/touchscreen/Kconfig                  |   17 +
> drivers/input/touchscreen/Makefile                 |    1 +
> drivers/input/touchscreen/touchnetix_axiom.c       | 3141 +++++++++++++++=
+++++
> 4 files changed, 3239 insertions(+)
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

...

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

This is right, it is release. However in the driver you refer to "productio=
n",
which does not match.

>+
>+=09=09Access: Read
>+

...

>+ * The devices have a 16bit ADC but Touchnetix used the lower two bits fo=
r other
>+ * information.
>+ */
>+#define AXIOM_MAX_XY=09=09=09=09(65535 - 3)

This assumes ENABLECOORDINATESCALING is set in u41.

>+#define AXIOM_DEFAULT_POLL_INTERVAL_MS=09=0910
>+#define AXIOM_PAGE_BYTE_LEN=09=09=09256
>+#define AXIOM_MAX_XFERLEN=09=09=090x7fff
>+#define AXIOM_MAX_TOUCHSLOTS=09=09=0910
>+#define AXIOM_MAX_TOUCHSLOTS_MASK=09=09GENMASK(9, 0)
>+

...

>+ * same usage to handle different usage revisions.
>+ *
>+ * Note:
>+ * During a th2cfgbin update the driver may use usages not listed here.
>+ * Therefore the th2cfgbin update compares the current running FW again t=
he
>+ * th2cfgbin targets FW.
>+ */
>+static const struct axiom_usage_info driver_required_usages[] =3D {

Is this too strict?
Could you split it into "update" and "required"?
So a probe succeeds with "update" usages, so you can atleast get touch
reports, but a download is blocked without them.
Also should u64 be optional?

>+=09AXIOM_REPORT_USAGE(AXIOM_U01, 1, axiom_u01_rev1_process_report),
>+=09AXIOM_REPORT_USAGE(AXIOM_U01, 3, axiom_u01_rev1_process_report),
>+=09AXIOM_USAGE(AXIOM_U02, 1),
>+=09AXIOM_USAGE(AXIOM_U02, 2),
>+=09AXIOM_USAGE(AXIOM_U04, 1),
>+=09AXIOM_RO_USAGE(AXIOM_U31, 1),
>+=09AXIOM_RO_USAGE(AXIOM_U33, 2),
>+=09AXIOM_RO_USAGE(AXIOM_U33, 3),
>+=09AXIOM_RO_USAGE(AXIOM_U33, 6),

...

>+
>+=09return entry->info->rev_num;
>+}
>+
>+static bool axiom_driver_supports_usage(struct axiom_data *ts,
>+=09=09=09=09=09unsigned char usage_num)

This is called many times before calling a given usage handler.
Could we just check in axiom_u31_device_discover() or axiom_i2c_probe()
for all the required usages?
Could the "update" usages be checked in axiom_cfg/axfw_fw_prepare()?

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

I assume this is supposed to be:
for (; iter->usage_num; iter++) {

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

...

>+
>+=09/*
>+=09 * Downstream axcfg.py waits for 1sec without checking U01 HELLO. Test=
s
>+=09 * showed that waiting for the HELLO message isn't enough therefore we
>+=09 * need to add the additional fsleep(1sec).
>+=09 * Touchnetix said that the boot can take up to 2sec if all self tests
>+=09 * are enabled, so wait 2sec for the HELLO message.
>+=09 */
>+=09if (!axiom_wait_for_completion_timeout(ts, &ts->boot_complete,
>+=09=09=09=09=09       msecs_to_jiffies(2 * MSEC_PER_SEC))) {
>+=09=09dev_err(ts->dev, "Error swreset timedout\n");
>+=09=09error =3D -ETIMEDOUT;
>+=09}

There is no reinit_completion() to go after/before wait_for_completion_time=
out() for any of the calls.
 From my understanding this must be called before starting the new wait for=
 completion.
The 2s timeout may have hidden this.

>+
>+=09fsleep(USEC_PER_SEC);
>+
>+=09return error;
>+}
>+

...

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

Is this right?
Should it not be:
len -=3D AXIOM_U34_REV1_PREAMBLE_BYTES;
len -=3D AXIOM_U34_REV1_POSTAMBLE_BYTES;

>+
>+=09switch (report_usage) {
>+=09case AXIOM_U01:
>+=09case AXIOM_U41:
>+=09=09/*
>+=09=09 * axiom_driver_supports_usage() is not required since the
>+=09=09 * correct .process_report() hooks are assigned during the
>+=09=09 * discovery.
>+=09=09 */
>+=09=09return axiom_process_report(ts, report_usage, payload, len);
>+=09default:
>+=09=09dev_dbg(dev, "Unsupported report u%02X received\n",
>+=09=09=09report_usage);
>+=09}
>+
>+=09return 0;
>+}
>+

...

>+static int axiom_u41_rev2_process_report(struct axiom_data *ts,
>+=09=09=09=09=09 const u8 *buf, size_t bufsize)
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

The index in enabled_slots can be greater than num_slots since u42 does not=
 neccesarily
therefore this can send an out of range finger.

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
>+static int axiom_u01_rev1_process_report(struct axiom_data *ts,
>+=09=09=09=09=09 const u8 *buf, size_t bufsize)
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

...

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
>+=09if (client->irq) {
>+=09=09if (!ts->irq_setup_done) {
>+=09=09=09error =3D devm_request_threaded_irq(dev, client->irq,
>+=09=09=09=09=09=09=09  NULL, axiom_irq,
>+=09=09=09=09=09=09=09  IRQF_ONESHOT,
>+=09=09=09=09=09=09=09  dev_name(dev), ts);
>+=09=09=09if (error) {
>+=09=09=09=09dev_err(dev, "Failed to request IRQ\n");

input_free_device() should be called.

>+=09=09=09=09return error;
>+=09=09=09}
>+=09=09=09ts->irq_setup_done =3D true;
>+=09=09}
>+=09} else {
>+=09=09error =3D input_setup_polling(input, axiom_poll);
>+=09=09if (error) {
>+=09=09=09input_free_device(input);
>+=09=09=09dev_err(dev, "Setup polling mode failed\n");
>+=09=09=09return error;
>+=09=09}
>+
>+=09=09input_set_poll_interval(input, ts->poll_interval);
>+=09}
>+
>+=09input_set_drvdata(input, ts);
>+=09ts->input =3D input;
>+
>+=09error =3D input_register_device(input);
>+=09if (error) {
>+=09=09input_free_device(input);
>+=09=09ts->input =3D NULL;
>+=09=09dev_err(dev, "Failed to register input device\n");
>+=09};
>+
>+=09return error;
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
>+=09int error;
>+
>+=09ts->supplies[0].supply =3D "vddi";
>+=09ts->supplies[1].supply =3D "vdda";
>+=09ts->num_supplies =3D ARRAY_SIZE(ts->supplies);
>+
>+=09error =3D devm_regulator_bulk_get(dev, ts->num_supplies, ts->supplies)=
;
>+=09if (error)
>+=09=09return dev_err_probe(dev, error,
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
>+static int axiom_power_up_device(struct axiom_data *ts)
>+{
>+=09struct device *dev =3D ts->dev;
>+=09int error;
>+
>+=09error =3D regulator_bulk_enable(ts->num_supplies, ts->supplies);
>+=09if (error) {
>+=09=09dev_err(dev, "Failed to enable power supplies\n");
>+=09=09return error;
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

...

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

This also works for ax80a. ax54 and ax80 are the same silicon but with a
different pinout. It is up to you if you wish to add this.

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

Apologies for the delay in review.
I have tested with ax80a and ax198a and everything works as intended
on both of them.
This version looks to be quite reliable for the firmware/config=20
download which is great!


Tested-by: Andrew Thomas <andrew.thomas@touchnetix.com

Regards,
Andrew


