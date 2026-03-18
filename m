Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7FF3B7B76;
	Wed, 18 Mar 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851656; cv=fail; b=ppf3CBU1rHhV8jbcK3j6JylqrDU6SAEY5zuxgYwT2z6RSFo2N4WJQ41f1Kps+Uj2fsxC0+aB/WTDXbDndyuThV+r+IMKCLWn3cgpHlp8Zy6kc4AVt5G1EbX+71Awp+kqHGQ474UYHuYmgYG/aqXaYx5c3XcV+U9rhy1W9fRTfdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851656; c=relaxed/simple;
	bh=S1wvjdletnPAwokJH3CJPH4xNP7P/wRHgZXsKToALZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o4ghUQbA1VlTEfGGKN6FP/2gnjoaj/hG/yJnV6b0t7cQf7zyHprTLulCsiLm3oJ0X1EtIabHK4SVzxNAMyrsKA8FAaub0J/kCKlFeu41nHMmZRd8g1qpuWF2cHHOa6/znCEq8Q1laZ4+6kyLfO0qI7jEsBAgOL0nvoYORQodut0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jzN39Guf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j16fc3sh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jzN39Guf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j16fc3sh"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IFDuUD1777892;
	Wed, 18 Mar 2026 16:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dTCkLGfOIp66/W/DqWCoRukVI6hJCjy5iygcu/03zj4=; b=
	jzN39Guf73+OneE4PjzuztzmLZxKWjPbHF6EnaN0u3qDTQbQSAU1Dx5nq49GAjhR
	gcLOpPcBcu1dNQ5CbVKcXfQI6WxEPFLPPAys0UmASccZjt53rjcNgh2CAv0NYIbM
	Bx/CL02cB5EW9ZwBpakrawkd2sxrUXvkv7D+Radxx4drakB2WvXoXQ7p8V9gUtRm
	meVdG9KKg5mo9O8jGUCPMTd7+tfO6Byg1rgIaylHvMG6bp8PnKvEvhCRQyqvcZ0D
	GVOfUVKDINLoRAOb7ruoPOHkbNDy/yi2ndUT8vU74HID8tnmqL5v3PQAS/3fhrDD
	5AIJ6m7o9p6nFgN7jPmjWw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8ehnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 16:34:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62IEwZE4003369;
	Wed, 18 Mar 2026 16:34:08 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4buvp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 16:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4n2ckgF8xvM/3paATCLPZgbSvw6MdMNm1RsgiipLDVnJN3SNhzqm8NmKkgRVHtRyN3tvpk3XQbhzlw3gZkS3saAA/iJfSqj6jAUe7r1Od4xyY554c4UqVWZxRfg/mabWk1fQVmVJjD509YBvuila/deSioyW9Fb6t/6Yt5YYlolOadTs9eNUZ5dSJgZeT7EQMjkp10GU5be6bILQNA/FoASJF2QqL3uwB2HrC1lHg0UnDlpFXhqeu9EkWecH9B0hHkVwvQmKpyRkdMPjE1DYFKS4tOaZVIhUUX0vCAnuHwoJNxLnvu6e5GIqFVN5Aa/ZKpA0rNb+4FtE7BP4LyJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTCkLGfOIp66/W/DqWCoRukVI6hJCjy5iygcu/03zj4=;
 b=jLqjb6JYVanm6llWoqud1A406vxb8AaU8KD042XVbnwxI58g4VSzTu625qB32xtM/0sNlg6lQwf2fql5kM8h/CkBR0XX/UXuG42vr7Ikb4NPKbt5/ewyrZOFP0lgBnmK5wOQWIfDWgjG0aqYnq6VIbPK3769dZKVlJxrhOoRHD7yHxpvfdgMlC3hH14f7e3ob7+ruxLYtT5fLqIc4NaowYAUT55fUPiQs9Xlm6dyPEaXqVqGz+cy32zttzP3Aex2lDnAAWSF5AAwx9OVPCrih/IbjP3OiPwsO9Umgb5tCxZsSPD9sqBZXkYWCfo763Ll4eUYOjNqgSaJQ7rcpf24PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTCkLGfOIp66/W/DqWCoRukVI6hJCjy5iygcu/03zj4=;
 b=j16fc3shZlvWXnvXEMM5Zp2ULezgU+Qd8HvNu2JesrlWjb6CVVALa4zWyUD5/cTxPySSegPJWKxGkSuFVxhnF9TPpDPkkDeIXoSTlLHF8TGQ9+zrhSCe/3HQsKX0F5CdFUvPwOiNY5DGD7NBBE9+vabWf0arobYkAGcmEai29pg=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 16:34:03 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 16:34:03 +0000
