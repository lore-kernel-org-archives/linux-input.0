Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795018781;
	b=TDSFdDM8pw3xAFEQcuqRGCeY3eYQZCavJb7Egt2SFyTl2Drx5kT395jom1irR5AslNPL
	 UZKxnA2DnL77oZUvWVkbo8apR8mDPe9TKMLZIlOi5lYwTRRdN0/saPrdSAU3sGA8jcHgb
	 iqTOcQgzPox2gg5EoI2ny6h+2M+AsN35Wcs6YK+9TGrQl+VfdSxoXRd+Zx4tSwKB8FMUC
	 2IDe3a8bGHkFajTYojxU9DGHevyVr/wDzgfs0s1Q8Rt5WCWwnBZrp/SHibHTO5Uuc3PBl
	 Uw1yQBxwcHwCUlTiqtJuuZgdnkidJD0ZkgDKkiMLeyIpmA7IHbt+lwFSpLBpap6rtzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018781;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hVTRo1R21iMOgHN98MXAKL/sajrsf+JVIHRS/bHydBo=;
	b=dmqJYKisGrwxKwmSrn5xO4GcAmAhXnRh0CNgf0cUQybWmgl6xLma6GP3V7fDdFIaLdVX
	 KeAKUeATGAAMyxZi3EukxyFHfmK1u52nZCmLdKwgsSJvOTFjJKV/888NGjzIqUJFGyDc2
	 pyoar6OZ+KQuCEeh2TEWpiZRABbCKvLwM0hb/PQDBGLqSiW0IegV4FH2cJMDcx17d7Tmc
	 G/ngNQseO0Us6EBm+HWcOMMxbVwaD0TccC4SmjMcPgZC3IhAnTRqUCoXhcIxLyLBl0qBe
	 /vcMi7ElwYmzC05k3dgusAUsyn4tmhkFnzb9RYpehYzLlZ6hy+tjVGk6PM2iEVoQbkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=UV8vzTqL;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Rz3sjgUE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97BB606A330;
	Wed, 18 Nov 2026 16:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C97BB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=UV8vzTqL;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Rz3sjgUE
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQ7X13179734;
	Wed, 18 Nov 2026 10:19:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=hVTRo1R21iMOg
	HN98MXAKL/sajrsf+JVIHRS/bHydBo=; b=UV8vzTqLOMAQn/ixRtvYy+Ens5N9T
	EHDaz+7USeeEExq+tvyy/0wiYFD5YhYIv/C2ynKgNT9u7laPiDzyGzv/t79KGj+B
	BWPX/Kmm1zKcoYKMGDX6IngzV28yYycmIm4H4STmpMfYPRZ1Ry7HVRB2TMGKXToM
	YObqpYet/WzQwCEfcBDPChdZFBsAMZX0CyHQeM0q6Me0mFoJrUq8ebl2nNA5BnDW
	VgNqaAT2YhEBx878diM3fmoC2daWDw4HJo8PmOwf9FkcOWaSgsEYvRCU2zjD2ll3
	pWWQ5zj0UsW2tetJuT8//CErh53tLexX5HmfnVInjVVEVom9fUyYX28Gg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j19ft29ek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 10:19:32 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYiXXxCZ3P3Hx/7d5ZM7larLt+Bfd9SwxcLKmQJo9lrIn2GeIn7EL0BEm8mB+EeSApbmhy9GHyyrsKjsbuZrZ53vpngTJUfoIPE2fR8io38bIsqXKLDgjKjIWESRIpWJYcJVP21hPZoN0oPCIxViymDIwDn/gEDOV+9zr//4WME43x2R4SgdZe8tnLBjygDV8rZrECZI8z0j/+9XG83ZSbtjnOMpzvhVgfW1LaivkRxNXiYw+fcWcLF4rkwqCvWdVMnmNGaRH9nRWvWj0VcxZk0Y7Ju3w6F8QEWDEFgGVVjTDc7P0BPMz69Owm+hbacITb4UfqQY7lNlh4QSOAi/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVTRo1R21iMOgHN98MXAKL/sajrsf+JVIHRS/bHydBo=;
 b=q/j/hiu9aX9lUUhyK4iCc9g4nbX8XzlMoYJhv+1hr0BxD45UEtVHZxwONbcCpRTRPSL6pi7ygi9NwhZeVOeomXCPzEHot/kKrdSTvjq9Qxtg8gSfXd8oXtWU3p0qXcmVXWfqyAande9w8YAPxmINQWe9BTnGZ3V3dXq/Us5hJWVyeISAKNtDFBuHf3hq6wKuZcGlTF9GKvc/scgTCNScJ5xfdZw5vB68WG5OvZ6q8fWI7naRbfwDY1TlUksePy3JhAcdCOVcSOAAXTaHQimZqnbz5fQ1pkeduLiJH4VUQ7CyYZWcj+TwRvdrd4ZD7XZGdevrDcTh5y1Y5Fjr3kKwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVTRo1R21iMOgHN98MXAKL/sajrsf+JVIHRS/bHydBo=;
 b=Rz3sjgUEbQrNws6WYknolyf2SWg9p2gw4G6E+e5yxMynnEOevI25aJVfkc5Mu8CMUIgE73F5Dv3sGGfFlt1XzumpjmoRBftMhYwNZxO06QaWxYUIlzIgsbIbijRKH+f9zG7yji8lc1Sr1g1g6FnIm7fxwLAIOVU7tSscTUiiczI=
