Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazhn15012042.outbound.protection.outlook.com [52.102.146.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342242314F;
	Mon,  2 Mar 2026 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.146.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470823; cv=fail; b=JbOvwGBq+FY45srs+VULCeM9RbThLME+J+cPFtBmIird00+6B81UN4tiPdu67k00g5bmyJxnKimj3Hxo46H5NgwbvOSpP6aI1CZewQjZqTx+jcoXKJWk5v0szWmM6p2Q1Yk6SHhG9v6GzyifxjKFUY9GeHXZN47IGWSjIy1g7Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470823; c=relaxed/simple;
	bh=awdDmwCKBST5wPzzsj9T50xtGPXTJ1qm42Jfy61npdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pFykkibOWOD1eBrExp84bVytV7CPCTohMf3AZg6YOZF7cgujxxWB0l9jaOxq1vOKUf5h77YGEV1Uv2GUq6nvonkl1pyw+M0e7SUZFWii9X3CKllW61IXB95HaJ7Hh412G1N2U5MiSeuWa8xQwpyBRnZ41La1LcnpTqNicIQkwfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lm5s2eMN; arc=fail smtp.client-ip=52.102.146.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lm5s2eMN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoGf8LlPGruLlao8fz1Ls9ZU6aN4tGX9RcfJZGa0zoLG+MkbOcK0m3d+FTRfT3vzYjLNE4vytREQEf3hNroNzbS2AmlF7/6FWKv2VNQXt/XaNTsSulrdflAfgkwV7IHowMIbsWUCR2CAL2blgYegY7mLOYmcYoCv08nIcse/yroJByMzakX17aGg0pMHM30L/Udbp2usmgU5RrJz3UtpcalliAo0FACnMLuPTVbnfMp7lXMPKlGWL8pJOcObf3RnL+mqRibV7c0Jf+7gHg2y2aWcz940wh3VV9uf/l2KtIuKLb+Hb7eMrHnLilo/mttS/TbwA49G7xh9/DLQ7PKi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeP+2f0xjFeEY+u/jkaf47LUbYRgICncUWl//DIl6yE=;
 b=AF1dQHrOrcT0sclaeboEjSJqHEPHUeat9XE3/XIOBvdQkwiRBiEsbJb2u4XQn/HD9I4pDm7S1z/6iyYUbETGn6DdX2juU2hY3xkGBfD6Zc0uOX7SceE5Z55Xl7uJmWalZsAvlpZJS/7jv1uJELG0MkSU4/P4ZvpQL4Za+K0P0mNqkJf7/3C3cam6LUr7QiWru8UhBHGh0BHZhT1nfRzuL5ZTixZiInPLdMdE5CZ6JCtbub0tMtvtXNuprnX0joOBH3+CxncaPlTZHdc19LKmN7qiD6lMYzDNF6aFLbf8Vpe6yx5PCFFtv45pm7TT2cXg+1Gj6eKNfZ9h/AQ+6Kdvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeP+2f0xjFeEY+u/jkaf47LUbYRgICncUWl//DIl6yE=;
 b=lm5s2eMNrQIajgtJCkfJ2xsKG0Xwiw1fqctD4Bg6BL9j8lzgoLsTssp4LiaU+v7KEc3fUhtTlpthAgUUjcE9UILLbRQrqe5FwUQ6I17gZ+dmeWoHehE7SotxC4dBqLAG9/NKXB9zXzYc0ooQ70zYNan1fp1rs9q5R22jyOwGbpM=
Received: from CH0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::22)
 by MW4PR10MB5725.namprd10.prod.outlook.com (2603:10b6:303:18b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 17:00:18 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::f1) by CH0P221CA0022.outlook.office365.com
 (2603:10b6:610:11c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 17:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 17:00:17 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 11:00:06 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 10:59:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 10:59:53 -0600
Received: from fllvem-mr08.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 622Gxr5h635336;
	Mon, 2 Mar 2026 10:59:53 -0600
From: Andrew Davis <afd@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner
	<tglx@kernel.org>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Davis" <afd@ti.com>
Subject: [PATCH] Input: gpio-keys - do not print gpio number if using gpiod
Date: Mon, 2 Mar 2026 10:59:50 -0600
Message-ID: <20260302165950.2159401-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|MW4PR10MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a09acf1-0189-4fd6-d1c0-08de787d2e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014|12100799066;
X-Microsoft-Antispam-Message-Info:
	1cIgCVlq1vMy+0eN6f34TwDGo10g1lmy5518ohjoO0gBktxwmlGDRMz5h0p3DGSRjakgGVg6a65jsNF9Nr8aBJRr4QQ5AVgdpXOxQ5GE49MshZjY5OsupZ0t/dDvof1L5uiLxM8f0nNac9351OtOfDRwTnnoacxNsqKzgk2V4vW/khssjMPZzwVMeQOBev/mUDCBKNIQy6Z5kWRDkOWyRnQhl/k66y+3whJoFfTIYOFRdcu2W62r9yWHKqK+5wjQKsH8Aro0BvPkl48aKrQ1VKlVp/HbzCPOe18yoFyS67uh4dYM5CMC1wdu0XkwXyu+2TJ/VBqSqELcAL+Zqo0w0Zjnu4gQtzfjRztafxFlfqufm5fd0t16wOpWA03oJE9jFb1Dy83510HxXXCscoQaSBo3d2caX9XF86EpvT/jduZOLMgrGT87kpHbLtBqlDG+nCzcGSpoWXSF0Ggq6v24jwZtTMQddwOgvhkK6MroWC7T/3bCo9DVctfu5V8kzWr/aCM3Ch+lc8LCXlACrGR1nIa8UcpCYsQ6j5AnpP63Slfgfm5162TJhIwEFl6tCXb8Qc8ooYNvehLc+XHXOjpTF6FcyvGpYkibbVDN+wKB+uh7IwyLQeuSfmtMhdjwbhEXm2AO/evjEo/IugPAiUlLivmiS2b1NfUsa2ZyCsMedUzPQgjetzWp2nkpdzO71/fBW5zrxMkjOhfvEwCJUdJVhjw6nCprYFwhTnDhLYh2X3kVjQl4fI821S4I56CMN/GvggYGz57mY+3GqwA7HGP/dP/gCvA4CPBh0BvsktkziTPB/H8Z7RXM1glptpZ/vLBqepnp0Rz+/IqRSAqJ260qRw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W4x42IXhjqFZOVWvL6GTnlOXJ8OnDcek31M8HMptZYM0LNeyVCwIHLYbFKRaS/Rz6WfImj/FI0gmYj9NaOZoJVXhI9dwq7JCXWbmAywwpxFr0Ya230QNSGs/Dmvo+NMdo7ADf2hoir9jCN+Jrls71FUteTMeHXO4Vw6eB5NvRaIOBSYbtA2qHvPp6562NgS3sMwLxA0GNbk+PQwUnHUh4aVU5IIrUbonYwGAOtbnQNSKoskpqxeB4VLXou9fQNM1yIxN/RWO/q0DANUOfMR+/vU9twAqWQ42rI9IBJsvuyIMA3Qux7UmqFMy3/egOSMgsFOCprMfC9+vZ+HJaRAJItpJGgprYNFC5JHmL1U9yhDFIEHF/zfee5hPo3vUw075RNITsUYmmaHB/aRTqee+LWg9uyY2C/tu3bOJJGKABORViixA7GwEU2W/QJsiL8/0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 17:00:17.9086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a09acf1-0189-4fd6-d1c0-08de787d2e87
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5725

The value in button->gpio is not valid when in this branch which is for
the case of gpiod. Do not print this out as it will always be 0 here.

While here, there is no reason to assign irq to error, use irq directly.
Lastly, dev_err_probe() returns the given error value, so we can return
directly the result of dev_err_probe() making this a single line.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/input/keyboard/gpio_keys.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e196174856796..a6ac693d8fce5 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -580,13 +580,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 			bdata->irq = button->irq;
 		} else {
 			irq = gpiod_to_irq(bdata->gpiod);
-			if (irq < 0) {
-				error = irq;
-				dev_err_probe(dev, error,
-					      "Unable to get irq number for GPIO %d\n",
-					      button->gpio);
-				return error;
-			}
+			if (irq < 0)
+				return dev_err_probe(dev, irq, "Unable to get irq from GPIO\n");
 			bdata->irq = irq;
 		}
 
-- 
2.39.2