Message-ID: <8eb5a587-13a8-43d7-9c09-7112f003b0b1@oracle.com>
Date: Wed, 18 Mar 2026 12:34:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: sentelic: fix comment typo
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316181200.146681-1-joseph.salisbury@oracle.com>
 <e35b4f27-53c1-41c2-a321-42a34ade9839@oracle.com>
 <abo7FVLq3qUzxkee@google.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <abo7FVLq3qUzxkee@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0050.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::11) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 601356d7-3112-4f33-864c-08de850c2a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	p7frbBJvhmQFFeRE9fD4EkG+5f2DWNLy+YKiOf/ztUL9ROIrziS6qCzEoBPGM0Q/Y7yA0BqShiCixR7uxsk8bkBg1Bu/gsDk3wFEtn9m0+U15ZRuMqibZpm20jTSywUJW8TS4aqCHNzQtUQ7Y3qBcqgmx5CfOeUEiZCM6datFXmSULj19J1MVsFVJrO/6fOynkQ0vNMy/g+U4egPwJTSqsTzbLGCF/vjKPf/GtDl0Mc9RqBtVtl7XRjDcmRSe5IHyKoCPJp5V3AKzjbKTxPdBXSCd5IQMw6l0m7iftMKUCiiZeggVLzZj/2rkzGtfwFpfNyBuMumpKh9a7ikaKQBh6SnPgl1zfRXEZJlsU9zhcpTw0zwezZBlK1HirzxkXoymK4bdtlMExDpMd5tyOPBL8tdCff7CECvm6KrYaDVs0iBdFpZV6OHXwKrHdnzje8lcR9KbIkbmmrH7X7w3QH2Z13FyhCitOdbfw5ps5ByxjYXoT6LOFXZ/SOOU3DP6I6gaTWfXI0AV0JkPo3nZkw9YMr7IAR3OgGW35XPsDscZJFk39jmSEEYK8Abra1pDl69kvNKKxfG9eDPGoy2FubJnqk0NZmoGMm4Pe1LNpqgHHGojDBldgmUiNdEAoo/KfsR9vgH038sL22QPHQ7FjsgatyMNk85l1GsZifATsjSczf6TbRv5jbMsXaF0Q/KkDxuSXNQkbBp5XOmpeX8udz1Y3KmryKFBCNkRnmjlzWs/Pg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTlQVDRCMTVqWU9OUW1RcXYzeTNHVDVaVVNYMExUYU41RzhSUTA4OWhaNEVX?=
 =?utf-8?B?d3VZT1g1dTVwUHc2WmFBNnNadzNrY1hkdWN4dWcwY2tvRU5tR09FN0JEb1J1?=
 =?utf-8?B?T3ZDQndlaGJ4eWMzSUZjME80Q1RYVXBSTGhNTTlENHlRamRVdVFVd25VeE5G?=
 =?utf-8?B?ZkdSbk53M1VLeVROcVRteHc0b3BsRTlCdW1vSnEzUjFrMmx5M1d2RnFtMUJ5?=
 =?utf-8?B?d29qYkpzV1hqWnhEbWpRaXcvMDJDbEhNcjBIWVY1ZEdlMzR3Y3cySnlnVG1k?=
 =?utf-8?B?RmhzUzRaaE5ZQjZodm5Gbkd2VzVNVkpnN1loclJUSHk2K0VnYmFrYmNyTm8r?=
 =?utf-8?B?N0podEF1bERUQlUvaWwveUFGd0lJSzRTWlFLcFNXSi9oWDVNS2hDNXFmV2xu?=
 =?utf-8?B?TEtTczI1bDlLdXBGNFpqT2NHV2dzQ2lZTFcrT1V4NnFGNkVxNzU4bXpNbmxH?=
 =?utf-8?B?bW9LWVBidXJrL2czYUwxRzBRTkltWDBpcE1jejlhZWxiaTgvNHhraU8zLys0?=
 =?utf-8?B?WkhRTVZwbGxpL1BmbmRUWlVGSVVtSERUWGk3SVc2L2FFOENIVUFGZDZkZzZQ?=
 =?utf-8?B?T1dZZm9EcVE0OXJhaVkvZFFUQzJWb09ldDBySk4rSjFhWmlGSHRFejJVK1lq?=
 =?utf-8?B?Nk5LNWxDbzdHaVVJOXVGcmJDajZ3UllYcytTeDFuWnZieVpESkNwbThRTDQ3?=
 =?utf-8?B?dXhCUWkxeTNBUFh4LzJ0M0pKOVlnVGV6ZTYyNWhIS3VoU0hPeFF5aWorbm82?=
 =?utf-8?B?YXpyWVIvUVMwN0kvNXFKTVFQQ3djcm5LaFlwc0xDWHdaTzZyOWFwbjlsZnhq?=
 =?utf-8?B?dzluT2lrZFBpRFJPQi9NQnBMK3RzSGxBbFU4NEgyWFo0dTdkOGUzWUZaZUxC?=
 =?utf-8?B?ZTcxbm5UMmlxSFRaVXVWblk0MjlFV1Q2bWFEVkZkNFlwTG9QODMyOFRYNGtz?=
 =?utf-8?B?TmhjZGRrby9hREE3WXZWTFdWdE1kd2hZZkJrRlV5MDhPZ041aitwSW83bWwr?=
 =?utf-8?B?cjVGNTNZbW01STA3RVhKODVYbng2eUw0YkN5SUY1VFRZaW9oNUZqZ2ZVbHE1?=
 =?utf-8?B?TmtFNW1heGZhUTBWMEdzQitQM1hva3NESjhpcVgrY2RnZmZGSU5yMXR3cUto?=
 =?utf-8?B?RGJudi9UQy9BMFVzTlgrT2VQa3E3bW5NN09QRjYzeU9PNkhMK3NOMktZWTJp?=
 =?utf-8?B?MlFkOWI0VFBKa3JuRmpBaFdsdnY0RlZROVdTeUZOQThDZ1A3UzZpZWYxR1hG?=
 =?utf-8?B?Z1NROERyMm84bFNGMkorVVFYdW9mTFdjTHNoSkl1cUY4dEhGbUxDL25PVU5h?=
 =?utf-8?B?UXpyUXAyVkFMbk9HVXh5TGgyQlV0czBVcUFlT1B3NlFaUnZLMHVhWGZrRjdK?=
 =?utf-8?B?K2k1eUJwMG4vM01OdU1kSXJac3BhbkJRY1N3R2lzSjZEVTdNSktpb2l6TkI4?=
 =?utf-8?B?OEs1TktLN3AzWXhVb2dEOUNHOWp6dFlZZGlkc3d4cmRFaG1HUUY1L1JjbEtY?=
 =?utf-8?B?YU5IcSsrOWJWMyttWlVPekZOUmNJYXQ5YW5KRU9vREE4SWtqV3dEM0RIRDQw?=
 =?utf-8?B?aHB6K01MRVQ4MDlZQkpMeGo5NWFHbHFISzRESU5FWnVWb3JBR3hRd3JQZXhP?=
 =?utf-8?B?U05GZUFxSjdScUZaZTZKZ0RuZHMrMHp3SEFROWtUcEtuRndXR1A5MkVyUTNN?=
 =?utf-8?B?RXd2RUlXL3NrajVpV2cxVUYrR21GRXl3eTJCcitEZVl4dVBJODIzZGY2NUFo?=
 =?utf-8?B?NFpMV0duMWtSR2psRm5KajV1VEtDeUgvM1A4TWQ1WllWSmxkRmYyeHVoTk5H?=
 =?utf-8?B?SDIrYmU1K1V1Um0wVU1MZnE3bnVXNzJ3Qm9FdEdrZytuV1FmUUFQZXFFdm5P?=
 =?utf-8?B?dzN4VHJEY3lVVlJpbkc0aW85Z3hxdGJnYWpHRnVleTVmRytuZ1RqZ2toV3BC?=
 =?utf-8?B?UTRWYlVXNDg5cStvZmpqVHNBUHdZTm1VVmtMZS9TZmJDOWN3Y1gyZi95ck1v?=
 =?utf-8?B?NXZsN3V1emVtbStXYzFvcmRrZWFrcUJFWi9nNjI4WktDNVhTWXN2Ym00ak9s?=
 =?utf-8?B?MWp6Y3hpdWVVemlUWWQ2Sk1UUkNsMmhhSElISFJPWDZoNnVMenA2SnpSMmto?=
 =?utf-8?B?TkJLdVhtdWlnOG4vWFRJZURCczFyTVExRWVYc2NwUkhSbUZOaUR3S2Z6d1ht?=
 =?utf-8?B?cU9WLzYya0s0V2o0ckxXYys5cDgrNmlnNUNodWVDeEZST05FZm90OE9iWS80?=
 =?utf-8?B?aGNJUWlrVEpoaHpDQUpOTm95bTFwS2lVY2JVVkdTT0ZKZEZFNWFNaGVjRlNU?=
 =?utf-8?B?bGs2TDZKTkYvQ3RYZ2dwdVN6UEFQTnF6M3NOUVZQUGlKTlh3dmd5UkZld1dJ?=
 =?utf-8?Q?4+Uag8n3SyI0fPac=3D?=
