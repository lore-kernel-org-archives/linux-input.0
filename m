Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792742211;
	b=Q5QU1DWz9NESWO+/+3WFx7P+hjePQmlZgqCvn+CoEY+pkvJhGyVdlizOscUr45TVuGux
	 GXaq1cLhOm+NJm482Tjvg3ord0Qwnstz3Wrg+fjRZ6Vp0K+Eb7iit62rQLtMxLv2kAfOu
	 FCrsTLbeXjR9FgQcjC7qQC4f1NV5qT7kthmSaOq3KEU8JtGlSwODFE6xomR788xnLJLYt
	 lAiC0Sgy0VIhAAAbCHk0xh/YLK9DMAmcGusYDckI3b6DQKrfLN4H/4ueBPvNDv4chWViC
	 fSZPArCd147h7Vq0pvq/nMwUOgOhRJ140ar7OogN73qgZmpaGuPu8GvoQv8PUHKz7YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742211;
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
	bh=q6C8oor1WVUFhtkXYwzBFZ+sNkstHxgmL4LEI+tMwrQ=;
	b=hg4P/wXw96hJ5k2Y6F7ULrOZeOW0MxVOwioFQVQQ86Lf+jYic0DRPjwShON2hPvaET5s
	 y5mDivaCgUeQbt7tqfpqGCV6S6SoO37rvrU1FzFnL7ZJN2enzNKnU4C0he0Db7ZeXKBoQ
	 dQbLeE77yU5yMryo28Zz8xaO+gITFNXdKKoUZGsqoanGQtXtErGGznuHdyBZ40fUyPhSS
	 FWtZRJatW8HOM3gb1q6CaS9yuOrCjVmVymfNBNpQUz0BK8XXeR3e5tsOkeyeu7TAHsiAN
	 dRuAH575GRrsg0Iy5+eL2gOgUHNR0thjB+cCvnbxGcAiVxzZATkNSiUOCQytbzprpXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iCtLDFc8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.59
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543C606A31F;
	Fri, 23 Oct 2026 07:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8543C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iCtLDFc8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms8APf23cnLqINK5SZpxgA5CD1X7yDbcyoRSIir6Emj/yWLC9fvzleQtmpONntibTEj3Ex0/lIqrNc1CTwCrgXAMoQZFHN/BEha1kAauzm/dLQGekTghfJ5M9qLGeJ7X3RwADCXtYnifWLzgAEkPj11ZnT7jFFAc0dSL6NaCux8ClxaCmnf+BktsqVjsDQS0srtFgqGemUu37XnDnff9YJs9w+yi/Z5QB+Hmmo9TuWDYHruWW//EHx6ncjwA9XTaB/79I/3lcwZibM8WXUk3PQ+v62Oo0xxKmdMv+o25sVZZTvDsX9PiIttWzI5X27EZC22mTtDE5nX8wO8UWoUqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6C8oor1WVUFhtkXYwzBFZ+sNkstHxgmL4LEI+tMwrQ=;
 b=khuPmwiKmd5uhyDytr8hkCvwCoYdc2YP1HQ9hswShg1hvExp5dJWB4LUFl654iHNbeM2Tqyk5JLon5yatzRz2namjwuWgEb90YMnmkgCB+D+Skg2YRjgHyyhdPpwpcghW3Z/9z/QI1ab0vOLd+BNfCzNGO8Xt2urRZlzP9o/Vk70z6Y9ybgTozIwPavGCsgmxj8AvB3zCRJ0t+YWh+Jha7FMn1siqAlj01PfPjDaIKZpGyBoNCK4XI4LyG1D6XqJ7cLZ9Y+02afl5DiuKEWwaOhejZw6LXVz6sraW5Gtvnpp97jx4HRpV0kOCbdxmfEPEiTIrWX3wF3+EpUmESN5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6C8oor1WVUFhtkXYwzBFZ+sNkstHxgmL4LEI+tMwrQ=;
 b=iCtLDFc8mTZ2UQFrTH9GL4NH0q41EvHEMlJQVcEfS6xnXyczGDiMOCGHvyfzKympH3npC1kbOywL9EGA+fc6kzd7MDqzhgJMtBA5Y6kwFMgDYNGJCk226O89e4RxF1AvjKeCFiX0vBh0esKZqOLrV3K2fSqAEAKq77uJZ0M2ZDk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 07:56:47 +0000
