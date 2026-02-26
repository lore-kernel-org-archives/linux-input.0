Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A8337699
	for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104117; cv=none; b=YI0AO/rg5YmBUd0k9/Gcg5njbU8ksvbV5rTBrM0ynaQcg27dbR0olzo9i5lW2gX/zyWKJBf4dhhAiRfsoW9LC0790swl+W+glU8OLRpv0/AV/RiFI1yMPTB8wNE9ixDM8B3G16x2jtUOe+14Y3I+JVfx7wwIdYpPMNDe3MH9JOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104117; c=relaxed/simple;
	bh=URxL+A/4WFZa+RcqwnSKDEAK7bvrvdCk5wqwA3BV3Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type:Content-Disposition; b=Nss0Byb2rB/xpxU/tjG4ky0jLT+skpfeqF44oeibfe1eCeT9vDVQ/B8ALOsbdPbJ2sK5wfLVIhKS3AWziKqsbA19f3HQ/YpdUuBs7jf4vxUkzJE9dMiX85hzyCi122xDpTFX2d58O/K8GweOQMrcR+QmU/pUm9KPkedGCbDqg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-275-2cTxgbLvONq0KxBZ-avrrA-2; Thu,
 26 Feb 2026 11:08:32 +0000
X-MC-Unique: 2cTxgbLvONq0KxBZ-avrrA-2
X-Mimecast-MFC-AGG-ID: 2cTxgbLvONq0KxBZ-avrrA_1772104111
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LOZP123MB8515.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Thu, 26 Feb 2026 11:08:30 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::72a0:d7fe:5595:514b%2]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 11:08:30 +0000
Date: Thu, 26 Feb 2026 11:08:27 +0000
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
Message-ID: <lgpdkwl7hxz7ok7qtujzdhf3c3iehwvm5d7myxfewr4kgrcq5k@3s4v4sjus7go>
References: <20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de>
 <20260111-v6-10-topic-touchscreen-axiom-v5-4-f94e0ae266cb@pengutronix.de>
 <qoelgb5k77a4c4jodn622a6wauotzkeygy5fj54cjjnobb5g6c@ysxkou6nhkop>
 <a7hajq5edw3w2pm5l3ytn65kmudjckvaj5relydayoua5i7oha@wsattyisot4s>
