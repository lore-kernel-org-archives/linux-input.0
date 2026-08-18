Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A73A785C;
	Tue, 18 Aug 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068822; cv=fail; b=GNxTxobhPdS0LpVYL1rU456a9DneiIH2txII6xEK0d9dUX0w31lGxtUn12PDOHjZwktxqBZvGvEOcnQ/9WXKJ9GrBXMY9uB3DCCx31NZqs8L4BO3SSPI8MbiCRfgMoF0lCW3Oyt2VdzsFfrk3cdoaWIsTb5/oqkQ80564n6WFww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068822; c=relaxed/simple;
	bh=hUxwZmYJitQmlUYxhCFNpW1gIluZACoVk9Tmir6PU8s=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Lys5lCbdkp5oLmbK1unaVnX6w+zbfx4Gs7bsDQpQXeTeV4iwd2jG3U0AzhYOoIUGuqa9DuikEKM3qVLea/xUTpnvTDO5J3mBzhfePyX8dX8rmz3XQMwV7WMdXoI9RnX9jGRY3iax8CzEvV4i3b7mdUC2slWtOL23DH+tcNg3ay0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xgundgHA; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xgundgHA"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDssQA3169804;
	Tue, 18 Aug 2026 12:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=eype8F7MmkIfUHgDT3KPSskHYnO
	3jUXXMvQtPXmjrn4=; b=xgundgHASSnpiIZP8AxvFKsVYVvKDF3tTxYy+2JMdBb
	hLOb/NAQIn1UM0rQy18S8s7yvNVef4cdkcUSEiMhGOcA29lK7vREpySnR8fqfgqN
	UKROnccDpKAqchsNkQfq1ptXg69pk+O3SL1xMErr7SmA/D5QwAAQJEd9FLZM29cX
	ag4KKBC9tfMYZ799Qpra7CE7M1Z8qeCx+4rTujMr0XmA5QI8+VIK7Re39cEZnGAx
	ennttuUMWVHDZom4tUV8AEiV9aWIk2ZemoRgqN4bvUCLFacq8nBsOr+gzydGfvsV
	FxkbLRzwySNzieZb1zpiaLIX7+00mD5IHaf3D1fJYcw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g3a5d8yjh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:00:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqW+8Xhggf+BFm8ViaP4U0dqBn+qfb5RHM4AxsqE3R1Vy4JYbBSo2/h3jWnK9htCuYeRAtbzVQDy/RaoaGcQRcB5xvp4j+fABybznBxroGI9utnEkORNm70xy7j6f28gv9nD0A30cCK7dKLJC1f5BMB7T6VA2yCU3+offNTS92MLRR2XEmamoLTWIG8mMqkC+/DGk65mh8XOVZPR04OsI7rU0X2omAGJHgarmhzuRhvFOEvpQ+GGr2r0WX857VpY5gfS53e5PYXaI7lB0lEw17XHmwAeTZ8ZjhQu9l7HERNTqDfVmw4Putdj6z6WQqGxHloI5b5hiDUHtkPiieE6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eype8F7MmkIfUHgDT3KPSskHYnO3jUXXMvQtPXmjrn4=;
 b=wyjan+v1YEcIA9j/7fhUFYC8cILMh9/3OrI8edasaffP+4Wj7r64sWHvMbdrnbp5Prk87CAFbCK9YiOKzpXWRBvBcmiUm7GMJZFmszmMm/DaxnBZbb26IHbRBseZCkRG/dA4wVNGJRs2OzOnlN5ReoYlC8Ms2VsNVW6s+MvNFE6niPLP32Gn7rMETPJ03AuRQcj9NaBkCAI5LBGhupjsSx8qIOz2daYf3MXvxljkHN9izKysMNWzOR2uvXrp73VFopQLe1NcDGmd4xpGidCvy7/vjxIt93arQqUWZy2tI8GA1yJ5apKvcoS5P+Nei1VlVrWUXGKWTNuzrVBmfBgcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by PH8PR03MB989117.namprd03.prod.outlook.com (2603:10b6:510:3a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:00:06 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%3]) with mapi id 15.21.0315.014; Tue, 18 Aug 2026
 16:00:06 +0000
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Date: Tue, 18 Aug 2026 18:00:02 +0200
Subject: [PATCH] Input: adp5588-keys - cache GPIO state before registering
 the gpiochip
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>
X-B4-Tracking: v=1; b=H4sIAIGBhGoC/yXMQQqEMAxA0atI1hNoK0pmriKzqG3UuNDSqgji3
 a26fIv/D0gchRP8igMib5JknjL0pwA32KlnFJ8NRplakSa0PlQVEfZBZnTWDYym7Fryypb6qyC
 HIXIn+zNt/q/T2o7slvsE53kBRUTl+HYAAAA=
