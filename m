Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176014119E0;
	Thu, 10 Sep 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059817; cv=fail; b=n+pvT3JxAdFhv3krXBBRUg9zIAXZ9E4P/1Bl35VhhwhPhRi3o4I35ea4j5IStj0NI5mhc0GY32oBnT7oKfg8udBCgf5bFRXuHT1FfZk2IPi7GRy2xtOGcRukNtKBseepp7p89z8+nBRQvfIgrZbYn4pjIOPwfNwkM/dS81VeY30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059817; c=relaxed/simple;
	bh=fuvlNg0k567Y2eVkXvsyYPXBZFLXb84lwFdi6y8VqHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlsSwnseSvnzha09yya/BNH2eZTg9wlbEYT3/+nTRVbV1+Usc6xOPx3E62f91zvhXNu5WlcSDqUBl+ICGI+9SYAQ36d44BjUVZa+duEKGa0FK0xjdelIJvQMnsp2wJDYIfsWSJkUuXQ0BxLCengMX6bW8ci6s6Xe+1XGLrYfcB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DY4+g8C6; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DY4+g8C6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBsc9j16l6n86Kpvou5gn68coIAP/SPnNN+Vnf8Rk2hAfqRJtm3AhipI5L4cEyL4KUY9dbHropqlcwkCMiIBCN3EnMrUcadjCf7wOy9yrknTE48nIjAGQNQ6XtGYUsYAPwMgFiIOrWa7FvAFL3ynOy0P3ESJrdtnjTxe6jHupvmOzu1UYUzgqPPrAuHSHOvWwftqNO+ivsUAp220qK30//itpAirXDXhgwpju0qVPhmp6XLOb8+EYThrT+MeZDCBTZlpM2jQC6HvUMXXbM2NlFX1p3oKkJ8PgbdfscGZi2EIL263PYzUvq3beaQm8drDDV7h1GlxDjDJePpr7h0Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFERsSrC7mfEgThZ9HdVhZ37+kaRD4Kn2dCqBkD/FwM=;
 b=OZaPoMhXzWMWt7+Ae9tBzGIUBz0ezYEOj0BqwJKCF9gsCOdgRPhp+lverY5OiOc02+xIqmadPpZC+WzdoUiq+wvg5P4yrC24n0VTvCPVOvx7lKk+59VenL+lahmAIY5RztkkL1mSnA00BVa09gAMcw44OTFKk1GHMwSh+YyN0PUdtLkV8542iyHABbt2zc/S0wTQNhjl+Z16LLoCmvQf2hMzrSKY7Un6WBQu/9crdizNbRa3JxhJ9KolCVSAkVzvvTmN0pgpXKq4qaYpjZooT5r+ZkrDAqplx54oFbgP1tM3/yl4xMnRmN04rxLoTgfBph/z1nFz1CNVzS/unXcAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFERsSrC7mfEgThZ9HdVhZ37+kaRD4Kn2dCqBkD/FwM=;
 b=DY4+g8C6ZJ5qZcjwsIcQOsrCFsAS+intQH8xwPY8zppS1jn0sQyYySv0jIpaqnZ6qRWrXA7b7s9ZWWh0OvoT5TWvMVZV3Mb8Nr8sz02+y5OFhty8uQxHR3gwDH7nisW8dN8UDToCfIojagX/GuNdJqkLRXtb8QcraeDvedGzDLk=
Received: from SJ0PR13CA0188.namprd13.prod.outlook.com (2603:10b6:a03:2c3::13)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 17:03:18 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1a) by SJ0PR13CA0188.outlook.office365.com
 (2603:10b6:a03:2c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Thu, 10
 Sep 2026 17:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 17:03:17 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 12:03:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Pierre-Loup Griffais <pgriffais@valvesoftware.com>, open list
	<linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER"
	<linux-input@vger.kernel.org>, "open list:USB SUBSYSTEM"
	<linux-usb@vger.kernel.org>, Curtis Vogt <curtis.vogt@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/3] HID: Add shutdown callback for device drivers
