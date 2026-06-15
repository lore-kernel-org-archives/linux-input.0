Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E335AC12;
	Mon, 15 Jun 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509796; cv=fail; b=egVE5NVttpafKzK7fbJorJu9rVfZkTvAHBp+oz2nYZLT3uV1rQ9BCQsUVpSIhv6b/K2pmZg1oseqyqERl2opr2X2JuulcHDx283wzwNrNhxat8hVhleqQtv5+BaOodwEZS/TjlAiUKWc0uuxvaSJS7E6pi1Ql/xk2DAug1NR250=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509796; c=relaxed/simple;
	bh=xRt4OuqaHO4sPMQcmufQFQ8UUxIuqcY3wfmQIa40g08=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X/wt9qlwBb10uQ2Z4vowauKb4ZypHSef6g6GNCW5Ewgf5eoJcPZOfuvmjAn0tX/JIOVS0KapFA6+chCZSQX2045DM1qn2TKfydSAynxCqgJh8et4SujN74BjdEXz3/fiCtT4AsFRJyaKeKJJMG353sWYROACLcY1uUjzDcoZbdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L5K/ZVtm; arc=fail smtp.client-ip=52.101.83.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L5K/ZVtm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub1ZfQhZUKpomK3yUzMVYDlTC1RA4HOxSGukRC/20W5lPKyPZ4331csD69G6Q1G0MrW9Ff52omkE7YlHKPvA7dv9g1yFF7TGMiEqiAwr1w2K75RZonWvtQ3iirEzYkho6Ea3GUhTqYp4er3vOGhOvhi1xu3yai5ZryukW8PiPwKm6gOFzCEQeE0H/Z9jozsFwqNIjWnAZhas29P7wreiBERtkKicvPpmxvyjgSyjErH6HFbBmSsIuHgb1AvJPZ4OeDOzh1Vr15SN8+hDKqLY7v3KpIooz5n/Fy30jzxqIDmGI5NFGV4eCWLLQdLhFJPjFkD4o+IdHNVMqME6AdMJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlZZs0hg+Nwuf+xMgeEDwJmkokPF4LvX6CL6//vT1IA=;
 b=and9ck9Xmg9rga6mRxQEntARMfzsgG0RjggHJy3MsgBF1796yFSW1Q6wHOnvtGDSB94AychKlrW7oV+VPKwwN6AfxKcRdXEbPm5/dyurMq32WL2C0Q8crjq8bVXs6shBCEopEzUc6es3dNq/JkR4w4lhCMIU/AOMUhSTJl+SufsIBOU8oyyz83XFb3hNoDGC7hyPXPqtn78PjbaYLh4ZUu0xdZWzalZ9RcWNyJ4/+2j3L3r/heeGjt7/svvi/xAWCaHrlB5UYM0KxREoorXKDfNKq2wCSFFYcXlDeTrnLIw4kI80nQY9jo9W/kw1Yu3Ys77TeCplvTmx5C9WaHDs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlZZs0hg+Nwuf+xMgeEDwJmkokPF4LvX6CL6//vT1IA=;
 b=L5K/ZVtmTeiYSM6Vq9WX3ff+Hpps9iStAp3Vk8Cjyhhn96twRBnRMq34LgBUXL+1/zkR/V3oT+QnFTisjPWGDO9WD3msagMINbHgK+vorU+IBaHM8LjzmMYUlm9SXHoX1Jxg9QOXG7TvR01ySHvh2GF4HHV/EeDZnwPI8pHGGL9BpjIeAB+mjbRtVf81KDFOZnLTIhCSDVY//AVVjD/FzSQ55BFjtQaOOXwCX9Dx9cltMPOxQkQnSqKv8/ty4adk7WyMfHJy/X3smjGKIDAKyAj9/sTuXxe75o/HjKCbo5UPul38Xf8l/ji2IVppSvxzUhIQj4vLt+++17H7M1G6RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by BESPR04MB12586.eurprd04.prod.outlook.com (2603:10a6:b10:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:49:52 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:49:52 +0000
