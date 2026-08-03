Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010077.outbound.protection.outlook.com [52.103.66.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2A356779;
	Mon,  3 Aug 2026 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750017; cv=fail; b=fsCUcLsaNxtbmuxNKZ659CnCpUL9HPzsN5jsaco2FU4qvH0Oh+zyWlOFG/zRrK1aQsMqtTNZYvUpxRQteREKDL9yJ/RfnkR1QjjfY8YdHBTxgR1dZErJgy3m56vDnkfFIxlFlLlkptNub7s5h2ELj0+D8AQ7aTiyZ4IK7lglAQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750017; c=relaxed/simple;
	bh=7/9Xeaxd/vilmzasElltjinp9XiT61eUs8x+v0SfUak=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SU6jrN6zkUS8Sjk9mbinA7hFlYF+OcuWVNZjcXgyF3/ACyPZr7kTtwyT4QIu3jr9HNyttsdS97736BpR31aHxFF7rvtt+DgT8Lnoz/woE6KtR3GwpN2kXvehsmoq9BX6dPywwb+8OneUb8rAFVUt0N8H1u1wEzlwbfQFFXq+tyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NPA7wufd; arc=fail smtp.client-ip=52.103.66.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NPA7wufd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTresNUksuXK+1zfH+bAtDe+21cACmOS7OokpdidVEOHkRXIN9w+mNAhfALCWKP6T4E8Ysx3+ljTpZd/od+BXLEBy7a+FHOOyeL3+zWXC03WD3pYeMs+DA3XDy1TENvZydfWjm+cAJEhGPpraRyTy+WrCRkiZFzT60LI4tTQE/+fnOVn1hQuimetgvA2279y7w2dQhSwwDAryJX+VUqrUwjC6ff6MyHAyK9OFMEY/j/jC5phepaTBAQ/ca9WTT2E2u1r95khdVL4qdsZiiuvZ0f1YArzrTZ19uvbbpJmy6epvc7zlnm9XNP4vNFdoZ0zF1T+orhePNCB0+ujf8ej3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/9Xeaxd/vilmzasElltjinp9XiT61eUs8x+v0SfUak=;
 b=O6yV0/vYYiY3jox04Jx1MtDcjYH8Q9JYPhKzFV46qp1oeJCFzoVo5Gugto7QAKyS3kJKJT+xEljCtv7/kaUmLGrUnF3hJu6lZmgJ2JCgQFYrdVcYsaNqpBYt0HHFvXuEzKYg9nNZOKyH3kG9jBqGZNptNp4rfIwyBwAeHGo1lMyvMbtyd6Rqg/nrEV3UGMdx4htuhzvcrplkxZNIxWNpdR2CIrO9FJsGUy1Es6GrK7xDp5DHEo2K7jo7wakCmUUF94aWW0yi1Azt8ESomg2WziWTwI1LQ1zKPuDwqiG1enjdGJZVXkT/dcQde7g792/Rk5moEWk4oURxltBIPnk6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/9Xeaxd/vilmzasElltjinp9XiT61eUs8x+v0SfUak=;
 b=NPA7wufd0IUjERlhmRzACqmecSdaqOtd9yvqiqxpuPz7K1pi4HFc5fAG9ti9Tqd/0ui4jDvivI4GdrDiNFRitAVKvmTGp2N1sZwYTWWsMYxsXuG2qVOlv5iiz+Sk25fiUuoyo5YVtjR5yDLmBz7Hn7zFtkFDdp5C67zASNkrBh9Y4qCVUkIEsxn4BJveSbVq/ZCa67/A77SjT5/5Y5ZVwE71Lk4f9vx+HiKGpl6Sw7tCh4w1ma/a6ASCejnfP30vAzsJxTnahztpYlwrTDUf+AgJpQoJwzPvxRkeizh8Y2LpOkjBxXLth5oB5Ud9VuVepK2O93MGL+XNIwQmHk8fAQ==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by OS3PR01MB9673.jpnprd01.prod.outlook.com
 (2603:1096:604:1f1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 09:40:12 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2%6]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 09:40:12 +0000
Message-ID:
 <TY4PR01MB14432E24FD0D38D1FB84F99AC98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Mon, 3 Aug 2026 17:39:44 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Sanjay Govind <sanjay.govind9@gmail.com>,
 Kees Cook <kees@kernel.org>, Zoltan Illes <zoliviragh@gmail.com>,
 Qbeliw Tanaka <q.tanaka@gmx.com>, Elliot Tester <elliotctester@gmail.com>,
 Dmitriy Zharov <contact@zharov.dev>
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
To: Aaron Ma <mapengyu@gmail.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20260801075623.2769601-1-mapengyu@gmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
In-Reply-To: <20260801075623.2769601-1-mapengyu@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2vOLqatgnclKlQ6H0iIDGnPv"
X-ClientProxiedBy: SL2P216CA0129.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::8)
 To TY4PR01MB14432.jpnprd01.prod.outlook.com (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID:
 <2b2b11fa-7549-482e-b3a1-4533fb69f470@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|OS3PR01MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 79dfb130-6d65-479c-3b33-08def14336d8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|8060799015|19110799012|12121999013|5072599009|23021999003|15080799012|25010399006|4140399003|16041099003|53005399003|2607281247196008|40105399003|440099028|3412199025|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3UxWGFrT0lkQ3dyd0lnejRLMjMwQkJtR3NwaWorZkZpc0RoVmxTd2FXcGxP?=
 =?utf-8?B?NVdnNzdxa3phK0NsekdGSnJCVjNudFZiM2VjdnY2MzAvMVVjamdob3RlbVk2?=
 =?utf-8?B?bHoxem1qN2tWSXdJYzc2RjByazg5VW5WbDF1bnhSL2dObm5ITWtjYmd4ZHVy?=
 =?utf-8?B?MExmYlFKR1BFVHlzV2JJaVdJeXMvK0J1VCtiYkU2NHZBbUl2dWlTOEtmQWhl?=
 =?utf-8?B?V3F2K0c1Ri9pS2ZrbVpBQXEraUM0cklibENxL3JJN1ZrUmp2S0JpcUZPN0dD?=
 =?utf-8?B?YnIvV0pGcFdwbWc2S3RqeU5MK0dtQzRNOHFncEpkMFpKYml0YklTNXU2Unh3?=
 =?utf-8?B?SDQ1a1ZuR2YxR2JPM1o3OHlFQzAzNWR3NXZtRm0zczFFenlhRFpYYWhCVGNl?=
 =?utf-8?B?U0FpVXZRZWpoMzdrek1weVBiLzluK2NHMG5UK2lpS1BlMWREUXIyT3o0Y2Z5?=
 =?utf-8?B?UHFPMjIzNXhUVG8xOHVjRGZFenZqenNrUDc1OFNyMnJZbTFCaFBnWlVmVGVU?=
 =?utf-8?B?YkM3a0xvU283cUNUOVA0WE80Zk5iUXVDRWFkMHYvRVB3c3g1cjdsV0hTMTdx?=
 =?utf-8?B?YjhaSW1LUmM2OXJMaFpSd3NpQkFIc0V0OEVNc3JJWTBtZ3BTaDNMWXYyN0tq?=
 =?utf-8?B?SzhlS1dHTktaTDJmMkxwZktMRTVnNmtOWVRmRlI0VFZVcXB5UlA3MEZxUXM3?=
 =?utf-8?B?YllEM2h3OEZnclpma3JaVlVUZ1ZTSDI3WWhHTlhXdEpSWFdlVklpajIrcWJB?=
 =?utf-8?B?YmUrT1FZdnNsRHFyVGowTHJhaC9LRGVqM3IxRnZlS3YxTTM3NjVHekY4TkFZ?=
 =?utf-8?B?NnpoL0UvM2VuMWE3bU5qTjFsdWZTaUluMmFWeE9zQzJTeUFpejBEa3ZsQmg4?=
 =?utf-8?B?UFVPRmxXUEd5dnVJVFhJN2dRalk0YjVzaitja1B5U0tlR1hVenZQelFScTg4?=
 =?utf-8?B?amlqSE1hOXJpNk5GUzFaM1Uvem5nNjZmcVJEUzY2OXVtNTQzN05hTVl1MlJK?=
 =?utf-8?B?Q3VsZ21wQ29mRzdrNkdFR3M5WHQ5ODJBRTVLTlBETU1iTkZVbTBiRmtCb0d5?=
 =?utf-8?B?TnVLV2l4L2h3OUVHb2ZQL2FJelRtSS9GZFVXWUhRUW5GbGtFZmRmemMzYUFT?=
 =?utf-8?B?MkV1aVZUWWJUc2NyeVRrVVdwZUpaYlhuZDdXQ1R6Njd2N1hRTU96SUg1Nllt?=
 =?utf-8?B?SFczbTNCc2RJVEdWRDR5Y0tYb0VDU0ZyWmsyek9TRHBkUE9iVFNFOEMxWThl?=
 =?utf-8?B?eXBETzJ3ZFRFT3R2Uk9tQllpSVpxd3RPV3EvNkFRVEJWYjcwYjFoWUZvVVAw?=
 =?utf-8?B?NUhoMk5lRnBETkZaL283OGtPNGlRNG9rLzF4OU1UVDNoaGJVTTgyZ0VTVCtm?=
 =?utf-8?B?bGlkYWE2ZUxYTEE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlRONGpRUnMrT1VlK2RxeEJGQlZ1L2VzcDFZNXNabFFub2JsZmRFRUFyQmt0?=
 =?utf-8?B?dXVudWJUMFNTSU5BdzBwYXhIZVdNQTVtYUdOUXB2c0s1aHdHaEhXZ0VKbENm?=
 =?utf-8?B?VWtoc2liSjIzb2Z0Y0hQQkxVcUF2Rm5VdXU5djQwOEw2TDdUTVl3b2cxTC96?=
 =?utf-8?B?bjZvc2l1SUxkN2paWDEvdldWVjh4clh0bXBhb1pNbGxTUFlLcEM0ajMzV2hp?=
 =?utf-8?B?SlNDZklwTXpiMDVOQ29WTW5zOG91WjhyV0Y1WnBSekY0L3BISHZhZmlGYnRi?=
 =?utf-8?B?VEhqOEltVmU4VEhzdGJmbEhmWVZhNUE3U2FQSDdDellhWDBIM2VvUE53UGdW?=
 =?utf-8?B?dXJreVl2MzRNMFFXbXdkN2swMkFXWFF1aHJBQm1FOUZ1MU5GWm5sZ3M5YzBw?=
 =?utf-8?B?M2N6dE9XdVBGV20xaGpvcFMyUjRyTVluV215cTdYVDMrSjhrOVhmV2t4VGhn?=
 =?utf-8?B?WE1UN2lRRjVzcWJaNHFLM2NocVZZYmJqWHpYMGtoSkF4clpPNkhyN3VpLy9Z?=
 =?utf-8?B?QkdGZ0ZGVFZUZVkyV3JDdjdCRWU1YXBMMksxUHN0SGJHR01hakFranZzYXNi?=
 =?utf-8?B?aXQ3RzRteTJibko1bmhBYWs1MCs5dTViaFdkNE9KMlpKSmljVnBHOWRWRnZO?=
 =?utf-8?B?SFJldDBnbUdPZ045cGQ4S3Y2cW5ocDQ2VzRsczFWZ0Rvb2p0aFdCWFF6bVVV?=
 =?utf-8?B?MUFCSTM0NElTbUh0QWRka2VwVlZMWjhlQmwrbEdwN21Gb0JLRHdHbGY0NmVo?=
 =?utf-8?B?dWtnR2Z0WVI0NDJNR1FPTXhWUE1JSC83UXNML2U3N1dSMkNyQzRxUjd2Sk11?=
 =?utf-8?B?Ri8wMXpzU2tUak1hK0oxdmNvMm5ab3BISzlibzFUNWRYcWxKREplSURYZTNC?=
 =?utf-8?B?WStJbnVjWEhPNFk5ZDc4ZVY3SUJBVTBUQ3BPZEVtdy9BWFlMME1lQXBVdnpC?=
 =?utf-8?B?b1hqVm1lejVCTU5zMlZZTGZDV2RBVnV6cWFVcjZKcGNrQmhZeGlWbkJrcXVE?=
 =?utf-8?B?enlSYmk1L1VBYVU4aitxVlVzQ2FRSG5qaXJVSjhGZjRQdGVGdUVQN3pnWk4v?=
 =?utf-8?B?YWdxSHNBOEljUTY3REpCTjBzQitKVnk2QlJ5SDA3Unpzcno2MWthVmVrdFZE?=
 =?utf-8?B?amVKZUZiQ3c1Zk12cUhRRnkwM1grSXVWS1JrVXZiZTJLMXFMcmwyRGFwRDFF?=
 =?utf-8?B?SjMxUjZVRjllMEFBTWk3Uk93R01taDVrcXB5cGYwNkxVQ045SHRWSmdNL2ZL?=
 =?utf-8?B?VE50amxLbS9rbktxRDVxRmUxKzAzLzluRStNb1prcnI5bnhjYXdrQ09OSmR2?=
 =?utf-8?B?d2N5dzRtSzZrZmNkenVDalhHU0lkOUl3bkdsRDBEQ3JqMG5HL1E5dTQ5akpm?=
 =?utf-8?B?cXRFbXN0YVNUT1MxZVZjRWFLSmVpSzZxTFF5RlV1RUlJTWF4TmpIekpYYXJ6?=
 =?utf-8?B?czlGZFovUzRWMDQ4ZGhOOTFRcnB1NnJjNGlRZTFGU2xuNkR0Z2xHNFliWEN3?=
 =?utf-8?B?Y1NQYlE5RzBQekFXdXp1T0o2bU95QlVqS2FXWU14ZWN4NFV4dk5KcTViMnJq?=
 =?utf-8?B?dStWb3J6YWdYNmMrREZ0dFNmMkJhTUFCTUtGdERFS09RQW9aTVViNnZ1MVRp?=
 =?utf-8?B?OGpIbUtTV0R4T2s5QUE0MGNHTXFNYlVOaHNJR1BvTjNhYndEOXMyWmNtMUlY?=
 =?utf-8?B?SFlJeWFWU0Y2QWZPNE8rTkRTa2ZFKzU2Z3N1U2JLSUVDTTAwai9yTlJxOWxE?=
 =?utf-8?B?WlY4MXZDcE5MaWh4UUF4M1cxaERmTlo1Y2lYL1BFQ0R0dVpzZXovWXB6aisr?=
 =?utf-8?B?MkZ3LzJRa2Y2NHF4cU5YSHQyZmFSaWFLVDlPaU9OZ1ZETDhua0Q5OTE2dy9C?=
 =?utf-8?B?V1VVTXV1bHlOK1o0SDNuTitQMUpmbS8wZHA3enczazJsK3lzZzhUd1dTR3JC?=
 =?utf-8?Q?YvL3OUWoOxte5NCgamUNMkzYoZkTMslq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dfb130-6d65-479c-3b33-08def14336d8
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:40:12.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9673

--------------2vOLqatgnclKlQ6H0iIDGnPv
Content-Type: multipart/mixed; boundary="------------5TZ9ebXIFKaDSPtgCrmkwPjF";
 protected-headers="v1"; hp="clear"
Message-ID: <2b2b11fa-7549-482e-b3a1-4533fb69f470@outlook.com>
Date: Mon, 3 Aug 2026 17:39:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Sanjay Govind <sanjay.govind9@gmail.com>,
 Kees Cook <kees@kernel.org>, Zoltan Illes <zoliviragh@gmail.com>,
 Qbeliw Tanaka <q.tanaka@gmx.com>, Elliot Tester <elliotctester@gmail.com>,
 Dmitriy Zharov <contact@zharov.dev>
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
To: Aaron Ma <mapengyu@gmail.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20260801075623.2769601-1-mapengyu@gmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
In-Reply-To: <20260801075623.2769601-1-mapengyu@gmail.com>

--------------5TZ9ebXIFKaDSPtgCrmkwPjF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDI2LzgvMSAxNTo1NiwgQWFyb24gTWEg5YaZ6YGTOg0KDQo+IEBAIC0zMzQs
NiArMzM1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4cGFkX2RldmljZSB7DQo+ICAgCXsg
MHgxZWU5LCAweDE1OTAsICJaT1RBQyBHYW1pbmcgWm9uZSIsIDAsIFhUWVBFX1hCT1gzNjAg
fSwNCj4gICAJeyAweDIwYmMsIDB4NTEzNCwgIkJFVE9QIEJUUC1LUDUwQiBYaW5wdXQgRG9u
Z2xlIiwgMCwgWFRZUEVfWEJPWDM2MCB9LA0KPiAgIAl7IDB4MjBiYywgMHg1MTRhLCAiQkVU
T1AgQlRQLUtQNTBDIFhpbnB1dCBEb25nbGUiLCAwLCBYVFlQRV9YQk9YMzYwIH0sDQo+ICsJ
eyAweDIwYmMsIDB4NTE1OSwgIkJlaXRvbmcgQlRQLUtQMjBEIENvbnRyb2xsZXIiLCAwLCBY
VFlQRV9YQk9YMzYwLCBGTEFHX01TX09TX0RFU0MgfSwNCg0KSSB0aGluayB1c2luZyBkb25n
bGUgaW5zdGVhZCBvZiBjb250cm9sbGVyIGlzIG1vcmUgY2xlYXI/IFNpbmNlDQpjb250cm9s
bGVyIGl0c2VsZiB1c2UgYSBkaWZmZXJlbnQgVklELg0KDQo+ICAgCXsgMHgyMGQ2LCAweDIw
MDEsICJCREEgWGJveCBTZXJpZXMgWCBXaXJlZCBDb250cm9sbGVyIiwgMCwgWFRZUEVfWEJP
WE9ORSB9LA0KPiAgIAl7IDB4MjBkNiwgMHgyMDA5LCAiUG93ZXJBIEVuaGFuY2VkIFdpcmVk
IENvbnRyb2xsZXIgZm9yIFhib3ggU2VyaWVzIFh8UyIsIDAsIFhUWVBFX1hCT1hPTkUgfSwN
Cj4gICAJeyAweDIwZDYsIDB4MjA2NCwgIlBvd2VyQSBXaXJlZCBDb250cm9sbGVyIGZvciBY
Ym94IiwgTUFQX1NIQVJFX0JVVFRPTiwgWFRZUEVfWEJPWE9ORSB9LA0K

--------------5TZ9ebXIFKaDSPtgCrmkwPjF--

--------------2vOLqatgnclKlQ6H0iIDGnPv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmpwYeAACgkQX75KBAfJ
sRkHQRAApjE5Aypn6KX7kVzdK6lsD0fmnfB40FHvKZuELw46mCynZjm26TqyMdNW
fUcFukYu+Dw5+8gT9EZ2BIhaRsjgh2ATC5sX/XcHkLSjLOEwl7viIYQ3ffZCwjUX
lDJ5G3oNplHoLFkeM63QKte7yJNlC+CueTF3Vo7t7nALUN1VA+YVn61Nf6g/kU5W
fhGqBv8VgAkEyrQYijweBpt5azEe9gMTTqmIv7QDKrNoQhn6MS10URbvZj0FLOIp
HCAMyYMHMTygE+0cONhn4+TGLP8SIGq/pYGdLz27o3KlKCE/wCoY2vFG35psA1Z4
ESww4xBNYt1ve130hImacMUG7cauvVoKmKPaGMivcmITSLjXLqKrKAgpeQsQNVe2
5Q0CNiIs9pwztGimH2hYCAvXbEoNG0XTnUujA8VnUNIp7x3T0mEmwfT5yDvcnHi0
dbfgLmh0vOe0Cy2mvhj3ejBoXK9BiWwdVBJ1EuLHltNLiQijmaRvKM54PSiX+Em1
JzpjdBb+e6+4Az59/r1oJioPIdpdzl1bUUWMidi/De5Q0gPfxTQFhRgRalfmXc8C
+geNGlJza+1OkKmy/e/A57thoudOaTJbpHxi61Dcpm8KRg40Xa8MDnBRY5OT+fpv
MDJfKi9ewWWVGjX0c3VInLtUmilw+0maLhISWTp4/AuDo81lxv0=
=rbpi
-----END PGP SIGNATURE-----

--------------2vOLqatgnclKlQ6H0iIDGnPv--
