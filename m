Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013015.outbound.protection.outlook.com [52.101.127.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B542B321;
	Mon, 13 Jul 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949102; cv=fail; b=VzxUdMIyb+sIuxWhc9KUZ9iZcttVOeilKA18R/jd2M/Wn9r+XrKiolXGNgqASwUmq0Vxff3Qqj37grFnvcb1cUQ8UIQ3d1dzGJBzul4CZrXXR/X7Dt89+lH+AiYCG6aNZCwfOdm+vH+dBBeYQmAUutGfL9vY7OmN1yuNaFnEdT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949102; c=relaxed/simple;
	bh=RfcLwio2xhj+JmVFhCDTCcCpVApUvZ5JC1yq4Kst0K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7XspRKSi2qUpcihlfr9Ks+Kql6mZEHmt/NKdXKwJJqRrU5rFHyeQmxC5li+nLP5Xxdm17HSMVnI+PKnsa7KOWB9ClHyhFtVQa2eTBjm79BpttuEgFCYNolYF9RZysevqZYZHcLv+QwKqh0A9hlZdRjLpQV/54r5kQF6O89cEnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=W4zznX8K; arc=fail smtp.client-ip=52.101.127.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W4zznX8K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw/dZOIzgTFjznyzQff93rPADnhEGHfdsfdjYfwmOgVMB0v8KPRFVbE1PoMXUw4z7eUlgMPoKf84R4ygj8Qrof2++vxR4VpN9PHICo1p7YP4vlhBgdYntYcUOnqGZJAyDbbCqtXHJ6Wek7tqn716VtMzIA5R1nrKkCYHDPzaQvYaI4AyodTHFXn89QZlubXyxWCrSIy/w/zKR8/sKhnK7z10Fweg+i7DXwBNTUWeLL/C4OFWyMWHBinCeTbf6NqkzsQEt5ReewEx3zYBcuKK7xbYobIX25cuZOoDMtKtOlFGBzI170aDF0dcGh3ccIbsLrM5TAEXXPwk2Sz8wexW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EljfDAkC2xOndzkvxHtJyc4iXYMghDoSHgInh4tw6fo=;
 b=rlNJYyZBEnxa9eCCtO2nR/uJJYKAskb5usbBRw+QEEqf4jhVx9HTiFO4WPI6uHpXmGPklYTpRwBq8BSJPuFMdUT10hG6EGsixlnlp3NW1EQ9GqRoitpP8bT3bxnZqGVck4GfFN2A1FlXUt7u5q0zeLLORZt1CMjItMhQ7ly8SRziSpaJC3TELjVokec0HW3xSn2mun9g9IIM4KH/uu6TVJWsimZKR8601PMQ6A7OlfJY2P1/A9uUB6rAoOoudz5XMjd3Cq2QVxZ0GqsaR7G2hGxuEkmhHsimVZ4G7zv7Ghfm3GdjB6yhFKtPEr2Hjdiq++BrmFoP96r6JaeejkAxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EljfDAkC2xOndzkvxHtJyc4iXYMghDoSHgInh4tw6fo=;
 b=W4zznX8K2kEhHp4h1nUOi7CH9Wv+to77PvXsK8SBFl0mpFTGFkrNxaopmpGG5m7hlT7OuTwFdmfwCSLNNI2u2KFpW+q5FpIvRS8q9csTpQDCPWrwaEC8vGLpPzyEwepueg+i0Ht/WtKo07W0q3Sw+cO2nyE75ZW5VO7tJDMr4ffNfejQRtKzMy9hyGSpaYmCNtTobetLjmBu0GbJlzKrGzCd6gkKDJYKmopZdOo2WyT9889znrsEOUuRgoYMPzl4FTM3i5x8cEnRsmyKWl1Fgdf+ES9rqXoSVX6cCG0IAt+H1qi/lEhOt2srDO7Coxt9PKaIo60b/7CcmyUB9u6I0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB9248.apcprd06.prod.outlook.com (2603:1096:405:3d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 13:24:58 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:24:58 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org (open list:AMD SENSOR FUSION HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 1/4] HID: amd_sfh: Remove redundant dev_err()
Date: Mon, 13 Jul 2026 21:24:30 +0800
Message-Id: <20260713132439.380121-2-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c75d39a0-1afb-49f3-f3f1-08dee0e2228e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|23010399003|1800799024|38350700014|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ej7sVkMTsbUxVa8RyApPQ8S9jL674nwgTHHLu5JiiBn1LgwPR7F6cFmTrP/KwIEHCaO0HE6VaXAO5vsdrxeDokwPI1ywQZQ8593kLqMw8+xrydNkqwMn7foo/Us5+pFlDe+YzE9xPkZ/OlgCQdyrpYD1aCCK5kPirDCbKV9/t2cbsQO5Kkp32er/3G5ZzbgHGdclwgn0BfH2BVtYfNJ4y+X70cYst1+/cpmnzfvyyNVrpHn4Q5+FByqcFkqJ2UXLFhYEU0A1deKN60x9WYDk33w0skinrZcMuxfZS0VeuMkGypoFeSDgAxk+GFAvfkoSoaEP9FWPeoK7iQlLB6NcdjAnMSDP564OqNJjcHXtDkrHaDdfAxTn2zpkYfFzPgTTQAQzUSzZltDBNX81QFMDlnTopH8qKqtkImjbgvtc020W6b7lhtGejLxO5UqlosmJrLs5aptow3zwp6g/BiDcAENzZqjRd+TfT51GVMmHklLJeKMsGCi3F2rtVKD/qSBu1qaDV30i3/SAoc9LEnWo9C89yMOtKP+MTkuYD4P/vIdT9veoM8/8YL5GLxrA7OnBj9NUN4O1fNquqfMDvCGeOBlfx3iLKBjPNpCsR5WQYd12LTFz73DOrA54wvf8i7kagGgUW2EMVTwQ3nb7y+uINhTlk/KHKs/3nzdT1BxVz6FEYy6L0VHW/w4JF4EUYTIxkQS01z/ZMZhZMz1SmeCfdumVHeV7vFhSELCOlbbhkHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(23010399003)(1800799024)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uDE+VJSltUy2tcZ15FmQvtA+UBN7Ou2K/zZOg4Qi9ppE18AO4w2HfjdLlK6W?=
 =?us-ascii?Q?pkCrVp0TtQvbcd4FuzQ53MWEoYyHZi/Pi3r4QHpgqK8MNSrnnTffgJ3msKpu?=
 =?us-ascii?Q?cgH0RVzrLPqWJNQOQuosmrFJ0rfUVAYxUdoTrSot/r7kIjsW1BVrD53fXkfR?=
 =?us-ascii?Q?+As9dxcY+OPVoHEyeq3x4H1KZvVgha3GOwGyhzkXrSetWx0NnuHHmJSpL4M0?=
 =?us-ascii?Q?RbRcTNtMZ9LSajGmcX40/jEGlw7gR0JGvi+YqlQ0QyXvM+1QI3IiKaE9q+ER?=
 =?us-ascii?Q?a/qlqtgF8woFRZKnrsYXWKZi0JnjXPiGQIET5Arv9BaZGfdkL36wqvZZsb7u?=
 =?us-ascii?Q?/wGH+X2Ny/fFZusZPvz9qZn/Fia3ZbnQvKMOUDALQZHRh8EcK36RWnK/Mz4g?=
 =?us-ascii?Q?j2cm4jF0jrxEpKnPtNnT3Lnzk4RwxmJ9yGz2k28ZP3aj6eXZy3xEOWFnw1TK?=
 =?us-ascii?Q?E9Gig9efDkqV8Uso15+Sus0XrqV7+xWgtSrebhcrhXCbqgtGQPg7X2ehAHgD?=
 =?us-ascii?Q?RpJ7LEaiTUrrQIOPBa4z1JpBYsXJqLVU/4PVw97/qVr08GVH9Dsk/GO0z89C?=
 =?us-ascii?Q?lMxrHRPGY6Nyy2ICuqXChCDegfHXkLnzwZjrPl3d5c4NFOnGfPt4KtfWDQC0?=
 =?us-ascii?Q?hwMPHQUEsoVyG8/+tYWz3aqBur6fenTpfsBrwaKI/GjKw8572DdQItiRI428?=
 =?us-ascii?Q?o51D/h08rK1rFgXX2PDqr14RqywL8O4+rTO1avwZ9lbnfO5XQuiacIbkSY11?=
 =?us-ascii?Q?w3z+7bmJysP6FruYVHKXuzDIJ/uqowaqWJdWrvMQU4XwqBvIATBuhPyVImpM?=
 =?us-ascii?Q?UHB9zXL+qVT8pIa9YvZJFL4MsElWldLnQ+51JodXlNufkUzmCBP85Xj+ZX/S?=
 =?us-ascii?Q?d2h863DDJArMqgW17vExt5J0o9oC8+3nE1SRUCZHi1MifjRsg07n78udtRO0?=
 =?us-ascii?Q?q24KZsjvp2UeITPkplcy03QozT+IyjiyoH8MrSaiwUxQ0VXBX0dKlj/ztVhH?=
 =?us-ascii?Q?0WIO9ygJGm5vMu9pOtXFRgxZ8HXNplxJZr+aA7o78DVQomHyCbGf8W/othLv?=
 =?us-ascii?Q?5OCQN5G05iB2LMq8+11Is1pNtt+AJRSPhJwdJJsy/kC+NvEqeoxhAylRwMja?=
 =?us-ascii?Q?z6UE93Ha6Ypd3B7QoIrqbUJVzjQi0PwhH6YazEsV5a/hxcWWjKpVERI6LkV/?=
 =?us-ascii?Q?3oUy2i9+bjmf9Ay9lPcIC68423j8aMUDhIJlpS4zY0fXBqkJHSWOvL3sgjwX?=
 =?us-ascii?Q?9WxObA2cJM/r1SUnAFPadfVP+kGULZENlNp5QNXlsszOCkyQ7z+mJUjFiSqK?=
 =?us-ascii?Q?EKToySV/+r+T1BvAahfeCFirnUpQc9yL6SlvOd8BKvJ+9RUm+S8mbv83vLM+?=
 =?us-ascii?Q?lwqCvo859xg+KFrgKz9UGJcjYgEQoPYfOUCsxdc53v/7vwjRGLLI8l1WHQkq?=
 =?us-ascii?Q?Za72AR1/U6hJZaQslPR9G3xQatc7W6qS9JIVtVvlhBiDimdARHK+GFGs818X?=
 =?us-ascii?Q?SvaSIbqeogFEUHr7u1FVd4s8DyRgladw4J2SQ2h+PvP5oy0LwJGjMEk3e/Wk?=
 =?us-ascii?Q?dQYiwAqZTSLCE+QLO7RFj2tKXH9pGIk7ZibPtePRFuAqX0cH5Ogj6bL401H6?=
 =?us-ascii?Q?oxEcG62H74TNW2bGf0ikLmJ+DIl5AYI9tyIpwZgCZmNb15duzxcr3yp96y0K?=
 =?us-ascii?Q?p0ikBQXlHhs1Kl0Q4rXREq2WcNuv9HDNHbQMZeL6E6KbpD2zGIpG3AICQ4cD?=
 =?us-ascii?Q?Boud3a7SkQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75d39a0-1afb-49f3-f3f1-08dee0e2228e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:24:58.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b1HkAX764souatuSuuVp/rFju0gYND+sk7Ap0nVRNetqVhzGmvCHmaeIbEQeL0YLtv2oxLgV6sgXOGS5V1l6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9248

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 4b81cebdc335..a2acd3ca20e2 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -128,11 +128,8 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
 
 	rc = devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
 			      amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
-	if (rc) {
-		dev_err(&privdata->pdev->dev, "failed to request irq %d err=%d\n",
-			privdata->pdev->irq, rc);
+	if (rc)
 		return rc;
-	}
 
 	return 0;
 }
-- 
2.34.1

