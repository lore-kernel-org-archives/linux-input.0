Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013043.outbound.protection.outlook.com [40.107.44.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744D3BED5F;
	Thu, 16 Jul 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188425; cv=fail; b=Ziy8cab0D+w2F0BB+r7hBYdpU/Yvt6rBT4P/oBSA3O0o8+kWrDtHbCUmKrcxPOD0WJHk5swUymBnA1+ySjc2mfVXaOeBDS1086yfDY+VEOvAWliIJk/wYFpxykaMcHb2Hhj6s+Kx+zX6lH1M5C2CgzBhZ3LlK+ZS3LMzW6Rkars=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188425; c=relaxed/simple;
	bh=rIdSxrmPhyt64WfWTi1bnO/7CwhCQBD2XFj2nPwLVy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGlazEV0+FH1g/7cE5Q33GWd8EtKNNO3Cb8G1MiuVHhcE12GNqg38Ch0OyA1i+mV6734zK3C1eWalkwmYCxFgohTiFS/lxuNwXB/MDYC2VOd9y4k9ygWlOb2aBnWytY0z5dBiFztMgf6Vxr+lCn9ZwncdyIk3WABMd2pnjg86ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IWHMkQ+H; arc=fail smtp.client-ip=40.107.44.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IWHMkQ+H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/WBNC1LrzuDn5L8cYC66Ly7LFnPBavq62rZwtcqKpwkx8a2xKJjkjtoC5GORIGD1lHoxp3dY46XOrrKc4PPNwt+79/ui73sA/bUlD21AUMz/LhAy6kYVnnMoTj1ByS0jqR5Lrp2jaCzwjAbfg0Co6YwFk1bSAZDFDgWT6vOWXLMwwZ2U6qwJGi1Zjre3zUbLZ+ujxFWSOD1euMXa+OFkJU4AaK3w7drJrq3YsRjuOqdN/y7zb18fDnyAKAubGJQC1knUvhOTNaCl1hrzBGPNgBtfnL1rePMRYtiQX8pg+SkP1ZdrsbCsa83Jy5fWWN/r6UFOd0UeJ4cVFRVJ1TGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOIz0Y84zgTrTYEevf2IWr3s7kOaVhK/8JS8Wy6vp44=;
 b=A9ndU651mGkjJCEsiUbee5RfVM3LRG65g5fW0fltW3WBPzv2ZEZG0aXpYw8qmXkCKBJTCiJfsMZoGheszDLWVGKaEBXCns9lzpIS6hZd4BAWJu8wk9m0XO7RSMiIJ9tiLmwmG6kIXHLDd6/jf+iCYEcSzcINt4qwUpbc02WgeolU3pggC3tqe9F4s8vMnkbfSACq+LTNM1IJEKUyiO/0qNJo7+ALtm/b9WsZFcb4aIN1iG2btw84bX0OueZ51ZGNvONSxICttrbGvvY3z3kX7geLiSVuAuVn1WkBFKjRPxFZ8Y2VTE7HIp8/JKUV3vHlmMFerFzpY8ajaN/ay7iXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOIz0Y84zgTrTYEevf2IWr3s7kOaVhK/8JS8Wy6vp44=;
 b=IWHMkQ+HS4j1B+DM8pbQr5Ve/1e/ABZDSyL1ERSTPqJ89VONMwtMe22TluIoPPSerhUoS59WrYjS+S1jxlNbdONN4TNORYCEv4CVMFcczG9z1t3L4tafRtMF9+p2G4RIiiYLdkDTw+RKRZPLsY6gYKACi2tQIqMupJ6qgway3/dIkVibUNp+y1MoRHfYqmhpk7XaU/bVbRUK3it3MC7tkLNcfelhc9RmehRKewW9KadxQMYkPqtJb0w3Nc3FLU6boQN2bIvKsyqpZQUWA9hmNQTcpKxO0RN/V5vvUd+jaxMuwtRYqtGJ8Co5+MzmFC7IuM1S7iq3pJnlS157GQEnoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8506.apcprd06.prod.outlook.com (2603:1096:d10:8f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 07:53:29 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:53:29 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org (open list:HID CORE LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 2/4] HID: hid-goodix: Remove redundant dev_err()
Date: Thu, 16 Jul 2026 15:51:52 +0800
Message-Id: <20260716075203.593012-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716075203.593012-1-panchuang@vivo.com>
References: <20260716075203.593012-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d8851a-d360-477e-6151-08dee30f5330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Hk/BrqOrTPDdpq5li4+oJTpm1renPl78QGfSw2lmHoky+U/+yjfaoChmp/ZZpxb5bPDgZDboOOKJyo9nmLePzh1afb3UBWAn3g5q/M18nFtHd80JtGanHvew9y5hoBT7TQJzAqxibdUZk7xzpDVxqOgjM2jvvia/iJuUBBXffQta3EK9bxY7K6Afp8wooqGKO+sYjm4KNL7iXuHF1OzTTrTCjACJ7F61kaoh5Y2GqxiJfr59Uu+2kSQL+Bw+EE5wK23c0oPtj0TLbdpkwgqDEYAw0uKPOT1EAqspTubbtbKyc1lLYUD+gDkwX/jXHPqszYZj8qF3oFNBoyzCQDm5NDE5Jw+/l+q7UwsZBqYIhRsFnrBd+zMlMrZIruh2yOpqEegspKfGi6d6VdA5UNGHMAfDLPeNYQOqwCenIInzgtppKwTq3/IdSBBuX3Qbp7naIg212obJvatcF1xDoh1RGIW+9fPcGqcrl3ZyNxnJhqXqkht4FmLkMob/kap4IJQ7J0SQRgp4YV6N6KCGX/FZgKbKBl32xZjddu6XfzDO62vWnteGygWI34wkjeUL1b3KeyhiNbw08U+/l/uN5WuCEYlurdhzynDnymQVx3G3oRYmQpDEtqol7dPyeUdK5893YH6KyOI+C5dX3K849XX/E5HfIlEFyGSrvtPJWD/UDQ5iMSGMUDYSCrPlJ/GWxcD13QZoMeXxFeajJj+zPy+UKXlaCTxvZyfSmb199po5CQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9XK5VzQZ9fuDKisWNoR7b4K83FQpCRhk0gGx0HLzC8B0Bu1gEgndapL3XLZq?=
 =?us-ascii?Q?qKxBCJ9/q0UUOGDtO2V/PIldPYAK+17e0B+8aqIw1f24SYni7Jz6ekUXJm65?=
 =?us-ascii?Q?LiytmjbIE71RgDqXNUtuZkh3xY7qYhLXbXG+JVLGYyJz/5cVJlZ74WdJvRtr?=
 =?us-ascii?Q?jvdDQdbkeLlPhKwgZdOkMAHZh1a08ckq/xvOkB6qcV8mtFxgkDqqBw7KSSTZ?=
 =?us-ascii?Q?G85L7SLLnpxAJrWJ1LXEJsGC88X1SSze4XRsITAM0PlqLDL1+0zTNUUJ+1i7?=
 =?us-ascii?Q?RZdcBrRi50JrBTUU+yclQciPM56XyfS3iIV2IueG+cn+m/rxSSCZHzjtYnia?=
 =?us-ascii?Q?wg6RAD7xDvCBBwVK8qsOqItXw/toKeAEUu6V0ylIu2AByG2ShaOOuXRAa7QG?=
 =?us-ascii?Q?OrXyyDucZ2rRPli+XuYIibhTuoqc7mnCXb1IZ25R4l8Y5cnHUWnD6Cl8aCtW?=
 =?us-ascii?Q?jIHhyh29EQr/jCZm4t3biSiGfs/PAiWkbeA4b/RfhzTyoh7Ec/7zJu7VAliN?=
 =?us-ascii?Q?reaLwcMEDUb7pQJIPS8MFb1f3EfT++eRiKGCPPmumcWv3R2kVIDQV9Kx/S2o?=
 =?us-ascii?Q?lgP1TRERsLMPbs6q8baPjNyhjzW5lsQvK4VxuwCFkzVYo8l8vy2hXGkFUAgb?=
 =?us-ascii?Q?yD7bx9n7/TtqQ7bybsr8s85w4NjgY+tW6aTYlcoOP70wFSPzSJn/OBc8H/il?=
 =?us-ascii?Q?HPEwGeWoIHYt9A2Pi60rx29y08UwMr+c3wN9vEwb5EGsOPF8JA1iVaIfRgwc?=
 =?us-ascii?Q?u4ry6e45ASUhWLElswkgOpaBDwYICwXXrMWqNZ1dBoPdqt3fkiyhEOknSSwp?=
 =?us-ascii?Q?YnWbq5St+GirvCuTY1LVn6UyG5UG8jUusdAZqGWlsq5oxjJTbaIN7mFIcuz4?=
 =?us-ascii?Q?g7J9QaJcL07yS9qLyaoCbw+nsMn6hmNScT2KRACwsWZShFQgSKFF+1DamX7y?=
 =?us-ascii?Q?XYwMv2LuJDbOwoiM3c3LvSeOcAQkS/zMEI86Frn00g6X6y1PxRs8aoe4nTbN?=
 =?us-ascii?Q?QKwzVY8KqbDD6LSOHsd0LXqiWxXDkQn5PZcDDCibSodwD8MH7I7m7hQKYOxk?=
 =?us-ascii?Q?SQXm5P3/8xQFLGwOXpc/HlDvwNGqjwnliROEvE9LbWjfYoF310L00bGKgaZy?=
 =?us-ascii?Q?RLp3q7pPhZd7ZU3KlJOASXctSpZTM52v379yFPX+MYBEmV6LsuYNiG272uHE?=
 =?us-ascii?Q?c49o3LMvOJzyx3kwllRQtkejqN/7QHRjzlBV8jcw1GdocKrjCtJ8aGoL2xdO?=
 =?us-ascii?Q?xqekqmS+ogUagP6MZZensQ6BwMCuAyTqvKU4KoytOgxD6JOaO6U0uZnd6+wq?=
 =?us-ascii?Q?RiQTBI5Imc6DrKIv4PKyV0pe9YJxZhzz/cu01UqlqNCQGS6LL/n7S9kcfnJf?=
 =?us-ascii?Q?2PL0+Zq/zc4eChIVOy5fexGw0UtjIO8KC1UxLY7UxTkoH0EedL/0NEAijSKK?=
 =?us-ascii?Q?67ktJiyVZ6iuuJmt+Ssv7pTQARfMskmoqtCWBbqCejrqXmwFDBQybfRJH2uu?=
 =?us-ascii?Q?Nf7/ur6tjU+ViDtCnP5aSse5ZW+ShaCih+ve68HFGMO//V3j+BCnQx12RISE?=
 =?us-ascii?Q?wpwz2DWoKltYC6OM+17qjhvribP9Xhz2ZfFTmMZzuAhqRDLT2gSIuy1N7kNR?=
 =?us-ascii?Q?YwKmZ2rajnM9mIR73BTOOzWPMCT1+gAMJ41oHg7Oyxyqx9YRPByNzynK4GfL?=
 =?us-ascii?Q?D7fgHYhqS2xznlJD4uud8md6Pea7IjuAHuqsrFOW8WPu4Lj0pLW2c95NthuN?=
 =?us-ascii?Q?azacVs1d4w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d8851a-d360-477e-6151-08dee30f5330
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:53:29.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLOmbqnm5PxGdtoG4+SQ3Sk52j4svZNwq0r5Ohizeh2/rpBPcJftjFT20sMIfy/hwAG971H0rKBd0IzqtZeMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8506

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

