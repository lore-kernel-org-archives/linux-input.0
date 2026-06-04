Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855833DB300;
	Thu,  4 Jun 2026 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556074; cv=fail; b=CEkXwPzySD+bEcnBdmjdSvA76bbRsdii98W/yxPH2x+1CK1/T2imxilqqqis2MnjAi3ytkDOSX82lRcxTKlU+Ji/10/pCN2YLRT4Iydm/mxeG6PqxNUHZzQn08QY8xmFQfz3YrD3iGSffdTGjNwki6Cwp24V4ktySYm3ktfUlBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556074; c=relaxed/simple;
	bh=VtnbJvA8pYHTvGPkWduDf6BpOxv61YXsuKCYOh5WtDM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UGYUxAP2u2SxnVlJ+nSYb1JvosK0C3tS2oxTorkck8l2+V1RDZcNtaQbrNtxOSVhYEnkYv2OQ5MbYxfI2nmcM7XvNBCxiH3FBDY+G/oUF8mfTHGJRXKeiAPnUSYDEqk75gAbEAdXxBp+R8FeyxDP4HSPujzigR9sqcOvq2OUkFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EWgsar/T; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EWgsar/T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbPrUgwIPOXDvvoxIHHF1NOdJ9ppmS9+i2HAqUSOuNhb4MzgyMiR4Bk+fl3jnsfzEUff6DG8DX8UL2OBJz2surumJkPwBZ/Me9QQXAgkWsodKckiD800z1pquzIjt8ca5dh9GralAls4BwaHnd91TL2r3IeNc1afz38F6Lz2aAhE1xR9nIi17c2i94mIX0NU+qpdYC7uM0eypYDpbdOAkDWryKV2Ei0KUUo9jgtZ1ZKUSj19xdg1/3NAabQVvMf4k75Og/KKMG++N1OVsDOGOWVYbUYnnm/qG8txjyasarInqcBbmSm7bq2ZOuzuyVH8UZEPYdSvVf3BuP6M2+nX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0We7+jtSkoS2dN3coVMBudYg269pJSvY3jFfLyh3hc=;
 b=vIfBllsgjocadn1w4HIWpfSZqsEnw/tuRBAbQCE6JzwWVyPBU+FBKwoSpkBLutVelfUyRba+xUUTCI4WDkjTZZs6V/K4n0S+SIiLwnadMH7V5Sqsu1p6eELWN1AvA3EhBIXh3yoW9HcA3CE6UFU2ynBgZ3NfA8HWKn+cD84SoM1tXopv/W2/HMKvUtjpxHbvdg4z8GFs54xs8cBkzKHqoQs1/gJRg8Bj0leD51WPzVHC/8bQvPEBMGC6FlS+VzQlCyu8mKCer7N1jSp6rcwQa/Usv8cIAgYCjm/zjV35+VBSWOa6qYlgOcjOLSvDsPHnD7VAnPHWRYbIpQOCgirEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0We7+jtSkoS2dN3coVMBudYg269pJSvY3jFfLyh3hc=;
 b=EWgsar/TSTwiYNHOA1gU4UzkZdFF8t16uS/bhqtxSZUQbBZMx1DfjoCMeYguyPmq3G/iZz2OdLPk2NRGX5VsxnHkTUNq/nuPwxwwA0R7TMhcIg9AOdPaIvZxsOXJg1rMMf/5FpDdvv9LtvbPRz/zCnveyXkPLhmCYwYVxnbLQhbJ9XcZZRK+p1RXHPUPb1cx6WjWhufJYCQ/Y/Rsq9NHawYeU7CS3ef0yJbYw2ORxKjUjZbHEsEucm822RNyDDoUWc/F+xz+NdI4aEtGv8aIZ/UXoXR87OfioZxhscrLHwL4/9twonTFfRZP7RVkoE9MKEgzMLG1rylLDwVJSjldkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:54:29 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.21.0071.015; Thu, 4 Jun 2026
 06:54:29 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 04 Jun 2026 14:56:24 +0800
