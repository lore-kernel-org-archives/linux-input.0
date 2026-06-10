Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259134750D
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111570; cv=fail; b=UbG7GL/Ac6jWm9kZIBrgfPzucYJ4LkCWmSrH4VR92pggFslDMRnQvpL3tRVE0q07yi5Uyb+WblewNyLynvExbTbJWjuReYk/YCdH/TU8wqxvwq0z4vMmEeNDxge8K7KJ8FBh1QYsf3gOxOIBzV6C9Y2KTUgf33AWDwkJGHqV6WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111570; c=relaxed/simple;
	bh=xxtqia6uVeiqUNKia+0lAmF3R1lZ315vqhaNfif+VqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kMQcqG7b96mDZFHTramYEZBueRxM22aWNIP7CVbk8LQqOWter7AuocPJnoRH6ZeLIrr514+HlVC4TO8/EPXiffOPhVsyRVjZ+SarnmQFVvk/OFE93HMwuB7qQ7OvQYLtXXbCGiFVITO8+aHxXN52eFZFPGWOuGz0ZEnbOCBX76s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jiAVSarf; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jiAVSarf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btjPotlErddNK4QAY1FB2g0UQI0haO5pX1DLneRPxpdFAcSvhJ5EXskg05JY0KqIW9cB4wAtX+Dga/Oi1b15bjDg36HRIIrStnuW8hvZ1/PbW/nKrq8A5nYcS/Wvkk7AOLEUHQr48nqJPTaeKFzi7c0MgHUCKbJUlrtwyJ3K4jIKjv9vOloSHicFvsD2i8HIk5xGlF7QTHYbMv86hIv3/K86TyE/G0sYarTGAOmmtglPb14MDlLOUmSKIIFEakdac4ykTvPqu6DL9D5AiKlDNQ3oHaav/3AaImdDGuHcuVl5v+BpAdi0AydlAprKlls2nlKRjcWh65d6LTJrEh2BRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+7iOKxeGFa01UpT9Wn4kkkZYVbUjS+KkBHcugDhbvI=;
 b=cdoCsbM0Y/DJPAKtRfC88pXSkJ4cgZM2xIN9iabFnsHzXzZVpdBVD1mwZlCIGdDu9C5m745LTjTRe9Y6ZL6yjtWWV3NjxxZe/NgVp7jrSk/wTYUiIqHzZaWw/QKSocJUk1H1CMB3LMXytPZuAzRF62qyyyT7g9xI7ogZZZrXekzoyMWygQSeN95xiOmlco65KeUQqSYt3M5C8LIePn5FA7/zqOZ5VvF6HZOLgj5xXJOv9vUUUsA2Kw4oIK+KMld9aE8EBeQsLJWIzeaG1lWVN8McfUKknesWU0S+jgN5Lxed74oNf75nzwtoxqlRtUy3t0Bgya5WIEInYZGLEkwfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+7iOKxeGFa01UpT9Wn4kkkZYVbUjS+KkBHcugDhbvI=;
 b=jiAVSarfPmTpL9ufT0Yyg3pwYcOSisW7y55luGFDMmWR8NkTTNLzB7CdMCA+r+HTJAhcfJqRltC5FqupmXzbXjicDpajNnQkRPN6V60lxpVIY5aE5ZRefT6na0VNHMab6XjxVKyNPMSK4srrhMKHo339rayX4bjt/HD7KtthrRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 10 Jun
 2026 17:12:42 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 17:12:42 +0000
Message-ID: <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com>
Date: Wed, 10 Jun 2026 22:42:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd-sfh-hid: tablet mode switch and asus quirk
To: Helge Bahmann <hcb@chaoticmind.net>, Jiri Kosina <jikos@kernel.org>,
 linux-input@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, bentiss@kernel.org
