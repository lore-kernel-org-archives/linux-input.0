Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C603D88FF
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424810; cv=fail; b=uf2FKtYkjA4lf21s36rqB3E0suR3s9zJgcDwoNCaYVoXADFF6VAT4mupXTUpY2f2LhkjIFwo8qi2QQAEi5irhcZjyWD2aqy2s9Y6TIFVHKfuUYSrBT+ocTW2PVxN0X1tlx6hoca/7aNC4R19b35+ejTvuvV41uWCff2oNvRhRNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424810; c=relaxed/simple;
	bh=trli5cuDxv+MxPx+oGQujK74q99D/07PfSa1VzXa04Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tMZxFO9PibpI5C6vcsf/xuXDZZjsFs8x4ikLoZJfFZhEUYgchCmhcclwz2EQNxUMnOWatbGffT0GI+FO4DP2X/sPaYVnnaRcebYqO7mRGZOUhi7AiXXXhDHI4WkfW01UA1vKw8oGh8gQGX3v0y6ER4y3zCjxwkssZCpL1uggGHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g4Iz2cEM; arc=fail smtp.client-ip=52.101.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g4Iz2cEM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQk974jjdsDvlxaN1xZb68Roz2Wy4I3q+XMj6aoHW/PIdhziinbB8jL/QJndZU5yuzFXaBn+0dle2fgvHjdAHTKbdTsh2mL9UbKxWKFvhP6O9c1dBZYGyfVqVA6wiJAWyhCHIzJfdT9I1Azm4uFt0FB0jhuw8FAfSyP9GhhnDOXJh3QVeCo8ccMTky6+JCfoudjKT51sBT/w8uTxjLDGHvLEZcUNQ3N5GFQYx2YZMEXB4pKvRLHAXBrtPMnDCTITX/8nH5XVKZHJu14hS4ORNHmRUvR3aDaKxzeUpYYdwLAcERhbrCX/dQzzMLvfe/JXXyZnGyXwKbGBIMgEcfr/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OgcU3J1mtb4B26WCXJrXrrl8gWVEs1YvG/S/f2yfyg=;
 b=zOpPcimJ4lw96jLIF9vF/qZBA5JGCDacg10uG9R4h+mFO6KQcJ1mgNlHWZrWNn263HPzxXZeKKjMklkXGHFL5V9nSKmEivu9jY5xS0UeihFj95/aM7RnbuWjvhkBAK4YeWSxUDSvmTrkLMREkYZSWYMzm/K2Zuyt+k3nJXjlrcSzyUBz81YGGfCoFi0PVileyWXN2If5A/O7Mi4QR0mzLHw+mpPfx9wjl3rDmCmstDkQNsiKo0Bvqf0X+BmCYhImoFOVzOAg7i6tB99b5MW9wmUaYcjoikrGHDz3eSl+RcPm/MUoJYr9OajCWbb9M/hb0QoQkhy4Q3i0h/Qxk18fdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OgcU3J1mtb4B26WCXJrXrrl8gWVEs1YvG/S/f2yfyg=;
 b=g4Iz2cEMuxGobnh0Bh5dSNEWLVrZbavmXJBlh3LIf+yhrS5la/XEXTinLSonTiReg+WhThGBHpgI8FPjOtRDNGenz0PeI6SYORBptyM1l6adzIqQljz8CJVVa8isybMBce+9X1gH5f9GY7DCX45wgUqvTwiwrVL6FYuv9p1erMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 18:00:02 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 18:00:02 +0000
Message-ID: <6b53a537-9989-4b34-b033-402773c871be@amd.com>
Date: Fri, 13 Mar 2026 12:59:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] HID: core: Export device version via
 HID_FIRMWARE_VERSION uevent
