Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182643A6B65;
	Tue,  2 Jun 2026 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381435; cv=fail; b=OQYuPZ3TcOXNvd/ZVPaaKTeB2it4zCudzy5y+q/iqGG0GP1y5nZ/bCNr5tf8nm2df5dOt65lAPL1V+wCzF8mwfSbKXmipXWWT+P7a8eeoP5zCYd6Rie04HNIotxNN2YFGpx2OOuoyZtZiVa4D3pGiAciN+IS17n4qRNVAWRVEo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381435; c=relaxed/simple;
	bh=o/5BS+ZruI6bBH5cxDTr8GNKAdUTTI/uwYYjvHhbRD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ls5F4HUVSqJl1wS6H3pbQtRUt7C16LSdDmhOjNwm2uGhg3SMTCYuFIIOdIhGpRty+MJyiQ2Sb2EdzgXItl/buMjUPdB0lXH+DCN4a+dw6RMPHpxSX5+Z9YRW+ymvLTYYvf8Fe6Tg+QW1NibVotggoSXFENtNjZjM4iAhkhZSp6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tUCWSh0u; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tUCWSh0u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRa1OU1E7P4K9cXl/udjTEA1mg4u1K3JG/zPZN+8lnJ4YGqnnkCVoPlv6jqT5pQsVNVZX7m1iOHTgq/OOAWr/mkbMjs7GUejiu8vHJqWA0HAV1cNUjpJKbi/GykfmxtyEP72FOAlvT+uBQ1oW+2aiTNs07AZnkBhL/tc1LJEzHgmMbgxpdIu3ypsi2bUpeai1GT5A7Uv/rSFB0rKjEKycQt9DyjOisz8XXBsctaZncHxGwPM/J58u+mPDCPPhHsLpMEMW51zfUs8rV0tgRQ/UK/Yu59A0dWS7cYuy02/4Zw/a4aIxqQaqlIqaJD6GlnRW/NoHTrETka2bpIwGTyfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cCtOYrDfM0zHUOQ0i2TQxVIh8JTit+4tbbLSIzMF2M=;
 b=vb+RsOkRLOH57u0qZ6h2Uq44Is36j76V10tP4r8AttiuePfOuCsckJQtar2jzYoJiZcDTUuknFoDPnp22sdWIKNF0/rsc/sTLBvM5G5HJ9TCBJ4oXL/uur89OYeQPtUuAAWwlyfriPPyCno68++k+7YVoO4gIw4hoq97utZjZLQ6Cpc4oomApm8n2LEqCjbyY8ff7QedYQmlvymHO2pcySwtxlP2Q1ZsNcUTfLTvZx67fDWnIZf19onXW8pUnSz3A10eQ/WI78m0RSJE8i5/jlbN1paAJ8uT9a4Z8+7mJFd9U+19d0ke0vP/AnON5qtNbeUC7lMCeaF0i3U5/o4qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cCtOYrDfM0zHUOQ0i2TQxVIh8JTit+4tbbLSIzMF2M=;
 b=tUCWSh0uC/S1K1/eqje3nRggG+EeZCpMkfnQ6/ZR91GZd+rcYC2aPN7xNPa2PANFWyMEdKqde2erI4SKrfU21W7CzUxufAduugPRykWZwZwp97FBWzYetvg/AzUe1UkCg+bPAgw1dWikYiyqGEUo3ZxIoM7/J/oVBmyy7VwBnFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 06:23:51 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 06:23:51 +0000
Message-ID: <79ccbd62-9aa3-41a6-a8db-1737672a8aab@amd.com>
Date: Tue, 2 Jun 2026 08:23:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: xilinx_ps2 - replace in_be32/out_be32 with
 ioread32be/iowrite32be
