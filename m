Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7964318BB8;
	Mon,  5 Oct 2026 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233281; cv=fail; b=VKTxIiU0eHAs8rcQrn3oIGSHVeunzQkW2DLrsXQkNaY1V2G9VcHPbYBkTfdr/00k2ir1ZhwDFWnRaLZK2CE9yFO8DeUvXWrE3cYwGjZ3l8UvWkGwKEHAjKTvnb6LMa+Rx24ToQXcvl+fnjJNwWuxUILNhCLQ7r4md9IcrGX6afs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233281; c=relaxed/simple;
	bh=OCPqk/Tlyc/Uam4GuOTsoL9xMrArL7OijkPwVS+dNOY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=VT3xKF/psFoa9FHZyoAmAVhuSBrdcOF8ReV1A5QJHUfuB1KL7ILyyOCZ9g989KHsiYyk4FbsWEe20NZFM3/AS2P7Z7CPZ2BBGmkGccgTCg2A7ldtoHWyqe6998K12PftZxWFCfSMHYcQRMkCoZfXW0eRvgmtVGgo7czLSvyiVE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=YZ/m3Nw5; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=PCE/Irdi; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="YZ/m3Nw5";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="PCE/Irdi"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 695HKlju323185;
	Mon, 5 Oct 2026 15:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=WypiJL25aN+i/
	ttz9klmwFnzYs3zQ2wukax5WYhkUo0=; b=YZ/m3Nw5QDmdCFgvq0rDg0WPcrDfJ
	C3kEi9+RDLKI90xCQ534W71vJPgP4vCPAZejKv0AQNYDMnSQMa7TaLEX9XNc8Ke9
	a0hs47/qgPXdFK/2ODDMoZsIiD/BW8GEoIorrCGqQLx5A92A0Zrba7jVaKGcxLeq
	cIscoBhAu+xuPe5gcIN+oy6dDFTzkRgLZ+KVNsnC03hKCOGUQtZbKoaKpYhZeUHJ
	G+B14EoMVLHo4ecYjW+nvofQZL5JLFfTHr+rZe4tR6g2Ejh3riBw6CLUfMzNjseN
	iAWT2tJR2S+VqcdmMvlvcAmpPSV+zvdSS17wngmwF5XBymZCYDEgWB3cA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	by m0380145.ppops.net (PPS) with ESMTPS id 4h4d7dthme-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kV2z5o1R9QE+GArG1oovmpB/w53RHHfKqKz5O0Tlp9q3jMzmHRrFreWiHxQIknYL1pNFRCTjvUqjIyCmfsOKdEiXVoDdWCa80Yn5J6VnNHQjQ3Gx3Tp/dJx5ox597cH9up25A9v7g9kBIFTSJ4/X8GE90xbaLEGy9Bty+lif/jqS1xhM3lOm9JUJfejPCmPTO9wUbGfi6G21UY4sO/dS2ArMSM2EEHmJ5L5SRROpEspOul9d6JE5cpOIf8eAkI9PzBPPIDGu7tZUH4zaAal0OqO3gmmyIVRHaDi40j2WXkwS6ydVtatlOVgzniazRttzU4V87It7vWSMcIv9nvXEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WypiJL25aN+i/ttz9klmwFnzYs3zQ2wukax5WYhkUo0=;
 b=TUVjLTKeKzR9FOB+Dg81cgyOBSOkewmLjfVxbpx9QDOo+9ZiZD8MupKWW0/nhYGS7z0t9up1N4eH0txEi9260C9u7rsskKZEeiewAFekPZ0vCRxcsDhfYGabqBinmPa38LmnRbDLItgcE97V9BQXTW3qdnFkkCtZdgTxlc0AAs4sb9wJIwKqWyk6dtOt9bMM8AuHeaf3Uz9CZoUCv0khlsXGZC+VI9IJZ777zybCFJM1w37DeK5MEN7n/gOHPeibCbJN8JgUWUO1IVRocXNJ+NIS+7MLRHWar7UH4GHEN5nPIvMZGnmMD6PQcRVAqH1wqcYn0aIxUIoeKpeBXGNalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WypiJL25aN+i/ttz9klmwFnzYs3zQ2wukax5WYhkUo0=;
 b=PCE/Irdid0t08B7NIO6lm/v32ZCFi8kWd1DROu7B+GlQ528CoisezA9iFL343jNqYJgkXwSHVmUzoELXzamX+LemAlxi8ivERSq+i6Z+s4h05Bg9B48uaYQSOtmcrb+0dFSwvbs4igoVk815zMrYEbSrM20JOT6SORi4xb3uM0c=
