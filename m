Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB23064B5;
	Mon, 20 Jul 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537172; cv=fail; b=myYqnCcqoDp8At7+w2X0EVhQjYdYoFTPmiJUUiadvCBk2kCBHblv6tSVQ7nlaT41MpitbP8s7rwybzlnhY5BGIqvtaWOtKSQFaAP0tKVWmj8cKpb7Vk8OlpgozJOpvVzrkregxBR7TjXiAi6yzpiU38W2L0LGjRbHZu6KtGQQ+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537172; c=relaxed/simple;
	bh=TtxmLylGg+mWIZp54YOFDXRNvQSEr3Pr0KsyhB9EzKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uxb1qMjS3Bn/R1UveK7nLAUaFr9s8O0wk1PRIS5Sw87zfLDGlEM1RzzNP5WUSgOMtf6JhaspixIMC5Q5zKHXXvnJWNdgiUl6W3WqdVWWt465He7N6XSubYZXUyZ6mNoLYWvz0ncyHeUSSwB+45jT/fbnlNCz4oNzKsSML/ozdh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M/AD2NPh; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M/AD2NPh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+JX5igbTkB+bkj+FLOlS+35t4Ej0b/iKCqqSZJwC2GudlyHcrBs6kO0gp1OV1d64XD66yMcD7s/ZXExYnewh+nOB45dIw1Co297DvAoUxnc71K8X9IK9rnjw/RA6OqpwZQE0TG27/gq+H+nf5j3ql6nA5w86TgQDRjFPyW3SFINuVfRdi0GSpTeZ2n03dy3x+UBiR2M0eqdiGRjVSXH3gsZeRktNz+wtRVTPPWKpsiQeM7SG+k7pU+EI8+1MG/r39vBadqQbjdmKbtAgKTXzqRgEtK54QYvuk7hkaJSku5JdGMsXBDxSfJ+NbMWshjELgopy0vvAMgZxQ3BJIXy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ0f+Q73Vpbgmn/LSlawgc4pp4DtMdL+sTzKqAaWlNA=;
 b=PvG7R5vLhhS+LE7ecA+6m3JHq4Z9qyXJgvdOCoLCzNqfk2GEPGlIPOvTaJVxcfkLy4HjhVitkAG7sav8ezHeJKGBnLLKbGFbsP9nz9DVAUjW4K+qkluq09QaJ1wqlKW5pes0yfRO3y2yBkeBXBcEWx2lsS0XwgRbqa62c/wzjSVuL8sefhjlO0jf06ibB7uqHQ32JmOXUOvx17s8o4COAeH9ijcoLLwVMRnMTi3oNxgIciGVSodb2ibYvCrQVtDKagM0MXzXpu4phiYOBbZtMGT3dWOuRc+M6JUs0LNcMYiLCcGYc+4gyltQt8J1zJvqANb7sLAGYuGI8dGMschuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ0f+Q73Vpbgmn/LSlawgc4pp4DtMdL+sTzKqAaWlNA=;
 b=M/AD2NPh6xFZoDTPIvsux8BxEAbvvnou9ZAyaRJJsCzEurw6QDmIXqrCwoBDk99jx7D1Qf9qAgz/1aLFiYGpWY/A3XdJWmWWQwgqfhFhIiTVlKlywTFFZoEtvIOMfIg+DDDbhu7rMj9wgWrj8+jrEau6N8GjWndbGD612tKZMmSPN3hXPiFn9jxKIAQxekcuZUvyfWmN0W3hmDmfxVf1TKFBj6JQdW2WJRpaWBlKmhD6usSuddDOAfNygFhYy5NN9CEfVHEVKz1yhiVXmIEG6ry4XJdDqHb7/lnn/GeAknDqu4wYo5qkYDVSzY8xslqQo7ciY7VBkGA30xEmkfCyUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:46:02 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:46:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org (open list:AMD SENSOR FUSION HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 1/4] HID: amd_sfh: Remove redundant dev_err()
