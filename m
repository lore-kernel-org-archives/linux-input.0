Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416F496D29;
	Thu, 10 Sep 2026 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073011; cv=fail; b=ICLl2q2kTFzQhj5/BsGitSnbe6ZIT0UeR/t3+ImrBMSG4mXSVKbxEPEI2HllTnO1F8zddxXu2pRS/MhfcVUlQs/cttZL4C39EzjPzVKqeZI0la05hrGV6w4UXUs20KBnoMHQRUZdJfPvkZxeSeZyTgJAuKhRrJh+NKmkrokmbOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073011; c=relaxed/simple;
	bh=FCbJVNsRD1dvIYr4NwrAhiRtHrOOKV+NZOshz9mfWuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mHeXrpp4i2UiXL+6bUSoJ8e2dlDc0tLSWQvQBEtwZjP6mUKCB4sQVYtgSrD5xE8wXqST+X8eupOV2FcCzuM1zkWahCjlgpUOVnn9qCNhaWvhLf8Kl8dM+1ReesJO+qM8PnvcPzM86ao6dv2QzmW0DdrT1nzytpiLi+/vljInL3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q1IDWQkC; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q1IDWQkC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk8zixvQMKLXnsxJN2RRk6lZdOuppFHZx3a6cuXjWmV5d0f6wvxUXU0HsN9Yj9uRB3BXDbqOl9J/nPAidsYlB2lckLjil7F4YzO+y3EYPzwZGmqL8u+8uO9KrCBH7CMdFE9sM8AjMLfo9iTzn/86CccwuisoTZTTQRuf4r+BVwg2+6jll8BTLaxrCYhcgvnihHKT1L5CzVHxCKeKaeHHyrnbhJpOBmyKVB1NH4s+BqQO4aLKAkfiITXAFohGCkHaQ4ZKourWE6qg6tHKFFgOFgashUpKQeku4fYj9J0cfhuH4VMG6qUfl6cfMllXvFoRKUj7YSz49wQoSr2ylGP5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KOoJe8e1Htj5akEXutOg8wkVy2SerLxiBamIQnAslg=;
 b=auMENIinKqj+H6QVDE9ui2hfeTVannsHKmhmlDgoWlsYJ3Qkv4CvzvWinAztZmQY77bm28y9zOuCdcTnqIH2kfqAKgdcsVmaMlcaiQ7v9lA25jUrajooer3rWgY+kSVGnq9Gezm+H9q7Rx8KvDrx4UKC7o0y3Dbjy68OgaObZ3AjbACo0INl9SoI/UxCFmvtzfW8n2EzlDcNb5PhoB4YK6mC7WGFwg3MKswCieRE1q+1l3gSKZqj8new2Z0IHX9IZdi9fouoX01CTWDVttr4q9xYKQWbtfWQV9UDvF3yeeuJ47cflKzaB7PqabTZCyRGd3E370ERFVHPaerVEarl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KOoJe8e1Htj5akEXutOg8wkVy2SerLxiBamIQnAslg=;
 b=Q1IDWQkCmbiKcAUrSyK90GkONDuIsSPJjzeZc2WtNPCScy3xfqA58qOfY0gWAOOU4m03wdSnY6gFOYjtsPHqUKxFwuiEmiW1ZkvwC9Z8C7xDfdsaJc5gtNl7NnHyu/f717BdEJoWYE4d9unrc+W+iIJTNEUAy4SItrDiOSdlPEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 20:43:21 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 20:43:21 +0000
