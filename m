Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5346AEFE;
	Fri,  2 Oct 2026 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934484; cv=fail; b=cSOg19zR0StZazNOsuENxau254lAauGEKCA/80Lv47GrubS9NhezyVXD3h2+gvHKekfnO6GdtImMThiQKNIBr2Jg5p7bCf80sd47Qz6fnS9vu0NdAZYRkWhi+IgpgJFVNQZVi4b2D9Y4dvmlIyA1yKm8hpyELtcFmz8e917lXDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934484; c=relaxed/simple;
	bh=y2KiDPDXs5GaCUL45WTiOAq+CR4tQOlqotRvs2f9RGw=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1SSMTcI5vgkLM1ZUhGGVToXdUQ1T/VGG8Q/cpI5ogLXmjZVoz2OhnAmJQL1CP/QxU7ZA1Vh9sJ37PHjTP2SCKK7Qt1WbmWLvHje/u/3ZHIVueduUgRmSoakq9cicXjIBRbSmJr6v0GNK9eP9I8nedvlc1hAfwRLYRAxk2kOb7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b1RGv1Ht; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vw8t51Zu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1RGv1Ht";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vw8t51Zu"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6923u5uZ823482;
	Fri, 2 Oct 2026 09:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Hdfqy3S3D29ZpJIV6Srb6OLhrrzeWOVx09TEike0pzk=; b=
	b1RGv1Ht9Hhb9bu+jIqiX/P/4NqPgc+OD0n2fMPfiuWdIGiTMznjZiWUhSE6oHQQ
	tbG++w8HhNdSm2bcti6/oFPYyFIx1k0ERC7R6RpgfgjAvJ7xf8jCpvGbJ2Vgd879
	LoMMIxrK1psvuSLomv4CWJfRQ2jODwUuj5k+KR8azvew+ClwQeAvUyEWXtR96s5I
	wu6SDpCSec6M0XzumuAjXVJxW4F2lyHLugzrGJe5NOGYCbHWTWZauyxtZnqHC7F4
	qZ5+iJwfYAhWmDif2oz65MSID1H50LRn0RvY1DjEbI5l9VwutyU/27X3TpjasQN2
	zv+qwIT5Jd9trxH4423T9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbknrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 09:47:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6929Z8CW025759;
	Fri, 2 Oct 2026 09:47:16 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gfn5ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 02 Oct 2026 09:47:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSGKI/qg8p2KBQoUbXJL69mAlQNiFa6MRVxwbTyPAGfry2vgNMNIiGjjkoYyXGeh8S7Bo1wfydHT261HH7tX479IRYC4+p4qmxBZ9ewJWw6PrOEClRLk3x23PAw7oQTyZ9/BrXAYFjMxhJqItxoahmEDqplDq1xQeWpIzoZ4MeCTetLKvzijbrD/ylZtjC5J1vbFSja1ZIJQMZYeYp7Y7DsmHAWTkwZmSF1xTQDshuHJw/1paCSHb1R6sIG/ezm1KdVQjWfZrho1yHnmCA2tl9ILjUxWPn9V47Zz7R+UIPZCRNyvu3MkT8z5oqPk7SFx0a+3w6/TNLi74Xx8ylmMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hdfqy3S3D29ZpJIV6Srb6OLhrrzeWOVx09TEike0pzk=;
 b=XVP6o9MYCcEtWtTVL/X5zzUa1KEgJdB+WQe3hidPmAlAoMSo5vii8D8HFJWf+MW0/VdO6kFNzezbRvuk+jsz4TNYhNLniYVDKq654vEkd+MDdeY5p8KM2PU0DbgYF0z/+47HAns+hsc82wzsiCZLIrB0Cn+Z/wiRYkZESl0cZovb6sHchf/JHKwOSoEWBA3vkyhD3FlX+fgnxQnNMzLsdrwi2YjMhCC3AfvUoc91z9b5lpywBlWheAwyzQq71XBbBHL7x5969t7+TpIYXNqL0sBoCT2DU5SHU9HUGfz+Jjki5VIPuuuf8apjkpVq9vRU+2BINI6EA1L8Jpv8iyYceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdfqy3S3D29ZpJIV6Srb6OLhrrzeWOVx09TEike0pzk=;
 b=vw8t51Zu7qAgYjck4FIJi2o60pVL+iWFZ1N0nD6hM0/IZwy15dcPSrZVzSjTz3k+XFoFHXZAZKtPBA0ZLZx93ln48JDFMY4LUyhLYTqUcsi3j7AEll3LVQooEwyWoZjDAlMG+Ee57R1eZuU3apl+JJX6SpMxfiKmOmgWYu6sdwc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH0PR10MB998121.namprd10.prod.outlook.com (2603:10b6:510:3bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.13; Fri, 2 Oct
 2026 09:47:11 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Fri, 2 Oct 2026
 09:47:10 +0000
Message-ID: <99c9d949-6e69-4b7a-99d2-1b4abe68dec2@oracle.com>
Date: Fri, 2 Oct 2026 10:47:00 +0100
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
References: <20261001225214.12351-13-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v4 12/12] kbuild, bpf: allow building the vmlinux
 BTF as a module
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20261001225214.12351-13-wanjay@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::16) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH0PR10MB998121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c836e46-a47c-45d9-66fe-08df206a20fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ikiZBPJhf340cQdXwWT8ler1BsG6PkOPDgoBBRQCKPMpjCpm5y58Z6W0oVk9l78VLWl0AN56SA9D0JB8gu/xSN957Bujaz08PfqK6D2zkpYpgWpjm6WfGPJ0Llf/qVJrnDVmh/piou5gKH1X3nU1taggUJspCOx780Bh4o/hIvHPLcEhJCSzrQ5rcRD/l7kb1OwX8uVWfpIAU4JVlF99BHg2AR4f+/wNmPt+vZnt6P/PoX6V0mb5gKQg1NRLakR9tP8p3SbcgAwN9/z7D7ud4iad2NDqyy6AjR/hSF56xtfFVgz3pCsDJbY40u0LRc+RzdBFyjiZaiSHt9AYM879t3FvFjgy+U+0uPcQEkPOhOZdXPIYVqNlfm+s+oEoQnBkLSEJC0m6cQi1vpnfzi76+GwrP5Wu9ahnLW7s5Ve7FFBJMcd6EZtHhNqq2F45v1eqXaGpdwsDTNOOQE8ZsBeZ/nmwVI/VkoBPp9RuMecWu+Eh/sgRe6VFHo5Ov6bL7KKNRjGZUQCJiZ5pCCKRt6vVoD9BewHAa/tLe841wuv8HK5AC3OzGtblhX13Va3t81/pE3z6qIGbBAuTnkDSNhbSy9V+r19I/FqbhBhVKUUdMzw/hzIAtp+gVVzsofZaWPJ9h3PQfleYWIC+LzMKASlfPv58VlplKktr4PGKfFPyzns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtEeTU4T29mVGMrQjdmc2xKaWVmK3VVRmhaUXU2a0RHTkxMenF4anNFdHBT?=
 =?utf-8?B?YU9HV3dDcjIvU1FkWm40eXYxODZGTzNBR09kSWdJVGJRa2RHTmcyWU1BSGRM?=
 =?utf-8?B?a2J3TFFseW9IMm5QK2VPVWtvcTc4aVc3Y2M3MWVXY2luSk9EL3dUTTVZZkRp?=
 =?utf-8?B?OUVBUEhtTHh0RVhqMGovaHBmaU9vK0JTQ3J5NUh0UXR0Y0lROEZoTnZUalpz?=
 =?utf-8?B?QVh6Y2RtcEd4R0xXNWdjM2NjdmVlTkxaT2pDUWFzUjloM1ZhQXVXQ1RTclZG?=
 =?utf-8?B?Yk81bW5FMk5yUmpTRWo5bWY3S2R0VmhyU0o5WU1GQ2o5a3RGZDBkSFViV2VJ?=
 =?utf-8?B?NjgxZ05PMUdPaHNaYmI3S0swK09SY1NlMXRTdUU1TzJES2d0VFhMR3JEVU5n?=
 =?utf-8?B?bTFjcGZQSlZEYkwzMXpMdnlzQVByblBoUU5ad0hXWi9TRFgzTlFvS0tZQkFk?=
 =?utf-8?B?eXplcjU1VnJNM1k2VW8ra1JwSUhvZkUrOUh6V1RqbytKOTBXSG0yd2t5ZVhG?=
 =?utf-8?B?cTBpejQ0Q3RoRjdTWUszd3RjT05CMXJzVFkwOTVWVTRQUkIzelo5aGdqMG5P?=
 =?utf-8?B?V2YvQkRiL0hUeTB1bithVkErRWlSZVFHeUxiNTVMT2hlRThJVTd2KytXaTdZ?=
 =?utf-8?B?UjdpamhMQkQ1c0FnOEswVWJxb2hDVWJtYmRFKzVkMHQvZk9ZcnNsaEd0dlNw?=
 =?utf-8?B?OHZ3UGFGLys1NHNid0xLU0NUR1VuTURpbFJUcWFGeit6eW5MclI5cm9Peis5?=
 =?utf-8?B?THZ2NEVkdkM1Sk03V2w1US9hTEUrSUFJRWRtWi9TL2puRHpmclQvaTliVmhk?=
 =?utf-8?B?cTg3UTV0RlY5QTYzMjJHby9EcklnMjJ0b1R4SGpRVzErQlRPcndmYnN5NFQr?=
 =?utf-8?B?ckprd3I4MmQ5VnJybXcySlRsZHhIWmZtZkdCbzhLRFQ3eFQ2QUZWck05ZWN2?=
 =?utf-8?B?M3ZEZmJyOXNJQkVMMEloT0ErWEZ3a1hZbWwraXRyMEFwc29vRTNrWlJhdlJp?=
 =?utf-8?B?V2VnekxWSnAvLzVJZ1JXTUdWUTNvUnZVWFA0NzQ3MWdGR0U5NEt0WGdKVnQw?=
 =?utf-8?B?c2l1Z1RCTitxMVpHUGZWeENXbVQxbWhGakR2MXFNOTRqYkViZjlRVjNTa1hY?=
 =?utf-8?B?ZStxTlFuTDZleHc2TXB0ZndhRTlhVFdMaXIwVlo4b2RVRXdJZS9rNUZmQ2dC?=
 =?utf-8?B?a0FFTmhvUS9KTWxua09JSGYzaUFKaVZTcDBYTWppbW13Ykk5WDNpN2c1ZmpR?=
 =?utf-8?B?VnV5Z0FBOHVnaUZrL1BFaTcyYUN2cVNOWEtHQ200WkRyOHIzczZrT2FqZkZO?=
 =?utf-8?B?bjVxMU1YM3pseFk5RmpsMWxRKzN1b1k0blkxQStPZ1lUTDRwakp5OWtRek5o?=
 =?utf-8?B?RVVnU21ZWXN0b21GY1ZMSUNkV29KeDU1Mks0SEZoelBBSXErc3BsTjRJWExK?=
 =?utf-8?B?Y3VRK29tQ1pkd2NqeTBjeVIxUVVHNnNsbmRWOWF3OUtTV05JbXNPcFRDbytl?=
 =?utf-8?B?VXhtelBhWHNEOFV0LzBpVHBBZFBTdHk2NUoxK1B4cnR5eUJSUFErQ2FQNktH?=
 =?utf-8?B?WlUwcWNldk5kdUVrMzNpeXo3SFFzL3Y5R0tTZGFDdjNZNk1JWVNSeWJTc3l6?=
 =?utf-8?B?TGxoRFl4REF0TS9LUjM0ZSthUmZXTllLa09Vd3FDVTNMTU5xTjBCSmphUU54?=
 =?utf-8?B?VDFnTUIxcjZHRnBzbWlrQnpSTngrbnpyVHQ2OWhoUmNtWEJLbFV3RVNFMmFr?=
 =?utf-8?B?Y29LZndlalExVjU5djdNK2JIY2Z1Q1p0ZDJML05iKzJwV2lieEZGRDFBVm9p?=
 =?utf-8?B?V2MwellyTlg0MlI5ZnhXVTgxaGhSWFFkekpIRmRYamRKNlFoL1I3MjRNSEFQ?=
 =?utf-8?B?VUtGeGZIRUl4azZhenNzMWZCYWtCcVdJRldIdy9IY0lnUFRKUktGUE1jL1Vu?=
 =?utf-8?B?ZFNYQzNOQjY5NGE4WHdPb1lSNjllWWR6Um9xaDNjeXJRRXFOUGdrd0lFc2VS?=
 =?utf-8?B?YVVBa2t1dmNVRFVnRXIvMGRQckJ1OURkb2ZCTm5RaWVJVnVFMmJTLzJLdkw5?=
 =?utf-8?B?VWl2Uzd6cTN6Y0ZuNnJ5M25lemhMbDdRdnFSNXp2MktTZzdOK09ZV0g1blVS?=
 =?utf-8?B?azZZZnBTY0Rha0RUTWljald3SG4rT09qQjdaSnVNOStENHZaUXd6Q3ZZYXRS?=
 =?utf-8?B?U2pnVmlWYzBTRXZtNnh3bVZ2NE5mRmJoQzl6NFNrVVN3MWkvSm1JTWlkODRG?=
 =?utf-8?B?dXpIdk0yL2dNYm9FdlNNVGlYbnNmYmdHOW5vZzVaOGIrQlRYYlkvQXVnb1lT?=
 =?utf-8?B?SXdQalJ1bnEzT1dxVGVscEhEWTZKQjJGbTlnRTRINmpwc09lN0NFdz09?=
