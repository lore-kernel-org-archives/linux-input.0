Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EA3D9DDB;
	Thu,  4 Jun 2026 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556062; cv=fail; b=QiO6gYxtRfjW8cmiWyU/579WB7N9eD+VRygGzFVlNVgbQ7Xr16cFvKEMqFdQcoDed5HnHB0+g/TuuFCN2aZPAM2GCzFDxoxe8DogyNlbBc9/DwklytnZwg0ClBWezrRH6clWLcUD5lfeFoAXTBOcvnGxsCZJVyMhqkKAqAIVrN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556062; c=relaxed/simple;
	bh=yqj1H3SdQIvr/dLK8fT44xDp68Kgj8X+0xVau765Xd8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T44nGCk5SLCrPCMJZv2ykdP/jI/Nn25xr4BHlvzLffL5oFvilXWnkZII2/nSKQhBPBndV9T8mBWqPxGv4iPQCi9WrAQrUPoQd0rcLI+Fpl31d/aUrbWXTtP+51QsfD9gYnuKhDCUXIuCiS57Z8PfrJjGgp3G4/uvDbC7tEQ8y0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZavVrNxn; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZavVrNxn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9lYvvHuBMU2ljZfDuDKel1eZ4Sw+b6U3ydxlF2ahbYk3t7T721cVMpvYSamfZv3I5piX0KhqCnE2TKN41XQrI2tH13m5Xh2oHzuzCYj55OddVhmVaVIn0snOguO5gGI24oogMVi5ySx1x2Z7FIUiBvc/iPzOXFOaCCbERkQp4DRiWzJIi2gcMasnwmppzALdhWbfbzBZOg9Yjq0AFY5bcuntpYvAt1Zxh+7nXX8OwTGxl2bEV+a7oT0kMYdWFdjr1NSbqaDWIDG+AdSZqSIzA6tQB17eeB/rJN+6SzuHiSl7m7FOPjDzXlh+FigkX1880Fd/S+8rAsspBtnqoKaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sulV7gfCho9FigRxDguUEhBjT3FUSJbGBHInV8RUE2Q=;
 b=gG/PFGlFH9sz6DabYbXP9Wcg4heRLzz1M56k9x3Fqe2PZiEoyiuEDNWTjotayNKsjNZV5fzfDMHVNoT0sQF8xyxJhi+Oy2PsI3sr++vU6MEFFXwZ6MFWEVs0wl7AaX/yc6bNtuwsdGDC1gORo6vvyCdGRisr6LK++zudXA7rtDOr/5Ehf0iwSN1oX03xOU6TQfCYXai3+2ikYMfDZ1AfPlZ5PMl7NPp6JxE3w5AiG7G0YyzCsHzF0RL+hzZIC+c2T1TNdKQGT5Ihvufu2u/Ek0tc/FeRaiDH4m4S6GMYkmKTVDzHui6s4uV1MHghIoEtLtBgxLizMRuKII6mJPEoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sulV7gfCho9FigRxDguUEhBjT3FUSJbGBHInV8RUE2Q=;
 b=ZavVrNxnc79t3OLufryUOT7zXSe73J4B3p+fJUeSwXrWz1XusevsJ33h/hAq91oVR9Yf7WniynX6r0TMKy0vYGKplU77kUX7VKy/kpDf2/canAvmNwvRvUQuRtX87lC+9IZisZbtBCJt1B8r0dpoPnd9I51AwaqOlteqw8voKNq9T1U8SB0rQBB1+T0dwOaO6Hh5l2LrtMnkCp4GRpB1bg9UghyE4//jv04+iI+1RA1B9A5eCUNy6742YVvsGDQse98DUz6Mzu0N9Vxgpp0HmWPGwP5Wh7HPoV4oP83STxIItaAE91Ok9gShzaskLTsBzUrqNCaYoObva3DShe7aMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:54:19 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.21.0071.015; Thu, 4 Jun 2026
 06:54:19 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 04 Jun 2026 14:56:21 +0800