X-Exchange-RoutingPolicyChecked:
	LnpPTP71/WwvRFq9KacrSLn1i3pjvTo+FRFMTgkdi5hJGdTYxIKir7C74Ulp8dtT2nYg+0ID8lPkbOY5a+6lY7Y9aRKCkmPF6UXq86TKZjvbpAiORDUimQ6DbRTVAEf27xnrOsCBzT8sYIbRYyqqMNTt9mpQ1sHSUloX2w1x5uTiEv7y4RAC+su4jfhNbbNMkN7yZFUjpKdPxWEvkfvsp7EdIFRyXU88rFUi47Nhm171oaQziMGZS62D4iUSBTsM5ZG6OWaYhM0VaLErJxhDJXDpUkKSP3ZB0RuknkAEzMcOdTo600OGLguL/5qOhYiviYnXlX00M3nq5RzDo4G48Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3FNZk2EdQ5llRv/N3PpfRTxDfgfcbY7ax/mw1ocBEI+P4pLScO5F7WavzfICeMMHW/j0CwbpaBoY1fxOTuAPS1mYMRJYz9eli1OE0Ba8z46DSehpWXhuqunpiyZRUZwr/tteRyjmuYiqMfZY7za4XJdbKeyEPtQ/T1qM04Dc1QMrL7J9sCJOWmrizxuFR7HFpdUKCApg4I3rvHWPVsJ070maefQnm9StRVdK5rAd/YDWsxj5mGpWWLre5RrThBzavB69Q0jM7Ca+H8mTiw8iFLRMOx7XbCWQmJleW+29IyATLAuaIMSuQE2kU7TUqnmPqCLDAh+74gRKUBdZj3+++sYK0aS/y6J8PcwDE7N9aTzdx6cbJhzdEtbsVH1/AcByUUyMStIxVv8Q+8vJY5CQp7FMVebOMLqxu5BJ4ynbxq0nlEraXQeGAM5+SLb8KpQPAm/oYH8YfMeJK6iXTH/vJ/AICR+HAIB6RBqNojfFDnBbZPRei1fBpfP/c6x2lRGgL1cqoodl5nYQl5Z0+7XP0Z96+v/ZJb/yRaOz5WgKJ9K+WTcO6/B29X+fTN/ajXBU5V6K3uEkeLTy4OWvKNCRkkCGrpCegNZdt+jUIz/3xY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601356d7-3112-4f33-864c-08de850c2a57
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 16:34:03.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5sBHoEoJ1J3c0J1VcZ7dVSf2mVxGbBo9tX5I0vJ9ss6U1UAFoaJdwYiR7M+XLYaRrs6ah1oQR+a15LJGtj3NeYBqUsGmnbV+qYf1T4SGi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603180141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE0MSBTYWx0ZWRfX5saL45G75fVG
 VFp7VI5H0kDlC5WvVsNgKF2aBog+HKX1yFurI0hh370WQ161X9WD9Qst/DMxEN7nzFDwX7kI39R
 AMFOILCC8V/nw0jMYOhinrAFeZihF9EBmA54iAllpQC/fLb5nASm76g+0rXm3bw/AF8KJnMTtPU
 dJCESEDRnwWeQm/78zNKMCCtPcEhAhxUyr1e04GeO35gIw32midsqT9c7Q72V9IhMyifilHYZXn
 Ahs9Ka7fCT86hap63UbzgZdOhv5gCvN1eykSllLwLwTnNez8WHBmpWOyxYoVnUWipS9Yb8MXJfi
 cB5xzXvY17v/nqts+WiJZpfMO/MrhnXW9KLuGPoLH7KiMocxflQCLAWhaJ50S7HP8IYfPSnlkbA
 QF1P5AM/hufdCVwXMDGAICcdTe+oJe9tZvNnFsT7jzKnI43PXas3R3gSEVie4IBW5eXwK5KsjaW
 VHm0LEqtynrv/+VrXfg==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bad400 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=sfsyJ-xnvCsKyngn9QsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j3qLfss1RU_OI7xjoO_I9q2N5QQL3zOP
