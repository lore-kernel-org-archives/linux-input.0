Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD371427FA2
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725481; cv=fail; b=fweuDihTQruP5F2RDAnWCst8RpUSWz3HYgsaVRRed6Ib0atpq7EWYb9G4VDz7qmwbfpVYRYsjFkNS+SGQOm3TIYxNyBe//goF+0Y3aRvqTeKDIKQXBcnRPvRDvwNcEDsRZwOoE4VVw1eloEV9rAa3mvdEiaerlJNBvZhMc3DVb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725481; c=relaxed/simple;
	bh=/RXIxj4WsszW4oC2w9SIDMr280D7BTkXzGAehLv+rgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WobGHjtDitBcjS83WM03yJOOzQWiPQLvKevlvflaEz43rX7LVbaT8wXhlmPLdeUFgZsgwL98Jf6GIbZako5cF8oQqnBs/ZwxVGGeSF3bKYBLJ8G8SUZpozZ6T7tpqeDSEKm7OAGAFRkBc2FbZkptDjSHguZM9HXpl3Ef0LW7f4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gslnr/Gp; arc=fail smtp.client-ip=52.101.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gslnr/Gp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBgMVNFf8LUPsjwoIEXZl72POY9/J/T5rJpz5AXXOdP5Ir8hIo1Cmx2gius2YM3VvKwNVSU5fFtzesSx7zgpNEktVvITzC92WQuLYUoaQx5DSzdgYcLldeas5G68Ee4HLOr9FgVetTBcbdkVwZTOSZKZ4aAIzG6zPCcZyY5sITz8tuCobXEB1I9OgFQDZdx/pMTU3NVcjipW7Lzh+Olj9YQXyernUn1+qNdfaSfhH737229ErT9RTC35aj25tK/ZJJIOYN3Rc+4MDbyJKsBAQ3NRR5X+5begj3oYF0FbMuIKp9MBGn2hGA1D2uOgdjseRUiaQE5XvgRyh9lI052Wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svRxjlrY7Nv6q2GtD5bj38ziUyD/88hb3S+DKdmgooY=;
 b=PZBIoMyd3TtqY1eKc2x1vE2HkPR5oWXg/qswc6/CPg1JUm5JCmBnougkBD47SVyLjNEHws6xxVHvIo1vYFxzb+M3wKJtnNMC0dQhtYwdBD6YjzDtkLeFoChVvO+3Ccxd6YQFY7fE0FxcAhK2HLFgfS1tkTG4UXJdhq+LtG/uD3zXfpFuqZ0+CiMIMtBPOgu9kDCokhPbGgEnEqbchTK76B7hONjaITodk0edKWIiEA4kz3z4CSxQMjRPO+zD+mY7Sr46XXKY6UveDNHypZ2bLH7RYORVqdeFzOYz69+ryN8HGLiKJnX08GJDnA2yiB/p3e1DJjS7TcihjTyy5hiARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svRxjlrY7Nv6q2GtD5bj38ziUyD/88hb3S+DKdmgooY=;
 b=Gslnr/GpgGX+oT6C/bRe8xidJLlY6hABbmVJwYCr4miVm2dRtJRCiCsO+4Re5eufHABW9EVy2piXLAdzlrU1NDX/5fBjoNyPRHWsPF5XxZQd2DkuHI7ihisSlQcKC3B/77REHr8KY4wSWx91vcTIHHLyWbYUv990cUhTIGObIBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 14 Aug
 2026 16:37:54 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 16:37:54 +0000
Message-ID: <adfedcb4-5d6a-4571-90e0-fb94d7ba5fcc@amd.com>
Date: Fri, 14 Aug 2026 22:07:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add SW_TABLET_MODE support for AMD SFH
 convertibles
