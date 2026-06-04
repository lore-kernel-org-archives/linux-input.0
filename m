Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECED3DB33E;
	Thu,  4 Jun 2026 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556070; cv=fail; b=klofLhWmmkpS56a24/W9i97+1Nde/6rfe0S3WJQsAgeyU5Q2Uslph2jges6RcRyxsSJZtWDiIxrsJGXORhJNdrsyNeO/sz9WrwDHKHM/jTzQ5Xfu/V8HGHzYH4d2JbXKRg2wSkXxDGJUj/OGNiVY6iyZoFUDQX3aGwSjvv7Mkig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556070; c=relaxed/simple;
	bh=fhiweUTxO6lrOUpqZhuAjL2AVYKfhFB+OBPIKrbH0cM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kry3kPgzmZduWllY6pV4V6fchRQgZc8Yf+5I5XSrucedkxFPcWQQMFda+0+LQZC9nMGEwwRMQ1B/1jJsM+WgJCijqy78aSkX/LTa+ofNK9DKjVlIs451En4NW75coB14pjzjOwqPCjOjOG7Zym1eNWcYceJrK1sBnXfds39WrdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IL8X7D91; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IL8X7D91"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh2S6FHeUMslGWhu4UzHMR9fgZS50aZiVOs4Ud4znn/8JWLjBTVqZEQ7aZs225Chl247+mfbMlsMySte7HrJGLSRIMLL7zkUXZSnfOG2Q5PJHb5z169+LHyIrqXlCyniSnXVnrPzKTGEufOZ1RcDjt6r+dQ+vZPEmrZhwcBiAUFhOVITyHN3PJJxcF9nQ2lxjdKdjCKwo/ZfkbE0NTM4GNQc51LrLbCriQ6wr+D1vAt3shrZ6f8GIzZGgkUfCF2ldCQGa7Mlz9aSUROyezffFe3crlqzS6tqtblFn+R0DYLGmecM+bXrVJOnVZZfgE3wkAebCAHuDLAjnR+e/7H88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mszyY4evDkGmzVIOQpv2Hbq8VRZvE74Ne6kBmEbUDZc=;
 b=jUL6Rf9RaaNndXhYrWH768CBEdXPvGdDnyFOlNHDvMQWxjJKVMZMy3KAQjKrY5vADMf3IFuBkTlw7evkmJNFw+JHKNkSEhnCt6rd4i9cISPEKAl0YPoRLtMkG4mXMfCovksZwOmff3zNp2rxRY59B6NyGvh4qZIAi5apQuureMQjNpiYXaf9VYTbW4vak1+vblMQczna94kck3OKcHgL7zvOJvWLpNFpHBi25G3bGpsDd3P4+s3g1ehX3hHxGoeBBHGyeNFoycMmT8cjYYL6Zz19xfWTbNeItSV2o2DEeJZ2VtvDMnoFATFk74cX2QZCo4kwo1wi/Z4ue+m+kGQ4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mszyY4evDkGmzVIOQpv2Hbq8VRZvE74Ne6kBmEbUDZc=;
 b=IL8X7D91Qf1jcXONQ/XVTk6patq0ZQo0DmMXKZQpaSRT/yJHgZv3ODo4B76RJdK37zsBWk1d/F7Aq5kzONoP/8Nvm8Tat7zJwZoAd6rYu6EP+xGYUCC4bZmiK0SG821k911jjM8qbXGYfOIM/9dh6cQQmB1cxEvP+yye3sZKc4Aqd/8I4szK391v6KWfLaQn8vUoLO91Gd2hlSr3PfGExXnorKXO0BW/7HTrOAa9QJtXLdgkzTmyyzgK3IQNL0buxyflKD5Q0LRG6VHpSsDnh5tflFgZWvVe+E2eJVKtLF+uLwXDJvc9aTtqo2Q2FicHWvyFWcbtWC46AcTozY8vuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:54:26 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.21.0071.015; Thu, 4 Jun 2026
 06:54:26 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 04 Jun 2026 14:56:23 +0800
