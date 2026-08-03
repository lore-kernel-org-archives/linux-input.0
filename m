Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D19424D47;
	Mon,  3 Aug 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778620; cv=fail; b=k0Oy17T6BsRb8K91IuFkGwYdrJv029KULylaqU9b6wfrEsLeDT8KNPPkcrb2GPtiIN/CpZSmnoO3qkJ3zrpCMiNImo1RSqrVE1nTYIPj7Yu6b10OHGaDb4LAdk4hc5IWltYkh7+Xbrdq2BbKm/nzSo4kdmK5VDb+GFjAarNbyb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778620; c=relaxed/simple;
	bh=dO2pqWJ3uBEHLmoX7142E3A3i3HX000LQ+c3aY141ng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NoOWwfGeWnnVu2mrI5tt4OoBy6duPLBkEsOWsLM7Gwip1+urZfZ4i/bxqGUlq8fY5a/sFbbiFh/oeRDiJR3HcRrgG3QPQNEUPjrzh3WTXKapifTd46jQmufFt4YEt8oYIcubDSqCUDhT49RWqEkJJVHHelrr0wOWmN5D81qR2hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oTEV/7Q5; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oTEV/7Q5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chSElK5nWx4L1kIauserUKgCRHCfJ9rGGWCUus2Z4YYCmK+AM0B4c0coabPnko7OG5lpDHm+RSEDdA/Q/2HUwQaWW+WFpGpk+GB2RCLW4yoMovW3kOgoU0B5Kci/NBeA7NZOem/HiAhI3+FqOySb49CbgXKMpAtzVFE95vMIJiWq/f29mVdoHEqh1mTCOi1/kU+wnaaXjEXqb4YrS5ysayjhGxnd1piO72fNbhE3sp8u2FWal/4OAexq+/6/ZddC3X/LddghWGfl30qbrcVjOnUok+pZ/osnsrSFUz5/Y9Srgx1VM6T/jOLy9wUtR01fOWIob7AJclzERlbxMM8Vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVucpDljxyS+kPF7eOswzcanwnHnaP7lUqLesukPe8I=;
 b=qhATmeY3rbLOscx4WwuoHDHgmkNkjKbPPpyAviu8RA8XDUwOmPckF4Pips/OlM0yikpzN5y50O6m3Fd2Zp6YY+/rWJF5juhBNR7ZKkGHSDlkJWmY9nLrUIP2l/jY6eo7+y8XFPAmHu6nr61FJSaus9xgOosgVmCZESHinGj/fR9Xz5z73EAAqCB9tN4bu2uNMz4HLg/+IlXQQnKn2d0hHRTs0qLwkR2k0LuN3MTznk/qDUvwabeWB7giouB8mJXCxd7W0faM2iLk894f1lnxfw/xUfwAkEsVVdrmDEPMtQEqLjt8yoyg0VAUTCuetFvJ6uWblT1Rw3wpW2jKMYk7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVucpDljxyS+kPF7eOswzcanwnHnaP7lUqLesukPe8I=;
 b=oTEV/7Q5ZkwuSpgkdKFswpHu/mRyU640bqrn7ZXJA7rD4WJLYxnzd/5BAamTJgy3PnjEzSYUcvNsroJiSnZ/zulDznrhdAUG1h6x6s/5rqa9x64M26LNpfGUVM0L0XxZI9TTCdPmVfjQGGiunOmt5fbFZT8EyruxWTG8SbXteEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 17:36:55 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%6]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 17:36:54 +0000