Message-ID: <55918a70-72c9-4f55-934b-81a692d4619b@amd.com>
Date: Thu, 10 Sep 2026 15:43:18 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Content-Language: en-US
To: Michal Pecio <michal.pecio@gmail.com>, Curtis Vogt <curtis.vogt@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <20260910220421.40356e51.michal.pecio@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260910220421.40356e51.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:610:cc::16) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 337f644c-5ca7-4a01-07fd-08df0f7c26bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|10067099003|3023799007|22082099003|18002099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	jXps/XfcdunM6P2PlYNoD4yKsua3PNJ/xGSJBZdsVM1tbTNKuoiM9be3h71O5tNiQq65okkMi83rcyDwMgLR2AHDPyZCFMzt/RB3tta8O3nXB/UUJP/9A1/W7Zd5eKzb0Z8RMJqugwtgs/phBk9/L3wOlz+wxCjsOyGb+Iyio87rxrugRESNnh2GkAitKdS2Q8u8Ybq1D3QEyhi+329xKR6Kne+bna64xl6oBzDZLbuRD7kFfKK/Qla3CF9MLfhG19YWASs2fdOnbqeQXuFnA3J666iosyC6Uj3RJ9cqbZkp8fW66T/9Fr2eFopxmKwP2tPrQx+KBvjxlS019nktIkrqoR6fMKeHtWkGjghJmg2uYGnshDpubyLBWIutuThWDEytMhzIqWcmPajoJZYpinQq0H4j8dRAUq+2FWWx85c4XyiYNlhhWJu/tHS55peERadCCPlt7IGSka0Tk26NgXY3UCTva/6HO6fHjyvXF5eo4S1HVZexg/p/6HVy/A4b25skfxMoGwZDxsI4t/6uSv/CKhxuF0NkpYrrFDvMKxTXqRtahHELn65IkrLhxXtt6JA0iD3ioz01DdljT3pAF80tTb7Z+a3Oewm8/+xu82IapVtuWXR/VOQyPmX4aYfC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(10067099003)(3023799007)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXpId2IzODNYVGpqZkEvb3NnejBDaVQ5V2hKeWYxaUJNc05JcXBBOXpsa2hz?=
 =?utf-8?B?S1NpY2g1UDJEWVRkRlpkeXExRkZkRC80QjgvdEMzekRUdkUzYXRKQWo1Vllu?=
 =?utf-8?B?dDR4MXdSMW9rWVVDWmtKb3o1Q1hNb0dMUEFhd0dJWEtJcXZ4YnJyMTlkUEkx?=
 =?utf-8?B?YzhWMmVYQkZMTU5lNS9lN2tRSDdGTkJ4ekFMcWZyVGdHRjlLQ2R4bDhqYjBW?=
 =?utf-8?B?WWxRVTFqdUgrNEMzVVB0RHArdzAvZUovTTQ3OFExUVBsNDRmZUtHMFQ4bURR?=
 =?utf-8?B?bzhEV2J1TFBFcndnMDc5aStzNFRuY21YOXVCRVJhRXFURjA0UGFWSUY3UUtp?=
 =?utf-8?B?bXRsQnNmYmlGMitMTFVxbUtzSEFjdGlNMnQ3ZFJEVUQ5cWVtUXFpWjJDZWNL?=
 =?utf-8?B?NE9Kb2VpTGJYaU9BbWdHRm1mV1JGSGNNamFRTE4xZ0xlaTRWYm81UkE4QWda?=
 =?utf-8?B?bHV4RHpCNEY5ME9SVGsrREt3MjZjOEMyaElrR29RV2xjb2ZnTDhzRGxyZDd5?=
 =?utf-8?B?OFkrVU5ML2VQQ3pEMmQvaUd2TXZHTWhPWnNoRmxUZWx1TU8wSnhEMWN5aGNX?=
 =?utf-8?B?R1dyOWx2N2ViQXZZWlJqaHEyYzZvejRudUliVDhGM1JsY3Vodk55UmdQMFpj?=
 =?utf-8?B?VDZSc1N4V3pzaGd6ZDNic01jOXVCKzYrMzlCZ1VOWlJQQ1FZWkljQ3FwcGcw?=
 =?utf-8?B?TlBYajgvQmxjY1lHZElLZm1FNnJTcUl5VWZQbC9mMXk3dmtZUGdpd1VZYmZD?=
 =?utf-8?B?S05CaUtMWEZqcVEySXpCRjdUeHpzUTlpSVo4anRBZ2dDd2NDZFNJVklZcC9r?=
 =?utf-8?B?ckxGSEZBTlplUjczbFdRRjNzSGNnTHpnNUNtUmx2MGtpSkZOK0ZsSGRNMmdv?=
 =?utf-8?B?WUY2S3YyTXZ5VWZEZ09zR29DbXFDVEo1MTB5NHptRFZFcDdQQlBpaTlRY0VE?=
 =?utf-8?B?K1hwQkJPWnVYODZoMk5oeGkydWs4QTg0WXpkNzVaUGxLdnhJcXdkMVdNUGhE?=
 =?utf-8?B?amtFemszN29RU01QNmtQNFBURjhpbGJHamNCTHp4OFlva05vWHdGM2NGVGJq?=
 =?utf-8?B?bmFXUklmNXE1SEM2Z3pqN1Q3NC9zYzVLTHdvR01JVURGVjRWY1NBTjBHOVlP?=
 =?utf-8?B?OVVKcHRleVZkV0JJSVhobktTQUVVQVkxeGtVTHBFR2JUSUNJNEhmMTVrbnJp?=
 =?utf-8?B?VmkzaFUzRzRzb1VZdG5LZHJzMC9iYnJYN0JtTmJWdm81bTJhY3lFNkdPN3c5?=
 =?utf-8?B?TkpZLzREb0l6TVlnVFUzTlNGakRHQ29VOWFZQTQxSXVnWTkxZFR2VElWNVJy?=
 =?utf-8?B?bHdjNy83SjcwdHI5T1FLVTZITXJpVVQ4WjM5eXRYR25xeVRPSHgwTnh5VEZL?=
 =?utf-8?B?Sk1Oejc4dHNKcW1HQjF3NFN2cEFzdHhIZ2xDTS9LV0RXMU1hR3JEcEFacDRo?=
 =?utf-8?B?a1hlaVZiMWJMQ2FwWkx2OE1lZ2VicnhxTEpBNUFZb3VWK25tdTlZcVNMdjl0?=
 =?utf-8?B?WXM0TGFQaUYyVWxtekR2ZjNpWE54Rkt3U3dDTCtZUHZEZ05SUktSbnRiamQ2?=
 =?utf-8?B?TjY4OVJhOVRuUmJyeFJaaHJYaTJzSlloV0NjZU1hU2xJdHRlY0p0aTYwZE5x?=
 =?utf-8?B?MCs1WTFFSk1leDdIdFJOcE1sR095YndqRVFqWHZ0RVJ1NDA2UW0wNkdldi9D?=
 =?utf-8?B?MkFUaHQ3dU9SdENxK2ZiYWJRSm90UVFNOVpuOVRLZ2lMeFZRSTBSbzNPYmZU?=
 =?utf-8?B?Tjh4TTBxWkNEaElRUjF6UTJKVEY0bWEzeFJTWHhydDYxbTNzZmdXZ0VrL1pG?=
 =?utf-8?B?WVdVR2EzV3lTN3NGZm5iVjlybG11MGFOUTBYWWpnZzlEVTlZVEpCMzhKc0xh?=
 =?utf-8?B?TnYydW10WURFNFlkWnNvNVFTMHdmcURkV1Rza3RHVUFjWi8vNWhuY2FadEc4?=
 =?utf-8?B?Y1liUG02cUVHUm50WGxjU25CQ1lnd1VtOWJNUDk2YUpBZUl6bXhqVFlhZ0l2?=
 =?utf-8?B?eWF1Z1R0RDQvbExBYnBXWW9QSnNReXQ2TnJ5VTlsQlo4SmJNaXJoTVowSkg2?=
 =?utf-8?B?V3BRZFV6UlpPaDNIRjRLbVdpc0FTdDBGSVo4QmRwLzVYTG1iQVc5VWh4bzVt?=
 =?utf-8?B?MEpwK011Z2xqMmkrOTIzRzJiSER1N3IyaEFSQ2JmbkVVRVFQUERjMFdaVjFZ?=
 =?utf-8?B?YTNyYmhHVjQycjN1TFlMVjh2NGFXRmdmbnhxMzFYRmdRUXprNEd3ZkVYRTFp?=
 =?utf-8?B?Z3p1SGRFNmZFeVlJTmRCZi9xbW1IeUJHN2VkZzlweFRRUmJGZGRmaEpkNmxR?=
 =?utf-8?B?N3J5LzVJTTZDR3NEd0JGWEZlRWlNZmpRQ0Z0MFUwU0k1SG9VdHlFdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337f644c-5ca7-4a01-07fd-08df0f7c26bf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 20:43:21.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MY3fgJ10QkJ0gedGbTylSEp9M118CfS+eDVQ4BahXmA+WAVqpXYTWXLI8G76bUgxs0qWFJl/uSWEouREioL0jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092



