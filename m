Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031BF4302EA;
	Wed, 15 Jul 2026 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107890; cv=fail; b=P3LyeZMXwtmOYCqFNVECoh3GDolW09RBQDxLYO3/uGR+jnvfqJSwRr6aLIWNh46LyqOFklyxp4YxGi3LTPEw5V+5RqVxi8bv3qQG+6WwB7tJ2z+QIdtAEOF6LBjT8VtmieeIrYfZ8o+oK8TSZ/YjuqrMWSwixZ+iV9MMsoBDTcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107890; c=relaxed/simple;
	bh=rewxjtOtB4zVo3O88fQLC80uyFAVvE/9qJRqO6+AUbk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Qgd/GMNHge13nRWIpvJ2EiTf7/BseKjpLpfZscRM+hE6ZlYIm7c4qf11GrRPOBdGIDZ+eVd5+xt+rs4ZXyhe7NsgxsPFkT8eRq+r1qoDS5ub3XUOSZksInfw6nmpvcuLgBXB+QPM5tjqDa3N0gOApdg0RTJ0zm8M0yFMtUaVGEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gRsTf14s; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gRsTf14s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCGwFVG6SjXpBMk/mTnF6BCVoPPEoICkhv4+m29SG6lg5JkaVfeN1yDT9Uks6TGkWMWEk9y0eWB+0KRjp0mvTNnH2VLX7e4h2mi2Yuye3LXOCeL8YKBRHiP6Wojny97j3DEBkM/sPgx5yK8EyAa/DNiwFuhRmYANWYxnFUb7izLDLSr5o5H1GS4NywliFVyPa+QSxroFT32pAJAx/IPgijk5V5ShDdtDl/ujvgikqG9RAQFBwx9tP/nylzsRyhS65Ttul4U63prpxY/RJxl4gDY/UMMG367pU+qCeSvhb96kWFSvn3eon/Y59UZvY0rDCssYgX5uTA/zFToAc5M9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAaUP6v8RLc7eCue2I1knOKf0bfgK29epdr8NxGZo+w=;
 b=jty6ulWZqwkJ6uggCo0bP4WcY76khsFmkDa9IhQrwUCXWJOqRuEULeOMmCzgmukRnvEnAix9CFEQB5ESdsRcoqf7mz0YP4wyJXesnlaXeoQyVd9/s14XTdCbD8gOpab4pw/WRsEjVA+G9e0tuNSk2wMd2Tz3MfHVxi+Wi0Q3ckvd++ln0P3jXzvEoWQ8rixR0JCbUxoiYVe0vV4at4LjiB8Sd3PcEm9XN/8OahuC+lpJ/XHnnWZU6BOjw/Rg5ptHXkFLO1lN0AnKSNBE46vauNrU+s5PXGxv2Q0hmzakNa6Ea3lq5dcp9o0AxjNsXd8RMze0D+dN0nHVuMG1InzzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAaUP6v8RLc7eCue2I1knOKf0bfgK29epdr8NxGZo+w=;
 b=gRsTf14srYs4F8Vfw8HWzcZR7GhCcxKanH3kx7segOeMGXHojpUjoKIiFmEahOeIoKMpvH+3H7URQJa9zINJLOl6AVSWZ430MYOjf3zFiVZvFdlsi/CDlY/iSGVf4ZtJcRPuCTnFOIyVBrtPB+cSUaJltZXXISzgGDY874DL/OGme7SKOFaccmU6hPLHViu4kf03hriD/v5S77KmUmfyC/pEOpH5lSMmW1Z/7bmBdbkyXJ9Upr+oa3A/SEPZ4ErN87wlFgwYJDKSsl9Zb5wk4ZV0BIGTEXckjEuY2IS7ItvowM8T8I5WlXDmErMkB3s8ybKjCwOTcJ2F8P1CKY95QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com (2603:10a6:20b:a4::23)
 by AM7PR04MB7047.eurprd04.prod.outlook.com (2603:10a6:20b:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 09:31:22 +0000
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f]) by AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:31:22 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 15 Jul 2026 17:33:52 +0800
Subject: [PATCH v5 2/4] Input: snvs_pwrkey - propagate error code of
 platform_get_irq()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-pwrkey-v5-2-07e7353c319e@oss.nxp.com>
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
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 AM6PR04MB5800.eurprd04.prod.outlook.com (2603:10a6:20b:a4::23)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5800:EE_|AM7PR04MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 390b537a-faf3-4b46-9810-08dee253d551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4kZL8nKVUUQc9UXLG0cYPK2LZFk4TXho0+7/IViw9V6z5DJyrueh8iCvNCFZE/AZOeD1KsF021eqCDEbZeWkqmRZ0G3fx0ZHrcsqUm0YZd9F8iED6FdOrG8z5UqEKyiKgbZBKVCY9FB08VkES3lf3k5bpC57FqXfUDv4asMJeV9vyzXJqZxtpl6F+AgJeoC4n131dq5V7Lc8UennQVBJ1zd+EHul6vJFGv5SX40cz4CRQDSczE27kU2OHRbdFteqvkO9/eHPuBTZx0wQ3fBTb0GEolqOGmHFT9o1f5HxchtyBSiR3gsJOt1VZW9ZTBl+/HERgtfTn5rUaB6Zgl0UGwLvZxfXXnQ3vMplF4BeHx+eGiZyKymoYdG7BXJdwI0vyH9TqkWYt9zR/8bGZ0Hzt5FKzUXtFgMkX00PhZxB5o8NyA1pbvy1U1SsbeQwXupw4qabRj+iaThK8Yg5CEAble9YDh4I5Qf1zr5uHs/TkhidSXNvsEc1oYVBuezsBDqGgDL+oSATjvyiVizLHR7wHGNVf/B03xjnyPyx0l8X5MBaEv02eRTfENYItJrVNUzdxeMlk2+fxPIgJ8OMm02YOGoQQ4w9s7r3sgElxRSBMBEa/nYjADLZrWwl1ndGqsubdWZ4jWqU0DBvO6SWFOp99QHd5BKeHqxkOnyWvs91mX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzZvV2F5TG9Lck5XZXA3azBsaW02SGRzSDBPclFSTW4xek4xUENIckEwUnJu?=
 =?utf-8?B?dU5zSlZsS0hPTTg1Mmo4SmpuSDdyZFVpd3BnK0VocjlOaGlDS1czNTQxeWVm?=
 =?utf-8?B?dHhtenZKWTRJZ01ObE02Zi9GTjBrb29ZVHpDQXdWZStCQThreUlxTkJPdmNX?=
 =?utf-8?B?UTBRZWkyNURXYVRQS0ZzamFvRkNWV3pWbDFZTlBhd2N1Y0wzajJtN1RWY01o?=
 =?utf-8?B?Z21xOEg4NzlDUEhtMEZZK0NqcCsyeGFVZytSQWMrSXlNMFVxQTRveDJmRUl2?=
 =?utf-8?B?dEM1V09UYnVBalJpY2phc3dXN0hleUYzSEU4OEEzalE0TjZZeEtxL2YyOEtS?=
 =?utf-8?B?ZUZjcjE2MElpMXdzb3RVRFdvMmN0MmxEYWR6dWVWUUJneHh1S0tveUh0YXNY?=
 =?utf-8?B?M0V5ZkNZcUxpS2pSM1l6NDg0dThISEdMMktXQjhNMW5mLzJsZ1gvaWxINFpP?=
 =?utf-8?B?WS95aDU2cjhuWjJ6TXkvWk5RNkpJMzF4b3VpQmhwOUxKL2oraVRsa0N1akFL?=
 =?utf-8?B?RHV2eDJPaHNIZTJGR2JNbjgyMzVrbm1sV1RBQmplelMzWjIxdkV0MnBPR2pT?=
 =?utf-8?B?cGQwclVPTWZ6OC9rL0lzMlA1WEowM1FUbXRMb2k1VXg2ZXBJbUFHbWw2WmRN?=
 =?utf-8?B?QmlieWFqVlQ2eEdUeFkzendhSlhjeVNCd3E4UUdpbkZmZWZockw1ZCtNMXRJ?=
 =?utf-8?B?dmtFK0V0RW9GSlZzbTB0SnpTUVE4WWNZbEg4c0RLUG1ZdmdIVDY2dkxmYVZs?=
 =?utf-8?B?aGxERnBRdGJWNTg2MkkxYlJvQmZTejVuU2dTMWFxTDRrQTFVeTRJUERtMy9G?=
 =?utf-8?B?T2wvWExLaDZkeWlNU0ZMM2IvdlBTbUQwekROYW12dWFwNXFEZ2Z2TGw2MXQ2?=
 =?utf-8?B?UXJWbUV3aTBEcUhMc1NVSHYvSHNIRVNjYkhMak9iOHFTSXNhS3JyREpkeDNN?=
 =?utf-8?B?YklxUWRQa0VuK21LVnFZazBNSzlpUnNkVW1nejV5RTZxUlZtcEU2dXJzUGdj?=
 =?utf-8?B?eHp3S3ZmR0hRazJNQjc4akVLVFo5MERrTWNJL2RKSzNEQ0puclJtSmQ0eklp?=
 =?utf-8?B?NExZNWV4anZ1REJYZnhpVjVOVnN5clAyMmNGUSt2L1VzRUI5ZXdKWWtLb0Z0?=
 =?utf-8?B?Zkc5c0xYS1p1WVVqandLMkFJLzRWQ2o5dTFJb1pjUENQRnFRTXprZjN3YkRN?=
 =?utf-8?B?Z2RzY3ZpVUN6YVVvR3ovUlh3d2NuRWlEOHNqM3pHWTBvaTR4cFh4S01uTVE5?=
 =?utf-8?B?MW1yNnBIaWRWOUxxQmthNmIvbzFza01DTXVnakUveVRIYlJFZWpUWDVUVDVx?=
 =?utf-8?B?dU9SZjFuMnYxRit3akJhaDdRUmQ3dk8zK3daVVZCZ2RYeUJOc05HcVQ3K3lp?=
 =?utf-8?B?YkxoL1hKU1ZOV25SUUNpSEVjTzE5TEM2dlMvTXIxTEptdENlS0xoUlcvaVRm?=
 =?utf-8?B?dy9mR0E1N3VUYi9SMzdVT2Z3cUNxUk9FUTAyNDVxOGhHd2RxdnJpU3pydjdu?=
 =?utf-8?B?ZmUrMzgyYWszRUs2ZzdTK29FMGxpTnFxdlZPMXFqVUJ2TTNJOGl0MHYza2Fw?=
 =?utf-8?B?c3JrOVlGcHN4d1VVYU9lc1JZUkZGQjZpcXRPUy9pM2l4dDhaQkxwR1EzeElG?=
 =?utf-8?B?N3VpclZlNC9keDdJMFI3VDBKbjd6aVpheGtub2NxbXhmNXgzc0RjVzQyZjc3?=
 =?utf-8?B?Ty9EdUtJTFlZMG1RblY5Nk9mMlE0M3NFZHdFRUlPVXY0R3VaaHZqNG9jaUht?=
 =?utf-8?B?MHZVcnNnOU9QVFI4NzdiYzR4TGdqWms4aENlZUFuNTZIZ0ZPYnlzZDRnWC9m?=
 =?utf-8?B?Wk5WNGJwVjRGME8rRGxrYjYyczdjQXN6OE50TVRJcFZ0RE5wZVM5VUZ4T1Yr?=
 =?utf-8?B?SUVNVi95T29mRG4rU3lZUGR6VzY4Y0QxNlUrbHh5SThmWHc4RWlOT3plN0g5?=
 =?utf-8?B?OENrTnBhOG9FK09jUkJ1OFo3VlRUbVJidjJPdkV4Y0xDalVjTmFCR25JK1Y1?=
 =?utf-8?B?cWJTL2hVWlZRWkFsVWl4L1BXK3lsZkl0TEM2NDZva01kVktjWkhPTHY3anZB?=
 =?utf-8?B?ekF4emZ1ak45NngzV0I0YU1wcFVMY1Q4b01jNVprVk53U3VXYzQzSURjdHZ5?=
 =?utf-8?B?RkUzTXZpRUxUNGw2WlFlTEV5cEJORWhHNlFMamRscnFmNlhwOXZLSy85bGpq?=
 =?utf-8?B?ZXlxYWRLSWpWbjhnQWozNDlOTmw4QXRhYjRrSGlEZWxTSTJlbndJQjBNbENK?=
 =?utf-8?B?QVJxR1dSR1hCZ25RWWJCS2pwSmZoalMra2cxcXRvOVhscUFUOGFsbTVKd1hn?=
 =?utf-8?B?T0dGdmV2LzIwN3dJRGlBVDBwbE50WE1vU28rMG00KzFXUGV6YnRXSDFySGR5?=
 =?utf-8?Q?vIy21ffvYCwd7LFqJxXkpec4ctZ3/CZ8ocwcN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390b537a-faf3-4b46-9810-08dee253d551
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:31:22.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPxTtXDZMLGW1DASe9QIScWeHr3iFeOjICToqmGa9bZGRXxZcsquBu2f2oB0HeFqJSB9AvH7KgsYmelbPEaqj5nsaa5CtjpsGEKbFzSdJMutvwGE8zdcDS0/pw7ERy6V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7047

From: Joy Zou <joy.zou@nxp.com>

Hardcoding -EINVAL discards the actual error code, which breaks probe
deferral (-EPROBE_DEFER) and loses critical diagnostic information
needed for proper kernel error handling.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v4:
1. modify the subject description.
2. add Reviewed-by tag.
---
 drivers/input/keyboard/snvs_pwrkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 8cc6863d26ed..d58bbbe9fd58 100644
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