Subject: [PATCH v2 4/4] Input: snvs_pwrkey - report press event in
 interrupt handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pwrkey-cleanup-v2-4-59fa0ddf0d7c@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f84b0042-516d-44d0-0311-08dec2061ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|366016|376014|38350700014|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WLiiEX+v8NVUy/V/07QkAOHzkBphub0xkfQB7rTJfMKPVAQXU7ZlXQJzQYRJ75Act6X0rgp9ZNASGu/zLkgNcOljzMjXDYwC8nWdWesiMvuHmJyPd/GzXC4riDz0uJzPNpRIMKaXWYVBjXhCdu5DPkLpPBrUipAR/T3UUinxcbHTy4ljRgXQ+/UcW5lFfZVwcalH53oQOcoCMqGQWcMXjkbOD/6qaKz3pWQjCvlm8WCZvzjxXPmqRV+BKVWRRE5QRkCMEkc0a42jDTta7vPs1vt2AZ3/u/50k9gk45MUkh+q4y1AtuJAj+JP9Z5/Jjuf341RiAH+CJLH+809E6PXlkcIEwKrsWX6iYQj4QzlYNYhqUNKtjVUPUnkVQ3jVw6413+jfHYhTl6rQ3Cf3kcJwKULf3y/DUxz1OjSu6d4SjcKbxTjRu6MTcfNK6ofjWLNm3dijrdZwaJjqMIlzstbM9LDdL0XovH/8ltJLdRFvck8sef5Rbu3pmcRyo5rOGOAINA3renJMtPptHboMPuGWCNlVk34LQWjOys2NOvlPqrL9oVDgedd+mhY/fuB9XjzvcRNqe9LyNaNyZh/tblVRxkSRUAT8vqM/LjV31OUT/fLbqMsYfQgnX7iiUUwrGhO0kjWCk+a9J44wYH0QUeUqySEMFZYOaUrBxYHhfrcPS62BpFEiPoydDKwMuAtLKEfS2rghMSBT7lE1ikh66cUpplSqEX51X2dvMbKzin6UBBA9yRo6YdrTkajnNI3jVNo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(366016)(376014)(38350700014)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUhkRllqMTRxVm5Zc1BsUkt0Sm5SUkw4dWsxdkhNVER6VlZCMDRFRFdQVU9u?=
 =?utf-8?B?ZFF0Z3VCczNqQzFDV1RJajRkcUFLc2c0STFUWW54S292NWtpc2tLekJIUHdZ?=
 =?utf-8?B?S0JMNnlzYXNIRFRlaUh2V1dhdGcvS2pIYVhpaHN1dmpaZVU0dWJxZklRQldR?=
 =?utf-8?B?S2R1UHJwS2ZMc00yVXFRV2VMU0srVjNmaDBHcjdZVjd6aEpEZ0NKUjZySTJQ?=
 =?utf-8?B?amQ2WEYreGlCTWFrL2Z4REdRSDJRbzJFQlc4RlorMlo0OXBoaFhwQmwvd0R2?=
 =?utf-8?B?eExNMlFTZWlibWRadExJdGJGam5hV3h6bU5xM2M2bnFaOGI3cmFMWEFoL1Yr?=
 =?utf-8?B?VWxtQTdncm1jYklWTGszY1B5aFhBKzdURkgvRlRPMFo0N2RUWjZuSGRMYW5F?=
 =?utf-8?B?Umtnd2VESXZkeGFxeFhsOXI5U0g4WE9XbCtKQ3l2OFNFSmxqV1ZkRCsxREJh?=
 =?utf-8?B?RmJPUzU3SWNwYzhSbUw2bEY1NTk1K0JrMDU4cU43MUhPTEtDU0ZHYnh4NXNp?=
 =?utf-8?B?OGhyZGNCUit2cysxNE81dUxoKzFodmlCS0U3SmhCMExMRG50bzBxM2hrV3pq?=
 =?utf-8?B?MDgrYTJvNGlJTmdhOFpTT3krZjVvQXJ1bW0vTmVNNnBYclRwbnVIMzdmK1lT?=
 =?utf-8?B?Z292d1pGM2Y1RVBLWE44UFVWNkFtUHFEUUV6aTF5d2E0eVpJSW8xc2dsUWZj?=
 =?utf-8?B?WGNzaEZLNldualRsRVY0SGNhOEFBcU44VWcxb251dUV1aGxpMkRvZjdBK0hZ?=
 =?utf-8?B?dGdTRzg5NmtqYnBlL0ZxWG1sSXVTaHUzQjFRcWR3blJpbUo1K1FMRm9rMVpu?=
 =?utf-8?B?dEswcFBrUElpV0RzQmM0NEVzUk9sOTM0MHhjdnNia3F1UnRmcU9zS1Zrc3BC?=
 =?utf-8?B?WnlLUWFsTU0ySHdOY05UcjJSTEp5ZDkva3d5Yzg3ZFZxUW9VenN0dXhJK21D?=
 =?utf-8?B?bUF4bUVTaTNqcUNUMzlwaktzeSsxUW55ZGJGYzVhSkZJcU5CMGFSRDBUVDdY?=
 =?utf-8?B?RUJMZ3MrYlFEVnUxSTlwZHdiZStVdVJLSzVOZVliQXpEVEpmQzRLU291QU5U?=
 =?utf-8?B?dFZGZElIL0xhUUJpWHh0K1BhZmp1dnFpYXZIdlZLUFZGbHNOY3RhQjFMV3Vh?=
 =?utf-8?B?WEF5Q0VVWjZQeTQvMEdYTzhZNU1Lc2xtM29JeU9NazZwSVRObzFSb2xIUzU2?=
 =?utf-8?B?aUxFVkpadGRGTW1COGxUbmprUTlpenpHODc1Q2RkZnNLdjY5c2tiQWE4dkdM?=
 =?utf-8?B?bElsdWlONVRGbWwvNS9MaDlDY041WHhNYWxVN2hCUnkwZk5tNnZTYVJzOHFJ?=
 =?utf-8?B?QkVEWFF5ak9FSGNmQkZZVlVscklzMDF3S0tWanBRa1FFMUQ2UmE2TWVCTnlw?=
 =?utf-8?B?TFpTbnVCYTc2dWNrR0syK0NQMUR5c1kvdGVSU1V1MHJnSDZ1QlhWMzZHYkF4?=
 =?utf-8?B?cGE3REt4MVEyUDE4aWNYR3Q0clFWQjFBck5QM1JHTU1pd1o1VEtmT2p1SHhO?=
 =?utf-8?B?QjFDb1ZiL3JjU01rcUNTTVRMVnVaaEVWSmVaMWFxNCttME5sQnMzZFMrdTky?=
 =?utf-8?B?dmhnbjRuMEFGa0tUUjNDVjZGMlJYL2orYnNNNWVIUm9rK3YxQk52cGNjeDlp?=
 =?utf-8?B?dmx3bjRvYmNVMFZ4YVorV3c1WS9UYm9TVVJmTTRpZ0w1RTdaWi9QM2dqclF6?=
 =?utf-8?B?WFJqc29wM2pZUzZkRjgvVU1abGk2dUdnL282aGMzelMySlYrVnNOSnNOTzg5?=
 =?utf-8?B?aU5veFBHZGkvS05VMEg5Um5ocXV0OFpNdG9MdXozSUg1Z3R2TERiSmFPbTNM?=
 =?utf-8?B?OFM4QkRaZ2lES1hRdG8rWmFjM2J2TXg2Nk4wdGdtMkNNSGdNWStJZjErTzVI?=
 =?utf-8?B?Z2RxK1A2TkNTU0NLbDY3NEZwZ1lhRmJiL2FSa2JGVnhsdElpNHhMSGxqNVM4?=
 =?utf-8?B?cGMrbUl4clVXYnVrUXBaSlNjUU1YdmVDSFdyYlpJdmxGNENvTUhobDNPZW8z?=
 =?utf-8?B?UFBKbEh0OFRITkcwdEdEYldvZWFNNXJHaFZaaDY0TjhwZmhrUnd4RDNxaDF2?=
 =?utf-8?B?Y3VhYXZqYTBRYjQ2N2lnTUJTcUtKcnplZWFVNkJtVjU2WnBOWW4wRGFZZmU5?=
 =?utf-8?B?ZVd6cEs3VDNLY3VkZ3VRaEpwaXJzWmtMcVdEa3JKOVVpKzh6Q3hOK21CNTN4?=
 =?utf-8?B?bFRwT29jYXgrdkF4M1QvcExhMVloZFptOVFvT3FQYk1SNnZmWDRLaldsYlcy?=
 =?utf-8?B?QmhEOXhhOW00aE1qZVFzb0hZcFpra3dORUNhNzBiNThmRW40b1ZsN0hmKzQ3?=
 =?utf-8?Q?67fGpt1FuW+ZMMq3u5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84b0042-516d-44d0-0311-08dec2061ff8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 06:54:29.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDelnwrr5Bucx5qroqJpeHEPM8yoQzusIX5MOC17HgP+aqjfQNktWGsqvqw0cJif
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

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
Changes for v2:
1. Add a boolean variable suspended and PM callback functions to replace
   the use of the is_suspended field per AI review comments.
