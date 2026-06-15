Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C61D5CC6;
	Mon, 15 Jun 2026 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509784; cv=fail; b=WjSTFj2RTvoNO7fe6+k1VJXB4PRYrAD+En5a6HB5cMXUz9GkNowtN/dLpHnicL1R5nlIHDx+CJnO61OHm5Bvso3xoVWgBKOE4TVD1rD7UWAVWpovskw0YrUJCEzyiuobE267ebwc+4GEkRbXzQ71Oo2AYm8y+e3BgaTJ5ZvJtDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509784; c=relaxed/simple;
	bh=Wwx9bmhqDxu5Ius+EZJGPTcD4TKi9NLO1x8ujCxeXkA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Jv6fsiu3X2R6wkPoM1pVPd4UfTVOXt83BmKvkLfMNxDSYna2Qj6Xfp+5uaL5+ItqMKW5QoS4st+7MZDLM1IBOthuwrVX6W2dcdnOyPi45dYgE7fQAHvcPjEsBru7Zvzk7fQFl0QLeIULuFA6RW/Hg9fQNNrb1e3OZj+63Zf2lv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V727CQ2w; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V727CQ2w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQY3e4ROLBO18qRBejDSR1CbWyJcwAF270BD/KQ+rzFtd3+SpSA21OUOrOtB1GUQDTiB0HthEqkC20aB28sOfIar50B2LqVFCAMthyX8dFbOs+3T1Pud6OpMZslZkzIa2e2KLtXkcpJAkD2EgsSP6FUyMvJ44vVvdx9eNHGTA6Pas4ZkfA7ljI1IcBzCfWrEdioruDFpkUYj61Z6tWreLGu3pEAAi842TzTpUQns1ZVVuWqNHPIK8dEwdhpaQGbpiedYTxrnILz0kq8crbbYEcpZwjkFVb7x1ivwqyeuIml8hEdMnAoKpccn8k9aof9m55CXAMmgL3MrCRbfaJeNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWVxESmhtYlQFY5LB5SyeURqtIXkWXk5bs2z44SUyDY=;
 b=ZzeVgtEBQ+Or9IDjz3JSwi1lxLdJSG9mwEx6LpzuwDcLxVmaYgKEsrvC/9Xrk+p//Tmdykjx5WUTENLBhFDyV9xKvFLJ/1yxm8DfAFyUCmQ1J5cEIQCvu8boo+cbw1uNK1xltiZdFEWus1G+EabN1Mg/teJyJArK9dRWUicDbHBzno53GMToSPbFnBIFk1Md7uTNwnmg7cbK8vo9KuvhNFnZ3q9XMwdmcVBROIYX2KWz1TBQxo7u7cYWV/6gzx6uXmfuy1xRejgXDIlTfDLt1LeOhSM9HswfiqMTCghkSznD672urOosPYyeXkVZPAcaC9lqlpz9jXV6ZgH0N9ea0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWVxESmhtYlQFY5LB5SyeURqtIXkWXk5bs2z44SUyDY=;
 b=V727CQ2wco1psLevql7lEARevvJ6ONV5En2xKI0ZeU0DP8eogBeMjxkoYwxYPbM1eXDytnMOyTwzGoI7fuGQc5dDAbJXqrDeZYBz03Z1Ml/V5hQzjGAKZUpWg1fk2Y7oFmyIe3G0nD8GyO+zgFYHhuNmXcA82uNz2bWI7YJDa5Zgmhxmt+27HsrrfgkeGeovQ8TIEG15JZ5H1XWBV86sDqVpzwmplEFfcj4AHGQuAFAjiUvMOGcHdeDrRan5uNqh5DQCg9aS3N5h0/pu1qWv0jmYWUOwg8NknUdpBL3HdaHx9C+hhFHSVyvxaT32Cy1PMW6+XQJp1AAHISUJOqBW8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by BESPR04MB12586.eurprd04.prod.outlook.com (2603:10a6:b10:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:49:41 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:49:41 +0000
From: joy.zou@oss.nxp.com
Date: Mon, 15 Jun 2026 15:52:14 +0800
Subject: [PATCH v3 1/4] Input: snvs_pwrkey - make use of dev_err_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pwrkey-v3-1-9510b1173f6e@oss.nxp.com>
References: <20260615-b4-pwrkey-v3-0-9510b1173f6e@oss.nxp.com>
In-Reply-To: <20260615-b4-pwrkey-v3-0-9510b1173f6e@oss.nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Cc: Joy Zou <joy.zou@oss.nxp.com>, imx@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:295::11) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|BESPR04MB12586:EE_
X-MS-Office365-Filtering-Correlation-Id: 703459ff-44b0-47f0-9d06-08decab2a836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	1YrovZiwkhDg1Xh6gGncky89PL8uz2vBMA2Zq/ISRhWPNcLqKqAwOgQt0RZoihRjSkp6r3ohf1qhE0bjvjCGjGascs0mBFEpwpVzWME5Pui+aAKoGX8ugwjaxpSqiI1+miqWqijT+PK6uCiKFx6ywOGcVrvBAkZsOoS/RDeJbmly2qAE7R3ULSC6bldL3XHaL5tAlwCDr4uAi03gHKP4VXibVVl5ox8jspLIBVieSJXLRiJQzcgEe9e4db9Ke4zAzhmWuwb2up2KR39O5ENkDBIL3Ln4mFcMcaGWWH8iSgkowNV5r01hGHNHDBFMhWsZ6edEO/Cu6RU8Xs3JwXQCQJhFlyzsq+t/1SMgx70aLtdLbMsiIY3A73itx3vw9ifOS0ZpFQPTt9UczPIY6AcijVa4pT/cM2oaCGezAz/WFtNNQsh/mAGKsjCKQWPJihMsad8f/5iL/ykgn03vjgASZC/L488RwRUouj9YzeRKlIQ1XwmFEr1egnMc13M8yww2k/jAE3ZHAVBvvWXMjx4gm+maBXZ3GbjBXKUPnr2TxpMn5EGehw4oaV7amfG2XJTMqluSdbdt4L7oQUMU/KSZknyV1VgBmHDqJPtDvvo1wI33SKxy60wEd1MeCYTW85hB++I7aK5Zkhilg24/2U2tnqCCM5g1B5TOk2F5sG6DATleMC0iYlVDcprhZR8v1bTQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHRaRDdVaDI0aWFBcHM3MmFiWE9ZRHc3OHcwYU5ybjVEZU4xbmUxaFFmSWtC?=
 =?utf-8?B?OTM2Rk02SnhoWVNzVjFHaDhJenp5Y0RwQUJpMVJpaklpYWVXaW1nVHFZb3RM?=
 =?utf-8?B?enNwb25Ba25OYSs3S3ZyalcxVnNUbERqenlsRklKS3JWempUQVRwaE9USU1o?=
 =?utf-8?B?dGtkR2t1WWFmYmZ1dFJGY2wxeWV6Rm9IeWZ0ZEJkekh1M1NIT1FLMnF6TElj?=
 =?utf-8?B?SUxWQkVrdVE1WEsxa29mNUNheCtzWS9CNWhIaW5jWG53VUVSNTR5RC9Ub25S?=
 =?utf-8?B?VGVSRVdvY2hONnhJUkdCc1IzNlFIL3hub1dsdDJjQ1hpcjM0ZmQ4Z21pRE5w?=
 =?utf-8?B?SGVsd3Vvc3Zwd1pUanZtNkR0emZ4VCt3MnREcTBsVGdlczVjSDgyc0p1UUdv?=
 =?utf-8?B?blFyZkRIOWRLWHZhYlZNcU5saTBCSHF0OGY0c1hqbkZUY3E4dlVYTHQ1UG9N?=
 =?utf-8?B?Z1cxcGk4Mys5ak5LTm9kaHRvSzNSTkkvS2IrR2NOU2lMNnZxMWt2T2tPT2hO?=
 =?utf-8?B?N2VwcDNhRXY2QzFydHBkNW9GK1FZaWwwSXczdlRIcHIvT1RtbzVBNUc0NXh6?=
 =?utf-8?B?U0k4Mnc5d2ZGTnJxNklJRFM2enJUVHUwTkhuSXBWWjR4RmdSM3RYNTdKU1ps?=
 =?utf-8?B?T256d20zbjc0ZnJLRVljMGZqZnk0amxMck9IYjkrMVcxVEV5dHk5dlNpVW5o?=
 =?utf-8?B?SitueFdtS2J4anB1T1pGclUrNXFINkRCN0NMNDdqZVBnRkc4aWMyTFpncnZU?=
 =?utf-8?B?a2ZBZWdOZENkR096eEsxZk1jZzJ4cUpiNTJtVC9HeTEzSk9yVVIyWDRpenE4?=
 =?utf-8?B?Q0MxbXpNc29MVGI3ZDMrUFhnYzcwMGh6eVViUndEaHB2UG5uQ01ReVpnaDJp?=
 =?utf-8?B?dkxhYVFvbDN2dG5FNXhMTmsrZTIweFpMcG1oUUlpL3haekpHMi82aTBhUDhK?=
 =?utf-8?B?Y3p1aVpVUmZsZ1JqRGNvTXlDNG00NThONm5lUDlnSFJvVFRXU2REMnQydUZj?=
 =?utf-8?B?aG5UZFBTVTJ6RlVvTU9IUUN4SExoTkRLWXgra1VTL2FhcDNVVUUrNmVpdVNR?=
 =?utf-8?B?V1cxeG1tdEFkNmxkMURVbUhMellrYzUvSGl5dUxwSzlCbm9kREVyVVRRVUU5?=
 =?utf-8?B?ZjBMTkRpODFySTZGUStaeHkwQ0RlMlU2NEVlbm53T2hBc2tHV0Vtc0RXRjA4?=
 =?utf-8?B?a0VUKzBTTzIyRVNiN3hXajN1MHhxbnpRdjJYamVnRzhHM2F1S0pTb25zR1Zv?=
 =?utf-8?B?ZDg5NCtxQmxuOXA0K3FOSGFYbjJzNC9admZjeVFZSGwwbFRRMzltYllodSsv?=
 =?utf-8?B?eWlJZUh6SU9GRjVDQ01WU3FtRGxVMThZOXFnZUdETWFqMng2YVZsd0pGbWY3?=
 =?utf-8?B?YmJ3eFpzQ0w5dW56cWN0NCtUdXExdjJhRXdtdHNBNjdiQ3VEaDkzN1liWkJY?=
 =?utf-8?B?Wk9ZZ1VBYnFmT3dzZmZXMHVYZjdxZXpyVWl4Y3A0aFNGcmFuVzZJaHg0a3ZC?=
 =?utf-8?B?NjNxcWR3UFRQYnEyR0NpZlZia0NzckRnZHJiOWlGc2NDdTZDR3VJWXRZMDZO?=
 =?utf-8?B?OTI4VGpUUy9WK0IrWkd6ODF4bEQ5elhuWmtudFE3K1dsQktEUjd2bWdFKysy?=
 =?utf-8?B?dWY0Zyt2ZGpGWC9jcjJKcVlnRHVoQjd3bkgzNkhTM1B2QVFiNUVwb0UxTklN?=
 =?utf-8?B?bkx6TFd3Y2NoaEgrUHp5eDdVQk5Kd0ZMTUFHSEpGWGczdXhzRkdVVUI2L1pB?=
 =?utf-8?B?VFNZWmFZZjdPMVFNSjBZYkRCSHpKWjdkdk1QRnBSajFjbkRyMVdPOU8wLzFl?=
 =?utf-8?B?N2I2SWF3Q1JsRDN2Rk10SnVZcWdqQXFqekVIbHJXR0ptbUlLdjYwOGJUSnA3?=
 =?utf-8?B?SWJSTjgyd3BXMG5DUldIK3M5TjNzRXJidTFGczBOWGZjWlEzaExtcFM3Q1Qy?=
 =?utf-8?B?djZIbkFhbmJhTzlGcWdZT3BrMkJKS09xQ2JUVVlEK09mSjNCYWZIdTZOY3VQ?=
 =?utf-8?B?aFhTbGxSSW5Ca2RnaXZoSERuZkJGeHJFTXVMMlBhNkwraUh2MDNzZE1ENTFp?=
 =?utf-8?B?eXJQY1lzTVRtVjhTTzc5M2tLYnY3WDNoTzg4N2JrejlqWTFLZEdJYkVrNEp0?=
 =?utf-8?B?bnBZNW1pM0dKOEp2YzhkMjQrdUtXdXpHemljZG1qUVVFcC9vZHBtaGVYdytL?=
 =?utf-8?B?azBmRHpaK2xRYmN4SUQ1dHkvL0NBWXUyNEQrb3FiREVUcFBMSXl6TmlMSlJy?=
 =?utf-8?B?aFlLV29XRHk0Y2RDK1JYcGtaRWdvQXJ5aWU1SHVTUm1FbVpBcUEza243QnRJ?=
 =?utf-8?B?ZnZ4bmVYaGdUSEtZVjI1ZkdFaFVUQkN1SmFPUmlSYStXbjlEaDJ5NWxqZENJ?=
 =?utf-8?Q?H11v8UJkeUh54OhQUyeGIe+HSNYCkPvDejgaH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703459ff-44b0-47f0-9d06-08decab2a836
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:49:40.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ksb8Eegwr2ZSFVh6kX6uJQjQd+JXYh/5wZYageHN4TcTM/kolY/dtKqIgHGEdol+oGgbRsztJGSI761Qnp4BCTFUf5DPNKgz9D17QrzaYAZTbqc3PKMQJxrrAw/ukac8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12586

