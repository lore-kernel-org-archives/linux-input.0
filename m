Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741712;
	b=CFaGdUGvfV2RbjmI4swkcTZYBImb4kdXZbK2A2+k/ByAPzFR4SK8VksKMiDlgU4OrO00
	 MmaUx0vAjPjpvS/1ns9GmN6y3yePoosimI2gHnGQ0PwpYyXrkZ9zuLUQnhsy4soQetUWJ
	 cJ6vgezDRMrQN05yxcS6PoKmGNloR2IBVBIFZbaC/2wfxARwW3wWQ7A3E1+QfBFq7933Q
	 gj6I8Y9E6S+cvft53ZK/gdyUYG5g21Mqm1sje4zl6HnX2mFn5nTLNEzCAm4r9/oSnFcNE
	 rEG9IpNjXitrX12bk5+QZLZLi5JjAXXhNK2iG/ynrGJ1RKT/UBrdwO3GY2h68XUNhBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741712;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pXqibVE6OTOxSRZ3zVPKuWHMF1L3BB5jwGruMRiWLjE=;
	b=qLk3n7d5cFYenEchJBWQpkyMvzWVApgZebhwQitF0EGn+DCKVyUFHUxUt6jngfwUS4Dj
	 iHk5NrKn1Dil/s5K7cYwH2IUk+k/ZRUdemOfdBwXksoRE1zqPYGHxdrHZ3RBCfhnAWG32
	 8ujBxC6FnA7snn6Vo7rDrz+l8eegbg++7ttrkgRele5Z/H06bwRHDYaWDvC2lJoCjFYxn
	 W6qV9ZtaJ1xkiyqT3Wz1GHNAHigf06txEF5ww02eoygfG2GHmpa1ZR8rfqd3xugglceWp
	 ueaaxHVoXN+Dl1CbWX5CyrPRXqUko0KyEKERhboamRqZmyptNToyaQFikgidM8rff7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CZQr5F1+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.36
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A7606A31A;
	Fri, 23 Oct 2026 07:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CZQr5F1+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHxUtPMQj4Uz6dgPwgGF1gouloz4LO6Jf3pwOO3wwfuNXzpstS42+3b+Usk0fQt6Inm+bngFYcGgI8SztoYjO8caLpYq5pQTy3XLU5Z6fwDkEhJ6rLped2vbSHaf+nkMe0JDvBlZlOHwokmaWE0Ig9Z8mP5Xu9s1pBXw3xtkCNA7zRRKwIQltreE3j+DjAOJOW54PZ7ZMOAMXY44BmxUxx5AFmpaKXvegAALr2AaCNh0tjF7QLa8nfzuUX80inHtCafAwH4Fbb+LDNqjnEZwYG9aIKHBxMxYHeVPj/nES3pAmxaZwFp65mVxwifh+guuP4UvJxqcQ9YwX+3c9zwoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXqibVE6OTOxSRZ3zVPKuWHMF1L3BB5jwGruMRiWLjE=;
 b=vETk0L7knh3+lrYfpGN5rQUFqStoekqRkIDCKBmaGC2kP+L6MZ7GMWPXH6wRhgBvsOwWRo4J55JXNCNBahgXYxGoSTcnXiBjBKWzWDYjHU2eP780NaUjs65rRfCyYAyNO4QkuvRDKtATfuYo9eK2Z3opzzMFV7emYjlyTFDaQ3hc05QIXFsR4lRKwbdOZsu37tjSW6JeLeWW6e6gJylGbmU4d4jYbWyMNhPQgOm+J07KtsdpUXmxDU7pCbltZRMq+Ide9Ihhe8ePwuBhQVfYtcpjU3l6rtFGaO+VVF9LDFhMmyk+Bc3ntj3LIatXgyKv4mMFoGuTzRLG9y23ZCRO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXqibVE6OTOxSRZ3zVPKuWHMF1L3BB5jwGruMRiWLjE=;
 b=CZQr5F1+OiVKSB+Y0E7C3seXaSf6Nh4eq1DMbIOBKcgnnohSIc5pLN9FEpihYRa35g9Uhy0L67RAKK0u+y0YWIr3rPr4gZ5UIPY1N1MU0zgNItwZZmmdfMwLGgTheNAtuW4yAsPtjRzhWI2o2s5BwcUNPs6pGaJRxmA7H9DSMnU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 07:48:28 +0000
