Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013015.outbound.protection.outlook.com [52.101.127.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6E42B310;
	Mon, 13 Jul 2026 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949103; cv=fail; b=TshulWux5ivqk3dr6bpodJMiGRCFvFmSfm6W7srdKd0Gj0NT2xmIWO9+tmuXmepjQ2ZIBmRJ5Muc6T/KEkOREC9JqLIh6pfOFEa+JSfqpKQuBIfUAt9HuIFg2yTVS6o4sNGsUc6WjbwTCBE4Hsw90sHk6ujTuD/5MpgD17z4x40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949103; c=relaxed/simple;
	bh=rIdSxrmPhyt64WfWTi1bnO/7CwhCQBD2XFj2nPwLVy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r90PCqNuGlNaQE/mn1XJlJk6dNdCAEefEVNXlt+0mwf4L+f9zcuB6RuZHKV0xNWqyQ50EWvTDQGphMQ9k/pJPUuUy4cJikAkHS7djz2tao62AGyX4OHlDt/BOxf7ZoAymmCJ11MX8SpNL53FA99zKJH0Eb+/eWqGM4OdA6cinDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aIa3FFn6; arc=fail smtp.client-ip=52.101.127.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aIa3FFn6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/pxdHYR2KlWWfTzIs9fetXlIC7LH7kja9B6W/Rx/L2ws/MUEAECSTfQZi8ApJ0/kGDJ4l1Fr10tfO5Ltd3o347bJ1xGVJhNTG+q7AE2nBlGL05yOQmgBEwcC1b9L7uEJAL1o48TUpL9WLLyjFDtTzUwFcyUrG1a0gYvQGZ2fSvs2uf2OTj5E44U2iWYC8PQRoYKAK/gxEK72x1a+RmeaUFXAJ0tyL5LPycFo3SFdM+2uTbWUXdp3YCInT/YRHFTwXaq5x5EI0XMipi2R48uUo8teQi+HYsg0grOREZbIVI8OpXZ/mxe8BuTnDG8XkIy8hBpQpDgUXyemABBoRP64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOIz0Y84zgTrTYEevf2IWr3s7kOaVhK/8JS8Wy6vp44=;
 b=oeHCrkqtvPDJN4dYTs1mXHBWSs1J0Bg7fAobgch5wGb8rRb299IWb7NU3RuHy3rNhHgwnRJDWZl5qrZ3ZEHS2GCZ4auVOrwcmjDz2L/yXC5g2VeiAJia0eEJ7qqKNekJN7Vb48vSGZCnP+f/zBOtfppT2EQgQWjbplFpPqiehTcHVj3kFe14Uvs1O5andd/uzNd2tHcELiMYyWy12M0VpuUsYG7JoSn/NgDAG6eUSQ43+bipEP36ngucuFcsVSroM7bA+AQxxgjbL2K8P317mEzkCMhJ0BOXsHeFCJEDPT44+oMfnhMSUB5TLqNDlTwHelKth/WvK2orvhnbC8xaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOIz0Y84zgTrTYEevf2IWr3s7kOaVhK/8JS8Wy6vp44=;
 b=aIa3FFn6xLJUzpBvEOxaDFp/pLRVcoWDsGUfUQTQRWFOrDfeatf9CCn+MabkILcVMvQv9pi8//ZjMxIUSOjuXLTE+KVWUDfkCjjvHK7ffeoFaMowFJUg8TK4G3dVKsdPkmFL9mk2xdgQm0H9vmnJx28YFyciazxcflYrBUc9imWncV3hVKwYZ2K0MLVyyPK/2kqiRfIubHVnvSISUuQEKzVhQeg8LVtYanJlhGHYmDw272nlo3f2yy636oa2lBVdJZiMG7gu1R1cVZaAJ6uKFUU+pRu0biHPR0NS5CzJ76KVTnNwWxvU5jJrdUKmglZ+A5XKA0ejQk9yuU19Oxie3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB9248.apcprd06.prod.outlook.com (2603:1096:405:3d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 13:24:59 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:24:59 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org (open list:HID CORE LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 2/4] HID: hid-goodix: Remove redundant dev_err()
Date: Mon, 13 Jul 2026 21:24:31 +0800
Message-Id: <20260713132439.380121-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713132439.380121-1-panchuang@vivo.com>
References: <20260713132439.380121-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYNPR06MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 760fb06e-d693-43ff-869a-08dee0e2235a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|23010399003|1800799024|38350700014|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ygNL+iJ3nSsTqEcaGq/Ib9MjCj8ihk02o+WH3f0KlNnNDCeA4vHvQr1EBtvjeBSGw7y4jV3kogdWGK+3+JmpTCPG17FbktDU3bL6o6Ka/G2swRhUnVYjwW7yk3cFAfNfbs/1JCXPjjScC3DmAIvqidrP7edLCcmKVG1L6owCFhb3HiOyRhoq0ZJxQ0ej2dGBfUM5VJZhBv0oRb183m+uuvfjTLkMWacYJmdoo1OwUPlU06JnmYSE3wAt507wSvs35r3w8gI0kF4yNCZTVnO2rwOiOVdb9YUlErUZjpXFZKU9R2/ZPvTycgnwctQBGUeqmuzv/7vmxsm/AOuTch7u15ZnZpZQSre7mudXv67QrOh21GdqzbpeLWVQf8zz1ri0Smlhs4mXFtbsx4nDf3UfNvUEoJoqgdm8QiSaAtjrL73GDftXwLjAOydVNTmTBnPJV46uADObzSvDCWlBdpjZLtBOic9eS+r3Q+XqpXW5dG69SIbpriwWNlPzJHWVe1/TPDOrlfgdNEyHql1F+cA2gJMO7vkVnr7OY+PbJRNHOOtOXmyQxp/uwzESnxVbSPKjMqFJeTUmR3whpBEPPBOlQ3OjF1CrZVbZaH3v6Esbv+wQbNProv6PggnE75+VNROHgSrfrpylI+0nbSUqPeOlHeAPzhjB6U1UmH/hWJlZWANANheNydlXD8OrswQwwZQyrFTxclBme7BqDqGxDZ1I4E8Nb4HS0WZ0xEJWJBG26t4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(23010399003)(1800799024)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IqNnvY4wCVxZHHgUKrx+GeCA/XR+fgQzobNp0rB/klu8ghWs/cdS1QpSNv7D?=
 =?us-ascii?Q?yMkQzclxRirXjwQcQxNdQ0cTvQAO9n7rDToiXnFMUlKiBdwMUh/GwvddSUHl?=
 =?us-ascii?Q?GJGooJkCcHTrnFocXNsgqP2cOBT+plu0OwbM3gtLozagvXIYOfYAMYVxUOzX?=
 =?us-ascii?Q?qlRf2XzisI002vh4bdbvvwxuuTyI2KdXsYPOk6h1jZuGkonri7U0cehBCtKy?=
 =?us-ascii?Q?fjOUzU0/1XUpSoOAYM/hT9PDiNq72qFc61340B6H4tG9c4CG3GLQI3T4Eozx?=
 =?us-ascii?Q?1VLS1xrxJp1UmwnCciUO5nXL08tQC7o6n8gRTPRm96t8IN0UtnVtS8zL6UnG?=
 =?us-ascii?Q?DQrbOvR4/cB2JBlaY+5mz0nV05dyf3NFjHSzowc73RVlHp9ErtGvT49TLPn5?=
 =?us-ascii?Q?auCK0UcwKLy3FDqYUWj6mlulMKQNpAUK0Q11EtcU65AgqNva9Xd1WeXV02Uq?=
 =?us-ascii?Q?h0fte5uPRAdM8YMvySFiVxLBh+oHUE5aOwEVOsIDFPpRrGSvXSPd9gHdQ0s6?=
 =?us-ascii?Q?RQzjBohHNMDp1Up7Lh1kYU2tE71zoyDBxLB6As96BRBTAHX2zoumgmSg+MLd?=
 =?us-ascii?Q?7LsFNNp4WENAXVA5CskirkjQ3iNlzUAf7/UttEstkRdrkerndY37672eQIPt?=
 =?us-ascii?Q?Plml9CgCKrFbUPZL1YBxlt4kRSR7V5WcRDotEFEh99iP28yHMd6cdhZee2Rl?=
 =?us-ascii?Q?4PAmQXtshIR3WFoi/hCKATpasWt5burm5e9d4JWWoiZ2RRd4+c7P5ruwKWqn?=
 =?us-ascii?Q?c4Nco7VeXLoQsMCQSOsw8sVUlw4obeF6JTiCCQXByCLTDDR3L1Ma8lCVAtzF?=
 =?us-ascii?Q?ueMMatfOv3TjFUAVyOhkQHhppIdcDEHVv0XVpuXHeRMZF1md0lzZv2w8n+fn?=
 =?us-ascii?Q?JDECt91DRvr0aY7BgDTv7H/N3Skmm/9uOnN5SLi+boEWVxuLWECKU6z/Gvhi?=
 =?us-ascii?Q?NQNLqVHz8c4zNHex3o6FWrUoO6f71Dqus9+JmQ7V9q84TaFvles9lNS4SWLF?=
 =?us-ascii?Q?n/fQvMWDSqu/lHc82fa3hYw0rkOSGPsZhu2goMEvPZzDmam/Op1a6AzV3FWo?=
 =?us-ascii?Q?HgZth01d8FOIVkNgDtqO1ZNarUrd82yisTp5ch9HYz7xVk3Sn6xpes/hzMdR?=
 =?us-ascii?Q?68tc9kU+vwJy8GyiMLQFAZnUke7nNR1lZWGqnq8UIyxvs39eBnOEPPactOgM?=
 =?us-ascii?Q?AtKwf/YfHSzogm+5qD0kmfPN+JG7AC2Pkg6/RL16H8ZimfLHd/ZGm3ALacjm?=
 =?us-ascii?Q?xn7jeR/JUKS83znr9BojadI2CFBMtjGMnjsQkM63kRjITluoM9z6GWw37+FU?=
 =?us-ascii?Q?vgDAAvYRFVwOwip4gxu0Owcwo/8wGDxW71yahoZ4TkXgEBTgRQUFLMegi43T?=
 =?us-ascii?Q?SH+wKWodN7VuKNiuX+cOmD1Uim4Tcan2PHg97GxOtP5B9RfS8CfM/qrVR+85?=
 =?us-ascii?Q?Y3nryfukBLsBQU0vtSckJE63599alc0t1Bu2IEO8h+X+x0JkTQXAE3VfgWB8?=
 =?us-ascii?Q?mChrB/jp0gz4TTbwinZzFiMUOGkqGcqnL0SxIfJNM7ijglwmhbyHWPBlG9eL?=
 =?us-ascii?Q?hkCQA3bH7wtSHRfycY1WZVJN+BoJAkzCWpcXHU9nGCnx76MKXle1ysx8mhi0?=
 =?us-ascii?Q?l6WyROzaGysXTo+mW3iOLukyVCgOfzd5hWhvKHabLlaamI2K2wW2lQH1OKXR?=
 =?us-ascii?Q?FBUHPY+NrMrvpXn213ZEBPulOOCEX0O89yY2btOIjx0CpOg9vlolVR5gtcNO?=
 =?us-ascii?Q?hQqbsPP14A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760fb06e-d693-43ff-869a-08dee0e2235a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:24:59.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpA+fljm86bEA2Ixji9ba5pQ6cBqgkRsMMiJ5m3X91dvttWaKoTldPN1vp/puTJvKjbNIJaXG+NoKVan3CWtNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9248

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/hid/hid-goodix-spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index 288cb827e9d6..03d549efbdce 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -722,11 +722,8 @@ static int goodix_spi_probe(struct spi_device *spi)
 	error = devm_request_threaded_irq(&ts->spi->dev, ts->spi->irq,
 					  NULL, goodix_hid_irq, IRQF_ONESHOT,
 					  "goodix_spi_hid", ts);
-	if (error) {
-		dev_err(ts->dev, "could not register interrupt, irq = %d, %d",
-			ts->spi->irq, error);
+	if (error)
 		goto err_destroy_hid;
-	}
 
 	return 0;
 
-- 
2.34.1