In-Reply-To: <a7hajq5edw3w2pm5l3ytn65kmudjckvaj5relydayoua5i7oha@wsattyisot4s>
X-ClientProxiedBy: PR1P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::7) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LOZP123MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 387f2c69-a573-482d-54c2-08de75275f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014
X-Microsoft-Antispam-Message-Info: Qu9I9wrfWI+2gvghLSNH7QLIJPMzSbNp6at57Et+nmCL4JYx3kzJ7hjgq7HW11SVCeyd2Yk/zrUZGpbveYEYBjfyGuVKGChuTbvhuSb1B9HvYdIJwS8kpV8Q8bLZIy50aAGWFZRiQDAz7PHip2b6ay2oIGxZhGqQZ8i5ODlTHpv7fHebTzH3mw8SUsMeJKy03FtxHLUp8tseMtiGfE2eAOZ8sdPfTv0tnB5kown2Do73RJjsZcQ9UgWEdh+EP6maYhD+e3Ygd8poly+SU4Zg0eKIuA6dfCdGo6iGtiFgRyqN4v1HtxloTNJk/HeaSKjenvFBAMEZvIoc7deBKYOLfuqXVP1h74j0MSIa66Ax1IxfbBdFWcbKmqNdTgHAbjmEF6wBQxe9E7FsmVFjtD7l7MMv7Kmv7o4uQc3MOoK52aELRknMSb4jsGmDrnflpd3idzL1BaUrh0ZUOi5n/zLx99wp9SnivOJ1QprmaovbCUf7Kqzw2oLwb4bBJCQUYZisQSoFgDmu7ymHQmfTOSwlcWYGjfHrPHcoZ0ANFG22+cmAcMJGGZ0acUELZFMnifrNz/BawFStGG2lYXPcbjr+QiNpwqv9PpDQbNoSUOSqi97vRZVg8VTNgB5sTjGQP7GZpWtRnsZKghoXXpU3C8mjlp/tZGO/w+k/zDsQSlzevh1mJKy4ls1VmkY59hyPvWHZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHkraUs1SEFMUUhGbnhQaHN5VCs2Yms1TEtPSjZJSnhBM2h1SE5kUnR4bzBv?=
 =?utf-8?B?QzNTVVN3YWo0Wlg2dStPQTRoZi8xR0haZ1hQMmsvSGhPSEI0SmxhbkhGZkNY?=
 =?utf-8?B?MUd4TDNSbnVyL2tmNFA0R1VOMUJ3MlMzb0NIQ1Mwb2hFNlNhUW1hb2VYR3JO?=
 =?utf-8?B?QVRlNnliMlNBNjJ6anljU01HT21VMmVjSXF4YVI0WEdTcldNTG0rS0RRWmVw?=
 =?utf-8?B?bzMvTW5PU25naDdsUHE2bzgyOEpjYS92ZFNmOU1HK0dBTVhuMm9NY2tEZUwy?=
 =?utf-8?B?UlQvSm9LcVRGVThPd0NacXBkclhJUlROZDFBOEJtbWVYTjN0M1BFVXVUM2JC?=
 =?utf-8?B?bW9WU2pzS0pMQkw0blBVT2hidlhpb21lMGNmSnBjYkRSMzB3TEZ4cTNUdFlC?=
 =?utf-8?B?c243d0pIczFJNTV1bDJFcWpPc205UTJvVnpxL1ZVNFY5cTVVSTZnQ1BKNFZY?=
 =?utf-8?B?SXdSQ3g2V045Z3NHcHZCaEM0QkJaaTJlTG5wcnRWVmhZV1RRT3NsbTlPZ2lI?=
 =?utf-8?B?RlZ3c1FLU2pjek9pS0R5enZjdDF5S25HVitBejJEQnlnV2hjQ0cyVHN1VlRq?=
 =?utf-8?B?VjFFQkpHdS90NmhTMSt2dFN6MWFqRThKT1ptTTR2T1JvSU1sb2c3dzhjWHF3?=
 =?utf-8?B?YnRDZUdFTlN4UHhMMUY3Ui9SaEd1Tmh1VlJTZUhuWmxvMkJ6THcyNk5xbU1X?=
 =?utf-8?B?WnFBZ3VhdmFrTmNzT1BTaUFBSnZlSjNzemcwQ0xzaVBaOGlIL2RlbklpVFNl?=
 =?utf-8?B?elIxRWpoUFVRZEZiWHUyYXVzVElacWg0RDE2OWJDcXhLQUgxRGZScnNqMlQ2?=
 =?utf-8?B?TEhpNE9McWpJUWkvUTZPWUl1dkdJTW40cmloQUM0V2xMN0dsWk9UbS9hNTYx?=
 =?utf-8?B?VEhvOXMxM1V3cXpFOVBhZU50U05zN1hBRmU0QUpqNE1sVUl5eUJVZkdlM2RH?=
 =?utf-8?B?cVN0d0lmdDBmUUFtbzV6T0JTeUR6Y3FKNDh2YW5MYWYwNHpyakx1UisxN0tL?=
 =?utf-8?B?bTc5UEtBd2FMVyswQ3RXRUFYa0xZR09NaU1vRUpaeThUQzI0Z0tXcHFEOG11?=
 =?utf-8?B?ZnVSeUIrRkJjSHY2UmwyVFdBYmcvY1pWbHR6RlFXczhTU3RWYVloV1BRQU1K?=
 =?utf-8?B?OTJUQVArNGQwUTR4ZjBFcXJGcW5xMnVpUlVNLzRxZjlJVXI4aXVkT2YrR24y?=
 =?utf-8?B?RnR0ZDBEaHVMbWJzTC85anNOemZMNTk3ajVwUFdxZ2p0Ni9KcjMxZm1wZ0tD?=
 =?utf-8?B?NWJOSnZkMnloR3poOFpJbzFLYVY2KzFtbVlNS09ZaXNOWkxIN2dPaERkNHNP?=
 =?utf-8?B?STh4TDZCOHlqWXFjeEJrMFJlMTNPR3dMbHk0d2pHR2lrYlJHbTJPVE9Kbnhn?=
 =?utf-8?B?VnpxV1ZHMkptNDVNRDB3em42NEVucnoxMzRKa2lKS1U3N25tZjI3Q3hSQko5?=
 =?utf-8?B?VnlsK2hGZDRxdmRaTUxPN3pMT1RPZVo1VmR0dE1sUlFwRW44WXVnN3YyS1BX?=
 =?utf-8?B?dlF0aWtJUGNUVFErTFhjNkp3QjZnT20vV0xRSTdWYjhydUlxa0JOa0pFYWoy?=
 =?utf-8?B?aXRtaU1wY1QvRzk1ZWVWeGFKTzVRUXZuSWtETVN4TDZyblBXbEJNVnYxaG1r?=
 =?utf-8?B?QzJWNXdhK0NBZStNYnNZbmMrZCtwaVdCck1aSmtnV1daQlNpeWQ2NXRodFN4?=
 =?utf-8?B?VllzaHl4ek41anczS1ZMc1M4OVB6R3paRFh4VGZWSG5IalJmY0dJMXJuUnp5?=
 =?utf-8?B?MlJpSjNWekZaK2tkQWM4TkZwbGZVUVJhSnhyTmhQdTRxYW5EZDBaNmwxdWdy?=
 =?utf-8?B?K0dDSE1Yb21hVEVvMXNheWJCbVJVTjVPa2dhM3FKaUFrVWRneE56NWJqczZY?=
 =?utf-8?B?QzYrOGx5QS8zTnFNdkQvbXlEY0pYZStqT051ak5nVzJlTHA5MmFqNzJkaGNK?=
 =?utf-8?B?b2hDWmNxWGlaaGNDSzllUTFSWjFpQmJ5NHFWdkNFbWJFejRXbGZDYVUvRnUx?=
 =?utf-8?B?ZXd6UTJXOGZkNlZtdFo3alpRWGtsVW0vOFZYc04wM3FrTVBkUkg2aWJqNHpo?=
 =?utf-8?B?QWQvOTlYK2pWcVFlRDRPVTRjWHhqY3ZOOTZ0bzN3dzlnVEJqYnhpS1lVVVRD?=
 =?utf-8?B?d2NhTldSWHhxcjlCSllSbnRuWVBvaWY5U0JMdm5BajQyU3E4T0lnb1VZaWwr?=
 =?utf-8?B?QmFiWG9uWSs1SGpaOUNCZkdTcnluTm9DZ2lLcXREM20yUGZDR1l3NHlwaFdk?=
 =?utf-8?B?WlNqcktXdCtEdTdOdGdQc1VzUmVmWjhhQmVwR01Ld3dyY3hwQllEL0g5aWNB?=
 =?utf-8?B?QlBVM3pPWUtTbEpIYUlzOXNKSjNuY283dVFnbW8yYXpqUk9jWElMa1FEK080?=
 =?utf-8?Q?OAIH2UOnoMJNvBOM=3D?=
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387f2c69-a573-482d-54c2-08de75275f72
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:08:30.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8U+q89id2bY2rKP2nHk3rSEHtPSzxT5hpX1vgJVZCVvVfxVJckHkL8euM/pO49XpmbwZn+FmIQGahb3UjhQICubbqZqjmgg0uixkkc+ScM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOZP123MB8515
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: euL52yHMExhqfZK0WDBiWgkdlm2cAH49UQYLfgEVRPc_1772104111
X-Mimecast-Originator: touchnetix.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 09:50:11PM +0100, Marco Felsch wrote:
>Hi Andrew,
>
>thanks for the your reply, please see below.
>
>On 26-02-25, Andrew Thomas wrote:
>> On Sun, Jan 11, 2026 at 04:05:47PM +0100, Marco Felsch wrote:
>
>...
>
>> > +struct axiom_u33_rev3 {
>> > +=09__le32 runtime_crc;
>> > +=09__le32 runtime_nvm_crc;
>> > +=09__le32 bootloader_crc;
>> > +=09__le32 nvltlusageconfig_crc;
>> > +=09__le32 vltusageconfig_crc;
>> > +=09__le32 u22_sequencedata_crc;
>> > +=09__le32 u43_hotspots_crc;
>> > +=09__le32 u77_dod_data_crc;
>> > +=09__le32 u93_profiles_crc;
>> > +=09__le32 u94_deltascalemap_crc;
>> > +=09__le32 runtimehash_crc;
>> > +};
>> > +
>>
>> I think revision handling should be kept in unpacking where possible.
>> Currently there are 10 revisions of u33, so adding support for many
>> revisions and usages would add alot of code.
>
>This isn't very complex nor very large code. Each u33 rev will add
>44-byte of code, so in the end there will be 440-byte. I've also seen
>that some revisions reduce the size because some fields aren't required.
>E.g. u93_crc is at offset-5.
>
>Furthermore describing the complete layout of u33 allows us using it to
>query the u33 in one i2c-bulk-transfer.
>

