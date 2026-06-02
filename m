Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896F3B8959;
	Tue,  2 Jun 2026 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389300; cv=fail; b=lq6Nmobsk4D9M8z8RLZWSghuhtM9yrFGBvpNjjNk8JjLAzblS5KPNnzeG/Uz8xOyzD3N72lUM7aV5rNGqwt8Z52iE50vsmXzwXtK6JEKJfptwVii3M+ZI0QJXPx5TA9/R6YZSccdxg6Q+1yhLBy2Ucai63+D3OeSDumoUv5ZfNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389300; c=relaxed/simple;
	bh=N5eqt/JM5Lfi8w+t/jfCYu+jwCaoB8TqyP8zvUPF0JI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SbDRyjUG+3MIlGSa82O/HcIjq+x77hpOSSxd/7/2Q8amz4LTLsqSw2kP55oII39EIF+vyO5ko5VBNYlQTwAPEXiBWSJ7BMvV/FpZP8fOh8NrwrHG6rw5zMKVI1pAAHDDA4rnkGD2kRdF/umV8lpZNYbfJDqA/3VLJy04CgAWY8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aTi0Kbkc; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aTi0Kbkc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AubdpEepy/80l79MpAhP+j1h0A+/mNu0ZFkUYcpBaqgLIJTTmp0tJAZ+KKKMDr3bl8GWx1mrUp4/79Q8mOvpVnvfzHXb1tVcu3dVjZlpI3jXbR+QVvxQ6EG+0hh2SagaDZGqa4ApiJkkNZaDUEpE8dCjHjJHqcU+AzzSyzhb/+cUwu8/TehwcFJeBhWpc/ehC0T8t9WpchnSmqbMB6oo+yrbqNJPid0Qf2+WxHscVDkFlZl2L5RLVITVraqMPAlxsCuZhLrunqDWxqT4prpVc23N38XiSkfBS4Eir0b1Elt1umfgCM40N9mMzBjvWARdERwVkjxGlryLaZGhQD+sOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4Ho4SApq/XqIjPI6LC25GWetHNR8dHRvk2VID058e0=;
 b=q5ahQE5slImVLhdz4MssBuybboSox/G30XRlZuQdQ9OqsKpP3kYyOBG45oTh3TuFil9y2rGeCi3TBMz+QkOMtKFdmF/FBB+7ybISVtIoB1fu4lEt0yg0YV2LtSq7ywflld4CdvLRKbteJGXZNgburA6rydmiUlmJwlyrI09RtjbwHJf2ld4kQZ05QmUCl6kkYEd0ik2RJHdsqnPVt5DDgYydrKW3b1mD08R5GorVAp3fR57w5yud/00DTbvXVG57tfLPlRijDf0whABAcndGcVrPjtzBvnq6dh045ew482r8TC8w2JAU4XBsInsAGdVaCmqh0kkW2EFB6qX/Fuo9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4Ho4SApq/XqIjPI6LC25GWetHNR8dHRvk2VID058e0=;
 b=aTi0KbkckcqXQ/MBBOUj5LWnXMHpu+mQmHB/I6hO3ish8SuQkQdFA1yiR3XxxrJeixkEjBkMXVJj8JeBTBKTvQETRl+F/jkcVZbZZOjmBgzmLATctHfuGSQS3m1aDkGsrJX2++wgIIrRqjqmjlMb+OLRaGrz+rSf66LzjuDTPCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 08:34:49 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 08:34:49 +0000
