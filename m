Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8242F6ED;
	Wed, 15 Jul 2026 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107897; cv=fail; b=apJ7WRmtf/Os4naTkoUECwIO/pNetmwp/8TxovZFn1CkGmamfIMZP5zHJuB7C3wouPpfqafxLC/Z+SSAlSTyy+UKO2nXsQ3F8cNSTdjfkErMr/gMGF78hlJMHMmo8P5H374G0Gs7z20ahlua/C2ie1kMjzeHm7OZnL5qhubHi48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107897; c=relaxed/simple;
	bh=AJQEKIoi2VhwpW49EK4+vD/T1pJyv4+nKZ8qkOyWGH0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mzNIEKYaQi8CxK2m0mE/qvnFqku/Nl1bqOWibgsAyb3RlOTNaYFB7lq01ydMf0ZKJNGYpt3jxeKI+Rhl+H6eU9kv8r2G1AnjzCzBKbVnw7kUzxh/UcAAHk0M2YfkGVUS9ZQPjT+vBgjkbLSo5UpREEQEKjrV3G4zM3CNbbMf+oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WgR9nDHb; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WgR9nDHb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnEIOkHVG7nnNS0/EiOx0xzAf8YgaU6pWmq5GP9kZ88OUS+jDweqj1rHH8TSA1qPrk2oWuNgyHElpvYRi3NqaB7Zl201f9z6j4gtgjsRgbgYfeQRPLiHUpX1GrHYUWjPWJ7tFKpjCYmGC+69hlJ/K++lV/t0XF5K/UTsFaGDFhoaHCHSeuLrP1QK0x6dfeZs+4q276UJisApZSnXpFVgU2elL6LtM6bxAkzezYLoudvI8BFimxH9pT5lKM6gSOJ7QtAX1JrwPwEFHc/0ueGI5ajWbE7P8FtBEnusgKmc/jwSx4DkqIQL+XQXs65RswSjJvZ1pQSV+Q3LREbqhbnQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6YuZnggeGpAV9lnymgHDVsZ4OhqISVjDOmgKLpBagI=;
 b=vUwiJqDINgBmHGCPVo2CVh/EezeXFrOp7q9K0E5ZguwpgiyThBkLqRCx+le241qZ3gMU7WbdufowcMYQH4SNKhTrCWi1073dfqzCEOEC6MjDtoyxyzpCI+e41gs3DtuiORu9UqreJBjsY+qORAR9rkF3r1HAVcalcXLSyt0FpkdCLYJsTwh97MFphBc9fE6Tl4EtiGa2gRw9KDHZOFFHc2ys2LkBIkr6afBJQO1fbO/uZKWaNdUjyls8j7BnnMXDVW6pPJTwIiQrLQ9iP0qgmrDIbwFD+ejTl2+mCc64DqKYLZfJ64ismnQOGcb+8KzJD/rz2YFYzDKFko4jQTraxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6YuZnggeGpAV9lnymgHDVsZ4OhqISVjDOmgKLpBagI=;
 b=WgR9nDHb4m9XFF3GGVVsN5X3KZXIPuudvHHNn/JaIJoUcc6Q6JvqpanXCOA6ZbCG+uiBAWY1/l647gqS0CskfgWfoZfc6veUpyoLpRYty7BlDQ260KVptAYrO0S1sy9jwgNLzmw8kl1PcT8L3wljYoQ2PWNJwngxKTqqOmqKrGkHEibuHp7kI5Uo+PQY5LZhE3SJzso0G8d7rcHhK3rQtSMoP79jz0sVdDevNwXfHZnCIRTBsfJHs3jPxcjs9pTZmuLjlP+NKtKKwHsDeUO/XHRkLa0t9/M28F/LQZbWQpLohz8BqDtVLNk3HyL3MDiXHohkLo/chKH0ljcbNLIklw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com (2603:10a6:20b:a4::23)
 by AM7PR04MB7047.eurprd04.prod.outlook.com (2603:10a6:20b:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 09:31:29 +0000
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f]) by AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:31:29 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 15 Jul 2026 17:33:53 +0800
Subject: [PATCH v5 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-pwrkey-v5-3-07e7353c319e@oss.nxp.com>
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
X-ClientProxiedBy: SI3PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:4:297::18) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5800:EE_|AM7PR04MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b302cb1-e425-4303-d508-08dee253d934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9ns8/zIbyjerjDJEyJQcQX/Olsov14d6T8YdkTwbo+JxSRAimpmeptMN68VnpGSjwTaAZLff/2mAhhMeuyF5mi4Tdg4+GGzpIdqgbbdfzv+Vws0hua0XKD76NTBdFJZfEmGJFdVusjLm7DR2nbxmiyNyDAEmgck1ZrW/QXydkT92loQH5Gxy8PUz7OdOm2HbW3GPL4/8f/57b6LmgqdABSZp7pli0CGI7f0sg6zt7nauEQn0JcdY7ajCODOtp3CCTVgLxmNbuvOUncURPi1X7ZH/N7Pi/jQPgiuheC164Ozev61BUEeeiBWsACfZZ9XZMD7CuvExqpgQ5L7zErlUJvxQ6kbW+ZyJKjwDJ61nuNzdQ08uE1qj3m+Nq5jzZJMieyIuJ+negcd97g75dtedwGBn+NgpNvoxWEnPXNRF7XMpVh98TbuWE02+RkGT99Oanv/2Yqoh+zB9ecl1q+ilP0YZR8biUT81BDZU+Tbn+Q5N9HMsMG8DhW38f2AjLh4Yf0a7fVOE5VZDh/vDW4XRln1fLlDVWgVGb+vx9pQjBG4S6+bc98AlSaO9Xb0xNA85ZW3NPp1BXLFG7t/y6xbjoZ+Z44LUN6Jwc/3Kkk951ulQZ3XJGISg8ZTo3P3jJsehAViL73J3ih+2Ors0dfkis+mE1HhQOI3QFpU8/wM8DlI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3g1djNxQTRURTdiQTNrWTYvR2ZGNGZzZldVVmxsL3BvUmVudWN2S3NNa2Rh?=
 =?utf-8?B?ekpoejdtODN5Vjl2OHM0UGdQTWw3N0ROOEpqdmFSYWdhaTNucWRDQ2I2OElu?=
 =?utf-8?B?SXU0OGVuR0UybWlrRjF2WXBsZlVKQ3B1N3ZYK2I1T0R2NmRtRS9HeGt3V3ZW?=
 =?utf-8?B?UUhvN1FsVU5hZStZM1d3c0oydHozVHBPM0J5cjZFWldtalY1L1BhUzBCK2Qy?=
 =?utf-8?B?Z2dXc1ZUdnhnYzNad0lSVCszNGhpSnViTGJ0NW40R1dBQVhseGxHb2tvNjgy?=
 =?utf-8?B?ZXBHUU1nd242Y0o2eWZ3bWtjOTN1QXkvVTNiVG1zTmRuNVRyUXF5RHVKN2lR?=
 =?utf-8?B?MnhxOFJrTXVGUTZscnVIT0RYME0wN3BCRFBibVl4RDU5RjF4SDE5UGp2RjhN?=
 =?utf-8?B?THNQeTl1cUMyUUR3ZTJRUlhJbGVWclpQT0IybisxSlhjeWlVc1FmK1hEWFlp?=
 =?utf-8?B?ZVpXSFYxQ3JwWUMzYlRwMTYxNWRwVnlqbm5CWHJVUkhPYmlHTnhGUkRxNjZC?=
 =?utf-8?B?Skthb21Nd3kvc3UxWk5oZVRteVREU3Y2MjJ1bGdZdWJuQUV1S1RxeW9LVFlO?=
 =?utf-8?B?bVpmUENjNnJtV2w5bWMwU04vV3RqdXduQnZ6eUx2QWllOFpya2RoS3hVV0ln?=
 =?utf-8?B?N1RaeGlETy9vYjQ1US9Sb0lyWHlrNFhNVkp0cHNLbk5nUHlxWTE0QzJnbVd1?=
 =?utf-8?B?Ui8ySDZJNGxHdXRZNXlzTkpWZXk3bjVuUjNGN25vUnZ3SExTbytsSzltZlR6?=
 =?utf-8?B?UHU1cHhRc0dHOHgrVitldXhrVGJMZkpsRkhIL0pzb0xYejR1a0hrNzFLZGtP?=
 =?utf-8?B?dklxWW1TWU1LbVJxeFF4QmlsMldldnNNT1g1aW9aVjAwRW5GL2dDY0ZuUVFG?=
 =?utf-8?B?ZVNrSXI5bHFwYXVucGdnMkFyeTJMVDJzT01nT2hEZ3BIVTMzeElzWG9UeFNm?=
 =?utf-8?B?V0NJcFRIUWJZdTFNczVUeC84elVpT2JQMTdzSFFzQTRrRjBDQjMydkhqZTNj?=
 =?utf-8?B?ZzNhSGdBbTZTeXVJcUxtQy9wMjlMMUhmY3YwYXJHeHZycTFkd1JDRUc0a25l?=
 =?utf-8?B?dkVZdlJRL1hOamhYVHpJeFJjT3NxQWFmOFovZmlUU1ZWNjZNYWg3QmN0cUpC?=
 =?utf-8?B?VVFaYTVIWmFtTXhnMFR6S2ZFRGJJV3NORU55V2I0OXVNeTFlYjZhbVJJRXZs?=
 =?utf-8?B?NURYbllZOXZFT3JCQWgrSWdBUStHd1lGMzBYY3o1V0ZwblZMdXowSVNMenRG?=
 =?utf-8?B?YmpYV08vQXZTWjdnWFFEL29hdHdkaTNZNEUySk1Dbm15SWdxeFEwVERKK042?=
 =?utf-8?B?NFpRZVlIdXN4bkhxdnJTY3FKNjVZTW8rd0VSZndSQ280SmxmcExLRklsUWlU?=
 =?utf-8?B?ZXpKK0t1UjJkd3pGWkhNR1lIb1dqZ0RUdGlTQVlBbE9UVmltekVCay9XV1p0?=
 =?utf-8?B?aDZ0V0NkdUFvbmoxLzJvSTFBTG1vNzY2NzFROFBXeHRRZTh3ZzhLQ1dJRjZM?=
 =?utf-8?B?T2hYa2VReWdsUFVMYUl2OEZWd2VTaGNtWDE3dllBamcwQlJldG5QekxpM1Jn?=
 =?utf-8?B?VGpIVDU3b0l4UmJNNFhOMWR4a0ZWbzNZckZVNDVXQ3pBdGhkUFh0L0k3YVhQ?=
 =?utf-8?B?NXVRSGhKVXYvdFFJYW1UbytUT3ZUNmpSOU9Md3ZUeEJTS0ExNDJKKzcwRnBB?=
 =?utf-8?B?TXFjQmtyNWJLaHUrWjNuakZGZWp3ZlNnRHhHTUx1SGNwOWJUV3owYzQxakYr?=
 =?utf-8?B?aDhhNHBNNTBHeHdsTDQ5ZEE1TThlbjcvd0dXMGdtNXFEa3ZaWG5IemdqZzFm?=
 =?utf-8?B?bmE2Um9XYmw2dGZBa2Vuc2VUTVpqMmlxb2tHYlBud0hDUGhBdy9xeThEV2NI?=
 =?utf-8?B?ZmJkWTQ5S2JHM2lHMGlJTHJMVjdsbU1hdEp4MG5GRjJEc3VIczloZGd3U3JR?=
 =?utf-8?B?R1RJYjVFdlZ6Y0I0d2MvR3RJZWVPUVlnQ2p4czFQVHgxelhVYkYzT254dlNO?=
 =?utf-8?B?cHBzbnJKdkpiTWFBajhnN2FNemJoYUcrcThyWi9KN1M0ZTZ2T3BzMFI3bEk5?=
 =?utf-8?B?V0lNMU1iZGRSKzdpbzhXSGtXQjMwS2U1T2ZuZEJ4UFhMQW5TaGRra2dUa1FP?=
 =?utf-8?B?ZnFoMnZkeS82OU5xRFFhWUIydjA4MFpCd0pHTGNVeTgrYUVrcE9NN0pQNThq?=
 =?utf-8?B?bmlpYi9IckxvZ2NtR0ZuM0xvR0J4dnRCVngvUW1qLzlkbGl1Ry94V1pRRHRH?=
 =?utf-8?B?QmIzRk12V0x5dW9rdUVvSDJjdmNEWVBSbS9VendUWVhMUDNINUd3eStuUGxi?=
 =?utf-8?B?VDlydTY0V2prVGJheGwzTGtlZnNEbzd1UUVSemZCOEpOOWVYL0ZJdnBoOTVX?=
 =?utf-8?Q?YH+ybQv/Me4HXZdXLzw4V1R22UBmlfnhZalq7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b302cb1-e425-4303-d508-08dee253d934
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:31:29.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGBH7XZGK3f3ho/zTnaDB04Ane7Cj50R5WgO2VpTJTYTjR3XMiY48e+JELBwIJQAI35dYF+Q+HOC8VCFLXfksr0iuQPGY9P1A2PceR47O5TgAtM+h6lgx3olwSFNZokB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7047

From: Joy Zou <joy.zou@nxp.com>

Use local struct device pointer to avoid reference the platform_device
pointer every time.

No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v4:
1. Add Reviewed-by tag.

Changes for v2:
1. Use dev instead of &pdev->dev for devm_input_allocate_device(),
   which was missed in patch v1 per AI review comments.
2. Modify commit message.
---
 drivers/input/keyboard/snvs_pwrkey.c | 41 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index d58bbbe9fd58..cbe44a38d2b3 100644
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
 	if (!input)
-		return dev_err_probe(&pdev->dev, -ENOMEM, "failed to allocate the input device\n");
+		return dev_err_probe(dev, -ENOMEM, "failed to allocate the input device\n");
 
 	input->name = pdev->name;
 	input->phys = "snvs-pwrkey/input0";
@@ -191,27 +192,27 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
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
2.34.1

