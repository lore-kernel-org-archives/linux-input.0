Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810EB3A6407;
	Tue, 18 Aug 2026 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069225; cv=fail; b=HD7kkEOeeDZT7JjgvevI5jJ/+ZMyiunMDqxmuGhL6qlf0a1Gio9zx2covnFQIQZ/HVKxUeMq+7aZgrC97f76ZNIoIjm0iiWmZdAtPcf/wlgLR8ttBSXU2wcbHN0cnaIfgcrAu194moBcYKr+xx/tsH7T3gtb2sQrrLf7bfUOAj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069225; c=relaxed/simple;
	bh=d+u4Gr4PsAvHxpdG5IBUWozQsB/PlHlYNefpQpybtU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TbbL9ptxNwVnnn2+4a+JsYhCrSJtTbbmTMIKs8XDVWE00F9/CR9C6u4HJhMeRa/QZ4UoIv/o3o201L0bbd0hH16jjmv8nuvGnR6vCtelhRyWV0Me5D9IU73g2PsYEC7S9gptfS2DPXk10cuYJC3MjSYEGyd82LX9fqI3SzzgnSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QM0a6OdH; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QM0a6OdH"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDuVXa3681557;
	Tue, 18 Aug 2026 12:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1ouHu
	3+fmTD7qFvd5ITq+g8T6Wydl2EGLo9r1KXt7aE=; b=QM0a6OdHtloP6AOvDTPFJ
	zFldt5Dy1qSIxuMNK8s66Jb6/lUFuF6Z9I48nCw0Vxsl6SJ0A6IxdYRqD8se90/j
	shuRzEkhGTTP7XzKthKII4xxOKQkQ5LQUVprfJZtrXl5qF+ift84I9sYRC21K6/U
	w8fOf2w2BAXUfAHBr89d2auuvHAd5v0bsePB24pvlf7W9t9z/y+n0HSztacviXy2
	xfuR5lR384hHaQihaiJjgaYAQDsQiTJySGn4cxD/+ZL3YLm04i3kheCKBIqDk3AV
	t5vo2uaDeSuTZbmkPKxZOdycudfg4FtU/IWbUrWk/RYgPkP90apWvMPW0xmaJiTj
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g4mn5ag9x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:06:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFAgzm04bis7rudcfBkYea/wWIEytdm92oa81Ex1ctkuCAdYL7e9vgYF4ybj8d1H01sGtY6INxA9Sjc+tDFULKS8ZC8d8obg/AnP7zQl/BOZkcePLnNt6e5y8hjv1RiV3MYyYnaO5aHQc+n1U6J6WYegIa9BSr09i0VwM9AgAqxtJgRFZ177L3R5gsEU4Ud5LJavfKANVLcKT1IUzZqY1UY3dDLUry1+ZOZU3eCaETkQfo+WoC0ixYbFezTxHyXWkQWyYodNppAbEqqTFQu4AR7LXmypGFpLwHxxnP5BFBueUGwk09zAwNyH01CDbB4/3gQ3HzcyT5A3O43K2Udyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ouHu3+fmTD7qFvd5ITq+g8T6Wydl2EGLo9r1KXt7aE=;
 b=MEVTc8k4p75fu1jTvmyA9ZEVJv6JPBQ75/8RlG/4sxpzriTIAsSvQlnytD8TVol1/KVfXz9L25dzHtXecICoTWDi8ReyLwDU248c/0iczZePN+/2n3006LPaVqKJWDcnOMjePzB6kzYVOEvt20A8fK9fiBJeOSIuNzIi32KeaXQJ9vumU1KwGsA99lDuLaKwHUmZztJY/aTc1ZrAfpP0sPGqma9YBKtRI93BMqQM8iQ7D2Pk9/z2u0vdMcWlMfXHGKnG6KHnaeLcpWk1C6VsYdmEchoL/Uf/VXfM+y1WW0Ow8jnEjIvyYrZZkS74N68G6iKzwOeu6N6uzx7I4vcDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH4PR03MB7652.namprd03.prod.outlook.com (2603:10b6:610:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 16:06:50 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:06:50 +0000
Date: Tue, 18 Aug 2026 17:08:01 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Xiaolong Chen <xiaolong.chen@gmail.com>,
        Yuanbo Ye <yuan-bo.ye@motorola.com>, Tao Hu <taohu@motorola.com>,
        Dmitry Torokhov <dtor@mail.ru>, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: adp5588-keys - cache GPIO state before
 registering the gpiochip
Message-ID: <aoSDTjIbJmlS8CAA@nsa>
References: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>
X-ClientProxiedBy: MA3P292CA0052.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH4PR03MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd42773-5d64-4364-7ef5-08defd42b656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LaljeaieSU99+Q0dbzk8IkKNW4noxs9tE5BsXU2NcnL0Fq6ODgglAoo9bvwzd5fh/fQoDhnlO2wBMYMkXN1c+7brSeUfIJ9otbxR22t+dKQYv/L5DhRySMy4x6Vdo2q+mgnNifOVcmVDYQ+7bcjV/bmZ+pg0ZdmNMfB2qs31oJJd63anwV+1N44zO2owrkLGqdiXoOgNSe/4596fQBE/AxDwpYzSm6QZDfatvryd6zMLGNR8DZJ88hkuH/xyaEBtkzSC/fyNWQoE4NWvsR79vqRkP8ZTKmy3xSsAFPke+4VWuj1odXNq+iFIlu5Csei5bHCC3b7Wq9hih+zWKLeUVow5L9gNZ+pe13xQaq5wLu7iPQEhMKsAhe+/faLCL2jvFvK25zwll/02KBHK+6aHjrSLUkFcrat6ZRWf7opIy9R2Uxy4pV26aBdoPpX/TEM589vVQIIRbk+vNHtRULV3HIbucVUEq+oZXIJfHd0G4g6PMKkD3rkr6O3Vqk7mBH+wVJWZKoe8FkRVetwI/ttQP1PFN2KRL+/bnUwkJroJoiKQ43EqQZ2rbAKYmAs6XL9XRGgbKMgOXqSVrrCQqxiP4QOA54qWSGunlHigpaigptIDQyaC2e7AeF/yIFMATW4CR+D8zKMtgHDCcomTjUPRkZKsBSHtPB78vGDt7mQzUpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXJBSjF4dmlvZkVFdmplT01nQWMrMjhrd1hGQWZrS1I1V2l1eklONnRGQWxK?=
 =?utf-8?B?R054MWM2QzBWaGRDa09sK0dNWEJWU05MU3MreWVjUTgzeXppS3VxUTI2Znpi?=
 =?utf-8?B?Vk5NcXd2SzZDYzZ0V0poNkZndlBDUm56OVBMWHdSZmJIbkJzVHlkOENPMlZ1?=
 =?utf-8?B?U3kvdllxNjJHTml5anc0RzRhV0xDaFAvNGVSaVFkM3VTY0I4MU5qdXJ6Rjcr?=
 =?utf-8?B?Mm5mVkErOHNrdWMrK1ZmTE5FZmY0M2tkUlAwcnNPKzlUYlc0VmVXVm9oWmQ1?=
 =?utf-8?B?YU5VTVFZUzVHVWd2bmYzaExMbnU5Q1NkL3l1aEowRytGVlZkWGMreVJLSHND?=
 =?utf-8?B?ZlZPRit4VzZwaEh3blJicCszeFV4QWUyUjNEY1Z4WkYrcXdBVlBkWnlleWRt?=
 =?utf-8?B?cU1YaGRva3kwY3ZUUTMrc043T1VMOUVXMWdUblcwWFh1VVdXcHdMOXV1VmlR?=
 =?utf-8?B?eFY1TDU1aUpNa3dleXNrRG1iQWhJMjYvUDFtSkNRWndRY1VVOEVUempzR21t?=
 =?utf-8?B?VThCclBEODh6Z284cTU0VERRZ1pBSVg1ZHduQk51Rnl2K3kzMlhKUE0wRkRv?=
 =?utf-8?B?dUdlaXlUMUJPVlBQQk85bG1lQXYyd1A4N1FLSnBOMzhQYXRLZjZmYk0xNVBE?=
 =?utf-8?B?OFVHUmZWVmhNM1ExbzQzZ3dldTBNUXBJQmhOdEsvbVduekRRWmorQXh2NEh6?=
 =?utf-8?B?MlBSM1lWN1phZWZqdEk4ak1yUGVmaGkycnJacjZsQkdNcHhjUXhWSHdqL25k?=
 =?utf-8?B?ZmZWK0x5aGZKN2c5RzR5QVlEOFBVMWhsWTV3Q2swZWFYNEZURitaRExxckdz?=
 =?utf-8?B?Q1pJb0lpUzc5aExidEYyMm45a2dYMkJ6NUFETVQzSTRFTHBzTEk2Y0JJRnY0?=
 =?utf-8?B?cWxYVEhhdnh2VGZSSllLZzdpeFl1WVJoUG1LbGdONithWkVaV2J3b3B0OHV2?=
 =?utf-8?B?QTFxczVsR3R5SUZZeGxpY1hXL1JoVHJaQ2VpTHR0QWxtVmxOVXJ3b1AwaTdO?=
 =?utf-8?B?cSsrb2lMSVRsd1g1QzVoNHJrU0xyczk0RkpFalRlRjJCVVk3NVpjYXhZdnYv?=
 =?utf-8?B?Qi9hNE5NOHQzWTFpL3ZXNkVsZG9yVS9tTVBhbTVLZVJFQjZwaWxCWlV1TWtm?=
 =?utf-8?B?bDdxOVMxYUt2MTFQa0xKNjU4bjVucEgzVnRPRUxUVlMrcDB3NUdhWVZYa1R3?=
 =?utf-8?B?ZWhIejlJYk9mdmx3VzQ2OVFkUUhQM2wyd0VGTFliR3d5Sk9qNHRzZXQ1YlZ0?=
 =?utf-8?B?WnlvdGJhLzZ0WGQ1WUNTb2F6QjUyWGQzNWpTMURVdVgwMllTS1pRUDdES2JI?=
 =?utf-8?B?RCtpMi8yaE9Yb1pNaEhmNC9CUmF6eHNzZlZwOTN4VkhMeWYvTExIZW1GaldZ?=
 =?utf-8?B?Uk5SM0UzbGF0SVVsdHRVeDI5STZzV3huZmVxWkg4UjFzWVQ4RnhkWFk2aHpF?=
 =?utf-8?B?SEw0QU9tODVyNlpKUmp6Z2Rld2lRcFJNa2JJNWJCaGROZHpRMTJ4ZVdqMCtO?=
 =?utf-8?B?M0Z6QzhwejBjeTFRcElnMEpYQnd4NlZPZm0zSmtUYlZvazVESXk4VGszdjIw?=
 =?utf-8?B?TU4rakNpeHQxUFVIZFIxdW43dTZsVVZNeFg4UFlRcXl6N3dkN1RzbzRlQ1JG?=
 =?utf-8?B?OGFSYUt5a2lQL0FsVEhBamVRRTV2dDBiSmJ1MUgzK1oxMldkUUtBWUIrVm10?=
 =?utf-8?B?M1BOZ1RSS2V1Z0RGVy8xWG5YQS9HUjJKOXdmTU52UkE5S2E5eTUvdjl1d2I0?=
 =?utf-8?B?dllLeFBVQTFQZ0VnODQ1c2dHOElhd1U2QUwxSDd4Y0tZd3FRdE1IcDJjN2Yx?=
 =?utf-8?B?cUdHUFJjaFFJMTN0ZHhqNUtLSDd4TEhhVld0cVhXT0pTb1d5VW9kYk5WRFZo?=
 =?utf-8?B?WTdUVVFUellJZStEUXRFU1Y3N3d2VU1tY1VNVEhGYi9XTnFuNytnZ1RhMUlW?=
 =?utf-8?B?c2tZUmJKRTI0MG0rQ1JVLzNmUEd1Vy81bXh4d1p0UWg4ZmQvSkFZdW9nd0ps?=
 =?utf-8?B?RjlLRE9XTjB0ZXNOYW5lelBwRlZ6dDI3bi9OSVVXcE9ibWVtWnFqOUVHYzBC?=
 =?utf-8?B?RWJDakdhZEZYNjlhaUdCYjA4bCtuMVFGcmh1ZXRMR3NYMERTV0hSSm84YXU1?=
 =?utf-8?B?TEZqQmZxUk9FREE0ZFZTa3RCdXMwWHBSVEh3N244NUVyRUlodHR5cVkvVUw3?=
 =?utf-8?B?VTArQzlFYXRPeHlYVDVVR3RKeUxKaE5lelVWRm9ZRVRxbUl2WDRKVllzQVpk?=
 =?utf-8?B?VHN2dGRTVXlMaHpwb0NybUUrSEE0YmtRRXBYMG1DOHdDYVQ0QmQ3QVJYRU9G?=
 =?utf-8?B?WE9HNmdmZEg4ZzRESGxXdWxObkRpRVJWdGhDVVhTclFESUt1Tm9oZz09?=
X-Exchange-RoutingPolicyChecked:
	L46cZ1JGWuFBb/fwfek7NHKuc13OYxYJdyraAuKh/wZ008siEj+GaCCANYl6ue6mhOKyx0MzgfjwMqDV/Ri5/ccXl3dOmgJIIfEGdCJbYksdXQhP5cIBWK0S2sjwVsMMYrTGSmadSu9VuvpfWZcVgEQC5cykjhW5c/jEIqRa3dpzw+NwtpZVa7B+KqNtU+0OU5UaGsKQ9hXRzq5kgRKpxz4NHE6Sxx8y46Ij6nR/KRCFBlT22R5i//t7HB1l1LGsyU6SheIUuOZ+wOQfQnz4EmQX5xCL/XK5aD+/PbLK5/eTUW4X/f6ih2kECzfMlJ+0iak9Mz/mkPEGHwyZAcfoaw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd42773-5d64-4364-7ef5-08defd42b656
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:06:50.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI6cV00X23UEDcV2aV1e4TG3cv0gvorczB7usEwFYxIHRLuObPg28K3xgl63jpRfAFwSLE+8GQXZHujigm1qLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7652
X-Proofpoint-GUID: hThmYzkCFPuEca46YmZMKH88W1g4h2SX
X-Authority-Analysis: v=2.4 cv=Lc0MLDfi c=1 sm=1 tr=0 ts=6a84831d cx=c_pps
 a=N6h9FcIU3O7PIE8+NyeJww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=4ypOXKjq6s9te1ZrbMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX7AESvrWVuMFG
 gGqzEO+/WFXOd2bDjY1vgHMgf4/TyNn9NMm47KHU4laBLECMWqpTjG39frwQs1CAwGq1HdO5Jth
 jETo4+oHAbs5hbyDWCqV6G0ktn2pEaKYl+nc7QqCMaIOtI1h+mJg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX3tZAaE0XofvE
 KePpKL+HI++rHrtBENlkWZtxlacgqXA390CtzuINuu1Kgb8oO5eNHtOTrEpV/d/Nm1iAHQ09Dop
 c9jFgb6mnjumLi03lDBsTiqr7MdK7yZu2Ad+SVcTDsMpaAlmwMTYmpDXVj04jeCUTQHPQOlqK+j
 vBwTliySKCZGUT/ZyfWaVZAEXSsXDn60Kf1jLuKznaOMus2ugK4iTnoxIfB9mcQX4WePyzx+6t/
 KfndmHBN2k9ja/NRNlw1lv5YRvfiu0eFYTJmc4w27Gdx/306t3peFhZEaqrQ0grwlXtHFbyGnDW
 4I0cqwj6t9hvJTUQYZiOTDdtPlmRqn4E5hWxgrBn2/Q1oqMeiXIH47w/nKgmcegYLp+HVN98mO0
 EvK/LucukaGmpwzuBPiu+s/WSKk/oyUS1kXyDjp9X3DELwRNbSr288VMRS/FE82Kg1UqlgpJMpx
 9llym5GcluQprajdxvg==
X-Proofpoint-ORIG-GUID: hThmYzkCFPuEca46YmZMKH88W1g4h2SX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

On Tue, Aug 18, 2026 at 06:00:02PM +0200, Alvin Šipraga wrote:
> So as not to clobber any pre-programmed GPIO state in the execution
> of its gpiochip ops, the driver caches things during probe time.
> However, since those ops can be called both during and immediately after
> the call to devm_gpiochip_add_data(), it is imperative that things are
> cached before that. That's not the case right now, so reorder the two
> steps to prevent any clobbering.
> 
> In a conrete example which motivated this change, a bootloader was
> preconfiguring an important GPIO output to HIGH before booting the
> kernel. Linux would then inadvertently set that output to LOW while
> configuring a GPIO hog on a discrete GPIO line within the same 8-bit
> bank (because the cached value was 0=LOW).
> 
> Fixes: ba9f507a1bea ("Input: adp5588-keys - export unused GPIO pins")
> Signed-off-by: Alvin Šipraga <alvin.sipraga@analog.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/input/keyboard/adp5588-keys.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
> index 40371f5bd9ba..4f0ddff5baba 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -446,12 +446,6 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
>  
>  	mutex_init(&kpad->gpio_lock);
>  
> -	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
> -	if (error) {
> -		dev_err(dev, "gpiochip_add failed: %d\n", error);
> -		return error;
> -	}
> -
>  	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
>  		kpad->dat_out[i] = adp5588_read(kpad->client,
>  						GPIO_DAT_OUT1 + i);
> @@ -459,6 +453,12 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
>  		kpad->pull_dis[i] = adp5588_read(kpad->client, GPIO_PULL1 + i);
>  	}
>  
> +	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
> +	if (error) {
> +		dev_err(dev, "gpiochip_add failed: %d\n", error);
> +		return error;
> +	}
> +
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 44f3468a0aef1aabdad551898ab7cfa2a9d20e99
> change-id: 20260818-adp5588-gpio-cache-23fb8d0a3190
> 
> Best regards,
> --  
> Alvin Šipraga <alvin.sipraga@analog.com>
> 
