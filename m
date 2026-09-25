Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B494CC62E;
	Fri, 25 Sep 2026 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351385; cv=fail; b=GUncOBEO8plgxHYyK6bQnc0pSfOmkUMTR47AR7vWuprhuypUJqzUlLPTGr/jUgbCOFN9eiTOt8gYNFPJ08VqGIDuqOg/BRa7AyGWm/pPMhKvoKdU/Fv9q04pBbfkdNw1IEZwInVHWCp45fpdHDgLB5cb43uaCGf5MlUTcNK5ZAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351385; c=relaxed/simple;
	bh=CVwtaXcT/WtLsW0AxFdniKjhxndT2eQzo7v5wrVdDow=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P32SVgQhiBGdc41KP4mhyEY3cDCmCDjR0kOOrrSuNG+uPW4sso1z9525+GRuvZbMbpxhbsMZzy/tYwbD/wYXtoKdj6o1zWboXXikwolZmEr/ew47p4xemB2raN7YPuHO9BcNx3Iuyfet4pyEVIr+Igxf67HITeY4DFHkA/tXOEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=SJjNtdBC; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GsO6jd0Q; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="SJjNtdBC";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GsO6jd0Q"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68PBOVgF2451668;
	Fri, 25 Sep 2026 10:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=aDRSKwtbr5J1O5+
	+50SOY7/lowd00SYoR5IyKyIGezk=; b=SJjNtdBCiIfi9CD0rhHSM+QCG6MBiKf
	JcWzDpykJyOmLtd+AFP4rVj0zimLCqYhpgQwigxXK4jaudrlXERHbN9gwpEVmosk
	xQaGz5NeNh/tt2ylXf7ZpEzOg16kggDFxqvq8E2TnjAQxIlY6zSD0nqgmnPBh93k
	SgiG0zFOD+7PzL32owvVWZxK3tSEsgF4mCdAVpTATdDTgpP9siBpkySrDxzdVlo/
	RRtlOzh9r02t2B5Pyq9h9nYIq6+2VidumCC8LN9PokFq/M+0bI0kVVZbSsq5fQHv
	XUe2toR9XAb/WzfudK3QAqf3JAUpRagjvOfKRdcpc2siGx7+JXoQsEQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gwjq4b67r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 10:49:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt6ggTxJQRpX2H4ulvybSchBAdlpgPt+wiykCQnnkkI5VgBUGy9n8oC/IhWQNiVoe+LVrKbQfDh5GF4iDydgYxEx9UgKADynZHiY24lftCLUz2jwJz4vx6n3LzZ7ZEAK2iGgqxBDNmmgNkxC7tIeIzJGOzd4Z0WTQc4k/57ZqbD76Qgh2nYG4avc4oKmt9UC6RDWUBT0Ej8Ie/uZSLHsXp2+x5YuGPvqvxhTO68QnxQjvhFekmwJ2nljLjqThTjzg/OiHloMp7ONfKtuA3u9XcaYz621LgcorxWT73mOK9mwqT0CXdGKJOYSS0+tdFl6FTKivJoEQgDi+K1g08sbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDRSKwtbr5J1O5++50SOY7/lowd00SYoR5IyKyIGezk=;
 b=U6xT1YmDQX8R9ipM5G4GDZixzFCtY+izqHRr55DPANui50G10ZHcO+UBWmWzHXIopbO/mT2e7vBEuOlmxFcYiEWLK/3bq0hMGUHLnELW5jzhcPAdPjjTb/0CwT00AATshq74qI3ydrYG4exm4kLKG8NcYVTY6rm+633UNepHK+XSMkJI8IVwvQ0jgi8rAqKca5oWX4yNXDecnBzfApwj1S7PWFENwqWtar1tHJoPEaavM1t97PYk6vQEVpL4popXn+qPCZIql3SpGhsYeCHO5HPsn7xlhniBwOAqOgrIgUHCUwcxslLR45mXnCgAm/XDGSdaVtvgz40aYUazXvAcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDRSKwtbr5J1O5++50SOY7/lowd00SYoR5IyKyIGezk=;
 b=GsO6jd0QXJz+PZWIZhyVfOrTgyoz/s3IhwIL8I9cDOb5w3rJ+7XKS2QQEcMujNdJsqNib3kcgWJRn6U9D88RQHrslrC9lasDf0hV2pc918zMc8QMt29V1/GtWUrMWWdMwSAcPjvkh58RWDfD8Rp1bZZD0UE4gSOb1YkDM8AmqzY=
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by PH3PPF079E800A3.namprd10.prod.outlook.com (2603:10b6:518:1::786) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 25 Sep
 2026 15:49:30 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::88) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Fri,
 25 Sep 2026 15:49:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 15:49:27 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 10:48:54 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 10:48:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 10:48:54 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PFmswg3030575;
	Fri, 25 Sep 2026 10:48:54 -0500
