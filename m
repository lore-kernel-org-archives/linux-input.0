Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D08367F51;
	Wed, 11 Feb 2026 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846089; cv=fail; b=F1ZVQAUc6K0M2HyV+36cZ/eHmkTHfeeOxFNmKtyyu01bnzAYeWLRqRYAoGWAaqsC6XqhZ/f58RPb0XlpZOvBgzKSzudfvRM+c5NFNCY62A7err7MR9CX2bPldEKdeVaYNGoXMLH6leSL5E0H+a+pOutMxdkrLlO3HHBY0o2qCO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846089; c=relaxed/simple;
	bh=4RsM9VoCYLGtZgKEqSw3aaNTbaSBhSjbP8yUQCCAotY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jecrnr5GteIC/X4r7hW3Fe6+5BpCV0j/l+nA1KR+JnEul+k4aqD6/xRI32FApMgQ8s0ET1LxJaAmepz560MWsJ8u/M9Ftr3CtmzRfLOKixv9q5eBCNeE8H+bcLYZiiRRXw/uHffdlZNUrhwFL4cvH/5xAWVcT88hNxn+ptbc1is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oDhPyxFL; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oDhPyxFL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEXgbqLvnlhY4bbRik18BT4K8J3ZAlzh+CcZYDgjTuvd5JXoA8ZaUmuCbdu4HAlGuYYn4Phro5woCupjBMGt05Byq3g65D1BLcxraKaItQ4uVjsdiQKLKlcxSe0zk9aocDGwMTUcleHzzA5rxl+Xq8nYKTjT4eGXo2td1o8BG8AQRaxmv6yTWW31BJmy3RWE8rwn+3PXjZYbtRf42I5iJPpyUogb8ODSDrcSAyqAzy/bbRLzu94UQWBCHQIqAVn8fwVwvOshN1jeUtRd/VzG7VxvkVXAaglPZeDWWlYXsqqvjW5c9wMM3OqAKEgdfSOs/S0+x8dOGUWY4YF/wNESkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR2eJgX75SwdAqsyJ5Z/IR+XNLsdMxAKhiX39ctUEwM=;
 b=ZpYkbzsIzA9RP7lP4JFAj7sIXTHuMjg4FE7WpLGabdUxHtR6XNgPHiqnHehbkg6ViVjKoF3m4w0P9LY1/kburadMB3LyPx3bL/nnF51qJKo1A8lDIOnYU+phzntOVHqDb307iOhul3VfQim/22bqIthQsxaPqCINlsnXBpsN4ZtEVBgF2QaAzw0Tn8cPAb2GaW5hQi3MP8Lkj1/StknSwZtI0hDXItEnzUvfs5as+VizRLx3ceVKq4dQ+jMmtI5xcrE8OrgVXODmcAbQsLzlQFa7I49penj0+q+ecdwdJpWIq8NsIbGvWilFSiO7w9u+lQVsRRbTwzWm7jpnei/PaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR2eJgX75SwdAqsyJ5Z/IR+XNLsdMxAKhiX39ctUEwM=;
 b=oDhPyxFLnzzx37NBT2qaxI/ExG8DYIILi8KvcKfHG+EUnn1hRPRcjtCBBRSpUwCYkb6S1BX34Wot6LgJ5e13gUFMWSpEukl1xDftRGeJUSHM1K8K0XM2q4HMB3Y6F1sKSOiDp8Da5Zc6aGs2VZ1qEzqmiQb9EYKsionjNC7/VS/uRYzcBCAZnV+dvE3lSrRfqGV4Cb8lvNtxwWTiyjc30CsyFGImmrNIDRkNQ5InzZGYK3ClOM4OIMfCRXW86wy0ZQQZBO5iKi4yAP/npDkYt/GtjAWMTFbFvqYAGbNVC7/x8CdIqVpSbdR0G7nkjbWmiCoivrzd/7a4oFJCwnBGlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10717.eurprd04.prod.outlook.com (2603:10a6:10:584::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:41:25 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 21:41:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Feb 2026 16:41:04 -0500
Subject: [PATCH 1/3] dt-bindings: input: touchscreen: convert
 fsl-mx25-tcq.txt to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-yaml_mfd-v1-1-05cb48bc6f09@nxp.com>
References: <20260211-yaml_mfd-v1-0-05cb48bc6f09@nxp.com>
In-Reply-To: <20260211-yaml_mfd-v1-0-05cb48bc6f09@nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770846079; l=4302;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4RsM9VoCYLGtZgKEqSw3aaNTbaSBhSjbP8yUQCCAotY=;
 b=dvUk8nG5y69F0Wzhruz6dlHhzSJxUkhVPao/HeiXRSWjwg+UUAwCKMGPVNKi0zjOVD5ffmaOT
 kIldsKfqiEJCrp2aoUaDMW2RqQ5NU3o/Wo6VQp9T3xpPfBOKwpmzf7v
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10717:EE_
X-MS-Office365-Filtering-Correlation-Id: 7651c3dc-1223-4115-34c0-08de69b64e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NENtWlR0dlBRVC9oUzU5MWVMRGZxSk5FdUlnZW9DRm92SEZSNENuUjVZc2lP?=
 =?utf-8?B?N3dpR1N3c1N0VUo1a0FMeE1XOGRzVVdDRURCc05RaHJaM2xnZVpTTEFKL0tn?=
 =?utf-8?B?RUhxeEhVZy9VUmVRSW0rV25PRkwveW9zcEJEdU9McHlBQ0hjcWJyMG9FSUw1?=
 =?utf-8?B?K3g2WEhxRjgxbWQ3R08wNys2QW92MEQ1dlBnandZUzMyUXlkK0lZMDRKeWd3?=
 =?utf-8?B?M2NRcmdpR1VTTnhHaWw5TG0yREVjbHpYeEoxZGFxVUcyM0FTZGNCWmhsQkhy?=
 =?utf-8?B?Tm1zWnlSMGxXTUJtRUpaTDV4bnhFTUZTWDFmaG1XazRSWUFHMG0xYnlnVC9a?=
 =?utf-8?B?Yml4ZTVXRlBGN0hqQmZ3dHJ2eDBPQ1ZVT1laTDN4a3BtWlViQ2kwQmtxcGtj?=
 =?utf-8?B?ellNR1RZTEpob0kyMk5MdFJjODFyOVp0ZkVnaDkwSUEwYS9IMWxxOUJPY3E3?=
 =?utf-8?B?Z0F6bG96eTdWOU1yR3Z3OGFGbVpkRHlOaDdtSXM5ckdIZFl4aGsyMHV5SmZ0?=
 =?utf-8?B?aGlPSnVjVHI3SXRmY3pMVjBOVTdjMjE5cnhYMDJBT3c0by80UWc5QitST2k1?=
 =?utf-8?B?c1hxRHplVVNxV08zeGIrazd0cTdTNStPdkdXK3RKQjdkQlhHUm1FSjZtQWFK?=
 =?utf-8?B?N1l3YmdmV1Y2b0RaeC9Od3R0enV6QXJ2eXdlSEVDU2RyZ256Z3VJS1lTOG5u?=
 =?utf-8?B?UFhrcFlqVzU2cjgvTmNCSjFCT2xmaXJJZi9KbU0vaG9UNW9pVzdaM0RMbHdG?=
 =?utf-8?B?V1l3UU9MaHNFWktvSEd4QWU3MmMwRGhXMWNobFYwcVk2ZUE3M0FLK1FZOVJG?=
 =?utf-8?B?NHJtVzU0VktyRExaTElCRXRqSG9YanRqdG9oWUExYnhCaWdzLy9YeW1QbXM4?=
 =?utf-8?B?N3NuOVJhNCt4VjllWkJudGNQaFVSdXRSSEpTUW03QUJ5VmM1OFRQWVdzS2hy?=
 =?utf-8?B?bnppWFR3OSs1bWUzdEwvMUErdHRpeE9vWWdaYS90YmtsUk9iMnJzaVoxMFUr?=
 =?utf-8?B?Sjlic09yTEd2UDFDZGt5VFlTbldsVFdCQXdGa3dTQnpadDBNdGVpWDRVOXdu?=
 =?utf-8?B?WEcrdmtjOVhPUHhDbGhmQ3E0MWlqU3lxQkFVdzVlS21pNU5KazJHSUk3eVJw?=
 =?utf-8?B?TER4cWtiQ1hoMVBPRi9BVUVncjNuVnJsd3ozNUhIdk4zSHdKM3VIeFU2YXQ4?=
 =?utf-8?B?ZVBpVjREd2VRRWhvb1JYQWJGZ0R5ZHpaTmVRZVI1L3I3UVdvU2FobkRmS1FZ?=
 =?utf-8?B?VkUvN0RNUU5ocHlvaXRVTUhxUUVJMTBFdUdvRmU4QWhJWWVsbzVBSzZzQnds?=
 =?utf-8?B?RmhzYmZ4WkxjU3pBNVpCRzlGdEcxemJXb0RUUVRUcTBTaTU0a2VMWC9iQUQ1?=
 =?utf-8?B?WFN1eDVRaFJHaGxtNDBMakl2aWFWalUzTjNJZW5uU3FFb0k5MnZWT3hYRnFO?=
 =?utf-8?B?Sk95YUVnbmZlWGFTOGtOaWFaQXEyZ2daYStJZldSTjhEMDFYNlgxakFHUmUv?=
 =?utf-8?B?aXVJZGFXK0pWN3JmNkpmK2ZoUnNYR1dGd3JmLzU1NTZid0IrV1pqYU1WdU5G?=
 =?utf-8?B?cjV3UjdNZXZDUUh3bjU5T1ZORTVYb1FJREx5eEl1dFFGNVk4UHdyRWlSYWU4?=
 =?utf-8?B?WlUwZkQ2N2gwRFZmYk1kK0cxTG9HN3ZxbGZEeTlRZUhuZldmZmFEdm9BK0JV?=
 =?utf-8?B?c3RsaElpenViNkZnWVNlYnFIMjM3b2x0RHM2UlN0M1MyUlZPVDJUclFyN1BT?=
 =?utf-8?B?WENPR3pNTUlzTGhFcHFqSEdCdGVzUGNxTU1QZ1F6N2RtOWFhckFCcHNPZlhr?=
 =?utf-8?B?Z0ZGdlJJcnlpOE9GTzQ1M0JnVDFaeHhTdFd1YlJJaUVHblowQjRwWFNBaVZE?=
 =?utf-8?B?eXlTNkdZZFdzY2pXeWlpUGllcVd4LzZ2N0Z4OXp5SGNwNjduUXpJQmw2MThP?=
 =?utf-8?B?bXlUcEJrNVljdncrK09wQk5GcmN0MUI0Yk1naDdpZHJyTVpLdFN3S0V2Y1Zs?=
 =?utf-8?B?ZzNmekxWcDZoZjh2UTh3S3dyTXIzQUpNdFNmSXFubzFEVDlIQjdBMHRYa1lh?=
 =?utf-8?B?Qmd1a0p0QXhLQjBzZ01oWVJ4SHhQeHEyZ05zSXdpR3QyR1RRZ0dkZTJSK2xx?=
 =?utf-8?Q?Ikg8sx/wE4Ze9BG6QKhPYUGC1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXVoSW9sTm1YNTdIbWNaMGZWNEF4WFZVWThYckNUQkRaSGhnRzZ4S01lMVho?=
 =?utf-8?B?ZXdJZEs0SnlMODZzUUFZcW9IRUJTWHZBVTZVRXhmZzZIUjhtV0YvTWZrazd3?=
 =?utf-8?B?YUo5YlVBdkg2Uk0vUGEzWWRSTlUwN0Z3SEp3ODN0ZXRicDZrV095cmpoNk5S?=
 =?utf-8?B?QmFkVzhUMDZRVHB6NFBUZTVwSUl4NFBmSWR5U1BMNTVvZWVnV2dpRm9DbVh1?=
 =?utf-8?B?S3RXUUtQK1RNbi9UNXhjSVZJUVAwbXdDMExRZk5ubVI2bkJycTFHSG50Rm4v?=
 =?utf-8?B?UngzODV4OXppTlJIWXJ5aWRwR2F1bGdHeUkxdWh3dWdRa0RLUGMrbmdTTy9u?=
 =?utf-8?B?ZHJCdzhLY3ZvNXFyV0RxQWNrdm1PYkhITnpHMExNM2FQSnVLUXRRMnkvUktY?=
 =?utf-8?B?cUliOTZSeGQrRWxMcmFyYkZjL0JFSHFCRENVQnBlUXpPUmozVWoyU0l0OHRY?=
 =?utf-8?B?eVZWeXYvdDYvU2EvTXg2S1BsWnQ4aVpFbWVJWGEzUUZCQXVndkpnTitvMHow?=
 =?utf-8?B?d0xxOUpVS0N3THdYUFJ6N1dtQnFtU1BZd05DaFhzbEJKZzl2V2c1RjJBczFE?=
 =?utf-8?B?SGNQbzZkbGhia0VSL2NSN3NUOUlhL2tOcGxpUkF1cWJWdGE3Y2tXQVIzdHFE?=
 =?utf-8?B?aC8zSmtLZm1CYWZrL1YyY3o1c3NKaDU0a2ZkQUVrTW1td0g0cjF3ZEtaRmh6?=
 =?utf-8?B?a292dzVEYzdjRytkQWtvSDVmTFNLSlVFYW1IYmlMZkFQZ1p0anRvQXFFNWdY?=
 =?utf-8?B?Y2ZhSWM4RDFzd242SXFNbUFMeEFyOU1JUGhCSEI4RVRqT2VpYXNjcFBnLzd5?=
 =?utf-8?B?ZW1UUGJrcFBNOVZIbUlmSHFyQXN3bEE3bmluTis5bDdMVS93L0RMaVdYWjU4?=
 =?utf-8?B?bHI1TmJ0NXRGY3JNNVdVeFpjdjV6aEZMdEx1L2hlU0xVL3psaW9QV1R3Z1gx?=
 =?utf-8?B?M292WFNaTFlLVEh6aWdSd3lHUGlSWEErdmphNW9Eb2YzUFhvOE9tU0M4bXMz?=
 =?utf-8?B?b055ZFdEaEhKRG80R3N1eGJDRWt6a1lDR0s3UldGOUNUQURTS1VTblA1eldx?=
 =?utf-8?B?TlYxODIyZTEzc2tWdUwyQVU4ZHk5UlpHazZST3labGZENjBNU29TWXBoMWVJ?=
 =?utf-8?B?L3lrY0g4WHo1MzhlTWJzWWNvbWJmWE5EK1pKc0htemZ5Z29YZjkzWThteFov?=
 =?utf-8?B?VlNzVUZWUysxYkhsdDFuS1ozVDVIc0ZOYTJuM3VvV3RDd3Q0b2UrVHRRRnJY?=
 =?utf-8?B?Vm83YzQ1OE5QZVdoWktDd012MlJOeitsZStiRjRYMUJOUVpCSDVPTVNLaFVV?=
 =?utf-8?B?aDNDU0VWNzBZd0VGL0tRRktVdUxsd2hrZ2RXNVBXMlJjc0RVTDEvbjhrRWgz?=
 =?utf-8?B?SkJKOVNJc2lJM0R3N29JMFRNOXNPTTI3M2lGMUdJSmxWYnkxNFdBZG90cWJs?=
 =?utf-8?B?ZUE5eDZUZkJPLytmWXVrdGhoZmhqRW44QktmRnlhakF0RE5UdVRLTnJTMmQ4?=
 =?utf-8?B?UjBrdHFtQnVDYWhnaFcyUjl4Nzdia0s1TXdBR3NqdUZnRENnRlRYSTJLVFIx?=
 =?utf-8?B?aFBzN2JLV1JpTWV3RjBPaXRZdWJJdzJSa25PZk5hY2tnVytKRUlyc21yaDFh?=
 =?utf-8?B?VFMvZmFtbFVHSGpKTzk4RFMrV0xPakxSQXF5encxVk80a1B1RHBWU01DNHZn?=
 =?utf-8?B?aUVBMGg2ZTZTNitJRVRjelJkTXZSNzI0eC9uK054TWNWUDNEVXU0eldRdi9q?=
 =?utf-8?B?T2s2b0pvRVRWQWVVbHhLN1grUzBnem9zNktzRlN4dU80c1doWUZ1b09hRmlL?=
 =?utf-8?B?T01uaVJ3K21qckVnRDVxdlE0SVBVM3lWclV3MVhURVcxeGZOS3dNd0hqU1Z3?=
 =?utf-8?B?aTRWUG1zc0tVdTNWR2JyNWN3NFpoZjk0bm1zS3oxb2tpMGszWFJ6MG40Yjlr?=
 =?utf-8?B?RWt3RVY4ZlJGMExMbndZeEpjMWxsU1JGbldRS3cyMlIzWHNKcjF2emJrNHQx?=
 =?utf-8?B?ckdqdGNPUHNHQUh3eERadS9hcVdFTnZhQkFBendUSzRKM3ZpRk9ZcnNtSEF2?=
 =?utf-8?B?ZzNLK2pqbWc1T1BxSEw2K0lJVkZ1QzB4RmcrbVJwbU1HNUFSbWlRdU5TaCt0?=
 =?utf-8?B?QkhpOXlvOVpjSlZwNUJtVlJBOG13TGUrM01NYnBwRmhUTWJ2SXY3bjFsYkE2?=
 =?utf-8?B?Q2R1K29KVno5MTZvM1BLNkppd25qbk0xaXRGcEF0WE04SWVuTEkycDFJVnpi?=
 =?utf-8?B?WS9wc3Vub1o3akZWUHdseUttcGZZYXdUUWo4WFhRaU54NnhGRHFmWkt1a0Mz?=
 =?utf-8?B?M01VM3Q2aEJCRUZ4VnV1MXpTdDlnOXoyeWxYU0hmZkFMYk9nNW1MUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7651c3dc-1223-4115-34c0-08de69b64e6f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:41:25.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ7N47V3PEAkQSytDrGP0ugNM5PWxRh6F+8JA15qjcTi+BNkG2yzSpzeMbwsETvvAD3Qbxxjfla7/QDblGiT9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10717

Convert fsl-mx25-tcq.txt to yaml.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/input/touchscreen/fsl,imx25-tcq.yaml  | 69 ++++++++++++++++++++++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 34 -----------
 2 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx25-tcq.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx25-tcq.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..94452ac423d04c24817440ce4a1671edeeb1ac28
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx25-tcq.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/fsl,imx25-tcq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale mx25 TS conversion queue module
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  mx25 touchscreen conversion queue module which controls the ADC unit of the
+  mx25 for attached touchscreens.
+
+properties:
+  compatible:
+    const: fsl,imx25-tcq
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  fsl,wires:
+    description: touch wires number.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [4, 5]
+
+  fsl,pen-debounce-ns:
+    description:
+      Pen debounce time in nanoseconds.
+
+  fsl,pen-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Pen-down threshold for the touchscreen. This is a value
+      between 1 and 4096. It is the ratio between the internal reference voltage
+      and the measured voltage after the plate was precharged. Resistance between
+      plates and therefore the voltage decreases with pressure so that a smaller
+      value is equivalent to a higher pressure.
+
+  fsl,settling-time-ns:
+    description:
+      Settling time in nanoseconds. The settling time is before
+      the actual touch detection to wait for an even charge distribution in the
+      plate.
+
+allOf:
+  - $ref: touchscreen.yaml
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - fsl,wires
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    touchscreen@50030400 {
+        compatible = "fsl,imx25-tcq";
+        reg = <0x50030400 0x60>;
+        interrupt-parent = <&tscadc>;
+        interrupts = <0>;
+        fsl,wires = <4>;
+    };
diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
deleted file mode 100644
index 99d6f9d2533579672eb4e277bcb40d274696831b..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Freescale mx25 TS conversion queue module
-
-mx25 touchscreen conversion queue module which controls the ADC unit of the
-mx25 for attached touchscreens.
-
-Required properties:
- - compatible: Should be "fsl,imx25-tcq".
- - reg: Memory range of the device.
- - interrupts: Should be the interrupt number associated with this module within
-   the tscadc unit (<0>).
- - fsl,wires: Should be '<4>' or '<5>'
-
-Optional properties:
- - fsl,pen-debounce-ns: Pen debounce time in nanoseconds.
- - fsl,pen-threshold: Pen-down threshold for the touchscreen. This is a value
-   between 1 and 4096. It is the ratio between the internal reference voltage
-   and the measured voltage after the plate was precharged. Resistance between
-   plates and therefore the voltage decreases with pressure so that a smaller
-   value is equivalent to a higher pressure.
- - fsl,settling-time-ns: Settling time in nanoseconds. The settling time is before
-   the actual touch detection to wait for an even charge distribution in the
-   plate.
-
-This device includes two conversion queues which can be added as subnodes.
-The first queue is for the touchscreen, the second for general purpose ADC.
-
-Example:
-	tsc: tcq@50030400 {
-		compatible = "fsl,imx25-tcq";
-		reg = <0x50030400 0x60>;
-		interrupt-parent = <&tscadc>;
-		interrupts = <0>;
-		fsl,wires = <4>;
-	};

-- 
2.43.0

