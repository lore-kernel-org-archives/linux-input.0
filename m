Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010021.outbound.protection.outlook.com [52.103.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8542D74B;
	Fri,  7 Aug 2026 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100823; cv=fail; b=BFndMCb24tT4NvAz3D6u4wj1UALjq8NZVjngk+SylUzrfioZpZgu718wZyJNDK6BHZXDvyK5PSMgF0rUhbpXI8sFkIgU3DStwU/WskEFG6jGzeqavB5bYMhiUTyIsmCU2eK9FjI5No0KruptvFzzEqPnkeZu1BBWeRifDI/eA88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100823; c=relaxed/simple;
	bh=OeUBGagzl+3ReImvMQldkdq5G3Pi8O41spmeJK5IlwA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxsJ7kJQS2Y8FUPZEFIumc6lAPiwa+vbMs8AyALU5mM356d7yqs7mXUzzADy1O+PLMk8j0D5lZavQg5F72ScU98mhI0mgH282lnRvDhjfEOJub3ZqHTz6JaMNsw9xYB497GEitsMmT6ftk8R4M6dsdwYfwrPPPyykqSeJS+quHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fWm3SYEI; arc=fail smtp.client-ip=52.103.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fWm3SYEI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LegvaJZPy6O9SeXX7gbhWiHWH486aLSKcDf5CF3aed19OEH+ua4Mp4yMWh/HnFgITDphfpysD8QNt3fp2xven+bWbu7CUcJBZLBx74PTzCQULKcI40Rkj92VIOoVFGaBkkHZroWLD3iVYtJZD4FltsReLTi0+XRtWiQUC+tTYIqIhjymm3HBXO3VS5DM5dEC1vYXwWZeQ6uydH+c0Rq/Jyjb9e24IZ4RvHAGi73kbES8/FXGEb4lfVBpg3i9qnZszzSBGkUyF5sBDJ5UPga376n4Cj+6MntPlyrUeIoXqgZnwdVm6Gulyh48pU/St1jxBWyjZF4YdUD8GfPw3WAWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeUBGagzl+3ReImvMQldkdq5G3Pi8O41spmeJK5IlwA=;
 b=K2Gt11fDLlAf+yEtz6HVWb+H67b8kPqz0z2kwHPTJUb8P+dO2kkCpK8HHrOa57D0FYGXCfbG3iUmnA1qB5j9Lnx+clnkHkD+W3gPOqLy/aErH26D/nLsQEKa6mYTZnTw7sEfvMgiWaai0MLBGUs0bX8rFSzqGl6tDIU9ofuo5NwWoJhHtG5h8Qr2Vp/yxnHXPquzRKspPe97/D25OreL/MR25js0udPYtZT3EnXxfIdOKm5VjujZYUtul5a+C7p+oXwFwKI+oUpiwTOJiiJEv4u/k2odILYRN3KPFOugZ+4ph53vnX0+2cqjkstdTHr6Wnj4D/kZmv5Td0+BhRYz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeUBGagzl+3ReImvMQldkdq5G3Pi8O41spmeJK5IlwA=;
 b=fWm3SYEIw0c1lq61wD8I/sPx6WdJ3vj8vV/z7Of+9FV9o0HbmjrJvsndZpDSLMtaIXa5m6p6JLRFuIB+VlvtT9cnC0XtxXQFhmTnrWdU0+MWy2+Bq6+AYsKGilUwT9QQS3vsHsMAnZmkzECihVteG/p4yg7BWhcmFT8pmCrRs0N2JipdjaVSP+uPk6aNQBKl2iAmhwkMOYJyQP2B9L7xu+8VCHr4KOaytOW1U0ppS0dH+qLdJzZOVyzNtqzHF+Pczzh7cv+qJJsC69TcILvNLQRR78UnhJ5p5ADHo1T3gVKwSPAHVrutjoP3Cfd5w9IkZr1OCN2bfEjrHDSQ++HgHg==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TYTPR01MB10902.jpnprd01.prod.outlook.com
 (2603:1096:400:39e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:06:58 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 11:06:57 +0000
Message-ID:
 <TY4PR01MB1443234F3F701D363CDF935FF98D12@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Fri, 7 Aug 2026 19:06:52 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Sanjay Govind <sanjay.govind9@gmail.com>, Kees Cook <kees@kernel.org>,
 Zoltan Illes <zoliviragh@gmail.com>, Qbeliw Tanaka <q.tanaka@gmx.com>,
 Elliot Tester <elliotctester@gmail.com>, Dmitriy Zharov <contact@zharov.dev>
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
To: Pengyu Ma <mapengyu@gmail.com>
References: <20260801075623.2769601-1-mapengyu@gmail.com>
 <TY4PR01MB14432E24FD0D38D1FB84F99AC98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <CALSz7m0x_sgJU_A3dnM59vefSwvu_XC2QT7WdHJhVx6ZszKCzA@mail.gmail.com>
 <TY4PR01MB14432E89E86246C0DDC8B816F98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <CALSz7m1BeZqraipNv46skaLQCnSCV3qiKoou=0QFJEGt4hn1Xw@mail.gmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
In-Reply-To: <CALSz7m1BeZqraipNv46skaLQCnSCV3qiKoou=0QFJEGt4hn1Xw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cCmL4V5WDb1z0sXeGGcI5bxP"
X-ClientProxiedBy: SL2P216CA0169.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::9) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID:
 <c4284439-41b8-44ed-95c2-f5dad107fb7f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TYTPR01MB10902:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a79ebb-c61f-4965-2350-08def473ff30
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|12121999013|51005399006|15080799012|23021999003|24021099003|5072599009|4140399003|25010399006|40105399003|2607281247196008|3412199025|440099028|26104999009|260806224601699003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE9oQ2lpVGQyTTdDV1lhcm1JT2xxUHZWY3dSYnN0Mldiek1PemVRME9aaFBR?=
 =?utf-8?B?MWozZkV0UG1tbGlBWHVYQjhRSHRaQmdFb3M3Z1dzeW8xYUVZUmd3WG9heE1R?=
 =?utf-8?B?RW5WQmovNGQ1UUN3MWNCS21xcjV1SWkydThQSVVaTVBvZjRnd1E3djJRalNo?=
 =?utf-8?B?OWVVQmhNWk5VK3B3Sk5OdXo3RmRlUUg0TVp6Nld0OXR2VWlUOENjM3JWT3Rl?=
 =?utf-8?B?R0V1cGlTZ2lCdXlDamd3eEM4dXVLNEJ0SWNwOVd4QUNXaFN2c0N5TmxWWExu?=
 =?utf-8?B?MU1FRnVXMjR0VUo2c215NjNIZlN5NnFxeWFaNGpjSWw4dnBsTFdpNDhpeTNl?=
 =?utf-8?B?QlZzOCtkWVhDWlZ4clBHQ2x5OFF5UUJwRTJmZUFzNkZ4Sm5FNklsazNNdCtT?=
 =?utf-8?B?K3g4blpMV3BUV24vVDdkaWNia01HYTFCelE2RVVQOTNnMzVoUjB6V25jSk81?=
 =?utf-8?B?TkdvSktPbnh4Mi8rSDNFeCtjYXpDcmtBK0R1eVhDaXdNWjUyUEc3YTNoclVU?=
 =?utf-8?B?ZjNoRFhBZG11cTNLcUVPQXVpUmRFRkZrQ1Z1SE5WVE1HK3ZzcVhrcnhLd25G?=
 =?utf-8?B?a2FkdFdXZTRUeU5JUUk5TG9PbGtCQU9iNVhveUtkVStiTVB2UWpZaVBFcTFO?=
 =?utf-8?B?bHJ3U3dLdGRiMGg4ZCs1bDRJbzNnYmtiTysySWs4VURPa2pwaDVnNFc0V3R6?=
 =?utf-8?B?NHVLMEtUSjEzUWI1UzBpcDB3TTBmSCtuNklsQ2hZc083ZnpzdGRuN01ldzM2?=
 =?utf-8?B?VDBxalVRMXRKcDRnbklSTGZyakMrclpJclNFeWhZRHNNd3g2TkJ4bWYyckNr?=
 =?utf-8?B?ang3M1lmcEtSZjdZNG9CNC8wR0w4ZEVsd3lXK0VPekdRWWF4b093SHpSYjMx?=
 =?utf-8?B?NUtwejNnSU1LVnVyVFUzS25IMnFkKzFBQXAzN0lCdHcxdWM5SzZMWkJXbC84?=
 =?utf-8?B?UlQrc2xDWkxlcThDSVNhR3Naa0JnR0JCYzJKdHFZRGtXdG12UXRiNnVXWWtR?=
 =?utf-8?B?ZUQrZ3ZmRWVVdkRRU3FJRG1WYUswQ1FBZlJUMFJ6MWNIRnNtWGdwaVZhbkQz?=
 =?utf-8?B?S2NTQVFXU00xUmZSZXBsQ0t1eUpJdUdiYWJXUlFQUGpGT1lKa2E0Z2dyWmFY?=
 =?utf-8?B?OEZIK2JtR3phTzBMS2FxWjRRNzlpeFBhc1N1SE5rY2k4RWQvNWdnU2pCbFlO?=
 =?utf-8?B?d0FGeVNrZ0RQVE0yVWNvZU9xRDd1dTE1Qjh4WnR4RTJzRkJmV1ZXSG5oTmRV?=
 =?utf-8?B?UnNPZkEyeTNLRmprNithckJHeEZEK2xuMzJHazZ4Y005Ym8yVE5ES2MrUUZz?=
 =?utf-8?B?bDlCUThCczB3emNxcTNEeHJVK2hRMVhXK1RranhhanM0L1d5bnlYeFA5ZUVT?=
 =?utf-8?Q?eAmnxjHknFmSG91plD/qjJxTSBuV4Mn8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmRJVFdiN0E4aTRYRkIyMXFEaVZQbTRGMmhSWVFFWS9IaEt3SHFWZ0xjbWdW?=
 =?utf-8?B?VXhWMXREbXJTSXB2OWdkbm9IVmMvUDlmRkttaFQvUXB3SUZ1Qy8wbDVRR1J6?=
 =?utf-8?B?ekdNU3JmZDIzMnBSMkVpQnRUQVc2UTc5dWI3UnVia3lVb1hUdlFDVXllNHRl?=
 =?utf-8?B?VUxETlJnSC9IRHBYTGZKczZWM2tXWFdubGNtS1Uyb2FCc0h1Vk44RE5kSUpu?=
 =?utf-8?B?L0d2TTJoRnNvVUJUa0c0WkFVSE1RaEZxclhORWhaQ2xSbHpjR2lMUXdBV2Mv?=
 =?utf-8?B?aTBZbkgxdUlsK2Znck1YRGdMNmFDSXB6YS9VWElOemdPcnh1SUhuUEc5YVk0?=
 =?utf-8?B?Wm03MkxKcWk1MHhyc0MzWndIWDVMdWRCclMzZ05Tc0dmQVdXNG1qWDQrRmgw?=
 =?utf-8?B?ZkpUQkltVjgwVjVFbHhJaUQ3cWoxYTNnMmN3ekJFKzBIUUQ1eCtMdTd3Q3FY?=
 =?utf-8?B?MTN4clBPcU5rVnNmMlFJTTdPYW04aDVOZVczdmVOZ3p5WURXdm1sZURDa0E1?=
 =?utf-8?B?YU1zRG9KaTBTbVFBL1oyRmdGT2RPUzYwNzcwOCtQQTA2REl2dnZkRXpxTTh6?=
 =?utf-8?B?WU42M1hoZVR5YjhnTE1sT1V1VFJjK2lhbVlHTC9YcnV4dXY4S2oyVldQMm4r?=
 =?utf-8?B?aWpIMGpOWkFucExIZDVoc3NKZE9BVTFMRU5aYTJ1enpRWnVMN0V1aDNaM2I5?=
 =?utf-8?B?cjE5eldPMVRHdk5WdEk2d3RaZnIyNGxXNnZVU1RkL3NaLzJGblNnNVdta2xk?=
 =?utf-8?B?YlprOGQwZzJJNllNNDNhdVVOOEQ4ZVIrTGowT1VqeFJhSklDK2E4VTBJWmda?=
 =?utf-8?B?c1UyMitudDB0ZzBnWmtZTHJOd0NkSjNSNUQ1dlluVk5BanprRXZDN2Z6UTF6?=
 =?utf-8?B?L0htWVM4K0lpWEtvVjRGMEhyNTUyejcvY1h6SEU2UVAyZkMxRUpNbVh6TlpB?=
 =?utf-8?B?bmVhRzdSUDRWdlZPYjA4UitpampCUVRxY1FXS2t1dDRHM3J4aGw0aEYzM2Rw?=
 =?utf-8?B?WnU0WnZObXpTb2RqcXFmN1htRHhUOEpFUzFxdHJxQ3hOTUlCM0FCMjNKdFVt?=
 =?utf-8?B?WFJOWDNDdXVVWFczaVd5NGlPUW5pQlRPM1NvcU1EVE9FcEQrL2pldkVMOWkz?=
 =?utf-8?B?aVQ1NEtHS2JwME5YN1VLR055QnZRSkZhWGRXZE9pNUNndFBSNE91RSsrT2Jz?=
 =?utf-8?B?YkZXb3VUdDZFQ1RQN21zcUlDdVh5U2VGcXlTUk1UMWhNcWd3Q0V3QUxkeWhx?=
 =?utf-8?B?eElqajF4a1dMcm9Wdk1PWGI1MTgwTG1VSjRwTEVsSTZJMDUwNjZQZzBmcnVz?=
 =?utf-8?B?VzM5WjU2OUppQ2xqVE5DcHpBazdjYjNDY1hQTHU2aU8wcUtQdWkyVmFDSnFa?=
 =?utf-8?B?dzdjbWhLa3I4clNlS2xsdDlYRkxLb0djYUVrMGRobGh3M04zdnNxYytycXBW?=
 =?utf-8?B?aDdQaStlaER3VjdoZVBiQitYeUlFQk1MVDZkaksyenUvL3l4bEY3N2VYdW1l?=
 =?utf-8?B?SFJlOEdhVjVzRHpZK29WdE1GS3dTNCsyWURBTGVqMTBmd3FtYlRpb0ZGOUo4?=
 =?utf-8?B?bzNVSU5UellUaEVicitIWkIwUDBDdEZjMEZIWXc5MUZWbURQeFhGV2hkTHY3?=
 =?utf-8?B?aG5yUFFCbFk5WkxjQTVkUlpWQnRmYnhmeW10OXE3M3ZIWUFuQmsrRW0wQXlk?=
 =?utf-8?B?ZVg3QnYxRHNoRk5OVnVOUk41cjBwUDRrWVF4ajlxd2NyOVB5ODFWbVBHYU41?=
 =?utf-8?B?UllsbnlJWG1Sc1djUUFRenJ6L2pqUHdoYUh2M0F5U2ZCYzRUZ0VFV2poSGJP?=
 =?utf-8?B?djMrS2R6UkdNbU5RcmNCc2tzSVBvWFRUYXZLZWpKQjRHL3hOTEVReStxMk5T?=
 =?utf-8?B?bWVxM2IyRVZpMU13aG9JWHZWZDlQNEN3RkVVR3RNQ21BdGtwd3RGVXZJMFhw?=
 =?utf-8?Q?UNh2sYoL8MCwr+L7Ig74WBo2jkW/3cgI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a79ebb-c61f-4965-2350-08def473ff30
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:06:57.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10902

--------------cCmL4V5WDb1z0sXeGGcI5bxP
Content-Type: multipart/mixed; boundary="------------ZjlKlbBCcjkkHHRXaxiRsnV9";
 protected-headers="v1"; hp="clear"
Message-ID: <c4284439-41b8-44ed-95c2-f5dad107fb7f@outlook.com>
Date: Fri, 7 Aug 2026 19:06:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Sanjay Govind <sanjay.govind9@gmail.com>, Kees Cook <kees@kernel.org>,
 Zoltan Illes <zoliviragh@gmail.com>, Qbeliw Tanaka <q.tanaka@gmx.com>,
 Elliot Tester <elliotctester@gmail.com>, Dmitriy Zharov <contact@zharov.dev>
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
To: Pengyu Ma <mapengyu@gmail.com>
References: <20260801075623.2769601-1-mapengyu@gmail.com>
 <TY4PR01MB14432E24FD0D38D1FB84F99AC98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <CALSz7m0x_sgJU_A3dnM59vefSwvu_XC2QT7WdHJhVx6ZszKCzA@mail.gmail.com>
 <TY4PR01MB14432E89E86246C0DDC8B816F98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <CALSz7m1BeZqraipNv46skaLQCnSCV3qiKoou=0QFJEGt4hn1Xw@mail.gmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
In-Reply-To: <CALSz7m1BeZqraipNv46skaLQCnSCV3qiKoou=0QFJEGt4hn1Xw@mail.gmail.com>

--------------ZjlKlbBCcjkkHHRXaxiRsnV9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDI2LzgvNCAxMzo1MSwgUGVuZ3l1IE1hIOWGmemBkzoNCj4gT24gVHVlLCBB
dWcgNCwgMjAyNiBhdCAxOjMy4oCvQU0gU2hlbmd5dSBRdSA8d2lhZ24yMzNAb3V0bG9vay5j
b20+IHdyb3RlOg0KPj4NCj4+DQo+PiDlnKggMjAyNi84LzMgMjA6MTMsIFBlbmd5dSBNYSDl
hpnpgZM6DQo+Pj4gT24gTW9uLCBBdWcgMywgMjAyNiBhdCA1OjQw4oCvUE0gU2hlbmd5dSBR
dSA8d2lhZ24yMzNAb3V0bG9vay5jb20+IHdyb3RlOg0KPj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+
PiDlnKggMjAyNi84LzEgMTU6NTYsIEFhcm9uIE1hIOWGmemBkzoNCj4+Pj4NCj4+Pj4+IEBA
IC0zMzQsNiArMzM1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4cGFkX2RldmljZSB7DQo+
Pj4+PiAgICAgICAgIHsgMHgxZWU5LCAweDE1OTAsICJaT1RBQyBHYW1pbmcgWm9uZSIsIDAs
IFhUWVBFX1hCT1gzNjAgfSwNCj4+Pj4+ICAgICAgICAgeyAweDIwYmMsIDB4NTEzNCwgIkJF
VE9QIEJUUC1LUDUwQiBYaW5wdXQgRG9uZ2xlIiwgMCwgWFRZUEVfWEJPWDM2MCB9LA0KPj4+
Pj4gICAgICAgICB7IDB4MjBiYywgMHg1MTRhLCAiQkVUT1AgQlRQLUtQNTBDIFhpbnB1dCBE
b25nbGUiLCAwLCBYVFlQRV9YQk9YMzYwIH0sDQo+Pj4+PiArICAgICB7IDB4MjBiYywgMHg1
MTU5LCAiQmVpdG9uZyBCVFAtS1AyMEQgQ29udHJvbGxlciIsIDAsIFhUWVBFX1hCT1gzNjAs
IEZMQUdfTVNfT1NfREVTQyB9LA0KPj4+Pg0KPj4+PiBJIHRoaW5rIHVzaW5nIGRvbmdsZSBp
bnN0ZWFkIG9mIGNvbnRyb2xsZXIgaXMgbW9yZSBjbGVhcj8gU2luY2UNCj4+Pj4gY29udHJv
bGxlciBpdHNlbGYgdXNlIGEgZGlmZmVyZW50IFZJRC4NCj4+Pj4NCj4+Pg0KPj4+IFRoaXMg
aXMgdGhlIGNvbnRyb2xsZXIgVklELg0KPj4+IFRoZSBjb250cm9sbGVyIGlzIGlkVmVuZG9y
PTIwYmMNCj4+PiBUaGUgZG9uZ2xlIElEIGlzIGlkVmVuZG9yPTIwZGQuDQo+Pj4NCj4+PiBB
YXJvbg0KPj4NCj4+IEl0J3Mgbm90IGNvbnNpc3RlbnQgd2l0aCB5b3VyIHBhdGNoIGRlc2Ny
aXB0aW9uLiBBbHNvIGludGVyZXN0aW5nbHksDQo+PiB0aGlzIHNlZW1zIG5vdCB3b3JraW5n
IG9uIEtQNTBCL0MuDQo+IA0KPiBQbGVhc2UgcHJvdmlkZSBLUDUwQi9DIElEcy4NCj4gSG93
IGRpZCB5b3UgdGVzdGVkPw0KPiBDb3VsZCB5b3UgYXR0YWNoIHRoZSBkbWVzZz8NCj4gDQo+
IEFhcm9uDQoNCldlbGwgdGhlIGRldmljZSBpcyBub3QgaW4gbXkgaGFuZCA6KCBJIG9yaWdp
bmFsbHkgaGVscGVkIG9uZSBvZiBteQ0KZnJpZW5kcyB0byB1cHN0cmVhbSB0aGUgcGF0Y2gg
dG8gc3VwcG9ydCB0aGVpciBjb250cm9sbGVycywgYW5kIEkgZGlkbid0DQpoYXZlIHRoZSBs
b2cgc2F2ZWQsIGFsc28gaGUgY2FuJ3QgZG8gbW9yZSB0ZXN0IG5vdy4NCg0KU2hlbmd5dQ0K


--------------ZjlKlbBCcjkkHHRXaxiRsnV9--

--------------cCmL4V5WDb1z0sXeGGcI5bxP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmp1vEwACgkQX75KBAfJ
sRlm/RAAhJn426Qvesc/CfLCuTup18AVvepm0ucHZ+f1wankXnH1EmxmCU5K0Eyt
zcW/Xezv4tnaXuZgsJGLA+QljkBoUXfnS9XCbVra8u///bTUsMP3V8vj4ivlvCci
76H5ISdDLaBHBGNZOZl/v+FyGjRjte+BClfvfbaD99Gm3ksOYj9gIJkddLTkvb16
jbuwq81cbn7yUrpWEE5Y7OluOodh4ATS2CWPATH+ZU2Fb6c38dNCXgalIK8KPjno
/COuDSaUKKxkftWlCTqcB7VzeOjSh53/SAJEDbjYhtdnrAcoIOXZMGBX7Fki52S2
Ze/J9DDxoX50ktZsg0fj+R6MzutfxgsPNmgag7hxEs7ydTsQaOofg8d2dxSuNYOv
qm9B1VjYClt5y0Uue5JAKZ4zhDi/+xxOJkTyI1Gz2xTg0M/yP1aID5uoVskDcyx2
bG+3eeWBflIzl29t3WF6hUeBWNaWZH/7UxiZUCZduLUkIlEzVCDYOOFQhGzPbPuz
gvprggwxRSw20VipaWE1A30ZVEbE+zz1bWYaAJ0RYR8Y/NCpdfP9x7hDUkbebNVp
vS/u+BMdhuVVG0R8IMwP1+jbP8FiH2PK8T2HJUeQkg3vbvxxOG9iNcZmIA+i5/wq
AC4PVT0SssIBdun8UqfdGLK8fwmij9tnogaie1j9Jo5UPkYB9P0=
=EXOI
-----END PGP SIGNATURE-----

--------------cCmL4V5WDb1z0sXeGGcI5bxP--
