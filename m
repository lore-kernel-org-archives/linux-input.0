Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142036D4F1;
	Mon, 14 Sep 2026 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397132; cv=fail; b=D/fAswG6/1AHlMgTiBVZ3Q6yuirlIuyRtj7m1Zgyqt9Oc1e/opew4eo8n0Rjiv5RicPFT7ytJZGYsSzdjB4RmQbQx1zr/4fkzNJ0O+EJFk7O9/lMiKLAtlh7BP/DsFcINPaPs1SwEidDcs6NhIhX54wAv+PkaGeEevVmRE3m8kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397132; c=relaxed/simple;
	bh=dB2nc1Jmu+AgHGw0hCFty6im90Vz2aaP4YfHuOziPRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YNO/2jSrNPuc6EtbtCqL0vpKoRTk2lhEQzp4NMLoG0OdssWdfTMAJ1pUCa7A6icEkvxCBliuaLH+j9/7VBG2NfHXscoqxmuhQD1BB25J+/fVwL8puu2E8sljJtZh5a0Pv0QOJhDXQufxQZvAEl0iFD2qOE80+qAk8BkAnKTrI9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iosFk7EJ; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iosFk7EJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMJqfvO1oDWX/YXtH+cVaokMmofE7ZsXdhrYanvvPM2NtyJb11FM55rJo/w6QcaAnJ4hg12Sg7Uldq+4VHm8LtAJKHll/mU4axTIiSqaSJGB5rOcyEVAUe+MXtcvv0vI7LH38rq5ub29uOungRv4p2OgNqlKT5uO348HlUV8r0otTWSe4aT86io4ZI9UuFCtPcpRi4ozzDv/Sy7vJpEABs55mOfAsAZ6VwBTdZyiaUBjVY+1BaTQueRPda2o/haSm+jehovzNCymx6M/hdsb1/aVGZff+c+xfGJGj6jHkTqFeY/43pccEqaHq8wGhiZGT41qv1Dij5eDXMjTpirZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocw60FMZakhO9upSzvrcMzdEAMXIVT7VKWde34qgFLo=;
 b=EwcxCXOeVo15zIFNeyJfp4X34ZI0G/91g57cBiu98R/IzH66hPjhZuYfrVafH/pNU2InwuVy8EiuMg+2vtphsy7scxNVIEZDoSghfX2ptLgO5aONk/+92p66W2P5DW3325tvsl3OzfrmSxVVsY/l6zCnQkUiAthrtEtz0E0YiqRhjHhaQN+/euvFlZogu155pQdXC7gFPaqUGPYrGC653AyM+xFf/IRj9zblq39s68uX5QQTLpne1Jix0hrrZksm+lC003tBdMK6bfM2kDjAUKMbfQgxf1u4uFwWzPnB8iYyIrTw2Ev87wj8I3X7i2WBpn0lzE01fODrD4UbBSwKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocw60FMZakhO9upSzvrcMzdEAMXIVT7VKWde34qgFLo=;
 b=iosFk7EJ6HQ0gVMUHgm9cPVIIprZ7oYYS5G0klPiyuHhLTKNfFDMOjcC36wCh+Qysj+F8dXbJS+paMSTOddP6AxXp4yrh+7iGFvxn3iUO8eN/+G3X1mx/F8xmR0jCyGmGWS4vyPh8lfENDDiSUqsuER+YbnqiRDMtta5FUkEe3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 14:45:25 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:45:25 +0000