References: <6879487.lOV4Wx5bFT@lothlorien>
 <n0s5q66s-p747-612p-o743-pqr0q2r79448@xreary.bet>
 <2632507.ElGaqSPkdT@lothlorien>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <2632507.ElGaqSPkdT@lothlorien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0085.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d90a0c7-3ae3-4cd5-cb95-08dec7137b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|3023799007|4143699003|11063799006|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FkH+TT9SHnjTKI+5/R4ZFW2pHAvcm32HM0av9fMTn2d3NiABRUlZ6ArPILCC7Xukmu/whrH36XKp0wnzwr5o60rCXQqBK+l0jziAYjueH+Yw4SYDMA/ksXAvPybj2YYpYVK9Zx/dcrVvUSnC3dJPAN/4PAiWhYMfrq//i6e6tDcAKiCzLcgV5HLgljeVjWBzse6rQKXal1JxG7GxQPLXMuw100uZTiBFhujoB4dVNemgh5vx6URgyOM2EWsHqS7ImdWTiZUtsrQpt4Xyv1F2GBDl6tzaIqPrTNrkO9LxDANKkQ57st1/+eFBTXw2P+Q3owbSLkMYVPoiuOtzGKEUrJH1Mk6g4F8z3dSE2go/uG8ZVnhp8WKOiywveDwDrQBNsnaJA4hxFFzMEDY8FQKdedguE8gAtNnrRtuw0taGbXpmh5n2cZmdON2BiqgYx3WgbvXR3AtgW3M2DChKDxBQIT/XRmePybj+uSlgM3m61clY+IkmfW4FC8DTd5TwqeT2rfqKhxYibrKKiQwij/09zMDn0laa3wrR3vB3BfERKZQZADzWNIYpieSbb3YoumrXEcYVRMTu1Cg6gM2NK4C9AYCXz1KDDwAfDAXx9VHJ+Qf75x7ERz/INbqEM12s73TIBsXU4NSKdLv3sia3v5BLUFx6dua6+JAjc3hJ1pEamhLL7U8/xE7W+etUy5t9OYbd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(3023799007)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkp6M3pNUytmLy95NU5PMUNhSTF4eHUxb1Q2QjJIc3RtelhhYWFISm5KSVZp?=
 =?utf-8?B?MURKOG5UYS9acDdpbm9zcFRXeGVtK3Iwa21hQm10V0hpQ1ZsMGh5Y2tsZkMx?=
 =?utf-8?B?WVFWRXBiQXBSaERkVjZseFZzdFpUM3dNdTRBM0JpS0dDaTVNWFJwOTZiNDFV?=
 =?utf-8?B?MVJSTm9zRFp0YzdhZHcvS09sd2tmN2Q5c1ovdm1mdEhQRGNsai9kaVhDWVlq?=
 =?utf-8?B?aDYveXp5UTIzNURCTkozN3dJcjRSaW92RkdSVzBxL0ozQzZXb0lXazN3c1ha?=
 =?utf-8?B?aTRVN2VSdkN1YmZnajRMc3FSNUJzL0JENFp3REZ6VXFXdk1ONy8zck1nRGsz?=
 =?utf-8?B?ZWJUTkx2U04xbjBVd2MvelE1TlVvUlJ2MkhJQWs1a1d2S2NvRkdzTG1HclRI?=
 =?utf-8?B?eGQ2eURpQmtFRXlYckZqTXpDQysyc0hsUWJkK3VhUjJaZDRxVWJCL3BIQ2Zz?=
 =?utf-8?B?alhOU2RReFVUTUI2YjVnMnhjSExkK1VvSWxoUERvYk0xWnNHbWxCcDFJcnpM?=
 =?utf-8?B?Y3N1V0ZUN0Y4V3BHTWQ0eXplZEVVZXY3b2JpSkExR3hRUDFtTTVNaXFqc1NY?=
 =?utf-8?B?c3Yyb3A3TzdoRW43a3ZjRzZCK09NUXBqQUo0WjRWdEJtd29wTWszVy94bXpM?=
 =?utf-8?B?VE42Qmx6dlNvSTJPUzkwNWpSVnJJeDloL0ZCTWlON21jQTdxcE0zZmJSM1FH?=
 =?utf-8?B?TXNMWmZoZWphcWVnOURNRzc1KytoaFM4UXQ4VXZCVzVsenFKV3NzUitLUUJk?=
 =?utf-8?B?T0VJazMyeDRpMmtsUmhGY3FheUYxWVpvNGNKOExqL3lJdll0SHBPQ1JKUkFm?=
 =?utf-8?B?N1Q4QjRKV2RQcEpwVzJtTmFFbEZydlREMCtMY3pmeCtxWWh5eXF0VktZM3Vv?=
 =?utf-8?B?K0ZjOEs0a205Y1Y3S1BVVDROcG1SbG42Q3p2b2dVdjhnQjE0S3g3Zmo2eDZW?=
 =?utf-8?B?SGRZOEVJbThkcUJseHNKTE5HSnVTMkxqVUs1dXkvMFB0OFM4ZThJT1BHSXVu?=
 =?utf-8?B?N0VXRW9qVzBISWF1bjg4WGFodkgvdFVqQmQxTlc2Y1N6YVEvK3hmQk5tcDZM?=
 =?utf-8?B?Y2NHNUpKUmlFSVlYdXk2L3IrSDd1VHFjQ2N4VHB2SnBFK2s0bUhJWTNQb3lD?=
 =?utf-8?B?ZTVvNFRnT0xkYitzelcvYkwycWJJNktpZCtEQXhYYnAvWFNJU1pJdER4Ri9I?=
 =?utf-8?B?SThINWlUV2JFMzl6aDBxRDJJVHRTd2p6NWt1VGJGdHBnUmR4eDU5Wm83ejNN?=
 =?utf-8?B?M3piMGVvQjhnWEM5cW9lUVFRL3Q1cWgrazBxcWRhdnk5RjBZSlVDdHUwbkZV?=
 =?utf-8?B?VXZNMmMvS0taemQyNjM4SUo4cXhhd0ZpZzVGR1YrOGFSa3l4ZU12TEllS2tQ?=
 =?utf-8?B?MWJhVUhpWHl0UlhaN0tqbDYzOUhhMnRiaUJiRFpIditDdWV6M1FWcTNXMTdu?=
 =?utf-8?B?OEcydGpXeFNCRnNlMmpTZWNOM2tDdGJMS1pFZUdocTZaTitaV25GUjhqTGw0?=
 =?utf-8?B?WmlHd1pPUGVWcFFKS3NlVmgyV3VXQkZMUHg5Tjc2VFJ6ZmR0a0JXS0pVSFRx?=
 =?utf-8?B?Z0VhREU1bWQyTU1HTWJNYWtFa3NYRWo4S1JDNWJXdThsa0RzUlZBRlNUYlVB?=
 =?utf-8?B?WlRiUVk1WWNBK1JTb1FCUlRsOXQxcWdaSmp6djZLYSt3SGpLTFMrcHlpZXZS?=
 =?utf-8?B?WG1XMFBYL284KzMrd3BBallFcDdsd0hkc25uaTlxY1h1ZnhsUnhuSXR5NXd4?=
 =?utf-8?B?cUE4L2RwVjVoRWlqM0tkcEhLL29rVUwxeFdRK2VxU3BVSEdQdlJ5cDZPdkJu?=
 =?utf-8?B?U0ZCQ28yN0xzbzBxcGRkckQ3YmY5RFhDUGM5T1QrbktnbG1WZndydjl4N1VG?=
 =?utf-8?B?M2pjWi81NXIwNW1ialZBMEpsSXJQVEI1enZQSFQ5T0lWMjB1UW92QllLSWwv?=
 =?utf-8?B?aFZWc1pHTjlUajdiTHZpeXl6Q1lqV0d1UXRDdXhwdVBLWVlwR3dqbjEvcmhB?=
 =?utf-8?B?Rm9IeENiM2VqeWV4UWJXZ0o2TUx1Y2tIK1puSi9EZkFoRzlpTHpQL1MwUE9V?=
 =?utf-8?B?RzdIc3pzcjVxSzlLblEwK2tHbFpRcjZnclpiVFRMekFyaW0yWkZWYjdSeEFD?=
 =?utf-8?B?OEkzcUNVUlM2QUVhYUFCL2VTRUtwL215SUNib2hueGEvWk13dC9vMHVvcGtp?=
 =?utf-8?B?MjJ0dklIYURUYkFHekZtYTkvNWd1aUIxNWI0ckxRREtBb2t5QXlBbTRvR2VL?=
 =?utf-8?B?aCtGVkVjblU3VDQvc0VHNDA2TER2T1hnMzVqb1dkRzJwTGh2dERhVDFNWExz?=
 =?utf-8?B?MVVBNnZVUVNscTNzekxFS25aRERMOFg0dzFONXZwQ2hWdW5rWFJEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d90a0c7-3ae3-4cd5-cb95-08dec7137b94
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:12:42.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Od6NTrdYo1SnDP26PUt1OTTNKPfNlQNOHrAjj/yVUWCSRXxrJ/DcWlCjA2tuCF0Pt5sUg398ujyxJQLZ1cosAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127


