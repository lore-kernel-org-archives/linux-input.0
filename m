Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55874359A8F;
	Mon, 16 Mar 2026 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704934; cv=fail; b=YXziCTYyRCBQ+HCMt9glacV97xeWPYmQN0U7K1Ooq30/pY4ThPSdAHmBnpylf3RckEqRwzWor3wrgPs4ENXt3cBl7gfg7qas02x0YnyDesgSlEXVnPCfiYP3JhBuFkZDfZ5i2zo3KU4xJulLdM24ELQlyKO0oP9un0Z0UI8EZ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704934; c=relaxed/simple;
	bh=cbH3KrntNiwMIKBeF5t8p1lIRWWvN5WoBGbOQDy7lZ8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUIElMNXUS4TPsMb0OCkuGuX/Hc/qQAgiK4LKHTzseqNymPsgHzRXDA2vImrV32F0e7IfY37QdSMTmJfuHW8POKXX/ti0smNXGDyi8uy8w4tf5INhS7d+8dPKxl+cyZjkUfcYH/Q82dIe1X7r4ajMhFfyVqgeHnVMaYydq61j+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MXvCreYB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BVzxZzjW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MXvCreYB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BVzxZzjW"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GN7VmF3005786;
	Mon, 16 Mar 2026 23:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/aSEU8NgcQsko6h/LP74Z9831r0EkvxUfymBgAX9yGc=; b=
	MXvCreYBb1SzIGgvYypcGkpyJzW5Jib3omwf/uxyO7AmsKe5WgN4aPtjBeJvmssx
	+ETYHKAXv5lTee1i8DigMvaegw1f0Mgp7HjP97CJqG5LsrhVtbOw5grDsmwPXraV
	B8ENO0HuqqmUSV65x83ii0lvGkArf7YnfQ6cqoRph/XLG7tRTa11SZ6wQ35Kc1SR
	FC6hkgKtVNQKvx6DN7iokIY+ZS/mP7iNt3adIvWiVI0v6t2Jx9BptmCnJuVmI0rg
	mDHeSc5LDa9t2ozn7aPlstDMEaosdqSuRp5R6AyMSwqfhMlV1za5dfkyg2aF1++1
	HiuXHdAJveksjNJRGTSjQg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyqbu86y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:48:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GLT8od002698;
	Mon, 16 Mar 2026 23:48:51 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4kj60y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:48:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s74/0gO4y11V1Im6Ac9lvgLnkSpZbjtignXL7IpMiu9HvZCnxcXpSMUQGm/C/nh9s6fKemFxv88GJBAhaHZ73E5Sxttb4vAjUCVCzJE3I473gmMFN3xNEczB0YpuM/QLkuZ8A7oPhDwP+LSuWzsBpFiSCF7Nt7IN086ylNv+Dzk395RB0xPrk4oxdaOpr7BqTWHXIt8YfG6vi59pszOxfPTtWtEjCnHlaufThYNWLOO9sQREZBR5GPCYYQ/H2ty7TZnJYAEfn0p96kwKZDVpQYtff7YbsCTD45WoCHSlgavhY3kh4AvfMDyFWE0n4ZP0Gx6R85BV2TnuHA/CPvkqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aSEU8NgcQsko6h/LP74Z9831r0EkvxUfymBgAX9yGc=;
 b=f/q7JYg6kZUPTiLYOOeNZkXfyYVWkvzhbBo7J6kAfIUw0/YtD5WFcma0IJLBKYnPzOc58MZFa2eKPzQmFKR2bJMCwMxzazdFGLl8Pj7NBvGyvrevaJrUTsF57ZwolPLzpM1Bq9Dkr9P1MewTd8vyTmb9WYGADok9sjRBdtIXcJhZ0KwhMrtRltUmZwtHVNbQ+smV1NVIO/j6oWUowHFdRi5Qgr4iYHLJ4QIsy/M6mD+JOfIiE3zc+2xWOGhsr3mMd6/Sp+75Hj/yDk9J+XdGAaxMTwVg6UekeuqC/n7vY8PNPGgdWlfZ6Ws/ue/Ide4ZqJIIzf6IAHI8DO2PrD+SyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aSEU8NgcQsko6h/LP74Z9831r0EkvxUfymBgAX9yGc=;
 b=BVzxZzjWvY2+VXKx+aJ6Yx2F/Dblz3x7pfJaaFvMU8zycvni5RQ/O5iv0FBTV69cBC0rzmElnpIyD3QKC0PC7w/zz1dkJ4PRGrtnTKTxlXMenBu5PYpSywbhf5nAckU7lKSRS5TGw8d+piTedNpEgXgMSKMCvQUrr4ll9rKIsY0=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 23:48:35 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9700.025; Mon, 16 Mar 2026
 23:48:34 +0000
