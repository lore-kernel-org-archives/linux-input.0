Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794947904;
	b=IGx7+REa7RT4r4n6jTACA6BZEm6klG0VAHOqNlSFCwf0Bo4Jl8V5F5rBs3k3ZDb3Gyni
	 ko1ah3IZngDQGuXI3j3Irl66ARSuEYPEaCj79Ezmk+2vlmXlTXYr6EoPTSaBm5i0uRcoy
	 z5SuT93SVh/UC/rTTmXO4aZJxaJLxdtzRPvC09fPSZCAKSKZEAZfUBiRVXA8QgHR0GYB/
	 7Cq3ZUnGVHz5jTatkDAKmZt28DWJ8syXIDXo2MOIXha4xvGs+cvGNrLlJZd5RKK9VonN6
	 e0YuqM+lcQIGJQJLQX4bgzLhlqrZuK1JpJxfN4wKF5TGvzuLmqsMEgXV1Ti2/u+NIEA==
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
	bh=YOebX4Iwt4b9P2ZZqyZCxJhhRDtEA0urTUJIhAQbht8=;
	b=JBiQlNo6/JW6B/NNrNlTg4mVaYjN3HSBOSilE2HtBzC26elk5BXLWw4etbbPfRdza4Qn
	 +DOc4OxjwHi9jWt0Wiaje69XnvgFwYkvdEQxec8kj1aHexkulm8FozTNDPSuZw6Sf2UYf
	 4UHZUG2Q14ZB0s0Rc9RoZzSmZ8dbTqI7jhERAdQpIzZ+ynFcW4tF/0kCTLwbjBo4nxE9n
	 jImz81ru4NM4FUA8v/JUpIsOiocw1m6g7RClHiz/5BEZLPEkGKh+6ZM81oYKuL/mtAvlp
	 hcK0g1+nzWyWpsWh/iE7BpoSAo9dUdLUDHG9dv7/CsnQjHoBn3qGIBIlerw4HXS3rZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=h5x2pztw;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WHLaIFU0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629E606A32A;
	Tue, 17 Nov 2026 20:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8629E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=h5x2pztw;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WHLaIFU0
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AHKLs9W785897;
	Tue, 17 Nov 2026 14:38:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=YOebX4Iwt4b9P2ZZqyZCxJhhRDtEA0urTUJIhAQbh
	t8=; b=h5x2pztwUkpk0FB1c8q/rLIJyVcuxW5hgy2wUwzDnsJ+SKPivLvGOVR+v
	BtPPH2iUdT7bRefWHZUJmUHzq9K9ixZGhM6omTZtkoM26yQ9J+2Orj62sBjhTlth
	vvSTKVLsbyQCPqIsoZSKsajDzMIlljdUjVlMtehvm6wbw/U/ztvpWHEzf77Gld43
	Rgnlo8wxiNDoURonEx4iZkAVvhZZHB1gm1Dn5QljM8od//xXElWYswAUDoU/CvYQ
	47ZdJOlL68NQUNCC/KZ/r7iRn+LkVc0xevBGthaguWvE5BihctfnBwJp4wlqQi2f
	uHZP4SbcYuXtD0SaRY6g6buoP7TWA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	by m0380145.ppops.net (PPS) with ESMTPS id 4j0kye41rd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 14:38:15 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAV63FY7gK0tSWwa269bNqQkAJmmZv+19dWq0OKYetJ8OWArLPETFSN+LEMPKZjIl7c3tF/xXtivVqVdNlGnE4RCMGTiXVpkEcZh7foYz6H7RhrZdxeWn2HhYgLAE61ZYnnNF4Vp37QUnlGmvh202LCMvU7UjLXYXVMkX+UViJJAzJFz663t6VM7xZf3eH+KogKTL82Qbf+s5xVJyDLgAieCulPP2A3oCjOTEsR+d7krOZYXIYOadWPV2jS1ZQF0ttxwqu8buSqBCbM0dhEkUsp+UZPCYIaAjOVcztzXzkBezspFWoK6h5JxamdXXyCepNUHOILUuWwNh+W22EIC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOebX4Iwt4b9P2ZZqyZCxJhhRDtEA0urTUJIhAQbht8=;
 b=aAa3v5+L85I1fps6yo3Q8mKKlL/e+ZSoj6fCQATbnXYIB/KWV+87lUGXvvTAr0Tqtj4JcdzumtzqLU7VL0VeIVtkCH8I6DFdSx6m1xIBzT4jxBe1eWL3k4rH4s8rG7SEW7REzjVCw2nob4IhayAeBh7uhyfxkHXNltf04QFll1mmAH7OiCemWAhDi266ttHHUQkWfrSz4k43+sbox2q71Nhw2rlmWLC9vrEs/7bDgT5b5jrEaoWeVbsylHNO2jfxmi5BLa+mLz/0fY74212yoO6VK9nkWGz1s5/ErqE7aSb+Dh9eQlqvECZGMCFh9uKOB/bM7xxVgs9gRzgVMHUrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=dolcini.it smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOebX4Iwt4b9P2ZZqyZCxJhhRDtEA0urTUJIhAQbht8=;
 b=WHLaIFU0OHc+92/mmbn9HLOhwjyzJzE3Hd+1HN5ODZcQP3/UAHiwYHJz+LWzs96RH1QgcZIrDUew/54XSjIq1QvXB6OMksh/gm5tiy3SeDB62O/5Zny7Nhy92Fn+zwSs4sYxNtJvytFskj1rLgKzvy4JvVQz+m5YB2btQ53MEvY=
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by LV3PR10MB8179.namprd10.prod.outlook.com (2603:10b6:408:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 20:38:11 +0000
Received: from CO1PEPF00018860.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::22) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 20:38:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00018860.mail.protection.outlook.com (10.167.249.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 20:38:09 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 14:37:42 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 14:37:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 14:37:42 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AHKbe3U498237;
	Tue, 17 Nov 2026 14:37:41 -0600
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 17 Nov 2026 14:37:26 -0600
Subject: [PATCH v5 1/2] dt-bindings: input: gpio-keys: add pinctrl states
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
Message-ID: <20261117-upstream-gpio-wakeup-v5-1-0e10aa2f7c1e@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794947860; l=2099;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=2P5YrY80AGOzDwzwjyekUM0MlCJCifVKmgKsCOCcW/Q=;
 b=8zNuYuMhOK75c1UjBfxxzCI4XcTLiyAwz0OjQu1nqgAGcOc6drf9NZyjDnlj3Nr4x2e36NVtA
 X26IU8+WgXwBwtxCfr+3+K/BCPMWh4K4xcrKawTLG4vFmFKutm22XbA
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018860:EE_|LV3PR10MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f25fec-5e68-4b4d-cb24-08df44eab133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|6133799003|56012099006|261022075727099003|261028144727099003|261022113327099003|10067099003|261021121427099003|261026140227099003|261009223027099003|261102123227099003|260925022911599003|261022105027099003|260925021311599003|260925021911599003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	WvvTqEubfFI4IxH8fM3IoGmUk2wkMjseYy/3WypiCTnFnW3SQ+xgSuDxAajdNaftdbby1isSpR0hfMt80s86wekWbLAuQX0pGA/Jqo15b6eGmCuq5rzjbsbd+o78LjdtXdZOxye1W061SNqL/hnKYn9iVeSpv/AcRQ8kBoMn8OPfEvoBikq/vX8LRTR96YKRz0VRTMTLUgYOx6EPHUT0JcgPgjTOh7eXRBEUD+5438tma+LzolH4AGuT6IB7n6lV6lQJogoIyQ5vEPQuoHO4rlbWBEnaBOhQ7I872Y1q5UwkbzzWG+KLLONcTe641Fvt6MpobhPI03VkGwa0dvWAvENLOFFwh6dcmh9/vwWOpVvvSRfKa5+Yyg698qOUjeQgiGUuKxheuzaX3xknTrzlGtwTW+BK23/M2VIJ1tZPDSgVUM5G7P5VhwuCwxYVTOadmtsgUwESc7uvJPAL5JYULfM1zBQg4p2jHFb0J8z6ELcbwYcOlVJUnTzHM+adTAWI5EZZrp9u5YpacAdTzLe8sG6bEUwnLEEVSKcIjT6gKLixb9FxKlZkW+8wbJQBcmUII9iByf2rwg688iPnyVyYMZFm6kXuqDjjmC/JKnpSsBkhCdSe2aZMD7fl+OsxZUSf8dlchDKJd534LZqwlKq33Kx1a/hi5zJiVudtMbA12uNr+LdQPuA4R58if1mGeH3a+gWPaCh/ulYxANBDS8+Kzg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(261022075727099003)(261028144727099003)(261022113327099003)(10067099003)(261021121427099003)(261026140227099003)(261009223027099003)(261102123227099003)(260925022911599003)(261022105027099003)(260925021311599003)(260925021911599003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i7goiy6WXQk6/Av2+vaTXiiw/bHInVX0p0x9PSsQ1v3YVsQ1HvYSga2oyFkRGZ7u1lvM1K+nOuYD5mzkVAIOEZ32DWleWuRHeXUsPGhag2wmvj+hB8Dfk/jxhBKO1kj4GUKCryWHwlOsefUDcL74lP/NPsLX79MmeNmmfJNNxQ3elZFV6fGRrq4ZQwJ3qyqcg9U2vF2RGY5GDHb/6fbUX580t8BBpCScO5OPPywVG0Z5FGPnhiRtPLJkBgbc1zGfQ1Hcm0kcGtyCRhkIs5CdxrigPtcl9X5TwLLKc4WzzM5xjV0A2nH8gUpeYyoRpKUhIN4WrAwqhqPvPXEYzG6l3v8qbeKUWFdk/Yg0yTaoC17jYSRA/ETbEJA2Ai2kQZs6FqyY/opemfkqJPBhsvuhBquuHL3wz0t8T07lP53kp3U94zOTMKKP8JLTcP4JUrHM
X-Exchange-RoutingPolicyChecked:
	bGMtSBP+4Z+voERpIo+kKnl/HYAvzExMOGQK/EpWp3IlYFya1jYenF+rL33fKNn6Zt+2LY1I0103loG4iU2YnEXQMw4AKfhybWc8bQ0VxVM+EvHb6m7NQi2CGeoEmmFOoT9tkmxk37RsfSTbY/uRzRiF349h1kbzt2BYYhiNGAIXUrFa9/9O6sEFc5g04SfG1e8ZcO58AdgAifz2aLbCRXUiYByT1oBgvFElLLRBOp1/60gbHfyEWExUhDs6AzFcvoyfOTqAQUml985kd2VA4o1v0osLQv08NtOTBBHiKxBtK2RuBEOiIqLttVRyMnZia68RYfYTRt3xjogj9Z9GxA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 20:38:09.4625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f25fec-5e68-4b4d-cb24-08df44eab133
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018860.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8179
X-Authority-Analysis: v=2.4 cv=bsTZl0ai c=1 sm=1 tr=0 ts=6afcbb37 cx=c_pps
 a=yvofFnGdSAaTKL5iNkS0vw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=wmc66NBkA1NQOucqkYkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fFgZfJGnlvrSA0ScFrwMGLUyOdHkyhd1
X-Proofpoint-ORIG-GUID: fFgZfJGnlvrSA0ScFrwMGLUyOdHkyhd1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4MiBTYWx0ZWRfXwjxXo+N3wDww
 ed7tJu3evYve0eLlDiptQAEKs4G+bRgqAWCtKFAKrAv+M7kMfQTJf/hBzl1X1TcmwWYDfmaOnaz
 jRba4VmB6t2k0hqlcQrSEQT5D6JM8MriTDIQggzXoKzaXSYU1T7Kf9iv0CijhrzLu0IMv7cGnhy
 vevDOtSYJbrZ+xrrnxcpb8sk5n1lsejYv2365W2PliFS4juh5pllr5tx975enzzJibmTRkIurDt
 P2oyMgFN0+wzwNSbVGg9QCLjBtTEZTMwBFWoHpF/RwYTwcWdDndsxG4oE4GwzcpCCtj0vx37LFb
 M/GH7eMo9kXOvPyce4OUXhhpzjKLayDLZHL+AIAIUuRTco9jBmnx3ATNqAMbg8pV08Ofut7RB/h
 v0cL2h7kcN8SDizTWyOwbuFxUOjBLi/XdvQ0C5KP5Ivz6Qrt/7xZMeVB/vvTUgayalMlmcWI7lC
 Xo8ofl1JH3lBw1reKNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4MiBTYWx0ZWRfXz/17TP8GPozE
 AWTZ7WCwG9Xbx+cQMf/U3j+yVcjdAv+bsHnbnpWBGyQuga7UrGqHqA53XSvrbe1408BWV2lyaNw
 b8W86fm7V73oPoix+46e4MuDS6iXSFQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170082

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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

