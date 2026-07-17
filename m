Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293D3ED122;
	Fri, 17 Jul 2026 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284687; cv=fail; b=JyChyUsTf2f0RzUq6EdwsPh0l0vrHI4YcAGSxA+15+m4McpEoXJ0pwdqdsMP6zc0XdpHs/Q32+2mxDVhQ0/zRf+eklly5PTIScMbfLlwiJV/Acj0mVDmaTb64RT1ognC+ejvQbPEsUaEKHNYOn+S+T7cDoylcFAukUxQxmZLLSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284687; c=relaxed/simple;
	bh=CTmt6th2F5rI8LNk51PdC58CzjN7N4Fti+9BqOUrk5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQPhzWsMgfS/xTVHhmjJlw3pQwzRNnFBZbKDbmujOfNe4scBU4xYly1K8DJSWt848VQecJTTRAmhm7lfRYo1NIWqU+Sy9jjw3PN56P10FGTV21iyFHzcRZjRrY2vZArpZVXyO2uESh45uV5qkB6j23m0tnVW+GJpAwSyZuXq7wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CYQYmcgl; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CYQYmcgl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d20xmY3aW3H508o4zwKLR6Pcnb4KuAPXH52ouhgkcxdaYjkpar7Io8K3Jc9Xdr+2XD0XfYvgnluC1Y1jwTIQqq3dZ3HjAYsVnLCwc4Ros90HcfsobHSChAsCtpP/zigKNSu4nKHIGmaWzC8mfyIquRSdo6dbIKpgdV6+BhyAVGEg5aWHk/N6/a8GrB+c5aMgJdztU66PkMYng+3+FIawBMApXSFwhTQWhEPd5ybUYibC7KhpnSNLexMih1vp62ODa2z3EgvaLNJpxLMCoQzZFstvHWqddWifJChnHP0la3fRQLW78rS6a2tSwOxlE6weknego6LKcNLFnoAo1dRn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dor7y59lKLDcgeZ2sqEUkq9M8Uq36VYsQq4UlpVzDbA=;
 b=Ml0oEHI1gc7hYKJ+byRkcrOBGYUs8B6nUQClT2k1wAyyqXCDRuhYti4GU02q4yiQIMl8WraX9zbYPFit32v27jCgOjFixVBNnYpw14FtvwJCd97qdi26v0kRv1XLgVqiRD1eePNyhInjvrPH+qhQBasBGXCrIIZdMNDjPNYR8fSG+O1KDj3cWoTRKxOqvLFmq2UW6N2al0dcIsJms0FnXosGs8ck9f+X9EelJmDL37x1coHwBIRPlBW6ucia0f0SvzVrYCLS3yWaERMw2pnWh5TAyuDCxl+wNcMggeg1plZ4CJCzRE026OJKHHdOeyNo8YyAPr8lEtVNQJ9acczlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dor7y59lKLDcgeZ2sqEUkq9M8Uq36VYsQq4UlpVzDbA=;
 b=CYQYmcglqsnC6kWYMjoTGwsfQfgKUvKNMVdW4irtfVRSF7pbaDmyUOHWdn88+caLs66iV+B+TL0DiAtXUvP4eCmWGxFWxRVJWZ6w6Cv2KP5KFETzBRM+KrsSrmu53lZU4Ma9fAawaA1ZZBXPtZMQONo/NFhrzBG2I8v4843RPFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 10:38:01 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%6]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 10:38:01 +0000
Message-ID: <313f2aa5-6757-43f1-ae3d-4153a413fded@amd.com>
Date: Fri, 17 Jul 2026 16:07:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: amd_sfh: clear hid_sensor_hubs entry on probe
 failure