Message-ID: <e35b4f27-53c1-41c2-a321-42a34ade9839@oracle.com>
Date: Mon, 16 Mar 2026 19:48:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] Input: sentelic: fix comment typo
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316181200.146681-1-joseph.salisbury@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <20260316181200.146681-1-joseph.salisbury@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::29) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|PH0PR10MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 875f1bdf-f78e-41a3-6058-08de83b6892d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EtDZWrI2xsKPMgjJA9hTXRpIhN+Q+UvJHmZYlk/VkHW59WEQKF0wJx3uE0j0DLNuON2I1i2O8vZERFsRpXVaj7X3aIgtOU32kJBKTAm86EWQAlWoB+wB/VxFyh8W7r2ndLC2z5NYPolgfJiO6jOX+7Wbw9phaJE4TWfkXG3rNZnp+QIg5dS0LHSNr73Nwa8CA5va0JUuIWSLUR8x57eOIxSpa8zJXI9eoaZz+MBGQfCdjsUA7jtFa8syVEoJdrIs3AwFUjgssM2t809nwaOd9HCRyqQTov9r4iRcDN+c8wWJcPt8cq9YehbDrljuEy8ruecSRh1IcAEPFghebTelQNSjEwqX3qzbkbF7u12tzAM+saa3qyZHH/5JM9cdO/3upLltd+yz/Ot0bfVBlaGZqhpD9RCzGffAtsqirDM3P5a1zkBPrGUD/S/ntsUcbJm0/rgzn5GHi4HXYBS8m1FtkPF7DUCBTM9C8vqWxkE5fVbMqbN90fBjEDml6EE1lk4nexwVr4gAIA/gFiEVQdCY9oYmLRozVTWh6SXJ6AXJFw3Dinu4q1CH49i2il6K6OfRCJODOrQeFM/Jw3WPDMLcIor67owl9bh8VLm22PPzD1piNMpNbntaTuUEZqFX3V6qcHe8oMgZTmLRi2VMkaLx4rTetjnXKw/Nhf59hDpS7S9qIvosdV1r2XkMNkCz5TgKKp6fXJKECtlZtfxbuAba7StLxjON/cAMU5m+sgo2A9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckZ4b0ltMXZaZzcrWFdDYTNNMmlPSldzdUhGVU1xTGRmMytTZVpmdmRFOG1p?=
 =?utf-8?B?VUFHSFRNSWZQcVRYc1FyWG5iSlE2czdHbzVVRkpkU2t1bjRqVjFjTEFVam5Q?=
 =?utf-8?B?OEEzTHJuVkNUeEQ2ckFjbHliN2FlL0lLY2tMODJML09lcDRDc3VVVCtKeE4z?=
 =?utf-8?B?bkd1QVpVUWRsK0NMYkxvaDAzUVZCQ1A3QUFGaVVuQ09BdzU0T01Db0h1VTJS?=
 =?utf-8?B?T3MraWhmbFFwUjM1TnJjMEQwWWRESzh0UFduYkdOVUNJSnUwRmFnUVJ1aW9j?=
 =?utf-8?B?WEh3R09RL25sa0JBUFAwRHp0bk1sL1pLQmhqbmhkbHRuWXdZcDlDV0cwd2wx?=
 =?utf-8?B?RVpYN25oVHVTaUlkTWNEODJXdFE1SGFjeDhVT21ENDVBV0NDN0VUaE1oNHhV?=
 =?utf-8?B?WkRQaTFWNnp1YnExTWlMMjRjdGw3SisrMUdEVDhVWWZFMit5VXZpQjRjWmxy?=
 =?utf-8?B?MXlCU2hPQzd3NXVnVFdYL3RGOHk5K3NCN05DbWo5cktzZDVhODJHYzlnZ0o0?=
 =?utf-8?B?aWdNZ0dTalBPZzdoeHpla25LQ3F5RU9hVysvVjdDK1l2dnJYVGxINDVremky?=
 =?utf-8?B?V2ZTWmlmTndZZnM3a0dYNzlaeElLdWNkazNXbWx6Yk80M3BleUIyeHVjYlg3?=
 =?utf-8?B?YmxGYXlLVDZKSFVzdnB2dWpNUy9FNkgwSnpoMkllSlQzWXQwNGZyT1huN2Jr?=
 =?utf-8?B?L1lJZEIxUDZyc3VzK0Zvd2xsWE83TG02b3lWMERtUHp3S3RlRG90REFDdzFP?=
 =?utf-8?B?MW9uOUZpYlpXbmxKNmk1azVFZGR5dFhGZlpSaWF3ZTN1c0x3aGVmbTZMaXdX?=
 =?utf-8?B?TUtxczEwazlNZFpJeHQwODdUczNqVFFXa09SY05wTEJmMnJwUzFKNmtKKzh2?=
 =?utf-8?B?VTlFTXpyR3YxWmxzRit5Q1NLemR4STlpaVZWTjZCVHR1dyt5Tzc2USsvS3lI?=
 =?utf-8?B?V05abU1RS3lVZzIxR1JpZnF1aG9CZUFqVXUxOHdheS96VVZJbnVtWDZGdzBX?=
 =?utf-8?B?SDNYcmRhNGQ3N0RXQSt2SVcrcVBGZFNkd2FGR24ralZ4V0dRSWFJazByb3hW?=
 =?utf-8?B?c0l1bGN5OHJnUTZwblNNSW5GZVhlUStPQ1luTE9EWnd2MG1kYUFIc3N1aG5D?=
 =?utf-8?B?RkFQNEo2aFhucjZuU1RGT3ZRZEpLVlRUUGlreUlNNG1SVk5RMGhQbFhsZlZG?=
 =?utf-8?B?NnJHTnFqZzNFRjFmS0JadWV4akkzN2tZaGFvbUxCL0R1ZnN6S2llWlRZeld0?=
 =?utf-8?B?S2I3Y01RT1BmTENlQ3ZyT2I2Ulp2bDhpTlZ0VWQ1cUdHZG9ibWprNVlyQ2pt?=
 =?utf-8?B?bEtyR0wvVEFxUjBSTzNaOEQ0WmErb2NsMU02RFZEUXNJNWljelFnUFBTZEJO?=
 =?utf-8?B?Z3o4U1I5RG5tY0Q4bU9vc3A4TURYZTNGL2ozTjlOZy9JS2xEMStHb2VKL2Rh?=
 =?utf-8?B?MDBPZzM3ZE9jb1R3MVMvaFJlUm91cUFRYTBwTFZzQjRzb3JpTndjTGlBOEJJ?=
 =?utf-8?B?NzZuVzNJNUV1a21VMHpRRitFSnZ2L0R6dWEwNDl6TG0zNXRoNEZjdXRFeVM0?=
 =?utf-8?B?Qi9Sa2dWQ3RkZ2h3Tk5HVVpFS2lZRFlOc0t5a1JEYlhqNjVxWm9ZcnBqRkV4?=
 =?utf-8?B?UlJUQS9xRXhhZHN2anZqc2FTN3JnMnE0NDhIbm1jOFo0alk0SFhjb3djRnVJ?=
 =?utf-8?B?VzhMS3Z5eDZuaUc5SllrRmc4SXU0U2llbUc2dGdvZmlXV1Voa0dSYWxBSHg0?=
 =?utf-8?B?SXJJUEI0SjM0UStVNk9jWXAvYUUzK1pzZEFIcWZ5Q1ZsS2pEUk8xcDlBTnYv?=
 =?utf-8?B?WVNwVHVyL0NPc3VUVFk3VUR1aVJPclJGM3htdUJ3cnBrbmU3OW5ydkVEYm5h?=
 =?utf-8?B?MVEyYnNIdTJ1TDVHbGNsczhaK1ZTb2tmMGVHMWtzNERLZHpjanlVOGk0QUhB?=
 =?utf-8?B?RmlDV08ycERmZHlvVWh1d09zUHNjVjhyeXdjRXYwUUlyM3doWXZ1Rmc1UHhD?=
 =?utf-8?B?Z2hybG80MDVRdUdydHY3ZURDb3haSnNBNXJVcUpjdmtsY0doZ1owZ2dlSUtF?=
 =?utf-8?B?T3NnYm9vc3p5YS9LNkgwWm9JdFd1VVNLSU1CWU1SdkdRcTc0T0hkZFdJRXU1?=
 =?utf-8?B?dklBemlDdm5wWTJ6RmYxMXpGNEVVN1ZjTUtIMlJCaWRBanN0SEhZSWFiT2tT?=
 =?utf-8?B?RGMyU0NISC9uUy8wVzZEZ09qY3RPd3JDY3pYanlac3hZTm1PZWFaSnpQcVZ3?=
 =?utf-8?B?bGRKWXhKdjAzTTRBeFcyZjc3cnJkRW5BUUMzVkYranptSlRHTzBCaFB3bFYv?=
 =?utf-8?B?K0c0YU42VnYra3htUkliNmNYQmplN1lONEtKc2VEY0dsMEhZUC9JcnFMaUdH?=
 =?utf-8?Q?TMeqosl+h4bAPnk4=3D?=
