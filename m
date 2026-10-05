Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F737B022;
	Mon,  5 Oct 2026 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233253; cv=fail; b=l9vuDECj0oBLzDmYZxywoXpkQcrkzFDuLur4PsY+sN7CUeKl4io0b/ycPZ8bYD7RzgLK7xEhNcMwJ59wcK3hU8deBpMYVfV8Zes++IPxsAQreNZ6lEL7Cw/u5BDxyVqUXU/jnrMrgIn4IfhMYps/uZbdsFKV5iiusCv2xgN3HY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233253; c=relaxed/simple;
	bh=o7lJSkU4/pZMuqYyhZlOBSRWoQF+IFMo1a0Yiux6h/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G4GGC+BeQvFzO9OOoHLXqqGRd69kXpdZmUdyVeCG0LIve2+PuS5XSvZzZ8naHAKYevP82BtheHWfB3cZNwVYwHodq3JoKsWZAntBtaJCdDdZd8YjBlC5Gwl6GlvsgqQFYWJ+koCCwgTRxVsOWZS9tJlH4sLX5xG3fxrlDqIBLKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=PhT6bT2e; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=LfCJM6tF; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="PhT6bT2e";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="LfCJM6tF"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HLOWd543855;
	Mon, 5 Oct 2026 15:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=m3YM+WwrrqPmjQ2PSZl1YxhC2LpoL3eCnVupBIOoq
	MQ=; b=PhT6bT2eO3WpL/ro86LJ0WDHmNfVERB5xu0agnhTvcImCaVk1H0W2WIR8
	DW9jKomoAmy9k5FbU5ONPXaOC0cEsdPHcia72dXdKrFLpx63frB1jd43+Vm0vNvm
	yyt9wlRzZLp6vJOTyt/ocASLLjZlFfpnhFzbri3kgrwXC3t+7d3zCAwwx+lk1+hc
	4LhvyCXQozvNd3OCFaUa0YZ9XZIVNSoah9ub6jlm8wI1e+2YWXnZnO5dYO2kRZAx
	4bthWyXZPW4KS6CcGfcqdRnM6+ce8DRHPI9lgsT85OyU30vUgyjDdfIMrIrrxYiu
	xCCOkmFWszLkDDB6KNvhs7el5TKNQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h4d7c2k7d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hr9mzl8+kBdx7z3dzfyunnCl0T4nC9s3k3ZRTfAq8L4J+07GmBuMbo7t8sDG3w6YxZzBnM+6fWoVD1LcOEtO0S8oDjz+ruFtsom3UFDBA61YIwLdl6scz8xbuWiEC/obz3LngmJHZgdPhFB+iSz1dtr9+tbdPzfvdBPoDBfuBu+zGtzsYoDfjxAhsEANpF0sK+9PjAJaiLob9DwcGnlATAtvuAWdJtTso60U9oaN6J/Jh0jN32Z0n74Dj7DtgGMIKrr74i39cAQ+g6phVkHEV4gCGtxOkniFvJJG1/cbbad1Y5IPEPGHvBeUmyMWa5e/UAclj0NzYfcfIRvcR486zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3YM+WwrrqPmjQ2PSZl1YxhC2LpoL3eCnVupBIOoqMQ=;
 b=fSdyUYjDdaV3rp13Pvex9n2Q6tJcdTNwNtlwb1aVTUfTOF9w86SgOo8qe3Q9NQVTE3NtD9t11maEdBrgJQd1mkzrm/zLpFrxrjwZipqMzn0aXJCUtr3dU/imnfUzv4/sX4xPGK9mLMbNjwFM3vLYVAmrgxX9KyX+08o4bTVriNmh9cc82XMGkuze21Bjcs35tyVDsrooQRMDX3ib+32QnK9kvLK5+3EvEE+ceYSy9SdBXbiSRONxnKFRecrSW5GTTgtCgtMjp11wcWl27A1LLp4mBKhJKgEOZOD3etfXZJ6TAWjGH9yr5krKeDGe8FDC0mzKT6ng9YNZlpKiIBiSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3YM+WwrrqPmjQ2PSZl1YxhC2LpoL3eCnVupBIOoqMQ=;
 b=LfCJM6tFVdfkdak7nTpPRcfKsfq1SeRI3vsFvAqa44nducyuSYaESKuPBRekK6EkfWsMn2zllfIMzPBC9X4BxvLSTDcw6Cu4aKZgW5xXk7OKAvYEbGsX07dl+nnCX7BrAamGc7nMvYUw+GUrms0AClOCSnqcu88LcCoPKHJxzkg=
