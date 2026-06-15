Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400F22D7A9;
	Mon, 15 Jun 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509792; cv=fail; b=SWvAe0EjQuVu3a/CyRX2tK+YmLCf9yNau0H0HSOcFk5paE/EM1cw4o63/V5c43KgchznSqF7opB9EQLVKA91ICDd2bTAjGMAfDQeQUbdXtf9WP9F7w6mgjee+LqGbdoSeoha1D50lyTfKFxQGP8QCklym714Qv/MV6g5bcySiqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509792; c=relaxed/simple;
	bh=ew+68yhnUjYXMeZwwciV7PqvkUurysDdsd2HEq+5nvQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LeAOj4A4Q1PPqYGbUdEw2ZSM24oD4VKETSFCWOWp01pvdWE+EvkybytqYJ/VTWWFUcqqKmmHW2ch6OYpLww3+s/rK9sYzKVDzA9fdRIoTTZSA9Kn1vlhvCK0Xt+OXt1IJkbTNiOkXSRgv6vWM6ggrZpt6GaRZrSlkYaqySSDokE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bV5NJ0Jt; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bV5NJ0Jt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkkKMWpWdgdWrKYBaMyAlJTaI6/O9qgzal6mUJHe8DX59XgNS8aaqt/nE12gh3wv+vbMwzkYTGElsGWKj1bzgpvAEkZGfAc+dgusb0GtkZqmu+MdS3F9/GKGEDvwR46Les8fa0V4DIQi1MOXHfTzC6LszdHiz5a8jJsTn9cDOr/xbAqkw7m4F1K/sF9di0Fbx8Bd10BubocXevbBMU+mn8Nr4LmH4g4GcIYkL3kiLOyM/gn7CX7FupnCW8NqyUrHhkISpYHAI7yjk7heAHgWyhELX2CCezNvsOX2O++D405ZGP5G4W0l6YSBnp8K8/h/L4GbR53JWz4U1aYRj+6oXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnUWq1smWEigRpGv/YFjXbj1qkzfydmrRbR4PmxQiMs=;
 b=QfnVh7hcYhzPjtZSGHqiwkJpDu87hmnMb7fV7zW3U8aKcpt3dkeDiC96RZjPH3YOwJxpbWOicMtCaT99GdsL1pH12IUUER0K6CDjGPuzt0y4QfNBdVfW1PalMZqRv35ptZaat4DyTMPVN79DpsepdtAX4kTxWSAIxWl0Rl2nVDviml+jwikI61wgdRRiirs3+/vVcpsX5Vz5SvP5B6Atsx2h2mY/HtTC+VBSP1DLxC30EOl8CZ3xlTyOPI8LpADFh2iYMa3XxUAFt8GV8CPe+wD3ZmTaLJ3CCHn2vGAstjmmQpzlQXjlJPbmvvhD6txVhtjCdFDvW5gAmYrOj/7xQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnUWq1smWEigRpGv/YFjXbj1qkzfydmrRbR4PmxQiMs=;
 b=bV5NJ0JtOa0AjFM2iXT9iK27EzVHycH7AMvrOUJiGaksAQXIFnHzVPTEL6Q5H7BRFWzFzza33EIQi+S6fuZFx72tAfKTLPuJiTYEV9yB46BnISyeqUASnZmb4DoEgz3EE5gStGQ6Of4kkMr2+sbHHzBspCJb3mFfxE4dafdv/WpFjcfFCj1H12bX/y8NKNZi4mNVersdcHlSx6aoYkyq4RTJ619rUcSIyMxyWpMQnGFM8DHt6+nV8p2/QNVkfamJhYOG7rdCaSo9Vlb12bsv8OsidLtrqDRRvfX3z1V5Yv65Fa71agKzzF77XKY8DLISeZP9rCKUItvZcxeiTzUrWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by BESPR04MB12586.eurprd04.prod.outlook.com (2603:10a6:b10:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:49:46 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:49:46 +0000
From: joy.zou@oss.nxp.com
Date: Mon, 15 Jun 2026 15:52:15 +0800
Subject: [PATCH v3 2/4] Input: snvs_pwrkey - replace hardcoding -EINVAL
 with original error code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pwrkey-v3-2-9510b1173f6e@oss.nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|BESPR04MB12586:EE_
X-MS-Office365-Filtering-Correlation-Id: d60c89fc-b39c-49bc-0b1a-08decab2ab97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	2/8OQMlO2KTewTUL21VmpChrlc7vjFkYp8aG+8Had0i1+kFKg5MfO5D5ZiK+FcMrMEZo2A16j2/oG41U90nW1SCzlj7fQVoy6FQIkikOzXqFZllRjUZ29xDN4/z/h7Xhr4H3ZkJn9iZF9MYJnpKy07TUf6PAerlTLbnO6WC6TkqNjCJ13t6DVIYs8I/TmLuW7sqobpsmJwcq5hkHhBSzJhniv8aTB9whsE4iENKElSKBku4kTM9cow5AwkN+KdtOe3k8WRlO6pWnmb+4O+G9pzAlnsc84rJlqKiaKYOn8p20GBhSpP2wfXW4TOQG25WNlS3kZSMRrfz6Ql0zmcf93gHWwogF1NGCyl/wMg+5jR7VrhkiSxeA09LDsennHJ7Iuz4GC0G3E84jS5hu4SPIB8VUPYTa7PlWy3TfdtvZ1lG5xBV3SQ5BLz/YquwydOL3lkPZDySvxdWiRCGNpMQQkIT3lxLbs/p0KdOnnHJG6wuK1SYhS0ctkvvu4bOYQFJU88uAkNQidJpMB44XnBOWiOTF9DlTE8+ZUTz5q70H9/GDkIw/xu4N0trXAQOdR9m4ZyyM4RSUvXDqtBefrSI0d3sig/23Lbm0/9wZGzSfmjiqZcXo8yCT0Gbx3we8lpbPbLKv8nSHBCIwSia9jjWPDoO0e0tw9HCWVQheDlRNU3iAXYLj0Yacc5eMuFgVciWG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUE3MmY0dnhELzV3MHJJbXlUN1pueWtVTnhLSDBCUGFBVFA1K1pYWGJGdWVX?=
 =?utf-8?B?T1U4QksweEQ5ZFBxblZMaDVQVkx5TVd6SGEwd1loM2lVR2J1aDduelc2MWl0?=
 =?utf-8?B?aWZWc1hzcWhRM3V5TWowWkdPOUczMVdaVkRlaVhWUnErTW52aklUeXA3RHJY?=
 =?utf-8?B?SUJaczJIV2IrT0pNalQxc25BU2ZCSWJjcWxjSzJrZmpIcExQZSsvREgwSmxq?=
 =?utf-8?B?ZS9yczZJQVArYXpDNXFtZlFmVWFsdlZzYXJ3R2FLQjJGWkE0L0pOMlBzVFdk?=
 =?utf-8?B?d2pSWXVjS08rVkVSY2VnMVJsRnBCVHI4WElkRHI3Ums2S1JHQlhuZGwrNjJM?=
 =?utf-8?B?VDdSYll3ajhJRklRUTU2aTdXMENzTWRtcU1qOUVST3E0MGJ6dXpIYWZ0UUdw?=
 =?utf-8?B?cmJmbkl5MW51YVcrV1FkbDdjVEh3ejltMUZORGlENjkvbENhcGdkZlQ0dFRn?=
 =?utf-8?B?R3Frd1hEemcvY1I0SFFTTHY3UkJjanBQTlp3VDQ4YzF4dWZIdDdBTENMaGFN?=
 =?utf-8?B?Q1RwT1V5bVg2d1Q5Q3FiVGp1SVBnRWJCKy9DL2hoQVJGa3ZIWmsvUGJqT2ha?=
 =?utf-8?B?K1dsQzJ5UXZ0QXk5WHNncWdOZkt3d0lVTFRRUmVOU1NjeGI1UXZ5MjJOdTZp?=
 =?utf-8?B?eW5GRnQ2WExTbEZ3VTB3YWpaVUoraEJMR05Tbk52UnZ3Nk1sQ25HYlNjMGcr?=
 =?utf-8?B?ZnBITDVEOUV5bUNwSlJ6cjlsWW9VMFoyb3BFc3FwRFgyTDNxdzNHdWFoTmFj?=
 =?utf-8?B?MUpXdytxWER3ZTZMRjJ3UDBZZUN1ekFYSUY1VlJkNGhONUdNVWhPUXRxbkkz?=
 =?utf-8?B?dzJkQW1OdUJtQkx4b0tSc3JhODQ2ZkgwbHNSSzJISTM1NG8xRU5VL2l1NHlV?=
 =?utf-8?B?MG5FVVFRKzhuNnJkeEJWdmZzZXZBdjZDU0F6UmxXa01ucDZQSUhacUZSK1k5?=
 =?utf-8?B?YTdmNjE5aGZvQ2ZyalFTUFowb2ZQVCtwTHJhSEJXMkhUVUxzQ05SUE9xMlNh?=
 =?utf-8?B?M2hKdzkxZFozOWtCQThzY2czb3phYWhOUzFsMzhEMVh0bFJCN3RhVnJuWGJz?=
 =?utf-8?B?Rm9EWm1lYXBWT2IxNE0vMFowWlVVTzFYZ0JTUFpKNkFyWjYwM0xQa2Y0ejgz?=
 =?utf-8?B?MU93eUI2WmV3bnl4Z2MyRGp6THdZOVMrcXRNNGY3QUdFUCt3dzlHNlkvalJX?=
 =?utf-8?B?a1NuT25LbThLUCtkV3M1dzdqN21HUDJGQjZRSzJnd0dIMnAwUTI3NmZ2TU8y?=
 =?utf-8?B?dlhITitROVBLMHBDR21qMkI1Qk5TeWJFS2xIQlAwaHlQQm5QanJuOWg4Ni9N?=
 =?utf-8?B?NUEyMzZoZzBadUNPQzZUWldESFlvd1ptRURmUzZ5b1grQ1VhYUF6bW5pTDRK?=
 =?utf-8?B?eThlQ05uNFh1K2hVU3FvL21IMUgzalB1aWdnT0YvYy9TbDBMTmVZTnpMTWo3?=
 =?utf-8?B?dVluWmtFN1JSd0pBRVl5K1lyVlR0MlBXRzdxaGhlaUVaajVSRkl0SXB5M3g0?=
 =?utf-8?B?d01VL29Na0loK3ZSZXdHY1NVQjdYb2VZYncyKzNNMDVIR1E4M0twNWM2V1FF?=
 =?utf-8?B?VkRWK01rbTU3QWIyTVBsa3VxdE9kQzdLbGxNRkdOYlUyaFRaNGk1QlFXcmpM?=
 =?utf-8?B?TVEvRk9XUmk1WFY1dytGNVR1Z09zYzg2K05LUlduZWRFeGNYMjNoTzFvcyt1?=
 =?utf-8?B?K1VQaFdUNVExV2kxNHBBZVdlWVEyZkI1ZWxDektHQk9SQXpXSGxpQm5FNm9L?=
 =?utf-8?B?aWJDWHVxS1NWWmlrazRNbEU2OEQ3Z2ljN3AvK0gyWXhTd3BqQ1dNL3ZqRXJt?=
 =?utf-8?B?Z3QrVkZNd3RIcTNib3phRFZuMDVaWE9aRnhLNWlESVprTGp3UEJvNHhva1VZ?=
 =?utf-8?B?ZWhTd0tWL1RHZGxTTVhPeFUzOU5sSmNteGI2ZGp3cmtiOFBaQ0x5enB3VkJK?=
 =?utf-8?B?eHRYRmF4ZFY4R2oydWdORlNPSHJxWkNwekQvSzBFTFNmT3BYQjNwN1Rnazh5?=
 =?utf-8?B?SFE5dkUyOHBUNzJpSUxlRVlEdmVCY1hzQldqUGxwcEJnOXFRNUNIRTY1c1hy?=
 =?utf-8?B?MTNjK2VDUlZORDV6dWU2M1VaWWs1eGxVUXIyakhwSFZRbWwwRHBLVEtNM0VN?=
 =?utf-8?B?QitTTkV0V2lSRXhEcmpJbzhBZVc5eEZ2dUc1ZE84ZGFnQmRPUk9nekwyb04y?=
 =?utf-8?B?UWluVEVvcGlnM2lMc2ptS29Gb1hPck9MVG50dGVXdFBvSkFDNklFbXcxWnZm?=
 =?utf-8?B?eTkweTJzYVM4cDVRa2hNUEVHeHJzYVd0Y1d0WmR4UHhScXp2UEwyb3hIN0VU?=
 =?utf-8?B?dEVrc1hMVVh1eXd1Q014WW1XVUdyK3ZDeXY2OUhyVERKanZEcXpoS3hsQ1k3?=
 =?utf-8?Q?WHIJqzeQ58ztTmqW/NXKZilZ/84eo0sx5DGgV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60c89fc-b39c-49bc-0b1a-08decab2ab97
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:49:46.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbFI7YM98ENunsqv1PfdzFYFyrnJrtTEiVMZAU6pqt0c01BaQlRtFzE/eOaDIWZMiPDefOpl6T3NKrdLXTxCPqkwbWiF04e6K/OMR44fvjten7k8lU2RoYPc9QG+6M5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12586

From: Joy Zou <joy.zou@nxp.com>

Hardcoding -EINVAL discards the actual error code, which breaks probe
deferral (-EPROBE_DEFER) and loses critical diagnostic information
needed for proper kernel error handling.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 748196fcce75..a291812e6d22 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -148,7 +148,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
 	pdata->irq = platform_get_irq(pdev, 0);
 	if (pdata->irq < 0)
-		return -EINVAL;
+		return pdata->irq;
 
 	error = of_property_read_u32(np, "power-off-time-sec", &val);
 	if (!error) {

-- 
2.34.1

