Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011029.outbound.protection.outlook.com [52.103.12.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D55559CBF;
	Wed,  9 Sep 2026 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969515; cv=fail; b=bHF+heJVcgS+IJdvONnq2FJUiqImJkRVQUY2oYNZBZBZYHniSn67KZ1PuvsQCstjjK4rkDbVn/fvxC73vG4nZ38rvGkN+E9p951IaCs5sOB/o01kEm+rhM8j6bdPRCIMmfT/lrcu5mokpmp9CW/MJTR76fTgYbVML7jt6LGa/tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969515; c=relaxed/simple;
	bh=hqQIlMDX08R0f/TsrECxNqE0iMj8lkY1iyVtGriqBYI=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Bd7fsRfimgh0eqfALetuncqVUdSDlEk0DkAihqNBBJpXNLvtsHUFZORqohaujA7JDRzLUdWdMXLUCL3fDz3SVi8TvK2hZbg6RWIcPJsu62+M/H715Q0RKaobOqVdRvLZqAo3mpCXYS2RNbkOENDpd7IVD+9fR45XQdA4Vuk1YCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=o/SrhZeA; arc=fail smtp.client-ip=52.103.12.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="o/SrhZeA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkVRxqh8k9OkgbKM3/BYV7MEFXEU6BeZNSIgQJNdIdL1dxMBUmRGJ6vEMuKLPa6HBVgBd3TH22R5qJHKY9VSf+MBDljsfJEh+UfQ0je/ThlXoxpRPal8FOv3Z9CWwHMoWWZ4BYRtm6MXS0T/yVleyJLf9XIJfZ+KUSbuvz85CqT1e0KwSsWgmg2quNTMnc2mM32DoQIXdY5WJSfzHr0zQerrgtrf3I4wOeHgN450O0ct3qbM5GI9IrNflEbrP8fjl0Ec9vOya6A4j+hWcFEx7A4leKDjFgCOeECv30H9V3rrA7qupYxV5HnvgI0XfoonWKiRznvMGW5VBlpjwtNN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzVj6ZxbVJlqve7uHbE/c7U5cYxauR3gIcWB89VpaZo=;
 b=JOLxSnbLPN8qeMHpF7y0OWyp+at4g9zvVClDw4MfM4pTMBdbbAiQ8qoI8MFSeMWyLte63WqLWl2UqmC58OjBya6whSAWNlYmRhgYruJ+dRo2T6mvP+nvJ03Qnjq8GTYCnBJ+75ypClwllZsoJ9G2BiMm4lEwKQs/OzBXT+fkHZPg9+VqVv2ILz1zkwEQmRa4pI4nsShGHerH/2ZQzLTEH9+VQY4QTGodXwJVvaH/6Q13hwXl60SJdkzK27xdNL+dZG3429kkME3ISTL84C9SkkkXOLuYuuMW2QKsOv2CkoqvvzoKT+iG2ziM2MkuklYCGxanARQshCn1ak0MrwrN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzVj6ZxbVJlqve7uHbE/c7U5cYxauR3gIcWB89VpaZo=;
 b=o/SrhZeALcRxUgfLCXPmRpKBfDcwl1OYIWUOrVYbPVmeJ2CdwWlMHa/Zxdurddi5Yn1eRHHH03LajzkUtzMRcT4FGCmTNAFnRA8FUamvXLb90su47gQPNmnXD4nzCMxQFMbsENL33EpKjt07Vkw407xUvusnzngU+RFLRIE9QYyxRl9Ay09vrNrtitdAH7/RyDK6AgcK7J2kwc6UqveL0zc9rj4RQRpNaetR8BoT9gomtTMXOwaBFRxoEagnNj703aBZkLeaKAefWCMkK12xj35AaHefbI3EA+CYxozW/Yr6nSOXVxaoiIygz/LemnZK8GjBKFApvBQSgnkuTde/Dg==
Received: from CY8PR14MB5980.namprd14.prod.outlook.com (2603:10b6:930:5c::17)
 by SA0PR14MB5914.namprd14.prod.outlook.com (2603:10b6:806:2c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 15:58:31 +0000
Received: from CY8PR14MB5980.namprd14.prod.outlook.com
 ([fe80::7c2a:5f3b:b2b5:e77c]) by CY8PR14MB5980.namprd14.prod.outlook.com
 ([fe80::7c2a:5f3b:b2b5:e77c%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 15:58:30 +0000
Message-ID:
 <CY8PR14MB59809F95431FC6FFB0D0A56DA0B02@CY8PR14MB5980.namprd14.prod.outlook.com>
Date: Wed, 9 Sep 2026 09:58:28 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Quinn Schive <quinnschive@hotmail.com>
Subject: [BUG] HID: logitech-hidpp: G502 LIGHTSPEED loses hi-res scroll state
 after S3 resume
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To CY8PR14MB5980.namprd14.prod.outlook.com
 (2603:10b6:930:5c::17)
X-Microsoft-Original-Message-ID:
 <d1d8c941-50ba-4cbc-98d9-e680caf859cc@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR14MB5980:EE_|SA0PR14MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: a3eda7cc-a266-4ba5-fe9b-08df0e8b3157
X-MS-Exchange-SLBlob-MailProps:
	KW6s2gPZH1dyipT8/XWlB5ovC7kO4cWuYFkIBtWARpOQGaMovzwiSAssWW68mdShEx590d5lP7H0uzToWkdYJ6No0kZT0P4+rN7vlVZcQeePvh2zyLMIEaQ2fif3lR11QBiHizyhhJ15GX6yuJ3nMQT2B84zSD/82s3ZvAtddDPBl7UVO24f/+Z1cB1ef6/Y/t7Mv8ON7+3606BTgxY0h6ej8a/kFqp03QAMEzfDgYjEvONPUtqbuj/Bwpr6w5fDJaBwQf46o9O6qYSjB8C389yCijwjOXz+G2xRQI7AQERRJA3/ZxmICZx1jr5N6X+G1u8+f6qN8r4QY2bHaB5d18QprV1QLaoMh5p8F7+NFBdWOvhNMiSEuTS+hij4YY/0mHRjHYvlxrc+C6HDNpUSOuLAwjm3kq8bSlGIU9gndBdQ/RZ9nab6HUxGRELOFwlp6aVZ8bkWqMO0achpPdp12wTTGspS2lGSON/utBNUlHjnYeKEqCoSIz4Yzhp3SE63cGEOWIvIjurDv2pSQ/JgQxTcnYZ2TT5BqvMxqJp2vDwk4QU6GtW0zvjM5qX7fim5vhmbCKaYXF6tr8HcNGeIGVpoAysUAg997S0AzvNtKn4FHpOymWEcq6ExImPGiZfuXQEOAVvNr0OYLrtwThw2AANZ4fh6FrM/bZvgYTt692bvUf1pm6pz6s+YUXqSEqwMQwmCEV1OFGAKHEW6iPe0AKHVYfwmSLRLSmOo/pJqlbg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|41001999006|8060799015|6090799003|19110799012|5072599009|25010399006|15080799012|24021099003|23021999003|51005399006|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW5PNU9PcVJPOUtQU3piQ1U5cmlyN0o1NUFBOFpLN3FSSDFodFc0anlLcFFl?=
 =?utf-8?B?cE85bkRISDhnSUdRcDlCTEZoRmlvVGozS3RYWXhtVVpQWG81ZjdCZmlBVmZZ?=
 =?utf-8?B?ZG9YV1RLWTgzMzJvRjk1WTFZcXN5eFphc2NpQ2FERDZIMDNFZGFGRnpRTFli?=
 =?utf-8?B?Ykt3c0ZQU1c0dnduWHVXb2RDMTZBTzZBQnorQzdLUlFpVXVpcnhrWVRucjdh?=
 =?utf-8?B?L3lwMTVqSDJaSUJ5aXRtbG9SZkhVUkZSUDFGK2x3eFNteU1DbGJWcFMrZjZZ?=
 =?utf-8?B?ZStZeTFGZk9nZkNqVEtuT29SK0o2YUd2UFlmZEkxbFVpMFA2cS9yMDlab3FG?=
 =?utf-8?B?amU5ZTJ1YzNRaFFrWDZsRExoZW44VWxpQVZReW8xY2dleXN3bkxZMVRYZXhZ?=
 =?utf-8?B?UDhmU2c1cjBFbHhHVDd1cU9QeGVMcVJ6NE1RM1ZYWk15REFnRFA1ZnV2TUdZ?=
 =?utf-8?B?UHZ4UnpvQnpnWXVUbFBDeGVsYmNscVBOSy9EZmFOcW5tT2h6SmJIVFNCZVZy?=
 =?utf-8?B?VVNFYjl2YUJ3WXYzc3JDVnByWlBkQ2w5Smw2WS9NQnozRjBHUEtzVGpydkV3?=
 =?utf-8?B?MlM5QWJBOTVZM3RsdW8xYkMvNkY1ai81MDJ4bFRxRmpOdm1LMCtGcmNTZ1ZY?=
 =?utf-8?B?dG1yejRwQ1pXQ21HWnRMeGZkYmtZNUJDL05xRXpidVJqcU1YSW9zVExrVEZq?=
 =?utf-8?B?ZW5hT0VsS0dhTHBRZU5STFg1Wk9JdExIYm1XZzRqNmswU1djL3BFVXcwajVX?=
 =?utf-8?B?ZUlSLzUxdDQweFdoUStUTWg1UkNWeGliekJZYUFPSGV6TmhibEhJNDladDF3?=
 =?utf-8?B?V1ZiaXl4WkRSNkswSnZzT2Fvc0g3b2JCWDVSNXBIT2p4K2lVQ2dsYTdhSFJW?=
 =?utf-8?B?Y0RWN0ttQmZlVlQ3eFpTTnllcDdTS25wdHlnV1JjTTVZYldWQ043NFFzazMx?=
 =?utf-8?B?YjZoS0s5S3c4ZGtxQkpDQ0ZUM1hjNE5Zb1A3a1F5YXhKbDBUcFpoWjZ6Z3Fz?=
 =?utf-8?B?RnBmb284NmJUTWt3ZiswZ3BFNW1CSGpTVytyeU4xSzlqZU9qdWhGbUJTWEJk?=
 =?utf-8?B?bitrUi8yZmdLVEcrWURSL3RES3pMYnJJNE95ZnVkV3RzUXJVeHMrTFRXenJr?=
 =?utf-8?B?RmppQXF3K2MzUFhERW1SZmRWeWtGaEpLZ0Z0blhhY1JUak8yRndBMElUem9F?=
 =?utf-8?B?Mld5Z0tNU1d5dXJQeEpyZVN3b1JGRWQzaFNkSUppZDAvTjFaWkppamRLMVFO?=
 =?utf-8?B?bmZwaHFJWnFyQUZ5V0hhK21pTmk0WlkwN3VueDFMZ3V2aUtLRXRVa0Z2YnB1?=
 =?utf-8?B?WEhMTlNNd2JtMDN4Mm41TThzQjEySGNXTXNqVlJaTkhkb09vOWxIM3kwTklX?=
 =?utf-8?Q?Fx6h7JMxESoMMMQ27uid2W1cGrOPPZ+g=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk9JM3N0SXJlVXhBdTJ3bzJRcmx1NFQ5Wk1qcHFpN243TmRkMDNINjl6VTg0?=
 =?utf-8?B?d0pXN0VxRzdXTDg0WFR5OHVFNm5scUhpMjFCY2ViWlRTMUFJaitJUzVLSXRE?=
 =?utf-8?B?SWFlTmtUSTVHQnZlZnp0Und3SHBOeDcyMEZuTlVNeEhYTHAvWnVUUDFrblps?=
 =?utf-8?B?WWkrMFRSSmhtZ2F6bWZwYkhBdTNYSDhFbFU3OWVKS1ZidkYzbWhZY3BWcHhy?=
 =?utf-8?B?aUptVnNDTkVLNmwxczloWVYxd0pKK0ltMEZ2MTZhemIzYlBmTFVjUklRWGl6?=
 =?utf-8?B?OE81bGYvUTNIVHNOVHY2ak5kaDd4eHlWcmREYjV6L0xEL0V3clpJd1VvTWZ4?=
 =?utf-8?B?Vm8xTDNRY25JZk5xSDNBaHZuTTZMMXc0UFBpejMzenMybFd2SXVjQWFPRlIy?=
 =?utf-8?B?cWNrYnA1aTFwV0dObit2V3dacGQ4V0dXM0RZakdNRVo5RFA5Y3lveUVNRFZ2?=
 =?utf-8?B?YVE4YTRuVDU2SGxBNGZLWDdJOERmWHVycUxkVVBsU0VqRDRUMUxJZDFtMnpS?=
 =?utf-8?B?UmRXOVpWVEt3QnNmM2o3bEJObXp0VUxaNFIrT3RrSG1QWnJYTXRpZ2R5SU1i?=
 =?utf-8?B?RjUvWW5iY25XZUYyTmJpSVhINGpORDV0dVRoL1lNUXZGUm1HblFqOFRhZm5m?=
 =?utf-8?B?RTZxcVBTUkpQQzJNcGhTM1pQSi9SSFJybnoxczRCV09YZzFJdVVUR2dpbHYy?=
 =?utf-8?B?ay9zTzdNMU9ua0d0WFhPWFlGbmFkajM5ekdONHZqeDkrdnlFWERWZTJDakNU?=
 =?utf-8?B?Z3cwUGJGRjdQMzNpbC9YaUp2Y294MXg2NUlnMzVFdkNyV1o5aWRWanhwL3JF?=
 =?utf-8?B?bS9SYlk0ZG0zc0IzaXBad0dPUVhuY090eDJ6M1ppWjhEd2I0NG12aVZoZUNV?=
 =?utf-8?B?enpUVm41QzhMVHFMdVdYeS92cGZhYWpxcU5uZEVQYjU0MTFWYTdoMzVCUTJn?=
 =?utf-8?B?UUpHV3UwZjFuTkNvbTJ0ZDdGZnVyTG9ML0JXMzk3SEoxZnNLaDhOdHl3ODJU?=
 =?utf-8?B?b0Q5RlJtNlJkdWZxRXIvUVVGNkVjM3RVRkNLTjMyOUZ0amhxMzcyYWt1MVN4?=
 =?utf-8?B?TGxMYTZOeUFsaWZoS3lWTGtsQXoxbU1sTFJNaDB6Rml5OTJxelRsekpLckhF?=
 =?utf-8?B?aVJ2dURubXlTVzNBblBXQWRMeGdDRDBtYkJUblJ6VkQrQXdmb3NWN3FZeWxL?=
 =?utf-8?B?d3dYV3doQzFCUHlpRTZwVkliOURhNU9pT21QOU1SMGJST3ExaGZOb0gvaWJ5?=
 =?utf-8?B?TkFOZnIvOFJEclk4Vk5Yb0VvcEs2YUZWYVNVcGZHcDBFYW1Cd0NmMjZVZjBY?=
 =?utf-8?B?WWQvOHQ4QVVIMGdSY0cwaEpRTW1ZUy9zMGowbStURXc0VGY3UnBSZmd2S0ZF?=
 =?utf-8?B?SWlXa3N4UTAyYTdmbFpEVjlOWVFHbVoySFJBY2V3WjVIQnNnVmJqeko3WEVw?=
 =?utf-8?B?RVZEU2JqNjdWQkZTZHRSOTR5U2tnSnl0cTdXdy96QTVkbnBGZk5KODlNZm80?=
 =?utf-8?B?Ni9nczJHWmtVczNzTHcza3NiSzk3aWtrL0o0M2thME5SU1UzM1ZBUXAybnFE?=
 =?utf-8?B?bTFSRlJFSEppQ2gyTXcrRU9JQjdlbXVucG9lL2pYcVFqL0hKckcydk91VlI2?=
 =?utf-8?B?RUtsMlNhQ21JWGFOVlRPeDVYM1hxRm5hR2I3QWFJb3FwenFsVDBnSXFZT0xX?=
 =?utf-8?B?dlRLc1RHUVhPSHJCS2ZqTURGNkFmQTVyd3VKWlFoQWppTmRhdm9sNG9md3Nr?=
 =?utf-8?B?aUdySnc5TjlZZm16WEVpbVl4ek5PUnlWZ2dRVklVdzVMeWlydG5YZnhhZWJY?=
 =?utf-8?B?UEM1Z3h2OGZPUnpvbVNsTEsrUWlKYWxDMnhWeXVKOXF4aEZ1QVVWbGIyZ0N0?=
 =?utf-8?B?WnNXakNFL2FiMndNRmZBKzZsU0NPQy9jeDVPbnR4aWpQNDBwNVF5TjJ5cDZD?=
 =?utf-8?Q?jkhsup/4cVFF2hcQjsF7TEgi8DiAVyCa?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-13b70.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eda7cc-a266-4ba5-fe9b-08df0e8b3157
X-MS-Exchange-CrossTenant-AuthSource: CY8PR14MB5980.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 15:58:30.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR14MB5914

Hello,

Before the technical details: I am not a programmer or kernel developer.

I originally noticed an intermittent scrolling problem with my Logitech 
G502 LIGHTSPEED after waking my computer from sleep. I used ChatGPT to 
help me investigate the issue, guide me through collecting diagnostics, 
and interpret the kernel/input data. It also directed me to the relevant 
Linux MAINTAINERS entries and suggested reporting the findings to the 
HID/HID++ and USB maintainers and mailing lists.

The commands and measurements below were performed on my actual system. 
I have tried to separate directly observed results from my 
interpretation of what may be happening. Please forgive any terminology 
mistakes on my part.

System / hardware:

* Distribution: Arch Linux
* Desktop environment: KDE Plasma
* Display protocol: Wayland
* Kernel: 7.2.3-arch1-3
* libinput: 1.31.3
* systemd: 261.2-1
* Suspend mode: deep (S3)
* Motherboard: ASUS ProArt X870E-CREATOR WIFI
* Motherboard revision: Rev 1.xx
* BIOS vendor: American Megatrends Inc.
* BIOS version: 2402
* BIOS release date: 2026-07-13
* CPU: AMD Ryzen 9 9950X3D2
* GPU: XFX SPEEDSTER MERC 310 Radeon RX 7900 XTX Black Edition
* RAM: 96 GB (2 x 48 GB) TEAMGROUP T-Create Expert DDR5-6400 CL32
* PSU: Seasonic PRIME TX-1600 Noctua Edition
* Case: ASUS ProArt PA602
* CPU cooling: Noctua 420 mm AIO

Relevant USB / mouse hardware:

* Mouse: Logitech G502 LIGHTSPEED Wireless Gaming Mouse
* HID++ device ID: 046d:407f
* LIGHTSPEED receiver: Logitech 046d:c539
* Receiver firmware/configuration string: RQR39.06_B0040
* Mouse HID++ version reported by kernel: HID++ 4.2
* USB controller hosting the receiver: AMD 800 Series Chipset USB 3.x 
XHCI Controller
* PCI ID: 1022:43fd
* Revision: 01
* Subsystem: ASMedia 1b21:1142
* Kernel driver: xhci-pci-prom21
* PCI address: 0000:0f:00.0

A second matching PROM21 XHCI controller is present at:

* PCI address: 0000:11:00.0
* PCI ID: 1022:43fd
* Revision: 01
* Kernel driver: xhci-pci-prom21

Loaded Logitech HID++ module:

filename:
/lib/modules/7.2.3-arch1-3/kernel/drivers/hid/hid-logitech-hidpp.ko.zst

srcversion:
7CC87403B0A8F2C3D6BE42C

vermagic:
7.2.3-arch1-3 SMP preempt mod_unload

The existing G502 quirk is present in this kernel:

LDJ_DEVICE(0x407f),
.driver_data = HIDPP_QUIRK_RESET_HI_RES_SCROLL

The issue:

After some S3 resumes, mouse wheel scrolling becomes approximately 8 
times slower.

Turning the G502 off and back on immediately restores normal scrolling.

I captured the failure before power-cycling the mouse.

During the resume that triggered the problem, both PROM21 xHCI 
controllers reported:

xhci-pci-prom21 0000:11:00.0: xHC error in resume, USBSTS 0x401, Reinit
usb usb10: root hub lost power or was reset
usb usb11: root hub lost power or was reset

xhci-pci-prom21 0000:0f:00.0: xHC error in resume, USBSTS 0x401, Reinit
usb usb8: root hub lost power or was reset
usb usb9: root hub lost power or was reset

The Logitech receiver is on usb 8-5 and was subsequently reset:

usb 8-5: reset full-speed USB device number 3 using xhci-pci-prom21

Afterwards, the receiver remained logically present:

/sys/bus/usb/devices/8-5/power/persist = 1
/sys/bus/usb/devices/8-5/power/control = on
/sys/bus/usb/devices/8-5/power/runtime_status = active
/sys/bus/usb/devices/8-5/authorized = 1
/sys/bus/usb/devices/8-5/bConfigurationValue = 1

The G502 power_supply state while connected and affected was:

POWER_SUPPLY_STATUS=Unknown
POWER_SUPPLY_ONLINE=0
POWER_SUPPLY_VOLTAGE_NOW=4148000
POWER_SUPPLY_CAPACITY=98
POWER_SUPPLY_MODEL_NAME=G502 LIGHTSPEED Wireless Gaming Mouse
POWER_SUPPLY_MANUFACTURER=Logitech

I then measured the raw evdev events while scrolling exactly one 
physical wheel detent at a time.

In the broken state, all 10 trials were identical:

1 physical detent:
REL_WHEEL_HI_RES = -15
REL_WHEEL = <none>

I also attached a kprobe to hidpp_scroll_counter_handle_scroll().

For one physical detent in the broken state:

raw=-1 multiplier=8

Given the HID++ calculation:

hi_res_value = hi_res_value * 120 / counter->wheel_multiplier

this produces:

-1 * 120 / 8 = -15

which exactly matches the evdev output and appears to explain the 
approximately 8x slow scrolling.

I then traced hi_res_scroll_enable() while intentionally power-cycling 
the G502.

Before power-cycle:

g502scroll: raw=-1 multiplier=8

During reconnection, hi_res_scroll_enable() was called multiple times:

g502enable: hi_res_scroll_enable.isra.0
g502enable: hi_res_scroll_enable.isra.0
g502enable: hi_res_scroll_enable.isra.0

Immediately afterwards scrolling returned to normal.

I repeated the single-detent evdev test in the healthy state.

In the working state, one physical detent produces a burst of -15 
high-resolution events totaling approximately -120 and consistently 
produces:

REL_WHEEL=-1

Examples:

HI_RES=[-15,-15,-15,-15,-15,-15,-15,-15]
sum=-120
REL_WHEEL=[-1]

Some trials varied slightly around the physical detent boundary, for 
example -105, -135, or -165 total high-resolution units, but 
REL_WHEEL=-1 was consistently generated in the healthy state.

By comparison, the broken state was consistently:

HI_RES=[-15]
sum=-15
REL_WHEEL=[]

The cached kernel wheel multiplier remained 8 in both the broken and 
healthy states.

My interpretation, with the caveat that I am not familiar with the HID++ 
driver internals, is:

1. Before suspend, the G502 is configured for high-resolution scrolling 
and hid-logitech-hidpp stores wheel_multiplier=8.

2. During S3 resume, the PROM21 xHCI controller fails normal resume and 
is reinitialized.

3. The LIGHTSPEED receiver gets a USB reset while USB persistence keeps 
the logical receiver/HID device present.

4. The G502 appears to lose its high-resolution wheel reporting 
configuration. In the affected state, one physical detent generates only 
one raw increment.

5. hid-logitech-hidpp retains wheel_multiplier=8 and apparently does not 
re-run the necessary high-resolution configuration on this recovery path.

6. The driver consequently converts the single raw increment to:

    1 * 120 / 8 = 15

    high-resolution units, so userspace receives approximately one 
eighth of the expected wheel movement.

7. Power-cycling the G502 causes hi_res_scroll_enable() to execute again.

8. After that, a physical detent once again produces multiple raw 
increments whose high-resolution output totals approximately 120, and 
normal scrolling immediately returns.

This appears related to:

ed80cc4667ac997b84546e6d35f0a0ae525d239c
HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL

but the existing quirk does not appear to cover this particular S3 / 
receiver USB-reset recovery path.

I have the complete kernel journal, PCI configuration output, USB 
topology, evdev captures, and ftrace/kprobe output available if they 
would be useful.

I am also happy to run additional diagnostics or test a proposed patch. 
I may need fairly explicit instructions for kernel development/testing 
steps, as I am not a programmer.

Thank you,

Quinn S.