X-Change-ID: 20260818-adp5588-gpio-cache-23fb8d0a3190
To: Michael Hennerich <michael.hennerich@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Xiaolong Chen <xiaolong.chen@gmail.com>,
        Yuanbo Ye <yuan-bo.ye@motorola.com>, Tao Hu <taohu@motorola.com>
Cc: Dmitry Torokhov <dtor@mail.ru>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: CPBP307CA0014.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::8)
 To BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|PH8PR03MB989117:EE_
X-MS-Office365-Filtering-Correlation-Id: 727a1b98-3648-4205-1afe-08defd41c5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|3023799007|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BRXYUbZcz5AQGF186yQPEa5D9BInz34bZoXjQYPTcPYdCnRSjjTyiLcxBhP+xpNUfY4tfaYM0NVIs3DOe9Co/c1S5Ea2uc/DWbre/XQnKraUxEVy/LmdM/hlW4zXNWpU2sr+AEwSun4RXO4sboTcbl+cu21RRMgwHJWcNsEEkd0b2Du5YQrQgp+FkETgMmn+0J+/488gzyhNaLvBRtmzitJyGH15rJDufPGnbBFl1H1RMbkpzptIr5bqmuYn0kJih7s33Gx91zSqgGTyXhovc9d4i5A/B2JKJ5CaW+392mSoW/uiZLc9+tah1WVJY+AY2G+eBQ938xNn5f3tBP/M9+Gzn+z0//u4qsSgX6ytdNJSLlQOuIvbwEoP3xZ003UHifr4XFtNOtbXTOl9CvBkvEPOaBLP2pjuWCqKYfI4KA0fZNEploUsah9vXsoskAm3Dwo4r5/iqk0QGZr3W4BKjBimf+8qwN5BSItXA/4iCwOvub/s4KPOxxvQWUB32oKwwEyJ5IWyjbNjcMljoS/SviYyxf7RHb4pyH+UyduMk0G+9IGYJsnMM0gGlHl9ruv+/27BAkoC9wqJmj17Xo5M62LTC4cFZx17iVgQM5P++dtblIdfqtorzYyyqq6c095Rn4szgV5OMiRmgtViX/e7UI1HNmoA6RRZiKLr1W+BQAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzRlbm1iM002SkxCSnVZb3llckZOWmJQQVlWempoNXR0SHpUVGZxcXJYTkxM?=
 =?utf-8?B?S3JXbnJETFdCNURob1N4OHM1dTZXZEd4QzZZeWVrY3YrOU9VV256ZWcvZUNI?=
 =?utf-8?B?T1VCeHR2ZTUyUHE1bGgyaW83ayt4MkxaMEk0M1ZjUlNFVXhkZC90ajdMcEdW?=
 =?utf-8?B?OXVlY2NiL1pRMzRLODF0L1A1aUxGeHpXWkk4NnlPQ0tqMXRvcmlhL0d3TXpt?=
 =?utf-8?B?Z0lXR1hlZGhsQ0p2TXRUaExiWUN3WnRhN2FqUkszU1RqMDBtUDY5akpjUEVG?=
 =?utf-8?B?YzZPVTd2Q2JOOERDRTBRK2lCV0dWRzFlRUtCUCtSOEVnbnBIYnF2YzNSZGp2?=
 =?utf-8?B?amZZeEhzTUJBNUU5Z25FaWVNdWdXMThWWlNXMENZQWFIbHk1MmxVNUVyZlRs?=
 =?utf-8?B?ZWVDV2pRV3FUb1VGcGJNTTZkbk8xSkRXWWdLR3gvOFpBL3FhODhlSDhlbnhV?=
 =?utf-8?B?clRxTks4TEpaSWFqV09ndVJSN2hsalErb2dXR0FvY0NNbDE5QnpoYjY0ZjNL?=
 =?utf-8?B?eHhIeXpzTzg0Y2t5RS9rbzFvZmlodWc2U0FaZW1YaWg3ZUFHZitidXRsZEpq?=
 =?utf-8?B?ZkR5MUZDbzA2WEYvOWl6U3RLNHEyamdoQitSQlR6ZVNDOVNTVm5qU0NrQ21l?=
 =?utf-8?B?RmpYRmZVNWt2aXIyK2dTekcxYi90MjNpRWx4MDVpWUJZUEp3TGtNa0gxQUtC?=
 =?utf-8?B?KzRIZU9ETS92U3o2WVR1QVQxOVh3V3Z3UzlQZ2tNaWlSSFhIdXNEb0hvWmFX?=
 =?utf-8?B?cHJrdTZ5SmJlc1NyRVlRSHFUNzlzV2lKSDYxN2t3SFBvbVN3RnJidUo2eUwz?=
 =?utf-8?B?b2pjM2p0WElCclFMVFRJVU05dHVaRjNzMW5TQ1dHK216MXUzNHBPQyt1Nmhy?=
 =?utf-8?B?Zm83eFVkRlAwRzBodjdiRXdkOUI0RStKeHMybGozbWVzakJiU0REbWJOZGl5?=
 =?utf-8?B?SGYyOXlRQmczM3VXNk5xMXlYVEgvMmNnQlpCWG4velZlU3dGUnZjNGRBb1Z0?=
 =?utf-8?B?d0x1TUdtdWltT2pqWEx6RkE4aXJzQ3gxZkFVT0NkR2ZKQXlhc3FzK2VMRUR4?=
 =?utf-8?B?Rm9Ea0pjMDA1TGFDMkRFeFZOVW9ubHVEd0d1RDRVd3Z5TDJLaG91ZDB5VjNK?=
 =?utf-8?B?akFydGhzOXhXUEpyWmM1eDY4TUtaeDBCT0RXS3VteEdKa282T3BIVnJseHN6?=
 =?utf-8?B?WkttK3hvQVZteUxXV0VGSXVQdGhKTDVHTHpPL3lYdkNwM1JNdHRVVmhyRkVp?=
 =?utf-8?B?aEVySUNwOElFR0hiQnJ4Z3hSMkVJa3dDZjcrU1RpY2FCZXN3QmxNcnlMNjgr?=
 =?utf-8?B?SnVHbjlic3cvcWh6VDVrRzRXRFAzd0crNndDUStkdzVRN2tOdGxlczErbVN1?=
 =?utf-8?B?bUx6RnVZVS9vdTV2aWowcnZPMzZIWDlFam5SWEpRdG13NnJPRFRod3dzSWZy?=
 =?utf-8?B?MjI5TlJUMEVRaG5taEdZV2VWcEpYN1dIck1VTnFjQjhGN2l4cVhLbjEyMDVL?=
 =?utf-8?B?RXRybmlyV2FRR3YzUmxiaC9JdFRSUlJCdUw4bXRYQ1pLbW0waW52U2gwckdU?=
 =?utf-8?B?Wk1ka0JIcUhWeXpteWo4SUtRVVhwRlA1Z0V1VzVxNlJJUElFb0VJdXRzMk1K?=
 =?utf-8?B?QzJJWlhHZTJ4by8rL0dBTE9yaDUwajZlK0Q1MjZKSmJmNjhpK3VycHZiNFB3?=
 =?utf-8?B?SGpOc0VOK1RiNi9FcHA3aFpRZ0VtbVNqNXgzRFhjTWhzYWlJL0pVcHBNSk1C?=
 =?utf-8?B?NmpUOUtLSnRSUWRxTTlUZVhKRUFhVEkzSTUxb3Z4YlBZSGxoUHN6dm1FTENs?=
 =?utf-8?B?RitkVFFEblpFcGoyOTQ1UVRSa05JWGc0bmJsNnhlZmR1RWY0R0NyaE4ra01V?=
 =?utf-8?B?VmYvL1Q0NmN1aUhlWWo1UXRHaHhzTTgvZ0xvR3dnblp0Vk9WTlRYV1RJZE52?=
 =?utf-8?B?a1RMSmpxV0NUYUY1TkZEcFZuMVgxMTlObWdRZWNveVdaaVVUQXNtY1BtRFht?=
 =?utf-8?B?dnhuUkJIOXdyRlVHK2FFRzA0MjR5RHRBTW1JN1d5em14NnBJOTU4cllROWRh?=
 =?utf-8?B?WmVnbEtHWDlZbWVvYTR1UEFnN1FCUnE1WmF1N1hTZEozdGthRlVORHBYY3dw?=
 =?utf-8?B?SEhodDE1disxbHRUVXZoMnRTOE4xYjk0UTRhcGZYZDM2QVZ4MkNDMWNaUVpD?=
 =?utf-8?B?dmNjOTB6eGRZWktmQjR4T0UwVHRuQnJJbUoySDVTZThIMm1QWnk0cG1DYjVP?=
 =?utf-8?B?K3phaFFiMEVvckN6WFdhTWRLekVFSFcrMzQ0YUZLdG9sRlhPSGRwOUFONlN3?=
 =?utf-8?B?R09oazhKNFhZLzRTMnpORVlTRE1oTzJuOUpoVmMvYWtCd2N2UHBmYXdYdURC?=
 =?utf-8?Q?5JjqWQYgX5YrA6Vg=3D?=