Date: Thu, 10 Sep 2026 12:02:52 -0500
Message-ID: <20260910170254.833871-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910170254.833871-1-mario.limonciello@amd.com>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 463bd5b4-253b-4959-e2f9-08df0f5d68c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|10067099003|6133799003|22082099003|18002099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wWPmoKsF05gdklSIozdrg4drO+CLfgHkR1BNvl22IJ9mmn6U+tlF/fWYoACmo8ud6UUI7GF3eyWLNMn4wbCjBN2rAd117G9ae3YfD+ZhMHJw9dMjDWX0MAYdtel9P6JZNgjIWj+pSC+0IMC6x9N8+GJ3s5l4IhcXZzBcKjCGZN8p59Z6Jjr7Do6uQ+gx1QIojnt66/wWxFW78RoRsRz8Mhs2fVVlo9N3xYK+PNr68lA+JK735zRYsml9o4TULWj+yi3idf+qWmefBZ3Io8VoZ3lvXnUa9iJzkRNByh0G+aEKzSVtX3JHmBKKi0wkzf/ryclZwuKyZezTUJOnJ9v24mEyBV9q0uNklT9L2LwSB4GSSlNJ2tHCXkbtgjp4JBI40GvmbsizJqwsxsAOUoKmOtZGD3aYuaInuxWVoRyv4pb88hgiWXWagznyXcUzWHnnMXT4NZBrnTq+TTiXBUTZTPD8B4q/3nVZjwxxR2lfA2A7REKYxefnqIct0YYZl9rJBehQUfXVnIiSN5h9zWv/rGNxtUZRFkH6DuaZ73t5OVbB5sL3Nipw1SD/xn+QnxzZKBDdh0QwCHn63f5Kp41g8p7qhG7WduGeVFMxMWMpidVwmZvEaNcCVI6jeiN8vu/CAhwD3v8Wt57zBiW+jx47L+2GDUGg9kuUsxJ/qMPIBwed6py5c8mv5VfdUfLbXZ8r/ly8UmDpSLnIShvmc3TznQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h/qJnCRkgRglxdBOsz4ZQ+dd6rlxW6yZ9ldHlhYfNzAjaGr5yjAFyC3ZDWomvR0N8tPYg0341aohwybShDDF8pTwbTbBS8ES2EzU/sS0bCjSOGG1hRQm377SFE6OrqFDHrauWwAFOD0QQwrCb6KeVzym2PpdADDIlZcRUOICvZ/J7FSn7yU8Tz73gZooMrFxmIEQP8WX/l6vuUacSdkt8yNH+l/hHDgu2QwyqdsOc3ww6e/h13NT60oGCbt8V38wIKAsq/jVJDYyATb4rcuXiVyzBDYeCmeNXUjk9iltsKFoMw3m9CGi1mgdZOn8eMjHdtnkmsZ3TEBKJpKjsbn3XQPlG7CijLjSs11uBO7quh1B5+/bW8kktd9cV8Ivb2a1mRxzqM/g3ky9i6yoLBnxJsQeBeUaNiZkqz+1vsSil2AYI98SRVQFk6a1nshCoarC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 17:03:17.3123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463bd5b4-253b-4959-e2f9-08df0f5d68c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

HID device drivers can receive suspend and resume notifications through
callbacks forwarded by their transport driver.  There is no corresponding
way to perform device-specific work during an orderly system shutdown.

Add a shutdown callback to struct hid_driver and dispatch it from the HID
bus shutdown operation.  This allows a HID device driver to communicate
with hardware before its transport is shut down.

Assisted-by: LLM
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hid/hid-core.c | 13 +++++++++++++
 include/linux/hid.h    |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f9cdf..7c8c1aa1f09c3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2738,6 +2738,18 @@ static int hid_bus_match(struct device *dev, const struct device_driver *drv)
 	return hid_match_device(hdev, hdrv) != NULL;
 }
 
+static void hid_bus_shutdown(struct device *dev)
+{
+	struct hid_driver *hdrv;
+
+	if (!dev->driver)
+		return;
+
+	hdrv = to_hid_driver(dev->driver);
+	if (hdrv->shutdown)
+		hdrv->shutdown(to_hid_device(dev));
+}
+
 /**
  * hid_compare_device_paths - check if both devices share the same path
  * @hdev_a: hid device
@@ -3012,6 +3024,7 @@ const struct bus_type hid_bus_type = {
 	.match		= hid_bus_match,
 	.probe		= hid_device_probe,
 	.remove		= hid_device_remove,
+	.shutdown	= hid_bus_shutdown,
 	.uevent		= hid_uevent,
 };
 EXPORT_SYMBOL(hid_bus_type);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c9..ddf57779bb3ef 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -861,6 +861,7 @@ struct hid_usage_id {
  * @suspend: invoked on suspend (NULL means nop)
  * @resume: invoked on resume if device was not reset (NULL means nop)
  * @reset_resume: invoked on resume if device was reset (NULL means nop)
+ * @shutdown: invoked on system shutdown (NULL means nop)
  * @on_hid_hw_open: invoked when hid core opens first instance (NULL means nop)
  * @on_hid_hw_close: invoked when hid core closes last instance (NULL means nop)
  *
@@ -924,6 +925,7 @@ struct hid_driver {
 	int (*suspend)(struct hid_device *hdev, pm_message_t message);
 	int (*resume)(struct hid_device *hdev);
 	int (*reset_resume)(struct hid_device *hdev);
+	void (*shutdown)(struct hid_device *hdev);
 	void (*on_hid_hw_open)(struct hid_device *hdev);
 	void (*on_hid_hw_close)(struct hid_device *hdev);
 
-- 
2.43.0