To: Daniel Schaefer <dhs@frame.work>, linux-input@vger.kernel.org
Cc: Richard Hughes <richard@hughsie.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux@frame.work
References: <20260313175659.268094-1-dhs@frame.work>
 <20260313175659.268094-5-dhs@frame.work>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260313175659.268094-5-dhs@frame.work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::10) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da2e7bc-9477-4f4b-9136-08de812a5953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	vyGF8iq+T5p/FRPmXtu+c88KjJf692JHpnseuHqE5aQWyn20epMuPGilHIq9ujlWt9swH6Cyy7j6d5JgI5CKDnbD0hdEhUmsRHG3nBPLtFhNuV2dWnpxleX5PsVypaNQj1F6H0Wp4yVrtGE7Gc/5H9txqAbQyKRZNzuch8f2T0RlgEn26rkThlfB3N1E6tX53XRMe4XX4a1ygcSw8j7pYlmUXZaDWFKzwEXWabUmMfPl6cFukEiydDAWr3Msz+qPXPen7MtQiVaPwTfL19qVQT8RsF5WG/SIEae6lsASgHobNrwRDjgO7kn9xP6WiTNNxchLBVNYvRNMiTZtUOKCFalYL7WIKD1sT4HCPj8AOmy0iPn8dvRJ2UyVHlGENJzJ/BX9GPY5H/B0REQ55tYWAEYvMDanK+AxG/HIgCC+RRZpAxwQmTZHocjdS6GVwVycARTFf3nxLUyyHJQhT/BlOcJjFNEpz4Fs+UVIzv+0YISL2H+cn9j9w1nN7DBkr7ALhOb7hkaejuRLyGNsBQyhAdldnT0/lELYS9sX0/OCqrQ3Qmv+onOzLMJpUjB7mUoCkdps+5dNtDXyfrtDu7rGuMVoT+n+Gvecs5rSIuCi81ZIbirTkIuV/m9QqzL8X2DC8yF0rb4hygj7sxUvOGWmdupIeY0S1Ox8eMoUVYPBqMaFBtuyBbRcveUo+Cl2e2uBu5vGZWImBRZYxlG2mcSkKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWdxYmVWUEpNVDlwYWZ2eUVQMDNtcFNHeEtRRGJpL3FzMmZYcXozbkgyYnAy?=
 =?utf-8?B?ajVlMjNQdENldlpvOWUyemFPREczTTNxVGFTMUpEaGFjbkFkbiswcHV5cStM?=
 =?utf-8?B?OHp2b3BTU0NaWWF1SzZqNFFUblhpWnRidkpwZ0FJREVMYUkzRjlXV3kwTTcx?=
 =?utf-8?B?NmFsYkIzSnpFcE5xU05oZkRtNkxVMStJZTB3cGhnWHlmQWJVcmdXSWZWTG5N?=
 =?utf-8?B?cndiWWxWODNSeFh5LzhQYTBBZFQzT3ZDczFndHNvVURrdDJ0NTlpbDlGQWxj?=
 =?utf-8?B?QysxS3ZJUGNLMk0rc1g5NmlPNS9tYnRCWVlOT3hCSUo4ZmJwQis2elJ3N3lj?=
 =?utf-8?B?WitBV2dnZ0VzVU13cEUvOElJM3czaHNWQ2JHdU8rQkM0TEFkYkNyUG9VWCtH?=
 =?utf-8?B?LzBmbnVpZTBmTUdTTjRsdXJqeXFNc1NnU25Rb1haZ0VvV2hoQUV2ZGkralpF?=
 =?utf-8?B?bnVQZ3VZc0xqRVRlcWdOMDFrUkczTEUxVjIrbTZRYXZZWm9sRURDT2YzUEFH?=
 =?utf-8?B?Q0kzVUJneisrWUV5YUZxd1dLUHByYlp5dmhRd2FOS2Nyc3ZYVHJMRXg0NW1w?=
 =?utf-8?B?NkkremxxcWFyd2w4eUJkK0lFTWlLL0xrTDRNWjc5S3ljTnJ2aDJBelA2SE1L?=
 =?utf-8?B?MzF6b1ZnRFhxbXZ2WVpENUxmeFFLQjVBNFMyUGhaaVB3T0pYMlBrc2NDMTJL?=
 =?utf-8?B?Q2U0OGFtbkFsNUhXTW1udXk4YjExS3B6QlEyNHFXOGFlemlnNENDUldXbFhU?=
 =?utf-8?B?bHRXSk85cDY1Q3pSUE13L1hvdVhqbXdQQlExa1hrOFQ0V09JckoxR3lOeE9J?=
 =?utf-8?B?U0xLUmJCRElyV2JmTjA0TmZubUFtN0lYS1BCaDhhOGEvRXpJYkg4V252NnRw?=
 =?utf-8?B?YzZHbmt5M05ESjkrNlFVdWI1NnNwMkZOWWVQWlBhUmo3WkhKcU9JWXNVRFBF?=
 =?utf-8?B?ZHkrOHlTZUhJQXNEUFpGK2k2aVhoMTBxWWI4Q3VUY3ZMOTlkdTBhUFZNSWMx?=
 =?utf-8?B?alBGWUVWdElkSE1KUm9HZTFSMk5LRzFlSWRacU10MWc3Sk5XZjMxTHVVZlhn?=
 =?utf-8?B?akYwL21TeVZ4U0J2YUl5cDEvdXlmSGR6V3l4Y1JxMTRxK25oUXRiQk1xREY2?=
 =?utf-8?B?N0lJMTNGUjI0VHRpMWRHNW9kVytRcGhYckhqemo3T1lOUzhMb2lFejVnU1pH?=
 =?utf-8?B?SS8yNDFuc0FXYVJvdmcrcitVbGx6bUtCMmVvTE1teTIvTGNtQzdZK1ZadEJ1?=
 =?utf-8?B?OG1JT1pMaEpBRHJReEFnejBiQXN1dG9CWkY4WHcvUmtucTE2Vk9rUG5wKzN1?=
 =?utf-8?B?Rk1IWEJZQ2s2MmVKRzRkZDhvNEptamNoQkFvbmZjR2NhUUNDRVdOT0cySXV6?=
 =?utf-8?B?RXBFbm1WcU1JeVgvNExMZXFOL0hyT3E5dmVMZ01WMTlXUHBwMUs1S2NtdkR4?=
 =?utf-8?B?MnY1MmkrS25VcEVpNnViWFdtdFR6MTUyMW83OU1xZnc0TC9Lak55eVIrZis5?=
 =?utf-8?B?OUNGNy9Rd1FqZWlXTm1aTGptbnI3TThHUzZzcCtPRXdaYXBnWDB0ZHJ6ZGxa?=
 =?utf-8?B?T0NYd3dKR3RWRjRZNTNwNStMb0RQbGNpbzJMbmVKTER0VkFsaEFMTWV2cGhn?=
 =?utf-8?B?NjY5R2tiT0lYLzNNSHEyVGU0c0VsY2w4S3ZZaWtvRSt2UUtDajFqdXZJWVEy?=
 =?utf-8?B?UlQ4TE1DTDk4cVZZRTVwT3BMYklCY1Jqb29Ka2ErdkxjenEvT290N01IYnBm?=
 =?utf-8?B?QmlpUmt2Nyt1RWpnbXJSTitiSnhWb1ZlVmk1ZDFMU0lXSFMwTEtSeHlZdkpu?=
 =?utf-8?B?MnMraUZKMkZ3Q3N1dFhBSWhkR3BKWll2OUp3NFpnOUpCcVp0bm5aa1J0TTda?=
 =?utf-8?B?QXJ1Z0xLRHEzb2lISHZzR1BsMVVla3lMUXJ5L0EyZE1VVXJvamVNVEwrZ0dW?=
 =?utf-8?B?eUdLakxWOXptQ0NoT0VQWEZGeVZvMW1HVFU1dE93a1lUQzAxT0xIdFhmbFZz?=
 =?utf-8?B?VTV2VDFRWmFwYzQ3bnZHUXVkdldTY0Jwd1VQQ2tpYmVaZUU0U1hYK2xuZXhr?=
 =?utf-8?B?U0hSNGFxSG5pbWtWK3hjeFJZZGFuUlFBUS9aNnNDdTR1TWxjL1BmUUE4eE05?=
 =?utf-8?B?cEIyMTJvTTdObGxNcnovSy9TSmo0ZmtERzcrd1gyNmE1cU5XdlQva3lwZnpI?=
 =?utf-8?B?TEdyVklVM3pyY2xybVJqUVFxS05ZUVh6T21kZUpiZndMTHpVZ0V3cWF2d2Vl?=
 =?utf-8?B?azV1cXl4VCtYVngwcWpIUXRXWFphcUNFb1FYOVBsUW1Ia3lFZzFoS3NXWVp4?=
 =?utf-8?B?RGtLSy9aMHRHSW9EN3VDQ1J3ZUVJOE1pMTJ3RHQxdWRmR1I1ODgvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da2e7bc-9477-4f4b-9136-08de812a5953
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:00:02.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 941m0BwnFnU7I1Ttt1oAu8JUbC4zjJIfvIGPBnNraHC3lXDRWZutxu6qizMVAKZgxvrinYWbkOlPR6d3H9iKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197