From: Joy Zou <joy.zou@nxp.com>

Add dev_err_probe() at return path of probe() to support users to
identify issues easier.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v2:
1. Drop dev_err_probe() change for platform_get_irq() per AI review comments.
2. Add Reviewed-by tag.
---
 drivers/input/keyboard/snvs_pwrkey.c | 38 +++++++++++++-----------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 954055aaf6e2..748196fcce75 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -124,17 +124,15 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	/* Get SNVS register Page */
 	np = pdev->dev.of_node;
 	if (!np)
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -ENODEV, "Device tree node not found\n");
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
 	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
-	if (IS_ERR(pdata->snvs)) {
-		dev_err(&pdev->dev, "Can't get snvs syscon\n");
-		return PTR_ERR(pdata->snvs);
-	}
+	if (IS_ERR(pdata->snvs))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
 
 	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
 		pdata->keycode = KEY_POWER;
@@ -142,10 +140,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	}
 
 	clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Failed to get snvs clock (%pe)\n", clk);
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "Failed to get snvs clock (%pe)\n", clk);
 
 	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
 
@@ -165,9 +162,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 			bpt = (val / 5) - 1;
 			break;
 		default:
-			dev_err(&pdev->dev,
-				"power-off-time-sec %d out of range\n", val);
-			return -EINVAL;
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "power-off-time-sec %d out of range\n", val);
 		}
 
 		regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_BPT_MASK,
@@ -198,10 +194,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
 	/* input customer action to cancel release timer */
 	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
-	if (error) {
-		dev_err(&pdev->dev, "failed to register remove action\n");
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&pdev->dev, error, "failed to register remove action\n");
 
 	pdata->input = input;
 	platform_set_drvdata(pdev, pdata);
@@ -209,16 +203,12 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	error = devm_request_irq(&pdev->dev, pdata->irq,
 			       imx_snvs_pwrkey_interrupt,
 			       0, pdev->name, pdev);
-	if (error) {
-		dev_err(&pdev->dev, "interrupt not available.\n");
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
 
 	error = input_register_device(input);
-	if (error < 0) {
-		dev_err(&pdev->dev, "failed to register input device\n");
-		return error;
-	}
+	if (error < 0)
+		return dev_err_probe(&pdev->dev, error, "failed to register input device\n");
 
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);

-- 
2.34.1

