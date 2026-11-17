Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794947904;
	b=NMhXzwlVRUS5tRxHRDUmenxkQ8l6+9JxtqzgLmayfXLURJzaf+c3Zlvzh7HCPtlwth3k
	 yHl7Z1h18WaKjyBkYtPD9D4z+NofjYwmQN849Smm+v6VZptjvGa8hOo0LQq5/e4hjus2P
	 vGFsEez6Ivb/UFBavJQvX5LRg26DAyki+r/DVgEZG6/AHF2bGiW/P5VKQHr3gM8w86p/V
	 SCu4BvRha0/w2/ThshEUJIKMvD9GY4E+taCKdEV7JcvxXzYrf7uBiHANN+4DMkFjcyl3f
	 g6eK+Z2E0DoSM3t24PZ8/28rdVB7FGIn2qyABfBGlp562YMfn9Vid41c7lBI9rlLIwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947904;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oPZ3KGhECdw+59cHKRLkfyLnKx2Z8YZbvqMPcjVHU7Q=;
	b=QZo7qLzSpXO7tITwN5WHLH6Yj3nJ6EuQ+rU3lWpLKwWB5bXdsKWmcjUZxK3EiI98rgrw
	 g1FnnFH1s4Kn5ocEkbWb88yqsrIuFyCjfjx3B07Nx/wQHQr6om0lSCG/oJkOIYyFE9L/L
	 YOiTqzFW3qwXp7HODG4wB5Zq/L+yYrbbZpWlqUBdPvUljC+v13We0Wy9gROdyF7mXTGH1
	 GvxFx9giVTeY5YMKd9WsHHr4dSQBmC6A+Dp4X8CyD2Gz2AW+nj06IYKfvEWTRNnjrxj+t
	 8S+UQTHTLfznTGGD2mE5Tp0Tz4n79RpEEHiFcyKQmxUEzzc03+nvs9fgVDF2w5I2gww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YRHg1GtA;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=gBqKKWJ1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86194606A31C;
	Tue, 17 Nov 2026 20:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86194606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YRHg1GtA;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=gBqKKWJ1
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AHKLoJD1494296;
	Tue, 17 Nov 2026 14:38:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=oPZ3KGhECdw+5
	9cHKRLkfyLnKx2Z8YZbvqMPcjVHU7Q=; b=YRHg1GtA5Ipe7+0Dh+IZXwYrrB+DH
	Z851zSixdrZdYWSDf244wlpHOaCo20iy+y24tRdA+hCtiQWn3GxTSSWk5AvkUXnL
	0XFAIY7lbNCSxfoTeywAv7qDo8tDhMXEy58TyiRkmmQDrW5MhZY4LAj9o2sbAWZC
	tLL/auNY0OkRWHOLtbQ6tb5OyvWC2cqfM0Wfby00DKkNgHjsienBedQ7hRO68Tvx
	QDRKSP4Pli60mVlFjFsItZZVgJPb/8BStWa0lzKagJ5f3BO8SA1SCt0J8cfUy8Yr
	Z/4Ola0W1h6qZ7pIfGLns1r+Rif/+5pDsdBobuJUHovfpbFDDnpJUrmOA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	by m0384305.ppops.net (PPS) with ESMTPS id 4j0kxqv205-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 14:38:13 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo5KY5uCLhEEwHt39lS3/UkO6PZGNTIpfdXi7q6Tdk9JnZnvTI7q5/uThBcCBZtq0p8WIvQx9npA5gze4GycBKBXfe6rETx2lxtawSoGs0m0kOdGWnusPskgO8ggaIPfUc0bhwh4fr+uNzSn/3NjLWPNFiHmEOeHO1sy7riWkGsMFc9U0v5N5b8XRvkEQpnBFwcMAezQ0Alhsv+B2HxHNfaFR+BdGyZFzzzALtJ1WeGYZ6UFTyf2FPVub0A7tmc7d+cuGrHUiQWOFbsOH/xgQ6O0HnN9V+lzQmcXT2ch6iqlKPsr0uP5U3qV3TZ9q0ZnEMhMcuQV6kV9r/hTk61p7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPZ3KGhECdw+59cHKRLkfyLnKx2Z8YZbvqMPcjVHU7Q=;
 b=P7ZngzYMCR61XKylWoSdwgVHpTRh/3j0f+4WKlvcW2qRraabL8rxATpegGvQEK+uoWUri+HJnTJOIzw5jsDP6GOy77OfmR12KFtP6P32DgAvw0jyRuaYsuB8jwYUdLYxTLWb9IuhKYGA+ieQzDktplJX1fr0JiioZMnEZCMaUDDpOtFZDItFDW/yfB6EcPcYx4jYBkILDYmg6JrmlSmbcPdJLpQgzDbLlkhtThk5v2Q4aL/cz5wmqaMNmezfeVKuh0+0uhyo3/l6LV+hz1fOFA+1m09k2dNaJ5ifGOpxAndQOIvs8LJI0fvBbrQanimCYzTMyCtR5N6Bch8Wf3tjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=dolcini.it smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPZ3KGhECdw+59cHKRLkfyLnKx2Z8YZbvqMPcjVHU7Q=;
 b=gBqKKWJ1ntK0u7DhQ5KiXX0zOQ/W1RoFW8L7p6jjodjvwr40HvCTvpuJYT+NorD50LQa7LXMDo5Nu3aSQOGj7mnB8QlXsALQvr/ql55CM4BsjR/eaUuC7tJijgEdwTXAmYnSa3m8cGq9o19DlDvjq+tRvokpm4DAm8nLtMv2Xf4=