Message-ID: <9c636802-a9ec-4f14-878b-0492576cdfc4@amd.com>
Date: Mon, 3 Aug 2026 23:06:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: amd_sfh: return an error when response wait times
 out
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: df6d0bca-cfcf-4dfd-0b49-08def185cf2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eqFYyjWMRtslwG0RE/P9kRhRaSOpUEqQh9KS+pI9RZSVrs4hCMCHlvzQfkA2/A4cL9oLOaCxQ9N5j8muFjQeGuPjbEX7CbCPDOPgSh4CAoVMwf0TSP+XlJSXz3XrAyDCp+GIxm56qVtQFKaoqx+nYAgfAuhOBzYSpz2A3u60Pmbr8WLpxNa+frDyuYfwcYYzFG5wFpKAcnuuROrk/2vb5XCHf0tiz7jKo/BGS00PD96Ew/OZdQ0xbFfZ8eXnhCQHG6OnVIqK4GcHCvAAlinCk0P9B6ufjAKGVP183ffLyMDY3cSm/ibWQ4A/ngVA/jIfAClpEZ2jDRzAMjSr7mL6ZvSR+kuNFuU66tMlQikmE/qx4zUkDL5nMlU2EqJr5bdWGQuolRUdH+DeIkeZROhlPXuRXac2Y8sCnDlQMXKkKYYYX2Ey4afdJ0gT+6qcFOPU7ErbXoze6bllAQCU1tGHC68wgIWVPQVz+RSSxb1cQskA7quUxBIbrfYYlQoyWjqXBVIZPfuNxoYdEhzWigD07+IE2z1pBDXSejXK30mAnoGq2Y5j44prZV4V7RC3UyNosoFgMIidp/cU0vILVHA/Z/O7/Cgr85dEooNVEIv03O31mw5ka8wLlAFmDaoFYQ97ny9iqbgxxEkjQ27K1JPjQHDvLMdneq2msgL3I0GgcmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2sreURsYmdBT2w4by81WStaMXd6ejF0ZStIZkVUcUcrZVYyYk9qMlNpMTRW?=
 =?utf-8?B?Wkd6azhuUkFEdkhIc21BVHRjM0ZkNDNzL2VmaEFYa2Nlb1A0ajg4MW9VY1lV?=
 =?utf-8?B?MktpRDluUzFncWRuaGc3NVBWTUlEMGN6aTNRYjVPRkltc3BEWVZ4VStUUVR3?=
 =?utf-8?B?dVl4L2RYMG1FNDJrcnk0WnJvdnlzUk1PTUY5YzU1SzU2OXdaQ05CVWRwS0Zp?=
 =?utf-8?B?MVNiZkFELzRpZUlwdkZrUVAwZGxaVy80L0ZUTjFsMEU5d2VQS1U0ZktNZG5V?=
 =?utf-8?B?ZTBaaGl5L3RIUVZKWVpsWnM2QUVpblhsZzNKOGpkSWhaQ3RZUDE0bTFpZjdQ?=
 =?utf-8?B?L0JacVBydDQ2YUpBQS9nY3VDR3NiZFZVYnA1cjBGN0xuV0QxdHpzOXIyajcy?=
 =?utf-8?B?QkFpYmVFZDZsdzcwb2RtMEpUQUp5aDJKWW41ZkFuMU9zbHBjeFc2OHFOeW9S?=
 =?utf-8?B?QmpMMzVCUXp0YlBzZk02RTZrUzc1bW1qTE42cWY2dThaMVZPSVVWdVJQaFpG?=
 =?utf-8?B?NTJmeUthZTBHREh1VHRMMERDMWZ4UG9zU3BBbkhkTjZnREt3MVJpbXE1OGN1?=
 =?utf-8?B?cXdiRUQrYm1zSWRtakJTSllnLzhsK3RSK2ZCaU1oY09GQWgvWnBuSVFxaEdE?=
 =?utf-8?B?SlZ0QmZCd1ljT1NOalZVNlFVb05abVBHWkQvcGRFVE9ncEY0WEJCTUo4d2w0?=
 =?utf-8?B?TDM4dHhSekFCM25ZdU5XaFNjTjhpVjlQMDJhMHVoN1BEYzFrbTdSQlRORHl3?=
 =?utf-8?B?ZXBCRXFDSXpBM0V0NHV3bW9rVjJYa0hSVTJ2MlgwTXhzaUxDSFAvMU9vcHJG?=
 =?utf-8?B?OWJWeFVwbkxDRmdPYlNWNUN6RWt5cHBRSWF2R0x1S3BhMGJCZS8rblFueVNw?=
 =?utf-8?B?MDFXYTJ3YTJTOFR5dDZWSlJJeXlYa1FrYU9IVUxvVks3dWpNKzlScXU3OEsr?=
 =?utf-8?B?ZWhZcU9ncUs4aG83aEdCMEdlU2hqQkFkLzg4c1NFZHB5SXRIYWhLeG5TTGxU?=
 =?utf-8?B?aWdrWHRtbmI4SlFKUEQrVWJ0bnB0dHhER2VrcDMvdHBGMGN5dERlcUN5QXRh?=
 =?utf-8?B?MUNWVWp3TlhmZGdnem0wZmJjdEpLN242bS9VRzNHcnFnR3lIMnFzWTlJZ3lD?=
 =?utf-8?B?M2hwcXFFbHBwUW50QWVtREVKbVRwY2wzQjRwTDhNN011WHo4WHRlcEo4Vkxx?=
 =?utf-8?B?ZmkwNkxBTkprZG1qMUgrdnBQVlRDQm4rMFBadFRUdy9rNHcxeXNwNWx6ZStu?=
 =?utf-8?B?dDlsaDA1SVcra0dEUTRuQzFwdVJiUnRwZkE2dW1HWG1PeUxqcUJYWmZXWGdr?=
 =?utf-8?B?V0k3VVlVRHBEVmU5cWNjd3R2ZTE0MUU0T2JEcDBicW1CRS9NYTJVRlJwRHBv?=
 =?utf-8?B?V0MrUzR2MHM0N08vWmdjTzE5QUltKzE0UzRJeWRHZHMzRUhsTnZqdW5uREpL?=
 =?utf-8?B?R0FZUHFla3hYNGtIQ084SzZlaUY1WHVaN3EwYjJCRGpacTVuYlNPSm5xaFBW?=
 =?utf-8?B?Q1NDQ0pPY1lBT0M2VENzUXhiUkdOREJqdm5ldmNsU2ZFeU1rWEd3cEJwNUFX?=
 =?utf-8?B?UVM1UFZqaGdvOWZUL0VJME84UEo3YUVOOENmNFRIbXZQNVJQOG0za1FQdzN4?=
 =?utf-8?B?UkF2eko2VG43b3RkUWlSNUo1Sm5ITUtNRE9BOGl1aXhReWtJT214RG9obTlM?=
 =?utf-8?B?SlV6c2tSeUVVaHFnMG5URnVEL2xPb0FoSGhNKzNBM21Oc3VtRitBZmZST2Ex?=
 =?utf-8?B?d1BUZWxEd1ovamZtUStvd294V3IwaHlNMkhTYVU3bVpQMVVIMFQ4elUreGh0?=
 =?utf-8?B?alEyMFpKMWRkOTMxeUVIU3FIdERteC9EanAzb1UwRE13VDc2eGpod0lVclEz?=
 =?utf-8?B?Wk40KzkrakE4Um1XazFMbWhBeWJhYzkraUplOFJaQ2hlMXZnT00wckpZVnJq?=
 =?utf-8?B?U0pSNXRLVENIRlFwMkljUjBNckdTbzVhWTg1MHNVM0ZQL2hra0tkcnVlcnFt?=
 =?utf-8?B?Q1BsZW5kcGp3cUNBNndrZFhrK0JncUJncXhxaHJBczBRQ21zNEczdGV6VHdE?=
 =?utf-8?B?M3JXNXR1QVQySmlpb1RPOGM4SFdMd1JDcXMwM3FkY3VJSmVDWCtvR0RQVVJO?=
 =?utf-8?B?eDB6alI3VlprRlRvbytTS2FvR2dFZmYrTU9uclFBR1gvMFVYTWRaQ0ZwZXRC?=
 =?utf-8?B?ZjFVZW50QmJVbU5QYjJvK2d2ZGZ5VHkyMnZUenREQkhSdklPMDhCcUlKeTdD?=
 =?utf-8?B?OWdMcGw0dHhCay85eUpEU2xGeEs1QkRrWWJDOFZFekVIUmZZeXlhaE1sWm5t?=
 =?utf-8?B?VGFpYWVFUjdSRGN5SlJNSEs5VTJBQjlvUkRKNWtWOFBJTkRqZjdPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6d0bca-cfcf-4dfd-0b49-08def185cf2a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:36:54.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQbg36ANNt46Riu66jGE5JRfW+VQdPaqBjsrxYpJE/iJoWRI1nvLgXDs+kHTRSwoag7icwJ/9hylcrKgJPjYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239