On 9/10/26 15:04, Michal Pecio wrote:
> On Thu, 10 Sep 2026 12:02:53 -0500, Mario Limonciello wrote:
>> The Valve Index HMD stops serving its EDID after the host disables the
>> DisplayPort PHY.  The headset remains powered by its breakout box across
>> suspend and shutdown, so the bad state survives and the next connector
>> detection reports "No EDID read".  The HMD then appears as a synthesized
>> 640x480 display until it is power-cycled.
>>
>> The 64-byte HID output report 0x16 with command 0x01 reboots the headset
>> and restores its EDID service.  Add a device-specific driver which sends
>> this report for system sleep transitions and orderly shutdown while leaving
>> runtime autosuspend alone.
>>
>> Resume a runtime-suspended interface for a shutdown request and restrict
>> the command to the composite interface which declares report 0x16.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4333
> 
> Hmm, people say it's a regression, so it looks like at least one
> alternative solution should, in theory, exist...

Right.  This bug sat for a very long time hoping someone with the 
hardware would bisect and we could explain what changed.

My initial suspicion is timing.  But scouring the web you can see it 
happens on NVIDIA hardware too.

https://forums.developer.nvidia.com/t/valve-index-initialized-in-unusable-state-on-boot/324710

So 'unlikely' that a DRM change caused it.  Maybe tied to the F/W 
version on the Index and it got updated from initial report to failure?