Received: from YT4P288CA0031.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:d3::9) by
 CH4PR10MB8097.namprd10.prod.outlook.com (2603:10b6:610:241::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 17 Nov
 2026 20:38:11 +0000
Received: from CO1PEPF0001885F.namprd02.prod.outlook.com
 (2603:10b6:b01:d3:cafe::c) by YT4P288CA0031.outlook.office365.com
 (2603:10b6:b01:d3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 20:38:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF0001885F.mail.protection.outlook.com (10.167.249.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 20:38:09 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 14:37:41 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 14:37:41 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 14:37:41 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AHKbe3T498237;
	Tue, 17 Nov 2026 14:37:40 -0600
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v5 0/2] Input: gpio-keys - support wakeup pinctrl state
Date: Tue, 17 Nov 2026 14:37:25 -0600
Message-ID: <20261117-upstream-gpio-wakeup-v5-0-0e10aa2f7c1e@ti.com>
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
X-B4-Tracking: v=1; b=H4sIAAW7/GoC/3XOQW7CMBAF0KsgrzEaz4zdpKveo2JhnAlYCBLZI
 aVCuXsdhBBIzfKPNO//m8qSomT1ubqpJGPMsTuXYNcrFQ7+vBcdm5IVAjqogfWlz0MSf9L7Pnb
 6xx/l0muL3jJUEGquVHntk7Txeme/tyUfYh669HtvGc18fYAG/wdHo0G3IAa54l1F7muIm9Cd1
 KyN+CKgXRCwCC5YS0TWIb8L9BQMgFkQaBZa2oVGyH14ehP4VVjawEWoXVtWNsKuhqcwTdMflwM
 censBAAA=
X-Change-ID: 20260904-upstream-gpio-wakeup-52a54080c948
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794947860; l=2309;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=DG12EHeImfEctwFD+H/XLOuKXotzif0ozqzlLz6ceXA=;
 b=N1bvqH4gOpzzitFuz4EBaA/I/gcDs4VFuH639wF6rauD/TIbFNIKff0bQNZ5YPpn+j+YV/RSs
 RlFoli15jjaDhsxxEIBSqVRZyIb8Ym7kzUv6cF0fQCV3uxR3u37nE4g
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885F:EE_|CH4PR10MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: f334ef3b-612d-4eec-61e8-08df44eab11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|18002099003|6133799003|10067099003|13003099007|261022105027099003|261028144727099003|56012099006|261026140227099003|261102123227099003|261009223027099003|261022113327099003|261021121427099003|260925022911599003|261022075727099003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	AB6GCofyYFtb54lD8uLszmx6RbYBtOuD0EixJTT/jPmhDvrDzcMZY3LTGfQ4FDqnl0z0+PngnvVYbfTLm/K4O71ySa3uHTXTQAHmpYfjA/CuvIe5bDEu6A5JNgNuryAWHKZ752bGUIgjqu1fbWcpOY4QL77xuWmXN8o5T0f8vtd7o9n6gmLISF+JiogNxoN82QPKLDfVBG6AEnTaUfjV800/UQTWaRksIkfryEEqAJcnXRxuynJE7ZBNMwMXMqn2XxJYzliK/ThXBYWekmsBhf7+mliZka1PFFazVvujUF0Mq+JKjVuW6uTRibwCH4CRtufmj6IU/NccqIc4ZY39D+5/IceP70VZlSCopkBNwiCAo9TBufYrC5fx4/L7sDfY6LlsZvqz7dHE/iBfYG7gVCfRKm/F9ZTloq8pvdfsMDPN/i2mUE1aa15znB/gyOnA08DllxXdsFweG+dpx/fQsFC1W76FIpWdwJZJTWr6R5asRlK3F0hf2FvCLbWW9CdoCjZ8mgWqOhFPtgIbOCn3oZI2arpyeuyCYpUjWj3nHIjIcWRfWOs6MYs3OE+aQRofz6P8R7+SKoTQqfUQlEy1aRBcisViotFPu5HlQVHgKLSPKfwyUeGZ7m+CfSxLrLJZL4MMmqCS91XgHqQS4/J+mg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(18002099003)(6133799003)(10067099003)(13003099007)(261022105027099003)(261028144727099003)(56012099006)(261026140227099003)(261102123227099003)(261009223027099003)(261022113327099003)(261021121427099003)(260925022911599003)(261022075727099003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zWk4LbNfVCqCWC06NFaxX4ooyO0qU2EN/ssPwMdxDjrXglWhxjqBY3tByhh54kJ8qMZE9ch7vft3CyqeVSQ+Eg/7sKwPdxhPtFqJBrG3jMB6lcaig9kCYsyUiF1B/7YHbqUEIzP+KOTUUAuePBXVnKWDN4nznem7rA/c9dVICbnfpxTiaHjzesZ0AtXEOj4QdGDx3cN877c6yexmJX4UT8q/c747thL0BnEukXD8/03xoW93AbuJoeVmYUNPVn2+jRtBVg/PBSl694HrLmf91KtqLpPD6a/XZri+WX0BmS+7kk03os2ipHDPC+EhtKQBNOk5d5MK1ZawhLSoqynTbxzMAY2qYmx7mC7vS9sTlsSa0d9rXD/lb8YkeoKa9crKeMccDD9afLFGMX6wG0LcjQEht7HfXVOZ1Hfj9vw3O2Vex0VGSqhK8GPsEDEnSeQ9
X-Exchange-RoutingPolicyChecked:
	bMQBHHpscdHj6jVxkHEpsVX1uS0sPzYWK1FvsOQm80QCEN2ynxkedZ72gpGoJiflxdL1z5rm39414BulcmQhdjslHfIn/+L2z3H42yP0hUIx7pCT9jGk5PhgmIwo/XttpVZ/Cd9gnNrf8hBtpuwXmquoZpImLQOoy1T9edFwDW4TUE+HDWPLGJtRF79o0rhXU8m4cau+xLW5mdzI/gwmRZ7712MEBMwo3pDVajMFN4TL3iB8XZ6w80si6KRtrZsQcGfBFbelOT2hrrbuiVdFw3CqdJ6o+hQKhylJ1unGE39AntxnRCyhlmErRlnryvrxkAMNIeZpBTuE3hn32q69PA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 20:38:09.3221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f334ef3b-612d-4eec-61e8-08df44eab11e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8097
X-Proofpoint-ORIG-GUID: mrkkxWcnssL2_4jiqWEANf2_SfJKnvaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4MiBTYWx0ZWRfXyjivPqlN6zdl
 N/Pi9ndJPgFgV8NnJF4JnTQW1l/6LAdnw9CDuIwrgeSJ6i+qLJzZ3XCvnlF3vn/iKo8EbCn+I8O
 dIIsE/Y2+cEDcyb6TYHh+u1Rctad5NQed4ZFbwmmyc4k0f0NZOv7qMkVdRl4WQjdvWNAlpcHq5g
 77JBhcXMhbbNGiL68qFzCPcQHbY82sbO4dkLP08IaU0m9x0QE0gUZYY/HdFVX2vQW8i5wc/SICp
 RYBevji63sNYOrosv2ms6Fmk7qPvSDk0eVg9psC55HNPkvhIdl91/FamMU+pcZJdf0VZJIMGDO/
 ZGczLayLbeSINgtMBfnqXxtzpentfC82cGk57rImEHH4MYo64+Jk1aZCSSRa3q2I9oT7FJBRU2W
 0L+yTjXL60kfov2LZvJMyQEcaM4Q9ODQgfZDrJj0booE+Fp1jDE8MbgvO/rvLUV7C/q44zZcJdE
 nYuYPRB6sBPJ7RcOdqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4MiBTYWx0ZWRfX6P1u/FsIVflC
 iU8EEMi+F3Bnxg+XlbQY7g6D1bdQ7o2I4Qa/LYxkKfU9qkgIhuKvhzzEeCZJGMiDQdlrb95E9aK
 wZw0POJtUHsFZnzUMj0xmuGl8akwngU=
X-Authority-Analysis: v=2.4 cv=DqzDa2/+ c=1 sm=1 tr=0 ts=6afcbb35 cx=c_pps
 a=1g1g+NiJF5nyOkqFb40SOQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=PNN4_0-CexN-1qqvoMQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mrkkxWcnssL2_4jiqWEANf2_SfJKnvaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170082

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
Changes in v5:
- Pull in Reviewed-by tags.
- Rebase to v7.4-rc3
- Link to v4: https://lore.kernel.org/r/20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com

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
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20260904-upstream-gpio-wakeup-52a54080c948

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

