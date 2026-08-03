Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941823043DB
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769129; cv=fail; b=PlH4uIc3Jf3Z1/bpaPNPXRLFdzuXYRZtilU/OPYQbZD4yru5yaUqosM6pWke0lxEuM+gwqAWyLZsiNKszUKIE0rPyjJ7YR1E9NJcDkplO+4RxgmHSOCwtUyBoMPFqPt5pLbIiBFinSC66EAI+t9GSGm4FuNr676RNAC+juLXm1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769129; c=relaxed/simple;
	bh=FM1MUMXiood3X2WI83lYFwBiZfQTjWxT+Y4C7/Ckat8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AX+cb8nMgC3mjlxmP05p3YiS/K9z1rlM6fo0NjpJU8AHdXdexx2fg7s5FHF/PNqQNp9XmzRopOp7x2KLQy8/JwAggpvb2OwKtF3wG9FOea6kcUlPalfV7RxhDyKtMkg779jlQ961iioEmuCf2vgMQq+dMHcOjiYyDu5mHBNcE+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I6r/Aib4; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I6r/Aib4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LW0lCWjlg67coxH83CVaaoxNRQqhGpK2hjHY6z4l+3jvuP9cXwL/KQiAm7Hv+KjaG6a92s/mwuVnq12sQ/qxvaEwM6DLvWwW9H93QXMTIMrtln3drBhZ6ZztFi6HrG3boGasjlKIgQsa9Hl9SJ3otxCgnm4q3/1vx35T5l7MNB7PjIgn5wfZ1f7IgfwP4W3VXMusJcsTz5W9c7JVOWSJSN6I00T1C/gfMbQnQAVu9JKiYn/SNLs8ZCrSzyhTgzULSvDP6hVW5j/mNWCDfcr9T4jrwRC1PL+H8lHZlWiyCte1kWaviQnwM5nf+UBZPCiUmVSJLKOcfWLKVWe6a0+QCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ1zrcwuMv/t9lR1nQ5ZC5vZA/SH9XBrHBwuKNz2ock=;
 b=n3fw5ahm71JaZYkU3vnTO7DfPkqOJhR+MvDLy7h/IjFdh0xkBlCgc4Vj5OtFxkL1DsuWR1KH/ECr9uolICmrID37coTmJ2GeVxfyXpeZDSf4H512QuDdCuyHAo5RTSWZXVMAB8dVSkR1OK2NTZhd/hXuDQpyylu2IvGMYkfQs9+y3U2dtPWvvHDw8udQuhDuzzfmAh2hoNI6Y0y25Kqvq7eEe8ktQujnquzN0qGtpnxU25xCB7VhCvG8S8s6XM9Dhv9RuzXQHubjR7si5603dnUXHsoKfBDl00TPnXrMt86xpQdEs88wF5m+3ZVd0W9mXUQMyBoJ3trPpOMZhvk9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ1zrcwuMv/t9lR1nQ5ZC5vZA/SH9XBrHBwuKNz2ock=;
 b=I6r/Aib4efpNSV0PqO+u/1dAVH8fvbqB08qDtMTAwkR2k195NV1SgtxtWD/xedICe1xKcI8bCAWzBMrxJNxdiuab80jO0dlHLDg0Mi/pVT/n1JyHi2C2Bq1/5Ml/RtJRlyvIUs8BPqQ/C/wVC6WTcMZrB0QNQA8E2QkOVexKJFE=
Received: from CH5P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::9)
 by SA5PPF9176ED2F1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:58:39 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::9b) by CH5P221CA0015.outlook.office365.com
 (2603:10b6:610:1f2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 14:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:58:38 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:58:35 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 2/5] HID: amd_sfh: Serialize access to the shared emp2 pointer
Date: Mon, 3 Aug 2026 20:27:58 +0530
Message-ID: <20260803145801.3801862-3-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
References: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SA5PPF9176ED2F1:EE_
X-MS-Office365-Filtering-Correlation-Id: d4406fa4-1f89-4305-a242-08def16fb360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dOglpdPheElYNzgXiD1MbvlqmvTegb5OEngWE9RNMaHKlEkZHTBAQL+kIxpSNIdo/zxQ5eVV5hDqKDgZ0tAzW2qR/nT4rQv4qazNgMEQRWH0Ojow4cpUNPdAR0zB9HWSz35W2YE46gacI0SINLjlppmBnYbh6y51jabD4HOyAj9Opccg5EtwSw3Wtq3pqG4Q6mVoUA0WopxrJv3Q1f8HDlmHMhDKjZj3OP2P0Gg4uglcAQXCEb8MSIE/T4eRANlHTD5g1JSqy4VrTS/EkjOLmcBkTGbNVdYat1o1K4vxKOZe7p30vRZIvsQ9OEe6eEnwe2XBLwP8fpPAWMfU3OiCascwVWT8KRl95UxF4FoWrbmOmPUNjTmMvLdF+hwtqIMbER9j/0TMKpJGSRbF8Igi7renxDIFsrc0vdVAIeAXMojPdrstleenFrupRFZeLEtsyMy1atB6XrjIRyuqv0IIZ8NqaI4vNmXLB3jm4CQJ+SxmytQk6F8cnJVbFFxSCoE2fqxJr9DBg/88Anug2lnGV/XK47koL88TxoEuE+FpFbadQ5v0gxjXijIQOtfHOPcQkC/Sqkcae9epsWH7Nh9zY4Lc+EOPLV20ArPy4BmFZaNMg2LlB6+kAeGAvhsPZt5XS46ngJX8OksEEHxRdAXV7iIjJEK4+PT+u47z1M5dZ7tAUyy06P0vIVqSfXKJdGu7RtRWxWUnDR28vYXPHEZi7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zEM5mb1FUXzZpPoEsJoOnnP9kLWFtkgygvfMMoAZhGjvlHpHxyY4DpAIvL16fgai57FVxRBo6ToORvlS3oVmMGZCD6Oqr/X/HgfwLTDhZ0soOSpLYAQ+boYUvkZqLofx7+AVw0TwyC4Q67zvKh/fY6BfOjEptRTGS0uXXZe/PRcmOnp6fMwDZhWAlpVThPcqrNxGDvMI6I/Byens5WhIjl7QBln1nh4M0BMgPp5IhUPTetYDlRoPuOdmNZ1ydq4ndcB++Fi5a4YTLypM6wgE6XeuZd3bJf/BvOIG7dL7XXc5cTltONWvuOL5pUWxeTikXPEnB2Xom1dk77H3qEGCXkO5X3W5fuVqC/zJOMQz5BiPDeOjQX1s/lNVRU+kDUAhSWG80vUMCA3bYMbNq+T0HuihvtusuKGTZOmqRgX79amxxK1c0quD2oU+BvTf2TG9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:58:38.5752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4406fa4-1f89-4305-a242-08def16fb360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1

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

