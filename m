Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF23B42C3;
	Mon, 20 Jul 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537176; cv=fail; b=odsQ/IQolwm1CcRfw2rkgA+2w+2w6wKIc+SaoZfcgGAivx/GjiQ5nGCa+0enrRNChMJDtAyEoohFMCCfh40xJsnWJDHPq3fIsEmLCgKA1M3flpS0VF5uY+4gOhMf9MY4lNKH6Zktdz8SGQ6F/TzP0pZ9pDOocNSrqRY+l6oJQKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537176; c=relaxed/simple;
	bh=rIdSxrmPhyt64WfWTi1bnO/7CwhCQBD2XFj2nPwLVy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l56+5DaWdWOt+6sKDIVjzFKvymfC9iaNegHLe9lqBciKTIVvfsAYLwjuwAVLjhg5LmrFI5aMKME/9CDvvfs4xv162eXoadpxrtIzN+yqSAhkTLgrfRlC4AcAuXygm6e5PUvYZFimbqAYImBjL3ZLNi5VZ3obGRRnBE0kxfQqLNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PhUlU3EX; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PhUlU3EX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXBAVvZTeXZbnpUrsrlfyynxbG5Bq5zinqrWXG6UTcfLqlHJj1tQ52T/UHz62L3lvzQs1Tl7MBgX0F5PubjPzQ/RwX2+vHLcOKDoYE36CSM1d3/m2zoW8RPPVh4N/wW0BFEIZKZwqIsWz6oVJ6dw5FUnSdIfw6hFGTHnJtUlRWxfQP2UyQzdCJbK0z2/LQAsre+0KqCNPIYJVfGQYqc5okseInNnDfwQsjFaJpoH3E4P27NLb0yqvTy7rLV1rXiCt4+u94L047JvY12FTdz4tQR8JF+Gw/aQrolhrm0cA6qREwuelj9K4wTnbXO7QscUnK/jm3eORopXT7d9nwv6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOIz0Y84zgTrTYEevf2IWr3s7kOaVhK/8JS8Wy6vp44=;
 b=IJiQ3EifejtfSnwwiQOUGDFGhNilcA8wHmkqY2tgZTe8zDUMD7uortSS454WBkdnWUd7nKc/Y6kmjqvE2rhHWAl6+qhlSWIwXDaS7EsHAq+WSagCZMvjy5V/FInnN6fTekztvE/M3ZACXrDgHXlmQolpm4ljsaoODhFpg0rNL/8ZIrQsMxfztCqxRcllogmKBXzSnbIPT9SqhRD1jLAwjsCq+gB1U/GpAuf/cr1Qk27jnuou9M3mI1WqmFlOMuJxEIIt6Yh93TxgBd9jFPjWUOYvvWPYa7pWCTFh4j5zZdeNLu41jyDXldqWqq+YUlxlTuVHvKqTrcUwyDW+GfqvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOIz0Y84zgTrTYEevf2IWr3s7kOaVhK/8JS8Wy6vp44=;
 b=PhUlU3EXjQiR508gTPwdBIVpJJMoDAN6dB2t9d8lTEMm8bMO2Osx0QigRtjzGvdkaF9BKeLdFR86e8ANuGqs/4rYp51HQccQYZFoST0mKnvOm2w0LORqgvSeVezRtYeXwDGXQmms6I+2VO1CmLKPoRDKse2UEXKiJk0PItQEQHp3FpeVzZ/Dq4n57ODW6vcxILSo/A1fRujMuZ+5POgt2P2H2955fTFoU69QRhM7hi6Xr22FbS1lT01SDrO4rbC0MTt8uz8IffYeLKipwsVqSmRl/kfi6w2wZhSdnRZzhBwvnIFIKDBtnjuri4WqKuUi7NjevnbHZgtOFkmhzZegDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:46:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:46:03 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org (open list:HID CORE LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v3 2/4] HID: hid-goodix: Remove redundant dev_err()
