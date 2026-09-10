Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011035.outbound.protection.outlook.com [52.103.12.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A22248AF;
	Thu, 10 Sep 2026 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999215; cv=fail; b=hMG0mEOakdG0S8SXfQihfjp8CqG8VXtxEUPN3Bi2ebkVCCt2FQf9/Yd8slCkgVkM0B+017U2FdqvtWI5a96mZAQa/UzEN8MOHWgh9KuAQn0qyDm6ALIg3LjzBkDbqbo+ll/ZfnlnmrM84NQ154EsYIy28wv1xZCKqY/NkQ041tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999215; c=relaxed/simple;
	bh=NXA2uLOtH7vzQb59VgjNbMCN5fkRoJ+VrzSoGJ9BLiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FBw7vmNaOJKUu0wsGKaAkiHaDqvqHjIz3gnzZ8IGzefmkvcoH6h8vbU1uH/lkdC9p+Jmwvx1Y3LUlhZmQhEkWZo4KOznwNQ8y0tbBo5IXWRIB9qrpqQfkShJqajOEHzXhdr4snc+emDF6noBp4/BU3M5eNL2u2i4Qd3yl7JCI+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=BsRwbMiD; arc=fail smtp.client-ip=52.103.12.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="BsRwbMiD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV/JVK4xQ9SmtwG64HZv/Q6lIwXQvTazGxTwRlEOlCQUATTync44tzpYSRIzugsxA0xMIn5622oDDzpgi7DZr74fHzhU9MBpYnQWVkOLAL2UTnirDd7H7hnfjD2dUPZnShm3DpSX8BP9qMIZdEwNb7h6wnadl7S9pT3ZVhmaTAZi5vI23T1FmK4oHaMCRsgajUfvmxA7mFiP/RYhf+PMJ1yLqgu4TnfzHSrsszTveYESL7VIi6nZshImavYH5r6i7z+qUzvIzkqz75x/LVMWCDVZcsnpgTYa5hG2E8HaYIrAOEZ5v0lMzebJbVh+QbwIsUztr4+0g3MJgObrbvgCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkZ8J7FzOrhYsoiE93aD1XCuqLlpWIF63SfdVm8s3Xk=;
 b=l3yXlNCuHTWDo+icddgc3p+iWaiJZ5Gxoa1tqxhlVesPicCIYm4XzeKksLBAgTbTVoZZj3+aDGosfwEthjGl60lkU5WY9S4joBy0zJE4kuPZ2oRlFgk6CnDD4Ba9HtArSwqHozMXDO2awm8WKXhZYFSzcytOtb+rt6PjwczO2fAY148sVPSvbWdJaD/LqbyPyP+hKRJEa8YevHwYE0yQuu21yqpqC69nIu6Pi0QeOmhZab1Ozw6iGbCXPAGSIoqXws6n3Ujbfh837orORMlPRkusf2etb9kjyyAD66XmhwlYIOQjyQGR3GhrgVM9IQQxs9k6dcLefk2rFx+cBMkN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkZ8J7FzOrhYsoiE93aD1XCuqLlpWIF63SfdVm8s3Xk=;
 b=BsRwbMiDKUmgHg3I3pSNHNs+o5CtjmxS84q9P9maTugOvy2md/5j1M6zFPpRBfLSMvYAIbgxLw/J3Nqh1Z0YV6YHBGx/4KpieOhomWVXZWpZ+km50iQbRW14oNEAdjuK3EBYFXEpI1qRE99DkDuK+Tjki5lVYJNl8jztf4YZfgBeHwS/Ig2mj7w6POx2p6Vjk1WfLxHVvXrpttbF1UelJs8KVwss286viyWaE665pzpgEGSlbTiQ+yTpl4O/GvIXpJUtqIC58yIjBVZgIXQFr+Rnf2BohtKgbe/fa46a+GxnkKScPu6xo2DitigSRo5JbqSd0+HlpNsCPuhfaMhwyA==
Received: from CY8PR14MB5980.namprd14.prod.outlook.com (2603:10b6:930:5c::17)
 by SA1PR14MB5449.namprd14.prod.outlook.com (2603:10b6:806:239::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 00:13:19 +0000
Received: from CY8PR14MB5980.namprd14.prod.outlook.com
 ([fe80::7c2a:5f3b:b2b5:e77c]) by CY8PR14MB5980.namprd14.prod.outlook.com
 ([fe80::7c2a:5f3b:b2b5:e77c%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 00:13:19 +0000
Message-ID:
 <CY8PR14MB59803EC0F6C7FD39A6D3C42FA0BF2@CY8PR14MB5980.namprd14.prod.outlook.com>
Date: Wed, 9 Sep 2026 18:13:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] HID: logitech-hidpp: G502 LIGHTSPEED loses hi-res scroll
 state after S3 resume
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CY8PR14MB59809F95431FC6FFB0D0A56DA0B02@CY8PR14MB5980.namprd14.prod.outlook.com>
 <20260909222724.30fc8f52.michal.pecio@gmail.com>
Content-Language: en-US
From: Quinn Schive <quinnschive@hotmail.com>
In-Reply-To: <20260909222724.30fc8f52.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::30) To CY8PR14MB5980.namprd14.prod.outlook.com
 (2603:10b6:930:5c::17)
X-Microsoft-Original-Message-ID:
 <e2396e9f-7cc2-446a-8962-6d65f4ef0cc5@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR14MB5980:EE_|SA1PR14MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: 97159af0-bb6f-40ea-51ad-08df0ed050f3
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLSPhlJ95/U7v6W/AahuugGa9amhVH1bOOMzGShn6L1hXXtP07nLAJrZSlL9cueJonl3VKG9NIAdw54/mPtGpkytrPAnX5NM3Cf95I0NspCbCk5WKJ7pCaB+RvkdcqNIDvH1Bx2jlnMdYuGfxVa6tHLPX/FcGkumFXNPemFfOqQmy6y3umWBeJS24NOhQGJG0wrIH4cKIccEq+GnybZ95401E8+i1t23uRe+R8IOIk4CuxKTv05x8E3OxTPUbXskyeGVt6RC6bl7tLwhxExyxj3YTEHtvlRkV5tXoVlDJ0kEhmk77uym5YFXNF86W7VXQBLS1UKlZP6d41Xd0WtJgRV8g4GWLMuv1RL95R2lrcePTafDrlmWBnS98f7Yr7Tq+N45mYTozMAttOAKBTbFiejbZ5lg0qyk2CRs0Ry/OFPAzElU8urUIthhR3hVlo2T/4OkpK42pRkbK+0BoE00+8qLMJKQ5MQjPTire6mqmg1Ah+bBMn9pfZxn+SF198QfIApR4UJpIASzL8D2SI5E6gdF2uFWiyu2hfXCcsegZwMRFApkmdcJgYCJNK6CwORT1rzH7UJnrCCiRWbqjoo5XjfAVoOH+VnDsVmbTg+B9W/Ogo15OMDLc3R1QU+Zgy3p5xjo+uWqvkcr/64nA8PBbHexWR0xo8fqdknUNjdQbJ0/XXSRLBInQORILSQHCNWz2yzN1Z4sjiALD+I1760pVCjsL5pLpuZ5VoBCO5fF1XkTxGx8Drgrw7Q/y0gS1WLSVhpywUpjwwGsYt34VTArFgKP
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|51005399006|25010399006|25031999004|19110799012|8060799015|15080799012|5072599009|24021099003|6090799003|40105399003|1602099012|10035399007|2607281247196008|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGNOVnRPeGsvZ09vQVVhQUhUZDVPNGtlTmNpTzNKYnU1UmhMNGRjMzNNUmIz?=
 =?utf-8?B?ekpkT0F5dXozVGVnbzhjK3NxZkFDeTUxMXFxUGFybzdJamppR01telhKME44?=
 =?utf-8?B?Y3N3U2QxWGlLSUhvODRBcW1IVUNacXhvSW1aQUU0a1Q4YytVcmRHUCtFSkR4?=
 =?utf-8?B?Q1MyUXhzYkppemEycDlNYnlqNDlLTGI4R1V1eDhwZ2RZRjdqN1M4VUs3OWo4?=
 =?utf-8?B?dXZtbFNMRVpENkloZ3h2U3U1aDV3c1ViS1BSWkxsS1pVbnhpVFNQcjJLUkpq?=
 =?utf-8?B?dmxUWDNpOGZrNXlDclNIeitxZWFqSjZhSHdxZVlWUk5TVnBCM2FSL1ZkNU9j?=
 =?utf-8?B?OTd5T3NvdGRjSWhndFdKS1RaYkJoUjdzNUUvdDZqZVZaeGwvNkl0OUJSNE4w?=
 =?utf-8?B?TkJjMG92Mk44WVlKdDF6QVJzcU5WaThkMzhKSVVTelY2N0R4aVdqOEZmU0dR?=
 =?utf-8?B?YnhkV0lRS0VYbGxpeXE4VG0vZHBESis1RGRXczVJZHc2SWlCa3JwbXFPTStO?=
 =?utf-8?B?OVVWbmFpN09BbjlUeFdrT2VWdTFGaS9xQWhLdlhNa0RmZ2UxMWxxMVAzc2dO?=
 =?utf-8?B?R1V3OWptTSs5dXV2U09Femp4b0V1cG5hWElsUFZ0ZTFaL2kzYVNoOU5GWU85?=
 =?utf-8?B?ZEE2ODFRdHhIU0MxdlU4TXhjZEhNbmFodXduQXhsWThVdU90alVNUzhMT2xu?=
 =?utf-8?B?RlowMWhwa2cvWTJySFRqWDd0LytZeTJKbFM5TDhHajJFRFRDYzNXTjF2bUQ3?=
 =?utf-8?B?NWpuQnVTYjFKZWpSZHh2dkY4dGNiQlZOVVJkbk1peXR1elZuMkRLSXhCaGdi?=
 =?utf-8?B?MktkM3BSMEdiU0c1MHdKYVZmWjJhUitvZnEyUTFpQWliN2tReDh0c2hmQU90?=
 =?utf-8?B?d1dsSzYvc1hlN3RRUnplbkJ2OGlZZStPQ2xEZlBWRVBON3E1YUpZd1l2citQ?=
 =?utf-8?B?VWNEZ0hPN0piZGRkQTR6TjFBQjdndXdDTzYvUC9TblFXZHFCZ0RnSC96b2cv?=
 =?utf-8?B?dU1GbnI3Y0MvYjFXcTA1WXJ2dkw0V2JVTlZYNDJzcDNRRkh5ZGV1V1haU0xn?=
 =?utf-8?B?NSt4TGRaUFMzaHBVa0l1TTVXcy9FMWVmYzFjRjA1eS9XYXhkcHdETGFFUXE0?=
 =?utf-8?B?T1U0SGhDaThCbU43YTBMc1dNL0JXTElTVXVOWkN0MUJLOE50QTZZNkgwck1r?=
 =?utf-8?B?ZmxjRmxhaDZyaVlob0ZpcVRFNm8wSVh6YkZXRVdZMk1XZTN1eUpXeEhUbjdj?=
 =?utf-8?B?cnBEWWkzTUFEVU9VTFFXRWg2NzFoQmg4MldJYTJXZEx5QzVOUGNKMERjRC9V?=
 =?utf-8?B?NEpHQnhQN3VzVVNTeGxJZXRKb2FyaFVtU1hWSHdRSnZSblpHenhFM2JnQko2?=
 =?utf-8?B?MXMrMnFaZDFxdWo2a1A2V1pWZ1ZuazZpZkszSFZzTGV3d1RXc0V4WXE1byt3?=
 =?utf-8?B?VUFaRVJLQ25yMHFoWWtaNCtiOXBlQUpFMUMvNmFMM1c1S1NLaVVCdXlQYTB3?=
 =?utf-8?Q?chVlh4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXl0Z05lY2dVREtjV1QyVHIvWFE1MFMyeWVoZzJLajZlSEtpYlpMdG9NRElQ?=
 =?utf-8?B?OHUwTzU0YkJBaUtxblQzMlVEaVVEazAvY245MTlYdDc1dGFhb1ZpYjZJajY1?=
 =?utf-8?B?MDBZa0tLSU1UR2Jhbnkxa2ovNlA1VjBOMlB6czc4QktnbSsrak9qY3dZM2o3?=
 =?utf-8?B?MXozdHVIL0NUSm0xSXFTVGFKdm51U1ZGeVhxK0kyVjluRGlmNFdIUDgxc2dz?=
 =?utf-8?B?RXVZSGVmaXhlUm8vaWtpdFhFTkpRdGY2YnE4cnFDVG9IcVNFMkJKWVR0LzBT?=
 =?utf-8?B?ektYdUpVZ2tlT1JGTHZOTG5HNjNVU0w0WE16NFJpWGFZME9PZ1RoN2NYSTRG?=
 =?utf-8?B?WStvTGw0R3lienR2b0lWaGF6OTF1K1JFMXR0TVJYSml3OXh1dFVycWRzTllz?=
 =?utf-8?B?eHhtL3QrY2FxM1hCdGhuQkFkbGNRbkpGUVoxSHlJbWxaRVFRM3VYbzBTbkNS?=
 =?utf-8?B?OSsydHRibVdzbEI3bmkrdjVkU05QelJrQVpsc3lhZnR2Q0FwY1ZaVW9vLzkx?=
 =?utf-8?B?NWU0b2J5aE5kSkF0NGxodnpSSTRqL1M4QU5xZFZ4dVZMWjJYMWprL05EWXdk?=
 =?utf-8?B?VFNJV2ZESm42cStyOFBJWkM0aS9sVDZ5WWQwNlVUSDE1K3FWZmZkMzcvU3h6?=
 =?utf-8?B?WDdEMXh5cDRTazMvVzRWUWRQTEtzaTNxSVhjOVl5SUJlZTh3M0dRSVZwWndh?=
 =?utf-8?B?ZmZhdmkrRDBVdjNGNTZhUHFoQ1FMU3lSVHhTMHdhdHh6aXhRTzVkYXNyTjJn?=
 =?utf-8?B?QSt3aVBZU3J3S1Z4YVJYSzNqMVp3YUJ2dE1GdUcweXdVYkJUMFdwalpQMGVS?=
 =?utf-8?B?ejRZM2FFaEg1VmZLMkZxR0doNnNhUmtadlFuVW1RTk42Q0VZcnpzeWpGVDhQ?=
 =?utf-8?B?SGhuN210WTFsbEVoanZkZGFJem5oVEhwV0FHUHBPMDR3OU9pQ0htb01YeGtM?=
 =?utf-8?B?RnZCUVk3eTc4emg3U0JiN1B1U21GQUJBMGdnZ0FJeXpxaUROQjhuYVBLVzVn?=
 =?utf-8?B?TENIc09FOVBZK0FFT0hnaXl4UWtZOTJNR2tKM3dYYkZ0NFQrQmdLRHM4aW9O?=
 =?utf-8?B?ZWExOGVQaUJoYk1jaGRrVjFWdSsvUnRnVTV3Z3lCRVdFMTRSaDV1VFM1RGQz?=
 =?utf-8?B?UTdvSmFDMWdyaEdPV1A3WVB2ckJUTmloYTNpWDRsbDVGUHpXbmdxQzNRUU5v?=
 =?utf-8?B?aHpCdEtmMkVCVG5SZW1hVko1NVhNTEVhL0FqODdKSG9uWHZtUVp2TlFQSFRO?=
 =?utf-8?B?ZUFYK3ZKQktWK2NGdzJ5UERUcE90OE5rc005eXNuQWFJbDlSY2k1QjZyb09O?=
 =?utf-8?B?TzZwM2c0aVlkQjRqUjRrZVBCTFNvSU5kS3dNZGN2TzBrZlY4MFp3UUdqWExy?=
 =?utf-8?B?c2phZmlHUDhjMVMxTlZVN0UrbXBsMFNtYU9HZ2djRVVjUXN1RzdEYjNXdnVP?=
 =?utf-8?B?RFU4Qm1zYzlIeU1UbS8ySUVXc01KTGIyR0s4Sk1GNE9zK0dhOXg2d2xYMzFK?=
 =?utf-8?B?TFdLUURIK0Jwb0tVdDVMdmh2V3VTUnlmWnVraGk5S0JIRS9VSkg0SXM5dHFY?=
 =?utf-8?B?clRWeGRDcEIxRVBBVHh1MW1OLzdjYmtlVmc4NGlURTRWdHZKenZLRjhPN0xM?=
 =?utf-8?B?NDlXdWd3NXZKbllxMHZBUFlKck5ZRUp4enJMWjI4U29nRGtZeDA3d3RhNkU3?=
 =?utf-8?B?LzcxMmJXQ2xFMXhFYncyOGRyYVA0OHd0TStzT0VuMG1xaEsyeXdLVkNqMDFp?=
 =?utf-8?B?Q2xvaHhYMmhVMDE0Z2NhUW9vTkd0MzJIbS85WERuOTJOdzYwMlgwSHBwWk41?=
 =?utf-8?B?ZVRqM0s3NlRWMklWVFJJMDZVY2dSS21ta0QxUFdqZFVEQmFMbUxEK1FXN251?=
 =?utf-8?B?UFZGd0kvek5rTVFjSDd1Qzc4TDJxQUNxSk5vK3Fvc29aTXlVK3g2c3BJL1No?=
 =?utf-8?Q?p5MjaoeMbEsB91YLjiOUv9kq+pDNlw9N?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-13b70.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 97159af0-bb6f-40ea-51ad-08df0ed050f3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR14MB5980.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:13:18.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR14MB5449

Hi Michal,

I tested the patch you suggested, and so far it appears to have fixed 
the problem on my system.

For reference, I have two AMD PROM21 xHCI controllers:

0f:00.0 AMD 800 Series Chipset USB 3.x XHCI Controller [1022:43fd]
11:00.0 AMD 800 Series Chipset USB 3.x XHCI Controller [1022:43fd]

Before applying the patch, the problem was occurring often enough that 
it was very easy to reproduce. I was able to reproduce the resume 
failure on the unmodified Arch Linux 7.2.4 kernel:

xhci-pci-prom21 0000:11:00.0: xHC error in resume, USBSTS 0x401, Reinit
usb usb10: root hub lost power or was reset
usb usb11: root hub lost power or was reset

The same type of failure also occurred on the other PROM21 controller.

I then built the same Arch Linux 7.2.4 kernel with the v5 "usb: 
pci-quirks: always assert xHCI OS ownership" patch applied.

I have now completed 10+ consecutive S3 deep suspend/resume cycles with 
the patched kernel. This included several short manual suspend cycles, 
normal automatic suspend cycles, and one suspend lasting about 40 minutes.

So far, across all 10+ cycles, I have not seen any of the following:

xHC error in resume
USBSTS 0x401
PROM21 controller reinitialization
root hub lost power or was reset
reset of the Logitech LIGHTSPEED receiver

Subjectively, the G502 wheel has also remained completely normal after 
every resume. Before applying the patch, the slow scrolling problem was 
happening very frequently and was easy to reproduce, so the difference 
has been quite noticeable.

These are just my findings on this particular system, but at this point 
the patch appears to be working very well here.

If there are any additional tests, logs, or specific suspend/resume 
scenarios you would like me to try, please let me know and I would be 
happy to test them.

Thanks for pointing me to the patch.

Regards,
Quinn S.

On 2026-09-09 14:27, Michal Pecio wrote:
> On Wed, 9 Sep 2026 09:58:28 -0600, Quinn Schive wrote:
>> After some S3 resumes, mouse wheel scrolling becomes approximately 8
>> times slower.
>>
>> Turning the G502 off and back on immediately restores normal
>> scrolling.
>>
>> I captured the failure before power-cycling the mouse.
>>
>> During the resume that triggered the problem, both PROM21 xHCI
>> controllers reported:
>>
>> xhci-pci-prom21 0000:11:00.0: xHC error in resume, USBSTS 0x401, Reinit
>> usb usb10: root hub lost power or was reset
>> usb usb11: root hub lost power or was reset
> 
> Hi,
> 
> You could try if this problem is fixed by the following patch:
> https://lore.kernel.org/linux-usb/178832755831.50581.1058201741431375556@gmail.com/
> 
> That being said,
> 
>> My interpretation, with the caveat that I am not familiar with the
>> HID++ driver internals, is:
>>
>> 1. Before suspend, the G502 is configured for high-resolution
>> scrolling and hid-logitech-hidpp stores wheel_multiplier=8.
>>
>> 2. During S3 resume, the PROM21 xHCI controller fails normal resume
>> and is reinitialized.
>>
>> 3. The LIGHTSPEED receiver gets a USB reset while USB persistence
>> keeps the logical receiver/HID device present.
>>
>> 4. The G502 appears to lose its high-resolution wheel reporting
>> configuration. In the affected state, one physical detent generates
>> only one raw increment.
>>
>> 5. hid-logitech-hidpp retains wheel_multiplier=8 and apparently does
>> not re-run the necessary high-resolution configuration on this
>> recovery path.
> 
> this still looks like missing functionality in the driver.
> Needs to handle reset_resume() perhaps?
> 
> Regards,
> Michal

