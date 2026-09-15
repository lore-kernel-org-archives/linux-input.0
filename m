Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D948D869;
	Tue, 15 Sep 2026 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494101; cv=fail; b=fyOF4+C1egZ9CWf1SQ4zs5TzJ3rKQEDvkoVIhSftV952hFW7GIVJYqCP23DP1KLEdBujx9YdKiA6cPPRUuNwsWgQvI5hbB+LRgRc5J7N0efhQsBHl9iLsmFI8+pICxpB3gxyuVwF1NMzRi0v6luAJ1BbJnw8hj0AchQvGMyMuOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494101; c=relaxed/simple;
	bh=7C561Rk5xH8PyGgdo95QO8JQM4F8z9GXH9ocEBsqUUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFr1XLdyfTZ1kbRv4qMv/DL3qTjlWuDpqKRa/1bFtrwR6LUf0KACSUfSm9ydThgsHBhhk+0KAHy89dkviSd/fFgoQ2z0RxLK4UHq8YyemaZekRWozce7N4nHKxqE9910gcG/SUqpO40ty4sWTXThKk/qTjbCs5vHo2yjryTt/k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=AMt1kx4i; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ojz+o8EX; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="AMt1kx4i";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ojz+o8EX"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68FF7FOQ2096004;
	Tue, 15 Sep 2026 12:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=Kj+iOh43WpY72C8
	P3CZeZJ19/1P1bGgV1YeHaEkty6E=; b=AMt1kx4iLSIIZfPNQiJDhG7KE4XQDj3
	hdYuMzDX5UeAKH/+qIabaz6kIdGsmEXyBupNrYkEYnbG6BRhiXDIj4bINik++Qco
	ynGGBk7X9kD1oi7IX8X5z53odKhhHc4BuKe6ChNwdMWc9VYetLe6X1RZzChw6uJv
	ZMEcHX58L1S+mfo97W901bxXEJ4eIalYMPeXFneI6LSbtpKIH29tjiRMueb3yqSk
	mDbx2cedYX//lO9q9Txlx3BKsdEaigd/xAmpwXwwTL4jkUmqmqlqQ62K31W12fZp
	E/6Z15xd9keyvH7YUEqSmSD5L1ykxCRkyphByHj/YKgQrSRLiY0gZZw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gpvpa5pfp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 12:41:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP0dnorYnKX18Gt8HcUi9v1PxNnk1wUQw6v5svIleutMvMdg5ndITmcGhU+aXeksrafmkol+XkKvXulCi/neH0GLral/ZCyFXcplenQGQk+eUxEKcniFrAAbFi2N+P7KpRgU3/pXode1KxsHjewLFbMTE0ZGqC6A3+8+yGSMEWPGM8UkgHfPa1YF2PFx2LDQu2z2kMdWIMKw0ZorhNP32k9TTSwozwAYs5pxxn2JQZ9rVZiOSYYr58iwxYCPnoYPGtjyuz5f9hR9ontglj4ERH1kBeElv2+V7WaySztHJNLH0Yoni4KbuW5h44TV2MOXBVCqJIssIjO8CztdIF4fcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj+iOh43WpY72C8P3CZeZJ19/1P1bGgV1YeHaEkty6E=;
 b=iKaM5NStC3eDBOlKH79Dv23kB1B2tdS88RsdofTlFCLqHx7LJwmColQ81QAr4K17yTKfq/kXK8TpW4O92Pdka09nuzLXmieOtzC17jkni3yHm4L1g9Uce6/KiHgv9/SQDnJIcwRiPBZ5ZcUAvx9m8rzqEO/tTaXWLT44Qgb08KN73kJz/goM45YIf39BM05UnhHMoobJH5YN1k8wlKs0QDfhtg3xKJttTIvnxpp+WzAcDnzfxmhTXrVPDvKUaZJf0fbCsmXJvsJkGh7HlqO4botad1ugpYKeydR37ZL/S1qoMO8U0uNFm7X6T4ROPRP5ohmHgOZAN6BvCQ+BKyD9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj+iOh43WpY72C8P3CZeZJ19/1P1bGgV1YeHaEkty6E=;
 b=Ojz+o8EXzc+t3rfxzFd64aM8qlLzzNE/bkTSVgzkn021PtO1PfE0bqjcnHmq4pkC5xxXkfennImWPeu7BW8hHSylBdTToJsOy3N9QsjVH9pHaSWEO3MhNhGSHHS5xz2NmNHpuiXANyVobwhJY7k9AdYw6Pub4MijFvfbQBgNC1s=