From: joy.zou@oss.nxp.com
Date: Mon, 15 Jun 2026 15:52:16 +0800
Subject: [PATCH v3 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pwrkey-v3-3-9510b1173f6e@oss.nxp.com>
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
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|BESPR04MB12586:EE_
X-MS-Office365-Filtering-Correlation-Id: d97cb4f4-4d22-4e9d-c412-08decab2aeef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	NJKCovzXLAu8RZDQMV7AEHQAZ1so5z9VHQcjm7kJjlr3vQVDW6RBud/u3b3yM2P9oEvQrtFlM8iGQHe44pnSKMo+v9xZq2AEmJRfIQcqQHxKoWJW7fXLG/RRLu6lWD0auc18Chf3Hj7kn3YXC6+SL1t3dI2AH/VObhHX/WUIoV7fDE6R7LX67t9lIauxwLkGtGhS8o5fmR6mG99oiOpTJXPDpCaD+Pz0Mo9/PP1RmX8XrbTgZ4tWt5JjsQ2VMK122pLIGrMUqwYtMTv7/3l2Oiov6HyqR1PCM/y/TOQjdy187LV/+1Oelpc/4ppnZucXzeKe89WyQq8+vp/NBEoYIbKtWuyB/pkkodDm82kZqSTs+DhW42RjrBFLABXcP3aZwtwPbZqzMANyQWW+sq5qFhX0nKotR84o6rnRKQ5zm7Ynr3cW8x3ifiK9uZHW+GKfujL92eb8/v3nhHEL4RiDwEeJnfY5CmFTwFnmgFqp/kHavpc3moR+L3uZcgGjz2czgyrfADiA2KUS0PTvBEXPMQNp6gVFuE5B/n5IHazwQ2fUeKERq7bPF1m1wCwvZINELPADAKK8KCUayLCI97Yq1bXmjgFR99y9rwBBE568ULyfbjGlOBEWUembREl9r12LzHDvMRC+/2Wng4gc+6q95W3NVY1Fg+fWSGzf31I2A5SydLPZh2TuNYKIugJ39Os7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amJOMitSKzFHQmV4YlRhRGdkN2FJS1ZpYVJ4Q25rd2NSbjVQa2MzNTdnaUpB?=
 =?utf-8?B?M0dFRjVQYndMS2I0YlJlSU5UMTFhWmFjUEZWMmh5MUhIQkRadmJqdzZSYUcz?=
 =?utf-8?B?NFdDUUVHazB1RzRtU2ZzaUFMT1BaK2d2TVFWc1VLQkg5c2ZDV0FxbXlRMjFS?=
 =?utf-8?B?Um1vc2Jhb3Fnc3c2N0Zmei9jd0xLcm1XUHNEU2R1WlgxamxmWUx6aHljQUpH?=
 =?utf-8?B?dmlTMjQzc0pKdm0rZGJhempuM2loaXJkSzRkTDZmNDhNUUZEaCtaSGhMMW1O?=
 =?utf-8?B?aUhES3ZBWnZmbEJ5Ti9taG0rSGpncWVuSWxITHNaVStmeURNNjlNaEZGcGhZ?=
 =?utf-8?B?MGFwa2t3WHRqYUtPNEZQYW8wZkt1YXdHamZpcHV2SWRiTTE0dWJZV2I4RW11?=
 =?utf-8?B?WU40OW11OGtyNmhVU1RvZWtqM1dudmdGVWN0aEFVRGJuUUZQcWJFT0V4RHFp?=
 =?utf-8?B?QXZta25GcnZZUVVpanBtbTNScnIvSkI2K1dKVFhtOUpUdkg1Nk9BQkhSekRv?=
 =?utf-8?B?MzRNNmYxRWtEN0ZvRHlvSVRFMW9GcTdVV1FNQXlJSjRUQmNPenpTbEt1MzNF?=
 =?utf-8?B?T2thNWcrZnA1UDY3d2piVk1TZXU1SUh4YzRlMzl2RktWZmlBNFZKcml3TTdi?=
 =?utf-8?B?ekNDM0VMOEhGMkx6KzRKVkIwQTJBandxMnpCSENPTFVSMzFDWFVVVnhOaW5w?=
 =?utf-8?B?UE4yY0MwRnlIT29heU1EZDBQZml5SldxS2liUW9iYWRoSThZaDAxMUR5R0pO?=
 =?utf-8?B?VUgzd0JkWk1JTDZSU0hQVmR2cVZtOGlKMGpucGFNa1hDZm5FeE9JK1FpS2Vi?=
 =?utf-8?B?aWNsQk1rcjlKeFB5cDhRMlFLYUJzR2VwZXRHOUdaTjBQYTE0ZnFNZ3dHQzR6?=
 =?utf-8?B?aTZ6OGtEcTZsbDErdUtRZTZvY3pEVFI5ejBuTmIrSzk5bDF4ckE2THYvSm05?=
 =?utf-8?B?ZitNZFlLaXZnQytvYXlVcjVxVUFNNXY3bmdYL3lEeTR5RDg5RGRma0ljU2Yy?=
 =?utf-8?B?eGpWQXNUNThxUk9RcVhVbjNTNjJJV3phSFNFeTg5ZkFSSm0wSEFKZ1F5ZFFZ?=
 =?utf-8?B?VEd3bjVqbGZoUHNnMmtKY05MZ3JTNkY1dHY5M3FGemhUV2V6VENXTHhjZk5s?=
 =?utf-8?B?VFJVV0Z3T1FzYWRWeG1lUnRRelQybk5aUWFBUHo0ajhkUThXY05yY0MyTzFN?=
 =?utf-8?B?QllKd3MxV0kxKzhDNDhZRjV4NjJpZlgySkFXMHZ2djZLZjRja1pTQWtTeENu?=
 =?utf-8?B?SEh4VjJHNVhuUkFRTE8wY3dMQms4UGFnTnE4dEd1R05UZHc1Y3ZQZXQwbnNt?=
 =?utf-8?B?ZktNdFk5b0dWd1Zmc0NJL0J5NjBzMWcza0VGYVBwY0R3VG9SMXM4MTJkMzlj?=
 =?utf-8?B?MXlTVCtjRFQyL2VZSVd4bm5HNWo3dFhJU2J4aTBDRTc0RFp5dml4YmFaT0Jl?=
 =?utf-8?B?cnBsQjdlNTRLV29FVm1qelFUbU1iNkhVNnV5STVmTkJoaWdEeVE2eG54SGxC?=
 =?utf-8?B?aFdPMHdsOFB2YXJLR2QzMkJmSmhSZDJtdDFQemtyYUd0NkdDcm9GTytRVEtW?=
 =?utf-8?B?K3V6bVNPZXR5UEREM2g0NjA1aStjRjVLTXY4a1p6Y3Y4ZlB1RFhPbkhKblBF?=
 =?utf-8?B?TDViQUVjUkhhRlBMVkk4RWdDall4aDNJOFNLcHBDY0l5Vm4zS1dzZnJBWDE1?=
 =?utf-8?B?Q1RDSHdLTTR5V2Q3eThVZkQ2TXcrNG9XRlVNOU9OOEtidHhieGc4WFQxVXRL?=
 =?utf-8?B?ZS9wS1pxZWh1aW1VdHpwU0hPMmkzSURYajFqOW9BR0d5MExReE5tQmNGcDMz?=
 =?utf-8?B?dHY0eVRESWJvQnE5UHhOMXBrQlVMVW5lV2pQa1VZZnN2SFBXdDJyVGhrVkkw?=
 =?utf-8?B?Y0VTMWxQODF5Y09GRFZIbjRNWC8vRTd4L1liOWgwUU9KdWRjYTBVaGRQZmda?=
 =?utf-8?B?cjRwWXZxQ3dBY2t1OEE5SXg0dHBnUEpzTVExMFI5S0dmbE9jcXBweVJ1OXJs?=
 =?utf-8?B?V1NkRENHNHRjV2tvSXZpUGdiQzFRc3hVWUp5dTBucG90RkRFNU9pc2VYdVhV?=
 =?utf-8?B?cm80N0p5N0VuM053SzN6WWxMcGJhT2JmYUpHMmVQSVQ2dHE2TzlUcTk0YjRx?=
 =?utf-8?B?ckJMT3JYeXVMak1pcWl2SHhHUGVzMzRjemJ5dFkxQzJ4aW43ZEZxdjZWM3Jj?=
 =?utf-8?B?QVJMdWZDVVNvRjVOY0NXY0hOOGUvekJ5Z0JhN0hpNkZCdjdiaEkxa2xqRDNO?=
 =?utf-8?B?S0Irc1F2ZmtmcG9NT25rU2FETWFYL2ZKRmNybFhFNkdPS2taZk0vR0JhQU9V?=
 =?utf-8?B?cS9NcWRYU0pnWWV0a2oxNytiaGM5bjZua2hrYTMvTkx4cUUzVUtFOTV6UFpo?=
 =?utf-8?Q?W29K//qrB7cquIeDA2SDOHsThr66MbspKSzsr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97cb4f4-4d22-4e9d-c412-08decab2aeef
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:49:52.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1wIfv/y8TRL9gc098RgBkZdiLk/N/uMMhhrfg9iXQIyxaaeBkSQJoA77OFksn/Gv4xcgfajdgVCWjP/e/ohJs74DvY2DVO4U2IywgBotv5SEGz9vRwuCp9Q8g1TUdOu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12586

From: Joy Zou <joy.zou@nxp.com>

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
index a291812e6d22..4a1d04898482 100644
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
2.34.1