X-Exchange-RoutingPolicyChecked:
	XB+vzQuXVtlLvhK93WAClAoV/QQKkO5Mu7I/Xi32cDQaMVajktlAuRWhxAV1wWQjF4y7R9zh+8KSxACuGAWH3cj0B0cP5AJuObepWpI7PUdSNk+F1Ea8M0NWwntOiBAWW0/PQuFpkNUjFHJFK1ePOqHLYRM2DbJ6ZeEU52O2hl/gKxv6HwZIvfXPycA777N/Yjrme3JUa3t4DkUS3AUGWSXFPQCWrSGX4BwMnHiDm7eshtbnBdhAyfgcz9FoPLlHIIGj1vWLg2VRfzgpCETCJfPmvg4+Ovv9Dku0xoCd+UPufA+F+Rrsf1dZ4Qje8npw60gYcSl12SG8aeYVM2Wdaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dBPyEJnSIohX2mai9L4PcGsT9ePlZil4tkV2aDgOlPAoFGJ7qHaTWG4hwnaW1/QVAuxD+kmV2QwSX884XSjaZ1t39JIoYNBlIDikuECp6TKEEIbar1D+8+4MuzIto6bcYhK8pgafDwjW75GV2CZo20b2QHA1XlPj9Ns8+kHoUAXZOE2GOmwvP6qpEyI9kVh2VwBrXYXzcvFqh5mBbUQBw0YAxcmQe6qIiwv0ynastmW2UI+5jJ5LWjNOPOCpKg1fAWxWKP51v/Vw9moHom++dIDSguojPlVCFtaV5UP14pHyMBJ9UANulf3lZF1+TMbIgftsRjOaLKfuujuG/rPaiXnaSxc2QossM5KJB//6XP0Eh0AeSnrktDpWP0293TUsLIsbt9kHIJca9TfBJsHBbp/OXFu8udzCb9oAonC2R08sIt4tQAkCMopmmO8ZVjeFTP/Ij8kDUNHG3xtThcLEoGiPrTm0ehpZtMP4q9VA7MyN2XDDVmqbLmOFdWS1TDBbhHeVEJJTYi+fhs2ETPVNV+QfWSGq2R9zzBDDRH06GSOtiS22JgalyV5St9WS4Qm0ZWaDOH3asYJrzwFVeXr9iaE7jaiP9N13m5dc/S93GAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875f1bdf-f78e-41a3-6058-08de83b6892d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:48:34.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lpv62w0zj50/8CAVbZ6eOdmWbeIJ0u7nz1lPrDJU9ZpxCK8gt5mjGfd7QdyiAJaBU29VErZgMmzIQZYzhHk1Y9EUsaecbibNeI9arqmj1iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160197
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE5NyBTYWx0ZWRfX6RKcCavzbjM/
 mIIdt42jL7VqwHZb51lAaTdtuxV8MrNLMPgqEN7Zc+vvzKZUXdKvCq+l4IkswyrVDCyQy8H01HN
 2WOL8fMtK7deMWoujbunskZ1t1RB0ha9a1ZIq3s1l2Dn3k3wCodgdYInEWB6yDyRBQlDwQuilT+
 BoTwWXHhszNazqL7oQuRu8rUXecHYwCjuMu/S3cttiJ8ITfcY8vvf+uSAcywjKAGBsjp0CFlFLx
 QsgpQ0hMYcofxQPiOm8tB9pfmt0zhaT3e2a2RVtzN7OhW4NpOQF11GyCqiQhP2WdwlAGXZsUfYi
 unS4xrSSYkRaK6a3I2lcBacPDDcn5S4CbTmSFE5evNZfOcLNkOONbkgBHlB/LDX/F2BFEyLZ5Rc
 LbGShs72/4GBgTFLg8aCar2hqdTmPjn12wsx/58zSS+ckDSD7lxq8nwlN8Ft4kbDNMYmih7DFNx
 x4ZBJYH2hd8i0nZDWQy/ZvgaADLDah1kuOWweBOU=