X-Exchange-RoutingPolicyChecked:
	RB/KzArna78UkhWhQ0SIf4tCbJ0AezViLhOj7eQ6It5AbJwq8I/xmz9GuRhaMHEVV6NwGC2M9wTQkpZ8KF3S0JUtXmA4o+6mb8px4QfBEUZDwu5I1uoussdmg0z4IT4CqM4RcXqueGHoRQ6GD1XXgbTTI4fEbVOaNIHTC1Nmm0HA6Fi5IVLWoS0MKQXnKKPBAWzZdoMhPoV2gAN2DCQpJSKDVYplAlSNrTUjnwu1x04x/rr1YtY40n8vpjJe81uaUzNd3Lj8ArP4WG+I3lBSumjCip14ULUbbpWVo2Amt7CGwLiLUQC8OWaJOIXrVdmgfKro2zpbUQoiq52DSubWeA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727a1b98-3648-4205-1afe-08defd41c5b1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:00:06.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sasH3VhkHrAlYZb28EQR6eeCL1W1+vArin2bQmoRNeES+/hKoR++YmsGC1JVbBAnWTAt3UHiTxZVrr5QOe3SF3JfootF7Ihm6WKAOC0iE84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989117
X-Proofpoint-GUID: 476Aofo3Vo2qeWHexqz0XqJi8ML4U6g_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfXwdrkKif4HWXZ
 wS7uGK9idq3XdAWNsAc+SJNPGnWdQvE+nxCuyPVPNohOJUBnEYO3IJQUkJPw+Z0MFPnHXMwkVfZ
 ECzeNtElDJuh389CBlnYmIWvblXcKvjP0XlMvZka5ybv9w6DLanb
