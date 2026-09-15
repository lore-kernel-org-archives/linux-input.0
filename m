Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD540E8FA;
	Tue, 15 Sep 2026 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490967; cv=fail; b=e+0IyRHXpCiE2Cp9pjjfOxgj2nTs9gsLudaez/oIVraoxTwFEJTkoPPpoTYaPIt7AI4U0nIwlwGJs+XA7kMHz2sly8A33kKwLL+FbrkrsR0R3hiNl1sDoc974+Vd7M9mCUfCkg1Rs2JEpr6imciLJ5FYsaDRZqHixlUP7gfGoGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490967; c=relaxed/simple;
	bh=X1GFyhvxB2D+taXqC+gF2spxxl2FEUG7LFTYVWMe/W4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1IIQPs6fI8W40fBYGgEIZVvtbSB48R3ZL2C9axiiGQ3CyhqiFPttoGHPmM5hpj9/I4BJm+4BiSKnte3REysntPNm+lwIAXQ8hpZ5NaWfBKqMBvr+TrFIAqFdx6geyNNvkxb73KZxmS8lfz8Y72KeFg96MzkQ8Sdf67p9l3o/5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=HTKzmORk; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vd2kcP3T; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="HTKzmORk";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vd2kcP3T"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FF7dgv561716;
	Tue, 15 Sep 2026 11:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=Txe7GypIpuzgagb
	dESr7fTIp/BW1T/mDQ4g1k+ChClo=; b=HTKzmORkIVmsaa2BZ6yAhdL5pPFcfBJ
	35DXM747eobKef+sbXPBaG2XDZS/G3CejJIFlimgxB618x5a9E0AH8j5VfQ+Pp7m
	i+lMGCkiLdkYWkEyS5i/F8ijR3WKksymzf6k4ZS4l2GgH9TcoCVX92AcrlY4Esep
	2oeky4B0L5HHXUHtz/PUazR/uqQPRVFgTUf7YAC5jwi/0TJJMJfjIwiQHiW2WHGG
	ke+3qGDRtOQ6MTEPALeWZtg/0svjzMQPNoQ62Y3yzaYZQ8KRyNnM4fkuDK0wJ1X4
	Q57Hh6Pcn8PGn0SmcFpJ/6BHUenF5kqekuzb7MNM7MRtrdiHqE7dIGg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gpvpjef2v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 11:49:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyksxWoISYM3I0jZju0ammFd9M3jwUHKPzmFBAQDvmUhnZPeXCdis43cu5+AZs2QLnjCH6y1BmE3fevGFS35XK42y1NT566wOrgtC3HLVZyEUJ3zuLlh8vGF254/e4vXdulnusYf/O3dG3skNdGot6SKx+24h8Tf4cE9RfmnFOy31jxLDRCTimdlZ3nNxlxNCHWxDyxWJgLrHCy780bmfpAbF7P3GPDCnS9s3bYC8toWJ9LMVtX6qZj5TwpJj4Q4uCzc8ZzWD7Q2AEQWxqYtuinGPtz5kPWIkcIU4kBlraF8k0SLawSOwgI1+4wUucwA4Ble3LWqdldv5+pn5TGn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txe7GypIpuzgagbdESr7fTIp/BW1T/mDQ4g1k+ChClo=;
 b=uVCQf23OD/hDRj/WAto4u9MVH+yOoquPe0Ig+zhuCKBU7n/FfSiA7BGE1I+I4kAK5XZOjb0e45lov+pw5JbqZxF9xvkbGVaP8RlXMttF+K0irLFyzX3Gcnul2FJFCm7gIn89WnIPkPwpw05PhXzwOMh+/DCi1p5RTUIlo48h24Rj0gytDgsVt/t5iCvbW6kmL69irX3MliBWhimsmaTOSIi2HO+CPoaYnmeAz1VJBoV+YdpP12jtlPsvGoybXz7sBxxHsMVJQPH1XxPdGHu7De31hm97pysxEGWI82UoSOprKF8e3FkrovaFZGEAKqt2oIIJjJ2ccEqsie2Fz7WDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txe7GypIpuzgagbdESr7fTIp/BW1T/mDQ4g1k+ChClo=;
 b=Vd2kcP3Tlhr1Eye2/3WkVd3feGirW3agjZWL126iW+PucBqfHMKt0Unt57B/3pCcgix3G4EmWDMt5aK4/g8+dZcufds9NrfOXAmNEzpS/FBMlB/9l+ldURa+EqjqlD2lud9kCKv9iqVytPjw2Lg2qnZwIM/8f71KItFagbTR40A=