To: Jiri Kosina <jikos@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
References: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
 <502r8949-7o51-n405-s500-p0n6226r37nr@xreary.bet>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <502r8949-7o51-n405-s500-p0n6226r37nr@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dfe286-47cb-4233-0eac-08defa226367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|6133799003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	q7a4WcQTyrb/o5e9u1jWCq9jgyj3cqvo2exKqKLGxlP0FTKpHX3nelJpLPx60DoIVYIgVYDcJHJ+eAPgRMc9KocKOGkO5/j2Egi/zKCjDq9KYmu3x3uzGk2G/Zloa7DbM3+fT7HozRX72dTWvHZ3XIcv33fPFmgvwKvjm9UJcOD3Qk2dqP7qft4TmZsdPWePd0E9zctU40CkyaMIiwFl/2sM5Az0+cr1mctR9e4khsulJ59fJ14m2XfFJqSrqHTaO9x17xpP/WdIPlWrefCCWhKukNvr5ghwx2NJnGztw75tOFkyElpzPjBJllRxw7oguLXHPp4wOtFdlsJlxH5XajTOm1JWwuczBMRCw0tt7qx4Lwu9UYC7/O9Mb7XWCEy434NZpPC2or4CUsKyNNvgb5v/HPWGw9kbWNooXIMvwAHHd7MzH/i2UtfKKFL902aHxnHuYzD8NHWDVJ3SdnO6w6FtLC8Cxntg7r2OpFWRrG9sF9Vz/YU4bmoPIusFM43ntZUR6YxidPXeFBKx+9TWnz3/pC51A7o0rDAxjkr7w4Moi/15CdpCb4+y1DGvyvP+hGS/JvAfACjrXlRg2qXF5JQluHJ6ZPsa5Vvj8Q7abhNWrAxaQOC0Eh1cIQAb9MlvccU2Z+b/CnjycuDI8DygJCJmkVoJJh6Lb0NC0nWfAXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzR3OHRpc1FYcWM1T1Z4K3l1YlRpZGNlTUdTVmdjUzhRQUtiTFhBUFBpOVc3?=
 =?utf-8?B?dEhyR0QvVzlyamtyZ2JCL2MranRlSUx0NFVvRmpUYVY2WFZ0SVRYS2dHRTlD?=
 =?utf-8?B?UEJVRFdSVVQ0QkErbG5lcWc2QmsvTzdrbTlweVZ4S1NjNjNFcXUxdkRzYkNm?=
 =?utf-8?B?WWNyK1A4WmRUaVRqT3ZsbGFZcXk3K2N5bGdrQXB6WGFMMjVtU25lN01ma0RF?=
 =?utf-8?B?ZGlFcW1iMG40L2ZpOGlXWlhLNllsVEZGTXYwWktGRldyLzNUUWJJYmtOdFJV?=
 =?utf-8?B?K203NmFHTkF2bUNyVjZJRmdSdTA3cXM5UXpVV2k1R3ZxUlNoeGF2WG1FRHVF?=
 =?utf-8?B?VGhLTno2WXorWGY1LzJyTnc3TjVnWEQzZ0Q0akRickdhaDMyQVU5bkpRa2hW?=
 =?utf-8?B?UE1yVHdicDZkZ3E1Ym5DcjlZYm1zUWpiZmNyUVUwNG5lYitmUklCVW9Obk5j?=
 =?utf-8?B?Skx3TmVzVjdpMUtidEFtUHRtQzhSaU8xeUYxVHVGSXdRSFZEOXJCaEdmc1lF?=
 =?utf-8?B?bitka1IwRmtSTkFCMjlmeHdHeEhYR1VyZ1RJSlg2ckQ3L1pWYUlVUlVGRlk5?=
 =?utf-8?B?cjNIeVEzMlQvM2ovZmtkMnNaV0pPNXVSWlNrK0o1NTZJM1dkNUl4eisrYWpt?=
 =?utf-8?B?VkJLbld6NXQ0UHptdFY0c2ZaUGp1L1huaDN2ZFpDVnVueVVkTUdJeFg1Skh0?=
 =?utf-8?B?dHIxYytIeWNjMWhjRVlKWEtnYy9EQlh1TDFkL1RuMzJXRVRONWhKZGRMMVY4?=
 =?utf-8?B?amRSK2tUQVIzUjZiYWV4NGJua0EzejlVeGZ3dTd6NTFlazNENjNseVA3U21R?=
 =?utf-8?B?S2RsWjJ3WUphY0VmTGhMUGtBOWpFbjNWUm83QVBDM2ZwMmFrVzZNM1VXOHZT?=
 =?utf-8?B?NmEvb0tPRjg0ODlweGJkMDJ6QlFNQ0JMNVZ4Rkg3MDRvOFRISEhIL2hXNVNs?=
 =?utf-8?B?N3lNWDJQSFpkOUM1eXBEeGNGWXpUbVY0amRkN2NDUlZSaGpCY3dlVEFvVDJz?=
 =?utf-8?B?L3gwL0tNYWxHcW9qTkNDYVNBMzdLK2FvY20ydWZYWkNCNy9sL0VDenZGQ3Fz?=
 =?utf-8?B?Rmk1blJDRXZLQ3ZtYi9sZlJCbm5TTzdJaFN4RW51OGw1MldRTEdtOXB3ZmJK?=
 =?utf-8?B?aU9tRjdob3A5U0NlTGJGVGFtYS91MjhsUWtCTk9nM2NuVWxreDAyTWNnWkNK?=
 =?utf-8?B?L0VWMThKSzBJZEtHa1JIM2ZObjRLc3JoanYxdEl1TE13RlVSNWlGREMrNUdN?=
 =?utf-8?B?b3E5d0p3U29xRzhnUE53aG5xMWIvdkJaWTlJTzBuUnIrQUdCOVF3RHUwYkVB?=
 =?utf-8?B?Nm5wU2NNcTh2VlNsc0dUVTNXWktsYmt5MWNyV1dXS0wza1VINUYwOVZCMXlQ?=
 =?utf-8?B?Mzc2aEJmVzdyNlZ1dDcrMWlrTnNYeDF4SjlXYkhpUzNGUnRick0wTm1lY3pF?=
 =?utf-8?B?Tml3NHIxTXRpbFRlUEp6bmpBQjJZajhWYU1BV0p5K2pOa3J0RkJOaUtwZ3RV?=
 =?utf-8?B?S2N2dkFVc2lmaVNzV0pyaDUvMGNGeHNVbm5RZWJrUlZHOHFXVFN6bDhnSXJr?=
 =?utf-8?B?RGZYc0RoVUNZaGFraVdLbFpscngzcmFqZmxEZ3puVDVKWklqMlYzVzV5RmRW?=
 =?utf-8?B?RnNEY09lVlBucVdURUNMR1pLWlYrOG9Qb3ZrSmd1bkNtUDZ2djExZHlkVjdZ?=
 =?utf-8?B?aVdnSUFwbVBFSE5Kamc0OEF5dmcxK0N0NXB5dlIrYkZSVDdob0NUSlJWaEpF?=
 =?utf-8?B?WDlYZHEzNjc2R1JtSFRIK0NuSjdTQlJXZnZMUzFRTGtGazdRSXFxcFlVL1Rm?=
 =?utf-8?B?SjdCL2tDY0FDMktJWloyVHhKdU56eW90U1VONHliQURmMjRxRkRlQllrSENo?=
 =?utf-8?B?cXJsTE9LU3Q2WHdxdWhoTE54N1p1dGdaT2t4OUhVOTd1YWFCT3UwZjYwcE5t?=
 =?utf-8?B?ZXhIUkY5WWJyaCswOFdWNjFaRnFicUZEMEdlV2NvSzQ1bGgzTGZIOFdpeHY0?=
 =?utf-8?B?SmhnU1dMZjJSa1gwVnQyRTliSkk3RW1OMWc4UUNwS2RVYWlHcjE2Uml6eUFR?=
 =?utf-8?B?RmR3ZGFZWEJ5V0xNMTc1REw3cEZlNERJSkh4NXJvMXV2TTVuK1VSRi9ZWElx?=
 =?utf-8?B?bTdlNDIxeFVPM0Uxa0JnR24yWllWU1Z4UGI4ek5TZE1LSlZsL2Fhb3lidENH?=
 =?utf-8?B?RVJ3TlBGRTNhZnZDYjdXSGxOUWN3aTFwdGwveFhiTHBFaW5LNnMxSHE3Z09Z?=
 =?utf-8?B?NFp4TkJ3QjJKY0dUS2pZZ2VpU3YxK3Z1K3p3amlsVFRHVlZMbG91VjgwWUVH?=
 =?utf-8?B?U3RNR3dxT3VlTDNaUWFIWGo3UENWaUR3YWxxRnM3bFptbFRMUlp3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dfe286-47cb-4233-0eac-08defa226367
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:37:54.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQAbORZfjUZk29g1Z9QOJXpzWVQiVYjzjebu2qaeoB938JqH8p1trhq75r8u+VdvyRt1eFV/fSGd6jSed2qvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784


