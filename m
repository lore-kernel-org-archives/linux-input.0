Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12653BCD04
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778980; cv=fail; b=e725p+pAwAVS7GS+pQnwsXZ067sxHt1hff3XF49fUfd5InOAmrg4eBbdIcSQlS6CmazAp2+/O6vRxL5th6mG+fnh+XIKnSTH2nQp/gqbqf24e2td4cLHfqZcndo72k+Sd0yuuHs4mPO4oWa9Hx9gboss5soEXU1JAkKYci1Eobs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778980; c=relaxed/simple;
	bh=E4mW2mB1DkOo4Ot/FmkAZ15aRoT8QjwKX547Tx6OFW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NkDqjhHDJyu8h7z4+ArptEyk0BaqFgmN0rdGTblQ46KdWo6/lRp8qLqfQgiHSOFjILda3YIJ/diIShkotMjXv6OL4MW9LtlvAxroPklBzpQzPXjJpkHnqksu79edHdoiMBEetRmeTSsSZtTgw0z+17afCyFsnMZUDi4ZrDTvegI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=auIAttoq; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="auIAttoq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEtf4X/ByLZuSDxnKN/WHmYa7WceKH4NkMNaFGwmZj+O6VfbT2nZeFGppm/FiTdhzXqXmI94zO81C1jys8oiCvsMCmLqF4iDPdRXWGMNZOHKEasyIoY/PYxXlwVo5WjuRlpsXefpq7XxBlLYwXbZezHbA4ZnbKzow0WrHvYbYO05ddXgF5BoiCo+c5eKswlugThqMY7gw77FyNxC2uK61QZW8g2pZTR6BPm+6igkRvah/LNX5/rleQEjSqmSkafEIJ/jQf+MnnWl4jIRegi2vC7oq1lOyZRzlXcfR+YYXmWcthMIIYaotKericwN6qqYCMUppf7FUr+bC2qMYsrlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8R9TcIFUNeCBjnafUQ0tVfLbrHFcADxWxurzquLNrE=;
 b=kA+t9yun7BgLYbMS9DOOb4UFvAm5L8CSaXr3mcKRLNxOd/AW/B6+UEjypWHLB57mCq2Hz+BkopeAb2FxuAOD8LXCzRmyeoBaCXM479hjZ15z1xdUm95MbG3X3hW08F+LanG9uESdGnDrUtYSv49Uel4buYO8k3ufRUS3868gn2edGw3yTFw9iwJnic90umML8LIONRl/pKD/7313Eod5IAXFgYC3RipoBsv1JVtXmDh7P4m8n+kND2q273RcRbNQNBgI2pfDklXFMNNO9rp3u9WYx/pTmgTwTeY6f/2ms/PPo/+zJYNDiBRSj6lv5/2l10KdCQlpSW+ag8IJy0jrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8R9TcIFUNeCBjnafUQ0tVfLbrHFcADxWxurzquLNrE=;
 b=auIAttoqajz+L/xCRsez8kg1w1NHFIvY7HjbZfk6D4pguYCXh+O/d+VAbXiborDvCt7rlYowUWgzNU5Gw/LL4LSOoeRDcaOMdBCViCyuIEB8AF2iXrvuyfDHTF0IsBhk3VfwcXPHbmFj3tkof6JMYySFq4w56FbRsaWkphWTsuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 17:42:55 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%6]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 17:42:55 +0000