Subject: [PATCH v2 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pwrkey-cleanup-v2-3-59fa0ddf0d7c@nxp.com>
References: <20260604-pwrkey-cleanup-v2-0-59fa0ddf0d7c@nxp.com>
In-Reply-To: <20260604-pwrkey-cleanup-v2-0-59fa0ddf0d7c@nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>
Cc: imx@lists.linux.dev, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA5PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::7) To AM6PR04MB5765.eurprd04.prod.outlook.com
 (2603:10a6:20b:ae::26)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5765:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 678b3764-be11-494f-64d7-08dec2061ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|366016|376014|38350700014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RN0ZPVaj9ApOL4hLRBfuAC8fpr5NysJsXgf97I2M4RE2c0tdWzL/UMeja8/6+pm2so+gH2Xpztoxo9z1YGe31yhzepFMQACF4eenCwBYrUaVBO9L5HzueW3AC223OUCGC1EQkaE3lBcWVvM4lUJb5pZ5cSa4gatd3j21W7DYpObyx+mdBHIWuFNaJ6SV0TosEcdKfIKnw0EITJ9KEEIoQuz+hLp5ALZ450AGfN5dKvQDRLAbDXeSSNW0J51n8rho6/PCs7IGGEchi9Fv/u3K95A5wbPlgVHDI5Dmy+Om2YWcyLo0xz0YegZa84vC+Ys1VcIcEDXzkfkWciafoCoEHhkWCZIyRWGjzOkO8iu2Do/7GJR2FKE0EbTkEY2LYnA0coT+dctWOYuI2/Hm8lFj60/jOoIsrt0rvfcJ2c5BVi0RR3Lld+pqErXZYO9o/oPynsUF6FuEldD4FT1PIU9OAES+Tv+rqmN0U4HyHHXRBfXzdXWGASxXNfTI4WlYl3kuM7AS4NsMFTZKo76wOMydH2Ziot3caN+cb7RbfQD9X51b4O+fTiQVH8puI8HgFpD9cW9rXYqoNxQSr/vWvybFIEY3PD1/Fb1u8fCbXZnXycNvyQSTM04ZHRoC8XvhMoS4/VSVHRxJrtxiMLRVIXPHB8JA+Y65RagM+k1KJuIU+1fNrr1N2LpvpgK6/XMYzn8IrB76Et3fQ9w3DloUZRKXmD+X9AwuPKcyo57C7hKKYn9pfOZ4JzKOT5OHYaCLmPve
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(366016)(376014)(38350700014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlJXU0hDcmRYSUltZ2JwU0NRaVNjcGVFNHBqZHMzTlR5NXRyOVJRVGZtN3cw?=
 =?utf-8?B?S0FDQmdTemJsZ1gzOFBLUHdUS1F5VUlCKytKVFhxMG82T1Y2RXpPZzJoTFhW?=
 =?utf-8?B?NXhra2l0MFJ0cVZQeFdjSGczMzlFYkpZWWNHZTY2bC9DRElhZC9BRHNZVjBn?=
 =?utf-8?B?VjBkVXRpU1JOaVcwQk5xWjV1TWNReklXVGhLRmFlVWxXeDRaT1FJUkYxa2Q3?=
 =?utf-8?B?ZFZIcGFmeEVKVVZEdHpiZnBhSzZNQXRQcjE4aVE0cDRxY3dSVmk3MWEvUWRl?=
 =?utf-8?B?UWVRR0pzUUI5YkxBdDh6UEJXa1pLWXE2dG84TEFEbnZWVUFsOTl3ZktJSVBp?=
 =?utf-8?B?dkFKWWREZGNyY3czaGE5Uy9OUDZSeHF6SmhyUkJKUVhDV1ZwcmxydjF2VmRu?=
 =?utf-8?B?c1dxMUFqaXRTVnpaMDk0T3lTdzNScjhCUFQrYmtDdjhzeFZLTW1UK1Iwelh4?=
 =?utf-8?B?cGVhNXpmZ1gwRkpGTU1WdEM5M1VGL0xpdTV0K2U1cHlXcTd1STZWMkVDYWhD?=
 =?utf-8?B?bndQYy9aaUtWRHZOSVgwZXJGYmhnYXJTaXdySEY2VFRFZEpTNDRtMnU1RzRF?=
 =?utf-8?B?VFdIK0E1NmtXQ1pncGJMTXZ6a204VjJXZStmNVBobDlQakpDOHRBNmNFbjBl?=
 =?utf-8?B?TDRmRnRtS0pibEY5VUpsYkovS0l4RVNqdHdsbXpTeS9KZkFmU0d0ZUlVYXo1?=
 =?utf-8?B?U0dYQysxVCt0amdvOUNPcllYM1M4Tm1nSnlyRkcxS0FJbDdnZ0ZBKzJkVjZD?=
 =?utf-8?B?NXFFTm1ZZkxyZVJZaWRpa0VJOHl0SkxTamlIaWdGc1BMUFJyUnpKMXlic2lm?=
 =?utf-8?B?UzhlN3dyWmttY1lrUEtuMG5PR2ttNDc4ZUhRQ3h5NXpMUEE2aTBXQTBkcHho?=
 =?utf-8?B?c1JkM3NmblV2dlZ6UzZKZ1RFNTZtNEg1UThOZVhMdkE0a1g2ejdIUU5PS09k?=
 =?utf-8?B?eFZDM0ZpK2RNakhIcUt2N3FmNlE0b2tzcXFOQ1lUbEI3OWFONFd0Ny8yVlZD?=
 =?utf-8?B?emhmRSt1MldNblIxa0ZyRE85MEhVT3dOZmQrR3IxdUt3cERkYTFIcitKVmdy?=
 =?utf-8?B?anZmczJLdGFDQjlLUDdqbENUWWJjbEV6czExYWZwU3dZVGhSTjBtMnIwQkNy?=
 =?utf-8?B?czA0SDVVaXRadmZsNUxiNlFNcGtSQzJibmJML2pmdGRqdUFNbncyTWVnRU1s?=
 =?utf-8?B?end4R0xwbjFqSCtyQWxkVW95cVVTYzRXK0dOTDJWN3I1dHVvdDUvTFVVRTlu?=
 =?utf-8?B?VjhlRTU4cVZYL3hUQjg2RHU5L3Fpc1M1cnorK1ZEeWdreGFDeXNOeW9NQVJ3?=
 =?utf-8?B?aFZwQ2IwcVN2SVNqeUx2YzlUVVppS1ZwUmlINGFzVWZmY0IwRzVtTVJzVEVH?=
 =?utf-8?B?eDJiNDVxNUJGcDJvSkltVUdmZDVscUpsWTcvOGwvYjZId01XVUhROU1wdWI1?=
 =?utf-8?B?WVFra0RSUGh4ejZnS1pkY1JRa3E4cFZGL0VmQ2F4UWlQVTBqZDlZWG9jSmlk?=
 =?utf-8?B?WTdwMkFJTmswZUNGYlJwdHpKVVhjdVhmUXQ0ajFqKy9nN2VwU3drYkJLdDkz?=
 =?utf-8?B?RUF6eHFDRlZscGtGTDZ5eStwc3JqYTJLc2VrMXl0SkdoZ3c2bXFzeGVuYzJh?=
 =?utf-8?B?TWtLaE9hQVpuV3ZaOTJ4Ly9Xb2JyQmR6TFUvVGJOcGpMcHFLb25HOEpjQ1pn?=
 =?utf-8?B?TVU1QmJrSklXQnFsNU94SktvdWpCUzdqeFVXUXZPWDRZWkZuNWc2SzlSRU5M?=
 =?utf-8?B?SFhzUWRRUU9HL0pEM1IzeCt4dWNKcjVEcEk2aG5MeEJ2WDlsYWExNHh0dzJW?=
 =?utf-8?B?eGk4djByRmNqN3NCZjhCSklnYzF2SW1OUG13QzJaZ0lzSnhGbnVEeGJONnZs?=
 =?utf-8?B?VDArbzBER2tyamZDWHdUNXA5RWh3OWxLY3hoT01Md0JHcllYUnNPMURSdnpv?=
 =?utf-8?B?ZHB2K3R4SXlvRmpkdjNvcWtGQmxYTG05aXltN0Exa295N3k3Sm1mRjBkN0Rn?=
 =?utf-8?B?Y0VleENzYXVQZ3RJeFNIUjJRbW1TT2VjZ2RhUWkzZ1grRVZIZHlibkZnNmJP?=
 =?utf-8?B?cUMxMGtIVmNmcnJwZXVnaUV3NTMramxrL0w3QTFmb0h4MFBvaVB1cURsUTJY?=
 =?utf-8?B?ZjQzOU9idCs5SUFnMEZOVnhaQi9wQUZYNFVXRlpHR2RnMFZIcmNUY3hoM3hk?=
 =?utf-8?B?SHJoUzg3RFozUUJ5VDJHMi80cW42a2dLWDRvblI0ODF0SGRwUUJ4bm4yNVdF?=
 =?utf-8?B?YWVweUlmU3c4OXdhMCtjTkVCRkdvTVBhQVVRcHVHVThkM3M3TExJUTRaSjhW?=
 =?utf-8?Q?LBtK/wu0hc+rNCxgoB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678b3764-be11-494f-64d7-08dec2061ddf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 06:54:26.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fjaec2c2ECjFuGW9LGbBj4wpyhmeMh2iBojabNhgVhraCt+zIkM+1IO/LxPtokS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

Use local struct device pointer to avoid reference the platform_device
pointer every time.

No functional change.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v2:
1. Use dev instead of &pdev->dev for devm_input_allocate_device(),
   which was missed in patch v1 per AI review comments.
2. Modify commit message.
---
 drivers/input/keyboard/snvs_pwrkey.c | 41 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index a291812e6d22ea963568cced5b889bad00658526..4a1d04898482669894e9978014b62e4e9774b4e4 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -112,6 +112,7 @@ static void imx_snvs_pwrkey_act(void *pdata)
 
 static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwrkey_drv_data *pdata;
 	struct input_dev *input;
 	struct device_node *np;
@@ -122,26 +123,26 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	u32 vid;
 
 	/* Get SNVS register Page */
-	np = pdev->dev.of_node;
+	np = dev->of_node;
 	if (!np)
-		return dev_err_probe(&pdev->dev, -ENODEV, "Device tree node not found\n");
+		return dev_err_probe(dev, -ENODEV, "Device tree node not found\n");
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
 	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
 	if (IS_ERR(pdata->snvs))
-		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
+		return dev_err_probe(dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
 
 	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
 		pdata->keycode = KEY_POWER;
-		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
+		dev_warn(dev, "KEY_POWER without setting in dts\n");
 	}
 
-	clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+		return dev_err_probe(dev, PTR_ERR(clk),
 				     "Failed to get snvs clock (%pe)\n", clk);
 
 	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
@@ -162,7 +163,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 			bpt = (val / 5) - 1;
 			break;
 		default:
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "power-off-time-sec %d out of range\n", val);
 		}
 
