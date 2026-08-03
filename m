Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11A426ED3
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779594; cv=fail; b=reyR+HeCWrZujteHAeBqOZdnnqgCxKlF0O+BUSSarSOrNtzHSHW3D7bYr2WfNGq1m4w52Xb9eOV8h2q1/b8q1S0x27cqSaRHVCdWbW73nIaEhIL6VNHXTKzBngYS0y20VLPF/VzlSMUUVfGuOYLMut09MuBAAok1Pob9CW9iTvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779594; c=relaxed/simple;
	bh=FM1MUMXiood3X2WI83lYFwBiZfQTjWxT+Y4C7/Ckat8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gk72hG+XXaBrp3fXqv/lX30vTq8Dj2X82qh5e4q9weqo9PL2hz0F9tGxjsETeFPqDhZdrJh6gHR1nnGwVEn8XGOS5iS0KVlwinLJfbpN1mL26wd6wSnFB7rITmwmLVRE7Yuu1bBJM/PVZ9UkR6X7z/YUmc1uUPptYpfdra/jGd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ESiERvdP; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ESiERvdP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7/3AQY29s0GbxRXW6W9U0GHqOEw0luRrCsLP51BmO/v4S7uecH58qT3gmsKKIFPzi2e323ESiIRzKpCSSYnWAhteoaYLrAskrSZi3LMAa+fWLYvY2xx+38TImW19IjOjraOj9Se+F0T2gAUuUbmHv1inZ4el3ss2EFXbprsXH+xoe2xm1kCB7DStSghzvSy7GPxYABAxLtEZYx1tAM/ajdymM+yGZtClKzz4Qj+TLGDAoj70sTSwh8bN2sGjCt5vt9S1kh9wibMAa7n1awemk2prSFnle7qxLuq3X1hXBs4/cwPq3jxHywqlKnRoTYjoRXm53cTOUuCEtOEzhe8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ1zrcwuMv/t9lR1nQ5ZC5vZA/SH9XBrHBwuKNz2ock=;
 b=kQfLxVcFKjwmon3k5Y8BegwrD4uiTvnEawlAmjL7A6VqJk+pZ1H/+t48rVb0cirt4MAq2R2ncmgLM9gJ01r8qMy/sKZH++wrAYNSLHyFtWxXDJmrrzaFbdB5dwv0IySDjHiOfdj0h+xpzxhRZUWopN5ByDHawwaeyeMUkBUL73BX61bpZ8qmTRviLPag3xwjLdSbTk7mMZEK4D1jv0m6Dsk6rJs6SI6+OifE9+WkfrUtgEku5kDqkx560QalnNL+SheaURk7WUh/rUZNTgOOeRcvyyTDxg8zOLCFIisPEPLMM8eGFufCe2iUklLJYETPbX5cvZp94KFr7A/vRpzz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ1zrcwuMv/t9lR1nQ5ZC5vZA/SH9XBrHBwuKNz2ock=;
 b=ESiERvdPm4FPwEUr1qeByc38un0qY9VbqgUhs7GTFFUsTDO+9itISGA1L5N59Y+qV2noEMs/BELs1K6bdvEOM9t3RsgZ4IJ4Jy1lZSANxeoM4QMokU9n0XxNGT6oKayyEvLt479nW7ZwboaBUL93+S8BnZ32egHp6XdL0Qb8i/U=
Received: from DM6PR05CA0061.namprd05.prod.outlook.com (2603:10b6:5:335::30)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 17:53:06 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::78) by DM6PR05CA0061.outlook.office365.com
 (2603:10b6:5:335::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.14 via Frontend Transport; Mon, 3
 Aug 2026 17:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 17:53:05 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 12:53:03 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 2/5] HID: amd_sfh: Serialize access to the shared emp2 pointer
