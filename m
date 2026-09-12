Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737E36402E;
	Sat, 12 Sep 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248860; cv=fail; b=Z/F9tyGGfWwh+0EZVjrXRTI3S90HGdA3NZquVcMQTvYymZFfu1FkYnxF+KV2YF5nAVMV/mdktlzE7MKIMzFsHDE1P+T8bd7ZXKbTW+/q09I4dmoGxIwo98LZDKOaGZdyKw2BVOlb1keD4zQwh6dpJwE8n8UeFRijpl+oHs/HQuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248860; c=relaxed/simple;
	bh=WH6cKY29IhZqNh+s6SLzQrdhIzAMlSwmmmaW3xwQM4I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=r699RuDZdMirwLV9EcSviKexXEtxGWuYbD6Fxzr9yHqd26hkFf71s3iFBr9xeRU0ZfBD0OcEpIzHr66m642dUxfyHKeCuxFcBSsnXjIlV+ne8VS5MIAYyS/jhc97mZOx9lvCIGMYr0mrb+Yd2v3WZn6i3tYYZ0Uoy/5GkMyolSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Sh9AqtXv; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SMILyFUk; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Sh9AqtXv";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SMILyFUk"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68CI1SQw901975;
	Sat, 12 Sep 2026 16:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=LVzf3p0Pjf76k
	7pyGIIpemuqfNZ40V1tWNgOZrJLtg4=; b=Sh9AqtXv6eZGGK6pK3U9KAKI/3dIp
	2u1uTxI27gEJxJWHAsd+Rc2n/Hy0BPHyGzePB0rJk5fOpjg+bX1d3it5QJvT2DCf
	h5A7QbP8KhGOsZd6IJBdOHHH0GZjmPx4TbUCSNFk7kSxHeLicW+Bz051sE6Aai2H
	89Id1kKGbxEqBiaqjUZXs0XCE1gLfQzlnFTw+cdhdLWvm2/d37dbu/nXFqnaJgtA
	Zb2cANZR3gafK1XUqyOnMjA+kHClom1+zqEEjQCiFco5nRA3neNTCyqd3HitQPvr
	7241emSCowp9eOp1oKL6Azh6VtE1PFpOTIM88+hps51NpRyJh4Ch+mN/g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gmy7au4cs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 16:34:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ProDFAZH1m5ikM2PO8esXCM+lbaI6Lju8ks44lNPUHqTyVEKVgiEfohrumI05t8ciaDJInECbVLMnScuiU8QdSj2QPWgZN3nWWlZnEHZO1r0LZ3xSUgcGVM71dakf7s6DHPdxXS0cWW+VhW2xeLv4n6vSsfFCNyszEA5r5/Js7tUZjM/0D/TEC+ewwEzouvrxguR1Xt6huuEYyk16HfgwVpWiSB5VsTeOOhsvkddIdIRJT5ZH0yEaIykd9TAoDbGTLtT4CclEUXHZL4+NofYwchjidwxWJYZOG6aHjmANhEoJOVyWs2ionDIKnIuZA/8UupmpMCABvQgrO5h8g2S2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVzf3p0Pjf76k7pyGIIpemuqfNZ40V1tWNgOZrJLtg4=;
 b=jluz6H08ydppa61Fe3IajP0uquFbwrsBMIvRu3IAzDF1Oh0Ku/oFAVHUxnH+AeBhzdXgVTlMBi9A/fbwExW2yYp+msa7yao7R0dGwkYGB0to2Ie6C42FAulNF94g8NiE1JbbKoFzJZ/5FGzACaIxWWztQcl83xUqdIvujYH5JLrm318wtTZQyLXfOsgsJWxCvS6Cs8mZ889/RCM040d3GoMTlunSZdmWqx/rX58DDQtUqan1Q36rCtUi91NFOBp2gXzQVBLjyzEkN1UFB3WpOSYvQuiHQojNSmkkoxRrgTr13CCJkODm8LRhGnkA1mrwWwZTUCUoSZcSh7zlAFiMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVzf3p0Pjf76k7pyGIIpemuqfNZ40V1tWNgOZrJLtg4=;
 b=SMILyFUkzFVeYVEE6hthznLRbfWGPI1AN7SfmBJg02CLGHrZmPBYlrqaZRBXrRIvVR5afO5lCYNY30BYGuNBmXIr+Zwo7+mXd65pcOEzgQZodyIdCUCOoHmxMOVcvXpFtjJG7oRavsFrbW0hAv/QBUiQyxX8lIPSAG0sJV/uup8=
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by DS3PR10MB997748.namprd10.prod.outlook.com (2603:10b6:8:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Sat, 12 Sep
 2026 21:34:11 +0000
Received: from BN2PEPF0000A98D.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::1b) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Sat,
 12 Sep 2026 21:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF0000A98D.mail.protection.outlook.com (10.167.248.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Sat, 12 Sep 2026 21:34:09 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:33:57 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:33:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 12 Sep 2026 16:33:57 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68CLXvl02513366;
	Sat, 12 Sep 2026 16:33:57 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH 0/2] Input: gpio-keys - support wakeup pinctrl state
