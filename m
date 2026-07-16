Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013043.outbound.protection.outlook.com [40.107.44.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FF165F16;
	Thu, 16 Jul 2026 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188434; cv=fail; b=EDiGOus9ZBHaAoEH8jtFbqhTeyb3e9ht/7aSevZCUxJFK7rApuc8V2YSPp0Tja9fp2iunwJoWewCQ6JeGMmT5qsUY39mXQ9kCPJZmqKsVz8IYS98meETHc7t30oSmr0xxOaPZFVb3HrmB8WDWXMgHrc6420rzGqplzNaDYOE8Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188434; c=relaxed/simple;
	bh=ZudKtQCuygLPCIPKVoMnnpL1wQ4hVddL2P/MzDng77I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvjNFQj1UAmceQbELA4rsjDxrKj5PsI9BkbhO4RpEZNs86TkbBBucO/GhVI7m2Zade4DbKgQX7GhAtAZVaO0JlhKXtX6mf/fAV1e/7rNlhinFzLp9oP7pD2b8IpqkDo9mFWa1vTOTRVLMwRqzsznZzOXIIBb3RcAmEGi3U7HJ7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hsNXrY5B; arc=fail smtp.client-ip=40.107.44.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hsNXrY5B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGykDhrpNcT3LN+Nfg+XspcOwtYkiRiHME/b5e+SIJRPy8O+Q+JuDKuLfR2uaMYXhrduAx49JosmksVRSxZ7TTJjF2ZsUflb5w/eC+N7FAUG/mUp52s+0OTo1Us8JHkvKpMZh58uNOs19HbKyF4ZhQiQGNWyLNVbUHpSo6F3riPnIrngPyjEbE0wqNHgNasG+3M3ljd6CZf6XgtC7BCbXf374mmZXm8v0Bwg8V0Qm+TVyjOXpniwksmyNMTs6LYOf3cMGXo2rnFftmx6Viu7NbXXPUVO48oL1KGxlC4NfcUYo2CWSsH3EQyzNP9eE2d+kongGJFfMgHXb+V/eonKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQlAX6iHBDku9AxK1FBJtXr3NdX98oXIfY9L2cqvSes=;
 b=jq9nObL/e1l9IbESxU7jaRBNeoHT+GULzT3Zfse2H5bmz0FY5QSmF5hduO618TfN/m5+2fh0G4yZ7cL8tJcYifmCRW0ldva3KzU70J5J54Vg3/Qw3YvJGeYD6+ehVi9GHDGsefkYBaD5vrfZSVwZ58kaawh7A/qpLfi9WyIGZ+eBKlLHA6GTVnpkPt5Z7W6pbVwEOkJ4k9+ulI91pSwf+5g20HKIn5BUYRtRAv80UqNkzcWB6Mnow906VdLYKrQJBR8RL7BivdV4JMVR7JRbtOQoFRkWYmA1x0jOsZPFANLeq8W+Kx5+JXt3dloHs9bWYbsPXBBGKmSOxPq9nOdtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQlAX6iHBDku9AxK1FBJtXr3NdX98oXIfY9L2cqvSes=;
 b=hsNXrY5BAazBCNf+A7/BMAlrvwOrtmV7OG5NthaQM0K61PzzlGwLnEqrngmUJKK5YtDtU+T2qn/5nwrumkSb4e4VsYsF8QOLRr3YBvgIeFoGPYY0yurns6Sv0T/2aqWOwN6bzE9/s/Dk6n1mN7XIw7UgdGt6GpsNfoH/bwqHXx7SbiT/uZlSxrXP8F4/3IaI6CK8iIQusFf/2XX44X84p2m+68UBKEvEPz46Cmn+K88Kil5MGFFmWUuIsKUB7NQAI0s54bADvrDgx7xIUDI6DWSLPh1t4sV9jbGEkgTjXvRmhfjTMXnmLRKuAZBxsFgiEWrc1b9bRuDhfUTUeqidgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8506.apcprd06.prod.outlook.com (2603:1096:d10:8f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 07:53:41 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:53:41 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Pan Chuang <panchuang@vivo.com>,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	"Danny D." <d3z.the.dev@gmail.com>,
	linux-input@vger.kernel.org (open list:HID CORE LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/4] HID: Intel-thc-hid: Remove redundant dev_err()
Date: Thu, 16 Jul 2026 15:51:54 +0800
Message-Id: <20260716075203.593012-5-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 22af746e-ba29-46ab-a84e-08dee30f5a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	YSFWaZSbTduHIvj5KYQBViIFBXIDus1B5IdLvNj5OiYR5qzN9XelmShD28plf7I59zpcMujTX9IxDuxARkuGxE/vGsECz7NJWmML9askBcxLeEi8SKr+jGSfEcabVbmnDkdVTXn3b5Ido05rF69VgdIAADkBEzUL+ZdBotnnfVsxgws8pnqIQJAt7C8Nxr/xhcnhT743+Lppt3QKlQCG+sxfkcQfpqdcAWo+NwuNgJlQON8uwD0+qti/rPiEVZQIAhan3PoqplSZ45FTpVbV2XCZG0E0b6AqnduPBbP7qbhoAyMz7SghNgrHdrtHR8bnCjoWrYjhJfGjG6Ox4FyHIzvSHemv7S8ZFvNePkeHZ7oPG341atgIoNQsoyXPmlwWLYr3ZoxgdbcVBb2ZnAbjGobfcdmpNp4y2jnyxwTxKJhoebfyCimtIp/znzk21aChE5z7BWQQBWCPfRKY/qPgAUIFoh2eWR5nIB7H9OyVCX0HqzgsXhK2/ZX2bhHis11bwhgsLd0VbuEmy8ldTB8V+8EGHY8+cuBODyDcCKqyURrHtAVg8VQWtTy1Pa5E5GDgEzGdfTM6orG+j+UyUFcDOLqlN6leOmNTnIL+5T4pTcEozLnoB+yMnrRC8oUHlwH42j9psw+sLHmFSNJw8KXznMPhPKlin2nf9eDQhoajEb6EpzWwOxpxlwcdMTwwpRsmkiVGadhg+K4QeWpLRW3bBiilKyVnyhxMHXtr2R8MDOu+nEagZAqHBJMtbRsixcNV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nxOPL4JDB7169L/BvbZOF8sDEFwqlQrWalUshgGPe0PHH/YBHa0ewMvejwPF?=
 =?us-ascii?Q?yMu+gtIpH5U56OYGA8tgm05+J/5q6Xdu5BDnILz5ZksnzMYhobdB6/rUW6kh?=
 =?us-ascii?Q?ehvWV916xzqWpguCpKlh3kSkPUUPieUzKq42gy6Yq7ve4u4XiNa/efIrO/Q4?=
 =?us-ascii?Q?N9ArRuH/29vLUHmUXGGJ2ajCrIA1l9jQ65/n3R51/hFYq/x3O4au3zRtGyVF?=
 =?us-ascii?Q?YLtJwEOeWn+3tD4cAqd2HL2M8AjLtTqMCfPVAeUsH6WnJGO1hCdp+6JPYyn/?=
 =?us-ascii?Q?r82/V2BRHL3OQo0vs7SBNW6RCFIiLxbMndbXTYtjPQAgiM7lpNmj7NXfFqHR?=
 =?us-ascii?Q?fKTCq9KqS1BJMbcnuxChNInVfzukbM3+XrUP1vLeQagYFSkRwV+L067CxlyJ?=
 =?us-ascii?Q?h5btY6GPbCRIeWBDzvtb5WZoLzSkN0/j7zq6hsCVj45QkQe8sK8uGZpoAwQE?=
 =?us-ascii?Q?JZBHIMejpgyDXE76Yi+WHbUpyk9DvSPj9J/1nmyItdvTu5nvM8EQGGhubdP6?=
 =?us-ascii?Q?ms3E6uNEB9lTP24dPbn05xrdKPdsF1ui/1aqfWZHLEdD0rQqXm4HRmqXouoH?=
 =?us-ascii?Q?2OH9plF4mOT0mr8ZUWN4DF5Jt50vEFVnA8ZZF3u25oF9wWXXDln9qSGF8kgs?=
 =?us-ascii?Q?k1IHCZPzAcptutcmKb9jUxBBBz02jAHrdZLPbti6KudbPIAWEcNALPv4NpBK?=
 =?us-ascii?Q?g3fOgEzQCHPP8hPXJ7xWy0lZ4rFwRxkFSoWC0qiEkxEbB9pIYmGxYbYAeqDB?=
 =?us-ascii?Q?7ZI1kRIClCEcXniLRfbpTNNsWJ19QflQeaiuyWb7ZKmiHhWU3cRowD5HxQ/7?=
 =?us-ascii?Q?1y0OGuQKxH5lL5102vOPqe5cbNd5I7mT/4wcgDUW3PGGyLyhmBONMmx/SAPC?=
 =?us-ascii?Q?3wd6YY+qI3mVnIdwDgG3HJiDiTuUYA86cMvGedU6RlB9i4KG4Dy+coLtkL4J?=
 =?us-ascii?Q?b+9GBWyG3ZJraxrlS0QQpWG0WxKAQ7aIeUNkSmI12SfRUWqkN0VvEjoXb4c+?=
 =?us-ascii?Q?COnZt00XKCTFNMrhApq63kB8jnShppCih25ytQOIobINOO1G9f+yQ9gGpIBe?=
 =?us-ascii?Q?sBV2eQnwUfVRvnvPKWHM2hbaXrJPYPfrWLacfMnSA334V2gLJ/AX6zS6YbLv?=
 =?us-ascii?Q?vA5TZIyrHpbAUMiRZF0gd7Cpo9fySyBZWnJ73wnQx32lqmigm0BqgFEZhEwE?=
 =?us-ascii?Q?H/pQpyPx3e2QdOY6F+z8fvjzjLkf1rGRJAvKIKkdA4FTQXniszy+vk3F+eC8?=
 =?us-ascii?Q?eTlvAANmNnT+aWQRQs/dBAxGlBv6Y2BdiTxUJ/n8lOKIUOsSU4LpJ8/u04r/?=
 =?us-ascii?Q?Qj7UA5uI+LVw3Dg3s/zHGEasbJqmldb9Z2CrKfxdvUstawkYVFyTCtwTonww?=
 =?us-ascii?Q?PmmHDSk32oY/p8kB4o/PmGK1mxigrKZYpzsOl1MjAAT+2iJdSog56q7z8Q9i?=
 =?us-ascii?Q?yDHRvfFZF1psD9108OC3JH+y8PIO16eqaaqfQK88s+1Fx0obh6V4aTZ5YS6J?=
 =?us-ascii?Q?oFnnsw0KeZ+AS9+zhXLs7SyUR4PsN6s3RyUctJKWNr6xQVGFpjlgZfZIv8KB?=
 =?us-ascii?Q?x7vnsdDLXNZxXsXIvMAb7rJ5XMY5Ycr4OKyz218dejcdcS8Wq0U6BlStd1Kv?=
 =?us-ascii?Q?PNHprify01seXh0Yv47kAKl3d8kjgh5BrAfRah9YfCnDKzOuWA15kLldW0gm?=
 =?us-ascii?Q?YY9fIS65IcyhTgjfk0XFKjrHODlShjphGzxqOxPpxvi66htk9HfIERSi5MjC?=
 =?us-ascii?Q?tZVvLw5+7g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22af746e-ba29-46ab-a84e-08dee30f5a21
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:53:41.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk3UlKV167QQaDFqpAYPa6erCBqtBq3QdBD0QbZG0TFsO2iqp1kVLaAJ1i+KKAch5i0zpNMQtpGVF6NbMvuTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8506

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
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