Fair enough.

>> > +#define AXIOM_U34=09=09=09=090x34
>> > +#define   AXIOM_U34_REV1_OVERFLOW_MASK=09=09BIT(7)
>> > +#define   AXIOM_U34_REV1_REPORTLENGTH_MASK=09GENMASK(6, 0)
>> > +#define   AXIOM_U34_REV1_PREAMBLE_BYTES=09=092
>> > +#define   AXIOM_U34_REV1_POSTAMBLE_BYTES=094
>
>...
>
>> > +enum axiom_runmode {
>> > +=09AXIOM_DISCOVERY_MODE,
>> > +=09AXIOM_TCP_MODE,
>> > +=09AXIOM_TCP_CFG_UPDATE_MODE,
>> > +=09AXIOM_BLP_PRE_MODE,
>> > +=09AXIOM_BLP_MODE,
>> > +};
>>
>> There are only two actual axiom states, bootloader and runtime (TCP).
>> This is more of a driver state rather than an axiom state.
>> Could you label it as such?
>
>Yes I know and the AXIOM_BLP_PRE_MODE will be dropped with the next
>version, which I'm going to send this week!. Not sure why this would be
>required.
>
>> > +struct axiom_data {
>> > +=09struct input_dev *input;
>> > +=09struct device *dev;
>> > +
>> > +=09struct gpio_desc *reset_gpio;
>> > +=09struct regulator_bulk_data supplies[2];
>> > +=09unsigned int num_supplies;
>> > +
>> > +=09struct regmap *regmap;
>> > +=09struct touchscreen_properties prop;
>> > +=09bool irq_setup_done;
>> > +=09u32 poll_interval;
>> > +
>> > +=09struct drm_panel_follower panel_follower;
>> > +=09bool is_panel_follower;
>> > +
>> > +=09enum axiom_runmode mode;
>> > +=09/*
>> > +=09 * Two completion types to support firmware updates
>> > +=09 * in irq and poll mode.
>> > +=09 */
>> > +=09struct axiom_completion {
>> > +=09=09struct completion completion;
>> > +=09=09bool poll_done;
>> > +=09} nvm_write, boot_complete;
>> > +
>> > +=09/* Lock to protect both firmware interfaces */
>> > +=09struct mutex fwupdate_lock;
>> > +=09struct axiom_firmware {
>> > +=09=09/* Lock to protect cancel */
>> > +=09=09struct mutex lock;
>> > +=09=09bool cancel;
>> > +=09=09struct fw_upload *fwl;
>> > +=09} fw[AXIOM_FW_NUM];
>> > +
>> > +=09unsigned int fw_major;
>> > +=09unsigned int fw_minor;
>> > +=09unsigned int fw_rc;
>> > +=09unsigned int fw_status;
>> > +=09unsigned int fw_variant;
>> > +=09u16 device_id;
>> > +=09u16 jedec_id;
>> > +=09u8 silicon_rev;
>> > +
>> > +=09/* CRCs we need to check during a config update */
>> > +=09struct axiom_crc {
>> > +=09=09u32 runtime;
>> > +=09=09u32 vltusageconfig;
>> > +=09=09u32 nvltlusageconfig;
>> > +=09=09u32 u22_sequencedata;
>> > +=09=09u32 u43_hotspots;
>> > +=09=09u32 u77_dod_data;
>> > +=09=09u32 u93_profiles;
>> > +=09=09u32 u94_deltascalemap;
>> > +=09} crc[AXIOM_CRC_NUM];
>>
>> I think this structure should hold all possible u33 CRCs and then
>> invalid ones can be ignored for the given u33 revision.
>
>Why should be the bootloader CRC interessting? The bootloader can't be
>updated/flashed, at least not according my documentation. Therefore I
>didn't listed the bootloader CRC here.

That is true, there are newer CDUs I did not consider are not available.
I shall hopefully soon update the python so that most usage revisions
can be seen more easily.
However this  change could be added later.

>
>> > +=09bool cds_enabled;
>> > +=09unsigned long enabled_slots;
>> > +=09unsigned int num_slots;
>> > +
>> > +=09unsigned int max_report_byte_len;
>> > +=09struct axiom_usage_table_entry {
>> > +=09=09bool populated;
>> > +=09=09unsigned int baseaddr;
>> > +=09=09unsigned int size_bytes;
>> > +=09=09const struct axiom_usage_info *info;
>> > +=09} usage_table[AXIOM_MAX_USAGES];
>> > +};
>
>....
>
>> > +static int axiom_u02_swreset(struct axiom_data *ts)
>> > +{
>> > +=09struct axiom_u02_rev1_system_manager_msg msg =3D { };
>> > +=09int ret;
>> > +
>> > +=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>> > +=09=09return -EINVAL;
>> > +
>> > +=09msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_SOFTRESET);
>> > +=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>> > +=09if (ret)
>> > +=09=09return ret;
>> > +
>> > +=09/*
>> > +=09 * Downstream http://axcfg.py waits for 1sec without checking U01 =
hello. Tests
>> > +=09 * showed that waiting for the hello message isn't enough therefor=
e we
>> > +=09 * need both to make it robuster.
>> > +=09 */
>> > +=09ret =3D axiom_wait_for_completion_timeout(ts, &ts->boot_complete,
>> > +=09=09=09=09=09msecs_to_jiffies(1 * MSEC_PER_SEC));
>>
>> Boot can take up to 2s with all selftests enabled.
>
>Thanks for this information :) I will add it.
>
>> > +=09if (!ret)
>> > +=09=09dev_err(ts->dev, "Error swreset timedout\n");
>> > +
>> > +=09fsleep(USEC_PER_SEC);
>> > +
>> > +=09return ret ? 0 : -ETIMEDOUT;
>> > +}
>
>...
>
>> > +static int axiom_u02_enter_bootloader(struct axiom_data *ts)
>> > +{
>> > +=09struct axiom_u02_rev1_system_manager_msg msg =3D { };
>> > +=09struct device *dev =3D ts->dev;
>> > +=09unsigned int val;
>> > +=09int ret;
>> > +
>> > +=09if (!axiom_driver_supports_usage(ts, AXIOM_U02))
>> > +=09=09return -EINVAL;
>> > +
>> > +=09/*
>> > +=09 * Enter the bootloader mode requires 3 consecutive messages so we=
 can't
>> > +=09 * check for the response.
>> > +=09 */
>> > +=09msg.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_ENTERBOOTLOADER);
>> > +=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLO=
ADER_KEY1);
>> > +=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>> > +=09if (ret) {
>> > +=09=09dev_err(dev, "Failed to send bootloader-key1: %d\n", ret);
>> > +=09=09return ret;
>> > +=09}
>>
>> A delay is required between commands. 10ms is fine.
>
>Can I make use of the axiom_u02_wait_idle() logic which checks the
>AXIOM_U02_REV1_RESP_SUCCESS? Arbitrary delays are always a source of
>trouble.

