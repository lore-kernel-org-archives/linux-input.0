Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9C3CAE88;
	Thu, 26 Mar 2026 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521501; cv=fail; b=O7pVbSCVRTSQ1Zy2wfcEZ5krBNdFeeVmoXUIPXpL8t4szSCnFfP4THl/DGNXWJ1oq/O5KQJR+nbj6+V5HV6bk6kPsYWdwfIh8B03RB2gktCuqBYt40SVs0XJIW2DOZcpK22PcqBqSYqiqPme5HAsdU6dpFRQc7wO9ClHAWzW+YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521501; c=relaxed/simple;
	bh=Lg34Loc2IzMBgmcRsR3x66hbgXZjdoUeKEYFZ12h848=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L5r9Rsftu7QXmZPUk9XJpp44AaUetHdxUOcD9O59tnKzXkP2RASZO9a4PvI9jh5gigBLEJzRktacy5xVmZsh4yIm7LYoWqmUA5pq7Idvcf9ID+nGysd0W7P2gdx6oZLtpDXAY0tWdYe76qr0Okv1gA/AhIINC1o3ZPh9L40f9q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L+2uLz/4; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L+2uLz/4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9EA9ekweW2QqhFDc0ZVOBmsIuntmUS/WLVm7OFo8L/ExX6swG7Gc/XVVo2fy4auN/mCW9l3LQtao8+xJFBSKxBloShn1EStSU1g7Wd83hr57F88QvBS6QBHC30NOH/OFOCJpF431uOogEWP1MrQNalnVsm/QHUyCUANSM7cFI4i+17ibDjrZy/C8pS+rZyNc6K53kxv4HAXCFDRU4l0TF4KL1MwIhQjP/uK50or6lajomamPdM/Y8hYEV8lyALZE/1y5tpKGQGxKgTjZ06JzHYgZX7clKyHrck0/BypQmByKoDnWRq4SWSXFtV6N1400OrpEhYXgx5Kb6Vl1wpX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wMaDFltvv8oDCq+hkda4xRbFD+YWCdXW80TqnKfKWY=;
 b=kYDu8GrWRrVj8bnRdKJVmejLVn214mdDfGV6WalQwC92Mq0VQTKJuJdKZSedFpFXUcAeL+lrWPCQVYpsbo7fMPkqOShB0d4nyg5V6o7prrCgG+ukOyCyc7If0zNN9EYdmvF7+sEIE7y3lE/2PHXvO0UPmht0S5uCVQvLgec68/tB9nrqNMQ09zwpKNY3lUxsg+C3O6FxIXLhMhUWdYSjA2qHd8PNwPqNQ9UcTjw4n9YM8Qb9MIqxmTMGeXS9GXFrj72EGUk0pilc7BNxMcvVbvzqRXX1kz8WmLKzGb2t1mnIUXTOxpjrs6NDx5Tc3ADlv4lzluyhXAjJt5UfPaErtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wMaDFltvv8oDCq+hkda4xRbFD+YWCdXW80TqnKfKWY=;
 b=L+2uLz/4rlKfb/fI2vAMi2mdMWu9QYTKSempAs5mlzX/hLjiVTynDG50Aa1VQA1swiasdtakTjyEJS4oMSAVxPkZeSSkH5vG6Ey+FJ/SrFHbdztDVcIficPk7hucYO5afBP6DiSU3btLo4XtGLu4Y5fMlRVybj1Vj/D5ibHhFVi168ghVxtnJcamQuy4RCm4SOqxb5zAjvQkoJwNhXpyZH78ORoc+PbsKuHCACHFeN2MY+GggkCiWspo/JfTsQfUuTttssItdLXSLW0TBrW5pLiHRXT3hmX8I4kAze8+lU6vZ5y69XcmKSpY/0NbvgvTRE/qyAJqIBqq9im3+Te8Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB9006.eurprd04.prod.outlook.com (2603:10a6:102:20e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 10:38:17 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 10:38:17 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 26 Mar 2026 18:39:39 +0800
Subject: [PATCH 2/3] Input: snvs_pwrkey - use local device pointer avoid
 reference platform_device pointer every time
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-pwrkey-cleanup-v1-2-d85d7c0bf275@nxp.com>
References: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
In-Reply-To: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>
Cc: imx@lists.linux.dev, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAXPR04MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb113d1-1535-4aea-9476-08de8b23ca75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f6WYiS9DBvLvQ8V9vO6HQp+cug+PYDBun5aMkKCQSpMmI1eqfN6/jd6ccgyyY2QqEdxyhidVQDRxNb0NcEOxK4f9oATSbXJ/MZhVY6mst9ce6TXQHdE4H0COKcGS6MH+a0Lxq7xVwtwdOi46QjlG33Q3tv7R/IgODTSmDu4FRZ01BZVihLS0TyaRBzo6cwj4VrN/b8VFfFwSJ90HTPjUP5j5fOz1o0llo/3IOKT++wA+mm1PQJ6mgicFKy8Ra2qeXUHfFz180m+M1UayUX8S+zlLOayPfNijG3t0kiC2ejjLCcyGKZqGwOYUNgEaZV+xjz+rPSK/WJysuYTbhMl7PNfkIzii54gsPmqalMECW8dcDrYpqTDxNGhFljhrZpNTCH2SqDqNpPV4RQWXTD/i/gh2PkbooMIoMCh84hJDakkBiaymI7zVse/n1zPRN3Kk6XX5/+OCylsWgQaEqquOjY6RWlMpkorSA2z1Ntbjojtc/Ns7miDJyq8kqQJ6aT5irOknlDW/AnpuwU3gF6IaEVZOIs3CLmi4lUyFpYw+eGGTy40NeYa5toIBBwEOtSfPrPEjCOMq3Rl/KozPuJkGWaGe0ISqakfYuURdR2tvt2Vsl8OKn8WB9IGGLOUycaB4q7DgQ69CxGJIUhv4BaiIaOdsdXiy2fYTQynxxmzWa6ZLuUlKa0T8tYOBHihwwCgl3mdSIux++COvfuaJY+41lXdKom/d992b3yn8rS644lIMpSU8T/oq0Xve4C9u42ogADAOoyvLLMHTleN1AjwZBofTIQbVO0owUrv1xN1F8yc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M08vSzI3SjVWK2kyUURjMFRXeHlTZW1CTkk5VEdNMEl1Rmw2aGZHdnl4OFE1?=
 =?utf-8?B?NkZITHVXQXhEdEN5YVp0eUoxS1Y5UE51ZGpFNVVQNTZHZVFGTkFqUmhub0lj?=
 =?utf-8?B?ay82ZDBFSjdLUXdlVW4xZitDekJIU09tVU1oeFdIUXFEOVJLeEtPbUhoanR4?=
 =?utf-8?B?bWNJdzE4d3JKbWZOMWZkOFg5bnRxTWF5Nno4SnhRQWRGZnRicEE4UHhhUUY4?=
 =?utf-8?B?aFVXcnloeWhQbHp0MWxKajlobGZMNGw5L2M1eWZQYWJPcm5DcWhmVDlhZ3pa?=
 =?utf-8?B?dUxlMFBRNkJyL0JjaHM0ZkVkci9yQ3BrSjdQZEE3WWx5ZENzTUJzdjFKUEJ6?=
 =?utf-8?B?dVBnQm8zM2xkYjBNMXYwQXNRZkVQeUJOOXBGMWxVRnRIQngrUHc1cmtUV1VE?=
 =?utf-8?B?TkM4Y3FmQTlwSjJJcDFVQUZsL3Rad09SanMvaFR2VU5MSURIWUFhSC9LdUEx?=
 =?utf-8?B?ampCSDRhajRhWDhXYk1sWG9FbHZ3Zkhkd0lnRll2cFFHZW9vVW92U2JBL0ZZ?=
 =?utf-8?B?S1RRNGRnL24vaGl1L0tXRkZYb2JwOXhYRndhLy9DUFNCYWFIS0s2SmhYZ0Zp?=
 =?utf-8?B?UjA1VHpCWlprVWh6UHFtQ292N1NZR3lPWnpqV1dkT1FkQVp5UG9KQUt3QlJK?=
 =?utf-8?B?czR1SlRmdEovU2VxcWZQRWkyNnN4UFhKbDdXWWRSdnlFK3BpTytiS1RZRXk2?=
 =?utf-8?B?aVk1YmxrOW5JRk1Xb2NDeTZPK2ozRE90MnFNYncybEI2bVZVRktOeGtKTzNK?=
 =?utf-8?B?MjdJZlVjbTB1amRXL3dUNTk0akl5Tmlmb0tqVzA1Mk1TVmhqN2VFcEdEeWxs?=
 =?utf-8?B?a3hpamRmZHd1QjNCUDAyc3Zud0I3akE2ZzV4NFRWN0w2bnJBdDVrNTJlZEgx?=
 =?utf-8?B?RGRTaVJSSTR1NFRSQVdIQ0crK2hQaTVMRWpqUFlhZTFBT3A0RnByUG1KSE9X?=
 =?utf-8?B?S3RQTVRZdlQyTy9ZWm9INklpM2xPb2ZONDFZNW1hdHlrRVRqQ2JKb1B6RkY1?=
 =?utf-8?B?Z3I2UEtSWWIycGM5WW05cDFteVBsd3VmZDN4Y0lVUElRanMrUXhzS1dOUnhX?=
 =?utf-8?B?K2krcld0ZDQrRVZvS05QQnVpbWF3Nm9WWS8yUzliRVJOVEZldWFSNUsvdVhy?=
 =?utf-8?B?Y25IRGtHZjhVZ0JkZCs3WXRGYXFnMFpidlRKQ1J5V2lseU5adjdCd1dyYzhx?=
 =?utf-8?B?OVJkRGprV3pJWTZ1UHhxMStwck5SUkJ1cXdma3VYTGpsNWV0cXlGamZZaU1j?=
 =?utf-8?B?amZFbzdtL3NQSmFjNVc3SnFrL29XYWxpR29vRW9uWEM5d2doK0VqR21zL2pN?=
 =?utf-8?B?UHVDV0pBZ3JKcFJhOGRKQ3pGaFFHUFZBWFJ4L3kxMC9CTmE1M2EzV3JzTzh6?=
 =?utf-8?B?S2Q2c0krWHRraXBZQlVFdXl0RzZoZTdPMjdJWDlzcnNrUm40cFREV2UvYUFq?=
 =?utf-8?B?NTcxcGYxRlF0VHZrMngyTGpvVk5DU2ZJcTFwSi9QeXovZnZLU3ZTSnJoOW44?=
 =?utf-8?B?S0lDQ1NHbnFYZzJNM3Q1dkY4dFpGZzl3UDh0d2RzMU52RVkwelJycjhzWW05?=
 =?utf-8?B?QkQrblF0RFgxQ0J3eHdLeDJSTi8wSlA4Ymtjd2paRWpsbVNNbWVybHgyQU9B?=
 =?utf-8?B?YS9pUldjUDVuUHpQdVl6QUxkTzdLQ1FrbWlpNUV0eFJtVU5qdUFIbm1wVVJN?=
 =?utf-8?B?ME1iVmw4ZlMyVUN1bXhEZStPWS9HVS9VS0NibXlldHErYUIzWWV6am1ibC9j?=
 =?utf-8?B?S0FlOTNLdkowRGxBcnR5MXMyM21KRjB4bytienJJK2RCWnhHNjJlNFlndTFw?=
 =?utf-8?B?K0tFZ0RJRzROYXhZd2dIczhZS0duaThPUzZwcXdiWnZWYktmOGpHTzhkOUFy?=
 =?utf-8?B?cWdRaDFtbXEzdzNQZGcvWFQyTnYybERTLzBoODBjbXFiSEp2SGd5aU04bWVa?=
 =?utf-8?B?RTRETGFzU0tiSlozRGROYUJKbEFGZ2plUDkvb3dtWXhKZVlmaEdoRTdYVFVV?=
 =?utf-8?B?Vlh2NjFkd0xjajVuNXlNK2NWYlhvZFgwNi9UMTg2czBMVUFJLzd1KzRaS054?=
 =?utf-8?B?TkZUYTIvTWdYVkwyWGRHMHIwaCs3dzI4Y3FPR2VSUGZvL3phNzFoV2piYzJz?=
 =?utf-8?B?eStPZjdaaVd0enJJT2FUdm9Ja05EMTAveU1VOUExZ2hjWmQ2bmpHamV1elQ4?=
 =?utf-8?B?dFZoL0dQbCtPck9ycVRuMkFMa3hkMjI3aFN5bnVCNWJxRkp4Slg1MmlJUGRv?=
 =?utf-8?B?L2JuZWZ2L1ZvbmFDWXlBRHl6N05tYlc1b1gxaXplLzU5SGlmNXBzTVhCMy9D?=
 =?utf-8?Q?TlIWbr+omDzJltd/zL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb113d1-1535-4aea-9476-08de8b23ca75
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 10:38:17.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/hyDWsDal/KEjh9McEuNFCM/t1ZeXldtNamSmOV/NXIb3npiplebA0klMY7qR5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9006

Make use of local struct device pointer to not dereference the
platform_device pointer every time.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 41 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 836ab94c160615f4b0f645d9b9f85d54638c2624..bab3ab57fdac77256be75a080773ea99372ec9c7 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -112,6 +112,7 @@ static void imx_snvs_pwrkey_act(void *pdata)
 
 static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwrkey_drv_data *pdata;
 	struct input_dev *input;
 	struct device_node *np;
@@ -122,33 +123,33 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
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
 
 	pdata->irq = platform_get_irq(pdev, 0);
 	if (pdata->irq < 0)
-		return dev_err_probe(&pdev->dev, -EINVAL, "Failed to get interrupt\n");
+		return dev_err_probe(dev, -EINVAL, "Failed to get interrupt\n");
 
 	error = of_property_read_u32(np, "power-off-time-sec", &val);
 	if (!error) {
@@ -162,7 +163,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 			bpt = (val / 5) - 1;
 			break;
 		default:
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "power-off-time-sec %d out of range\n", val);
 		}
 
@@ -182,7 +183,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
 	input = devm_input_allocate_device(&pdev->dev);
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
2.37.1