On 5/14/2026 1:29 PM, Helge Bahmann wrote:

> [You don't often get email from hcb@chaoticmind.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, 12 May 2026, Jiri Kosina wrote:
>> On Mon, 27 Apr 2026, Helge Bahmann wrote:
>>
>>> Add an input driver that interprets the "operation mode" sensor offered
>>> by the amd sfh on some laptop models.
>>>
>>> Add a quirk to make the driver work again with the Asus VivoBook
>>> VivoBook (turn off the "disable interrupts" flag).
>>>
>>> Expose the intr_disable flag as a module parameter in case it turns out
>>> to be needed on further laptop models.
>>>
>>> Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
>> Basavaraj, can you please review this one?
> Some additional context, maybe helpful for review:
>
> 1. The numbers and behavior were extracted from the ACPI tables
> (WMI driver of sorts) of the notebook; I don't have access to any
> official AMD / ASUS docs or similar.
>
> 2. I have an alternate version of this change that is more indirect:
> - create a HID driver providing an "abstract table mode" message
> - have an input driver attaching to this newly defined HID driver
>
> While that is keeping "more in line" with the current driver
> architecture, I am not sure this indirection really helps. Particularly,
> there is no "canonical" HID tablet mode switch message defined,
> so it all remains completely bespoke. I am happy to change it if
> you prefer, but would need your input.
>
> 3. Since this is based on Asus VivoBook and its ACPI tables,
> there is a possibility that this "op sensor / tablet mode" behavior
> is not as universal as I surmise. A point could be made to make this
> entire behavior model-dependent (with a mod param to override
> / activate for other models). Happy to take input / advice.

Thanks Helge.

I'd like to go with the dedicated input-driver approach (your option with
a standalone input driver) rather than the HID-message indirection -- it
keeps clean subsystem boundaries.

For splitting the work, either of these works for me -- whichever you
prefer:
   Option 1: I create the new input driver
   drivers/input/misc/amd_sfh_tabletmode.c and once done we will review your ASUS VivoBook
   quirk + intr_disable module-param patches on top of it.
   
   Option 2: If you'd rather keep ownership of it, you write
   drivers/input/misc/amd_sfh_tabletmode.c consuming the mode exposed by
   amd-sfh, and I'll review and help.
   

Let me know which option you'd like and I'll proceed.

Thanks,
--
Basavaraj