Received: from CY5PR12MB6550.namprd12.prod.outlook.com
 ([fe80::b0a5:664e:bd0f:3f14]) by CY5PR12MB6550.namprd12.prod.outlook.com
 ([fe80::b0a5:664e:bd0f:3f14%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 07:48:28 +0000
Message-ID: <5069b5bf-4605-4eb6-8365-08c0b7cb4b9f@amd.com>
Date: Fri, 23 Oct 2026 13:18:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: amd_sfh: Add DMI quirk for ASUS VivoBook Flip 14
 TP420IA
To: oolaa@proton.me, basavaraj.natikar@amd.com, jikos@kernel.org,
 bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019-amd-sfh-tp420ia-v1-1-eb5d0b5cc89e@proton.me>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261019-amd-sfh-tp420ia-v1-1-eb5d0b5cc89e@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0308.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::6) To CY5PR12MB6550.namprd12.prod.outlook.com
 (2603:10b6:930:42::6)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6550:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7daae359-76b3-415b-fd26-08df30da0656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261022105027099003|261022075727099003|56012099006|11063799006|10067099003|261021121427099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	US5k8/LZOO+OQQbH3RkOkeDXOsxt6ceA1Ej+Juh3sCkdxxFQ+9arFeMESZwOEbyXzlP4yV8J6CvlYjZFAoOiWTribktU2UWASUZLzABmV8U3Gqkq+uxYLm65ohX2BThZ2SrPa0A8UaETnomcmYQfBKvk2G7H83AvfecxZw98wxfRyuVW6Mtw1CTpJeuK8UXTiNZU0WgLgcUNqfAxSJQnrv5y3Ve+T9sQmPZF62MzqSMmv4QFCvXa6zlEaeIiiIIqmuOjG+RFRgKHzN7MnIsMhEffiIHCyblw7w/Aye1w58TTb+u0kDN/41Gm+K/lomb/npcGH7iU6eX8EfSoHzWV4UBzHX9ecsz5/xy6LGe+b4iXYGt6+UF154yXjy5Xt3KQBluKDWRx5epbgVzvaZIeadIP2HlbnEgXuxV8XilUryzV1BRaVLUz8JVRc0rLYWB+dXsoYGdaUyjvP57PtnINKrZFFLN5xuu2NEW7R8BJTqwqqGk5FTK6QYw8c70LZEIILIsJEjvJH5Fwg/qUaUdny2oSLciPrgc5Ty3760RyKlC5vWK1lynEO2ANEWUKVxZBXrpflsU4qFMbFfyNe8cdwcu1WE2nUAFBZEOxVIeW9idL4LEUvFGm+INreYobKcU0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(10067099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxLUmNZaU9abU1LU2FuSXpWenpqckp5TG8vUEtuNzY3b3QydURYemtiOFNU?=
 =?utf-8?B?dWpoMExvL1BrTi9EWHE1OFVzYWF4Q0k1ellnWGFwVno1YXJMUEFYWFh5OVQ2?=
 =?utf-8?B?Y1BRWEZna21EUWpQL3J1ZHNzK05VVWMrSGx6eXpBWEZSOXVDLzJkUUswemJr?=
 =?utf-8?B?blRHdWxGZCtmVmJoUUV3Q2tNNTdiV2x4QktEUWFJM0ZTM3p5MUJPbitPNStm?=
 =?utf-8?B?L3lXczBONCt1NXF6ZUxzdzZBVGZMZmtKZTVIck9DNC85eUFVdmdsakU3UWJD?=
 =?utf-8?B?SitscGEwTXR4TDhISnV0RGlYZlpmUE1xQk1acnVkb0xxdldqOVc0ZHEyMUds?=
 =?utf-8?B?R3ZueFRJbkJkdmEzQTZpOENhMXdxRFgvbjFEU25ybzcrSVRhbldrRWZCMnM2?=
 =?utf-8?B?dS94NjNsR3gwOWtJZG9LbitBZ3BHN2VkSGphYmpGVEUvU2c0V0dSZk93NkRt?=
 =?utf-8?B?S1FKMTZHYjV0cStodFRXcDFydVNFNk9xNGM5N2tqK01HVnFCTlAvRFEvZG42?=
 =?utf-8?B?M1AzRHhGaUQ1VjRYbU1DM2FVaDNpMDFjaXREZDVJYmZRRGMwQU5Ha2tVMU5P?=
 =?utf-8?B?TVBvTUpLSFRrTDNGWEt3NHdoS3VFMnJpbHBmbWtYWUF6NTg1cVpraE4vZzhQ?=
 =?utf-8?B?cXNJWUQxZjFJS0RuNkZWLzRKTE0vaTQzWE84bjFGd1RKV1h3VVFpMGNzNk44?=
 =?utf-8?B?VGsvNSt0WGJWUVJlQTdOanhaYVV1ZjI1S3hrV282VVVadHZLcnNuZHp3RUkv?=
 =?utf-8?B?M2srTXdqY3VycFRwOWxUejMzN0VML2t3K0hPcUd2bHFYTzBkM0puajBHN1NE?=
 =?utf-8?B?dWY4Zmx3YUtsTU02TjFQWmlzVS82UWMrRFIxOGJxaGJlS2RBdiszeEl3RUk1?=
 =?utf-8?B?QkFXQlRrMGdETVFQay9jdzZyVVpReTN1bnIwMzdIa0Q3VWxkSEd3VGV1VDY3?=
 =?utf-8?B?REpxNkVmVGNRd20xUFNUZ2wveGJjTkoxdVpiVGs0M0NyMGJtWjd1ZjZFTlI5?=
 =?utf-8?B?RGRKSDJ0UDBtOExWMGE2MHUvK29aSWY0cGFyR3VPT2piOUZUUGtjQ3ZjQ25n?=
 =?utf-8?B?U24zdGRqenhMakFua0NKWVliTHpLNEQ0dEpDalRnRXJDVXNVdXZicURjOFVX?=
 =?utf-8?B?ZWFxRVpwUVMvdkEyVys3a3FCRW1GNG5WTkMrZURYY2lEdDRoSDdnNSsyOVQy?=
 =?utf-8?B?eHo0VXBRamlacTdxdHVLdFFuZkszUm5YY0YycUtueHRrcEFTeldVTHZQNjJv?=
 =?utf-8?B?S28xTVY0aVdrWlQ3Ymc0aWVnYldMK3RTaEV4Qk5PcGFtUVFRczlMcDVHZjlK?=
 =?utf-8?B?NmhTN243TjNsb0ZjQjR2aWNuYk8vYWFucUJZU3QwNGJ2UkdJRVJIYlduaGlB?=
 =?utf-8?B?UytkVE8xeVdMcVZpNW5ydzAveXNVY3ZkZTd3djZ5Z3NpZmZDaW5KRk9kYXVZ?=
 =?utf-8?B?NjM3T1VxeTBEdnZHdWtFYmhSWjU3K1VhcHVwNjRZOHZFSWhZWCtFOXkrcXBQ?=
 =?utf-8?B?ZzZQeXZldTViN2RrN0lialVlbnFXQmJuZ3YrREgrUlplbGNLU1F4R0t4TG1Z?=
 =?utf-8?B?UkFCeUN3SW1NQUlPOFc4TXQ5QWhRbzkzU1JQT05acDk1OVFVWXdjRXVRYTI1?=
 =?utf-8?B?c3I4dzVkeTU2UEFSZ2NIazErbkNQdGM4SVFwN01KTXhkSElyQ2w0Yk12QVYv?=
 =?utf-8?B?dEc0emJKVllVSWsybnlEWHBLN0JZT3NkUXBDRXF6SnpOVmVPMzlLYkora25i?=
 =?utf-8?B?amhnUlZGZlR1OTRjV1d5aXB6Rm82Y2NRUkIwQW5Mc2x0c3c5NVVsSE4zNWFt?=
 =?utf-8?B?R3ZXb25PQWRUNU03OXN6T0lBSXM5WjZneWZkak1yV2NrNUZYZXJSS1pBZExP?=
 =?utf-8?B?MEg3YkNFNk8yMHBFTjNaaGZpNGZoc1ZpQ3NaUFA2ZHhBWCtnK2pVc2p1WFhx?=
 =?utf-8?B?SU82QXRZTHRjS3pVV3gySlZqbXF2OGI2ZUpqMVpGQWlsTStibVlDcUdBUU1t?=
 =?utf-8?B?ck5aeEJBNmdheHh4WE1SUHJKNG9CYmJMQjBQVk42NEFOTFozRFpwR0k1Nmw3?=
 =?utf-8?B?S0doNk9qNURIRUtMK3Z5Zy9sYlltNHVYdkduNHdwc0xCem82M0ZKMkxHWmNI?=
 =?utf-8?B?cUxJd2k2aUpOZkVzb3h0dDl5enFKSlJzMERPYloydWM2a01kVlBVTFlQMUxO?=
 =?utf-8?B?ZE41aTYrUTh3ZXp6eURtWE9zdXJ4MG5HYVU3TW9sUU9Ba1NrVE9INldVZnBa?=
 =?utf-8?B?aExCWmkreXVZdHBWNitzeFBUeVpLM0QvUG1ycWNRbEVJMkx2WHZhTTIvNW9T?=
 =?utf-8?B?Q0x4VGIrN0RyUm9iUGlLTEZKTUZRTk81by9CckJjSVdSTVIvdmFxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daae359-76b3-415b-fd26-08df30da0656
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:48:28.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNEhPRj9O/9RjvL15cr2ERYYo4O/vd+fqXscfNXE1CPbxaaytKQSyTuJHBsMsNZAygfs5AqRkvM7Khj+LtzOCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341


On 10/19/2026 7:07 PM, Artem Suvorov via B4 Relay wrote:
> [You don't often get email from devnull+oolaa.proton.me@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Artem Suvorov <oolaa@proton.me>
>
> On the ASUS VivoBook Flip 14 TP420IA (Ryzen 5 4500U, BIOS TP420IA.305)
> the MP2 firmware does not answer sensor commands sent with interrupts
> disabled, so the sensor hub finds no sensors and the accelerometer is
> missing (no screen auto-rotation):
>
>    pcie_mp2_amd 0000:03:00.7: Failed to discover, sensors not enabled is 0
>
> This is the same problem as on the HP ProBook x360 435 G7 and the ASUS
> TP420UA/TM420UA, which already have a DMI quirk for it. The TP420IA
> reports the DMI product name "VivoBook_ASUSLaptop TP420IA", so the
> existing TP420UA_TM420UA entry does not match it.
>
> Add a DMI quirk for the TP420IA so that interrupts stay enabled.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222143
> Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Artem Suvorov <oolaa@proton.me>
> ---
> Tested on a TP420IA (Fedora 44, kernels 7.2.10 and 7.2.11) with the
> amd_sfh driver from v7.2.10 built out of tree with the same DMI entry:
> the sensor hub is found, accel_3d shows up as an IIO device,
> iio-sensor-proxy reports all four orientations and GNOME rotates the
> screen. Without the entry the probe fails as quoted above.
>
> This patch itself is against hid.git for-next, where the TP420UA_TM420UA
> entry was added; there amd_sfh_pcie.c builds without warnings (W=1). I
> have not booted a for-next kernel on the laptop.
>
> With the quirk the log also shows repeated
>
>    hid-sensor-hub 0020:1022:0001.0001: Event data for report 1 was too short (15 vs 14)
>
> but the accelerometer data is correct.
>
> AI disclosure: Claude (claude-opus-5-5, in Claude Code) helped me find
> the cause by comparing with bug 218104, wrote the DMI entry and drafted
> the changelog. I reviewed it and did all testing on my own laptop.
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index b3cb13b8c5e8..a88867075291 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -322,6 +322,13 @@ static const struct dmi_system_id dmi_sfh_table[] = {
>                          DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420UA_TM420UA"),
>                  },
>          },
> +       {
> +               .callback = mp2_disable_intr,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420IA"),
> +               },
> +       },
>          {}
>   };
>
The DMI quirk looks correct to me.

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

> ---
> base-commit: 92d5263296a43f3808926b11848832bddf2590aa
> change-id: 20261019-amd-sfh-tp420ia-5052f202f118
>
> Best regards,
> --
> Artem Suvorov <oolaa@proton.me>
>
>

