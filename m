Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABD3CB2D4;
	Thu, 26 Mar 2026 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521504; cv=fail; b=rP6Z7ZaLfa5bcUaL5+zezNUXkf3VlEyVM6d0kXDKFzB2AQL1zkazMf2XRKZyTXaWM6oh8XM9h47kvh5EYeqppoQJGe4MgbVbAq3rG/P8Nr1eCFtUfVMpeakPLSgdaEG533NMoil33RhyZE+1xEZfjVh0Zg6/JzoIwNptiBejTII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521504; c=relaxed/simple;
	bh=/2/BO45Jja4fcC085rLdKcjKpiEWhLQ4uUt+3HA19g4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nsJUiZUkYml3Z1wmSd+zNPFwdAyt8cG9Q1U7yeHYumYxJQQ4bHsHApv+soRQCInFndyNl8cYK6OD71Q486RKVjCe7++rGYuo/Wmx7MPTmEx48jTKL8MWUlTjSCpfM2Tx6nYDkdahicHfPKMWejuHcd07RbNg0VQSODG+OJ8etfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K5SoM5hE; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K5SoM5hE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz+OZN8CRghIc1QloiQ/OOgemZ4j7c3khLqf8BlCu1REVN5gP8g3Ug3q/sdOMVJmcfZheR9M0S37uT7b3Px7wwUYbhhqDIP//e1mGscid+uHn2zlznp2ENjJY9ikh9rbB8qZT/kIK/K8VnnabmM9cbIy9+BcefLpB2Wc3267yTv4XUK54mpoUAHl0p2YWJcizmzvCTkRFG/NIzK/BdEgVj5HGz020k6/4blKWxDj5dTxCaxXh9wbdUIoE9nxJ0uWo/SLgN2ppMOrhnMJGTXN9BasEQ9CbsyKpsB1K/Hdzoza/0o5HFSpUdY1wfLwJ8EGJQvOq6HTicpOdnJd+1CulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=470TGF1THXUR8+txISwEJDWq/GamtjNHEH4q/KT7paE=;
 b=k7f0+gYAepf3jdsg4WF6zJ9mI1Y2TUIzB+BY+2nOyqYxiAcg2LxbriOJ3S7NaOcv33qPTSZm7vlY3TeK7qQLQdu+fKrplBwDDd4C/Yke+Eaw9A8n9TUJxHBxPE6J2oH67X1V1rziHjggo4+48J9a9VPr8BR8f8xswDG4wsacnf5+PxlPaQlDeKau+b4HPtQzpjx+8k+swrmK42ddd4lwJ4r8i8/qcFDsPKPLfOtX0eFsdf89xNCFr8WaSto0vs6UXBIKBvuvSf6Slt3Metx6W98s79MSjF6N0nqmAVjeIlMjcHjmg173yFyuvbdZ/Yufh8uiBbKIFFczWZNDQR2g7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=470TGF1THXUR8+txISwEJDWq/GamtjNHEH4q/KT7paE=;
 b=K5SoM5hErUUVfNNMhYbJhJzXDGBYQMofl0lmETKJT41laP5bEEGgddYQIwFn6RXpD5UmN9S3mZ9FwE7SGSEwvk3ZjLB+uIuk+6zK731lhdzv6E4Qm5y5jLD3fg2deNorNwgymekH/yMxBmQPWmR94OANysKAKdSX+TswFwQ57zPtPdWmUsDtWc12GoE57FoBYshbNxYbOIfhAePTS7aOHxwN7XaiCZPId+FeK+4xnGjw0+i3kN04CluXctiDCALljRUgqdSDSVd8XrXlYgb48X3RfIyKsOViZhOFZw+aurbPHxgvNkREzpfWDuAIYEnCE4H7EMeWODC2nmFfvYogbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB7765.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 10:38:20 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 10:38:20 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 26 Mar 2026 18:39:40 +0800
