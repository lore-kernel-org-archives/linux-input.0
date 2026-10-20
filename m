Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792534165;
	b=JMu4WXwekS8oolD07LWuIZGVbZRxHpi/xpFo9iirw3YLQaa8yOmHj8PaQutzlfg3cMmj
	 0mqAy1aRI4dTR3lK6k/UDcMa8XtvjAkmuzZuuXpxgAHr9GB42sbpYIO7NB1kcSm8jZtku
	 RPofkgEYvJhS2SSuwaTKJ63v8JGn+FuUJkdZyH57IXfXWFFACHyozgxODJ4qjnNBYzZHp
	 DB5oW3JWxRXzAGPcFvm3GH6YlGaHHrkQig7fl1dgdpUVNlEJ/Hw07h/iU1AAHK3H8ceZL
	 OLObSsar3KbysP8PyI0QAy9WHShoOJRgI1ba6CHhEfKLR/J3gLTL25TJnmpLNX1a2dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534165;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Zo6yFst62W65naiSSqmRo6JXEdZESlqlCXYpRfBFUPA=;
	b=LpsnZG3FDUgdSnitGyQTYl/iaaI2cRawRJQ1dVH9C9r5iLPq8idNxTNcR2u5pANMTig1
	 AQ0i6I6oCo5SfBGYpxYZsZKciIxvRAaddx/AUpHerCgI2f+M37Lx7uQ1N4IvWUFWbVeg5
	 8svU3P6Vbp+hMBAJ5G8o92WRWCn+5f+uJFn5HwxKYG4P/Z2UuWUrck4MDmdW3YoSU99m7
	 pY0oZ0PGr+3Ib/ukDPhYnEa/JfCxk3+hSWfREYDYSgErDL01F/ExvIUhi/EJ+JUfouev2
	 49Jxy3oTpOaj+Z/poMGdBJzac/t4PmBDgaX6AJOlGgOlALEyHr0J0RnQA/vfd+SokpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AJ3xEjlw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A31606A319;
	Tue, 20 Oct 2026 22:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A31606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AJ3xEjlw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH2BEg5ygAMDYZm1h14aZUq+U4jgecC0xMA5lC7TdHyO/MY/HXim0KUwmJAa2BdSsISpE9oPyNcreCRpw4Y/BhYkCz18c3xVlnELEltK9n8HbagKg7sscRTrolOPkJ6iMlFW9/6fAOsuy8UxOY6IzuHOo4cWu2twvqSIfEEvCS+QYN8pnVzU+9YcnH+wguNYQKQw8VTL8ME7xX7sow7TM9GHgHOOX07zr+Ln2Ow7WYb1RYDHVm3FDvHYtiMD+qfXL8rxwnPcSVqiEflzotTC7N5Qo8Tzquj4r4nkBlk0Y691Z3CyIo0x9ATgy6CCdM2XZW/t5oEc2BfGstIRUcehIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo6yFst62W65naiSSqmRo6JXEdZESlqlCXYpRfBFUPA=;
 b=qg/iek2qvtMSdcFbO8qoSp7PCST03mWWmuq731UxgC3syD6PuA5UzJKXU/dO+jMf76CR0f46nt7reqQqPZAk68QniYlbZaHkAvkgBxc5qlE0d15mMBnj0xhigtzTq02jAlT3k8fVppCp/9CMiJg9QJzwRpHs5KRh2y8NqjMsfyiJniSpixIF11c7KpkFdoZKr42f+ooQDc1CgTf5ZWWfTNMXBbptbqAs1ZT8ygdv9vFCRJz9vJKa7wV+ErVESUxj9uHtWz4iLmmyjTppxJLnb7VFx5kgVDsJvLMiqMGVoZE50Bma8ggzQqrHhvN1d4LjJml7OKAEOBa/WhAmvv+PxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo6yFst62W65naiSSqmRo6JXEdZESlqlCXYpRfBFUPA=;
 b=AJ3xEjlwCi5eToi+xJCW+GRDGFRJB5jlxN0wotPIqaxRS+q4Tlfia6xWLNIZM2vhQZrTbgi57qkmPQZM0HrgCMJyvkf+pUC67clNe/cnuwjVqhc9UP0EKT3JclCiTnohEGVve8614sz4ZN2NkapE+1JQiFdo9gZjSPkrb8RLmKPhLzuPBqvfdri1RaQiJ7xRTfRFbm1CioVmIP0CfGPZmBqgZCsmiJ2XmaP4NKBEDZbRrpg0kb+01IncB5dfmSoEEkSSrA9Dn+H89I4PlF71jLmf6NM2ER6tWECBShU8yG9ODsioUEBJUDusFg+4zHdBgKoWKUVPrgkzzvtE67jiow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 22:09:21 +0000
