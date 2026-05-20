Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796A3F23D5;
	Wed, 20 May 2026 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288933; cv=fail; b=jL2dvx6wtDWcpsCjj70nISxylizlrzDLyheWGuR/cZqOwVBs/GdfjoH14Rq6R3q9zyTCZFFHOt8THx4ONsfdQpmu0xsuMe1IkoHpuEH0StONzQQrpgnqt8n/1LhHr6gTTU2y1He3GBYEbjYSz9wuj1m6xzuFBIWBtakxZNnNZ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288933; c=relaxed/simple;
	bh=13CTa3qCVpN0wCmX0tNZzvjjeW6AkHKTUipa53g5dvc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bkBx6AfucXscsdWP9Y8oYk/PbdSIzGGrPQ3E06Worfu6fwSLDZGwAZiBcUv5L0H2s1hsHID2GTOI6luXXstQeE88sU1iBcG6gWJLcrR4J9CqsJTO4xcYyqWOy/8RhS+RyXOnoJ9Ln3CSuhH9wd70eDMA1m5S0KitgkO1B/yvATY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dtN1X1Ym; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dtN1X1Ym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjTLT9lknQVWMr/8aocLfQ6RG/N/hmU08PMeyxFvLismBrticSpXjdKIZfjo6Drf+BvAToSARsGdwxb2HyfL2E9rDZ2HJG0Xm37B3O7aCcaHHTq71nJPI2x2FGHXrrYPOGcdnbexqFl8k1MWIGS55LwXQYWC2b8zpB2VCRSrLirV+Cb/WhiE3NtLN0zCfMjrLkAn9hu8wvu1HBmXf3pD6lyJW6sRq2AM9xQNVOrLXYdOY+73gFYx0Axh0kT09Tgbx+PcAlcwvP4NVvN+UOBwPHgQ5LgD742236qhitdCyM6Iwnj5BldZq5wYDo1EYUoEJnzCoGV6bdyiXgi6YKacHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13CTa3qCVpN0wCmX0tNZzvjjeW6AkHKTUipa53g5dvc=;
 b=MKPrR0GBuuS4JNqxqLZ5lB+qWyfFH1+OU+mJwLM/YHggLbFKd8sZ286gKJBTrJ9MASmzWI9NyDmhrOb4fnM7+HCIw5T65crmcMfeYtir4z96Zo6GutbsOaZG9CIuj2wta37KnCnvN5xWPDkYLDcXtDvxQpW6649C6IOhqkzT4GdrD4kZjN8sgNk5h8XxvPDp2HHhQBH3ngxasnXQ3mVs2c+SRrtFLpTv4pcKsxWrYBZMh8jQUAqOvX6rQalUaMPUkEZqQc5X7opPP+lVxqB0GCDnj5u8d/1Hoh8/1QFts/GcFEqXeRZGgyjKl25em+w/XemGrPeA0LvGGRf84SZ9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13CTa3qCVpN0wCmX0tNZzvjjeW6AkHKTUipa53g5dvc=;
 b=dtN1X1Ym5sZUznfUH9BrcHUCZFrCKPnMOSRZ6Q1CDpzhgjPAZ4Ak9jfgSxIPgd0+AH9y2u3CTuplI/ZNH+zTexUg4KU2zMj9Ymcb9WlVZ3+TcKG7IyS8oSaNjlxq75oHwk1QHiizIZPBE3rc+GS68rttEp+T6OM+h8wesZyFDVs=
Received: from DU2PR04CA0040.eurprd04.prod.outlook.com (2603:10a6:10:234::15)
 by PR3PR02MB6297.eurprd02.prod.outlook.com (2603:10a6:102:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 14:55:27 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::f1) by DU2PR04CA0040.outlook.office365.com
 (2603:10a6:10:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Wed,
 20 May 2026 14:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 14:55:27 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 20 May
 2026 16:55:26 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <kernel@axis.com>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] input: zforce_ts: Remove error print for
 devm_add_action_or_reset()