Subject: [PATCH v2 1/4] Input: snvs_pwrkey - make use of dev_err_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pwrkey-cleanup-v2-1-59fa0ddf0d7c@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c1eacf0-812d-41fa-387b-08dec2061999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|366016|376014|38350700014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gFw/SPXu93osI2Adj1ljwBMvFdNkTHYOXHx4fznldHjQFz55rK+df0qCvTnOFLMJ32Q6AzIsn2I7xjFJ59S8Txljz96yiwT/C5UTfWkjxMOfj8qmfFnH+WF/mKCh/hSGxzWAg8+eqCXso2sKbS4S/y049vIoMrANGARCt2rNppzV4M9QSLhCX5beBZ6u3ipuLxxeV7ZL3e9pK1r/6RGdknILGmjZPqkUUTUwQfpAga+paq/yk9k/dn1l9aMBeO37F9Cxhsi1/Wt/FNkZ2133n/qEpyry3LVzpNP8nwK3ErUoDYZjfbfaCKV9Hpbr2wRr47fmvmIMgmmElGXklDzWQLtDjkG2a5teo9syaJAFcqpuQ3y8pZIH2ecP58/hBpFyOUz0Vr4Ymet377Hekt3jV/ioaKrcyyBjifK06EUrKhfR34BtTi+rSjKf4Fu0IupdUP4napIz23CSSmgLEOtXm/NiWjf940n9qu6bt6ccOwpqodR+zQX6PQxvGMiWXZBd4G21QbwHDXDHycZ1I1P9cJzZp6O0kzpv9i4WlsKZY+l29kSsJ42D/AwoJTT7pH+AgmVhEG7WNAjbJ+lnMUACWHSem6f0BlJOh5eDMyc8f2xCnD7qFMwdAuHndHdO73S6Uc0Nwi4UsOyKbp+/IF04l009FDVMl7cD6pAmBIzIz8rd7//sKDNJWddn5/r5y2yRK6y2Yyd/2F9yswY9GCt7i7y/OEIuWvpAzKonvEKn2OxDIsyJXxhnXpQk758kDymq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(366016)(376014)(38350700014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE5KSk9qSWM1S290a0VWTk0vempjQ2UycnhtNWhOUmZkdFBsaFI2WVdsemht?=
 =?utf-8?B?M3lvQ2grSjY5TmJxQWdCOXF1RmRYeVRpQlFTcVZ4ZmZJdk9aejByVTAvTmNG?=
 =?utf-8?B?MmhYK3BIUFYrT3BkUE5BVElOWW5rNVhaMGZUYnhKV3l6Y3FPMHF5ZDdabmhE?=
 =?utf-8?B?V084NWpObUVMNko5OTB3eitZUkdpOUlRaXZwalplSTNPczVSNitNVjVpY1RB?=
 =?utf-8?B?N1l4TWRiNG0vQlc0aE5iOE1vN2ZvNnBHKysyOGpTcGZxVnBvQi84blh2bkFl?=
 =?utf-8?B?RVdhd0IzSHo0eG1hV2YvL0VyWXZubzBTbCswdkZLeTRkQmhIYWRqMFlNUGxM?=
 =?utf-8?B?cjJybjF4YjljMEM5TDViM0w0UUV5RDcyL05aRnE5ODVzN29zRFkxTWNUN2NK?=
 =?utf-8?B?em00YU0zeXBTdTgrWjB5cnNQcC9zakx1Z2J0ZnZJaC9IbDFZVWdDSk9tNkda?=
 =?utf-8?B?S0Vua2N2VXpQZ3J3R25vMHFVQjNOM0oxMHlNSzhzVTNDWGZDTGM1L0lvME5Z?=
 =?utf-8?B?S2ZUTzQxYkZhMllkclgwZ1lhdXVaTStxckExUW1GKytieFpYWWxoMTV4SlJD?=
 =?utf-8?B?QkVrZzNFRDh2dkxTY2U0UjZReklnY2FYajAyRnFnOVZwS1puTEtVUElGdVp5?=
 =?utf-8?B?N2ZqWkxXOXJVM1ZhYTNxSTVOcGJ5T0JlcG1lYXBIWklTUndmK3B0SXBmeGN2?=
 =?utf-8?B?UFl6VS9FeWVMaVNJNHhoQXN2dzRpbWYzOTdQVmFoVVpmaUZPNWhkMS9UK3RL?=
 =?utf-8?B?NUlBNFVqUVgxVmc4ZFl5MS91c0l5RVFHaDV3Sk5oTktTNGxUWkVWcndFelZI?=
 =?utf-8?B?ZDEyM2Z6amk2Tk5pYjRIVFlTRGNybnNsOUlQZlJONW53am1zLzhuRHNiQnNN?=
 =?utf-8?B?OGdlQ3J2cm11YkRxOE5ibDY5QTN0ZjRwb0FaSjhqd1lSVDdxYTZqY2FjQ3Nt?=
 =?utf-8?B?ZWgzY1dFWGZHRzU2ZGhxR3BENnA0bFNhTnlQekF0OFVPK0FnaFlLVGFhVmFV?=
 =?utf-8?B?aGh5eXY4M1RPaXF4ZVVLeEsvaTZyYW5DTGJPUkZUTi9rNG0rc3VxbFN0ZWMx?=
 =?utf-8?B?bC8wWXVmVkVoZmw1V0NqdVRrUkc4dkY1clE4SHE5U1U4T1lnNW9MZjdiTHZS?=
 =?utf-8?B?Y0pKVWVWVm5yV1R4dUFIV09qTlF4RHE3UXdxOVdRcUo4dC9IQ2ZzYmlpTE5q?=
 =?utf-8?B?SWNMajNDbkcyZTQ5Y2JrWlJKMlFRRUxycy9SRVRHUEFRS1Mzc3pYSU1IWkZy?=
 =?utf-8?B?T1RiNWFVRDRiZ2FKdW1zKzg2cldFSmlucCtEYnhPUkMvdW1jKzF6REhZNlNU?=
 =?utf-8?B?MUgwRWVLampFZ2tNZVdjc3BWWTFQS3ZWZmtpNE9IRkRYNHNYMVFlUW9oY0lX?=
 =?utf-8?B?eTYveTd4SG51OUxCT21JcmtjNjZQdU03K080ZXpTOU04VllpR3BIL3RObjNF?=
 =?utf-8?B?K0hkdkYvTXRhZ09LNWY4M0FoblAyN1lKMFI4cEFvRWd5eks3aEwzNnVpWklO?=
 =?utf-8?B?R09NVGhJYUFQekh3Z2pob1BhdHV6SVM0RS9zNGQ1ZzZySEt4V1o3M2NDL1pw?=
 =?utf-8?B?TTdIMkgzTVNaSktLMGp0dmNKQ1JGQ0I0a093UHg0aEk3cXNDaDgrVWFUSWU1?=
 =?utf-8?B?b1J1SURsUW4vMUphUzdmczNVU2YrcjcrQnlOVFR3QUIvUnB0OXJzcHhoNDBN?=
 =?utf-8?B?dXZZa2ZHcUJzbHZTcjRPNGI0M0pXTDJLZWFSYlpScjJnQjZTY0Q2L1BUbkFT?=
 =?utf-8?B?Sm54NmNudlJQK1ZCV3d1Tnc5ZEdXZTZXdFdvMDhmVlgxaU5vUWdPQWpWeUVB?=
 =?utf-8?B?K3VucndZRy9kWlJnYTNHSkRmamNOZDdGcEt5TlFzT1M5d0RJOFBLQmdhQ2FU?=
 =?utf-8?B?UXNpVG1TVGdhUHNvLzg4UURod3hZWDFvVlpTbTZPZXNVbC83d2p1eFRpSDFi?=
 =?utf-8?B?QSthQkw1Y0k2ZytKTDdUUnI5SFZuM2RMMHlnci8wc0VNRFZiQ2pBOGkvVmxT?=
 =?utf-8?B?ZlpqVWpTTis0TmZzdjUrdG0xb2dIUHdOY0xJYlhkbHhDZGdMN3BKTHVsQUow?=
 =?utf-8?B?MHlNRWx6OEx0S0crWUZLWW0zNzFhZjFPMUViS1VCMVlZUTc1NkhRYWM1amN5?=
 =?utf-8?B?UjhhZnNOdVAzb1FHblY1cjk3TEUyNzVHNEUvTk1EK1NLczBFcktqRHdUWW5i?=
 =?utf-8?B?ZlVFVlhNd2lpcHdiZllHSStYSFZNUGxaYzNiYldKU1FXam1GZEI4aWhkOXZZ?=
 =?utf-8?B?Mkdvelhwa2JMQkxWbkUxOEJMY3RPTjNYTXhqOWtpUjJJTC92bWpDQmtaNW52?=
 =?utf-8?Q?ie++DINmvLeIuM+Cas?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1eacf0-812d-41fa-387b-08dec2061999
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 06:54:18.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bx9PI3yTpnGD8BPukv7SBYp9O8xN87oRuiw1MztDr3+KraOdUrjbX/2nwleFVFkZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

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
index 954055aaf6e29527f22f8129fd47ca17722e2bc9..748196fcce75ba7192b1ee5fc516bdf4a9ae074d 100644
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
2.50.1