Message-ID: <39766ac5-cd58-45c0-87dc-a67db835889c@amd.com>
Date: Mon, 3 Aug 2026 23:12:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] Input: misc: Add AMD SFH tablet-mode switch driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 Helge Bahmann <hcb@chaoticmind.net>
References: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
 <20260803145801.3801862-6-Basavaraj.Natikar@amd.com>
 <anC-yvKFovLA5WWC@google.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <anC-yvKFovLA5WWC@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb4c5e3-aab7-45ea-6518-08def186a60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m+ruRndrvq4pfluzqEnHQ30NoDJEGYIa2CJj7W9xUjSjSRqWwcczjYfCb5YziWQtWy7Acz+RbNrDMk/vMT9BFgqE9JSVpvgRIFki+jhA82f/1o6K7f31aOkFMiQWqwxaA3K82eXTNxGKc/LA8hDNGhZKvOeD08M/XQOJxA/P8U0BH38RFFre4fpTFfCAilmGkn2GSYnlUUqDoFj7rfSJEmau7rr+Nv81dGaW8LFpojmLNkbGgw7FfKTKGEEsX5BAo8Qrrszu8mI79drbFMxbanQMRu3EYsxEH16ctQiGcUFnVAakfsVAuPs7MBG/YBcUjrRCCE2wRQE8Rc44EwuSrIlQMJxaVZo6nKGVo4ukahqSztQXYI/hfuUa4tE7bGrASQfg5CJ6RVE+UATe6FbQsGlWKazmIjwv/F4HzEMf4eVY5alw2VuQFNvNtrGqsJ0nHDlv0OerYT+Fx+254tUr4PWZstKK5Hpl6bTfflSXqQVo0elhaE+K9JuigRJQZsYWevRzvJCMBfJGqMAq0/ejs44MmpNwnuoEMXx2ZJcSsFlGWGujGC0Bfb4OccX4z93zyEertNDE126R/mHy7nyg5k0d+10iJK7rZgiHQJmOA7BSImm71pOUk7f8dBDc8XewZzCe1btGTyvZ5/ZWcWZOVp1+b5gsz5R4HXsZp+e50Dk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1RGdktFdStydCtWeFZwL2VmL20rekdXZXEzQUlvdXorMmJkMHJrMFFCWHhv?=
 =?utf-8?B?elBLOE5uZG9LU2dENDBzNTJiNGNFcTZvZjRBbS83eDdLT2VPNFk0UWxRS0Uz?=
 =?utf-8?B?SkJqWmh0OTVPeUlXS21CRjRLSU9nbDBlRmxkcHovWGwwV3hPNDFrbTBvVDk3?=
 =?utf-8?B?cGhHdTlacGtyV2NyUjdZeHBKQ0QrME54NGlzYTM3ajVWcTZTVUVmeVcreUtp?=
 =?utf-8?B?QnBSV3d1Y0lCQkFIbWJ1MmFHK0crUVZrZVAxQm54YTNHaS9nbFVYS1EvaDJm?=
 =?utf-8?B?VldsUHByb0lmcmNmQk9LL1Z3MXRGR0FWRmh4RTVqSmNuckU5QVpJRWNxRncv?=
 =?utf-8?B?ZFVsYkhydVpBQ3F3V0tUV2VWQnRwcmcwNEFlZXU3bGdDK2NZNnJDb0NQaU91?=
 =?utf-8?B?ZVNsVktuQ1FCbG93M1BFbGYxRmtkU25BR1VYNUNLR2tvWmg3OWFHZGpIMWIx?=
 =?utf-8?B?VnpPTVl5Tk9QcmlzQm5FeCt5djlFNnprT1ozQ2srYmI5dmZUTVFSbEZRSW9t?=
 =?utf-8?B?Z0dWZ1VpTlJEMUkyWnZQZzYremdaMmRTYjFCU1VHYXl0dnpqTHZrZndJeUpX?=
 =?utf-8?B?eEhoM2toNTNidkVBaGFZMGN6Q29mK2lDTTduOXFqcE9jQlV6blRHc0U0U0Nn?=
 =?utf-8?B?Z0NOV1pGODBJaXhDRzNZL0cySXZud3pRV3ZLaktWTWFCakJFVGthYW1DdmZh?=
 =?utf-8?B?bHdQK2JmV0pkdDIydFdFT1kySW9iUTcxVGN4bk40TDBDRHlnS3ArZXE1OWxM?=
 =?utf-8?B?WE1JUjFWNlZzWklpUEdrKzlyYU5oTDNNNkliOWsySFhyQUNZVHVJRm9vdUVn?=
 =?utf-8?B?K1cvaU9HNXlOdnk1dWxCb1FrTDNHT2t1aHYzMVVORDllYVNPYUY5UlloRjZs?=
 =?utf-8?B?QUtOR0FYdlU0NkRqRXJNRjdXY1RFcU1VS24zUm1vb3RpV1ZzNXBnUW9YQjlS?=
 =?utf-8?B?TStJVHY0VXE5cDc3eHltcHJtbThKNVZLTDZPdmxMTUQ5MmIvSzFxY1NJb2FQ?=
 =?utf-8?B?S3FiWG1pajJQRXNxcFV0S2NHZG1sZGRBbXlYS1lyeDh1QnVYaFI0YndjZE1z?=
 =?utf-8?B?dk5QYkZtSkl2cU1hb3RzdmpudjNiLzhaTFlxb1Q0TzZrWng5Z0d3dS8xMmkx?=
 =?utf-8?B?emliekpzUVYrKzBUbElwV25RRlJVUys1TVltVmlPRzdMVG9vQUVoejlYYy9P?=
 =?utf-8?B?NWN5aGVpUVdsNThOZENpNEZYamhZdXdqVzl1WEVmWVY0L05seDY0NTlBNko3?=
 =?utf-8?B?Y1pKV1lIbnFBZmJSYmZVdmFnaXV4V0llQmZqQm5NMkV2Kzc5WWlnZmdFdmFz?=
 =?utf-8?B?clkzZ2RGUGllV240Q3BDc2ZDRTJTMnJIVnp3RDE0VWFoWUI1SWxtTVZVdkx3?=
 =?utf-8?B?VEsySVdhYTVIQ1FJNnJGeUdjWnJXVGN5UHdPSjQ2ZkExVFg4YVltc2FPU3FF?=
 =?utf-8?B?Sjh1a3lkMXgrS1BCNURFeUNYUFBIZ0IwTllSWkI4OFYxeWdEZERrSHpLQkZw?=
 =?utf-8?B?aGdMSEZReGxGUnp5eFk0bUxVTUlXczhoVG5sNlFGdUhhRFh5RFZMRjdtY282?=
 =?utf-8?B?K2pjd05TT1VMekpzcE5mYUhyVzBmb09JYlFseFIwckpTblphMGZ2bkVaZGpM?=
 =?utf-8?B?dUc0NHB6SDZodzg5UXBlOWRTcVdXUE40VTFjY2dhWDJQZ0MrYVV5QmdQcmJB?=
 =?utf-8?B?WEM0emlPVXVPL2xLNzJHOWFBVmdOcG5uQkkzMHNGWlZuNU1LTUw3cHFLMTZo?=
 =?utf-8?B?dTV6VEdITis2SG1sT0h6NmhkVGxVNTN4akNyNHZHdE5ORlB6eFE0SytRdmFo?=
 =?utf-8?B?c3dheEVkM3AwZXVGeEJoc3QzWlhFSTdxSDNqSTQyT0VqNWdBOFFqUFVEdlAv?=
 =?utf-8?B?NGgzZW9Kdk1xVGNUK1NHRmJESWt2SDJuL1FiTnhWZ1V6dm1XbC9qM1ZYR2JJ?=
 =?utf-8?B?M1cwWDdOYXJDV2JqMWtrR1RlYkI4U3BCVlpacDgyUjlCaDVoSGQ1aGd1UWJk?=
 =?utf-8?B?THBUNUxnUjkwY1R5K1pidkNFT0dxVEZGUzB3ck9PbEs4MVFXT2hXcGFvQ1RI?=
 =?utf-8?B?dDFYRkVTMmNoS2lCZHZXYWpPcFY5eklvc1NPazVZRUEwMHZTK1E4Z1RzVGoy?=
 =?utf-8?B?c2hKQnpsSVlEZTMyZ2dISWlyRk5ORkFWOTIxWGhvTTUvSi9oTDZpd3I4MXRw?=
 =?utf-8?B?YXhrVEJlbnRWZ3ZDQ2t3Wm5rQUE0c1liMzJkVWRNaDRGbFhtTk82UTFmdlgw?=
 =?utf-8?B?WFY3MHJ1dExBeWR0WDUxNUtISFd6eFdxUHNXRzRpWFRZTjdrVzFhQnpTZW92?=
 =?utf-8?B?VmlVdXNrejZDZ1lRYnYwenAzVDBDVDFuUG1USk1CYWU3NGg3UkZ2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb4c5e3-aab7-45ea-6518-08def186a60a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:42:55.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b44PaANMCGYxl8ojO6/WuZe31qjPVY9GRKYOH/T+LMbi5n2mkJZ7aMJ8mWfMkj8a6N/ym9OOHC2lvY6cSZsmdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668


