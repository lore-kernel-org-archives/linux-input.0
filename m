Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4436402E;
	Sat, 12 Sep 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248875; cv=fail; b=uAktgTtuOo/CsS2f2hGV6lnRyCdDu0KylkFjw73fj7FCSeZyjKyTPVavALxGZtNcFIfTEHMCPv0WkAiXnvL+3ShcsnJ1UoteJH2Axt5+08GGtUIUwdagUZ2dQ20Mfa13eqX1slqFJjG9faqagjRuwvvyElf+O4J1/3G4pTS6/LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248875; c=relaxed/simple;
	bh=IwpX1ujSVwqdH7Va+HD0cKHNT2GcXjTGL+6E9gnexSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rPXYxt0X/yqsDn1jm0oc3kjPg+tmK4lJ7pGIzVcinL6WUOVTMuoDEznfl26JHZ0GPOzHNaUz9YQfwneIGf6fhWtKKpF7w9cwWCaUSeW+v4EDf3cIpLU3EBandLAz88oTHcvh5vlcajTM4Z0ooCrwkvdgEXd6yVh044cUe2qW6p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=IaBJFEac; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dDSyOjY+; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="IaBJFEac";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dDSyOjY+"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68CI1aax837180;
	Sat, 12 Sep 2026 16:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=W17uPpUDDO96ZPMxkfEP3BbxPcxhXdSW0MafOip4T
	lc=; b=IaBJFEacjRh99CCbFu33V1DCvucRzHl5JqEVyKQd0Hl15yuroZkWd667w
	c2IaLHyjAXM37jD881LB80VAcAbczCIN5ZslbPtf7n6uAIME28MgrnHMotMuzcnw
	HIHIL6cjiUmugKELX4ujCXIPQb2KzNlqZKGCZDlUFU0hoPr01cCsTIZODDgwG4lH
	ZR27kjtAK+w4NAr+lyUEf6HLXHRBmDv5TrwzBPrV5XRv+mVuS8IwhjSA4+v/Efnb
	yOqFz6fq1xe6KWgfuj/9u+GM5Awso08UfMUbieX9TaN9x8GHlXLF+Cg3AhZoFBc8
	wOri6WDepZu6W2bM+umoN7Dp6SuWg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gmy5db607-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 16:34:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cihefgsTpXGwTkIym9RRC+VHHlXa65D/YRzHU4U+F38QJ9AmP4mswp6LZhdSBct8m/qW/k0udxV2/hlL0NxpJuARoFf+h9dWZYvifPlFnxCwSzCf836ZeLZLsyTqY9WQmREvTReM21ERXlx4cM5ejisEKNGkq4YjpEbrv1cATnU/3jWdwuJKdvJDP1kRWobWPaAHhtQg5DdY+J3A23fn+pUO76G2SzDRJ2ZRzGwHKgEnQyvripHbgELrkqmzqOt5QMeeiYktYSqGrr8n0eGe2lWOa1Ld0Eoot3NzxyhsZlng/UDOCSatwz2RvrtB28yyJcxWrJr7m/FSniO6yCjWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W17uPpUDDO96ZPMxkfEP3BbxPcxhXdSW0MafOip4Tlc=;
 b=fQme9MGT8QwrqTxyeZuJmTFijA0FcenfKJUYPXOfE7imgUJht3lIflm195VQ/8h3FJD01g0nOX/juj8NnO28U19h1ebQc04PHxi1h4qkdD0IU/f2hKMHz0EDr9pdvfs4NW6nM97SB/pq9TjX5CO+17jODscdxeIPNjnmq+DIa7OBQ+ol2MkyXy+FvMC3YKvXCnHOI8Bl+0RcPYRB9CuoWm4nRmBdEurPBRPC4srwYcN03/PmLOumSYArs/yXWv6eXahj14UfJ9y7VSg3sWY3iy/Pj6hk7yUqNa5wJ8VbVe5G0R3wvZSOSVVnWS6p7tmG2XIzq/Qpu5yYuqn0MmHrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W17uPpUDDO96ZPMxkfEP3BbxPcxhXdSW0MafOip4Tlc=;
 b=dDSyOjY+OWvIIyWz6qgdyYUsLWK7U+pgCyxF19u7yhTduZUc824GCuJpqhotmLi6Umppn1ZcjOLhgpChq6eJHj7z3irEM0qRWHC+UHlwdGYi6Mols3KjDZL21Sbp8irh2wHbfHTZ9nPzhbZnFZz+w4xsuKolf551bu5rIndRZus=
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by LV3PR10MB7771.namprd10.prod.outlook.com (2603:10b6:408:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Sat, 12 Sep
 2026 21:34:25 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::24) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Sat, 12
 Sep 2026 21:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Sat, 12 Sep 2026 21:34:25 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:33:57 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:33:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 12 Sep 2026 16:33:57 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68CLXvl22513366;
	Sat, 12 Sep 2026 16:33:57 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Sat, 12 Sep 2026 16:33:54 -0500