X-Exchange-RoutingPolicyChecked:
	Xgs62ltKapn4anoqxJr7VMCrl998zb6KcPD35eMFnoxaOpFEyL/MGp0SZBpqO9oRhB5/eF0LOBdCdfN8NoxfgTwKWlUBLm4TksH+YpMleD7GZGasuSC2blsBK9/4AUw0yi+31p1qdik79MgtHBUDENw2zSrNhstJjSv6gWFmdeWSd+ZirqmZubW5soWPNOZ98tLS6ZpQtCpHp4tgcj+y//akXrUymdZCe188kUWc1rDrLS2pf4DaxaUROQVX/cDSHefgQIgB4IXBdhAb+OsysItAkUiOfBk7dhd8SAgD6XGgOI9+z+hqQcRN54KxH8oIHDUbfq8xmfuY9Ww3eylhKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N2BmE9vpZbckM0k+mLW6hS4Hi4u9XmTB4QP1WK2pvoXdwA4WmSj5S5kglvnxBUgxVxtvIunxypgYms/9ICgPGk97U15uPBxCUgJnY2KDTjWKSnY3OR39TemBSZiL5M35P78iy3UUQ/BbV/8ix7ZRMzDY+K/PrMBOopuSu/gfUyBrtfso+CpzVGWJ19jZazibZVHVdBArVxBsgmv4uMp4AbOjmTSURccqsxiBnTIj3Gntse2+SdFk00fazqjeCNUpw9I18uzKYwBI5lNyNKIxzyNb+p2jwq8vlai5kTfga1KC9sPGb4fUvrAY7wSD0+dalhCDerpqGdlmYVhbSl7g9ek9eKKrnD+QWpGIuiuRAmPIGU4iyDLg5vfmmwE8hsMeqiKP/8H7bkkkugHLy+N1w6Z91QXtewAq2vO96Yqy7MfZXjS/XFg35sv1mZB715n7+iSSsP4tw0pxPiM/cCPfKZy1tbeO9nn4SG476qkdNjL0uyEFU2kGhbZnveKoCh5xsguoS+w0LAnpciLTYpFNMTM6WIaE+tUfzXKLC9QMXePaYMbfBM1+u8TLrROMzIhZoqWjn4U6EXtFodzQMxfFo8ev13WpuMvL89zUD1rqVGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c836e46-a47c-45d9-66fe-08df206a20fb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:47:10.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f89Drr1FHSHCUfhGLVsf4HPAs0Fx39wo2lbi212c3o6dfjJst6NHhuMlGDcoJMTjfHf3M2fP5WQUC427paOlAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB998121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020038
