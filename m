Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345133D9699;
	Thu,  4 Jun 2026 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556066; cv=fail; b=pWDVkF5CgkvdxIZhwhQDazaiAzmATGbKRarxKmxFGBjVex/ot9jVTtCsdVoWMFIDq+MjyTMEHcTdfHwfMF5m82yRITr/njF6LHgNN5UdRty1JffDmMGm9SiAY1o4/T8Ua68i4nG+KoF+GbsDUZq4uXcio7+4YcI4CgrCR9oSL6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556066; c=relaxed/simple;
	bh=5jTKXkTxtDaDi6KrBHMi5CaFJjzYAKVZkqmMoUQghq8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jqKjrgBUL+VDstRwCYzkdKe7YQaaUupVQ6SHIt/G+FMvfYkHpcZWWwGmQXOwyoUgnv4S5RVQKQFgnsd/6XIEP4pe0qAv17cyW1rW5DlhLyKaK6eLlfYOsLtMZ/52Z5TdJfDcaB7I6hvx/9FvO2Sxfu+yOTov0rcXEaSJVK/SoNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=guu5ulxb; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="guu5ulxb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKhEP+/INrQD5hiXpgjup3zTdlzxq5EsEAPQ5xjVlHrf6axPb4GGgWR4otc44QQNY0xmJgIt3aSf0SQoZ69IWE9yIk6zM3gXkOas3WZK8SQ9O9kNEzoQ1AyvQOzZdC1NMbYxuIDN5U0STldARsm1FqqNaGKjYM80gVB+gTWwtx+n25Iy90P0zQPv6oQa1W0Cw/HBJ1lpJb3J9mtUuVG3D7R1Yd77jAD8YOYI3AwiRm6unhTg+HIadFtld/ESPjFZm+TI3YMVyiPIYsaVBtahWMv0oVBm/3jh5LLaLwlxiYRmTrCItJ1v8Do+T2GhUGGIGhNWSSqSrJKlJsKPd7KeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg/hUARSYv4NtW1DwZ5b2ydFGWn1pA9qg1v7CkwH07g=;
 b=HV3qa6VLpaL/DRjXluOC04sri+MjVP3YlsVbbfn5As6jt77cBSauJsXIER7KaIGOB12E/KiB832QNLHuPm73B88U+rSaLQ/SIzUU/A/0NXazG3AlQC8n2B9DxE7S5zV9bKFLWt84U0nwTiU4G+LL8Jw+5WPrNlphVfRAQAPivjuLPcPjkj55rCMU2RfZtTGDxUQh8dl8wbL7n6Gwdj6Zyv04r5poIJpSdfX/js6Xjq1nTe6tZXIMcB1iJRAUWFWqfL2p0Sj7vzs1WyPMsSNjpd7Gfrr6qSgFqOp3xihf2xeUugwM6CD9SdorTXAMEDx7ADq5YHwBFIcWdvicGS+2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg/hUARSYv4NtW1DwZ5b2ydFGWn1pA9qg1v7CkwH07g=;
 b=guu5ulxbGgz2OAzH5dchPGS1BMchX1wUvcaktD26SaG9jChZmuQbwt0md7Xf84Z8Uu+HSXvKCFL3GWjNzYp0YZNk+bN0fLgTVcZesbFzJFOCZ3yC4msVXub63cAXih8GsR9nSLiFRO9dnB6PDJCjdSbIcToug/zf9BedTQHnYZ2k/Ozoz17xrOrxj3MfXHgZiiWxM4phtkje8nEAXaargcZWjaE/9XMJPOuadyHyzskZOfyTzrti3Qbfw/ClQRldiNM/lqnyQJFsi/58CWMV+ZKr+WPwWxPiqQZz234/2xwvXCSOvnJZrNYDhdAHippvjn2qF7VJI/Ji8rnsx+GkMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:54:22 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.21.0071.015; Thu, 4 Jun 2026
 06:54:22 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 04 Jun 2026 14:56:22 +0800
