Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB63B52FB;
	Fri, 25 Sep 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373188; cv=fail; b=eUqg5JiiQMjcDF1pspHA61lN28rpoTw2lDnemJT9RCahglgbBqnVLARWV2y9r8PFiZ8jWBk4b/eMgTbe6y316f0ajKUUtCN7WfDVimPb2OYymKwHfUysKUfSwaAFUVpTRKwP2PdenMnGp4Gbxkzx4LHVrk8WRukF/6fmetOKpQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373188; c=relaxed/simple;
	bh=78+h8KeYCgiQg9Fjo6wdmq/WlOcVOXzO1ysS9J82u1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KsG6gbQ/JTyLT26vI0RzmEexhQ3Kr1d3hk1w1PmvFCKWI5VShEqesQdP3VJBpUyvXPWLTK/los6ab9OvNQf34a+bKqCWiSjaqVAgzCww/YqUbgden25mIxXuVYacofmZi9y6PijhCaB72DtrLjJuf4PPo5x7lqKLcmdg91unr1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GM/dVohe; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wyBrNB5H; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GM/dVohe";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wyBrNB5H"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68PJgeSI3099136;
	Fri, 25 Sep 2026 16:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNM
	CA=; b=GM/dVohequoVJK57mEwcV2Pv9rcvJ7W3GZ95qLjAzAIQ1nKx72OlSJMO6
	LANPgxazWEbIITCIXUnvBzu5rxZu1DFe0rsz+0Q5WdXulAcMX6yFpiYb+kPsLi9Y
	9+6wOtwsw64NAMnW7W4WRxz/OZV+sw6XIcZ1DT3Z1fyEaskhHLk7dgS9wMz0HSC1
	nj6BRHMkG8oCzXR+jHK32IBL7BcKhVvjorF+w945XvUMhYklF700QQa+mB54+RZE
	4dcLTVMjSEb23MiBlcYMYo18U04zmHS9J6qqeJnJ6jMIQurSTxQuqs0eLjZGGyJa
	JodzRe7LEE6iKnkfnSKRru5EDEeBw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gwybrgkd3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 16:53:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqLSo8qpS6aC5Ro6HAT+b0/xURO3oUUsfIzHUbKiCpKN13K6SGse2vT3gK7LKeagBlr82Jm0ySCNumj3/hk9uKXt4keYhVSWwMqrU+Q63YdTyGT/K51ff96p7FurFtVZRKNrOFGW0G21gW4jJErSh+CE31FV9J67bKg1aHLfLKMqoSSbhHJjS3xkxKNyWJp9ZSjQ1nzzsfE7vo2dthzvt0tDtYhAsLVfO+L2lbFM7mc6U1oSl7zeiZ9NEPe7b16BEP3xqCYYHvsqkWYmE7VPiwIbJE8LwVe2vT8XJUtQASGH5qO6TJmZxT22PQ0DUVMM5OkotF9k6t+OlBC5WLZ6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNMCA=;
 b=LihoJ5hCNFnkf+gfapwJ4w+cqEKBQXk2quqquJdKxCGAE8UcO7e0JEA2uK9gB62EoYALdJMhIYYOvCK1YhPugN8Jb5CCeFbgVH7PSaHpWerWtowGuQt4DQZeAM2D9PNODfIo+cvoQDwpipH9AY2XUGzBSCFOcdnmO99UgnEQaBJ3z94CFnXFvIul2LmaS0DrnKwh4TitnFmffyYJ7bIf5NtEFOTlqnrWg1+ENEZZe5lFtCjVU/DkKH045PxXO/jnkoQTyjyfqk0IgtGL4di/qCTSsieF5sIjHlxmfF3vD98kwuwb1hQjvAg4wNBexLVwd/6wghW+4m5WLh9cTup6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuXmF1DQwEy26wm6ceNGi3dY9dJNWSwuY+YXLGFNMCA=;
 b=wyBrNB5H24bgjbs/l4gjP4LtrUd8gYjHBJNrXJ7GLAhcPDQcFI97EgTzeb/B4etR27OZEXL5OttEbXpy/PEqE6WQzYQIloPZMvzIl7ro+2xFUaunjpjh687tjTs4ibfjaFAAwSzhbPm7RIisbWcclZlxWuMwbwlVRhCUtT5U8h8=
