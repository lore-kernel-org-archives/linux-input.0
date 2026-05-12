Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16364385D63
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605774; cv=fail; b=dBE8W16wkRlRrQTxey/C1WnWw3k0J2LmiRy2xCJekIgFvXAG3UUYZIsx4ErvgkSig1iwHkVFEd6podBynTdU2wGn4o70yMCPnflUVAlCVft/7GlHzxQKNr99H0WQhLQw6VdFi5XxGczNptEeE4hfRYriot96o7O/F2S8Yt8g0MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605774; c=relaxed/simple;
	bh=ZygI3WIqXrDFlAy/nZci/gXSNtq6yCIjmE97RWNrcbw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XuVI8oALCc3xyPLApAkedUqgPcuI8DCj4DAHgbVVJA+zBlQmVO70DD0kaDT2GEX/0yhDMW7eb4kpnVyIDskEKf0MGyxrx5fFCXCZOqgBkWKEm9MkLQ+WO4wpnY98SFWpn895HGrCQEjmy/NCwIYleoO8jNyxrWdv11QbGOTUGXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YxfL/eGO; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YxfL/eGO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaYpnTNxv+GGjYyv9ZzBrPNSSrQFINGWh8/M6nwI/AJsyPFd4kM13KD+yNuwimAkd0nldF3kwBQgrjUkfqGjkjN+YrdWvn+ENgc/1+rIjEvDrt6WU2xh73N1lLd5xhSmSnWXMamgpS5p7Rrwa/rn1tKCNuG1gXZE23SkMaZ846WfjrJAQLSARN0Mcu3qv4ozBboKCeU1Hmm5ZM6UCkaz5M3QVTLQfATc5EEBXu4Mtu6TO+VdKxItSbGmZTN/eIAmgHpXB9Eg9lI3IW7zNAqXYuSdMoQsQgY/uYwWe6rFgJ1YSMlY37pvefUKNTEXsMM2/29hxt4dbcrr3N6yTARvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZygI3WIqXrDFlAy/nZci/gXSNtq6yCIjmE97RWNrcbw=;
 b=TGCunQBlLYrEEemSsYZ5gjWjn+cMq5e0iXdNEGOw0Jh4hKAaacUv2sN0kNwxv76nuT4NaLbQiJk/OqLRR7hOABTzyEna/DAq0yCJaS5f80tw8EOI28oMm5ZExHdQPtIMsEGUvDlUErFZ4eEVM9eZBRxNgY9CZwo9o+WysX6XfaizCU/0HCW/3xT02hobLpZhlSjYi4kEFNH7bqRLKbs6EQXvukugprlYku+28c/52BlOM1N8QCBHpKZKf01TNR35VOQ2fOYYuhsUvBVWzft48a9n2esfiPzjJoEeoM2AwyQ9jD4B9nUGB9KcKb2slvIagkFkhtfosge346L4hzDjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZygI3WIqXrDFlAy/nZci/gXSNtq6yCIjmE97RWNrcbw=;
 b=YxfL/eGO2rC/bjREgzfAsOAu/g4UY7TynoZ4KDo+u4r1PTAe1VySMAng34QTgAeoWQLRaw/dNXFV6D6fjuTsSS6qizSd4oKvES6yF/DEECgAjKzbKPBnzbFZGJ0mr2jo3mRjAD3IK9P5AIkYfNXjsnxi23VPlvt5mPPT4DR4+XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 17:09:28 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 17:09:28 +0000
Message-ID: <8a07b89d-564a-435e-9d71-1d7f884d1cf4@amd.com>
Date: Tue, 12 May 2026 22:39:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd-sfh-hid: tablet mode switch and asus quirk
To: Jiri Kosina <jikos@kernel.org>, Helge Bahmann <hcb@chaoticmind.net>
Cc: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>,
 Sandeep Singh <Sandeep.singh@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, bentiss@kernel.org,
 linux-hid@vger.kernel.org, linux-input@vger.kernel.org
