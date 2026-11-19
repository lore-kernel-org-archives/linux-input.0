Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.130.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795079577;
	b=T4C7q8mkvdbaYg3pRsTvD4txQHvgArjeFNheFqljbfzBrcj/GHI0oN+IscJ4vJjSxy6x
	 XOHnWfQ4+tBo5879hFEsTZ6B8+SVFrmI5XW1SZPQE+/sP+TYcQUz+2F/An/REzgV98uej
	 6E5SE7LrzH2L/4H2r9/NCEYQuGgWkzrikYlzG0TZ9no5BnJcgb6m6ciuzvttaSFxO5eVM
	 RLnrqi1H4s/iUpnH8QdwwadL8ZYGYQIYg0ddQzzThhsaulYVeRDSpWq1n8cm2rwr2HZOD
	 gR1ZcQeRwbV4K5syIHJdMyBpbSgRrfz5qyWH5/TKN3YAF59JtGILo8yUS66pYe4/7Yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079577;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8D1gNUSDy7c0U+03wfTJBNTnsYDSvEUXFPfEdtJXXHc=;
	b=lSmDGUwlsYYk+6uc4zSRlXgxGnV0YrTi+a2oSS+qkeQ/rO6zR87olcujHRimjYM2J0Ue
	 EueF9KKWTUh8oCSIMJxZkiHueQRR23mMV9geEv2LdeER6G5+lVhJ9vJXMftq86OJrh+0F
	 cf+o3IlchqpbwMySn8jKlvLAkT5xWj+KY7gdBETPxjYJvbrBe1xHVttlpxArUiGG8sUMP
	 UMri4pfQQJBxRVkz39hoV/oOr0XA0G8NzC9wDVJeZGFuqR4sAgm2BKz+nhAT/CG8YTvaC
	 gF2/4L4ICb475/xd878WN2if7OxBJ56tqgUmlesW5UQOUINKRzZ391Eu+REYAM6buow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherry.de;
	spf=pass smtp.mailfrom=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=jfFaPc3p;
	arc=fail smtp.remote-ip=40.107.130.45
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2423606A325;
	Thu, 19 Nov 2026 09:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2423606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=jfFaPc3p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVpGYDv+5ierkXdqrx/yVDhsUZXn0zE6KiRw5E2BoveWaeMeXRrdDcq3vSADClsUgCIQ/pKQneI3pXu/4ud8q8JrRrwxI70lNhW5i7hA2JTIL1UdG4+JPmVBMeGL2HUUEhLL8yD5rw8Pci/3VF/aejAJQfFo6FbzCZ2yPc/l6NQFUEevXkH+3WoGlcVmYUZOoqbCYNvVmboYrhPGvzWw9EPhCzsNizStzs1jV0Tj6F+PByxl2cmxvNVyJVmPB4S9+kBoobEPq6OS3mfpaCjmSG8oTfmEiDlwPbHfMDL7Li5/yJv+6W4LKhsaDCusvdxyGiSDuHyWe2+Q8QHLECjQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D1gNUSDy7c0U+03wfTJBNTnsYDSvEUXFPfEdtJXXHc=;
 b=Pevfqz29yBUCRBoU+4E5oxpeQzmHtrP38ittjlqPl745C/kytSKhy7C9JxjfudLNH4YiKohEImDIqyCwESR09X/LWH7smjcQwMa6kGFgcaw8cA8zkJHcjd0NZz1cKIvC6ZDd+bEPNlaAEbuH1EhlDPIuVGHDsfHQlJufcIDaDf0ZFO8mSLCkNz4+nQwhfNuCzyDCUCF6oew5t0552bOYHJtT7Kejdb3M5Ozlc0ut4r+y+EHdkhFT2EAbkphAZ7vHihWcsaKRFqV6fjZ7Dl3zJ4bn3y1n/o6N/1P3pkkt3tkzW/ivy+EjjdyNADS8oIIjuw7doZnsXH4r+u6rd703eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D1gNUSDy7c0U+03wfTJBNTnsYDSvEUXFPfEdtJXXHc=;
 b=jfFaPc3p1tfaOmyWVZyGqyBFVuhovMiaM4Ghp3YJkTyQx6hSWcodgG29C8ra+XnGxwfyY2Fo0HI89wQ0Ylni711ewJHirk4TiNMEx89awkzwOSXGs1qj1OwG1jbX3D1rXVEQKx3k4aKn9PmUyQ03TmUa78HM1ud8Lz5PHd5l82k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12016.eurprd04.prod.outlook.com (2603:10a6:150:335::6)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 09:12:51 +0000