Yes, I tested with axiom_u02_wait_idle() which is OK.
I am slightly worried about too short a delay to axiom causing instability,
however this works fine.
It can unfortunately be an unstable device..

>
>> > +=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLO=
ADER_KEY2);
>> > +=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>> > +=09if (ret) {
>> > +=09=09dev_err(dev, "Failed to send bootloader-key2: %d\n", ret);
>> > +=09=09return ret;
>> > +=09}
>>
>> And here.
>>
>> > +
>> > +=09msg.parameters[0] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLO=
ADER_KEY3);
>> > +=09ret =3D axiom_u02_send_msg(ts, &msg, false);
>> > +=09if (ret) {
>> > +=09=09dev_err(dev, "Failed to send bootloader-key3: %d\n", ret);
>> > +=09=09return ret;
>> > +=09}
>> > +
>> > +=09/* Sleep before the first read to give the device time */
>> > +=09fsleep(250 * USEC_PER_MSEC);
>> > +
>> > +=09/* Wait till the device reports it is in bootloader mode */
>> > +=09return regmap_read_poll_timeout(ts->regmap,
>> > +=09=09=09AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, val,
>> > +=09=09=09FIELD_GET(AXIOM_U31_REV1_MODE_MASK, val) =3D=3D
>> > +=09=09=09AXIOM_U31_REV1_MODE_BLP, 250 * USEC_PER_MSEC,
>> > +=09=09=09USEC_PER_SEC);
>> > +}
>>
>> Just to note if we cannot enter bootloader with u02 due to a corrupted f=
irmware,
>> you can enter bootloader if the nRESET line is toggled 5 times without c=
omms.
>
>This could be added later on by $dev (maybe you :)) since I can't test
>this. Our system has the reset line not connected :/

