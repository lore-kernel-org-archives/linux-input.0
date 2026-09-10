Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2053CA6F
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060896; cv=fail; b=YHDsklpt0wPicIxSxgjluuY/P70/ji970KVBsHMDbDovs/bdMzLJR2sutxMFJ/lHpWkJObcHIskKa7nsMe9jgwECGqZswx3/gDDT4mPsautDj5MzQX/riqa8IANUG3MGAfwlQFeGyfj6q6Aj+5fcKVv+tFkr6XZ1qgBK3bJ8oFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060896; c=relaxed/simple;
	bh=7J6MuMKcCt1oUie3YhofsLa1LG8mPc6pf4yvzK+W/kk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rkN2jWPCKyd8XUnmtJ1D6XN99b8ejB9BiTS2gTXWJf9/Pu45mJl2ZKyBRIVxmwoxASxafY2T9TLEtRJqmzPH6c0TfZ4S/EV6gOaJIPa2On7QgB9VRlM9I+VMZFSb0Apd1fk8WbhQ+xRuL0sEjKpSaytRfu4TOtdkaxvt30dWZFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IgX/m+0U; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgX/m+0U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7nNGF7Rd0ncb1D490Fo2at0xx8RxL1Ohwbrk8slgmFLVJg9nscLQbbWBnWCAaqpshwKBRZ7rhUKVo0ZckAG4QH1biaai+uSAKt2VzS8Bc1vvrOd0KhdQg9Ws37F+mcDSaBYqCeyo6mC+uyNAAxmN6WrruX+QO493cvmhOLS3lycQ0mRuu5ZBuQlLG9r1X8rxNzX9SyGjOrsvKfmwEEQyDrKkZOKTDQE/Ghgkel127NdzRntgdT2rNprGnoglis/a/lMzJWl/Ggy5HGPw8FQfaaV9YTCrV/s2gUIgO93MJVFOSBaywbT7q3hmhPvCTnO8J8nfuo2dJ873/FkY5q5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wXljZRSS6UG+XYQDQo4aS1LOUzrv/z3QKQl8dzXjdw=;
 b=bZUbyxCmrClH3szkj60ceOLRHWDiK1j+NI48rF0c0N7N1QbRq7mlx2vffDEXZNPYD3wATX+h5OYXiFqgzaRwKVsIBYc0TSxtjNoiRq/F/JneY3wC40zzreTHEvuEqErjdMwRaSzzXkHVS2hQB1YbeeOYqptM+vUvR2sF7qsBxDyilTUPMfp1Anj3iLHwQ2KduG1TX6hVmK5pEHtmFTZzCOSOS/MXh8ody8cfvILnHr5G5CdhJxwmksLpyuago1LnDriJCHimcJ3uh5+w4Pd3zCZsRitKE8wAF3G+0fWPfavC4dt158uA8lMnU98sizFR2OdOwuzKiI/1PRvBlFdd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wXljZRSS6UG+XYQDQo4aS1LOUzrv/z3QKQl8dzXjdw=;
 b=IgX/m+0UJ3d8NYs6pe+QohnsfLcr70TPsS9axIoWLy/CiR6/HyhDcHt+3tQNiHB8nik4YZ5zlx/iQx10g5rSk37SDShEe31EX+gf1l5tZIbsA3WDIRUqT6i0p+fZVKlig7zfqA4EqYIxwAs7gjqMoEnw7ucz+IstPh2mS6OMF80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 17:21:18 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 17:21:18 +0000
