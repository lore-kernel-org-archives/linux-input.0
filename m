Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E247CA8F;
	Fri,  2 Oct 2026 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935580; cv=fail; b=XMKrkZtm22VgTYNGw1kK404UQXm53tKE9hcGxwy+6TsZOUZXHi9aLkIcMJ3VUp3+tt80zRO1hnCOjcXH5f7LD7UCS4gnjbpnZXLQwIFM0Bbap4fau9VjlTaVvELeVVe/y9FAQzceDSovvd/gCOyCGhTgKo8iEUdo370rm0CheUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935580; c=relaxed/simple;
	bh=cM1w7Mti1o/T2WxqN09+8f9LpWBtrC/gxAzQ1bvhaQI=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jIiPlIEhnw10WqtPIkYY95A+JIlYaTlsLvTMtrC3uxWse9h+M8HAwudh0R+HqE98zg9eeq5BxthTnCrLqCxKFfgpfrrJUS3c+uwuTPGlRE4l5HXWP8AfvzRF965geBqi7Y3ohNLE3Z5N4QZkKvOPS4vxszn2sW6gYt+0unmnCJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aPMFJHKZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RKdwr9Ct; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aPMFJHKZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RKdwr9Ct"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6923GoEf772614;
	Fri, 2 Oct 2026 10:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LBDAQ0TrS97tznKY2KfaOpMGb+4JStsPRGjpJJNJUO0=; b=
	aPMFJHKZrzihVQsWA2v8osQQnK9SXYxMVVPHXbh+srJRz7LtTQ0IMdNvcb8zee/t
	0BF9nems3zhIj5a0/fjHl+DAlnMn8PVoVhJB8BQ1Dmvp5PiRcMERxbUpNjxbbjb6
	yxlRvjXQgrCckC8NejoM8rZQyx171ZrDWqK0tsPDf9G+Z6XLg73uArr+0Z7jZUXo
	iFvfWru8OZ+jZ0Qk0sZ8fCv86LKZTYr0c/N+TXj6OmYqN/cMeGAIeC2dYZtqdZ74
	NVLXNwn3J+6vVh9A7EBxA39vlIx313Z0EZLodKmDZR8kELWbvllWuqjcr90xLJlk
	N5b8KD23c+mR3iUZPYNbZw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx6ksbvh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 10:05:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692A52v3034726;
	Fri, 2 Oct 2026 10:05:31 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gfx76e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 02 Oct 2026 10:05:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivMO5rAm/EZOc5gD1drs0Q+lR4ShDneq+PmFPUep6jVyjJBUHQg52iXwHJ7q9vtujzVxnPUxEUHp9ZHqmomlMV0Y1Z7LSkRy2TdkFFu4n9Nocwtf87NX4lLCxx98qTLhjy1ckESg/za4D26kRM8U1uTGrpZ7Q3yPYG+JADerzppDAbG4Jhb/veBvFWNqOBQLqR8JgqwOz9gmOQgGP9BZ39rOdNCcqWczujYirnU1BKA4CJmZWHeAk0vMielwXbP9uxBHtV+hiE1Tpf/po6nkh06d3wGSbAq2Ztx2OXvgMerFLX+Ijinq7RxfmCHmRGK26gqyF278yasRTo9XmQ6Y7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBDAQ0TrS97tznKY2KfaOpMGb+4JStsPRGjpJJNJUO0=;
 b=tPhbzr+IG4LhTIwiUXjdK1MX84EyWLbuFiIhjU9BDcyuTlh18jpcYS3j2E/XnM2glJQ2Spbh45i81hcvnbMCOhblCky4KMKmcp2i8IRN556tPCV7oI2zDhum3zUgqGVsBCzKcbEb+zdgJPLgZzb+u3OAfkL9AfdVkypsPqEOVhBVC79WM3i+3PedPwEYD+a6PFemlkDytwjlDIK4PUga45oVceb0G0bxpy71MLt8mhwgLY2M9w+RDCktybGYk/1y5pr34mYzI9XGLSEU1WnmcpGmxc/ux+xdJbpSoo20VNsR9Ah3sdBctpoc8MhVymQ0LsxYtDhsGPsLdH2oj/AnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBDAQ0TrS97tznKY2KfaOpMGb+4JStsPRGjpJJNJUO0=;
 b=RKdwr9Ct/UPaE2ZgbzEEp9lpZn+VZKmYx7L6YhI6zFkSGbkZU6xRJNPqexCXxu0StgpFlS7j+7dO5CfgGAMZ4Gi8sHowX6hBVms5L38sa5i+QeGqRmPe/+wI4xwNmcKgNvFfxXPcyYqwljtRB39CVu2mxt+77ov4zrrrlqFObV4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CO1PR10MB4577.namprd10.prod.outlook.com (2603:10b6:303:97::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.13; Fri, 2 Oct
 2026 10:05:26 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Fri, 2 Oct 2026
 10:05:26 +0000
Message-ID: <88bc8156-efa8-4ea6-aa4c-237323d248ae@oracle.com>
Date: Fri, 2 Oct 2026 11:05:03 +0100
User-Agent: Mozilla Thunderbird
To: wanjay@amazon.com
Cc: abuehaze@amazon.com, acme@kernel.org, alan.maguire@oracle.com,
        andrii@kernel.org, arighi@nvidia.com, arnd@arndb.de, ast@kernel.org,
        bentiss@kernel.org, bpf@vger.kernel.org, changwoo@igalia.com,
        christian@heusel.eu, daniel@iogearbox.net, doebel@amazon.de,
        eddyz87@gmail.com, ihor.solodrai@linux.dev, irogers@google.com,
        jay.wang.upstream@gmail.com, jikos@kernel.org, jolsa@kernel.org,
        linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux@weissschuh.net, martin.lau@linux.dev,
        mathieu.desnoyers@efficios.com, mcgrof@kernel.org, memxor@gmail.com,
        mhiramat@kernel.org, mpohlack@amazon.de, namhyung@kernel.org,
        nathan@kernel.org, nsc@kernel.org, ojeda@kernel.org,
        petr.pavlu@suse.com, qmo@kernel.org, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, samitolvanen@google.com,
        sched-ext@lists.linux.dev, shuah@kernel.org, tj@kernel.org,
        void@manifault.com, yonghong.song@linux.dev
References: <20261002073422.14253-1-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an on-demand
 loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20261002073422.14253-1-wanjay@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO3P289CA0012.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CO1PR10MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: f87aacfa-0860-4f85-d0b1-08df206cadb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	om9Jw+Kz32Fl/6bZ6VFaM/qxmC88B/+YutOWNiDmRXxmbY/cKMloDHPGT9WuBSX0i88GNISKwKy/NgSP1wpZpVMykRrDN7WsY6YmuAUSPAVsObW4j0enkdDUoZ/C1AUw0sJ3P8G5y3KGJFar1LRuNze9yyrXcr4kTeDfM+ZYdOaLaXLfO9/vCe6ceJb8smIpbNPj2ZSuqg0gsVvRTI2v35xjULIoZ5/qH/XDPTt5zmUF5qoJLn9j6/qkgECIC4Tdb/LnTQSF5SP/+kUJ+C3P65jvsURvdyBPYvGpVy6SepB4Tkzuw340iXImBcSBPrBzgFVBuBvH2vsRJHUsvx+WOU71iD+0sFEt9W3DxG45+Rr6/o6jboyEza6eexTz6rllY87vwb0oRm+b6Es85ahqcpQ4yp8m3hHymoMBvuVAjRPmh6Lu4zMsRlSlW/mnRCnA3T70WkgNAGT8gfPhYn/C67NHpMQcAnEmkb7hdXftfS1J+6/Rs0Uwfn0T8KrJX2W9qLBFs6Wr8gqQ/Kqsd8/ady0IxRs0U2HI+Ybrv4mMK3qNpiRwSU5T8XbkjCefxOuBzWXeKo7/vQ1/Qhawt9syFwuG/HorOpYXnFmnTj/Xewy/iA57IrHNd7b5Rze4YREEmIVNmU8gsoZxCL8Kzpouu/tuRA1xbfMmxV44cnDpwDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUV2dWdJbTlJL3hhbzRQeDYzSGxDSzk2T3QvU1NpNjFzYWtNbEpZSzdjOEM0?=
 =?utf-8?B?dUhuWFJaTHFQTlVWUEt3Z3ovNTA2OEF3YTJjL2NzUUpsWk1SWmJud1lRNWo4?=
 =?utf-8?B?cHNHK205Z3ZZSElKTFQzdmd4dXJRVDBTVHRkU0s4MmZNRjBxREpPNmpNb2Vl?=
 =?utf-8?B?amlxVURiUlBHTDBPR2l3SW9vU3BHVHhLbE9zSEJUK3k3WGMyc285b0JPbExz?=
 =?utf-8?B?Q01sSzdoK2VnUzZINmRFQmw2bDBGdm1YTG9VVkpuV1VGN0lSYzh1dHUyZEw3?=
 =?utf-8?B?TjlZaUhRcEJkVzB1QTBxMkxmcW1kYzBWczZFWElWT0NwMDcvK3JCYTk4bExx?=
 =?utf-8?B?UzdIVFJta2FWelRXN1FaaFNvRDVxUFBkeVFMV1EraDVSU1RROHpjNW1QaGFs?=
 =?utf-8?B?Z3gzdC96Q2paVEVJTmxNVEhXYWJpNWk4c0tLQlNjSVcyOHFsVCtwUlBGUWox?=
 =?utf-8?B?SkpvRHZKRkdwM1E1Yk8zRFFyZEhtV3VqRkhNVE5ONm5QNHFUdktrTXBSR3p2?=
 =?utf-8?B?QmV3M0ZkdDJTY05DVCs4TmZDakNiYzUrUUtVaUMwOHdVNVBFNm9zVDJ0SkFn?=
 =?utf-8?B?ZUttK3U2bUZmVEdTRjZtRVJsQjRSWHMwSFozUzRmNk02dXFGdklhYUY0K2Nn?=
 =?utf-8?B?dVFuU1pkdXd6MDl6eUlNNFFIUzl3SU1uN2RsMXdKWjQ5VkE3YUprMkNhWnlQ?=
 =?utf-8?B?OWRiSUd6VnpQYnpnTXN1a05yaWRseE9Yc1V1U2pUV2FjZ2kzSjFuY2twMDZ5?=
 =?utf-8?B?MGt1Znc2N2lLSUFrK3JFWS9lVHd1N05YSTBDczc4NzBJcUgvbDdxYnlERlNF?=
 =?utf-8?B?TGpSL2duREw5OHMvMHdBK0ZNcjMvYXMxS05MeUFZK216OTNrWmlHN3Vib1Z1?=
 =?utf-8?B?UW5YSmIzQ2k2QjZIcmtSV3pnajNTZzBhWS83QTllY08zOG9ZRlMxY0dUVlh5?=
 =?utf-8?B?b3B1UmtNbWZ4SS81TjJmOVNCaUdzRlVIV2EwYXFVWktEc1l4dVgrc1BlU3ZT?=
 =?utf-8?B?Yy9jT2tlbUZHUW82U1BFendtcUNrWW9PaGE1SVJsYkhaQi9pZEk3dFQyQko1?=
 =?utf-8?B?MmZMOHhiUDVsUmtKaDlzQkVEcTM3bm1tUFJTNzlrSVN5eVMyR3lLMFBkZDBT?=
 =?utf-8?B?a0FUbG10Z1lOUDFzQmxsVTdVYUMzRDJjYWlEczlqYTVSdzVIUEtpSnMwUHRG?=
 =?utf-8?B?VWFselZqblpVeGlaaFMvNnNNSk80RElxaGl1bWxLdzdWWmJRZ0pQWGhyUHhW?=
 =?utf-8?B?RTNyeng0YnJQMW1MVXZwVzRpSDYwQjg1VG9rZk0zYm5TUm9sSW8ydzRCRkpD?=
 =?utf-8?B?UW5pRmxEYm13VWNrRGkyVnlmUkQ5UkZIQ24rQk1ERWZYbFpzQzVYYTJ2NWhw?=
 =?utf-8?B?L0hYRDVxWWJXSVBGMjQ0anpyVjBTS000ZjcyZjBMd295dmJneXlXUjlhQktx?=
 =?utf-8?B?M1VVbUZLeHYzR1NqQS9NeUQwVU1WZVp0VitxRnRwTzVkbUdEY2lNeXVvaGRE?=
 =?utf-8?B?ZHFOYm03cHk0V1QwVHVGd3Q3WTJpV3BBWHFXSDFwdXBBNDVYL3AvTk8zb09l?=
 =?utf-8?B?dFJhZFgzNU55V09CYTJSalFlMytaa29hOHFxdWVXSW1VYXJveWlGMUxGOHNV?=
 =?utf-8?B?TTRrd3BUZVFQSmFSRGdqd2JXUWk0ZFNRQVdvZWxpR2RsTldxbGRFU0FQZlRB?=
 =?utf-8?B?aWZUM1pXdW9RMmVTeTlxSU5SQjRKL0p6a0NGZk1uWkpxZkV4TFB2bEgwOHB3?=
 =?utf-8?B?U1Vqb04rckxveWtSMFR2eE8wNGt5aUdKMUVxb2ZQYVF2ZFdFbzVrc0N0TzdU?=
 =?utf-8?B?Tkw3Z3RvSkUrSmdROEpQekh4Q2FhSXg2dnM1SEZZSDhqQkFlRkxJcStIODdC?=
 =?utf-8?B?WjFRay82K3dDYXhrVldnRkd0dk9IWHBMVm5yekxCK1RNNTRVWEFvTzA0QUZn?=
 =?utf-8?B?QWk4cVB0THhKekpBT2R3NVplRkFIRW5vTENjRHd4TmhpTGhQVEZOb1NCek9D?=
 =?utf-8?B?d1VHMkV5bkhyWWo4bmZ2TDdCT0FqTzZnYlAvbnV0aitCUzlCdHVYdGZGd09I?=
 =?utf-8?B?SythWTBWcXFzY01EQ1lSZUxWMmxRUjV1Qy8xZS9JS1Qrc2ZBUTRod0Izc3BO?=
 =?utf-8?B?Z1RkcW8xV1hTV0R2bC94czByUjE3TEFmNys4WC9zSWJITXZXeTVlaGpqdTly?=
 =?utf-8?B?Y1VlVDR6ZXNPNk5FYVhRbE9wajFWM0NQckNoWkFXTTZvQS9DbytWeXJFUGJY?=
 =?utf-8?B?cW1sWFpYK0hvajhsbnZ5Sk84bkpPZnk2SUN6U25kZEtpMkxEeGFTZ3dYUkZX?=
 =?utf-8?B?R3poeVlpTGNYejZVNS9iRDFsR0l3OVFDbFBzQmxOTE03dERLbkllZz09?=
X-Exchange-RoutingPolicyChecked:
	MWTmxtpajnmxTH3HOMDckDsw1NvZOYPaeNuhs6cQQOlGUDrtxUtQrjuxGPfn8iv2hkO5re2zku9Gj8FmIiEOcbn1bGludB/dBStjWSQ929zFLdY6lFJzPTgu+7CMwDAB+dYTxmaZCiSwg4P13rN9mdj7y5n1kpXQdS53dJSxNzl9kC4iWOIxHiDbSqlrEi4WeJ8Y8nDupWapmK8XjyZCVtU3+ETm+eiXky3UQ0XtO67YQVoy7/wkXzj6+D68JdPwijSQafX4YKDCjIJDO3brE7p6xfQxUEg9c4c4famS+Eyv3T2o1Oh0OD3UoI7l1kZkmVy7aJyQJhC5ZtaO4e5eiA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bbK3KFn6iKJqhyTZpE6IdKQSj/WfJc/upz2mcK/hoBzJjlTt9gD5tsE2zcyjygvnX31def0UDpEZxFl3GBqJb2etZOR2UsALtc2ieDgLFBU/c1cISXf1C172Qnd5W7/YXipSFhK7OUyX95+p0OAPe+EshZE8Pbsl/R1echYaidhlZzOje9H+gAor2l/OCgRopoT27a1siLTjNVJOlRHIvDAhlwLCdm+KRlkGqiCMpdMlTCfwE0W8YKQU4x/T9O3Lovdla6jUWmWh/cNMCTdButjJ98lncHDRe+NX0SHrFa/KeDlwwT7/FlF/wqsF15R+etFxBcjr0e58PAgJg8MG1HXU8qNZpSIz5hscxtQVJiew/t7K4aPvKVHl23Kd3EdvVLuHr1datFXPAAbPV/QjF2EdB1jHq6o4+VcXczdMnqxYeCr8fBV6HAWG113N8ssxFgLkuORgeKDcQc8Eyno0KA8BYTq3/gRuPxToCzuMkCri3DN4ZWZhpoVuA6c8495eAIC5/YfiLb44eS8hEp8BROSCuGIvCVg31a9fTj32tddaFxl+zcdCVgtfKhmLiB9eVsR3UtLZWANPi7mcSKb+D5SmEY9T+uTy+ldCtfX01yg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87aacfa-0860-4f85-d0b1-08df206cadb5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:05:25.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQv3kk1G4B1waHNSKVpv96uLlC5TY11ZILgAOWJkHjlxr43J4L5+QKOoXxiKKe94jr8cWtSZNpVF6+c0VkqONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=965 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610020040
X-Proofpoint-GUID: fvMX7qF2niXFF4c3EWwLMNMQ7Aj5-YgL
X-Authority-Analysis: v=2.4 cv=U/gHnuru c=1 sm=1 tr=0 ts=6abf81eb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=loPRweBkcqcq4HFqS_0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzOSBTYWx0ZWRfX2TSC1aj7X5hc
 hasZE1VlA0/eN/Mn3jMts4nH8AZQRE9i/y5m5WnEQnBDa5Rc5yMUuKctLg5/waAlEBu4E6WM6Po
 /FPdFHsxZefZbYTtV+yjyvxh9Tnfo1TYbe8F6FTTnu4+s74dF5sy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzOSBTYWx0ZWRfX7CPV62KYFAAD
 VfP4uypCSPGBlKa2y0t+U1jzRdWaRYcOA4t6g7LUOun7QgO/cRUcQbYri7AqmsLWoQYMN7FNbJ7
 TdfTxRJyss1dEMzlDono1djmy+rAqToBUA5j8Ni6Z9L5ydhrEG0pj1U6CxhfY9L4HyCLJetx7Mq
 tDsdSMCMcqrgz4dAZTBF01RIrFOQtj5WWS5HAGpoPJ1m0QDE14yv3HvoxL3AjR+cPhZB52hJbuP
 IuVm3lDN+UqCTJ0ZgSE722w/1MZ3FgBNgrmiFMgCWWaAkksGISVwwY5CU4dScyLu7vC56P3+mP+
 +TqrGC73qPmbPl5sIkhvCKNYNXy7pYw6MSJTug6XgI2ocyzN7f95JQc4KdnjTm4ZlUJh2NBi2Qo
 uSRSBPrMjcSHrIaNaUc3tnBwginDn/C/7fuRko3p/yvpuqdlgfbevbQ9Q7cx0XV1SMFshj/EafY
 xKoJlhzOHpLgKNJ0k8g==
X-Proofpoint-ORIG-GUID: fvMX7qF2niXFF4c3EWwLMNMQ7Aj5-YgL

>> A question I had: is it really worth 2k of complicated kernel code to
>> *maybe sometimes* save <10Mb of memory?
> 
> There are many reasons this is worth it.  The main ones:
> 
> 1. This did not start from a number we picked, but from a real use
>    case: users who run large fleets of small instances, 1 GiB of
>    memory or less, with their workloads sized to fit.  We are not able
>    to disclose more detail, but for them 5.4 MB on every instance is
>    real money, and it can be exactly what pushes a workload over its
>    memory budget and onto the next instance size.  That is why we took
>    this on, even though we knew it would not be a small change.
> 
> 2. Loading code and data only when a system needs them is what kernel
>    modules exist for.  And most of them take well under ~1 MB once
>    loaded (nf_conntrack, overlay, vfat); even big ones like ext4, kvm
>    and btrfs stay around 1-2.5 MB.  The vmlinux BTF is 5.4 MB.
> 
> 3. We are not alone in trying to keep BTF out of memory until it is
>    needed.  The inline BTF work [1] plans to deliver its data, which
>    is even larger, through a module too.  The .BTF.link record and the
>    resolve_btfids option that serve both are already part of this
>    series (patch 10), so this is not machinery for the vmlinux BTF
>    alone.

The other consideration that embedded folks have raised is disk footprint;
apparently by moving vmlinux .BTF to a module that is a win for them due
to the way embedded systems are partitioned (vmlinux image on a different
partition from modules). And for them a lower memory footprint is a win too.
So from my perspective it is worth doing, especially if the only other option is 
to switch BTF off and lose most BPF functionality. Between small VMs
and embedded systems that could amount to a lot of systems.

However it may make sense to approach via a multi-phase delivery. The inline 
stuff is pretty close, so if I can land that with the resolve_btfids support
for --btf_link that reduces the footprint of this work somewhat. Then perhaps
it might make sense to split into a prerequisite series that does the prep work
for module-delivered BTF (roughly patches 1-5), avoiding issues around module
load by reorganizing when we access vmlinux BTF. Then the remainder - stuff
which is tied more closely to module vmlinux BTF delivery - would be a smaller 
series (I'm planning on sending out the inline kbuild stuff later today all
going well). Others may have different suggestions, but that may make the work
easier to land; the multi-series approach definitely helped with the inline work
FWIW.

Alan