Received: from PH7P220CA0142.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::12)
 by MN6PR10MB8165.namprd10.prod.outlook.com (2603:10b6:208:4fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 20:47:53 +0000
Received: from SJ1PEPF000037B5.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::f) by PH7P220CA0142.outlook.office365.com
 (2603:10b6:510:327::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 20:47:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000037B5.mail.protection.outlook.com (10.167.244.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 20:47:51 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 15:47:04 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 15:47:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 5 Oct 2026 15:47:04 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 695Kl493892360;
	Mon, 5 Oct 2026 15:47:04 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v4 0/2] Input: gpio-keys - support wakeup pinctrl state
Date: Mon, 5 Oct 2026 15:47:03 -0500
Message-ID: <20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcMxGoC/3XNQQrCMBCF4atI1kYmM0msrryHuIhxWoNoS9JWR
 Xp3U5GioMv/wXzzEIlj4CTWs4eI3IcU6ksOPZ8Jf3SXimU45BYIaGEFWnZNaiO7s6yaUMurO3H
 XSIPOaCjAr3Qh8mkTuQy3F7vd5T6G1Nbx/vrSq3F9gwp/g72SIEtghbrQ+4Lspg0LX5/FqPX4I
 aD5I2AWrDeGiIxF/S3QJCgA9UegUShp7w9MduloEoZheAKePLLhOQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791233224; l=2144;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=OCPqk/Tlyc/Uam4GuOTsoL9xMrArL7OijkPwVS+dNOY=;
 b=XmyAEhkLAwfJqO7ws8t6m7O4MuOb9i7We6BLQC64xXvGsM5WXqUZAl8dUut/72Y4dB5Hm7V4x
 JQeFX1Gv3S1BBZIO97v447Q3MbwNQNsyzMUCrrJJxho4F/B+tH7p/Ym
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B5:EE_|MN6PR10MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 863b5887-3c20-4c8d-67ef-08df2321ec84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|56012099006|260925021911599003|260925021311599003|260925022911599003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	bLkzsQFfrq+o5PExI5IXtkTYIqHmr3Xmnp9H+akjHrNhC7LSQxTlKVbGt5efVulS9Sk7WMmMlhIxhbMJsZe5QocwWxczzwng1ZJZ+bF/XIwR5KOe8IKsh29150n4JBN0qO4ir7iuuv8ERM5JclTaoc4sWy5Lr1qNITOFUCBnplBWeyFf219+aYF9m+0Z4A3cCPVhcdYV7Dmyo/Wc8ADofmv1rRK1u0T5Ktrq+CqJ41l7MmsUpmeuTbu6yR8v5l4ROKu5Qt2ycEoqLnXP6o0ApIzUk6VXiVPKVvxPIkeILei83pv2354og5PRj3o/ltwqbWHi1aZyJ2h9yYHJ1DXho9a8GQRM9EmP5RBr0oaoWq+UTFw8SkOwOPJoiP/RdgYVTvzRigQxdOzedH8bVh3XyvM8yLcCHaKGTtOWuvg7u0b7YOcknrk7nHbcdsf9Gn2EN+Lf3gM04rIviEqVw66LW9Mle9LSezlFrIfcFUz3y/lbXNQW6tcr4J2uuremS1JDijdCxtFyyW7SUlCWxsDHRnkpk0CR/7lRg9W/cjGr1Dia3LKcajI5QzMFcShhA+2ZfS36wdgkIhr/dHIqObqTF1yD7nb9nhuUTYSY4oNQZS5ScsohW1wjdZpw18N09GT+30fDwPLOwAqXOOS5jPYFX+JvwCrM0mFauljJZIDwN0+WT1NSFKUduoM2tuUi1PE+XkV0O8hkJoxwSoW5LkWEJg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w2HjI3kyRYujWFZvX2uIN2YGixCncS6lx+tQ4QMN+MweEqsJYwmldrWffOTilTXSBieWPKTzKQoSdOsGOmWYpISiTBPWXU+6DjMxTkf3YF/J5jH7Gd4R1DKivAp9Gahp3n3Q2cK9p12VCWrnMM4tLwuE8ljMpjAnd3rEOcSgJ+gRy30mIwwwzlXN1xivPj0bBIncmIXXZdJCRJ05RKxvqyQcZzAl5Jfu0i0WuPa6tpz26K1Di+XmG7dldC8uE08E4urZ+hJD3sC/hGb3gMGnDuYgzj6qlcfVJ1DmO/k1C4dMzYKQNKVg3BdULcm0scL4mH2JugfQha7J0LyAnxw1VxDY+F00GZv1XYpArZ1GNzblBr+Gu3q7DaU7sJGPnOHHCSHcD00i97YwqklHdzyf7m0ZYCEAXB4cKspXJkLcq0UbC1bioycJgFN0i8AcbquO
X-Exchange-RoutingPolicyChecked:
	aQkDUGUi5EnIb5/HX3I55Use97FWEl5KcgMP5H0sMX0LW8dTawyOUUh1Ke8ArYAB/Ohl2dGmIWeLSJHoQegjJ/ayuiczNEy3G7Nwx3zxzgFIRP0A5LpLeJFu2oo5nwnxqNfpRDs0191vSYr32FYlG+hbDf5y23avad3JgNEJxFoaK8mh8/Wp84xudiGwmcC/VP0jPsn0/UbkrJoOwuKLaaiGJL93MGI5Yj4r00g7D/CWEvMkBqMSXR2TxxhfT7qwfZBGBnycnHuIk6t2fMXiYOfwplgVjiN9YJBqIbUZ5CHRyx3WwHNj1crEh1ryaWnYRYLeETnhLoUcPAS68hgKdQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 20:47:51.7485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 863b5887-3c20-4c8d-67ef-08df2321ec84
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8165
X-Authority-Analysis: v=2.4 cv=AMeVrcbb c=1 sm=1 tr=0 ts=6ac40cfc cx=c_pps
 a=N7UEZcGu6nKKiVkixTDHSg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=PNN4_0-CexN-1qqvoMQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX+op9d6nKJ19K
 80O9XdOWbV+EEc+iYmdNA2pXbUZ/N5RcLyrYRXgG5FXpZt0qC5q8Ot9abgK3iYKeonQiJ+iSE02
 2BSCZQ7UG22udygvlFm1+0goAIlEaoY=
X-Proofpoint-ORIG-GUID: 7f3Q1_cSEM0Jpa_E7P4t2-TE0PQxsiOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfXzgROk6ZbhRNO
 BMYXtQiNSyHxs5blOBr1E8teh495iW7/QfzfJU7UYs/h837LdEoXfg6joMn2YUJiQqSudKH5pj7
 bdK0s2Ik/Hg8Gzd8JF/szXvJIn3Ei4uAIz6Nu7DkJiOaFqJ0OmJtTs6+V6qRf40Afdjmj79gDIr
 z74ClgCit9XH3f2DSNICr93vuk0J6y1fbQgJYtju26bglYGPBbYhgvUNF50eWPEsPoU2RiF+9D1
 Sooi/lVeI+UnAwF4qoVEpRJT8rGHrNVGO3EIrQiOHZKRRSt/qkFMhzPQWufDafyozGvtafzGWDO
 AdEJeZi9t+FxO3Uztyx6zf3t6o3jDuSJv/nZDFVJr8I1Dy8OIuR8+Yock9TaFR9ulouc3ejSfCj
 UiUAkRhayRENzyEEqw9i2jxFiSAQ9JXjXsxkPGTChoCxB7R3uYJPfo2C9RDg0MBBThh5SKC2fTE
 pYkt+heXwUNfgnFkMBA==
X-Proofpoint-GUID: 7f3Q1_cSEM0Jpa_E7P4t2-TE0PQxsiOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050081

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
Changes in v4:
- Propagate all errors but -ENODEV from devm_pinctrl_get() in probe().
- Link to v3: https://lore.kernel.org/r/20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com

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

 .../devicetree/bindings/input/gpio-keys.yaml       | 16 +++++++++++++
 drivers/input/keyboard/gpio_keys.c                 | 26 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260904-upstream-gpio-wakeup-52a54080c948

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

