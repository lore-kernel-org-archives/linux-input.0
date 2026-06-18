Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448273C943F;
	Thu, 18 Jun 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767769; cv=fail; b=pqIF/P9/tPr+5qqkSBZrkrAZgOeLDAl6+WOqs56vjF3rTeQpfi4Q+6/OEMwVcUcp/MKNIwJobVVYcJYUFWFfcHseWPZBHrpSjd5xsVuhga+6fFCxghxWx9zK2D3N9aTVdEVqKRAtPI4jy0utzfafJzrVZw2P04QSSZ3p9qM1+XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767769; c=relaxed/simple;
	bh=drW4dsnI339pR777yzuDqleQKr3giiq4ZP9wvQ9mjEY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n/gyS63+ouFJWgqmPHBnQ78oDwpoWjU0Ev1N+9W1PQF/5k8nG+PlYOd9kYAVQS+EVsBUGcLYIVRwxeB5u1zCDC0q1IouxizfcoD4O/6Ww8XS5gTktwIEr/PvQSOS/L4yneq9jC+NF3uo1NB/CZVu7BarKWZ7jcwHIB4ZOK6t40g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s/uTWWfK; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s/uTWWfK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qnjp+w3awErYWTR2PhnLurGR2Upz09U6xsX+7AaJsMUUcqqd1jP3VqTSI5StZ5j40Hh8R7RZ9fWq7E2YkP9Qib4rSfKEKP1mp0XRp4uBRfb8CHwlQMSFuEH8IFjlBjWaU1MDWN9zr5QyPOnp/I0ipT2HwjkW3g8JP3eg0y4lvYKeWdBwpgCDzMw5cVwTbFiESjvtE44DTapE+Ub+52IwP5kMCCQXp/t9/5Rzg2eGvt47Cuir+U5RMN6PCI/be2Yxm8Z2Kxa41beIuSExje0hrdfsv2N+64Hi8DHH1Rnkua6HHMCw7W/O71wD4csN806aYI79Q6KJxd6mz7yF43xtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaRTu4zzQP3iSz56PcXqi+9vv8i3HD6cMl6Rtpk+zBc=;
 b=wtO248r5Rai9Z6BbNIy2x9+6llp/6qZsD1s/Xn6QyOn6Y/SteX10IjgW/MyMDM69agUziGDuPuA6Pf9vYyUL6fjKCSgJ3FTbfXyCLT2Gl23iASYqE13whIzi1cbMeDNp4VxO3nCDUYdS07z7Ge5ETbSkOLS3w4sD9qb15fND2HvWOB1QFlnZBA5FVUfVJ8a61DCJE8OUDWPeFNNHLS2qT/natLRp4Vs0UaPNIZqRCnGmPVWV8sM4RMZ33tdsupm0wCqQJxe6zDy8sytryTuI+85flJJwRninSl/II7Kyyx5cOdKLMHQh+9ujzpTyy+clbA++Wkj5nEgxJTVE+xWtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaRTu4zzQP3iSz56PcXqi+9vv8i3HD6cMl6Rtpk+zBc=;
 b=s/uTWWfKEG/xdKqnBmXoYXKhD5gjNuyrNrdwNf8hrPfjeJhrZiDFA+XFkkGCN3uGrnBH2ltQsVPkzUlfKriQ6Yf4BMbv6z82Z7pp2YTxiqIFv0s+xideMynE8wC3fKrAyK6vHiQaIf/PEBLZBIDIbvmoePaxMMcxvzLkTherpJ8wMzFDnSWQjFaDXbEN0dx05BBFlB0MMJzxw6y9aK2Rb3HdprqssY10+7zc1CK1QQ3+I6KCJA1nbfLT0RL+NgjFRlqsjimOA8c43OwlfOR3W9Ih6Xf/vePQsfD5qlbKM3WnZOZaHbuVWzGYZgtBJDLziW3MNqSAaiCpiHzqLH91Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PA2PR04MB10157.eurprd04.prod.outlook.com (2603:10a6:102:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:29:23 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 07:29:23 +0000
From: joy.zou@oss.nxp.com
Date: Thu, 18 Jun 2026 15:31:49 +0800
Subject: [PATCH v4 4/4] Input: snvs_pwrkey - report press event in
 interrupt handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pwrkey-v4-4-4bfda105bdf3@oss.nxp.com>
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
X-ClientProxiedBy: MA5P287CA0159.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::13) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PA2PR04MB10157:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fcbf97-bd0d-4070-bc07-08decd0b51bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LXMeq5ldxfV8c/nG7HelB+daDK3Y8spKwzTa9We8Vikk/VJDkt8fHFxaMlYxr1HJD3dIjpzgnv0zIXiThDQ2GG2vfr8/kFu4MggiDlzHW3fWDnDxcXp2HpO80Si0Lqkzuy/p0UF/4qzSx53IyAYECCiPTqfWgTznWVuaZGjCMTztLjg0n46/ovmhCpoPVmZt6cQf8RxUnhxpjrx1gIkTwjNHGqQiaZiF7WWebUa7yTpy7WJfLmeNqZV6X/NjvyE2+ibsh8azPS3g4P1q0LDqw6dQr8aLfkWKOi5TPzCpPmrlv48UY8pTkpP56sBIPRX0qoBlx5CMBBBZd1CZlT/atXB6BHHEC3spf6yZCGhc0mxm16BoIcVj/D2ijK9CkrdokJ+SmECiSrs/eYpl7uvbWtdNB1eDFmF8Q6chSwlrSqLR6kyGMwdBOar9e7Dqg22ixLpp0P5p7tCxFWuxYPrZwFwe68WoyucBvj0nG8wH1j/iUBSfgIH+FGm6sVIV5e15USMwX0V0pmpUArP91WuHk1xgj8MnSRrK1sfT5ueDLclG2H3vx2hmdWcUaBtn5n38pikq8WAJKPFGoD68RpLuwqK7gCgN4TI53aQhkr5O1dmRAuJx260lHppGg1wpFUHTIqfh7j6dowIPaVYKwHFMwMF3T5KbE/22G+5m9hK12gWE8Uq8qTPTRi442YD51QB9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzZ2NmNvdHhZSk42Wm9Dc1ZZWm1QOUhyd0dkalZ1VHlERExwdjgzL0lUSytL?=
 =?utf-8?B?WUJrM1ZoNklVUmJCVFNpR3lnZkxIU0E2TEJZZ0hIeE9mc3dRQ09GbmsrVnJU?=
 =?utf-8?B?ZXBrTC9xSnIycEk0QlRFZWxXK2VDQXBDVldPZkFQZXVySGsrZnBtRFNxdnAz?=
 =?utf-8?B?T080TVh0TXUySHVjbnJQblpKckxoVWluWUw5eEplUHZpN2gwMGJWeFNBSXhu?=
 =?utf-8?B?blRGMU9zZ0wrRVJPZVZ6ajNCblNiYVhvNWFhcW5Rd2htOWl6UTAxTmZVNkFU?=
 =?utf-8?B?RVFFQW1EWVNSZUNOWE5DZ1lNOXBxZVFyellDMDV3eStNU3pKR1dZUEhMMG1w?=
 =?utf-8?B?UFpOcGs5Qy9meEpDSytrb0ZXTitjZjZ1NlF2T1dGZUpJV00xV2lhUVNFMXh3?=
 =?utf-8?B?WWdYRWVDS0p3Q3Q5ZExLWXE5Uy9sQy8xa3Fibm5Ra2hIcGhmR3JrT0lQZzRw?=
 =?utf-8?B?a3FtOFhvSEc5bk1CQzQ4QXBFb3BjcDBlOHJkc3V6OTFrZWwrRXZRWVEzbjEr?=
 =?utf-8?B?dkJDd2N4bHlZdFVqalZLZzBNSkxkcjRhRmJXbThnNzJZcGg5QmhLYnhxamhr?=
 =?utf-8?B?S1UrNDFZQXJIVkw5TXE5NXZwemhZRm9Md2VyaEY0WmNxc2gyYmJNU1JFN1Y5?=
 =?utf-8?B?U1hyd2J0SEw1Mm5wNGVkcml4eXBQTDZiNWtTNGszd09FQi91a2FSOC9NMWt5?=
 =?utf-8?B?dXVua0JlTHBxemtOdW8xSDM5a3gyLzJNY1hYWXFUQXZOYTlqWlZLNldMKzZ4?=
 =?utf-8?B?bHJ1M1hXZnIxVUd5aEdaNU5xRzRoazFzeTgxa2ovQjJuYkVVOTFvdGZSS2V1?=
 =?utf-8?B?bUdKcDVLREZJbTUvTUx4WXpMMHI1WW1lWEZxTXAxeUlsRU13R1BBU25CeGZI?=
 =?utf-8?B?QkpsK1AyTnpPTjJobExRenJhazF5bkxXZFAyLzhMZllxWVpSR281bFBZaGpY?=
 =?utf-8?B?clVPT1R0cWszQisxL2FmQk1uZzMrZWtHUFFoeHZNa0p3SDlDVWlxQVNVYUxY?=
 =?utf-8?B?eGRvNXhndGRDbkRTdURhS1Q0aHB0L2xOdFJ6VkdZZEdZRDNIUHliUjB2Rmk1?=
 =?utf-8?B?RjBhV2VZdWFadDkvaWo0NEJKbXJyZ0dtNHF6a3VQNXpuREVLR2FPazdCbGYv?=
 =?utf-8?B?UHloYlVPSXc0RXhGWmhvVjBFU0gvaFpkTEh4alVtMjNDTWVuUy9OZmdxT21i?=
 =?utf-8?B?ZDlVQTBObFVLcjFyeXhxZjVCekhieDNMNGdxcTJYTXZybnV1eFhpNE0wOFVC?=
 =?utf-8?B?bFpOZGYyL2UrY0RjOHpFVlJmZytsVHFJa2FrTnJyaUcyWHdjUHN4OHEyKzFM?=
 =?utf-8?B?cG5RaCtvQkhIcmpjWnVIMWFHL0M4em91WmVHNnllZXFWNVY0KzZ6dDI0ZU1n?=
 =?utf-8?B?OTdKZmNQQVEvYmtNdWhPeVA3MWI5R3o4cmw2ZC90RXp1VENMWU8vaC92Wm1I?=
 =?utf-8?B?MWJYejBLdS9BNzVnRlorVkhCd0lqL0tKejl0K0c1eFpQQTZIdnQ3MG1jTFV5?=
 =?utf-8?B?bHcrbG5vMXIvcys0Q3BSVmdQMzMydU5YS08rc1REYzZzbks0R2d5ZjVEN2or?=
 =?utf-8?B?KzcyWTNzeUFKeG1weXE0eUdsTmcxS2pWMGV1UlMvR212NTJtZ2ZMRURVYmNO?=
 =?utf-8?B?YWZtdkpYM1RsdmFQQm1GMnV3eHFjeWx2LzNicmF3NUxQV25kRzhZcnZWekJq?=
 =?utf-8?B?Nm0yVndubzB2MmhMb2k3TUVranduMncxUldoTjVkeHB3TDl0WTdWb1ZKekli?=
 =?utf-8?B?bW5BNXRBSmlsNUg0MjR2QStmeGo5WWkwVTJmM1VLbGNSL0tiTVI2cEMySHYv?=
 =?utf-8?B?a3JRcEE3MjJTSkZCSFZvZERFemVmR2E1RU9rbkMwNlJYUXhXTGhVMklneHg4?=
 =?utf-8?B?Vkh0ZzBscVI4VmZ3UjBSY0hUa0owM3ovMW1UQnBpSUVCM0RkSi8yMitKZFk1?=
 =?utf-8?B?cjFDb2pTcjlNUDBYTGh4YlhDbWxIM1dqZE5XUnFpT2VWMEh0QUlwVlJGZE5N?=
 =?utf-8?B?QjdqMVFHZ2M1VThQZ0lKSU5wMmUvUThxODllUWk3N1VCVjlCTlJHSGdTT1BD?=
 =?utf-8?B?SCt2R2RuNUk3M2V3aWx2R1l4QUNUSDNIQVRTU0lsdjRRMlFaSENaUWViVGJF?=
 =?utf-8?B?TnBZRFpNSUtYV0NJOFYvNHBoeFMrQjJYeXE0b25oRDZoK2xad1R3UW8xRmJo?=
 =?utf-8?B?UWNDMnNINGhCcFpuZHRxQXhTallqQjd2anFCK1RwMnBzc01uRW5IeThHMjdX?=
 =?utf-8?B?emxWQjc4Y3l4VWlYWUJEMWoyQ1FSK2N3WXhUNjBPNDBYTUZPZzVhaGZUbG1W?=
 =?utf-8?B?N3dmRVZOUGhCQTh6cElDZUdQb3AvM1EzSnRoQUVYVG1XY2xzajdFc2xSdS9K?=
 =?utf-8?Q?6uclUt/WfZfNDZzmTrEE3tqRZeLhjvBBlPhH8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fcbf97-bd0d-4070-bc07-08decd0b51bd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:29:23.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTuvLM2276RpVvQoGvoNqvKFzNlpzZiEXZsKyBm737DXQMx1Keu3MBba9j351+aaJkuO0A/Z7X4Y+i8vl2IjLylS5GRqsbiOk64nmuRVJnjsjPSkfbIfj5FMGj8c2zGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10157

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
index cbe44a38d2b3..98c33d0bb1ec 100644
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
@@ -217,6 +244,32 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
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
@@ -227,6 +280,7 @@ static struct platform_driver imx_snvs_pwrkey_driver = {
 	.driver = {
 		.name = "snvs_pwrkey",
 		.of_match_table = imx_snvs_pwrkey_ids,
+		.pm   = &imx_snvs_pwrkey_pm_ops,
 	},
 	.probe = imx_snvs_pwrkey_probe,
 };

-- 
2.34.1