On 8/3/2026 9:48 PM, Dmitry Torokhov wrote:
> [You don't often get email from dmitry.torokhov@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Mon, Aug 03, 2026 at 08:28:01PM +0530, Basavaraj Natikar wrote:
>> Report whether an AMD convertible is in laptop or tablet mode using the
>> operating-mode sensor provided by the Sensor Fusion Hub, and expose it
>> to userspace as SW_TABLET_MODE, so userspace can react to the device
>> being folded into tablet posture.
>>
>> Cc: Helge Bahmann <hcb@chaoticmind.net>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
>> @@ -81,6 +81,7 @@ obj-$(CONFIG_INPUT_RK805_PWRKEY)    += rk805-pwrkey.o
>>   obj-$(CONFIG_INPUT_SC27XX_VIBRA)     += sc27xx-vibra.o
>>   obj-$(CONFIG_INPUT_SGI_BTNS)         += sgi_btns.o
>>   obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY) += soc_button_array.o
>> +obj-$(CONFIG_INPUT_AMD_SFH_TABLETMODE)       += amd_sfh_tabletmode.o
> Could you please move this higher. It is trying to be sorted alphabetically.

Sure, I'll move it to the correct alphabetical spot in v3.
Thanks for the review and the ack.

Thanks,
Basavaraj