Received: from DM6PR05CA0061.namprd05.prod.outlook.com (2603:10b6:5:335::30)
 by SN7PR10MB6305.namprd10.prod.outlook.com (2603:10b6:806:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.13; Mon, 5 Oct
 2026 20:47:24 +0000
Received: from CY5PEPF00000E76.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::73) by DM6PR05CA0061.outlook.office365.com
 (2603:10b6:5:335::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 20:47:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY5PEPF00000E76.mail.protection.outlook.com (10.167.247.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 20:47:24 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 15:47:04 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 15:47:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 5 Oct 2026 15:47:04 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 695Kl495892360;
	Mon, 5 Oct 2026 15:47:04 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Mon, 5 Oct 2026 15:47:05 -0500
Subject: [PATCH v4 2/2] Input: gpio-keys - support wakeup pinctrl state on
 suspend
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261005-upstream-gpio-wakeup-v4-2-96f092de4690@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791233224; l=2916;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=o7lJSkU4/pZMuqYyhZlOBSRWoQF+IFMo1a0Yiux6h/A=;
 b=9J+7RhEjRREO/jDduMAIuWHLgQkeVI8l7nsNxbmzk8GDpSBzDRY+XLe8zG8wBZZDQlu4fr72q
 j1VqryNWE1vCD+YAQdEtKpm3oankcZdkmHfuGejrqzHSYyOaRNLrZJx
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E76:EE_|SN7PR10MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 00db700f-8fc8-4f97-da82-08df2321dc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xe0phjG4tWjj2TcMurOWajdvnQDI9OANNSKU5H2WXnJJUPNU4XJdBIHeSqo8tmVj1dDtz4LuuUfbzHQ0l4mpkkFL8Yeq0/NvrvtKzCuv+tDTxXbUzyo70JyGzXQA+2J7CHebpjxA+0SnAv5RHURWA1+hNShUXNtR7Y7Et732ZqiKHKiLkxdOU6CxLdlk9t5qOD/mLUKFHkBzXwVxG5PgMFf72PoJcVSfIt32+RpTPIrFhJiOS/OPFSwkCDGZ24MKUpGT65xDTyVErRCNGIkEhPAIwgN0D2/1PbhS0yTVleHcg7TPLI97k8kPlvhyjorZifIkFVML7kTkb+DgMq/p4N5i1PhFnAmj8vcI0opz6anloeNm3SqDPlUcTHkZUQ9ZbYRE2pAbwoa+i8BqxGw5EB9nDwisE3QY1Qs44PRrXN96Z9t7BinQ9zQnK9LCK+dcGnlvsbRJqRPpb6EvbpZwVHPAs7T8HMdyZ9yhjfFGiwt9WHseHIxIa158ZCXIyM83DHAGs1ToJi3ZssiLCuL+FAlHupRrh19oCvW6tEFJxxIPAHtnAyqgXyDlhAiHzy/UnN+Do4AXH2jbVap44gkNwLDXuGjj2IroNFrilYr9aI6rY0BMGY2yix8XmCK7RYujTu5XtaosfN7f4BSIQRtHc0+xesHaKHPcFGjJjKP8AmkdBjSQKvA86qlozF6Fwx+jdkTqcEPoU4dD2m3iDBWWyw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kWPFRnJG8lnQ9ySUy38ZIjR2XQ1Zy3YLhKAtYVfqzu+ELwLxZFwy5KPn1+Pf8KA95S3JLwRxKGOSNlQz5oqyQSbpkOLyZgpE1CacZnJrqHQiovx/KGfDap37rv16KDIeZePHhhQbTKDEMSFEIRYlFwp9pEfDULgC9y6owsmncu8P8dVt2pCZpdjGCCK20ImTeifl1anmUJtCAHuEpwnw1wGBmsMgxtBa7vMgLZbqyKv2+FBHxxrGvalJ3E0thdkkUqwg4K3Nk8xd+jN4RQCckfrxEPb4k49iQSfyFO/hsDNyXNQeap8yVA+I5teopkohTA7MWUsxQ44FHudipzeLe8kSyI9GP5EEQCkzAZc8UVoknfw71TdFlr0uFnarQ/F3bE4bWUWFtSpDZ8NtZyz/A1/KuHMCGeaOCdn3H0W5dXOl+SpnEPUancV4lh96sggU
X-Exchange-RoutingPolicyChecked:
	BpbXeGPSsa9q3+3Ms5JRLz5h9E+5yK2tnN3UitOFtZzXSUpekgssYfVFb/9kwpUMGHGjwjF0pzGWjz58T5tOZ6lxELUo4ABxQ7pSkNarx36+vfe5vxVRE/waXFx3jgb8TgajjCMJIAYKbEXRIHM+HXTsAcRunhQKu+ZM0caDE4JPlzWpDydgOQGxis8KWdT+S9YlQ3bGfMIUT/2+IMEhqrajnjYeNJXrX3tyyD0aHsW+3sefu8jEoxkaa9LH9iBHH0VdiO2QAds/3cW9DiZJIvEmPbNi6Vne1qILi04j5Bt9sXbzqGMlUmdcsr/C33hhGWnsh9zbQqFU+qsAYvZ4eg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 20:47:24.1400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00db700f-8fc8-4f97-da82-08df2321dc0a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6305
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX3Weq7GE6HBS2
 BCHVm5N+V4Rw+qJ+bjzbtnvj4QrX3nLAJvEivCc3FMRoah0XHZAjLwkSpqNJe74bQBmqBbgx1yZ
 23Kz/W84WmFT3L5KUCqdE4VRZ2NOrcU=
X-Proofpoint-ORIG-GUID: j8rELX5l6VRVqD_td-wWwCy5XrVXnfSZ
X-Authority-Analysis: v=2.4 cv=RfYFmFtv c=1 sm=1 tr=0 ts=6ac40cde cx=c_pps
 a=J0oTDZHsw5jmD/+vARdUUA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=OP4iwnenC8Is5NdNPIcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX+GZYdUmunYbc
 WY6O47XwGxUdN3FWv2ZhOu6I6qGqePv5qT8Xc6qK4VoMMh9M0If+KWz5dr7bjiGUnNSXMJgXmF7
 FYljJX9IwzvjNtNYHi5fYuXHM8d4pDL296l5JXOzIdB8ue3hxeZRCB7s1XTvt/wapuR5T3YmblL
 CiHHnL1vzJSJerNb/+A3KSbMLK8bQ9ikBtjsH+Y5PKi6USLi9bg3hBsydxsrhkb5asv87ARe0V/
 BB/4H11Ev9II35erfWL71mkucjyJwL08nK1VkJHlNzG+HYxjM0joCo7k6pJpOL1Mf/xqDANY3wt
 N/woXTT023Mpq/gfQOvQLsaPCVIsVSemKbYqz0qo1/s8smCSZ6ypy6gCauBxv3feEHnHyo7VUaX
 3gtTDHrrLtLz+7I9fJMNlBmoC9A6m4FhnGYYhDmlnfLinTi2YGahSDnFIL6+JBQ6E9UUjRAxQOn
 VlPFRgJY+b8QQlpPUzQ==
X-Proofpoint-GUID: j8rELX5l6VRVqD_td-wWwCy5XrVXnfSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050081

GPIO can be used as a wakeup source for TI K3 AM62 devices during
suspend to RAM states. The GPIO controller is powered off in these
states, so a wakeup enable flag must be set on the GPIO pin in the
pinctrl in order to allow wakeup.

If the device is wakeup enabled, select the wakeup pinctrl state on
suspend and restore the default pinctrl state on resume.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/input/keyboard/gpio_keys.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 129fc4212a5ed126496b331ce626682d441c53bf..8d3409c6de1ea87ccc118b2d6ba9ffc313caa027 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/spinlock.h>
+#include <linux/pinctrl/consumer.h>
 #include <dt-bindings/input/gpio-keys.h>
 
 struct gpio_button_data {
@@ -60,6 +61,8 @@ struct gpio_keys_drvdata {
 	struct input_dev *input;
 	struct mutex disable_lock;
 	unsigned short *keymap;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_wakeup;
 	struct gpio_button_data data[];
 };
 
@@ -884,6 +887,17 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	input_set_drvdata(input, ddata);
 
+	ddata->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(ddata->pinctrl)) {
+		error = PTR_ERR(ddata->pinctrl);
+		ddata->pinctrl = NULL;
+
+		if (error != -ENODEV)
+			return dev_err_probe(dev, error, "Failed to get pinctrl\n");
+	} else if (ddata->pinctrl) {
+		ddata->pinctrl_wakeup = pinctrl_lookup_state(ddata->pinctrl, "wakeup");
+	}
+
 	input->name = pdata->name ? : pdev->name;
 	input->phys = "gpio-keys/input0";
 	input->dev.parent = dev;
@@ -1010,6 +1024,12 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
 	int error;
 	int i;
 
+	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup)) {
+		error = pinctrl_select_state(ddata->pinctrl, ddata->pinctrl_wakeup);
+		if (error)
+			return error;
+	}
+
 	for (i = 0; i < ddata->pdata->nbuttons; i++) {
 		bdata = &ddata->data[i];
 		if (bdata->button->wakeup) {
@@ -1023,6 +1043,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
 	return 0;
 
 err_out:
+	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
+		pinctrl_pm_select_default_state(ddata->input->dev.parent);
+
 	while (i--) {
 		bdata = &ddata->data[i];
 		if (bdata->button->wakeup)
@@ -1039,6 +1062,9 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata *ddata)
 	struct gpio_button_data *bdata;
 	int i;
 
+	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
+		pinctrl_pm_select_default_state(ddata->input->dev.parent);
+
 	for (i = 0; i < ddata->pdata->nbuttons; i++) {
 		bdata = &ddata->data[i];
 		bdata->suspended = false;

-- 
2.34.1

