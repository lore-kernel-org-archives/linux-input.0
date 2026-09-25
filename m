Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC4440A3E;
	Fri, 25 Sep 2026 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373206; cv=fail; b=R5jibORa2gNL7sf6W5aMF65aH/1L1iWdA/BJYIzsiAFY2W8ypbaXoFA3bXnIH3CFFrcG4/ogl4h4Nu/JZNMfEwF/woe3cs0cHKh3cF93xT2yLVCIj/tEk61iP0fnSrHwd2h822WpYvyqGhSo3N9xQnKuTGvCjQPo4muEM8rp6BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373206; c=relaxed/simple;
	bh=fuNmscThEJtRWYPqK+Y2+Xj+BGUa/0+eDCuEIMlo5Pg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rEEp3P1+EBYCGjMcNWuyYc1B74oDmaGMx5TC81CI+5YHY6tiEzg0MSZaIoF0ELMqzuWvf49ivG6hqQQEQsd0mJY/uzpyzBcRMBRdRSAt0s2v3oYd4qqiOatl4YRGCE0Sw1m09ehYv3qx/QWzVdQ+74yEinv7dBy03H01CIdApC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=H3TmjEm9; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lc3Y7pif; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="H3TmjEm9";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lc3Y7pif"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PIouYP2801091;
	Fri, 25 Sep 2026 16:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=0G2Akh7dK5ybN
	cQwd+bvpkTXfJuYAmJGTBoliqVuhd8=; b=H3TmjEm9Mltky0xatwomn93RLFO9s
	4WznLbggZ68LG1IjaaT979VpZ7Cx7cQRMAf8LlCoFwIBKPqonAlrEFiKVmmvGOAN
	bbirsfkj1PK1q48MU3hRVCLEsWT7tw1BV54tpT6EXaOcLGi7l0+QTvvZ/OPDPzhM
	K2eo8QuTw84bvyK+/GbsaXFjn8EIW2uty8wXEE8rJOcLhA1tVecnhXhlj57CCdDf
	4IgjrASee38BDHoRWz8fc3FE0GoKTM2hHK9RVDERGWWw8HNjtGEmf2wfBcDEZr+d
	miV0oNJ9Q8f1CPfzVXzClw6SbCZ5OM3TLq2diiHUpMGAAW/Ae5HbqyhYQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gwtcntk50-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 16:53:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os0u7BH7KmDPXzHQnWHlBs1wRviVkvwMf6ROcohgPID4IXNaEU8AFzWI1PoswNSp1+Sny5RUB7n2wEPCEUbVDTnOH/pKEvVX03uZZhcObHI+fQLZ1IvJQdSiV5TR8995jTQ1bJnJmgBSYXcKFzY+1uDkaTT8utt8CtizAF9DdpaOcHMoRfvrmz/YUpI9HW30pO0iiQG6ypnXFQrJeXs6oecm+uEruOaZ7F3R2SmIE7NU5L2lO8bjeFaFng9sG6TXfHTvI8GY02yS2ztPxitzQlkuVxMWT41w6bgp9c7f5HE9JElql9eCBpxa9YeXa2W7sOQqkhcMCC+QwMenrMDGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G2Akh7dK5ybNcQwd+bvpkTXfJuYAmJGTBoliqVuhd8=;
 b=t3i0mnJO2W+OqhIF1TNJthV/hzNqk7rrNBSy1LCReR8FpyNXDzyiDeQ8b6GZYQh+psmeh7Fvblgf4u3cOUut8HanD0DXBBOEeNuJ0jOVvfXcSCnx+JBWUocVrYcItfuU1vZkKSNnglXBaWhkTbiWoNs5e1uqQh6vyPXmgFgEFq+BGHk7jN8m/8rJV3+iUhbWHX+EZrdyxZBCu3MBi5zAJSRUGlVl9i0g0JfTMcq3n85RVlQAxNxL9umsNd9EOc51nPCYJ3iNM8YUoNcJudr5ch+rIQMG4W2CbGE5Z1QJT+drwZt1fQYk+eSVNOH2qEGYRNgd0wCfJRGmWM7nYhq7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G2Akh7dK5ybNcQwd+bvpkTXfJuYAmJGTBoliqVuhd8=;
 b=Lc3Y7pifdWmriEkCgMokpJ6OP2r5gi3l8YXibkgLGNSRgvYixuYdagCLH7ecpejOiyHMGT/r+WW3uLk73eeepdo0QmjDgAGcotptIoN/QZ7NSI5yFJBGk86p4KypkVwD52ZEG5dtDRCoLxhLYXSWiRFTOPDKXFJ2c9VwuoUkHYA=
