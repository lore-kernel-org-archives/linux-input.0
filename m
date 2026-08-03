Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A942D6407
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778931; cv=fail; b=uKB7hU+3jiJ4OOPOyGl0g2gCclLOFUHT/XIByCEmvKk/hZI03gKU7i+vSTzobXK7Q4qy2S8DujkbMCrwa5cZQz0/yYoYpgHVD02Qz9FyV2fDwDO0+R5ni/2TSaoR7c0gpAAlN6RUGeQib35lRpu4KuIAKIOmhXWwNp2dXZTyZn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778931; c=relaxed/simple;
	bh=TsgrT6+/5FrlyyDk1Ywjhtm+vTDYOirVt+a+T+mTDB0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TSPgf4KRnCoTPBtVh0yoKuk4GOnlAzMD0MHHi2QFFltU+iTCY7fPVkLvZcu35fhDRWf68DAJE4O7+liR700FbmwB09FoXmOJhK6Bpr0kA2FN5Ij/FaDYyJAyfa3rrvXINK/ySYp6rECOlLCDX6z0XvXu94ov4dLditwgd9gAzSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F1sD0H30; arc=fail smtp.client-ip=52.101.62.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F1sD0H30"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfxGO292W9EvufVZkeMUPtI+nhGhjyGitJvQ5vRjS1sy4R3TtrxAMmnNgLtOVJbMGKsMNTH0lvwcJae/6sYFgHtrvCahP7Fia4bv6ddn/GIwoR313Ypd8pwwoSa//ZNDafIp3sSp1ysb0s8zuMk3AhTlp8VQR/D5HTjaL7y7qqGp/gM6JYD6PZUz7Ha0kk5Gmm1+cyeKNC9u7H33hiLW+YoaZiBfwvickpN/6zUIhFZPk0loTAWMLpi07caRbo8QP2qKpr4o7eebTscjsOWBMfJs22doGY89cEGCrVY7gMC1tf2uDIvXVerWbBzgVRvoxoj93nvwU4IjkHbbBHZiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsgrT6+/5FrlyyDk1Ywjhtm+vTDYOirVt+a+T+mTDB0=;
 b=Kf4yGRCSCC90rGn1Vr7BhZGO24WRDMU2Q3un/IZQu85XQOqS4lY/sFT1Jtrw9okNf4lde8tz9nqwqhQhdlWKUgBssiLfn19icV6H9z+Sg/5rSrYqBUru1wsTgelo8wEfDR/a0gRKiu7SVenUsO0zeo2Nk5q7a2wuMzbLfsrcLMeDRnmzl7aiKIqXO3qM3wJ87TYcKRzTegM3RtAoGDjQ4YdmZIrrxgMPfijlDRTnb9lw1gdwyp6zUoM0fmg5N988vsXj+2dJHn6ykR2ZQIkpkkuvvwCtKg49j1kQcOhFTKk1QcawQ4U8hmzf1eN284ioUp/+TB2DJOURUn5eV1958w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsgrT6+/5FrlyyDk1Ywjhtm+vTDYOirVt+a+T+mTDB0=;
 b=F1sD0H30vGoK8aVuBBLs/NbTdDDU2ucc1TLKbq6HbOjhJAHhGd3QJHhp2+a5fzNV0USQbDMC8XIjRj0ykmPJtkTfynfk/rv7ERWeA3NHDvZOiPhJIwqHLAh2elECI3FFAvmMtKqm95v/GpEsf4SazF+v5I7YdNmBhJrhhBNkVEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 17:42:06 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%6]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 17:42:06 +0000
Message-ID: <1500f3cd-528c-49f9-95b2-ed2463eef351@amd.com>
Date: Mon, 3 Aug 2026 23:12:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] amd-sfh-tabletmode: interpret sfh tablet mode hid
 report
