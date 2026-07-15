Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5828DC4;
	Wed, 15 Jul 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097262; cv=fail; b=KeBXc1V9JV01nOieXJnVzC3PnehOAkA/jzrqQfj8dmmMUfUJKBD4IoVuPVMOqAGYqUQ/ZzUVok+sDiPMu415pVrol6vxYMtJU2aQYJZ/eWixtwAHPhzE+1F5LrF39HVmfky68sf5wBMJ8H8B6hTT31BdhdEdUoegjhp5YFmw3+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097262; c=relaxed/simple;
	bh=Q+36J0rIDfY87N7Y6F+82T3eaGpEb4Ytp5lwKGP3J5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8kWYL5OHLxnOF66GlWF5tCOWIJsM5kuhwCAlMqkcVBHd52REqXUYZcZmcifClHQtxvMAAA/E6dwURXJFP6dpp0xEmtxD6cVBLSmXkFMciekVZzYZAD4dl26SMbc86FGuZETzfHNp3OFcHN8U9+8hH2pEuql0/7e+pvUzYgCOuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bWzEFXYR; arc=fail smtp.client-ip=52.101.126.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bWzEFXYR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S13x5TrEO62NC2llLdk0ufNbBOIWDbJ9wzQNofvYaIzZZtKrutByzh5uqhKCpsl0JYEwz4sZWrPc3FJO6PwXZAhj3YpwdDz8XC95Yi06l5gssce407SnqygdQe4ORwTY7vUY4TNl5HKbASruvbn+RgLVpUg3/7v4kzdObEcFWU0+hlg31hM2DmVPZA3Wi8H+CU4vbr34U96qg9F8Wasiid5asULpl/OFiJJmnDDWDh0kCyX8qjvsbp1HkDIEalsEF3gKd+It2wc4g6ODMiu0sK0YSeWK4zPttgdPDKRJJG89X82NBcToiPCcfWPyAE16eZdLXfCOkWpEAovmqI3DAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/AZvyyuuXnqUKPLLhwKvLDVwLbuiT0oLYiHg230AtI=;
 b=BrnmaCDFw7H/2UnP71QbBeZDEOJ0pL5L7NZgFS33WYNDAkU56TMtkDZCnKc5bw5yZFRtN1DtsV6jB452duyiGyuwc/qKSp/7yLzLHCPWGMwmnYz6+EmjxDziVzRXgDNuHIUbFiFXTz3DqX3VPSyXTzjVTxoPFJOsRPDI66agIsQwv/EPsCfp9IW0IydY4uOtZbexVymXpMDMNvQ63q34ouEnXB3oXS+NWXzy7W4xw10LWnJITm3ZSH1I66s6DB0WlntrhpcdCXvvI63ilrb7hnClecKDJCYOy1w3vjub17Ya2w2ulwO3eKdKshAYqcdEW+hMncYtB3nENLhvUgAXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/AZvyyuuXnqUKPLLhwKvLDVwLbuiT0oLYiHg230AtI=;
 b=bWzEFXYRO8+typamhrA8Oktb6BSAoKSf5PGizAWCpIBsnIeYJLDbdHyZioAmM/uF7iSdmasxzJ9SWNf4diAZV6e3hW9ga9stw6xmx8CUzTJBGrqcw8R9a5SBAMTNMY7yPNeMS9jav3Huk/FDB9AAYSt5AdkbOTUiR60DXedxO2Hl1P6Qo99cY4P5iwmtU2gWnPf2LC39yyv9fI/nnGFSbB7w+UBFyO0HM/1RTJGhjd/ubxajqVCEn/MY8hfztXUJZieEjfdmjYHEWieGRqxFLeOD7UV4mcnbMRLOz1y75dWX0sjPgxcXUvfNFG8rEZiw4q6600YiC6i91p7SOFpeqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY0PR06MB5610.apcprd06.prod.outlook.com (2603:1096:400:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 06:34:17 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 06:34:16 +0000
From: Pan Chuang <panchuang@vivo.com>
To: even.xu@intel.com
Cc: abhishektamboli9@gmail.com,
	bentiss@kernel.org,
	d3z.the.dev@gmail.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	panchuang@vivo.com,
	sakari.ailus@linux.intel.com,
	xinpeng.sun@intel.com
Subject: Re: [PATCH 4/4] HID: Intel-thc-hid: Intel-quickspi: Remove redundant dev_err()
Date: Wed, 15 Jul 2026 14:34:06 +0800
Message-Id: <20260715063406.476663-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <IA1PR11MB60987170F254F4152C1F7C95F4F92@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <IA1PR11MB60987170F254F4152C1F7C95F4F92@IA1PR11MB6098.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY0PR06MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a359197-129a-48c0-59d2-08dee23b17cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|6133799003|22082099003|56012099006|11063799006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Yh91m60XkvzsAapateJ45ZBSFtvkwfH6vnaGmy++fZ0hof3kr+I1BKz/sXDM+o0wIZahjpHmgQd+diTegYHj7I/KDszhqyr0R0Nx5wAbDb52R1Y/LQ9oRBBqGgy5SyTGxpKjzbzkKKrp5aTnsV9YFbBfUa/reO/JILIv/UTqQVjN28Se4BsgIxU7S0aGCXEDDXc2jzoNWPdSX5epoZ+q7LrDjNvI9wGcOp8wmC4EoRTqiqNXCq5b411OdzdCI62oUD7zTIt3GeGZlsc2ltqYeSJQduN3SSrB3jP/RM8rs1QeA+b4ZLv5TfF4kB5WjiozPmqqkUOYRRwuq1e2kzUzVwjxtJY39wegGNrNxBJLvaD6vYsGmtiiBJ79uekcgztTAc+Hyrq8nRA7RTbcNWuTPHiRnynzu67ClSs68zk1BABHgCaHzj/u9Cdlx0SwufsTdC33Un2ePz9eGki+jQB5pgSRuJ6YTAN9Do6skJvpvEOFUe2REhaPlEQSdWUZkepUvUf/uvgG1gU/ZUhUC24HTyGcTDlyUc0Y4h/rtaiwgFth84u7hhLl8s9aLEctLxjPlZ37jmsTYbSxx3ZR80tLlsdDm3S6vW285k5qeVrE6x8uOcMOgPS9VneTY2VFOUpzcClc6bIgaO//HIKQVAGY6IXjmmjG+newOoArdqH2lEoBEaNTmGrGc9eUrBulvmXK/ivjjcSvqS76mIOpIQKF8VsTCqcjzeEr1hzy7ZH7HC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(6133799003)(22082099003)(56012099006)(11063799006)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l02vgaLtA74C8xy3zqXi/q29yce0hmMJHr+uhQexIPAN5muqx9ns3un3jxaN?=
 =?us-ascii?Q?/7L7JOaaJWDuhIQm5g/Hf0w0cDF2VA82LntPsg3UgBacOAKww6vuBAXpYj3q?=
 =?us-ascii?Q?mZ6Hetgj0A7ziyg0LgLMxFrW93WhoqzyUXMRFFxzSS2i7bL6pI/2W7Knrsj3?=
 =?us-ascii?Q?gA5tCetCXNGVpHdxiiBNTL4Oq2t81eqPf5YXrmnm7lplhG1J+nXtuP9UWFXM?=
 =?us-ascii?Q?z7JZU+U/lErCUgJt55qrFj0bBCu5qkvgBPT3AsVMRsPTnMrg8Grcxz8bWaG2?=
 =?us-ascii?Q?Fhj5N9Oiq/PaVNmVI6GU77AAKCkQ/h77DykZ7LZEXy+sWFEQaDUKa0FKIj1b?=
 =?us-ascii?Q?DlPj0D635S/SGHJBlzXS2wljy3sIkZ9P5h2Y09bRkAIgtye+twNpRRP5ITwY?=
 =?us-ascii?Q?YWoma3bXORf1VNWJXrOlzrkWxga0uyIgnENaiabfTDh4rhdWndta9BP0R7po?=
 =?us-ascii?Q?4vB5xyoFLMiGtL+bZnJKkyzeOyMZcowrAqMcZ3bbIHbbRMzWdoJM8EIRiODj?=
 =?us-ascii?Q?d21YBEEalhQMbFoONFh8QE7FVtdqcmcGvk+l5kx8tGUsiUpc5C/6PtNefXyo?=
 =?us-ascii?Q?MUDhu2PN4V02JMZCFCHgZODQZFqx7zwNgepE00TZC3B9BWkxHvtlvihryorm?=
 =?us-ascii?Q?a0QFRXLZri4pCzxT4ocWs+Clvq7R9nTNDJxZIecb5YNmD/73h7bOlpvNx1le?=
 =?us-ascii?Q?lsxgS0vYHTadml6AYMcGnH5daBiJBv3Dm6VYGjJav30rEIJxiHMXyeo3gvWQ?=
 =?us-ascii?Q?rA8CKTc3z2hEUsU3W9gr/EdjBczxmimKyWpSsunXBrkMOMNcz8988VjqNXF4?=
 =?us-ascii?Q?nmtPsJKUuw3g6vgJoEI6DZN4gHvWMgPPDgi2CG1pPlLAkpFSk8vRsNbMogRQ?=
 =?us-ascii?Q?Gi8k/H5gA0dlBo8dDYISAJUd+c6b0a02szfhjJi0hFfv8E+D4sEf4SiphrKM?=
 =?us-ascii?Q?Zqw35PRMvpB1FtHjhwSpWDI/kKISYHOOcsgMSWcbJGmCai0a46IQOFquTFOQ?=
 =?us-ascii?Q?t741UEEmJ5qXogSI/Co8uFBlvAnMHQ3LYhwZErBdLa31jPJNvbrhn60fipML?=
 =?us-ascii?Q?fOYNMUzWbjSmQnzAsgXmn3GdOSKF5hdag+xEV1n98EI8Kk4bWji17WyZpANC?=
 =?us-ascii?Q?NFnuI9uobi/nW38B70Tg40L5OwR+X9sIcMebsSG0DEMMvhG2zkHSH6eIrCQf?=
 =?us-ascii?Q?dftafwJc069rTnbQTDv5nSYxT2JOXq01owa/zHHQBCdp4v06u4wgwAtxgvuR?=
 =?us-ascii?Q?AenaTOftSATfTYuBF0xyaabIIhYeKoXglVtPYbq8bEQ/qEY+7SHhzB+aN6P5?=
 =?us-ascii?Q?NWp9CY5cveIijB1FYO/HW4mTK3Xmj3a2TxGBNc9ULDfLy36seo9SBvedsHil?=
 =?us-ascii?Q?Wi0W4qFHQvQ7cws8f2Eb1x8FbzyYrpoHgzGNUrhzWQfBBOLuta/n/2K2Hlio?=
 =?us-ascii?Q?QzJDhKqKqSETsEy+VQIK8EUeO1BFEj/VDgUWoYlVT/PxsLoI1q3alF6vg1kC?=
 =?us-ascii?Q?2zpDOZt0mTGtvsBK2feT0Ca/RO3QPLCA4Rtrj5ixCcODGHpe4K5XC7GiNlkl?=
 =?us-ascii?Q?gpQa2DubUD4HEISjqVkKroqswBzOvLShewTibZFziB0hlDV1cBx5TdtEYOx7?=
 =?us-ascii?Q?Rh2VOyu6M+0Y9mWKEUk4HQeHTj8P44pnlJX29w/FlVMU2ORmwS+pnN7LWsLz?=
 =?us-ascii?Q?bT1hv25kvMGPuoh1mSGHVM+9dfOIxIqofGZKaxvcb2QU0FbdynBzqIt9J5x3?=
 =?us-ascii?Q?Oun22QAAKA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a359197-129a-48c0-59d2-08dee23b17cb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:34:16.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1w46R1EPWFds4GkKTRkERH4J4w42C9uLboQBNmuatKK6ERyzzV6S3VcJJOai2b9L0pftCIFyRLMJejRq+P++DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5610

On 2026/7/14 8:50, Xu, Even wrote:
> Thanks for the patch!
>
> If this is the case, can you also do the same change for intel-quicki2c driver?
>
> Best Regards,
> Even Xu
>
>> -----Original Message-----
>> From: Pan Chuang <panchuang@vivo.com>
>> Sent: Monday, July 13, 2026 9:25 PM
>> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; Jiri
>> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>; Pan
>> Chuang <panchuang@vivo.com>; Sakari Ailus <sakari.ailus@linux.intel.com>;
>> Abhishek Tamboli <abhishektamboli9@gmail.com>; Danny D.
>> <d3z.the.dev@gmail.com>; open list:HID CORE LAYER <linux-
>> input@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>> Subject: [PATCH 4/4] HID: Intel-thc-hid: Intel-quickspi: Remove redundant
>> dev_err()
>>
>> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
>> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
>> detailed error messages on failure. Remove the now-redundant driver-specific
>> dev_err() calls.
>>
>> Signed-off-by: Pan Chuang <panchuang@vivo.com>
>> ---
>>  drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
>> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
>> index 4ae2e1718b30..504ef3c842ab 100644
>> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
>> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
>> @@ -636,11 +636,8 @@ static int quickspi_probe(struct pci_dev *pdev,
>>  					quickspi_irq_thread_handler,
>>  					IRQF_ONESHOT, KBUILD_MODNAME,
>>  					qsdev);
>> -	if (ret) {
>> -		dev_err(&pdev->dev,
>> -			"Failed to request threaded IRQ, irq = %d.\n", pdev-
>>> irq);
>> +	if (ret)
>>  		goto dev_deinit;
>> -	}
>>
>>  	ret = reset_tic(qsdev);
>>  	if (ret) {
>> --
>> 2.34.1
>
Sure, I will apply the same change to the intel-quicki2c driver as well.

Best Regards,
PanChuang