Subject: [PATCH v2 2/4] Input: snvs_pwrkey - replace hardcoding -EINVAL
 with original error code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pwrkey-cleanup-v2-2-59fa0ddf0d7c@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ade2d0d4-5a49-4f0b-2c1b-08dec2061bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|366016|376014|38350700014|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/knIitC4OAHMlwFCbKXLlV+3qpBO98muQXX89fwxmdffEHkeO9kR8e7dwhZnWOJdKV29QIJudhRN43Afqe2Hyjox7hdTmyaF60cnsnryQd2zNG9yEXMbBnnR1iVhB2GkZs09ceI6Puo/mqBBqVxhEB9PQ5jlAy+5Rzg2BvPtKHu00R9iC5kDObxaqg6iuIG1XFXSGfUcryFEV1DVGzX2XxTmdto8cC2X3gTpVvtztcUPrz2CIZ7+tRKfRGeTDJae4rKcvVQq8swSYcpGZyqn3iu8FtA6/M7pJmoZFYH+Q79nuSXmnDFEYU5lCgIFB4ruSvn8k31gombjHVY7JQffwcbzWjYPooCPuOuQPkfBYL1W+WVmXm8LiK/s/dMDQZJttJBdpxwAjxWrXslR6e04CXk8g7XiM087TeuIhwMYpif6O4gi88mTUb/JRvOXpBCLi42lpbjhEEu3bJ7nwB/ojC+SeLpB4/EwSaX8IzN7gbJEpTYeQFyTmqSEQQmySCKy8eOMl9w5hJ4y/zL+WkLCuf3nb3j1fXP1KZUqkP5bGaJY3b/xm4kOP7OJqRWal8ao04N+bY989YB5UwjKGjSkklAgxuwxtWuqA8yWZfMlRWAGNdsffcxwf7MR2ZTCuAuGriMBkkiCpF4bwUWG/3OwlE78ZT/ve44VuPIj+sO3JVFTgQ1A86v9rLr82gP2nDH+pkr+VKi6iuU6bsv7bykyyhYaoMN0cVHRFvx8LmR5Ep3B/iSexcATUO/7GiqNbKh1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(366016)(376014)(38350700014)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXRzUmNUQlVjQ2dTWER4Y2J4OCtHNzMrTitMUEZMZHRpYlRJRzZESXptYnRL?=
 =?utf-8?B?djJnRFc4eUkvVmUzZ0xWdStlWm1OSEJZUXRDTUlHUjVXVElhS1hKdEY0a2ps?=
 =?utf-8?B?eUJxNW04dEN0aWhMa3JON3h0MzNWRWtSWDBVaXZjeDNMelFVU3pEUmdCa0hq?=
 =?utf-8?B?Nk1CZWordlRLL2N6NkU3RFd1K1llZVordytQM0lNeDY2bWNXa3k4SEYxOHR4?=
 =?utf-8?B?OHJxT2JyT2tmS3psdmZxYVRya3hVSTZ0enZ4VHN1WWZZR3R2WDJFZ014S1po?=
 =?utf-8?B?YjJ4WHczRktzMlhINjBENTNjYlFZeWoyeDU2emVnREdVQjVzcFVaaklUUndw?=
 =?utf-8?B?ekRjeWVFVzNoWFZtMjlCajdkWlEzSUVFaXY1NnE3SlFGZUtDR0tSQjVxL3dB?=
 =?utf-8?B?SS9waUhTTlh6ZHhLaWh2aENMWEMrcHo2RS9ZRGZpdVBEaWcxdnBzVExxVVJU?=
 =?utf-8?B?VzRDa0YzTUZsRzZqaUpzMXlzWUFhbTlsaHZNUzF3dkpaTzd3SS8xd2twK0N5?=
 =?utf-8?B?dGNHT1N4OHFDWkxyQmV2ZXFORWtiZ202WVpOR1hLQjRDSllIMDBpQTNUbXEz?=
 =?utf-8?B?TncxVHFJZDVyajY1VEdlVTgzaXVQTStzN1hYcjhVZjFTQ0V0bEpqUWdaakJq?=
 =?utf-8?B?cFBOWGc1bWFxYUxxQlFlZGs0KzdraE1pYWlGdWVHbVZ3OEtCZXZiUTQyVFlx?=
 =?utf-8?B?SDZJZ25lTU1KaE9BMkc4c0dVQnk0MVFKUUpOQzY2aWZUQ3ZObVNQOXk0Vk5Q?=
 =?utf-8?B?RlowVUk2K25PVmxDT3V4SGx6Q3pYZ3lncTVseVhQMmZ6T2FaelJrMHVibFRk?=
 =?utf-8?B?UmNLNUVzMk4zQnZxRkJUcExHUTdMOE1lSFlpc3ZZY2xDcTkyQ0hQVkl1NTJK?=
 =?utf-8?B?cTErVzdwY2JUZHFEcUNQVStRcnFmRTJuRFhSMWZiMXFRdldXNitOaEZwSjVG?=
 =?utf-8?B?eENhL1AxeXU3RFQvMEVVdm81a0lZYlVmRUc4SEZrRk9TUndGSnFYQ252bVdr?=
 =?utf-8?B?dTNKVEtocVNYUEo2K1MvbFdWaXluNnFwQzhOeTVDOGVENExPbHhRKzBRdFd6?=
 =?utf-8?B?VnBoNDRvaGFMMm1EbWFPdkFUUXlrL3N6Lyt6aVowamllM05NNEg1OUZuUk0w?=
 =?utf-8?B?dUcvbTd5K0hDV1lrUEsyQjZBMTQwczQza3dzQ0lKRzQ3TTVuMUZkWnVrSXBs?=
 =?utf-8?B?YVVpZ015S1pmeGxYNHViZFZEUG9ycjFiUkFib1ZaV1A2OUQrR084QUpoc2I4?=
 =?utf-8?B?ZXdFVndRN2MwVkRiR1liWEU2YzB3K1Z1VTBMSGNyK0NBQVE1NGsyaDRLMDVU?=
 =?utf-8?B?UlpDUU1PckxGajNrcHlHTytuTUFDaWNiaW5NTjdWN0d4bEhlM0Y3L0FVRnAy?=
 =?utf-8?B?WWFuSkhKNk9KQlhHaTFkSzFMVmR0RWhoUW9lR2RPWm9NYlJyL0VTaHJINE9G?=
 =?utf-8?B?bDlad25YZHhGVGxha3VhdGU2L1BFSmZvejBSSm5BaXNhdFlKcnBhSXNOUVA4?=
 =?utf-8?B?em9aZWxSSldkK2s4YnhZODFTVkJ2eEdnU2FxMkVjbGxsSExMQUhRNU1ZVW5U?=
 =?utf-8?B?U1VCWmllSjVqRU5JQXdkbnRWSGlpVE5ZbldlcTZSclR1NGtJbTdNd1ZrQmo3?=
 =?utf-8?B?emhXWkp1NlNsSWZMcTJTNXU1YVZjaFM1Qi9UVFdVTWlpTGhEYkVNbUYxL0lG?=
 =?utf-8?B?WlBVd01hRXlKVXhycEVPbUNPdGhyUVl4NjFIYmhlZ2ZFbGN1K0l5WVJSbzE2?=
 =?utf-8?B?eUxRWk9veTlEMXk4aklvcnVBL1ZJZjZ4SFFSUFdZMkdId29Xa3E4NDRsYmoy?=
 =?utf-8?B?ckJMdEJVNWN3MXIyU2dVaXo2L0FNUnBkYWNXcjFZaTVpL2ZEeWFJdGdheVhv?=
 =?utf-8?B?bll2eTZoYk9zY0dsbXZCcC9Ya25rdHRSY3QwNXdpaWJ2R0p5aXc2UjVHbTlI?=
 =?utf-8?B?WFNYME5tZ0pVTmh3MWxwYTNBMmcxWEwxTFZkdnovSWd1NE5qdElncWdYelQ1?=
 =?utf-8?B?bmh5VHR6L2E0R1EzbE52cEpuVDh6UVhTN1Mza1ZlN3ZsRzFQaGkvc3Y2S2l5?=
 =?utf-8?B?dHBYaFN1V0RwR0RNL3JJTElXREdVd0ZSOGtRWUFZSjJEQkdLT3owV2ozWVBP?=
 =?utf-8?B?clBSQVUvdG1EMFVSNUYvQmhkS2pCWGJmTk9MZnMrTll6S2l1dnA1QlhmWG5W?=
 =?utf-8?B?d3Z2Slp4UHRXRDF1eGFabjhtR2hmUW9JWkhaSkRqNHBmKzFFZ3Bsa1owZ2o1?=
 =?utf-8?B?SnJaU09hMGJacVp0alUwSm9VOHNBTGtDUVlSZzRlOXZvTHF5UG5iYUdTZHA4?=
 =?utf-8?Q?EtlqI8yCCmfHVcdJ0b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade2d0d4-5a49-4f0b-2c1b-08dec2061bba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 06:54:22.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfAi1LiEA/zCYFMLhA1I++nIQrOneADh+iI9KFq57P/y0e8ieWQt2xX9r/e7+UrK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

Hardcoding -EINVAL discards the actual error code, which breaks probe
deferral (-EPROBE_DEFER) and loses critical diagnostic information
needed for proper kernel error handling.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 748196fcce75ba7192b1ee5fc516bdf4a9ae074d..a291812e6d22ea963568cced5b889bad00658526 100644
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
2.50.1

