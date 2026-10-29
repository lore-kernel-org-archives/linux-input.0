Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793302309;
	b=tdzobf/vmWZKciJl+nJuP9vJM79XvGc86vC+xiIhdeWPbDpXHnC+px5zo+ENThRj+ABh
	 YyGy7e81UumArEdb4oEvS7y2f4zg51WtQskU2dwP66Nn08K0FtwjpNQLtv5yWTivZOPIa
	 3aaKaJPCOdrorf15VUYc+NsnjZ8NP+MotFuPnPyzrdhmBCMX2CrOGWfEKdfI+gyicUTwC
	 d8WC1Xk3WkRpcX/NMT3tK911ufg33TtGCMpnwxadiy4NDo2Rjj3KBJx+WpgLBlzJN4p2/
	 2ntA20MvedvzuE0ElB00x3/QMd3GxOEK/QCtiuf8LuVCM+VUBxcHpEWnM1GOGBdvwPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302309;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rXHdJ/PRgQ0OXwcLegs87BCYF8A2eLw0cDlzJtMRi14=;
	b=I2eNmyeI2Niyx4/Wla5NO8XrddHbd5pK9aiOs8LbBGytmade+0/8ZDwalLXvus68W3fN
	 FtAnbtAlh2YO9c5oasw+iHiW3JEbvCPJ3laf6hoUykdCTbsC5G5Q0a5V3bV3YxibFzsZO
	 nmj/Ql5ScL4KtlTQunlPWOvtxHeReh+3NwsvOA8vBOCiUXs3rFHZNg2vstI/yUT97FrgH
	 aW7xrqPusOGzUmPgf9Fpr1LeQAw+iSvLakaao9EW6Oc77w+VCwYXGZYkXJK2NN41jpSHd
	 7/L7Qe0i5N3erGsgUFQNR+U8c1fwgKsZuzriAzs+/cDETCCd4LxW0F8J9ELjzjMZi1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherry.de;
	spf=pass smtp.mailfrom=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=KsnkjUjp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.56
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030E606A31F;
	Thu, 29 Oct 2026 19:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B030E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=KsnkjUjp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysnhl9WH+P2y3qf89fe9lbioq6Nc2Yn/NnJFG7zRHHDBUCpD8JgvfDraYfewq47VzWelcwwwkWPkOFLDd8s8du4/78/izutq9+qaTYcxJP7r5lt1OOTrAKCOpBzrTNL6eGjL4I8p6LBQPsnafLZXghGQE9mWtIPFVkbmlO23XdyGhMf/ju64ppUb22OCgI5BGPdz0bzJ14SU8X7FRTpEdXV4hyaasS8gAl4/loh611Ve1H9lb1tiSi6S3I6LnpbNDxT/ROe138QEdvNBkoo0L7qO2SaP0ERVx7blXcOLxWs6xT1bsCffk9vU1yAbMNr+mmlFkvjdxTNlkA6h/VuM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXHdJ/PRgQ0OXwcLegs87BCYF8A2eLw0cDlzJtMRi14=;
 b=DBQkfSLI9uXkZhMCG+8RjxB4gNrGJb8GoG4OKnIXz2UhpaqsyVnmIXato5SRhQueEA1Cr+/0iWBpx4IJ0CdmixCNa1113PXY/9+TNtBFo0kzsYcjQslha0AG03b8x8dhjLGERTD7aRmrABeitl/G/iXE9fy+2ylEmB8lv9Wj4eT5DLF+I5QvOKje/oNB1IbR1o8m/QMdGcPhReM1b4HaHv3N+TnfxS9ohH2P713osIfeYLTS9zOq42IKOBM2Wn9g2nlsfqBEMsf95QSrH9ENKBI9g8gHwUXylOImxjqM9FALAZfr8MCPCf74NvCmA36+vVOVqnnnpFcQOmDhlQp1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXHdJ/PRgQ0OXwcLegs87BCYF8A2eLw0cDlzJtMRi14=;
 b=KsnkjUjp3tSv0ZX5+rYg7NE1PPRE6f90XNPqHHteDQf7h2avltMLwwi+oZ6gomy/vrPYFtuq9j81uCfsETR7KSChwTK8YhvCZz7fFI4JL17ENo1zSd3PTc3xcDAygVpsasOIa3uzdqaTzbY8lGJjf2T4H0g1jfVRcf5o+kshr8A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MA9PR04MB991951.eurprd04.prod.outlook.com (2603:10a6:250:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 19:31:36 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 19:31:36 +0000
Message-ID: <a220ebd0-a28d-44cc-9a80-62382018348c@cherry.de>
Date: Thu, 29 Oct 2026 20:31:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Suspend-to-RAM fixes for RK3588 + SPI-connected RK806
 PMIC, enable PMIC sleep on RK3588 Tiger
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0151.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
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
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MA9PR04MB991951:EE_
X-MS-Office365-Filtering-Correlation-Id: 464ac9f0-6005-4aad-6eb8-08df35f33f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|10070799003|376014|7416014|261028144727099003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|10067099003|261021135927099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KYxlVY3KYvCKikhfcoLuaQXeHJkRAodEnwAqEKlGkx0LMzgEYZvv9fWPSq7mJxj3SU2mj3DcfOEs1b8QH99oBYgfYldQW7Y5c74iCqN6+BK4YcE/1qZiOEykxEQPaxj1MkyG6V3QhbqcXe2kr9HNnbZbuTP16KHB7L94+4UkgoOINxyU0dwhWmSH6gisJZals0vxZ0QW7/X5JSqtNxJb0pXEsUGQbGqAjjczB9wQT6g9NMRLtsHGSUyWOzC8JDfDICLu4Z2wi/pG6zNSP4DkxeVCsATxx1FPmu7//v1Nq1OYQhCxsPWhQOouwc7e5OQDJEvl851V4VHYDVb1q+PeuvcPkTdrUhKUdd6SPrSUfw+iV8wwcEDTvSi57gPtVOG2Ze5FSoTvuUyx1qjAqBqixYI3Z54Hsc6Oabx3w3NiqMbu+s211bPYABfaW7BYKUtX3AeusuTziLgqFxjH0ZlGISM86CSA2AEtT7r59isfuQCxVJg2iUXEQE81wWcMrXXhI58A2lTCz09eaopdVacMSPD9l4m8XExGVSJZyjWvn1jN2LOjVX9wewsDgYbt6jYExliAxUV9n5ch6jRkYvdr3UWmKogoNQ5wLz11YYFlIFqhLKMn/Tzny7r+BGXb5U2p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(7416014)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(261021135927099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmUyQTNBSTc2bkV4UTdManl3SHZBU2ZwTUJGMUhtdUxEMnd0VXRyS2w2NTNw?=
 =?utf-8?B?TkMyV1pjeVp5TWVzWHZpUkVpVTE3R05DNW9RMDZpZURZVWYzZFdLQzZ1Zk9o?=
 =?utf-8?B?bnA0QVg4K1gyaEdNK1dYajE3cllEQ0dBQlNNQTVqREg0cXp2b2VxYUQ0SXhR?=
 =?utf-8?B?T1AvQlhXYXhHKzllUzVVclVYVW40bTMxNWpkamsxaW9hbENVeXRFK2J1ZDhC?=
 =?utf-8?B?V04reXZ0U1c3d3plYXJDRTQ2TjdzZDFSVkJ5MTdTQWlodmhSbk9ZOFltVFVn?=
 =?utf-8?B?RURLUnFNaWJjUFZ6YUJ0azJ1amFFMW94aHFJdWNhQ3NTdnNpWHp5cGRONzQz?=
 =?utf-8?B?ZWszNEd5bVJZVGhqZnZEdkFFU2xGeVR5YUwwWi9jUWlxRlg3N1RvSXE3UVUz?=
 =?utf-8?B?c1BRdUJIbTF0MERFL3QzVlUxb3U5WTB3S21kYjVFRzJBb0dBWThiUmFXTzhK?=
 =?utf-8?B?ZHhKLy9keXZESVR6L3cwc3pEZis4REZhNENVbHhpSU0xcGIvS2h6ZkhZRUdM?=
 =?utf-8?B?ZWdHSkhVYU53ZnVkZWVtUFdlb2VxU1BVc3JmaFVISDV2SExRcFlkaDFFMWcw?=
 =?utf-8?B?RUloTjlKNk9qalVkNFZrTHQxdWtiamJZQk8yVGJXSjF6UlVpS05KdTV3SHN5?=
 =?utf-8?B?Y1pRcWxhaldRa29CNE1ySldpNGQzcWZmblhoRDNJWU5PUTFOQVF5WWNmSlZo?=
 =?utf-8?B?bWxaa2VlaVBKeTI0ZzQ0N0grQTU4ZXljVGxkcGQrL2FGU2RBRUd4ek9nUnZ5?=
 =?utf-8?B?UnJuS2NCb1RxcnB2L2paeXdKMUkxUmdZUnNxbjBLa3Eya2sxcGhkTWQ4MTlm?=
 =?utf-8?B?ejAxQUtQdysvdkxORVNDenhyZVhtS1RjaWxTVzJ3SVJSQkx3NDVyeU8xOStz?=
 =?utf-8?B?Z3cxU2RHTXVsQVZkQys5cE1oamR4bkgrSHpkS1ZUVlRPelRWM0NHMzRIRzdp?=
 =?utf-8?B?VDd2YzlxVkM3MG9IYWFlYjdwOHc5bVpOQlRvc0ZMMFVIMGdnN0k3UkpKVGw2?=
 =?utf-8?B?c3hNKzYrb0NBMEd3VWNYcmcwcjNyOW1CU1ptMVdud3pMdHNGWUhtQmJ6VHEy?=
 =?utf-8?B?QnVMc1ZIakdvNFJTUHhzcGtnakNSbkRCdjd4K1NRRmtieEFVNklnWG5SOENy?=
 =?utf-8?B?TE5ZUkxjVExPZWk2YlRxSWJHRSt3RVR3Wm0yZnN1cDdjQUVHUkE0RFdqK0dk?=
 =?utf-8?B?V29VMUkvZmhRenNSZnlacitBWlJ4ZU1oVVZpM2tOZ1cwSEE4YWNta1FZYUxs?=
 =?utf-8?B?NDVOMjNnNHRGd3hYTGlFS3hUN210dnF3Y0ZpVDFJRlF4T2NaMnVDcktRVWdx?=
 =?utf-8?B?SkdFbC9wOFVvMTNPYXhpYWwwbUxqZHhOSEFmSS80V2lEdlQ2bHBKMjZNbGN3?=
 =?utf-8?B?MndaZXVoZXJ4ZDF2Zk1sekpUSzdjMnpySndqVDZmSm1SZWtpVmEzQnJvRXlR?=
 =?utf-8?B?a0pRZWszVG1tSlZBWG94S3VES1NVUTMyT1hkZjBGYmpwNkpBQ2d4NjJUQmlo?=
 =?utf-8?B?bnI0a1VLNVlWdVdWSXVONS9FVXpNdG1SellHaFREWkdRRTlDSlpKbkoydnN4?=
 =?utf-8?B?Z0svTUt0MWcybkFBNmdKSXdBUnU1VElZOGlmSUgvNmVXRVJjUE55NCthVFZF?=
 =?utf-8?B?RzZsdDhvdnorODVCcUtKK3NGd1IreVZKZXVXM0Z6eUdnMVMzUUs5anU5Sjl6?=
 =?utf-8?B?SWs3U0FFMlZobVUyOVZRRloxV3RHeFlXU2twZk5YSUQwcnFNOWxaQTRlaEto?=
 =?utf-8?B?VXovaVFwT0VuR1U2YktIK2QzbXZmS2dHaEh4YjR5Rm4wSnVzeStETmtSY2hV?=
 =?utf-8?B?aGZFN09CWmc4eUs0Q2R2NExyK2pqdmttVG9LRDBrSzZUWjIrckZwR0xFY0Rv?=
 =?utf-8?B?RlJnM0oreDRoVnVWKzEzSU1odE43L0wrcTZCODU4c1ZFWVdNMU1qRllUZDl1?=
 =?utf-8?B?TEVmcVZCbUlQQWhJOXFGNE10VEo0Z2tPMzBranJjUS80akRRNkkybVEwZGlh?=
 =?utf-8?B?Z1lReG1odHYySHZRd3FUaVpvNDNzTGx4T21UVm5hMndSMFNTdGkvWC9yY2dG?=
 =?utf-8?B?clVnWWdUQzVCOEJtN0FaeStnOWs0empHVVh6RkJpTTNpZkQraDlxR00xSGlO?=
 =?utf-8?B?eWljdGhKd0lSdWYxMVhnS0NmYkg0dTJYT3BPQStaRS9iL0dmL25vOU5yM2Qx?=
 =?utf-8?B?U2FZWnZ6U3RyQkE5RHdoV3l3UlFMRVk1T29oNUo3d2pmRDBPak9JNEk0Nm9H?=
 =?utf-8?B?UnlFS083UURUSnZ5SFltQmlXTE5WcTJjSE5hTFg2cGM4clllM2dwTEQ2SjRT?=
 =?utf-8?B?YUVEZE9XUWFROTV1Nng5ZmV2U0JBdmZvZFdGekhPdm13Z2cwQUlPSVU4WnhJ?=
 =?utf-8?Q?/Ljc7TUuLLR3hdZxzxEWFefKLBq1mnCsPPqQZp32QrUry?=
X-MS-Exchange-AntiSpam-MessageData-1: N7eENv+o8uC0XnsHL/dJcMUMCrXeai2+7F4=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 464ac9f0-6005-4aad-6eb8-08df35f33f19
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:31:36.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idYDF89jTOXDiP5vL7hnzt4LaOz8VBj+yOH8u+tV7I9kstu28uJM/J2BUuVJNg8+PwFjxGjjDPtBVGN1rUbZPdDLVvfc/9/52p7Zu1S2jGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB991951

Hi Jakob,

On 10/29/26 11:06 AM, Jakob Unterwurzacher wrote:
> This series, together with a few out-of-tree patches (see below), makes
> suspend-to-RAM on RK3588-Tiger work, down to a power consumption of
> about 0.4 W. Patches 1-3 apply to all boards with an RK806 PMIC
> connected via SPI, which includes most RK3588 boards.
> 
> Patch 1 ("Input: rk805-pwrkey - enable the wakeup interrupt during system suspend")
> arms the power key interrupt as a wakeup source, so that the
> power key can wake up the system. This is done in the regular suspend
> phase, because the SPI bus to the PMIC can no longer be used in the
> noirq phase.
> 
> Patch 2 ("mfd: rk8xx-core: keep the PMIC interrupt disabled during system suspend")
> keeps the PMIC interrupt disabled across system suspend, so that its
> handler does not run before the bus to the PMIC has resumed.
> 
> Patch 3 ("mfd: rk8xx-spi: add system sleep PM ops")
> hooks up the existing rk8xx suspend/resume callbacks for the SPI
> variant, which so far lacked them.
> 
> Patch 4 ("arm64: dts: rockchip: put the PMIC into sleep mode in suspend on RK3588 Tiger")
> configures the RK806 PWRCTRL1 pin on RK3588 Tiger for its sleep
> function, so that the regulator suspend states take effect. This lowers
> the module's power consumption in suspend-to-RAM from 1.09 W to 0.43 W.
> 
> The patches do not depend on each other and can be applied through
> their respective trees.
> 

Then have them in separate series. Series should be as small as 
possible, down to a single commit if possible.

> Testing
> -------
> 
> Tested on RK3588-Tiger on the Haikou baseboard, on top of the v7.4 merge
> window (a8530b69fc4dd): 30 consecutive suspend-to-RAM cycles, each woken
> up by the PMIC power key, all resumed without errors in the kernel log.
> USB devices (a SuperSpeed hub with an Ethernet adapter, and its
> High-Speed part) stayed connected across suspend.
> 
> Out-of-tree patches
> -------------------
> 
> To test this series, out-of-tree patches were needed and used:
> 
> 1) Upstream TF-A does not complete suspend-to-RAM on this board yet, so the
> tests used Rockchip's BL31 (rkbin v1.47), configured through a small
> out-of-tree driver. The plan is to get suspend working in TF-A instead.
> 