Message-ID: <ff5e3967-e753-4ab7-b310-9a741e47815d@amd.com>
Date: Mon, 14 Sep 2026 09:45:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Content-Language: en-US
To: Curtis Vogt <curtis.vogt@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, Jiri Kosina <jikos@kernel.org>,
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
 <cb4d4f93-2e34-4c5b-b400-06fb01b6b04c@amd.com> <aqVcun3-ksMgzb9z@dhoja>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aqVcun3-ksMgzb9z@dhoja>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:510:2da::21) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: df9b3151-61dc-4bdf-6263-08df126ecfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eDMyiS+UjN14zPBZD+ayZwwFJJ7LVF/AQoM4CUxymC+a7o/26Zh2Bvhnsf6JBIHQf/U3hWSPzffh+rU9396y/KYh91+c+e19J3indE6rxWxrQFN4hcX7565zqmF58zYybOUHyPSXIb92HI7NCoOGMTUdpirlpPK0HaUqlbRor1iqLur/+cMELFQGLdX1bcxlVJCbNSLZDl/hroSJw4oTp3PnahAkw3vJ9TwQvBODTitDLnADEVgoGU8t9w7ZUEp2V+48izBllbanVHFlyLLXoYVCnFrblhX519Z7vmrGEgtk1dWxvKiUIz7P5mtOC3co5DdA8+P8FH3T7KGHwvjDfiWa9c0cvWym3M8CbDQaRcywRKJFpnazcvhqerS8HxqLJ5kvGPKYkcH6Y6hvn8RFC6eypdE6pY0qN9qlA2aKmWn5ndphaKKub61V4AD1hzE6bakc9C3DJd1zLbd87hmoAnZd31lW6bn4tM4H8Sx5ygeuXjwDCzam1RMY5+P/Bkjqtxq2Tvgqi9eP4mHLqK/N3kRVK5wYobSqAGUN7Mb6VGYZ6jZpRaiKGROJ5vTbe35L5FsIFl0VpBeVfrfvLoQz7bk5fG9qTLrU/OU30B9j+02Uur+mEjiB24OiQCiYwocVmeT4FmU4kj1a45yDGeyDMuDhRBKPnZX5DtCQJodaE0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clVIUXNSMWJPT0pzYkVHM3owSE9NSTZNK0QwTWhhRlUyTmxrbDVtelZKdVNm?=
 =?utf-8?B?QXkvY0ZpMlZxYTNSUkdhQlpXUEVnUFc2MGhKZGYwaW9UMEdaek1HQ0RaOGM0?=
 =?utf-8?B?T1l4WS9ieEUzanV4T2dOUnVzVmhzei8rLzVPZFM2U3E1c2ZKa21xVjRGZUxW?=
 =?utf-8?B?WUdlMkMwbW84dDFOZ2ZpTFpncVF0dkk5cVlrdnZ4WXAzWE81Z3FmbnEzdDJn?=
 =?utf-8?B?TWxmOEo3MGNlaTNNS0ZGSCsvTER3ZU5iaDNQeFhJZjM5d3dSamp5MzUrNzhF?=
 =?utf-8?B?NDVTa0N2ZUR3QjVDNFZSbFBBdWNnOG9RNWgzL3JuQ0s1L0ZJTUhkay9lVXNC?=
 =?utf-8?B?Q1hXSnNvS3ZUV1ViNnM0Z1QwZnd3a2d6cnc0U1dlbUlWbFRscXVGdnZyL2ZJ?=
 =?utf-8?B?SUpYODgwN3BFelMySFRlWEVZU1lXZ1Y1QTdxT1pFNEhBbVlINXIwOTRWM2JL?=
 =?utf-8?B?T1p4aUpGWHI4V3plcmd1V054SzcvUkE4VXVnT0N2RmhYNUthTkN2N3h4UFNw?=
 =?utf-8?B?UmJoZmtoVkZ2blJIT0JKQmJ6WmtrQUQ3V1kvR0F1ektRNDBJNjVyc1M1K3BU?=
 =?utf-8?B?VWxIbWY5dnZBNnUxNlVEM05CaXR6VWlWVTljb1dhaWZkMDZ0MXhHYi82MVFr?=
 =?utf-8?B?a3ZGZTlFUTFtb0NDOStpRko5cmEvQ0cvQzlRRitZcmVtdldPT0YvNlBvNzJP?=
 =?utf-8?B?RHh5algvd2VTdUtTdzMyZEFndUJjc2FlN1JoNmpsQXNrYWFjRkNkNkdJeDB4?=
 =?utf-8?B?MVBpNm9NYlZ0SFl0R0dtZzR4V3JOc3VudjRORjZ5UkxNcjhqOFJYdGRXZmRX?=
 =?utf-8?B?aExhaUdDbFFWd0Rla0tITlJyR0ZJd1h5cXhjbzJDVTQyY0VHMG9yMG52dWRJ?=
 =?utf-8?B?Uy9uNnQ2bzRIb1lXdjAyVWtkdEdzbkN6UXlCN3RrVGlOaUtpbVJHcGlFZ2xu?=
 =?utf-8?B?QVg0S1B3cEJPOTN0dXAwcmtqN1ZCUkwrYm9DL1NxWXY0Q2JNdVY3QVNGQmZw?=
 =?utf-8?B?Mll5M1dkc0lCZVhYRkhJNUNuMzZzRkFUZmszOXFWclRRbndXY2dDUG1pRHV0?=
 =?utf-8?B?WWR4M2xmQWNnNFhYb25ycTV6NGxneXVLdXRHdFJ4U2JpV2pWZHdyNDdlWHNQ?=
 =?utf-8?B?Z3RiR2MvUE10NXUzRG5selR1Qyt1Y1ZWclBDSm9paW5CS3ZUcmhjOURCWm9k?=
 =?utf-8?B?c2w5RE9LazI4UjBiR2FHb3pZWTRtY1d6MElkMWZhM2had2ZLS1JWYzRaSTVy?=
 =?utf-8?B?dUxtTUUvVkpOVzdDRGJQOW9yYnlaRW8rYjVJYTEwdnR1clBTb2tjZmdGbmJ4?=
 =?utf-8?B?WGd3aGVSKzVvT0U3MlpBanUrcStTNHRJS3pkVEw5SzJ4V0kxRkdrYXZscS83?=
 =?utf-8?B?T2txVUp5QXhyRVIwRnNudzQxQWd2N21iZ3p4QXlnTjFDYTNKcld6alNrUzdU?=
 =?utf-8?B?SDNGQnBEUGlTeVJmdld2WHpFaTZqR2xIMVo3bWIzMVNTQlpMb3RFNHdnSFky?=
 =?utf-8?B?eGIzeHUyNUtZRndJc05lNWJISWJ0QnRpTVpEUW9EVlkzSTJqTC85VUs1ZFJt?=
 =?utf-8?B?UjB3MmE0MCtiZm9aNGVjcEFwMm9kKzVNNVZiUVdOaVU2QnJpOFBZL3BZTUxK?=
 =?utf-8?B?aGU5bGZ0VXpVNFVrME0yMlBPbGJnU3BaYXZ2MmR2bmt6Z3BYK2hVT3RQN1NE?=
 =?utf-8?B?ay8weW5qZTRoMVh5R2Q2bXc5cmRBQ3htWTlnNkUzSDRNQUxPU3VETGtML3RR?=
 =?utf-8?B?M2dERVBKM0F6N3lJMjcwTGtzNFZtN0MwbzhNdDBwak5VSzMyWkVKK0ZPaHFR?=
 =?utf-8?B?cTFmYkNKdGZnU3p5SzhBQ2NzaXpubklDSCs1Y3NkeVAxK0l1V3VqK3JLVjMv?=
 =?utf-8?B?eGx2Q2lwSkhqZ1RxVG9jVFhkbGtyaVdpYnVBZjhicEh1RnppQ2oySnNLd1g2?=
 =?utf-8?B?RC9SYUFKUGlkOGZnVkQvdU1reVdZZ3FSb2VXcGU5cnpDQ21vOGJhenVEa2R2?=
 =?utf-8?B?NHpqbE4vMXR5dlJlcWJ0OTNaOUFpdGNCdVNJd0d6YlNoSE1xNFUwWjV5VFp3?=
 =?utf-8?B?UmdvYUc5Nm5HVjNOVUZLVS9rL0tFaXJsQ0Q1VVo0WHRFQml5dVNhOTRvWElM?=
 =?utf-8?B?T0ljSEdsNEh2WHdEWjcvck9HOCtQY0hRMTJncmRYVkRMOEtlS1NYNGhqVG5I?=
 =?utf-8?B?MzAvWlhneHNSSnFYTHBiNmZVTkZYd244ZUltU1g3Vk4rKzlLTGFnd3NKYjZ4?=
 =?utf-8?B?YXZSRnErUzUwem1VV0lXb2ZvL01TZnM3OVVRbHFYUDRvMlVNMS8xVVhkYllK?=
 =?utf-8?Q?9tGnTXl9GbRRi++Sfq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9b3151-61dc-4bdf-6263-08df126ecfe3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:45:25.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tt67D5glXpoyf6z95uu6tjlVLBNb3jP8umTAyETyVXhtywx9aHqHtAv6iqIOwcgPA5FmKjN71RVDABbbDajlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035