Received: from PH0PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:e::12)
 by PH0PR10MB997666.namprd10.prod.outlook.com (2603:10b6:510:382::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:19:25 +0000
Received: from BY1PEPF00026969.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::84) by PH0PR07CA0037.outlook.office365.com
 (2603:10b6:510:e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 16:19:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF00026969.mail.protection.outlook.com (10.167.244.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 16:19:23 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 10:18:32 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 10:18:32 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 18 Nov 2026 10:18:32 -0600
Received: from ula0226330.lan ([10.249.36.95])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AIGIV3l2330484;
	Wed, 18 Nov 2026 10:18:31 -0600
From: Andrew Davis <afd@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew
 Davis" <afd@ti.com>
Subject: [PATCH] Input: exc3000 - remove use of i2c_match_id()
Date: Wed, 18 Nov 2026 10:18:31 -0600
Message-ID: <20261118161831.232721-1-afd@ti.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026969:EE_|PH0PR10MB997666:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eedc876-b252-415c-5cf2-08df458fb550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|261009223027099003|56012099006|261026140227099003|261026121527099003|261021123027099003|10067099003|261028144727099003|261022105027099003|261021121427099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	oIrItxVWTXGbfy4/5a+DG+6GOUAP28l0+3h9pyMG8M8g+aepas8ZoYUB3kP1dNJ+0Yj7OpsJJOenJzFJ21vDvgFQXoIfc7RhBatebbTjXdux9yKhqQTwohgeVipW/oFI9aasNUqm8VGtXu8D3vBsrrz5ZKyKZWiWYlUFI/FztcUyenn1zT9a3e2ooANQyXtay4Hbh/5JHXdSxOz0BYyDJszvgAlHYDWssNDtCd4OnuO+iF0+HmC64qee5LOO1dfbff5y6x1vjywnVLEPw68lEpWbqWygOP30tPuYLIjC1LEbsHSePFkN4ajxGUH62jN2YdYh2UyHPUlb9gTqYo365wFVSWCdbFgWS0QPdh6dI+cnPkv1kpulizFyVtFb7PoMMHllqOCKB6x7lJWEuzMHYNuzy0s9M3COT62Ph/kQM4SXHOhO6Wd5G0XU7R8NfT8z+eHMNkBsCjneQh3yxh8IarVomie/dGjw1EVGOB0kFgI9N1eZyEDbuEZS0BC8D0da3ATIBhAzH3YDfpsFv0okfBL4Mjmyi1zsMTWk0ecianrWAtPy1G0pRsi16ZoEQooBGrz94UGv9ev8sGClpPjbz5VoSRASAKau2zPsKljX47p3REowxsbJ6AuCFjPJNa+jEhy2hUG4XJuE91F9qQmxqwVeZFHSv1FFv11OJJTa6EXf1Msq99p7L2o8STDMblH6NOCMeBJBLQhJjjNaeuV7iA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(261009223027099003)(56012099006)(261026140227099003)(261026121527099003)(261021123027099003)(10067099003)(261028144727099003)(261022105027099003)(261021121427099003)(261022075727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	78ZTpaS+wxfQJ02F033glxV9R6Du94RMpuzvFV2PHZOwVso53l8dsdQ9JYv0rnyw5yxmKVzNYVPMACOyXZmOtVuZw4IgOWsT/yRyrRBiGtWbtZZaJjKcqxvwIP8/qkCwfJAA6KSjvdsBNk1GskJIBjkJv1n4Uyq/QByoaVY3ydKE0ftCmUjYT1DZRVQlAlC0irnrRqvb4mX4zcmrK2g8Bn9CmXkd9+lE7IE07SWF5TjyAW2oHkXwNcaQMqNn1dr+Ec62quTKvwsIDBfuSZtb3Mct8eOjOF0AH85lwtQJ3g/wen5xNr2rFv+dTrlZRPPoT/CpD8n+6EGBTwBASvlaYMMh8Mfcyj8s1my3MoRnhn6QG85KXrzUemtJcpLm81IuZ77OxOShhaG07OFN/gaZts3zX0DxNfHYtJ6OBgwy6z+JrJYdXiK2nVEQot+xgzld
X-Exchange-RoutingPolicyChecked:
	E/LpQ/iGj+YK2pq3WQIHSWqk5y1T1wJl1jL1IyCO2mrbfP+YxgppJdNS0ZXRaSM0EKZ3bNujvV69HB73ozFPCKNL/jxW9Rc9lbcEfNfawf2pf8TQVEmfjt77E8SLyxwV3Dpy9EWerIsyuyc4l0qfBpQSM5PwBPntqVmo/MkjETr5b7G66ZxK63UiW6du71TApULYvbN6QOrDXU58qK3BQXzkU4GIGGANZ9JPDSmaLFzr+gqHYRJ/lTcrqtMvIWvxDzF4Lg/ixv0A4WgtaypNuHXS2Evx+r0O3k5nbzD4m0xRXyBg/xVdmo0lzVOYyvJK8pEvJaO9i4rjEyIzB5Z9SA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:19:23.3091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eedc876-b252-415c-5cf2-08df458fb550
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026969.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997666
X-Authority-Analysis: v=2.4 cv=NMFAaE6g c=1 sm=1 tr=0 ts=6afdd014 cx=c_pps
 a=9jnBlOlZf5MLgdYWwawaCQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=p7Iin7H2JEfblOv6RwMA:9
X-Proofpoint-GUID: UFl95UjYKwZYogNWgEnbckRru-U2XgCv
X-Proofpoint-ORIG-GUID: UFl95UjYKwZYogNWgEnbckRru-U2XgCv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX/hAgkM/WLmvT
 NFioEfR6pK/ZMeUz7eyvK2bI/V6AzFHDPLLf4G03SD867f61Id8OrVHb6WEetxz4HzR+EOTzAw2
 +8S791+C8fMuazr3pAiRkGZbhzMHxNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX/XxOD3U7cvHB
 iiW4xhqErw1nmlGBdLsbQXQ6YjR+AbQ5/barcYrcvTyxcFmrIu5Y9FzeEbtYsDRzuOizIDjErR/
 o4uePfJAcTEP80QXfTC46tgD104AAJkHwtDfS+fhKA6+tKHg/+OT5LV3tXdKNISTj2l/00kG+OH
 5aL7wrqPsN+arUYO7nEr2ESZXkFaG70bynwpprdhhB4aBTNKMJPlQqUnl2Sq2zShAGyqepxamcB
 eV2I/1givSdM1Zh/ivVi4YuWybJGZWMaHwE8bkTFlGZXPO3M46uVb9YJ+0hdz+AK0XgSbnlsoFj
 lNdm7BjwYCETeFG+OaRD689hweAGHnmXDoC/eyBFDpsTbHac8Ykf1ptrl69t2exKkK7gmEZjerC
 48anbUzwF/A4Z3ZE1fmxQzpA52Ltkh3lsglrqDE1UoweJMH9y86UJWZgvsNhjp7eC2KjonJN+Gd
 Ev2+OtSuLwYOO1Dw++A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180064

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/input/touchscreen/exc3000.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index d6e0c5183a483..f8f865cd4a9be 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -42,8 +42,6 @@
 #define EXC3000_RESET_MS		10
 #define EXC3000_READY_MS		100
 
-static const struct i2c_device_id exc3000_id[];
-
 struct eeti_dev_info {
 	const char *name;
 	int max_xy;
@@ -338,12 +336,7 @@ static int exc3000_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->client = client;
-	data->info = device_get_match_data(&client->dev);
-	if (!data->info) {
-		enum eeti_dev_id eeti_dev_id =
-			i2c_match_id(exc3000_id, client)->driver_data;
-		data->info = &exc3000_info[eeti_dev_id];
-	}
+	data->info = i2c_get_match_data(client);
 	timer_setup(&data->timer, exc3000_timer, 0);
 	init_completion(&data->wait_event);
 	mutex_init(&data->query_lock);
@@ -432,10 +425,10 @@ static int exc3000_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id exc3000_id[] = {
-	{ .name = "exc3000", .driver_data = EETI_EXC3000 },
-	{ .name = "exc80h60", .driver_data = EETI_EXC80H60 },
-	{ .name = "exc80h84", .driver_data = EETI_EXC80H84 },
-	{ .name = "exc81w32", .driver_data = EETI_EXC81W32 },
+	{ .name = "exc3000", .driver_data = (kernel_ulong_t)&exc3000_info[EETI_EXC3000] },
+	{ .name = "exc80h60", .driver_data = (kernel_ulong_t)&exc3000_info[EETI_EXC80H60] },
+	{ .name = "exc80h84", .driver_data = (kernel_ulong_t)&exc3000_info[EETI_EXC80H84] },
+	{ .name = "exc81w32", .driver_data = (kernel_ulong_t)&exc3000_info[EETI_EXC81W32] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, exc3000_id);
-- 
2.43.0

