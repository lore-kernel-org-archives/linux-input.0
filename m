Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44E3C9ED5;
	Thu, 18 Jun 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767757; cv=fail; b=IGsZtFwwkn32ZDsuDUEswYsWsKRfR8gSqZrJxe8yOBo+qNpt4FtTUbjvaufnV7P+poN4qz1/dU4qQ2tB+Yl1g3qJ18i51y4QNf3rCbRABaVfZZNz+GLCOqbh3/0pStXEYQo4JORDdOCCd2jrpnaMq0jDZjGciU/cjH8QHGN3AEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767757; c=relaxed/simple;
	bh=rewxjtOtB4zVo3O88fQLC80uyFAVvE/9qJRqO6+AUbk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gM7Bh9tkJxa6cbES4CCN2TpIvkz+EcQ2/yIev9One2NGNSdhZ+nJ0r6bzGMxI697wiCUtpO9C8iK0L7k1MV5W0V7j+mWK73nxvfy4lrPeA/4mPtK7Na9FCHSii4X8THc2pIqaKdv592lXTWW+/QV6OLrDPkdrYZVlvgrPVPPkmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KgOrE9Px; arc=fail smtp.client-ip=52.101.83.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KgOrE9Px"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAnT28NDiYlxFZvNA+fTAOcA9L1SgR0T10Qc7VSVbFmURIYStuvh3yyiAHC6cgCy9dNOncleMveRWxZYHeGo/e+nxP3WWFQgTz/E27UOU781uGNbvN0u6ufgN4P/7figqeAWZFphzqcNFzK+5U8lox14ki51Oai02T9VXlaE5MfQQkqEJ+3FzlFwTFd+TCz+Bx9Ferwl2Q5zlgwDogigq7OXgbRWv0831G1/El74HNsaApsvyxCZwW/UU0psTwbVLRbYKIsfNHKhWKuAhWJiuQOFT15a1zk7QhB+LpWTa+DhBqZismAKe30UCDARzFqY4Sw1UIFPmeQtsTIiUBo+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAaUP6v8RLc7eCue2I1knOKf0bfgK29epdr8NxGZo+w=;
 b=iAZ/LRJjwuw9jaYpZ0UT9ENvVUloFZ7yqjQLKKkWdag6HWhTnEfCKQTw99pr/sg6+390owUgAE4q6Nb9Ft7/r8CM0KJH+ZP1WhO9mfAl2xLcI3uc8ZO8UjFxgWJwQee1HjReylFXQV1fQtCs7s4/FfS/sG2Hu6XlBcdGb+QJ0tOJaSFELXy7v3iwYYUPvxzy7eB8MNMh1c5fgTMFmpCdgry6zc1lsNDkvCaQ89psiDt5JyKvPqy+N/0bxrSrjQBu7LZ9rH/b/gDFn8hf47+4+Ypx2XnvBF9VZ/hiTZrLk3Vop4/E+uWYR1SHMBxrHgVoYDbEA06+Z4VWcjiY290N9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAaUP6v8RLc7eCue2I1knOKf0bfgK29epdr8NxGZo+w=;
 b=KgOrE9PxV2kNgWRjSN2W+jzy2v38LwbueSTxcckoXPGE3fEnggEsRMzg4ZVZpK0IfiFrJW7S61/TCNFL1D3r40cv+dHMPjE6EGiXFffS6Le+1rysZn4OiEhQvYSMc3i1JkK3XsLn0UqVEInazVAis3sqMxVeNAXjW6TRZ9In/aq9uMewxHZDNTHWYgvwgifsv56XixyhlAifWizGCKd+wtvlXEgNGJ58zjH8Wtfx6KRdmhvRHwrJ+UaBV2XmaQzcHxI/HdGmNXRWQDgE485EZPzELggI9MfGk5oqR5u8ZuS+JqzpJq6dzr+IVV4agT4W1ySA75WVNxG/eEsT+xcb4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PA2PR04MB10157.eurprd04.prod.outlook.com (2603:10a6:102:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:29:13 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 07:29:11 +0000
From: joy.zou@oss.nxp.com
Date: Thu, 18 Jun 2026 15:31:47 +0800
Subject: [PATCH v4 2/4] Input: snvs_pwrkey - propagate error code of
 platform_get_irq()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pwrkey-v4-2-4bfda105bdf3@oss.nxp.com>
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
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PA2PR04MB10157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ace4da0-b0d6-4664-88f7-08decd0b4aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gjs0VkU2sWTaPfhnq4XlIjH0S/V3EMUMYR0CcDZ2UCNTLpiXM/V6fJly4qmv0MICywsdoWojiPxd0Ji6FociWXKewoSWCGInzl/xjPDfEsUYSPYlmjGg8yBZRfSNZu4HmH26DAmdgM1tTJ0icIR/6VwKAMVfCmnC0B+k2uQnEw4zZ2agaTLTGoeBCjy0/D9643Vuv7O7DUgRr++6ycc/P/HEg5O/GyMfkWqgr2MB3Supw7A1VvYFVaPBP6vPg/GJfuwUja4l8Se3V/bIXB0/lXCdifxFl4hiwPr9UTchBVtlFKOd1uQduNVDjNo37t69VQQFr/8zKsa6MXflE2KDzjhePCSy6Ggaw2RjI0ccEricZlfcwiZUblsp5c/vLlZ5zeCkocnr0qtIfOk0tzts5JqFsfLSXOiIBWi5L8EIbpswTbkjYC3evQYpvqF4hE/PiqR5HU1bu2JS155GdeTrF37hIHbU/TFMziukKVFwTj5p+gyhfAtpUDouwMrOzrFtF9bShTXRWKK+OgxMeHpvsBtulRZxrNBOCMjZyCjSF5sIj0efT3yVzqbYK9BTzmCqSjbGNMREzRkygjdGPEB9tjb4qCwUaM8t+jmU91bgJ/9luhIJfO7NkSmjS3UVJABK1SdbVAUEXl9A4HNAs9HAn7WjQZbLzsm+NdLjEpNCmqVbbaGO6ywcmB5/sGLPj8Ug
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWJld3VDSE5xQkZMQmp0Z3pGbDNKa0c5L2ZXVzJZUHRkcDdKUHMxbHhxaVAr?=
 =?utf-8?B?a2hiek1sa3FOT3FtUk9meGREeVpLeG5jTkFCUCtiQSs1bUZ6ZEozZjVzSS93?=
 =?utf-8?B?MjZKL3JIbS9CaWRXWHM1MDIraVdmdjNTUTZFd1ZCL3lnWVN0OC9WMEpxUDA3?=
 =?utf-8?B?M3R5dGp2SnVWYzUvWlM2dHkyUGFNRkNGT0F3TkVpMW9ESllIS0ZBU2RGemVG?=
 =?utf-8?B?UE9yYTladm56SndxQytHMFZRWm9SWE1QMElEYkVoQXg0T1c5dkJnaDA1UVQx?=
 =?utf-8?B?OEpnMWZVSTAva2J4R2lyNXZOVE9XODE1VVBvc2N4dVZrL0pQRVc1U1pIYnBN?=
 =?utf-8?B?d2x3b3pSc2JQKzlCNHBFblZqOTFlVG0vbEdyMU8rekZLRWlMOUdTeDZHRnUx?=
 =?utf-8?B?enFPZDhiR0V3Umw0d2svNFB0bTJKeTEwaHo0dUw3L3NFQ1FoaVJpd2hPTWRt?=
 =?utf-8?B?ZFJDajhXa0tlMmo3ZHY3cGpaZjVweURveUJaWHJ5b3R1Z0hrdlJYaDg2a2lO?=
 =?utf-8?B?SFE5a3JuaU8rQlBzY2lsUENsdTd2cWQwQmVNbHdOY0wrcXBTbW5RR2JHT3B2?=
 =?utf-8?B?RGpRd0M1YlE5bENmR1diZ3JDdXpUMHJKZ0lzQ0JBUnNsOXczTWNtOUI4N3Ry?=
 =?utf-8?B?L1ZXZTd0eUFINm5VODJrY3hqOU1NZ2hBYWJOQXhtQ2hnRGR0UFN6TWR4aVpH?=
 =?utf-8?B?a3BsZng5TWxGSVdSSFJTelVORk5uSm15ZEhWWjl2dkc5dENtblBjTUFrZFVZ?=
 =?utf-8?B?c0dBbCtCVGNzQmVmQWJ1YnEydWRsMjNIamp5cmszcFdIcVRQWjBxNEpHOWVo?=
 =?utf-8?B?blFjUmZvZldDSGdKNStaTXlRK0VqNlFBcENBdTJCd1F4TS9vTUF3SEE1SjZE?=
 =?utf-8?B?ZFhHQS9TRDIzYU1EQWluUit6VU5QUXVPejNnOEYzdnVseCt6ZTlYZDNEMVpr?=
 =?utf-8?B?RlF1bUg4ZENybEJVY0I0U3kra3V4RGhTOEJhUWVOalFaSnRQUm1nb3RRRmlK?=
 =?utf-8?B?N1IzcHVtcS9yTE1aakZSbzNKeTU4TDJmSG11MG8rd2MwcjEwczFzUVVid29u?=
 =?utf-8?B?NUM0Z0I1dER1amdrRU9PYWQ3ME5kZzlDUVR0Njk2TjJCSE1pZFpMZUxmUjFx?=
 =?utf-8?B?QU9VSHNKb2VDdGUvODgybk1zSnZZWDljR3FBanhQWFdjYThTUTBrUXZnQUdx?=
 =?utf-8?B?RklqQ3RuMi9aVmoyN3F3NWpiTjZiNUsyeHByNkZVaHZ6RkwvcWJqREh2Ri9j?=
 =?utf-8?B?a3B6aFFaY3J2Uyt5UWduOFhFd1hxY09nNktXVmgxTk8yWm9uYkFtVlIyS2w0?=
 =?utf-8?B?M3hTZXZkS2h4cmZpNFBQN1JKVGV6MlIrVHFvRk9jdndJYmJDNHZZd2Q0Vkha?=
 =?utf-8?B?bVpSSXBBWm9DeDgwaERDYXoxbUNDS3dVZXJWdFYwNkkreXJ4TWUzM01PNTJa?=
 =?utf-8?B?bWRMWW1WWTF5ZVo4a1ZvaVVHUWtUbFV6RExNMGxaMitoTHBWbnA4UmZVNE1q?=
 =?utf-8?B?azYwZHhKMGdEb2FnTVNCTWh6emE3N1ZxUS9TdXQrTkxNcUVoZzQ5MlU2NFRZ?=
 =?utf-8?B?UzdMbGhLMW40aXBkY2pndjJra3JNVXNyekRtOHROL2Joa0p1Mm5GR1REUHJC?=
 =?utf-8?B?dzV2Y1R1MEpscENodzVlSUtiOVdibDdXa1VUcisxZnFNaW5BTytVam93TFRL?=
 =?utf-8?B?b28zY3MxRmZkU3A2a3JnSURIQ1kxY21lcUUxd1d4WXM5aEZTOEM0ZnpiZUxF?=
 =?utf-8?B?TUwxRTduUWMyRTBoek43cHBCc2ZuN3BCVlJnVXJxVldsL2pDR3k3Yi9icE02?=
 =?utf-8?B?c09XZXcyTWEzMGkyT3VFRVdpTlVnbGRrMjF5dEx1ak1SZWd4TjBRQzBKUHhL?=
 =?utf-8?B?YjV2QlphdHdsbzdOM21Yc21NQUJwUnB1Z0ZZSnFLNFdwNmJqOUtyTG14NnVZ?=
 =?utf-8?B?WXZUeEJjRmIwQ1ZwM0MrZ3lFUWcwV0pESW5ybndZNGJSNWVocC9FNndqakE0?=
 =?utf-8?B?VVhBbWdRaUJ6WTBuRTZMM2E2NjVwK3RjeTZOck4yRTRmZkZTU2tHWDdTZ1lS?=
 =?utf-8?B?ZlFEamg2YUNleHRRUUdnK0J1c25lZ2xJekFPbnlBb3ovZms0c0lpdXdyN0ZV?=
 =?utf-8?B?S0JWbVdxaVFuZVlCaTlzLzU5Q0E4TTYvL0FOanU1TDZ2UDczSzcyQU5lUnNS?=
 =?utf-8?B?QnJVRlVkKzBMT09sc2lwcVlibi8wWG9DY0FaUjBRWU05RElNQ2pHNWlFY1hq?=
 =?utf-8?B?QkVwcG11WnBscVFhTmt4WkEyZTgvZXRiMDBYTWZNaHdtZWJ5OWRPN25meDBs?=
 =?utf-8?B?d1hxa0kwZnIyV3U1VExhSHJxT2xHS3d5MHlCRkdxUVN0cUpBOTE0MFlObVIz?=
 =?utf-8?Q?00obJcpvITzH9QA4ngYZxKVy5sII/OUOgUkpG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ace4da0-b0d6-4664-88f7-08decd0b4aa6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:29:11.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS3iwSguvY0k/LGt34WvcHslAY/qfJ+PHiXeYf1a2+TTZzA5FvDXSxPW7NHyBcTaZDhDF0jn+Bgg3e5XbF0bkPpLEaSBnmhAlsbQXbhpaWQBCRDqhNVZBWe/yKBkr+pV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10157

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