To: Chen Changcheng <chenchangcheng@kylinos.cn>, basavaraj.natikar@amd.com,
 jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260715094622.115062-1-chenchangcheng@kylinos.cn>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20260715094622.115062-1-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ca4b2b-afa6-4452-faee-08dee3ef7988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|18002099003|3023799007|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	eABCla7pyBo7qqgyhGbhPRX0qIkB1a7t1MtWupMl1e8ucYZgg2JvBnDSKjuDqFkbQprGYbOQdsuH82ydJzqfPKjgGE/zomFxfuipi+62IAtc63/5rOzodkXzMKjdpQV4OpMF6vWVk3y3NUGprwttRf8NCXWWqE1i2GoApaJHS7K/QoE59os9uPLsoMcwkaJarMYNm0C6wweCn5TgRidyWUmi8m0pR9tzVaWcNaWxcnuozviVL+JsMyqfpWJ72D3w/eM/yfJHz10M/yN3PIsctvhB0uou/dPoZstbsEh2ES5spZidofMP+HGBKYbAcNtUo10QKcswZ4rJLF5v+deNkXDa29Nq8WRAdO5af5UxkkIfFe9LBnp6FrN6HSlj6hdV1HFFX2BHV/joX+jKxNHLL8tFYQi6hgbCmSLmHwazQeVuxP6D1zb8sukDj73UUzprbUkH9d6fqw5YCCPbLOQwMJIqylh+xPYk/ivihVSIB+6e8mKL0MKt8tbtTitPdqrylarx1rQvGGPagk05Svv7s7nJezazqc6IctBikxikyqUEGN4FdeEAnhXZtw39tiHwEGYaUjerbg3/3qgHqGrSp8ys5JNptcjs0tR+JbkNWcWT0d5OsmxZmASWWH6L24w+6pHO388U1e2T0CkYULiF6lt23GQtDvSIR0hv1NaFDuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(18002099003)(3023799007)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHpnSi8yd2ZsRnhlaFdycGM5L1grRDZIa2pOTTRpRkh3aGlreTJXUE92MHZU?=
 =?utf-8?B?alNRMG5CQ0x2WDlEZ0t1dW5TalRMWGx4cHFwamlUc2RnY1ZOTmhOSFVIUlNk?=
 =?utf-8?B?NGpBZjc4RVkwZzlOeEpJekc1STluVGJLUm5zRUd2YkIwWTBQN2tUNXRVSWRW?=
 =?utf-8?B?UlhyUjIzUXFQek8rOU02UDFCZWlTTlkvQnVyclBUZFZlT0JqRElUUWlpZkMx?=
 =?utf-8?B?MThMWmFLVi9rTlNJeXB4VTBxNzZwSzNSNjUwaFNmZ1hVajRmeWt0dHdqMmxk?=
 =?utf-8?B?UUVoVnFQVEFQSUVVaFRhOG1tVmd2d0w5aHYyZTdacE1CMEFBdk1TL2NBZEF0?=
 =?utf-8?B?M1BuMWJ4Wk92QWcyZmdCcGNRbUxvR0JqVmx4UlFSakE0aTFjcVFZRkRBdEIr?=
 =?utf-8?B?Y1Q4dlZIa1A1RWhISWtXVjFjMytuZnYweEs1U0I1TFRVdW5rdUVtQ1A2NThw?=
 =?utf-8?B?NDlPaUp6UjNVYUZVc0xUQnJjV2R6eXZSVnRIYXl2U25jR1RwV2N3Q0tKdWxm?=
 =?utf-8?B?Mm15T3BmWE5PQUl4V1Z3M2dWME9LVU1qaGwrU0NDZDA2QmJ4Qy9FYnc4QWhT?=
 =?utf-8?B?QjUyZUdhQ2Z3SS9ZNDVwdHhiR1ZCUk5NMVhBZUpDN08rYUJSWGg5VHZ3M3dK?=
 =?utf-8?B?YXJzUnJ6SUo1ZFdjeVZTd2ZLaS90QXhTUDV5UlRncFF5dnZaRU4rQy9NOXc3?=
 =?utf-8?B?dUtKYm5CWmZNall0WjVHUnF2dG9XR0RzQ0owdE5hSmFDRlJlTUlsUXlWb1lC?=
 =?utf-8?B?Wit5Ukozbk9EQlRoazcwdzdCVXZiY1Z1RTFuSDg2RmRjaUc1ZDhUdGNuRlhq?=
 =?utf-8?B?SkVqc1kzNHVCSVBaR2JKT0ovczNUVXBwRnNjWmR0cWdITHQxNHloYVdQS2dI?=
 =?utf-8?B?VHNJUVlRR1pMbCtiRGZ2QTNEdDJwNjE3blZNN0hhbnFJcUJRYjIxU2IzTlk4?=
 =?utf-8?B?ek1QUHdWUzhSZmxTekdHaGIyeFRMWVBiLytQQkFwZ3E2NkU3bFNvRG43bjdm?=
 =?utf-8?B?aVNCYzBhRjlJUWVHY0h4eFBEbHNNa0cydGVJSnRBMW8xdFNkVVE3L09Bd3cz?=
 =?utf-8?B?T0xuZ0lLVDJaUFlXbG9ZYzRoQlRrQ3c1Rm1DeWF4NTJJblcwYmRNaytjU2w0?=
 =?utf-8?B?MTFlbWk0eDZhazNtL3Z6T2xzaDNheE5IVnB4MnltZStUa0ZBR2hNZXpidFZN?=
 =?utf-8?B?aEphWGQzUnkxNDNwNjlpNVl2ZXVCaDBhOFJ0aWdabUQranQvLzVOc3pRQm5m?=
 =?utf-8?B?SFZxU25tTUN6RFFXeXNFbjZJMVgwQUtRVkU3TWcvSDZMN04rRFFVRnhHbyty?=
 =?utf-8?B?S2dvVFRXZzNvU20rKzdwUk9HOGx3NjBQT0Q1NHRvcy9Cb1VhTXZ1TTkyNHV5?=
 =?utf-8?B?VWttcnk0NlVJa3lLQ3ZTanJFVmR0ZXNtQ3BSdEE5d0dNKzE0R3JCKzIvNWNs?=
 =?utf-8?B?RVh6NStPS29DQjNDQmgxMjZKRnJkdHlUNFNTTkJLWllZSGdtRlJrTXFTRThv?=
 =?utf-8?B?M2JrTW5hcEdhcFU1dDNEL0l2Rk1vdkkzNUlaOThEc0J6OTd0TDhXa01ibVVJ?=
 =?utf-8?B?cHFRZ2U5T2lLSkhwd0Q0TDVVMFJsTkRuU0NuOWtrVTluYlZFOW1NcHVpaFpz?=
 =?utf-8?B?ZjA1OEFGbEpjMFhNcURIakh6YTV6RUZ0aG1UeU5LcFowUlEvYXVZcXVPM2Q4?=
 =?utf-8?B?bHR4aWJHOStqMDk2SjZxSDk0WlhLSURSZ05qR1JMd1RWY2MydlFNTjkzT2Jq?=
 =?utf-8?B?RkZIZXQ4c3VZbG9vVzhvRWl1U1A2cTdMWFlVNlVlM3BNR2E0MWs0eUJudHhh?=
 =?utf-8?B?aW9YajM0SjhxRFFpek0vZlB4WlduamJqUWlUeHpZcmwzOW5HbTNGazFoUXg2?=
 =?utf-8?B?QXYvSHRRbGhnVkdqV0xwVjJvMXZPY25mSXYrNC9kdFdBU3BFZm4xdnJnV2NF?=
 =?utf-8?B?VGlOclB6Y3B3TU0xN1J3a1AxY1EvZXRIbDg2V2VmNGFaQkQxY2lwbkVKc2VF?=
 =?utf-8?B?em0waTVBSTByeU5oY0JOTGVOWEdzd3FDa1BWYncrUURoVWdJM2hNSmlyNDZO?=
 =?utf-8?B?VkNZWUMrZXAwaTVVQkZPanNKY1pkTFc4LzgvWXJEUXQ3RzM4bStiQVpwT2Zi?=
 =?utf-8?B?bGdObE9MT1hyTjU1ZHhZZ3dYUk5PWGY0QUVhYUYzVkhDOEVKYXFGdStEK01T?=
 =?utf-8?B?ajdrOHRCbURrQzQrZzdrOUpDSURvNHhTTE8wbnpkbVdzWjNXMm9STFFTaFBV?=
 =?utf-8?B?eDJzdVByQXRtN0E2aXZYbGQ1MmU2eWVYeUJsRHJ6K0c3SjlTWkJTQVQ5S0di?=
 =?utf-8?B?T2dvS3hRSi9iQk1Gd1hBYjVWVXZGSUt4azhRNGZ5NWR0T0E1bnJSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ca4b2b-afa6-4452-faee-08dee3ef7988
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:38:01.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHEN26tRC050A3sMYHRMYWTuPuPGt4YuLiE6myUR6g2QqFR8lsJH244OmpLpbAoA/w8xiGPZZyPq5IrOk66uUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373


