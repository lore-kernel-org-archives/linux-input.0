Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D612550AF;
	Mon,  9 Feb 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644188; cv=fail; b=CelRqDGqbq3xJ8XHlCJVlJMh8IOYYOlVvh5UBuGMlooZZL+Xcc4NLz0t6xYxNsh5l3d+k0/xRU8erpdT5d/lUjMH4l5kcwI+iqnLoRiMWj/XPZqyQhYNrNgWZbDINuCcVm75CiWWIYqEcQOFwAW69EwqVfSqDKq/YhZXlpS0t0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644188; c=relaxed/simple;
	bh=ds6i39s7T/eDaKVZdk0tdJRPh29VVkgbCKK4BHahx5c=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=Rg/uH/XVJGfDt+NwiW4U4Jg1QkaVZqjacTpg/phBxuhtc95Hxlk2Jqu/Ce/HxH0V4VCb6u1ERx/bZGWwPCaYVMzzRt5sOXGuYW73p0BHdBUN3t5xG4Gu2G+jhD/3GE+24Ex0/D/xpqXHV7w9FXTDOI+mQOajfd/cEbXM7fZJVao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hvNSUhLT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rlBuy6i1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hvNSUhLT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rlBuy6i1"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619BuvMY1797273;
	Mon, 9 Feb 2026 13:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2025-04-25; bh=ds6i39s7T/eDaKVZdk0tdJRPh29VVkgbCKK4BHahx5c=; b=
	hvNSUhLTSBVTsPPefjKxwyPMG0Y1M4CkNRJR52WSgz8bjjqDC+8Njf46KPc9Fx7B
	FzbS0qgMS65Sw+/Nmy9xMF+UuHDkZrGnAMv9WRm49yV+dNqTv4C1irMRpcv+oHnI
	Kk8hkyCrb3Ag7YgU3z8k4KUcxL01ZlqqAQRpb6kS3FzfycuoAt4ZUPVPqenzJjCx
	q3E7otKhBCvA9ED+xiS9Ekba9GtxSSucRGZuenoE6a653RNXoBP4uisTrA2rltnJ
	euOmCwl3OcsFlNVzGX0dyvsdYly/o3RtDvBYAdi1fJDGZdN2kfgG8Sto1ehUt1Al
	vyUkWYSZ5WlQbqTVBVIjLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xfp1xuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 13:36:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619D1FB1000436;
	Mon, 9 Feb 2026 13:36:23 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uud1jc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 13:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwJ6K9/hZef5wCxi9wCOI/0ay5SPwhY3PCUpCN4MIEicwYZc1zkWZK50NJnMdADZ/OeGjqicS+a6NrbUlkNiIYcx7phzqlDe9ixNUe5FHOxj4+VC/Ug2S6Sc+6+Y14kRtVpKd7KxhA5cp317o64Mr+YlPWYFfNqcnYbbwRZMuPk8a5j3qWycnIEWFdHkkAD9IkwQfDJ4Nf+baj7ExJs+muMCgipvAcRZ2m6u4VNwFUPTx0wuuzC7S1jE/EK2Ht6YPa+ooAvHZBXYLU/1d5iCnQoc7ftZsdoIhCNtNOi9EtNriZXhSWj0OEJapWYkzNYE38l6Y5F9jbsuFgGVA0KNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds6i39s7T/eDaKVZdk0tdJRPh29VVkgbCKK4BHahx5c=;
 b=F4vNpy/VO2GNooRwC++GGwrIwyFXhRkuY94mgZprSbTLSRpfuGowiLtTRDOKs6Hy3aE+OseupGe2ddLka16UV/B6+GXebiDaB47ik1NU81+KFbbKIdt1egeVRnyRvNiU2NJb2Q3L6WzElog7fN34xgoWQN8Dprtdexv9Tyh7T5DYwOkAubWhddfnCkyJiYGfCi1F7SlXJQnN369psKiyFLXqXHMTk2crmMm5Xkrz9oCaRbr+BV4Mc36GEXRpWE8dosZo4+JlZzOonSGLkSuk/4prn9LErbZxpkGkmaT8GHSMnYy+0eaN5nVqyrVu5NmV/KUkMq5FJOg+T7TbhQHzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds6i39s7T/eDaKVZdk0tdJRPh29VVkgbCKK4BHahx5c=;
 b=rlBuy6i1nyYpNiNIQWdxTvTkBdden4RpDtDJGonrCbI0RHocXJS882LeI+YiE1ee06rJjpQ7nFaaVbhh6QfQwD87utmf/dr1gCD/LLoCXRs+Izm+4raRzeZ2hWg39KqWTMiId7Sf3nxfEsus4D4zsRY7SpUWyQm41kVqXA5ahM0=