On 8/14/2026 6:14 PM, Jiri Kosina wrote:
> On Mon, 3 Aug 2026, Basavaraj Natikar wrote:
>
>> Add SW_TABLET_MODE support for AMD convertibles whose operating mode
>> (laptop or tablet) is reported by the Sensor Fusion Hub.
>>
>> Patches 1 and 2 are preparation: the first tracks the MP2 version
>> explicitly and the second serializes access to the shared emp2 pointer.
>> The third adds a way to read the operating mode. The fourth registers an
>> auxiliary device when the sensor is present, and the fifth is a small
>> input driver that binds to it and reports the posture to userspace.
>> Keeping the input handling in its own driver avoids pulling input/evdev
>> into the sensor transport driver.
>>
>> Changes in v3:
>> - Destroy the tablet-mode auxiliary device before the hardware teardown
>>    in .remove(), instead of from a devres action that runs afterwards,
>>    closing a use-after-teardown window (Sashiko review).
>> - Move the Makefile entry to its correct alphabetical position
>>    (Dmitry Torokhov).
>>
>> Changes in v2 (address the Sashiko review of v1):
>> - Read the operating-mode register only on confirmed MP2 v2, by tracking
>>    the MP2 version explicitly. On v1.0 that register overlaps the 64-bit
>>    DMA address programmed through C2P, so the earlier unconditional read
>>    could return DMA bits instead of the operating mode.
>> - Serialize the shared emp2 pointer and all exported readers under a
>>    mutex, so a concurrent unbind can no longer free the device while a
>>    reader is still dereferencing it.
>> - Publish emp2 only after initialization has populated the client data,
>>    and clear it early on the MP2 v2 remove path instead of from a
>>    prematurely registered devres action; this removes both the
>>    publish-before-init data race and the unconditional global clear on a
>>    probe failure.
>> - Destroy the tablet-mode auxiliary device and release its id on removal,
>>    and allocate the id dynamically so multiple instances cannot collide.
>> - Report the initial tablet-mode state before registering the input
>>    device, so userspace never observes a stale default posture.
>> - Rename the error variable from 'rc' to 'error' to follow the
>>    input-subsystem convention.
>>
>> v2: https://lore.kernel.org/all/20260803145801.3801862-1-Basavaraj.Natikar@amd.com/
>> v1: https://lore.kernel.org/all/20260721174422.3109166-1-Basavaraj.Natikar@amd.com/
> Now queued in hid.git#for-7.3/amd-sfh, sorry for the delay. Myself and
> Benjamin have been on a few weeks on leave in parallel, and then didn't
> really help with the throughput ... still recovering :)

Thanks a lot, Jiri, and no worries at all about the delay.
I really appreciate you and Benjamin taking the time to
review it. Hope you're both back to full strength soon.

Thanks again for queuing it up.

Thanks,
-- 
Basavaraj

>