In-Reply-To: <pndfrbqj2u6.a.out@axis.com> (Waqar Hameed's message of "Fri, 10
	Oct 2025 15:36:33 +0200")
References: <pndbjoum7td.a.out@axis.com> <pndfrbqj2u6.a.out@axis.com>
User-Agent: a.out
Date: Wed, 20 May 2026 16:55:26 +0200
Message-ID: <pndo6ianna9.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|PR3PR02MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 1354c176-2549-4124-8ad8-08deb67fd456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003|11063799006|13003099007|4143699003;
X-Microsoft-Antispam-Message-Info:
	gCG1i2uJsK9Gih8h5XK+DO6c6oZjjno6ydM90p9k4rUTrIWeUPVoUW/GB8T44AoQdUsC82bK8SzM0Hp+KV7vqxzQ7HrLq/axfG7IDgEi8AXcy4SIeIyAeNQf7Gnas40g9Kh5B/L35AyXuYC1Sgy7BEu8pKA0Omn4ehW24T9NuuGjl6NETVfnasLWE2zoWzHVaP9fKSJeMc+kmFBrELq1OIkwnd1S6sYEE54h78W6Zd/r+LW+Yl8ba7Iy5+d5dLspfb7bMZdv6rCQa1ymOtv9hLcwZw2SkgNf+W9YyEPNOsKGQGY1MXkxh0JDFjS30CZ/Nl2ip1Ey3B3Yx60ipsncuq9OPNH49qVIe3Qsw2VqpxwakDuENdLylPgG69F8nRBE0I1yxyhFhTOGSKWuO3dH0p/dIbVHtEZ0PwmXnWSUkgC6oHe9IOUjo/Dloe4WwlDT4vTIH+1UNXKJf1Wpk2J+eW3HgG7akktCeYWwUDZ1Hq8LyuJBEnVmScYuDpixR3qmUsbuYv/lDJEknWACNnY8BeGTA+6iG9h05H0fT1FbBSGDtQl3guHvxvGBu5v3zjqhZhhVQtuwd50PeOZJYa8APXRqiBlq7nZpyemnmCdQPgGv/nSaSb/UE1FQPX7jlJz/ERfA1KLffLomRkCwhD7cNQT0MdSP44oczsomk9ebpAGoB4F0o0hjwpUbof0rMkaY
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003)(11063799006)(13003099007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4QOIV4k+7yEnbSTXuetGn9+CJ/oputWnhVIsm18kWflaX8nzIF+qUt9706KPBEQPsYJ2m5SWUPm3i98bN5xBJk5h2yf9c0cHcrKDdz+gGeVjb+XexOcQptzCOOZZ2zNaC8CH6CBkLyWcdhE245CJVobsHzFjpLTHNUdOnw087i6N4xGPQ4kPBRejEgX5KjhzWPM4vm1Z61NRjD379mINHoLvMSUU0KTRbFNAZ0sIitDr0quEJhBlClMMTAXRoUC/BLd+it3atZEyVBo8tSJ8MP1h7YCcEpaLcouVPwiAdohnL0xGgu5Tg+dtqanc06ZuiwjmjaxviOX97B5acAlr8rCjDD8c00Dtk5yOaAAcyGvJs74r7YDm3KgfjMwXw2SEXZyW0lt8pEoAC/b4FTbf3Lu8RFPKhv7yahmDwnLGev7SJWGUt6xF4iaEBM797tWT
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:55:27.2225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1354c176-2549-4124-8ad8-08deb67fd456
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6297

On Fri, Oct 10, 2025 at 15:36 +0200 Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Tue, Aug 05, 2025 at 11:33 +0200 Waqar Hameed <waqar.hameed@axis.com> wrote:

[...]

> Friendly ping incoming!

Friendly ping 2 incoming!

This will be the last ping for the original patch [1]. I'll interpret
the silence as a NACK (though it would preferable to get an explicit
one...). All other patches in the previous patch series has been merged
[2].

[1] https://lore.kernel.org/lkml/pndbjoum7td.a.out@axis.com/
[2] https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/
