Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D6432E69;
	Wed, 15 Jul 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107915; cv=fail; b=iL9Jxg3ckskgSSBlWGe48ENpQJ+c7LGGPUv0acZxFdTCEMqqApUBQEiW67dv1/jSTcEVAGsFAdw6/RyUj5wLq4MLEgWKoX9E370ED3Ar/qIel9q1gxaYhlg4eRMLDwh2kJfiVQQmQTea/RYMBFuX3Uqsc+UP11TWq5eJW/3Rimo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107915; c=relaxed/simple;
	bh=0nMx/B1DDmadKjqga69ELH14oqYF1ypYJI7bzhCQtWc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=boVnvk1bAAQ3mhwFnum6qgPqR959HXGhYi5TytOms9ITRqTt98MEb1wwK/g3t9F3EvZVybFhirJMH4FUxK3AzckAHzcStjHcCD0vNVMY7ScSeosTAO/qxbHA1J3MGRclVxaPVROmyyhV3Il8ltxI1obWKY/f8rcQEoBh7zGpwfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tahjcDGn; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tahjcDGn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5crkhkPVczLabQmIhVneeF0ZkmCbsxF6tUrFYHSDAiSwRGM5WztbqeP3msT4sFOIdWr5Yt5r9syJ81hO7RldeaPqeGPZ4ZtwdkJ3fVjS2i+dRM7P+u0gEa7S0A8urTxjPSPkqCIsImx5s3WcwEW/DLZPVmnfEbGbWlk/g3t8Fl01wgFuokESM/XuXMfUJCZREvIKGPrc8AtO84IsGW+W305SlA0rsMNODi4jBkpsui5jfoIJJhq6BtpKvhBqcpRAaGJj6RB+cyDGUX5b9931VfiZHmA+8t6ld2IDDTs/EBbS8CbPmiyk393gb4YgG2WtJiemQ15Tl0piPQqSgy2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1Czf7jtLJXh8pWbETfXupF0ks30LZ/uZjW8HZ1hqgY=;
 b=hiDT+n9d4cc/pmUAZLZsMpXkgbNRFqxX4UvKpAggB8IV+4h+31jXzu+kIoH7y4GbBVe2YvrpaPHXAbQFHHqfgPlweql/Gaq9venqIlTSiHeAfTNTINPgLZNxsf3AjY4WOuzsQyLHbnstUSzTGHJDbUYZAdlbkiiYQzClloeDfLlILGYbMsUE7LmHD24DcbE7VeWdhTEiFiHGYCp6Jr+KnU7nONvdhVrX06AjSYdikJnKXWAqD4Cq8T8jaCPTyfrIm7qykwaafDMRhRh54PlJDaJCS9fuLg4/PVIJ0o+G7a0Rz8IFLIyGmuASamAKa7NVw7epMMW5U/ho24WkL3R+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1Czf7jtLJXh8pWbETfXupF0ks30LZ/uZjW8HZ1hqgY=;
 b=tahjcDGnqp4DpNUO0tDvHn/gxvEwlfsgi1IDkbjSerYolZNvrFU9nomjYOpAsX28/wzEkVCZ2SW7QGdiXb/+d6Q+Kmi59q5qTuRjxOHEGT3aPnm9f92RXdXMAfxlDrH2uV06W42XH4u1enFw84uUO9gkb51n+PR+rhlaqxKaBQEBu7k7nEwr1rEi+VEK+ADvc7e7CxEVXczFo8Zw03ecZ+L7ND8sLdq9Fry99Yyb7dkO08qmSQTvKAT7H+sp1N0lF5V8OXRmsLCGE+/DThPhFA0hrVJdKReXjmOW075I+N4pqjb4GvtsgmyyW2rzPbfrSjEEog1irUGf3e4XZUXoJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com (2603:10a6:20b:a4::23)
 by AM7PR04MB7047.eurprd04.prod.outlook.com (2603:10a6:20b:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 09:31:38 +0000
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f]) by AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:31:38 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 15 Jul 2026 17:33:54 +0800
Subject: [PATCH v5 4/4] Input: snvs_pwrkey - add press event reporting to
 avoid event loss during suspend
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-pwrkey-v5-4-07e7353c319e@oss.nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DB8PR04MB5803.eurprd04.prod.outlook.com
 (2603:10a6:10:a9::27)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5800:EE_|AM7PR04MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 928692ff-58da-4076-2102-08dee253de4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VFTZpCaNaRyUFRbwdjunOLJd7mltsk+Ri4WKedKUTPkXDv1VIHNcdUIFkPLWj+aptzx+RqLIo/H9HPxiyVymYxzl/SesyQnTNa2+DvRhW1cdJVKYKl15aQqT4ZRFIXTLQaXw2Dw925FWAOcKUlQgOTLK4OHPaDjSuOGDP5M9yH944oQMJfXfycJAREIyjXnLbCcK9nSIqIlvtt22K8O6pcz9i0/QNo3jDl4jSHvkcOLUR2W6gpDTHhVt8mkTQHa/dOc8o6NSGLopF4fITOjHrN0PzGXh6ULymwl1Y6Xk+u1yekUvPK+1cPxYM0abBJVpjI3hwHWvPCBu4F50TEyUsja28aQQKd8HFqKQBrNlXXO1OqkyD0REPnJK2cq0wNg2MMvciQ89CKV9fyiEanWiWqoEGfIeuaezXVXuyK/KtI88AP+Vc9wPWHSBnPgVN79nZbtONFROnp9N6y62rY+V6OSP1atHhE6WkafXWNF2ApnZH7UlI99BCK3bDfpvUBxMOnULxT/tRGH99XkDdeRUywHAXqNivCcQbfR3nrpCIjlRccNxjzxGXKFsNDtvx4IlraIVtJPokKgOxn3w99UtKZLntxDUbfh0Xti2RfWKfLQtspQy694VfIZfXvxqMxrrVcvIysZDM2ZhF94qJEKfRbmwgXudB2pl721I0D/SWsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1JuYnhLeFRBY0NmU3ZtWlVITzk1ODJJbVMzRjVqR0NhcUlyN2hnWG5qOFRo?=
 =?utf-8?B?ZlRrc1dWcVV4akcya0U3cXFFWEJOamx5V0c5dU5SbEhqKzYvdEkrbEw4NmFt?=
 =?utf-8?B?YlhOd0RaWkN0ZEllQ0s3TktXNjQ0Y1BDVkdLS1ZmWE02L0hPcXpIZ0Q5MGdQ?=
 =?utf-8?B?T29MZTlvSFlNVTIwQ09ZVDV2SGFzaENaT0h2aXhjSnFFejYyQUFIWXRHa2ZG?=
 =?utf-8?B?UEhZYmcxalRMYVd2cXFTQW9YamMxU0tVMWwrbThFTUN1UEM3bTJuYWpkV1Nw?=
 =?utf-8?B?elBXOHp4Sjl3RlRLcEJPVUtMYkVqYkMvaE1YaitBYUlURUtkUUZZRHZQK1lo?=
 =?utf-8?B?dzlOUDVlTzVxUXpiZ3RCc0MydjFsaWppU1dSSUkxM1hydzRSRE1xWDFQMWsy?=
 =?utf-8?B?dFdnbzAyVHc0K3ZQYll2SGsybDVYNjNHdlFqZnNpU1k2dHpWeVJDRy8vK0dw?=
 =?utf-8?B?aVNXajRFUTZTVlFxMzJFZVpWZ1NlUE5tWWgxaDB1Q2cvV1d2VTRvUWFFa1ZE?=
 =?utf-8?B?TU02Smo2cmwvaVppRmZmb1ZneDE0SWYzMnVXaERDSDlxYk9Ham5BQ29RWnVz?=
 =?utf-8?B?QnFzMWJaVjhmdGRRbkJTUEdhNEErWE83UnlFVlR6alUwd1pIUnAyUG03RzlW?=
 =?utf-8?B?QVZRZXNEZy9VUEZ3bHQvL3hvTWlaKzNoOGV6cXNDZkd5akxReU1ZZjRkRmNC?=
 =?utf-8?B?UGZmU3NqTTlQVlM0SmRrY1d0QkE5eFRmYzhsdldVTmxYdmpjd2dpZVhMbWE1?=
 =?utf-8?B?U1kwNFdwV3V5TWJCNjFlUEhRV0pLbHRsTEM1Z0h5KzR6UzRTL0dDWWZvV0Vl?=
 =?utf-8?B?NFU4OHQwbWVFNVNsNzBsSUVaRE9UbUtrRzAvZi83S0E2c3h1RS90bmNaMjZE?=
 =?utf-8?B?akpGQzRyd2FoNDF6aW1YNmdWNktqOWNlbkc4SDBiTWNwUDZXQ0FKM3JXY0g4?=
 =?utf-8?B?L1B1MmVuRGVyL1czWTVSWVBFZklqOWNja2tTVXZISnNzWDFFZzQ4MEkyN2p4?=
 =?utf-8?B?OWpwMXhkcFE0ZHVEa2FJUytGbkZTcUN5T3ZuM0NxSDlValpsK2V6TzB1V3BI?=
 =?utf-8?B?SGZVM3Fzb1RXem84Mk9VelUxeFF6dXZvK3lLMmRkOVFXMWtTa1NhWlMzOUlZ?=
 =?utf-8?B?bDU1SEdSME1vTEhTWS8yKzUvMjNVUmZUSUVxSjZWQkwyOWtFUzJuK3JWQnUy?=
 =?utf-8?B?VjI5UFR4NjJUWkJmYlRQV2prWjU0WWtWMTJqOWJIdGFwb25JblE2ZGwzektz?=
 =?utf-8?B?a3BLMXorQzdCVitIamcvMlJCOFlnSTRYSnFTdkJlenAxc2pSUW00YVd0Z2gw?=
 =?utf-8?B?cW1wL0Y0SW1mdWxzb0g2MTdQUmN4SXBjbmIzNnpLdjRrV0NXQmVXT01JaHJj?=
 =?utf-8?B?ZWczcC94ckNUR2VJOWJFQXBsTGFRUXpnMEdnOEFhY3dNOHdtVTRkVERaZCtW?=
 =?utf-8?B?SSs3K1JUb1B5azlNMHZPelovSDljS1NuNWVvWEZDWmtxWm1sZjFZUzgyU1lB?=
 =?utf-8?B?ZE5DdzJQU3Z6VmNpaDF5TjFaUkROY0h4SERYZVNOMTMvOU1CbUZPWHU5YjFI?=
 =?utf-8?B?a000OUk1NVFEMWN5d3FRMWRvaFo1VC8wNTFpOGJrc2pSVFcwR21aV0phS2VW?=
 =?utf-8?B?MTZHSU1NWS93N01EUmVqSW80ZUQwNlU4ekZVS2FaanJrcFZ2VGJaOHEyNnBt?=
 =?utf-8?B?Y0txQThOY05uU3BqaG9uTlhsbWFkRE1ramRHdTExN0l0d1lGYTY2a2VFZUxw?=
 =?utf-8?B?V0gyVEUzM2FENG1CMlUyN3hoNEhoeVJNZytyUEJqYUtIeGVqVC8wMnMzS0Ux?=
 =?utf-8?B?Q1ZLaWNubU1CWTZTN2t0OVhoL3ZvWVdEcHVqcS9HN2ducUVaZHA4dmxldmtN?=
 =?utf-8?B?M2hidjhFQitUekNoSUxTN3ZrNmpxTDdMR2RLMm5oMFlYeXdjYmVpL1VReEQv?=
 =?utf-8?B?Z2FqUjN1QWNIaUdGM3I1VXJZVGVLek5Rd20rNUtRRmZBSmIyS3NSeW5oQVh6?=
 =?utf-8?B?N3JDeVd1RUxVaUZVWDNSUXVPYmhQZ0pTQjB1MGo1cWJHY1dNb0d6OHBCdXRM?=
 =?utf-8?B?MG5qS2M0OS9PVVFLa1NZUFBiN3Ura1ZISSttbUxVSis3UWJVVWJTS001TkIy?=
 =?utf-8?B?RUtCOTNNeXBHeFdtWmtkaXl3eENlNlMvT0dVNlhZZTRIUFJPMnYrVzljb1M2?=
 =?utf-8?B?amRlV1RZK0hBaFY3TTJDaXFKR2NWMkhxclE0OWtjR1RZNCtkY1Vsdyt6VkZY?=
 =?utf-8?B?Q0Z0V3BYem13TWhyV2hjVE05UnBIRlAyVEJuWDdlRzJvQ3Q3STJCTUhrNktx?=
 =?utf-8?B?STJCV3lvZHB6K0M2clVaZkNUL2tKL3ZpTGZJN3g2K1UxUGErMXFBMkFrS04v?=
 =?utf-8?Q?iKTIAAG+Ksfdole5Hu59a0k6+hVx/ZKwCP+Fp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928692ff-58da-4076-2102-08dee253de4e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB5803.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:31:38.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mii95toH/U17qL8olxFeHApGtfXpXFNcZlaUJq1VbF7lNoBNWEcLtGwfXfYGQP4a1umiAdhlFD2HpE0ogzVpTLEFIs0yYqUbpO1Xdq4mfPGOau+ABYYihGZgX81mcC7/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7047

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

