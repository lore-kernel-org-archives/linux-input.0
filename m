Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8183C5DDE;
	Thu, 18 Jun 2026 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767749; cv=fail; b=nbu6A9076Sasdbp52a0IOiGgYvbnFBcGE9cEZIK96nmV2IauobymAYptzlONs7ZZFRN7UIG/3w1lDARkNb5MZ/hZVtWwiWN533/WWH8l0l7jLlbKqJ7reCNc6/zRVeR5k4qNBfyz9Wz95088vzCFLLCQw2a2SZv4Ttfo4yFQNrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767749; c=relaxed/simple;
	bh=1TgEMXeErXhfxxkfRcE+2U0+71rxx3lgO7sPW1apzgw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=foBFD4ZhIU9h2MSS+MO/l0CWkOvTg3M9pwhf2INswnTUpLxf9oEW4b8L3T3gFo4EggrJaG6bCgWBp08QNbay/DK8Rwj8lqN7baVIoGiQzHLBiHlWn8t5K4LpDQwWgUhYPmKZ4EOjzPSDyRDjIq08NRaqCYLWcmrzIstmz2uK0jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=c/txdbIL; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c/txdbIL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuASCeFhAd3CYW1oDrhccBWPVjeFVgqdTAwYh+sdo1QxWAFwGg5d8aDeDoPc8LY18JJka/FpXmFF6PqyZ6yaQTWbHnLCGnDUnDG91TljbVoRGhR1X/2BD3cnm+u+Sk62B3oe6grVsa2dLznnieuQd2AvMe2SEweK+OYRJe1SIZ5IcTLQ3yDeZU2RUMY4F6vfDJN78p+QbHTJajMNwBh4J3Gc2UK2jPMlE0dbZ47A2mwQzk8UD5KT9IB2/W50X1qdh01W7HidVbmsiW4hMwZro3MuELpt+zn6O4/Ll8oCW97wptJvnlUhah72L0ZYtddAN8moFgXngXYDIcnIorUAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne/4HzlJlC6FYrTj5GTrfvcfH6cHDf7ZYARAO6wO3iM=;
 b=CUJ0AkD+viuC9N8sq6k6kUBZEcLZeiLuTOE11D3aS7BIo9q26aLVgNcvLForjacJQol1leodDVhNcuunQP8jrvUozhKYenQGpENRRKfAGzIU161Q2/w+DayDRi/qWxLExVlcTYSLyJc9L3Efxize28RPZbFVl8vgw0WegqPSb1k5vzAOUe/25haiaRawpSIB7HhnF46FZq7YdHrCGKByMLNwWxUuI1+WrlX8nWryFKWQ6wgoCtHF3uZxkDOmek/86dEMp1qs/kTtYUyWBJciKLltttRhcX7QXHsyeveFpTh5M/5U+AJ1gjxAJljZwzX9ZwtnWqkzfmRjRzogBpDodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne/4HzlJlC6FYrTj5GTrfvcfH6cHDf7ZYARAO6wO3iM=;
 b=c/txdbILuAxP8w8XaV7rAO8Bh+nSt+DqGSnzTORpoOkY5KS/qJpWmrRtfH1bpW+4VLwShYsya4jn8A7fqD0i1VdM6Sncy3KSft5rwPcihTOKClbw8NlQ5MWMDfhQcj1lpnL8n55eXkhgG7gd8DT+46UTm7uS1H7ohMAKtDaLJz6tMlt0K2q9OpxGcTm0HTqGqIVrvcRLJjiEtaJWTZH/HUU/u4jIj86YVE3syaiUz8nsg8rRw1b6Q5LkWGEpIrAFUAugUoiICRTA4u49IlCXMoXTX+4deOSuoCjCBdW0vQ5luU3+txV5lcjpngbvwveq4/bNL4zHP3VX104+aMSQiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PA2PR04MB10157.eurprd04.prod.outlook.com (2603:10a6:102:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:29:05 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 07:29:05 +0000
From: joy.zou@oss.nxp.com
Date: Thu, 18 Jun 2026 15:31:46 +0800
Subject: [PATCH v4 1/4] Input: snvs_pwrkey - make use of dev_err_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pwrkey-v4-1-4bfda105bdf3@oss.nxp.com>
References: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
In-Reply-To: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Cc: Joy Zou <joy.zou@oss.nxp.com>, imx@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:4:297::12) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PA2PR04MB10157:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff4b84e-4c70-4db2-9796-08decd0b46ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	c6cLwD78dl4tgwiC+ieo1gNV0TBiTkcdK6mFvtF4mVDIiac3QzfvfVnkRc4vjZKHm8e2qxB/VYGdpRMIjTcxykCnJhhu0NjLyJgWo73KZBI657RukaRf3rbPfe2wepA26LCXZwMNDfGfZThoZ3MiH3F2rsrcP/2N4jcHVHhrnxw/Aiq9XJSPhgyHFN7gnnz02R7BTfUYDZq3PHXsDfbr/4Sc/9v2n9YUdxLVyuIo9CTdTm/JcH0eRcnFJUMAPMRarc0+nOrDC9y2AeM7KnmVkOofcnhddEhv9u3h6Vsyi8wG4tz9seQRlpKyKnPvpRw/sBBqRpEElSU6FHqptIYooTMRPtytbG55xg5Vo+TfGOI4oClnhws00HWK9WxrDtKRMASHRCgN16jlNDPO8a2dYzunqLcl5ntxsQT63c1Gr5E3vHz6xoVM/VeF1nh/pkYkol/nkMe3veZ05IRyl0ZNWFLJs0LqXkPVwkiK5B6UIbTdvAFPCV/r8bOMqc08ipHS3Ltd2pxff+zRr4Nozx5FiyBnyEVRrDZNkMGrhPmucsiGtLgcbBrXvWbXtdAjfX/2aiC2GIir6SiS+xDJyXOv7or5MHgS8EnliTQBjseZC0s8AP++dujr34Nrkhb7lCVeqfYJA70Us3jXXcBs124CC3mDveQr+MatH3xxa4Kq9n96cED+Xyci07V4KStSzCcA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alcwYmlDbWI0YVozbkFNbTUwcDh0Y2wvT3BDNmV3Z2JCYk5temlIVW1XaGNu?=
 =?utf-8?B?blUyeGs3MVJEbXpWM0ZkSmN3N3VmczZUWVBDV0hHNmZkYVluM3hheFlFeTZY?=
 =?utf-8?B?VGFRU0hJbnhWTEdmUXlUeC9WOUQ4NDdWclpXYlhwWWRHOC9KYXQvRUJzVVVD?=
 =?utf-8?B?R0VRNzArSDVwQUpld3ptb2JQbjA3cWJyM3doVUVnUEhHYzlOWE5QK1lhRlFn?=
 =?utf-8?B?WUNaOHZIUGV4M3QwSTdLVFd2K01xS0lxUllLSzl6VGEzdVd5S2VoekV2R2cz?=
 =?utf-8?B?Qm1PR1dwdXZzdUtLVjNzWDE1b2hiVFliMmxKRHNFY0NpTEZhZkVXTk51STU4?=
 =?utf-8?B?RXJvNzRnMWJUeGVrY2hZTkZ0QUxGSm82eVFQU3ZVWEkrUTJ3NUJocTZnd2N0?=
 =?utf-8?B?N2MrSk1IRGlsTUUvR0xYUS9VaXhtYmpoOUU3NEFxdFdjOTc0bGNpWWQrTlhO?=
 =?utf-8?B?VjNQQlpGKzR3bWpaZkwzOGpxUC9xSlBYKzluVW1qbmFXT1RqdWg4QkJ5YTh6?=
 =?utf-8?B?WWp0T2h3ZFNCWEQ0VVQybmlYNGdFWmkzTSt3cUprUUxsZ2RhQnVuY2lvaitT?=
 =?utf-8?B?TDBwd1c3WmgxRlF0MVh0ck5jWkUxMW0rTUJnRGcxRmJPTjRLTFVaeE82cmtM?=
 =?utf-8?B?ZkJaVHVUZVlwOWVwajROd1puVldrbnF3N1MxaGpHVDF2bkV3ZGwwMkpUNmMr?=
 =?utf-8?B?cTJhYkVoYWgzTGZjM3dJTjk2a1J3OFFGVklEYW0wU1NyaG9HSmI1MEFsSnI2?=
 =?utf-8?B?WkowSVVia2RjWURCckErSnRQTFBUOVN2ZkdUNWVXVS92ZFlJZFNFcTdpNDdN?=
 =?utf-8?B?cm5CcHZIMlBPVXhYL21selQ3VllTTTJzSGZwQU1xSDlPOEV3UEtWUjJLWFBq?=
 =?utf-8?B?NTY3OVNyOFJoaUFldUE4bDNkNXgwRHpScTc3SEM0VWtsb3owRHVURjRPRmFS?=
 =?utf-8?B?SGg4NXBjTndGZVRodVFZYUtaK3dPaVNDdklEclRMeUtmSlNRQ2s2QjJ5YW8v?=
 =?utf-8?B?a1hnNXFNcWZGY284b1k3dHB4VFA0bVBScXR0OGgvbVlnMll3VDZ1ZDdBZkY5?=
 =?utf-8?B?VWh2aUk1b1pwak1lcGJZZFdseWVHMG9JTmZNMVp1eDZidFg5cVEzN2FqYnpN?=
 =?utf-8?B?RGJadDdWMEpPb0Qzc3pyblNGVE9aMW9uRnJsNlVtMXhEZ2xmTVg1dFhhWk1N?=
 =?utf-8?B?Y201MFNFcDNqMXBXblQ1aVFyOXA5cnkwOWdacnlGdW9mMGFrQVExbk5mRDAw?=
 =?utf-8?B?TE1qZWVtcVZtK2ROZFRTc3BRT0FtZ1g4K2RkMkhoRWt5YUJnQ1FCMWNVZ0NB?=
 =?utf-8?B?WWw2Z3o2bjJLNDhNT0ZUQXdnek1JU0hvblFzN0ZKRFMwMXhUbHlhVy9FWmx2?=
 =?utf-8?B?Y3pyczB3TmRFQVNMbjNWaU9naExnMFJKc0RGc2dWVk82SmtvR1Q5Z05RR1pi?=
 =?utf-8?B?TWUwUDZLbDBUV1YzMWRGanFlYk9lTE9TME1iVmUwaTlTN1huQi9EYWZFdDFK?=
 =?utf-8?B?UWNsTldDaXdSZCs4eG9zcGczRVY3UlUrNmdGVlRwc0xCaUFkSnJ4Mi9rWFZN?=
 =?utf-8?B?OHFMbDNRbWg2endUY244RDV5YUNwZm1tQU5xSzJkVDFsVlVvOTE4TDNhd3p5?=
 =?utf-8?B?WXJBUGFGVGNMY0tqekhhdXMrUzdzQ0RaLzJhN25hR3ZCV1VkMEZGWTZUalRj?=
 =?utf-8?B?MFRtTEZHSytaL3J1ZUdobVNkeTVHNm9mTFgxYTZVT2M2ZnB0ck1vdEJWbG9q?=
 =?utf-8?B?YVdLZTNmSkdEN3NMdENuQmxSY1A5aERiazNleVdUN2EyYVNIV3dZdmJkQ2ZU?=
 =?utf-8?B?ZEl1MkhKUkhhWU4yRUhmOE1aaWlKNVlQZHRZSHhXL3ZLNVRwcDdnVTczbVNz?=
 =?utf-8?B?dnNRM0JzbGhlYWdpUnVqVUh4UGNOWnpWWXVkcU85TmFUWUNxYStJaUUwQjh4?=
 =?utf-8?B?M29xZmNGRGl4R3hnUzg0Z0l6YS9tdGhlbGI1RVpaTUFZM2dzZS9hZWszU1Ar?=
 =?utf-8?B?aC92RmUxK1VNTkpoSVhCUnZPYTNTL2lucUxOSS8xYTNyYWdpbWJ2N3J4anRv?=
 =?utf-8?B?TjVmRnRsMHg4eDJvZWtDQzhxL2dMWWp6c21RQ1lPNUNHRWovbEJ3bzlyMU9n?=
 =?utf-8?B?bC9XS3B4eHF6aE9wRERtcUdaRnN6WGpua2tsNjhTa3RhSWxCN2FRenpveHZ4?=
 =?utf-8?B?ODJjZkZmRlpTU25xQ29TSHpPUXpXbCtwSEx0QTlCMXBHcG9WbHY0YjlqQlM4?=
 =?utf-8?B?TThkL1MvU1BrdVcyQkprZWxyaTJ0cy81WDl3bkxEZXI2cENJQTl5eEQ4R2kv?=
 =?utf-8?B?QUhROHEzcUdSTExXUHNXWDNpNmdNQ2NDWUtKR1ZNSXVycmNmTEJaL3RLOWk3?=
 =?utf-8?Q?L7QdpJ/NHrEWGo6qE0uKxV5CGo+XFvrca58EN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff4b84e-4c70-4db2-9796-08decd0b46ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:29:05.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD80zglDJ139E7GDizyi53sCY98E/Hu5wj3x19OVw48ZQrHk9wKrxb1ClQ5Zya+Xq7aU+QQ4V7ETATueygQWA/EZRvcxFqZgvDPmnHCm8FBNQcbleeJWvJN0ljEjVFdy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10157

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

