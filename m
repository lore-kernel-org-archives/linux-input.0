Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB1405845
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655897; cv=fail; b=sqV+29bRjoJqzOE4W2r+vbG/f/iBP7PCZd/gvCw9pGKKhhra7lQCS1ZQRZa/paSfwABJfsnPCspueOgLIQlDQ15agbZATVaImdjU6b0qEGs5KObhFZWbDPr8hvILD+6+wi4jLXIQ1+3FnOXmot/RyiRqXmSQzP0nJ5WjJXZRN0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655897; c=relaxed/simple;
	bh=P0XZ7ty6p67dPWbuR34Dm0o+fUGi/Q8ELLeiilQMFaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S8yGjor84WfJvXmpwPNt7AvmZ4s8+IfWxzGbnQMzPTIfQmcIiHAfE1zKfd6mcOkNF/iYIoJiFpondfEyjQOX0q3s/qpx3de6PtwDlRrGmuNi8c2WGhIKx5iYSoXulH0eHtbKgarQcjsOoRV7WZO0ZTkVlOcAalh7SiNTqFRLhkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b7dmjlIM; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b7dmjlIM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5kTgkHQo0EPwPtpktw2AL/TO6swzeOHqRB5zBCfH/depumdfsNolUkLdpqHEdM2YYkkzBt4JqHVnftOzHIpouz9mSKaOvWvZh3wnObQumm53JpESTi14R4ANUWc+GhPeZ3R1pewRGvBnUDRz4GXVtWlOUbrS5tq434hCIY6XW6wH76SOjmE1Qx+Qgmrf6MO2hVq0C/CCCMWrPzA1lzWM+KUO/n4zb6iyOh7+54XSx4B9CobGDwO5RB8hrJvbgWZL5n+LORNCRVfyn8/FgGyFmnYLd41BT1tE9J2cr4V7yhJTctP0rCbddWUylvC+pCQU8fwEi6FCXRD9EMe7Vrlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAcRwXrJPjf4wHrzNwBZ6JOY/vIpZqrbm+Ozd2JIpyo=;
 b=cXUxww9J7sGc8g8kIqBSPH19BA38ioBg4aMdqBRGvoK4i5/4oqQ4AtvfGPk8Zq8yOgI7FKOfCI0lSICuZz31jDBanJf3f8jXpVlglzWXpzcq5+B7Sy4YWID6IqpiQKzAZUpNhBfBP7dOa9/TWM+17+EQ4l3yz94U30NL2VI3+kBhoLCK+JrrQZv5A9LWtLL1gzQVUpallMRxgptWZ1T9ZOU0D7ngll3N/U82GxwCG7DZN3pRtleO3cfEwzRhzay0zV5MILVkI1pQToUeG3leQTqzoVCRHp++ggjvJ6Bi+gZDZwxWuAyw3f9p0u3VH6gLbXJeEK+HoRTVqI5w1WYtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAcRwXrJPjf4wHrzNwBZ6JOY/vIpZqrbm+Ozd2JIpyo=;
 b=b7dmjlIMAsog8SnEtbDwnD+cVMxzmCOTMn4EStpcwu6kZIOfqWYxSZ/0AxxRnchI+j3nv4qb//cDdM/TArFCJF2c1Re60HmqD7z1iV9rUScUkSBD+E/mYZDXLmDTPB1XNa4myq2IMPG2aiYZfO56ctp/v15rzgOFNjnW9mHDfHw=
Received: from DS7PR03CA0138.namprd03.prod.outlook.com (2603:10b6:5:3b4::23)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 17:44:47 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::16) by DS7PR03CA0138.outlook.office365.com
 (2603:10b6:5:3b4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 17:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 17:44:46 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 12:44:44 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH 0/3] Add SW_TABLET_MODE support for AMD SFH convertibles
