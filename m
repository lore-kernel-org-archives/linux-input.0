Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82A40682A;
	Thu,  1 Oct 2026 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871101; cv=fail; b=NMHF7r08oNBH3bxaTu6wvMQBxVaiaodxA0s1DGlRPpjr7aB54v2C1/PzzFwfLdWbWb1nKtcWksALGqiblqdVaE0ea96L/yWHJl1JfGLfBngHott40Z5R5CyyTUeo/zTox5Ljtj4G3Uvpr0sloJ7I3eJqZpPuIJlqo1Qg95i4Wuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871101; c=relaxed/simple;
	bh=/HypzgdGcQCqbaytCpMjdOzFrQ8LDulcwG7vbbfQtz0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeF0+z8EtloWtAHDVcJ9XRPVDS2/XcJjHO3K5DrTZalkWuB9uy88RWz6vtpvh7j4kjxUcsrSlnkTraR5WN8hDQDbAJX+Q3I7Z6iwPJ+5BmO9v/VJUVtuB3lrqR/VDFQntu8hTICB82NM+zbhGDBn0dJOIeDVovN/DJ5lgcr0Y0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oPxyo/ia; dkim=fail (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=hB/wosNv reason="signature verification failed"; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oPxyo/ia";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="hB/wosNv"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FsSvJ2350597;
	Thu, 1 Oct 2026 11:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=QQyYak5QxI67tafgaARiuWm1W6cEgfklJJbaCTWh4
	+g=; b=oPxyo/iagU/N0WwPMupfl+CeRKddinDsGpfheAciORcDByjJtpNdsTq5M
	zg+nndNSDEiIxCK05Wu7pdgHf3BQgCRw9yIB9W1vXkVEQO/f5apxPrjWgixqin+1
	l7rA77VkSiCZNInaoKIQdsJUVpj6EGsanOV8gillYaj81mz9ZUtSE+N65qf1yrwP
	Pz1kH60EzlcDNumV8EOyqS1I+Ccz+8yTevsIYFlwBOcjwpVAdd3Z45xR/9rHp3B2
	LTyASSwBdIkrtJlya8XOBbWG4HXQV03DTt7gKZwnlZzRG+oeKGPGcUqKBdk27lBf
	WipxkOP6FNE93HujhYB7JDpggUWKw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h1eurceds-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:11:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6sdSMzEUC2KBOnVS0OsZR1Bp02tLH9gU21ARuEfQlh66bzxRzfIElKo2j7nM/yv+bgiK2FMp94CPLRuRKIPBu+PdGhQGikL8RaNvGuFqO70TeivR7XZlJ/k1/xpt1+GZussESgjKovf1Ycd8fan0C0bt5d7ialkRkgb0cTQQVw4A5EC08HS8+YsNf354LdUCxtTSU3+h9tJieHbmygUWF8KINKgxHSAkovziSzEhUZhtnk1JlWhzWuXmV8t1IDg1bNANRfecoeIqt/EvCx1enqiZOZw3Y9Qf8VVlx+lk8FUYNWzepOk5BvCkvx8SavuxYdp0Y9MpvHxYIZPyHAZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJweDnrRk57EdNJGjmOqEe3WrfMh2p7UGVYFKXGHcYQ=;
 b=kAqXlABvdMgpSLynAEuV7PxfSFU6ILyi7XsvDdhpgf6jGrJ6hBcIZn4I8E8NK9GXMdklemgeB8xO+aRYM7guQAc1OuiOMQgP2Kz8VuI+BiZNAhcb3KpPiBavdR5HKM3pOKYt5yNw5qRkc9+AALz9WdWUdeQN4Nlh1UOfak2q9WeXt4APQw04GBnF2TuScXY4LlIXzIHrM2uh/Ux88ABdYfbBaPN4xvQSkqkQmzP/Bboy6AetPS1TqZkeDVRCd963JvYsNgVvtzwmRzAUl/5RNtVSTfWh6KVa2jX3WJ76dcDKsir5rQGnDDThpAetTEVnqgVUa0i0knEAmtVdnJgPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJweDnrRk57EdNJGjmOqEe3WrfMh2p7UGVYFKXGHcYQ=;
 b=hB/wosNv4CiJzFckGmhcIHL4cR++rYyXwEyNIgCjQ+3ovIHX6XrKFqiCsgOKI79jrx+wj4WBvSmakWVjSXMCGmpQlpih2gkd56Z8zOXJeNJQdsXH8607rQuKtHzcjlkAXdOR9G0AoAaGDz0uUtL98DORaBmcuKF80DVRy5XEvX4=
Received: from CH2PR20CA0003.namprd20.prod.outlook.com (2603:10b6:610:58::13)
 by CH3PR10MB7234.namprd10.prod.outlook.com (2603:10b6:610:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Thu, 1 Oct 2026
 16:11:28 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::23) by CH2PR20CA0003.outlook.office365.com
 (2603:10b6:610:58::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 16:11:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:11:27 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:11:06 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:11:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 11:11:05 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691GB5aX1297060;
	Thu, 1 Oct 2026 11:11:05 -0500
Date: Thu, 1 Oct 2026 11:11:05 -0500
From: Kendall Willis <k-willis@ti.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>, <linux-input@vger.kernel.org>,
        <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Message-ID: <20261001161105.xw47b2qzq2aui346@uda0506412>
References: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
 <20261001-upstream-gpio-wakeup-v3-1-6f3bcde367a3@ti.com>
 <20261001155950.44EDE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001155950.44EDE1F00898@smtp.kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|CH3PR10MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 686a631c-1590-4899-3e95-08df1fd6a5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|4143699003|10067099003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Gs3GVHYrVSuqYU/ZklihNGWgvCv8KkuvxseQ8smJ/iq4K/QDLeEQpkenQJrj4cIV6cjKJN/kNSTdi6u7yziOWbE2xVy/Rz1+ergxyShTk704W1U+B6Yq06LjFOCAXuy5CA0ZRMl5LlAxtieeQtG2NzkYGGhihW73ynEmSHwvNkxTNQdbciM2NUjoZVSXdTYOkFSioHS8ZVWdeci8WYQK20IB7ek2IQ/hKRUgT7jNXn6dqFHInDLSTqw4hV32DjQxo/c3LZaG5vRXxhAc/EiygsW5BEZknFc73xVDebGK0zMhMJAFciqqdJ8pmi6LdQW01dTypeCQpNS+/RK00QO+eVRIo6w93v5atfoyzNYIwQx5av32yZ3HNJ9Cs+vv4cuq+/xf6y+10uECFbmMO3zTtW+DtcYg7DMNcIZhEdXg3OVvCKu5+i7qsZ6OSJ3x7pXX0eiaJrmx9abQiWqdqVemAf22EkAj1o2hltMVeFxw3owu/MtjqluJxJxvA0cHKsQmMyW4jXF8uIxA6YhIp0WxJ4SVaS3HC6qY6g5VCO0bAv1UjejlqTGDlkQ4N3Ku/pUeHGrAcb3Z4BGe8eHWJXrpoF5yxLXaldymp3cYT+aqgxbMlCFwSrliOEnMhFvDg0dQ2evb2ngdwgKuGlGiY5DDnQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(4143699003)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uLwzoRw282LJxKmMJoFVJkg/0BdRGh/kfZXlh1Ii0LdsBNLi9N5hCZr1lzxigEFsmdPmhzhLpBGPfC3OSrMkOBamHWLcuSAJKU30dq7w3OwICVLdmHco6f6lrB7r3tnd0gJQ/vE9TD+BcpBYUI38kzotnn4PLN6jxzu6k9uvHEv6JXAGsJjitj4HMAfHQqSOLvdpo/ddfWA5BjYP1c/4fJG/Y53Vb009Aapvi7+q6usIOL4B7PGAmrZquY3vw8GamJphTS0mDmt4mKwOQQ/yzFpNNWVQ01Beo8ztzNQ8j61AaUbE1/9kW0YFmECWvLvX0VicZu1TvofHoBal4AFpPjeRSon3kRsnAP+NqKMtQlyYEjb2c7s0/I8tYKOZ5P8mRLffiFSnKzekmr7hi0sbKI9idRUQ9U45N31smvlUZtKVNYRNa2UedO6v+ZsTN7Qy
X-Exchange-RoutingPolicyChecked:
	t4ssAmmREYs5WM5cECSQ+qDHYD/4mgSU+83NtMO/b0qyHmOZGCwQelE4ooMCCacecgn/JP7Bn930Kt0iaZ1Y3RiN+MV9A54KT6pAribfEW5IAr/ijoI0M7bc22fntVbnmX9MIUQ4vxPdSHraPya9znrNyH4tMz5AAJGGK3vkuroSekRr6QCUpQ/kh273ATBrUuWMaXTdKK7vyyFXkpIUKQpi+ctKWJvRiZiAicNr3MYpHzebu04gOpEsk81n4Y0+pWwnm4SbiCdpb/bwwaWN7U9cat/H4Td1nP+oqpAuuZLb0V6v+8weXUW28sG5kOpIAVgquZPK6pIllRL2vSXPVQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:11:27.3465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686a631c-1590-4899-3e95-08df1fd6a5c4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7234
X-Proofpoint-GUID: 6V7JTvEhGoWaC9spDYa2dl5NiB90aopG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfXw0Rh1FloiQjU
 WAqDi06IRF5lyi6VWaPC6nmxhkA7SKeBIb/GjxgnVAfa66O515PIhfpcowL2VJgYucJX3FNDzav
 TaE0XwwXKvnWizh8NSiMe2k7WivnD1gf8Nz5tamULbVQFGp6VppaKobD+PmH7vHOd6d1qPJFZAb
 2XpXQpH7Z8hAzFMZF+9Lt6R1ecT4X4MqcdX/3pMDPckEi4FVxTRvQoCRvO+69IK8luXMZAEjAX0
 lvB0NTsN7yBeDasnnEepLiq+6Wy0nH3UumK4JNanYZF/oCPotdO9uFFlzR4BYUnwhRRTd13o9pp
 JO4fQHMaPFryoY9jUF9YgvASvw+WCU89z2+0ZeSHUi4SCdso1AuM0CdZi6u6slUNeUn0feCDRhQ
 HQtL5iy2BwEDpgXVUiRoh7ozmHYif8wTWEANsZRVtxrKmep399ru3vk/mh9aRLGry8teXmN1jjv
 ixK2m2p01zkVEibazDw==
X-Authority-Analysis: v=2.4 cv=KvzYSmWN c=1 sm=1 tr=0 ts=6abe8637 cx=c_pps
 a=L/RFU+sPSyhylg1snxNseA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=c92rfblmAAAA:8 a=n1o1H4E3dpWPV8R3zxYA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 6V7JTvEhGoWaC9spDYa2dl5NiB90aopG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfXzzd1pVDa8cti
 JXe3boU8XEoCr9aITzIn75XjasPpGcgUj+nIlzoG5Dm+L6qGJ5bE0B4wnVgQMNTUg2y4Zais+bp
 a6qQ82dCY0aufGiRLy125E2CXfK814E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010064

On 15:59-20261001, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] dt-bindings: gpio-keys: pinctrl-names constraint breaks at91-kizbox3-hs.dts
> --
> 
> commit 907856f3f65db782a0530ddca90b6bdcafcea767
> Author: Kendall Willis <k-willis@ti.com>
> 
> dt-bindings: input: gpio-keys: add pinctrl states
> 
> This commit documents pinctrl properties on the gpio-keys device node. It
> adds the default pinctrl state and a wakeup state to configure pins for
> system suspend if GPIO is a wakeup source.
> 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > index cc78c21529213..a0712fba45845 100644
> > --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > @@ -22,6 +22,22 @@ properties:
> >  
> >    poll-interval: true
> >  
> > +  pinctrl-0:
> > +    description: Default pinctrl state
> > +
> > +  pinctrl-1:
> > +    description: Wakeup pinctrl state
> > +
> > +  pinctrl-names:
> > +    description:
> > +      When present should contain at least "default" describing the default pin
> > +      states. The "wakeup" state describes the pin state used to wakeup the system
> > +      when wakeup is enabled and the system is suspended.
> > +    minItems: 1
> > +    items:
> > +      - const: default
> > +      - const: wakeup
> 
> [Severity: Medium]
> Will this implicit maxItems constraint break validation for existing in-tree
> device trees?
> 
> Looking at arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts, there is an
> existing gpio-keys node that defines 5 items in pinctrl-names:
> 
> 	gpio-keys {
> 		compatible = "gpio-keys";
> 		pinctrl-names = "default" , "default", "default",
> 				"default", "default";
> 		pinctrl-0 = <&pinctrl_key_gpio_default>;
> 		pinctrl-1 = <&pinctrl_pio_rf &pinctrl_pio_wifi>;
> 		...
> 	}
> 
> Since the schema update limits the items list to exactly two specific
> entries ("default" and "wakeup"), this will introduce a make dtbs_check
> validation regression for the existing board. Should the schema accommodate
> this existing usage, or should the board be updated in the same series?
>

I already updated the arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts
in another patch [1] to abide to these bindings since it is not standard
in the kernel to have multiple pinctrls with the same state.

[1] https://lore.kernel.org/all/20260928-gpio-dt-binding-fix-v1-1-552e4b324a36@ti.com/

Best,
Kendall

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com?part=1