References: <6879487.lOV4Wx5bFT@lothlorien>
 <n0s5q66s-p747-612p-o743-pqr0q2r79448@xreary.bet>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <n0s5q66s-p747-612p-o743-pqr0q2r79448@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::27) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a1ddfe-29da-47a6-5a63-08deb0493979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	UxUQtj5rd69VSyL05giK6X4IN4hi293y7q5qRe0IggBZ55dhIeAf/0Pd9ToFO13R0J2ldFRR3e+nE0BcxjdAz4kSwjEj2QRCSJXm4PmuIi1Jb4bQmzCPXT+S4dPFol5NqimviGQGLVlNgiybzLO9yqwqg3YpR/ZhZtm3oXwVSOo9IeSlnL5hPSe9adbA8ZrifYLpxYTK/NPkfs2FKNRR/QjaH5OnYf5C+eQT+7esWANdxGfDJJMdUuZvG6GPBTxw6ik4oFNdjAiJSPt0CNtebQRaVd5Gaytag1W7bAHmBohrFS1ZsoHWgWG9awWG/xaZf9DCPS+vBLxUsslCq8LJFMzWGFJQDX83GEcT5UtL5nA1mPyXEmdINwpTOg7dcywTvua94lYWHjgUhLrMF1VJHPFokn1gy6h3cNBLig+sFD1ic6fJJUuK//7bUXy2YQXatvgUYWjRvXIQFnyEICLwh9Qc+Q/9rIQi9Bke3W6/W8n9e8zG2o0zW7Vac0tkwhyd9at9VzbagToGY3ic6l/rcbl4RXoolAr7LT+KBwWEtarNdNHd/DCV6MKHVCDbB59LIHuur2pgn5WCwOr7PRKxkw2zQtCGcaVlZSMfVHbHf2AYl1kUeGvdvuureM6VwQaHAAeTWu4JLooRKRiroseoq5dNU8lEsJ9M5bpF+epVLAwo02vQcTsYo8VrZEar1IjQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkVGa21HTWdHdWV0YXNxMGg5WC9JSEZyK3Y1SzN4bndlb2FEOUc5Nmd4VTBr?=
 =?utf-8?B?eDhWTGw4djg5V0hOSzhUdm5MNkNEeTJ1UFdkcy92TVUvaW9DeXlsVlZqRjU0?=
 =?utf-8?B?aWN3R254aHc4SlZsV0dKUFFkUUhTUzMzNTJxamI3QVJTQ3JPV1pzVTEzV2R4?=
 =?utf-8?B?UFpxOHlaUG1ZaUtMYnV1aklMWExjVGlidnNySVVPcldhNnJWc1ZIRmVsY0pF?=
 =?utf-8?B?My81bGZib1U3NGIwMnNDeW9vZnkza1Q1UGUyMlNhR1YwaFl4S2dPMWRVTFFT?=
 =?utf-8?B?S21rQSswM0xLSWw4VzVSZkV0VjBMM0w3djJieUNORThQR2NsTWl0b1F1b0Zj?=
 =?utf-8?B?ZFozRVNDeG5QRzRTRm55UTdsTittcUdCcFAxUDFGWG9lTUhSSFNGWjdFcWcv?=
 =?utf-8?B?ZWtMUFFLT0hEdFhWWkNTLzhrSE1mWlhRZzVtc3Z5SmRaMUV6UnltTlRuOW9T?=
 =?utf-8?B?SFRtZitLSm5CTU12RWJ6MU1TVmtpcEUrd2RjbU9iZ3N6dFNtRmFZeUtINGNM?=
 =?utf-8?B?aFNLTjhIZWtZdlNnQXdNdkRsUXM5eDQ0S1NCK0xTUUtReHBzaXBLbXV6S0hR?=
 =?utf-8?B?TXFDQTFlWTJLaVlvUTRyVXI5eHZRUzg4Z3VQRDgrQllzekpCeVdJMC9pOEZI?=
 =?utf-8?B?OHA3UkpHU0s1ZDRjOERIbU83a1RTMDdkYW5Gb0pXMldNblArSlNOOU0xWVZ2?=
 =?utf-8?B?TmdLYkdYWDVJdFZBdnd1MExMWDI4MDQxREpTSkd1c0VTR0s3azNQS1lmdmd0?=
 =?utf-8?B?V2VQeGprdW5zZmIxVDlnQk5lbVJqZWw1bzZraEJiN2FPSVpaZkZOOFVoQm1q?=
 =?utf-8?B?ZGRBdjlZUFhZUzhqbjJyZy9zSGhDYVNuZW9Ud3N6VXc0ZHFvTWxZcGVRalZR?=
 =?utf-8?B?T3BHb3IrTytWVWVtb3JtSUJldDdHdFlkZmkrVzQwdEw4WTVQMG15eXNSWmRI?=
 =?utf-8?B?NkpKQ1h0QUVrZ3NTdFUzWVlqTndadDlNMXNBMzZWMEdkWFhRZ0hoYzJTQkxi?=
 =?utf-8?B?bndaL3pLS0lobDlJdG56VTQ5alRtR1ZhYXZTYU85dUkxY29mSnNwQ0RoMnIr?=
 =?utf-8?B?UHZReXpTb1k1WGM3YXI0Z01ZK2YzSGs0WTFMQ1pMR3FhT2RYTG9EVUZzOVlz?=
 =?utf-8?B?UmF5bW5Iem1xUloxNjA1eUd3OTFlRDcxZGJGYlVsU2RyM3ZIMlZFS3pmV2tO?=
 =?utf-8?B?WUYyVVBVKzJHYmNWeDY0VUx3T3RDUS9sQVpVNkZRS2RXNnp2a1BJQVJzN2dh?=
 =?utf-8?B?ZU8xeGxGbjQ5QzdlbXZMMmczLzAxckJCRXR6UmJIbmR4bERTWHVSdk1MbXdu?=
 =?utf-8?B?NWFMdVpCZDFlYjFHV3JvL2trM1ZkYUlYajc2OE11SUQ2TTZRaGgrYnVWbUgr?=
 =?utf-8?B?eUNDb1VmZ0dJazVPa09YbEJrU3NkTGRJT0x6L1lJbzFyaGxkWHR6aE9tazBp?=
 =?utf-8?B?bkJmNWN2MjN6TjV1eFVMWXFxVVdRT05oNk5XMFhvSmNKdm9aUVlNNVplNEJC?=
 =?utf-8?B?endQSXlLMXA3NEZseVM2Snp1Y3JQYTlPOTU3cFlLTWpmL0c0TjF4QXNNTHFI?=
 =?utf-8?B?TkFOTjE3K0Uya3VEV3d4Ry80WFA1V29JdjIwM05sRWRuMWxCMVIxRTVoMEl0?=
 =?utf-8?B?ZTFkT2hRblgvNWpmRlcyZVgrL1Y1MVJBS3hWeE82VFZQeSs3b2Z3bDNQYm9J?=
 =?utf-8?B?OEtBQUw4TlU3Wk16dXZvenBGSEZ4WURySnZyKzlDUUJSY292bm5BemprdGpi?=
 =?utf-8?B?NGQ3d3dhY0J1cVB6alRTL2JxMGdvdGdPVlpEOHlGVWQ0RFdjZEdUL3FxU252?=
 =?utf-8?B?YUFpNHA2OXoxdUkvcktDV1Z1NjVoTHdtSlIyOEUxdmIwVzFpWUkwVEJaQkpG?=
 =?utf-8?B?L1RBYkhubjd0czlQcmo2U01obkdraUF3SnpYbUxpSVpHY2F4VlJxMDh6M0xq?=
 =?utf-8?B?SThFZ242eEpFNmFMVU5IMW1MMTF6Q2t0a25ETnQxdTkxeHZxVCtyRkJ2Nlhm?=
 =?utf-8?B?SXVmamMzbkgzYXFnTWgwa1dnd0tTR01nYUgzcUlpRnplMjZsRitpM3A2R1Mz?=
 =?utf-8?B?aHNsVzFtSTdDeklJblBKTTBsc3kreDVSWHdlbFhlRHREb1ltUENpa1VuUldU?=
 =?utf-8?B?WFhFakJ6K0pXL0NzaldrSHFMYjNMNzNzTGU4dEtvSGZnQ21jMkxsWjBmODU5?=
 =?utf-8?B?VmxRMXliM3cxdUF6OUtPSHVpQTBtSW4vZlZxWG1JKzVxUUliWUdLK1VWZ2Js?=
 =?utf-8?B?ZTRhZVovUkRTN0YwbmFNU1FrYXBqRDFIajRLdEswUkJZdlhPT0xQSjFZSnNj?=
 =?utf-8?Q?jwcVXUPTDjMARvvxOZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a1ddfe-29da-47a6-5a63-08deb0493979
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:09:28.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQ8UR1BDbN+fT61WH/kZBXQtiBES9WIkR2wHX7FZq/vgCN6/rzCh72XIRzF4nMDX68EpCegKiUKbs8ma5S1AbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147


On 5/12/2026 9:36 PM, Jiri Kosina wrote:
> On Mon, 27 Apr 2026, Helge Bahmann wrote:
>
>> Add an input driver that interprets the "operation mode" sensor offered
>> by the amd sfh on some laptop models.
>>
>> Add a quirk to make the driver work again with the Asus VivoBook
>> VivoBook (turn off the "disable interrupts" flag).
>>
>> Expose the intr_disable flag as a module parameter in case it turns out
>> to be needed on further laptop models.
>>
>> Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
> Basavaraj, can you please review this one?

Hi Jiri,

Sure, will review. The patch has some changes that deviate from how
other sensors are exposed in this driver, so it will take some time to
review properly. I'll respond with detailed feedback once done.

Thanks,
--
Basavaraj