Date: Sat, 12 Sep 2026 16:33:52 -0500
Message-ID: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEDFpWoC/x3MSwqAMAwA0atI1gZiaUW9irgoNWoQtbT+QLy7x
 eVbzDwQOQhHaLIHAp8SZVsTijwDN9l1ZJQ+GRSpkmrSePi4B7YLjl42vOzMh0ejrNFUkat1BSn
 1gQe5/23bve8HLwZ+3GYAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789248837; l=1396;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=WH6cKY29IhZqNh+s6SLzQrdhIzAMlSwmmmaW3xwQM4I=;
 b=bX/qMM6ZHYnR/gkNj2Y36iHL+GZiHY1buOSWZsEMidBKm65N7qx9owGiMnvw4jkmu5bwCNsmQ
 EnC4a4tGtE0A94uekhcnvkUWuLSvFWlY2wwhoZqMhWDOR3sB9unMLWE
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98D:EE_|DS3PR10MB997748:EE_
X-MS-Office365-Filtering-Correlation-Id: b1df4551-76ad-4202-f095-08df111594f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hQ3C5nl9x6I6GusNl5yKZjQT/VlEHbLgzmta+D8WrMlYqt+jREVo3i/QHEM45mmC9WN8vF7jUQ9uCSdOfFbl5VmZldXDLu41UsOwFKgscNHYNi8Fci9tfXqq+AysmYebPkFLC/wveWGdoeTXAEjnsEwxyYFLZMleZQ5zCpjn9IdhZ23jN6SlOk/EVjHhjZ9IRtTPMgMSE84Q1B53niRH9m7Jhtu0jBSM+1ISOOI9sZp1lH0zS/PCFdNeq3y9ePLWPD7i1XfJ2bF1V9lK3VmLpSsCJhRR3y1S/WhHMlTcLQoCzNzabm/BzJBtEq9NDaBOOPnoBtD8mV65YwaTvLrkGopZIRu5uHeT2mRjMAWL8gsGobqCXaJ9yXtklzKzXuKnPwfI/n9BAiKPJgTd+ZoOtrxgVRpVvYno8KjqPZM9lTmEAMtAvye+hsxQDpeAE3X9IM/z3jJafamT/xmKRzTt3nfbYmF3SB5I4Rvj7Twl5iVzuypJbLiY16Hcb6blOr/FAEU90OrwrU2fIrNTyDtzKSf38VvZuLdREPUPMoyMS2gSgW40Zop3utS1RYY2hjCNUWZS1bjEdCYuIdPJy3G/zz8wut3fnuudAdzQYNcvjMJ6PCvtifjs+EWgusxB696RyaIKlF6spkVy8v0RjvEBiWqFn1RhwphpgOiimn6Nl4+lkrbLKddzGnUr6sju1naXaJWWbVp4khTrsZz1Zmcd7w==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(6133799003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	togki73XHxvyECEmBCOH6MnEIz+HHVAE3PrDUgvc7foCvs2VWhfPnsbo+ORFSsh02Jm9ZlxYtQvtjGFFTlr9/QM9sGUDkvsv4GXouZgN9wO5Ke7m0ycgKtRNA2FN2xHIK+RKzdQf8/FhkcQbjxXsytWakdmfC11IWLe5id2S+58uC0nV+1l56IdbXLt9/dGSkieG+xK1ZeEbrTeYYS+TlLxE8J8V5H5YcFI7E/lacQwivvVJUfVKbfoDJowTNWPxYyerIZIZufJcbIOl98iU37wJIBzqcRGK545Relb13zeMtyKACMOs5sn+J41ozSF7KONtxYvVJoGvUxwvL0uR4fqhMRYdJAg31fnBHhVVs4xzPLVZyOx0BHAalP/kEJxqUI1oBvP9WjvQ7cdWZouRK/PYhcxo+AcNGcBlUQYuaJ8G/I5KiTtnWdvK8nMl2gYC
X-Exchange-RoutingPolicyChecked:
	NIUgEkOUOwkqoLcGxgEfbBCRdobaXjn66+1NgLwhcr6dbsPlZEyyp3KLTgE+lJu+ScB/vu0pKkzPpUKxzJBo5Tj2UtC0KiDJ3jHVI4IVpUH1WHao+RXnHIUH6Bk25I5GZ/M2OC53UccyE1mmisTJ4T4OdasBD1O6bY0QyHpZ8ssomEFmvCKSqdeshpwXT9aYazQxb/QO5D6+pYYJzYiym3b3JKAiUeqVQc4pn6fLzZQoneK3Gdv5taAyZ8waBi68epT9SBfpNg2vnbrDePuKGopqtDY0SRI6dckhKDg/cPb4LIQDLTI3jXkQVc30Ihn2v/mNwQUlW1ix2a6Lhr8GRg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 21:34:09.9837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1df4551-76ad-4202-f095-08df111594f4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A98D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB997748
X-Proofpoint-GUID: DpQAbhMy4MdMhLaXaJDVzACHY14nWtVr
X-Authority-Analysis: v=2.4 cv=XZkcX455 c=1 sm=1 tr=0 ts=6aa5c556 cx=c_pps
 a=1puOLNWm8QjqX9uS9MZT0g==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=7DPGvfV03aZnP7ExyBwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxNCBTYWx0ZWRfX4P5GFQx6liiv
 FsBnvxy76+XA4nXclhTRWf5CyvSgj7gP2tuxs0Pz/8/s8TmUJ7hLS5HuWjmdOOQ4UatKkdRiJtX
 zGrnew3wo4HoqlIAhkWcZhVmTd0wPr6NWJxQtv7Jgfz6OC+fT2EOWg7tIbdDZr30OK5vw3IojcP
 JAPmbesc0KxlpHbrRatKAHcl5sUsT26jX92kL5jDaLE/T2Q3eXeyABBYeTEI/Pl0dDLH2Erq2tq
 TLpz0PyLet0m+q/m94POE/AvnWbhaLs0AkuuLvqNqT3lxyy/7a3I3NbuyI7Q5lm0qWUlT6VNwtQ
 xRVD2GVxdJbxt5wsrH8eFOUPjw+bG9IxaLrhD58aQdMeJjEOc36eKyvCSZw0N1Ugrr35nOAEabl
 arWNEg+Mf0jCyGhQqyBQvgJ/VU29eQlkesSq6w0a+kgoRwZDInk6htDrIwqFBLg0+TGalaw1hTh
 m+M2AXD9awawTqg9zNQ==
X-Proofpoint-ORIG-GUID: DpQAbhMy4MdMhLaXaJDVzACHY14nWtVr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxNCBTYWx0ZWRfX5OfQKec24/1z
 zT863smU9SNjKN8+0rEGJ4ki3sCJmifH4vx2eugw3VLz91sFnzrwpFFKsBJOyVz9VXPJTtxbSZL
 b9ObU4uZORGb/karZZjwyDl80SofGYM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120314

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
button".

Tested GPIO wakeup from suspend on AM62L EVM and AM62P EVM.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Kendall Willis (2):
      dt-bindings: input: gpio-keys: add pinctrl states
      Input: gpio-keys - support wakeup pinctrl state on suspend

 Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
 drivers/input/keyboard/gpio_keys.c                     | 13 +++++++++++++
 2 files changed, 29 insertions(+)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260904-upstream-gpio-wakeup-52a54080c948

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

