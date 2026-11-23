Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795419287;
	b=h6R3Ao2sDM45hfKudV9YRKCgB51f8aEmmW3e6wGOqZSOIHa0e3VNT2RAe1DMGPZsx48p
	 hsOrSy3eb86RHDd0BZhv5JTIg9YyQ2esfUPTdI2nKjkJUfJPFyylVDAZaTF47UWvz8OQI
	 VivWYZhTDSx5wmJYPCxWGU83tpDtAjWnZt0PhqcYXrmuSTwxeJbA6CNY0tOfSsALdAzfg
	 QrYbJ8NLUpV5EvtEm+c3xORHsa4UcEKo1VaIVwWnVriUNKSRcGHBRGCpdpUcTab7F9lEb
	 F0UGXrjP2PcOI+8DEO4HjVgckJhbQ+QfJfRN5QzuZAlc8pNISLFX/VxiQ5riOQxOv2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419287;
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
	bh=T57QsN6rKUlQzjinlx/Lv/9B6wUmyTki1OLw3GS78MQ=;
	b=0lFjjSgvKSgN+H7o63CzMohMUzkW+/SIdf1UIicqD4tLw0dGDA6jHfl6zR6KBk0gN9k/
	 M9x//JyHqLS9BhrlDnoQhwqC8YVnDWfSWvs9XNgW3Vy5M4k5q0C8kRfHwWbsjZ4Lc7Q+0
	 7NZD6ew/wPYorDyl3O2C4It0yZyMG5gcMmay9Eiu/lR5tQmTgyHlsn645yxMBVBlDKLvS
	 pICjyYZO/j+JMrKlndcfbdkFMLf7Wu/mPjVKhZGG2Wu4ov7YrrbOxrWTY+HHClgHx8vfZ
	 Ml+eANwtGEP4PAcy12KtexhYeX8towwnlbm2/sa6BxpdDvSy6VUYNWb1DxnkSjmY1IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1XLB9VQX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.71
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E0606A31A;
	Mon, 23 Nov 2026 07:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD0E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1XLB9VQX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6wCn880QuBUiSuqiWYI6ykbYm7hSmP31d7bD7hZggCAKosPBRQ9dB4njy3nq8CCFPkuudL88OISn2Dc57bos67/mkfRXx0UdeHre/o90oSFyCecMLXbbSQNERh2w7v4JqnIwQuP04/Zvvp7B0ROjTSbPOTqidupGOg+fwF5MyNRnf8G+t4sENHITPD9nYn6Gh8/eb5FNmMIlxakVc+7K2GKtCEIr61Wc4NQI+gRWfH14pHsklTREt9DiY7ttRV7K0+4wbVSGsKDm4eGuNs66IHaaiBGpphpLDEIPBsE+cddbvUFoK/XLvOCuUoWqkAgTy/yFRbzsq5YjpLR5HLAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T57QsN6rKUlQzjinlx/Lv/9B6wUmyTki1OLw3GS78MQ=;
 b=lX6hyLi0UI0H2NbIpW3P1rGAZv7FzykSRjz+2xWBJscLBRQ/4dNgfXac/nDNllhvHnwL3PmJznXOM4eoqDxRyjZ8r9vFVgsCuCXJl782HOsxM6N1vZztpApQ3SQFvI/YEwahdl/LByvrXCrfQHisq5gTbhjDZZqmu7rJDjAvLHAod4/GGv2/f1y8Bjxa/6E3tyBhs0qx1JfMuP3jenyvS23nnC20YoQVxebvvVNsAC0ti1rw70AqRNFSBsLabusyJjqfWoEjhwMgb/iivezabvemiJMZ7ddheh1otndMN5mTKU2Is1mm5PbVWzazR0Nke5mmlxOkCa9YPBqQLqKSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T57QsN6rKUlQzjinlx/Lv/9B6wUmyTki1OLw3GS78MQ=;
 b=1XLB9VQXcM9vgNPMoxWC14l+DjR9dwvHmtUgb+lj0ygrWiKCtgNT7b7WT0ZIpZ5JWEREFCxIx4Lrg9NYZP7+QdpNq7qX+9Cb//q2Ztw9T051WX3fA/y/MJM8rn4jvgY7tHaK+j75wLkLNeBjJkhyc5bGjyFp+ec7UcIcNCqlOCo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Mon, 23 Nov 2026 07:34:43 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%5]) with mapi id 15.21.0615.013; Mon, 23 Nov 2026
 07:34:42 +0000
