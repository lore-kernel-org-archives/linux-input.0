Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21C63B52FB;
	Fri, 25 Sep 2026 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373205; cv=fail; b=CmMOTxLUzJmFN3hkq3FTNPWo11WkDo2jr2zvGy4oSDYeSLm71NlFLP1rtp858M7h8bW+HxtQS8FJxUTDGO4USBNFss/FtEKv3y7lv+ESiWtdJTa3N5Lvb0a5yqrOw6fWpjkCwrpgpBsXVay/wkdaBN4otazSc6sVWn/jTPi5jQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373205; c=relaxed/simple;
	bh=8vbwlk4wUdmy0NHRBAB6+Pzx0H3C8BZUNdSHPEROmQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZIEXhprLpC5Jc830eKLw2b6olsBkKGGDWh0Hd6/BORHPA/3pe1ed28gWj17mdBOvs9rTHcdKWFhM3lNujh/K2TnwYCmSXoHw8mrGRyggqh7c/XvdOaVenL2iMK9rxX4GnrqGFc1bmTueLMH8qRsc2UGq/UHqDVKjxOJjr/ePzbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=eAyGkEYC; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fjcPXgnP; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="eAyGkEYC";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fjcPXgnP"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PIotvr3281765;
	Fri, 25 Sep 2026 16:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=6Xl5xlyEHdvb/bdq4+0uyRfvbCdQ48s5uYNXWT7+q
	k8=; b=eAyGkEYCZn5BT/L3PqtGQssbQS8LFIB0/LuSShKTQ3arLVNLUuGlldyHu
	XW76/TZiIKHY3ysxy0dnCOGnGO1OSYDuKvloItS4aF1dNGZnfea3hDJl/P4t/9Ow
	O38UxS0RrTr3fP8Ip2Y7k7rQpsAsbFTY9sZ6JeubyA9Jc67qb0TBqDBmrF7Mu1Bd
	B6LSyU9nbfadR8S2lJCiitF8hUadh5AOM4/N5oekjbQ7QeJ69Oslfib4/UOSyLdz
	OPMw+kzDUezoYtMriX0a5NHCTMs1oJQV/jNocasUApChE7q2stPI1ilh6vYEOfvU
	DmLKTQV+wkb4bG73Vbnx+sXDNvpAQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gwkhrcr1v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 16:53:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPz7CD9yHmlgEYg7YZPslwbZHhmYy1DmWcipLFRR8VbahCIz8jl6+v9sHOGK+iT61OX01rznr+8c1AlT4aotfb/EdNDyPGOEbuQN33ExN8CkR09DCxdYwieytrCopp7VySRlJsyG48syKQ1sKp4pa3n6F1gdf8VROiPY2x4VLtLaIwBsr2M+qQLR88mSY7LAVcp9Zv4v3GVS2Ae1yU5eWMISWwwhx1lSfPrQsXhkm37FasbAB5aeBPNe0TZBkUDV45Vj6Qds44fxEUP+0/lsBtPavjG8xXyglOMkRp1InCigw2cDVxAyc41aMhbsg17OTO6EgOYNCue4mi1CmACiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Xl5xlyEHdvb/bdq4+0uyRfvbCdQ48s5uYNXWT7+qk8=;
 b=JlJcxlYM5U6J/X9R4o1Ih14nMF15kukG0ivppMWY/rpQefP7XGZU4ZBD5w5+B8s2BOka6C+qQbcf2sE5GIEVNxn2lAjRqQeNT7zggmq6j4T5vN9J4oE+r1MoYGW+EYDOooxudGxIvc2bcGW7lNnCJdLAtIe86LnQXs/A/AcFVO1QfLWwZV+u+GyS7nKlCLZqVdd6ZNR1aDzXTRv1FwDjrXjkvI7mmp3StKqN66wt7dfIXtSFOQcPTLm7A/8chDl3wjc2X6ltev6TPxoKQHdAXDkvcQPRM8lx/eLaJt+x1yWKeNPTVgriI7dvJEG0pxYywC9b57GMLL6ugkKVddiGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Xl5xlyEHdvb/bdq4+0uyRfvbCdQ48s5uYNXWT7+qk8=;
 b=fjcPXgnPUjHrRwRylClQT3TCoRG7xHPBSNlvcGk0XVVI0l2r1J3jmd4TtktU+cUBB0r683X75ARsz6cJ2mAtdCC0sGan1ZDT7d3HuP/yW2uc+FP0HCLC0YPPEndFswXLQlltHRg5Aa2A4RBU7HCL7D81faGES3aiWLdBNs9g67w=