On 9/12/26 09:07, Curtis Vogt wrote:
> On Thu, Sep 10, 2026 at 03:58:27PM -0500, Mario Limonciello wrote:
>>
>>
>> On 9/10/26 15:52, Michal Pecio wrote:
>>> On Thu, 10 Sep 2026 15:43:18 -0500, Mario Limonciello wrote:
>>>>>> +/*
>>>>>> + * The headset's EDID service is lost when the host disables the DisplayPort
>>>>>> + * PHY during system suspend, so it needs the reboot on the way out of
>>>>>> + * suspend.  Doing it on the way in does not work: the headset dropping off
>>>>>> + * USB is a remote-wakeup event from its hub and aborts the suspend.
>>>>>> + */
>>>>>
>>>>> The internal hub which will be quirked by the next patch, or its parent?
>>>>
>>>> It has to be the internal hub if quirking it works, no?
> 
> The parent needs to be quirked: the breakout box's own hub, 28de:2613,
> sits above Microchip USB2744 (0424:2744). Only the 28de:2613 hub ever
> registered wakeup events, and quirking it alone is enough.
> 
> I also tested the quirk using a stock kernel (7.2.3) using the kernel
> param `usbcore.quirks=28de:2613:j` which stopped the headset from waking
> the host. Without that param I found that the headset would wake the
> host when healthy but not when wedged.
> 
>>> I believe there are two separate problems here:
>>>
>>> 1. resetting the device at suspend causes instant wakeup
>>> 2. a few seconds later the system wakes up anyway
>>>
>>> 1. is solved by resetting on resume rather than suspend
>>> 2. is solved by the quirk
>>>
>>> Questions:
>>>
>>> Any chance that 2 also solves 1?
> 
> It does. With the quirk from 3/3 and the driver rebooting from the suspend
> hook instead of resume the headset reboots during suspend entry and the
> host stays asleep.
> 
>>> Would resetting on suspend be preferable, as the comment suggests?
>>> Maybe it would, if the reset can race with DP seeing empty EDID?
> 
> Yes, and the log bears out the ordering concern. With the reboot on
> suspend the headset is already back and so the EDID reads cleanly the
> first time. With the headset reboot on resume a re-enumeration occurs.
> There was no "EDID err" upon resume with either variant. We can go back to
> Mario's implementation of headset reboot on suspend.
> 
>> I do think that resetting on suspend makes a lot more sense for that exact
>> reason.  That's why my original PoC did it that way.
>>
>> That's a very good idea to see if the quirk + moving it back to suspend
>> works.
> 
> I've validated this approach works. Happy to return to it.
> 
> Diff against 2/3 moving the headset reboot back to the suspend hook:
> 
> ---8<---
>   drivers/hid/hid-valve-index.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-valve-index.c b/drivers/hid/hid-valve-index.c
> index 43c1142b7215..f6941dd04910 100644
> --- a/drivers/hid/hid-valve-index.c
> +++ b/drivers/hid/hid-valve-index.c
> @@ -103,14 +103,18 @@ static struct attribute *valve_index_attrs[] = {
>   ATTRIBUTE_GROUPS(valve_index);
>   
>   /*
> - * The headset's EDID service is lost when the host disables the DisplayPort
> - * PHY during system suspend, so it needs the reboot on the way out of
> - * suspend.  Doing it on the way in does not work: the headset dropping off
> - * USB is a remote-wakeup event from its hub and aborts the suspend.
> + * Disabling the DisplayPort PHY during system suspend leaves the headset
> + * unable to serve its EDID until it is rebooted, so send the reboot from
> + * the suspend hook.  The headset drops off USB about a second later; that
> + * does not abort the suspend because its breakout box hub is quirked to
> + * not be a wakeup source.  On resume the hub finds the rebooted headset on
> + * the same port and resets it in place, and the connector detection reads
> + * a fresh EDID.  Runtime autosuspend is left alone.
>    */
> -static int valve_index_resume(struct hid_device *hdev)
> +static int valve_index_suspend(struct hid_device *hdev, pm_message_t message)
>   {
> -	valve_index_reboot(hdev, false);
> +	if (!PMSG_IS_AUTO(message))
> +		valve_index_reboot(hdev, false);
>   
>   	return 0;
>   }
> @@ -130,8 +134,7 @@ MODULE_DEVICE_TABLE(hid, valve_index_devices);
>   static struct hid_driver valve_index_driver = {
>   	.name = "valve-index",
>   	.id_table = valve_index_devices,
> -	.resume = valve_index_resume,
> -	.reset_resume = valve_index_resume,
> +	.suspend = valve_index_suspend,
>   	.shutdown = valve_index_shutdown,
>   	.driver.dev_groups = valve_index_groups,
>   };

Thanks for sharing that.  If we do stick to a kernel quirk we should do 
it at suspend instead of resume.

But to this audience, Curtis had some other findings that libddcutil is 
causing part of the problem on Linux.  There is still some more 
investigation to be done why (for example is it a concurrency issue for 
a shared AUX resource?).

If there is still kernel patches to be neeed, they'll be posted in a v2.