Received: from PH3PPF272D9E96C.namprd10.prod.outlook.com
 (2603:10b6:518:1::790) by CYYPR10MB7628.namprd10.prod.outlook.com
 (2603:10b6:930:b9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 13:36:20 +0000
Received: from PH3PPF272D9E96C.namprd10.prod.outlook.com
 ([fe80::9403:fff4:cf9c:6d06]) by PH3PPF272D9E96C.namprd10.prod.outlook.com
 ([fe80::9403:fff4:cf9c:6d06%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 13:36:19 +0000
Message-ID: <fc66f27b-9a73-4a71-8dbe-f48609719d90@oracle.com>
Date: Mon, 9 Feb 2026 14:36:12 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        ricardo.lopes.esteves@oracle.com
From: Ricardo Esteves <ricardo.lopes.esteves@oracle.com>
Subject: [PATCH] Input: change joystick 80 buttons limitation
Autocrypt: addr=ricardo.lopes.esteves@oracle.com; keydata=
 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 tA==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------m3C5luZLYlECFMP6to55gvxY"
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To PH3PPF272D9E96C.namprd10.prod.outlook.com
 (2603:10b6:518:1::790)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF272D9E96C:EE_|CYYPR10MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 087c0ec7-15c5-442b-4a30-08de67e03525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|6049299003|376014|366016|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFVJSzB3aGNRLzlRQnppSDFMZVFhZGJseUFvUFk1OEluR2h6MlI1SnZnUHJ6?=
 =?utf-8?B?Sm4vVFRtQUlrTHAzWnl5cFFFTVhTaEtoUEFGeE4vblBEcTFDbHNkbTdjc2sv?=
 =?utf-8?B?eVlLSitKVFEwaHY3eDNiWWtBY0JSdzBRM1NpQ0N2c1hCWG5seEp0WXN2UEpD?=
 =?utf-8?B?RE9zNUJ6dWpZcnMvZVVEeDg4Qzk0dzlXdmRSUWxkd1MrZHNjTFpnNnNzb1Fx?=
 =?utf-8?B?YkJzMGdkM2kzVHhTdkMrSzJ0VUMwKzdhUi8xTUxuQkROaTB2d2NOYzMxMjNa?=
 =?utf-8?B?Z01hdW44REhxVVFkYUcyeHhzcXhaWnF6eGxjL095S1dhUzZiNkIycDIwTjJR?=
 =?utf-8?B?c081WFh0SW5aZVV4QnFlNENtQXV2V1VJTVRNZVF6V2pwdXBlYlZaT09rd3Nv?=
 =?utf-8?B?OGZCVitGUGN5UVN2dEQxZmw3NTNjcUY2WHhFWi9ZenExZWkvQVM0dVhPV000?=
 =?utf-8?B?WWpaQXp4ckUrZjBYRHgzUEcwSHB0R0FNbmV5NTJTeDlaOUNtM2pONmEyMjFW?=
 =?utf-8?B?bkFTWVpqVlhwVktIMGdTUzViTUJZc1UzbXExM21pNWxYaXVKWllXd2ltZVJp?=
 =?utf-8?B?UTJKdnZqSFphOEhqeGRTSmMwNzhqSUpjNVBzaDdtUDJDeWIyNXNiL1BsK1pE?=
 =?utf-8?B?NUlQQkdsRk1aTGhEQWtJVnVDdXRXZ0M2SkVSVGFLMmxscTArQnlLejluVVRG?=
 =?utf-8?B?cTNYK014ald6MHRrcmMzc04wd29nd3FaOTgwZllpU2o2dlUxNGk2WTgvUEVv?=
 =?utf-8?B?RncwQTZrRnlyRjVCdEVwTldyQkwwV3pzVDg1NzlkM0xOQWVJazZ4Vzk4NFVX?=
 =?utf-8?B?TFlGT1Z0TERnUTA5ZUs3NXdzeFgvSUh6KzN0R21DTGw0RXBMN3ErUU1OdHBC?=
 =?utf-8?B?UW5wOVVtTEZPR3kvYnZDNW11RWdTK0srbmFjT0FXZWhyUjRyUWhsYmF6NjBo?=
 =?utf-8?B?azhqT2h3QURHWDJzd1U2aGdwN0RhWTVXOFV2djJxdTZ5Z3VtTXFleE01QWZ2?=
 =?utf-8?B?MnJObFZSZ0t0eGRjVWVrOW1ZU1JQMDhLNFpCeVFSQUhCdVRiUFFIbU9ta3B0?=
 =?utf-8?B?MUYzdHBoUnhGSjUrbVRHN2RSY0tlNXlHSUhENmlVRENCM0hMTWtvTlF0WCtn?=
 =?utf-8?B?K3VhWXZiRFhwTWFJZHNCMzF6ZGcxMjRiK2h6QmVDVkdsa24ySjRLSnREcmRT?=
 =?utf-8?B?QUtTN2xYSmR6NGF2M2ZmSGFFQ09zRnRZNzdGbTlJVEUrWWFLRGU2K0xhYi9t?=
 =?utf-8?B?emdnRngreUlnTUVvS2FTdnlNSHVQNU40UC9scmMxQnRDVHJ4cHVOWE41Ukl2?=
 =?utf-8?B?d2pJTGM2UjB5aU9IUUs1bFM3UXhkUnQrWUQ5TlZQalBheWJjNVNPSHlTenZx?=
 =?utf-8?B?SVE4eERLTWE1WnJuUmpKZXdSZENjK3FMaHZQZ2lJQTJSdmZCZlNSNjY0SXhp?=
 =?utf-8?B?UFBLbWdid2ppTDFacktKaUxhK0lnZXNSanJNcHhCeUk4SDZ2K01GSDUwcjgw?=
 =?utf-8?B?SDlaeWwxd3gwdytTVThudk5oV0JKQ1ZMZ2oyMjRGYUZ5YVZuZG42dnNZWXpH?=
 =?utf-8?B?cHhOY3FXTE52c0tQcEJPVWlkSXZNMlNGVmg2RjN2NWVwNGozMWRiN3VqVzd3?=
 =?utf-8?B?MUNJNnh5dURGZXJVZ1I4YndERVFaQ0k4VkFZWFE3cDYydklBZjNhMVFBbEN6?=
 =?utf-8?B?b3NWNS9GT0JUY3o1YklJMlh3WWpHR3U5TWVMVUlmN3JTUjltc0g5YmNodVhk?=
 =?utf-8?B?aWZDNEJ2aTdoN0hKQ1d2eU9LQ1ZnSld0bWo5MTBGZWQ1a0tnaEZkS3BmOENV?=
 =?utf-8?B?MHhYQVk4RjZMeHI3VzFFT1RSQXo5U1l1UlRlS1RMZzkwWXZVRFZtY3JjN29H?=
 =?utf-8?B?M2I3VDlycVlQak45L2NvMFEyTGZSc0N1NjZTL1I0L25FUVc3TUZqa0tVS0tP?=
 =?utf-8?B?OVUyUXlnUEpsOFpGUk9jRkNoQ2xBUVY0dDdIUE1MMnJ3KzNYTkM2VkhIRlg0?=
 =?utf-8?B?Q1lzK1k5Y0paSDZYMHlpcUxTeURqbWpXb3hYbDFZdG5rV015VGtIMktkMEVh?=
 =?utf-8?B?VnR5NTRlK0o2eTA4cWhUSmlvRU9wZHI5WEZDaXFaZWZrc3ZuVVZLcElBQjZz?=
 =?utf-8?Q?k5rw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF272D9E96C.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(6049299003)(376014)(366016)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk9vVGdkZFFEdnFiMUR4dVg4YWVaMnZqT1hBTGJma24xRE9lbGE4MnphOVdu?=
 =?utf-8?B?ZnBBTDhTbUdTaHVrV2JNa1ZWMWpNYVFYOHdqRFhXb2Q5Rkg1QUlMZFAvODN1?=
 =?utf-8?B?RkxDVml3dTNNV2JQNnNuNFZsZG00UXNaTzZGcUdjL2llYmdXeE1VeEpNVkNH?=
 =?utf-8?B?UVQzcFFzM2VUeVdwK3o0aUNnalV6aHlob1NBTE5OT0ZGNU1mTGVsdWNoQnZO?=
 =?utf-8?B?bzV6Zjh6RmVNc2tnWS9UVXNKZGRUTlRFcm93d0g2ZEh0UGRMZlNla3dWQUlC?=
 =?utf-8?B?MGFnQUZMUEhVYVpJQzY3aEVkNXlQcVgwMmlXdDlCTmFQNVRMK2xhU2cwbWJM?=
 =?utf-8?B?TTJiZmtJZUZwOEY4Zm1hQzNod1AxcklpeTZSMDREZXFZZ202YzNQb2MrMHh3?=
 =?utf-8?B?VmxVQ2lyNVhJSi9zbVhITmJWSktHNnptVEZuUWtCTEFiVy9VOFJvWXBFcGMw?=
 =?utf-8?B?MHRQZFdYVUFROTk4WXFZVDBoTUxnTS9yUVpyV1dHc0dld1hBYUNEOUVLV2sx?=
 =?utf-8?B?VnplaDZ0UjNkcGNjTVU4ZXFkZjZLQ09pZ254Ulp4eEF3Q1JFTUhSa2R5TjQv?=
 =?utf-8?B?MVpzRlNwQTliZ1MrWTFSNm1POXBXNnB6S2xSVlY0L3dxblJiWHRjRy9ON0pz?=
 =?utf-8?B?angrY3U2RGZENEZwam9hM0JibktKbWZiKzNrZ0NtcTJUckhQODJnKzk4S1ND?=
 =?utf-8?B?YjlpNjloUXN0a3VhNkl0NXhDZ2o3MUltUEQ5WlhoRVBxcGs1UFg3Y2hmdGlT?=
 =?utf-8?B?OGxJci9LdXNidXRQN0EvenZndXFnYXY5elB5TzNIOVkvbE5ONVpudzAwZFJ0?=
 =?utf-8?B?K0t5cUhTYXNPajNuclhKRlJZVDVzbEdBQzRqcFR5VWErZDR1Y1dkQW04ZzVk?=
 =?utf-8?B?QTJOOUVObDNHT3VSZDJxallrQjhmWXpsdWU1NTNsS2RXbkMxdVNjSlhnQkNY?=
 =?utf-8?B?SmVSSnJBN0EzOURmSzFHZnFoUnBnZEJGNEZGWnVpMUNGTjkxaE1mVnUzSGlt?=
 =?utf-8?B?bTdXdHV3YzYyQkVwVW5nTmNjTXF1clk3NVEybmlHZGJYcEdlR2dBS0VSdUx0?=
 =?utf-8?B?SHFrdkRsRVk2YVZUOEJOM29Hb0ozR2M0UlE1cVBydHBWNlMrRUwwUW5POTQv?=
 =?utf-8?B?cjI2NDhobnQ4b1NVWjVkaHNlWThIUmlpRmtVUXJTbG1YTk9rcWRGWjZPOG9j?=
 =?utf-8?B?eE1DZ3g2aThyOXhjUWNyUkdSMll5UnQvNU9zak1jbHlZUEgydmM5TTF3TEJ6?=
 =?utf-8?B?NEVyQ1d4NjF4SWdBVE44eGNhSFpjQXFhZi90VGhLeDdMOUtucGFkV3JlNkgy?=
 =?utf-8?B?ejRpd1MydHhwclVtbmRhYjFXRFZEdE1IeWVuQXlXSmpmRm5Sc2ZMbVVyWElt?=
 =?utf-8?B?RDRFcmROdWdoT3hpMEx6d0dIMmptUy9HWnY3TUhERjhLQWpGamtvdzhyNC9p?=
 =?utf-8?B?aHJ0QURSNzk4dnM2ZmZBejZBVXdORFIzRVpJSXJQT1JGYnRVV1I5akh1Z0xh?=
 =?utf-8?B?N0p6Y0VFZElvSUtUTHY1L1ZXZG5KbzJvWEthV0FlL0pYelo2eS9CTzFING5l?=
 =?utf-8?B?SGtwRUR4RUlyVmJRcG93RktuSThhT09SRDNmVHVpWVh1N3kyWnhqV3lEbUxa?=
 =?utf-8?B?T3UvbUhWdlMxZ2R0OGZyQXhGVW9iV01qMnV1STVVMU1jWmN2dG5wQjlZNkRO?=
 =?utf-8?B?VU5jZCtEU2dteVB6MEtJYUgvMncyWTQ4ZFZ1NWpGN25UQjhGaFUyMVZDQWVt?=
 =?utf-8?B?MCtNTnVsZ0w2NnFHbkdMdERmdjREODdnbkRKMzRPc2RBTmRwV3NLR3NVMFA4?=
 =?utf-8?B?WWxvM0w0T3I4ZXBVc1pEYzdBdFR2OWYxK2NlZ2xVNTRjcG1UbktzUkQyZGZm?=
 =?utf-8?B?RHRqbXkxQWpBVVdhRWZnbnFnazNwZHl3azdYTlBxc0xUNzFiMzVPU2JRVDJn?=
 =?utf-8?B?ZzRURkpQRUJGQXRpWnJZcjBKUG9pZzFDYnVtaWRvS1F1dTN4NGtmZnhLTkFj?=
 =?utf-8?B?bnVqRnhNZ2t0d1doNU8ydERMc0pUVFhtck45ZzdMRTZpeVBMRVFmT3pyaDZH?=
 =?utf-8?B?ajUwMDRUL0dSdUo4THJpWUo0b1kyT1doT2RNU2pRUHNKOEM2bEJtVFVGWFdx?=
 =?utf-8?B?L21tdEtISmJ0V3ZPT1NwaHIrNE14V1h2a1pmUkNRT01PR0JlSGxCaXR6bFVs?=
 =?utf-8?B?VmdkMTR3WGVSSm5iNEZZaHRIT2kvUjlweDh1YkJIdjN5QmRJd0pQS1YwUXUz?=
 =?utf-8?B?cFZhMUIrU3pZZGRkMFNRbEJJdkdBeExvRVJhdnhpaUFBcTV6NnVCc2MvRm14?=
 =?utf-8?B?cW5yRGxScWZaRHdJZlVna2g1RXZBUVFEb2ZPRFcxbHU4dWFhOXVLNlMvdWxk?=
 =?utf-8?Q?IIh8nAAeXCNBjVR7ScKnbGIj5PIOkgZXSZNr/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gbC/p9Myntv5cYB96qmgpPRa/5X28jsQIcLAF+8hCHWk+xRJpg3z/lDpvIM5y0e86Burlqw1lixlivLuDeeVrtofQoYS2o/nsSC+TFcPVtpx4SW1N7++M5j/e3IqFO9E0m1Goe8LpowLjzdqVGqgqc2XdCOS+nn4CJY7xb2VxKmcRPKhqnmjgpM8cVFGIrCzMdlmGR/bsN6buwbq00fkPKnuCyjgwlGZKsBXvjUZxZGEXIFcEfDXgFp5N+n7yf3ZdwRsHHe1u7Fxy1pmm13VorZ/S3wXgZFmq46ESj9izkDmRD5T8qkSXafKp7pWuxT8aqbPUpAxyrt3QX+4H2+lHCNEb5lx8+Mb/6yjFpyZ4QAzhAW+71m2VVVYPwAzjNXyHSa/8XIjdCfrQru9NmEpalm5bpvCfO4HinjWLFDbEZoDXl+cnhkxtu/iFZqakvHVbLHT9hggfbS9I2dV6gB2cLtFG3rMvWa87wMoCDu6JjyuTB96zeek4YW3UoNomdJAVL/ZY2I2ciW8Uhl2voD/1w0Pm28j/fp+IoPfytV+oHWFgjrtzC2JRwbr5m0CrZUde/qV0GRY+KPOQAgl3lRENquG60J/4McjZ4DgMp4RnhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087c0ec7-15c5-442b-4a30-08de67e03525
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF272D9E96C.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:36:19.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0AgvBxPA5qXTL6qpIrqQEa0HE0W7OSlNWRpOZyWITWr1Ce6JQPRsI/idRaCf7hpMNWgEnbZpNVSShJMeGa11nF/Ud0Moj3ODs4N35Y/dBB5lg1z6SsufCJDWj3B427i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExNCBTYWx0ZWRfX5Eyo/tBnrizl
 lvGJQ0LZCLndfRS2+MNtQXskDYh56WLfyIPL9JPlvo8mqDepj8zpovbjXScFCRgsNoLF+rUL8OY
 AT6koJDiPCXeUQLBiHt1mGghW9GXjWTu/psi4t0flKxEH3++V/a80QloV8B7k1X56UYI26sBQ6o
 WxBBjOpzJhZWm0Y3l/3UgfBmcLYQZAt1QCzhFsX5DQZpg8sOB0ZhfVLnxzK22vQcgoxKAUQtyjn
 ICra3K0mZKWeMcdAmQOSr/vB8uq4V8uF4hboanR8QMkpumMTQd7mvHC+1X0noUVhMzCL/7aaudD
 xGWrzK9OmsHGqLyn9bCd7IFdUtDSDIEXdhbHKuUtiyLjn8zbbXljxNUZRH2WT5JUFCTnpyFuubn
 hV/FqeXZawtG+zhxyt3zFiD9i7Ip0ESSgut0dfg9hK7m7hkk7dNvcyUw57f9BOKw8J/r4zJeH8W
 YmWX7zL34d8IJIneBL8rUtpK62T5KB3KXl+akOP8=
X-Proofpoint-GUID: 8nA9RqZCeKidUerVksOGtlnMgBoT4dPe
X-Authority-Analysis: v=2.4 cv=V8xwEOni c=1 sm=1 tr=0 ts=6989e2da b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=XyCBdyJe_xH6DId6t_8A:9 a=QEXdDO2ut3YA:10
 a=Itayem3rw-AL0rx2JOMA:9 a=FfaGCDsud1wA:10 a=DoVTsoni8T-BmjqBbckA:9 cc=ntf
 awl=host:12148
X-Proofpoint-ORIG-GUID: 8nA9RqZCeKidUerVksOGtlnMgBoT4dPe

--------------m3C5luZLYlECFMP6to55gvxY
Content-Type: multipart/mixed; boundary="------------d0ougI2NZQpHe4nWUk0b2vft";
 protected-headers="v1"
From: Ricardo Esteves <ricardo.lopes.esteves@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
 ricardo.lopes.esteves@oracle.com
Message-ID: <fc66f27b-9a73-4a71-8dbe-f48609719d90@oracle.com>
Subject: [PATCH] Input: change joystick 80 buttons limitation

--------------d0ougI2NZQpHe4nWUk0b2vft
Content-Type: multipart/mixed; boundary="------------5qsHhtTYmPuvhjiqSXp8LWP1"

--------------5qsHhtTYmPuvhjiqSXp8LWP1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Q3VycmVudGx5IGxpbnV4IGpveXN0aWNrIHN1cHBvcnQgaXMgbGltaXRlZCB0byA4MCBidXR0
b25zLg0KDQpUaGUgZGVmYXVsdCB2YWx1ZSBmb3IgdGhlIG1heCBzY2FuIGNvZGUgdGhhdCBh
IGtleS9idXR0b24gY2FuIGhhdmUgaW4gDQp0aGUgbGludXgga2VybmVsIGlzIDB4MmZmICg3
NjcpLCB3aGljaCBpcyBlcXVpdmFsZW50IHRvIDgwIGtleXMvYnV0dG9ucy4NCg0KVGhlIHZh
bHVlIGkgcHJvcG9zZSBpbiB0aGUgYmVsbG93IHBhdGNoIGlzIDB4MzFkICg3OTcpIHdoaWNo
IGlzICszMCANCmJ1dHRvbnMsIHNvIGEgbWF4IG9mIDExMCBrZXlzL2J1dHRvbnMuDQoNCldv
cmtzIHBlcmZlY3RseSB3aXRoIFdJTldJTkcgT3Jpb24gVGhyb3R0bGUgQmFzZSBJSSArIEYx
NUVYIEhBTkRMRSwgYWxsIA0KMTEwIGJ1dHRvbnMgYXJlIHJlY29nbml6ZWQgKGlzIHRoZSBq
b3lzdGljayBpIGZvdW5kIHRvIGhhdmUgdGhlIGJpZ2dlc3QgDQphbW91bnQgb2YgYnV0dG9u
cyBzbyBmYXIpLg0KDQoNCi0tLSBhL2luY2x1ZGUvbGludXgvbW9kX2RldmljZXRhYmxlLmgJ
MjAyNS0xMS0xNCAxNjozMTo1NC41NDIyMjgyMjEgKzAxMDANCisrKyBhL2luY2x1ZGUvbGlu
dXgvbW9kX2RldmljZXRhYmxlLmgJMjAyNS0xMS0wMiAwMTowMDowMC4wMDAwMDAwMDAgKzAx
MDANCkBAIC0zMzMsNyArMzMzLDcgQEANCiAgLyogSW5wdXQgKi8NCiAgI2RlZmluZSBJTlBV
VF9ERVZJQ0VfSURfRVZfTUFYCQkweDFmDQogICNkZWZpbmUgSU5QVVRfREVWSUNFX0lEX0tF
WV9NSU5fSU5URVJFU1RJTkcJMHg3MQ0KLSNkZWZpbmUgSU5QVVRfREVWSUNFX0lEX0tFWV9N
QVgJCTB4MmZmDQorI2RlZmluZSBJTlBVVF9ERVZJQ0VfSURfS0VZX01BWAkJMHgzMWQNCiAg
I2RlZmluZSBJTlBVVF9ERVZJQ0VfSURfUkVMX01BWAkJMHgwZg0KICAjZGVmaW5lIElOUFVU
X0RFVklDRV9JRF9BQlNfTUFYCQkweDNmDQogICNkZWZpbmUgSU5QVVRfREVWSUNFX0lEX01T
Q19NQVgJCTB4MDcNCi0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9pbnB1dC1ldmVudC1jb2Rl
cy5oCTIwMjUtMTEtMDIgDQowMTowMDowMC4wMDAwMDAwMDAgKzAxMDANCisrKyBhL2luY2x1
ZGUvdWFwaS9saW51eC9pbnB1dC1ldmVudC1jb2Rlcy5oCTIwMjUtMTEtMTQgDQoxNjozNDoz
Ny4yMTgyNjM5ODUgKzAxMDANCkBAIC04MTcsNyArODE3LDcgQEANCg0KICAvKiBXZSBhdm9p
ZCBsb3cgY29tbW9uIGtleXMgaW4gbW9kdWxlIGFsaWFzZXMgc28gdGhleSBkb24ndCBnZXQg
aHVnZS4gKi8NCiAgI2RlZmluZSBLRVlfTUlOX0lOVEVSRVNUSU5HCUtFWV9NVVRFDQotI2Rl
ZmluZSBLRVlfTUFYCQkJMHgyZmYNCisjZGVmaW5lIEtFWV9NQVgJCQkweDMxZA0KICAjZGVm
aW5lIEtFWV9DTlQJCQkoS0VZX01BWCsxKQ0KDQogIC8qDQoNCg0K
--------------5qsHhtTYmPuvhjiqSXp8LWP1
Content-Type: application/pgp-keys; name="OpenPGP_0x9DCA12A350F395E0.asc"
Content-Disposition: attachment; filename="OpenPGP_0x9DCA12A350F395E0.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
J0r3Hz5uW0QZZBP8tA=3D=3D
=3DnpJH
-----END PGP PUBLIC KEY BLOCK-----

--------------5qsHhtTYmPuvhjiqSXp8LWP1--

--------------d0ougI2NZQpHe4nWUk0b2vft--

--------------m3C5luZLYlECFMP6to55gvxY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEjFgxbIZFDeAgiyYFncoSo1DzleAFAmmJ4s0FAwAAAAAACgkQncoSo1DzleDt
uhAAqK2TSj1lL0SvDPYET2o5htWaKOtCBKDgJuSSzvxeYpTjToe1oMIex4RD4woYxDGp0iYCa3W1
+g8tRItjA+4bwysnz1PowVgyfXYDI8zl8AJSxJBJPdg5xmcPl2a6tMj/t0W7iJ6K4pxBZNZrsG/I
8K7ilQOTdUX8ovWFfYyccBYkZfzyupHFgNmKEBsgIk78BItRjVe3EDPePF7feWxmht7wd5ewgGpM
qOV3PEn4Chql+xLcAycP5BJ/aPxK0zbmN0eD8F2M9kjFSHXhA1DFhB8dvJKvzhmtxP2lTLC5JMyS
/jsYN/2oB3If552FCwGKJiWqRX+NrRovc9lkqCUwAwgTMmPVJwaA0Ga20owAjFl7x8ue7h3QhSas
UXwvQY926gpBBsaxdCH3PXpKqN1HV/8gWcD0LNwiedCbNc8f93Azt1ZY9/eR4BAmCXnQkyvp86lO
/Sgj9mFcYYLKGSL8coYZNQADxRIYLUJjmUbGJEz2QBWm+nJ+c6ym7YNnJwr/5Nfcy34pz8Z4DGzh
xSXNRR+sD8FfVXx+4uYVTbudTKtd0WTCs4PqiaEsWcpQruEKAfx0dmcgJf4R83MXUqAfEMfXKoiV
Cr8oU9kpUlvjDopuDoDE99AiaCm+sbXcpMBQpCEPeIOedxkm/FdF6MEsGdTr1WpFm47+yIJADx84
Gd0=
=HqQY
-----END PGP SIGNATURE-----

--------------m3C5luZLYlECFMP6to55gvxY--