Received: from CH0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:610:e6::28)
 by DS3PR10MB233121.namprd10.prod.outlook.com (2603:10b6:8:610::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 25 Sep
 2026 21:52:59 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::29) by CH0PR03CA0293.outlook.office365.com
 (2603:10b6:610:e6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 21:52:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 21:52:59 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 16:52:41 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 16:52:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 16:52:40 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PLqe3q2596725;
	Fri, 25 Sep 2026 16:52:41 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Fri, 25 Sep 2026 16:52:38 -0500
Subject: [PATCH v2 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260925-upstream-gpio-wakeup-v2-1-6c5533356246@ti.com>
References: <20260925-upstream-gpio-wakeup-v2-0-6c5533356246@ti.com>
In-Reply-To: <20260925-upstream-gpio-wakeup-v2-0-6c5533356246@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790373161; l=2049;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=78+h8KeYCgiQg9Fjo6wdmq/WlOcVOXzO1ysS9J82u1s=;
 b=C5eHtcjZk6TVVRttmPFNVPl1X7P8317hqvqZK3/qpZAnnAlBZyYfD7yAgPeP98VY1Q03Sex9S
 z/p8wGySMC9D7IptHsX971Wd9gyRoR7BougA2nx/WCMsS5/GAENqqCR
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DS3PR10MB233121:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ac1dd2-f2f5-4c75-0b1e-08df1b4f5d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	Fq4/4DQp445N1Ymus9Km3AHzDH0bjbN5zztKgczTutj2yCCkaSQWVwE9+MoJE7G/ywYaUzXfxwv5R+hFpK5DP5H2M9EuP5D5gS2VViS1uWuliTiqdNUerjRew44wI3IGvegULHyPSSnzYF+8ac/ubU9peZh8c1K2xLtgEkS22bF+tE9c3v+X3SMmABHu6ox7gEhcwC/TaUop5eXVUf4DI2XELYjpf4llF8LOty+VewuNci/lIEglaF2zXJGiMmdjNVaRuKftdxTkDQPiZcY3RUSKvGR5R8qhjO/yBg9rKD/Ns9TJj/ui7Kn0DDe6lR0AR+pBdGmmP10e4RR/uJsEs0QbSXPJmAlT4PRDHeeuDkT4245LzTJ0KzhWU8fINUCCHFljZTYfYYgPgM/M1ZR0s0oKjoPxxlJySy6j2azILF767a2oDRBmgBvCwvdFnBmiYSWqdkggiNHgxdR6IO5WYFX5UaI30fB9fAngJOeKVDq2ruJHXH9Nz+O/Iq2HrnOXtNfvECl5XsEAQvJcOJHzaUnxrZC3ZazM1ccEH2vnT+Fby9bKMNpqJJt6qNfFv0USQSD8VCEDr9pab+XLCIfeTYSC0ZDByT5z+Js+hl4N33Ept6/EXfcKWtOvfV57qR/O0PySddX3z0P6t1Gr4DZ6vOt6hZ2rkf4blGNH34rZSvT+FqkjVFop0fbqZ7H1cQ4YYukzvKYAMSKXk5d/Lg7bRA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	71goNGp+BiVWBfFNTLF1aJTF26TX4ETSa/odK/QhQUi8+YxYXj7HpOsEz1ZcsS2w13C9HKj0CuNN3orhsuO2LraDtArYF9xzAoiLgOtS4rwyF8KG4pGPZLaafTUNviTPHlMTtW0iTlmx7/5GPu80C6thZbXIxY2ajU5Z/D5AK3PBsJn+2d/75z1YkJqbFRL9dzQYI3Mya8ytJiqsRIkDQRESv9ycv97YGPTIqQp2vjHaSyM1RO2wfZ1TRdHN8uRi66Xy2xezJi5rfFLQeL5Z3xlAqFyejg1ju4KM9e18gveGGrSlbZETX9B7r4HpenraKB+UUs87LODx97QB9zgKGuGqvLs2B2DesfNAC4/EPEA7Yquzw4aPTlru3x6x5npeJu+GJxCV9zByYRIsdXnIyZHcfzsyduBKPv4UuiKaxl/MZv3wBPOzCTcSunxN4fn0
X-Exchange-RoutingPolicyChecked:
	ttnpqJpXinbFOK10bC5gN2oQ3WK9sj+0Qk8zPRJGdyctrkroRnpxztuccocEiY4sZGSeWGSuStVCJk0XynX++Swj6FjAToVXK1yfl2MXrwN/Rj6wFF8AtdDbW0RM5BReo46ZyCZ+rWHp6UGfqREAh2+xOIr62TfRfkoSkfr/qGyfV+apDK6m8/psrkEMbJhA9lIDu0X2QoXGDy2iDRBvzCIosWj4iEo9NDPvXT3ju9gY6A8Y3+238jAYGlIooOpj1YZvAMe1OBF7HOUO4Jqn//73AW+l2Ffpxt/WtTYgZKIzM5NoN4L0B/oKKXuseFK0JijS221zipk7k3m1RafnDw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 21:52:59.5138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ac1dd2-f2f5-4c75-0b1e-08df1b4f5d93
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB233121
X-Authority-Analysis: v=2.4 cv=PMKaavqC c=1 sm=1 tr=0 ts=6ab6ed3d cx=c_pps
 a=NNTlVNVDZfSUkWkRvmJkNA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=sVqJxYME3hYzk5PecwcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oeFjrpVpaEe_WvA3VK4lWuRdAtag13bi
X-Proofpoint-GUID: oeFjrpVpaEe_WvA3VK4lWuRdAtag13bi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4NyBTYWx0ZWRfX6kK2VlyRD3J2
 IiTbas9r8OphvRT2T2iRtaaF4FNKBDmW5RhmMosg3Kbt3oGx50EWUkWmhglQ0rQDRZe4NreabHH
 2nIsGODPt7CBZUQjuZg4eg3FwJ2tbfE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4NyBTYWx0ZWRfX8KpUCTlUJemV
 mDiek1ZKp1PFLKn3b5YAxmRJtei8QrUwpYmYaF6aGG96flEztJ4E1Vr137Xrmr0Z902y19PRt/U
 n6A95iJEab21/ahPkuOq3phAwtC4Zp4z7SfiLxuwHEWaU59fYmzWBNqvDmAHaAu2vlSxxqT3wcB
 jlrM3lvVPyHGPC+/3TNQObqDQCaf+mYRHfxzSiRSS5XJ913p+q7x2YVJIMKKKWkNbrpq7zHFmgO
 7EKUS87HJGnwfIiTs0ZuzvYfOa+5GN8dgC4pxeYZeP4w1uyP/wfd/KSY0ozoFqb0pbLK+XzOYLv
 OuhPuWzp1yseONFhcxhmrfz2Bz09nc4zZkllVN2hnAxlH4gQfVcWI8w72Zrsp4w+rO4QMUdbOal
 bLzs2K+4FwRnNZA30asOWiXndPeZQYzMiyayoYC9bIO+2paeKNLCJWL3ptMpz1j9CphLy8Odhsr
 DqCq+fsWk+98iR3cZbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250087

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