To: Rosen Penev <rosenp@gmail.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, chleroy@kernel.org,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <20260602035907.623599-1-rosenp@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260602035907.623599-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0006.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 1badcaff-a5e8-4a04-83e8-08dec06f8341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uwkEcIMSffWQYVZOvaN5pJNZBEw9rxQqh+mOUvA7+ky3AuiO2XF3U0J+uz1w/DGB9Ih4OTo/VBNKjntGhNR5g5wyLJMn02apru14ABvo5LWLGwIPLQERY4ritdTabQd1LcCm/jdKu/fH89tLO0ZVBC5ijfgCL7WSaeZOnhGBakwKynM+bHvhAIG5WUfM6kJ2TMwoNfA46vw8f+dHl0lvfEkSz1nBjFLiOexsBQuUalWNBtz1s5HyC/2nhBXUGq1CWgGOTNKClUMmnKpgJDgOGlB7GE74c1P6jahlt+juTA181wy/iieczW03xwKED4aV6xbNkMW2dbPSMfzxRas7Sny0C94KiVr/tijNTrLfZVjdzUv8n6tqyBgxmMeMVGRciZ6e7BsVfZrIagbOO6Ry0TpX40c45YozOO376rCfpZOxjKxKTIrSvUWfD2iggx3/cWkVNWeQBx+k+CLhaYtf36Gmb2eDiz2yyYnHBynpGJCboOYWVBM8Eq2Aw/KYU+OegZ89JvZfwuuA3x1PE/Fj4CrxPMMGh+JY+t3JEmbtv/75v/fglpt/lqOB3Vob14iDj/+jgZ3BxA/IgZSU+W/2ojeJ/z+mbYACAK8b1BaAT4kFwkOALtYfFlMXstfGeJoxlaXty66SI5yFYmxKALJSRYUoGM3qunBpe5gU8Dmcop2CmdTEhHLizw8c/V65LNQJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGc1UGwwS3FuZlVVY0FvOG9SLzBkRkpKVWNaaXJQZUthblF4WmlRMDhqQ3BM?=
 =?utf-8?B?WFJBRnhaWGhhRGZ3VlE2NlNPc084dVVOM0JNLzVFM0p5ZUJHV2YvOHdLandn?=
 =?utf-8?B?N2RqU0ZsK3JsODlqWXN4MmdiR1RGRXR2ZFZHeUJzaXJZdnY0Z0pDMUdrNTJk?=
 =?utf-8?B?eVNjS1JEQmlmeGhqNnAxeGlVdDZxYUZKMTA3VXRSL1gyYi9nYVgvdCtUMGhS?=
 =?utf-8?B?T0JINjlDak9kZzFBZmo0Zk5KaVVlSmQwM1VPcEt4YjA5Z2tYQStsNFNDUU9V?=
 =?utf-8?B?eWZiYiswb2JRaXdrMkVMSlE2RHdsREJmV2pHSjg5dlBDUHRmTWsyeXFtaHhW?=
 =?utf-8?B?Z1hIdFRIWFAySjMxVWUwRS9VNkkyYURSb2dRdjFkaUhPZW10QkdoNUdPNTFm?=
 =?utf-8?B?ZVZIejkxSXF5RHpuM0dMRmgyVlhBQ0lDSWUwNCtzbGV2WVNyMU94M2pxaGR5?=
 =?utf-8?B?aG5HbDk3Sm0zWjdNNUtYMENtZ2Vqb1FNY3QxYmp6RlR5djgyNThRZ0dzZll1?=
 =?utf-8?B?dFhReVlXMXpCdVNzWFdXakpzRU11R1NudGxPQ1RjS1RNZGlyUGFyNHVTTTYr?=
 =?utf-8?B?RTEvbEJzTnZ4eTEyTjI1K3Q3ZkYvZm5PYlRiM0hqdWtyOFRzaDk1dURKdjJH?=
 =?utf-8?B?Vmk0Ty9tZFkxSTJDR3I3Z08wWG9SVWtEcG12R0VhOFlqTHNpV2psbVRuNXVi?=
 =?utf-8?B?MXEvbnQ3MGQ2bEducEZCSjhOWVdCaHBydEQ2NGhaSHNicEpXbmZFVTdTbjJ2?=
 =?utf-8?B?QlUrZm9nM2ROL3ZLL21FUmlRV1BzN0FmZ1FHbXhFMk1NZUxzajVKNGtVNjNQ?=
 =?utf-8?B?MXFSNDFLWFJwS0EwTzI4VXM5bjBNTktxUFZRQXNWbkNzYjg4NEl4WURrNEdp?=
 =?utf-8?B?bXp1UTVLREZjTklwZHNTZzZOUW1vZ0NFYTlNQmRmWnVoS3doTUlDMTFYaGt4?=
 =?utf-8?B?UUFqVVZPZldGcm5DMENZS21GbnNnK2d3S1BDR3lWb1dUNHRvVkRjUXdvRUcr?=
 =?utf-8?B?Sjk2VGd2VlF5YVorL0FlTTUzZktJb05Hb3JBSHdkTnZQZjRPZ0tmOXZPdVJQ?=
 =?utf-8?B?aFdpZS9ZbWgybzR2ckFtVUZiZkhBSHBIR1BweDNHLzhHMDU4RjNGclhJallr?=
 =?utf-8?B?RENTd0xZQldCMmpDRkFQNTdPcVNIWHZOZ1poWHZFengvVm8wZXY1VWViM3FD?=
 =?utf-8?B?VllObTlxYk1sR2ZZWHNnMHJuYlhoVFdIVkNkOStsc050cldvSHN4V1Fvd1Fw?=
 =?utf-8?B?Unh0K2lwZmJvRnBxVmZxakpOc1V0UkhJbDRPbDdxTGhBYUVUZWp2ZGpwVCtZ?=
 =?utf-8?B?RFV3UjVSOHA5T0xuUW51bDJPOHJrak42dXFmaXVna1plU0s2cUZoWEVMRFY3?=
 =?utf-8?B?elJkNEZYUUJzRlFXNmxYN1hiTUc0bTJ4bk4rdTRKL1hKU2pva3FGOVdQT2Fw?=
 =?utf-8?B?Ty80Ty9GR3ppaHg1MjV6VGl2Y1VpZkoxR3VpMk1PMmtUc3M0ay9IM3ZkL3Bv?=
 =?utf-8?B?VWV0WjN0dFVsdnBNTkFNVXl0Nk1QS2hwWTZrenRuc2dRUzBKNVRXUVB2eEZE?=
 =?utf-8?B?cEJpSVYxV2dIVTZNTXFwZjZERC83NzF1THN4NG95Um5TZVVZR3NUR21oNE9x?=
 =?utf-8?B?cU9BUnpLQXY3Ykp1QjA3dVhMMmhjRnBRcnRVeDlEM0Z6cDlnK0xDa21qSWsx?=
 =?utf-8?B?cEp1dXdFYnBqOGlWczdMTkxTRGJoL290Mzl2NGkzOUFoUFI5OW9oMWxTTkpi?=
 =?utf-8?B?a2FWNDJWUVRsUW5KZGxDZ2hlQWZwNWJUMkRwMW5ySnFrZmxHUmdCMTRDOEZ0?=
 =?utf-8?B?WDUyTkJXc2FkZ0p2T2pTUHhPT1I0a0VRSlFYRnJuTUh1SnNrMTVBTnR0VVlB?=
 =?utf-8?B?U1dYcHpHMFRTdE93UlU0b29ia0wraVJENXd6OW1CL3E5Q2JCY2ZoaWNUSm9P?=
 =?utf-8?B?YXREcVo3RXg5OHpsZFhSTG9xNGU3bGdPUnVGV3BwbXRIdHF0bU03MlloNnB1?=
 =?utf-8?B?c2t5aGVYQ0NEWU8wbmJVMjBOUzVyYldmOURkUHhNYzlPTm1SQXVsQ3oxSEx2?=
 =?utf-8?B?NjdDV2sxTlFEV2krUTlCeU1BN1JmejcxY0l5aVhMT1NxVU9NUHBXQld4OTdk?=
 =?utf-8?B?WTlLQjhkS3VwY2lIcFJERVpqdGZxV2M2eHBmSGRNVUVvV3JVVEpqbzdES2k4?=
 =?utf-8?B?WDF5b0hsdlV1YlpGU01jNnhWSzFuT2tPVFBaWFV0b0VwWThBS0txbUtqSERH?=
 =?utf-8?B?bFJzY09kbUJ2cjhoMjFPTGYySkpWdnlQaTd0elVuUEdMMHRuSXJSZ1VJM0RP?=
 =?utf-8?Q?sb6AG2iMz/oY9mkllJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1badcaff-a5e8-4a04-83e8-08dec06f8341
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:23:50.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lPs1d95zpWFDvrZXwdhQ2TQjVUZkmPQAM8D4K1neuoIdiA6miZN7Ae9wlBwrqI+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093



On 6/2/26 05:59, Rosen Penev wrote:
> Mechanical conversion of the ppc4xx-specific accessors to the generic
> portable helpers.
> 
> Allows enabling COMPILE_TEST for extra compile coverage.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/input/serio/Kconfig      |  2 +-
>   drivers/input/serio/xilinx_ps2.c | 24 ++++++++++++------------

I don't think that anybody is really using this driver and would be better to 
just remove it.
If not, no issue with that changes.

Thanks,
Michal