On 6/24/2026 8:05 PM, Pengpeng Hou wrote:
> [You don't often get email from pengpeng@iscas.ac.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> amdtp_wait_for_response() waits for request_done before completing a
> report request. wait_event_interruptible_timeout() returns 0 when the
> wait expires, but the current code treats only negative values as errors
> and returns success on timeout.
>
> Return -ETIMEDOUT when the response wait expires while preserving the
> existing success path when the response has already been observed.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_hid.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> index b04f675d4..8f88f965f 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> @@ -87,16 +87,17 @@ static int amdtp_wait_for_response(struct hid_device *hid)
>                          break;
>          }
>
> -       if (!cli_data->request_done[i])
> +       if (!cli_data->request_done[i]) {
>                  ret = wait_event_interruptible_timeout(hid_data->hid_wait,
>                                                         cli_data->request_done[i],
>                                                         msecs_to_jiffies(AMD_SFH_RESPONSE_TIMEOUT));
> -       if (ret == -ERESTARTSYS)
> -               return -ERESTARTSYS;
> -       else if (ret < 0)
> -               return -ETIMEDOUT;
> -       else
> -               return 0;
> +               if (ret == -ERESTARTSYS)
> +                       return -ERESTARTSYS;
> +               if (ret <= 0)
> +                       return -ETIMEDOUT;
> +       }
> +
> +       return 0;
>   }

Acked-by: Basavaraj Natikar<Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

>
>   void amdtp_hid_wakeup(struct hid_device *hid)
> --
> 2.50.1 (Apple Git-155)
>

