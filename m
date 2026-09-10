Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458939A81B;
	Thu, 10 Sep 2026 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073915; cv=fail; b=P3hkD041sBPdilaMyPOrRabMeB4IyJH6zcEVbkv+Z0enjgbq5zanDOChJMCLIqVVzMDCzoGwkwAnB0JHK9FkJNeNF6SNZ43w9wlKAVwayhtoN+1vB1g2SWhDwGqFXjm/8DDy/JREEyfachPIyt3BhU4Fkkxw+OUjWf/nfVyRkhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073915; c=relaxed/simple;
	bh=0kVMItRUXTCSjsQ5QH19TDC0IixPyqAS/HtibGJKrzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nRIwJjFysK8lkE5wPZIR0BgI9q7V3tJ8W8wt/98E+IsxNxD37Ux34VDmH/Go1Sbxdhkrk3jI1fIEJAdtMV/dJiy3P39WAhOkYxemOdojRUDPs9nr+4OXLy/zQbh4B3a0jpd5WSgayk6xyqugnE+LuIVP/eW0SJN2uUd2G/LFzi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=stVQ7+fS; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="stVQ7+fS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDanyGBPnrWRpOfTfE70r4mzwo09hKWSBwdh5BGgJ5o05lT/rW7xMzVV8iW9TcpB4xV2LO9mo2EKeszncJntIk1OMTsVq9pURYpf+6++tOfy/45C1r8u94cSxMuq+mMs7MwE8IWfar4WIiat0TwP40zGI3JRa/ZoDTsjAiMSqXPxv+mwY2hKseqT9i1KmIR7MB8eKJ7TzFOH3TDX0Hgnq8XY9Zn4UayXrIB91wK3LVGXKnF8pBnvfdaJchwa1Q727mPmjLbdkAAQDi6kdqS3Gdmlg9yvk0Djb17/OsDlxr2SXoDHuObrTN0LY+L4QgGwkqhrWoyFnxc2vk6JuWT1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8miNpk86lwKs7zqtEGgvbIsZMDp7QnkLlzPUetlwo2A=;
 b=AJndp/lbFEoUJrQbQMbItxEWUVOcH1oLQGwkEWaoJ1eSKMi1B/HgE5MiRBt2Q2v2nhpVN4e2Cw5YcMqJmZjiepgAutEI98ZrCR4c7TpVmOLfreVJwna55v8cR+QaLZQHZC56Wi1jz9owfC/NU2O6JYEQqfEE0acASNFW7Fy97aw36If13ALVPrdzN131mJiWB5BmNHQJKboE3kE7jLVLfjMqI0+DJRHcq+CmiVJmUaIoNrknNNcAK9MAX06EQzm0TuxmK5VVFAoW+9QAqWcabzMk9jnFR77MRwy0apm6Pk006epeVGC4EMrh164fvCXT0EbzSZD3aQW57gE4l3+U9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8miNpk86lwKs7zqtEGgvbIsZMDp7QnkLlzPUetlwo2A=;
 b=stVQ7+fS4pjXse4ZaHdAf/H5hU3udzxNGAWuYFGu7ThysDVi1QBy08LMmvysF1TNdbZwmyW4vlK5H9aftnmhAxGwOz6iIn4A17sTaP3jN0b/+4bBw9qrqRLVHjK7HUhJjiuW/kQHp8y28FRavIpPWVXvqwOzqUCzIcE9FYdDaEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 20:58:30 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 20:58:30 +0000
