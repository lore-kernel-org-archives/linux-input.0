Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793287809;
	b=SuFMWJvNAIRR4UwTH57w+7BSH1F057M08B540uetw17HFkxZ+Tc/mRinrDzTFCJKmg7E
	 W11UlTMmjrxiK2FEpJrab2CQnFKnLSiSCqugaYY4vO+cNU9Y7WRltFOW6aOzYVHeYvSY8
	 EpP2A87Mpg5p2EBqKHnmh+rLQkwqaZlbFPoT30e94+pWaMKgfDINLF3fGlzOerfOpgFaj
	 ezbyxGl6JPudwWtaceA/h7SresW1zwTOR6jhAxHX6gwb/LZufKkCP0hkDj7w6RwG4BoME
	 yCS7duz97lxa/GNCCnEk3tRCZJ9ITwcEuNOUX31lqxlUXNFxsgwL1zDjfBJy/RAUYlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287809;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YoU7Ayu4k1x4d8SE7rPzOzwrG2g+UQxtJnFNExgnEZ4=;
	b=F4vudtaVZmAtOsvh4G/Gi3UWFJQG8mShs8XRF2Gc2tX6VhbVmPGK1UrdSnaPtDtbcA9H
	 TrUtWnQdCnkcgFCofDSb38LCTM2adIevTsgHC0B+kK6chDeGX43YmQIoDJaI+XYLXlYm9
	 kldj2msnWzw4YrwGvdFWUfafv4BWRzFALZ3xdTnry3T+tPUNwFKNnFfViI1n8Jw/lhMtM
	 AwMjry2V5W0nh4at9u7/s2K06hpu7ubHxH4XteFZT32jutsDeGXO4IjxlqFnl03ZwmmZn
	 ajcSDkMLxHI6Ox0kHvCDd44ax21/0ExfDCFo1ZaVsSZiO0vSZJK0ZzWJ5s78oyAa1UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YiJSq7Ux;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=pIx4kl+a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D87606A338;
	Thu, 29 Oct 2026 15:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D87606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YiJSq7Ux;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=pIx4kl+a
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69TEmSpA916443;
	Thu, 29 Oct 2026 10:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=YoU7Ayu4k1x4d8S
	E7rPzOzwrG2g+UQxtJnFNExgnEZ4=; b=YiJSq7UxvwLeDU3jQJPjGdNemRvFgKe
	NEfFy/ar01CRUtizrHnPpiNpKfGKh4doRw9jiGUVLKiwWH7lXFFP9gl0iWNyBD49
	cMSPQf+dj5smX9L5mUFdWIZfAax8Xw9szfYdbAlNBnVIFgSURQHXR5GHzAXt/yws
	Y/Q8iY3UyshIc1lta851esRefnPi2BnCfnmb7nxVxm8CZR3i4OdMSDUBTfFuWVEv
	T2YVS6vw65T5+zUtyxVupJ2rUSEK4TIU8gzyiyDKaTjooVDyTVv/xwiIgVs2Wqkq
	OYib1gkiWRM93aB5K53djbWzaI8j3TDMSMqbLevTJfnZBkMwG9EEP3w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hkurvwb1j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 10:29:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBYCIxJuQteTCo3iNlwNZWLzpzNbL2m6SQneEOQShrs42I6Z1b9hpesqmBHYyAuXbkQZ8g0kGQzvXWdvjoHsl5WyqSv0kCRirJ/kRmLVr3+lU/xkwHaLWk0P0V71vp7cB4vrj+GfMroA9XgXvlGGyF4Vw3eLJxKstCuNPiU6VbD5iYcW0Rb160zAqsXt7MNwjkhozP2IbTE2pfXC5XvSSqshptU9XVVtWIOsKIEsPfzEj3DmaDvExAoWZZ0hvlUFsvPGNuxJxmrR0KuoSp+PoswCVHADA60H9WYIqqyRkmXPUJYT1vjFOhtzgmk2VVpsbNrwn39xKk5bfXPwJAMk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoU7Ayu4k1x4d8SE7rPzOzwrG2g+UQxtJnFNExgnEZ4=;
 b=pUYUaNLFZX9zivyLyYrzOM06ft0BSmj8F6xSrANLGzG1OBuwLfx+StLNv3IIR4Z4DeAOduOjnWhCmZC3aHBL4YStjjfjXUZ+SOS5uexJWXUnkooR/+cXSVwU4QC5HztwV3Rek+MRLE82/maR0jIyhf0LQZBIGsGWjsI9a/M+rb0feOEl/I9pbEJN56Xkt3SITrgVUYEJmS7WhYhxiXkWDWWheL0jLlm1CcrSRxKjVhYtU2SZd0/Bcr+n1qY+a0GlUDsCwRN2uKeauJQqGCxgYIYUTtgmPqFWkHnVBrbcmaTOG9c2T/qQXAWJI5f053WNCDZF9u9rT1SE0FBxiyzNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoU7Ayu4k1x4d8SE7rPzOzwrG2g+UQxtJnFNExgnEZ4=;
 b=pIx4kl+ahSpdufwn1r+29dR4K8Hge8hy4LYaIRxnH99JDrjSTes9or7fwkvR4T2bo61mYLPDuIrnzTRuBRTJmnkN10YAYrv+5uh2Rxja+INfdUE0vlachNIPF/F5kVV28HWUCrz4tYiifxiSTPn2QuWr/yEIbzV/Jg3gXz/hDAg=
