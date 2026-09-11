Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF76369D72;
	Fri, 11 Sep 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139562; cv=fail; b=S4EgPLZZHg6vA98XMkZNGBdprtY7It0MWQmkwhylTKpG4pSlvB/xaSz8EAhr0Nh2YwFpH6ykUWF2h56HALzhWwn1jV91G3pres1XTHDAM2ssEjj6SNRHnc1tem5TmYSean4mKJG6fUFAFjOc8QtUjA/T6tqewz2Fq5yqQdmGayY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139562; c=relaxed/simple;
	bh=E3Fdp4X7s0yzTBQOjhb4eDv5mLv9i56skOojDgkU2OY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D0HpKKY3MUAmyiGuxw+BSqalVD2pYInNC/YeW139QNW6rzSDwE64kRr1lqyEh8WSFc2xOncmkja0WWJ15uT/Y6oEzyvkKhssWXgw6Qg4fyUySmM1Ekhm2EtHYbvMFwl512ve0Y87HfKxh2ge/GBzykpGz3wZFqiDaoAkN0Kg/CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q4W0wHoY; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q4W0wHoY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH6/toJODxt8rFwtueIHQFWwPGU267L+LzWqfltMQlQEONtXU83juW1f/nF40o+igBPD2TX/6Gn8iIZ9QROG7ebjIo4FE2WbbXi9YXH8ALZUc0Z8Qten2d2qxxeqHlkHPKBL0iiPt7GMgdsMyrmiX9JjLRHZ3S5flz1ag2ZIAREekinzMlZTRlVrD1D9CRT17aAnE0Stf38TR/eAfJglChs2MmQOORJ9g0XyvwBBUpLEARv3NhWIbmytMfx3ghRAQVcHlYSFd4krQWPEtNvbBGiKOE7Es+asAVLEiSp12FR5OwHNEJle/hBDoLZhKDAQiSIeuou6Vg1tAOkukFsdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PIDuasPnkI75GR9zMoAZllxtSThrymZe+5D5GKAJ64=;
 b=fMCF8E+PKMCw87adXoP5k9a0zXVjtjvXdtrYUyfxAqJdb6Z1GdYMO7VCM2vk/5nifYCOpyma/6V1TkHhZPlqvXFEiN4q3DQ3xL0u/SXThLrMBp8MWx4w8dm0vN528X+Q0g6pluUdiBK8yWG0CSFyRvGx9p5Zp88XBbAntMza/6S4X6LGp/mQb1yfe9quFZlCs/2DJpVm5BAtM7/8DGHNALio7UQEwldBuVaqNUDgkfVh6yL6QhGvUF7QvbErxm1fCk4KLasmKVNtMI6zu2xdkHKOOMLbbPUrxdxoiNtYEQWoCMh/f/IDFT5QqmVtJXnLy7PQ6+Umq3+LIslTukiE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PIDuasPnkI75GR9zMoAZllxtSThrymZe+5D5GKAJ64=;
 b=Q4W0wHoYbsjqkKcx5GWDZrEGTVkDQRHD08jF8Kxo6JgmzHlcQUWhyQXbLs8VrBvPki6xycnu0T4FL+CFU0XoFpKY1e3KnTX2NVOfC1ufd1GTcQYjBHuWoXGaOMB4h50ppXn5b6SOA+RsKLCtLp8970Sh5rthKN6pK9pqKZQDNEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by DS6PR12MB851160.namprd12.prod.outlook.com (2603:10b6:8:416::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 15:12:38 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:12:37 +0000
Message-ID: <2d4b2c51-ac5f-4fbc-82aa-8d573d095687@amd.com>
Date: Fri, 11 Sep 2026 10:12:34 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Pecio <michal.pecio@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Curtis Vogt <curtis.vogt@gmail.com>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <2026091133-silliness-recollect-e190@gregkh>
 <20260911111652.703b865f.michal.pecio@gmail.com>
 <2026091106-footing-antelope-7ceb@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2026091106-footing-antelope-7ceb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:610:56::28) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|DS6PR12MB851160:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ad2f4a-8768-4eac-28b4-08df10171d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|4143699003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	436rYtRFKuwkog3Rtyhy0oF0FjQQ4dBfl9gHJ5OxJX3hBeeoqM/kYQo4Z3bDPEbYGOkuxfSPbgy/RsjtdxjAxresiKYGCKkTMCU2uXoPi6HLTpRSIG7oZA4dUNZd+Ne5tZm8Ru2kiNXOIQYjAL1gp1rx1EmUyk6g5eAqgsjEJTkIr34Vl+RAtQ2tnkQcbh/R80tcG6RVMq3Bx7NiF+XRrl5zBzXkzADna9HTQznZTxiCI6Dx0J77Wz4Y6uOinCm4xpmWo1MrO9mhiYAQR6vcNthtUFfxsQ3NdTxwzSXv1ByfQ2rku/s9U61xF/y7ETwRzyn5vPVHYW87OaRSAYy9/P1UKrEqLdzqlqs1bBv6t16Do2yFm8e/IyTY1jXO07KqyuOkHUq3KLcqqi0QKeY1BxosVV16sufe/bOHuQUlF3srbbHea6C+Ya/oSm9QOkk4/PxY+1jPBEHQ0GotEXyayrrvUQ+PirYMMmLbVFVVsJm7DQTYGhvbx3Z+iWiAdzchkDPnOhztIMrRahUP62Ltp9IOsL2AhBX77M4zT0FDsWIEJpOpgNI3z/md0QuQFEgg5DH2Z4Dk4ROy/paXPle2t+YUSCitZ+MGRMgRL+kC98VI1lbUXPWGxoplxDSkF0/SIxIwtOXjSQ/KH+T6/z5bXUGElNk3iO4Co+02FE0nuVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(4143699003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHFoUGFndmZVaDRLcFU1bm4vUFkybDZaZFVYVklhcjlrOGwzN0pja3BtMGk0?=
 =?utf-8?B?cFlDVVNuOW9WMWd3TStkT0dtOWpJMW03VWhDSEhqOU5qR3FrM0lSRitvUXF2?=
 =?utf-8?B?T2h0akZyQnkrTDdvaFR5N2J3OXRtdk4yTHJuK0QyT2dab3BoV1NGcmxKVExN?=
 =?utf-8?B?eFNiZUQ4emF5bWZVKzZROXZDYTQ3bTRwU2k5S0NraUY2dU8vL3FaUlBtdWV2?=
 =?utf-8?B?SHNRNCtONnkraGtnZmxYOG82RzB0UlQrWWh3T3EzWVZHQzdPY0ZxK1YyZWZG?=
 =?utf-8?B?OCtSeDNLaU4wcHNsdUtRRXRZNzducDZVUXI1cHZQakpEVDI4MEkzV0NrVlJ5?=
 =?utf-8?B?cWRDZ2RjUnZQTWNBNEE1dkM5eEl1bUZEdXF0SHdCT0ZDZ3BEbDMrRnpUZ1g5?=
 =?utf-8?B?dFRySWdJTkhEOHBiK1hOb0JSc1NiU2xlYkNSaWl0Zk4xYVEyUUM5SmRCWU1u?=
 =?utf-8?B?VHhwU21lSzkvcEYrWHdSUHpxUjlNMi9abkZxZEw2aFZNSEZwQXVHM1NGWG4y?=
 =?utf-8?B?KysxLzBNYTc2R3R0U0pyQ2gvWnUrSjB1ZzVKTzRqY0RxQks0U0RxcEt0VnV5?=
 =?utf-8?B?M1puTWF4eWdWK0h6elJMZnBpSVZ3OWZkU2JkOFZUSkhRNE9FakQvZ0hFckRs?=
 =?utf-8?B?Nm1tSnhrWUhYSm95R2Z2MGpFblBIT2lBTHIwUEp5S3pxSWxvY09vSFoxSjZy?=
 =?utf-8?B?Lzh1czlrWUdXcmh2YUcyUUxzd042VkgwWVJ1VUUvN0VKcWE4ZEZTYS85YjVW?=
 =?utf-8?B?VmhtSGdCM01IMjVTbmUzbFlvL2lKQTdTdSt5U0psZVNaUFZ4djE1bHliVm1Y?=
 =?utf-8?B?blhuWGg3RnFzVDAyREFTV2t6SnpIR1duSjdsYVNSQ2VKRmNlYUU3UmRkWEw2?=
 =?utf-8?B?SmJpbWI4Y00vVCsvUThzRWFac0NMZG5RV2N3VlV6RXdlc0hwU2RKalFMYVVl?=
 =?utf-8?B?bStkTmtsRWd6SkJmUCtFTHd4eHZ4UTVtODdPMUE4ZWpYK3RueDQ0bzh4UWtr?=
 =?utf-8?B?bVR4MXZ2RGMzSlA5YXNyTmVXblIrOUsxMytFTlFLbUpoVmRuQUxMUjJuY29h?=
 =?utf-8?B?dDJBNElwdlQvTW5QNlF6WHdDVHZCejRkMEMvYkl1eXM3cnFlSHk4c2loSlZn?=
 =?utf-8?B?bmpsdDNwTzVyL1Z6RXgwOHRQRXhkTGxnNHRNNjJ2QTRPRmx1bVcrSkJyZ240?=
 =?utf-8?B?cXdiYnRWQnlJWXVPNlNEN1p3blRkV1NVWFNEU2ZWclliYVRuT1FmWUh1enlz?=
 =?utf-8?B?M0MzR1VGTVp6bVE0TFV2cVJrUWE3bTl2ZmpJNThTcEpab25sSXJkbzd5YTh1?=
 =?utf-8?B?L2NwczJZbXVPNVV5MmxjVjhFNFBwQWkyT1BRSm9JR04wb3pxYVJQSVllYlFN?=
 =?utf-8?B?N3BId1IySTNSOVRLU1FndVNnNEtWb0VKWW81QnFqa3RmNWQvV0VmcUFzKzJI?=
 =?utf-8?B?amJ5T3M5RjVCb2VwYmZKcncxUXNMYUxudktLNHExc0FaUm1VTXhoeG5ZLy9i?=
 =?utf-8?B?dVk5aS9sc1J0TC9jeGlEaWhBbkQwSFMxelYzM00vRjczM3hWb2EzSjRrM0Uv?=
 =?utf-8?B?Ky9VMDdaZjhDZTEyUVJTOHM5a2cwOWFEQ3JBNE9kVmlweTJOeU04ekdRODF3?=
 =?utf-8?B?UDRCUnZGbzllS1A0eVBEQmtTbE9qRnBtOXF4aHB3T04xT1dQenQvd044WEZF?=
 =?utf-8?B?Y1ovZFdkZHNzUWJkOVhXOTNXREZKRGJlMWVkMHc2UWJMSzl0RUZURE9vQm1G?=
 =?utf-8?B?SENrUUovRHdUck5uc1M1OHQ3b3QrTjE2cm5EaXcxblNzSG9VSVdOSUs4dHhD?=
 =?utf-8?B?RUphYkxKQngwbDY3Yzc4SjZ2TE5ueUhGeEY4TmZNKzcwYUpCUFppS1lTY0tL?=
 =?utf-8?B?a24yVlpBWlRDaDFrRXpQeUp2aVpCODZNNDVMK2JuTWZHaXJlSGdMVTZHUERO?=
 =?utf-8?B?b2cxa055UGdIa0VTUjhXczJ6NENwbmU4YVFsUU01ZjViaS9EenI2bFVvSXRQ?=
 =?utf-8?B?aGh0YWZwTXJKdmkvTFVyR1l6MlNSaUZtanVicDVhaHd5ZmI3Q2JhU0xiVVNq?=
 =?utf-8?B?dTgyZTUzbGdPMjVNc0RnbnN1UUlJVWlwaGw3SkVwVjUrT1dzSlQ1dzRkTnJ6?=
 =?utf-8?B?UkM3K0hDTm1tQmplS3lOejNxVTI4OVRmWXRYMkxJbmNteXJQWFArdElVMmRI?=
 =?utf-8?B?VjUrbFlnSzdIb1czQmowYm1yTklDYVpUSkhoRGNsd1VleEhUWlZwRlFhNGc1?=
 =?utf-8?B?cFJXNCttWHR2VGRIcnh1NzY4MzhYNTJaMk51cHo0bjNReGxFTFlQL2dTMm5V?=
 =?utf-8?B?bzlVTHhvN29jQVFMRjhib1k0eU94Zno5Qy9qbXpUK0Q2Yy9ZZmhoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ad2f4a-8768-4eac-28b4-08df10171d07
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:12:37.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xbJ5zQcZQMp7r2FQ/Ouir2f+8bpGblibAPJ3hDJNyGA8Mvvic0OtuT+4hrcGOx1PQHspVOHkSZnwDkavbVLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB851160



On 9/11/26 04:23, Greg Kroah-Hartman wrote:
> On Fri, Sep 11, 2026 at 11:16:52AM +0200, Michal Pecio wrote:
>> On Fri, 11 Sep 2026 07:54:12 +0200, Greg Kroah-Hartman wrote:
>>>> +What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/reboot
>>>> +Date:		October 2026
>>>> +Contact:	linux-input@vger.kernel.org
>>>> +Description:
>>>> +		Writing a boolean true value reboots the Valve Index headset to
>>>> +		recover its EDID service. Writing a boolean false value has no
>>>> +		effect. This file is write-only.
>>>
>>> Shouldn't this just be a debugfs file?  Making it a sysfs file seems
>>> "risky" as it's not a normal operation.
>>
>> Not sure what's "risky" about it, it's hopefully a root-only thing?
>>
>> And it's the only supported way for userspace to recover buggy devices
>> from certain failure condition, it's been suggested that this could be
>> run by udev scripts. Isn't it more "risky" to ask userspace to mount
>> and tinker with debugfs as a matter of routine?
> 
> You are creating an "odd" user/kernel api that is used for debugging,
> that's not what sysfs is for.  sysfs is to show attributes that a device
> has NOT to cause the device to go off and do some random thing (yes,
> there are exceptions, but generally that's the rule.)
> 
> debugfs is "do whatever you want", so that's a better place for this.
> 
> thanks,
> 
> greg k-h

I suppose an alternative path we can build to all of this reset handling 
at power state transitions and sysfs/debugfs is a callback system for a 
failed EDID read.

Something like DRM drivers can send a notify to a global queue when an 
EDID read failed.  Other drivers could subscribe to that notify and 
react.  I guess this would only work if the USB reset sequence to the 
HMD looks like an HPD event to DRM though.

Also it wouldn't be perfect.  If the HMD was connected and the read 
failed on an unrelated monitor on the system the HMD would reset needlessly.

Eh, I think I'm talking myself back into this approach the patch does 
now.  I have no qualms moving the on demand knob to debugfs.