Message-ID: <cb4d4f93-2e34-4c5b-b400-06fb01b6b04c@amd.com>
Date: Thu, 10 Sep 2026 15:58:27 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Content-Language: en-US
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Curtis Vogt <curtis.vogt@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <20260910220421.40356e51.michal.pecio@gmail.com>
 <55918a70-72c9-4f55-934b-81a692d4619b@amd.com>
 <20260910225259.66b480c6.michal.pecio@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260910225259.66b480c6.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:610:cd::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e536a8-340e-4852-3572-08df0f7e4471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+BwFehEuDO/jJ/1i31XzvO0lfDECuRcMqssLkmceIcwfK5q/bkHMmhl1Vs2GzahW8dpYm4Q7SZYoNRpR7x/mbvE8NLmjEuXWN4VS21s5vjwsLybIABjCnd16BFwDXixKqCHY/Gf6rj+K4mILs9OakIzWcwNC3T4KRRhe+7ws7Sw/nwfQPRBunQVk6m4YSM2wBIAC8D+8GqEML8ceUWCQFnbB1omw+RdyZR6X33REpxE3b9dAf61+ZPG8uyBO84rV0ixpGYUuydYXYXu47b0Xzy938akdtuk6UFzBUHZuGTQoy64S6e9ayKXm3+Pa1PJKFAW9nfUoTJRSeyxCNsvj6NrlIiDsT4CgobNEZixqYqhWhS9pUjdMCp0q5Z+hXBqKWk0+kBf/mtkPCtNfkTUzIwhsEeQf4y+q0aHkbpzla7A6mPlCihMIWmSOwmlOs6a9m21y92SJpb5hYAa3nNH/SEN3g9gjB6u53JLelkymhPxJ9FdQ0A2CmYkd2XTy9ANCV8XjUYE/UUWhUyUllWC0pzua/6RaGrI2F9HvwEtlZLYOzuIooJdCpu4Wn92hMgOlzRL2PalC1aivfK3R+oO8KtilHidbuRe+i93Johk/x28S5qNO5MaMt0cYi1H5EE+5gRU/ODCi8juy3+ZssNbUTnWtft4xD3/PnUCjwdVbiCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nzl3bzBGQ0FtdnhuQ3RkaHJhOW5sREpwYS82WFVWUHJRSW9IOGJ4czRHaHox?=
 =?utf-8?B?YjNTRkpCTWJaWG51QldIeHBLR093RHB2eHhIQ2dvY3haU1QrdEdiNk9jUDYy?=
 =?utf-8?B?c1R5bzlOejFKc2k5ZldsVlVWRTVtancyUlFuSHl3UHJuTlhKOTVnZUFPaWpt?=
 =?utf-8?B?SU9HOHRnZGdQcHU4Y1BUUEdGZXB2cGpzVE9UZVV2UUIvMEluU01kNlY1aGNV?=
 =?utf-8?B?S1hMK25GeXk0NndTWjA0TWlzaitRZjY1Z1JBeUVMeEhNRUloRUJCNXhpZVpO?=
 =?utf-8?B?MVpkeHl5eG8zL29PRVNTcThEdFc1b3BwcmR2bnUrRG9Db3ZZNzdka282SGlj?=
 =?utf-8?B?QTF2cHY0MzdBZkhJSmQ4dUtnamFJbGJJSlg3UmRqc0VKbGQrNlpoSEJZOHdt?=
 =?utf-8?B?TlZ2Rk0wY1lVd040T1RoVVgxT0xLbW9DalJSOWhrQlVDcUhDRG0rellHTUdL?=
 =?utf-8?B?enI4eUMwbzNFRmRFZlYvQ1RaVStFYjlBTUZGNnpja0FYZU16eUtBL0gwMzNo?=
 =?utf-8?B?OTRlQXN1ZWlseGNZNHE1WlB3V2ZsMTFDQkhrTForRHZudG1lNUwzUVNxbWNa?=
 =?utf-8?B?SlVZZzUvWG9EcThsajVtQ3FqU0tTOG9NeUNKcmhKeDhOOWxDd1NWcXdHY1hV?=
 =?utf-8?B?cHVUZzFSYmR3eXdTL1A5Q0pvS08wc3FWUk9POTc4UXRLSE5vMEJqZEovTU1a?=
 =?utf-8?B?eGxrSnp6Z3ZQczhGaHNBWkd6M2xjSVVZaFBDYmQ4aFN0TEdia01OYW5tQlFL?=
 =?utf-8?B?QXVUdTlaY3RXQ1pTNjE0NkhFTVNjSEoyaFNQR2JLWG10VmgwS0FSNkNyUTBG?=
 =?utf-8?B?MDF3dTdrNlMra3cyT1B6OGRBOXg2MGl1MXR2TkVhNFAyZE90SloxSjdjaHMw?=
 =?utf-8?B?SXdqMjhKYUN3ak1zVS93NHJVUEU0YzRQMExuUzluWWhoUjFuWk1XWFVvWTI1?=
 =?utf-8?B?SXVUSlFHbXNqYTBxRzAvdzhNdXZWdXhHT29VRCsrc2dsblBKeFpUQTlmVEV3?=
 =?utf-8?B?VVpMK0Z0ejQvdWh6akNsWDVUTkI1WHZsVzE0dkVZL2F0YzB2Q0hNaUd2UTJp?=
 =?utf-8?B?TjdJVG1MZTdBUmFNM09lREhOL2N1dkZjRS9tV0wxRHl1K1dKOUluUnZYOE5Y?=
 =?utf-8?B?SXd6aFdFZGJqSnNIVmoxbzF5elRVNURweXZLTSt6OEsxWlRiaExSVUllVXZI?=
 =?utf-8?B?d2lVVldjakFmZGZ4NlBXVFIxMEdMWE8yUDZ1aDI1MmlKWm9pRGx3Uk5pSldM?=
 =?utf-8?B?YlRlRnlRVXlGaUdCTnF0MFQ0ekkrUHlYWDlXM2VTVGhZQk9VZTlMUk9DZjNO?=
 =?utf-8?B?WWFVcG1zcFBzMFdBYmtKdmZaaEpmdTB4Ym82ekhVVTNOTGVmSGpOaHFSZUxJ?=
 =?utf-8?B?U3puU2dQSVRnN28wNkRXRmlOMUZ6ek12WUtiRitSS2ZxL0N1V21NczBPdTNG?=
 =?utf-8?B?RmhBY3ZRdUpjK2xjbkQrNkJhZ2Fza0hpS1FEVzlISnd5ZzBhWU5nd3JXd29H?=
 =?utf-8?B?WTQvTzlrUlBNa1dpdkFjY09UMTlNR3U4M3RKNy8xbm8zQzgxRUhxRTBOZDRZ?=
 =?utf-8?B?bTF2WkNtb3ZVOTR2eHRxZjNPd2V0YmRyWTk3TENuaEVDMm5YWEwzRi9ET1BZ?=
 =?utf-8?B?WDFoUzlsR0hlMVNOVlZBUER6R0FLNURaVlk3UW52dzZmaks4N3owNVJQd1dn?=
 =?utf-8?B?YjJBVUYrUzRha1pDbGJ6T1ZQMmhycXdtMEdxS2Q3ckRUVjhSTXZuMW5tUjJW?=
 =?utf-8?B?MzNONE9QNndpV0pWeHZMNmtEZlJJc0NsQ04zM3hIbXFkWFdWNngyV1hBWWVK?=
 =?utf-8?B?SGN1S3VJSjdwU1kxbFB6VDVyaEQwQlJBNm5UWUlSOUcrdjVxMm1yUWVGWXdW?=
 =?utf-8?B?d2RMaWJIdmtlendVU0ZTSExPeFhUa3JvMlBDZVFOVmJSdVJOc2orSXJZSVUx?=
 =?utf-8?B?L0gyTzhvb0hCamtnK21JcTlJUW12NjN0WFNuM1g1aTlPS3Yrek0zbHc0Ymkv?=
 =?utf-8?B?NzJ1U0VtUVlyWFNuejZvRnY1NksvbEtWaVVNWEM5Y3k3VDlISHYwZER6ZEI2?=
 =?utf-8?B?V3BDWWkxSHJuUDAwMzlEa3FnbXlma2NuTEpJYVRoNHkrOTRYTkJ6V2xvejcz?=
 =?utf-8?B?NzBOeUVGWFJkZXpnZkgwUSs2RDFXV1lKSWJGQW52YituaFpKMXFucTZKSUs2?=
 =?utf-8?B?elRjQ3QxZmJDYXROUzlXMmxBTzVYSkhzQzNqN0pWL2RlWjg5YUtkb0Z1bmNk?=
 =?utf-8?B?KzlrSHhERkNRU1VZbENndnNuQTJLWk80MTVSZWxjbm80WUpNQTdlNTlRd09t?=
 =?utf-8?B?elArN3dXYk5lSDIvZnp4bFNHRHIvSk12UVJlTHdpNEtISTU5V01DUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e536a8-340e-4852-3572-08df0f7e4471
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 20:58:30.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRjK4YQbyVCnFa72sBgnnFC9l0UqBn05YWxycnA8Jn9X3hwj+sYwBQzfxVJ4ZxX+FqSRQuhMm6+Mt1unYO2DfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036



On 9/10/26 15:52, Michal Pecio wrote:
> On Thu, 10 Sep 2026 15:43:18 -0500, Mario Limonciello wrote:
>>>> +/*
>>>> + * The headset's EDID service is lost when the host disables the DisplayPort
>>>> + * PHY during system suspend, so it needs the reboot on the way out of
>>>> + * suspend.  Doing it on the way in does not work: the headset dropping off
>>>> + * USB is a remote-wakeup event from its hub and aborts the suspend.
>>>> + */
>>>
>>> The internal hub which will be quirked by the next patch, or its parent?
>>
>> It has to be the internal hub if quirking it works, no?
> 
> I believe there are two separate problems here:
> 
> 1. resetting the device at suspend causes instant wakeup
> 2. a few seconds later the system wakes up anyway
> 
> 1. is solved by resetting on resume rather than suspend
> 2. is solved by the quirk
> 
> Questions:
> 
> Any chance that 2 also solves 1?
> Would resetting on suspend be preferable, as the comment suggests?
> Maybe it would, if the reset can race with DP seeing empty EDID?
> 
I do think that resetting on suspend makes a lot more sense for that 
exact reason.  That's why my original PoC did it that way.

That's a very good idea to see if the quirk + moving it back to suspend 
works.