Received: from CH2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:610:4d::26)
 by IA3PR10MB8370.namprd10.prod.outlook.com (2603:10b6:208:583::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:49:09 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::1a) by CH2PR19CA0016.outlook.office365.com
 (2603:10b6:610:4d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 16:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:49:07 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 11:48:19 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 11:48:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 11:48:19 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68FGmJrq361599;
	Tue, 15 Sep 2026 11:48:19 -0500
Date: Tue, 15 Sep 2026 11:48:19 -0500
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
Message-ID: <20260915164819.nlgpuvf37rhzgc66@uda0506412>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
 <20260914-unbreakable-competent-beluga-efb5ad@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914-unbreakable-competent-beluga-efb5ad@quoll>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA3PR10MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 317e4a5b-af4c-432c-91fb-08df1349428e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	LipL2WfJ2P14v4i1L91kqUn7D1Pjmtsp5jeax2z79xUVLtonOsLdS8AzJUtoicMHGANzj2ZGWbezu7HI6U3WwP0Uj23ysnQFGkTrf3TR7nOm8JF8Q3PgD+YRNyVf5KptS5l3/b1c8oWMMBAHK+YMW3Oj7sZwYdTT/KVXO05QQOtAWhOHxuBdTYDkDIjDDYsUP4R7RImwhnPvwqaHI3EPOydRfjEogKv6omaj0ii/a95iF7j+uUto/eWmyGdGaXlt11UiRE4Htn8g+i8qJIKaUTZNLZrcQIW622B1HNZ1PttH/cQ5eVk5TKF2+EB0h2OQ5PJSOvbTWOcojrkzUJqqyHYhMl9PoXCb8cvkSyX6oxiKFW8EYJBqbfirHTIeMVH6xPnCx1+G4TYMxg/7XNSl3D//+LM2pMvkdnjytkXD5PW904ExiZ8BC61INuBggoaPoESiMdzN2yC84fq6lKcW8fRlr1I0dGTX5F4Z7VoLnT30RDgIULY9+Hs5NuJZbRAwtqLpYUfOBT7EhywS4ekI+O8yYVSuiVJiM2G7OE0aM3a2/Kr9NsD5qJyGLdzrAbZS6BE60fIrUQNrqTjNvoRE2NjKY3oYoA2nd7FAul1piTJTbqUAKfLpHHqNuEq3bX4wpVv2DaCuxt9WDzFjXgxVXA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PJ6kzzvFCXoyMB591x1MQkCqD0z2/I6nmO3x+ugC1GuK95By8ExyQHf0YYwW5q89mVoTsHzyTgQ48o0cyzDICiNyPV0a1pgHrWsv6iCdMgbwr8EqUL/ajWwrPu305yUbE7OkW4dEMvbi34IunGi9GyoSo5/EhSm2VC2Do5aIi7F9Otg2UiSw89G/7x+hWKgjXHgvoywxPFU6sM4mTLffDeYuM1wI3dhnGltCGAcAIAaKC1Un2LrpNBMEMsYKgclqfhyfHfJY59KPiQR2EHIpbvxfTSFgCs865ZBj+7/stNMYrnppMgy0xZsNEaDiP9Ttm/u0ggizeJItx+1VqPrl4ndF5fAr6+fU73YF27MOxDjzhEvzq7Q61QNLaUWchb5sW/KEpWfvq7QbPr3naAB28giJBZc3a+BPrU288VzwBSK3h+ab94oPlxUBykX47nJP
X-Exchange-RoutingPolicyChecked:
	kAzat5P4YBbUHA4JICLKburdgUk+Rr+xsu5ZbnUW8wdvKIGDEYk9UnxySvqn5EcYZ66SSkcqcflrJrmuvgivGijGD7kfVxIFDIeD1gGTPJi975ZKTHRid4VQJFTwK+L3yrAMuwVPegVZJ74oHFka1AE8DdmSzLSNXzzR0STBm/Wtn0kpwFxAPCdtsTaWK4WeiOest2meN/0MoVnlRnSpEQLB3eymrhQ/O3+RIH4IBd4wqGPRGcqTnQ8TAfY1kYD9NfI+1p8WGxDNaMAH1Ylxvml2RXgemJ6cyuNimtDrMuwD1eRnwPBYi+N+op0GQkXAsQpKoh+Oyfd5plhIKtE8pA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:49:07.9018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317e4a5b-af4c-432c-91fb-08df1349428e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8370
X-Authority-Analysis: v=2.4 cv=KvnYSmWN c=1 sm=1 tr=0 ts=6aa97710 cx=c_pps
 a=6pz+1SGHl1vfFjSiae6wlg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=9AdMxfjQAAAA:20 a=sozttTNsAAAA:8
 a=xIIpGUz3RgIRYSf-t0gA:9 a=CjuIK1q_8ugA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 1tl3qP8-HzKjDTt8Eg95kxhM7M-1WDRB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0NSBTYWx0ZWRfXy2AIoIzeY7hF
 ybfYhI++aYJcoaP/zOJUnwwjfeyQ+9GEiRXctfjemRoT6/FWeikkQamxdAQN5ZEluAYEfQQlgIC
 LF667lvlFJP2UcOo26WEY+jj6fxRDPuzVysFxKoeg7MoAuQMJeuapGY6AAXhVq2u00i6W6tb2SN
 mCh07kxLXaNdIxKmmLYNltvNJwPC2D4mf+TWJYoiJ0unt7XNRwK9Q0HrFWrm8UrVxLjoJiuXSs6
 erPU0hcPCdZxdn7phYq9djKPaGfAathLfc7Lh6sKuBEcgLxUIFSjWPnbAoNKUupohIiCFHY87s3
 HEneeX2EhLsXTZwMd1IV0HAng6rZ6ifQCLBRDm3BSyuZFdqPvZgjYSJFgAugk28w34d0q3oqUZ1
 XD/pfqK5y+WOWaxxIr9WQX8QMhoGRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0NSBTYWx0ZWRfX675oic5+bipV
 xuLK1/AWF5sjKH9zZpB/OLL3jogq3ir0XliGva/LIsBcTHDegm0dd3gesIUvJt3LNzuewM2ih9I
 zcFsMWzo48e9VuJVqB9UgjGVk4BMYLE=
X-Proofpoint-GUID: 1tl3qP8-HzKjDTt8Eg95kxhM7M-1WDRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609150245

On 12:13-20260914, Krzysztof Kozlowski wrote:
> On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
> > Document pinctrl properties on the gpio-keys device node. By using the
> > wakeup pinctrl state, the pins are able to wakeup the system from a
> > low-power state. The default pinctrl state describes the default pin
> > configuration.
> > 
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> > index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
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
> > +      states. The second state called "wakeup" describes the pins in their
> > +      wakeup configuration required to exit sleep states.
> > +    minItems: 1
> > +    items:
> > +      - const: default
> > +      - const: wakeup
> 
> This will introduce new warnings, which should be being fixed in this
> patchset (e.g. at91-kizbox3-hs.dts).
>

Will fix the binding to work with current device trees.

> But nevertheless, isn't second state the sleep state? How can you
> configure pins for the wakeup state - like being in the wakeup? You
> configure the pins for given state, which will be a system suspend, so
> sleep?
> 

The sleep state usually refers to putting the pins in a state to save
power. The wakeup pinctrl state is for putting the pins in a state to
allow wakeup from suspend for that device. Both 'sleep' and 'wakeup'
are for system suspend, but they fill different functions. The CAN
subsystem also uses the 'wakeup' state in addition to the 'sleep' state
[1].

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/can/bosch%2Cm_can.yaml#L121

Best,
Kendall