X-Proofpoint-ORIG-GUID: dZ5_Y1wkuzTz_5oaIuFb2sFE5nRo5ywr
X-Proofpoint-GUID: dZ5_Y1wkuzTz_5oaIuFb2sFE5nRo5ywr
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abf7da5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=X5ohVAmpVNyKFfFoyWQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzOCBTYWx0ZWRfX8Jfj4HpfkMB2
 Bie82wB/IKM4stM3j4cBL58enQVnNgZoSmk7YcX48RQhXNKBb+Kz2eRwSUGScY/ijz5jFtz3oLz
 5Popo559dNqnFJrTxgJi0ir+uveI2pGu1eb+ctwhQPBzA6UE+K84
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzOCBTYWx0ZWRfX3zYh10yDCYql
 mVWmeDyiG9FmmSmAaDJ3BOvaoyjehCSBLvp2FPXTY1Na3e+HN8DQP8oMFgSABEC/3zp11Pdwi5c
 hnjCF/FiGzF7LTYd8DjpAL/TDwmXSs4yJdbZnMVd7VvFY9ddCwMVxpPJmoDnRXw5QEnhersUoH6
 MMAINbeg70lsM9sNvxU+ikheO+mDexy54P0cKfeIlU0jvaVX01wiKercxj1l+3vfpSNV26nA8V2
 gNaLbWV82A/grALYTgbNmBGbW7FBQlwe66Bt5Vx8sw91lY75XZIMrhcrASqHAeZUGja/JFl3bM+
 YGt/ym2ktVhLjYt4BLOVWiOUOMPP2C6WBf+9Q/Lqlt0Bi5D1m5xIRXqQL8VorzaywsrpkhkuvDH
 j017YQaNdDMHYK9MO9jGoDa6C+F//+SFDOTtN03kDm6s5a8F0ISFJwRoxu1JpvUBPGw6tpKS5Y5
 A4yty2oc4D9pgBENagA==


[snip]

> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 46e80970f723..c884308d1e85 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -76,6 +76,10 @@ This package provides debug information for the kernel image and modules from th
>  %if %{with_keep_section}
>  %global _find_debuginfo_opts -r --keep-section .BTF --keep-section .BTF.base
>  %else
> +%if %{with_btf_vmlinux_module}
> +# With CONFIG_DEBUG_INFO_BTF=m, btf_vmlinux.ko carries the vmlinux BTF in .BTF
> +%{error:find-debuginfo cannot keep .BTF, which btf_vmlinux.ko needs; build without debuginfo (--without debuginfo)}
> +%endif
>  %global _find_debuginfo_opts -r
>  %endif

I think we need a --keep-section for .BTF.link above too?
