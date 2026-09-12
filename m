Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DB2C21E8;
	Sat, 12 Sep 2026 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248847; cv=fail; b=ohcswXYt69KkHi/nQzNKq5A475SZDr2SHhh6k2qSBWt+jfsgPKorRGjkDdYCmN2Bh62UxqDcSbzdwpdvlDY7BOkutVgY5zLaloUsq1Kg+NzRVtiNAgy2F2CGL3K1Hoq6Vv3gIGSWy+UQoFxIvMkQ96L+FIe5C8QDLiPWeNUNHPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248847; c=relaxed/simple;
	bh=VcCbu/2jndcU5mnCil2r/RGsgAvWWLA6vdgTYsDnhXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BjJ+VuK3OaXLTgOGaerIroRT/3M11ZBBvxjPdDObaEJICpBfZzFjQ3f1aUobnX1MTm2wxiW9u6HgxF7Ax6kkYaMsVip9Gteudvqeelq7Ze1eWmqAbVp+wO0Tx6/TuBnLj6WJJIMQ2PB0kqRD22+EZl6ULLXAh+uI5EXkOftjsZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=CNvAkNAM; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qFrcspYE; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="CNvAkNAM";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qFrcspYE"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68CI1XfY1114444;
	Sat, 12 Sep 2026 16:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=nSwhFpcUcpfjcYmg0lOsNX56rj24Bf6u6h773+qPA
	BY=; b=CNvAkNAM1zFtXFr9GR+m8VViivYVJFErIesCXrN1UmoalJ4CrDumKG3g2
	SDBG9S7NPuM21uxrhUY2W6pFFLsOmZHXJ3iHBQDahcihcmFK+GWcE0JNlkTEv88O
	2+6T7S0gaA7mJa2exATSUD7oxTBGhZYusbBwHpsKiNXLTnTDoX7NCKJsnfFCAjGU
	R7WgcIufOjFgURXYpsu+NkwtJYLFPZQrezTlgJu8nnwbNPZeE1Tkdux+EraKt/X/
	bPs3onHm3eIqbMyecsgn39hjSlDu7FDfsi7iA2mzxYXg4dtPBrp0GT2cjcNQkqZT
	tgcgJ/ZBUzIXFszdghE0J2jIFOvbg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gmy6f359h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 16:34:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqXOGLaVb+PA0SxVnB5Vym4dmz8/xigyiMicLZyEF2MS3NRLaNDn0tmCFBoSh95HXBkKsXP0QVGpgnH0exeBN9k4a0KBwjdmsB9cHHoX8z7HPgC48SVq/ldPr7Jkab73OBv0rcu3S8/NIz5tn+lrT4r019BwF26vsz44LaWSTGNwH0KDPPiD0kXeLfwYzOSiNLw4VfBE0zXbWTmyyo7t1amlA+jk0XPhoHlOm2CZ40z/B7k9F53w+FqMAODzZGMDQfrSZ5V1VmcrL9omnUDSxZePsBoZd69XM0/WbzozSdG1k2o8lwxstmX3cwgyekcvXmDPkSyBcbv7yWFS5R5v/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSwhFpcUcpfjcYmg0lOsNX56rj24Bf6u6h773+qPABY=;
 b=KzPWlfgguUGQT+J3lsfEBHPAuiMkppGnpTIk1daErwRPden60817WFLuv5eb+Ri90sEpZK4V5G1q8hyMe37aAMTp9Rk5bt00/MyI/EEVEG3uz4DCYwO5cLg2s8lOetZl+dp97wUb99s02dqCZRBfOXlJdc0Gpmm0SOjKICHCPDxDnA9wvv1tFLLs9JVIfA1otjUXHGZu6vfTfCpM16uOsBVwDdbrAfKudN87VSwy63hFMJLuev0YgynYju8zadLG4ovixVqDAmFEgLnBnZFmjSBKMlcO00KxXnuCT2++na0Cx7+1agICJoPQ80Y6tSco0amvoUwzQ+xVJ2mGh4fwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSwhFpcUcpfjcYmg0lOsNX56rj24Bf6u6h773+qPABY=;
 b=qFrcspYEqkxhv7UpOB6WUClMV+gO5L57Z92duMzMD/6W620D9kp/UNfUBHDwmev/e3g4tIfXDTkhHK/8gyk9jBlYm2QV+Hu5vYyghgdPc3IssU7Iwaiud2R9ed9It3Tq+hob2QS3guG9G0xc9FkF1Sh4wQ+PzAs2uQerj7jZHeY=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Sat, 12 Sep
 2026 21:33:58 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::66) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Sat, 12
 Sep 2026 21:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Sat, 12 Sep 2026 21:33:58 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:33:57 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:33:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 12 Sep 2026 16:33:57 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68CLXvl12513366;
	Sat, 12 Sep 2026 16:33:57 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Sat, 12 Sep 2026 16:33:53 -0500