Date: Mon, 20 Jul 2026 16:42:59 +0800
Message-Id: <20260720084310.210976-2-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21eb8390-4f79-4c7e-33cf-08dee63b53fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|366016|38350700014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	n0SFqPzuLPSxc12I1QkHW8S9vRe6zGWPEJs2HpDE4C+v7SdoROdeqWZf3sJB+TLv5CRUR69TcgDpf/22ztN6u/n/3ittghL4YBekMKF/GBde3v2djcTOAohBzdRwUUe4/3HF0sQW+5KNgZPa6QKAQoW+vEZqWBhlZn4gacCnpyg8h6ZoL0FWs14z/sZuWop0Nnv/PtiaEpuUZSdY6By4YECXN0KmQA6mcbFsLZ3R2E7zan1TkPBG/o7IdH8Ro4kAM1H+EBxGs1c+BHAGCW0toHlak2Y2jjj4hEj9GLYsradn8L0l0+Xw3NU0H27XpYixvHTAs/3ockrhpN462spAl1UMZqlCgp6IE1qYk7OdYlFkjfWVIvFtiCeSso6YV7qcorFFLkH3jeK8VtqC2PM9gUpn2PhzI+4j68LZAyXe0ec2AvdXn2Esr0kO+FDriwskz1AAmHCnni954GRF8IU0gAOv8WPE/0KXxT26OOxCcRmOwwt6EkCARI9bC3ABMMmqNcgH/Swq2DbUxTaj6o84tyVSZdUxuApDnLOSv6fFwk+Zq12FD4SzLIPO2fVMW2HKYffaVxpypde3hgqRg5NLbIbUo5R0OPGO9ptnvgJ0b9RfuOJUgX0Y3jjMudEdd7ULsPJfx/f+XTt4z8Zq7CRwCgM3aa+Lz7gcKRWHaBfIu/H34Dq8V+BOTa+StRTVSdbtTpxK7C7P1rRvld0dFYLgA8btvCQnqUBifD7x54JVIuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(366016)(38350700014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZjUW0sgIQNElExi9MtqWsmWf1bkoPufLtdq25ScxTzK7izpTPbh2ZdrDY5S?=
 =?us-ascii?Q?rHKvPi+xIJUUj5RpuE6g53mpW08WeejCxIHQZcFzQ76jyZso8siQkRzKZur9?=
 =?us-ascii?Q?kyELpmic41EpuS7hRcQvKGE1K8n0mLnMEBEkmBxGrqGl9prKiLZ46IdIwcW1?=
 =?us-ascii?Q?qiO3qiKu4GR2vqPe7HObuYndIi0RMV74uyE9GDoeHMYx8oAgcBELLQcbKi3x?=
 =?us-ascii?Q?9DeZlEog2+QkaUVPuEDt4A92VkvS3qftHYuSCid+vldtkenffqHqiA5GIGeB?=
 =?us-ascii?Q?w0566iGpidaG76aKGLRqCagTu57RhTUpYxbB/cup1Vf/FAIc5H8WDe9/vEXi?=
 =?us-ascii?Q?Fi/zRUSUsKUYZSt3sUcHlQrO2+jWQU8cBSo85/X6QWQmE6R+gaGaY6/952es?=
 =?us-ascii?Q?9a4asUoDuKw5lgnbvUZpmG58CMXDpaEhd8u1O857Jvs55PmLaoZJGrF9mWck?=
 =?us-ascii?Q?qrlc32sPPEqvByG/GOttpzqiDMDm6ruB2/E7XzjHr/cqjcP7gT6oIlyXBsz5?=
 =?us-ascii?Q?71BPdnehobGzkSaQoI2ZhyRXAT0hDWra60b+mHLxIgA2Plqe5WH4FgRCbE/k?=
 =?us-ascii?Q?wSifd0BC/a0HD/yLZiSPVR6+fDLr7Po8YYbnG4D32z7GqGA/oTNABw0S1smS?=
 =?us-ascii?Q?JslObO00qIbAQyJizpGCpSYy14ZR3SOrB+4zAhdT5KXFcRrqWxIkARvMT3/N?=
 =?us-ascii?Q?TeXLC5g1Y2BT/O2BXpEHIZqpweWJ0wWsb9EQXJbxdZ5iv06+UB/XG2F+i+6l?=
 =?us-ascii?Q?BOH8OoI2ODkzrxyDkyH9lhrrL366r/5aJ11NEVWIXYBA4K1vuAZebAdiCc9R?=
 =?us-ascii?Q?NRCyqFcSRvPv8BU7llKe1gk8BQkuOB53UMD6Irv7lskpfvj1qyDSRQVF838n?=
 =?us-ascii?Q?+sQbmhGD3vjRDxpUhQPAS+dt7giCBUWTRjZV8W/eEO31/Xs4jAFp9CNYktas?=
 =?us-ascii?Q?zIULGBt9NsbSlCOldtn2LGbp/id6teAcmqIdX+E8hD5LSberQmc18fXU3p0v?=
 =?us-ascii?Q?5e0hnJXv9+UXIm5Y94UFircFw0zydQB5BnM/PuIddvb5nclbpPSbPDdjD1IR?=
 =?us-ascii?Q?gwx6TcLKW/AlZxJWjk+cqkc7g6OHG4g00aJEfAAQLMmN9Xn7Zt2T1z3j4W0x?=
 =?us-ascii?Q?hTyem2yHz+pzz9/h3UUb6s0a266YpEp7WSxwSZFIKGz1JAGYfEXHDUkGI1Lb?=
 =?us-ascii?Q?8j+Ql+zUeafTebq1dzy1QyT/eFgJqVYui7s7uso27g0mWqCOOEyKF0ttztW5?=
 =?us-ascii?Q?YwYTTYJT72GloDgItdYtLia0ZMZhQZl9RsBNG3Nt3tWHYVUOe7AgE/SZUqe4?=
 =?us-ascii?Q?tBZCdnqJXk4LsRKTtVfko8vCr/sYvo/PC/4gd2ZumOE3qzRqzE9IhuLEmAZJ?=
 =?us-ascii?Q?NgBMQJrdGzhpubw2Isjip9EINlIVyXzvc60uwA+pJ2b+n3yIp1ncV8hXQUTY?=
 =?us-ascii?Q?A7nf+TkVBlZL+36OBllN8yyRChZ9N6ikhToSaLAdn770a22unTBVx8nLR3sl?=
 =?us-ascii?Q?kPif1h4aRZHVkK8Fr6WWZVrKYpNFWH/rWiexBrrTen6t7ZVdexPmNcZDMZZZ?=
 =?us-ascii?Q?L97jMB/8J76phsgB9eiecuh0gTlMcNZ26gD5XKLfUZCP65tSy872tvcJo5/h?=
 =?us-ascii?Q?QiGrHR1TQiuIqY9duPmmsi3CSLV4F1cAfOgLTFXR8Y1Gb+SlBBw4nMLI3QeJ?=
 =?us-ascii?Q?iQsJxusfKcP+t/9GW7irQGQiofb1rFUsZCJomJChdiFspess2Gm9wunPtcOt?=
 =?us-ascii?Q?+mDix0QNjQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21eb8390-4f79-4c7e-33cf-08dee63b53fb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:46:02.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WapNnQrajI/iE9Os/JvBvFDciTxSthLQtXHI9FpWiruKlmE2MCjM8LfkSL2SD441r6gIJMJDUStf2Mtkk24zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 4b81cebdc335..4d0a95fbc4e4 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -122,19 +122,10 @@ static irqreturn_t amd_sfh_irq_handler(int irq, void *data)
 
 int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
 {
-	int rc;
-
 	pcim_intx(privdata->pdev, true);
 
-	rc = devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
-			      amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
-	if (rc) {
-		dev_err(&privdata->pdev->dev, "failed to request irq %d err=%d\n",
-			privdata->pdev->irq, rc);
-		return rc;
-	}
-
-	return 0;
+	return devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
+				amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
 }
 
 static int amd_sfh_dis_sts_v2(struct amd_mp2_dev *privdata)
-- 
2.34.1

