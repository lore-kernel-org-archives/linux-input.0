Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFA33B3892;
	Fri, 27 Mar 2026 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615633; cv=fail; b=lJ/3c56urByauvMklhbr2viaJgSGpucQDjSfcPCYr0C9HEfcBKi8x8B5JjK8uPvHFLio2UW+IeQsUnXPafBaPoH+h+ITrLKWisIXStgSK9M6qDMoVeNbF2r3ItTDQn4uL8NDuTDxSX2edCR/tdBDT9NLJSf5rYaLo9mftb3aecY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615633; c=relaxed/simple;
	bh=1zIUsDmmxNToniPfpQDg+2x4Ej5Br1BrDBSnO8sXqes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aS7AVoGZN06jCuq08dreg5lJo4xiNCgH4uLwU1Ofm3if+ehrPcoGWlg0tXGVrhs91aIDVFE2YskAwtpgbapRW3Zx48qi3G59ZhTp+/2lvano8WNlHgUdv76a01D+GWBuyou1u7+v4wZ2aG86RA2lyjIAYDpfSmrJmkFQtj8Vm1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KyBdEIEY; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KyBdEIEY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQyNSyfzBcaAva61+D1nbuxi+lk/j+wY5INCmL52/mDKeUFI9WSLKxAAww2EitwxpP8ry2fYOxoHnepY1wUcwaYsmjtiV8KFNBQPo+6Vh9kMI8LM/uL2ab19E+VukFvmYWkQMCI5xctkLRrsgfekQ9cjzPwAReJf+iKa26NDrsA6OH6tvtirZ8flJnAlgKCxEzdCfrlRV9aD7ofazw2r49LeMGM0GsCHwdPFMyxcd3B2pv4ai17ipn7RVmanwTodiptQXHGZqKjqOnhLXOkgS+hXSTsieKKVELGggHzNvO0OJLH2lfJmos1Ezb+7b3yzafHrcmx7CJPHViGOo8wWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfgFKZenY7BZtTnGoDKXZIc+Q5bnJQkWGU2vAgy+1uQ=;
 b=P6AgwVedd26SEd3+tfdj2Z/mX2Vg9KQ8KlVBdSatpaOfSTBjBGMLrWKOvruyHEZrwAqkiO3rEQkj/FgSkXwRF1YKeB4YAtkuHK64YafCd3fMxoGEw588v0ydTfMCfpvcfXbb0/nGZZXYF/02/nGCT2vToXu6YkdTVKJhUQMGZEBgDDA3wd2TGmNBqXPPqca09Rs5WeP1mBwSsSjN0ZH6m1eiV3teLvKyOocRw8E5jQ6kX9eWSOZP422dnKEbTyeiQ0MfFylA944xjiyiHdu4I0Cw1KlSiNPnWzOpD5zREpPLe5C5gGm/PnJnXb5D8vHdDGkRCF8MmDyWRppOFZykQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfgFKZenY7BZtTnGoDKXZIc+Q5bnJQkWGU2vAgy+1uQ=;
 b=KyBdEIEYd/qcJEbqBEEwTmkOwkR10H4Df1YAKM7BVyteVljr26qRVEyhpQSMoMoTVCSio/Ab3Jhj9LwAi/3jhOZVulvOb2V1+gP058+1/QxS/sZGatLeLgNVWm7F5Fg0BMoqM9qVhVkgjGH2sCM0PB4j6y4efu0baC7n6Xff0iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 12:47:08 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%3]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 12:47:08 +0000
Message-ID: <2287aea2-e4ee-410f-97f3-a7a842e26bcf@amd.com>
Date: Fri, 27 Mar 2026 18:17:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: amd_sfh: don't log error when device discovery fails
 with -EOPNOTSUPP