Received: from GVXPR04MB12016.eurprd04.prod.outlook.com
 ([fe80::f2d4:9db8:9a4e:b0bd]) by GVXPR04MB12016.eurprd04.prod.outlook.com
 ([fe80::f2d4:9db8:9a4e:b0bd%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 09:12:51 +0000
Message-ID: <af94a18e-cb7e-4319-95e3-0df120f730dd@cherry.de>
Date: Thu, 19 Nov 2026 10:12:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Suspend-to-RAM fixes for RK3588 + SPI-connected RK806
 PMIC, enable PMIC sleep on RK3588 Tiger
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Jakob Unterwurzacher <jakobunt@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
 <a220ebd0-a28d-44cc-9a80-62382018348c@cherry.de>
Content-Language: en-US
From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Autocrypt: addr=jakob.unterwurzacher@cherry.de; keydata=
 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
 ldPHIqbIwpfecQ==
In-Reply-To: <a220ebd0-a28d-44cc-9a80-62382018348c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:803:64::28) To GVXPR04MB12016.eurprd04.prod.outlook.com
 (2603:10a6:150:335::6)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12016:EE_|DU2PR04MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ab31c7-0474-4bee-9f7a-08df461d496c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|11063799006|4143699003|921020|56012099006|22082099003|18002099003|10067099003|261009223027099003|261102123227099003|261028144727099003|261021135927099003|261021133027099003|261021121427099003|261022115727099003|261021123027099003|261026121527099003|261022075727099003|261026140227099003|261021130227099003|261022105027099003|261022113327099003|261026130827099003|261026135527099003|4133799003;
X-Microsoft-Antispam-Message-Info:
	bs7TWLY+TpYAiyoXsT4+xl0ma2kDgE3WAJUDNvrAdngCChNEdV8+w69Mfb9ob6ZmNZFoFVbvitCvkTKAtep032lr0B1S/koOm6fIlu+9d3D8lyUYATbeq2TLn2uBwuztkSvbE+ji9+XxqCp/KCs/d+Uf3BScsV5UphLjBXNaFJafmRQxZPFLQCX/4fexXJIzWabcGufcWEchvJKz3pWXCa4/PJdEJ1FMP1evpTC7MbI0uqiT4wm1qWJRliG/14VIcVWCFSeLVMynPrSF79rfD+/p0ZME6Hxr3DR2n0uJkpZSoIDXNBGwwcv7cjYzIQyfgpipXb/EQdZTkm9Gxp7GW/zF4Hnp1rKHTu4r+JNh1xjqlwA9JWqPenU1VJ4NEsRNPgkwvKcWFMLkOo3V2haaHdHt9XQX1PEkkDiIEueUbrPjzDKOu/Lor7u4Iza2LkAdLTSYdTH9fbzNS91sUE+kaphxsZyzAXXsgdYVSHLnQSEnPPfDholnSHnZ/N9d8n36OQurTJa2HBtb1EyCuGoQhFcTvnq1aCbRHSAyAivqyRJF80O0MPrjElXzZJ1qUE8dpX/xWCjRAZwLB6THLH5mvwvt8LrNGnesQL9q6T2uQBbK9GtRcAnua/0g6FaDa3KvuD4b87GjE8lqy00+vzI1Eke8re+h3pZb6pbWWkCyWx8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(4143699003)(921020)(56012099006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261102123227099003)(261028144727099003)(261021135927099003)(261021133027099003)(261021121427099003)(261022115727099003)(261021123027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261021130227099003)(261022105027099003)(261022113327099003)(261026130827099003)(261026135527099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmwwR0JFNG5kcG5ralErdVEybXIwdnJ6Q1pQVHFQMUdQSURpb2pxWktycVdG?=
 =?utf-8?B?L3BxS2lBYTUrcEhRdWFoQkYxQS9mSmxTbGk1RHl1RnlWbkhnS0puSWVPTG10?=
 =?utf-8?B?eTErY3U4alZ1WUFaZTNnSkRLQm5QTkdEdXZoRHk3NzJhSkxMTHltOEVKN2xY?=
 =?utf-8?B?QnBud3BwRzF0RmFac3BSclVqcnplbmVLdS90VXRPUmZYdENsWURjOTJHSjdm?=
 =?utf-8?B?RDdSVXF4bS92eVNSaFhBYitscSt2OEZYQXFZTytjdG9jdE1MUHNpZ0dOQ0ND?=
 =?utf-8?B?eUhwMHJSdEc1endRV1lrODlTL2dpM1JDaFJEcGYrUFB1d21oTzNzYTBBTEdz?=
 =?utf-8?B?d2Y1dWVtRkNQdzJPbGRLWlJGVTlVRU95Vlg3cDVrSlVrOTlHVDAyV1NpZlhw?=
 =?utf-8?B?eTNtczhtK0JLU0p6bVI4dFAxaVA3c1B4UXVpWDlMZ09uSy9uZG1iWkEwMW9Y?=
 =?utf-8?B?Wm5keWdmaTR4LzhlODcwR3JXL1dnYzZaQmdnVHRSbDJVSTZoZDE1Vk5tMmdI?=
 =?utf-8?B?cnlPNUxHUGRjUHQzMzYrTi8yUmZja1ZySWdSOUxZZDhtWklJWGhyTGpibmdU?=
 =?utf-8?B?RGJMSHZPRlZ6UDRHVnpHTEtZR3phTkh6WHNVNmtNNXlZQTU4U3BCcURVaFNC?=
 =?utf-8?B?MGFwRWJNaGNYQmNjS1c2RDR1L3IvVHlMcDhsMXJNNHJwSWFUU3l2Rzh3UXFn?=
 =?utf-8?B?MVVUV2xXR0RKN1RNWWd2Yk1lUjVMVHpBY29jL0NuSHk4YnpXTVdMYzZIaVlZ?=
 =?utf-8?B?RTY0YXdOb1RXWVArYkkrVU5TQXRIdTBJd04rbStUa1FOTFJwQ04rTDVja01r?=
 =?utf-8?B?bGp0dFpzUG9pVXVZaE80RzR4d2tOVHpzQmg2MHhnMjhlRFJzYi9CWmN0Y08v?=
 =?utf-8?B?VEFOTFRBeHJwc3ZVV1BNNzBqUjc0RnZaaW9vejM5K1JLOGMyUER4bGxrdkI1?=
 =?utf-8?B?MDJpTjRZdm55YngzbksvbWNaeXRLZW50VkxHdVM1cVU2SEkzVTZHVFMrWHlP?=
 =?utf-8?B?dkhXS3NMMFlpZmRjSlpLeCtBOENjSzRzenNXK2d4enJ3VVJIMWNwQzc5eXZD?=
 =?utf-8?B?VkkrTTNuUEpaeDhzM3FLejVMcDdRQzFpbkZub2J4aFFoUEZpRitTSDBlU2M3?=
 =?utf-8?B?WjNFUTlpeGNOZWFTekxoQW9XU0NXZWFiVWJhVTdSQVBRV2JYaWV4S3ExUVVS?=
 =?utf-8?B?SDdOZGQvUkpBaUxDbmo0WEdkZEx4Y0ZJSEx4dTk3UU11SFVuSlYrYlNQWHFP?=
 =?utf-8?B?b0xOVzJSK2VZUlJlTUlUaEltZ0xTREM1aEFPUjhzZUtMa0t2MWozVm44WDJp?=
 =?utf-8?B?R25LVkliZHZqa241WXNoRUdGMGlXUzF1a0JoUEpZcjV6Y29qeXZoMzU5cmYr?=
 =?utf-8?B?bTcxUWRTVTRaQnpLdUcrVWhacmpaOTJESlZBTER4VGE1QnRzSytYVHpmbFgv?=
 =?utf-8?B?VEFsRi9QWEsvZ0pRMVNiTk4wbzhaOTU3UFlIQ3oyZjJIandFdnp2YlY5ajFH?=
 =?utf-8?B?QXVKMGJlZStpWEg0SDZzZ1MyWXVob1ZQcXp2aEJlT1dGR0hvRjVOWWdqQ1Nl?=
 =?utf-8?B?QTNvaUdkN29xaHQrYjBqZitwWXZqVlpQZmxCU0hSTjlFL0d4M2kvYURZaldU?=
 =?utf-8?B?Qm5kRllEVXQxL05wQlJHN05oUEZ1QTJkcS8rY0VBbTNMZHBRT0QraWUvVTlB?=
 =?utf-8?B?NDAzUTJYY1lGTlZ5SDlpeFNDTUdmUjlUb2NMMGgyelpIKzdmWjZLblpCY05H?=
 =?utf-8?B?c3UvTTB4TVRqdnJwWjdnaUR6Wnd2WXZ3L3lVZXVvTWYwQWtVeldQL0VpbzNP?=
 =?utf-8?B?Ym9UL2FENUVxYjNtTzJSSzFOSEpEU3hlRmladFRyekEzUXZZZjRQZDNYMVUy?=
 =?utf-8?B?MnA5RytaOUtEZ3RMZ3AzWDFOYm9JeVJMUzA1NkgyYmViOE9OU2ZXcStPOGln?=
 =?utf-8?B?Q09OR1RQRjlWaldxVTJLRzRpRU9XZ1Z5M05mOWFvQ2MrK0h1VWtwcno2Qk95?=
 =?utf-8?B?d1VUdEVTbEtUUFhtcG1rblZ6U2NadzNDbWtWb3FJN2VaZHBnbjhLZ3NvL3gr?=
 =?utf-8?B?OGIrZDUxeDRyMlIyWXZTRjA5NGpXWWJEZjduanZoRDlhcWdxbHNDMllBaEJa?=
 =?utf-8?B?dUR2SkZXTGFveUVhT3BDY1Y4NDNiR1p2OW1xd3J5RFdleVZGSVl0NEZIOXNV?=
 =?utf-8?B?aTNBMjNXV3JFWUJ3Zjk3YlBvSUhvR0lnd3B6dkJ2L0tZNXdMblZGNEUxdGhD?=
 =?utf-8?B?QWNxNUZ1TGRmc1pxMnpmNVpSeDV2WSt5ZVppMzBZeW9rKzdhOFhTbU5ta2Nv?=
 =?utf-8?B?L3c4c3dwWHY5QUdwNWxremFFRHQ0NVBoT1loVWFwdGdEQmx2bTVjVkN5bU8x?=
 =?utf-8?Q?p9gfaVgHDQv/i7c8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ab31c7-0474-4bee-9f7a-08df461d496c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:12:51.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cP6Ok+cF6MfCKDHA3SA5Ltx+atJvKwo2WeC+rIrQqMyEKbypBxmjK+01rIMFSxhUeDKaEIBktae7G7AV4DqjuQGOyzVvyHfNIW2bfih2gmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919

Hi Quentin, thanks for looking at this!

On 10/29/26 20:31, Quentin Schulz wrote:
> Hi Jakob,
> 
> On 10/29/26 11:06 AM, Jakob Unterwurzacher wrote:
>> This series, together with a few out-of-tree patches (see below), makes
>> suspend-to-RAM on RK3588-Tiger work, down to a power consumption of
>> about 0.4 W. Patches 1-3 apply to all boards with an RK806 PMIC
>> connected via SPI, which includes most RK3588 boards.
>>
>> Patch 1 ("Input: rk805-pwrkey - enable the wakeup interrupt during 
>> system suspend")
>> arms the power key interrupt as a wakeup source, so that the
>> power key can wake up the system. This is done in the regular suspend
>> phase, because the SPI bus to the PMIC can no longer be used in the
>> noirq phase.
>>
>> Patch 2 ("mfd: rk8xx-core: keep the PMIC interrupt disabled during 
>> system suspend")
>> keeps the PMIC interrupt disabled across system suspend, so that its
>> handler does not run before the bus to the PMIC has resumed.
>>
>> Patch 3 ("mfd: rk8xx-spi: add system sleep PM ops")
>> hooks up the existing rk8xx suspend/resume callbacks for the SPI
>> variant, which so far lacked them.
>>
>> Patch 4 ("arm64: dts: rockchip: put the PMIC into sleep mode in 
>> suspend on RK3588 Tiger")
>> configures the RK806 PWRCTRL1 pin on RK3588 Tiger for its sleep
>> function, so that the regulator suspend states take effect. This lowers
>> the module's power consumption in suspend-to-RAM from 1.09 W to 0.43 W.
>>
>> The patches do not depend on each other and can be applied through
>> their respective trees.
>>
> 
> Then have them in separate series. Series should be as small as 
> possible, down to a single commit if possible.


I'll split it into tree (1, 2+3, 4).


>> 1) Upstream TF-A does not complete suspend-to-RAM on this board yet, 
>> so the
>> tests used Rockchip's BL31 (rkbin v1.47), configured through a small
>> out-of-tree driver. The plan is to get suspend working in TF-A instead.
>>
> 
> I'm guessing you(r LLM) meant upstream TF-A here? Or what is it that you 
> mean?

Yes, both my LLM and me meant upstream TF-A.

>> 2) The inno-usb2 PHY has to be resumed when its 480 MHz clock is enabled,
>> otherwise EHCI/OHCI resume hangs. This is addressed by Sebastian
>> Reichel's inno-usb2 series [1].
>>
> 
> Having access to your downstream branch, you have a patch generated by 
> your LLM and not Sebastian's patch series. Either use what Sebastian 
> posted, or be more careful in your choice of words as I read the above 
> as implying you used his series.

I have now pulled in Sebastian's patch series instead and posted a 
Tested-By ( 
https://lore.kernel.org/lkml/ae532396-557b-4a0b-b13c-920a971962b8@cherry.de/ 
).

>> Known issues
>> ------------
>>
>> PCIe devices do not survive resume; this depends on system PM
>> support in pcie-dw-rockchip [2].
>>
>> [2] https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fr%2F20260316-rockchip-pcie-system- 
>> suspend- 
>> v5-0-5bb5ad37d643%40collabora.com&data=05%7C02%7Cjakob.unterwurzacher%40cherry.de%7C464ac9f060054aad6eb808df35f33f19%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639288990982194241%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=cg2d38YMtjlOG4gFsyy7LYI%2FWi4RFRUuHL8QjVL0DJg%3D&reserved=0
>>
> 
> There already is a v6 from almost two months ago. Did you actually test 
> with the v5 or are you just hinting at what could be helping resume PCIe 
> devices?
> 
> I'm sure Sebastian would be happy to receive a nice Tested-by tag if you 
> did indeed test that.

I was just hinting.

It was merged in the meantime ( 
https://lore.kernel.org/linux-pci/179407115382.87267.12160393716568806842.b4-ty@b4/ 
) and I have now also pulled it into my local tree. It solves the problem.

> All your patches are missing the Signed-off-by, required to signify 
> DCO[1]. LLMs are forbidden to add it, so I guess you missed that when 
> reviewing the patches before sending. Please triple check that you agree 
> to all criteria listed in the documentation before adding the SoB to 
> patches generated by LLMs[2].
Well, that's embarrassing.

"b4 prep --check" came back clean, so I assumed that b4 adds the 
Signed-off-by.

But, as it turns out, "b4 prep --check" does not actually work.
I have reported this as 
https://lore.kernel.org/all/a37b228f-0d12-4c26-b29b-51ad59bc6d1a@cherry.de/ 
.

Thanks for the links, I have triple-checked.

Best regards,
Jakob