To: Jiri Kosina <jikos@kernel.org>, Helge Bahmann <hcb@chaoticmind.net>
Cc: linux-input@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <6879487.lOV4Wx5bFT@lothlorien> <2632507.ElGaqSPkdT@lothlorien>
 <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com> <14202195.uLZWGnKmhe@zephyr>
 <8083nr01-02qn-5984-pp59-264pr475p132@xreary.bet>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <8083nr01-02qn-5984-pp59-264pr475p132@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f68305-14be-413c-498e-08def1868953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	epXUjazjrLl6ta6P0OdmVXHZM/Jlw+heXIqlLKpqEDqytwZkk5ojNl1HcwOxwIV4t86QUnJcxoxdkLY3nVM8jO3DxmbbKAMIef3iUVDAv4Hk0w1B5wE304Qwp93o7+stR3RKtUJqt3WuGiYuaovA3l+Y4I/zByhYJgiRAsb/B2Icclsu67w+ctp4iPobGUoyZxDqSC18pjjmIIHSmf8bFmy/+ndwBLpFema0yeYzrNOH3PEMtjrUDiujrMy9rlJFU7dtrXaHHRXQzEuzKzsPmpJbLtel8PyU0hEZFqJ3jr3a3v0tvK27s9aFN7/1vv8Q5SwWoe/53vVxtngsDyZDraw2ZjhdRBJYlGdVhjaqlLoxxyPgqt2+fO4H3hqMFiUXcm6K+U9Wno/ROrofbuW6cG+n7diTUn4YGSNNSmWgoO6XiB1Yu9+OzAht1M4ToDx6rMpBO/hwBK6WiK4a483w1uw19byB7Vs2q9RaU6y6vKOkndtohu7UfzBrscWHWh5yLqwEZOz7LtCTSeMlVAw0loA4nAUGslRZiyKxj7fYmC7c6ULqPXcqigo3Rvy10nHn7oWc5STAvmHQ9l6fTnIp2rYtYoL4r0P1Ysm5k9vQxS1Xa+tKRrN9KYq92jijja6XuwQWJR9O2nR39c3NJHMOfw6Ueh7Wmt8C3LzL1DfJpYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk0reHdjZUYzYXNoVUpIY3o2bkxwMFhjam1NSUN2STlUSzZLL1l4anQ2c0Rp?=
 =?utf-8?B?ZnNEejZ1RFRmYUFHbzUvaTc3MFU2K1NObjd4OGFxZFhtZ2VRRHROUFZTdkox?=
 =?utf-8?B?QWdzWkVWS2k5aHVRQjlKaGVoZ1hHT1N4WXN5dzdtZEJIMUdqQWVvMElEeUJL?=
 =?utf-8?B?TEVSVFlxZU5xSWxXYWtIaHd6dVVTMTB6R0NlV2p6SWN2UEtTYmlqMFVDL1l1?=
 =?utf-8?B?UXFKRkN5VE5rWW1GNzlwdFkwZ09QdlZmSVFmeXhNbWtKUnlRRXhUQXVSK1pw?=
 =?utf-8?B?N1JLZjNhdmFRZHNwQ01xZVdYaUZ5V1RITFlTY1E0djRWSEM2WUFtS0ZBMVVs?=
 =?utf-8?B?cFNyT0p2MUk3eGlVYVI4eStUbHVQUWRVRmpiTnA3bTllS2JwQjA1aTZpbDFu?=
 =?utf-8?B?Snpqdm40VnBDUHVTNUE4S2ZGb1ZPcTdIejQ3T0dnMlZuRjErenZrU0R6T0d4?=
 =?utf-8?B?R2hiU0p5Wjh2MVZRek9ZTkkyRzVSdldPV29iQndVanU0Nkd4ZTgvWkRPRjFx?=
 =?utf-8?B?MWpreWtqOGFzMEFpeWhtQ0RLcE5PeUdzbG5PVnRqSjZIekVVa25jNkFkb0p0?=
 =?utf-8?B?RU9GdVNOdC9IUkU0MFl3V0NBdXg1M2toMExTQXVZME9XakI5V3habFZUNVpQ?=
 =?utf-8?B?R25hZ0dlSlF0N0dLbXpWdjBtakhuYzE4UU1DYkhIZE9aQW8zcS9GZ0R4d2hk?=
 =?utf-8?B?R2tHTWZNSjRpeHEwOWFMRW5YYVQ5dWRpZDV6Y055VmVjM2NLYW9WejFNUEU3?=
 =?utf-8?B?czhJYXNZSE1vNkpvYmdrNXF3SXFGa3ZLMXR0STdOWjlpWGFKT20wL2FEbm4x?=
 =?utf-8?B?S2RJSnRNRzJUN1R3bUxBN0NoTzJJV052RzNZMGcrZVNPVjhIOFdLWVpPekVQ?=
 =?utf-8?B?MzdoSEQvSkhIZnF2VENHQlo4SDhFckxMcE4yNi90YXN6bG5TNTN3Szk0Nkd0?=
 =?utf-8?B?WDdNVWI1R2ZkMFpxUnFPSE1YN2E2d3NIOUJVREVrTnlsbDRIWjJUaHJ6SjRC?=
 =?utf-8?B?VHp4ekZCVnVhQnYwMmdpZ2IwRnI5MEprb3I4aFJEUURsbVIydlpnWTdzK1BE?=
 =?utf-8?B?YWhtQzd3QW16ZTFMWTQ2aHVHVDgyUFU4NDlFdEtDRFhucUlNOUFrenhRSFp6?=
 =?utf-8?B?WHAyQWp1REppOWpqR1NTdDBXT3JIQVlhcDRHTEpQb3FXdUVCRmlwdDFvdnRR?=
 =?utf-8?B?R2l5L3kvSUlLSkFVakp2ajQ3SUtVOXh4blBuM0tIWWVrRDJTNDR3aEsybG1E?=
 =?utf-8?B?M2hNdzZBbTNLandhYnZCeG0rRVdCRFBnVUZHc3VKSjNMT0kvNlFneFJ5NmxW?=
 =?utf-8?B?KzNNUTFyblREdjVQVjk0Y2h1NFFUSy9QQTU3aW1jOHlqNlJSNXVwR2k0LzQr?=
 =?utf-8?B?Q2IwL09qcS9BSWxaamw3ajZ1QW94SlIzbmVpMmExN1kzNTUxVzVpb3huREtQ?=
 =?utf-8?B?MHU3Y3dMR3NMM050eTNJeUhwNldpMjJwV3dVNVI2YmFjejZqR3EyNnM4LzBH?=
 =?utf-8?B?ZUtKR3E3Qk5ERzBhSHhZQ1hGZm5icklsL1F4NlhsZUFYT01vN1h4MU9VWEor?=
 =?utf-8?B?cU9WRmF0b1M5VmN2M0lmWWxUNnZrdW92eHl6V2NyMjZqUXhpM0thOFB1THdH?=
 =?utf-8?B?dXUrSEY4OVpqVGc5dGNFRzBHTFluRkN6MHMzeTlTYTF2U2ZBWUdPSjNhM1ZQ?=
 =?utf-8?B?V0RMa0JWNTQvbHVBMWRlTU5GSUdSeVFWTkRpYlFQTzhXd0hCM1lJZTBtOXBn?=
 =?utf-8?B?N3pIWGNjZTJsaUtFaFdzMS9Wc1dhdE1WeGhySU4rYVQ0QWR4S1RHbThFUWtl?=
 =?utf-8?B?NHRRTStvN2cwSWt2N09TMVFmZ01RRWo2Vy9IbnJKeW8ycW1IVE51VjV0K2Zv?=
 =?utf-8?B?b2xiRVZTWHBPckd1M0VNMHZrRWFUQmkraldZREh2SkdxWkx0ZTArRU5CbFBr?=
 =?utf-8?B?a1VNV2ZXVFBRb09TQWV4YVhIWFh4Q1R6RlNBbzk1TzQwbUtLbkZESXFOMDdt?=
 =?utf-8?B?QWRtT1NmWGFRYnl0L1pxZlVJaDZ2cDI2SUlZVXpNL3VxaEQvTG9UQkdWYy8z?=
 =?utf-8?B?YWlhQlN0c2FPV0wzb2huQTl2S1F4RUdadGNpdHlmRDBVejlrNnhIU0lrVWFt?=
 =?utf-8?B?UktJRjhNWmlOaUh4N0tMMG81TkE0OWUvQk80MDNaMmcraUQzQm5HYVVkOGlE?=
 =?utf-8?B?Tlg1ejRMa1krVHR1Wm5tRFAvcGFQY1EvVmtrRngxckNDMEhHU2k0T3RnT01B?=
 =?utf-8?B?aEp6YkFxblVPNWdJZHduMGFDRFR2WkxqSVJRdjhKVndad3lJMFRLS1p4MnF5?=
 =?utf-8?B?NEM3VTBjTlNnYkRudzZLSisxaTIwanZoclFkOSt5YVlHLzhiaGRvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f68305-14be-413c-498e-08def1868953
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:42:06.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UEHvWf86bxC1t0ipoZTIxO/HW9mkWc8M7FJrGR5FxYMHWPvjDN/KXeCwShb5upZPQVxXgykRf8gM+veAXAw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668


On 8/3/2026 11:03 PM, Jiri Kosina wrote:
> On Tue, 21 Jul 2026, Helge Bahmann wrote:
>
>> Add a driver that hooks into the tablet mode hid reports
>> generated by the amd-sfh-hid driver. This enables tablet
>> mode switching on e.g. Asus Vivobook devices.
>>
>> Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
> Basavaraj, I'd like to have your Ack on these two, please.

Hi Jiri,

Asus quirk will be handled separately once below generic series in place.

FYI
https://lore.kernel.org/all/anC-yvKFovLA5WWC@google.com/
https://lore.kernel.org/all/20260803145801.3801862-1-Basavaraj.Natikar@amd.com/
https://lore.kernel.org/all/b128d96e-5a05-4ea1-9356-2b4f7169911f@amd.com/

Thanks,
--
Basavaraj

>
> Thanks,
>

