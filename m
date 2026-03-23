Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.85.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4F37D101
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260076; cv=none; b=YBorrJ9RRgP0REIq5+cvZbianW4IPSvUoMnUubrT6zHIN1pO+twzKgUHQPYs5NrkVKgXkpODp2HrMHISId6BdcQUM8Jg0b8tuDDOYgExXfbt7pF2cWKozwYdNMKmnMMR4kA1udh0ErXvTmzwePccW4tmLkl2f01BrxvgLcUC65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260076; c=relaxed/simple;
	bh=fblUXtGyjojUlB8YF5BX6/FMzzxplNqHYwA4cyo9zvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type:Content-Disposition; b=Si5Qb885WF1xQeMmXUs/OCSJkDdIYYRCiuNzd8zR31PEQpgczBPHcFdnRiBWKJ3LDd4YBznqO/j3QChG3PQT29I8Vb0W7jKCYnqixvDGh+/uJynooLQJiNKclXXAps6HMWotZeRcW8EylyoDxqFhKGOF/DGEbGLApk0PojhJRys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.85.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-284-1KMkuASuNHSCHy5-_9abLQ-1; Mon,
 23 Mar 2026 10:00:00 +0000
X-MC-Unique: 1KMkuASuNHSCHy5-_9abLQ-1
X-Mimecast-MFC-AGG-ID: 1KMkuASuNHSCHy5-_9abLQ_1774260000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LOYP123MB3247.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 09:59:31 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b%2]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 09:59:35 +0000
Date: Mon, 23 Mar 2026 09:59:48 +0000
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
Message-ID: <hxa6vfro5jirigd4jqm37wqlyslphy4yqctbbaeraz4sfcx366@qklnqawxb4t6>
References: <20260303-v6-10-topic-touchscreen-axiom-v6-4-8ac755add12b@pengutronix.de>
 <rnbwxsdiwjojk7354c6k4us6xxl3qpbyt2lrbhgqz77avrdwga@tqb6voucuysi>
 <enyz3io3i7mzoaquexpkbsjtxmcuib7lxj334ii2yqvdgpvajb@aspqccwo7vnf>
