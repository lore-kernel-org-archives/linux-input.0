Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C3377EAC;
	Mon,  5 Oct 2026 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233240; cv=fail; b=dP30+cg/hbxGeNpepCVkj7Z0kzZ0MeSoX3EMpzVcWxWo+e576m5A1dRlU36tv6T09pHegOZon+/5Max3aEsjXTS2nuV1wOowLOfM5hi67JkcNdPX+A/fmDIyEeKDCn59NsCMcJHuOZ0Qu0mhzKmYncoHKalhWRQuTttPZQxm8GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233240; c=relaxed/simple;
	bh=78+h8KeYCgiQg9Fjo6wdmq/WlOcVOXzO1ysS9J82u1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=S+zOsWMmQ/qHK2BAHMowVs3sFoznMqC79U941yMu8fvgjJ+SN5dfQbQAAwsHYXt/OpiOu6cho/TAUbd15QXbQJ5eUDn4VVlF5+0wdJrUXUtiZYQNenwn4BlSu7zfKIv1zNG/h9lqiDRz8NCm8LvDWAkYHgEr+NHOlyuml33DC90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=po543vvD; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=nFdwgYys; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="po543vvD";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="nFdwgYys"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 695HKljk323185;
	Mon, 5 Oct 2026 15:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNM
	CA=; b=po543vvDIRH1+pS3lI33pp1e9J0MmElF/obOplRsdNDavjorCWi7bTphx
	DSDNmqcci1NTMeML4K9wt7XVwqXvCQaHo9j77+HsTXnpgmV3KWrANTbo4VjfuWlW
	aE2KlAop4fsBoSVfVaII3L7nJd2aytdCebxnpbzffXdnAIw/1FSNS9Z7kBZa+w4X
	ayeB3vUDODmZ3dpCrLpjHBrFfR/yFvT3NNXRSY6fq5rzjXZcBBWyRewfTiQ69SiO
	LgFYAb24L3ofLnwGcWNZCFuRv+lgycggBQEyFdYJ4DQkjbypsL2nnOyBOiylfppa
	Bjf4YIeMW530vQWwZkUwIIR3EIREA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	by m0380145.ppops.net (PPS) with ESMTPS id 4h4d7dthhd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9NHVJ/z7Sa3iM0Okc1yLCH/Zl3omVMIUJiPR5BtrI8MYXvaZzHyrc5qERFX0rzaQWkgqntvuPN4UYpHlzZVdBx8lA667//HgDXkUewXiB8EP86Pv0BMfQHQMZOplqLaTeOJWKPLVKgtAB/02SElahTZiaAFj0wBHhIk7fzwLVxZoJcVihT7fwo5Sk/CCCm0DPHKBHOXReXVhjp7zRV7feZ/AJonv7df0sShyDGGJSTR7OEHEWc0MU3sAdMHPVDn+kM2C2qZh7m7fYGM4ET2SQ6AZG9Wn0b9/Ohw2jxUZ8tdLVrLnBL2Kbnwt++4TycMcwNl9M13i9JeSPNgnuOwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNMCA=;
 b=KD82bXpAm26YMoJaK0JkBzCcvR1xcBYyC2BNQumNVeQoGE7szjEuiHImrgqiTjQZKiXs71T3TLJLvqpsqY2su54WvKQetJ7+N3mwLxbY/pyVN6XTQZdDSnSXEFZ+1eYQWFJfkDmVDgtoTBGvKwRn4bBHQbvJQKDhqiNyR3ecWm3QlhqITR3gs2CbkGLwmB69/nCmiyCmC85lbrRRGc6RPQYdzTJUYqp+moflPTB3Svav7056p76Y6v8H/bT/B5aOYnAgOiSCXLr/tc4D/eURdQnUvLeBzKVD0RUSDQJzb//VzJP8NKrNTUy2Wr8ULvhzaPuOdVeNGOuIuIDR7TDqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNMCA=;
 b=nFdwgYysA6/GO5rz6/PGldcafLC3wPFRwPGH6EO3TY5xMECMi2HVuhc2l+E1GJ8VyNIe5wQPmznbc2RgIx1FncAJFCUmVdSkdmjSW9f6ir+bs5Som+n0qcbgHweSIw4eTEBtH7V+s6xmkhow05UlM6gE255r2C46ADtdIdI9RZs=
