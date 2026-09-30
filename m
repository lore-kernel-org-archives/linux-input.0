Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB94ABBA5;
	Wed, 30 Sep 2026 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800268; cv=fail; b=mJ70LjjkENebjK0DDG1G40QSkBhyKBThay+gD2S2BESNIyO54RVwd4rQDm/7/IQlz/6ZKzv9OIjZLZIG9kOWqi+0pLMITpPRYyHqWnLJYxXsHPTsPRuvo/77Up83rpnsHWKr1ReZUlJ31Iw+SJadPxCBk/fDfxf+DwvT42KEg5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800268; c=relaxed/simple;
	bh=UWm4h54C4v04iCsc2HGHptZEfqPbA6+kx6wIi8spX6U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slzekhF0kzy3uwMr+gNYV/FNPutMpJl7p0bqDqMztoiwZC+ZOk2UkDHH0L5F4gW2x366olhHUamAfZ4a5RY5ziqyyGjbRna0uH30Fm/YhAdqGEK1m5wB/w5usgZneTisZ5wRdRAkviUryBryd4442dTZR5CgMlQdRLK6urtPqJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=RY236dah; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=cCx50zTY; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="RY236dah";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="cCx50zTY"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UKUIkD100319;
	Wed, 30 Sep 2026 15:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=jcHhWz8ODeGarJp
	RYQJahQ/yoqO4GUE93zFwtbFcyIw=; b=RY236dahdH2pNJFF2jxvuRaIdB/y77I
	YqR1g5esHhQJoQF+4niPk4vrdu0MymEecNNbOaVUcuwHgZIznw+HbE+pHnkh/Fzr
	bi8GBNVwkd5srwa8h3BVoa0DlI4S7WilSERFGh4ieXYeQbj9QcSDT5WtxO8kdPf0
	JQ8oTW53ROJT00cjKN6LqFWyZeIiiE6bRBW7IA1mjU0HzmayXP286dKYxQhnHMm3
	qmJPTHlqk7shBNLGIFVkLQQB4oJwlHd29CmTpT4HmNpQI1MpyP4QdMyrtnK6Or32
	dC2xvTUHasJ5wRBucQd4GnYAyP/HJutfukR0R2fEZLxZrWyKtW0TshQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h0ydvbsgt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 15:31:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoaVFSPzh+g6+sisKvH5ogtYSHMhM7claHVWPlD197yqy9cQLSuw9DQNGXLn1zqhbYaHyGB4YxH6hmXww8aq4vVXb/FnLi8kY8MVJSThzlQt1SmILVSTN1WvgDcwZie9bxytQ7uxLS2MI5TSYIYWG+rgdS3Z8zwW88PaNIFjmg0zbWD3WjKXV93mJ1+OErJP8IpUiimJqCox/+hnZOqVH1koP/JcUIDXl2fq7AxvvxwVi1/p+K/lB2oCbR4VlCfCzb67Q8sGrLA4U7qcFeFiJdim7JheSt4hSEyG8rv5pV8/A13rSI2bHD5TOF28j1dWD25AjY3J//JnPNOsaSbO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcHhWz8ODeGarJpRYQJahQ/yoqO4GUE93zFwtbFcyIw=;
 b=tG1a5+09oQZn3Spd8tmxKTF8lpy+eC7yjiU/Jod87uW04CB9Mh5SkRXHU4XvPNU3F6kQ+1KcI9MoQhWrwK2rRg/iwnVl2+DFOOrdXM3XGp+W8Zq8W9iVX1JxoZKVToYuZg80PAfGDpw4gDHHUBk9vsmnJ5TeJ3PPFYiCE0E62ADa26XBCmWySFvbKvJqND/DrTHPrsHu8eq/iJBSa1bkIv1XDOcRZG0C4oU126yGSHziiR/3goxXCRb4VTmW6jl6GSixo3N1Q5lJid+LxjK7SLjdWX0Sqp6ysFCUsCulmwjpKCnG0odzvFUzDeTjUWFk9ghZcTOZFts/wkpHx7/Edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcHhWz8ODeGarJpRYQJahQ/yoqO4GUE93zFwtbFcyIw=;
 b=cCx50zTYN5hb4bP6qL/3sEPxJm09JHDGP+P8HqBuQyZgh+CqAQ+eYfRtn65qh3KR4b9lHQdcF+bp3SR0xbuVSeRho7qXxhTyY3SraooAyGqSKDBZ2QJbSi/iKJrAEB/t+JgsGMrru9Kaf0BFw0sRzk7PkUlz/ng6Qv6bUxjc6QQ=
