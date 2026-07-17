Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4633E63B0;
	Fri, 17 Jul 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282186; cv=fail; b=Wr//jFGt5ENUOwoT64fRvqnu8ORgi+CR/nNCDndJsW5wVn0hkhMRYMZWON5OsINs3fMQ7unLdY7ujG/qMaI5I4IcRiiwAOgPJUPhcVCpOgRh7EZh7f2VOTjJXoPVRx7PoITgGGdjNTeJCtJCJ69P5FaTwxKW2hdIwgKj/o6IV38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282186; c=relaxed/simple;
	bh=+3XIZLXk1V717Yb3IMAyyvox131EDI/Vsg3GekvSSZc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EJ00j5hgMciyxIibtnsdRzAst8N9AdoAAuXsUgosAsfHv52x4bP7w9/BpKcqf/9bd89/PLCgFqw+ECfSkbcmZmsVC4lQVKyYoeCFBx2INVdBCc9b2T3y9LoOqUX67xuhjC1FJ7m2Q3KIB/I4kli71xMlNdWq8V5ahIdEAkhlqag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gFZHgh/t; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gFZHgh/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTgj5AohOXaikTvVVv6DhjdbVAfd8bGTd8MNqXQV8fPeDSQcFTQLEgwjngW2JjIAFFap1tlbg7QkYaELJF0+o3CloPdVwtAyAm5CA0NIQ2/b0eHnt59pnUNNo7fxvmnLSwurk0pQ0B95A4abIe8VK/8VZZq4qqyiuKSOtKiLo+Ux6NmzL3Ejdxrt+hbzt9SXFZodSMTo5bJtv88wEXBH6XRXdP3oc9SC/R7whEc333CDBx76JoRsVsREeFnGL/tJRE2vtnmca1Gj88GinwqSUu0KEDOy2WTsAmlkAieNb9otajii6CL7FukO2t8COAwz0R9n9XkdnVa7pc6W4T5rWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=korvSFbamXalYFfzYyIVUCc+2n0avoKMSUxxTiLPwDM=;
 b=t4AdoCbNgzl1PqjtxHKASX7o6+Kw3YbkAOTD+n+uwVq4G1CssF3S0/QgBSwYJabSklvbMDG9KrrtVupcx+2PyhOCeRPA+EzyAkaK5zdD0fqLC7Aj8iscFZbaSg7uaXI95uOJRvUVx9kiIsT0d/lXLZ0xaL2Jngcyi33bUnKKO71FwrmoMH49ZlYiMPUwAp3+58FZmgR9fgWyH1XB8yQ8YzBAsidQ2dQ2Orbr60GmNxmdzCM9sad0VaF/4ZkmlXnxHgBhvcn2KxjfDduHcEWDDvkYqDAn0q6RKdi4cHQSooQrIm8x3QzHinI5/RUuXB+U7a7IL3bKTSoqitETvVSl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=korvSFbamXalYFfzYyIVUCc+2n0avoKMSUxxTiLPwDM=;
 b=gFZHgh/tzkL13Bljns/TsjQriNZG7TU/xuVIFpRusFGi+9ZqyxaDFL2Wpdbh8tDGkiu+EqMalKNDsyUYf3RwWJbOvaK/lgNGPfKzHs4Dxc3+8E720zLQ4t4mJEMYGuDZ/9/aBxQont4D0sKuFROV6uNGx/zKD1EODN+9xN4jrh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Fri, 17 Jul
 2026 09:56:22 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%6]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 09:56:21 +0000
