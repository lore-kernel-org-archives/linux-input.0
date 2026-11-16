Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794851699;
	b=WXFpB9C1jjzXVtywLoCfMMtvPgciia2gWD4LE60QuifssDRNTwnauq6wqvJTiiTX09B/
	 eJoyMgDmDVWaUcfsFmZNjMgLsJRYws3YrKxxyWGEaVBL9CHeRNXXJzURghJxe12FpVtbp
	 eSKcGvvPooa0rVdmcFjfKLSKhsZyBzT0DHafLiTvIJsdih0wp47/8e4x1zQ1H+YIM0PRl
	 uuyPY0vB6EGuulfm+ejSqAy0Vg/g8boNQCYhJJgCjpFEIdZjLKgb127Aia5lBODFui6lY
	 ttczGIpV97D6P1ETuRV+G/dOjyGRCwwKVdcamt/xTuuEzc65FbawPrBJujTwzoDSm9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851699;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Cc:Subject:To:References:From:Content-Language:In-Reply-To:
	 Content-Type:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cwsmVIEMAwGGFSGVAIGu6XJgFp5GZQeD3vuhMLua+Qc=;
	b=d4H7o5vGsfFUSV0VjBTzGKRvijAZNDNjip1szjRVZgNAyI7DLp/KXK3C8dDUuyG6lV3I
	 58mQldaaff8RX/qvoOj2QHRvJebKtKKnG/xbcwiqcBob3cvkXmLRajk2b/ZlCfWXvwDUq
	 am5T90YP4Ytt2J81AzulHao0GBQdGaV+W6cCJyJuIIMXOLFZiMA4RnwJxSfhXyLEKRGb/
	 N4FCyOYJrUOg0vxonAmwbjGV7FfOEWih8ihLNs4KIcqm8rfzEL5KICpMZSRoltjAV4yNz
	 3oeiDPMYnZxTLyCYm0GEvbRf6iCGD3AcrsvSkmjlKjk0PKm9qq+4ndirsCE7wWekDcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=n2JqswJj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.3
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010003.outbound.protection.outlook.com [52.103.43.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A9606A32C
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 17:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E55A9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=n2JqswJj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFNDxr2Gl0FhkThTP5eP/mQKEnGGbphpu/QouwvlnNuKFs1Ktv2jahNHdhWcJzqJyG+oHgi0BPUy5EwCDsgUS/ZLa4NSYggvpBe5I5OEqJ18l42C0fYnTLpU3e9TzJiPQmANPTsqcNkegfL7GraXQGRk/ws3AL93TXJWGid6M1OLtig3hosewoVsVx+ljsjbAFnO7jq/8kcOq2b2MCtT/xUItwoBczOL4wuuWCW+bx7+bi33Q87+nS1gve0Zm84WXCYIGFGPuXDDZCzzN3YcwOoTCUCQk1q4qid35on3+Jubsp0bsMRTIaprdidkMlUl9acU18NudpFNXGD+8KExKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwsmVIEMAwGGFSGVAIGu6XJgFp5GZQeD3vuhMLua+Qc=;
 b=lit4WMuVzT2+J4a4yFOY4wdPjDurqlRsnqJSZbuqz3XlsGS8zUrSdExgiUmLNltR2l1tTXtx0wLZ6IeGqKuA83kgMzJzqer7v3k0/8QE6tNU2wGKMCt+hWWOk+JrWo2Dg2uSvWiE5pjeIGeMgrJlTfXClvbz66bnY6XOh3m/9T0k7jfXwOtrQynCYce1dfDt6DePXexuSOKLY7EFWkfOz6jhX/4d6fKbjnPcavmePQybHi5tuzJECFDdGuaJhJolii3+8CaZJ/b3ClesbQ++VeKHdoI93g32YP2dPeJ5BmSbG+UsKojUgXkBx3imlyLGVjJCZXTyxqqLVIu9Z6LWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwsmVIEMAwGGFSGVAIGu6XJgFp5GZQeD3vuhMLua+Qc=;
 b=n2JqswJjZKGeJD0QnxSKdgqPGeY1Mij/5grtqR5Vayn2kNfAKVy630Uh1EFUpBZFLlBtYxLNKlQmcV35JG2tBFQ8DyeBBJrgUckm1tUH0Qg5aBCY+lnfOGht4jpKgFMVqVTKwZk0iDKuIgK3V6jWEw3/1UW5fYFDavejlw5c7E5Z7k1hY5db3AVJWi4Cq9mQtgsoMgzt3K0CnjnEne9r60DDkBrP1dmY2iU+ApXQ0igM8w8MMoDcDjAxrWkivYeWFuiNYdQ6lyuO20EQGk6JVAxojQgSewvhiImtT/SjLr9oajwr9VwRtxHyZ7Uq6ONfKtBHcWohbeBxcX35VS0+kQ==
Received: from TYVPR01MB10892.jpnprd01.prod.outlook.com
 (2603:1096:400:29a::13) by OS3PR01MB9800.jpnprd01.prod.outlook.com
 (2603:1096:604:1ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 17:54:55 +0000
Received: from TYVPR01MB10892.jpnprd01.prod.outlook.com
 ([fe80::911f:7aa6:717e:cac3]) by TYVPR01MB10892.jpnprd01.prod.outlook.com
 ([fe80::911f:7aa6:717e:cac3%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 17:54:54 +0000
Message-ID:
 <TYVPR01MB108926C926A5BDB204C5FCA94987C2@TYVPR01MB10892.jpnprd01.prod.outlook.com>
Date: Tue, 17 Nov 2026 01:54:42 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com
Subject: Re: [PATCH v7 00/12] Input: xbox_gip - Add new driver for Xbox GIP
To: Vicki Pfau <vi@endrift.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org
References: <20260912030426.2997003-1-vi@endrift.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
In-Reply-To: <20260912030426.2997003-1-vi@endrift.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ol50KTEqWcN1x6Wdla0X4FVI"
X-ClientProxiedBy: SL2P216CA0102.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::17) To TYVPR01MB10892.jpnprd01.prod.outlook.com
 (2603:1096:400:29a::13)
X-Microsoft-Original-Message-ID:
 <5479d5aa-412c-4d66-b208-9358449897a4@outlook.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10892:EE_|OS3PR01MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: 3019cfaf-30c9-4d4c-04a5-08df440ab878
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOZA7krvRMWCRkEboGRCdP8CQXDohV7SgdcUbaIQ0flFcjjFOx9hTlgBEInBA4xelQAYLH4R0HXvPIcXIxcHtX5mPIJTsbKEEXwiN9h98000dWQPmVWZIYdYwlP3Xm6MfCjIof8Lpsq5VSLJh66V9pOBSVyPM76CeVyrzhWwqVa4HbymzsULu4bxIsQvxs5PFRv/LLFbfECp7a4RI+tm17W8TyzaF7SVN9aVddiZ/UXoW+5UY7LbR0EoJl0wmNQLPkMu7Ss++iB+4lY2OkP0vL492r6tAe37jk1U2X8G75WFjoLHhpd8cwxWz1Oxv9ozu7dJkwpKRfmLXVBU8Ll6sEi5zPxOPLFd+7EZ/X5LNNYB2vPNYytHk2wOezqfY3O1JW2NMfTfw9mBbcIDTym4wkiiTXg8QrtYYobVUZsb2d9QlpSvjWLDMm1C49UuQ6n2+8bBn49Fk0DsHg43iXkEhV/QB4XiLP19IBESR1oDXkDP2XwQkRpGslzNpWv/XpCW+FoA01Au2svz3A1s4dMlA6pD4ebNopOeDRFaiPrFaLNIulOdzg8RbMhqNGFy2OYYdZs5YWXSkHn+loRa2jErylDsZ5iFEBgLMXy++HXeyf9jf1cTm3ejSSZg6MSLseIRGJmD3/5YTlw1J4oSHQDm3oXeglJIPhsLCNPKxVmf+AVD10Nz1LsfL4oO32ay36yyZ3Cg72UBsHKfW31goo/73ylXHFAjvoDNwDKAbvjIUYPH4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|25010399006|24021099003|5072599009|4140399003|8060799015|12121999013|19110799012|51005399006|440099028|3412199025|26104999009|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVU5VUVvaDhKNWdJdGR5NkxzRUppbFljTnNvWTlQcXgrS3RBNkp4UWNDMC8r?=
 =?utf-8?B?WnV5QXBjY2w0U3V0Unp6T1MvaldsS2tpcVVyeUY2cWJOdWNHbVh1cnNkY1lx?=
 =?utf-8?B?YzVadHVEellGcFhrWDlvcUY5TXRPTlg5cEdWdW5NOWdML0VQaVBTYzFBRUhD?=
 =?utf-8?B?ZUNHSUJIYWwzenhPZzF0UFZEZ0dzT0ZTc1RGQ3pPbFZwb0JsbjlvOGlzQTF6?=
 =?utf-8?B?eWNpcTBpNVJqekY4ZEZyc2EzNDl5b2NLQWF1Q3h3Zitab3BGM3Y3MGwxV3RQ?=
 =?utf-8?B?eXg2UDZKUEtEREpNb3cvMnBjNW1FYnFkdDBDemxEM0k2VGJ1czdKZG1GTm1E?=
 =?utf-8?B?cVJWL3FDK3BtVlh2bEVvWE5pQXYyU0VVUjNwaEtiU3NJQ0labHRuWWJLampF?=
 =?utf-8?B?Sy9QQnVURUltU1ZYL1BQMHVHZEZXcnVjRFBoRzIvbUhxZXVULzFnU2lSMDlK?=
 =?utf-8?B?SklmMEdTNVZCdmtzUlBSNXFaT1J6Q0p3NXRlZW12QTV0Z294d25KNDc3d0Qz?=
 =?utf-8?B?LzViWmdNZktyVmdiNFl5TWlWbU1PK2YyRTFyTWszTSt6WExHWDBWbytvZVdU?=
 =?utf-8?B?ZlpudFZFK2xLMVJBQmFYTFlRVGo0aGdQbHlBbnNXVklFRmJFLzh1dEJZbW8y?=
 =?utf-8?B?L0RuMGp3RjJnZ3BqdHpIdFZSUWtaTlgvNVk2NmFacDFSbEJCbEtjOXdXb1Jz?=
 =?utf-8?B?MHZTR08zaGRaRW1RbjdUdG03S21uVG10dDJKZ0lBd01zanZBK055K2pEU3Mr?=
 =?utf-8?B?SStVMmtMa0JtMnZWaWlDOUZvaWhoMkd2N3VnZ25BR1ZqU2RVNHVUcktNV1VF?=
 =?utf-8?B?TmMrUVo4cUdVSkhDRVc5QkcwRU04OHRIK2tpTW1IWS9NV0RzdkQvTTUwc3ZS?=
 =?utf-8?B?Q1dKQ2V3QURJMWlDQXo5NWd0VlUvSG5sbktheE1tVVFaZ3ZVRXhBVVd0R01F?=
 =?utf-8?B?eGpFR3MyYnNyMGFMamNnQmgwMk1rYmp1Zk1rOXcveG9LQ0YvQkMrb25rOGpG?=
 =?utf-8?B?U0MyMmg5cUc3Y2ttZ1dlV0xoejJtWG4zN2xWMHFMd21Qclp1R0RQQlRNbHRY?=
 =?utf-8?B?aWt6bW9wblV0a042dVNzSTJkK0c2eHN2N0ZBdG9aTkFKMU1tUk9zWlJlR0VI?=
 =?utf-8?B?NzJDbzByRS9VdnJsYjAyTnF2eE9yTWdNNmN1dFRVNERiVGUxSFdGMi9lNDNQ?=
 =?utf-8?B?d0JIN2F2MlhIcEpUSVFxQTJDMDRKUi9ndnVEWndJeWFKZUVCSm5LZVNwNlBx?=
 =?utf-8?B?T3RyWUNPK1I2cWhOY1dvZXpPOE9ib2FoNnoxanlNVjkxSjRheTVRNG0rQStu?=
 =?utf-8?Q?tiBW70fHcWjbBrPNuRE1Tq4H2SwJa796Hg?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJncWpKNktsV09SS1lPRnY3SkF6eERMMkJEMFdCNWYvMCtyejR3MzdyRU8x?=
 =?utf-8?B?N2t4UXNueTdpNjE5RW9SZ2RMT2QvOWtyOUNnZ3VaT1NrRmg2RjlYTmdUTG1O?=
 =?utf-8?B?bTlkWFBjMHFwcnM0andlajZaM3FuME81M1hBZ0x5ajMzN0tjOFFSMnh1bFZp?=
 =?utf-8?B?VjlyTHByOHJyaG5LWG1pNHhOaVM4SmJjQXQzaVRSNkthK2JBYTZGK0Z4R2pT?=
 =?utf-8?B?ZXVFS3QxaFluUmVTNlNLVGlVVnBqcXN4NU9IdzlOT3oyY2g5MDc4cEhzWXV2?=
 =?utf-8?B?RWxjNXZRYzA0Rk5zQ3ZBV1p2SkVydHhnNlRYTVkyRlp4clVNYUlaSUUzNW52?=
 =?utf-8?B?b1VMSDN3SU5acHRtcDdJbmJhSjRVTWVaS0h1U0I0YTV5QSsxT3NCMWs2VXdX?=
 =?utf-8?B?R3pYbEhHUGlLM2hDZG9nTEFxY0xzalpObnFBQXBheUlCajh5TkQ3VkNJZXBQ?=
 =?utf-8?B?R1VNNk9JeXN2LzY5Y2E0TlJGYkJ0cllFVDdpWmFLYjE4QTJxR2w1cXdpQnNo?=
 =?utf-8?B?QkRjYnhTcGxRWGxudWFvdXpnb0ZsMUpreldsMXhDNEhIMytrYnY4UkpsWWJi?=
 =?utf-8?B?RnlJVlQ1S2tiSzFRL2dUaEZkcnlxUDNCZFZpYmJKaVBYNWxrdmtJbkoyWnFQ?=
 =?utf-8?B?WldVaitCcWN5MFIwTnVNbGI5SU1zN0FXL3Z0eHVZb1g4WWlVQm41eW0rbzNJ?=
 =?utf-8?B?YkFHcHAwaWdhb3hadjBFTmg0Z1g4a2pWK2RGQ0lQRWMrbTh0VTJHOWxqckxl?=
 =?utf-8?B?YWtjUlZkL1p4SFAyaTBrRlo1eWV1ZHZOUUNET3doSzhKekFrR0QvZnNFOXg0?=
 =?utf-8?B?RnFMYWpKMDlVZmRvcE9veDJrc1YrTGxZdVBEaExibU9xd00zUzFwYmRBVE95?=
 =?utf-8?B?V2hLb0JldWhzVkp5ektPVzJxbDVFN3JIYW9pakhFeG0yYmFoVXhqbUNPOFVo?=
 =?utf-8?B?ZER3M2hIOGNwaHpPMjF3bFEyRWIwMk9uQ2RqQ2kvck83R2ozTHRzSk1uNy9N?=
 =?utf-8?B?WFpJS3B2NEh0YnZnUDFscHVKeTE1K2dTRHdjVWFFSHFaK2E4WnlMSnpHSGlH?=
 =?utf-8?B?VUxPQkV3d0V0UEtsZ2Ywa2d1MVFVald2TkFOTXJQYXFJU1hmUU81b2NIWDJv?=
 =?utf-8?B?RzU5MWxtT0FrQVAwRzVQMW92MURVOFBKQ1BIOW1KUDVSdEhKQ1E2bk5WUk5G?=
 =?utf-8?B?VkhPbTcrbzB2UDMvOC94dkJjbFZHNmNNOUdXNTVLYkhTeXNlN2ZRZGdTd3NE?=
 =?utf-8?B?QkEzUkVXMnFpd0RBQ1VsWUFicGF1MlFaQlJwRW5XeVcvcHhPZDNOUW5Td3Vh?=
 =?utf-8?B?NUY0ZU1oUnZQS01GazhGUWtTQ3BvU3VRRzBCUm95M2pTUHptM2ZRMXg5UnBw?=
 =?utf-8?B?ME9udGxVYk1GOXdTZ1d6aW1KTi9uNGx5YzNQbVcwbTB1aExNYUU1TURKaDVQ?=
 =?utf-8?B?cFdwRUJZQTcxREsvRmxhU1oxT1h2cjFZMFo4UzYySHZyY2JkVGk1NlI1bkh2?=
 =?utf-8?B?WlJWeVVvMGgxSUhpanNWVS9reXYxLytCZjBBSTBtalVZYlV4MzI2dWptL3Zr?=
 =?utf-8?B?czRyTk14YlFSejJZWHNnQ3VZTTAvWUdVYkZ3UlhFajYyRVY0bnRGZXZyZ0la?=
 =?utf-8?B?L3JuTW1XVDM2QlN2Rk1PK0dIZkowekZuejQreFM2Ym1qT1lVMDFySjE3dll5?=
 =?utf-8?B?dzU4NVViK05mMkViaTBFOEoxVlJIUzVRbWpOM21MQUg3bFREMTF6bUJwVi9Z?=
 =?utf-8?B?Uk5mRTU0ZnpDUU53c0VjYlU1YkkrSk5scUw1Y2VWVzh1MHIxSWtYRHd4ODJr?=
 =?utf-8?B?NzIzVmtlMDllSnRSYnFFMVoyOEY1VDhBNmlUSUNjNXlZVkVBN1JNRjdxZ3JO?=
 =?utf-8?B?UkRUOVh2Z1krODY2VmRsY1JIWFQ3bWRHTHNvOGtTVytpcGRDNUViVjNUaVBo?=
 =?utf-8?Q?yMOppnZBiR41u71wVZxfCb1mF6ATlbfG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3019cfaf-30c9-4d4c-04a5-08df440ab878
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 17:54:54.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9800

--------------Ol50KTEqWcN1x6Wdla0X4FVI
Content-Type: multipart/mixed; boundary="------------QAiOFZAMExEvWBBxAELL0Twv";
 protected-headers="v1"; hp="clear"
Message-ID: <5479d5aa-412c-4d66-b208-9358449897a4@outlook.com>
Date: Tue, 17 Nov 2026 01:54:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com
Subject: Re: [PATCH v7 00/12] Input: xbox_gip - Add new driver for Xbox GIP
To: Vicki Pfau <vi@endrift.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org
References: <20260912030426.2997003-1-vi@endrift.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
In-Reply-To: <20260912030426.2997003-1-vi@endrift.com>

--------------QAiOFZAMExEvWBBxAELL0Twv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRG1pdHJ5LA0KDQpTb3JyeSB0byBib3RoZXIgYnV0IHRoaXMgcGF0Y2ggc2VyaWVzIGhh
cyBiZWVuIGZsb2F0aW5nIGluIG1haWwgbGlzdCBmb3IgDQphIGxvbmcgdGltZS4uIEkgdGhp
bmsgeW91ciByZXZpZXcgaXMgbmVlZGVkIGhlcmU/DQoNCkJlc3QgcmVnYXJkcywNClNoZW5n
eXUNCg0K5ZyoIDIwMjYvOS8xMiAxMTowNCwgVmlja2kgUGZhdSDlhpnpgZM6DQo+IFRoaXMg
aXMgYSBuZXcgdmVyc2lvbiBvZiB0aGUgcHJldmlvdXNseSBzdWJtaXR0ZWQgeGJveC1naXAg
c2VyaWVzLg0KPiANCj4gVGhpcyBpbnRyb2R1Y2VzIGEgbmV3IGRyaXZlciBmb3IgdGhlIFhi
b3ggT25lL1NlcmllcyBjb250cm9sbGVyIHByb3RvY29sLA0KPiBvZmZpY2lhbGx5IGtub3du
IGFzIHRoZSBHYW1pbmcgSW5wdXQgUHJvdG9jb2wsIG9yIEdJUCBmb3Igc2hvcnQuDQo+IA0K
PiBNaWNyb3NvZnQgcmVsZWFzZWQgZG9jdW1lbnRhdGlvbiBvbiAoc29tZSBvZikgR0lQIGlu
IGxhdGUgMjAyNCwgdXBvbiB3aGljaA0KPiB0aGlzIGRyaXZlciBpcyBiYXNlZC4gVGhvdWdo
IHRoZSBkb2N1bWVudGF0aW9uIHdhcyBpbmNvbXBsZXRlLCBpdCBzdGlsbA0KPiBwcm92aWRl
ZCBlbm91Z2ggaW5mb3JtYXRpb24gdG8gd2FycmFudCBhIGNsZWFuIHN0YXJ0IG92ZXIgdGhl
IHByZXZpb3VzLA0KPiBpbmNvbXBsZXRlIGltcGxlbWVudGF0aW9uLg0KPiANCj4gVGhpcyBk
cml2ZXIgaXMgYWxyZWFkeSBhdCBmZWF0dXJlIHBhcml0eSB3aXRoIHRoZSBHSVAgc3VwcG9y
dCBpbiB4cGFkLA0KPiBhbG9uZyB3aXRoIHNldmVyYWwgbW9yZSBlbmhhbmNlbWVudHM6DQo+
IA0KPiAtIFByb3BlciBzdXBwb3J0IGZvciBwYXJzaW5nIG1lc3NhZ2UgbGVuZ3RoIGFuZCBm
cmFnbWVudGVkIG1lc3NhZ2VzDQo+IC0gTWV0YWRhdGEgcGFyc2luZywgYWxsb3dpbmcgZm9y
IGF1dG8tZGV0ZWN0aW9uIG9uIHZhcmlvdXMgcGFyYW1ldGVycywNCj4gICAgaW5jbHVkaW5n
IHRoZSBwcmVzZW5jZSBhbmQgbG9jYXRpb24gaW4gdGhlIG1lc3NhZ2Ugb2YgdGhlIHNoYXJl
IGJ1dHRvbiwNCj4gICAgYXMgd2VsbCBhcyBkZXRlY3Rpb24gb2Ygc3BlY2lmaWMgZGV2aWNl
IHR5cGVzDQo+IC0gQ29udHJvbGxhYmxlIExFRCBzdXBwb3J0DQo+IC0gSElEIHBhc3N0aHJv
dWdoIGZvciB0aGUgQ2hhdHBhZA0KPiAtIEJhdHRlcnkgaW5mb3JtYXRpb24gc3VwcG9ydA0K
PiAtIEFyY2FkZSBzdGljayBzdXBwb3J0DQo+IC0gUmFjaW5nIHdoZWVsIHN1cHBvcnQNCj4g
LSBTdXBwb3J0IGZvciB0aGUgc2VjdXJpdHkgZmxvdywgYWxsb3dpbmcgdXNlIHdpdGggd2ly
ZWxlc3MgY29udHJvbGxlcnMNCj4gICAgdGhhdCBpbmNsdWRlIHRoZWlyIG93biBkb25nbGVz
LiAoVGhpcyBkb2VzIG5vdCBpbmNsdWRlIHN1cHBvcnQgZm9yIHRoZQ0KPiAgICBmaXJzdC1w
YXJ0eSBkb25nbGUgeWV0LikNCj4gDQo+IFRoZSBmcmFtZXdvcmsgc2V0IG91dCBpbiB0aGlz
IGRyaXZlciBhbHNvIGFsbG93cyBmdXR1cmUgZXhwYW5zaW9uIGZvcg0KPiBzcGVjaWFsaXpl
ZCBkZXZpY2UgdHlwZXMgYW5kIGFkZGl0aW9uYWwgZmVhdHVyZXMgbW9yZSBjbGVhbmx5IHRo
YW4geHBhZC4NCj4gDQo+IEZ1dHVyZSBwbGFucyBpbmNsdWRlOg0KPiANCj4gLSBBZGRpbmcg
c3VwcG9ydCBmb3IgbW9yZSBkZXZpY2UgdHlwZXMsIHN1Y2ggYXMgZmxpZ2h0IHN0aWNrcy4N
Cj4gLSBFeHBvc2luZyBhIHJhdyBjaGFyYWN0ZXIgZGV2aWNlIHRvIGVuYWJsZSBzZW5kaW5n
IHZlbmRvci1zcGVjaWZpYw0KPiAgICBjb21tYW5kcyBmcm9tIHVzZXJzcGFjZS4NCj4gLSBF
dmVudCBsb2dnaW5nIHRvIGVpdGhlciBzeXNmcyBvciBkbWVzZy4NCj4gLSBTdXBwb3J0IGZv
ciB0aGUgaGVhZHBob25lIGphY2suDQo+IA0KPiBUaGlzIHZlcnNpb24gY2xlYW5zIHVwIG1v
cmUgaXNzdWVzIGZvdW5kIGJ5IHNhc2hpa28uDQo+IA0KPiBWaWNraSBQZmF1ICgxMik6DQo+
ICAgIElucHV0OiB4Ym94X2dpcCAtIEFkZCBuZXcgZHJpdmVyIGZvciBYYm94IEdJUA0KPiAg
ICBJbnB1dDogeHBhZCAtIFJlbW92ZSBYYm94IE9uZSBzdXBwb3J0DQo+ICAgIElucHV0OiB4
Ym94X2dpcCAtIEFkZCBjb250cm9sbGFibGUgTEVEIHN1cHBvcnQNCj4gICAgSW5wdXQ6IHhi
b3hfZ2lwIC0gQWRkIEhJRCByZWxheWluZw0KPiAgICBJbnB1dDogeGJveF9naXAgLSBBZGQg
YmF0dGVyeSBzdXBwb3J0DQo+ICAgIElucHV0OiB4Ym94X2dpcCAtIEFsbG93IHNlbmRpbmcg
ZnJhZ21lbnRlZCBhbmQgQUNNRSBtZXNzYWdlcw0KPiAgICBJbnB1dDogeGJveF9naXAgLSBB
ZGQgc2VjdXJpdHkgaW1wbGVtZW50YXRpb24gZnJvbSB4b25lDQo+ICAgIElucHV0OiB4Ym94
X2dpcCAtIEFkZCBhcmNhZGUgc3RpY2sgc3VwcG9ydA0KPiAgICBJbnB1dDogeGJveF9naXAg
LSBBZGQgc3VwcG9ydCBmb3IgUERQIGd1aXRhciBjb250cm9sbGVycw0KPiAgICBJbnB1dDog
QWRkIEFCU19DTFVUQ0gsIEhBTkRCUkFLRSwgYW5kIFNISUZURVINCj4gICAgSElEOiBNYXAg
bW9yZSBhdXRvbW9iaWxlIHNpbXVsYXRpb24gaW5wdXRzDQo+ICAgIElucHV0OiB4Ym94X2dp
cCAtIEFkZCB3aGVlbCBzdXBwb3J0DQo+IA0KPiAgIERvY3VtZW50YXRpb24vaW5wdXQvZGV2
aWNlcy94cGFkLnJzdCAgICAgICAgICB8ICAgMTcgKy0NCj4gICBNQUlOVEFJTkVSUyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2ICsNCj4gICBkcml2ZXJzL2hp
ZC9oaWQtZGVidWcuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE2ICstDQo+ICAgZHJp
dmVycy9oaWQvaGlkLWlucHV0LmMgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArDQo+
ICAgZHJpdmVycy9pbnB1dC9qb3lzdGljay9LY29uZmlnICAgICAgICAgICAgICAgIHwgICAg
MiArDQo+ICAgZHJpdmVycy9pbnB1dC9qb3lzdGljay9NYWtlZmlsZSAgICAgICAgICAgICAg
IHwgICAgMSArDQo+ICAgZHJpdmVycy9pbnB1dC9qb3lzdGljay9naXAvS2NvbmZpZyAgICAg
ICAgICAgIHwgICAyNCArDQo+ICAgZHJpdmVycy9pbnB1dC9qb3lzdGljay9naXAvTWFrZWZp
bGUgICAgICAgICAgIHwgICAgOCArDQo+ICAgZHJpdmVycy9pbnB1dC9qb3lzdGljay9naXAv
Z2lwLWFyY2FkZS1zdGljay5jIHwgIDE3MyArDQo+ICAgZHJpdmVycy9pbnB1dC9qb3lzdGlj
ay9naXAvZ2lwLWNvcmUuYyAgICAgICAgIHwgMzMyMCArKysrKysrKysrKysrKysrKw0KPiAg
IGRyaXZlcnMvaW5wdXQvam95c3RpY2svZ2lwL2dpcC1kcml2ZXJzLmMgICAgICB8ICAyMjIg
KysNCj4gICBkcml2ZXJzL2lucHV0L2pveXN0aWNrL2dpcC9naXAtcGRwLWphZ3Vhci5jICAg
fCAgMTI5ICsNCj4gICBkcml2ZXJzL2lucHV0L2pveXN0aWNrL2dpcC9naXAtc2VjdXJpdHku
YyAgICAgfCAgODEwICsrKysNCj4gICBkcml2ZXJzL2lucHV0L2pveXN0aWNrL2dpcC9naXAt
d2hlZWwuYyAgICAgICAgfCAgMzUxICsrDQo+ICAgZHJpdmVycy9pbnB1dC9qb3lzdGljay9n
aXAvZ2lwLmggICAgICAgICAgICAgIHwgIDQ0MSArKysNCj4gICBkcml2ZXJzL2lucHV0L2pv
eXN0aWNrL3hwYWQuYyAgICAgICAgICAgICAgICAgfCAgNjg0ICstLS0NCj4gICBpbmNsdWRl
L3VhcGkvbGludXgvaW5wdXQtZXZlbnQtY29kZXMuaCAgICAgICAgfCAgICAzICsNCj4gICBp
bmNsdWRlL3VhcGkvbGludXgvaW5wdXQuaCAgICAgICAgICAgICAgICAgICAgfCAgICAxICsN
Cj4gICAxOCBmaWxlcyBjaGFuZ2VkLCA1NTEzIGluc2VydGlvbnMoKyksIDY5NyBkZWxldGlv
bnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbnB1dC9qb3lzdGljay9n
aXAvS2NvbmZpZw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L2pveXN0
aWNrL2dpcC9NYWtlZmlsZQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0
L2pveXN0aWNrL2dpcC9naXAtYXJjYWRlLXN0aWNrLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9pbnB1dC9qb3lzdGljay9naXAvZ2lwLWNvcmUuYw0KPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L2pveXN0aWNrL2dpcC9naXAtZHJpdmVycy5jDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5wdXQvam95c3RpY2svZ2lwL2dpcC1w
ZHAtamFndWFyLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbnB1dC9qb3lz
dGljay9naXAvZ2lwLXNlY3VyaXR5LmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9pbnB1dC9qb3lzdGljay9naXAvZ2lwLXdoZWVsLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9pbnB1dC9qb3lzdGljay9naXAvZ2lwLmgNCj4gDQoNCg==

--------------QAiOFZAMExEvWBBxAELL0Twv--

--------------Ol50KTEqWcN1x6Wdla0X4FVI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEndez/blurJ1OdxJq0EdkUReHwWwFAmr7Q2IACgkQ0EdkUReH
wWy3MA/9HI8va69NrU2pEADGA6eZ5P3ieEp9tukXNL15zhS6cv+0GsM/Lb/9Um9I
AXUlGZtM7w+TuobUT1yA53W7z+URCUOmCwN/tN9bokY7YfM3CD7QZU6p4Lst8jRK
+HIme9aFmoM+pegZQWpw82wlxfc307VHy0pcD5vwXMQuDfZk6+ncPJrDl37oFp9U
Iivg6F7C+2XmWhYk4XWS1ZdcaXtyj2hwGLW6gc8IapPA77BcJ8/nzT5zhztzyff9
OTHYIIMExtxrqXNkDWF2bWSdaqJlCgKXiyQ2ltXiU3FMTAAFhnx/BgfidlCdqXtj
kApsAw9c0H1HyHMjvy4wJv/PAzYlaAn0jtm3B56/WnWmWD2gHTIk/4f3S1hXSPPX
3zlE/CpvuBhwbmwAhI3vGRaQwuCkNRgOS6qLIoEZE+aLRlPL5PGANesY7WvAxCNm
2GW5hEnSnCgi6m790qnIEoR+1D/CnXO4os7E9ECOXRWR+pWEUDu/VPO/KYbZhP6U
qfRn+Gee3APB2Er6i2AGp9G3hS+4uhwEY/P8HMNu1xRwCxvzQ2beQA4jZJu4d7pk
lJeh0Kk5v2OQkZgIcFMl29Gkp5jHo9n+A5EAwgMGcbAXOkQsj5StDX7IdGS2C1MN
xTPgLE+i6spo1GBrs2Us9SW7fdgcBttU4ANNFzUGqzmTEGjtZf8=
=xALV
-----END PGP SIGNATURE-----

--------------Ol50KTEqWcN1x6Wdla0X4FVI--
