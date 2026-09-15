Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AF40B373;
	Tue, 15 Sep 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488622; cv=fail; b=LRg9ocdgDvIUNrfkPOvIJz/w624U2ETnNpdFHHlghz0dgjkvoted1g2gvk4YyAmSFIBt4njstNMyjk8qLV2jSDi0oWG4SPQlYsD+brJ0OERhNGfkEbg/d//0eo2soTuY9TLnmezMKED4FvEJiX/Ps2KAG3NlzCZFRhzXRCR8ujs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488622; c=relaxed/simple;
	bh=J60x6hrGaUzyWySn3IxxvN6UtLLgW9i1w5G43i9YeMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0oHVwb8QJ3iP2PX4KPEeAxo5w0xfX8z9CJ1Dk7wGC3Xlw9rsxlKuBWQLQASpWoLVLHXRIC6dBqeEb3whTOE/RrxwBAOHByZN/cLq9C0vl2EwloBM1ABpMYBIyxyJ5qh73M8AI3LrjA6/WF0bmfB2snOmcpt01thlA0nKWP1kfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Toxb16PV; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jqmqLCZi; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Toxb16PV";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jqmqLCZi"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FF6uHC257826;
	Tue, 15 Sep 2026 11:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=0L+f7fKSwUAj+1r
	RwxE9mpJcW73eGk63V4sOv1OL9OU=; b=Toxb16PVkyv4SJ59zi7/JaL9p9S3WbO
	bKr6TRJKWpWWH6wOQXXoLA828aGEFs0L2GharCs9Ydvr8D6mVh3mD8zVZdzA5E6L
	XgZVFAHYSCrkk6a90j/d5vazJfo2YW5/bbDOIordTIxaMCmO0POtJGeKtclKfNXc
	zfU+QOs5tQ1DJIVlqDFzD0N3gxsWPNQyVw4NKdRn0lXAyZVML/+rlJh00FlNdOM5
	dRDqFOUwq2Y5+ZOOmrtLOBBv/cA5uIGZAO9RLlBj3YfAP2nXpCgrCgZZdisy/sAZ
	YCH+8RcwRHlqUzn/nnDuYvoZmycYQntEjhzlHL+VUB4Yyatw++ZTOcg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gq362ts6v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 11:10:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwoPzZ1Bcf3VAUkoBbwS9a0m7wJE5nraikitT6HYsEcikXc3emFl5WjWpFIFfxOGfmOIaF48nn0jwobPOb5R3yGYyirWvt5bpthAvBElgMNU0q1Q6wTxCQUT2qa74gXChnKQqyoqIBiGsV/Jmbh7uOqxd/Y417Ffu2/q6FmWoHlsEo/UxVqkhHhPSeBTXboV45UDQPEhViSMoTguJ0rJYbE+kAITrLgNA9I4Ty0Mn5PC/YD527zIxTqEKnv5EPPBMGtXvv42RXl2/I9EeCRNyBl5s6T0XBVxVPA5KymDbOL7jLoHMOQDeBMPjXEMUK/xmpUtkhVe3uvoYpQDPflnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L+f7fKSwUAj+1rRwxE9mpJcW73eGk63V4sOv1OL9OU=;
 b=lsz9DEKsTfKL6d2lRPgI4ugHTpLQYiygnCRhf4qkkjr+9MwWQKHXlEuwWRoEfrw+RWx/qzAHWnsYv1sKuRCIrL0nXXeLvs3UMqkA/0ZK7tPK0mMu3KBhGjMDvPOb1ZfEeam23JfpFZcnYsK07eC6j4Rog2+MSfz0buvSzqi1JAh1W9g4Wf1fenObftbo48Y9f5ei4tBW259FLAAZC1lrxEQPAmU6trcMoRpjpyaLC25ppq5CFiQvJyZsb0EANUgck2I8xJtXReqs6tFmOpoZNs0uAqm8+VDwWyucVOSm1Tafcmgib+rCkgNPfx7LpiJPPlZLFh09vWuB6S66ECRxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L+f7fKSwUAj+1rRwxE9mpJcW73eGk63V4sOv1OL9OU=;
 b=jqmqLCZiuY659av8xYbgmjIVoWnhai0Z50AOdxw82TksBrjW679DMssyzGH1lKOjAmXkOzWpXdw54ICm2xYMO8I49GMP7iZ9fioOrV7W1o7TMaaLgrbAEfsE4sHKgiVBfsP2EY6N+BVIkphUy7k6RECTKPm4vkFHkB6796ytNPM=
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by BLAPR10MB5204.namprd10.prod.outlook.com (2603:10b6:208:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 16:10:13 +0000
Received: from SJ1PEPF000037B7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a6) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 15
 Sep 2026 16:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000037B7.mail.protection.outlook.com (10.167.244.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:10:12 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 11:09:50 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 11:09:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 11:09:50 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68FG9o39302770;
	Tue, 15 Sep 2026 11:09:50 -0500
Date: Tue, 15 Sep 2026 11:09:50 -0500
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
Subject: Re: [PATCH 2/2] Input: gpio-keys - support wakeup pinctrl state on
 suspend
Message-ID: <20260915160950.fortr3ptp2izzxjn@uda0506412>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-2-f0e12484b836@ti.com>
 <DLEVJIB1SL4O.2WZY8O2F54YL4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DLEVJIB1SL4O.2WZY8O2F54YL4@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B7:EE_|BLAPR10MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df183ac-fda2-498e-c4c9-08df1343d2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|6133799003|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	a85PiC2AC+7Il17gs+MQZBbfblsThN3TQ5i/YdhMmv6+WBR2Fj0BC8Ac/fQcfKUJKhmdrzhAJG57uXGkoZK/PzfyL0Eo8PmnZOqGmwwrdoet6i6+onOWuIgPAZIi5qb5fnnU7F2JDB0oaU4JnE16rcFtAPiaKP053Yml8KEPdvK/9UXTAs+xR0lGoWGYbWnLFNXJIPQ+tTkgvmfUGqEC5o1Q3DrR8O378brll3Us+gylcK78ubLUYeAEMrrN+pbvvZap2iBaISrGmPoyKbfJxErdKChFh+/vg1cdZSaEJjhQWaQxoJghONR521rdU5sG0BgFSFHHZyTa+1PbtEVsMnU/byGrkiuqnTTlrAtq0aqdmYaSj6mLbj+CU7829FqCW2ivfTFAQrKT1qAi+wjq6XP5IysDZBhaD94FQ8NK+E9KoH9xUchvr7gON67jtKynp2Ie3BwmkU22S9+oEIWcr9+BdMpu62VNrhxp89bJn3aG+1JlnJfUy64VP6eF6IK/Gda+HR4HkRbc2edkvVWNjwbZScjYTov3X8M/5VymPLGPllAwG6CymOjAIQCuyqC8ymRFZmBdZ1P0UOSXG7HTiL+Iyb9wWePMD+NBT4En9v8WisnHJpLItgEH5Q19V6CS0cmgxLcmX/yQjonMtmVDBujj/dAkd9Ai/kkCCVhoHFZuVa4TTn3ftkoWHINSxS3wq4Tn8A1P+5j/PMZxQpwXDA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(6133799003)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZaTEbro2Kpjd+30/xjSR1f6b2DozhCZkZOpRGXCQaup5N8/KHFlOw8G2hAW0zB++zZGgC5quTvNnkMk2oONN2w/vtP9f/pZ1GRANua3j7WeqZWFhYwiFK/pHkqEgIW7tQJEt2OaDLm8xzlZOpeKdxOAfWL6NsbfQ0Y0+Y0gFiDfR2/CLPtSNpCrcIt4Cvup0j1nQF+5qx/DB2SA6PDg7PCyN9tu3MUmrSPtZKdRc0rtcvIYZSY/XwDda5m5fNWUVwIpCt6C/Y6vtDCEOLb9ZZXTHMk/kisG98IWFdmp/qjcqFgDlt7m9lqZPJJ03w9ukbBu4g0FfSK2+aOF7ymN+5ClYkvMd+Ia0ywnTBfYg+ZI0YtZ/2tMgUIEOwjSpRXUABIIVUqQ1zT6Gm2qI64ChZlB/OtAJUx/nD5+8rfg2n5IA9G4yFDLVzj3GRgMwxXom
X-Exchange-RoutingPolicyChecked:
	0zDf5kzdzlrMx9G0/nmRokM3nVyBK/t6uDUa4VZ0LRTF6PNrUJSRZb4CRkirbl85pFLlk622P4YJNWoT26r5AaEExJs/ZhZSFgI+aljm0JMZ6FeGx26jNjcNEHlSbVvUw3eX+xmRz95DARVClo+nfDTz/w8F3kWXZqdCahY+qsG1rEkxqOsQLqwZ7hrkD7CDwOJhNmmzv1ORhAIMaLqki7MUR+5DiQN3SgIWqr0b3Qfqyhgp6JrITwGSphgaLvtrt6tRc+gnm7Pwzl07qA5QAE+aV2oyI6Z7EybmhDDDJTEmsmhVXtWIvBC9BkoNwY9DJPtafVflXj7PhjHOH14eBg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:10:12.9211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df183ac-fda2-498e-c4c9-08df1343d2cd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5204
X-Authority-Analysis: v=2.4 cv=P9yvFSAu c=1 sm=1 tr=0 ts=6aa96de7 cx=c_pps
 a=gOINuM4uNKhgYw9Qn2OeKg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=Fng_SOEyvtAQtxmiwdcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Zk0vGMr7RX3GH9LY2GwiBEbLaOb3KuA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzNiBTYWx0ZWRfXzLM/sA+mw8wv
 +Bx+TZQ4OfEmanxk6wBeG1WlML5LUWTjKXWgg4q9YFTshy5gS2L2PDg/SVg8Op25525pLLOW3Dc
 rYRiZJGgS1A735RIQmaf5DrYUSlQDJlFWa/0g5i3mosSmuBIG+BWFKRhRvY22m6G7kHEGyzBa7p
 0TdXcVk8vuuHvGa/KlUOo0IArXnIeckadEv5UdSXB1gkb9bA03TghLSCEtLZaQ2RJruZb53fmR7
 utimeLL0nbI9lnqogtDZQH9hXsLJq8Ba4F2i/RFjC2Eejp/WSsq/O0W1KBukio+f3kDxF0jKaPv
 71tMZwHvDfOqvyWenaiT7TQa8ErM+ss/tyuP7NtgxSmJ7SJ6dWlu3CfFbBtsfXyP00aG3laG4md
 9kwDkwE9PoVlgm+uU5blD5BRaxWq9AjnmAG6D8gHgyswzKWddbtig+YLW+tqrihPTe9k8ByRCyN
 oNsm6PHv9dW0T5TjbQw==
X-Proofpoint-ORIG-GUID: Zk0vGMr7RX3GH9LY2GwiBEbLaOb3KuA1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzNiBTYWx0ZWRfXwSPupEmA3d/Z
 ZqcStC7Fw/F531meQs+P7vT7AfI/RUpfFnBYcRtuCzQb6+m6QjfACs4C6b91ViTZBoxQCh7Z2ll
 6mGNaZ8KzANj/8HbsCXpA5rEIG8QPII=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150236

On 09:51-20260914, Markus Schneider-Pargmann wrote:
> Hi Kendall,
> 
> On Sat Sep 12, 2026 at 11:33 PM CEST, Kendall Willis wrote:
> > GPIO can be used as a wakeup source for TI K3 AM62 devices during
> > suspend to RAM states. The GPIO controller is powered off in these
> > states, so a wakeup enable flag must be set on the GPIO pin in the
> > pinctrl in order to allow wakeup.
> >
> > If the device is wakeup enabled, select the 'wakeup' pinctrl state on
> > suspend and restore the default pinctrl state on resume.
> >
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index 129fc4212a5ed126496b331ce626682d441c53bf..b409e179705195e5fec172ff62088395109cd758 100644
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
> > +		ddata->pinctrl_wakeup = pinctrl_lookup_state(ddata->pinctrl, "wakeup");
> > +
> >  	input->name = pdata->name ? : pdev->name;
> >  	input->phys = "gpio-keys/input0";
> >  	input->dev.parent = dev;
> > @@ -1010,6 +1017,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
> >  	int error;
> >  	int i;
> >  
> > +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
> > +		pinctrl_select_state(ddata->pinctrl, ddata->pinctrl_wakeup);
> 
> If wakeup state selection failed, should it really just continue here?
> 
> > +
> >  	for (i = 0; i < ddata->pdata->nbuttons; i++) {
> >  		bdata = &ddata->data[i];
> >  		if (bdata->button->wakeup) {
> 
> There is some error handling below in this function. The selected
> pinctrl state is not rolled back in the error path.
> 

Thanks for pointing this out, will fix in v2.

Best,
Kendall

