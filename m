Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013055.outbound.protection.outlook.com [40.107.44.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA07F428475;
	Mon, 13 Jul 2026 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949114; cv=fail; b=tOVRlhpqSbIi1EW4L5hI8air3C9SdUlTVLHQfafVQ85UJKa64WFI0y/fP1RJkHIlgQ/fGPk1lZZkJa91cHLd++llya410T9kbWOmi0y4kXW77J6VTd25qSAFgEB0fiAOcMKN5b+z0ABGTL7J7ylDRmASUxg6L2mXTDxpnLb2mr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949114; c=relaxed/simple;
	bh=pGpq67zANS6IoDeNWczn3vPFy983TEhjbiKeM/WBxFw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4VdcpRWuoyV/XYY3j11gD3f14eK6zmnEDyudCifpGDRBlo0+4FTkSsKWw1GtfiVHExI4JZkb10FSUj/7fTv4+lgk+BPjHZriLDbEMeOE0ltlFoNIOgE57AUsVlbQN2kQjHkvX/vgXlTF0uBw3gb/FntQ1QX6TDscT6KjoQ5tC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kwgMXCVU; arc=fail smtp.client-ip=40.107.44.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kwgMXCVU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIfCl5o8ax+WDGjOHzWOMnBTuRovg+v2Mo8ss9d5Vr4/vJU8RaTMQ53nIAdzeLl71CJooXvOLKJjjFRnogfiinVbvCh9UcVUwA9TSzRaMhUpoo7ClrY+GTLNttOt2Sa9fA/svlV1phJgzidP+z2TgEZWw/73hlESE06gvvXrWTs30Ct54aTzhvb2aRLGDDUEkflncgVhE5u/Vut1Hr4BCYBuFwFXMDQqRfIrfG1mmbcEbeD36E3qWHhapPxm7kgpvLKxb1xyvQO6cqfvazvTXcQ8jp2zBIVE8F+nxvh+lOdIcFmiKlmO8YWuoUDNPYZDgMdDyoDqpWc89uexaZBv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffZkQFSQ0UmJ2QdL9Sq1IflMpsuDj/WyfnZeI//0sYQ=;
 b=zDqj4r+PBQeUHf5kuBtKWfqofbcwEST3/kHWZW3inZCSk/pxDU0lNcWNCmifgl3dg/kuz7BDSlYdzvRiInpkVyqo5RO8lJbtPdsbNH0hiREZd0syWUZDlNJhRnGhlrcSqey+dr3gsoy1BtNGM1O1uWIerHH7LY/0QuVb8tTi/wugXy87ngTfE3QVroxeHUXrJW13aQ+ildhzK9jIj48N4FecwHjBAV7Mr/QmzfwNyKS/Z36VN7+n7QdBTR4A02iOzOyesfDOHP2ffc9AaCMp6YAxqKjn+NMdOKgm5UfmiwcZncQGXAO4Z9OxTXuFpNAmJik2E1IWzcU3FW4eBj4Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffZkQFSQ0UmJ2QdL9Sq1IflMpsuDj/WyfnZeI//0sYQ=;
 b=kwgMXCVUv3O/xtGvs30M57mTamJdFPOZJmWR0L8bFD7QNyobKD6CZnacL5kS7czCfrDoTeiWImmnTPQpyOFYAlgde2Axc7s77ZNJUDM6o79uqvxeiTdd3SLiWXACIwzPuxIKNrOynrydAiZkcyXQhREc7nqXCRkRgZ8csO0Sbge4AFU6KW/h6OVGeNpeFdN7ZAx6CRV3K518eH0bYK7Gky9Dl5gpaCu6YnMM9qR/mdTMdNkW8CQ3MuSG5KTmzylY5mMI9bDeEiXA4VbEvJ6Fm/1jmU1hewTs6C/V/Jyg9tf9KV07/d85YzEWJ2p+iemB/hzfBIxUgUbSGhEgYIHqlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by OSNPR06MB8956.apcprd06.prod.outlook.com (2603:1096:604:49b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 13:25:08 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:25:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	"Danny D." <d3z.the.dev@gmail.com>,
	linux-input@vger.kernel.org (open list:HID CORE LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] HID: Intel-thc-hid: Intel-quickspi: Remove redundant dev_err()
Date: Mon, 13 Jul 2026 21:24:33 +0800
Message-Id: <20260713132439.380121-5-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|OSNPR06MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7537121c-b093-45c9-ce3e-08dee0e22862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|366016|921020|38350700014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	aonnNAtdFF04h6ydf6Ss6hrhHx+mYSruGjS7iwNLT28YcvDkzj1u/ztX9QNMAYFPiFhVDph2LRAqMmYgY7HYGWsKaAzUQss9Rsz0a1uqYXS/7d5+/QDCsqkQKZ6F/jYwFmyQbk7hDhnrqYYxvLqtPdiHsanRuOWtG8NRhThSSp69gJFDpdGIn9e8phWAtlpVdPnf9xgLPAzHSQp/wrtWfBeKijGngFSgc8zQafr4kmRiki3ObekL55fRoaWXaL8pDPRen9lyjy0h2XM4mtx+l6ofgBtz+OdoHgaBPzIZR8dZlOUAZPM86p/cWsfzAR+cy9m9D9B+Ys27n9p9l6LUbWEQxsLVSay2P31mTynXvyWuO7i8yH4sCmk6jin2Unze5+teUT7v2XBvj4EliIjGJcBv0Xuz7AaSqVpDC30smSUyqYPSjp2Z2uLXSN0SHwgAEC3ZIFZdpjpuxX1FLnD2lXGxk9QHN1divcDYWJUCQcPpyQ+8+1ounhSh3gm7jr79yl6x2jmFMzerYNlvZpq2w2lP2fKH8w77P4CsUAPSKMJvgQXJpCCJXAne0egXgFcHqSBjCPNi226GUOH20Oc7pvERR4ktlMNTZkd32IvgZnx9ila7yQLPb4n/kWB04zz8j1BqK6SXmsDI5lbG7vh/NLWCfahSLFCxq5jAqSZUHcxbq3fuJqiViDE/ALK1GYW+YvvG6oZuTuJMxhchncBjGnPAiQXu7Jiq5HCcW+3NfDLkucM46O5GSNnwBODf3JnO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(366016)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sOkWzTZTYbAmpVKN5Zm4yufuJKysW6xOo97vOKrPf5hebUXWN8CrjgLp0MUN?=
 =?us-ascii?Q?+MxKSL2+v47PHCttRYueGA12JhliCyCHAUQj6xTdmZHNdrGIx8U6XnPm8uvc?=
 =?us-ascii?Q?/tNLim4JeJ3rlHg3H8Jc3khoFWnut+tRB+3yyklsf4vt0FP7d2bZyW00Xdbs?=
 =?us-ascii?Q?JoZwISu6594Y642PorYV4EwsMqvgUFtUeklwTJDre/Rm3CXtRjwJH5gAEd+s?=
 =?us-ascii?Q?/hAJRBbJLPcQq/f/b7vpijkwNR/FN+IRk8a5lztI4a8Z0eZzfPfTouUj2nIb?=
 =?us-ascii?Q?seKKPo1k/9Eykmi2svKb7yopKSA61OXVC1JzPasFun8quOJE5MY9BcNTS8NG?=
 =?us-ascii?Q?oT5jjvfrDlvyCv3xlgZVjno4ISVEZ7ak4Llde9BeZgxDrIsOUwGKR5S7nadF?=
 =?us-ascii?Q?K9TalFXtaG6JiVPESK/6VbPgecG28N7Xb19sJbFU+GcmS1og13A2P+pxjZQW?=
 =?us-ascii?Q?+0NkeOoAesYv8wGUsYZ2lcwX7TJIwL8TbNsgpGHLPsxJpBGH1oDC7jpd66/K?=
 =?us-ascii?Q?C5FPU+Od5JjTHlSZ/tP5LfRbGlRSyAZcpYKCYzi4WpmKwuFrXecmG8bMcGYm?=
 =?us-ascii?Q?JZRaKWBKetR0L+ZW8Sufy5qdIZiZLt1P5sBet0TaPXaGcwvqLFoAmbhG6qRJ?=
 =?us-ascii?Q?DkW6EP1DKfvhFYoHrBzb/ZnyKOPeaMVT0AKsnuwVj4LcMw4x7PzBFPSKajg+?=
 =?us-ascii?Q?RnwL0n8syycUerqfCBTKzSQj02cyCCRuO3zILBwYr2oIjMYJdytTelrWydnW?=
 =?us-ascii?Q?nWbsFs+PM9cMNWyqp1ptLzP7gywCXpkw5KzRcsdOfpHrl1wNNmk/uJehMtRC?=
 =?us-ascii?Q?cmseHO6MYy7vZO0NSxELBLKxpzmysbOmyqQnawaEzOlDlzF30/8a8svArUzC?=
 =?us-ascii?Q?Ib4M/0AHIniSLXkmwZzOLLOwsc6uIGXWG1SZA/S/S+71rgaweEcrEAZQqIaA?=
 =?us-ascii?Q?MVPRQJuuE8dzXjcyTWNTpEVPlAZCpyYuvseVikDZF2G9sgZLB/hlVdu+spfB?=
 =?us-ascii?Q?HtyB6xpoCjSI1iqR1sivzLslDdN9Gb2IyJhNT7L/nwzg+2a+974FFF4c93wp?=
 =?us-ascii?Q?O6pWz6j430Fk69Hq+8viQHvgzLXYg4BQ2/D2jIy3qHW4GU6TtNqm4DZDMSiu?=
 =?us-ascii?Q?PZs69iBGx+hBHmnY2wliRV8WTGrQWb3hFdk3Lcv5zRMiPDNYEBmqwYcNCadK?=
 =?us-ascii?Q?PeQNkAgxKM4IV2oKGrH9PXKh7Uq7u7GAxoTXbI1DGv1HCC4xTpMOR/c6uwWT?=
 =?us-ascii?Q?5rYy5Vdb/LycZuOFH2IGRhsQ/9Sp6hOWyoIM2jlaOspX9+erAxQun2Fqv2Df?=
 =?us-ascii?Q?A+zFILi2Ka0NE85i1mDi6/CQZYgmKWvsxSFiBuN1nSB33gCbEJX387T7ynyb?=
 =?us-ascii?Q?WAiBdnvuoV7Ja8n2ijb8GlU7hQ8YMbwgPmvcpkMSBrR2SCoFkhyqPM82dpfI?=
 =?us-ascii?Q?D93UWsjZ4UBGafJ9zqGkd7U3545VlBM/tHm/KoEmg0jgn2dYL3Il0F1kd1k2?=
 =?us-ascii?Q?IN7cTG1a82pNxKz6PJ8SLfMMo6TxphkKBpA09oRJD0LlYpTjXEGn5o4zneTN?=
 =?us-ascii?Q?nHVqmvIZAeMmdHAOsAF0UsaaSm5zLdrVr4VZ8uvXVo3UyYOaXnH/ITvUw2kw?=
 =?us-ascii?Q?d9KqARkAfzgwtN9q7jo9AqXQvHSwnxPH+deL0HkKXyz13mA4/1DU5ADFOjt6?=
 =?us-ascii?Q?q6b1zAtUfm5YBsHT4qzFCxEpHo81Ys2fg/+SAvBKszPejwjAs8yz1O4tnQWw?=
 =?us-ascii?Q?6RL6lkAhdA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7537121c-b093-45c9-ce3e-08dee0e22862
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:25:07.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5i0xaowO9TxCQgNrPAor5iL+4jt8jy1jbk2jP4OsuZxtR2ZNMNGLt2GOOSyi4EiStwWv8jZmJl+WQPxw/Xu93A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8956

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

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