I have no idea.  I don't have this hardware so I'm just trying to help 
these people how I can :)

> 
> Obligatory question: does it work any better with Windows? :)

Curtis?

> 
>> Link: https://github.com/ValveSoftware/SteamVR-for-Linux/issues/939
>> Assisted-by: LLM
>> Co-developed-by: Curtis Vogt <curtis.vogt@gmail.com>
>> Signed-off-by: Curtis Vogt <curtis.vogt@gmail.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   .../ABI/testing/sysfs-driver-hid-valve-index  |  12 ++
>>   drivers/hid/Kconfig                           |  11 ++
>>   drivers/hid/Makefile                          |   1 +
>>   drivers/hid/hid-ids.h                         |   1 +
>>   drivers/hid/hid-valve-index.c                 | 142 ++++++++++++++++++
>>   5 files changed, 167 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-valve-index
>>   create mode 100644 drivers/hid/hid-valve-index.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-valve-index b/Documentation/ABI/testing/sysfs-driver-hid-valve-index
>> new file mode 100644
>> index 0000000000000..47d8c26b1eace
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-hid-valve-index
>> @@ -0,0 +1,12 @@
>> +What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/reboot
>> +Date:		October 2026
>> +Contact:	linux-input@vger.kernel.org
>> +Description:
>> +		Writing a boolean true value reboots the Valve Index headset to
>> +		recover its EDID service. Writing a boolean false value has no
>> +		effect. This file is write-only.
>> +
>> +		The Valve Index is a composite HID device. The reboot command is
>> +		only supported by the interface that provides the headset's 64-byte
>> +		output report. Writing true to this file on another interface fails
>> +		with -ENODEV.
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index a81bf51cbcf10..8ea2dd570058f 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -547,6 +547,17 @@ config HID_WALTOP
>>   	help
>>   	Support for Waltop tablets.
>>   
>> +config HID_VALVE_INDEX
>> +	tristate "Valve Index headset"
>> +	depends on USB_HID
>> +	help
>> +	  Support for the Valve Index headset. This driver works around the
>> +	  headset failing to provide its EDID after a DisplayPort link shutdown
>> +	  by rebooting the headset on resume from system suspend and at shutdown.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called hid-valve-index.
>> +
>>   config HID_VIEWSONIC
>>   	tristate "ViewSonic/Signotec"
>>   	help
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index 48a863b245eed..21f512cab6250 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -156,6 +156,7 @@ obj-$(CONFIG_HID_XIAOMI)	+= hid-xiaomi.o
>>   obj-$(CONFIG_HID_XINMO)		+= hid-xinmo.o
>>   obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
>>   obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
>> +obj-$(CONFIG_HID_VALVE_INDEX)	+= hid-valve-index.o
>>   obj-$(CONFIG_HID_VIEWSONIC)	+= hid-viewsonic.o
>>   obj-$(CONFIG_HID_VRC2)		+= hid-vrc2.o
>>   obj-$(CONFIG_HID_HUAWEI)	+= hid-huawei.o
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index b3aca5aa91767..15cd29a338a8d 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -1391,6 +1391,7 @@
>>   #define USB_DEVICE_ID_STEAM_CONTROLLER_IBEX_BLE	0x1303
>>   #define USB_DEVICE_ID_STEAM_CONTROLLER_PROTEUS	0x1304
>>   #define USB_DEVICE_ID_STEAM_CONTROLLER_NEREID	0x1305
>> +#define USB_DEVICE_ID_VALVE_INDEX_HEADSET	0x2300
>>   
>>   #define USB_VENDOR_ID_STEELSERIES	0x1038
>>   #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
>> diff --git a/drivers/hid/hid-valve-index.c b/drivers/hid/hid-valve-index.c
>> new file mode 100644
>> index 0000000000000..43c1142b7215b
>> --- /dev/null
>> +++ b/drivers/hid/hid-valve-index.c
>> @@ -0,0 +1,142 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * HID driver for the Valve Index headset
>> + */
>> +
>> +#include <linux/hid.h>
>> +#include <linux/module.h>
>> +
>> +#include "hid-ids.h"
>> +
>> +#define VALVE_INDEX_REBOOT_REPORT_ID	0x16
>> +#define VALVE_INDEX_REBOOT_CMD		0x01
>> +#define VALVE_INDEX_REPORT_SIZE		64
>> +
>> +static bool valve_index_has_reboot_report(struct hid_device *hdev)
>> +{
>> +	struct hid_report *report;
>> +
>> +	/*
>> +	 * The reboot command is a vendor protocol carried in the unnumbered
>> +	 * 64-byte output report of the headset's third interface; the first
>> +	 * data byte is the command id.  Report 0x16 is only declared as a
>> +	 * feature report and is not what the command is sent as.
>> +	 */
>> +	report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[0];
>> +
>> +	return report && hid_report_len(report) == VALVE_INDEX_REPORT_SIZE;
>> +}
>> +
>> +static void valve_index_reboot(struct hid_device *hdev, bool wake)
>> +{
>> +	u8 *report;
>> +	int ret;
>> +
>> +	if (!valve_index_has_reboot_report(hdev))
>> +		return;
>> +
>> +	/* USB transfer buffers must be DMA-able, so not on the stack. */
>> +	report = kzalloc(VALVE_INDEX_REPORT_SIZE, GFP_KERNEL);
>> +	if (!report)
>> +		return;
>> +	report[0] = VALVE_INDEX_REBOOT_REPORT_ID;
>> +	report[1] = VALVE_INDEX_REBOOT_CMD;
>> +
>> +	if (wake) {
>> +		ret = hid_hw_power(hdev, PM_HINT_FULLON);
>> +		if (ret < 0) {
>> +			hid_warn(hdev, "failed to resume headset for reboot: %d\n",
>> +				 ret);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	/* Use the same interrupt-out then SET_REPORT fallback as hidraw. */
>> +	ret = hid_hw_output_report(hdev, report, VALVE_INDEX_REPORT_SIZE);
>> +	if (ret == -ENOSYS)
>> +		ret = hid_hw_raw_request(hdev, report[0], report,
>> +					 VALVE_INDEX_REPORT_SIZE,
>> +					 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
>> +	if (ret < 0)
>> +		hid_warn(hdev, "failed to reboot headset: %d\n", ret);
>> +	else if (ret != VALVE_INDEX_REPORT_SIZE)
>> +		hid_warn(hdev, "short headset reboot report: %d\n", ret);
>> +
>> +	if (wake)
>> +		hid_hw_power(hdev, PM_HINT_NORMAL);
>> +out:
>> +	kfree(report);
>> +}
>> +
>> +/*
>> + * The suspend and shutdown hooks only cover orderly power transitions.  After
>> + * a crash, a hard reset or a power cut the headset is left in the state where
>> + * its EDID no longer reads, and nothing recovers it until the next orderly
>> + * transition.  Expose the reboot command as a write-only "reboot" attribute
>> + * on the HID device so userspace can recover it, for instance from a udev
>> + * rule that fires only when the connector reports no EDID.  Writing to an
>> + * interface that does not carry the reboot report returns -ENODEV.
>> + */
>> +static ssize_t reboot_store(struct device *dev, struct device_attribute *attr,
>> +			    const char *buf, size_t count)
>> +{
>> +	struct hid_device *hdev = to_hid_device(dev);
>> +	bool val;
>> +
>> +	if (kstrtobool(buf, &val))
>> +		return -EINVAL;
>> +	if (!val)
>> +		return count;
>> +	if (!valve_index_has_reboot_report(hdev))
>> +		return -ENODEV;
>> +
>> +	valve_index_reboot(hdev, true);
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_WO(reboot);
>> +
>> +static struct attribute *valve_index_attrs[] = {
>> +	&dev_attr_reboot.attr,
>> +	NULL
>> +};
>> +ATTRIBUTE_GROUPS(valve_index);
>> +
>> +/*
>> + * The headset's EDID service is lost when the host disables the DisplayPort
>> + * PHY during system suspend, so it needs the reboot on the way out of
>> + * suspend.  Doing it on the way in does not work: the headset dropping off
>> + * USB is a remote-wakeup event from its hub and aborts the suspend.
>> + */
> 
> The internal hub which will be quirked by the next patch, or its parent?

It has to be the internal hub if quirking it works, no?

I guess it's easy to check this by looking up wakeup count from all the 
applicable devices in sysfs while toggling the sysfs file introduced by 
this patch?

> 
>> +static int valve_index_resume(struct hid_device *hdev)
>> +{
>> +	valve_index_reboot(hdev, false);
>> +
>> +	return 0;
>> +}
>> +
>> +static void valve_index_shutdown(struct hid_device *hdev)
>> +{
>> +	valve_index_reboot(hdev, true);
>> +}
>> +
>> +static const struct hid_device_id valve_index_devices[] = {
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
>> +			 USB_DEVICE_ID_VALVE_INDEX_HEADSET) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(hid, valve_index_devices);
>> +
>> +static struct hid_driver valve_index_driver = {
>> +	.name = "valve-index",
>> +	.id_table = valve_index_devices,
>> +	.resume = valve_index_resume,
>> +	.reset_resume = valve_index_resume,
>> +	.shutdown = valve_index_shutdown,
>> +	.driver.dev_groups = valve_index_groups,
>> +};
>> +module_hid_driver(valve_index_driver);
>> +
>> +MODULE_AUTHOR("Mario Limonciello <mario.limonciello@amd.com>");
>> +MODULE_DESCRIPTION("HID driver for Valve Index headset");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.43.0
>>

