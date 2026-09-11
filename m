Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821394A0925;
	Fri, 11 Sep 2026 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142940; cv=fail; b=rPLdnyjwr6DA4/gTKKUQl2bmIHBpl1TEmEmp/U9m9jKUuQvR08GpfxF9GvMxpNbl2IIQiNybYZWGxxTS3ifH/GwJ/H/t2WNf18ND2L9VKUWtSwWj/MaUisG3M0jNjpk875TSU58T0BvsK6h27FmB0q9rAZgp4VNoegi9uoaqrk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142940; c=relaxed/simple;
	bh=LnMdalgarIgr7Rr+AN5TKp4QrUxLq21B0dy0HIPGnDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ch+w69QG4P+Bvgp41fEkp3AfHWt8AbYuDB2bFIALSSgBs9I35kiFmsaB4iS17/VcMu30BZdAxhSGhXcicpbMIMPSY5nzj6T+OKk/DoNDY31/G95dqmdigI+95gEUDxAVGavZFcj078k/dd+DAIUBDekQ8ELLVqaXnkn9KffCrLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LViDhI0A; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LViDhI0A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwTqwex+oM/Ibhy6riR0ylX38Kk29HeI/D+q1I95XaKzBfJR19k3WmfRusjCwk7FKaw65TXuSbTElzb4S/Duj/HnssE9fjyCPVOlul5T0bI5EMFQ2HyRIAsBdyFn2w23upFkD+SxaU7gQlt36RtXcTh2/p++9H0V0Jj25QK9uLxmINlQImLGEADE2NeeYqMBlQnVlJrJBcJE3guImC4HhP7N3YWl8435mr8IT+suJGhf2Qx61YOuMXhVWcDyS8iA4Cd7Hc9RteUeVJjdPjvzyfMtZ6hctLQtGcgfNIee3JKWoJdpg/9Pq+0/wu6j2r1btrdIPCNDiS76ntho7ivs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CrFG2VCtB3W0sy/r9346wPRozLD2dC7zxYkrWK7egA=;
 b=DAli3fSWJxHySqNppn78oOhEEtIqfVFPxXU7IB30aX6/Rj07HqUPwPQED5Cc0h+frB6sG9zBEi83EFNZU3ZeReUFKqu4bdTyBpMtCl1g4KqlrAqjN5Yo7XHTaofo2X6Sx9E1o/s9XFQw+gfM4MmBRLFBpyWN0xP4cbjn0HfVkxbBT7VJKhqYmYW5ed1emnqAFgrahRAuQBr4YlbFJLj9D21IUCYs7AdHZCgnM86/M6mSPG6HqvqCwT+7s9v0dft3sl4/vExEfBUDXQQL+VJh7VfnrOUJ5nf1ATrm9F7acHVI+sQlPtwlrXvlL3StKPQSmUP3+Qzg+4b5sdbP65YNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CrFG2VCtB3W0sy/r9346wPRozLD2dC7zxYkrWK7egA=;
 b=LViDhI0AzQKTaVeJ3K55tJkoOCRH8GDY0hSkyYbx0dVK21ps4A1biMKGHJuwq8Rl2ZzXlHBMrKW9/jQui2IJ81S/MBXazt3SJk8XsmgO8WHfXy+XuA6fXgEf3ZeerzLHKEVHFoRoRIiPXHQ1+G25ltf621B6LuuKkf+x7TpOVho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Fri, 11 Sep 2026 16:08:55 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 16:08:54 +0000
Message-ID: <6710c9be-92eb-446f-a7aa-049e0d5734f6@amd.com>
Date: Fri, 11 Sep 2026 21:38:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: amd_sfh: Validate BAR 2 as memory-mapped I/O in
 probe
To: Jiri Kosina <jikos@kernel.org>, Preetam Sundar Das <daspreetam4@gmail.com>
Cc: basavaraj.natikar@amd.com, Benjamin Tissoires <bentiss@kernel.org>,
 sandeep.singh@amd.com, Nehal-bakulchandra.Shah@amd.com,
 skhan@linuxfoundation.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+4eadd4dfe9e66522bae8@syzkaller.appspotmail.com
