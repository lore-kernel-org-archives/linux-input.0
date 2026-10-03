Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F92AD36;
	Sat,  3 Oct 2026 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791027995; cv=fail; b=FMTykeTfpxK1ul5KB9ibssgv51/ELHSNCtzohgE9UbaEVHClu1g0KNyClmDI4HNg40hpObW+jTM29NifKk3g3gxHwWc5TsrBk/U/wKR9XE/0i+iFpNVrvK+SNBjlpUQLr3RHcbQcbKd5mhNsXvqMOGxIqnwzShQqvSZ0JPtmmE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791027995; c=relaxed/simple;
	bh=ay6GB1irUlXRNVJAjBh6sgGeunt2mCbWhIGwmFuRos8=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uS3z9E15wDY5p0gCn5BGkH3pdGRr5mw/yky5fLH4pAOlB3zpvUTYWdeERXKePKapaHvmrxTj4VkQRbUamP5gBbcTC9CP9OSDnKYpakzI/0i/MG55fnu3PvPxZmUJpvGaptH5zTohvTc1WAxMOqe4eLD4QMBKmbGSG73A9vtjRDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bVcb5Cl0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J9COJA2o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bVcb5Cl0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J9COJA2o"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6939xbeV2634673;
	Sat, 3 Oct 2026 11:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K8HwUYy0qU9+yyjaEiC85DOekA75GzrDnms5fpqkH28=; b=
	bVcb5Cl0n4JvoxBd1l37rFrRnI96uWylEkm4Dtn7OAAhtSGHncydTXKC8x0W4kOR
	uzSS/D1k7mibOVOE8ehtW96iMoxeS5jHca59KbnjTmQx7lXJDjF3MN5eXUBXiUPC
	U1AqjpTkVmQ55BAqUFWu3W/sjOACUmbqvuyufI8nt0xHRxKMAmF80XY1dzvG5LlA
	ssS9sMp/nYjHI9sSBPfpm6L3+3YDIe92Evpd7KQSJ28vpfz3ffW+2nT1YqqSiEeb
	elcFo9nPPSJ3eFdIAcNwpAjS6JpfAcDPnnpzUK6h+OQbZByQANjD8dZqbOCWPsub
	+jfHXAOLCQ5cwP4pzJI28A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2srcr6fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 11:45:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693BZLRG011961;
	Sat, 3 Oct 2026 11:45:49 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r5m91rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 03 Oct 2026 11:45:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/lXKEdNY9mJCE52x1LRAYGyqBJNfA1hf6/BdGjFlq4ctlbZlqjl/kqq8ZEeMRKLcCNx0CPOcJvSGGINciesTP38d0PdDtKH8hZgYMD9WSZ5LRIKCXusgozybsdoGegdktllRnkGW7b27R1du03smFq3vDb6pgzwMJdTVcGPI0XPLVvUe9ZW1zq4K9u3IG7E80Myz40PtyDWmQhWDIb0QLaQWnAAYHd635S9+SIX1Csh16XGZ7WyxeGQKKpngZaH4PEe9tIuDj2I/qldAw1s+pW4BA4kD/6dMGeO47lsw0tbztf1VYnsSf765ViJEcMyYPfXhwdBmSGJDkyYGRx1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8HwUYy0qU9+yyjaEiC85DOekA75GzrDnms5fpqkH28=;
 b=PSozbH06jvgOTmRk/+sCL0X8f26oZ8AvXnP2SwhOO8SBlVd0jINXzZAV4af3meLr7xAo3JotkMF/slTlpTla09+F+bTy7qLoBnLjwm6k1VXuhOQndOFuCrX1RejbTve/xVMphcjNUksdWsdEG0TBnotTVdzXyYqLeQnoFJuob/yFkANFAngZ6jRcuRoUx0bfw1Ft2BopTdX+Xo53xJEy7v6PqX83Qpf4XyZU3mmXlqerYrIKak5MNT1DaT3D2SOSj3MSCR5/b67ASefu1mPwg6bhlwpWBudUM/qA4LPvLqB+q52Yl5OBIHAs+ncAp8zIrHMeimOFLDtYD9bpVGpSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8HwUYy0qU9+yyjaEiC85DOekA75GzrDnms5fpqkH28=;
 b=J9COJA2oga+ogPK999vjVCoiBEznhD5/btFiD/T9ptIqfHpjdislw7RD8l/C4ZcrGExVJb8lhcE2rNrnG25w1GfW3D/dAdvGtlPzK0aUca2tYpe2Z3Ah4Mx23IhgZf1f3ch6xej+jrLq7yt+Ar0vk7uiAzXOhcKlvVNqwVseW1k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA1PR10MB7513.namprd10.prod.outlook.com (2603:10b6:208:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Sat, 3 Oct 2026
 11:45:34 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Sat, 3 Oct 2026
 11:45:29 +0000
Message-ID: <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
Date: Sat, 3 Oct 2026 12:45:18 +0100
User-Agent: Mozilla Thunderbird
To: alexei.starovoitov@gmail.com
Cc: abuehaze@amazon.com, acme@kernel.org, alan.maguire@oracle.com,
        andrii@kernel.org, arighi@nvidia.com, arnd@arndb.de,
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
        void@manifault.com, wanjay@amazon.com, yonghong.song@linux.dev
References: <DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an on-demand
 loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA1PR10MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: c33b768f-67f4-4990-d793-08df2143d279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rPu9W5HwHH7naeES90JwZikPU+ZrdjjO+sRSCMTUSugyP+fMTZLUVQgVFMXZJe4IEHtmeDGdag6JVzIDLwjYse3QoKxhBlkkSRhSOTJ3iFi5J2bOzmlOb27acKZ8fyHO5GTXURNxBnJSqIWQqwxqrZW103PulEp3sknoJCS1bjuDtpUXFJKfZ8ASa+92PlCarumXrlK3PgQNjVe3O/dbXpeVaT1AFkmSM9stXvRuZEL5KnHHRkliSGj6nxIa3irp4NhyE4mTwaC3oMOVlpQSAwG4+r4zHlt9lIPO4JPbv+a+2Llt/1rKXC2+RTjYXukVXM0Dl806BfJ29DkE3aqPluUQP10hzo5uE1VkueMCwZw0wZhCt4adyK8SX5tIHkPGuTQnHzKySMoa8AnS3g2pDk+poaZ3aJQ4+TtbXottB7cK19B89jKLV7Ucgm0ODj1WKBHQSaDSFXcMn+JhL4vnIzl3UKjlqqZ3EZUXUqbMBawC7Kw2fLS5XTJOuz0S/5yw+q0M+WOyrG+WYRbfFP0rzTcOoOKTEs2tgFCkhFSBw9ocNeX+yqzXxNtx8FxnDYHcDMyo7ksUJ4uYCiNLtrqIo7w5/p/5Tw7NK6ZsO0A5nftq4mHsDfXToPzWd/Zc4B2e6XvGEShJqgqHVoZde3ZKlUKNzVh5lWd8NcOUqFmnggA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU1tWWlvSE53SmVpcmNoYnY0WUwvNmVwMm1pNWpobElrVUJsNnJIQXI2emV5?=
 =?utf-8?B?YUV2cXpwdXFnU3JROFFtY2o3MGtZOVpXb2d4alFPeHpHdllMUUdBdFpXSSsw?=
 =?utf-8?B?dUttanREMVg2K2JhVXVFK3JNT1JXQzU2V2xWZzJFUlNCMjV0YkhEOENicjl4?=
 =?utf-8?B?OTBIak9jY2xPWExtR0c1NStGN3JzVG94VHIzZVl1YXBSWGlzQTlhSUtzQ0Rq?=
 =?utf-8?B?WDdJSDk5RkQ5MW9KM0YvbnZuZUZlT05EQ2w4U3ZROHpTTEE4SmZmQTBOK1BR?=
 =?utf-8?B?RG5XQ2c3cjV6MklLSWNram5RZDVWZTU4Rm5KY0ZYZDVyMmdtNHFJMlV1KzVN?=
 =?utf-8?B?bVVNSE1NWE83QWU4enVRMTZZQUdJOE9pOWtjZDBiUy9MSUJNd3FVR3pmZmpR?=
 =?utf-8?B?WEMzRW52S1BlOFYvaG4zMGJLWDJxTUZuNndCZ05oWFFQVk5oMmNabTEzZWxx?=
 =?utf-8?B?YURRSkdacGg1V25OaERPZDJOb3VKNWJSSG52SlJ0UExkWWxnSlkxRy9kbmdZ?=
 =?utf-8?B?blZDcmVoRmlmMnhFMFVPUkU0S3pxdXYxbitKcTdyUlVuOC84MithRkk0dzVl?=
 =?utf-8?B?UGRRVXV3UVArZk85NStveG1FbmRkVXJ1WFFNTFMzR3libEFwQUV2ZjVMaDhD?=
 =?utf-8?B?eHk1SmNZSEh5a21vbzY3L0JyWGVwRTNjOFFDNzVWUGpJUXM2RGs0MlEyejN4?=
 =?utf-8?B?T1ZIQ1V5MUl3SXdGdVBOZW1aYWZJblJGcDVEQUZMVnp3QWZiOFkvcVRTR0pw?=
 =?utf-8?B?N0pFdHMwclJBMjQrUVRScHNkdHJqS0didlg4SW9RamlxZG5PbjU2THlLblp2?=
 =?utf-8?B?Y1hvZ2FFSkpXbjFJRktQS1V3dndXU1MvUTdJWUVhTWp6OEtUOG10SEVUV1Iy?=
 =?utf-8?B?bElFWUMzbmNQVWJNMkk4N3VPT1BTbjZSaFFqSjFBWmcxM2tXWFJQRTdCLzBD?=
 =?utf-8?B?VDFEdW5VRXpiNXVKZGRvZHRlUXhvZFpTVUplWnROQ1l4NzF6NjVhcDhqK1NV?=
 =?utf-8?B?U3VQKzRtYmhrRGQvbVgzR3grU1VFR0orWk9Gb0Q1MUlwNzFIdjFoTUZpcXBu?=
 =?utf-8?B?Qm8ySm9ZYkZYQm1DdXlzWWF2dUYxNjlqc3Y5eXdBbk9UVnU2a3RaWFdyc1RU?=
 =?utf-8?B?RXZkdy9Ba2Ixc1lJem5xRE93Tk9oaVpMdHY3QW9FSkZ2WENwV0QrL2tUbldK?=
 =?utf-8?B?akVEMHo4eXlKSFZMd0V4bW55WVVEVzZ5VUdIWEgvU1BGRDdiWDQwdGkrMUl4?=
 =?utf-8?B?b2RlMGUzU0poZERnRTRjbmw3T0JmNU5Rd1U5bXZxWmFnb1pLTU5aSXc3ZmdZ?=
 =?utf-8?B?NXBNYS82YUJjQjNab3pmSmNYSFpkNWNubHR0N1F2RFVJbVRlUzFUVW5abGJT?=
 =?utf-8?B?MWFud3RwQml1VlR5MTU5amQ3TUc2OWlXQ3MySU11YXdhVmsxZm1nMkVHeEtw?=
 =?utf-8?B?eEZLZmQ3U2JHc2J6TFJzMUUwWHk5MTBVaHRJWHV5VlpNcHBwYUt0dUJVSDJj?=
 =?utf-8?B?Q2ZNT1JQeTRVMXNDTUcrRDVuWjJhN1BOcEd4Vm1tL0w2aThsMytiQU1wT1dZ?=
 =?utf-8?B?VWtTeTBoalNyQm13VzJYS2hGck1JY0FGQlNnbVJXanlXUVFhTUNzTzNOSzJ6?=
 =?utf-8?B?alBMdStITU1BWWZpY0lIcGdWcWp3WHd5dGhpMjBGV1JVVHNHMFJBMGVQNHQz?=
 =?utf-8?B?WVg2RlB3M1lYeXQwSzVjRWI4SWRkMGJOZktTSmI3dWpkL3NvaWNGQXY5Sklq?=
 =?utf-8?B?aFk4dFhOdjFUT1loelpoRjdmbThuWWM4OTJsUnJ2T0FjOWFYVHk1SEV6V2Qr?=
 =?utf-8?B?TkloS2hIOXlGRHMwMU5SSnNHZGtOR053OS9keXY3VXljQURvRjBwSzgrZ0l5?=
 =?utf-8?B?OG5VbWh4UlpXR3BTK2VVK0RVMEdieHlNTGdGM3o4Z3NKUVgrRkprQjRBQ1Vi?=
 =?utf-8?B?T1ZmTkRzUWZBU0o1R0RWVVN2M3NLSFNPaWlyN004Mmt5SGErUGl1b21mY1ox?=
 =?utf-8?B?YjVzeEhOTnMzUFl1L2hjNWNXY3lvSWNYNURPSjg1eVNVVTQ3VFlzcjV4S2k2?=
 =?utf-8?B?OXlORml3VThHTmFnOWNqSENDcjk0YU90ckJlSEU2RFhMcWxRSVlZQ0t3TllL?=
 =?utf-8?B?NFI1VnZNUXhhaDcrVzVxWjNzN1VmWEFaRmVEWjNvTjZsWVhPemQrV3lBRE1X?=
 =?utf-8?B?U3VjYmYxQXB6SnZpU2cyNlRyTW1KR09oNzRxYnVNTS9ZZzRsNy8vcWVqczk3?=
 =?utf-8?B?MUNCL25adldubStJSWZQVkZ6UmV0VlhndnVuWDVRVHliVnVmam14OUc0eXVr?=
 =?utf-8?B?SFJTbEo3OVExanpjd3pneU94bVA1bTh2bjRuQUwyU3o0cFAwUmZYUT09?=
X-Exchange-RoutingPolicyChecked:
	2YyR1Uezdto171KG5QATuNLrPp8pWiTWgKsfA2fPenbZcnLt3HUZ8Rd+jSncvM5LEaZz+cJ7BeSGjlsXnQeLlC5Pe/w5+zjF0aeSP+wkR0itjv68SBNgaAE/A5+amwLeqbDjdFIh/xUxfO/NB1i9/bbvhj5IVlv78gpIx83N2ymkhIJflku+VymldUtD/QV5/mHJY2KGMHsuK9jWqbTWqiFdTtd78ukxv4k1hzwIlXxD0GfcdJUiAP6bxgcRyd+fwKBfAjuI0aLfNq6662aePKuwHX9eWzej/WI5ZtEjzHOvhi1X2EHWsNb8W8K5CvkyaJ6CoTO0DsRsUOYm8L8pYQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6TUhUgyyytxh/ThFQpAoRJOuG400O8GycwQcebydLG8/98OJiLBu02pEzcWJkuGQccMnPyq2fa0T5Cqm3BFpLhHBOQL6f9rPSuDTXHsnXE1q1qts4Zym5iAXBX8x0Qz4x256dJNHSnGbH4/6Jo5K2kdtE4i6BMiNJUjqPBBpvUzB8quyugz9wb1Ax2j84PbPWVUGjwY3GfI9zgjWzomYJ55GxJsWv8RGzX+9JV8Avfo5g/TeZM+1OG5zK9OEyPOtziQLaCZmM+AWSVSKUGQaFSTR+j7qu+l3kqTP4Hwi69wf3wiSF3jwTqTZ/vlQLPFZERm/6vXK4n5R4kHa89sLpFlwsDJScBliNjsDzvu7R0RzDfq7wt4LO7UGhmoKOfF8hxHDbyCpMr0SvJSULlQjUjUdUql3ES2LKjpPusakHi1h3uca2ZHpvcJo9POeM9JHnHNDjaGj/UzOLdCFseJ7cG0ypq1mOImFruijh5pzbLWSjQ/yzr2QdGLt++dQjTVE3x6WxYoTiD3oouacq/QNCDpPk4wOStYDO7orlTA0JGYNhDkgrCDRxvlze8805YOh650BfLRzxd34rVvnLRWs6iDdsEw790o0AcM+4TVuNJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33b768f-67f4-4990-d793-08df2143d279
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 11:45:29.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6aZPdlRrsLoFmjycz58F3RUPIB6uIR09iH2aZjaXJWvRKLsPyDMI4ohxnQv6TqAMolFSxuW0ST3BKao/PiEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030046
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA0NiBTYWx0ZWRfXzpiDG3HPKhlU
 fbZYJVRN1SUhuKIXomjKNI1fZO0PBvbdlpDVkKmHCyGzH0PikSPv9B6pyXgVL6JQDTmV/0sc9j4
 vEyd9tO9Gv14TCbYD971zwxumM0SWyUwPzzmtTwbB9du4EGupAM0
X-Authority-Analysis: v=2.4 cv=d/dgWhjE c=1 sm=1 tr=0 ts=6ac0eaed b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=SJ64B12V7Fz9WuX2eU8A:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12107
X-Proofpoint-ORIG-GUID: aLxTfdGfCRr_jW22OjAHc2EkKlGLar6C
X-Proofpoint-GUID: aLxTfdGfCRr_jW22OjAHc2EkKlGLar6C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA0NiBTYWx0ZWRfX11HD6xeKEXfR
 6L6k4vjUM4QylPDoFlBaSomQ83k29XaKYE9yUo1T74agXZi5MvBgBKl703J5KnpU7oNJoC1xlv+
 Wgfeqm/MFY2n9zYgQYhBXI/DubTbL2yEBwL7+LupLV4IU1coOPLsGjPxJaOuZheC4wonkJhHwkY
 7EMYRcVobeQOD25l8NDx/AmSnNA6SsKcSajFNC2AaCss73ApRs3qyNup9DR64/Sb23vb6fUwC0W
 XJLG+/0Hb/tgoKadar1RiMWvEHIUBH+o8rvOSk/QwsekD4v2uLrX5qMqqn4oEZ8Z3jxQ55s4IIS
 DnIEfkPRHin9UeIgyHzfmsXgH10NK0n0m4QHf4WICw9nRT8/6i5hZJ0ELDQj0CEHi4DKipebTuO
 CGzuNUHYWa5ntxE+q4oQQZnagehCaSBUjUHQcGUXZmRSWFuwaSg7Ptr74icQLv2V6dkq7R9Hj0+
 Csldg7qZogERpBmeCq8MF9bfzivMBYovNx4JjfdA=

> On Fri, Oct 02, 2026 at 01:58 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>      Keep zstd-compressed blob in the kernel image and decompress and
>>      parse it synchronously on first use.
> 
> imo this is the only one of the three worth considering.

This approach is clever; my prior thinking on this was since vmlinux is often
compressed anyway we don't win anything from having a compressed .BTF section.
But as you say if we compress the .BTF section within the kernel vmlinux,
when the kernel image is then uncompressed into memory we will save most of the
space taken up by vmlinux BTF due to its still-compressed size.

The only overall cost is if when we wind up using vmlinux BTF with the compressed
.BTF section, since we have to do a full vmlinux BTF allocation (on top of the
spac taken up by the compressed .BTF section) right? So slight penalty if vmlinux
is used, but big gain if not.

If I'm understanding it correctly, seems like this is a nice win!