Date: Mon, 20 Jul 2026 16:43:00 +0800
Message-Id: <20260720084310.210976-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720084310.210976-1-panchuang@vivo.com>
References: <20260720084310.210976-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KL1PR06MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e34fbb3-2f1b-40c6-67f3-08dee63b54bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|366016|38350700014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hM4Lc5h5IxtUH1XF8shYd8f5StJMWFc+85zWACDh0aYzltMMNVsoyBSic4QkQBW2/z/2NUyZfoaYjEulUDxqXOvziTdg9W9y8Z236wQILDeep2R8abMYM+n3zDeqmd/ekqZKD+xjAT3yYsmB+l79kQXerxqJx3huaUv3aySFrYbl+Yf5RG3Lgvn/JpHrqaYajZqY0LLZpHv7zrU75uEYAZkVkWFWBt72YtrK8EyuGMTjFSf1x6zaD05MoZ7pCEz++ryFEvT/Ml1B+1I6PG9eL4ZchAYzvrrN6LOsGWxadD1YOE3L31cCgYTDG5xRPAXMYkLpwlDDcT+lorBQGF+fQh7Q6Arz1xuInsly8erSz+jhTzDo8G2/bqT5e9VLgKJxA+WmCuDcryEY5C9ipRmGHbVCYfWwTavFHDUC6HqTAvJXDF66FVMNMeDqW7v7WZZf8rg2TUp3RA34qcE3+C4CQF5c3/uNkQpt7eI0e2nWn38xuAR9PRZkYDgirkRt4zLw0aIxG/SJTvidrjO1xhLco4S/dH0Tdhn13D++lK/x7nAfI3EQY1WpE5oYzXuHdcal5i1p9QT071E7mjWlkMBCUlhBTXDWfiz9AorT1FynqqhHIqSBcQxp88TDoJ7lo7z09WsNrwSVe/tCQoHW0WGa/GQhLsDDirvmJk7kj7uytJCLC/qE9ZIlMj8oBwMwkNEzlkiQGQPn05MOzrGblz30BQo+63R/WlxMXCN+WZNPmQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(366016)(38350700014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vzPpy4Mp6IhkO1PIRzl6wgn06hSgayq96BGvSFfDy5E2Zv2PSrZDiuSWlBDH?=
 =?us-ascii?Q?DYo42i27DrsFd79jYArKI0QtYEaOcRtByGZwgkw8ER1xprc83cyg/6CJeUOt?=
 =?us-ascii?Q?bMNLvD43FWsOHrS1MzT65KsjQNmUIxIIKBvIpk0oSb124JRQ8e7MV/kRfHea?=
 =?us-ascii?Q?LPqUq4DMCNE1Lm8MJojrx+y03CygZPth7/wpogxaI27p9T1i7vU7TPYKwfRW?=
 =?us-ascii?Q?d6L9fvJJNi9gsJZHPf1pi0PugXyB9EHq8KF3FgFyXJiZQgl+foahc8ocQczj?=
 =?us-ascii?Q?CP4veCtI23gb7MR5b6vv0MTS/Bx8t0EU77u0K7p91QEB1Tkfy1Ss+r7h09Q+?=
 =?us-ascii?Q?4q/jkUAt6vxFe5/e6g2aW1XE4oUDDk8avSmODwBU5/05yxnb9zFCKIlJg4HW?=
 =?us-ascii?Q?ak08USiyyzRgmjvQ9W02CULleiealIA6cr7pCG+CYBMleJvsZiPFZ3yz7RqB?=
 =?us-ascii?Q?74UMMq95LpM7Wu0M3R2FG1rYBnHds78yH3+OvzuEDRgPGbIDt3DR2OGl4ch1?=
 =?us-ascii?Q?4Gh/jQv66poISXG6b2XPrvaAvUP2hxbLpIDzJP6yj6h35eKdoMrtAwG1jf3G?=
 =?us-ascii?Q?iq+OewWmot/EtpJRrQHrcjlK/M6E/AL3Qi0LTQXa/UBP8JknlMX2of1YJpvH?=
 =?us-ascii?Q?HsdiOetlfygZspi63XdSXmXMQFXfUCQX9C+4XqRcPhjFIXP0SrtK+rE3wH6J?=
 =?us-ascii?Q?eeG4zU4YVj8LnPbuO1a3z65coDCepR9BS+og9dZEIQEPZIWMJvFZd6uOdIN9?=
 =?us-ascii?Q?CeaTrcrxZFtvLieEOps0VxYVf/faoQv5afJ6inYOYqn/OM+0Qf6GdymHGhh9?=
 =?us-ascii?Q?cxEZXQuhPG0QikqNCUsYYWMyEyMUR6gD/dazJLH+i48uYFjumrYQFer/SmMW?=
 =?us-ascii?Q?2Xyl3dswktKYxBk4J1wbMUrvscQrmI9fZmEPLv9ZvblnZ3ZRAOJqSL6kq8X2?=
 =?us-ascii?Q?+izm+oc9cZdivR/ttQpqtX7u0n5W2fx/tg4vBU/3G1Ysjf9MYmsLiyUunhDK?=
 =?us-ascii?Q?Ilo407jcq37aRlHdhVMdL7IDxySiSbS7CKyDnDbxAmH4bAODmKZrXK2jt2TC?=
 =?us-ascii?Q?gmvFz26HIu0xrcpF1rC4THyfGO0CFtGSzxX821Z8yyphQzUZ2QE2h/lAbVgX?=
 =?us-ascii?Q?B+68WOuNq+fRnaq7B1tfrkT2N9jWyGXmzI5jfBdsbMta3LIPon/ciQKLb6qA?=
 =?us-ascii?Q?MB212c+Yz7mHfr+XoNBEsltMTjMqIeNvmzK0NVSVKZlmPEv/+y3jVNeQyYUh?=
 =?us-ascii?Q?6C2/64/22ZGASPmnTR2bxayVG0pzPqBpa1tYIvFT0a1xfzEq/TchzK+srk5/?=
 =?us-ascii?Q?81t9AjTpCUhUF8k99hGq+Rff9s3Oc3DCMxfjlzYNdOZkOJeQwWYnlpFSIMoS?=
 =?us-ascii?Q?I9b30Inq6M3pJt2LjWBv6UaImdIG0mpIbBNXX6F0MGFXtiX1XC7ZpK2AS88m?=
 =?us-ascii?Q?t+owUwurrGQWg3ayyfXBjyIX75v2Hk8YzMpmXrnV2JMMgefaEFfm/0ssxSY3?=
 =?us-ascii?Q?LluE+jYfAMrrDaG0Hvty15ErCFhjGa+/3UcSrDVGmCZ0czvCtFVgr5nmoE6z?=
 =?us-ascii?Q?PsUkZfECLBo4QWbWSQFrHj74kGxWWID7y7XMPA6qVz8045EhbWg5U4ZZI06W?=
 =?us-ascii?Q?tmpOcd38SQftXHfUvRaHfSJlrXwzarOGtColp/Z1I+9lBRHz9akln9a7/DZx?=
 =?us-ascii?Q?VAI/vI6pEk2VTh6GkAXShMQMo6uzR/DdZrW7IoRw5xTHF5baqLYAKnraGjEU?=
 =?us-ascii?Q?dAurZUWuHA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e34fbb3-2f1b-40c6-67f3-08dee63b54bf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:46:03.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sZncF+uGEG5oWOtLGLOzOCp5CA4TkxKUp5wXbD4nJkXMCqrQMrkn1JNh5SAw1gwV1GzPV5wFzbsUx3H/+Q/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044

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

