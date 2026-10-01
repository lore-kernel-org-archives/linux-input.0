Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62783B3BF3;
	Thu,  1 Oct 2026 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869889; cv=fail; b=Fkyh5XoqWR3W2knRuY81tUhW7id/KuRCOn+UAvEN8fr5PH5hRtpX1hUtRFWJ8zUyAqsFQucvdaw2reTAAt6UXpVQnsPEtM0QfUWe8OOA/y8WvQLlbYe4UwXE+BmVud5DXXUKQjh/iE+qc5s+3zgMKfryRPGvaufRArLVlk0jmt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869889; c=relaxed/simple;
	bh=iyYMJBupqZzTSSdCw+T8hzFfyxbWQdqVoxcB0eGXnuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KOXOBn0WF6qIPzDO0LkJ+KhBVfbMhkkm+YVqhzfWVnkywzCmTYtIB21yB2ifyOY08+YzumJHuEa0oC83h7mwflaVX78W7f1iLAg9oMomLGcUe01wxMKjsRDABjCLVsARzcQUA9bKSlX4pqLGahUCLEwIwCGYq9yph6QcvPQSn7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=MLJ9YjW4; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=TzX2eqQB; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="MLJ9YjW4";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="TzX2eqQB"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DkXsi2097970;
	Thu, 1 Oct 2026 10:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=WFP/MtYvcgTzyyw9zM2l3BrjDijGOq2Xf+aIVoDF2
	iU=; b=MLJ9YjW4mAbCPWHHZ69gxiDFr3XiSck47qRjZQBNXA1iu8bngdGSYiOM4
	EoONPGzKy95sKoC8VBticQHqLzoShV1lD4eJWla/wMgrz4IahWnV0MRCFXapPAWB
	TWXNaOq/2yy8QqlIHK9xAebc6n+xVpqrNiTx1zB6ElOCabl07BopAck6FBg7YyGH
	BKdUV1e3Ql0XuzgdqOQHX0EbPeX2uClIS4Q2vMKwV7MuOhS024WGDSl6xNuxo4Vl
	cOw2mMBJgA0PLyI57HfV7RiaIidA0D4SzC4Lullgg+zVdSDOL4zRTOkde+4Tl6v6
	Hm/h3kFJgvV4yBneok/7XBNEU4r6Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h1eurcadt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:51:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7zsa193QvWJaUMz8OfsLTLACEa6sBquaZyIq8l/T7nPbigpinVt1bRltEaZAfHMAkt30chbOUvlI9Vj3v2uV45FOyetmysddxUhG9uE5JpabByfLBJ8X5JcvKXES9Gp1xxZYr2yE1nfBdMRo2T2qNk+lmC0STft6r3D4bhrWYGddQdGdQ15jL2xmsT1ReyfzpQajm81rcq24+nxN9ci6XH5vA2r7PZsdkdh+5jIvbh+qw2YFd3aDKHknafXlcxgVFQiV8kCKnUhZY88HeBEhJtW4i0lkyR/gNFN2aUt/OT+I747JJQSE7bG4dgCYStHIXHkMFSyOYMN3IiBDuwDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFP/MtYvcgTzyyw9zM2l3BrjDijGOq2Xf+aIVoDF2iU=;
 b=W8UilHDuDbVxo9mnD7GOsJBZA0NRAtj0TTCMOmml5q0u3okvExZWSaPEMYu5SIIBd2/QbRmPd+9vO9ZLid3JB9wAn+BL1nAflduHEyJQ6Hqn2eaLFEkSn4TZ1PFdk00eIH5R4LJvhG+jVrFM+iz4TQIVbq0VHFnYxR7H9V7H8r/2kUx1W/uuWQqyYUa9gfCrmpVxbEhGK19OonIfAT8BT9Gnc+9L9kgjlcU2Xpwp5lQE3yN7dIh2zQ7C085f1nPTcBplUxaQm6BsAovJAcoQkFAOolvzpjEfT/WK1xwDCMcsq3a0r6RboTWgHzksp98fbiiCu1VV7r/jBfIAL4N2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFP/MtYvcgTzyyw9zM2l3BrjDijGOq2Xf+aIVoDF2iU=;
 b=TzX2eqQBnYDw3hql4REgPyA5OO6yZHZg7BonOoS+6RlpMFbox+OyolKUC/2zLDZbjimM3IRUG0q1tHwi7owqMZcdCRloFnWnfK8ZXJF8QTf+XYx1GzgTbqbUxFRjg8R1AjAyPkIbsswULaFmvSYIIrJz2wjFB1db7w8+GwrJ4ro=
