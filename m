Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182186;
	b=hA/dN9wgpigVwSR1bRTN0mcXLTHt9yhrmDVX22kN+eOs00JdqWvw2C9y0T3FDAQ+5ufN
	 maWvTz9cvmGJvU+qGMbdkMl7gQveBXMyFMe0mXru30aiRd6nIvGPGoYjIpmXKw8bsBQdB
	 UAb6HFF1mP1GvuBAQqspmK5XZJPOuOWE8DmrqgQyHafmmq1p5sM7+EPs7hTVqxQMGVVj4
	 hgRnZmvgR4lDNkxa955fiPM4YJbpE8q3YopZ+Zy6X6aBgbJ8DRCSps+opmBvRTbwfUOdC
	 qFLcDcLd2mPfmlIqieFaSRRBZA86TR7rAviXXRAkj5OpUv06uAypTQ1uBZmbkhBihnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182186;
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
	bh=q78t59WfVpvCxgLqXsoLMVuo11RK6A9rnfepJ9lCCuM=;
	b=yH0LtRzdppmzyPE6Xs8O28rLBj/SDEHAAoHgkeDvZHvlsdX9GcEusIdQc5Z6p55/wFvj
	 vsArYkaYrs8YKvLUUxqhefabavUx2xNnUNekMktQBFKbMha+5XDk17YN/8g6zt6SGRhJF
	 lkPNMKohd6jMz6Xc9P/xGEwqM4SdVI1QVmzXjjZHn38noIGfvdDYUCXfyu+24Lg61pli+
	 lq6Mu3Dsoyelvtxg4TAYOIYQrlE+OHHMMHrAC0DWwEPSb5vNirpx2MIS5EzkW3nTqG4c2
	 oLSoEnMCIpY9dS68UXKeDbpGXdQMRkOq2V0MKUC0Iw+5zb+yeEseNqkulHtBtbWWWpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherry.de;
	spf=pass smtp.mailfrom=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=FnvX5oM4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.57
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC160A2621;
	Fri, 20 Nov 2026 13:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9AC160A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=FnvX5oM4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aelO+7PHjC8tZ9cTLueuF3rrarpIuYTZC6gO1flBFanHS/WcRNl9RMIKTvaSbSM4VryIMhFX/U8aPMRUXccFMKlv9cmPt96HRib2rdjXRBnphe6zNdA18i8yqyde5jNcPZupAD+PaFWNZsBXPMKmodpeCiZix/iIMSeU9/m0kHjM9199gsilB7cJor43k14BEnm2NNaf6tDeOtPtdgNH444ZKXyzrW+tryuLq47S9ncbD6nVoJg5v88tR6cd94Eo26zmOKTp1HjxFN6PMMM+NezyebdD0Y9Uwr8FgyozZ03zvuT8HavNuNW62Rq916W68osrFwnDVGj+HfH8qWMwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q78t59WfVpvCxgLqXsoLMVuo11RK6A9rnfepJ9lCCuM=;
 b=Pjf4Th8fDfGaOmSC5qgL+62SPnK3bXi4Bpv5BFmMAqzoDWtMCWL89wvQDPovn5fk31fL+6vAH1J0FFIXREQR20sgcdy+4gE7pgSejf8iMcprHN3wceEVb9JjCDM4BQEaP3lZtl5lNYmDxZV6OuDV5y4/CjA1kJ7hk8BQg1plaKr22ZVJY3CPtRiTkc82mvuZlAN5m1sNZlEeGmK19gsQaIsa0r+3G4gOEN1wClieWidOu75l/tM2VnS1zdvjfetTr4EhwWkI7pdD90cwxzJrrL3cI4BKP4ZX9/X+CZlOHh1JJDssNd96XWCPZ+30haEq9iQ73TEyESXNv+0NZujWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q78t59WfVpvCxgLqXsoLMVuo11RK6A9rnfepJ9lCCuM=;
 b=FnvX5oM41hs5nuCX+3rcrXshvHpCLfU5UUJ5KKaVk7kTO3nOYOy7zzkBHzeRg9I9s8xOl3MbcGHEBNLxkLoyVmzPdWLqOPOOEz9aiFZr9zNLqIXYdxeBn1eKfrtjlYlc67i1GS3XcbipY3t9s7autzVUkNKyCQRt54hNLoXs+Lk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12016.eurprd04.prod.outlook.com (2603:10a6:150:335::6)
 by VI1PR04MB7023.eurprd04.prod.outlook.com (2603:10a6:800:12f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:42:59 +0000
Received: from GVXPR04MB12016.eurprd04.prod.outlook.com
 ([fe80::f2d4:9db8:9a4e:b0bd]) by GVXPR04MB12016.eurprd04.prod.outlook.com
 ([fe80::f2d4:9db8:9a4e:b0bd%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 13:42:59 +0000
Message-ID: <7bec766f-14b1-4eac-96c7-d7f1cf38021d@cherry.de>
Date: Fri, 20 Nov 2026 14:42:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Input: rk805-pwrkey - enable the wakeup interrupt
 during system suspend
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jakob Unterwurzacher <jakobunt@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
 <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-1-cb12621c1fb4@cherry.de>
 <avUGEQhSKlko0Fm9@google.com>
Content-Language: en-US
From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Autocrypt: addr=jakob.unterwurzacher@cherry.de; keydata=
 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
 ldPHIqbIwpfecQ==
In-Reply-To: <avUGEQhSKlko0Fm9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::17) To GVXPR04MB12016.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12016:EE_|VI1PR04MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbb4ddb-1f11-4414-461c-08df470c307e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|11063799006|5023799004|56012099006|261022105027099003|261022075727099003|261026140227099003|261021121427099003|261026121527099003|261028144727099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mYGwrL/jF2wClmba4invmpcRcCaKkqRU39Oc1sboB3Dund/sqknR038o5Qq3D+ycB6DLWbWspuTKngJsV1AXDGhmMWZ6i1qVIvbTUqq9piviSOYFe4yta9DKCHi+eF/VpkXPU5HvgVlKYESFSKvQpS4vWurQuY41uTOO7+eGZocVg8tO0pqcH9UyV+Ml3gi6etYNub/MpOoxPDdzfshpKqMLBSCMXmgyxholG94qHPoIN1IaWspKD/dRTGfxlCYsCMT2tPh+xtkVLC6esb3FeGj6uRqMObbJU8Y1fjOXuyNVPYScLQCDmqNS1pY1lDiPnGKsvGFaQA2wP1PeZrkdl6RfLoZ0vXTIeyxBy383TcV02Hue8jFbq9lcoMUbPEArwxO2aQcwLSsXKrDZnx4hAGp/eOHhEFiNxIbWsZCYgSzUK5uA1pGJe05GbbpGfGkA1mIeV9I0i3b8jPlPqUS6uEXB6dPDB70QmcOH6aONUAOONX6+NHfQi3SiibFzBoAb4uBoFLaCF2NG941WpT1W/ESwbp9Ul/Os524F6nb2msmqQC7CNAYVSQJFnbRU4yLF0L0W5RdaZEMQtPr3rKh69J/ahoJO3tqAzcL5ayrO5IRzwmhBz9xGZ7BgSSCnOMB+qkJkhAjBM7mkbmrNAWKrcnjecMpJsDPcbpzgwmnfFF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STlJVjF1OEtFRlJOZ0xzMUNZTUJCb0lkTlJIKzdsNms1ZEtEdFR5aFE4RnpG?=
 =?utf-8?B?UjBjcFpXMVFsK2J1djFIR3VIOUplbm9NTGFnMnN5S3dQV1kxTEw2ZWdCK01y?=
 =?utf-8?B?SWNGVEZCaGlNNnJtYlhYWXFDc0QwajA3N3N6T09lM0tqZXVIbnZ5bFR4ZkxT?=
 =?utf-8?B?SkFxc29KM2NhSjk3Y3FETWZaUTFYTUV6MGhVWDlKZURjYlVoVzlVVnVhNU1J?=
 =?utf-8?B?M2RNT0oyVXRsUnlXMitDZ1dmcnZsMkFoaFhuT2UxSDRZSkdraHRJU3cvUVJ6?=
 =?utf-8?B?RzZvSVp5dmxyb05VNEowV2F6OEdTTStBc2dMTkF1OWtGeWoyLzA5c3M3eXRt?=
 =?utf-8?B?ZytyMEFjblpSdndWMjNxLzRBR0RyV1ZYUDZ4eForMlJxdjBMakcxK082T2kv?=
 =?utf-8?B?MnFKNFVhQkhxY3FMdTBGNmovQ0JzMGN5OUhPYWtacS9aWjhvbGFtUXBmUDJB?=
 =?utf-8?B?dHpmMmlwQno4SjdvTG1JbWpFRWxuZTFqaEtlQ0p1L3dzUWJJYXpsaWVMczZa?=
 =?utf-8?B?RFJJUmlKc3FUTUVad2IvQkZ1RzhCbmxCb3MrZW9aaVpYbm5uQ1NZclFZSHVx?=
 =?utf-8?B?eGMzYzN5YlVMaWxhUlBUc3hma205MmMvV3h4K3JHc2QrV0tHamVtTnJzcUdX?=
 =?utf-8?B?ZWRvTVltUm10eVNIQ0ttOGxqV0pyUU1ualdub1RhMXo2d0N5UjhWS29wRXVm?=
 =?utf-8?B?bHB6Qkk4clp2SlJ0RFA3TjdFVEEwbGZESGRtNmZqNGZ4ODdKN2ZRZHdpV3lK?=
 =?utf-8?B?bEpFV1NQOSsySGxtbVZTelZEQ21YY21LSG9mNjhBMHZuUWpvQXd1TnFxSEtK?=
 =?utf-8?B?R05OeHl4RG41SEE5cm9NSGs4Y2gyYk9tMGJ3aU0wSEtVNTc5YTAwelhlTnp0?=
 =?utf-8?B?TitvZzhNWXJBbDZDZnJQcm94aEFIcjl5NVN1ZThNVE9HbUhra0NQa2Z2NENz?=
 =?utf-8?B?UGlSTEM4bk5KQk81eC9nWjhieUs4OS9vVzhCa2NZQVRlNGppTWx5UndQVHZn?=
 =?utf-8?B?L1RVUUNhUklMTHE1Y3V4dVlhNTFyWDRlNUtSOEhJOTZNUlVCOTJwdHIyd2p4?=
 =?utf-8?B?SWFhc09LS0szamt5eTl2RGE1ZFY4V3dxdVdna054MzNhOUhEenBDYXorSXps?=
 =?utf-8?B?VnJabS9qdE9JWG9JL3NwYm5YOS9mUGd3ck1oT3QvaG01ZjdsSEdwRVcvN3BT?=
 =?utf-8?B?U3ozYUlNWGNUeXRoZEZ1NVdtbFhaT1Z3VnhsVnpuWU1vc1BSU2hWNG9NWmpZ?=
 =?utf-8?B?WlVEQVhzbENyczVQUjN2YUVqUjd3bWgwSG1hejE4K08xNGhya2FVbzAxUmJ3?=
 =?utf-8?B?QWZVOG1DdjJHdlRwR2RxbU5haU5jbGNqd2xaQlFCTnJYV29RQWhDR1RNVjVa?=
 =?utf-8?B?eks0dVJxMTlIbmZacVV1MHdoVjgxVEwvV3FNZUhKN0lLZUhFMWdlZ3pvUUti?=
 =?utf-8?B?R3B5YlVXU29oK0pzQUEvZnFtWHl5c0dIeW1UMldkM2xETmRBc1RuR2FhN0ZJ?=
 =?utf-8?B?eVl0czRVZHZmTG41QlR5UkNRVXBoYjM4U3RUUVdQcG90ZHVSYVFJTGFDc2p1?=
 =?utf-8?B?Uy9aV0R4N0doOFJ1clJHemRlaEF6TVo3R012eWVEOTJ3OHROSUJtR0F5NTB3?=
 =?utf-8?B?dzNiS0ZWcHE5cEdZMGVjUTdmb1VLRVFCaXV6b0lJaUNraGVhK0NjRUQxWFJO?=
 =?utf-8?B?aTNqVVJMQ1ZpRWJKSW56NVdyK0Y0bFhiVjRDWkJhQ1BNMmY2T2JtSXZWclFh?=
 =?utf-8?B?WHcwSTZtdjJxcDIwYjNWWDlyYWk1RUdGMVk4VERYdTZSVU5vYUZiQi9vUmIy?=
 =?utf-8?B?UDlOaVFYb1lGNldIUEVYT1VvdUR4WW1xckYvZ3Z0MDhqZHlJM2YrT2ZOSWU4?=
 =?utf-8?B?STBGZitDd05VVzNpSklTcVlOQ2V3NFM1dFFvRzc0a2h0Y0dGSCtzTzNrWHVX?=
 =?utf-8?B?WFdDUzc3L2tMMHB3anJncldwYmo2ajJaemhsY082REd2TjZtRCtvTGFEaU1G?=
 =?utf-8?B?Mm9rbVFiall5Qjgyd0YzSy9CTktXaERIVUtYKzZ2WXJ0a3FselQxZTN1VVZW?=
 =?utf-8?B?OXF6dmdubFdJeXB4Y3ZZTEQ2SUt1QllQQXg3SFBMQzFqQmM4UHdPOHd5TmFL?=
 =?utf-8?B?MU9TdjJaSjhscTVsbEZ5NlZxbHpzNFJwTGt1eGkvL2F1dFJucXd1OXQyOHlK?=
 =?utf-8?B?SDlCak5iZVRMT0h6cEMyZzFvcnhlVDVSbWlNK08rOUxieUFSNDNTdEhxcW1l?=
 =?utf-8?B?akEwZGl4MkJOUDVYOFJON1gvamxCUjhIMkE1MVhTS213eWpXc3BtOGZjckVD?=
 =?utf-8?B?S3VkSCt2Kzc1NVlwUmllZFhQNnc0ODBFZGRlU0l3bnRKNXVlaERGUkphckJB?=
 =?utf-8?Q?C3sS0THCevhZBN7I=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbb4ddb-1f11-4414-461c-08df470c307e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:42:59.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1t342ixbZCpj/5uXgRSTbNEXYBUXChq3w7hfroxvNASNY0RqZa78fC/dl3ztDFbOY4C4ZStcmNs7kN+QG+09RtvEayu210iizFCfYqYeak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7023

Hi,

On 11/12/26 01:25, Dmitry Torokhov wrote:
> [You don't often get email from dmitry.torokhov@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Jakob,
> 
> On Thu, Oct 29, 2026 at 11:06:23AM +0100, Jakob Unterwurzacher wrote:
>> From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
>>
>> The driver marks the device as wakeup capable, but never enables the
>> power key interrupt as a wakeup interrupt. As a consequence, the PMIC
>> interrupt line is masked during system suspend and the power key cannot
>> wake up the system, e.g. from suspend-to-ram on RK3588 with an RK806.
>>
>> Enable the interrupt as wakeup interrupt in the suspend callback if the
>> device may wake up the system, and disable it again on resume.
>>
>> This is done in the regular suspend phase on purpose, rather than with
>> dev_pm_set_wake_irq(), which arms the wakeup in the noirq phase: there,
>> enabling it updates the PMIC's interrupt registers through regmap-irq,
>> which fails when the PMIC is connected via SPI:
>>
>>    spi_master spi2: Failed to power device: -13
>>    rk8xx-spi spi2.0: Failed to sync masks in 7a
> 
> Sounds like this needs to be solved in PM core rather than hacked around
> in individual driver? Let's CC Tony and Rafael.

How about something like this, copy-pasted below? If no immediate 
objections I'll post it as a proper patch.

With this, rk805-pwrkey can use dev_pm_set_wake_irq with no issues 
(tested on RK3588-Tiger).

Thanks,
Jakob

> commit ad2298eb4cf079b087a590231f09e7cb3ed594d1
> Author: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> Date:   Thu Nov 19 12:03:24 2026 +0100
> 
>     spi: rockchip: keep the controller active during system sleep transitions
>     
>     The controller is suspended in the noirq phase of system suspend, after
>     its child devices. Runtime PM is disabled from the late suspend phase
>     until the early resume phase, so a transfer in that window can only work
>     if the controller is still runtime-active. If it has already been
>     autosuspended, pm_runtime_get_sync() fails with -EACCES.
>     
>     Child devices do need the bus in that window. With an RK806 PMIC on SPI,
>     arming its power key as a wakeup interrupt in the noirq phase (e.g. with
>     dev_pm_set_wake_irq()) writes the PMIC's interrupt mask registers, and a
>     wakeup by the power key is handled as soon as interrupts are re-enabled
>     at the end of the noirq resume phase. On RK3588-Tiger we get this:
>     
>       spi_master spi2: Failed to power device: -13
>       spi_master spi2: noqueue transfer failed
>       rk8xx-spi spi2.0: Failed to read IRQ status: -13
>     
>     Take a runtime PM reference in the regular suspend phase and drop it on
>     resume. This keeps the controller usable until its noirq suspend
>     callback, and since it was active then, pm_runtime_force_resume()
>     restores it in the noirq resume phase, before interrupts of child
>     devices are handled again.
>     
>     Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 1a81fd94b4396..504068b15c184 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -938,7 +938,27 @@ static void rockchip_spi_remove(struct platform_device *pdev)
>                 dma_release_channel(ctlr->dma_rx);
>  }
>  
> +/*
> + * Child devices (e.g. an RK806 PMIC with its interrupt controller and wakeup
> + * interrupts) can still need the bus during the late and noirq phases of
> + * system suspend and resume, while runtime PM is disabled. Keep the controller
> + * runtime-active from the regular suspend phase on, so that such transfers
> + * work and pm_runtime_force_resume() restores the controller in the noirq
> + * resume phase, before child device interrupts are handled again.
> + */
>  static int rockchip_spi_suspend(struct device *dev)
> +{
> +       return pm_runtime_resume_and_get(dev);
> +}
> +
> +static int rockchip_spi_resume(struct device *dev)
> +{
> +       pm_runtime_put_autosuspend(dev);
> +
> +       return 0;
> +}
> +
> +static int rockchip_spi_suspend_noirq(struct device *dev)
>  {
>         int ret;
>         struct spi_controller *ctlr = dev_get_drvdata(dev);
> @@ -958,7 +978,7 @@ static int rockchip_spi_suspend(struct device *dev)
>         return 0;
>  }
>  
> -static int rockchip_spi_resume(struct device *dev)
> +static int rockchip_spi_resume_noirq(struct device *dev)
>  {
>         int ret;
>         struct spi_controller *ctlr = dev_get_drvdata(dev);
> @@ -1001,7 +1021,9 @@ static int rockchip_spi_runtime_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops rockchip_spi_pm = {
> -       NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
> +       SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend_noirq,
> +                                 rockchip_spi_resume_noirq)
>         RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
>                        rockchip_spi_runtime_resume, NULL)
>  };