References: <20260815121938.1337631-1-daspreetam4@gmail.com>
 <nr9p85pr-39r8-0r18-60os-p7958qq473oo@xreary.bet>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <nr9p85pr-39r8-0r18-60os-p7958qq473oo@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0073.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::9) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: c2866941-3d81-4506-e379-08df101efa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7FsoOaloQA8gGyr+cEvW2qwcfB5D0I5zgMiFkEktO1XcB9ghfQQTBKIJmm5k1H7lIfGJ1LnwGO4vbGUdynBgiFYZsyzHqcUFsuX+JCpSdjeemD6lHZJYeFOLNtMlv40E3dy3rTmSV4WdXLKm6uX51HqVmfAfXREt+cMvhbsThdvGTOIe78yMbVt3kJTHPJMYU7GjGYfuV39c2wJm2KaoxdHUmmqhk9b4QQhurbswOHn6GrzpLxMAEy8c34agcjlBBFRhE7PnnLYBzDCsUMvYMmL9AornDAJejICVh3XJyGNSX1iG/49JzkVNsYyalZYtn6ox7XrRM6qEh46uWby8r5Otb8oH9Vp8Ncx1X0eVTpWR87j568tNNq+crZ1/Dc+buKjJIcpJ9dA50jKaXd2MkRrUK6+JwjbrEKZrbDIDc9WMglqchtb6wTMw81h46RJMuLhzriDw/FWPKXwsdzOe11TSPpXTPBeonbEHvTWeNUidayCWmC7uuUctuR85xtYljq9jsO+4dgyF2GCXYadfyg07GFOY+TiNeWirRVK1cQqWAFgV7FyLl8eTGli6vMI4cJXhQIJ09ZTsjl6/HgWLgB/9KjcaFU9sBP1ioMOy6GV7r5tjrszIfdlEGTP2l5vk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW9Iby9KZ2hqVzRqVy9jTVduTXRpOW1FOWFsUnMxeERyWUtkMXBqbGtwbGpZ?=
 =?utf-8?B?SDZkQ1R0WHUyQWFQaFB5UGFiWEpmNW96dHlmK2xmbEluK25rQm9TLzNYaENS?=
 =?utf-8?B?UTdyZkI3RDBVTEZSSTY2bW91U2hmYnJhdlFuSjFGT1hDdGlWVUltcVczM25U?=
 =?utf-8?B?T3BZeVMzTTA4UHBHcTVkWldlZHFjWnkyY2xoZG5hNlNhbUpKbHN6TzkrU2Zo?=
 =?utf-8?B?WE12K2VkVFFEd3RGZk9VYll0OVFNb0pBdkkxNFkrMURHNnVXVUozckxNaWFt?=
 =?utf-8?B?NlVzT0gyblYrS1RFY2JlOER2WnB5WkRSWFpRWHRkZjQyOHhXS09ubEU1Sm5P?=
 =?utf-8?B?YkdZZ04raFkzRCtKZnhTd00xTEVsU0NFWUowQkY2S2trMjJIV0NBMUVoNFV4?=
 =?utf-8?B?cWxTQm1OSXFjZU9hOXJLRHJUNEFhMHdNeGVHSGF4aTFNRCtGVVhNTGFsRzl1?=
 =?utf-8?B?UEpuZkNxR0lVVmtLUldLbGtFa1hxY3Z3d0ZaaWxmQWx6WEdub3IxR2FuRnRB?=
 =?utf-8?B?SU56T214eUNIeGordDZ3Wmx2Z3VZTWkvM1hNTUZwT0lzNEZmZUVNTDl3NzVw?=
 =?utf-8?B?d2V5N2E1ZUlISkxRT0UvVW9keXpkVGViTTJ1MWxDV3VyY1ZQNUdLNExzZDhI?=
 =?utf-8?B?U3NXcGJyNmtEWGJFSWhUek03V3kwa29SaDFTZ0M1dGhZZTI0cUVTbHZSTFJz?=
 =?utf-8?B?UHRGdW5FY1kwNWlydi9Nai9pZ3I2d3BHb2hESzIvbEhNNWdHRlRlU0djUm4r?=
 =?utf-8?B?S0pCRllnUHBVcUdpZnZVY1dYenIwTjJBTHQ1UFZSZTduOW1Od0o2RmMvdEZq?=
 =?utf-8?B?eGxwTEpPdjBLREdXWjJ2NERQMUd5R2JXdjJCR2EwcjVYdGdjMEZKSjNBL0Q3?=
 =?utf-8?B?ZC9ES0JlUGxhL25kWHZwN29wM0U5ckQ0TjZrK2EzSEhtcHp4ZGR5UDJkdFlN?=
 =?utf-8?B?alhYMWdMRXJ6WHBWbHlYUUpQdkVwbllwaEloeTQ3MG9SdDY1YWpCQWgzVWc5?=
 =?utf-8?B?dlJHQWczM1hVMnh0NGFLVlNpZmtSYSs2c0ZEUUo4ZWIvYnN4dkdkNVRDUmpr?=
 =?utf-8?B?SFppYjlLcEMzbCtGSmtmZFJBdUJHMTFreEk3TnFwY095aDdBc2pMNG1OYTBa?=
 =?utf-8?B?bVZkdEdWS3FCWU1BdjdCUktEZnpZRHRTTFVhR3lBMmprQjg3aHRnNkw1V082?=
 =?utf-8?B?eXNtZ3N2Q1RZUFZkRjMxTXpCeDVGWnNNcXlWUkRIRzFTeCtJK21vdlovdENR?=
 =?utf-8?B?cE1kRWxlemJZZExqbTBrbTIvUDg1WCtwUlAzcVc5SWc5d0xUOC9xQjQwdzZq?=
 =?utf-8?B?MkYzdWhHNWlheHg1RndIWkZDQXNtOSsvUE5Td0J2UmhjOS9mLzZDallaMnpj?=
 =?utf-8?B?YVBNWUlxQ0tSdTNUV2FlMlRtbTZ0aXBaYUhUdGFIMjkwY1JBT0ZrWWUyR1FO?=
 =?utf-8?B?a3ZzY1ZuMU54NjBISEVmTHNKZitBWFk0SHFLV0x1eGExUXlkUGRDZjRlU1RJ?=
 =?utf-8?B?RjljQnl3MGdjZ1FSdFVkb2t6ZTRZR2VJK3lGNnhtbklRVmlzZm9rVUZLcnpj?=
 =?utf-8?B?eVpMTzRSaWhwTEhMM09LWG5qWk9EMnVEbUdxUmVsZE1vT1hOaC9sc2k4N2h5?=
 =?utf-8?B?MFR6K0dtbENJbUJQL2xYUG1DcDYxVEdsK0g2eitqbDYrTUdHbE5RRjN6Vi8v?=
 =?utf-8?B?UEE0QStpYkN1b2xyTWQrTnVIdG1jZ0JXKzl2QXA1dzB6bWRrZkloZ0VGYVAw?=
 =?utf-8?B?TjA0c0Z5NzloZllGRGJXVENTSE1oQ2xiQ3k1bGJVd2Q5Zm5Pa0kzNmFrRGRz?=
 =?utf-8?B?VkN3ZmtyUGJNelVJWVBGOGlhMDRreTlCVjNmblZEVnpTODZ2cVRtQzVDVUFH?=
 =?utf-8?B?c2cwT0hiejBBaENTVlpIWHlSNkFvYzRyQjZidGl0WlpWOTJOOEppYVBnSjZp?=
 =?utf-8?B?cCtnekV5QVVFTzRjZGN3dnBXSXFJWXdiZXFWM1Z6M1llVEp1dCtkYVdWRzRP?=
 =?utf-8?B?dTVRQ0E4c200VlFnNng3cUVOb0IwKys0MjdxVTBOcU5rcEJ5MnRJMTRLMHJq?=
 =?utf-8?B?VHpLc05MRmhnNE5LTEtWbVVnL1hXbzllb0ZhemFDQ2JJN0FIakJuM1NVcFB3?=
 =?utf-8?B?ejBsdTZPQmFWaE5WMTBYWFQwL0pHMTZEdWMxRktKQVdYLzFkR0VRMkwwQ0hV?=
 =?utf-8?B?MGxWZkZac0dhQnRpcFBrMHdPNnF2bnhpdTRrbkdKd0xEUFh5NlArRU9xNlhh?=
 =?utf-8?B?ZXFHOVA4Ymh4NXRCSU9GQWxqUHBocjcyQnJHU2p6N0h4WTB3NmZNYmFhMElh?=
 =?utf-8?B?djIxSUZhOWcreGZ4bXR1Y3lTRzRncVdtNVFDMng4RzlhMDFyY25HZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2866941-3d81-4506-e379-08df101efa19
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:08:54.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIlg+7vMzszo4DGf+Vq0gYD3kXfOCc68MYlRnW3VQVAyMZ5V8hcLcI3v+ZC4IM8yJEbGkbHe9L29mgcn4hHRUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326