I'm guessing you(r LLM) meant upstream TF-A here? Or what is it that you 
mean?

> 2) The inno-usb2 PHY has to be resumed when its 480 MHz clock is enabled,
> otherwise EHCI/OHCI resume hangs. This is addressed by Sebastian
> Reichel's inno-usb2 series [1].
> 

Having access to your downstream branch, you have a patch generated by 
your LLM and not Sebastian's patch series. Either use what Sebastian 
posted, or be more careful in your choice of words as I read the above 
as implying you used his series.

> 3) The GPU and NPU domain supplies were kept always-on. genpd powers
> these domains on in the noirq resume phase, when their regulators (on
> I2C/SPI) cannot be reached yet. I'm not sure what to do here, yet.
> 
> [1] https://lore.kernel.org/linux-phy/20261001-phy-rockchip-inno-usb2-clock-fix-v2-4-e01bf509359e@collabora.com/
> 
> Known issues
> ------------
> 
> PCIe devices do not survive resume; this depends on system PM
> support in pcie-dw-rockchip [2].
> 
> [2] https://lore.kernel.org/r/20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com
> 

There already is a v6 from almost two months ago. Did you actually test 
with the v5 or are you just hinting at what could be helping resume PCIe 
devices?

I'm sure Sebastian would be happy to receive a nice Tested-by tag if you 
did indeed test that. Link to v6: 
https://lore.kernel.org/all/20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com/

> Tool use
> --------
> 
> These patches were developed with an LLM-based coding assistant (Claude
> Code). It ran the suspend/resume tests on the hardware, analysed the
> kernel logs to find the causes of the failures, and drafted the code
> changes and commit messages. I reviewed all changes and tested them as
> described above.
> 

All your patches are missing the Signed-off-by, required to signify 
DCO[1]. LLMs are forbidden to add it, so I guess you missed that when 
reviewing the patches before sending. Please triple check that you agree 
to all criteria listed in the documentation before adding the SoB to 
patches generated by LLMs[2].

[1] 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
[2] 
https://docs.kernel.org/process/coding-assistants.html#signed-off-by-and-developer-certificate-of-origin

Cheers,
Quentin