Date: Tue, 21 Jul 2026 23:14:19 +0530
Message-ID: <20260721174422.3109166-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 665e4242-0cf2-42a2-221d-08dee74fc16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	UQDO0V+fyVPQIXA6mXAW7BsbdfVXUXQ8EMbXVzQFnoRsJCao+u2m0gP5qBNM4fTnZH75sJ08cOV4/g6l4Eqd0b1As5tYZ9AVEotsoi63DBDqN4q+fhsbQtbGjFnvIZczgIn4mLCBnGq5Mc0Cn1Ay3FZkhaxblc/E6AlDlvsp+Y8p72kcCmaDBfka+DJh37xJ7GuJ4wKQhEkVgmRvemE3fuRQQ7n3wwAp+senxMIG8kYlWD0SNtZ+AkWf0L1FhaWSNxmmD2O7+ULNgo1fY2lJAvarPwzMur0QTpGBpTAqkogXnB/pJpA++SIssJyAvbiuH13dY5atawr1hYEpwJcbRp5aHB5GdJ1TcWWHiLP82TznI0LusAAtEN5bYz4dJymOLxgzdcPEiaHaOrT2vuP4XzRjaGJzIccnQmY9c1RqDG44aKR5YabvCb3qp+o5t1Fd5WGoJsTDisFhEa/iZjOn4S/i/NA9adSe/eiJZMoTPbGzjNFlJJJnozT69HTPMm8Zp3q+aU2v8rt8jc2rFJJ4iokvO4HaqjlYiE7rnvlhGY2N4MozvsG02zeZQ9zty8BXMFm3BkRaJaVIAc8uGPRpC28EqNlYLHEHQTOvXyup9+mvmK8uD9CmRkpO/MbjhJ9XpIz3pzMk64f7K//m6xdaP1QZzpj2A+aBmvVel6bk5H2uYeGhCpTVEhWaCS0b3QWfvw9MHwieAqr6AXY+BNlrhw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4o4S48aNl99bxAb2Yw0eteEJu4Htks0msvziPB4Z8mefAqxw31KGEn3uBgyA70CwV0K0SuE+qDseKzInEJuIizIdlJYWsgjeW7jUdY0FOKMV/BVNkb3Kcxs3xQ3TAgnSXNpZVnPPtboLZjmtnT2E4eJcgSAuZAXwKTFroesqV0PvZu3WJte7flSbPhqQgRg0b5ddP3kKVN8oHYuJBHT7QS9KNJIvw1IMOAnrybqXIbA37y367NoFUYkLv9CkoFLTzewDTo4Lm+EoUZVS5b4ZdJ/mg18bHEB4Jeajbldks63AwLCZJykM/CDwT4NltT8qAgc44BWstzgzM4/DbKFFmwjZ4Exieeq1C5etzGsUWUkcKE67WN5nKnhE++aI7sUozYwTJUowPRUW1mafYb7BFAtL0jStLm1CQH71ezKHf9X2XPzPoQ32ANLGG52RVzAr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:44:46.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665e4242-0cf2-42a2-221d-08dee74fc16e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926

Add SW_TABLET_MODE support for AMD convertibles whose operating mode
(laptop or tablet) is reported by the Sensor Fusion Hub.

The first patch adds a way to read the operating mode. The second
registers an auxiliary device when the sensor is present, and the third
is a small input driver that binds to it and reports the posture to
userspace. Keeping the input handling in its own driver avoids pulling
input/evdev into the sensor transport driver.

Basavaraj Natikar (3):
  HID: amd_sfh: Add accessor to read the operating-mode sensor
  HID: amd_sfh: Register tablet-mode auxiliary device
  Input: misc: Add AMD SFH tablet-mode switch driver

 MAINTAINERS                                   |  1 +
 drivers/hid/amd-sfh-hid/Kconfig               |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c      | 16 ++++
 drivers/hid/amd-sfh-hid/amd_sfh_common.h      |  7 ++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 42 ++++++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 33 ++++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  1 -
 drivers/input/misc/Kconfig                    | 15 ++++
 drivers/input/misc/Makefile                   |  1 +
 drivers/input/misc/amd_sfh_tabletmode.c       | 81 +++++++++++++++++++
 include/linux/amd-pmf-io.h                    | 14 ++++
 11 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/misc/amd_sfh_tabletmode.c

-- 
2.34.1

