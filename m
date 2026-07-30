Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25EC3C73F7;
	Thu, 30 Jul 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415167; cv=fail; b=JU+ZEOCJ8XAiuKK/jsSts+dmB44dRAHex3VMUpGmDspf/LuNybSPpYncow/3X+xdvOJr5THCQIVTAdxh/+Af4/12yDx+9YmQaoYyzyl/ZOTvvIASvVPIbDVWDC7bHAIVL3TvlBUPL8N/B6JWCPWJSnZH2MxM4KDPYbQGaYYzWQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415167; c=relaxed/simple;
	bh=Dxctt+YdW320PRQRHXvCQ3nBLrU6XfR4fFbgFc3VFbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SH5t9/ekEZSXIDDJCD7bSbG2Efuf9zSM6sFfGxuXu/Y3CBNLssH5/DqmTxfxSwpk/LdqHDp9gVtYFWh3PrFV9c/pLkOn3QQYPY6IQjifuMq/dPbuQ6hMglVF+RmQ0zpK4os7+pNU7904tMvAneX3b1ODDJrjc7o5SHJ7WOsQXfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NBgLlFHs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P0QdZ/Pr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NBgLlFHs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P0QdZ/Pr"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U1ogqJ129036;
	Thu, 30 Jul 2026 12:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K/UmfsQsMuMfOGqXHXwYRZrUIFjGsf58F2ZLHOtxOZQ=; b=
	NBgLlFHs3ZTdjeWC2tcAOgwyQ+fEqP8FzpToC3jdigHFVmAajPdxMG+VUdUhAqEY
	FWk7ksw12uqsfy3zDq1w4BAZ5O98a0xyuteRlbR/62xWItJNlE1TqQumLcjTQPg9
	Tx4bYOSTmiMt6BKaT/lIvhxJOMO/6yAaMQEjnrXT8pfIEUDDRTdn6rWl+QNJ2CIt
	J18JVGTx1GxB6nx9LlJ9LxqBZt7lBgsEpLi9T8rVadfLH4ZJwF9I18z/Df619orL
	zXhLO5QW3p3eiey9fLDHqeucF5IvA0wwIZWxXpDnlmps15nqo2ErI1mZflV9bGZk
	agfgLkstIhueXTsdzN6YGg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5nqjw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 12:38:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66UCUYgo016548;
	Thu, 30 Jul 2026 12:38:57 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6s41sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 12:38:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqiGvulMl8utM8IYOvXpK1Rhu7KpXgXW6qDFPACWd2T7wvxBVv90qjqJ600zuTTem0KNojmIKTO3iUj9QMk2TWLE/W8/hYeZiMcFF16a4KpYJ+46Jx7JY+NBAfK1Zh1RRNo/pBLlPKErnokCmyFL/QzPQNRQcNPCtWRrPj/HxGPG5qJuTwa3ifbBfQN323vZbgVgTEUpYN2Q+sGycXuJEiJTv3HzokdXAWlkiU2nHIXNLHNw3kpzVvrbKLbRjErqilre2xmOexP7ogfaE64tjg77I0PMnJlPFGnUpTlAPFHhUcEg0xOAaVVGPlxz62V2cCum5ewMeOG0kt70tNjKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/UmfsQsMuMfOGqXHXwYRZrUIFjGsf58F2ZLHOtxOZQ=;
 b=Pc8mZK6C53pfDEr781KqpKx+oR6e6mU/jLa7MuXvn+uZiPDvzk7h4VY55DcwSfXMTqd3LVAuBqO+AJEiEhkuu5D01cm0U/ic1+slbZdfVSiabuPiy11kNSSKgL8SvsNPgZDe2DoCQeu0a6Y7+OaFEEpWBxifLOg+8fn06y7WeSUgP9IzHzMrGrOJ9pr23s/JoWb0D7ee0zMDnYZeLyL1PenuV97XISLVBd9zxq1oU+JHI74ELdJvZQ+0TPOkRjSa/nVEA0KGijp4RBhbV9n3gVVMBCaO7wT8lvBM7qIW/2WpxrwPvEP57hAYKrfeci4MAb9EKRLOlksQuWFLFy88tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/UmfsQsMuMfOGqXHXwYRZrUIFjGsf58F2ZLHOtxOZQ=;
 b=P0QdZ/PrOEGIS3i2T6gUxrG4EQpO+nuybGL3yxfcH2nXspxz25ln4adNFdu0t8kIrywtR8r2ElgQipq5Rs3D35BPKflArha+EDnukVS6xjc0QtDWX0VLt3gbcw5QC0670i3dIK89giUwsjwOqKBLpoOZKNBBSkLYZEZ+vT5uXHs=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 12:38:52 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 12:38:52 +0000