Subject: [PATCH 3/3] Input: snvs_pwrkey - report press event in interrupt
 handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-pwrkey-cleanup-v1-3-d85d7c0bf275@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf22082-abd2-4a27-fdff-08de8b23cc9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	aBjc9JdphpwM8S8X4M4bUkNNhsOG2EZHcVD6LwbyetlsnjuMAabzwb6RVkTQ2FhLQJxKUgiUG8ZVaORtooLzTN5KZ+6o0uYYHXtLD/rkijYKlx7f7FlnJ1fapBvn5GTEQbCdOkf0N5BZsim+BrFVvT4oCn9ktMqO2LaYNafF5NufYxRKMibKpjLxoZn6rhbVnl7GiF7bI0HSWDtkoPS1Oi0U75PjIQhbEM+X1QVJqobr4Hv2UPcHWXtDSQsn826ziD6theE9sNuU1sVHfAAXXJwhZdTS6seh1IgC5ycWelNk9Wf8IJpxS7m2i8jQ1gagkNPzZCOO74j+MZ+Nhym4HDjgjRrsDk92o9tackT/Wp6NUT3WZuKsvuK7K62Z9par+IHedpVxUQv03AXHKVdgETab2J/jdu8LktBEV3++qPwHln3wVBDXM/3ql+oCZ1g86S1H8LfnGK15VBEKzUgVoWsqEmmYCBRsVqXz8pcRo6zlwIQq1Oo1HGsKeCYk2EcGXdHmcsE//GrEHpz8PIfHcxMv3/B2PKpLpmmO1kyU+A50rdGuL0RE4bd8y+QMIfk3hdwD/+HMSUQ1KpFMpqYD9Qn4x8jrQRjLjAhZU03hIqjL3RooJiNMhhPLs4Tbhh3YkPiHqR5LTo1W6Q0iwvCm7bJ0be3+URARBh62J0RKn0hIYnsFDUpS/tCPFz60RhSqdsfsB/hrVY8KnCRVUAhgq3Kyr2tRqzINgnF2pC//za02Pv1lL83Krp0sWXl1hTKR7CUx6zjTDf1ZyKHXDkumuj7iDibfxWe1Xpw2/AgFaq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0Z2ZERrU0RHVXZ0aFUrcytkQUhRcEx4eE1mWFJqRVVuMEhtL2JQWWJvMlpk?=
 =?utf-8?B?V2R5M1ZhVS9TanVRSGQvY2JmYnc0a1VvMEt2MnJyWFl5eTc3ZjhYVE5mYi9E?=
 =?utf-8?B?RjZiZTVVM0NQdXpURVFaeDFYNzZaejlxSnJ1TFh5WHpUVUlvOVVBT0lhQXlw?=
 =?utf-8?B?REhqbkkrdUNRL0xsSmhmenptUTJ3eFF1NFZ3eHhnT3RUTE9Nby9LM1BValp6?=
 =?utf-8?B?c3dDdThPSExnZXIzS1M0QXc3VVZGd1VuUHIwbkZFcWJRUUZxNDVaYVNHTHUr?=
 =?utf-8?B?T2JGL2tLVzlNUnUweWh1dTZrMnYrcDJZVjRyL3c4QU1JelJKeFJwZXc5L0Fm?=
 =?utf-8?B?L1lUcGwxNFhhUk9ZbzlTZ1ROdnlXdUw1M3dmajR1b3hxaEJIYm41NVNNYkhm?=
 =?utf-8?B?blovakRYRmxkd3NkbGRTa016UjJXbDIyVStUa0dRVDVkSGlKZVhra2l5Z09v?=
 =?utf-8?B?ZllnQkk3TTBnZnR2NW1MNFc3M1F0YS9Fc2xIY3lMSTBVTGV5R1dBWTJaV29h?=
 =?utf-8?B?WEpJbnRIYzA1RGtZTTZSVmNXVnEvT3JhVGJmc3RSNmdody9nblQ3eHRuUXd5?=
 =?utf-8?B?cnhyUWM5bWExMWdDcDM2cVoyWjJjMW1WNnF3RGJ1cnJPc2ozYU9aZlpxVGEw?=
 =?utf-8?B?RDFPLzRrYjh1YUZWQ1NDMk9KVE9yOWhpRTcwckIwR0R3OEVTdkgvZ2tmWHBD?=
 =?utf-8?B?bWFpemtZZWNHYkVJUHpzMGMxZ0tFckk4SXZVb3A0N3FDbDZpaTFjMVlBR3hr?=
 =?utf-8?B?dlNOZWcyVkVuK29xRS95NEJKNzVvWWtpRFl4cFptdjZNUVVwZndxTW1oaVRM?=
 =?utf-8?B?S2RTbS90VzlkNkhwa1VzN1VZSWt4QmozS2ZNaTQyOENTUzJ3TktZa1pXTkt2?=
 =?utf-8?B?Yk80SE8ranBXL05iOUxib1djK3B1ZlJIMlNEYytYNTVkWVpybzF4cWZZSHdG?=
 =?utf-8?B?MDdsV29na2lpTGIrYlpkcFlJWUE3MTZ4YjQ2ZFRJMlMvankyaDVJcW42QVRm?=
 =?utf-8?B?aTl4QURadGhTaFprcklrQ3YxbFJMRkNrd0E2ODNtMVBwUklnY3NrMjQyY0Vm?=
 =?utf-8?B?RXhwZnQ4SzVlK1lHWVdWdlhnZGJ1djZPelVpZExRYWZwb2pLZkZYZjQvRFZY?=
 =?utf-8?B?dUx0RWNCUCsxdlFUWjJyU0VIZFhRRWFXZm85TWUyQXJNTzl3a0IwR25SU1NY?=
 =?utf-8?B?bldtM281S2VjeFphYUJ2UWZQZEZPclowVmZ0OEFhNS9mSEVCQkRHQUtWNS9m?=
 =?utf-8?B?c1ZTUU9maENrK2RUc2JMK3lDd2NNdzZVVllKbWVtalhiWEZ5blNRdGx5UnhD?=
 =?utf-8?B?NWpaWmZPK2owNzBWNUE3V0F5bzVRTFNJY3UxWjd6MTUrVnpuYVRKQkpyWi9h?=
 =?utf-8?B?Yms1YjdNbXA1amtMcXhqZE5tTzJ0RkxhQUZhb2F0cU1janpOWEgyVm51N1JS?=
 =?utf-8?B?QTJ5WUtrVW9nRVdVRWZQZkhkWGpmVE50YzNodE12bkYvdjZWcGRhYlVtbWIz?=
 =?utf-8?B?VWV4TzI4QXhiWG05NFRnY1ZhWHAvSm9mV2c0Rnp5TW9UTTNlbEt5OE45azRV?=
 =?utf-8?B?RUkzOVppL1RLWDBxcjhTbkRMQUpwYm9lNFluS3Y3aGM0bVJpVFhoUm5JbDVv?=
 =?utf-8?B?NWYxYklDckdDVjBDK2w3T0VnSjVVQlQvYzRRZDVHWHBFa0llVTVtMFpvNGlS?=
 =?utf-8?B?Z3RNVTBiVDV3TCtYUFZDWCswaWNJcXhTVFR2SjBnOExraldIQ1B5aE9tYVFt?=
 =?utf-8?B?MFNoaW5NRGhKWUExd0d2QzB4WWw4YjdXRHB2eUlqWmhXMmc3cUdQbVJucXds?=
 =?utf-8?B?dnpDMmQ0T1l5MlB6aEFmVkhvWmVBSkYrTm9teDBVUFBVbjBwMjdUQ2RlaEMz?=
 =?utf-8?B?ejZiLzU4Y0pJc09YQzJnUVJXc0ZOUkx6OXZOSWV5dzdaOUN4Wi9XcHZURW15?=
 =?utf-8?B?RFNpVWN3UXptcW9RaVJSQ0ZFZTZleFE4WTNIeXAvOFZRaE9YYnNENkxpZDFr?=
 =?utf-8?B?WXptKzlaaVRZRzBSUkltbVA3REJIMGpCWTF4RHlmeTJZNkRJRG5qcTVac0xl?=
 =?utf-8?B?ZlpyWkcrcnh6TUlKTDl5TmZzWmdSQm1iWlJZZVZ0L0NOTTdQR3BZT1pSUGlX?=
 =?utf-8?B?amc0NTFwSnp1VTFhRGdlL0UwcTh5dTQwYU5pc1JIUTBibkpReEIyeHEwakh1?=
 =?utf-8?B?ZVM2eDNUQlBHbCtLV1I3WkUwV1FpUk4wVVk3SlZ0VjF2RGdLMUM2b3lrY0Ny?=
 =?utf-8?B?eDhJMnVhYTlodnl0dG9id0k1eTR2NTJ3anR2azNHcEI3d2Rpb1Z3QXBCOHJ5?=
 =?utf-8?B?VUdTOU8wdWxaNjVWVlBQZEVJSHBTR01RQnE2eUhReWhUV0hibjhydz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf22082-abd2-4a27-fdff-08de8b23cc9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 10:38:20.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUlVjgj5I/E6GOElNRSNzx1btL5q9g/PaBzpyKRlHJsdorf4eAE1g60ZcYOjFVD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7765

On some boards such as i.MX8MQ-EVK, the PCIe driver may take up to
200ms to restore the PCIe link during the no_irq resume phase. This
causes key press events to be lost because the key may be released
before the timer starts running, as interrupts are disabled during
this 200ms window.

Report key press events directly in interrupt handler to prevent event
loss during system suspend.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index bab3ab57fdac77256be75a080773ea99372ec9c7..b557c1618d7369e872c6ce708a7b3017264ee385 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -78,6 +78,16 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
 
 	pm_wakeup_event(input->dev.parent, 0);
 
+	/*
+	 * Report key press events directly in interrupt handler to prevent event
+	 * loss during system suspend.
+	 */
+	if (pdev->dev.power.is_suspended) {
+		pdata->keystate = 1;
+		input_report_key(input, pdata->keycode, 1);
+		input_sync(input);
+	}
+
 	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
 	if (lp_status & SNVS_LPSR_SPO) {
 		if (pdata->minor_rev == 0) {

-- 
2.37.1

