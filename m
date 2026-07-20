Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C13B71B8;
	Mon, 20 Jul 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537183; cv=fail; b=Xx/WGkHn9aAp6RsX4w4rYzD4jMcPJ1HaBZK/Do16AgHZiIXES2JcMaQyUlIbKmFPhtO2EgewM7dYHXwW+v7gujtz9zBMMibRLLvcKFQ/Qk+nodaZbitX2aa+MrTZesby3zlLPVeHu4nHXoSTouVF8qF28TyNf/3BLzHhgsrn5Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537183; c=relaxed/simple;
	bh=bpQesPniBc959fOUDprdxjOtf/kg5AxJxIkoPCCCj+8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGX0B8NAs+UULMPGOvU160748V5H8KFtTXRXtFkrpsElMeWS6WUzD+zFGBJjxP/77GV3qgfGB0h0+mE9rKlKtiuzNdADMkATrbqKdF7JdI4ZygHSnDKLp9yjcOu2Qf1pBlT7bQCO4JkbfaJK8T5iNL2mwKMT+0aobZPx2IX1ZZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rv5YxffW; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rv5YxffW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdyNXFOb6FgfkNWafIPdSrlcD/V+NKWpdQGtF2qCmdfHHC0Nv/KeAa8JdM58bc1BBLzOrscpzrziIiry3VpyeMuSuMtgpaG+KRK0UCn0HURjE2iZWAEFLfAn6VYKkQOgRR+gecxQKDp0jIHk+2jD3LD81LjHAMsDSPpKRib1C23TZwYXg0I4rS5RemDqIzpQCnkguwwGw9RRnEB+D4YDxPkcZKoOuPiK5YTdZXAKWGwR5qO0hdczS4904UdEzvqEZM1g1pEHdxafJ+4D64z2TSDoJ6ekqNwGsi1KzkUuBZe76Jo4m5JL7nACdANpPyKAx0rxHa1MuHUiPCXWOCPLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MpT7Z1a9HCh6JJYH8kxwAOGMnO6pCC60VVCihz2l/M=;
 b=Qi6Q+MEqzXiUNGa38kmZ2M9L07buATsWDWBvoi01RLK81sILDJs+7+Vc0AewU03WPs2hYPo90QL73mJFWXDmRRfVB5ZnHuQfKn4bJgLetFCUfxKQsiwjj6uodl30B+w/SiSxngZL4nPxgxXcXyeAFiUvR6o3p19mJD7mtGoBxe3aEKRI+xOSh3uy2MA0hyyCZrj+PF4tks/V7KUJIUvuTQw6Rcdx/6alWeSlZpkQ34YtXgDNP69AkQoKeJdS4DKQJdCLZVrNFGTVzOtPtS3hm/cEcNGLSeSAHb6ckI6a+ywkFcSnhtTjMFRGcrbmYH8dhaAIh+TQxR55yjlZubYRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MpT7Z1a9HCh6JJYH8kxwAOGMnO6pCC60VVCihz2l/M=;
 b=Rv5YxffWwqbPoPAioKXsLf+LkRRjLgQGMy5y1it+xte3O0+kaNxyEnPq6JaqP92tcUgeDsdB4I8BVW5Kx/RkXpqcaE/HxnJJoGth4nX+9pS6G55qvB6CSvoIYRlWg4KiZ/M/mSTCZjmKI2Ca33zncTRevKgaUPQ7VYJwc3ZmqwS9lXfoGKMQvh9p5F0055yZS8YMdDbKFCOnLHikujn6YOqt98klIbppUvTKjApFNP9zP4xLdOCdO5niNVjqyah1dpdQ9+tAI5Vd8UGMkQxO3RFLjqMiSLx4Fmj7KB04/eaLlnrFNpWoi/OyaNNJ7IsVBifww6BygL3AY1LGP+zupw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:46:14 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:46:14 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Pan Chuang <panchuang@vivo.com>,
	"Danny D." <d3z.the.dev@gmail.com>,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	linux-input@vger.kernel.org (open list:HID CORE LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] HID: Intel-thc-hid: Remove redundant dev_err()
