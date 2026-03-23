Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DA38237B;
	Mon, 23 Mar 2026 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306337; cv=fail; b=FMZJPUKyFv58jbxWfqC/djetG2PK+CIu4RUaNpA/rvNloiGp+6PEfMQ3QjOSj2JBv/PQSb3KporMb4CHJ96GRf1m4UzIRbpgJpfeTXp3EosaJeyqLwuTVE1yd0+8Gw2jekN5oREgGejsIgMGPajXJ7bTA+loOuW3xrbB/7+6MmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306337; c=relaxed/simple;
	bh=UfmtgFG4/EsCoOTL4qxpru1cu/SBsrTMgxLlA0dizjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=WCPZlWfVjme1Mb4WwWjM/xynmQoPm61b4cQWAY/ggC3Hpvl+JInstaBOBEcpGIdiYGeB51X45SyUU4PI34hn+SF3EPGNbYhA1B5rRI6JjLqjHXWtOpUCiPSPR2888KYScaBXqGa99HgQZEVPPXFSzPgaxD8TuM5e83KTwAZTrbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WRLtwLdp; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WRLtwLdp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBjHRe4Qk3nifKBHNfyG8ohHTHjkgbg//V+GO3t4WJarqPBtksWNLN7hA8gth2LJ21S8q33QR1sinU7T3iE74DRKtPBOU+TIY2DR6ppuM4HsOBlWA3UcMYPIi0lpP19vMIyGthBIBe/xZKkKr9CQh9zpMOdhZRuT2H44rHpv0IM5nvZhOXKHiRwg8CR/SJIY0Uag7CYCMKwdbKfn3HyLMu+6kowtLrBcfoR9XZDKv0etkHk1i9ygbfXLibJ/p8tyW28RMimhNypbN9ZjBhm4nVA6fkN0wILJCeG6iVjdq/toa5pzrxZTLB1l0nG+lRZA95RYMOmiG2Y59BhsjGbYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peFdcalmuFGBjCh1O+XRQ5N1R1dD5cO/X60DfglqRCM=;
 b=yu6wWxiCrG9xKnuQkuE1DVZ4FZE8ddt9usuv71S7y8PRTd1mKrggKRpW94xlY3KnOSTuG/jj9eAEcZMWmxoPM7t+PaNhI0AP2nWgEOrdUrP4RwKL4sTXo+u36bwZQFH+gWkp+0nTL6gYDnXeT4hEgDS8Fgwi9Ex1QbrMMahC3Uw8hrcDX4Q6fN3JROD3hKpssgQGpIWS7zIibXeNpQG1XvfYNn7Quo0h6EsvRA9GeXWnh1BNjZOY3pj1QpLQ64eBoROf0kH3sWM/qrrvm9n2asO73tHWJ0HjwlEWe/R+0fXkBqCNtdkl35FBljniVlBpkl1sxBLktHsCPlcdIfhh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peFdcalmuFGBjCh1O+XRQ5N1R1dD5cO/X60DfglqRCM=;
 b=WRLtwLdpzfg7epwE+5lPA4vz7YV519bCxC3n2SVxpRLuWUO1EgFqU6Zd+D9cClsRax7YGrfDWqr4xFJh8Sum1kG/Tgjc+VLbHfIB3KHAY6VXvjJTeRONfaiPnvetPYV3+1YNhXeKKXPKXwJOLAfozzMBtnHnN5s5mp6tsu/2u3NFfYtxunUN3wE5bNYUEdMQgfJW2uzLbPAPVz0AtIsRPlnAgQoUrm5Lxp6lAHWgBlN5/pFmPQ3AkYlxLlEbSvc/gc5sgc9pC5V0RN2TzenUvtiuvOVOtYDVcVIW9VHOYJn+leyTohA5SYQlECAPOe/Tq3u3Mmt5GStoWUjCXsPUOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7886.eurprd04.prod.outlook.com (2603:10a6:102:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 22:51:43 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 22:52:06 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260211-yaml_mfd-v1-0-05cb48bc6f09@nxp.com>
References: <20260211-yaml_mfd-v1-0-05cb48bc6f09@nxp.com>
Subject: Re: (subset) [PATCH 0/3] ARM: dts: imx: clean imx25 tsadc related
 CHECK_DTBS warnings
Message-Id: <177430633046.1457893.7445268334136397143.b4-ty@nxp.com>
Date: Mon, 23 Mar 2026 18:52:10 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-ClientProxiedBy: PH8P221CA0044.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5b9f78-0e4f-4eeb-957a-08de892eced6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|376014|7416014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WFfy31DfzqYZ0EhW7PwYiIWFt/qJ6IB0DJXt3GJigrMHouem5khdzUYjeN3FiKMt02mtAAfwo2FHK+axadfw2F515PCOas5Jo0ULWT2iPMK3QT1D65597k1ojVRbD/WSy9PGb++3/Lg1N3PFS7OdzMH98xcjUJ2C3Q8Z6O3ezOJ9h30zXGbM5Kp175KTAdL2o6V0Xb0Hc+4jvYM7ze2aJbqperXtzzlG/6GLUhfw6JrNx2FBqImenPJZKhjUwhCUjhlTZmCVKgWP3ouVb9cV6ri2iutFuCz0tfaqckNV51m1lCmMWwlTRYJb5A4CbDsMS8lT+dyzjRWmQg1iukPFrHBMjpBacrmKKw1r0MRK1itLQD7SDZ1X0Lyd11WYxuZ6wMZtRBA5D5gwWTFKeurdcMbgqi84BWZ9eMf4ZSzVfN3gYfJO5Y3EgAyIKVaJrJbolFLi8yp3taCGBn1UHtnuRoBNUJLJY08zT2yiFuJsxZuSHUfoJJdpfayNE+DeM5MXgv9UiWcOv2ztvuT4V6rnh0Nb/ZlmOjB1i5sWZ3QCxFkf1YdqQPsVyN3UkNX/fl2FWYDNDm8ScaKjWtOm6RlUwponqafKeqeRYrild1NBkh3LUABGgSLtNBfhV2bF+QsLsjKsVSOUDUeW00UJCj3JwXFPxyB7KVdft9jn1+V/lMOWxhyTumHR5j8bjDpr7si01WFYtQp8uWA1e5G15whbhOrpmSbeqRwkVkO/odsAFJ+aAgfftdHcyD762LytiS4RESmvGW4budzwI9YiBcEdxKDdwZ+a7WOE5WFGLONzFtk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(376014)(7416014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUw3T3B0RVFXaGJJRWZKZkZJMWN4RVRlUmY3VHIwUjhDakgvRFZEZ0l2Y0lj?=
 =?utf-8?B?aXN2UnRKUnBKWjhza3UrVWtIOTdSZHJnWHhJT3JuVmN3UUMzZFU0Q2FlV2ho?=
 =?utf-8?B?TXAxQUlnZ2djT2UxNkU0UFU4RElDdmxOYWV2YUJzVmh6eG1zOTlmM09XMmpR?=
 =?utf-8?B?YWY5Sk9kTHRiSTF6djhJYnhicGRtK2xaVWg0WEZjRmlxY3lWYUlXbS90MDMr?=
 =?utf-8?B?ZlRSYk55L0xIb3dxSnFYS3hmMjhpSE5oTVN4aDlJcS8wMlZnVndsYzhtMWJT?=
 =?utf-8?B?K2phdkdUVFJhTGdOblNjKzgzbytjdmRNWnk3TGVpNHkrb3gxR2trc0wyMzZL?=
 =?utf-8?B?Q2dFMEJTU0svUWpvbS80MGlhNldOQy8yZG1ndnZtMDJlNzVHNVpzaElUbFYx?=
 =?utf-8?B?UzRaQS9FQXBILzNnMXdyalZyZSs5NnVvTFNvWERmVlFaU0JoRkhjdHNaTmRH?=
 =?utf-8?B?TlRGVTM4R3FiZDlLZXR0Q2JBa2FCQXVRWGJUbkNUVHJ2eElmNFQ5K0NQTUxo?=
 =?utf-8?B?ZDBPNWZlQlBJTWhOY2NITnBoY3VRYWlURXYySVEvVUQ1Vm1GdG81MlV2V09n?=
 =?utf-8?B?MGd1NVBnT3RYMnNhVWl5MGJNd3hLRjR6emlJaDdUaTlwZXdxUjRKb01Da2wr?=
 =?utf-8?B?N01SZmtLUWE4V3h1MVhCaG0ra1ZiWmVrQ3J0b3Q3bnRmZnFPSEROMGRKMHVi?=
 =?utf-8?B?MmpyU2tVTmxEQ01iYmp2T3FhMm9rSExxQWladU94SllNeTZVcHdJUDMwZlRH?=
 =?utf-8?B?M2hldXFkVmtkYWRUckJKQjNqOWMvbFo1MGVIOG9ZeXJ0Smw4Q0dzc3NpTzlT?=
 =?utf-8?B?S1ZjbXRhZSsvSVBQOTBOMWVpRnNVeFZXNHdwMVphRW9sT0QxRjY1Mm5ncjRm?=
 =?utf-8?B?NXZKUGFlZHdtem1WWWUxQm1pSkJyYkFmV2JuQmYvSTRCVm96UnJlTmY5cE9L?=
 =?utf-8?B?WGRzRWFpdVBrcDZnTzU3ZmI5Nm85MUUrUmtDZ3pKc0VqeHcxVlNVbmhsMndZ?=
 =?utf-8?B?SGNweENORHJSQjU1eElGZXM2UkE1ZU9KTHNNamltNG9nNCtRT0tTWWVDUDll?=
 =?utf-8?B?TEZzdllMeC90ZWQyVi96Mm5WRnZVUjFGMTB5MTNIOVA2Y2JJajJWellDRHIr?=
 =?utf-8?B?cGxHbUJDWHltUDFtdkQ5cmJ3VktiNUV6S2FlbUVrNE1kRTJLcVlLR2k5UWVS?=
 =?utf-8?B?djF4WnoxdUdMWVYzN1MvT1FWR1VqYXFnMWg2MUJ4dEpoN2VQMWZMQVhGN0Qw?=
 =?utf-8?B?bjYxSmUxRm1WZDlZUExkaFlOYnVZQkNiSFZ4eUhRaTJWYmY0K2dmVXdSVGJv?=
 =?utf-8?B?T25LOXBsT0JDQUN3ZlI0Zjh5SXhUcDdxZlpUWmh6SE9lREd1bm9PbzB1VFZl?=
 =?utf-8?B?bXg5cXprYm5LUGtmaWx1WFY1ZTg2bXBqQXVrK1FMbWNkd29WeEpVMWFsZ0tI?=
 =?utf-8?B?OSsvK1VFcFRHR3hsVUxyRkM0eklPOEtMa2pNWXJGdmtrUmtRcWJLckNmQjdI?=
 =?utf-8?B?VkM1Vm9TUmZkTFVGWFpSRUEzbzYrUGVSbzQyTEdIOFIwK1ZzcGUrSk81S0F2?=
 =?utf-8?B?ZkhuM2xsQWl4NHRUVFRkTGJETTloNkZZek1aR1QvTzlLZkxFY3RxWHJpczJW?=
 =?utf-8?B?d0ZXU3pXengxVjRlbWlMOEpGRlBwSVFZdExBdUZIQWEvME9lR0pNU1BwV2tz?=
 =?utf-8?B?eUJIUmorMFlndWtEa0gzdlhMbDkwSEIrU0NlMmVzNk8zZUpINDRSOFEyS2NO?=
 =?utf-8?B?ZWdsSTIyV2VmTlE4L0ZBN1hzR0p3N1VTaDlWaUY0aVUyek1TdzVmMW9WR1Vv?=
 =?utf-8?B?bEcrNjliWGpqYm9nMlpSQmRlQ3JYZFduUlQyUTYzV2lTVHI0MGkza2dwemlo?=
 =?utf-8?B?NVFMSVE1RXVjZVlDSkgwZGtEQmdlVUtEZ1NKV0xhdjhRSDhpUmpvM3BZSHlN?=
 =?utf-8?B?L0hadVo1L3ZuL2FwVWFtczZQOTB4NHY1Mys4dmc0YzI0NHNhQkMzRmpRdkNZ?=
 =?utf-8?B?c1V4V21CNENCTk9ZK1ZpTWFOekZUWk5UTXc0SFhMcmE0TnNKWE9RSnVGbWVL?=
 =?utf-8?B?S01KanpTYnlsbXhMV0xWNGNWQS9tb2JqTkM5dDlubHlsajNHemxxcnA2aDBN?=
 =?utf-8?B?MXRNVVFWR1NmV3FFZmdTZGFVQlAyOXVGN083VnR5QlNxVGRUS3E5TTlKNVZD?=
 =?utf-8?B?TnI1R1ZDbU9MUXJpekY5YTNVUXpUajJCU1pGNjNGVmNKcEdKa3BRa1oydFkw?=
 =?utf-8?B?aWQzRHpTZzlLZTc5ejYzSXpSZkdCNGVkTTBJcWFpVHN0bGRtYkVrT2tOZ0Zm?=
 =?utf-8?B?R2cwQVVWd0txTXhPUkN2bXhpbkFKSjlpZVRlZFc1QzMzOVBiTnNIUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5b9f78-0e4f-4eeb-957a-08de892eced6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 22:52:06.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvlknzoBr7125/DyAWTqFTE3q/S2JN2GeVwhS828JP/fJzpepacRecQh6HovjGyAO56vupSoXWE9aMnpMmPaNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7886


On Wed, 11 Feb 2026 16:41:03 -0500, Frank Li wrote:
> Clean imx25 tsadc related warnings.
> - convert txt to yaml.
> - rename nodename to touchscreen.
> 
> 

Applied, thanks!

[3/3] ARM: dts: imx25: rename node name tcq to touchscreen
      commit: b2166e73d9ac16189db629589d229eb94558e420

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>