On 3/13/2026 12:56 PM, Daniel Schaefer wrote:
> Expose the HID device version to userspace via the new
> HID_FIRMWARE_VERSION uevent property. This enables userspace tools
> (such as fwupd and hidapi) to retrieve device firmware version
> information, providing parity with Windows HidD_GetAttributes() API
> which returns VID, PID, and VersionNumber.
> 
> The version is exported as a 4-digit uppercase hexadecimal value
> (e.g., "0100" for version 1.0), consistent with how USB devices
> report bcdDevice.
> 
> fwupd can handle this since:
> https://github.com/fwupd/fwupd/commit/fb0d4cc98abe253003ea0e1837277fd42971e0de
> But the kernel hasn't yet exposed this.
> 
> hidapi patch is in-flight: https://github.com/libusb/hidapi/pull/777
> 
> Cc: Richard Hughes <richard@hughsie.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux@frame.work
> Signed-off-by: Daniel Schaefer <dhs@frame.work>
> ---
>   drivers/hid/hid-core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index da57cbf0af26..c2075d5b40c3 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2884,6 +2884,9 @@ static int hid_uevent(const struct device *dev, struct kobj_uevent_env *env)
>   	if (add_uevent_var(env, "HID_UNIQ=%s", hdev->uniq))
>   		return -ENOMEM;
>   
> +	if (add_uevent_var(env, "HID_FIRMWARE_VERSION=%04X", hdev->version))
> +		return -ENOMEM;
> +
>   	if (add_uevent_var(env, "MODALIAS=hid:b%04Xg%04Xv%08Xp%08X",
>   			   hdev->bus, hdev->group, hdev->vendor, hdev->product))
>   		return -ENOMEM;

Isn't this in

hid.git#for-7.1/lenovo-v2