Date: Fri, 25 Sep 2026 10:48:54 -0500
From: Kendall Willis <k-willis@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <msp@baylibre.com>,
        <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Message-ID: <20260925154854.prlhmxuvac7xgvm2@uda0506412>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
 <20260914-unbreakable-competent-beluga-efb5ad@quoll>
 <20260915164819.nlgpuvf37rhzgc66@uda0506412>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260915164819.nlgpuvf37rhzgc66@uda0506412>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|PH3PPF079E800A3:EE_
X-MS-Office365-Filtering-Correlation-Id: 801308c8-cff8-467e-9419-08df1b1c94d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|22082099003|18002099003|13003099007|260925022911599003|260925021311599003|10067099003|56012099006|260925021911599003|4143699003;
X-Microsoft-Antispam-Message-Info:
	qXp69sOPz0RjCfJB7tO0t7A2HLNI5M015GnZ4jLiMpDSauWUId/wgN8tWtbKtb3QDBEpmcq73L8tsHJa5+diETMElwj/1Dww2y7XKGlsWyTivZpPbt4DF/qj+lifiI5XoDIVStY2na7YDT8E2NkjjDZfngI4v1Qlzs4E06tApYPcDWQ5gwX5GKBHgpWsODeeOpJppVoLP9Jfu59pJxOxK0EQiE8QrErn6J7pKrhd3tedFpmZ5eOmzE/BK5Tup/9TB/7bgdo1x4NRzm4V+erRwXMOtKVTsaySzPt3JU5TsDtP+cgSnSsOqZG/TnH3WVzrbCwzBsyJMB3RIdt41cknt5tazOLYEaUNuRBpiqFpd0CJiJzOR4GD2+nMz0Bmskn0UJ9r8BCbxSuuTFpQ88V69qEla+ZiaFRVWJaCpbDcVL4ZsZ53L8QmZdF0TWdqfDTEJou3GDXMGrmvUrGFvbmMIgswLz0o2L+DS5WVEGSvBH30sUX9/M5i/eCU62KRIQBG7+qm18f9GRb7g/c4oeFCXKuCbK8rbg6+lgXvu6qUS2o0mM16OI0LWWkRYnO+UAF2dOdjkM4Q/ThzOY3Dxx6xuFcimmIx4MPMqNAUpnfidYndTBvq1mzjJPoKjQlTgpFcuWbxtdDc0H3MCoPKlLd00w==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(13003099007)(260925022911599003)(260925021311599003)(10067099003)(56012099006)(260925021911599003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0q6avKoKjuv6RvjlkIRsh7hiKuH27S9OrNWK2MD3nQd0/29K4U6LG0b4xl2xciMlCVfHJEJAIT6AXT4/h2aGm9z3113mC/aGCL/3SfPqAyJm1bQdh4m+LrgJci9K9FuCQNEzGirUJOkCFJi0wAplMp/Y+K0czhTf/pvaASdFXzNe5jkPOuVzqspFpSk2qWWXXPtlLLpybPl4R2LkAQ64qjCMM2pxULjjx1i51027TE2wQty0eXxol8m8dm4nIp0XjsmrHowyTPjZOeTvElEsmqGgXtG2LtXA2urMCPm5oUK061x2GBsmUNiKGZGmYw8lw/KKhwwC+ccMGbKc3DjP39YvsSaqHgIeRbj5xf9waGBvGe8jlkJDKDACRnifz3JvbOUGq9tjZy9FKWhGdJ8yYNWuZ6/niDA6KFrSUwuLcApANKJEMRVJurY7rUlZdFDT
X-Exchange-RoutingPolicyChecked:
	S71mQ040goW/ZswEQxfGH82fRys9ZqzFf387U6tFds+F7gYowE3YzucK7GyPKlEesSUridfbMrS/5jRI7gWjXMwVZ9j2AiEq1XQBIzbMH3a7TsSLMljImWuGvySElnxg9Russ48c6m7reuKmYpMZcC1i039Hcejm30t9dtV1sWmeu2a2ugDlaf4LIP5B1o638RQ/IrKsAhfQEdMFUwGbH3QbBW243Szs3kk05ACgYF5WigUH2KcjChlTg/0RC9vINxwd4wn0dHdfHHMvnktTRl2CFsCJmcB9A0jz26MGx+BsVVLIbTsEkbJAlQNpDnniUrixzGBRc94C/uGDJ7xVAA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:49:27.9012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801308c8-cff8-467e-9419-08df1b1c94d7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF079E800A3
X-Authority-Analysis: v=2.4 cv=H+pOUOYi c=1 sm=1 tr=0 ts=6ab69812 cx=c_pps
 a=6wX/tLcgNF/HagpTIcwFsg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=9AdMxfjQAAAA:20 a=sozttTNsAAAA:8
 a=7yJttATtmX0BVjD8hAkA:9 a=CjuIK1q_8ugA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: eDVjFDM3-AM2C3epg2YnNs9gIb7bk3rY
X-Proofpoint-ORIG-GUID: eDVjFDM3-AM2C3epg2YnNs9gIb7bk3rY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MiBTYWx0ZWRfX+oVFrr+xOyOu
 c5YzUF3TKSYLBhY3TMz7UJuT1xb1xD2rJOIyU951Ofx9lhC5BAxaPJ/x/AUJ21jfEEoZVjRShVN
 4sf4ZNmu8CLeLNqrsyqD0V41uJ3exqU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MiBTYWx0ZWRfX1o4GyDkEPXZs
 FIayE0gbxgvGejCkCmzLwwN12REuu0w6o9Hj3vfI7EeuHxHMhrc4HRIECCIOlOQD3pgQUbUW0la
 1jxl+XqnBFBuIZrlpEpa5iZfaRxi9QW4bCBxJIYYRXl63g+T95qwIsyYwJu8YOv7t2CZWlgtnz/
 7W1sXfxNStoblZxgZMBbxMhMdb5ayKbPicDdkhmvP7Ux6y0g/25N+5g2hEd4PHLx3/Ec74xyLcT
 qRbWYpsmH2zYjS/3CYfG8k1rnOjBfJYjt36U3X7AXJ6PqRna5/wDvHFFhXQ0x5AFyGl7XR2+dfU
 FfytXJsk9ad0wpy0udauSFxfvFmydZZ1pDgswaGPZwKYhRSrR+V5CgZ78vs9yrsHdmj7t90YY+S
 7IeLKydwtZIUTvpseNN+q1KppWAsGj6Z/1cAiko0OmkPiM1Aby+P0F1VxReCwaFFNPkZOhiTy4d
 pMzbHHl5omFP1n4qsAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250062

On 11:48-20260915, Kendall Willis wrote:
> On 12:13-20260914, Krzysztof Kozlowski wrote:
> > On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
> > > Document pinctrl properties on the gpio-keys device node. By using the
> > > wakeup pinctrl state, the pins are able to wakeup the system from a
> > > low-power state. The default pinctrl state describes the default pin
> > > configuration.
> > > 
> > > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > > index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
> > > --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > > +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > > @@ -22,6 +22,22 @@ properties:
> > >  
> > >    poll-interval: true
> > >  
> > > +  pinctrl-0:
> > > +    description: Default pinctrl state
> > > +
> > > +  pinctrl-1:
> > > +    description: Wakeup pinctrl state
> > > +
> > > +  pinctrl-names:
> > > +    description:
> > > +      When present should contain at least "default" describing the default pin
> > > +      states. The second state called "wakeup" describes the pins in their
> > > +      wakeup configuration required to exit sleep states.
> > > +    minItems: 1
> > > +    items:
> > > +      - const: default
> > > +      - const: wakeup
> > 
> > This will introduce new warnings, which should be being fixed in this
> > patchset (e.g. at91-kizbox3-hs.dts).
> >
> 
> Will fix the binding to work with current device trees.

I looked into this more, and the only DTS that I could find that uses
more than one pinctrl is at91-kizbox3-hs.dts. I am not able to add the
wakeup pinctrl state and allow endless pinctrls and constrain the first
pinctrl to be the default state, so I will send v2 of this series
without allowing many default pinctrl states.

When I looked at at91-kizbox3-hs.dts it looks like all the pinctrls
could be consolidated to pinctrl-0 since none of the pins overlap. I can
send a patch consolidating it so that if these bindings do get picked,
that device tree is fixed so no more warnings are generated. It does
look like a bug anyways for there to be multiple default pinctrls since
pinctrl would only configure the first default pinctrl state, and the
others would not be touched.

Best,
Kendall

> 
> > But nevertheless, isn't second state the sleep state? How can you
> > configure pins for the wakeup state - like being in the wakeup? You
> > configure the pins for given state, which will be a system suspend, so
> > sleep?
> > 
> 
> The sleep state usually refers to putting the pins in a state to save
> power. The wakeup pinctrl state is for putting the pins in a state to
> allow wakeup from suspend for that device. Both 'sleep' and 'wakeup'
> are for system suspend, but they fill different functions. The CAN
> subsystem also uses the 'wakeup' state in addition to the 'sleep' state
> [1].
> 
> [1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/can/bosch%2Cm_can.yaml#L121
> 
> Best,
> Kendall
