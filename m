Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E13CDBB5;
	Wed, 15 Jul 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107885; cv=fail; b=EjjmXq6omTEsg93XduGXPLjC3DyInVvS3wDm0rAH5ZVSVwEf5TWy1SjvZpRrGAvxqPmrnFTrF8XKMwX4HOyo0hCzR5U+kn19Zkp/PziKdvego5a7CFZwU4bah6JC5Iozb6AxuYEAVedNfK0KB8gSl8IDOohwb7EX8TJ2/MQdfCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107885; c=relaxed/simple;
	bh=1TgEMXeErXhfxxkfRcE+2U0+71rxx3lgO7sPW1apzgw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bMumthsvjc7LDRrKyP84+Ca47hsVKyk9mksXmjvrhBxVUW535AIehbp1QjCbfNXdKpTXZ96cKZxdBhFiG7Bk3t2Sro5AFSMYOTcKt17oSWOGlMdJKxyPugjWC2OFkc0dyq022nKgeNV3e9khCLqqeWimIVeT5EYjB6wQF9qW6SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SIHstvKl; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SIHstvKl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohj+EYMLstDc0JEpOI/0ckH9HDusX5OHVCZZ7s1rrtBLoE8iV+OoMbNMHc4NGRGN7XqawV/P3IM7308nToSgSwo0yfFMORm21FLiDsIgU66tlc7SUVD7TxXyH7aN3qnCb7PkZdt8as4qhfHi+p2o4eJ5vT7S9lGVuhPZEc/f7jwRMbjmlCHcreX++/tF6znFiQ2nqFg+KZ9uicwaf3U6iXgh7Pk33KIoKQWUnRdyCHkPekiO81EvFQ2KuLtkpvVTEfhqQEdd2M7AFfIdrTLEs2omEgAa7JKKvvTrVwbuaRw+p05wi1mBkaqGi0o8rpu8XxYUZqh3rzkzyiYN85u5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne/4HzlJlC6FYrTj5GTrfvcfH6cHDf7ZYARAO6wO3iM=;
 b=lr/v+SXOwZFnGdOJPhA59AXLNhBHvLrORGEeiS7Em9J4OMSYrD1DU6pOc4ULgAId+tWdip+nVAjOXGa9qQG0SWnBb1/DNVBR7tj6MlCv8bMJEdJz2HBIXH4ToROZ7oJ5jrZhruzJCHxRKK7cW4V5BLXxKTqS2EVw2Ec5wbYIpn3vlwBy9cKkAo5jvPe8zk1b+uN2Q5ey47JfYhvZtOV9jS4qHKwPQI/U0VFUWS3TT6Kptk2C3Mmegf/VGNK5iCmmTo3oLHUA7DkfgOjSs9t/lZteaAGTIy5SUEUXMLMeTIj9KwFaEyWKqXnPtq/9QLV3zIqqmFon05QJOiyiMYULxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne/4HzlJlC6FYrTj5GTrfvcfH6cHDf7ZYARAO6wO3iM=;
 b=SIHstvKlwS9T6Y9FITAGVDFZyEFzss1I5zr4IgMXq3ZzXXcnzDAenavayn898qVRiAnc7DZq5ySWXRgs2bPdXhdwtypAp4wShh9gg1maPuW7A++eEigMni9WvBqe5U59Y1u+w99TyaVZtHj4aRgRbG0VUVBH4FZOtxOhzk5HrQu1tibgX/rT19TgSxu+FVA9JsHA9QYHiEJ83IM00wCyTDdaGJ/r83mK0n3jpQyMmtBnWXwzacWfSugDAfVf8rw6lDnxT+vGMtq977Db2x3Lgso5WaFKoTiuozlF7LqbGU9Tqf9CUb+68q/Wgg4Tq3XDhmTi5/UkhiPauclQF7jQ+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com (2603:10a6:20b:a4::23)
 by AM7PR04MB7047.eurprd04.prod.outlook.com (2603:10a6:20b:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 09:31:16 +0000
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f]) by AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:31:15 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 15 Jul 2026 17:33:51 +0800
Subject: [PATCH v5 1/4] Input: snvs_pwrkey - make use of dev_err_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-pwrkey-v5-1-07e7353c319e@oss.nxp.com>
References: <20260715-b4-pwrkey-v5-0-07e7353c319e@oss.nxp.com>
In-Reply-To: <20260715-b4-pwrkey-v5-0-07e7353c319e@oss.nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Cc: Joy Zou <joy.zou@oss.nxp.com>, imx@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To AM6PR04MB5800.eurprd04.prod.outlook.com (2603:10a6:20b:a4::23)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5800:EE_|AM7PR04MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 764979fa-3b7f-4669-b0b0-08dee253d15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6GW7Etlr8I7NH9aqdtabgtpJmlMXZta0/TKns4lGcWthGlBtqwYAzn5xiVRxXaDFYzlPSLqwHOw6Vs1gIxWjH7m9CyfPW6f+vgR9VpPVTlxOcetWw033u2Gz21qKBEZiJ2Fg6BvMjPq7nHa5uW79vPL/MN8T8gblUHW80ZX5K5I3kOTSVmWlYT0F0K4AthWL63PF9xK5U1tUkT96oDTcZlXE2E9xGm+TZ2Fuj8YTOgVmHuM9UOfJhQBVeAZU67Hje6eu1zinLXg5o97/otgYzi+tRxUaW4NszF+9cJCcEN3K4zr3ChpBfKs8hyWPtSdNeS+U0VOuVnzNoJfdr4rkWD7rkFPtueng3ZfWYtRtymiDO4pgpl9FpUgpPv1VfjTOO4BKDo7H9yNoYgZlo/7iwUSowHaq9j5gIJiEqmWKdDKqKVMmoOYVmrcwQ/O7RMKDWm+6+++JqM7sQFsOR1QYclDbMQ+gpSp4fDpFXBDqGkzeCENmWGx/ew3Z1bDzSn9Nz2NTbzDESOyIEqfjZKCwrUqdZJP6jaTDT6ykeBCCyC+XNob7Y590hqEH2KNbDHlwk3/Llz57sl+6j3pMetirrQYZnAQmq4gNKWupcEQmNbeQjFqqO6hbBR/Hb550e2j6+uBq4bETk9nFZpt4VWyc8xMEPdSmJ4Wk4PQHic4hzmo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhPWGZ5bzByMlpha3Jkc1pLUms0N0dtSHYvaXBDRkIyVUNCQWJ4azZYSkpt?=
 =?utf-8?B?OEszSUtrVks5VE1RRXJ6clFoeHBRQkpPYUVYVzlEZVBFSHFmZEJnK24zTzJ2?=
 =?utf-8?B?ajFYVmQ4cThGMlFoZHJDZHNoNFVXY3pSRXRJdTZsc1BoalNHS25aenJiMFV4?=
 =?utf-8?B?ZGhjaDZIV2oxbUNEK3pZYlIyTXlTV1FNZ3VYV1pOY3BnZ1Y3OFhZNjZRdnR4?=
 =?utf-8?B?eWlVL255OEh5OFcxT3VzUElyWlEwZG9FcEYrQUw2elRqT0JRYVQ2SDMzVTg5?=
 =?utf-8?B?MDlsM0hKa2NnTzlzVXUwa1VVWUxiL3h1YlpHK3lqUS9yZkNjRWpRTmlrbm8x?=
 =?utf-8?B?OGNXK2dFRUVtNWZLRjM5S09JN3ZONVFqWFFxRHBvdUpJaEFxN2pZaVlxMGV4?=
 =?utf-8?B?ZGo3d0xkMiszMVJYNUNZV2lIS3RCTWtpQW1HdDltNUllQ1V0WWUwV0FyakNt?=
 =?utf-8?B?RmpmZUhVekRWUW5naWxSSzNSVkNpNE1TV2ZzR2RmaEJReU1DWHdFQ1ZQaW5M?=
 =?utf-8?B?a2ZYazdBL0pyV2pjWUg4ODdIcWFPRHlOdXNuSHd5eWtCSnFvVmVEczlodWI0?=
 =?utf-8?B?WWd4N0xCcmpobUN2MHU3N2d5QlF0K1dBWEZqV1RxQWZZQXQzWlEwSXZQVzla?=
 =?utf-8?B?VHhZM2N1NmlGSkN5K3hSK0dNYVF5dzhMSDViaU1EekdJZlVjdU12MkcwNkhT?=
 =?utf-8?B?UjR1YzBZbktxelVMeUV0K1pib2pXekVqNjhYc01Nc3VZQ2dlazlSTXVFcUoz?=
 =?utf-8?B?NFFKMzI3UytrbEtOdFFLdE5qL2xwYXdVMlp6ZmZ0VDA4WmhEZmZEWmVROE5J?=
 =?utf-8?B?Sk9JSUlhNjV4YmM3d3JkbWpUMGFGUGplUVFybzdwdEZvb1hpbzQwWXdBOFJL?=
 =?utf-8?B?bVRScUVXdUEzSmdXUjA4SkNIRXg0UXZSTnVCWWxoVmlnTHovaEJyS1l6dEZN?=
 =?utf-8?B?d0YreXFFemltc0IvRlE0ZnZaVWY0K2h1TFpjYWV2cmZGaWdIZ0gvVEJLa3l1?=
 =?utf-8?B?elVnL1JKWkVMaVFUTXNJdFJjV1pVczNpNWJ5dXdEUEhuQUg4TElDOUZTL21I?=
 =?utf-8?B?KzRaZUVobEZTU1FneXlJd3FscUtiY2JlOEk5dis5YS9zdy8rOFN6L2hNcEx0?=
 =?utf-8?B?TXBhcldJR0dwRDBvQTlDV0pNTy9LTko2a0JOalFGNjIvaVpWYkFvNXd2bm5D?=
 =?utf-8?B?STJKRjhadEowMzlhNWFjMXVMWXFTWFFtSzVRbmxWeFhHME4vNFM4MXRqQi9o?=
 =?utf-8?B?N2lZNWg5aFZRSnFvQkdObmF0b0ZkaUtCM0lFRDYwcnF6U0YwOVE3cGtZMkxo?=
 =?utf-8?B?anZMMEZUTFU2UFpJSWpxd1VCNDBPWk1DUWFPZWZxYXlXbm42YUdSU0FHdTc0?=
 =?utf-8?B?eFRoUDk1TlRFNy9hNGhJTjYzeW1Xc1NWWkFQUUoyaXp3VGhXNk1zT2s5dmhY?=
 =?utf-8?B?VDE3b0NMYkhWYUFVY1dqMTc4WFd6bC9RYUlCVXBmc1oycWM4MThzcWEyeWpn?=
 =?utf-8?B?Z29NcW5jblNSY29nQVQxZ0lNM1pKRVFHUmNMRDlZR1RXUWhKRDY1VTYzMFZB?=
 =?utf-8?B?cWhnYWJ2MkMyekhtNFBlVU1HT1R6ZGZqRGpVY1pGV1dadzliUDVCMFc3eUZh?=
 =?utf-8?B?bTREa3lkcGhtVFJvbjFLRmw4NFcza3JTY3BKVzBROUZQMTFFTk5aQUdpTFB6?=
 =?utf-8?B?ZjZJOGt3TVhweko1bUZYRksrOEFBRnpVVk9Nam1NTU8zZC9tRkJ3azBJaHdH?=
 =?utf-8?B?bmxROFNTcVVUbEkwRHkzUkdnYU92dXhDclY0aEZPcEY1RDhLRVNOU0kvUm54?=
 =?utf-8?B?OTBuY3BtbzQ2Zkc0ZkxRRmhmR0NQLzFLOENOcWVXK3MwbnNSSFNueThubXdR?=
 =?utf-8?B?NklQR3lCS08wRUMveDZhY0xwRnBQTmlSSGVxRjMrcWw2ODRzNWxLOFJvek1R?=
 =?utf-8?B?dTRWcWd6dlYrRFZuUUdyZEtLVytkUUdCaUdzZDE4cncva3dvUHcrZENXR1RM?=
 =?utf-8?B?UzVER0Y2bEVKakFwbTJTZ2orM1FCV1R3SWVwNFowdUh2UTJSVVc4Nnl0azVj?=
 =?utf-8?B?ZkRuaWd4Wk5xL1FoL0FQVmhtZG0vWDgzUEMwRDFIWFFMQzdVUENTVGkvQjVj?=
 =?utf-8?B?RXpWSWNma1IrcE8rOEFYNEpwYlQrK3U3QVBaSENJTER5azFLaXY5cHlYNkhi?=
 =?utf-8?B?Umhpd29QR0V2QytnaXdMSUtUdWdvb3hxV1BlaTVNSW1XTVBvdTlzcUJKdjdp?=
 =?utf-8?B?WjJ2enFKTERWMDBCRUpmSy9pYVdxcEFjUzFFRzlDanRxeUgyUFdDMG52WlM4?=
 =?utf-8?B?Nmw2T3cxaWZXaS9KdkNlb3VwRkVKdk1lRUVlNkc0NVVkZG1SeWpqdjQvMDlh?=
 =?utf-8?Q?vxLihp+W6iERDz1udxJQPcz3hAuWJO+Ir4PwF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764979fa-3b7f-4669-b0b0-08dee253d15f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:31:15.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Foc7qgEIBdoUpeFs91vwbtH/Gr7OGAV1EBQeitn2YuDAo4K7ghm9o7YWTBJ2pXRUb1aJEirfBi9XiVs8vlwNNvKRGCw6rNncQQsIdDF57fP3g3AFRgMeG7/rD5dyX6A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7047

From: Joy Zou <joy.zou@nxp.com>

Add dev_err_probe() at return path of probe() to support users to
identify issues easier.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v4:
1. Use dev_err_probe() for devm_input_allocate_device() to simplify
   error handling.

Changes in v2:
1. Drop dev_err_probe() change for platform_get_irq() per AI review comments.
2. Add Reviewed-by tag.
---
 drivers/input/keyboard/snvs_pwrkey.c | 44 +++++++++++++-----------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 954055aaf6e2..8cc6863d26ed 100644
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
@@ -185,10 +181,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	timer_setup(&pdata->check_timer, imx_imx_snvs_check_for_events, 0);
 
 	input = devm_input_allocate_device(&pdev->dev);
-	if (!input) {
-		dev_err(&pdev->dev, "failed to allocate the input device\n");
-		return -ENOMEM;
-	}
+	if (!input)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "failed to allocate the input device\n");
 
 	input->name = pdev->name;
 	input->phys = "snvs-pwrkey/input0";
@@ -198,10 +192,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
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
@@ -209,16 +201,12 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
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