To prevent event loss during system suspend, set a pending_press flag in
the interrupt handler and report the press event from the timer callback
when the flag is set. This avoids out-of-order event delivery and keeps
the existing timer-based debounce mechanism for normal operation.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v5:
1. Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS and remove
   __maybe_unused from suspend/resume callbacks.
2. Use pm_ptr() to wrap pm_ops pointer in platform_driver.
3. Replace suspended flag check in interrupt handler with a pending_press
   latch: set pending_press in hardirq context, consume and report the
   press event from the timer callback in softirq context.

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
 drivers/input/keyboard/snvs_pwrkey.c | 72 ++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index cbe44a38d2b3..970c7d65bd57 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -39,6 +39,9 @@ struct pwrkey_drv_data {
 	int keycode;
 	int keystate;  /* 1:pressed */
 	int wakeup;
+	bool suspended;     /* Track suspend state */
+	bool pending_press; /* Key pressed during suspend, report from timer callback */
+	spinlock_t lock;    /* Protects keystate, suspended and pending_press */
 	struct timer_list check_timer;
 	struct input_dev *input;
 	u8 minor_rev;
@@ -49,14 +52,38 @@ static void imx_imx_snvs_check_for_events(struct timer_list *t)
 	struct pwrkey_drv_data *pdata = timer_container_of(pdata, t,
 							   check_timer);
 	struct input_dev *input = pdata->input;
+	bool state_changed = false;
+	bool pending_press;
 	u32 state;
 
 	regmap_read(pdata->snvs, SNVS_HPSR_REG, &state);
 	state = state & SNVS_HPSR_BTN ? 1 : 0;
 
-	/* only report new event if status changed */
-	if (state ^ pdata->keystate) {
-		pdata->keystate = state;
+	scoped_guard(spinlock_irqsave, &pdata->lock) {
+		pending_press = pdata->pending_press;
+		if (pending_press) {
+			pdata->pending_press = false;
+			pdata->keystate = 1;
+		}
+		/* only report new event if status changed */
+		if (state ^ pdata->keystate) {
+			pdata->keystate = state;
+			state_changed = true;
+		}
+	}
+
+	/*
+	 * Report a press event latched during suspend. If the key is still
+	 * held, state_changed will be 0 (keystate already set to 1 above),
+	 * so no duplicate press is reported. If already released,
+	 * state_changed will fire next to report the release.
+	 */
+	if (pending_press) {
+		input_report_key(input, pdata->keycode, 1);
+		input_sync(input);
+	}
+
+	if (state_changed) {
 		input_event(input, EV_KEY, pdata->keycode, state);
 		input_sync(input);
 		pm_relax(pdata->input->dev.parent);
@@ -92,8 +119,17 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
 			input_sync(input);
 			pm_relax(input->dev.parent);
 		} else {
+			/*
+			 * If the key is pressed during suspend, latch it so
+			 * the timer callback can report the press event in
+			 * softirq context, avoiding out-of-order events.
+			 */
+			scoped_guard(spinlock_irqsave, &pdata->lock) {
+				if (pdata->suspended)
+					pdata->pending_press = true;
+			}
 			mod_timer(&pdata->check_timer,
-			          jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
+				  jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
 		}
 	}
 
@@ -151,6 +187,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	if (pdata->irq < 0)
 		return pdata->irq;
 
+	spin_lock_init(&pdata->lock);
 	error = of_property_read_u32(np, "power-off-time-sec", &val);
 	if (!error) {
 		switch (val) {
@@ -217,6 +254,32 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx_snvs_pwrkey_suspend(struct device *dev)
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
+static int imx_snvs_pwrkey_resume(struct device *dev)
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
+static DEFINE_SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops,
+				imx_snvs_pwrkey_suspend,
+				imx_snvs_pwrkey_resume);
+
 static const struct of_device_id imx_snvs_pwrkey_ids[] = {
 	{ .compatible = "fsl,sec-v4.0-pwrkey" },
 	{ /* sentinel */ }
@@ -227,6 +290,7 @@ static struct platform_driver imx_snvs_pwrkey_driver = {
 	.driver = {
 		.name = "snvs_pwrkey",
 		.of_match_table = imx_snvs_pwrkey_ids,
+		.pm = pm_ptr(&imx_snvs_pwrkey_pm_ops),
 	},
 	.probe = imx_snvs_pwrkey_probe,
 };

-- 
2.34.1