Received: from DS1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::8) by
 SA2PR10MB4731.namprd10.prod.outlook.com (2603:10b6:806:11e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.7; Fri, 25 Sep 2026 21:53:15 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::1c) by DS1P220CA0013.outlook.office365.com
 (2603:10b6:8:455::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 21:53:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 21:53:14 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 16:52:41 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 16:52:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 16:52:41 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PLqe3r2596725;
	Fri, 25 Sep 2026 16:52:41 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Fri, 25 Sep 2026 16:52:39 -0500
Subject: [PATCH v2 2/2] Input: gpio-keys - support wakeup pinctrl state on
 suspend
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260925-upstream-gpio-wakeup-v2-2-6c5533356246@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790373161; l=2720;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=8vbwlk4wUdmy0NHRBAB6+Pzx0H3C8BZUNdSHPEROmQI=;
 b=4gGSLFaFsmYMYP7vVclIT2tJhhXmCLEHNq6pz0EyJ8Y3N25edjM8RxIDp7OzJLefXz9CeDROp
 140VeOxYdJjDzL8RO9yOthjNrgHSm9E9wD8fNLVRelcqFNXoU3nrGIQ
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SA2PR10MB4731:EE_
X-MS-Office365-Filtering-Correlation-Id: cd61746c-8cb4-4da1-b1c5-08df1b4f667d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uxG7mXhoOvPvEuiCQlQSMc0DVL2dBmVIMZfO7qB76Mh0rhEwPyruWV6firJgHj/mwyf2U9WsdSZ1VeqMG1QY2WmznmWV/uevm1XKfebwca4Rh22D5BWI7YEoLjonB1+I/IBBvw9El9ULSMSI43NsASWw3Sd8ePGEV9YQMjpPzddfgKjXipQF5RFyQd7zZrBHrUAC8of5ehFn+owkAUsWW4SxWcK6sJGxzcybIxv6k0lwfa6J4b0QIIAE8pHI1ygKDzywy9huafyxC4GN4QmHn49oODXg7mh4QIDPqQ/E90+8RXF+tN+JRc5/dwRhWH1OWXpTCsOUPaj+/8nShxLCsZv7Gu/rqJnY5wFjnwOd762gVYHGIamS8Q8H0pDmOmv3bOyTFLKxShpj5GaoVXLuWmdm9W0PdqPy0yuePUkiX+wV05ZgjMv144f8kCDXAeABSImymAZB2q83uRO8wXsAEcYnQg6eiu5p1BcRZEE4U3R/ajrPAAAu5sFWD0NfbGLpgaB9HMsjt2J0XDypMtNmy5+IqEjZjD8jY3yvD49c0hCYknQvWTlY6PohU5d7n54zA0GtybSPaBw0FSFvfLe4J2iatRrC2woQcVrTeB4Ij5q6Bxg3Q1w89CRHekYGqbpqEPXr61Uuu3FHMYkOkG7MY4i3kaP8/fLthPt99Zj9kUHqvCtEyequuRaWGQti21lpFMlV/EKZeNncOSmdavZ+6Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9xgy5RlLXsjAe91UuKn3CtZNmIwBUacsJbXXaOO4Zv1T6u0OXmm4Q2aHagmRmwv3K3QOwDtwIFbpAXaFGmoE4s8oL0BCeeVUNuAlpBd0iLkOs5w2K3xd2IciIXcOLUNritZtuO0D1suJBHYe6IsfxATGP7f+Eap/5vQ+ZsoqQmKwTzdOjM5PfLFB4bFN0H9SEgMIRAof9A/AMJ/i5I0QvKHk3uIM/gePRyBYX8+NpNGW2dhDEdpVPzg9rqXaMeL8zHohEdCadZFOxSFMQEtH17A4j6pE4tj6AQrW2cDWZ9i1b4v6VLD8oBKv3K0atJ8GMNFo31sTmqC839PiUf/4Qxgl5W7wlgpvkCSh8lWjzq6+clz/BsZ0qIZEA2GLxo7I45yuZJ4vIq3gWHx84aWqCbQfEoOpF+QFxf/0mB4s2uRdYd9rbiGmnr0I5mHxTobD
X-Exchange-RoutingPolicyChecked:
	r5qUGvCmorvfo1goM7n0yt+8lOQyxxOtdgpSbNxqW1TbeTNK4KnMiUoDJh+ZWfEQSLt/gttLe+eXroF1k/FI+7NKj0UY7sPFFCB1mibVzwbk/GIFQYvJ2gFQKDw95P1PkUQ9KiwlU9y/Z0uA2+35RHM09JJgrNxG/8TmfmQow5vkkIDKlSO/jY+vWY88yQ4UpqZzUYombCIDHsFXk69TrcOo/9l4ZK0KI6hKlddQoMtLXH3a1QyWF26/FqT5Q24QsVv+xlAlr4GNebuHTqQ8jSd0tfbNeiueOvD2iKzbR3Wi52ia0IGOfqA3O5bJ1LZwUoPS+rg3DYJb2bijYw3wGA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 21:53:14.4744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd61746c-8cb4-4da1-b1c5-08df1b4f667d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4731
X-Authority-Analysis: v=2.4 cv=Fv+QbGrq c=1 sm=1 tr=0 ts=6ab6ed4f cx=c_pps
 a=5XdDR3/zV2dQAmk0xmzXVw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=OP4iwnenC8Is5NdNPIcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pj9R-kIYm9Y3A2A0YzTdmH3d4TimNUeu
X-Proofpoint-ORIG-GUID: pj9R-kIYm9Y3A2A0YzTdmH3d4TimNUeu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4NyBTYWx0ZWRfXzwJCibgWKkFM
 btOxEOlYlU0k9M/T3wtPmYaxI9r5mg280hWrL7NTirpVcClPoKArPCmRH7oyfB3NFmcjiohXdJf
 F20++OvjDOCgo00UX4X5qLPgAA2lLIqJnrZLT1rtRYZW3ghbRTBqvAsrn8pf38IDURfkKTVwN4l
 Xp6PucBsPqdwnWUbDTuPU8zrtUQ3DDKHWCOqaJYsIQX2eF+eZxuVifOwjh+yixEQx2OCScrlDfW
 vamEE+wd3/wB2XJOsh8NGPqslMsna5MGCBitNGJgzO8GGOGF9cKNTYVZYm4U/J+Re9xAPTYw6YK
 JJYdk3RcapiajH5dB4ojdplGx4nTuBHsJMQEO98Zk5RDAUiz/a2J0eZhTP2SGJxlUha3zeBdJkC
 0g0xUGt+/va6qnK/wittjAEz5XFecquCzBjGzSPFhgH+DxyQK8UPYVg/kHMDEuwkHgMA22YPNLo
 9g/W4maVTXTGxtOuIsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4NyBTYWx0ZWRfX7FP6LrM4ZZ7X
 V3yT9xiWVgomCSGLOhib/JyOjA79lTZRechLb/EQHBhxOqXfrF+tjWb8k6WDPeXbNfgOineGCy3
 FMoWoILcu02BZB8LKZdN4PSBIuiePig=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250087

GPIO can be used as a wakeup source for TI K3 AM62 devices during
suspend to RAM states. The GPIO controller is powered off in these
states, so a wakeup enable flag must be set on the GPIO pin in the
pinctrl in order to allow wakeup.

If the device is wakeup enabled, select the wakeup pinctrl state on
suspend and restore the default pinctrl state on resume.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/input/keyboard/gpio_keys.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 129fc4212a5ed126496b331ce626682d441c53bf..d3fbc9776ac8cbdc7349a28df990ee609edf9e59 100644
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
 
@@ -884,6 +887,10 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	input_set_drvdata(input, ddata);
 
+	ddata->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR_OR_NULL(ddata->pinctrl))
+		ddata->pinctrl_wakeup = pinctrl_lookup_state(ddata->pinctrl, "wakeup");
+
 	input->name = pdata->name ? : pdev->name;
 	input->phys = "gpio-keys/input0";
 	input->dev.parent = dev;
@@ -1010,6 +1017,12 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
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
@@ -1023,6 +1036,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
 	return 0;
 
 err_out:
+	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
+		pinctrl_pm_select_default_state(ddata->input->dev.parent);
+
 	while (i--) {
 		bdata = &ddata->data[i];
 		if (bdata->button->wakeup)
@@ -1039,6 +1055,9 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata *ddata)
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