Message-ID: <4b0e71b3-7c9a-48ce-b7bb-6755d7647f65@amd.com>
Date: Fri, 17 Jul 2026 15:26:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] HID: amd_sfh: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 "open list:AMD SENSOR FUSION HUB DRIVER" <linux-input@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260716075203.593012-1-panchuang@vivo.com>
 <20260716075203.593012-2-panchuang@vivo.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20260716075203.593012-2-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c505c53-03ec-4f3a-367d-08dee3e9a7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zl3hKA0M63naKvPkXQMzGhu/8sNpqbDxhwMMaZuwgkney+qUqXfBM8VZhG/EbxATlGOMzncXEh8UTKuOQsI0JV+W5weNgf4K5jQ60Xd/+EVZq9zYqBvg454rzE895zdVv5RyzxNW2YmXctnmcYl5rBht2qL5G/bfExta+zZumWp5i67jTIE9+VbyYJPzy+HsrxVpiYZosJpGFJSOupwqmgtE9iybgr2f8ZWpq/DDy1edrNUTBDOMSdIAeaDpAET/6ppVpbWSr0BXEWQaaPOSaQuq8c5zCiavx2uE/2rqZPmvnV79PSkpqJeFh6URb1pZk9FPfzCskT7c6l/6h3DOS0gToDAY+QZbg0mvowCA1EBCIJoJfC4B3iIeE9RfwIN5NpMVqrDAjyykymv678sdHkhOvhArW10H4a4m/w+ZxHvkv4EZGqaCj84qDtq1fj6ZZE28NmoaRztpL6+wXYDXtTKrGxHTsHgcfQcOuxRgVkA0QY31Ac2NBD2JWScV3PpmM6+ltJFrWYREszL6peCzOhXggOjXa8tGtjD6KzQyBhfQMTBusVjMCURdfophilbgZkPe/iMDwZ4CLPDwFVlCwRFVm4/GXS3m8eH70DlBQWM1ayFjrmT9IoJnd3ocxaPd/EZJHNZXx1MejW1oUhe1CyQumWsNQgBW1+8JGKw8gpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elRnRm9Dc3NFYnd4VmF6V21zdHZnM1dBU3ZMSkxBbG82dWtsU2hOa1hWbDN1?=
 =?utf-8?B?OFJsWHV6RkQ5Z3VuMmlOZ1dkT05SMUhRMGEzdnIxQkZMcGRjSUVtYnhvZkcy?=
 =?utf-8?B?NGtzTG96RVBmaDFqRitveEpzOUF6eFl3cVlrQ081TWtnOGprcG5zd3BSOUM4?=
 =?utf-8?B?ZVgwdnZxQWtaVy9Tckswckx0RUFJL1BuVjJKNnBKVmFlTWJWM1dXRTY3Wmwv?=
 =?utf-8?B?c3RKTGFyVnA5TnJpa01HZlpKZDNzdHdNRXFyb3FvMmhINS9GL3ZVYUV2aUxs?=
 =?utf-8?B?UUYyUnhiOW9HeWN1L2VtNWRCaW03WVdnMzkxMTBUOElXUnVZekVtU29sTmpi?=
 =?utf-8?B?MlBnRHRQRmJPRWtpenMyT1RFbXAwTWJwaWlFaVd5Qmsvc0xyeWdaNW9hWlBS?=
 =?utf-8?B?Mmh4K2RLZFJxRmZqY2VxdEJyTWxXaW12Yk50Mk51dXFFZGhEU1FUbzZ5NnVv?=
 =?utf-8?B?dExuYlBxcDQwMTVjdHFhWkxEMTBrSkZ0aTZZUmNaRytodysyS29WWTNNS0FV?=
 =?utf-8?B?bCtMc2cyVmtZcUkwbVpIVmYwODVqU0IrcXpwRnJEOC9KK1o2YWpueFdxRStN?=
 =?utf-8?B?NUJKMnl3UExaTjREczY5RFZheFlXNzNGRTY5OW9vL1RwQW9FdHV3bEtkTWFa?=
 =?utf-8?B?d3ovazEySzBZRzRyR3lpcHBObit2Mnp0VGNYV01kMHVpbXR1MWZWK1NyR2d2?=
 =?utf-8?B?YmlYaldYUjcyN1N5dTJsZFJiVHdtdVBwR0t1YlVicUd1SXY2QzJuSG9OTy8z?=
 =?utf-8?B?a0pOTVFSdHhJTzRXaFFJR09RRE5rbkdRSnBNK2I1S2V0RmdKT3o1VUJVWmRa?=
 =?utf-8?B?cjgyT2dGa245bVR3RUg5TWdLVEVWbkF6OVJoR1AzcThaNThTc3R1TndTa2d6?=
 =?utf-8?B?TXU3SHpyekhaeERRZjRqVTVsa3ZMZXVsVHNOR1Y4UnE3bmdGT2tlOTBVTjBw?=
 =?utf-8?B?MFRCUVN2c2tqTU84SktPdmlyR1hQWXpmaUh0M3dkWWk3MUJmaGtKTnFmUTNK?=
 =?utf-8?B?N2ZyaW5XN0YxU1lmTWsrYU5zMWhidkhGYldBL1dMVHlwVUlKZDdONklKQjU5?=
 =?utf-8?B?eGdKRVowenFxaklKY1RJR3gzOUxXb3B1L2p6UzYzRGd0Rml1Z0NFL0xLSUov?=
 =?utf-8?B?bE9HTkJLUXFOTVFTYnhVMUF6WU5abjNic29xd3V6Z1o3WlQzakw3Q0JtNTJk?=
 =?utf-8?B?dmlJUnZOdFI3eWIwcEhqc1BTSXFCdzV1SUF0SmNvalZKS2dWdDZuak9ueGVI?=
 =?utf-8?B?ZVNyZlZVMEViVVA3MUZ6MXJkYWc5RUFnWlVQNHlpemxUQ0NIeXYyU285OWR1?=
 =?utf-8?B?Sko1TEZEL282Y1QxSk5vQ1JCbUJqSW9uRnBPUmg0elRpNDBaWGd3WG92MmY3?=
 =?utf-8?B?Q21EaktzZ2lWVmtLYzFrM2pEd0FRQkpnL0VxL0pUaE85T1hoQWRoOHEwVGl2?=
 =?utf-8?B?ZTF4cEs5WDRIeGg0VE96VU5lbGhrejN2WjZOYkNZU0lJaGJ3b3diU2xoVERH?=
 =?utf-8?B?Y0JrMnpMWlYyVlVlUnpDVlprUGp3ajJiQ2t4VE54clRqN0ttMURId1Vhc1g0?=
 =?utf-8?B?Z0Q0N1JUSlhBZFR2ak1xVlhYM0JvTWZqb2tMalBsNVVDRFJQMHZ1R2wxejQw?=
 =?utf-8?B?NWxyUys5RXorVE42cklsMjV2endNNkg2dE0xOURPSzlLNjl5bUZGSUVkMXpK?=
 =?utf-8?B?djZKb3RIWUxSZFVTaEI1MWdBdUxtZU9mTFR2dDg2eldEekZCakpMcTJOTzV1?=
 =?utf-8?B?RDhHOFUwREtKQ1AvU3BkUDUzamlVY3c3Q3hpL09lTG84dXljalJJMnhrb3pN?=
 =?utf-8?B?Y0lXd1pKallnVDdZS3l1RzZkM1owNGorSVV2WTNDc0s2aXBhRy9wQURGdlhS?=
 =?utf-8?B?a2ZrMnk3R2NVaU53QUxrRkZyeUsyUjNvWi8zajU3QldYUUFBNkI3QWpvOGRN?=
 =?utf-8?B?OVlSSitnZnFqTGtxYUZPSW05MTlSNWdwbTRremJLYm9kMVlDdGUwNW5xSGoz?=
 =?utf-8?B?Q2JpQm1SU2kvVGRNZ1NGZUtMT2xQUldycjNFL2M4eTUxVXFadWNoMGNFeVlh?=
 =?utf-8?B?Q2s5eDFIakZWM0I0NUgyRjFiYmo4a0JWVk5nL0NZN1EzTisxdmhRYmFoTG9q?=
 =?utf-8?B?c3JKMk1XaEFtLzJsT09BaWtBOGhSRUFjOXJieEUrQWk3WlhKc0V3MWtPd3FS?=
 =?utf-8?B?SFJUbU5LY0l4d2FwUUgrY3NiUXNBeFFVaURNZ21kcXplSnBHWjFBWnhYL3N0?=
 =?utf-8?B?T1o2U29FZWZYSGhObzZzeVE0WUk1dUM5RnRId3pMdmZ1K1B2a2w5MUp5Vit5?=
 =?utf-8?B?aWgrQUdNNUVGd2l0MTFxUmhmMTJCMTY5aVlGVWtMTThyQmVVQWZtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c505c53-03ec-4f3a-367d-08dee3e9a7a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:56:21.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPNtI1FIbmTHw2a6SeU+k/icRD6Z6WoNbHuXiuAOO1YAL5DarhnSlBmraqEeJCBb5sWRqvimtKb51HjA/2g2ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450


On 7/16/2026 1:21 PM, Pan Chuang wrote:
> [You don't often get email from panchuang@vivo.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index 4b81cebdc335..a2acd3ca20e2 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -128,11 +128,8 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
>
>          rc = devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
>                                amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
> -       if (rc) {
> -               dev_err(&privdata->pdev->dev, "failed to request irq %d err=%d\n",
> -                       privdata->pdev->irq, rc);
> +       if (rc)
>                  return rc;
> -       }

Please change the function to return the call directly then

return devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
			amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);

With that change:

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj


