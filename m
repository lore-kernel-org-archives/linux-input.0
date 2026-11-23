Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420487;
	b=tS7GPyyH7DQ8Dqq0BmPs6rxGKEMU/XGc9NCp48RGpduKUiW4Jn1aG8XeP8rOvRlZoeGt
	 xIQRObGpMNWoNdrhKVyTOvo0u3XFCEoz6rMztvmqh3Y5VspJvN4e/yNEeq/XXE4GCuxlK
	 11L/fmrWYJXk7KH3RjX2jA//Pq7fMBRVoGKeZWySN4xqN+cQhAu8uTYU7g2t771ftDiG7
	 9SEe8nn8Z37EiTN5koSBaQReSake46yT3R6AvrI/GrEv/pdixNDkPjiLc+rjXtx13mvi/
	 gk5EvBpZWh6OY6GU2tC/WRgW5XFVGHQodIOjXdLOEMq1RoNGkl9AkPPKDSHJQYe/ZPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420487;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=N8E8j6W441fCm7zWo5JQDgwVaa/9JBxsmVv0cmUx+KU=;
	b=5gyh19ovmZ3/iY9+30e4bNDtsKOmkR1Oa5IREZy4UOZNx94I4c0xi+bfMwW5lxIJOcEQ
	 b7Ew1czPrPLkvhW50cMli3Y+kzLom/Wcd0EYbQMkmo3Vd/CIh48TjqrHABDTHC9zLLXAY
	 lM8dCg73phrkyEjJElsYVBs48xcq9BP+L/206JJDgcqYrJAwz5oj0mGm2ZgrkSPX9iocu
	 k3juEhVg2a1zOCMeHd9SLikxNipCCME9esvb3FqNSsLy2IuJxScdoBfVOFnwR0JBMe7Qu
	 qex/MfLa5S4bWCmuHTz9PQoxsWp20BxH4XuL1LpMU1myb8M4pw6/AzO1AxIJQFZ0+Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cAoPU+Rd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.6
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D8606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 07:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E0D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cAoPU+Rd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBPthge3ghghzOndqrrzv7M9RMJDKQJf5IN4b3YYvgH+JJ4+AQO4NhoNo2HdCkt2Dn9wgqOyNVqLt7sQKyL1IdpvZGFjTpABUeZousjXHzLPkmL3i0EZKKvv8hyjo0ENmFbwbI1YkWBYxyH9HU/OjrfgfdThcfomZmvWdVKN49nd+MRmYqbgoTWzUE1GTl7H535QoTEwTKD58hTO7/Vdo2NGrV6J8ktRuwLnQCnK0djrezZysOC4wy/3HOjHGds06ajvPjZH+juP9q5rwx7ybgz47k84V0HhWBmFsL4gbBKsRGH2a8jDhNSy9N/jbiVeoE+APZALlP0hdHNe9aXSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8E8j6W441fCm7zWo5JQDgwVaa/9JBxsmVv0cmUx+KU=;
 b=SCl80+UVnjrLoigZSSMTpjWsaTGSTb9N84GaTAOoPZMYSxUTEjXikgMhW7c8R5FmvP1UmTaesdvgGPlysejTtFdyCkwiptDkTMb0PP820m9+RbEpE5Rrar+VyXrju9wncNcOOQ7GotoPPV9rp2PBgR6B9qLnof54HE/Xk82FpwQzCL84TW9xtjhMuUx95lysQ0OQ2+hwamf6IsmJ0c2ZZfGRxW2nkIQ/6B68VyyIpdAo0xuwlUvgUKSlT69yfYCKMpwPsA5vPZZs/Ht0FZSrHrZRR0wkCwDCMJrfLMdnIWeJPqB9gvhTUSLgKvdyL+OHwAl/9Np3Crb9mHCdlfQ0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8E8j6W441fCm7zWo5JQDgwVaa/9JBxsmVv0cmUx+KU=;
 b=cAoPU+RdS1mS9/cnRKyKUq6LiyXijT0fX2ecC4MVnXCr+9fDlsfJEpSIiVDZ168ZWLd3jrXIjIGxjp8eM3pHKQsbc3Ho7Yh8IJJ2jYRXt738x8IPJNvo/uZAjevRYGtRiVTW50Aon7SORFeMjdpFIpsHv1Zn7iwjdR7sgn30rvk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 CY3PR12MB9655.namprd12.prod.outlook.com (2603:10b6:930:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 07:54:42 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%5]) with mapi id 15.21.0615.013; Mon, 23 Nov 2026
 07:54:42 +0000
Message-ID: <c301b3b0-43be-4894-9c85-2da60b415f78@amd.com>
Date: Mon, 23 Nov 2026 13:24:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: amd_sfh: drop redundant calls to memset()
To: Dmitry Antipov <dmantipov@yandex.ru>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-input@vger.kernel.org
References: <20261119122430.494125-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261119122430.494125-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::11) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|CY3PR12MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: 96159d3c-8eb5-43eb-861d-08df4937084c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261102123227099003|261021135927099003|261021123027099003|261021130227099003|261021121427099003|261021133027099003|261026135527099003|261026140227099003|261026130827099003|261026121527099003|261022115727099003|261022075727099003|261022105027099003|261022113327099003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	POJ08Oo/SgutVGd61aAw1456wiG4Fz/XqfO6kHkc3BidbZY2cGobXyLGmZ/bZY+D0XjvydcILJ3dfozUJ7yppAnhceGA/MT0XYBuNRY2ZIEj7aHSciAKJWK83jhPavGYVYkgt+FqBSI7zCj4mG55GFsnkdKLgcyrVBAaT1eDFbhWk5f56B8qStlQjmbBCIXdZBRShtOL7RMyd7ekOeJBrCxEfPc1d+9hrswT2SQT8f8XH04OCEDDLlBbdSWMiX2eebPtQIKKTc4Srv4zbP5yPAc3vdA5bSPT6gvQ6aU/+laUtxrtIj5DaESiyiKcFj7r8ijHfYmx7K8HzD8ij8opwk6vU/Hyk3CM5Q1Xu0LNdlX6pscGgAXfCgUFwEvYJu/mpKYjIP7AHyEDMN+uhF3111y+7YmZoHNYtpAZLGHhpZg+J3u4pN8F80wyhdkTf46K/9SYId1JzLnijlSiVq/n7m0AmXGpYUhxGCgE6nrpBFJOIjLTPciL5P4wsLDtoCZxZEhr3VBlvuCdRnz2jES5CGjXhNCLWgu3JkCgnW9cziMd790TmFusa0PNuD0BgiNGEnmxPZc4xi58GFIFYYIT8a1TSL/77lvcU2h2+Z1+lzfkJZIDfgqu22Mh46ShiCsdW055wDirqsHqrG7jZiqgKJrKEYDjQg1bjW34n30AYBk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261102123227099003)(261021135927099003)(261021123027099003)(261021130227099003)(261021121427099003)(261021133027099003)(261026135527099003)(261026140227099003)(261026130827099003)(261026121527099003)(261022115727099003)(261022075727099003)(261022105027099003)(261022113327099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K05JbWtJMzJYQ0xIZHZweGFYdnU1dS9hR0hoSGN3TmtoS0RhQ3AvaUg2aGFl?=
 =?utf-8?B?eEVDTFc2UUVYdDBNeFp1RDkzOTZycGc4SWxkbnZDRXM4dmwwcmxlUU4rMTJ4?=
 =?utf-8?B?ZW8wZGhxS0I5SmZqOU4vM0ZHRi9GaGVPMDJFWEgxVWhLOG5IZ2ZZSlpKRmta?=
 =?utf-8?B?MnduUGhPQ1FiMDB0Ry9XVWt1M3FNZ1pTZmtXcHpRckZRcGVkVEx5V0ZYQllT?=
 =?utf-8?B?NTZoRmRia05wUkR2eFdJbWtuaXJhU1dUWEpISi8zY1RlRjdkQUQ2TDVlSDQ1?=
 =?utf-8?B?Zk5nOVQzVUNoMzNjckg3UGpLUW5LeStvemc4VGg3WnhqZXUwVUFzY2lwSHFC?=
 =?utf-8?B?ZjhWbktSWHlNNTFxRzRiMzFzL09mUEk1WVlrRkpWbHRYOXhmMTRjNWxRdVFo?=
 =?utf-8?B?d1ZudEhlbnZFUC84UHBSMVlsYUxPQzVWSXhEV0djT0QrODJHdUJtUDJzSzNL?=
 =?utf-8?B?MUNZbjNEVXFsMm9OdStpMEJ0ZnZMb1Z1S0VlNStDbWFrV0ZNaGwwUHEva1Mx?=
 =?utf-8?B?TmdTNlFtaDFqTkF5c29GdWxiS0Vzbi9CZHRDV25jdkYxWUdDekswS3JMTEww?=
 =?utf-8?B?RGYzZTJ6Q2hwbXlwbGhQUWJERVpFUk1aWEFua21LTldJbWlKUWxiVkk5eWQ2?=
 =?utf-8?B?Y095WkI4R0JrR1U5dlVHUVd4eWJNMnNhbVhqdHE2OFViNzdCc1IzZk9qbGEz?=
 =?utf-8?B?bk5Lc1pFYTJmRGdBN21LblIrTmJWZ1NaRDZtb0FTY000TG9HOXZIVDUrVDZM?=
 =?utf-8?B?ZndGeGtoVjVpWG16dEgrcnUwdFBYamZaVmtNMzBuL2lWTjZzbUg5ZWVDSCtU?=
 =?utf-8?B?djBZZ2hqSTFjandwcWdkcE95TnQ5RG04SEZ4aTNLYi93ekVsMVBadVFyTmJl?=
 =?utf-8?B?MGJVVjBsSVRQWklIcUZMaURhWXlESzJCQnRPcUZSMHZITXhwYUNkSHBUYUtC?=
 =?utf-8?B?aTlLM3NHUXZCcG5CU3dtS204TUVLK1pyMHNsTzN2R0xISEJ3OE1RQWxpY2ZO?=
 =?utf-8?B?YmpJMVFSQkpHMkIxa0VsbTZKemFPWm03WjVVMHo5a3h6bEE5MW5VNjdrYklC?=
 =?utf-8?B?T0cydnQwcXdtQVAxdm1GNFMydmU4TU1nMmpIS1Y5OS82Tk4yRk1CdjAxa0Iw?=
 =?utf-8?B?WXd0UjVBdGdwRlRrVDgzSjZES1pSbXpUcjZYZEVXdmdXT3NoeVZWcUgvalBz?=
 =?utf-8?B?dkRYU0VHcldlSXl0SkdZangwdDBXbDZTN2EvYVdqZVI0RFJRQ3ZGVEVYQkUx?=
 =?utf-8?B?T3g1OTg3YWRSWmJ2YmVHQ2t1VisvdTZ6QXVtZkw3eHZCVm1zL3lRRCtLSjNG?=
 =?utf-8?B?ZjE4WE9kcmEvTklDeGNpbWJ6T2lydHdXSkNvb1BnWllYenBnSTdKRUk3TXFi?=
 =?utf-8?B?YkFUQmFxdXlLTzI5M25XRTVvaG5zSnpoSWxXUTlHNmk3YlA5OFpWb2Y3NEI0?=
 =?utf-8?B?d3BybnNzY0s4eVovYitOV0lrcTBmcUNjcEdRNkZMWmh0ckRHdFVIZ3FvQlkx?=
 =?utf-8?B?NGthMUIyQWpTUVVKS3ZQWms3S2s0ZFg4R214aDRkbFkvTzlTd0dYSnh5ZGNW?=
 =?utf-8?B?UzJ4L3FyNGVEeWZpM0hqSk42aUhMQ2p0ajMzWVZxNGxxSFBBdGIxMER6SEV6?=
 =?utf-8?B?Z3hRd1hrZnRWdUZnZlFPZWF4Q3VoTjMySkc0bG43UWh5YVlCTnJBMkFncGZx?=
 =?utf-8?B?YmZTT1Jvd1JHaWRBbTlVYWZmODczQ29DbjhZVjVxNjM4cWtmNzBQbWlFZHB5?=
 =?utf-8?B?dXFVdUxVUjNoWjA0VGgxMWgvMWpyNFBWbTdidXZrNWQ4N0htK3lxU1V0S0JE?=
 =?utf-8?B?MFF1TmMwOFhmWjJtaHI1SngvaWRObEtITzNxR3pwbnJLTlJ1QmlsVlJMdGdO?=
 =?utf-8?B?YTBjY3lBSlpneGM5L2phdmhnc0pnOFZYd0tUWm9HcW4rbkwva3V2RFZ6RDZ0?=
 =?utf-8?B?NW8yT2c3UE1ROEVheHhuLzlOWHQ3bTVYb2prOXhIaVoxMGl4YkpLSUErMm1o?=
 =?utf-8?B?YVZCWk1FRmUybFBhWVZQWDY0UXpFeVBwLzl0K3JCQ3VxaDVJMitwOCtoQlhC?=
 =?utf-8?B?bkc4WUg3bDZhZmZ3ZE5DdzlTdkFLdWFvTFBJM3ZyN0JRR2JybmpKVlZKUmpo?=
 =?utf-8?B?ekFtU25XYW1oZ1AvTVZhN1BENTByMHNnWktmdUlUY0FIYVZuTmxINWIvTWZx?=
 =?utf-8?B?ZG5HMmp6MzF3UGFoaWxza2FmN0NpVXlZaEZvaDFHa0NoeXhCSWV1N3lDVFlw?=
 =?utf-8?B?Vzg1dDc5K3lRQzNLdVhwSkxvVmRodDlrWml0NzVlcVRKaEtpZDl3bVVVTS9M?=
 =?utf-8?B?MVdqZjBsek41czdxNXUwdU9wbUZlZWJaeDFsdk42UjVsSUxNUDhUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96159d3c-8eb5-43eb-861d-08df4937084c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 07:54:42.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQtLkjPWT8c4Je8afMxNPouH1MGD9hIJZlQzLMG5JJbFvbEf229VgZxT5psBpqYIff81g3h6yLnbK3jiDlCxbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9655


On 11/19/2026 5:54 PM, Dmitry Antipov wrote:
> [You don't often get email from dmantipov@yandex.ru. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Both AMD SFH and MP2 descriptor report functions zeroes out
> the descriptor buffer before completely overwrite the latter
> with an actual descriptor data. So drop all related calls to
> memset() as redundant.
>
> Fixes: 1434f9fc0e47 ("SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)")
> Fixes: 93ce5e0231d7 ("HID: amd_sfh: Implement SFH1.1 functionality")

This is a cleanup with no functional change, so please drop both Fixes:
tags - there is no bug here and these would trigger unnecessary stable
backports.

With the Fixes: tags removed:

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c | 5 -----
>   drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c             | 5 -----
>   2 files changed, 10 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> index ef1f9be8b893..ac7bbd6e05f3 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> @@ -33,28 +33,23 @@ static int get_report_descriptor(int sensor_idx, u8 *rep_desc)
>   {
>          switch (sensor_idx) {
>          case accel_idx: /* accel */
> -               memset(rep_desc, 0, sizeof(accel3_report_descriptor));
>                  memcpy(rep_desc, accel3_report_descriptor,
>                         sizeof(accel3_report_descriptor));
>                  break;
>          case gyro_idx: /* gyro */
> -               memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
>                  memcpy(rep_desc, gyro3_report_descriptor,
>                         sizeof(gyro3_report_descriptor));
>                  break;
>          case mag_idx: /* Magnetometer */
> -               memset(rep_desc, 0, sizeof(comp3_report_descriptor));
>                  memcpy(rep_desc, comp3_report_descriptor,
>                         sizeof(comp3_report_descriptor));
>                  break;
>          case als_idx: /* ambient light sensor */
>          case ACS_IDX: /* ambient color sensor */
> -               memset(rep_desc, 0, sizeof(als_report_descriptor));
>                  memcpy(rep_desc, als_report_descriptor,
>                         sizeof(als_report_descriptor));
>                  break;
>          case HPD_IDX: /* HPD sensor */
> -               memset(rep_desc, 0, sizeof(hpd_report_descriptor));
>                  memcpy(rep_desc, hpd_report_descriptor,
>                         sizeof(hpd_report_descriptor));
>                  break;
> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> index b81a97dbb1b0..b92e80035652 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> @@ -30,27 +30,22 @@ static int get_report_desc(int sensor_idx, u8 *rep_desc)
>   {
>          switch (sensor_idx) {
>          case ACCEL_IDX: /* accelerometer */
> -               memset(rep_desc, 0, sizeof(accel3_report_descriptor));
>                  memcpy(rep_desc, accel3_report_descriptor,
>                         sizeof(accel3_report_descriptor));
>                  break;
>          case GYRO_IDX: /* gyroscope */
> -               memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
>                  memcpy(rep_desc, gyro3_report_descriptor,
>                         sizeof(gyro3_report_descriptor));
>                  break;
>          case MAG_IDX: /* magnetometer */
> -               memset(rep_desc, 0, sizeof(comp3_report_descriptor));
>                  memcpy(rep_desc, comp3_report_descriptor,
>                         sizeof(comp3_report_descriptor));
>                  break;
>          case ALS_IDX: /* ambient light sensor */
> -               memset(rep_desc, 0, sizeof(als_report_descriptor));
>                  memcpy(rep_desc, als_report_descriptor,
>                         sizeof(als_report_descriptor));
>                  break;
>          case HPD_IDX: /* HPD sensor */
> -               memset(rep_desc, 0, sizeof(hpd_report_descriptor));
>                  memcpy(rep_desc, hpd_report_descriptor,
>                         sizeof(hpd_report_descriptor));
>                  break;
> --
> 2.56.1
>