On 7/15/2026 3:16 PM, Chen Changcheng wrote:
> [You don't often get email from chenchangcheng@kylinos.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> In amdtp_hid_probe(), the newly allocated HID device is stored in
> cli_data->hid_sensor_hubs[cur_hid_dev] before calling hid_add_device().
> If hid_add_device() fails, the error path frees the HID device and its
> driver_data but does not clear the array entry, leaving a dangling
> pointer.
>
> When the caller (amd_sfh_hid_client_init or
> amd_sfh1_1_hid_client_init) detects the probe failure, it jumps to its
> cleanup label, which unconditionally calls amd_sfh_hid_client_deinit()
> and subsequently amdtp_hid_remove(). The latter iterates over all
> hid_sensor_hubs[] entries and, upon encountering the non-NULL but freed
> pointer, performs a use-after-free read followed by double-free of both
> the HID device and its driver_data.
>
> Clear the array entry in the error path of amdtp_hid_probe() so that
> amdtp_hid_remove() skips the failed entry.
>
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_hid.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> index b04f675d49b0..9eaa2785a9ac 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> @@ -162,6 +162,7 @@ int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data)
>          return 0;
>
>   err_hid_device:
> +       cli_data->hid_sensor_hubs[cur_hid_dev] = NULL;

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

>          kfree(hid_data);
>   err_hid_data:
>          hid_destroy_device(hid);
> --
> 2.25.1
>