Message-ID: <029f3952-5dc5-48cf-b012-6bad8c2fcbe3@oracle.com>
Date: Thu, 30 Jul 2026 13:38:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/8] resolve_btfids: Discover kfuncs from BTF
 ID sets
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-input@vger.kernel.org, kernel-team@meta.com
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260722233518.778854-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::21) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3c190a-3f47-41b5-6cc0-08deee3782ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tOJZNU3eByRy4vnyf/dpx1G8sitewPeY8NtxJF/GZh+nOwVgeegEUjlvOyNmClfYPNMll/cVXUKLnfqLptTvqa9++6Qi/7EXRev775AVJwF1W3P5+NIBScn8Qa+7EFuVkM+Pa+xE/SU3sosRhI8my3RnkYmz2Rpdpku05PqHMENbSb1JdW4aW0GaFM/vMmXRToEd7aaOhjnRtaBqDh0KBI3a/5s/tazP1pvANJPzpaqmuHX/1FtGgHawUx2sh7J/DHXptnipSDU0U3XpJcHlJv7Jq1gBcThKSxsoIDMUqTPJnH4OrugK54zokrBdAbIfibQM1cJndjo0QF3s9wS3Nx2LYexQ4pzb0p0GmbfisGruuNrAoBJffURU3BzRuGcFYFtB22A+Ukb3qF9FU7V+m9nxDVY00Buohf4a+DT0cLvc1emw1ZMUqAD12yRG7zo/Le13Ro//zlpb5+R6573LUmkQ4cECf0hlO4/mXxOYgtG9vDQLlFYyPQh6kYTtBudoZdmh+cblYQvQxWgWzpOORMTgSJAMc9OmMxir48K1OI4qo5TsjqctaP8hxAhO0i5FH1zraD6LegPjotVDMbmRGSBxjaHw7P8FMlNwRdkzLjgmnqERiPZaeh7++A+HTw4TgjL718jAno5HOUs/R9KOQgNeWdLYmx/Ya3aEdqykM2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SC9wUExIRHhDd3MwejV6QkFDclpGOHRKaTVVM0I0SmdyUERhQllzMjNqRG9X?=
 =?utf-8?B?R3ljNGpSajBWS1N3bEVFM0JEcG5NQ3U1cUdGMG1nMUxiZGdRNEV1SkE3SVhq?=
 =?utf-8?B?UHRidlZ6TTZnaXlvTXdsTzRCaXh3YXFqekFnL0lCVW5JdzM2U3Y0RGxTTXpk?=
 =?utf-8?B?eXM2Umw5OU96Vk0ySVpBaDUyMzMrOXR4ajBmQ1F0c3B5RGx3RGlZNnVXc2Jj?=
 =?utf-8?B?Y2pSbTYyUFRqOGFIUmI3ZFovK0tCS2l4emVpcEY4NEpNZFZsMWFUNlBQVDNl?=
 =?utf-8?B?SG5NamZJT3BKOWF5c1BRYXZ1YkdkNW1GcmI3VTZka1RIc2wxNS8yTWZFeWpr?=
 =?utf-8?B?SXA2ZERoYnZOdnJHOXFDWnMwUWZLVE1Vd3Jpdy9zcS9zY1Q3NW5iTW0xT1FO?=
 =?utf-8?B?NDdES3NnNW5oeXFISHYyTFQ2d0gzSytDUHZHbDJMVXpVYWdXRSswaTJOOGt1?=
 =?utf-8?B?SmpCUXdpdVVVbXI0R1JZLzdQaU05N3FHcXhCWXJJSXduRi9oMzRQQXVCd1NE?=
 =?utf-8?B?bkx5bXNCVDJhTEZDTFRveWFWaFkvcHQ5b1liQ2Fqb1Q2RWNUNWRoaEErOVZo?=
 =?utf-8?B?TTIxOHM3UGttL2ltZ2RiRkpqMDZnR1JMK29SRzlaZXdRNUJjTGxMY0ppNExY?=
 =?utf-8?B?NDc1b2c2VnV5NHFEUFhFNWtpbk9qVmNRNkxRYkVJT1FtbVNoWFl4ME05WkMv?=
 =?utf-8?B?SHNOVHVwZTV5ZFdWclVrZDV2c2F5TVNKQXNuaXFJcm92QjJldlJuNEs0Tnpt?=
 =?utf-8?B?bEh5M2NxSnVuTFdYWit6U0lzQU9YVGNMRlZWVkJjL2pUUG8ySGErbVQwZG9a?=
 =?utf-8?B?alFzM1I2YkJMdjJibUpsZ2V0bUprV29GZ0FmOXlGVXJ3dWRiOThNMlZZaE4v?=
 =?utf-8?B?ejVwQlFUT2pxQ2o1SVp1NWgzdXI3SmMrdXY2d0tVenQvWUVUbituVFU3V3dk?=
 =?utf-8?B?L0hTNG9YTDNDQmdxMEZ4Mk80Rm9zWVBRTmVJLzFLMjdkZm93MFBPTWZkRE1H?=
 =?utf-8?B?RWZQcXRQMjhPcmRVaHA3SEVKUmVDb2dJMi9jVnVEV1I1Y1NNUVZIYjRTRjhS?=
 =?utf-8?B?THExVlNGM0tUaWUvZ2RjYTk3ZnRVSmtxTWFUdlk3Z2RzdDJkOUMyOG1FVXZG?=
 =?utf-8?B?Vks5dmxmTmVsOVI5cWRxMTgva1cvTXBrS29uN0pSRVBRSk1vV2dJaGlXTDFo?=
 =?utf-8?B?YlhTT2wwcDBWaExjSHNVUEJuMkp1M21QYmxZNXBZa1B1ZkRXZFNDZTJRUWVO?=
 =?utf-8?B?TXZCclhQSkVITTQ4RFRVQ0xmWlZwdFZ1NkZScEZRUzBEazJScFVSNHhyWjRn?=
 =?utf-8?B?STdkeHIwRGRTcjY1OEUzUFpyWnViaG1XY2xpc0hzTEc1cVBCck5pdWxCSm92?=
 =?utf-8?B?VTUvYUlmNUhsQkNvUjdKZ3N5S2RFSHg5YnhKclBWZTNNRTN6NEpvbmdkd0VS?=
 =?utf-8?B?aWliT1ZBSlFWRm9UQnEvZ2N1bG1DYlJ0eWI3bDNEZmVweXBKVjZ0YllKWXQw?=
 =?utf-8?B?OFZ3QVBkYUZ4bzFLYk44OGhGUWZSUHl4akMvMEVpK3ZzK21UREI2eG9KVnZZ?=
 =?utf-8?B?ZlpPQ2FLczZsZDNLZmE2UnlBU2lBSU96WlRIVlpZQVV6Y1NqZ3BRc0FjKy9h?=
 =?utf-8?B?UkRDcmJDbzkwTlRyRE92VnQvK2lnNTVYN3ZKamw0b3RER3BTamMrNUczR1pl?=
 =?utf-8?B?eFlzdGlyaHU2NVFNOGZmV3hzUm1ySkVSSnRhN2pIeVZ6TEJUcnFXdUttVFE3?=
 =?utf-8?B?ZzQyKzMwRUthODJKalFmNWFsMkRSREI1a2M4OXN3eDAwT1VtcDRuaGJNQy9p?=
 =?utf-8?B?Nzd4R2NsdDRFc2c5eVF2TmRTRHd4cmV4a2hNS3NZcW1lWnNUTGM4TzFaVFN1?=
 =?utf-8?B?YzJZdjhaYzlmQzhQVkJhUmlvOFV4b3JBQk5hOHppOVpKSmpIa3J5bVAwMFJw?=
 =?utf-8?B?RUhsdVBLWkVrY3pHUGt6bGNrNndNeU9jUERnL0x2ZHdydkh0eHlzc1pkS0w4?=
 =?utf-8?B?UzU5bjlid3ZRcUFQbm1ycFIyV2VOMVBUZTk3aWFlSFBpdW0xZkZ4Q29YOTJx?=
 =?utf-8?B?ckQ5ekRxTjlGNmFVRXlUK0tqM3pVT3VFbGc2SGtFbHV2dDJJZEFFRVFtZkJp?=
 =?utf-8?B?aXZnN1FaK0JncVN5cGhLMHBzY2hOVkJGWS9zc3hpNllkREM0MHFXNUlmSUo2?=
 =?utf-8?B?aUltR3pGbmsxUjdMczh6MFM5amxLWVRvd0RSQnZrOVpTdncrUTFEamRLSHdF?=
 =?utf-8?B?ZysvdWJKZzRlT0VYM3FJZ2xSRzk3NFBlSnllQzFucjg5VDF6akpDRTFZK3NS?=
 =?utf-8?B?M0c4V0dST3FtU1ZTdGRaTXRvNjRqZ1NuRFFRbThjblNuMDUxU2doZz09?=