Subject: [PATCH 2/2] Input: gpio-keys - support wakeup pinctrl state on
 suspend
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260912-upstream-gpio-wakeup-v1-2-f0e12484b836@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789248837; l=2369;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=IwpX1ujSVwqdH7Va+HD0cKHNT2GcXjTGL+6E9gnexSc=;
 b=sAa6KnVxZTwGyPdS9zzaAvNEgRrnL94T4XG9qXz6WjeBZx718aeZbI7om18Ls9UN8c5pVKZeJ
 C1se/pc/wbeBQPUdJKxDyUhbveYOOCNcQj2GaFPn7B0ZNSlWDrk4+yw
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|LV3PR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 7155e07f-125b-4015-3bdb-08df11159df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ctBgiD1xz8+Q2XHUNdtf8bTPCIMhBPkwcgBOpSdq4ATV3gjUdir0piC+4Fam8xj0kGfv+LmaG5dhZfbo+sx2RHAU8EDx2fw8Yd/hOlBhYQRQ21BFDq5l5CVUsqZseNG0YQ289fCNJBqhjUIRwqTk9qKL9hCn48Rlk9e5aLX4Z/ekIo6CQCCuuvdC+XLw2nltysNx3gKR32+6TsNAVB09/hykiVpDcmByuAsaFFwf3smppUhG56yvuDtEesJr0QnfrxPtHyrYVDt5SuScVjosdSIjRs8dRaXVrQjjLxwv82g6Z5hnnWZ5A/ohTe2vpV/k8fJQRqC0+OYyfeUxfj6GuUyQoxwGUHqgWsGFM7ElV0cYj2ayrfcS0R24+GLQJWtddKR6gu8eN41pOMGqnOthcTZwgdgA0R97EPqvBA3XxfZgIYe2FRWD4fPn6aZDJFWlYm3JVSJdWNRm/IAShUNeDFLtiIa5o13qDLWNT1XnOKupzHNQSFZzpVQL9iXETa7ju6ETOykhcEzXHhldvCglM+VeMYHkQTyAO08pUWUimDOBSL1oP9ZtbA7tPyZUpQkqbYZop00sS+emMBcVIFjoQ0B68uU8YvvGEFrdb2k5t2Bp7fYhU3kI7xGGR/2SHLyews8FSi6jC9qw+pEL6oxVNWhLSYq8PXfltBM4hxXxYkYi5MvnIviPx1yp6VEP2fHpwElOxd2rX9HLuN2d9JV4cQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q8vMj1Z2PiPl9EpbXdy2dPOoZDKa8XI4h2yRqBkc0n8ATbJMH1rWHqBTm+Oq44ucVvLFN3vNTDtyZhcofU5ftHbxTZOh+a/Dfv+elMvv7CQbk3/oEgpI3dmootL5ZU3BpDAY2q9uDXXUH59XZr/GERkdzRl/CGNpIi6YaRyA1n5SP8AA5CY6zHKEvJTqyZmma5j3t7X6lbCI2kctG7q2d0Zqqzh0ijHHJ6C+T7i+W8bi653aHp6qn+8i6X/huvZMjEuND1jli6/yYHJnkyLK8eHQfeEZcpn5wzyATEr6NBBf1VtDNZHyScDNSSqrCOMU23hwPNUPIPo7LoNeIBLVPLEP5OLKv5CRLRkCi/psxUl+AABNNNe6iQOTDadX+IhTUS7/MxyubroNIsY5AWMeAp+PFtUAm8XFx62jkT8BOW7o9lubsRzAYOd2ofQl2Cec
X-Exchange-RoutingPolicyChecked:
	fWUkEqP1wKsLRiN8VvQGgC7yJqWlGmzkUM+DX0O707k+eYHj9EvjkAdwQUD0ZlihNKr1pTWpejDbwYkQ0MUK15EBZKFf6SAxuzhPM7cwq/ZNAR34kPdrCCQKvE47zkAx9m51jw+2sUfp0V0dZbwCmz7iMtCAy/SPfkenHxlSwKsW9l6J7hKHXk57rPFJuHLz2NlO6PJQMon5UAwH2ByaXiHOlOyUfSnIdn9jMbTDLp4eqfBKvJJmrTfRpea+fMOE1pquArVp2+fxlVTv+AYzzKnphK1nVtFdwiKUUyg/7VcyoZnYApeFpqX43ANiKgGN47zX/0b5n492MdRVOjCEiw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 21:34:25.1601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7155e07f-125b-4015-3bdb-08df11159df9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7771