Received: from CY5PR19CA0109.namprd19.prod.outlook.com (2603:10b6:930:64::6)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 15:29:48 +0000
Received: from DS1PEPF0005344E.namprd04.prod.outlook.com
 (2603:10b6:930:64:cafe::16) by CY5PR19CA0109.outlook.office365.com
 (2603:10b6:930:64::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 15:29:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF0005344E.mail.protection.outlook.com (10.167.23.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 15:29:47 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 29 Oct
 2026 10:29:27 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 29 Oct
 2026 10:29:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 29 Oct 2026 10:29:27 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69TFTRPG2198262;
	Thu, 29 Oct 2026 10:29:27 -0500
Date: Thu, 29 Oct 2026 10:29:27 -0500
From: Kendall Willis <k-willis@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <msp@baylibre.com>,
        <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] Input: gpio-keys - support wakeup pinctrl state
Message-ID: <20261029152927.2sanhdhcgfhirdkw@uda0506412>
References: <20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com>
 <20261019125925.GA149024@francesco-nb>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261019125925.GA149024@francesco-nb>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344E:EE_|BLAPR10MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b95a4c-84ae-40df-468f-08df35d17751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|22082099003|18002099003|56012099006|4143699003|261026121527099003|261022113327099003|261021121427099003|261022075727099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	AbgPixvtHyl7PM8jvi8oqbRKSp/eP9il+gamvpvmDhxuwN48g+oMN701HdgjZrrWvWDvKz5XcLXFlvQgjrALT4OQuDDBc2ff+7D4O+JfsIGIBocMEshgrY18HfGkb82q5T2C9a5vUgMpt284K6kYi+sdsuQuLuDDSuDqc12Bj2RX0bxmnD69bAafLNowGCmA3WUj7Ai8wBK1A9HjEzkQd1ENRQ0XCmKxL0bjQN49lltMi6At6o9X1e0PDoc1T/8oJDCsRgDzipGvOy3qVBXvwlth54c0+sO1tYRaCMz4b8ZGz8qETWHYyrRY9n3lmBBpLIJaQj98TLKM1r8TJEpPP8UI9Xmi3UEHR3JoKd+9FU1GP85F2Bs0E5BIYDhut/oFntyr+WhgdNrqfZ3DLFPQ9vvTeQXdW49Y9Xsmye7/8Bv+dWCFAKPEMW5BXhFQS9JvXq6BbbHwF95wnGNKsMBl5TGTrY4dFY7j/QwZ2kWgsjMCH9UuWVEnRwohja9Wn/rbPqVMqIP8a1Gg7MhJu//SRBlqvnhiZcowTK8LkbKFiIcIdQfo8c+wQ5NuEbSpdgKuKxzS165kUPqZ5EnmidtD4COQVoRIYRKko3ldYzJ5wZjheDAnimxUJ9nF5PjvtNt2Mcm7PP2Av2NVgWzXvzkQ29LeiJrVBciog7re8ShwJyE=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(261026121527099003)(261022113327099003)(261021121427099003)(261022075727099003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8jDWHLMVWQNObZH6vDemDdRp1w4aYSlr37jLxS3JfkVGQf5RUIGsB1XKTNte/e8DLlL3VORnbpQkI6wktis/nLIHPCvuEEcBmp4zkSq2dNWIUYWzQPTsjRbt2eczg0o1RrzWvgI+/RoFOvzxzgohtIEQV0p8+GFLGJGHv4OHFsc45berdjr4FSgJDQrPAsPBN3IwF/UpgbPcs7Z/S7iVKpLdChRuDjehrSlEO9nr4lja1qNifNNy8EYCYI5bXHwLfgcO2aIb8PC3lttZhr9fE/tGqyPZwi+yjls56wCiM/ZOXJd82QHIG9ac9UJRGFgOyjllAZa2WjTGUkS/AMtVhE7JSZ5euRYZ/ku1LxbroFlV3eywZM3Qf4qdCNWaQHOqT4IYwxKVYNrete41hp/20IyWzdLKHQEyovOfJEjBdw94fC5wzZqcnu5VuP4t4STa
X-Exchange-RoutingPolicyChecked:
	C/u950m1dcFuS/UNcWRuyMfNXV8scXf/lGK4ztRPc6mp+b+dAYeGBifXMinfQtJH+GNwaEKWElpTDQKEe+KJKlAWhVfNIoBOi6R+MfCAWB1vorFA8aND4z9B0o/TodWz8cCuFp6zad1HxWgJZakyO6JemUZJxn7Sbu/6hgjDfSim0qM0kptZMJuZhYeVt3lprbd0nr+BPWeG8JiUIaMLK+KkoawMvRZJ/cRyRcea9j01CFKTfypM8owwxxRC2hHi89F0K465bC50oQ5+3Lv4dLVGY2BRHFCUrrJmwaWa3ydq0G3cBS3jCIXW62Y0OoJiBxNT4ERmTniZdfnMXg4Rpg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:29:47.5145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b95a4c-84ae-40df-468f-08df35d17751
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0005344E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-ORIG-GUID: EC-tDQW6UH21GRnJrC4lP9hrwn3bjVYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfX3IjcOvzZQM1Q
 sCds0UrMbjbmU9JXBzWieMrdtWXZgbZUON7arwzUt2jl0vyqUe3YNiF2aFLU3bEYp8+vBB0gPBQ
 D0ctFdnaw7jfRm8tBbsV0t3nkB39d6b4kK1lr0ArA8q5kWXEH81Mo2LIrfThMDBwxTjcKzPFmw0
 suyf0VJtDIx0K48Ndgps7jaYqgLmSF0NV0yax8uEL5qir/empvElAp9fz3fHqJ7kQSzYH82KyUu
 juz+gabsE8RasSCJgome/7oz1mxgRH0cQC8ad48CSiLinZvlI0suWWqrnexUrVBcZk67VPl1beX
 6/hWeMvXciKyv22xD+spfbi6Asb6YnYpaG81KF0mLwhBp2EnkKIj8KjmmwBLFoVBq9zPs8bfwn+
 3WMe9Kv4fa36JPM+l5w4miVaIx9YvvYN4Uhz7AC6mVqb+hsNL5tagGNqimA95vk9cVPJg268/Jv
 i+LD3RLzpYoOLfFCsnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfX1jNoe8iMNFuM
 Bsh9+MqtYv2iiNJv5W+ciGoDX1HjQ8gzkSuN1g417lqmEMU/wboabxhJKchBsaSXIor/ilMYoat
 Wf8k6riMPn7xp5VoQLaEORYX5fiKTFY=
X-Proofpoint-GUID: EC-tDQW6UH21GRnJrC4lP9hrwn3bjVYH
X-Authority-Analysis: v=2.4 cv=DtrDa2/+ c=1 sm=1 tr=0 ts=6ae3666e cx=c_pps
 a=5LsHMtEjVXEroYtotTqlkA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=wLaOW_Snd1wFKdABpi4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290060

Hi Francesco,
On 14:59-20261019, Francesco Dolcini wrote:
> Hello Kendall,
> 
> On Mon, Oct 05, 2026 at 03:47:03PM -0500, Kendall Willis wrote:
> > Add 'wakeup' pinctrl state to support separate pin wakeup
> > configurations for GPIO. Upon suspend the 'wakeup' pinctrl state is
> > chosen if it exists. On resume the 'default' pinctrl state is selected.
> > The 'wakeup' pinctrl state allows wakeup from low-power states if a
> > specific pin configuration is needed.
> > 
> > On TI K3 AM62 family of devices, the GPIO controller is turned off in
> > suspend to RAM states, so no interrupt can be received by the
> > controller. This prevents system wakeup from low-power states.
> > Alternatively, the pins can wakeup the system if a wakeup flag is set on
> > the pin by using pinctrl.
> > 
> > A corresponding device tree patch using the 'wakeup' pinctrl state can
> > be found under "arm64: dts: ti: k3-am62l3-evm: add wakeup-source for GPIO
> > button" [1].
> > 
> > Tested GPIO wakeup from suspend on AM62L EVM and AM62P EVM.
> > 
> > [1] https://lore.kernel.org/all/20260912-upstream-gpio-wakeup-dts-v1-1-2057d76c63aa@ti.com/
> > 
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> 
> What's the plan/status on this? I see rob reviewed the bindings patch
> (in v3), but the tag is lost here.
> 
> We would benefit for having this merged, Toradex Verdin AM62 needs this
> feature.
> 
> Francesco
>

Thanks for pointing out the lost tag, I will resend the series with it.
Since there are no outstanding comments on the series, hopefully it will
get picked in the next window.

Best,
Kendall