@@ -180,9 +181,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
 	timer_setup(&pdata->check_timer, imx_imx_snvs_check_for_events, 0);
 
-	input = devm_input_allocate_device(&pdev->dev);
+	input = devm_input_allocate_device(dev);
 	if (!input) {
-		dev_err(&pdev->dev, "failed to allocate the input device\n");
+		dev_err(dev, "failed to allocate the input device\n");
 		return -ENOMEM;
 	}
 
@@ -193,27 +194,27 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	input_set_capability(input, EV_KEY, pdata->keycode);
 
 	/* input customer action to cancel release timer */
-	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
+	error = devm_add_action(dev, imx_snvs_pwrkey_act, pdata);
 	if (error)
-		return dev_err_probe(&pdev->dev, error, "failed to register remove action\n");
+		return dev_err_probe(dev, error, "failed to register remove action\n");
 
 	pdata->input = input;
 	platform_set_drvdata(pdev, pdata);
 
-	error = devm_request_irq(&pdev->dev, pdata->irq,
-			       imx_snvs_pwrkey_interrupt,
-			       0, pdev->name, pdev);
+	error = devm_request_irq(dev, pdata->irq,
+				 imx_snvs_pwrkey_interrupt,
+				 0, pdev->name, pdev);
 	if (error)
-		return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
+		return dev_err_probe(dev, error, "interrupt not available.\n");
 
 	error = input_register_device(input);
 	if (error < 0)
-		return dev_err_probe(&pdev->dev, error, "failed to register input device\n");
+		return dev_err_probe(dev, error, "failed to register input device\n");
 
-	device_init_wakeup(&pdev->dev, pdata->wakeup);
-	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
+	device_init_wakeup(dev, pdata->wakeup);
+	error = dev_pm_set_wake_irq(dev, pdata->irq);
 	if (error)
-		dev_err(&pdev->dev, "irq wake enable failed.\n");
+		dev_err(dev, "irq wake enable failed.\n");
 
 	return 0;
 }

-- 
2.50.1