Received: from BN9PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:fb::12)
 by MW6PR10MB7549.namprd10.prod.outlook.com (2603:10b6:303:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 15:51:16 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::1b) by BN9PR03CA0037.outlook.office365.com
 (2603:10b6:408:fb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Thu, 1
 Oct 2026 15:51:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:51:14 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 10:50:35 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 10:50:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 10:50:35 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691FoZWP2219384;
	Thu, 1 Oct 2026 10:50:35 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Thu, 1 Oct 2026 10:50:34 -0500
Subject: [PATCH v3 2/2] Input: gpio-keys - support wakeup pinctrl state on
 suspend
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261001-upstream-gpio-wakeup-v3-2-6f3bcde367a3@ti.com>
References: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
In-Reply-To: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790869835; l=2843;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=iyYMJBupqZzTSSdCw+T8hzFfyxbWQdqVoxcB0eGXnuY=;
 b=ra5PrhipHxz8n4FP7aQ20l4hf5SkNlWXVQeEztwR4MaTNdibje4as5NjXFW+JNrsfSbeTNeW+
 IiFz14DWlfRB2LQaGjJbaR5f7XPC5gEdGsJ4TwcaYYEnqI1dvW41Q8v
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MW6PR10MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 693118b1-d558-4f61-59cf-08df1fd3d2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VX8GaM6gwX8osO6atT6WpHctCB5tyxoaSb/vs3pWP6UyfpogVrytaW3RNJUrjUh18y9e4UmuLYsK824SgzcT+SRVJak041WPmFs5RpzvYxQSLxvKPIT1cKr/xxqk51N0wKZ16Knq60INDa+SGsnb9cTV540Q55R0ACTb3XlJX430qDN/MEdkrAaVa/bkMaeqlOg8bKUWdTcegsbtTzS/7PiX3Fo0E95ixVTD/FjsjB14bTTHHflT6ayUWPCJ8mEnm5xtVhfUL0PdLTnZ9CPKT+nasAv9xLkdP+qlfGk/Ox/CsRnPs7927m9DUa040UqLD+n4a8PL8sB0ZGZePSH1fn+4LFdsK3Wkzia96zacmvZGhuitCj58oQN+m0XtIuTdtNwJH5VGs1PwQdCWUrcf4l+AhXNKH9fFE5io5KBd/IY3i4HMusR8/8zjM8Gqo6CymNtwzbOoCSdE8PN2WM1Q+7BI1i2bW2jfJsfoNKfHZfHEjnVquST8VIZefPr6+qKCWTd/S8JaJ28JMMsAMmS9U6ZtaZLetO03HmfiOMoRzwPJc+J3jcvUcoK/9XC7e6IisVWtBwDiX3BvEkB7OXbPPgGEh70ZEYDyExIf40fpG/5izr3fheOqXr6Swb3x9ORGULiEgavb771GAwEqN+G3GugrwqNvPMGBBwRwGU6LDKs7LxYMO/66qfaUCtilNBUh3q2HXcu9VPqLwl5Z3Ws0qA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	69GenCBZQwlvvYuRmGhdeeYaHZmYuRdDWN+60IEutZZkfvoscEWSDGnWDu2Tc6FCp2qdapy0o8VqceSOqI2B7pROTuiSD+TFKWnchSqNsqo/FprfuHCJ5Oj/xx3izvUj69s2cUmPWLtTXurv2idYowskMprqtydcvldaaXJvmU9M03CJl1UCjRaErXj7WO9Pcztmi50Zo4lvCtGWiR3TdXBucJ5vd2p+zHtd5+aExO6puvhH9oByRwtujETKygiwEvPw6rVuPMX2zw/jwjejFaIkyiu0GxZetF7zQ2CxrmDtzq9txm75JGJ8K6ukM+W7jNWbLBOSAFFQqw0t9UYsbkNXz1GLl3JBIRKCKIA+kMsBb1DxbojmFjoY1wvICYUvA1K/CGSkmxRmRcTB9BA02ytEq5Jp5xzro94wFQFcuZY15h248MhPcZhrERFdCjuv
X-Exchange-RoutingPolicyChecked:
	jJE0hL4meDSXb6DW7VF5dVYi3WK3gZHMmnniABRtnX+lk3l0jkqwLqSdYlOEtu5/T0bHKLqykz8aU0tBXC9a8hAiHsJx9Mkme9VtoFxy0xG5EKgGZZWAcvgaUAFCJXkOd+VSUXtMyDRweKIYkTJPC3nPbIqK/VfMV7jGfsqCIbfl9dwhakHkCK/T8H7AXx4TCXCNYoc7PNt22vd7awJf5UZFGJUnHotMX4RTRUKHtbCXq3XMq+oxyvv21P12PhrwbFsvHiNsMxcKmvOfOpkoiJPBxgQE+/0Jnr8HAma2Ws8bIK+p2inYGHOJDkYs2GAgCh07txmkh6CnWzGAr3s4og==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:51:14.6180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693118b1-d558-4f61-59cf-08df1fd3d2f0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7549
X-Proofpoint-GUID: 4n-U3T55CaEBbjbUSTY6uRvuud7kpVF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MiBTYWx0ZWRfX3Wuv1+M5KnHx
 Vm68M8FKl71G5xpxCySig8wUnIMk4zhEhPA7x7A11uwcSnvgWEZThH4ENgykcLRF0nbgwImkyWS
 N4meZcv1WGz0h2l3VDTbQ408X09Fwn5L6yVC0zYl3zJoiDQ1EzN8wf6EWrlH3EQKqYXOuSr1jUO
 GLdWnexQd8YxgAf6FcUlnkDruKkjvpent+VEtWkbmeWuQ8/2G97T6Iv5/IPH3SRoqNVByqCxhPX
 aMkfYoOZqDVPYGv6s++woYyYXklol7lKFbyCoPlKHNEBHv5KDVHUQruUkxUEN727gbsiH7oXPQV
 BKbhjU1o0jCGGIC0n8i1pIbWN8wWGoOb6/9Z0s6WDy7oToGtZVa8bqlzEtd2zh9wu8WKKVaxO5w
 U85Ji8GUW2eLJ6EY70oPMeeluS9WzvRf6bEOvgxt4yvKftW3pgDQkyNIddGwiGpsBc63Y1SwLoz
 7ArBl+8c+Z4z848S0wA==
X-Authority-Analysis: v=2.4 cv=KvzYSmWN c=1 sm=1 tr=0 ts=6abe817a cx=c_pps
 a=6XMsudVPN6gIPUAaaOvvlA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=OP4iwnenC8Is5NdNPIcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4n-U3T55CaEBbjbUSTY6uRvuud7kpVF9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MiBTYWx0ZWRfXxnDsJm3vIyA4
 ppjjbzpekbOm7PBsKvTwfL1hTX7smBwpdRfww1fKiLjO0xvlLwyIJZ3AFeDxlFa5YhFmYWDfAsP
 LJJjRIDyu8tEJFLzughcoJsB9uofPXE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010062

GPIO can be used as a wakeup source for TI K3 AM62 devices during
suspend to RAM states. The GPIO controller is powered off in these
states, so a wakeup enable flag must be set on the GPIO pin in the
pinctrl in order to allow wakeup.

If the device is wakeup enabled, select the wakeup pinctrl state on
suspend and restore the default pinctrl state on resume.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/input/keyboard/gpio_keys.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 129fc4212a5ed126496b331ce626682d441c53bf..b95bc5bc65ffa643bac2dd5de242ae7e5986a848 100644
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
 
@@ -884,6 +887,15 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	input_set_drvdata(input, ddata);
 
+	ddata->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(ddata->pinctrl)) {
+		error = PTR_ERR(ddata->pinctrl);
+		if (error == -EPROBE_DEFER)
+			return error;
+	} else if (ddata->pinctrl) {
+		ddata->pinctrl_wakeup = pinctrl_lookup_state(ddata->pinctrl, "wakeup");
+	}
+
 	input->name = pdata->name ? : pdev->name;
 	input->phys = "gpio-keys/input0";
 	input->dev.parent = dev;
@@ -1010,6 +1022,12 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
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
@@ -1023,6 +1041,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
 	return 0;
 
 err_out:
+	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
+		pinctrl_pm_select_default_state(ddata->input->dev.parent);
+
 	while (i--) {
 		bdata = &ddata->data[i];
 		if (bdata->button->wakeup)
@@ -1039,6 +1060,9 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata *ddata)
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

