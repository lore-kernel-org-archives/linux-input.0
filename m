Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449819F121;
	Thu,  1 Oct 2026 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869866; cv=fail; b=ZCjL9CvRGEGwNfFcEpWkX2UgOR+//7QnaI4bK49MUGxGN2Yqiy1ZKe/1a4ZgocLXAuF8e+scu6fFCTu3g5KesCx7VsKyJHPq03o7bCQ9529WyGfzCVKk56zXU6UL5icN9qNaE56WJZwyro4YTwj9Y0L95mtTVCR2luBCYC6SWJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869866; c=relaxed/simple;
	bh=j9Ncs+fzqpgNioVzIE/YtSMEgnVrlmvA/hx2zo5p8S8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=b9F8oFif14RAl43gfHi2/feFGKnkGJ4X6pk5p7V2OQg6EbOZC88xPkXaK/N4FYFpgX2WI+3iVKVLwnlG7qQtoRrfKOgbEG80800V8CaBsgWS7w3dxjhBgp7i28zbV+Uq8fqE0VEaWYJ4zqoJ9kvDNrCTZGEjsqpiAfXyM7dD2Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=MIof5HOv; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=G2bDdUcX; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="MIof5HOv";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="G2bDdUcX"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DkWve2097957;
	Thu, 1 Oct 2026 10:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=sESnqf8SdHNgU
	06xW2ehFPfu1i1xn2Gg67kujRnKRgQ=; b=MIof5HOvwwLNwV1mFgH2CxxwF6VJU
	MOAwV80g3nbVc8mL8kuTvXpR1ee8vXa9ChMTx47wXz/jiVgBJLgO171+n5QK1PaZ
	yOSkTr0yx8e+2BIdoou+rxsjx65wSOZJTxL8LATs/kuIvpR9awMzdEyU6fOKGtHa
	ArAdmZ6hA9jg9HALMJJIh4KSGeBfQ1QlzkjDEmQjsF3RnKlWtjrLHRjVsbS7iHJ+
	2s5wBeYlwtmSyH6dv7as4q05Cr/Mr3F/jyQWnUq8Lv4i64sinYyrK5DKWXVCadn0
	nw4NZ26EqP2/+ZselUN4UkfmDS/gTak/2jh7QqFO64amzrgBm4EFvZPgw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h1eurca9x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:50:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLSNymL6sGRT/KUkn8brmvfWhKTpTq6BOG19qV59apYAzTuNIzoLz+UT0Pclswu1+kdFFydPZY6vUt78e5dLBu/gV0vcfcuLBC8fQFT1M01WJp8N2I6STVtNay5rreh30PEgr7b+RIdVgmPeAkVv/VkwIHHlnd3kWDAV0Nm8Gi4bxGDmYw1QjXs7plvrA+mt6T0WU4hbEnFsZPM46/6tB2ud8qdTaE+Q+IAztFRu2pvO6cQndrPo8EeIz++yjDWpvXUqCOpSmgvlBM21BFGk53/BQSZDyJesi6KdYBCpfvXmXdhPcBTXhBnHvtFqBKVaJzX03V6AsZGvzg+p+YxhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sESnqf8SdHNgU06xW2ehFPfu1i1xn2Gg67kujRnKRgQ=;
 b=au2xDtK5TA6M2L7mzkItVJXzEHdzCJ8T7HfmutHa+g/e1RJd0LT3vVFuapMr51+YLBR8lRvZi+B4+c3BWvHq8pKsW3GYtiaMhFSR1TsU1fDTcj5cIaxasrlZSsmauxn6T6ad+fxMS9rOxKxKax7UHsAWEYdC9jLg3LMC3osTjSM00Zu1WgKewTI3iCqbXu9eqceMnOfOnAvKAvAqI5N1yAib5s3l4nEjtvuzptiSbC5DEGT20G0y3P23F9uvaIF2iV64s4w4yLgMr+ipP0pDz46hnaqvpSVoflfgMNmQMg8CljGd0upPn8pVtYvl3JCAuWjPeFYb9y4M4RBHIt1VZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sESnqf8SdHNgU06xW2ehFPfu1i1xn2Gg67kujRnKRgQ=;
 b=G2bDdUcXOOOnTvVGJqXRylMWkottu5Ew4HuNKJpdEokdbj4o0FqMhrT3/Nxk2MSW+rsvohmqF4shZullCSsUkGuZDkrbtj2zuKCZQ2pW48qeQ2YLKvKIsYh9tsqRPu9vV39PHFA4QTJtuLMf8amf3wAHyiIbb/zjzrIFQSTS9Gc=