Received: from DM4PR12MB5102.namprd12.prod.outlook.com
 ([fe80::36e8:500b:ecc:e0f4]) by DM4PR12MB5102.namprd12.prod.outlook.com
 ([fe80::36e8:500b:ecc:e0f4%7]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 22:09:21 +0000
From: David Cemin <dcemin@nvidia.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] HID: asus: map Consumer brightness usages on I2C keyboards
Date: Tue, 20 Oct 2026 15:09:19 -0700
Message-ID: <20261020220919.611287-1-dcemin@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To DM4PR12MB5102.namprd12.prod.outlook.com
 (2603:10b6:5:391::21)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5102:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 981b9d4c-b5f1-4f85-8ea1-08df2ef6cb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	by88Lqr9CUcvn2Z9zoxwGsmCsXvr9jMwLCGMF6/JGoLNAse4JSJ3kxlCu68DZSuDc1kxoLZYA8T/qZhUGPteTV5wT57hw1uiY4N+nlcdHHwWfxNeOY8Cs44AHca6BnZuTWwEu4TmerZ74C5vZEjp6lFIPDc17kWgvy+adTwrhNhOjjjSNncTiV0GogLj2YlzaWDwiAv8UVNfKrLITDJqN/VAx30CpQKWPxmXeA6GO/bkV7ftAWCjIsoEBoVVlmO+kwVT8JiRuw+0xAB+heUVDbFRkkNULjQlsBBNX6zhOEu3ffliEHeVgnttoDlD7YLtzlW2gtF7+oxHDbr0wRVQ9/5x7ZOPHJnuYE6lOQ+PEUB53rWlPUqJZBOAPi8+Hs1GCyyv6s78XyXAlkVD7lYwtyusdLHSOR9yvCKYZI9Dapv9L7CFg3hZMnvOzOSCMfshos4d8pcNR0NSmDSycLqtJlZW25mHNHQKmjc1jGNKounyMFsg/s773y3jakoVrQ+q2ed7rUYtg249HlJXJwk+BPbtQCop0nck8aM93CuoOQEz2fcVSR4TiIAXPzEPqTH2/WCf/9LLjT9Q3DbJghSOz2Igb6wPj91UPOUb43QsCcfKATgYLAdUnvosj7ToWLass+F4E9Kiz/a8NTv8bkasLmsFwksdjfgo1of8t2CvGn8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5102.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(11063799006)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WI8RJLgZ0D1ShcQqLFd96p9KIRLmjv3D1Gzzk380yuifBBgvt/oDzEr2XrPJ?=
 =?us-ascii?Q?9NUIUlLR+4MBJreDzb/x9L+U8V52bCCd+zLZ7l2CWPCG/hZ+qhJE5IgO7wUy?=
 =?us-ascii?Q?F4JkBlOXvr67AmPA+PHLFsRvd3TnjreaVJ7nqyTGW/OqujHSAXGD332ps0Bw?=
 =?us-ascii?Q?kBKSxUEmQDjnP2drB9338fq9hqJrkBwQZIRgLafWHf3jtRKk00zm/z37edJT?=
 =?us-ascii?Q?KkDeREKV4gtuBDbAMJPSFvwm2Tkxdng30+fpFwPNuFT/XThCm5aNi50EYwsI?=
 =?us-ascii?Q?G38WtF/A8c3ZAN/5JXWhcRNxzuSRY6RfBnMCx8SHVceq6dA5vH/P5Ib7dE3U?=
 =?us-ascii?Q?2JXVgIIpb+D0XK8yRbZA8ZqDKvyzPN+3+kPpZbqMy9wL0OdE0XQaDoSeEjWh?=
 =?us-ascii?Q?+DqcyruR7voplTZHxxQRyxs5Ylc8OJvsiI0dSfUFNVlpZdTR47vuO2xvfb74?=
 =?us-ascii?Q?Jb25Qwd5JT5iMSzmWhAsXVRV0VGAO1FrX22oW+iiwHxQPU8ZFSNWZ+2NR/9u?=
 =?us-ascii?Q?xjzaSrXaoN1x3uDPOftISlndEoxHYMXnmrcQmUKpwhB+0UKpi+jZYgc3kHyK?=
 =?us-ascii?Q?gfQYax+WaIPHWhKmRpk+/FUBVZeKanDUsZHygoQTZw1DLQp/WsHlktS0VdG0?=
 =?us-ascii?Q?koUdsDDTUUeFbux1LsuRweSRylP4LzJHTAKWi4svIHjQZ7TbTzNDtTwvYRau?=
 =?us-ascii?Q?LWpOh9OoUEiv7eI0VaNJ5GlxocA9EjNGg7jjdrmVvK8wIA/Jm2CdTK92wZQr?=
 =?us-ascii?Q?NlPCKz2JdhIWwu+xjJ/oe8LNsB5mHUokrQvaTaHl0/2AF0VxOv69cjLvOEUr?=
 =?us-ascii?Q?vso3MUk5y6fnDFmpH6UDcZcg9V8B01QEMGREUmfqi2bk9uSzsVvOXcjNDVxq?=
 =?us-ascii?Q?4OJpnDMqO3mVwY+whdHnM6dxiHn1XUFs6QSb50rDcaKaDiShZQyMy30mXzPk?=
 =?us-ascii?Q?GmWmdbwcjzPxunZx5CUPLbjVq06PYxlP6M/k9wLCY5yycBZIHfrjz0g1xyyt?=
 =?us-ascii?Q?JqczIi+5wZuP2kPERwPV0/RuYxsXRWroEvgidE/2A2amRkGH5vjsjOp3TV9n?=
 =?us-ascii?Q?CaRnwNpkAzOZzaX66KTHbuV4D693x5CPPUN3+/z+DxRA0aRdK2gTgopmW0VP?=
 =?us-ascii?Q?tvySAn/oTAdiVrRiUASg8wHzVTa/WQ2lw4LJOwou7dNo8HLwjkj6gQjAYtuH?=
 =?us-ascii?Q?rLz8WIU9Cxp9rIISzNKI12HBukI6TlMtxGSs5d5pgzVSQNy9OxSo9q95SoxR?=
 =?us-ascii?Q?H9BUz135rEcoTIVqoXn9IvNd9HGIX6HmuJKWccqXk91By2cF0+XygN9W0zsz?=
 =?us-ascii?Q?uzLkD3wUYIv/SDIpEgoBDTKt3GJ+Aq6WAdu0TPXg9Dj/uB+fwk8+8oD8EwYL?=
 =?us-ascii?Q?JKcr20Mc7+Y783jgmFQiZyWK2PKvHZBvAhTlNviC/f8eFSsuhcdBpYkMY83P?=
 =?us-ascii?Q?WC39JfJhtm3X/RJeVS3XD2jTDxPSCqqz1zn7g5jSdbpViMTx4M2m4QZabqcY?=
 =?us-ascii?Q?TwpOPrpIhJoPurH3kMRPgq9Ek3L5NMBGXArPGPWk99i0q/g2CMOmuan/ID3C?=
 =?us-ascii?Q?du++PZfNnMHcoBIQvZT+0yqf+uYsPSRVF5FX1GEiRWZZ6EzWGOw/ZN3wa2vB?=
 =?us-ascii?Q?rPhzKsWXB9o4s8ExTPyTntQ43/Qq8gpvQlMqxSEUex6mZ5MvD2Ue2DOEb9us?=
 =?us-ascii?Q?v56i25mtEQWDP9wxAvjSJTl1JgOiIKmA+loeOCIJZLWkfeJqgeHDaJfkrh7y?=
 =?us-ascii?Q?o0ayg/aSsQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981b9d4c-b5f1-4f85-8ea1-08df2ef6cb28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5102.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 22:09:21.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2fsPNZMzm6gH/0Yjq/Xo8pZMxVjPl8Why2WldtN6gNgyRwV6+nzi2bRG1GqZzuev6MYnES4C95ZsBk9s4b0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373