In-Reply-To: <enyz3io3i7mzoaquexpkbsjtxmcuib7lxj334ii2yqvdgpvajb@aspqccwo7vnf>
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LOYP123MB3247:EE_
X-MS-Office365-Filtering-Correlation-Id: 245341b3-af5c-44a0-fc72-08de88c2e2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|56012099003|18002099003|22082099003
X-Microsoft-Antispam-Message-Info: lq2E1RzSNQXunLAjjsQtHdEK4aFWJKG71qnZa/pxE4lRZbzT80bdWtSkkVJo9PRyVvyKDDU51rPEJzSPKfpVUAPKTNnow+mJ4qzf/1yivqAFGy4QoVZMgt1rPaeKQeVAl5K3OtqWpwUlel4DatLmlw/Nqgsge9qfBvO9o7UnPS6ov1xzVe0p4i4fSxfy+VOzETGSz/cvYLudkzGh/r5wSnGVbcHWIfLcksHL+ZpzXhni6I7eI4EJtMA3zZ7TBAXdcfO8rjxCihyPue1DhTfvBrKrT8gT7tK98FZ/sZsxEutGoRmKC4D3RTeqCJHcC0kvX7diUewoxxeB4b+ioJYcdX5DtOTJ163nC+B/k5eNIv1vAVlXo08nv7o5QX2jyq0ERBOxbc6vuf6AmGHTgrw9A2yAYtex+Ldbg38fcRe7O4d0t7XoiJZWM7719ozAL5pSVK+5/WmP9LAAaVc9mEO9akIterf5bI5wMA/OKF4iIDss4zOY4uXdprgrVmoK1ZSHBv1BkD2Mr52EjOLcfGgPfXidbmi64vxX81A4UbA7n0CtWYKvreHiZOuym/ymGVxxyFlc67Uv5HUivtQBL50sj3n4p2vGSwwlqZqiRz5++jvWUACUsNpdjz4iJ4pZwzqWcaH1e4AAnl9860+Xbx3L5xzLPxm+zsNUHYyDrruW6pbypFkgsTKgALeXh3wvAlOguiVWA4cNvaRLzk7hGi1jSJQkrzIAMxmaRhvHyqVHt+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU4vTG8rZDJmbXZsUUNEcHVtT1hOOFI2bUxRWk9aWDJWZlhNMmRUUGREd2RO?=
 =?utf-8?B?Y2U4d1FzWWs1cmpvVTlrcTkzSTdZY1c2ajdydUJFMEVmTjVhMjQvUmtjcWpy?=
 =?utf-8?B?S3QzVlcrOEhLb1loOGlZRTlqNzR5Ly9uKzRHOVk5K21IQnFWWjBZZXVocWZS?=
 =?utf-8?B?TW5qZCtNOVJaMnp2ZWZzUVI3K3UyS0hQWGpXTDJSWDdsU3dRZzh0ejkzWlQv?=
 =?utf-8?B?d2Q2SWtsZ1ZWZEprZjBOL092aktDMTM3WFJ4cXovSnBLUjdDcFdycTdTZm5C?=
 =?utf-8?B?SnZYZ2lUalRxaXBkcHo1Q3JVRUxGT0ZVR0hjSzBMMnlBQk1DcXdmZ2JRS3du?=
 =?utf-8?B?OFJpVG8vcFozaGRtTmkxMkVSck5WeGdoaXlObzJ5MVBJb1ZrenQ4M2dvT1ds?=
 =?utf-8?B?cGZ3cThHNjl6SG4rT2NGMENtUUQ1Q0UxOWszZThzQ2pYdFgxajFyQTdUQTB3?=
 =?utf-8?B?MnRLZ2ttNmFrcDF4LzhId05seS9wbE11U0liMkMxdWlnaXE3SGNjLytrbmFU?=
 =?utf-8?B?OVU1YmxOWiszZHpTdDRIeDdUV1VqT2NtVTJ6YTl0bVowRGNrZ3oycWlSbzVS?=
 =?utf-8?B?bFhwU05KREJhdDBhcEdyS1orWHF4VjB5R0c3NHE0THQ1YmNzMDhxUlNONmZM?=
 =?utf-8?B?U0YvVnQwNnRoejdWZ0Zua3dxYXBKVjJPM2E2VVc1TTNGS21DcXBBRlk2MVhZ?=
 =?utf-8?B?YzBBaDhMcUlINWY0dVlqcDh5WDlzQnV5NkFHY1hucVFXYzhsV01jNnhuQ294?=
 =?utf-8?B?R1hvN3dPNzEzem9LQWdkbkpjMEIvelM4cy96RW1xTGtFUzhqVkZHRDFkaDlZ?=
 =?utf-8?B?c05LVmVESkV0UUEwMi9xK3J4SjUzSGdocTUyUEdwQUl5c0VvZ2tUVFptT25W?=
 =?utf-8?B?SW5mQnJTTEViNVBUdkpRODVZclFqRWhqRnl4dWhBNnJEbkxOTHoyaThZeXBJ?=
 =?utf-8?B?dW4raTZwekhWajFQRkhySXFzZ3ZEV1BINU1jWWpoZEhzWDBSTWRsZDY2KzFm?=
 =?utf-8?B?QitGcEZKRHZnb2ZKNXFhM1FxVFJsd3dNMGJwdi8yTWk5VUhxS0FDbkZzbEox?=
 =?utf-8?B?NTl1dzYwN1FzNjFMUGdSa1BmR2FCUlp6cllQdHF0K3g5WUNsRmxmZjdtdERu?=
 =?utf-8?B?SXBLeTVFcXU5YWVHWVppV2tyUUZMSXc4RTFRdmo3SkhEWGNpMVczRjdENjhv?=
 =?utf-8?B?YWdaOTZUcElINDZtMDJjaUhkUnhlSVlKa1B3MThtMklXQXVKdkJRdTZOajIz?=
 =?utf-8?B?c2JCblArd0tyQVRzeENBUy9JLzF1T1NMQU1mZ2RETWd2dndNM3d4MXl2MUp2?=
 =?utf-8?B?OFZaQlVtdE9aQzk0RFlpYTZJam1UZXdqeWJ6d2ZPdHV4L0tTNzc1TjRjZFdu?=
 =?utf-8?B?MDdndnl6ako4a3kvRjJ5NFJRR05MNWJVbUhuKzNNL1NVU2p1MU5wdm1oKzF2?=
 =?utf-8?B?dEhScXVTL09KNFBLcjRDUlB6QkxkeVNINHU1VW5tak9GempUY3VvMW5iUGpB?=
 =?utf-8?B?TzlPZUJPZDJ3eG45UWhsTUU1cmFxMTNGVHd2K1NQWW00MzR5V0d0bC9VWWR3?=
 =?utf-8?B?aWR6Qjg1elA4cVljeVlFS3Z4L1oxdm1oMVYreFpvN0VJTFY5Zk01YVZnaFR2?=
 =?utf-8?B?ODJEUEJQSisvaEQ1MG0xMzhwSGpzRUlFeTY4U2h5N0NHRlBnL0hPR3MvSjdq?=
 =?utf-8?B?UE5Rd1YwVVpYak9RL1BQbnlTWHJpcStPSTNxUUhZN3ZLait1cHN5VFlpcS9m?=
 =?utf-8?B?RkYzOE01dk8zdTNDUWRUN0RpR3FjWGNUOGVPcStUbXRscU0rc3RIbmZBSzRX?=
 =?utf-8?B?L0VXN1BDdzFuQU9TbVRNNytiSDdGVGJlc1hOcGdrbVF3dlhMczlXTkQzZTlu?=
 =?utf-8?B?TXpLVG1HQkVaQUJFcmFyaHVLZTBMcnE5SEQ2Mk04Q3VPVWhBOHlYTG9rV2ZL?=
 =?utf-8?B?azhCbWgrMllnUDR3UkRSWGJady9XRlBlTWhmMnBobjVXdzdqUThsMXF5L2Q4?=
 =?utf-8?B?N2s1enI1VUd4QUZ0Q2VYakhwdTgwSHQ1L0pMNFhrZk9RL2NkSEhxWUNDYW91?=
 =?utf-8?B?ekloQUc1L3N1QzMydlVWcUNHaFZCZmRjZE5Zb1UwZ3Rqc0c2NnF1b1I5djJQ?=
 =?utf-8?B?WENoaURxVFFZME85bzQ4TDZ3OXZMTGdSUkw2d2ZDS0hMYjgwKytLZTBDZnQ5?=
 =?utf-8?B?RHRKRGJKMWwzb2VqODBrZjNoMGlsbzIwL2tFQkJJM1NWN0FlNllTY2dzQmJx?=
 =?utf-8?B?WnZPZ05iSDFESVpsSEMrL3ZHN0VURS9aZlpzY1RHYWh6K1o1Z044TDl2ajdP?=
 =?utf-8?B?VVFLQmpiaW42ZEtTc0FNaGNvVWJTcU4reE9OSTZZU3c2YktldW0yTmQvSEJ6?=
 =?utf-8?Q?g9JgTSqBLfT98ZLI=3D?=