To: maximilianpezzullo@gmail.com,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Croy <ccroy@bugzilla.kernel.org>
References: <20260304-amd-sfh-suppress-eopnotsupp-err-v1-1-20214ca6a2f7@gmail.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20260304-amd-sfh-suppress-eopnotsupp-err-v1-1-20214ca6a2f7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DSSPR12MB999212:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc58d7b-3180-4d32-fd37-08de8bfef4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zfCcj1ODtONxs+RoIDmnvaIyEzmwhMEc7/GW6JM45iYhZQSwsTQZAUYlsIsH7wFUiI8PKotCLYcJne3iqCkvPaFpVl0rR1r29Lq4i6rG4eGsAhGddMPLI4vL5qnESTQPUTkcOLEey+i5qZsNMfNhb7rNeTE5Z2vAIJx2mQNIRJ7vO1s94Ll5xbDfDEf44YZxQo2J7lf7CzsUbfVsooV+Ad+S7juTjcbvbq9XAJcMGGHr39RuaV3gWJa78YxKZG6d/tB7NCvCZ2c9oPVJqFzvPYM99DGxZbPZ4K4GP7ejMKexf5VH2uyZpJqabV809q9W2f7sUcj98SRVmpe8jk1pz6mTK/H6sL5bODrNwPQYp5DwMKDOtyTI9rO7TBnEWjhvZgqCgPeSX0EMAXsQvA7JDAXyQx113y/lDp7gF82r3ldPLoSAwQPZ8JDsIJ4WRl+aIb1nYuC0U7JrVfHqzJtSJQJQPVO+lVeTVGEq05QuLT8uqRvCkAuRcl/8HpxApr4Pq9SdlllAq+5HQ56CE6gQtqPXboKjxAnldjRMDDY3wh9qaPjdJg8K+TjzK/pS6KtU0dRVLS0H3G8BqaU/pLpSzZU85M4QN5j+zSHMM1XcBCkJva1GC3rBolIgQf6c+BwZdtGqMmWTqmtbn9kOyPwcKEYU/WMr1l6VcgMmZFj7QzxKYjTgKwJudMWB/UAXNy/PFlQRSuHFjZdhWgLWRqRGpHztOb1E17+0Lt6Z4N1o020=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm5ubVBvNCtXeE9EMDkwdTJNcnNuZk5HSUkyM0lFSjErWUNyZ0c3Z01IN25n?=
 =?utf-8?B?MDNINWQyblJ2L2piaXcwQ0NXZHhpOUJ2STV2V1pJL0NBOVNQNDdtWlBqdXUz?=
 =?utf-8?B?MjcvRUlVaStRaXFoeHEyVnR5SjFRNmo4bTFvS29MM1VvQXFCL3hvRTVDZWpZ?=
 =?utf-8?B?ZE1pMVVmampET0N0LzFWcXZtS0Z5TzFKRXIrczRNM204MjFNaW50ZkNiQXBV?=
 =?utf-8?B?SGgwSExITGkyVHp0V0pReExkQWRIMVlXV1B6QTBjanpva2xkWXdBU1Vxd0cw?=
 =?utf-8?B?dm1MaXg0enFEbVpjSWNKdXZSZnlvQ1ErcWpLWVNDY05WKzBaakFoNWM1NGNI?=
 =?utf-8?B?eXhFUWhGeHNxL3dqTlYrM2RPNzB0WjQ0elgyQ3BEdU4rSGJxK3B2SG1sZ2VO?=
 =?utf-8?B?R2JJQlhEQjZSWGZleVQ0ZkRDZ1dJcW1jZ3ZZaElWYk9hd2hxWXE5WGVkUXhB?=
 =?utf-8?B?VTI1bzFCUE1wNXkvS0JaZDcyTVQvK3FCT2huZWJqcWNxaDVqSzFqYnVvQ3NW?=
 =?utf-8?B?WHdVTk02cGorWlJNV2ZVSjNpa2RvNFZsUVZhclRxNlBNbmt2UzEyOUJHcDkz?=
 =?utf-8?B?NnRhYlFFM1R4Q0R1Nk1QS3BwRm4vVVhjbS9JMWYycldBU1loNE9mRXkvelZS?=
 =?utf-8?B?c1g0aUJLWU1LRCtYdXVqUnRIcE9PTGpYRDk0Qm5ZNG1FbTY2RUtMZmhZcHVY?=
 =?utf-8?B?Ri9UaU5JOWV2Z2FRZ2VXTFhlZUhvUWRIZUdrb0ozU013dU5UK2ZTa3MrS3Zy?=
 =?utf-8?B?ak53Y2RCbFhsRlRGdnk0VHduYU8xNk5EVTBqeG9wekVwYXByczBjdmNjWEpw?=
 =?utf-8?B?U3R0dmhYQ0YzVE1HR1NiRmMrNHB4U0F3aDREWm0xUHZxK2RIdkhncXVTZm5G?=
 =?utf-8?B?NkYxdFZLYVdSNXZDWUZWQTdsWWl3SEhPaGhmdVZaVjFobVJhSmFHWUVyV0ZK?=
 =?utf-8?B?QU1XckpQS1h6RzFHU3pUaFlRWGJockpPam9Nc3RHdjlpeVZHSVZFeFJkK0d4?=
 =?utf-8?B?ZUpEZEZUdlZIanIwWTNaUXErdzhTTFo1WC9ZaWcvTDQwSFhlRHJlNGFZY2pL?=
 =?utf-8?B?WW9QcktGOEkvUUxxa2FqM2ZHQmZOMzVNQUF2V0pqbTljUjAyNExZTW1TUTAx?=
 =?utf-8?B?c3NzMUs3T1h2amFFbFNsaVhSN1gvS29lR0FtcmNnWlVIdlkwNWppSE80eURs?=
 =?utf-8?B?ZC91ZnZvZUVXQ2hQYzFHcDBSVnI2Z1UwZTFkaytDdFNEWTBkUTNxRFFPKy8w?=
 =?utf-8?B?ZFlWcVFhWVdESmJvc0ZLTTV1QWFMNi9BTTNYU05zNDlaZzZwYlFVWWZUZXlu?=
 =?utf-8?B?anpjT0ZQY3BWb2Q3T3lVam9QZEVwODd2c0dwbXFEQTBieU85T3NxemhFZk9k?=
 =?utf-8?B?NERPMmRmWUFGSXZ5RVVDNmtHeTZybUE4Z1B6ckxrQ3ZQS1o2S0dleDF2SVNu?=
 =?utf-8?B?NzB2YWFxMTBGU0R3c2RtbC94N1lPbzZWdzl0RnVSdmZBZFBkbHJmSm9ldEpI?=
 =?utf-8?B?OHpYOW10UFZFVzRvdUVEaURPOVFmZm4wV1lSTUt4RGFIY3k1ME5GdEtCcDFq?=
 =?utf-8?B?VTB5c2xDTXVzT3dGazVPTzVFWjJwUHZVZmoya2NQREhLUGtQdlFEWno1bFZm?=
 =?utf-8?B?SC9pV2xvL2tNQ0JBYVhGaXY0MWZ3UVg1RHduaE9GRDdoTTJHTFd3NmZjOGZk?=
 =?utf-8?B?WlBxYy9wQlZMRXRaeERzbmM3QXY5LzlRcHg2WXpueDBDck9iSE8yL3YrTFg4?=
 =?utf-8?B?ZFdmVWpoY1RMbzh4VWRpQTRGMU9rVEpaeDRBcW9UMFlUcGZSakVwd2w1VlJS?=
 =?utf-8?B?eTN2Ly9IYWNrU1BmTDBGcFVTUDZTQW54R0RMUjJKL2NhWVlvU0F5WVNlQk5y?=
 =?utf-8?B?RktUWmpFM2RDcFpaMlM3cS9ZODlWb2x2OGN1dHYrZUJ3Zml5NGlBR2t0cllu?=
 =?utf-8?B?R1NLZHRHNmF1VDdBSllDTXpBRkpyeG1GQzNKTk9QWkp6cSt3Q3QydEErRzI5?=
 =?utf-8?B?WUVQUUlJSFZTWTNpME1Yd3d4OWZwNTlPNUhmcmNWaTFNUG01a0FTeHhuaWlo?=
 =?utf-8?B?UVBzdEQ2ZzBhaEhPSHJaVWhLNEhyV1dENm02dlVTRWtHRVh4elE4dVhkMWFR?=
 =?utf-8?B?cE43WU5BMStiRWI2bEIxeE1ZZHVCUGdQL1BxRHNKZXVtMFl2UVlzRlE3Ni9l?=
 =?utf-8?B?OXRaNSs3MERCODhiVFBhWkxBNzR6QzloRlZ1bnZ5VXArVkR4U3F4ZURaamww?=
 =?utf-8?B?emNiV09iYlo1TS9XYzF2MFJWb3JhMkNHM05lTk1vUXJZcW5jblNINWU4WWlu?=
 =?utf-8?B?cVczTEh5ZGgrZjJlOHhuUFF1ekR1cmY0dTRUQ0lBLzdCa1dvaWUwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc58d7b-3180-4d32-fd37-08de8bfef4a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:47:08.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBHp+MG9cNY0sFWQoYU09sMx/drwAihAxNd0zeAVCh7bvV0t7owfM/9uhkvXfHFj0XK78VYcFo5r3Fl1xThmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999212


