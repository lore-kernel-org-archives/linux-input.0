Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794947904;
	b=sCPIdJrxS7HeJTZo/EuahZh7gs15AVpveRLsOYekgAPbqP4ChVxWvEhYhe3h2Jfvy6Yw
	 TDk6Z9kBSZrwVebuIs/PZeovTQTNjrxy8xlxoGAAqpSObxcAtWnwfOHAJ7xbox4ChYZGq
	 1CtUHd82z+pS3nLgWSmp50zKqXVxGKTW2RNs5axNBeZK8b1SwiWhTT2lGangmng1/khTD
	 AZfZGl6aODnASQ5a3GM3P0jteBGjmDythuz69HCmqNJfavsH6gxSxJ4+YMrQbO10dWVT3
	 t45lRs3LEq3/JRfKyFgraza3fnmu4IG690cn5Eb3szBHPtkWNodEVh+blgvtOBJ4nOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947904;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OVJCv5IL+3+8bqjX6P4A7yL1nftjASslWZTEUVU+CJ4=;
	b=mWbxUUKfWZlVtjH11sf8ka+S/ywZp8a/pKK8ythjN1LQ0y+66ItYM+tRMbfMnnlduGVy
	 sXH2RRGCdg+memT1xNEn11lW9BMlvbNMGzS4C2zQbjPI4w8Y1Iba3qRTLo9Hv6w1hLZuY
	 /p2JA3oAe6jVb8OCBpv15yvHlhzUxaKi18humQZszWMgxLQNvDVMxtF1Uv+HFCV3cw7ro
	 rg+hTDhOAFYRvjrOE1mkPMH82SlsQHcUzatunLno4fQ2hadUJF5j0kTV/tP2KfrvUT3pJ
	 Dv1CfZhOy1Vc1UFktR4rg+mPgL4Do3lERtTDPTqAPdOpgWDCYHfWstIjDEoA1McLUZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=R3lkPJDj;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Mbo2p095;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB97606A32C;
	Tue, 17 Nov 2026 20:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFB97606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=R3lkPJDj;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Mbo2p095
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AHKM6Go786274;
	Tue, 17 Nov 2026 14:38:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=OVJCv5IL+3+8bqjX6P4A7yL1nftjASslWZTEUVU+C
	J4=; b=R3lkPJDj9JdzXUtSdTADW/4dY8Jx4V+cho00rNuloSL33cO2uzh8z6CLY
	aI0Mb/dGwCll2hiCnUi6ns3Wgkx9aJJanha4UP6TGiA00h4ml5zQzKPuzeJUIjT5
	jEaAYc3vOtTm0kY3ONZl5Cpd0OBjMg3nqn55yBTVHuHT810X/GQ1UbcFl7bWgn9r
	YiOCRr58a+QbL2ywva2w2rIDTYJQR+zYimcGUlgXPhCl65l15Xsqu53000blszHE
	lhmDSZjIVm961mY8nCYkPvPvFOX/hfwe683aXBGs6FkcV0P3GFwYaRedz+d+HU5Y
	9Mxwrpf8iNL+yc2Ygd/zEfpOurc+g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	by m0380145.ppops.net (PPS) with ESMTPS id 4j0kye41r7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 14:38:13 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwegS1spTfSsXEsS1QDYE0HWd6Z2/+ruG4QyfvBwOgcEMecMA45YeCkHuwty5ZkfNHFwqSaI5y0OF6kIQe0msNiCN03/yzeyEz9lLNCNuTkF+08MMiQVJD8QR74oSKGZWgqV6VO2tg0WWvpJcnq3xaNDUQowCkygz+dXr6Q8Opt3uJUS7mXtTIv08iX98JSz9DdPmiUiKK/DJtNp+QZU4eQu2g+xrUVCXFxJqsW8rMqlaygtcvIwols6uo4xg2lC8elfhrE9Eb9L2kbc5pTqGjbe3040Dpxu2eVRXLWvhITDooo67Ny41zkGtvrW1CngUefXxOKGbnptYQTMC48c2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVJCv5IL+3+8bqjX6P4A7yL1nftjASslWZTEUVU+CJ4=;
 b=IKVfjrwx/BKcjdq3g7BaBc8zcoVE7WQ6mzClDXRcvPPjIYQmrLvnT5HsSgaGXQW1+qkJu/vWxGyjglHUYufuZL1wLQLEdj8s3XRdRr15QCp7PQlKFF2IXZabWC/QnPf0L2/yDwaL1yv5TBWs62VyGU9U2utQjtACNGvbKkXsCpw9cWzQFxYlOU5s5tDuf7Q/KGmjJgGrVxXIgCOhw8Nv68uk1SsyJLQfAirBYGUZ46HFj31iSICbY1sFwwPTiRxv6JH4XfISkitDGe4uMhsdhn+TjGZt9uJmD0tv8sqmwL3bYJq5Oj5YT3DXe/+njfflKxGT5EGzY8QYdH+97wldUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=dolcini.it smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVJCv5IL+3+8bqjX6P4A7yL1nftjASslWZTEUVU+CJ4=;
 b=Mbo2p095ZCzXNL+nhOzu1UHU86+KTgrwH6qCQyCoJOw+2LSYnepBIDFg/BZwPd/Nh5kRsZZuI1mHLwifurkDlFTyWnAJDL2kW5WwH1kyIMRX9+72dSFQyv+O5OS3IxI6jZDR1pATlXXSJdttr72W2bPj5LK0UW8ue1VfnUT32/s=