X-Authority-Analysis: v=2.4 cv=VpwTxe2n c=1 sm=1 tr=0 ts=6a848188 cx=c_pps
 a=2EcEh/UKxA6NVIT+L3iE4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=9iIB91CYgl6GYy9qEPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 476Aofo3Vo2qeWHexqz0XqJi8ML4U6g_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX93iUIH+cDctp
 Gd3jUy0Gm8WvPExzuBzSU5UH2qtw3VfaO962oWLXqCGbwqZckDwG35kOIiFY6Fpovdl4FTWT/jC
 QAJX+8rvRO9ab8vYwP6uYj9AUx+Df0Cy2IQQHnNNmPEw8JpHcai4H2BC6EqdFtjTnA0LZlm3+q+
 2/DjtPPB3cEzNPln+KYF5A+vFZ4i9f2oDFEHB/3U3bpnvZqbOgFyQr8v+l5e+HF7v5KvEmDArg7
 7yItHcQwwuxm/QwzwDKiO2DXktog3nhsTZ3CajF3Fd/DoDmTpFB4+TY/9Cji5Pm0zCZpVhdypRX
 tS+m/4LwUYSxbQb7GRZ0i/0e8QjWCqAqyoOATsyjwoubXfTQBigYrNuzQKXdFDaZ+PptiQ3Exn1
 2wg/xupRj74PXUb1hw4wKAAfaVq/9KBeutYIso/lOJX99OGBhbKeINEWMTbK7LGgXWx62UuE9uv
 MyUwnHgYfPCC9TMxx0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

So as not to clobber any pre-programmed GPIO state in the execution
of its gpiochip ops, the driver caches things during probe time.
However, since those ops can be called both during and immediately after
the call to devm_gpiochip_add_data(), it is imperative that things are
cached before that. That's not the case right now, so reorder the two
steps to prevent any clobbering.

In a conrete example which motivated this change, a bootloader was
preconfiguring an important GPIO output to HIGH before booting the
kernel. Linux would then inadvertently set that output to LOW while
configuring a GPIO hog on a discrete GPIO line within the same 8-bit
bank (because the cached value was 0=LOW).

Fixes: ba9f507a1bea ("Input: adp5588-keys - export unused GPIO pins")
Signed-off-by: Alvin Šipraga <alvin.sipraga@analog.com>
---
 drivers/input/keyboard/adp5588-keys.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 40371f5bd9ba..4f0ddff5baba 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -446,12 +446,6 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 
 	mutex_init(&kpad->gpio_lock);
 
-	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
-	if (error) {
-		dev_err(dev, "gpiochip_add failed: %d\n", error);
-		return error;
-	}
-
 	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
 		kpad->dat_out[i] = adp5588_read(kpad->client,
 						GPIO_DAT_OUT1 + i);
@@ -459,6 +453,12 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 		kpad->pull_dis[i] = adp5588_read(kpad->client, GPIO_PULL1 + i);
 	}
 
+	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
+	if (error) {
+		dev_err(dev, "gpiochip_add failed: %d\n", error);
+		return error;
+	}
+
 	return 0;
 }
 

---
base-commit: 44f3468a0aef1aabdad551898ab7cfa2a9d20e99
change-id: 20260818-adp5588-gpio-cache-23fb8d0a3190

Best regards,
--  
Alvin Šipraga <alvin.sipraga@analog.com>