Message-ID: <14c1def9-4423-4907-8c50-6d8de91fcc57@amd.com>
Date: Mon, 23 Nov 2026 13:04:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/hid: fix brackets in comments
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261121085628.1430330-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261121085628.1430330-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::15) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ec6570-9c9f-4e9e-1c0a-08df49343d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|261026140227099003|56012099006|261028144727099003|261021123027099003|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261022115727099003|261026121527099003|261022075727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r2KpoGl8J2bQ1yDk+zhjdmHmyLUACnSe5TIwWOoJkrwb/o0V+ntGYBZadQlMRSxoYzF9v9Aaae9w4I5VoAxK+/sSLmhbltvuH5nvEpnvJ/3Tl1U4ZPSLA5OqZRQOZAKJN414Vkz+f0i7UzEsbogDW2y/qm4JYKWbDIZQPKCiwTX5P+cK16hFhJUNkMRoXh0BEdgWybfbb4clML5NZ158980QAhNm9c/QurbfArbNMZG4zPAPY9Qotots998Oa14mXktI82l4nNmyRVJmQSdL8F0MJAfTRqo7LihACUHpZM8LOryOFV6VpWxKBqwixcEiso8EL1rvO+Hq9lA4NsHcun9DR97GUv2iIJxwighYo3whVUzByFAlJLRRaLF6dmcIdEJ8GABjxZM41sWoBY2pLS04dprBNso5L6LG520KR/WGuwgxkDoJM9KUenwNbrKTyQji5x6Q2st12bMha+pNazmccuQd2C9Sy8junwC0CQg+rodwgzatnFWZZPkvGHnsNkUpsfP/QP2zOBmC0SzVeEHkyvplCGrVwl1oBfRXYhm1aDeoZxlkAkLVrU/ffpKc6AE2NIBSJvX8rcuv4W2lYbF9j7bUbdj3Kr4Q8VamcdyZx7x7kBWUccJGheA4A9evBGXI0sO6wKR3jLTS7yFWEIPDdQ6XefsBqYw3RQ4TBYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(261026140227099003)(56012099006)(261028144727099003)(261021123027099003)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261022115727099003)(261026121527099003)(261022075727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTcwaUl2MVVJQUlmVGQ4UWVJK3JxT1pnUllvNTVCQ3hDdzlNcjRtRUNjQUdG?=
 =?utf-8?B?MktRWXNkV1MyMjExU08yOTZuakNTVk9OSGNLbFJDeUIydHVyZytwRmFMVE9k?=
 =?utf-8?B?eE9VSUJpVzNjYWlxMVVVamJma0J3ZmxjbDlxUE84eWVjRkNxbW41Um9zSEEy?=
 =?utf-8?B?U3pqWXF5NDZQT0ZXdXlWWktyalZ1YXZzYW4veWxrc3ViVjhFOHAvNGE1dU1F?=
 =?utf-8?B?eTRGOG5jUnJtMG95WkxiRjExemxnUTVHMzVKR0Z4S2Z1enFnQXh6T1pKQjNJ?=
 =?utf-8?B?cGtYZnpBM0J6UnVrZEVINldMQWFYL3NWaDZlZWNVU0ZLT3d6V0l3MWNpYW5s?=
 =?utf-8?B?S2lkQkV5OERNa2xZTVd3WGZ1MXEzSU1yVDhraGM5QTk0VFZFYW5tdDVTQ2Q1?=
 =?utf-8?B?aWdsNGN2d0VqLytjdFZlSmpHSyt3d2ZBTmY0NTg1aGJzVU1CMXJrYThPZStr?=
 =?utf-8?B?VGdXSXNGczdpU09QNkppaWg5enBsUFNLc0lUL0MxTmxqdmhXQ3RGeGpJZWZE?=
 =?utf-8?B?N01JSHZFaDJaS3phQzRvZUw5QWNmMnV0ZlJSSUxnT2k4b3I4K3ZYTFRFYnBE?=
 =?utf-8?B?MFd2dkIySWFpNE1jdVAxbVFWMWx0M05EUnR0ZVBrMlB3RE1vZ2VtcHU5SEFa?=
 =?utf-8?B?b25zTEdzR3ZaQW9COFRzV3Z3UitQcDhXeVJDS3RjNWZqTWNFV2xQMGdqUno0?=
 =?utf-8?B?MG1PTmIzcFJsbmxPRjR0QWpjREltNE5tQzBwai9KTTh0T200bXZDYVRNSHF3?=
 =?utf-8?B?NDRnWVJEb25YdDhGUHB3Vktna2wyRjgvRXMzdmhUU01NWUp2TWZpcXZFVjJv?=
 =?utf-8?B?TkFydFpxdjBXUHFTdzVJbjVPNU9Mek45RWRZSmcwQURSTmY4cGZELzZ6UkJ6?=
 =?utf-8?B?VXMwbkNub0NBZStsWGJZSGt5OTQ0Nml4bURndVBQS1lOOFYzWXB2dExkVmpX?=
 =?utf-8?B?QjNSZG1adDYwZ1lWcGllOGwwKy95Uy9PUitvNlZhQzh6bTRQTWVnSlhmSmth?=
 =?utf-8?B?UW1CVjFrakdScUlCcFJTMnRGRW9HUkdCOWhpQkVXNk9rTXQrcVhJUHZmVnMv?=
 =?utf-8?B?dG91MUFCWHdIMTdFODBIdkJBQkJoL2xyZS9rZnp3dWJpOW1EUEdoNDZmTGpS?=
 =?utf-8?B?U2REZ1BXWU5TeWFteEN0ek0rSktQZ2hFT2hkZ0g5eWZFbjFtZXNrV2Jwd29I?=
 =?utf-8?B?S0c0UkNEcDc4RzlKaEpTNy9mUUtLQ2pFZitybmlTQTNQaWNUd01SRmNlbFRE?=
 =?utf-8?B?VS91Tks3T1ZVc1BHcHNzU3NqUm16bys4dU1YMitwVnZrd3lMeXJ1SHVHK2xR?=
 =?utf-8?B?YmRwMHRLc0FjTGdad3FSTTlnRldUejgwWlk2R0ZTRmdvZTlmaUFyeE93dHA1?=
 =?utf-8?B?MTl5cWtVWjhZdVB1ckEzSEF4ZTIzZDhBWG5RbjNVUmJIdXBoM0hmK2YzT0ZI?=
 =?utf-8?B?NTVqSm9BdzU2VGlob1prQ3U3c2UrOWJyeEl3TEF5MTVOYzNZaHZpYUpNbFhj?=
 =?utf-8?B?UzZpeC9ieFVRY1FtRWFJbEFQMEFUSXFGK0haNmtEdDdlRlJIeG81N09jdUtM?=
 =?utf-8?B?SEJxZDB2VnY4dkt3MDk2V1BZQnFMZmZDUGdRRFAvRmtLYlZISXUycWdKL2VU?=
 =?utf-8?B?WWpvUlRHc3RvODZPZkQ4TFo2U3JtOUNXQlRaa3AwN0tqTm9xYWNRZVUydWJN?=
 =?utf-8?B?MGpVanlTR2ozQ1dKdC9hUytyYWJjRzVUWDhxNnRqVXB2T3hSUnJUb3ZsYmla?=
 =?utf-8?B?VlNHQit2ajYyOUx5UnNYS0FrTGk0dm5OTXdkYmdaaUR4WlNzUVhPbVpXT3pt?=
 =?utf-8?B?ZW1aN3d0ejB2b3BqeXdjajM4SXRHUTBhYXJDQVd4Qk9pK1NpY21oYWpQVGdp?=
 =?utf-8?B?QXluZFVzQnRwdmZybDZtRG04SzBOVW1PcDMrVmpDd0dXOW1JeGxPc2ZhRkpD?=
 =?utf-8?B?MWVyR2JXNVhtRnNDK0pDQ0F2czBZY3Fkb0U4ejRRS2pCa1dIV2p1T3NLNmVJ?=
 =?utf-8?B?Um5vc0lSYnBXOEZ0QXNSbjlhVTN1dFhlOUpNUi81S2Mrc1FmSU5UUHRYYnZt?=
 =?utf-8?B?MVpwWmU5cFY4ejhDc3hIN1FNNUdDVyt4UFA2N1dibDFMd0toS0YvWEhQa1pM?=
 =?utf-8?B?Z2JBa1JwQmRKTUZaS1NYTHM4c2lrWE5hQzhTelowazNtVll3ZnV0RENiWWlL?=
 =?utf-8?B?N3dSd2xCT1BYUTFHdTlmYndtc2RNYm02V205NGhobGFjcHp2dThpajlWTmVo?=
 =?utf-8?B?Zk02ajRqdG5WYm9YUk1jNEw1Ukl5YXRhUTVwYi9FdU1tUlFUaC90emthblBh?=
 =?utf-8?B?ekFaWnBnOGx1aWlGVjRBU2RMamkrKzZ3QndpQlRQeGx2YUV3cGNHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ec6570-9c9f-4e9e-1c0a-08df49343d42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 07:34:42.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWU9sxoR0l0J/GTZqAqiAJPQe8/WWTDnuhsFCH2CNwkXwx6xY+U4tbcXMqL9zd2xojTW+6XPf7x6eWtjmfI7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867


On 11/21/2026 2:26 PM, Manuel Ebner wrote:
> [You don't often get email from manuelebnerli@mailbox.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Remove multiple ')' without opening '(' and add missing '(' in comments.
>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

> ---
>   .../hid_descriptor/amd_sfh_hid_report_desc.h         | 12 ++++++------
>   drivers/hid/wacom_wac.c                              |  2 +-
>   2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> index 67ec2d6a417d..6c331c2c63b8 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> @@ -81,7 +81,7 @@ static const u8 accel3_report_descriptor[] = {
>   0x95, 1,         /* HID report count(1) */
>   0x55, 0,         /* HID unit exponent(0) */
>   0xB1, 0x02,      /* HID feature (Data_Arr_Abs) */
> -0x0A, 0x52, 0x14, /* Sensor data motion accel and mod change sensitivity ABS) */
> +0x0A, 0x52, 0x14, /* Sensor data motion accel and mod change sensitivity ABS */
>
>   0x15, 0,               /* HID logical Min_8(0) */
>   0x26, 0xFF, 0xFF,      /* HID logical Max_16(0xFF,0xFF) */
> @@ -248,7 +248,7 @@ static const u8 gyro3_report_descriptor[] = {
>   0x95, 1,               /* HID report count(1) */
>   0x55, 0,               /* HID unit exponent(0) */
>   0xB1, 0x02,            /* HID feature (Data_Arr_Abs) */
> -0x0A, 0x56, 0x14,      /* Angular velocity and mod change sensitivity ABS)*/
> +0x0A, 0x56, 0x14,      /* Angular velocity and mod change sensitivity ABS*/
>
>   0x15, 0,               /* HID logical Min_8(0) */
>   0x26, 0xFF, 0xFF,      /* HID logical Max_16(0xFF,0xFF) */
> @@ -408,7 +408,7 @@ static const u8 comp3_report_descriptor[] = {
>   0x95, 1,               /* HID report count(1) */
>   0x55, 0,               /* HID unit exponent(0) */
>   0xB1, 0x02,            /* HID feature (Data_Arr_Abs) */
> -0x0A, 0x71, 0x14,      /* Orientation  and mod change sensitivity ABS)*/
> +0x0A, 0x71, 0x14,      /* Orientation  and mod change sensitivity ABS*/
>   0x15, 0,               /* HID logical Min_8(0) */
>   0x26, 0xFF, 0xFF,      /* HID logical Max_16(0xFF,0xFF) */
>   0x75, 16,              /* HID report size(16) */
> @@ -429,14 +429,14 @@ static const u8 comp3_report_descriptor[] = {
>   0x95, 1,               /* HID report count(1) */
>   0x55, 0x0F,            /* HID unit exponent(0x0F) */
>   0xB1, 0x02,            /* HID feature (Data_Arr_Abs) */
> -0x0A, 0x84, 0x14,      /* Maganetic flux and change sensitivity ABS) */
> +0x0A, 0x84, 0x14,      /* Maganetic flux and change sensitivity ABS */
>   0x15, 0,               /* HID logical Min_8(0) */
>   0x26, 0xFF, 0xFF,      /* HID logical Max_16(0xFF,0xFF) */
>   0x75, 16,              /* HID report size(16) */
>   0x95, 1,               /* HID report count(1) */
>   0x55, 0x0E,            /* HID unit exponent(0x0E) */
>   0xB1, 0x02,            /* HID feature (Data_Arr_Abs) */
> -0x0A, 0x84, 0x24,      /* Maganetic flux and mod change sensitivity Max) */
> +0x0A, 0x84, 0x24,      /* Maganetic flux and mod change sensitivity Max */
>   0x16, 0x01, 0x80,      /* HID logical Min_16(0x01,0x80) */
>   0x26, 0xFF, 0x7F,      /* HID logical Max_16(0xFF,0x7F) */
>   0x75, 16,              /* HID report size(16) */
> @@ -581,7 +581,7 @@ static const u8 als_report_descriptor[] = {
>   0x95, 1,               /* HID report count(1) */
>   0x55, 0,               /* HID unit exponent(0) */
>   0xB1, 0x02,            /* HID feature (Data_Arr_Abs) */
> -0x0A, 0xD1, 0xE4,      /* Light illuminance and sensitivity REL PCT) */
> +0x0A, 0xD1, 0xE4,      /* Light illuminance and sensitivity REL PCT */
>   0x15, 0,               /* HID logical Min_8(0) */
>   0x26, 0x10, 0x27,      /* HID logical Max_16(0x10,0x27) */
>   0x75, 16,              /* HID report size(16) */
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625..b7aa6b60fb02 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -546,7 +546,7 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>                   * physically implemented as a touchstrip. Each button
>                   * is approximately 3 bits wide with a 2 bit spacing.
>                   * The raw touchstrip bits are stored at:
> -                *    ((data[3] & 0x1f) << 8) | data[4])
> +                *    (((data[3] & 0x1f) << 8) | data[4])
>                   */
>                  nkeys = 3;
>                  keys = ((data[3] & 0x1C) ? 1<<2 : 0) |
> --
> 2.54.0
>