Hi Jiri,


On 9/11/2026 7:52 PM, Jiri Kosina wrote:
> On Sat, 15 Aug 2026, Preetam Sundar Das wrote:
>
>> Syzbot reported a page fault in amd_mp2_pci_probe(). The fuzzer creates
>> a malicious PCI device where BAR 2 is defined as an I/O port rather
>> than a memory-mapped I/O (MMIO) region.
>>
>> The driver previously assumed BAR 2 would always be MMIO and blindly
>> passed the I/O port address to readl(), causing a fatal page fault
>> when the CPU attempted to read from restricted memory.
>>
>> Fix this by explicitly checking the PCI resource flags after waking
>> the device. If BAR 2 is not an IORESOURCE_MEM region, safely reject
>> the device with -EINVAL to prevent the panic.
>>
>> Fixes: 4f567b9f8141 ("SFH: PCIe driver to add support of AMD sensor fusion hub")
>> Reported-by: syzbot+4eadd4dfe9e66522bae8@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=227a9acbe565367eb7a1277b47115df8706d9a12
>>
>> Signed-off-by: Preetam Sundar Das <daspreetam4@gmail.com>
> Basavaraj, can I please get your Ack/Reviewed-by on this one?

This is already covered in below patch

https://lore.kernel.org/all/7f8690bc-17c7-45e7-bacd-a341b2ef0a4b@amd.com/

Thanks,
--
Basavaraj

>
> Thanks.
>
>> ---
>>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>> index 4b81cebdc335..aef105a81570 100644
>> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>> @@ -451,6 +451,9 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>>   	if (rc)
>>   		return rc;
>>   
>> +	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM))
>> +		return -EINVAL;
>> +
>>   	rc = pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
>>   	if (rc)
>>   		return rc;
>> -- 
>> 2.43.0
>>

