Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011026.outbound.protection.outlook.com [52.103.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC38391508;
	Thu,  7 May 2026 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143278; cv=fail; b=iBpCDdQPV5SIdpSV/JmCW9Y0TfsYGyHTnwEIP5m3Es1JFYXTERsEkbdz4sSSwl77htbohKgyr5zo6EUe9HKyj4q879XSBpOOakWDykQtuOJMMfvmonEQGeTofIrT04vOeHb8zz25havIUezg1gDXBIIzu9aJD2OCelsysHXXfuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143278; c=relaxed/simple;
	bh=6EE/CI/H9XC9x6JruXkX2JvQvojyLlYISi6REVM46sE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VuNqI2QYu1/GSKe2giJtwVyNa0fxAamRAhiuswIRNrPl4Qvlj7bNL4EJmShYhb9ziFb3Lbv09w9ymQyPwKYxUdLUh7mQj+LX/UuM9iHaicY10s1R46Q84t6fSxXb61uVlpcR2hWRyumUshudX8myUXUEd4BNHHasOskQCzjXh+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aQ8VgMYu; arc=fail smtp.client-ip=52.103.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aQ8VgMYu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvutfSEIhdB+zDKJsFq4IzfJqEhTb3fulP7IcGCt8/Vf2dqWXF2RFhELMjUxOetLlRjBdMR1wOq4FE5HWa7QQ8Qt9EJ2dmYyhwOfYns1oKGobLAkXNoCLLBHnJtBjaADG/79G1jmlkSeWmYoPj2PgslqlS5c/jcaJCAYDdPH8kLzv3JWTfsUF6ymr4AAdKKFNthF1Z6oqT+/KtBZgeb0ukxhRkCiEkNbIhIFr/tf4V10Ry3sLecK0Vcp86ohwUsGL/vE7SAnJU4AHGIyn5vXkK6k/2wOQzJF9+JBw2pkF1XhyS9lP5ukB0eAzifPlFV3TWO7r262rXo+fBKSlndy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EE/CI/H9XC9x6JruXkX2JvQvojyLlYISi6REVM46sE=;
 b=XFL+vmz9gfTUzo1eE2e+3qQAtoGrgkfDUJRLztLNwe4x4TOMxQwyHyozxINgTIwKSoc3+hK7OtJF9aUIJJ4bkz7lo+9oGNFJiegsI86iyMAeo9FPdshPG4IqitDQd0D2/bJ4iFEaTDkdNh9zmvM95ENGxEWSe/UJ7zEYysEYUabOSUQYuyrf1bxnN66mCL4wLdOZjegfMd1rCukBGeUl75o9RyFmX/rhAIf9Xb9F14reB5L0syFLt/xYjF3de25SrXRgqB4IMIJAhC5EtIL/oAKNhHuqq777nECA6yLwlmdGPxouFy1OWXnhh+MC6Xr4SZjTjnR8dLE1hlsH+QQpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EE/CI/H9XC9x6JruXkX2JvQvojyLlYISi6REVM46sE=;
 b=aQ8VgMYu/XeGu4ODXnfp0sW/kFHc2WzD4zxM+JADkkk0sg+4Yg2O1GvadNWrFF0IRx7QQlwCZPbevXSzVD2NW5jQoPXuzEQZaosLgx9OFQNQORW5OpAkdeFpz3ojdOTtCvRgsmelmZLu2fw/gYCujehAy4XbCQTXq18KdfDS2Ob8BcFn47JzzJD8fURZ5M+dorlv5wxqY0UA8orx5gJjK055+Rqr2Ln7xegq81s9lR7XOQMH17rI9ljsDTR4SpxHXpnJEObkzim8FvRqDCTbW0ajyYHL9AbXErWGBhE40fJS14FuI4VlpTmRRLVqb0Nt1zAvebQJUE35l55CYdAX6w==
Received: from OS3PR01MB7969.jpnprd01.prod.outlook.com (2603:1096:604:162::11)
 by TYRPR01MB12759.jpnprd01.prod.outlook.com (2603:1096:405:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 08:41:08 +0000
Received: from OS3PR01MB7969.jpnprd01.prod.outlook.com
 ([fe80::89a6:c807:9302:8c01]) by OS3PR01MB7969.jpnprd01.prod.outlook.com
 ([fe80::89a6:c807:9302:8c01%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 08:41:08 +0000
From: =?gb2312?B?wfUgv60=?= <lukace97@outlook.com>
To: "jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org"
	<bentiss@kernel.org>
CC: "vi@endrift.com" <vi@endrift.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
Thread-Topic: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
Thread-Index: AQHc3fzESnlxkoIv7EaQZzi0AMwiEw==
Date: Thu, 7 May 2026 08:41:08 +0000
Message-ID:
 <OS3PR01MB7969C09559DC6C0DCA520720C73C2@OS3PR01MB7969.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB7969:EE_|TYRPR01MB12759:EE_
x-ms-office365-filtering-correlation-id: 9ef77a92-c110-476f-34bb-08deac1462b9
x-microsoft-antispam:
 BCL:0;ARA:14566002|39105399006|461199028|24021099003|31061999003|20031999006|37011999003|25031999004|24071999003|15080799012|15030799006|8062599012|8060799015|19110799012|40105399003|440099028|3412199025|102099032|26104999009;
x-microsoft-antispam-message-info:
 =?gb2312?B?Nnh6NUpNK0dobWtzNzZTU2dhSzhTNkZncmZxRHl1QkNmN0pJQVNEUW5OWmw5?=
 =?gb2312?B?SVo1dzdFRkFtU3lEUS81YWRRdDQzUVpyZFdhOUlJZUNZeTZLazJuZ29DYU5Y?=
 =?gb2312?B?V21FUFFkR21abzdkRUpVS0VCUUJ6a1RTVEZzNjk0Y1B1TlpkclN4alhwTjBk?=
 =?gb2312?B?RFEvTUNoUCtrakFIWDFOdklCK1QrZnIyRm00M29pbmlEbERtRTAxRVo1S3NE?=
 =?gb2312?B?TWxDbmRJRHp3Q2hoaExPY2JVTk9UQmNmSnViRGJoNXdrRXFkQlN5ZW1vanVQ?=
 =?gb2312?B?Um9ST0V4QjBsOTFSR1VOM0lnMU1pN0N2dHJBUnFnNktwYjRtSmZvVURGZzV6?=
 =?gb2312?B?bEVyc1E5RUVPUlZpRTBndVJ2TEE2NkxpeVNHSUIraHcxallYb29KSFczQytY?=
 =?gb2312?B?eTV3Y2xwOW8zdWRZUm5qcGN3Nm9vT3hlL05aeVVaYVpEaWE3SldkS2RLRnNq?=
 =?gb2312?B?YnA5NVNtWTlZa2ZYSWNXNzhHS2dwdVlaek1mZTZXRm9YQXV2YVhJcXZXMVI1?=
 =?gb2312?B?ajQrbHhYak9lZHM3ci9LbDN3M2o1b095NGVLYkhtWGVvdWN6NVpUWC9rcTVa?=
 =?gb2312?B?UG1yYW5ZV1JJcmZTa0VlMVJXZURJaXgvUmhIZWc1S3g2TTBNZ3BNclRKZnJz?=
 =?gb2312?B?ZDBpOHZDTkdoemhhRFBXd01CS0JrTDZTRkI3dVFueGh2OTRyOGxOTUJGbFly?=
 =?gb2312?B?QldCcWRWTVFmRWxHY3I2VFBPOVlhY0xudDRuSjA5VGIreUN3SThxZWdjZVZV?=
 =?gb2312?B?bmhnQnc5RWZRUWtPY0ZnQ1lhVVJTaUNBRXBEMHlaYkRvaE94YnFoK1c2bXhH?=
 =?gb2312?B?ZkFDU1ZuOEkyQWtERTJGSlhnR3E5OTl0QldCVFlCTDA2TkJ6ejd0cG5WeFpj?=
 =?gb2312?B?N0ZKN0w4OERkV2VUeGk0cXc1VFNocHJBMWl0M1NHUVE1SDJzRFM0ZThzWFFq?=
 =?gb2312?B?blV3RnZ2WFRZZC8yUDBTMC9YbmVDTTFFOHFBV0wrSkRQb0I3R3M4bzVmUWpG?=
 =?gb2312?B?VGxGUFFHcWZzRFdQQWRzODYvQnh6ZWg2TGtQc2pxMytCTFoxRkgyTjJkN3lq?=
 =?gb2312?B?Z3haUTE2YW05alRISXV5WW9aMlFSTnNmR1oreHZORGZEQjJJMTlrRHJPdTJn?=
 =?gb2312?B?QXdtQWlROGt6QTg1TTNibUQ4QWZNcVNneldnQktZbG1mVTZtRjZxSWhDWDJS?=
 =?gb2312?B?RzEydk5vOHFkNjVHUGZIRWRDeFU5RjBBNjFZcGRZeVBKNkhNa3N5YUxOR3Vl?=
 =?gb2312?B?WnB2SjEyNWhCbzFrMkZmcm5rTXFYdzcrSnNDWEVOYVJuREJVMEpzY0dERXVD?=
 =?gb2312?B?b3pWVTJxcHgyYjBBamoyVkZlcjlHUHhNbEJTRHpmSnkrRjB2aHlYNFhpVzR3?=
 =?gb2312?B?MnJHd2RlY2doS1o3VWpxdWloNnJUMWRwdzY2Q1UxZFcyTEo1MHRRUlBKdTQ5?=
 =?gb2312?B?Mm9VK2VNNlVLeUorc3BQeG5JTzRXRUN1dExWZkVZakxGVS9XWkxpZXBoL2p2?=
 =?gb2312?Q?QsVl4g=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YmI0Y25oMkJrZlpITWJSUktCaEkrTDMxdFdwY2pRYlgrSWljUDN2MElwek1C?=
 =?gb2312?B?TytkUEo3OWxjbEJXMVY2QWdRYXRFRTRDWlRRUmZsNGdoaUxuakllczZlL1dr?=
 =?gb2312?B?VDlZTDFJdndTQVB6b0MwQUxqM3htRDZBMkpJQk00YkZGL3hoUkVLaS9DK29q?=
 =?gb2312?B?V2Jsd0FrUi80M0lOSmEvTzVBZmcrTVdEUEcvTEZLUTJmQm41T1U2SXpmSGkw?=
 =?gb2312?B?NGtROXUyTE5BMWc3Zy9oakNLQzhiMkxlOXErKzV2MnM1bE1iYXB4cHBoS251?=
 =?gb2312?B?bGVTeExaVldWVG1Xc0x5QllFVUttWTR5bFM3TGtEbytIcW9wRUdHb3hCdHV2?=
 =?gb2312?B?MittYlZ6ZnBSK1E2S1RVMDh0eFJjL0NoTnRsdmFVdVZkbE1abGRLOWppU21m?=
 =?gb2312?B?TzgzM2NEeDhaWi9ZNHRIa05PUEw1d3VJVVhvVjg4Y3FmMGlvUG1zS29DcDRo?=
 =?gb2312?B?U24rNUx1SExlTkwvT2E3bHBBcjk2QkpNcXhFYWxQWHRpK09DN0xUSDJ6VjNp?=
 =?gb2312?B?empSbUkzWEV2ZkNXaDZWT01wTEcrRUkwbkxQdmJOUEtreUtpWTBoME4vVjZK?=
 =?gb2312?B?U2xQbDFweDkzTmkxZncvWnlrRVliRlZuL1hweXM3eDcwQW8zVkNLc0t2eThW?=
 =?gb2312?B?QkxDUWJSV2Q0dnNLdnZxektydXdPUWFtcVd4bFpYWWxSbkZwdUo5aUFWb2Uy?=
 =?gb2312?B?TmZseGRhWC95TWIzOFVGN1d5OVNOZC9tRWo4RU5RV1hCc1A1b1FLc0tUakI1?=
 =?gb2312?B?OHhvR1FmZWwrMk1KeVBaZVBGc1ZCRU5Ubzg4K01ybW5KTkZzWFNkNlZPd3hD?=
 =?gb2312?B?bXFCczZ3c0pMZXZrZVhMTk5xZzU4MWNGUWpveUtubXBqQjhWR05oN2l0azNt?=
 =?gb2312?B?Z3dxenVGOThKWWptSmdYTGZtUDhIWGZxdFlldkFQR2poSjQrT2FzZG4yWkFF?=
 =?gb2312?B?eUhHZWdMd3JVM2U1YWxIZnpZZStWSzNzU0Y5RCtRZ2F6NlFjSHNTdEJraTVH?=
 =?gb2312?B?WnJVZlNpYXVxWStkcUtuKytNTDF3K1BGZUMrelJnVEs1QWRmdzl2bTdYL3Q5?=
 =?gb2312?B?dkxGVkxScWMvLzlaenlTZHZ1VldEb1ltY0tDbkZ2eEFhQ2FpQndYZGlEWXFx?=
 =?gb2312?B?QzZ2amQzaXlzR1FFZ3ZLK1M5emVqcXdURzNGQUpONjV4QXUydHB5NGVTS01p?=
 =?gb2312?B?MkhPd0tNa3psckFmRFQxRXJOdW5nM055U3BJNGZTdjRJb1V6cWF3U201ZE9X?=
 =?gb2312?B?NVAyK1pVN1UxQzVWQWNnTzVUQkFNdmFlMFc4RFFYZXZlUXM0ekhOYVUvbGRo?=
 =?gb2312?B?bEw3ZDdORERKRS9lenhLNlFTWDJHcWQwdnBQVTgzV1JDcDc4M3ZaMzhkWW1r?=
 =?gb2312?B?Q1NqVmN1VVIvT21OY0hEUURTZElicG5rbmxIdTNqTGhBNVUvVm5EcHhFY0Ur?=
 =?gb2312?B?VXBzdGluVExaNHF3amJMRG1zdEhwT1VUZWlzWjBiWUZHcnFJYXZGTXZXUFAz?=
 =?gb2312?B?T2dKRHcxNTl1TVY0Zkc1SlVCZElWYmlwUjdjVllhandZNDV5THhpTGRzQVpi?=
 =?gb2312?B?eTJIcFpSSUY3YzE3S3VzTk01YkpIYWlSekdleVduTjVDTFVUSUVSMWI1YVNh?=
 =?gb2312?B?aXRlREk0U2gyVjdHdVIvRjRPY2s1dUk2Rk5hK2ZRQXcwNEY1U1o1dTFaU3NY?=
 =?gb2312?B?dHVuQ2RyR1kzeG9iRjRzZk5oN3hnaHZtWHJ2TFpxcWZIOUZQRm0zOVBqdUF2?=
 =?gb2312?B?RkhLT3FkYWNhdnRxMWRCUVd6aHoxbXlxWlJUdFFma0JHTDF6dWFRMDJLdXBS?=
 =?gb2312?Q?hevHbny42skaVsMxIiB2Rz+I1oVNo6628rg3U=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7969.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef77a92-c110-476f-34bb-08deac1462b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 08:41:08.8767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12759

RnJvbSA1NjVjODFlMWIyZTFhYWFkNjc1ZDk4NDQ0MjhhZjdiMzVmNDMyOGM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaXUgS2FpIDxsdWthY2U5N0BvdXRsb29rLmNvbT4KRGF0ZTog
VGh1LCA3IE1heSAyMDI2IDE2OjMyOjA0ICswODAwClN1YmplY3Q6IFtQQVRDSF0gSElEOiByZW1v
dmUgZHVwbGljYXRlIGhpZF93YXJuX3JhdGVsaW1pdGVkIGRlZmluaXRpb24KClRoZSBoaWRfd2Fy
bl9yYXRlbGltaXRlZCBtYWNybyBpcyBkZWZpbmVkIHR3aWNlIGluIGluY2x1ZGUvbGludXgvaGlk
Lmg6CmF0IGxpbmUgMTMxNyAoYWRkZWQgYnkgY29tbWl0IDQwNTFlYWQ5OTg4OCkgYW5kIGF0IGxp
bmUgMTMzOSAoYWRkZWQgYnkKY29tbWl0IDFkNjQ2MjQyNDNhZikuCgpUaGUgc2Vjb25kIGRlZmlu
aXRpb24gaXMgY29ycmVjdGx5IGdyb3VwZWQgd2l0aCBvdGhlciByYXRlbGltaXRlZCBtYWNyb3Mu
ClJlbW92ZSB0aGUgZHVwbGljYXRlIGRlZmluaXRpb24gYXQgbGluZSAxMzE3LgoKRml4ZXM6IDFk
NjQ2MjQyNDNhZiAoIkhJRDogY29yZTogQWRkIHByaW50a19yYXRlbGltaXRlZCB2YXJpYW50cyB0
byBoaWRfd2FybigpIGV0YyIpClNpZ25lZC1vZmYtYnk6IExpdSBLYWkgPGx1a2FjZTk3QG91dGxv
b2suY29tPgotLS0KIGluY2x1ZGUvbGludXgvaGlkLmggfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2hpZC5oIGIvaW5jbHVk
ZS9saW51eC9oaWQuaAppbmRleCA0NDJhODBkNzllODkuLmUxODc3YTlhNThlMiAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9oaWQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2hpZC5oCkBAIC0xMzE0
LDggKzEzMTQsNiBAQCB2b2lkIGhpZF9xdWlya3NfZXhpdChfX3UxNiBidXMpOwogICAgICAgIGRl
dl9ub3RpY2UoJihoaWQpLT5kZXYsIGZtdCwgIyNfX1ZBX0FSR1NfXykKICNkZWZpbmUgaGlkX3dh
cm4oaGlkLCBmbXQsIC4uLikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAg
ICBkZXZfd2FybigmKGhpZCktPmRldiwgZm10LCAjI19fVkFfQVJHU19fKQotI2RlZmluZSBoaWRf
d2Fybl9yYXRlbGltaXRlZChoaWQsIGZtdCwgLi4uKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcCi0gICAgICAgZGV2X3dhcm5fcmF0ZWxpbWl0ZWQoJihoaWQpLT5kZXYsIGZtdCwgIyNfX1ZB
X0FSR1NfXykKICNkZWZpbmUgaGlkX2luZm8oaGlkLCBmbXQsIC4uLikgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKICAgICAgICBkZXZfaW5mbygmKGhpZCktPmRldiwgZm10LCAjI19f
VkFfQVJHU19fKQogI2RlZmluZSBoaWRfZGJnKGhpZCwgZm10LCAuLi4pICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKLS0KMi40My4w