Received: from MW4PR04CA0199.namprd04.prod.outlook.com (2603:10b6:303:86::24)
 by DSVPR10MB244415.namprd10.prod.outlook.com (2603:10b6:8:37a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 20:38:11 +0000
Received: from CO1PEPF0001885C.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::21) by MW4PR04CA0199.outlook.office365.com
 (2603:10b6:303:86::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 20:38:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF0001885C.mail.protection.outlook.com (10.167.249.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 20:38:10 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 14:37:43 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 14:37:43 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 14:37:43 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AHKbe3V498237;
	Tue, 17 Nov 2026 14:37:42 -0600
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 17 Nov 2026 14:37:27 -0600
Subject: [PATCH v5 2/2] Input: gpio-keys - support wakeup pinctrl state on
 suspend
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-upstream-gpio-wakeup-v5-2-0e10aa2f7c1e@ti.com>
References: <20261117-upstream-gpio-wakeup-v5-0-0e10aa2f7c1e@ti.com>
In-Reply-To: <20261117-upstream-gpio-wakeup-v5-0-0e10aa2f7c1e@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <francesco@dolcini.it>, <msp@baylibre.com>, <s-kochidanadu@ti.com>,
        <a-kaur@ti.com>, <s-tripathi1@ti.com>, <vishalm@ti.com>,
        <k-willis@ti.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794947860; l=2985;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=CZ90YrEMk+EFYbLuGgGO5n1pj9c7obOYYCx7f5q/glw=;
 b=XDDmdAR5rXXMqNZr62OB8bA6UIruxVCnX2HkUGCTWrTUBXfOXwP/y02i6qtgS6OF2j1RaZFl1
 tzHTKizxQpTBxf+4S4GeVrg9UPKLykBS5RfnNJ+JNINknpjpztorEKO
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885C:EE_|DSVPR10MB244415:EE_
X-MS-Office365-Filtering-Correlation-Id: d1528222-2761-49a5-94ab-08df44eab1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	T0VmA2aVXe3PMCjqJcTBndLgw3VNdGJEiiYcxAN0IRjg1Fy4FLVCiE0PhDk9QDMRhBqlcc4UqJ5QkIxgH+sd2NsxVfMnVx87hyeaVQSYUmMWrkih2cvaXGpTurhO65I3SAFc/uoO8w/zMkINVl94N/6tuvlA7AbltIdPkG+iayz2BF0s9vDKFZn61t3xZ3ICxURuAnwSTcaRAqY2o5OlfInnLIWJuEWSNE3yOEI8vy/Egw6YXn0sjxLypOdx6b7sj+figHz/A6TounGzajasSXZeXaWbD8f9fYX0IRFxeFcumOq+ssvZNbmiGK0NjyUK6xFmKHXXYLobmtSpTT4001m2XNxhJgWnbxM1jlq4gBGsC2tnur/kcX702Kh4p/RjVsBM6I20+2K9iDYvV6J5kHpemEQao67kFRHHeKrtew8gnFC9bWetktmzrb9YM9cfpsdwUSVfE/P/HK9cmkgcLARdnlQbvGlDsX3oBZ5ueS7hbMcmP5Os0GZYS0g9rfn1xZ7YnfLKaLHxazU1pFv4wZV5cEm+Gb0suAHYl7Icad67P+aJ8YlQ7NmNmkG53/ClENsvvzunelzlTaHoBxLBiqNnwYlKygGL2NRBI7qRfWWlRPdJk5w+JNFhM8BiA48d1YEmrwZloQRNBTqXMRZFmqyIiYGY5HVJX7YAzL7ntYFyJL5hIAavLiFNu7fNiRRVWIs9PhM1UsyMhA+TXf11Bg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TPeHwwTrqu/19fCE+MQZ+GhQeTxOZZrsPMMhcDgcm49rL7h/szZ8JjLIOCvFtrvCCmSVgQNtbdsh8UaLXRdptBBcrsxVXIwQDl3ql8RDK+ux0mr8l7tTYkRm8ZPWygx6PATq3YFWzSbzokgu45pcjLBc800c0z+eR4OtE/k1F8po6KpqFC82lWzxuBYOlnFAXggkR1DLOIq2IBKt03Tj0xwbvXNPFk5i9Ic1Nd6Y5uhRVk7bWLW1BN/bHCKGvELwiSnbLTozOJ3PQUQswLSNixPeOgXWNL0FW6GE9tEO1wT+WkFc2y1JjYaAmiKjyplIRWomftSqVaqCpti/saw65/ih8iTBpycsOpX3oa9UojdO9et0oa/1+0tbCiXRHcNieelz+3D+vTp++7q6RRrVtog3IUTTCiYaZohLTQm5t/iEB3KDyJOyuhGZIFDJRHKA
X-Exchange-RoutingPolicyChecked:
	jAfAo9asZffDwE3Rds7juY/em6jcl9Wwp2XO4Ee5EFqxXG+VXOJJMP85EGUI5eJvxVlcGnIbTRepq5mBjggYFYg5CN4qxZ7Eb8RwgPnSbLbp+SgdoXaHSX1FJheIJaZNHsPV0R0NTUMO20AYr070KHHScxpNtfOeQqTOtO8nbQqVP2/rhEcNNXlUNMaXZyc0qdLUjn+B+p9rGvUX0bxpQ1AI/vrdA9/ZfRshaYhaOGSIftXE1Y59xy/ZzMdNvb7N/E++v/cCff9aY8fR3kH59fEJ77RO+BFmTPt532ROE0W4hqXvp/NiMPRuMPcV5QlyC2IHD5uocliXE+GUlHJDQA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 20:38:10.3060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1528222-2761-49a5-94ab-08df44eab1b4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB244415
X-Authority-Analysis: v=2.4 cv=bsTZl0ai c=1 sm=1 tr=0 ts=6afcbb35 cx=c_pps
 a=GhmtI3pHzNGJg3++3mR9yA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=IpJZQVW2AAAA:8
 a=sozttTNsAAAA:8 a=OP4iwnenC8Is5NdNPIcA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: gt-yTkt40Nz-DVYPITO1RfYtkGoiWXP9
X-Proofpoint-ORIG-GUID: gt-yTkt40Nz-DVYPITO1RfYtkGoiWXP9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4MiBTYWx0ZWRfX/NeYAcx9xrd8
 eiHcl3XvPm5JtKbgW7uVqQmSHkb1AKN06JvoQL1PuNunDq62NSs7PXlk0b8XUrXig4BWdQyiIvZ
 xXZr+QZqvKHiAo5IvXoG1xGwgtbkjilJrxTreLwIHVJ0DHJAcxDexDLV6Oq0amDV/PFInyHN66E
 a5q3RoCykKFF1XFFWnlS7ZRA/Ty8pL+ZpeF0sdg+9geXmcIHpqhMqz8uExgjEEJK7uHTrZpKV52
 NcjVSQyJul4nR7M3wobtGxnmbw31iTpJPxfEQK3pE26z7H/a0gkvg6O2U7Kcgb9utbYANOLqaPO
 XZaecfNIen+U1DDNSBG0pf8iP+k2R635wffX6HIvOXzse3+ClHeEhwEk0dy50A32JLPQYyqAgmI
 XlRmO4tKGNAkRrcTZdN1FjT5GUrYyi0YcQOFDQmsOX/fTspRQHeDIt2v5DDXYEDQQRt5L464RVk
 7agqiRNYJ6UZYWZONwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4MiBTYWx0ZWRfXzaKbL5Ssabkh
 YVqFnZssMyfX1UnKInqst268cnx4Fbv06ZSO9tSt8VDjGHkHPuzLHSAZECfRJ3BpcTQO0o3d/uf
 hP0o43gHeOU+edIStwiSHpKhhNhDiyw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170082

GPIO can be used as a wakeup source for TI K3 AM62 devices during
suspend to RAM states. The GPIO controller is powered off in these
states, so a wakeup enable flag must be set on the GPIO pin in the
pinctrl in order to allow wakeup.

If the device is wakeup enabled, select the wakeup pinctrl state on
suspend and restore the default pinctrl state on resume.

Reviewed-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/input/keyboard/gpio_keys.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 661f2da6054b37a752c20afa567fb37f05576237..685be35b09a9e99b2f20f4707fe0c3e50e152aff 100644
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
 
@@ -882,6 +885,17 @@ static int gpio_keys_probe(struct platform_device *pdev)
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
 	input->open = gpio_keys_open;
@@ -1007,6 +1021,12 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
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
@@ -1020,6 +1040,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
 	return 0;
 
 err_out:
+	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
+		pinctrl_pm_select_default_state(ddata->input->dev.parent);
+
 	while (i--) {
 		bdata = &ddata->data[i];
 		if (bdata->button->wakeup)
@@ -1036,6 +1059,9 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata *ddata)
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