X-Exchange-RoutingPolicyChecked:
	PTPfyOj7ug/fTUM2JwzN8V1P5zXtj6EQMYTtxWtEwMX1eTVJGBFE9ToMVK/v9VWk0x/2NBhOe2rxTdfSWJSL+wLDbJCagdYsEek91mgtBdQ5lou/vmcf46PAX8fS1h+Hp/SoH7jRddQOHQNxXIhrMu6hRw1vBfgeEPGsw+RMq8Q2tXkLSAWsqgQQEpllhyfX/HAgREc3JTqQvPCTX32DLRcbdUlTUWahpJYG+hizX/l2/F+FiB3wjG14MzmteR3af28KK4yKAf817SbeQxxoCF1M/nIwKezma86d9zcOjUgk1VH0hNYDDoNlb9KLceqAAH3jYzB3FNGr2u+CBeX8vQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eXa6dT0+zDgcUD30J78aPPcZEKjW5O7nXqJgHuiCQEFK0uy+mZ03xFZVxm8mjidc9q9TanXxCPeUAmG4MPVnDSlAlNcHZ5WiTuSydmaWlrgzZlzckLjKLLdW9hKzTjnsnqLHsFfT82QRjR3NlNHJgTfqZyPcM2cpAk5lCxVYb14icIZzArxQ8mrcIiqM/YJed3FzDoKRqTzeJm08t8Am7QP47AX+wg/ffos1xm6ZWmpUMAUgLgOVomiUO7fXAjN6fODMAe1BEZ5FhMLc8hw3KZDIFbU8spLVjzoWVwCPM2WY8NwXTenbMwefozqrA4lTp3tYa73FpFX+iaiCNwOzb2YLcLeR7c+gFIxht08xixiz5n4K8EV4C/UBU/hSn2hfGaNlJWBd07x9U7zD0iEenQpU9NKVAF1AjKZGZppg05iCyfXfQkVroXacENBEOTt88L6LrMva28xV6WP4JTMwCQx+Zyd9jLaHw7hM015nCLr+kJkbv3zQOVFk2SkyG4QuAMnKcs98SEjFH4uOpB1vdroSigxIG/VSad8ryYMw6ZeGO/MozMurLqdw8kdbEwlStUnczhJMpUurdIY4vWHIIrmlbUAIhdD3HHnRW5Rlvmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3c190a-3f47-41b5-6cc0-08deee3782ac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 12:38:52.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV4LVeQ1bU/EbPPSF7ajGEC9qhshgBmWZbrZ+RXPYOkPZ6OCLmnDGSRV5Gm9PEiYNFC8RE54mX/BBWPVkyft8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607300094