Sounds good.

>
>...
>
>> > +static int axiom_u33_read(struct axiom_data *ts, struct axiom_crc *cr=
c)
>> > +{
>> > +=09struct device *dev =3D ts->dev;
>> > +=09unsigned int reg;
>> > +=09int ret;
>> > +
>> > +=09if (!axiom_driver_supports_usage(ts, AXIOM_U33))
>> > +=09=09return -EINVAL;
>> > +
>> > +=09if (axiom_usage_rev(ts, AXIOM_U33) =3D=3D 2) {
>> > +=09=09struct axiom_u33_rev2 val;
>> > +
>> > +=09=09reg =3D axiom_usage_baseaddr(ts, AXIOM_U33);
>> > +=09=09ret =3D regmap_raw_read(ts->regmap, reg, &val, sizeof(val));
>>
>> Could we read into a raw buffer to save having to define a little endian
>> version of the CRCs?
>
>I don't see the benefit.

OK.

>
>...
>
>> > +/* Custom regmap read/write handling is required due to the aXiom pro=
tocol */
>> > +static int axiom_regmap_read(void *context, const void *reg_buf, size=
_t reg_size,
>> > +=09=09=09     void *val_buf, size_t val_size)
>> > +{
>> > +=09struct device *dev =3D context;
>> > +=09struct i2c_client *i2c =3D to_i2c_client(dev);
>> > +=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);
>> > +=09struct axiom_cmd_header hdr;
>> > +=09u16 xferlen, addr, baseaddr;
>> > +=09struct i2c_msg xfer[2];
>> > +=09int ret;
>> > +
>> > +=09if (val_size > AXIOM_MAX_XFERLEN) {
>> > +=09=09dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
>> > +=09=09=09val_size, AXIOM_MAX_XFERLEN);
>> > +=09=09return -EINVAL;
>> > +=09}
>> > +
>> > +=09addr =3D *((u16 *)reg_buf);
>> > +=09hdr.target_address =3D cpu_to_le16(addr);
>> > +=09xferlen =3D FIELD_PREP(AXIOM_CMD_HDR_DIR_MASK, AXIOM_CMD_HDR_READ)=
 |
>> > +=09=09  FIELD_PREP(AXIOM_CMD_HDR_LEN_MASK, val_size);
>> > +=09hdr.xferlen =3D cpu_to_le16(xferlen);
>> > +
>> > +=09/* Verify that usage including the usage rev is supported */
>> > +=09baseaddr =3D addr & AXIOM_USAGE_BASEADDR_MASK;
>> > +=09if (!axiom_usage_supported(ts, baseaddr))
>> > +=09=09return -EINVAL;
>> > +
>> > +=09xfer[0].addr =3D i2c->addr;
>> > +=09xfer[0].flags =3D 0;
>> > +=09xfer[0].len =3D sizeof(hdr);
>> > +=09xfer[0].buf =3D (u8 *)&hdr;
>> > +
>> > +=09xfer[1].addr =3D i2c->addr;
>> > +=09xfer[1].flags =3D I2C_M_RD;
>> > +=09xfer[1].len =3D val_size;
>> > +=09xfer[1].buf =3D val_buf;
>> > +
>> > +=09ret =3D i2c_transfer(i2c->adapter, xfer, 2);
>> > +=09if (ret =3D=3D 2)
>> > +=09=09return 0;
>> > +=09else if (ret < 0)
>> > +=09=09return ret;
>> > +=09else
>> > +=09=09return -EIO;
>> > +}
>>
>> There needs to be atleast 40us holdoff between axiom bus transfers.
>> I am not sure that has been considered here.
>
>Is this written somewhere within the datasheet/programming-guide?

