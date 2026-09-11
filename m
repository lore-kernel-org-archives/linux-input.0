Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0E35201F;
	Fri, 11 Sep 2026 06:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106514; cv=fail; b=iLQf6X1WmL1y6qy14gDwCfoTb4gjowLBz3XvYFd3WGdFuW6S45JKQU+RvMb7g6l/1drXTCBRCr3P25W/JPkJEdKa9Am5Xjok9fEnCAwDFyUju/lKOaJ7IQf05a6oFeVPMS0SI6Q3QuaEJKSFKMrfaqGajsUkIqn7+rl2askgjS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106514; c=relaxed/simple;
	bh=DsS8tzKjs3hKl0psiagIWYOmR6Ru8naGLM8anh3h9yI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jQGnyKr3Aexq2KiD8wrGL12HB8cv+zSq4rpZi9fPMvd5ql6t8RqdYh4AodS+izgBQBNaWrpTA8Gm/X3TZYvsTikcqJOC72aJJoVdd1XiA9N2Z57YU6WhO4B5KHbezcx9BzL+vvtO05o4uREhZHANi43Yyp19H1td9HdxoYFp9tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yu3jwEli; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yu3jwEli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjWLR0WJT8TJi0Wj5bZQ+tZFOU/HYlj+hXzgl9WCV0KKcB5IDaVFavqKuovjZExGEwroyzYx023P4daDfQ7N+lYe3egsgrpsDkoEOLxBsN2ZDA4Rp5wFKKd1xNE4xC/q2XH8tX2L1UEcpmVlWbrC5FXtkxvTWvKTIwBGkkdewk00YdbvfDrFPnynMJyvsuKz1NTNPfP8AgsHsvfMrRVW6XirZ7gcYHsbgARQsLxR7wirhi0fWYwnbCj618u7MvkMey2kPMXX1lrCyMu5CDhVpjLaSGng8g9A3Hs5QSnIs742y+7d9OWjmvGgklBNt6kJXgUZumLCQHVdKHZ52HN48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rADBkSyg+xUKXdCGtXPxLpn0XjJ+B/Z6vyhSpf5DSLo=;
 b=tIxl/dGSCFLXuIPOHOJtHuDgLDk/0SfnSGFra3HbKjCxi7Qn5H8A1hEyvAKEzUR6b7VbxhFnpRXXhWZWp/GrXp1sqJEBDeJpUB6LQQVRYISBdmbVSH0OC27uJzhiLd7pSi3VX4xS57O1rOPUHSVE3aC0DD59tjrl2rp56S6xspOuFTnL+NnFdx0j9A0+VHcdYbUPpM0gP0LsJMKU1DRoGkmZBWFMNcusdFz8dxZXJn0NotMV58oSzba2FO912NDgqXm5nuqNqWX96euys6AFatEOL2gxEFGQBFIujluqiAJHYPr5QlSL6esINTyR+Ok/wk9VJxlo3Iilii9BbhYxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rADBkSyg+xUKXdCGtXPxLpn0XjJ+B/Z6vyhSpf5DSLo=;
 b=yu3jwEli0HVj4VDox7L+f0x5J7Mv77RQ0HoDX5rz68Uh/0EE5X6z0pWFCLxYjcCSyqVGoO0e1SnnJzxIIGTXrjRBDhDo9SY11cn03ROftK+NNWSxa/ly1GfRu/HLUeHwzps1FRrc2jFJn+LObajii3wYq72PtH5iicKGfc0O/hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 06:01:47 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 06:01:46 +0000