On 3/4/2026 1:55 PM, Maximilian Pezzullo via B4 Relay wrote:
> [You don't often get email from devnull+maximilianpezzullo.gmail.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
>
> When sensor discovery fails on systems without AMD SFH sensors, the
> code already emits a warning via dev_warn() in amd_sfh_hid_client_init().
> The subsequent dev_err() in sfh_init_work() for the same -EOPNOTSUPP
> return value is redundant and causes unnecessary alarm.
>
> Suppress the dev_err() for -EOPNOTSUPP to avoid confusing users who
> have no AMD SFH sensors.
>
> Fixes: 2105e8e00da4 ("HID: amd_sfh: Improve boot time when SFH is available")
> Reported-by: Casey Croy <ccroy@bugzilla.kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221099
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index 1d9f955573aa..4b81cebdc335 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -413,7 +413,8 @@ static void sfh_init_work(struct work_struct *work)
>          rc = amd_sfh_hid_client_init(mp2);
>          if (rc) {
>                  amd_sfh_clear_intr(mp2);
> -               dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
> +               if (rc != -EOPNOTSUPP)
> +                       dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
>                  return;
>          }

Looks good to me.

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

>
>
> ---
> base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
> change-id: 20260304-amd-sfh-suppress-eopnotsupp-err-0be59878e2fe
>
> Best regards,
> --
> Maximilian Pezzullo <maximilianpezzullo@gmail.com>
>
>