X-Exchange-RoutingPolicyChecked: ZPLRj345MFJblBvRpuE7e3jizdOgqCmC48zUqgUBI5S1GeEg56w/txuhNXCfZvRPAWc0kY9HnvV7X78q5I/+8Rh71nu4inEvR5RAWQpxsL6Sb2+py3glWcWa9CMpqtS2GTzf4EI11H/pDacP1mJ5Sahn2n/HfoCBmdzu1+aRT5/O88DO1EC/1PhnHLH62hx6WN/Tgvo82yHpLHG+T/fLFoITYWNW2dGvk7evoCHacJMqEjOY+qbDAqkC006kzRFXOrBXZVelZ/mprchZgFHuQQdrTwgpidBK1VyXZvJ5GD1ckNxmjBdMKT/TyM038weZUJbredaSEoMOi3pGHe2x8g==
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245341b3-af5c-44a0-fc72-08de88c2e2ec
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:59:34.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReHscVVVB1D6zQ4L060Yen6Yi6KES8wMtMt86EGVhNxwFWRg//GZW/iEiXSoapzBLEmL5N7Ojfk6nwPKJUBztLoYL/xbdRy/59bxnCInTQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3247
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pSApvTXeXSWJ-YNjj9sGECYK7bFW_TJ6XaZvJ5mqvcs_1774260000
X-Mimecast-Originator: touchnetix.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 08:50:05PM +0100, Marco Felsch wrote:
>Hi Andrew,
>
>thanks for your feedback! Please see below.
>
>On 26-03-13, Andrew Thomas wrote:
>> On Tue, Mar 03, 2026 at 11:41:22PM +0100, Marco Felsch wrote:
>> >This adds the initial support for the TouchNetix AX54A touchcontroller
>> >which is part of TouchNetix's aXiom touchscreen controller family.
>> >
>> >The TouchNetix aXiom family provides two physical interfaces: SPI and
>> >I2C. This patch covers only the I2C interface.
>> >
>> >Apart the input event handling the driver supports firmware updates too=
.
>> >One firmware interface handles the touchcontroller firmware (AXFW)
>> >update the other handles the touchcontroller configuration (TH2CFGBIN)
>> >update.
>> >
>> >Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>> >---
>
>...
>
>> >+static int axiom_u02_enter_bootloader(struct axiom_data *ts)
>> >+{
>> >+=09struct axiom_u02_rev1_system_manager_msg msg =3D { };
>> >+=09struct device *dev =3D ts->dev;
>> >+=09unsigned int val;
>> >+=09int error;
>> >+
>> >+=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>> >+=09=09return -EINVAL;
>> >+
>> >+=09/*
>> >+=09 * Enter the bootloader mode requires 3 consecutive messages so we =
can't
>> >+=09 * check for the response.
>> >+=09 * TODO: Check if it's required to add a delay between the consecut=
ive
>> >+=09 * CMD_ENTERBOOTLOADER cmds.
>> >+=09 */
>> >+=09msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_ENTERBOOTLOADER);
>> >+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOA=
DER_KEY1);
>> >+=09error =3D axiom_u02_send_msg(ts, &msg, false);
>>
>> As mentioned before the delay between commands is too short and the
>> next command is sent before u02 is ready, which means the driver fails
>> to put axiom into the bootloader.
>
>Please see my comment [1].
>
>> Have you tested with an i2c speed of 400KHz?
>
>Yes, my target platform is based on a i.MX8MP.
>
>> All you need is to put true in above to wait for the bootloader command.
>> error =3D axiom_u02_send_msg(ts, &msg, true);
>
>Please see my comment [1].
>
>> Just dont do it for the last command.
>
>Please see my comment [1].
>
>> I am not too sure why you are having issues with this, this is how we
>> do it for all our devices.
>
>Please see my comment [1].
>
>On what platform do you perform the tests?
>
>> >+=09if (error) {
>> >+=09=09dev_err(dev, "Failed to send bootloader-key1: %d\n", error);
>> >+=09=09return error;
>> >+=09}
>> >+
>> >+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOA=
DER_KEY2);
>> >+=09error =3D axiom_u02_send_msg(ts, &msg, false);
>>
>> Here also.
>
>Please see my comment [1].
>
>> >+=09if (error) {
>> >+=09=09dev_err(dev, "Failed to send bootloader-key2: %d\n", error);
>> >+=09=09return error;
>> >+=09}
>> >+
>> >+=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOA=
DER_KEY3);
>> >+=09error =3D axiom_u02_send_msg(ts, &msg, false);
>> >+=09if (error) {
>> >+=09=09dev_err(dev, "Failed to send bootloader-key3: %d\n", error);
>> >+=09=09return error;
>> >+=09}
>> >+
>> >+=09/* Sleep before the first read to give the device time */
>> >+=09fsleep(250 * USEC_PER_MSEC);
>> >+
>> >+=09/* Wait till the device reports it is in bootloader mode */
>> >+=09error =3D regmap_read_poll_timeout(ts->regmap,
>> >+=09=09=09=09=09 AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, val,
>> >+=09=09=09=09=09 FIELD_GET(AXIOM_U31_REV1_MODE_MASK, val) =3D=3D
>> >+=09=09=09=09=09=09AXIOM_U31_REV1_MODE_BLP,
>> >+=09=09=09=09=09 250 * USEC_PER_MSEC, USEC_PER_SEC);
>> >+=09if (error)
>> >+=09=09return error;
>> >+
>> >+=09return 0;
>> >+}
>> >+
>>
>> ...
>>
>>
>> Other than the above comments I have no issues with the driver.
>
>If you're fine with the patch you could add your acked-by [2] :)
>
>> We can support more usages in a later patch.
>
>Sure :)
>
>[1] https://lore.kernel.org/all/4x3dnedfzf3rqzsy3wjdoj6yaxmy6kop37xhxeao4v=
jer7ifdi@35ux42ztq3eb
>[2] https://docs.kernel.org/process/submitting-patches.html#when-to-use-ac=
ked-by-cc-and-co-developed-by
>
>Regards,
>  Marco
>--=20
>#gernperDu
>#CallMeByMyFirstName
>
>Pengutronix e.K.                           |                             |
>Steuerwalder Str. 21                       | https://www.pengutronix.de |
>31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

Acked-by: Andrew Thomas <andrew.thomas@touchnetix.com>