Received: from CH0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:610:75::26)
 by IA1PR10MB6734.namprd10.prod.outlook.com (2603:10b6:208:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 17:41:26 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::9e) by CH0PR04CA0111.outlook.office365.com
 (2603:10b6:610:75::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 17:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 17:41:23 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 12:41:03 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 12:41:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 12:41:03 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68FHf3ow3673378;
	Tue, 15 Sep 2026 12:41:03 -0500
Date: Tue, 15 Sep 2026 12:41:03 -0500
From: Kendall Willis <k-willis@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <msp@baylibre.com>,
        <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Message-ID: <20260915174103.ad6tjy6w6s24h2yc@uda0506412>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
 <20260914-unbreakable-competent-beluga-efb5ad@quoll>
 <20260915164819.nlgpuvf37rhzgc66@uda0506412>
 <dec4f6e1-115e-46dd-8fb9-a3c67f1a8811@kernel.org>
 <da881fb0-93da-4d75-88da-8898b2c734eb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da881fb0-93da-4d75-88da-8898b2c734eb@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|IA1PR10MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: d98c56a1-ce9b-4e1f-3fac-08df13508f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6XbHIdBNoCO0L12TsVa+MgLwD/19oiBHwX+9BGOhVRUhFfRK2Di5CoAu5PtFlsqXZlrr4YWw92fXPsTBt/d/4WR+KgkLRPndtMKLjgtGpcOio0KIfp1ghwzD7WbgUT05evysqHvjFFMtj4eFHt1ycki8hyRfKc3Ct+IpAtc3G56V3XwAjJkQN2KslDsHwWFCgbWEOcdqaIXnQSrD92x8DmL6vAardvQePgT6IpcN4rF3aFAys9XdzgWCu9rIxyBJZ/VBa7Kb7NuE7DIQJO5wo/7e/rC/rLotPNYR6rST+manumKRu1mnqoAA4UEwWSB+Gldm8LemffSHeGj83ncD4WATaiWQXPcMN/EmwYF+tfE6JA6UxOQ/iKx2K79znzjLahR0X/5ltJ45b1o3NbW8S2garTKLhLIRX6DrKAUQJO0/irIR/8IC23+06KvMditn5cxhPBjhFBkZiricmtBJ23eAJEAeWBPCujt6as2Ga/tcYFjfdigvtum66IUeEzOwLFh783TtxOW0WHgcOuvGU/LryGNGN6X5kVFjNrIK3rArNclZ2JcSYh9eZzkhrhZrIM5WMWUnS1Ta7ZMBmz5e4wE9nlBu3Ry7d3lyhcowOVn/zAj2qRy/qIJ4WpFm+23YjHvwLh9dO2vODOJCWS+tMELyLrDXLwomcGlPKQqqF9aH5BsS20NgE2n7NbHW+z2KR05mK6XVOzVwVNOQxNB4Fw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Da8LCjlv/gyaNXXj43rus7cFvSipBxeLWZzvpJyxI/a9yBEnxCkskUwPbGicBIctZV+4LgSz8maVsB5f8Wqc52eXgLBf5elefGKO24ZIliQz+zrE0MphHTYK2ZuWUtXd/zfVs9FAQWFIzC361ddNh8nUK7jP9hvJKgeIYier1e26ZXWpeGhK4+UJqDdKHvtTZaw+j/jEZbtyXfV3iE0X1R4Bh0F0NqA/xeuysk63g9fWr+uXimXaDOHEfU/UyRLzjAhXDTcXmRFiMZhrMdDHcVnDmJw/tfUzsjf2eNidhxb3tZY3euSfldOFqc2Uv0R4QpkwVl2U4kk2e8UEmQpjusKHxLgRYiKIBdqoiZUaXGZOCg3ASsdZ6JvfB1Crr3HYKMpW2bEEmYQPirCLlqtjG0e0I4SrhH+x3EDXTOU1d1CB/PL+LMQL6kHm2nW329Vs
X-Exchange-RoutingPolicyChecked:
	zyM9PjIogAv/Mh2JB+NZBEBXCg3LcU6EGjXm487TvQN7WPuJYis5NYTOXIHQXV7eVuLem2Pw38YGWkwniVNiPAsC5vwrOA8tt6frVeFnBYh394Ew5sH9EPqTbGkCm1zM26Z/W9AgCDv/lM7IXXl4qTotuOQ5IqoG8Ghf+STYrzSb8Z69pATiuPyeRt/hW7z/w9Yj1xBD1nN5EX8Rj1edKUm9pFiMzoN7tq3PTYxJxNEHTUdGRFlxwsL9AwFBVR3oSpVHwflWVrVlW+H0mr+RHO6pX9RaDaxsacayPBDmH2qBhiX1Y+GhaZu06YApHNxxq9pSsQa9uHvj0xSiRx8Aug==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:41:23.5701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d98c56a1-ce9b-4e1f-3fac-08df13508f91
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6734
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI1OCBTYWx0ZWRfX/4y50OyJ6BxN
 k/qaTN3CNjBdF7QIzHZ5sCXfDpNLuyhoBZRmGHzS44IGSPNBtBT+aPO3bHJsuYwlvLj7JE7dP7S
 IMetXK8fIpCW8tkitaEKan5cS/NE7BnKzFRiFTb9Mj6FAg0BA3o7B4D30+lcVjzk+tguOAdnibC
 lyAqUbEFZCfNyxFVKiEj/Yp3ruGc8injRuYRTdgHeZ11FLIt3qPwO7qAoxcgNJRdnNY42w7eLdg
 oN57IHYpKhM/VH/W66KCsCQNiF8lZmFHtwwotNExYyIup0JSbcnLilEhVFwgHPrCp4LBYYR0Pjl
 OddIuyqx21y6IesXeDEyUlSxmX7LOzmLYFq4NA4MBv6WptsmaIHFWduzcC1I10BuBEG+qKc7xrU
 F9TmojpaVNvfGOt//U4/dUjPkuckbVwi87KdnNcKjhppOt61sBJzRSDJBM7dh2Ro5/QSBK8sfrr
 iJIramPmrHbfWDjo5Lg==
X-Proofpoint-ORIG-GUID: -AoQvC5GdA_0ysGkAtW2IAIJ72aSzdXn
X-Authority-Analysis: v=2.4 cv=U7cHnuru c=1 sm=1 tr=0 ts=6aa9834e cx=c_pps
 a=UGDxSQ6JIm3CXF+tY3HRSA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=8KQqiiyKSBWXZ-wswmsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: -AoQvC5GdA_0ysGkAtW2IAIJ72aSzdXn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI1OCBTYWx0ZWRfX/a112qlDcF3e
 nwzZLG4bcPkCoUAMwbCRBbJG7JCwtZ/S3pPZRTHQAEHhLliHteqpJ+KGmHYY2tkBLjhjTyZFhT9
 FO6WplwqkPl/cwc2rVdCXAMvjYEW7ZQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150258

On 19:07-20260915, Krzysztof Kozlowski wrote:
> On 15/09/2026 19:05, Krzysztof Kozlowski wrote:
> > On 15/09/2026 18:48, Kendall Willis wrote:
> >> On 12:13-20260914, Krzysztof Kozlowski wrote:
> >>> On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
> >>>> Document pinctrl properties on the gpio-keys device node. By using the
> >>>> wakeup pinctrl state, the pins are able to wakeup the system from a
> >>>> low-power state. The default pinctrl state describes the default pin
> >>>> configuration.
> >>>>
> >>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
> >>>>  1 file changed, 16 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >>>> index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
> >>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >>>> @@ -22,6 +22,22 @@ properties:
> >>>>  
> >>>>    poll-interval: true
> >>>>  
> >>>> +  pinctrl-0:
> >>>> +    description: Default pinctrl state
> >>>> +
> >>>> +  pinctrl-1:
> >>>> +    description: Wakeup pinctrl state
> >>>> +
> >>>> +  pinctrl-names:
> >>>> +    description:
> >>>> +      When present should contain at least "default" describing the default pin
> >>>> +      states. The second state called "wakeup" describes the pins in their
> >>>> +      wakeup configuration required to exit sleep states.
> >>>> +    minItems: 1
> >>>> +    items:
> >>>> +      - const: default
> >>>> +      - const: wakeup
> >>>
> >>> This will introduce new warnings, which should be being fixed in this
> >>> patchset (e.g. at91-kizbox3-hs.dts).
> >>>
> >>
> >> Will fix the binding to work with current device trees.
> >>
> >>> But nevertheless, isn't second state the sleep state? How can you
> >>> configure pins for the wakeup state - like being in the wakeup? You
> >>> configure the pins for given state, which will be a system suspend, so
> >>> sleep?
> >>>
> >>
> >> The sleep state usually refers to putting the pins in a state to save
> >> power. The wakeup pinctrl state is for putting the pins in a state to
> >> allow wakeup from suspend for that device. Both 'sleep' and 'wakeup'
> >> are for system suspend, but they fill different functions. The CAN
> >> subsystem also uses the 'wakeup' state in addition to the 'sleep' state
> >> [1].
> > 
> > So you mean sleep would be a separate state? But then aren't both
> > exactly the same states? IOW, if device is wakeup-source, it will have
> > for "sleep" state pin configuration allowing to wakeup.

The 'sleep' and 'wakeup' pin states are both used for suspend. They
would just be used separately since only one could be used at a time.
The reason 'wakeup' is separated out is because it is more specific for
allowing wakeup from the device.

> 
> And about CAN, I see no use of both sleep and wakeup:
> git grep pinctrl-names | grep wakeup
> 
> So if you use existing code as reason for this change, then existing
> code tells they are the same.
> 

Yes, as of now both are not being used at the same time. I was more
pointing to existing code to show that the 'wakeup' pinctrl state was
being used for wakeup pin configurations.

Best,
Kendall