X-Authority-Analysis: v=2.4 cv=J8WnLQnS c=1 sm=1 tr=0 ts=69b896e3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=4MZOSNe7vlMP78D6yDcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12272
X-Proofpoint-GUID: CV_qLdfqRi9xPJFnNYMbReJhwOsIgf8I
X-Proofpoint-ORIG-GUID: CV_qLdfqRi9xPJFnNYMbReJhwOsIgf8I



On 3/16/26 2:12 PM, Joseph Salisbury wrote:
> The file contains a spelling error in a source comment (formating).
>
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
>
> Replace 'formating' with 'formatting' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
>
> Fixes: fc69f4a6af49 ("Input: add new driver for Sentelic Finger Sensing Pad")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> ---
>   drivers/input/mouse/sentelic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
> index 02cac0e7ad63..9ba3631e3d0f 100644
> --- a/drivers/input/mouse/sentelic.h
> +++ b/drivers/input/mouse/sentelic.h
> @@ -60,7 +60,7 @@
>   #define	FSP_REG_SN1		(0x41)
>   #define	FSP_REG_SN2		(0x42)
>   
> -/* Finger-sensing Pad packet formating related definitions */
> +/* Finger-sensing Pad packet formatting related definitions */
>   
>   /* absolute packet type */
>   #define	FSP_PKT_TYPE_NORMAL	(0x00)
I inadvertently added Fixes: and Cc: stable tags.  If possible, please 
remove them as they are not appropriate for fixes to misspellings in 
code comments.  If it's not possible to remove them, I can send a v2.