Received: from BN9PR03CA0343.namprd03.prod.outlook.com (2603:10b6:408:f6::18)
 by DS7PR10MB4910.namprd10.prod.outlook.com (2603:10b6:5:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Thu, 1 Oct 2026
 15:50:55 +0000
Received: from BN7PEPF000000A9.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::88) by BN9PR03CA0343.outlook.office365.com
 (2603:10b6:408:f6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Thu, 1
 Oct 2026 15:50:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN7PEPF000000A9.mail.protection.outlook.com (10.167.245.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:50:55 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 10:50:35 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 10:50:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 10:50:35 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691FoZWN2219384;
	Thu, 1 Oct 2026 10:50:35 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v3 0/2] Input: gpio-keys - support wakeup pinctrl state
Date: Thu, 1 Oct 2026 10:50:32 -0500
Message-ID: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEiBvmoC/3XNTQ7CIBCG4as0rMXA8BPqynsYF4i0JaaFQIuap
 neXNia60OX7JfPMjJKNziZ0qGYUbXbJ+aEE21XIdHpoLXbX0ggISFITjqeQxmh1j9vgPL7rm50
 CFqAFJ4qYmitUTkO0jXts7OlcunNp9PG5fcl0Xd8ghd9gppjghlgKXPGLYvI4ur3xPVq1DF8Ci
 D8CFEEaIRhjQgL/CMuyvADimqBI9wAAAA==
X-Change-ID: 20260904-upstream-gpio-wakeup-52a54080c948
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790869835; l=1960;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=j9Ncs+fzqpgNioVzIE/YtSMEgnVrlmvA/hx2zo5p8S8=;
 b=AYmAyCTpKsUyfLjVNaicPxoSycwyjQMyoTv6dielmq0RmuONyzDEbHrcQPdjUV5/wjwY6KN2Z
 nPpnmYSzWJ2CmBdNRukONk7TI+fwjESPa7KKMVD+XgUHo9ekSuug9SK
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A9:EE_|DS7PR10MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: ba57eeaf-b063-4fd5-c659-08df1fd3c746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|6133799003|10067099003|18002099003|13003099007|260925022911599003|260925021311599003|260925021911599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/noWrPLZFQ6niusRfZJNKYFGwQdCWEEE5gp8GQXOuNHwa8uvgQaNtxLBYh0OxauIdZx9p/VHgC13RMBhTwJYXetErajYXezzto9z88VRM/7Mva9EHI+dvquImSLVWk+liRgKvVjjP1nubCSFVIArAi0g9vjxw+fNpBWw4im/WZg6534A+mDhOIktABTaiNQpbLzUEoWVaFshgFZ0mnhoLev04M6UC3CG9S+Blh2ti0CzkF8soFK7EACyIWyTdnXSpVHJ/+UBouZz6XV73eIa9MOJtstThCzPOZAC1iPfw0n5mTYHzVWE1yP/Vj7YYZz0vp6NJJX7XGiu7XGC1C5yh2Th09JFS80BXKGg6pZnqj51eE1N/zmzGBzJquZxU3vhv1aeGzv84QfURUqtO3kCnZBLk6hHtlNndjHXcaLu34RP5XJCQ9AUiTPprSMb/sm25PCj88ILvQsBRZ+/ca0CxaJ/6HktpvSICeJQK3182oC8HYg90mJGOonwNvvJOAdCsOzItoTCekp4ugXl2p3yg9XX1gOn4E3pOGpKK2MwyRBwYZlI8ng8wCEnvuuuiAvAZ+5mxAcxdn4wuzLiB3v47/Lxh0HIUrb3s3/8k06PuOYkLPYH+VEhfdj7kRL9SNoCpZJYq6zFrNgFwJjfqyV7yG0crTOLriMGV+jeaaWvJDPsBJuM/ewLEUwMWnOeFXE5HHD9JYa5agBZ+ObYTy5onA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(6133799003)(10067099003)(18002099003)(13003099007)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dQfLaJ1H0ckR/NdjJXUZytlbDtpoDbOJbH7zFU8ointJn+pu5pxu94C7xqtmnwC3HmRQf93GPieVpph75dqz4vRjo4A8kJ7fkB13MN9BuyWFxVo6wki6Za8nAj5Xl0OFvZfc9dxuJqSkRSJOdFBCOLu94KwUWrY4j3dgK+VkZ6cKjsmALeQB1bOm96NL/ol1ejqTHgIzmThmMO+T3jFfALO2KMZoY1SwgU+oSiElweyICAKzINTqZfi2GB/WogSswxF1mledfKF19lnyKyUYlolEdFC7EOMr0LHJvEiXcehlSYumYsjQBsQvonHro2LcqynnBiZpt0eFzPdmDdI+tWHoki663Mndp46nwLW7k2A17Tc7seiWODvNk7+V7EbhN/3LuPSFsSSYNzUPJ5myptuMZkrWttlnc0FrB0r5KT0Ar3/qJRmqyjYTev9kmSjl
X-Exchange-RoutingPolicyChecked:
	Fy1Yy6yvDxFDf0z5CxwmN0PcIiAGcV5TvpaTLmPQliGoCef+FqzmOMmjhG6S39LRN312MppxQ0dvx6XJI1WBNk5s9jm1J1ctxJJ0NMQ+QgJ5bQCkeoWOb/pOeSJYkmpzIQ/sNB0SEpTZD2zrrR+Qm36X1qqFDYpTj9xwHVfhF1xqbbf25iCI5sBTgpeVbbEh56zUyqiBesEgSbsaXpLTaZNb7+y0+TGd9F2esSpyx+s68Tzt040neHXqNkCy8Jj9itRKQOA1T1MQsFpDX8mW/o7KLqZAEourUSmqCYN3km2lU9EcWq/6VJ0jP2W01qwD5QmocSubDgojrEDwAHnt6w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:50:55.0538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba57eeaf-b063-4fd5-c659-08df1fd3c746
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4910
X-Proofpoint-GUID: 1uATb5hGQi06R98izaW2mjxGmH7EIJOq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MiBTYWx0ZWRfXzYgOQKvRJipl
 EHI5slc03tSkzucdvhZjjhYdDgjdzPXJyOirguzf0PgSwLeooGzsmm2JwsYWmpnlPtPWtqTatlm
 KYD7IqJetkg/5sbyOf85ydROcVtcTiKb7LvY718uWc1ztSInnOxz/BADRW+zL3kEiDDlnjNqdGJ
 6rAotaLF035dHxA3y09tpIANmMIJe92ebERFsqZr6+AA2RP0ybxHN1HNIJyKHVwtLO425YHYELU
 t2SBkGG49sqJwi8fEDpJ8amGh6zhFa/jPqhoUEc92Ny3ok0E8tf6zRKVbJ6PsnTbhckbvdcsFFj
 3PZIBZR+xl69Svp6ad1ozy97KQNzLfuyLiTrDgG3p/U0ta6OihADaz9XU2MPQ9R0bwSweiIF0E0
 pgu8/dXMKsdSuCH2Zj2l6v64weWoDQvEuahgLyFsn7XV6GxIlt7rFp3CkHfDyLBclXTpejtiMg4
 e9MEQwrfP/QVJyfzqew==
X-Authority-Analysis: v=2.4 cv=KvzYSmWN c=1 sm=1 tr=0 ts=6abe8163 cx=c_pps
 a=Qv0FdJiMAyQkWbHkl99ofg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=-Qphp7tN00GYOQeAMIMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1uATb5hGQi06R98izaW2mjxGmH7EIJOq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MiBTYWx0ZWRfX37KYXV7IyLTT
 Ijd5r4lCZ/5k7eBSdLuu7Pu80V/JY9e0aGTFyUv2tfoYB4h1pnLh2VaeiHDJtfdpA+Nou9DXbQZ
 J3EldkDZwyHqzSirNkQ1IYu7cN7W/Uw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010062

Add 'wakeup' pinctrl state to support separate pin wakeup
configurations for GPIO. Upon suspend the 'wakeup' pinctrl state is
chosen if it exists. On resume the 'default' pinctrl state is selected.
The 'wakeup' pinctrl state allows wakeup from low-power states if a
specific pin configuration is needed.

On TI K3 AM62 family of devices, the GPIO controller is turned off in
suspend to RAM states, so no interrupt can be received by the
controller. This prevents system wakeup from low-power states.
Alternatively, the pins can wakeup the system if a wakeup flag is set on
the pin by using pinctrl.

A corresponding device tree patch using the 'wakeup' pinctrl state can
be found under "arm64: dts: ti: k3-am62l3-evm: add wakeup-source for GPIO
button" [1].

Tested GPIO wakeup from suspend on AM62L EVM and AM62P EVM.

[1] https://lore.kernel.org/all/20260912-upstream-gpio-wakeup-dts-v1-1-2057d76c63aa@ti.com/

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v3:
- Propagate -EPROBE_DEFER from devm_pinctrl_get() in probe().
- Link to v2: https://lore.kernel.org/r/20260925-upstream-gpio-wakeup-v2-0-6c5533356246@ti.com

Changes in v2:
- Update gpio-keys dt bindings commit message for better explanation of
  wakeup state.
- Fix error pathways for if switching to the "wakeup" pinctrl state
  fails.
- Link to v1: https://lore.kernel.org/r/20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com

---
Kendall Willis (2):
      dt-bindings: input: gpio-keys: add pinctrl states
      Input: gpio-keys - support wakeup pinctrl state on suspend

 .../devicetree/bindings/input/gpio-keys.yaml       | 16 +++++++++++++++
 drivers/input/keyboard/gpio_keys.c                 | 24 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260904-upstream-gpio-wakeup-52a54080c948

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