Received: from MN2PR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:236::11)
 by DS7PR10MB5925.namprd10.prod.outlook.com (2603:10b6:8:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 20:30:57 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::14) by MN2PR05CA0042.outlook.office365.com
 (2603:10b6:208:236::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 20:30:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 20:30:57 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 15:30:26 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 15:30:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 15:30:26 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UKUPnC3801755;
	Wed, 30 Sep 2026 15:30:25 -0500
Date: Wed, 30 Sep 2026 15:30:25 -0500
From: Kendall Willis <k-willis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <s-kochidanadu@ti.com>,
        <a-kaur@ti.com>, <s-tripathi1@ti.com>, <vishalm@ti.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Input: gpio-keys - support wakeup pinctrl state
 on suspend
Message-ID: <20260930203025.yxfg4ipykfbfhpkq@uda0506412>
References: <20260925-upstream-gpio-wakeup-v2-0-6c5533356246@ti.com>
 <20260925-upstream-gpio-wakeup-v2-2-6c5533356246@ti.com>
 <DLSN3HSWU044.10UYU9AQX2MV4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DLSN3HSWU044.10UYU9AQX2MV4@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|DS7PR10MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 60700009-f332-4fed-4f5d-08df1f31bb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|10067099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	CEQyEDLg/hn4eERIJBi8IF9WFnpp+xi35jYypViR3J7BeCc8/anhCWVYphXJ8pDa9J6c2dBLZRegHakZssbT6Sv5Jb7jfXacE7JN4H6g3n1wzZY9yIJ9RJBnjNhYVM8clHuR8pQMDQxaKSdG6NvcCDFXpj+R56eFCkrzhEC+ZmzxalSW3MYNSaSUE9Bef4swaEqzIcXCF3fW410j2VdVTzXGDmI2ajQS/vExQzENXrCnnz1HyINUHRnczuY1qNa7jYyLjVh6LuXFiof0dert8aH81gvhfgkg41Etw38++gU577+MT0JIcbd5LvlxoCYpZvbz98IF8BRAlT++xcqfPGBlZQxM7W2XRch1GRODEfRFt0b7NJqAalZa54O6xgKhzgMEh7u/k+nNcuzxuSRmit8hh6Ep3lkIrsJnf3nwdaBxLyPA3hVlYu9r5f8hoMvu6kairEWcJjayHFye7HdkLlutTSsYyFbMJSaaWnzUd4pQQcHBQ4MkxUfwf8hnO6Nm7J/h4/TXD2HtIpdhc/zGZJjZbgf5LyKl2S4ZfazbnfuOY0O8YYuieFU27aFCEDTkK7vAPoa0N4ozXNgF8qcDg9j86DTkZaELlE3Yn8qg1gl7vUUoNOC40o9MI6/ixh3ebSZnl8aPEh9E0Jy4FjaKtR09v3iqngAsGVfPDilRMuN6e6w32/A0bNMK5ujnFPxxhxWkTBayuXxQsepl7ttZSA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(10067099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5NWiJYxxQ2OddBr1lv68q0V5o1VthEH7qflUZ5uln1MHXcdh5Kf+mB2A6HR4Qhpjl/3T/TMBTMTG5bwxqL/VhloCzdDROlr/sIx+6Z98jPEUCNb5H5G5nBi4i4+rargj+Pt8SDtFg00tId9veBrXX1iw2BOn+LQDkbteXbHWz3aSSG0KMioSMQ6W13uclUNnifDidWqmNVhuoXPe7MNtDi9LHtJ1ud3miW7eUq4ITnseFoNp9zDnUhdoeOaRvQ5RtHIUpesRREZfoGGijgA3huWH99cJzLBgP4n7o5Oy8WPcFo8kncR27V5QuZnSrU9zId+71ZhEtlRkCERaXT/iZ14FkJMSqJBcxd8RWkxA1CVsRbBlpgNi9gG2aoAisLMRBm65GBkzp/riJYA3raUaU3L2bt9V+2IxpmfUZT4V6XzVVldE7KCqc2ZN/EPwmeLq
X-Exchange-RoutingPolicyChecked:
	cuM+/4uTqVfSaJv3H0u6Rsd/cV0c5ZhikWsF4hjGHdNiqwS8ZRiXhHf5egfc4KTJsK9O1kGRcC2nzLsZLt4Apb4ok1HstR0qnMsFMygELoVnsl0Xc4VYPh5vkiEreQV+XHA27JRPVS2IQwooG9FhNRWtxN4RbvTGLw1mAls6BYJ2eTkTO194kegcmr/FM2Pa9nuRTCM6MzaGsIpQRBkApXrYJPJi3nUskocNOj7ROOyLR1xf3P8PmRfSbR1mspUg6uX3Li8ntcwTfuXH8fbU1+7Ot8/Kdt6v8HR93Vpo9rfQBQ34jVyAqHB9qCU6Gn1gxpcSjQkWa/urInc7W9V+XA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:30:57.0021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60700009-f332-4fed-4f5d-08df1f31bb99
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4MyBTYWx0ZWRfX1nJbcAkOXiRH
 9NPMRuPeFEnjctme2PYIpYY3ZCSneCQhv+Gz4BfbKaSvO5pAyetGdislLF5sjszwcLR2Z5iOh6o
 SzqIydI1seIaVcp/kib43azKKQAELV8=
X-Proofpoint-GUID: _WIRhx1Bh0iJJygIC0ZZ2KPN8YEYI9-_
X-Authority-Analysis: v=2.4 cv=TegDJhQh c=1 sm=1 tr=0 ts=6abd7186 cx=c_pps
 a=hjCSP9ZXGz/ZSNNiZYHiPg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=dYMiIVJW8jwqjlodqNAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _WIRhx1Bh0iJJygIC0ZZ2KPN8YEYI9-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MyBTYWx0ZWRfX8CPqrPRKPQW7
 rkYPB3WqV8ap/jeJyBNfjgHmshXWG4c+iVuudFc96scqy0lgeONfWzQ+XAgSqArG1+oQTyx+Lrg
 7nME+mtADVYKl7EmdVfR5ZQdLwGHmBKU5uY6nWv8t6MKR2/hj8QHizXi5jR4zZjZlZGOEUO4w0S
 fPsfFlqcF402VJCesKIlUVSVTwnQE8JfHVhu2xyDQT+Z/mv4luKjITrK5zPNKKXBn8h+fGm0+LO
 EAq0WEteXCPTIXf2+Zbit7PVELzhgDEhp+GGTVMEhKdOWbLc9W7hKFlDAsEgMv+lqeKVz+ahJeW
 PPRaRxM0OOLe0Rn0ViFXgGSlGx3x8P+VfI6Wo6RF7X0RX6pniu9p341+S7JF/EWFnHbJm0o37MX
 qY+6rEHmqs3p8tOB5DROQuujh6HBmw1ZKlY1e78fLBpJliytqKOvqIaz5opLjfSAA8z294UqWIH
 9QXBRRwtSpUmUBhH2vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300083

On 14:11-20260930, Markus Schneider-Pargmann wrote:
> On Fri Sep 25, 2026 at 11:52 PM CEST, Kendall Willis wrote:
> > GPIO can be used as a wakeup source for TI K3 AM62 devices during
> > suspend to RAM states. The GPIO controller is powered off in these
> > states, so a wakeup enable flag must be set on the GPIO pin in the
> > pinctrl in order to allow wakeup.
> >
> > If the device is wakeup enabled, select the wakeup pinctrl state on
> > suspend and restore the default pinctrl state on resume.
> >
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index 129fc4212a5ed126496b331ce626682d441c53bf..d3fbc9776ac8cbdc7349a28df990ee609edf9e59 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <dt-bindings/input/gpio-keys.h>
> >  
> >  struct gpio_button_data {
> > @@ -60,6 +61,8 @@ struct gpio_keys_drvdata {
> >  	struct input_dev *input;
> >  	struct mutex disable_lock;
> >  	unsigned short *keymap;
> > +	struct pinctrl *pinctrl;
> > +	struct pinctrl_state *pinctrl_wakeup;
> >  	struct gpio_button_data data[];
> >  };
> >  
> > @@ -884,6 +887,10 @@ static int gpio_keys_probe(struct platform_device *pdev)
> >  	platform_set_drvdata(pdev, ddata);
> >  	input_set_drvdata(input, ddata);
> >  
> > +	ddata->pinctrl = devm_pinctrl_get(dev);
> > +	if (!IS_ERR_OR_NULL(ddata->pinctrl))
> 
> Should this check for -EPROBE_DEFER and error out in that case?
> 
> Otherwise looks good to me.
> 
> Best
> Markus

Yep, I can propagate the error from devm_pinctrl_get() if it is
-EPROBE_DEFER. Will fix in the next version.

Thanks,
Kendall

> 
> > +		ddata->pinctrl_wakeup = pinctrl_lookup_state(ddata->pinctrl, "wakeup");
> > +
> >  	input->name = pdata->name ? : pdev->name;
> >  	input->phys = "gpio-keys/input0";
> >  	input->dev.parent = dev;
> > @@ -1010,6 +1017,12 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
> >  	int error;
> >  	int i;
> >  
> > +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup)) {
> > +		error = pinctrl_select_state(ddata->pinctrl, ddata->pinctrl_wakeup);
> > +		if (error)
> > +			return error;
> > +	}
> > +
> >  	for (i = 0; i < ddata->pdata->nbuttons; i++) {
> >  		bdata = &ddata->data[i];
> >  		if (bdata->button->wakeup) {
> > @@ -1023,6 +1036,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
> >  	return 0;
> >  
> >  err_out:
> > +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
> > +		pinctrl_pm_select_default_state(ddata->input->dev.parent);
> > +
> >  	while (i--) {
> >  		bdata = &ddata->data[i];
> >  		if (bdata->button->wakeup)
> > @@ -1039,6 +1055,9 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata *ddata)
> >  	struct gpio_button_data *bdata;
> >  	int i;
> >  
> > +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
> > +		pinctrl_pm_select_default_state(ddata->input->dev.parent);
> > +
> >  	for (i = 0; i < ddata->pdata->nbuttons; i++) {
> >  		bdata = &ddata->data[i];
> >  		bdata->suspended = false;
> 
> 