Received: from CY5PR12MB6550.namprd12.prod.outlook.com
 ([fe80::b0a5:664e:bd0f:3f14]) by CY5PR12MB6550.namprd12.prod.outlook.com
 ([fe80::b0a5:664e:bd0f:3f14%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 07:56:47 +0000
Message-ID: <5a1bb0f6-5884-4bbe-881c-c245771cef0c@amd.com>
Date: Fri, 23 Oct 2026 13:26:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: amd-sfh: Use shared interrupts
To: Ho Jie Feng <hjf3108@gmail.com>, linux-input@vger.kernel.org
Cc: Basavaraj Natikar <basavaraj.natikar@amd.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20261018100406.44560-1-hjf3108@gmail.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261018100406.44560-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0301.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::15) To CY5PR12MB6550.namprd12.prod.outlook.com
 (2603:10b6:930:42::6)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6550:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: d6160baf-5a70-4936-84e3-08df30db2fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261021123027099003|261022105027099003|261022075727099003|56012099006|11063799006|10067099003|261009223027099003|18002099003|22082099003|261021121427099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rCjzUXUMYU3Fb3O834pstTMYP+EM2dszYsQcj+ZCVWEFHyI4XSqymK+Hrv+jK8DM0Qhb1sGrsEEJDGerluCrhdHOc/QC/uw5bnMOEet/1FhFQTlHtJk0wR/9gpbS0E8ACxqsiPnFVuBNI1KeQcJHrzpiqeLI+Ha6YNL9IyxDrT+JHLgtHJ65uWoCvjWQsR6f2UmvEliAhTTTYEkTeoJjyOX6S/9xsMHUsk5SxRTxtTITXlKRbFE9V8SIgJoROHP1cTWrEt3fw+5NHYjneRzcMdM9woPqkdzCtKLXZtuZP911R/EvJUqZFtyj0mIRSy7EzzvydtMxJ6NuXfYeeSkwYPLIBnERcxnY29l3kXiP/bX9Dcd+Cz5IddToeobo5TjVriYsPhdSWZ9ccAAJjzAOI+Fc4uq+B6A2up3rgCL4wreHbw8fV1O2EB5DqCC7kzN807t5IYf8ncG+9nd5uhk9osDNF934coygrdauySEuITcce40A8ygievFRYVMAjJ1MuiZB0OoJ66qDlozNDO9Klz/9U54OBVphfr6OydILWrVNQr+tH4CS1Hx7Ztm43zioaymjJBfkmTPmh6lATKFQwWI1KCX4+DuppWk1Uua/LremELXEcf+HAuzSXYc5mjtYjVMNVcfqjFiITNJzci7t47g/EM2HZJnewztqzVbCXAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261021123027099003)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(10067099003)(261009223027099003)(18002099003)(22082099003)(261021121427099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWlFaldxTjNBMU9XdGNoayt2QkkxWjN0czhzWVpibVZlTi9nanQ5MkFjNVc1?=
 =?utf-8?B?Y3ZsTTE2cXRxZlk2blprb2ZMeE9GNUU4UkJoNHF6OEdRNyt1NmQyNlYraTNq?=
 =?utf-8?B?OFliRFVNZU9HdXY0YmhTcExSZTFmU1RjUTFubjd3bExTMzVoV3N6RTh0U0ZK?=
 =?utf-8?B?K0s3Q09kRTJqMWtOKzRnWDZReXFtUEtjVVl3MkJDWmZxUFhuOUw1NlNkZHRI?=
 =?utf-8?B?NmJPa0hzSCtHY1pGVWZXeXNEOGxqb2Fnbk53b3BBejNFcFpURW9WbFZNTzBD?=
 =?utf-8?B?SnRHWitPYmkxcVZEeE9yQmR4RmJOSGdybkJKVTZyMlZ5REJ4Vi9uVVlOSkZH?=
 =?utf-8?B?UGRCWVVQejVLYlEzOVJpb2MrVFdVVmNabGlBWTVNUlNMeHpzNFgzUHovNk1p?=
 =?utf-8?B?TmNDbmxVMHozUG9KQ2JrZythWStHUVI1cm1hd3hvcERWRjV0a3RqMkt1Q3lB?=
 =?utf-8?B?SERNaDJqdlAxYVlObTZabTIraEZ5YnF0TnBxa0hJN3dyR256Y1RvY3k0VWJ1?=
 =?utf-8?B?a0lhY1FiSDlhYXRxcmhVYlNvMndFZmNIUGY4WTFOUlRVOTlnTFhUL0crZ0tP?=
 =?utf-8?B?bitvNTNHdUtwOWFGakM5M0FVZCtibjlDU1BESmY3V0QvTmpSTVZ5K0hGZGRU?=
 =?utf-8?B?M0wxTzVVVlp4OXIzVmhyQndkWitaODBEVy9mTUZDcXRUR2hXM2ljRlRvQlVC?=
 =?utf-8?B?ODFGck5RTnZjR3BpcmdZRW5NT0h0d09YcjRaa3h5bk5aVEJBTkZRSHY2S3kx?=
 =?utf-8?B?L1cwaC80ZWZiNXdoeXpQaS9jdFJ0MXRVdmJSUWgyQWRVTUNpRmFxSEZZR3pj?=
 =?utf-8?B?ZXFSUlVhdGRyV1Zncm5JZnNYdjZNMEIraHV2a1FqU0xKdlFRSFdTMVlzOWw1?=
 =?utf-8?B?SDh2WldCZWdPUTVFSWt5bXRrSVJzQXFwZTl0cGxqNEJyWFZHTkswdnZZVUZQ?=
 =?utf-8?B?Nnp3WVFXZjdNeUhjbGk2Q3RkWWR6eERDa2g5eXRsWmFkVlRpeHd5SDZjSFoz?=
 =?utf-8?B?WU1QQkgyQVAyTVg0bjB6a1ljRkJJQlZUU2ZsNGtFNk9rbkdzUDAzQ1ZXRlV0?=
 =?utf-8?B?SEw3SGROQndtUWlTb0YzNXBWQ29tem9ieXptSGU0S0d3ZE03ZWE4VWxtaDJh?=
 =?utf-8?B?V1M0SjdMSmRuZFhMb2RoSENXUk0zbGhsSnYvakhmeTlNMXlNbUJ2WFZPUUJW?=
 =?utf-8?B?c2w2K3I5UzZmcjg5c2RqYXBqVlF2VFVHMDJKRmkwT1hqeE5aMUdPOGRFdWJi?=
 =?utf-8?B?N3VlTnM4ZG5EWnJMVmFwRDNwK1NmdXFOenlQT1BEbmRQT1gyOUtlM2JtcTFM?=
 =?utf-8?B?Y0FvUTJ6K1lnMC9xbnNaT2xGcityMldBNzBibWFTc3JCZEl3TEtOb0paMiti?=
 =?utf-8?B?WEQvOXZtdlYzREllcUlxN2I1cm1NKzVvZkVhZHU3WmZlWG9tZi80UHI1aEpM?=
 =?utf-8?B?UTl5NWFuczhxdVlNMlAxRGhGeEFSMWlBUDJmU0FMUGw0d0o0ZWptRm1xNkZQ?=
 =?utf-8?B?S3laeERsVjlFU1NFQmJrTXJXNHMwUGNVOTR6UHF2R0hFclk0Qll1a0QrVUky?=
 =?utf-8?B?M05uLzhJQzhIaWFCOWU4b05ERGtma3JmLzVZRjNqR1JFUUFRT1JYbzJ5dTRH?=
 =?utf-8?B?aU05RnJPSFM2RjAxaUdsekJjdDNkTURvRy9ybU5BaG9ET1F6eE1IWU9tVkpM?=
 =?utf-8?B?SEhtSEVZNkhKT1Z4bVRORUZjS01CNk9TSGJ2TDN0dHNDbDhoaTVFeW9hTHFE?=
 =?utf-8?B?dS9JTUVlU3JBZnF6YVZvREx0Njk1Q0ovWVFUUGt4WWlZOGFmL1M0b0cvMmx5?=
 =?utf-8?B?d3haTy9wMmJKdXRXM2JnVXY4d253eURPeTBiNFQzTzZlejFOUlZQVVFqVEJ6?=
 =?utf-8?B?d090cWcvMzJhNXBoUjlOQkpsTGlZMnpwYThDTU5BV2VJTzZWVzExcUFuODNj?=
 =?utf-8?B?alhHc0k0aW81WFdzakdIOWJmTnhXRkZrZEJaYUlHWjJ1MWY0VUFtTG1pTkhI?=
 =?utf-8?B?c1RCR3NxS2pab2FBU3U0Q2tkQkk2WDJwanl4S3ZRTkxhOGdRaWxvZmwrN0FP?=
 =?utf-8?B?MmNJcU5wTFl2KzN3VmxHZHRIcHpSbkY0c1lHRktzTkNVZ2xiclJ1a2JzT0Vr?=
 =?utf-8?B?NWlBeEFUczJtOFY0S3hjTHl5QUFOellNMHRmUDlkMXdmczNDOVBEKy9ObGdi?=
 =?utf-8?B?anRPVDE0OVoyNStIZmI3VFNiMG9zdG85cmExTEVMd2JmMWVueFVPb1FhUDdh?=
 =?utf-8?B?NjRseDVNZ2pLa2l4SzhNTXNIZktjODhiU0dYbDg3TUpISEc2Mk5sT0dkblZ5?=
 =?utf-8?B?WXh1ektBQkRGS0JwTCtmQTVTWnI1ZkVtYUtoODFkTTlhYXNHY1VHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6160baf-5a70-4936-84e3-08df30db2fdc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:56:47.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHiXvEXGV4GfYeV2VsB6AEf0E9Cw0eNLQq0ON+95iPFxdA2rvjA2cOI1705y7Ow3GjoRZTDv84vCrwDAJUqidw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091

Hi,


On 10/18/2026 3:34 PM, Ho Jie Feng wrote:
> [You don't often get email from hjf3108@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The AMD SFH driver requests interrupts without IRQF_SHARED.
> This can cause VFIO PCI passthrough initialization to fail
> when a passed-through device shares the interrupt with AMD MP2.
>
> Request the interrupt with IRQF_SHARED and check if any flags
> are cleared before acknowledging an interrupt.

The IRQF_SHARED conversion and returning IRQ_NONE when no MP2 interrupt
is pending look correct.

Could you please make these updates?

1. This is a long-standing regression introduced by:
Fixes: 7f016b35ca76 ("HID: amd_sfh: Add interrupt handler to process interrupts")
Cc: stable@vger.kernel.org

2. The commit message wording is confusing:
   "check if any flags are cleared before acknowledging an interrupt"

The code checks for a pending MP2 interrupt before clearing/acknowledging
it. Please reword this accordingly.

Also, please include the test environment and the actual failure/success
result: host platform, passed-through PCI device, the original VFIO error,
and confirmation that the device now initializes successfully.

Thanks,
--
Basavaraj

>
> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_common.h |  6 +++---
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 18 ++++++++++++------
>   2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
> index e8cc7f1d289cc..4481a50359de6 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
> @@ -85,7 +85,7 @@ struct amd_mp2_ops {
>          void (*stop)(struct amd_mp2_dev *privdata, u16 sensor_idx);
>          void (*stop_all)(struct amd_mp2_dev *privdata);
>          int (*response)(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts);
> -       void (*clear_intr)(struct amd_mp2_dev *privdata);
> +       bool (*clear_intr)(struct amd_mp2_dev *privdata);
>          int (*init_intr)(struct amd_mp2_dev *privdata);
>          int (*discovery_status)(struct amd_mp2_dev *privdata);
>          void (*suspend)(struct amd_mp2_dev *mp2);
> @@ -100,9 +100,9 @@ struct amd_mp2_ops {
>
>   void amd_sfh_work(struct work_struct *work);
>   void amd_sfh_work_buffer(struct work_struct *work);
> -void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
> +bool amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
>   int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata);
> -void amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
> +bool amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
>   int amd_sfh_irq_init(struct amd_mp2_dev *privdata);
>
>   static inline u64 amd_get_c2p_val(struct amd_mp2_dev *mp2, u32 idx)
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index b3cb13b8c5e87..f48a096a6d2bc 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -103,25 +103,31 @@ static void amd_stop_all_sensor_v2(struct amd_mp2_dev *privdata)
>          writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
>   }
>
> -void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
> +bool amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
>   {
>          if (readl(privdata->mmio + amd_get_p2c_val(privdata, 4))) {
>                  writel(0, privdata->mmio + amd_get_p2c_val(privdata, 4));
>                  writel(0xf, privdata->mmio + amd_get_p2c_val(privdata, 5));
> +               return true;
>          }
> +
> +       return false;
>   }
>
> -void amd_sfh_clear_intr(struct amd_mp2_dev *privdata)
> +bool amd_sfh_clear_intr(struct amd_mp2_dev *privdata)
>   {
>          if (privdata->mp2_ops->clear_intr)
> -               privdata->mp2_ops->clear_intr(privdata);
> +               return privdata->mp2_ops->clear_intr(privdata);
> +
> +       return false;
>   }
>
>   static irqreturn_t amd_sfh_irq_handler(int irq, void *data)
>   {
> -       amd_sfh_clear_intr(data);
> +       if (amd_sfh_clear_intr(data))
> +               return IRQ_HANDLED;
>
> -       return IRQ_HANDLED;
> +       return IRQ_NONE;
>   }
>
>   int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
> @@ -129,7 +135,7 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
>          pcim_intx(privdata->pdev, true);
>
>          return devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
> -                               amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
> +                               amd_sfh_irq_handler, IRQF_SHARED, DRIVER_NAME, privdata);
>   }
>
>   static int amd_sfh_dis_sts_v2(struct amd_mp2_dev *privdata)
>
> base-commit: ae6927c533a4454570950125ca8ba909c45f20f9
> --
> 2.55.0
>