X-Authority-Analysis: v=2.4 cv=OPsXGyaB c=1 sm=1 tr=0 ts=6a6b45e1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=kFJTeDM6s70Eq_2oaRAA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-ORIG-GUID: wRc1i0BWV0R2ly468CyBYH5egNCmQ_yf
X-Proofpoint-GUID: wRc1i0BWV0R2ly468CyBYH5egNCmQ_yf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NSBTYWx0ZWRfXxJeqynnZOVxp
 lf+XDclFe5z2KANYUeDOYK69I8QB8+JjLk3R9i3C+SXFa5s9VLWcbyzX7z/g9OSgJYlJKpVK8Pf
 K14AxGZz0MzA52RcAJZdNUTc9Sugd1KZWqaOI+qPbWVYOBOgz1xc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NSBTYWx0ZWRfX/UzeryEy3kfP
 N0VaELoUfns+RNeQYJ6obqefQ8/Xux/EWGkIv7t5JlLy18xIsDF7hLAVKgVKmgSjSN+sCUgTssl
 QQlv+h3eivUXZ1wfi1LexLW3/I0pHpdwc6iVZt16ISZp3UTvZkLR0NUYdGuJ89yilflXonAklR2
 7pSBdGumQ4QnzCvuPvOCzaYOqy6D1zBwzdXXSnDYCiAxaSdyPoG8m9IHLO90in8SNhZkiQ9Nu5N
 1qENJN6nxwIPcnaowoY/E0Ekj7N+a3hAFrSd6uud4fMD72f452LwP1bXLHEyNnavb8yJa9/7oRN
 FPViGm590T8+rJRNvh25x/pbqLoVB0Yd9P1Aqr5XZwNd1+o7RnZ88H74o3hmT5Lzj8z5pNTDGIQ
 MzVdwBYstymSxsqI+H0kNcc1YSf5Fra1fAZ0rsZl4NIYlMfS2oOuC09n3uGBNgwh6KBx4qVNEY2
 w8/HRRrnzgKSCzQsjNwMeKnsQJEYQwRaVdZXcEts=