Subject: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
In-Reply-To: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789248837; l=1434;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=VcCbu/2jndcU5mnCil2r/RGsgAvWWLA6vdgTYsDnhXg=;
 b=D7wbwofFsopR9PMcxT7MZkNzKKiLAT6zDln8PdRsvjXMLDrECs4BmwRK9aw9JMJg1jSgd8DGR
 PDRlMtPAADkBMQJYPC+r13tY2uaKjAa1Lno1t+TrXXc56CFkKCfc9QD
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CH0PR10MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: f00641b0-7984-48cc-1064-08df11158def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BUIwGvKAqjYunyv9At5tNImp9wkoprmK8+reWsBmYq+uA+lmENpul63KETYdmtj1O7qbjafQdSqWyvIQfIh8fL59mUbE4zg8Z/z7OhQODNXzD+ZP0WTX0o9XkB6qEwe59hAOlvSjSzc/LfohKVDaJ21afEEAVtA33P8FyaKzms8HAXrFPOS8T+v86yPTTeadS5sIfOmSc5S0pwQREagwWDSQQCl5uAJJbwCxNX5sVwgGaXrtJvF/rwpqQhW0rxl0el8m2jL0oTy3BDbi1sKoEvgw4mwJCn5Pf8TZ7mEHZ+3eEepdLeJEjOIKXTt1wHgwOzPtEu/POqW5TRzw7H1JV7L6Ny62TjUKpysMDzzphNkyDj4iZcdtKpLPZXFHiOV7diegW5x8qy9LvB4Mb3z4aqDa2EU2Sp26GTzH+GjBK/SauXUZul7BEAbJK3uRNL7RmWh3h0w3FnIRh9/tqGLO+/8Umr17qfx/uIyvhKzv7twrh/2XIZ8/kroty7OnKgWdobUlL2JEmA4SngiCffd+2NOsDqzc+s4Hic9QpblExL2sMSoT/5vyhOqD58Me0zjMtGpKzgWyvUizN5ksO6IcQRprENVlJVVHtalISga3u6WHyyqiEiGrftrY+9eQmcBj7AvOqt2974UIQqjTMpLK14Pf8znrD0iqeSiQzPD9Sp9b3TITKqL1v30WOny+PHWVQIDe5xALkkIvRLLubmQ03Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JrTpkM14pX9eMcYG/FHUtAykjjMfA4EP0Jgsn6lNR55Gxna3De0jGaLbZi05sgRo1bX3vp++rDil9d0FY4tiCnPT8mXT3uiQ3F2oiNI97/WAVFhqWs+ryLzvzd+CC0QiXMG/GGSEtPkerneGOAPV5oE8kx1tYeJvEfCLK4MoS/weG3cPhtgPRG4NFl7nhgKVp4WVQWIMso3AqYa7sfqEyNanzSUynLBGvpIRlSFiIqdn4Xbox7Hve4x8mczLDD6mcpJODC2kr2psuqMHJBEAuXqnSC33/IiFwdxF0x/NFhW3fjcSI76w958scEx88b+FLbJrNPNkOGTUDx0KcjLnO/zxlCp+xJmbZLE4K57PRAAzJCByRZWq2b/niqunm71f72jQb5VZBgzbJHjVylp3ifUFMzZBPf0d7vJiB1BpMi/GMzOFCyUQJFCOKK5+DNFc
X-Exchange-RoutingPolicyChecked:
	WKFSReClAzsNubnucMpv+d2Mze+JvfcyjkI66aXKkkOuYbLTt5Q0zS1z+8ZG3XBIdan5tATT1ynlyL4NOMsVrakTmHQoQHLj2RflS8ndQtv0wOQpT8mSu/1CB4LAWdwm80xZ3T0Sa1d4QdSn2OqVqyhaNJSh6PoObyCGuVzyv/uVHRfFzZgmrDoNtdmANG07+JgmEuwsYoDjReS4oslM8J9D2y+KuwyUsYfBy7p0jb359oVffzUDyGdnopchxZmpnrvbm2+va32FHiARM8HlOXWea/tIwV9N8RdDQN0H4haU0JhCeJYLizadoX7juUlXcKeFk/ixfU4T+xv7AJ8q3w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 21:33:58.1930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f00641b0-7984-48cc-1064-08df11158def
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxNCBTYWx0ZWRfX4xDClU2vLpUb
 gLRrUkw3HbqHs18IRFQyZ7xUQXs1G8brIXBIw2vCqgrAj8a0uZHEc/1+6AVpAvuxUktgWzBOSxy
 2Jm1l8CozXBGwjYqqU+l7i4uvLz7+lyd9dJjy0/pbGwsPL4y02qJmNq4jDJnuRzJq/Gv9n3oSXz
 eGQAvk2wtycBu9mqDQ983FlmxOkE2fKn+vpaA3LAJ+PiaszqQl/2TKWKEzB2oKgh2GP/Fb0Rt5S
 +gZC+/ghuAFGX2Sh4uKnxuRklsIzLU4x6ih7N7V/rOlO4p2Qm1JNn+Tf4PAIu4TZH4JXLSkGhsG
 Ql3RnIL0/Y+iRWaDd62cNVc60G7UWrEgfFGt/XDH0uADSyqwV07rPvWwih9biRctgKLyBrPswPB
 ttckRf8UWyNxiVI0mlZ2T8IBkbZYTiYkubqBAtHBH67FGXzWM6iDRVPzZBAmE0HBeVF87x2lB2H
 7ggWT9K17KG+1n8pKrQ==
X-Authority-Analysis: v=2.4 cv=XpxvqlF9 c=1 sm=1 tr=0 ts=6aa5c54a cx=c_pps
 a=up4QpmAGzzRqrgyk5KT4IA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=aVAU5thMVh9tkDM1sQYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxNCBTYWx0ZWRfX8HXAF/QtTt6o
 siCCJsG8vD0hSNPR8FGXhHNAPUUnZk+2nEKp8cLlxyPCbM6pzyqEtPxeMXELPctbO1vuTKiPqXD
 fB72CGR7A07YUhI0jORP4Q1ZaWpjB7Y=
X-Proofpoint-GUID: 1OkzXjfc_TiE-7rFb5ndeIEsfRx1huH2
X-Proofpoint-ORIG-GUID: 1OkzXjfc_TiE-7rFb5ndeIEsfRx1huH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120314

Document pinctrl properties on the gpio-keys device node. By using the
wakeup pinctrl state, the pins are able to wakeup the system from a
low-power state. The default pinctrl state describes the default pin
configuration.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
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
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
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