Message-ID: <b9e06f81-2b18-4cc3-8974-6df9063b02cf@amd.com>
Date: Tue, 2 Jun 2026 10:34:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: xilinx_ps2 - replace in_be32/out_be32 with
 ioread32be/iowrite32be
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 chleroy@kernel.org, open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <20260602035907.623599-1-rosenp@gmail.com>
 <79ccbd62-9aa3-41a6-a8db-1737672a8aab@amd.com>
 <CAKxU2N-M+vDeDKtYa6=M-4kazOUrGTrwJfHoF6Z+od1OZ-VBpw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAKxU2N-M+vDeDKtYa6=M-4kazOUrGTrwJfHoF6Z+od1OZ-VBpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0107.eurprd04.prod.outlook.com
 (2603:10a6:803:64::42) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: a87940f1-0ecf-453a-9b72-08dec081cf34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SDy7IqarvZBrLyvwW3TnkDTZDzJxwiplebPW5nD45Xk/yErolTXijA9j3XmQdwJZLTveVL0WuMqlPzSkwYrR63lPzCufSPI4AsKWlvgL04ZlGWxEoMEya6uxQ/FM8hu5CduDWTmdUWUyvYvXrHvyPkDOrqBAaFV8nuE0b5QKmBJGdTQO7Uyef5c1AcYUS5a8BI8usHZwZt0TrbDtcIUamn4JKdrGQps+XIH7ToPTX0QHXL8N8MzKF3CyxRfBG8G3CG4m5+Ztcm+K4Oh0dlyFCB6dVPa6ncYX9BdyKsMpR+GBct0FsrrTOlyrWZOA8i+2jny2eSOtSsoTbJbvgto3Vtiy+j72LOLMqKbx1NYn5KCeAZBahbypw2BXS/aHucZe71zQnTfNx8P+pY1WplQ6zsMGAnspeoXBQ/9jD36A61EFCM4xxZaN4O1pfJeZttk9bKpmgx6dMzGJezQdxdqXU9nJOhJjwU9SnS2dqWaLf5IcyU0BYS7UvN6oG0KtHWwGfkfQK33nMP2FMRiPiEuC1YEjKL/gCyKYhJX6wabVW8WSic+ocK8qzPxgihLfnJguqwEeWyFf6PihqYwntJ47XS2ePE13OrJppFKLXQKChZ1uu1fNCuhNUtPLH7wp51mSZcTS5ffZ05trFFYKd3UGycMGmGnAFCk6jvX35CWDGcy2mxWtbLW0TpSWs+L0ijsS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1FqcVRqMVdJNy9QOVpSa2tXYmRlMWx2cS9lUENmbDlTR2lYZUhldjhMNE8w?=
 =?utf-8?B?bUdCaU40bnppYU4xdjNYM2FmNzAxRUhMWmtneVErcjA3aFQ4eFV6TWhKM0xk?=
 =?utf-8?B?RGdWVW1FbFhsV204a1dta3VBQkNSUEs4cE5UN3c0c0VjSWdqdjF4S1JQcmxL?=
 =?utf-8?B?R05NcTRNMjNBNUYreUVVUmJYWVJtdUc5ZlNwMTFxNDJZN2pHckVGaG85QkZw?=
 =?utf-8?B?YlFvcVdjSk1uYzlWbnd5dmlCdmpiS3JZY2JVcjhLSzFpSmRrT28rcEFaRlVt?=
 =?utf-8?B?QWZQclQ4OTBIQVNqMzBSZ0J2enl4NEFJYXlsTTg0QTlvRFBWTm1FVXJXMnVB?=
 =?utf-8?B?ekRPblI3NzR2TUxWd3lmRGw4SUhPNXV3NzRzSVhHSDlnQUlnRjVNRDNiVitW?=
 =?utf-8?B?SituOE9RYktvTlU0aVpYOW9OczhJSDdPYlBYQ0h1ZVlUTm5oYUk2S28waWJI?=
 =?utf-8?B?b1NsOUloaU9YdEZYRlBsWU1URVdjRlFjOXlHTTlGTTZYQ0NJZ1NuVmRJYUpP?=
 =?utf-8?B?N2RqS2pjeEVwSjVTYlF2bUdXbFVyQWFHcTd0WDYxR0hvNWMzM1dKMWp5OFdW?=
 =?utf-8?B?TDBqQjdYaWdGanZYL1B3Yy91UDZRMEJLU2VEbDA0V2dxcUtXUkNzK29WZzlS?=
 =?utf-8?B?S1J4RGJyWjRJN1g0ZVZFL2F3eXpnMWVCdmFFdVIxSSt6Mk1JMHh2ZUJFL2JK?=
 =?utf-8?B?STZwOHhxVkNKaFpvSkNGVUpwUG5yMHUzVXF2cDJSS24xV2hSa25leGFHenZQ?=
 =?utf-8?B?T1pPc2RBWGZQK3FGN0NuUVZMTXhDaDIrS1RIMGoyS0xmSDNyVVBCVUMrYS9Y?=
 =?utf-8?B?dkxnWWZ0QVZIZzNuY1lUbzhnSTV6WGErT3l3RlFHbkErQng0Tm1LdHJFSFpr?=
 =?utf-8?B?U294TWhwN0wvUTJDb1JoN3p4aFg3TVpVZXArVC9PL293Y0ZIZTFpK0NjaGZP?=
 =?utf-8?B?OStXZUJlYTIxenBPVmhwMlg0Z3dSYlFId0V5ZWdpUVFIUXBZVWxFNGp5M1lr?=
 =?utf-8?B?V1B4azJKS0U2N3VzakdCYkh1R2JJZWlCejRwTXRIUGwxTzJCUnFoMi9MUTVQ?=
 =?utf-8?B?RHZHWklUSFhjbDVsN1NSZnZMaXlyUHltUU1mNFl4K2hoNjhybE11YzhEajhh?=
 =?utf-8?B?NUR1VlZSNkpOSHJueTBSY1JJRGdiNHBmem5sL3ZZbVRKdnBZNEVQYmgwamV1?=
 =?utf-8?B?bzV0UWd4enZ4OXkyL1EzMkFUenpYU0lJYlk3ZDd6QkFlUXc5RUJYeTgzaXlH?=
 =?utf-8?B?QkZsMStxTlMwSXhWZUxtaVBQVCs4NGFZbE0rMndvbnRZdHBtYmxTUmFIa3dY?=
 =?utf-8?B?RFhtZnZWcnNydmwvR29yNWJkL29pci9CUWlZeGZDZ2JxZjZEZDJqdFdoQmFY?=
 =?utf-8?B?MytGYmJZeDVLRGprUGRMbHJ0MFUvaW1GOUtwbVUwcFpVdmlpRHM4cGlWZ1lL?=
 =?utf-8?B?MXhiYlcydUJoOGd5dlRObTJrQU1jUmZRSDFKS2R2cEZPNmt4ZWdicU5OSkJU?=
 =?utf-8?B?MTFEOU5CSGVET2J1YzlYSlR0ekVDNlFwRWhPOUtPUTR5d2J6RDBBdnpMNDR0?=
 =?utf-8?B?cUFlbzlRSTczblJSdnA1cThJYkRPSm0za3dXRUVvMkJBbTJJSTlWWVduMUZQ?=
 =?utf-8?B?WjI2bEdyOE1MR3o4Q0ovakt6bk1xSUV6NG9iTVpWTEVCS0ZJVzEyTkt5Z2VN?=
 =?utf-8?B?VDdFc05OTzJXK1MzUmdqdFFvRlZ6SVNSYW82UEYrdGFEb0xIdkFIcnZvNTg3?=
 =?utf-8?B?TXRGUENPMCs1SDFGTloxUVVVeEFuYmpaMnpZQkx1WXI2YmZHTThiSEZselZr?=
 =?utf-8?B?VGV0YU1sUlBPUzBZNHExMlVUNy9qTmZkdWZWa1J4Qis3djJEVFdpK3ZIRU9T?=
 =?utf-8?B?RDUwNkJ5eE9nZjQ4M2NZUmI4SkFBMjB5eDRWOVBHQWFRVm5oWlprT1pJZi8v?=
 =?utf-8?B?WXl2WWcrbkROM1FVODYyTlNSazFPY1o5cVdKVnd6dCtGMkxVZzRJZzBxU3Fs?=
 =?utf-8?B?UXhaWWtwQklYanBFYlJhQVRadmFVVkpzUnVGdDVHNExUUW9ORHA1K1RaR0xK?=
 =?utf-8?B?a3lSZDlPWG1yYUJwc2ZXekpJVDVnU0Z1RU15VnZ3VjNDSWRjbU5BY1dVMHJw?=
 =?utf-8?B?OW1wZmFyQTBwVndydFlRZFFBVXBOWDZJV25YVjFOVzRxM1kydUZDSFNCaG9L?=
 =?utf-8?B?dEIzVk1USE5nUFE3YVY1MExZRW9xejIvNjNtUE5TTWduck5RMld5REVHTkZY?=
 =?utf-8?B?bUs5ZWd0OE5LMEhkTkdUYW5NQThOS1VDaWEvTzhqVHJwZWt3dzJMUGVYTk9y?=
 =?utf-8?B?Z1ZMOHRaNDZDa0tKbGs3RzhqT1NXcFRvMVc3eVRtSnQwU3Z5MGROUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87940f1-0ecf-453a-9b72-08dec081cf34
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:34:49.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuGX3ekmw8Av7UF7nQwOBMITE7+QOoLf5gWVMhqa9+WbBz3+FvDZtog8c2whTYXB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442



On 6/2/26 10:27, Rosen Penev wrote:
> On Mon, Jun 1, 2026 at 11:23 PM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 6/2/26 05:59, Rosen Penev wrote:
>>> Mechanical conversion of the ppc4xx-specific accessors to the generic
>>> portable helpers.
>>>
>>> Allows enabling COMPILE_TEST for extra compile coverage.
>>>
>>> Assisted-by: opencode:big-pickle
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>>    drivers/input/serio/Kconfig      |  2 +-
>>>    drivers/input/serio/xilinx_ps2.c | 24 ++++++++++++------------
>>
>> I don't think that anybody is really using this driver and would be better to
>> just remove it.
>> If not, no issue with that changes.
> I have no problem with removing.

Can you please send a patch for it?

Thanks,
Michal