Message-ID: <0407d630-e1b1-4a20-8e05-b0d0946585ce@amd.com>
Date: Thu, 10 Sep 2026 12:21:15 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev, Curtis Vogt <curtis.vogt@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <20260910171756.57EEF1F00893@smtp.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260910171756.57EEF1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0497.namprd03.prod.outlook.com
 (2603:10b6:408:130::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 15df03e5-4ecb-4de9-fb20-08df0f5feccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|3023799007|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8YmP2/Cxn0s/syPNVTm9YVEdNTwmbzef8tGGi50JvOpcsMZW2kYUR4kFSOMZHnVLpjpQc57RduiIC13+RhOojljr65jw/l7Wwgk043zDrzi+Q5/ozbPCeItA1uPxctetPyuyHLh+iFaDIXVKBm4HkA4I3TYwoRFrU02wtv8c9owCctT14r/2RXS9BX33wRZL++CXT09XOKKVxXvms06A8pZoAuHcWw26VcdYjlEQ2XjX+nARZKCIZTcuIRB4w4xLuFCpOzTPpZo3dhsqcj36rwKKXDUHSznd1pAwYAfQTmWFmY7j9YpFUfoiMEQHwAqv0si0HnpJB9VK+wF5vPAxEPrLBjYbVwA4omtdW7HHPZD7bLNRhfCABZwc4fKMKSq7/tVzG7Sz/Kig1sBkTssm4YRZ6mOmbOzUPWhbXyazdqAAVTiCzH2u4ybZMO6/c79d2dmbbn6oPocjFtbKculAq+pT7dPZjuTiwp5OFAqy4JSGhe4TvL5rEN1zsS8B3lq0H/JBK2jsxVKgkUj1psOw+SQqHZQCcIymBYIpLjoRVnWr+U80GGKIiouzJ2HjA56dExI+knya0piqg+bCmJOKRxFdGPqrBGy7bWv+0zTJng7tGUAOhexHEhUCEt6N5dUCltymUYBohlfZmfpW+QS65CG1xwu31wpJ6fJ7PEMpfjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1FTcGgzTVdXSGJ1TXBHOXJLdEdDYjJVRG5BTWR3SVNocFBQamYraHVON2Vx?=
 =?utf-8?B?SkxmMVdxZDZpMUZvSXF5QWcxSXh4QUJGdUZmc0tscjNDUTE2YzRsenRubFNE?=
 =?utf-8?B?VTdZeFRITUp1N1l1RjFmZTBIMnBITWVsd1pRcEhmazlqTUtQMml5clpDZDBi?=
 =?utf-8?B?dVkxMnFWaDNSMHptYjI2dmV5NldhY0VQSm9WYlBlZ2RXdVZGM0l1S01iUjM2?=
 =?utf-8?B?UGc2MEE3R3pPK1JIY1IyUmxUclhtakpSaWQxb0lKNGVYdTU4eWk4NU5nS0J4?=
 =?utf-8?B?QUdUM0hWV0E4QzNMK21yUmJsR0NLQzJGQWFTamlVaU1Wa0d3STZsYkFLeXFQ?=
 =?utf-8?B?ZHc0dWhDYklpenU1VWlOMzBkWW55UlI4S0xrczhGVkE3STE4Z3F2aHNBdU5q?=
 =?utf-8?B?Y2xaVllBc28xTXY5Y1BZVUpQMWRmNWFXVmUzRk5MZ1pnOThibng4TWEvTmc4?=
 =?utf-8?B?NE5rWHI1MGtlUlhxb1RwVkZzdnEwOG5SMGdtSXcrTE9iM0FWSzRSdXR5dU5l?=
 =?utf-8?B?cHYxN0NYVHh5R2pXK3puK3Z6dVVsUjNyNjk5TU9KenM5cXpYaWhROVo1OVhk?=
 =?utf-8?B?TVVWK0dhNjdlUHNtaFdQUHhBRGNNUVZzTjlXR3U1cUlldUY1a01xcWlnbFlw?=
 =?utf-8?B?YXFYZGx0TmxjZkJ2L1E5dnNVY1FRay81QmMrK3J5ZkVPVll4a1o5MlRGeng0?=
 =?utf-8?B?a0lMbjhHT0dhVU4zaks5T1RjUURMV0pHVWdJbkxVWVFIVkdER0RJVTRobnQ0?=
 =?utf-8?B?SHJ3T0tWZzlzaHoyaFVuRFhBRldUSGlnaHIrUTBSaExTc1ZEbnRFZDJWb3ht?=
 =?utf-8?B?NzNibUwwdmV5YXNmakp2cEpWQTl0aGNxaU0rWjFBbzc5ZnkxbkYyMzk4OEFN?=
 =?utf-8?B?QnF6RUJyQVFDRENRTDJ5QTlQRS9KdHovUjZHUVNyaWM1U3JHV1YrZFhBakJl?=
 =?utf-8?B?VG5rZDZvUzl3QXI3ZVVMTEluQW5iczVIOG1OK2g2YjV1ckVrVWdNRVhJK1JT?=
 =?utf-8?B?SXpGeEwzU214QllhSHRuNHlxd0pUaWgyNnpQWmg2V1o0aFVxUzRJRjNPaUh3?=
 =?utf-8?B?ZlVCd2pscGplRmtlUXNMNFE4bjdZaUxRY2N0dGdEdEljV3B1dmZkcVM2N2ha?=
 =?utf-8?B?bGt3OWF2TjM1anJERElsRTRQaFB0NGFyanh1UEdqU0J5TTFUeVV0N0J2ZllL?=
 =?utf-8?B?ckdlTFJtRWlLUFV4NEFHSWU1UG1rQW8ydHNuTFYzNGdDbHJKRXJQU0hwRXVK?=
 =?utf-8?B?eHdTQ09pS0V4aEsvRytDOEpyTDlteGcwRU9NdDY3YUFUWUJmVzdiODNGK2sz?=
 =?utf-8?B?dmZDUVdpdklEeEdmMUcxUkhNRkhrWUkvRXU0bm1uYnBwcTBTSXhEL2JzOXFU?=
 =?utf-8?B?MkR6SlRBejJCWER1aVRhWTZDMjJWV29ORE1zdWlIbzVxamdXT0dtNkdFM2FW?=
 =?utf-8?B?aFJzck9BYnplcHpySlo1K3hEWVNKZXZrVHl0TURUTjQ3alM5dEFyVTVpcFRl?=
 =?utf-8?B?eEV6VFJLZ2tzSkFXTGZkMDhJWTBGejdvRGhBTVlqWHBFV25MVDBUSit0YUdH?=
 =?utf-8?B?ZGZ3R0d4TVE2V3lWWG1CYncwNk9YMFMwYm9hQXM0Q3lPYUtXLzZsNE0rbEhj?=
 =?utf-8?B?NThEWUpJaTBVOXJ0S3M4NE5jR1p5dzcydVcrbllsZG9LWUJPcUdJTG1LY0ti?=
 =?utf-8?B?eUpsVTB5T0xQUkllSjBqT0xMdzM4T2FKcU5jUWFhRjdWWlRDdUdDZUlDWUQw?=
 =?utf-8?B?K2l3ODRDUG5NdlZCTHJVSU5XUmVBdEVZVGVDeW1RSnR5dzlMbzBhcjlzZWVz?=
 =?utf-8?B?dTl3bitsRFdvbWNKVXpCVHI2UENERzBSbjVuNStGQWxGRSt4RGFVZVZKQmdX?=
 =?utf-8?B?YU9xaUdzcDJ4RTk3QzI3MTdlQzNRVzNOdnlOd01pTGZpeXd0anQzNDFFNEVu?=
 =?utf-8?B?Q3UzbWpwdDlnVVFKNU85bnJHUHFpUjg2SXhEY3djOTFPUHdZRWFtaCtKdzND?=
 =?utf-8?B?N0RKZFBlb0RuTEphZ0xFQXk2cDRJRFJQVlVWdTZ0Z1VSVERjZmJ6N05Qc3Bm?=
 =?utf-8?B?dGxsbTRBdFpESTdYTXViMHllQzhyT3JzelVLNXVPN3FEQjRjTjN3YS9wUFpC?=
 =?utf-8?B?TFdkNEYxRDBxK2doUDNnRHVoL1doRE1XSlJlMGpXa2RZVjFlcUt0MTRpOExv?=
 =?utf-8?B?SDMxRFZDNk16ZWN3Y2cxNFFpOUVJbEtlWlg4VXRKR3BUYzYzV0ZQa1k5S29M?=
 =?utf-8?B?RHNhaFdzc20xSy9RMm0yb3pWaU8weEZHeTZWVFBjZmdJbVpDdDB2Z053VzN2?=
 =?utf-8?B?NUNzRTJmRkFqSEpZU0ZpK04vWW84c1RyakRWR3BEVkd0c2l1S1RSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15df03e5-4ecb-4de9-fb20-08df0f5feccb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 17:21:18.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zBuFd76gBsZRDRwyflxTqmhbhItSYSPe2ivyQlH6x/LPmkqYV/qTHlxaTqcA59FIGKygJAFGBCyjUhE6ObXcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692



On 9/10/26 12:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incorrect buffer formatting and report ID targeting in `hid_hw_raw_request` fallback for an unnumbered HID report.
> --
> 
> commit 4526fbce2701e5a40089fba6ae186ded76bc0864
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Subject: HID: valve-index: Reboot headset on system power transitions
> 
> This commit introduces a new HID driver for the Valve Index headset to
> reboot it on system power transitions. It sends a specific 64-byte report
> to recover the EDID service after a DisplayPort link shutdown.
> 
> Link: https://github.com/ValveSoftware/SteamVR-for-Linux/issues/939
> 
>> diff --git a/drivers/hid/hid-valve-index.c b/drivers/hid/hid-valve-index.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/hid/hid-valve-index.c
> [ ... ]
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
> 
> [Severity: Medium]
> Is the report buffer sized correctly for an unnumbered report fallback?
> 
> The HID core and usbhid transport expect unnumbered report buffers to be
> prefixed with a dummy 0x00 byte (so payload size + 1) for control transfers.
> Allocating exactly 64 bytes and placing the payload command at index 0 might
> break control transfer formatting in usbhid_set_raw_report if the fallback
> path below is taken.
> 
> [ ... ]
>> +	/* Use the same interrupt-out then SET_REPORT fallback as hidraw. */
>> +	ret = hid_hw_output_report(hdev, report, VALVE_INDEX_REPORT_SIZE);
>> +	if (ret == -ENOSYS)
>> +		ret = hid_hw_raw_request(hdev, report[0], report,
>> +					 VALVE_INDEX_REPORT_SIZE,
>> +					 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> 
> [Severity: Medium]
> Does this properly target the unnumbered report during the fallback?
> 
> By passing report[0] (which contains 0x16) as the reportnum argument, the
> fallback control transfer will target Output Report ID 0x16 instead of the
> required unnumbered report (ID 0). If hid_hw_output_report returns -ENOSYS
> and this fallback is taken, the headset might reject the transfer, causing
> the reboot command to fail.
> 
>> +	if (ret < 0)
>> +		hid_warn(hdev, "failed to reboot headset: %d\n", ret);
> [ ... ]
> 

Curtis - can you check how the headset handles those cases?
