Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013043.outbound.protection.outlook.com [40.107.44.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ECF3BED4A;
	Thu, 16 Jul 2026 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188431; cv=fail; b=k4K2fUOadmbwJNK+KXynOSiqZGeaodi+jFr9diP3PKFcJW3x2eB1X6TT3yav7zdCme+Stp/dm3U0Vg8h2bq9IvYwUID9he30ZiuTChUowK4+Hxttn4URuCAajFLs4of9mJwZYwFpc/YCc22tuckPeRDMEADDWjzLa5sxmXv1+ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188431; c=relaxed/simple;
	bh=ZcNcckda1dnWUwD9TdPwawLmDQnlGaq6LY8VZt+uOaM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvaZap5I5k+OnhNbXbFCDOQ5+SY4Mz0DZtSx4e1DM5DmVZnPWE9muZpcQGGDEaps83/Ecpe9+w/MMorXCnsKoB/WeEcCVN83Aj+kjoxZrI9b9JvGg/KftlvtDO+SW6mjeYuhYOLZep4szI1l5+mT0hXSi9jjzh7Qux5yezkYM60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FAaeuJft; arc=fail smtp.client-ip=40.107.44.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FAaeuJft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWRvp7z/bVJ87zzp3cy67nxErSs/2QHsoudo9ZrarHayk9GuZC1PcKNG6B7vbjDSiPRH0Plf3jydchvF99FEJrYz6biRuCfLBrIHDD1Hl1GjiQWzwU28nyiKXC59+o2p6W+DJOajC6Xc6rt3KPXFp3UIK6a1sAEvsJGXYvUJ5xfTNmp/NPBX450cjWtApuJLL7IxfQkVZ7eIIYXnQ4qea9HFaaIXVM3xubVeA3AOk4kaBCtgkI37JLwILASSpIDaXxvf74rwOxwn1Tb0xFDgbhYHmdHE6qhSuYk7M4i4jL2rUuA/T/8c+KAkDtd8NUC/+5Ss1Z1qhdBYYeRJiWDkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQqnkSRd4zAYbwzlRhVgThpJ44dUYWW6LZsP71AaZCU=;
 b=UHel75ggMNTTUBT3u6EbOz2S+aY4DSjhTqIEAeohZG6EZ/Uq6V9YgAWHkAUO8aeojhzvEhY6a4osln3eM2G6bncIYEfn1G7FCc28vp8HHJ2ORylfqZLaxGbm7hUbebKqUw5VcFvpXmKKjOHXbSyqqBCWA4MvCj62msQLsCcEKGL0y/PdVLTwYbzCCtvW4tJaL/LCqjUIdEdNsizsb9HrZrFAiaaB9k5kPZauKmofXace6KD7DOQvxr2qdlACPcJ3hGW8XwcB0tPquc3QMDmZJU5O+Abtaeg8mvc9EYCKAeqZd7UNx0K+Ldd9Lhxedxru4yRSCzpNt76/KPeKfRJTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQqnkSRd4zAYbwzlRhVgThpJ44dUYWW6LZsP71AaZCU=;
 b=FAaeuJft0TvFxJsE3j2iviybmKD9eWAhVr9RX9WmIvKq2/dgtwrQHHcOUrKdNXr1M1Jcne9+/3MBDv1hSvqFDBb+z5/fcZDTZe+S47zZYp/uAXyYQSr7fVhJi6AOXP0vF22Fn97og0hZT55Kh25fFlL/W8MJb6skXt0+h+h7SV2Xveypg2N6iaWv6u3lvrwWqTAfl/AHKPOVv69Nn4BMzMuj4tsGyTc1NRmwJsQry81/JzWqVFqfShJxUvzwpv0PejbAq2mkmHSPYT11uNUAvgmY7ZC+uzY2UZ7s1cbpOu55PHztXcLTK0SrNKXGN5SN5oAwtfFt2PZlepz2Vs/4jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8506.apcprd06.prod.outlook.com (2603:1096:d10:8f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 07:53:34 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:53:34 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Pan Chuang <panchuang@vivo.com>,
	linux-input@vger.kernel.org (open list:INTEL INTEGRATED SENSOR HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] HID: intel-ish-hid: ipc: Remove redundant dev_err()
Date: Thu, 16 Jul 2026 15:51:53 +0800
Message-Id: <20260716075203.593012-4-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 108ceb6d-ec8a-4304-7c83-08dee30f55ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	vcuC4+BGVObiSxTIHHMEE0O8HTURnyLl50GVr9+4Dn5k7aQp+9PmSwdhQ1x1Ah7U1QXRR8DdnaUeo9vKy39kcLckPQIRpD3mT9rdlqrqfQQDOLATR1SeEDxiM+IAwvQmdBf9XP493m61kofe1n7G2GE/dXhMrQ1dweDePwhhN/h2Iez3jAflwF6/rdjM3gAIBtFk0T0927USlT13z5d0OaCr503N/Y42wTC76opuL7VhFCMCJ+26Tm1iEBYmKgHlTujZUutfcvztEATphW8YOYHkim5U5ECy4R5A3bEod5Mw7F/KCKC5YqqFBWQvVSQ4A1Ee32tma0bh8fFdxi81UJy1qbdWtWcO+0G8DBe4b+iW48XFutTDdZ19Gl//1Wogla4zGYdrAdnSQoU3yitVx5pjnjKyeuymXvDGVhzq2V/miEMsumvdbGriFXP7XeMIxkX1lQeG/iAu0lBJ6e0M/CHuXhpNWIAJTt8UghvMnYjM0YjBqeKcbiBqgt5PSY1KCrjHTR4IfhER7q2dIoShn5RnvT0ur6fuSVGJrIHLG89OfxsLwYaHClV5ESksvXio6vdDVoIV+UO+WV0+fWl9Hr8m3gJ9fHU0LH7vVd6tAFuqk72AnjLQjCjBUvyyuU5MvroSuAHBKmZnhNQ+iC2B0T8IJ5w8pKm4Hj7nUPQocbKyHYIxYL6HaWwe7fp+W1iuQc0zWn4GN0iVQJFVzJXXXuBKnoE2YYXicdsZswQdKSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VE/iH1ogjTHvrvwq0Rsc8COexbzXTL3DxljIOvDl5EvOFLj/H/hMRoLO27fH?=
 =?us-ascii?Q?nTbGMkG8gxEkYaPb8ITwQwJ9zf34jRH+gcAfBmftD7qJgnthf8IV0SyI8e9W?=
 =?us-ascii?Q?Ojute6gBMRqN3QgvkyTcjshZv7KziRqDsrGWn2LgNmT2oAXtSRRUzAAm9/MS?=
 =?us-ascii?Q?L89BFQOpjCvcVg7YxesZF3r5xT4ZLsiLElIeIp0c5VCDGgT+SNvgIeFXQWiW?=
 =?us-ascii?Q?dUe1a2lQD0DHUwVPO0eVOXoWGy+UhtCC3DSyFrqKTQ6V4abyWJ++FuJY46Rv?=
 =?us-ascii?Q?RwPyIW/6VmqeiSrDZAvkKl/UW7u/oWNyZEArugu4VlD0vGAy49LcVOeVycVd?=
 =?us-ascii?Q?cw+mXOUvIgvmfbHjtIRWa7ZiG8Dw4p6QK9woqtbVyyOCogV0hTkdl5zrPBfF?=
 =?us-ascii?Q?lyvdAO13LjghXHA4znOlgxNzPBHx0+ekeirLWKUynK94hy99vFqYsqoyF6VN?=
 =?us-ascii?Q?6frAeUlORqXovGnRa5PejFygMVkaumtz4IigMiUksQkMlsmdlqJ5nmLv2biH?=
 =?us-ascii?Q?3thIqKdli2N2sLyIaFSXktTGEapNvkY205cUpQSslmJ2FY17GNSoQGyxoVeJ?=
 =?us-ascii?Q?Zu0Uq7cKJFccYEslryQabfOmlKQXjuw/+5mUpAQQhjwKIQomoypEH+VltI3Z?=
 =?us-ascii?Q?FfP+05VV6Osno/QxUVEJs4FLuxJ2OL27/1cnn8MhWoFyFsLiNCUB9djzY+sp?=
 =?us-ascii?Q?AQOctU7v3ZHhe9Lp1iWy24n5GkZ6Onj09Kq2H0E+cepNtiGuIbG100CjruFr?=
 =?us-ascii?Q?eBTz8qmT/MkOFmvhQCWP6iLKRav3S4TC3w50vGULrze4SEYm96eBPz7pLgCF?=
 =?us-ascii?Q?OsAgem5J65H3XKi+opSJBhg+rx9wYkPS2qhBMGHmcBBNSQv/4EyhmQiGA1yx?=
 =?us-ascii?Q?KZLZWt/J9t2rc+X8QMeQG3RPy4NDD9W2Ti5oz6vH3jw9NMqkWoA/UnvjqCQU?=
 =?us-ascii?Q?EJmdg7xHwL8LsyHJCogy5Vk5J2ATchZ5yYNAD3xOTpYQX9D0mu8joWo24+pU?=
 =?us-ascii?Q?zPQZvBzGKvuCuGAmZcr3YcgXtnjvaGR9yGJ4JKgf4x2+OKdIjQTORDIoaEEx?=
 =?us-ascii?Q?LzLvLO/eir7bFHjC8ujzMYJZZaQrfgjBlgP9/boVviSC9SQNZEwh77M9hxzu?=
 =?us-ascii?Q?nAYcMadkPutOBcgtd3Ta9p+HHKu2ubB9jcnVssHx/eVPXKnhR7a6x0YbNAAH?=
 =?us-ascii?Q?wbsvDU5qqY8apnByZo//qkOTRMhAS7BsI9x2AnwmJi70c+Dvj83SsfuwzLfX?=
 =?us-ascii?Q?FHa40Y5MWBnp/wGZF66VMsb6uYnXpgllu7qVKRVeDV+UrRqTHxmdpNTT3ZRJ?=
 =?us-ascii?Q?ipjkGmvndNc1sBbEE5rFmhMMSH7YNTX5O+g6yDDnI+24dO1pck0UhXi2miZm?=
 =?us-ascii?Q?jfTCcyaq7BZAXi1BnKvX+Ntkyo3ilODn22HS/ZD025553GkJdwuUIrw/oBHq?=
 =?us-ascii?Q?uDAOHBVadw4ROm2PiFmMxygKXDSEGGFmmW0irtaRcN0Ou7yQY4IEGkOAA/Cl?=
 =?us-ascii?Q?qPxnUIk3zZLmPapj0PFuKB0Q4U2WWz9TUBgTUqSGaHJqmWS+J6lBXOZw/h68?=
 =?us-ascii?Q?y+N5Q0l6sTjlp3j8Bf2POQBdcxGpTyLutpfXLoH7E4aGQKhNp1jxhKy3d+y9?=
 =?us-ascii?Q?iKboX54nWzWrjJqsjnQtAlf0icJe0+3PmbpfUNLCSdbkyPb4V7H5xxWJo6jA?=
 =?us-ascii?Q?/rbUtr1M3652jNRN/XKSPrBSwZVK1si2Vq7gS+Og342eVydfqjTjqhr6BcTt?=
 =?us-ascii?Q?zvJgYG6q7A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108ceb6d-ec8a-4304-7c83-08dee30f55ec
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:53:34.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQlqey8eO2tYacF/+d9finG06uDlDnKIIm6KvPERBFgDPmtB/PzZYGA86ipJAXwSbloE+Eyx+ltA/ntZeZc4oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8506

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 8d36ae96a3ee..e7196e429c8b 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -232,10 +232,8 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ret = devm_request_irq(dev, pdev->irq, ish_irq_handler,
 			       irq_flag, KBUILD_MODNAME, ishtp);
-	if (ret) {
-		dev_err(dev, "ISH: request IRQ %d failed\n", pdev->irq);
+	if (ret)
 		return ret;
-	}
 
 	dev_set_drvdata(ishtp->devc, ishtp);
 
-- 
2.34.1