Date: Mon, 20 Jul 2026 16:43:02 +0800
Message-Id: <20260720084310.210976-5-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3a2dc7df-1899-47f5-88f9-08dee63b5b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|366016|921020|38350700014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	UjXiX1FGK+zm0yoMs8zPQHQCR1YBNgz1HJjFf9UHFdQ05kmCZYygA2+o07Vx9yevImkSawH/LY7xU6xFu2GqK0/4hC5q7YrZJ+GVP3pWu9ZKB/+HDB3najXXmmUzCwdg2PI+cnwdcSvrNbmafMJYB7+3RhkrHykSx4uyNQNzZ02RcuSP03aeP39KkOWJ9HYAKbiAuqnXOy82TaqEoRXIMcONraSo81xMLYGOuyF4pq6xQ5Y0yFxCl3Vj5dxJcRX0+CsqJ2W/MQCh+Ib3yo4J+Q4GaPZXxzjq8RtsBxIsgrBirzl6tmyAYbw5WaIUWkO8LBjlIJzCld6WiOEtj+Binxseg29WDia9hnRe3rG2DKS791l6jPwSvcrKKeR0BVJRPsFZlPYEvruz1rx8h+vbs5A352nL5+Jc7DHV0Ouv79CjApBEeRKULeSG+YSUMkRn9f5tMKBcvjyuuAWbk9zbDUb0KtHBO3Jsh8c4Pdv5ocPiOtIXpkX8TUhupSqXLLdR8uQyY2UHhU0iYVsgqF6F2ooTCAkTilkCrN5e6T91DYHgjuqeeXl3SEnnqD+jwlFloA8zVnBPcowx8sejT2b9DXkN/ONev84tw8p+f1CVey+ZhuEfJxhkmRINLn2ons1RlFq+2yXjMc04I0zHd7tV96/3E0uwhDqjY3UKS8fFBzIeq+zKCQ/cGPyf9V+tI3hdaeJKkWQfbtDK4K6x63PHA0XJykJMwTz7NSNT4wbYyiPRxjnFp+HRf//cN87AYxdG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(366016)(921020)(38350700014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMi5H+H6htI2aJm6hcsfYOBnrXDGIv09R9isJCBFJH5XPK1x8b//NLb1QpVW?=
 =?us-ascii?Q?sHodvnYgxvhGUOdyyO8Tn6y9nVtvu+l/f30BexTWNRBsvbxULdE/PRF3h+Za?=
 =?us-ascii?Q?HqWcVO5j0naL7Y/832RsHaGaUzVVs8jDXdo2FYt+EwzUFPQ+3rGduOKsCv3u?=
 =?us-ascii?Q?Wo1tKL1OgjYARm+sIirD/dq1s97ZrgekOu8cNvaNvj87rN9v90Dp7hS6HH3e?=
 =?us-ascii?Q?Z3Jg8PCyoICnEZSFiiYEDb8risb+6Ugvn9ZIUrE7VUOsy5E5jlAvnmAQGC+7?=
 =?us-ascii?Q?amrZ3jcYLs8hliHMErhEZQJzYRSEflSxfa09bKW/bTnOGwAXDSLCG9AzbKU6?=
 =?us-ascii?Q?L0Yrhj/+Rx7w6t/fyRv6ewNWskD4IUobr9OhYGpuVErAt80sEmHYMCDSzgVu?=
 =?us-ascii?Q?P5Bw2FPBS81nM8An3gpBZJkUytdS6Cys8kDoUhk0+Yxgm0JW5Iz5A8wH8x38?=
 =?us-ascii?Q?Ln8wbPGwzL+BSZv397sQsL1YNod3rYFNhQvJ/CEN5HrQ95ly1zytT4vNzq22?=
 =?us-ascii?Q?XaYVXi/WOofYYhnsr2LiQeJvo4UWBOSaWLIXWLtOuunJ/2Ataqd6Dp6nPqbh?=
 =?us-ascii?Q?ETWGZMXgaqjGa3aBcdVjv9Zayvun5yesPeR6RmLoLd7RFRL1xgxzCyAh2kOY?=
 =?us-ascii?Q?7uQKqzhNUo8e581Loq2Px7XKBzetJ3iUVZ9FgXghnw7ovSK6b/BjukiDD9XV?=
 =?us-ascii?Q?y4UmNudYET8dbprGvCXKoMUP0k2TvABDTGHBRPCgWdQPMtSJ4WAWDc1ok8Fx?=
 =?us-ascii?Q?6JrgtCCOplRY4ZAIAJXC74e82aqDe9hO9LdxlbaTDk+rkCf8uLoqB8MOjBJQ?=
 =?us-ascii?Q?zuI2mvjKBcInpkN+HfBeZRt46ClkjboQ47Ue4iknyc0Z7J8rJcypHxOBANTK?=
 =?us-ascii?Q?sQrD5WytSwbUVAK8pNbTmh64hSLUWiecwursF/3jH6xaLKpO7x7t+HUXvsOP?=
 =?us-ascii?Q?nUcfnwwrdk3WtngHgEzI0eN7NTuGkau52KC4IR7/mvONPya5mV9JF5JC5QAO?=
 =?us-ascii?Q?8e1Gwku3/iiaDL2fIRPDUAS5LqLkowFh2t94mNlaqrkNVcqtkcRXd6nqZX5Y?=
 =?us-ascii?Q?2QAv+9cCr0ucOE7WPLbu0WjK/YbvMPhDP6dnnekNtmwzxFJpEoyBesun8vmj?=
 =?us-ascii?Q?8rmRrfABU7iBIQSz3hCqpusWnarMEGLDbSeniEDfGXJ6HCT3BiLsQcPGRxta?=
 =?us-ascii?Q?6l6ILPa83NQLUgIEt2fJX84UEu/jLyNwuSuL8Ktcg/OLMzI21zdqOa36+BQh?=
 =?us-ascii?Q?rEQMrzqAUEd2xszgbMQzQjO7ZqHLD3DqvaCzPltPX4+wL18vec6fPN4Ag1Pj?=
 =?us-ascii?Q?dSW85W7et+4uImDzFxy29F3HyC7SSgc56o+s6LrVUF8UOq0+kIJGCw0Ihbgq?=
 =?us-ascii?Q?S9i/3kx2IUQWay4crLqynM1aQTyyNU49nPNcK0PJguuBD8vVWM7vrOVIx5M7?=
 =?us-ascii?Q?cIwFm1ZeFlksQMzOhGOlDt2HrxayaInF3c1y6TRl9m4mFBWisJGGNuGpxuXU?=
 =?us-ascii?Q?QAvGI3rlS5gUFBLMi794kSHNxlpJapdBI2mQ8OBygIy5vIf8hzsK45M+dcAZ?=
 =?us-ascii?Q?Ul0kbettZ1NE5ALoHt6HuGvOjl6frVPZk4HbLno+a1//CIf0yC/Wl+cxgENP?=
 =?us-ascii?Q?VUaPzC9OwQu3vESY+buVoTwLU2FkxgmD+HI4SdQY0SnnpK8dxf7SLItwPcLa?=
 =?us-ascii?Q?TRXNJJCFmuHx0rXgpNlp7VMKKZ/xNn4YevyuKtK9xqjtkezk9VkVbHhNr79j?=
 =?us-ascii?Q?3q/pOy8gOA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2dc7df-1899-47f5-88f9-08dee63b5b25
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:46:14.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsdcqOBwOZmZ+QbBh5deHiylG/aErSAEBYrAHybj1ZOL8IK1AzfF5dMDMi5UEwIQoaGFQwqzWbqOz99g7mPWDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 5 +----
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 46d3e9a01999..59f500345acb 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -682,11 +682,8 @@ static int quicki2c_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 					quicki2c_irq_thread_handler,
 					IRQF_ONESHOT, KBUILD_MODNAME,
 					qcdev);
-	if (ret) {
-		dev_err_once(&pdev->dev,
-			     "Failed to request threaded IRQ, irq = %d.\n", pdev->irq);
+	if (ret)
 		goto dev_deinit;
-	}
 
 	ret = quicki2c_get_device_descriptor(qcdev);
 	if (ret) {
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 4ae2e1718b30..504ef3c842ab 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -636,11 +636,8 @@ static int quickspi_probe(struct pci_dev *pdev,
 					quickspi_irq_thread_handler,
 					IRQF_ONESHOT, KBUILD_MODNAME,
 					qsdev);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Failed to request threaded IRQ, irq = %d.\n", pdev->irq);
+	if (ret)
 		goto dev_deinit;
-	}
 
 	ret = reset_tic(qsdev);
 	if (ret) {
-- 
2.34.1