2. Move event report handle to else branch in suspended state, since the
   pdata->minor_rev == 0 branch has no debounce detection per AI review
   comments.
3. Modify the commit message.
---
 drivers/input/keyboard/snvs_pwrkey.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 4a1d04898482669894e9978014b62e4e9774b4e4..f212a6b26185d13e1af62728e7b2add5010adc5a 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -39,6 +39,7 @@ struct pwrkey_drv_data {
 	int keycode;
 	int keystate;  /* 1:pressed */
 	int wakeup;
+	bool suspended; /* Track suspend state */
 	struct timer_list check_timer;
 	struct input_dev *input;
 	u8 minor_rev;
@@ -92,6 +93,15 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
 			input_sync(input);
 			pm_relax(input->dev.parent);
 		} else {
+			/*
+			 * Report key press events directly in interrupt handler to prevent event
+			 * loss during system suspend.
+			 */
+			if (pdata->suspended) {
+				pdata->keystate = 1;
+				input_report_key(input, pdata->keycode, 1);
+				input_sync(input);
+			}
 			mod_timer(&pdata->check_timer,
 			          jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
 		}
@@ -219,6 +229,30 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+
+	pdata->suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+
+	pdata->suspended = false;
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
@@ -229,6 +263,7 @@ static struct platform_driver imx_snvs_pwrkey_driver = {
 	.driver = {
 		.name = "snvs_pwrkey",
 		.of_match_table = imx_snvs_pwrkey_ids,
+		.pm   = &imx_snvs_pwrkey_pm_ops,
 	},
 	.probe = imx_snvs_pwrkey_probe,
 };

-- 
2.50.1