Received: from CH2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:5a::39)
 by IA3PR10MB8562.namprd10.prod.outlook.com (2603:10b6:208:57a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 21:53:17 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::26) by CH2PR08CA0029.outlook.office365.com
 (2603:10b6:610:5a::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 21:53:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 21:53:15 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 16:52:41 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 16:52:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 16:52:41 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PLqe3p2596725;
	Fri, 25 Sep 2026 16:52:41 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v2 0/2] Input: gpio-keys - support wakeup pinctrl state
Date: Fri, 25 Sep 2026 16:52:37 -0500
Message-ID: <20260925-upstream-gpio-wakeup-v2-0-6c5533356246@ti.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXttmoC/22NQQ6CMBBFr0K6dsy0FlJceQ/DouIAEwNtWkAN6
 d2txKXL95L//iYiBaYozsUmAq0c2U0Z1KEQ7WCnnoDvmYVCVWGNGhYf50B2hN6zg6d90OKhVLb
 UaLCttRF56gN1/Nqz1ybzwHF24b2/rPJrf0Gp/gdXCQgdklTa6Js5VZeZj60bRZNS+gBwI1PAt
 QAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790373161; l=1787;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=fuNmscThEJtRWYPqK+Y2+Xj+BGUa/0+eDCuEIMlo5Pg=;
 b=5o3Ezq5S50unyi0Q1F2JrAADFXVoE4zw0QbUsSmgywWIvb99ENcCgNRRPSGVdig1/hxdVuttu
 ioOWuRxYKuTCZX8j6Iy4LrbGG0kIbGzFYru/tHtckuD4KJ81BI9ZpJq
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|IA3PR10MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 6243cc50-f0de-4e68-50c5-08df1b4f66da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|13003099007|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	/TnaNvkKPse0cKJFfvY1mk1YMXfhTyoSFJ25AbBiLdgIxcnplwatkIwDq5/s54iQLbtQIvf3vXZC3y14lXTpBWPt3nX3RCO0zUwILSmtf6sztCGR2P6SZTK81TW687OIXz1wBiWjrpCz9kRYPt6BNZ8qS2xi9K2zZ1mTzzJhBF9R/4luqsP6YkdjAOo2ODC8qBJikOo0zaS59FUjK5gJwRzAglTPLVs2x0f/xkuLABPcBIQdCETiH/W/ePRfLgMjasE4P2ZY8OVmeJxxZngt4sG/el2/4wMv1GipvhKdgEdMKTh7uILHNvp9dXJOTb8dd5apN/U5fYNUgcGoMB2pKcOKV2Llxn5jThS8Er6U83YsUFOOwg6c/eloBc0veLnvGRsIRhGCnU6Mttn32NH1qyrbolY03E+KSVYdVQR6bn15sO+zXL1uvQVsfA1henP246pjxYRlPsUUIHd8o6QbL8PkkFuQ7A2OFO15ieQokAhN+iiWXiFionxYOuxjoE115lT22TTzOVyE73Bytrfdt764PnTDk6iH5rgMLu9WeqHKZkKXvnqBahDIK/YC7obgYm4mVn+Uigdmg20UL8ooE4j7pvhi9ml+IqYB1K1Z0zrQsBzt6hDoXmfsWGJqsttO2Pb2abCZoMpZZ6KB/N0zk7BVR4CZsAw7LyfL3ZRyjIu4Z6F4zpWdT14MBsRUKxUE7N8NWjtZfdJ8Al4o9kQbQA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(13003099007)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/lHducEd66CRbgNlok9XkXecrvTYfeKlQOExO/xH/5RMexAjum9mcWcP8sKK0MfUjJvcy4V5Xq0hx1UgQSRkyf2nHwvG4Vn7EfRIGoTZ+U+OfQFifNSTJ0RsbQ7GajiO4YCglztZSgVp395bzn1san0JUgpPeFIStsZn99QPHojr9vIg56W+/VRQ/z2yZgKYts1Jq6lWLj8FUpzYZ1TXQ6zK6fxjuOFH8pwjWMFgsgT3lJVVo849shHJVW7KZxcutvX562mMoefM3tuXO8dXzi9WgaHov4wtN2QoE9zlNPiyv3t/JnMeiV7RwI4bXkXbyFIcWAxn6liz0SonwWhRmbh6g6c99AHGLYqfnKdw2ApZ4zT4l+ctYmZCv2NsSSaH+0CErjwg6jOBqACjqf1MxRfk8ad42EwYC7fzbm+6zMJpko2ga8jYWcE65+/JLVjd
X-Exchange-RoutingPolicyChecked:
	A8Dvmi49yfvtVHgd5Vbve+iEmdYYI4Q2fsxTdKiRme2Ap+FHyF5hTYOtd6Ao6/gdRSgYI6+KOnND37u96joe3Z0LpzKMP+SOWb/07nFVXxNUIDEAqV7RyIPXZK7Bl0jv6CnW9TqbRBSbrpul/lfBsiU42hG7BUTm2nW4DwrJwp6k5zDNnvpIswoqItDPjduWnCXG2/9Jps2hIHDyVgUyRhSuAIZKO9G4JUTrX5oebQ0Ob4lwxeFRDym4bYKvUn77ysqod8LQQXLUb8HHFaEspQZqv/LSRpxusPTTjzRqAeNWTos8ovbsI8RyUNUo/goLIcJQWdrBaP7mN4I5lDyqEg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 21:53:15.0885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6243cc50-f0de-4e68-50c5-08df1b4f66da
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8562
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4NyBTYWx0ZWRfX9cgxhCr//Rs2
 9OaW8FQ/LuwENkTmLbaQ6+NGnVG/vGChNS1ddb901cmG+cUqi21zFA30D7oNOg86059l+2K1wLM
 L+1PV++g+hMr1gXgRHceMqwuVauK9vU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4NyBTYWx0ZWRfX8+O/WVYCoYa1
 K+SViCT9QWOlt5gA1cWkFXfmMntLi2AcB+TnTjRJPHROSmJGPajKvPa1jCORLl72hi2o9OSOZvZ
 M/EOVQnCKhQQoTRt5/SbP/38jGAAbxiRMJMrUlTqlJI84C9PGh6tHFJOdr+OwJ/aM1Di/EiMTb8
 199ifTxEU4UUpGWMfOiEx2idVhJNd5U5gvdf1sN9bcohpP7+8YzciwIqoO9EncgqDsO2yOU+OnI
 7rRoUcmUa/VYQ6fgOK9AO/1Pa32tO9PoOBuTGMy96aPFdHAdG+Mlk4+gktFydCn6Db8JuC6UoJu
 R3CpiGMx+ACuxJj8Urtco4KOTS5HKxpbD2oGmTEB408Q+7asuogZ9X9HVRwKE0XCeWMqab64EW4
 vBskXVUC1sUSkA9l+9Ee26r25D4QvDmgloUKhwhpWhNJO7JhzxBRcsPn8NVXu/ZVtkkkwfJUOkV
 csmCm+cUh3ZiWaPViQw==
X-Proofpoint-ORIG-GUID: PDUR7Jo2FW4jVlM9dAPoEXTHfpgCMNH-
X-Authority-Analysis: v=2.4 cv=P6evFSAu c=1 sm=1 tr=0 ts=6ab6ed50 cx=c_pps
 a=XYxO6LlR7Df2C67LKP0s0A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=-Qphp7tN00GYOQeAMIMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PDUR7Jo2FW4jVlM9dAPoEXTHfpgCMNH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250087

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

 .../devicetree/bindings/input/gpio-keys.yaml          | 16 ++++++++++++++++
 drivers/input/keyboard/gpio_keys.c                    | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260904-upstream-gpio-wakeup-52a54080c948

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