In aXiom Comms Protocol in v4.8.9 if you have access to the webportal
it says to use 40us holdoff for report reading. Although this may apply
to all transactions.
Doing comms while axiom is changing the DMA causes issues (NAKs), for the
driver I posted atleast, the holdoff was required otherwise I would receive
0-length reports frequently.

It looks to be fine currently, however if there is unstability for users
we should consider adding this or something similar.

>
>...
>
>> > +static enum fw_upload_err
>> > +axiom_cfg_fw_prepare(struct fw_upload *fw_upload, const u8 *data, u32=
 size)
>> > +{
>
>...
>
>> > +=09cur_runtime_crc =3D ts->crc[AXIOM_CRC_CUR].runtime;
>> > +=09fw_runtime_crc =3D ts->crc[AXIOM_CRC_NEW].runtime;
>> > +=09if (cur_runtime_crc !=3D fw_runtime_crc) {
>> > +=09=09dev_err(dev, "TH2CFG and device runtime CRC doesn't match: %#x =
!=3D %#x\n",
>> > +=09=09=09fw_runtime_crc, cur_runtime_crc);
>> > +=09=09ret =3D FW_UPLOAD_ERR_FW_INVALID;
>> > +=09=09goto out;
>> > +=09}
>>
>> The firmware CRCs dont need to match for a config load, only the usage r=
evision/length.
>
>What difference does it make? The firmware CRC implicit includes the
>usage revision and the length (register layout). So we can ensure that
>the configuration was made for the correct register layout without
>checking each register and revision.

Different firmware revisions/CRCs can have compatible usages.

Aslong as the usage revisions match to u31 the usages will be compatible.

For us atleast we have different CRCs for small firmware changes, therefore
if testing such firmware here we would always have to uncomment this sectio=
n.

In the updated python I changed the check to the following:

     # Compare the firmware runtime CRC from the file with the CRC from the=
 device.
     # Only proceed if the CRCs match.
     if not force:
         if u33_from_file.fld_runtime_crc !=3D ax.u33.fld_runtime_crc:
             logging.error("Cannot load config file as it was saved from a =
different revision of firmware:")
             logging.error("Firmware info from device      : 0x{0:08X}, {1}=
".format(ax.u33.fld_runtime_crc, ax.u31.get_device_info_short()))
             logging.error("Firmware info from config file : 0x{0:08X}, {1}=
".format(u33_from_file.fld_runtime_crc, u31_from_file.get_device_info_short=
()))
             return ERROR_CFG_FILE_NOT_COMPATIBLE
     else:
         if u33_from_file.fld_runtime_crc !=3D ax.u33.fld_runtime_crc:
             logging.warning("The config file was saved from a different re=
vision of firmware therefore it may not be compatible:")
             logging.warning("Firmware info from device      : 0x{0:08X}, {=
1}".format(ax.u33.fld_runtime_crc, ax.u31.get_device_info_short()))
             logging.warning("Firmware info from config file : 0x{0:08X}, {=
1}".format(u33_from_file.fld_runtime_crc, u31_from_file.get_device_info_sho=
rt()))

     # Now ensure the config is compatible with the device
     valid_cfg =3D False
     file_usage_table =3D u31_from_file.get_usage_table()

     for usage in usages.keys():
         if usage not in ax.u31.get_usages():
             logging.error(f"Usage u{usage:02x} unsupported on this device.=
")
             break

         usage_entry =3D ax.u31.get_usage_entry(usage)
         if usage_entry.start_page !=3D file_usage_table[usage].start_page:
             logging.error(f"Incompatible config address for u{usage:02x}:"=
)
             logging.error(f"  Device: 0x{usage_entry.start_page:02x}00  Fi=
le: 0x{file_usage_table[usage].start_page:02x}00")
             break

         if ax.get_usage_length(usage) !=3D len(usages[usage][2]):
             logging.error(f"Incompatible config length for u{usage:02x}:")
             logging.error(f"  Device: {ax.get_usage_length(usage)}  File: =
{len(usages[usage][2])}")
             break
     else:
         valid_cfg =3D True

     if not valid_cfg:
         logging.error("Cannot load config as the usages are incompatible w=
ith the device.")
         return ERROR_CFG_FILE_NOT_COMPATIBLE

Possibly we could add a force parameter to the sysfs like above?

>
>...
>
>> > +static enum fw_upload_err
>> > +axiom_cfg_fw_write(struct fw_upload *fw_upload, const u8 *data, u32 o=
ffset,
>> > +=09=09   u32 size, u32 *written)
>> > +{
>
>....
>
>> > +=09/* Ensure that the chunks are written correctly */
>> > +=09ret =3D axiom_verify_volatile_mem(ts);
>> > +=09if (ret) {
>> > +=09=09dev_err(dev, "Failed to verify written config, abort\n");
>> > +=09=09goto err_swreset;
>> > +=09}
>> > +
>> > +=09ret =3D axiom_u02_save_config(ts);
>> > +=09if (ret)
>> > +=09=09goto err_swreset;
>> > +
>> > +=09/*
>> > +=09 * TODO: Check if u02 start would be sufficient to load the new co=
nfig
>> > +=09 * values
>> > +=09 */
>>
>> It is not necessarily needed.
>
>What do you mean by this? Do we need the axiom_u02_swreset() or can we
>just start the system via u02 (without swreset)?

There is no need to do a reset after a config load you can just start the A=
E
with CMD_START, but we can keep it as is since it does the same thing.

>
>>
>> > +=09ret =3D axiom_u02_swreset(ts);
>> > +=09if (ret) {
>> > +=09=09dev_err(dev, "Soft reset failed\n");
>> > +=09=09goto err_unlock;
>> > +=09}
>
>....
>
>> > +static ssize_t fw_variant_show(struct device *dev,
>> > +=09=09=09       struct device_attribute *attr, char *buf)
>> > +{
>> > +=09struct i2c_client *i2c =3D to_i2c_client(dev);
>> > +=09struct axiom_data *ts =3D i2c_get_clientdata(i2c);
>> > +=09const char *val;
>> > +
>> > +=09switch (ts->fw_variant) {
>> > +=09case 0:
>> > +=09=09val =3D "3d";
>> > +=09=09break;
>> > +=09case 1:
>> > +=09=09val =3D "2d";
>> > +=09=09break;
>> > +=09case 3:
>> > +=09=09val =3D "force";
>> > +=09=09break;
>> > +=09default:
>> > +=09=09val =3D "unknown";
>> > +=09=09break;
>> > +=09}
>>
>> The following are all the variants we currently support in order:
>> FW_VARIANTS =3D ["3D", "2D", "FORCE", "0D", "XL"]
>
>Means:
>
>0 =3D=3D 3d
>1 =3D=3D 2d
>3 =3D=3D force
>4 =3D=3D 0d
>5 =3D=3D xl
>
>?
>
>This is also something I can test on my site. Patches are welcome once
>this is mainline of course :)

It is like so:
#define DEVICE_BUILD_VARIANT_3D       (0U)
#define DEVICE_BUILD_VARIANT_2D       (1U)
#define DEVICE_BUILD_VARIANT_FORCE    (2U)
#define DEVICE_BUILD_VARIANT_0D       (3U)
#define DEVICE_BUILD_VARIANT_XL       (4U)

>
>Regards,
>  Marco
>
>--=20
>#gernperDu
>#CallMeByMyFirstName
>
>Pengutronix e.K.                           |                             |
>Steuerwalder Str. 21                       | https://www.pengutronix.de |
>31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

I shall try to give a more prompt review once you have the new version up.

Many Thanks,
Andrew