X-Authority-Analysis: v=2.4 cv=XPal2ghE c=1 sm=1 tr=0 ts=6aa5c565 cx=c_pps
 a=QTU/OWcW2qKRxVucCLrmDQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=OP4iwnenC8Is5NdNPIcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxNCBTYWx0ZWRfX5qVRB1URv6wK
 5zV7BBB3wSp3fhPgNiYx6jdUcCV64ikRUajHX224VO6Ptz2rg1v8pJb/V+yK/+hVlNtUHSc+xmO
 jL2UYIyemkUmfB5e318AQbL0yM9qKfwIyoEX86pBE0eM3lLc8cHZvP9VXrkEq6YOGOQ56l5fPGz
 ddODzEiehLrBRaecD3gsouA5hdmLLEEsRAIZmY3MfgoW2VALMf2cjyqukRf04jq/nnJA1KBRE0n
 e+EZZ8WWG6L2umHVBD/LevkJBJL0VgwzQ6E+4tzJ0tSr5/Z5ldC/si+5gn5PWwk9lc2AyqTKtvE
 j0VDa4gaaYzGkEkrH9tnVyu8DTWwUR2qUsclBfLWSxXpUtP1YIrkmxGAR7x96NDB9CfLasbzQy2
 AHnoIbWkZ+Pu4YPz5a6g9+b/jbEl0v5oQvcQrjDFvut1q/ZKXzkMACExTdRTFxiHAIhKpqVHKPc
 vj73YLYhZbwaQN8Re8A==
X-Proofpoint-GUID: KfrAjRNyKCCAaNeC97hH8AeJ9TXnDwbM
X-Proofpoint-ORIG-GUID: KfrAjRNyKCCAaNeC97hH8AeJ9TXnDwbM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxNCBTYWx0ZWRfX2zL0ft1jFY/y
 A0cOIQLhcZYpFFgjIOFR99aQ2VFVsz3TmnOSt9gSwigpfStBRh+cKNBOU1MJNVjrUHCWOY2Fm+0
 HmR+G9uyNB+CYbPm/Luu89VXaFho+LY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120314

GPIO can be used as a wakeup source for TI K3 AM62 devices during
suspend to RAM states. The GPIO controller is powered off in these
states, so a wakeup enable flag must be set on the GPIO pin in the
pinctrl in order to allow wakeup.

If the device is wakeup enabled, select the 'wakeup' pinctrl state on
suspend and restore the default pinctrl state on resume.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/input/keyboard/gpio_keys.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 129fc4212a5ed126496b331ce626682d441c53bf..b409e179705195e5fec172ff62088395109cd758 100644
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
@@ -1010,6 +1017,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
 	int error;
 	int i;
 
+	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
+		pinctrl_select_state(ddata->pinctrl, ddata->pinctrl_wakeup);
+
 	for (i = 0; i < ddata->pdata->nbuttons; i++) {
 		bdata = &ddata->data[i];
 		if (bdata->button->wakeup) {
@@ -1039,6 +1049,9 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata *ddata)
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