X-Proofpoint-ORIG-GUID: j3qLfss1RU_OI7xjoO_I9q2N5QQL3zOP



On 3/18/26 1:43 AM, Dmitry Torokhov wrote:
> Hi Joseph,
>
> On Mon, Mar 16, 2026 at 07:48:31PM -0400, Joseph Salisbury wrote:
>>
>> On 3/16/26 2:12 PM, Joseph Salisbury wrote:
>>> The file contains a spelling error in a source comment (formating).
>>>
>>> Typos in comments reduce readability and make text searches less reliable
>>> for developers and maintainers.
>>>
>>> Replace 'formating' with 'formatting' in the affected comment. This is a
>>> comment-only cleanup and does not change behavior.
>>>
>>> Fixes: fc69f4a6af49 ("Input: add new driver for Sentelic Finger Sensing Pad")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
>>> ---
>>>    drivers/input/mouse/sentelic.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
>>> index 02cac0e7ad63..9ba3631e3d0f 100644
>>> --- a/drivers/input/mouse/sentelic.h
>>> +++ b/drivers/input/mouse/sentelic.h
>>> @@ -60,7 +60,7 @@
>>>    #define	FSP_REG_SN1		(0x41)
>>>    #define	FSP_REG_SN2		(0x42)
>>> -/* Finger-sensing Pad packet formating related definitions */
>>> +/* Finger-sensing Pad packet formatting related definitions */
>>>    /* absolute packet type */
>>>    #define	FSP_PKT_TYPE_NORMAL	(0x00)
>> I inadvertently added Fixes: and Cc: stable tags.  If possible, please
>> remove them as they are not appropriate for fixes to misspellings in code
>> comments.  If it's not possible to remove them, I can send a v2.
>>
> Sorry I did not receive the original patch but even with the typo fixed
> this comment needs more work to improve readability.
>
> Thanks.
>
Thanks for the feedback, Dmitry!

Would you like just improved readability for that line, or would you 
like me to add some additional info on the definitions?

How about something like this:

-/* Finger-sensing Pad packet formating related definitions */
+/* Finger Sensing Pad packet format definitions.
+ * Define packet types and bit fields used to decode device reports.
+ */

If that looks good, I'll send a v2.
