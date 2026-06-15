Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C763B42C3;
	Mon, 15 Jun 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509801; cv=fail; b=Quf1wN50XVf1OPEW8+92JeMasQi7ZDtPaPAXu6dmYHMV8tG7FZ3yPxgAywUmqDfcWtGZwOK6Owiiann1YMvXPR6QxGreqCAJ2NreviYvhEsn7r2BU3doierMfogxT3kFT9XCLIqGY9dhgSomzuomMuQn513wJ9mSZJS6YAf2Tfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509801; c=relaxed/simple;
	bh=TncmtquqkGAeyfa+rQ3xSj2ZT9ualm3EkIZA0b/++K8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EdI3N5A7Sb/KJrSILIp1S1hCbVRpHkzSfjFSrIneIPWfEGk4abCFLl5baA8fuV/iZBAQD2v8Nlwrk/Lbazlhg6U2eXSMu5BWe8dy10IY2RlEoZcr6NYKJMU11tDfMVSXEoYEP9uvAIFvqfvF4grH/D4PFxFcdFqS9p8QHztJK7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q7NCdajC; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q7NCdajC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAQfCj+npG0CfkMyzkhDS0bc+KdolxX8ZPcZowrIQ6pPn9oeGIXqQObihp/g5QquVhFPDb19ypxLMw8XHRLjzME57JUmD/dipdTT26M6YhrRIyxPYMGBPKh0WRoB0oWOK1xJnYzGYdT/PKKM20tRr8ZizE8eiKBsu3RXln/MqNDMB1adJBRCI4yIJxPYu9x9PFUaZEMEJktRDXJe5QX0QZuERxgYN6FgUO7bVKieYldI4P6SeopDarVYD7TqhPcf6gRSbz6NX8IF7TcpTPr0oZKkqO+1xZcLMeXntyzWUm+02TNdYTlfi2wt1fwZUFu3ngcH73YbrDam36m90ikB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7ad6OPJ3b4ATQyjdTgg48J33y1XxB6AOGmaUMxJMng=;
 b=NPb9CqCF4SpQwHfIHZ2ez6BLm16DcNVJzkX8w6RoHKULpMXos6E2DI6/xAveYOIKvRSmsKelVM6nc5JV7FeutN5fY8rZvW2l9tHZetunv+435vdudd3tHgCBg0vHj9P80C8zIdJRu4u6YMCo24lR2XycudI22ZZvuDuRmimeMioQ1216DN/vdBMtES/TbYCWnILyjVdjbeEsVuW7BZJyLtZ6RTwc/Ft/2Z80XbDWopC55lgiyJ5bm4s+3cLimAo2U/Xu/gzXd68CsvxXDE0ArfSj67NIfATGFkZt1BGVqtLyHpTdM2/TId044zRSxwwZworq6MO6U7RfNcMN4H2E+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7ad6OPJ3b4ATQyjdTgg48J33y1XxB6AOGmaUMxJMng=;
 b=Q7NCdajC7kMzDOtvk/q8AgiHu2LP8zks3RAKiq1h/w1jTPxLKcl7OybdIoawsJenpSdEhBsuS9vsQQH4FNRDCFl7uo+vUqArpQQ2NBjWlsRb/Zm3wzOBk8hrc/57OBq6cv9ZsPRdlCGS22rIod6R8HYA1OEw6XxbenzD9inZMn9OaXn07ZX3tI9zooEoXKnXLhqf+rQQiNCZF8/WWEGVZZSQuBfuqtiG0evISqoBg3NWoyf70ywM08/kWXCbDfQQem4/Ph+wgi4+kLHwL42DFu0MBHFPtMrsb+TwkkHViF74ESEzgiZr4SLAFfB2c2Ssq39WuS8L0gttBPnQC+pRRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by BESPR04MB12586.eurprd04.prod.outlook.com (2603:10a6:b10:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:49:57 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:49:57 +0000
From: joy.zou@oss.nxp.com
Date: Mon, 15 Jun 2026 15:52:17 +0800
Subject: [PATCH v3 4/4] Input: snvs_pwrkey - report press event in
 interrupt handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pwrkey-v3-4-9510b1173f6e@oss.nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|BESPR04MB12586:EE_
X-MS-Office365-Filtering-Correlation-Id: bad28a1a-9e2b-4156-9683-08decab2b227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	3DF2saEG2rGKnmqh7p+JARgI6utFPfggaZrE2sjYM+s8CkxM1wapueeqvZlhZ9OvJ/n+/G0ZXbq86N6+vPA+Ha2lBWScGfwJ46Xcz1IWFY41GfUUsgBFrH9hxRwg6UtlCrFSxI317S+9ZKokoEYrzkUWROXMgIipDGR3JDkLdlnrNiZ/q0/JaevKk/NJugM8G0+1hYZshtaFU2WBCqmreyltPY7qqckEDJAHSXXkulPwMibF7HEvgal4sWjn6LM+GRe8psfVZNnQcTy/kAwH6+soHG+8lFmaGliNmCNVU7hfERfAkafXrodUq0OUJZHvVtBxuOgNDyNdN3ZL9hyrV7NxDc83t2XX77+yfTX9k6sGmOSNlZUFf+O7arpE8GIHTcEsqpbToNefOD3tlPPlPzVQv8A4FRLI7rTIU/LyxkRN9LWRGLIVGjMDplxq5XymSHS9YnJOpBv5G5wud3zjZeBmLtcOf/OzPjleGAfE6U/2ucJDhWYa8PC1MKV/IPbsfHS9WhwTU3jit7AzPv48pi3CjnUJnee6nDYtGfi31uxcLuE03T//0qhagXxvPO/1cfWuMdoaXMskxizq+UtsBfEpAmpw3EDq8JR9S9Z90plU5Wzyv0qp9Lz+/PrnyiAk9plEe3VhqSyw2QWEQUpBeSJ2COxGY3lifQY4tkAJfV7NV3Cu3JwqVi29cnR7z+1x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlNjWVVseXJGeEdNNjRrTXNtU3RhQWZSV0UrZTllUkVtcDNDTnZhOFhMRTFw?=
 =?utf-8?B?NWdmZ3VuUFBYcmFrcGN2ZDdiak96VUsvUC9FR1FpdGt3bDZDdnQ0RzNFL1RH?=
 =?utf-8?B?RmlCSUJxYlRyVExGR2JjWlZBNVd2REdzdkhVZDFiUFAvbjYxVlFJS0ZnT3Vq?=
 =?utf-8?B?RytyUzdZRnYzcitnOG1FUE10Zm1TcDU5akdQb093MUdOblZPNzBWN0Y5QUlz?=
 =?utf-8?B?bHcxTFp3d1VBUVYwcHBZMXhsaXc4TVNxWEJoUDN5SW1CTGYzZDZsQnhnNmdx?=
 =?utf-8?B?bU45WmErMVFKdXFSK29pWGxIUlhCMFZrL0tYanI5NVppKzRXVFpGQWhQM1l0?=
 =?utf-8?B?R3BIZ2dwTElxZGxzcWVVSzExdFBUUlNTU2lwdWpnS2VBbEYrNlpuOWVxSE0z?=
 =?utf-8?B?SE9pQ0MwbjU1Ti9wNDYxY2NCR05nUExuS2hFOUJvK2s4V0lpK0xVRzhlZTRt?=
 =?utf-8?B?aWFaaHp5ZnF1QzFyNkpwUkJxM0xFdmIzbzUyRWpmeGRtSHVIN3N0WWZCWEI1?=
 =?utf-8?B?WDRNSkdHRUZ1Y0xrU3pQUGFtc3N4bWszclBudG5JUllqbkN4UmhDSHJXWE9w?=
 =?utf-8?B?dUFJY1IxWFRIQ0dqRmRxenZPOXpxZjVpMDFSdmxWVEVxTXZMQ0RhRm4zaHpE?=
 =?utf-8?B?Q1lVeXFITVhRdy93Q2ZUSVBHRFh5M3pEL0hBSDc1OEU0TUo3eTdEZXJ3K0RK?=
 =?utf-8?B?UGdSRk4xUDlqUlkwZjh2clJwZVM4ZG5QU2lLZXlINHlOQkRnTTJmb0QxV1k1?=
 =?utf-8?B?RENwWll2b05jZ0FrV01PVkJERFJFZ3l6ZWtVQ2dGL0FNVXA1ajVRamdvWkxO?=
 =?utf-8?B?TTNvMG5KaVpjaWRZUm42NHZUa3JYU3NmVlE2MG1NMnlMMDN1SG1VMDFJd1lV?=
 =?utf-8?B?NW50RlJodkl1WEZWNFo2R2o4L1ZMaDRQdllac25aclowbENxVWNVb1BLOUpy?=
 =?utf-8?B?QlF3YWpRRmtySHJlOUtxY2lsYXExWUxPTnZwd21wY2pJVjZxanVHalBxS0lU?=
 =?utf-8?B?VEMyNUQvVjJBQjBmcjNLb09JZlMxcDJyd2E3WVlCS1RVRDJtR2k0MGkzSzhs?=
 =?utf-8?B?amJBZU5UYWplTDMxRzhqVUh0VTc1U1BueEQwbmF1SGxCc3dZRTYyMDd0cHl5?=
 =?utf-8?B?c0xERnorMU1zdnA5VWpxSzJzSjVLdlQrTU9PVXJtZ281cmJVS1dPK1R2Zmtj?=
 =?utf-8?B?VlFNdHRGdm85OVlBQng3VzRtU2VZY3ZJNVdhUDBsaUwrUGZ3MVlFaWE3aXFZ?=
 =?utf-8?B?U3VNQjhJY2grVCtSbUxYRnhEREJ0TG5yZzQrby9tdFM0RzAwZXpjT0ljT2lL?=
 =?utf-8?B?MWJ2N2FVY3pwU0RvNkpiTWw3Mnh5Qk44YzduZzRZOGJtY25KQkIwSVF4RFZS?=
 =?utf-8?B?a3pMUVBUTm0zdDl3ellHSytKT2R5T3F0MVBUMU1kOUtaZkFKMXowZGp6VExO?=
 =?utf-8?B?OGlQNUkzdEhCQVJwWGNtNGpvdmZRMUttVCtSWVhHd3cxNDdxMlVWYzJXM3lL?=
 =?utf-8?B?SFFCTHpWUllNMmNWMkZCVWJ1NkIrcmNPSHU5UzByV0dKdkhpMkNBY1V6YjB5?=
 =?utf-8?B?NytScjllSVNTZ2ptYXNJOFVPYVdMZkh1WTBlNGlhT1J3KzhhOW44MzlyYWVn?=
 =?utf-8?B?dXNjcUJUL0xvN0xuaVQrV1ROVkE1Z2Q1aU55SmdkRm54TFM4alEyeW1POGdT?=
 =?utf-8?B?bHNzSTZkUE5mWEdaUDZDR2lscFRzbi9jOU9OOWdhUVFWSmQrSW5xek1wdlcv?=
 =?utf-8?B?aWwrUVpTcW5GOTRZVEFiMTM1RElSbWt3VlJKMVVoRDEydVFKZ3FKeklTeDdQ?=
 =?utf-8?B?US8vdHRDdTFQMkNabWIrMmNZRlBROWNBQklYVHh1NnhBbFhGQndQRjJ4WEUy?=
 =?utf-8?B?RDg1QUd6QTFHa2ZSU2RFVXJhZk5KM3NaZHFIV0l6S2FoL0pBeHZrZlRDUTdX?=
 =?utf-8?B?S3RpcWtPb01oTFpwM3l0L0lubThTSmtXWmx1SHRwVGZFN1dJSms4MHg1Tkll?=
 =?utf-8?B?WmwrVGwvNWlIcVN1L0JHL0RGc3lORnhlK0g2OGpJT0FwRmlLLy9NZHY3WEN0?=
 =?utf-8?B?NjlTWVZGN0VXQmx3ZGZubnJ1bVlwakpGYklLSDZzaWI0TjB0R2dKbU1qTnJK?=
 =?utf-8?B?ZzBJZTNmcitucTNxZ1c1Wi90cWk5emdUL3Z1WktUWTFCTDJBZm1vaUE4aWQv?=
 =?utf-8?B?dHpvaE50Zko3aE0zeXBkMVFuNlpLSGNvam5LWVNTc3N6dlVoZGE5VGhKQU1Y?=
 =?utf-8?B?T01HTzY4MG1rZzgxV3ZnZ25LakNRQXk1TEtjZ1ZKSmdYbVV2RnhZVExYcEhZ?=
 =?utf-8?B?SkNuYklFbjIxOFBVMGxYOXRBQ3dWVTE2YXRuSXJ5SVB4R0pWbTZTRTlHVkVW?=
 =?utf-8?Q?n1g4WkUuKtg+zUM0p5Ujytq+lRMl987KpDs9t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad28a1a-9e2b-4156-9683-08decab2b227
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:49:57.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoZbM0pqOCqL4zoyFnsrvBsUXJNS1cMnkWyfTyIgzEKJqzfI8rJJ9bWZtsOwNCkxysBrB4I9Mnx0ObU1u3x5/ad+8ixYlA9lJZfnsj2IzYepX+PAED+NIvwG6wfOtgHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12586

From: Joy Zou <joy.zou@nxp.com>

The driver implements debounce protection using a timer-based mechanism:
when a key interrupt occurs, a timer is scheduled to verify the key state
after DEBOUNCE_TIME before reporting the event. This works well during
normal operation.

However, key press events can be lost during system resume on platforms
like i.MX8MQ-EVK because:
1. During the no_irq resume phase, PCIe driver restoration can take up to
200ms with IRQs disabled.
2. The power key interrupt remains pending during the no_irq phase.
3. If the key is released before IRQs are re-enabled, the timer eventually
runs but sees the key as released and skips reporting the event.

Report key press events directly in interrupt handler to prevent event
loss during system suspend. This is safe because:

1. Only one event is reported per suspend cycle.
2. Normal operation retains the existing timer-based debounce mechanism.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v3:
1. Add spinlock for pdata->keystate and pdata->suspended per AI review
   comments.
2. Replace hardcode value 1 with local variable keystate in input_report_key()
   under suspended.

Changes for v2:
1. Add a boolean variable suspended and PM callback functions to replace
   the use of the is_suspended field per AI review comments.
2. Move event report handle to else branch in suspended state, since the
   pdata->minor_rev == 0 branch has no debounce detection per AI review
   comments.
3. Modify the commit message.
---
 drivers/input/keyboard/snvs_pwrkey.c | 60 ++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 4a1d04898482..d6ea3c2d87c6 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -39,6 +39,8 @@ struct pwrkey_drv_data {
 	int keycode;
 	int keystate;  /* 1:pressed */
 	int wakeup;
+	bool suspended; /* Track suspend state */
+	spinlock_t lock; /* Protects keystate and suspended */
 	struct timer_list check_timer;
 	struct input_dev *input;
 	u8 minor_rev;
@@ -49,14 +51,21 @@ static void imx_imx_snvs_check_for_events(struct timer_list *t)
 	struct pwrkey_drv_data *pdata = timer_container_of(pdata, t,
 							   check_timer);
 	struct input_dev *input = pdata->input;
+	bool state_changed = false;
 	u32 state;
 
 	regmap_read(pdata->snvs, SNVS_HPSR_REG, &state);
 	state = state & SNVS_HPSR_BTN ? 1 : 0;
 
-	/* only report new event if status changed */
-	if (state ^ pdata->keystate) {
-		pdata->keystate = state;
+	scoped_guard(spinlock_irqsave, &pdata->lock) {
+		/* only report new event if status changed */
+		if (state ^ pdata->keystate) {
+			pdata->keystate = state;
+			state_changed = true;
+		}
+	}
+
+	if (state_changed) {
 		input_event(input, EV_KEY, pdata->keycode, state);
 		input_sync(input);
 		pm_relax(pdata->input->dev.parent);
@@ -74,6 +83,8 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
 	struct platform_device *pdev = dev_id;
 	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
 	struct input_dev *input = pdata->input;
+	bool suspended;
+	int keystate;
 	u32 lp_status;
 
 	pm_wakeup_event(input->dev.parent, 0);
@@ -92,6 +103,21 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
 			input_sync(input);
 			pm_relax(input->dev.parent);
 		} else {
+			/*
+			 * Report key press events directly in interrupt handler to prevent event
+			 * loss during system suspend.
+			 */
+			scoped_guard(spinlock_irqsave, &pdata->lock) {
+				suspended = pdata->suspended;
+				if (suspended) {
+					pdata->keystate = 1;
+					keystate = pdata->keystate;
+				}
+			}
+			if (suspended) {
+				input_report_key(input, pdata->keycode, keystate);
+				input_sync(input);
+			}
 			mod_timer(&pdata->check_timer,
 			          jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
 		}
@@ -151,6 +177,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	if (pdata->irq < 0)
 		return pdata->irq;
 
+	spin_lock_init(&pdata->lock);
 	error = of_property_read_u32(np, "power-off-time-sec", &val);
 	if (!error) {
 		switch (val) {
@@ -219,6 +246,32 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+
+	scoped_guard(spinlock_irqsave, &pdata->lock)
+		pdata->suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+
+	scoped_guard(spinlock_irqsave, &pdata->lock)
+		pdata->suspended = false;
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops,
+			 imx_snvs_pwrkey_suspend,
+			 imx_snvs_pwrkey_resume);
+
 static const struct of_device_id imx_snvs_pwrkey_ids[] = {
 	{ .compatible = "fsl,sec-v4.0-pwrkey" },
 	{ /* sentinel */ }
@@ -229,6 +282,7 @@ static struct platform_driver imx_snvs_pwrkey_driver = {
 	.driver = {
 		.name = "snvs_pwrkey",
 		.of_match_table = imx_snvs_pwrkey_ids,
+		.pm   = &imx_snvs_pwrkey_pm_ops,
 	},
 	.probe = imx_snvs_pwrkey_probe,
 };

-- 
2.34.1

