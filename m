Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5613CB2F2;
	Thu, 26 Mar 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521497; cv=fail; b=aEZGdUog7dvuoY8sVWG39wnc/mzlPd1LX8ck2Ktxk7pekJiANttsq9bCJJp/WCg2LwctaZ4Gu35usTlgKliXdV0un25vvG/rb25Wp0O+prde6jqV5JLfNi5yPlJjbp8mEqkCjgPbsCBqcxr+CTEkR/ZxHDLVvt8p7rb0YAbeBTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521497; c=relaxed/simple;
	bh=l9gVAFrKsTiGh2gVsO3if9yB7W3Y//W4j0rAL1Z54pU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YsP9Rl08AldbiH/QBsm0Jqdti16pG7pvi6z9XSHyMznTK/PsLzvt/A6V8w9oHt0jjpgj/LiTfqg9xvE0Z6AFjVgitsfcNICTzWXg3CiqrkLi05SFtyOQRbuGQRPyqtJkQKiCrCgdFUBMXQGIb0lme9NcyTNHP4EeQK5rDBe1ZEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OjSIOsT7; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OjSIOsT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXtFi0ZQU8M5fj9swZz8WgDyIRTjGnPZLOLSRldqnu3Us1ShJBuP3MnejwTGyxJmjmIojPoMgDaEtVZSVXG2jM75TBnrTfdjW9FBYnYVTXQzdwluY9xmbto7joSAIRo0iu9GqdyGtYzlivo+t/JzR0QD18P+RO8Qm9oM3ebbTS+uCRKxg319ipAsKtrvvXQa3VaR8ujn0UNLEpLp2FsIurofAkjosCGhFb+aRJqwzOJllPQuPqhQF/5R8NcOovqk+UBOI/J+0F52bcpk7D5HW31gHMF0i+xOanm6t9EAAV8hEesuXblalBYtzGWLYXELdyhyKpGqb+zVl07eU6Meaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vQNlC0wAzP3pdZsvAOyrQEPvV2/JRukAzD6ogcE2LM=;
 b=hYb632PN442ziRnlKOwsNy4d6D93KMdMf0Mew5UEVZht4LPOUDPD4qwZtbMmaYIEnCXrqubxUCSA2Hh6uSll9sPTABfybEaGyp2PhJFx1bAd5zqtvUtrag6HMjTEowj+MU1u5hj8lWPZNVo7udj3/aZYmSmOXx3jDfomVgt0Hs6fHMdPRJDb/28yVbY+RRRVZk4DsDE9EFbhr6kKzdrTv1fuWI+43JajGLcGjfQqPwwhsMQ83+Ba44SGGmz3tI7rK7qSc/BoA359Y+L2EtuD7YXDebjUTWqe66pLROj0+tO+BqgeZy2XaHGCa9Ia5wIahb0r7en1CofL6bLJLHDFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vQNlC0wAzP3pdZsvAOyrQEPvV2/JRukAzD6ogcE2LM=;
 b=OjSIOsT70nYyII/yaoLFUb25o8lfnAZI8niF41acIoeaqZV7s4r9de3/vBU0IyLF0MaW9GHpcHKstruwS/m2nbGsd71L6xYudoOo2f2zjSOLUYgnjkKtYKGiyNfXvsz0eihDE433ybI7iadu1Q3nbHVU7gv6xv1TWkeiMfcWdTkgZOrZGN32JHJUgQjckV5pp1OQ80QzhMl8upMwBsrqfHBCIVWjKluvHK6lauiCh63gtQJuUUPRVDo8+D2t9p/fLc6bVwNrKdWqiFbRZyTHJ0YLVQTdyC98wgSEMmvMK0gDxRmnPmuZINESkDYLu9MOI2qO/wrVXoLZad3J6DzF4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB9006.eurprd04.prod.outlook.com (2603:10a6:102:20e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 10:38:13 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 10:38:13 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 26 Mar 2026 18:39:38 +0800
Subject: [PATCH 1/3] Input: snvs_pwrkey - make use of dev_err_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-pwrkey-cleanup-v1-1-d85d7c0bf275@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8dac9be-331f-4cd7-c6d4-08de8b23c848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n9xu5lleo1xiDlW2u5/mnxVUv90PsSZ5SfMFpKVK0Gpyl0q5KHJx2DwOT7ydz+fKQ2S3H+6Z8LT3VM3k0bDshT1FTiKQZhCKNA6BqLxe1SextWJzf9xOaHA105RnJRU9/P2kNRorgC9Rqdw6Um3Uq6QNZ9OubR9X0jkNPr9ogrqg+GQM706hkapi41zXG5acSyXfJJKg2Mksp/kIudN5micAkORcEFFxzsFSmzusDv6iPnto86rMBHc9QEi5PqKbZ3MFeaXqc+iHBmvok7YtWaAL8l5Tpb0ekdvARC/rJr68nTKeWB2NOAaM90xQqDJgRgtOX8aLyXzqyZI/Hwz4zfKSoBhDnXT3170U7IkvkxFaBzp7BzUfGTL+v8pNuCCX0fimHyVII9nK9WFLkN0rKa5nmugbR8n/uXHgVablmZQq9aTX09rJzzaFgCTd7TA0MZH3aaUseJOOw3UuqNrn2wxZTIyzSRQ5HCjTn02Pg5CgRUOGCmxJiQQZMAK0c6xCxVj3+8lteOal+tFxm8t3gikmEyuJIvthDHCBM/DUBLQLDJgN4Z5ovKrEEg3xiFwIu5yisxHGcGdNPpcuobX6BHgdhYUKfNkAQqFlxqJN3T+y9DQY/FIyCEbdvLDQTF8F4t52exXv/vvWQocyFjzU8sEdc7BmC6WgWeu+uMHN9Hin3E1j7R8g3Bzc7gUp1q3yhIvEzueT6K73HrBvv5ZiKyyHstux9gfRKNrgkBsbA5Mwx1na+rmE6Pq7Ygq5SoLPp50HCnMDWPuNTVnflCEgrAgSm9jJMl/0GpxgfUslhTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si80cC9BbUUzM3o5TWFzOXNlNUtLWFhhdEJvSXJSYXcrQ1J2dGdEVG9Da3g4?=
 =?utf-8?B?VXFhejgyT3NjeGhYSGVVQzhsMHpGZVhkSnNyYy9nSm0zZXc2MmV6ZGZxNGRR?=
 =?utf-8?B?eHJmUXh6Mzl5RzF6MEswa3JoWDZ5OG5Fc3l1YzJyRjFNQ1QxTHcrT1IrZWlu?=
 =?utf-8?B?ZndmL25ZWXRUVzZ4NGplYmxiVTVVR1MzZVJQU2hMM1RkQ1BnUFQ2ZzBvb09H?=
 =?utf-8?B?MmJubklMYnQxamRYVnhvTWs1VjlUUHF0R2NCOXVJaGJCYkdMSW15WXBHcFNl?=
 =?utf-8?B?WkM5MkpBSHFRZHlMdy9nby9mbWxheU15UXBoV1lSbmN5amE0Q2VvMGR5bDFK?=
 =?utf-8?B?cDlUYzg0d0dqYUhxWnl3aGo5dFBZeGhXSnk4S3pPWXB3dlJ2RllFcXBWc3p1?=
 =?utf-8?B?K0llcmhsN2cxNnU3Z254aEVBckNkeGlKQzJJaiswUG5LRFBFMmxZaHllaWFa?=
 =?utf-8?B?NldncjFZVlVWWElGZHpFc1lMSjVURlkzV2NqU3l6RDJaZ2FWNEdVUDZqOGQw?=
 =?utf-8?B?RHRDUHQ0VFN6NHRqUldPVEhKSEEwRGx5RnJwKzdTMVlDMXlJdTlGUFh5NXRv?=
 =?utf-8?B?ekhjcUtvTXdldFB6dFI3VmtmeTF0R2pqN2ZwdUVXWnFOVnIrQ0R5R21BL0tZ?=
 =?utf-8?B?dG9qMTAwNHhqbTREOHVMak16R0NMRDE1YVhtZDlaZnZJYk9UMHBkOXhrMStZ?=
 =?utf-8?B?UFN2RldVS1E0TVBBT1hiYWZXdVdDU0FuUWxGeStVVlB0aGdRcHBwakVVRHA4?=
 =?utf-8?B?YWhUOHZWRFBaTmdwNCs0STRjUlNZOXlQSWZmNVNMV2VoREpsNk5rZWJ2RXcr?=
 =?utf-8?B?VXJjVHZDV3pJbFoyMm01dVJlaVlVMEV6amhzQ21Cc1FNYlZhVVdLSVYwODBG?=
 =?utf-8?B?TWJQUDhjSlNKWW9rUjNySkFyMHBlQXI2U1VKbDZLSGYycno2eDZrWDZGbzl3?=
 =?utf-8?B?OG5hOEZUMDZkTkIrTnduMWNYUG4yTy9tTnJZNmNGWENQYTNNQitIOWxBdTZo?=
 =?utf-8?B?L3dwb2l6UXQwclFxdndMOFZIaTJtdFo4d1JtWlBRc2dmN3dmR0dnUTNISGZL?=
 =?utf-8?B?cHBtNDFYUitWalJWbytVU2VmSGtHMHZkWDF0aUhmYUtQUTZhV0Z2MU5FVDZ6?=
 =?utf-8?B?MWVnVnlISzZvNmpGdEtsQVc1TTdSdG1wL3pZZmZNVWpZcEV2dG5kd2xqam5l?=
 =?utf-8?B?RW5ReXpuTHBvNTlCa2N1b3NlQTZrU3BwRHAyT3VwcmRHNmZKUUc2WStFc2Vn?=
 =?utf-8?B?VkxnVk43dndFdExhVC9GMUNQSW0zSmpJVkwzTUo2TjlZVVJDa1FUenVFTU53?=
 =?utf-8?B?QldSbTgvR3JVeW9obExwbWpjbE5Ib1NlZjZUNjdGVDBkdjBTYzQ1TmxWbEt0?=
 =?utf-8?B?dnYvVGJsRXFUMGhYQ1lNcEFnNVlsTzdXeElweEVkMnhyMDhBUWp1SzRiY1hK?=
 =?utf-8?B?RjNLY1orN0M5Mk55d09lMGF5SjhtWEpJbnMwZVEyOXczREJyRE05QXhEeHpP?=
 =?utf-8?B?ZU5UcXBZK2grRlZuUjZEd0RzalZtZ0Q2WFkzanpXM2pnYitkT3RXOCtUVE8z?=
 =?utf-8?B?TnQwQlNpRWYrTHplR2dITDJTOU4rS0tBNnptelBsVmF5MHh1ZHBLUzJjS0oz?=
 =?utf-8?B?N0txczlQbmc1NWU1ZTJVTmhnQXJXVVdpOXBKN2FFUkxvQm9EY2J6ZnhTSXhR?=
 =?utf-8?B?SlU0bnlSd0hlU1pqMC9JbC93eE1jbXVMdFFNVDhKNjZFa2RNQ3Q0c2NVaG9s?=
 =?utf-8?B?WkozVGZqYkJFMVRJUTAzN3FTVmNlZ3owOVVyNWE2Qzc3WXBFb2loV3M2VzUy?=
 =?utf-8?B?Uk85R0VUWjByamZ3RXNjd1V4UW5VcDl3eitLRmxGTkhrYTBkK0xUa1M2TDlk?=
 =?utf-8?B?QVJkU2haMTFmYnJ6dWdCNC9zR3B1N3lhTHdKN3p3bGZkTDBpU0VWak5xeEFn?=
 =?utf-8?B?WHF1ODAxUS9md1hPdThDYy9vSjZOZEJmTmFHdklFeWFwRlN1enlvTXQxQS82?=
 =?utf-8?B?OTJSd1JTZk1panB6UUpVaDEwREUxRDlPbDRQc1gwVWRrbXAwbUROdHhYMWZY?=
 =?utf-8?B?UkRtSzVtWnBsSnlwMDZsbVJud1hVZyswYjVLc1hCdFJYa2M2ZTFaSnlLZUpV?=
 =?utf-8?B?QzlhZEdnczRUOTRDUndkYWEydmtoMHhURFdHNno2SFRWcUFGSjVpTi9QZkhJ?=
 =?utf-8?B?UE4rNnBKbGcyQndwRzRndUdDMUEzOG9SNVNUWXh5TWRnb3R0SEhjNUx1YU5m?=
 =?utf-8?B?Vk1pWlVtRWRtVmg5MUZEMHA1MmpjSk96U3cxcmxOcm9mekpxT0RvSmtDK0g4?=
 =?utf-8?Q?S6YpXs2kXWsJevZTae?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dac9be-331f-4cd7-c6d4-08de8b23c848
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 10:38:13.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DacxZH2rpDJtLIMY0jki61+RtzN0t9cOT95ok7b1StsnyEt//m42qMXsCyMZZY6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9006

Add dev_err_probe() at return path of probe() to support users to
identify issues easier.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 40 ++++++++++++++----------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 954055aaf6e29527f22f8129fd47ca17722e2bc9..836ab94c160615f4b0f645d9b9f85d54638c2624 100644
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
@@ -142,16 +140,15 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
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
 
 	pdata->irq = platform_get_irq(pdev, 0);
 	if (pdata->irq < 0)
-		return -EINVAL;
+		return dev_err_probe(&pdev->dev, -EINVAL, "Failed to get interrupt\n");
 
 	error = of_property_read_u32(np, "power-off-time-sec", &val);
 	if (!error) {
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
@@ -198,10 +194,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
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
@@ -209,16 +203,12 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
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
2.37.1