Received: from BN0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:141::28)
 by DM6PR10MB4169.namprd10.prod.outlook.com (2603:10b6:5:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 20:47:10 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::1) by BN0PR07CA0025.outlook.office365.com
 (2603:10b6:408:141::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 20:47:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Mon, 5 Oct 2026 20:47:08 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 15:47:04 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 15:47:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 5 Oct 2026 15:47:04 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 695Kl494892360;
	Mon, 5 Oct 2026 15:47:04 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Mon, 5 Oct 2026 15:47:04 -0500
Subject: [PATCH v4 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261005-upstream-gpio-wakeup-v4-1-96f092de4690@ti.com>
References: <20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com>
In-Reply-To: <20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <msp@baylibre.com>, <s-kochidanadu@ti.com>, <a-kaur@ti.com>,
        <s-tripathi1@ti.com>, <vishalm@ti.com>, <k-willis@ti.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791233224; l=2049;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=78+h8KeYCgiQg9Fjo6wdmq/WlOcVOXzO1ysS9J82u1s=;
 b=7VWBPy+i/sWXItpJjuejeGKTJGQfMkOpI+MgtkfyQXaZXfJ6OfL1YWROhhPjOoQdq9glcpw5l
 OSRAB0+nLCuBskf2n00egDE8g0PFcrx/dVw84uXeA79JiVh2qZWd9MR
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DM6PR10MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: f126e31d-6032-4938-d493-08df2321d276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|260925021311599003|56012099006|260925022911599003|260925021911599003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+VNqZcGi/19To2fT/Nsj7BTDUm8igGfSS4qLrAT1AXGvC+vvYOVmb+IT9L96A9tkgyo08r+W7oQaGCPrjvkcU/+M4Istd0cEeLTb8ArSbXE43CcxZovfahs2MWNUzRx0ybuOOUrYgXq/wq/FsU/i9FzZwnoWMmTHX11iqDCSfpkYnFShgGXzra5jrDQWCNCN8gWMEdKz7kUc4l/xmJUTNBQ7mEjEP3DsQZIlRqg9VdRDctiITxBeVREQklHfQu0K8E6bxggKXO7Igb6qrZtnDywknadLhUL4zyx6INq6TRAh9l0XqPaUI/fdZ+a+lZfM0Y+2N7/F3vP0ZeNR+H1WrH3L496NEWxZsmOvsEjvzNG3pGH4pX5ZtOG4i7u2NEibmaaPi50ntsPJGPyt6xe9aOV+ZMrH2HhdH9Q014I8X9XxNYwDSLcFGXMJM8tIQir9nNHyMLGDbex5fx4MT0wMdPffX1bvahK6I52EL/cA+7hRs9aB3PS4/aAlEXlWRwMBIjzjEIqOFjVcPpWUBuIIVZmFN1gEawBN78uhXHkZ//+0VYPTuKl1/EJ+NslHLWaoPw688IEipz4+akHP8B2gz8qRP9EWkXtAQtopcA8IpCKldzxIzg5dAxLetTgbTKbGDMaSVXcZ6SKadUM/t3/7XOmv7DgEJTz4KAm+jmYSiIz8w4r/T5jWoVTRS/UfrozJGs5MLw8F2XK3txzbywAqhg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(260925021311599003)(56012099006)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lmc2pgnNOFW5Aoj6hK028fcoLEvciED8RHXdaxxvVcQtYGaN20C6KRqaOs8Wa/aiC1HjB/2gwYbaqk/cSmQgjSCxumgjZh01NqAXVbA0wEnTJtASdxTEHN7SdNiptp5qN5pq0m3ehgmRmd84QjaabNI687b08v/n5a3cE61urUTddZ0ARVIP9lB8+RzhtvWjiyiaD4Etu7xfbeqlj7TitdYr6cQ6z8YqWMxHVqenkQjJUbcaY2oXCB0mQ1o39/rezqWwmrWsnGAC9IO2ZzJY3HqEzPHAo2D01rl4AoyCv26Y1oqvCznSNvzGjCWbotIh2XHHCObOjPSKlqoszwFyHCRKJ1VS9XgQUlgN5gA7cV+rNOGBgcCRk7dUniMZd6r0ESssIEozVHToN67EiqqNruqw353Oiz2SxaKRs9gJESGFC4klNDOh/FpnLYLP/QWD
X-Exchange-RoutingPolicyChecked:
	YQZufrApytyXW8gUPFFkXtDQStehnJ+4Rir48TgStU9mxzGwbx0aYzuoYGB1dB9vo0nk51adTI+VcsotPLRKMR77ePphFu2Gzrc6zr6cyu9LUXbGu9JhecT8+u2INGhCWAay62JoGX+c3wymCM9Mn4zmRMYcftPoSgZIbDEWTEAgnJzoe5Q5Af8wztyAHwYMqxxJXvxxS9I0MtimCBvKIOC8UGmk24dfotL+FyEFuz4l5B6abDLJ/PeekykFeKzp/tLRK/UZw4ws5Mntty1yOZlJNoLS5+HkTBKALX5lq6tHiGNLkzQPXkWv3MmEqFIsItEFVrt3Oh3eTFqRlqkiFQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 20:47:08.0627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f126e31d-6032-4938-d493-08df2321d276
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4169
X-Authority-Analysis: v=2.4 cv=AMeVrcbb c=1 sm=1 tr=0 ts=6ac40cd2 cx=c_pps
 a=LyZwXkN/zJaPlZXKe3eCLA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=sVqJxYME3hYzk5PecwcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX667ixYHXVMjr
 HCys49VjtdP1whnLtZUHF7lkajq+HbRrJ1UU6/Glt42wJaIaY0EA0P1X/IWfu1Wc3q0TNMCfvAs
 tjEKUvfJ/+102aH095Zlefv0FdYwJNs=
X-Proofpoint-ORIG-GUID: nDGbYj4ROwoTKmcmDBAMCgzneRROcHPa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfXzUHXA/kjyOGF
 ovcAqx5bcSRONub+juBtEanVl5ulVTgoI6lWYsoDWfxTzf3pOYZBYM7XzXZIfYEyZX3lVonMe+q
 z7Rp6hea0SlWMJ0McNKCHw+CEjyZdL79sV2P9zNpq4maQIE4D/KgNBasL6dj7EoFaFjiEa7S9H1
 0VxjzUeGDEMd7Mm9N8tTWBsUtXaIfhjiT2zGvSqYsMxxaLSgwXDhEgrn4BwTnIzrDtdiuhO7l/x
 apXEhIl7L5Ers4aDDtIR/x6dSUcrnVjlJE4CZcq3fIBXY7il9FHzbIVhPU32+47JY0BkFFrZVlQ
 asOs2Xsb7mvhWvdas04oyu483NjyXxBC2FxOS8aqzrOc0EdE06+DXcEUtTKz44RbG6J6VwN2zXf
 AoP/LxXKU6q5IJDrNVty4DL71QoGVvnZL/o3WMIVU3CpH59/RooUjyIQGczHd/n+EMwW6cfTZbK
 UEOMhU43TIXAGcU3JPw==
X-Proofpoint-GUID: nDGbYj4ROwoTKmcmDBAMCgzneRROcHPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050081

Document pinctrl properties on the gpio-keys device node. The default
pinctrl state describes the default pin configuration. The wakeup state
configures pins to be able to wakeup the system from suspend if GPIO is a
wakeup source.

The pinctrl sleep state is not defined here despite being used to configure
pins for system suspend to save power. It is not defined since no
gpio-key device tree nodes utilize it. If the sleep state was added, a
device could use both the wakeup state and sleep state. The sleep state
would be entered upon suspend when wakeup is disabled for the device,
whereas the wakeup state would be entered upon suspend if wakeup is enabled
for the device. For now only the wakeup state is defined since it is
used specifically to enable pin configurations that can wakeup the
system from suspend.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index cc78c2152921308fe0cad3e29ca78a5fad08f066..a0712fba45845e42ca63489354e0cae87de2143f 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -22,6 +22,22 @@ properties:
 
   poll-interval: true
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The "wakeup" state describes the pin state used to wakeup the system
+      when wakeup is enabled and the system is suspended.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
 patternProperties:
   "^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$":
     $ref: input.yaml#

-- 
2.34.1