On 23/07/2026 00:35, Ihor Solodrai wrote:
> This series develops resolve_btfids in preparation for bringing
> kernel-specific BTF transformations in tree, which will reduce kbuild
> dependency on pahole's features.
> 
> resolve_btfids currently identifies kfuncs by reading the "bpf_kfunc"
> decl tags pahole emits into vmlinux BTF. The series switches the
> source of truth to the BTF ID sets registered with
> BTF_KFUNCS_START()/END() in the kernel, which is the mechanism BPF
> verifier uses.
> 
> The series is based on patches #5 and #6 from the original
> "resolve_btfids: Implement BTF tags emission for kfuncs" series [1],
> and includes a few significant additions. Particularly the build time
> enforcement of kfunc flags consistency [2].
> 
> The series consists of:
>   - patches #1-#3 implement supporting infrastructure for the proper
>     kfunc discovery and deduplication
>   - patches #4-#5 expose btf__find_by_name_kind_own() and use it to
>     fix a latent bug in _impl func lookup
>   - patch #6 fixes inconsistent kfunc flags for HID kfuncs
>   - patch #7 implements kfunc discovery from BTF ID sets
>   - patch #8 adds enforcement of kfunc flags consistency
> 
> The resolve_btfids selftests patches have landed earlier [3].

I tested these changes and all looks good, so feel free to add

Tested-by: Alan Maguire <alan.maguire@oracle.com>

to the series.

> 
> [1] https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.dev/
> [2] https://lore.kernel.org/bpf/9b2196dd-443b-4632-ae11-030cdbdc59b4@linux.dev/
> [3] https://lore.kernel.org/bpf/20260617210619.1562858-1-ihor.solodrai@linux.dev/
> 
> ---
> 
> Changes compared to [1]:
>   - Drop the idempotency (ensure_*) machinery: assume valid input BTF (Andrii)
>   - Use rbtree to store the kfuncs (Andrii)
>   - Enforce full KF_* flag consistency as a build error (Eduard)
>   - Various cleanups and nits (Andrii, Emil, Jiri)
> 
> ---
> 
> Ihor Solodrai (8):
>   resolve_btfids: Implement generic ensure_mem() to grow arrays
>   resolve_btfids: Index BTF ID symbols by address
>   resolve_btfids: Keep collected kfuncs in a rbtree
>   libbpf: Export btf__find_by_name_kind_own()
>   resolve_btfids: Fix the _impl lookup for module BTF
>   HID: bpf: Make syscall kfunc flags match the struct_ops set
>   resolve_btfids: Discover kfuncs from BTF ID sets
>   resolve_btfids: Enforce consistent kfunc flags across BTF ID sets
> 
>  drivers/hid/bpf/hid_bpf_dispatch.c |  10 +-
>  tools/bpf/resolve_btfids/main.c    | 275 ++++++++++++++++++-----------
>  tools/lib/bpf/btf.h                |   2 +
>  tools/lib/bpf/libbpf.map           |   1 +
>  tools/lib/bpf/libbpf_internal.h    |   2 -
>  5 files changed, 181 insertions(+), 109 deletions(-)
> 