Date: Mon, 3 Aug 2026 23:22:27 +0530
Message-ID: <20260803175230.3839752-3-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
References: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 92eda5ab-aa63-4f77-19ae-08def1881225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AeozATW3dpnlt2EeYQDOWJ1l+jhU6solfB6JH2ySTB1Z52XINkI51IQf4O/Pp5awr6Svb7DjwMQKtWMVk0rkU7MoRg6fWdBRw9jweE7sLGZkLUmok6t2S2psArEa8OknQ3YYZYCkvKiHsE0/BLr08Bs+wBwvNrjVckr9pRO3OJGQFxRXYX6kk/9SBmYUcI63r6skeBqzHBitPURyoz87nCEkd4Vv+dZeEHrctxYZMwfo7x6zGz9R0/FHcpwABUlPeBPkgEjAiKbMyx14Y4TkSdoXxt7KJOvCn5v2i5lRvu32Dk37oforEWOP3HR+6bnfucwYRpN0hFqKmOflcgt4Ux/PP3ARqh0BjD74EXAL2dFJDUuFK0Tkamthj7qXuqKli74K0ExxzT2YfQXTZ08/4/nXokVUCjymV+76DxPB1xy84AWZ3DL6e6WE06WpqdoJViiHW2c7nsBzMwyp/qYkjioCE/ZYv7SpsH/hbi6iXlTwlpvLWV1gJBHC7hksvMB1Yy4eAwkpouam0ToKMd1IvxtGoCKsHM7GKDWUkupsKOilJSbAEF+YjSWa5tTBMEO8c2UVRHdB8gHgsUUh3ZevDj0WzyMgpq4TJBO6Ijm5dwZngGomKP4nknrxtRyOz4VaLECtE29ef/2s3/XkZGPMcdyuQk5fYy87Kl2mL+zgn1kne/otNxShYN2NYQQKjoyo/oc+EeWizGkeueEzrgL+Qg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bctB98XeeyvCdzOcxOA174tpMjcdRB3iVHZKsyQUgGkwXUeXMv6RYQYj5MwdfOnh3oJ+kOxBDPW67/4ULF+WbZJUpIPH9qNNFaR6d3Keq9O0axRnH4HvHjNFzGiNz41WrD8b2+U7lOzXZc9YqBtqO4/yqcda9+fJi309N/ajYMQuunyUXoMHYxC2ReP56/971jrIYb1Z/zbDClLK1JyMRc7YBhh9KjgQSHliHDpSByd99xDxwaoufHZhlxqrii1BCRI5l6oeSQimsPfghEpc/2cZoq8GbMAWzxlSIptB5FfuN78RTyDmBqCp79gatz8xD45ptQ/batdAq2hRhd1PWDAVqCqHmlqmKYnl9EJW/Usq2Rw1pGKnCzg1Z88tgF9iuQ2o/Do6rZXsYCVBLfY5ff+ekg3+/6S48co18V6WNzdchvw1CxlFbN+ceXdNMx0s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:53:05.4791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eda5ab-aa63-4f77-19ae-08def1881225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

The SFH accessors reach the device through a file-global emp2 pointer
that is published at probe and cleared on remove. amd_get_sfh_info() is
exported and called from other modules on unrelated threads, so a reader
can observe a non-NULL emp2 and then race a concurrent unbind that clears
it and frees the device.

Serialize the emp2 publish/clear and all readers under a mutex, so a
reader either sees a live device for the whole access or sees NULL.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index 837d59e7a661..dd2720bae65c 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -8,12 +8,14 @@
  * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
  */
 #include <linux/amd-pmf-io.h>
+#include <linux/cleanup.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 
 #include "amd_sfh_interface.h"
 
 static struct amd_mp2_dev *emp2;
+static DEFINE_MUTEX(emp2_lock);
 
 static int amd_sfh_wait_response(struct amd_mp2_dev *mp2, u8 sid, u32 cmd_id)
 {
@@ -78,12 +80,14 @@ static struct amd_mp2_ops amd_sfh_ops = {
 
 void sfh_deinit_emp2(void)
 {
+	guard(mutex)(&emp2_lock);
 	emp2 = NULL;
 }
 
 void sfh_interface_init(struct amd_mp2_dev *mp2)
 {
 	mp2->mp2_ops = &amd_sfh_ops;
+	guard(mutex)(&emp2_lock);
 	emp2 = mp2;
 }
 
@@ -160,6 +164,8 @@ static int amd_sfh_als_info(u32 *ambient_light)
 
 int amd_get_sfh_info(struct amd_sfh_info *sfh_info, enum sfh_message_type op)
 {
+	guard(mutex)(&emp2_lock);
+
 	if (sfh_info) {
 		switch (op) {
 		case MT_HPD:
-- 
2.34.1