Message-ID: <39389c18-d35d-47de-b8c1-fc5b5ad69efd@amd.com>
Date: Fri, 11 Sep 2026 01:01:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Curtis Vogt <curtis.vogt@gmail.com>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <2026091133-silliness-recollect-e190@gregkh>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2026091133-silliness-recollect-e190@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0895.namprd03.prod.outlook.com
 (2603:10b6:408:13c::30) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4c9316-5745-4787-0217-08df0fca2943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|4143699003|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QmxnDRRetVjlJhBgUwyvtOJL/E6EMw4D4zuJErc+InU6z038VX7ZC1SNuwe6g1n6Db9VaBk1tnq2bTwzJmZZItfckTNTwm4aob2pfKLS3Bt+OIu56jhkewIo4RDd3uOZQRR1vzuuJNrBqCc9NparJPdrTC2Q3ZVCE4DVnbbvM3Xl7SCOYLWZCUv9Zm57tcjH4WKwYvWNU7h3/VQZDlFftRKtOgl2mtGn3oV9istny9Uy4WDM4JYfamOg/6ci61uLBA8JFlAd5Vdfo5HPZrG0/qmj0yDtfiCX2lOul7yv05s4AWHWJQ+i00Z7GioIBgdHr+SLZ8zITGKon47nw0vA5foWzyPb8x19GQ8JAB8mCyo4Huoqqs0n61PkVag/vVLiA9aPlbUt+Ph6PxDPiwV7hl3EB7Zl9qecgSYuXKZl2nRJ6eONvW3R/UsH2t/5EWz+CCvulJEyLNmBDqpT67mPGTt/9ltmPsYcCQcjmeRm0M3FIUL9q4JaKgF3byQJU8fifJOh2NCSPBAIfz616kTlLZtWFU1IO6p12C5GDxZzrntjteiC+AzkRv28iMwXG1zEXkhxx9aHOmVrK/63dZSVuyksVThUtphYOu2zDCkqyl0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(3023799007)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFFhdndTcFhTaW1ucHgydjR1cnZPcW9JbFQyNnpjbjR0V2JQdzB1dnVXdTZO?=
 =?utf-8?B?MUh2NEdZakFsNmlCdGg5aktvME1aV2IvZFlSUDFjNThBTS8vOFQ4VTZaU3la?=
 =?utf-8?B?YjlGTzdmNlE3VFVFWU5OVlhCb3ZpZzdvTHdyVHpPOUJRLzlWYnZ6VmRkUTFl?=
 =?utf-8?B?TUtMOVlPUVZPS3NuRWVtYVRLTTJENG5qeThpTnBIc3pRZTJHY0JiTXVCRkJm?=
 =?utf-8?B?YklySUNMclRJamtGMXFnOFpNYkFRM2ZITnYzQjBxcVl6TmZKTVBMUldKbnVQ?=
 =?utf-8?B?L0EveEozK1dWSzdlb2k3a081UTlCQm1XQ3NYZXhnNGNUZ0VLaU9UNVRObmhi?=
 =?utf-8?B?T242em1hdi9HcGJ3dmEwalpMNFY2c2kvbGRCNEVFWlpYSEhjeXFvNmo3NkJN?=
 =?utf-8?B?WE41dEUrc0UzNzBBZldjdFdnRHNEV1cwdmVUUmlJSGlDbkpkblhuTjFNTzAv?=
 =?utf-8?B?SmxtNlRwYVZpMy8vamxMWlBod0xNNm9CU1FGMVM2bjduRkNHVjhDTC9scndl?=
 =?utf-8?B?WGpyWWZTVWlqMkJKeG0xSUsvclNpNXpxVGVzWXhTS0owSVI0OWtkcWl0R1F6?=
 =?utf-8?B?MzVVcnhMMHFkVklJTkk3UW9BeE5sTVovMlVmOXhJTUp3d2xZbXQ3MHhZeWJQ?=
 =?utf-8?B?VTl6cS90ajYzWUhkRzZ4K1J0QlhxVm4xUFMxdzdGWDZZNXJrVlZXbHlVa3Fy?=
 =?utf-8?B?NGJzbEc3alJ0aExhODhtTWEveHpXY250K0xjVGFCMFNFV3lwN2xXQnY0QUtS?=
 =?utf-8?B?OVY4cnQreG1URXdKbHFvaDN6RnZCSmMrVzhTV056UDU2NEhXTXBvb1NpU1Jq?=
 =?utf-8?B?QS9PZDkyamhYbjhoaGlmVnRNUzJudGpuc29naGpTNU1LWVUyVDh4ME5DUmVn?=
 =?utf-8?B?WjM3am9qSjRlWm5TTlZhMHdUMnVGdFQ3cWU0MUk0clJ6d2gwRkxRMFNjMHpL?=
 =?utf-8?B?aFJOVTlRRStiM0xXTVlEVGorWm1pbHBGUnM3ekFUU3Q2dWMwcGpBcVdHcThv?=
 =?utf-8?B?Vi9iTkpWUzFuNy9iT0Z0VWNuVE9UeUliY29rdXhrMnFadDk2b29IS2tSV0pm?=
 =?utf-8?B?QnJqWkM3cDI5RGM0bkpYWmZ5b1gxQytXVVUwU2ZtM0RLeDQyVFlTT2hndnoy?=
 =?utf-8?B?bmgwdDVCWmw5NzRaeGdIczVXcFJiZ1M2OGNrYnFUUDFVSm9uTFVyMm9IeEZn?=
 =?utf-8?B?Zkd5MWdCeUx6WEVhV1dFUTFWRkppZW1rb3JBWEVBelVYQlRPM05zRVVHWHYx?=
 =?utf-8?B?RTZJeHFFTUxFOEtnZ3k5NzJjR3ZlMkxlR2ZEdnMyaU5MRUVBWFBWNENNN0NO?=
 =?utf-8?B?aVlBS1RLSHNIMHJDOVRsWWZmNExHekJYOW4zY0d0dXUrU2hmZllKazZtQzc1?=
 =?utf-8?B?M1MyTDd4dlNTUnM0TzZLS21DbW94OEZQaHpBd1lZVTZSeVk1ei96aTljUEJz?=
 =?utf-8?B?Y05VTEJzUzEyV0YzaWhQOGRoMGhhRkxBU2hmTUZRWVpZbTdYY1dYRmFrbGtw?=
 =?utf-8?B?cENpMDB6UEQyTXB4Ym15Wm1lbG1OVGt0QVZkTEJlK3U1TUdRT0dXS3A2ZjZT?=
 =?utf-8?B?SmZQblZxbW9iNDNRTUxrejd3aEJSYlhKSG1sTzFCTEZHNE4xVU1GSEhkYzNS?=
 =?utf-8?B?MWdaRnR5TzlsMDVCTGxDU0dJaFg4YzhFWUFvdTgyelVIb2NzaDdDUUowZlcv?=
 =?utf-8?B?ZXducUoyNlczK0xoRWJDRXVEVHR0TDBMd3FQRHdBaDFGWnZ3REZaVG9jQjZy?=
 =?utf-8?B?MHgza3R2eXNsRUJDMm92NTE0ay9VSW5hVFFOcm9KSTZ2dnVXNWxBcENwaDR4?=
 =?utf-8?B?clM3c0tkODRVeUFnN0JtcTdrK1N0cFpVK29pSUladVduY3JaOVp3UDhXTFFP?=
 =?utf-8?B?cTNGc1E5UW9hRU5NNnRLZS94dEpmNUUzZ25XR3R0eENVblVNdTFVeDQyWDJl?=
 =?utf-8?B?TXFrMUtiMnQvOWlFdytJN29uQmFSdGhjUWg3aVFYWXpwayswcWhFZFJHZlds?=
 =?utf-8?B?Vm8yUWwyZnJ3Nm5Gb1g3b3VHOEdseHZMUjVNWTNzdmNXcmJpcDdpejI1c1M2?=
 =?utf-8?B?QjNyOUZwSkRrTGR6MlcxT0dNZmlQdlBGbW01eTRwemRqbVJHSFZXSkVMNnor?=
 =?utf-8?B?UjRDTWJSZjQrZVhSZWFYVHMzS2o5WjcydUFGTXBWZjd5L1ZZWjhQTlVHaTlz?=
 =?utf-8?B?WllBcmJPQkJQaUtkUTVtSGt2MlBNQnBuaWt2T1pjR29Vd3dHdTZrRURLR3Bk?=
 =?utf-8?B?N3A1d09QWXpoVDIxZHg3dE82b3ZSeTcyTHNuTE5hTzVMVmg0UzV2ZFM4YnNS?=
 =?utf-8?B?cCtVUG0rSi9Tckhoa2NXMElBVTREWVZYa3lNY1RibzllM200TEEwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4c9316-5745-4787-0217-08df0fca2943
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:01:46.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyiDzt4IK+9UC8skFMskkbXXQT2DGNGOpXjsCJhtqW2tKKVyUphc9kAOHY8edzviFA/NvaUSs5y6CsXi+W6Arg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839



On 9/11/26 00:54, Greg Kroah-Hartman wrote:
> On Thu, Sep 10, 2026 at 12:02:53PM -0500, Mario Limonciello wrote:
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
> 
> Shouldn't this just be a debugfs file?  Making it a sysfs file seems
> "risky" as it's not a normal operation.

Yeah I guess that makes sense.

> 
>> +		The Valve Index is a composite HID device. The reboot command is
>> +		only supported by the interface that provides the headset's 64-byte
>> +		output report. Writing true to this file on another interface fails
>> +		with -ENODEV.
> 
> Why would it be present on "another interface'?  That feels wrong.
> 
> thanks,
> 
> greg k-h