Several ASUS laptops carry their keyboard on an I2C-HID device with ID
0B05:4B42, the same ID as the Zenbook A16 (UX3607OA), so they bind to
hid-asus with I2C_KEYBOARD_QUIRKS since
commit 206107536018 ("HID: asus: support the Zenbook A16 (UX3607OA) keyboard").

Unlike the A16, which reports its brightness hotkeys on the ASUS vendor
page, these keyboards report them as the standard Consumer usages
Display Brightness Decrement (0x70) and Display Brightness Increment
(0x6f) on report 3. I2C_KEYBOARD_QUIRKS includes QUIRK_NO_CONSUMER_USAGES,
whose input mapping ignores every Consumer usage except mute and volume,
so the brightness keys never produce input events. The keys work when
the keyboard happens to be bound to hid-generic, which maps those usages
by default, and stop working as soon as hid-asus claims the device.

Let the two display brightness usages through the filter so hid-input
maps them to KEY_BRIGHTNESSUP and KEY_BRIGHTNESSDOWN. Keyboards that do
not report them are unaffected.

Tested on two ASUS laptop models with this keyboard: with the keyboard
bound to hid-asus, the brightness keys now adjust the panel brightness.

Signed-off-by: David Cemin <dcemin@nvidia.com>
---
 drivers/hid/hid-asus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c38a2b3b33d9..cf21eee68419 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1311,6 +1311,8 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xe2: /* Mute */
 		case 0xe9: /* Volume up */
 		case 0xea: /* Volume down */
+		case 0x6f: /* Display brightness increment */
+		case 0x70: /* Display brightness decrement */
 			return 0;
 		default:
 			/* Ignore dummy Consumer usages which make the

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.55.0

