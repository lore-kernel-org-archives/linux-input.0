Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE2408629;
	Thu,  1 Oct 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871192; cv=fail; b=lgIJzxVQ5+POhoiCjDumnWi6OJG9LoY4iiq+jTzlGW5GKW2LGPEr6BmCGUtDx4yVJIWgLRvqa5cW38JVr0av6WxNQ/ccStiVZgK1O1KEv0NcK2OaFNfU/6bvDMKtTAhrSVAh4uv53edTxBkxiuqE1d3KM9jRIQR7NZJ9wPYfRF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871192; c=relaxed/simple;
	bh=vD0BPuuPaT7p6yFjKe/T96X9q4IxYQYvY0YSHFzALnM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COD/RWqZInJtP0o5oFpFLIm+egs0Sx65tuJ8pbu2RHaT73T+4hxVmkW/yQLEAS5LNOsmMqmoFp07PsB77QY8zTQW7ZDCC5xFhas1V+A46FEMaf6qebx6oWeKAdXlMuDtFKtFoJBvizssPDIK+N/liiUAXw1aQns8UdT6XCqqhok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=AUO4ZDwm; dkim=fail (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=hz0cWIp1 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="AUO4ZDwm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="hz0cWIp1"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FsvtT1848513;
	Thu, 1 Oct 2026 11:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ai94jCX2f0BkN7lMV26IRC2Aj7JDRZ08pTuOIaxrY
	Gc=; b=AUO4ZDwmHsly7sCOSR73xtRGRqKHR9nci2fnpsdLm4wC665eylMtPp3W2
	iO7JpS07oF1hVRu9sCpbwwSZQWqkrzX2/zXbez6szUfUq79fBMZpg1kZ0gDcNVMn
	SAvot/iE00b5nkQYnZL0wc/D+TUa0YF3Z6KzsoELs/TJiBfMV/y4GTl64EuTuYh+
	5BVx5VKHJ24OJ5laNEAjphIUATiaHKPaJkWh3/yZPIa1P1sNVuiC6yd++YmRfayW
	YfoeQ0hhwi3OxvhaQhvuzaqcirmpNlFt/iZdP2bbV/WfOZyAMK+8pTB3ZTqN8jvi
	clnbXn5v4uXGJaeONLZxoGOKQvxJQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h17djxu4n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:13:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi+xR18JX4luyB21d48Bh2RZRaolZeNuCXPccX1dNOUmTIDl+ih08T1E8o7SNc5xl53JnjLqnIkqzwzTxHTJhcAEfPlqnDbONeTXbijWhaMRtjVwta2J9VEMc2nC6ZpFqT5g1WMi83nJA7gqKYuLPYy+alBpaC22UaoebgIkO4VDMxecH3jBaCcxRIU2ulqoLec8A697SnhV7O26vwExbpBtFLgQmw1qLlmhuhBjYzvr+HPEs5RJzVkwRBw6TLMXjphkOE7e1Q9vHzkgjyqa5pgpXgEwerT6x18s63qLmR6Mghw2pIHB6lgh2zAs+Fv6K3zNTxWmJ+uDP/DCCqgBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhwQzJeRbQu2+rkNUta5D5/SeDsYskMz/pVt7QOVDCk=;
 b=g0bt8o+S6W/Ey3P6zIkVfCoIdf6m3yoljgGDPzYbFQeYWxEmSeNQPlzg3djOVtSq7nMu/v3SFOdoV/2hPb79D1f8brKMyXe3gliDYb7qlTBYMUrud6bLZpMaxAk5CH09HmcW4dUYVwKDu9yLy90AnPO2y3QXdtDKP07+51FzZeLSed5Ng6aAceHQEPl1zmDnjDuwN17hxgrnjh9NhDG9J5lDrMEDsiXlL1fSGIx1L8PyVpSZBRnc7HWkD+I402Y4EN9jRRAw8MOLnhtLZrnSpcyjkAusjv+Waf8HuIe74kFqWngHVVHnc0eAfSVvmOzBtsz72G/5Z89DQXOYrWjt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhwQzJeRbQu2+rkNUta5D5/SeDsYskMz/pVt7QOVDCk=;
 b=hz0cWIp1etidQNthuynMWUXOJZOJS+jOII3aQRkr5YDbfzuQs1Sbyn8YUUEMJGj1iCq3ogS76pO5KuIr8uTfOeOEZQWIly5A9ZChAjI6whCLS+bUtb07qznAO9Je3kgihXqTtCj1Wve0HBHNXnScTJLRULiXVVj9YU5xzKV7ArY=
Received: from CH2PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:52::40)
 by IA4PR10MB8277.namprd10.prod.outlook.com (2603:10b6:208:566::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 16:12:50 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::29) by CH2PR04CA0030.outlook.office365.com
 (2603:10b6:610:52::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 16:12:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:12:49 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:12:31 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:12:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 11:12:31 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691GCVji2250266;
	Thu, 1 Oct 2026 11:12:31 -0500
Date: Thu, 1 Oct 2026 11:12:31 -0500
From: Kendall Willis <k-willis@ti.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <robh@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: gpio-keys - support wakeup pinctrl state
 on suspend
Message-ID: <20261001161231.eopj5fqxfn6d54sz@uda0506412>
References: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
 <20261001-upstream-gpio-wakeup-v3-2-6f3bcde367a3@ti.com>
 <20261001160201.4F53D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001160201.4F53D1F00898@smtp.kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA4PR10MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c88dc04-4022-4528-bf5a-08df1fd6d706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|4143699003|6133799003|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	dPgO3nNnn1P68M1XDWo0DfdMTquaaEEqAGeS4p2BFCrbheOaCHDHESDxKiHrlNBa4ZgmaKoVEK1TX9fObvp2h58UM0r6oRfCIhYa2QrzvCtLAlo1RbB9mVskgmReGQhkeiTG1gnoNSc7FA5TextZE4D/csKenBWxro+DrTgHQBG/PJtD+hwa0Zj6S0lmvs3d3aLuWfWB9nbHEgLuvEC6APsuKQ8OGyRW0vBZSppVmyjDQ1Xg9RiWs3UK8Q2XAp1/3MZ6TOcgEemwpJfdEFibgzh/10JLpJeVVq+iKOqDGspcwbA95ZzkF8QGqy3qk7/9Ouhn48Ony3y/5YBUuIGmbvNA42KbK4001icALvuhXOnNBSWpWTNoDN2vnhJtEfZ3c9kGg3Utg0+7TX+qe6v9UdmdelImxHvzpDfTbSPGDGc+oLuwTfTg8a4Lp4MZPpwBd842G4bxc2n/j1FRd5bcyXD8pH206EHpmXhdQ0xL7pYTy03n2C5meXAkAzxSGDqekJZC2wDsmNo0uk2C45ChxzQaocgXbJ1RZZerZFgYUrjTImoNVp3gMz9Bok6stXouycUipGBj5JgIzsGjEp0p5Lv1vUc9YcZWehZYWVPtVFXqtsfCCypXztAK3W/+1iwtFrWcKeW5DalzuHL8Sjcx6w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6NlDZ8yZBfIrlpzA1/8M2FWgBls3/dT7R9z/hdIT7lw6TQB18RAY2EGY3hJR+OfvWEvsEp8RRoo3AxYSpImsUnK9wWURCyJC5wI0pnOP5ZNq75I2JlMIa6Sc17hruts68Ms3meh2KGJRtf3mXGXzEvsADUh2mbMtYbVvGG2M3ib32NJRTIuiys60szzMMVRxulOHOsUaLIsfOLH4aq9p5qMOTumft2yLMezEvMJJoBd810q/hUKMHHaHdABljEjPKBjxQsrcqnTudQYvi1+IO6aLOsSDBGXeF0fwQy+ZTKFc0RGFr5GgYuWGIaLOG/9PPmeuE2rXMAjb7Xn03jqEadCw7b8gp2FyP5iBinvFoFAEDyWlpO3XZXB6qK/AuIfNqosUtb6csu3zUPgkQdY2IeiYbfwvDNCSLjYoHlzG6dBm7E5wAlXDMYqBMkD76v50
X-Exchange-RoutingPolicyChecked:
	suQrZxgdApEeSMLt2ks9huTtX7Nx1nKGUM1VIcAf4kz7Bgh3GB/2A/bY9ObiQ15Vxdf1hc/KXj4TXKbRSWyVlk71/jO4olORMO2ud7tvgKW1ASBbab7Gol5X32ngygTmTD382YBzsIfwYfn52byI4+fodpqlcjDlofgTEjugkNDNiLaU9jEUrL0xhurPPrLWmROXF4pmaUCrDLFkU+rxxVgP36Yz/LrFQhZu3zC4oOd3HP9xxT5tPX2b0E6vaBeeNNGNurkXs5F8eSvYwiYmpnTXeYi0RhrPMg/YW9TAwNU4ocLygZWUzfXTAmG0JALRsPXuJVLC2u4jPF5FLfIduA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:12:49.9934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c88dc04-4022-4528-bf5a-08df1fd6d706
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8277
X-Proofpoint-GUID: FNiYvai0lG7mR3jRsrqSyOYtZfX6G4YG
X-Authority-Analysis: v=2.4 cv=aswnmiZV c=1 sm=1 tr=0 ts=6abe8692 cx=c_pps
 a=oox2QBUX2gBgMMQWkhdftA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=c92rfblmAAAA:8
 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=FCuVtdZQX9sabzJQ80QA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: FNiYvai0lG7mR3jRsrqSyOYtZfX6G4YG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfX3QA+IugRLREE
 rIFauBR7Jdak4GcQSkVoklvK8yi9A56/TTvIr0hfDQypsBsBfvLnoWppcUGKOxpA/JxJVUgAzOK
 3xmTOu/CLsBhhQ4LbN3dOAP1WBCjRw0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfX37zqs95NVWZA
 fu91mTAvQpesyYtnL66wjAmCDU/w4j14Up/fIcCMBU3K8C+ncN+Oe/dBqBgADxo+yzTbhpRMpkC
 Jkl+mdxkvx9jhHYb4s5BwQDBMqnPUAW3pouc/P3eP47VwTR4PZDhE3jYtPUsK5ortoI/4L22aK7
 nyDdwXhF50QPKH5Hza+kt+0mCifQ9MJVnRjcKGSfZGr+6v6g49gVHzN8k1TD7cnhEuRKeqNsmNN
 UmK0idWymUpner8SAfGM5DMyExB4w13RzSy5DcpEHWDWnXWZW372QfWtIRbsk/2OSV9ccoCjz3g
 eSbsbp1cqmiCSf+CyoSnxaJ5WJrfvcNWmAvnyKt4T8u+YJsXNXsaM7zywka8TYz3WSJXHjNxAM3
 e0bqQRkwssfmGSw6qJFwUdpECexE1WeG7gu66KxHQMhMc8/39kdF1Pl/PNuJpmfoL/tpm1qcQZ9
 oj5E9lXUxB+Tk0nnzmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010064

On 16:02-20261001, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] input: gpio-keys: silent masking of pinctrl resource acquisition errors
> --
> 
> commit f85782ff9c9eb4bfa803e47eea6427b48cb93f09
> Author: Kendall Willis <k-willis@ti.com>
> 
> Input: gpio-keys - support wakeup pinctrl state on suspend
> 
> This commit adds support for selecting a wakeup pinctrl state during suspend
> to RAM on TI K3 AM62 devices. It retrieves the pinctrl state using
> devm_pinctrl_get() and looks up the wakeup state if the device is enabled.
> 
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> 
> [ ... ]
> 
> > @@ -884,6 +887,15 @@ static int gpio_keys_probe(struct platform_device *pdev)
> >  	platform_set_drvdata(pdev, ddata);
> >  	input_set_drvdata(input, ddata);
> >  
> > +	ddata->pinctrl = devm_pinctrl_get(dev);
> > +	if (IS_ERR(ddata->pinctrl)) {
> > +		error = PTR_ERR(ddata->pinctrl);
> > +		if (error == -EPROBE_DEFER)
> > +			return error;
> 
> [Severity: Medium]
> Does this code intentionally swallow all error codes from devm_pinctrl_get()
> other than -EPROBE_DEFER?
> 
> If devm_pinctrl_get() fails for other reasons, such as a memory allocation
> failure (-ENOMEM) or an invalid device tree configuration (-EINVAL), the
> error is silently ignored. This allows the driver to probe successfully but
> with silently broken wakeup functionality. 
> 
> Should the error be returned for all failure cases to avoid masking resource
> acquisition failures?

Pinctrl is optional to use for gpio-keys so we only care if
-EPROBE_DEFER is the error from pinctrl which would mean that it just
has not been probed yet. All other errors can fall through and the
pinctrl_wakeup variable would be left as NULL.

Best,
Kendall

> 
> > +	} else if (ddata->pinctrl) {
> > +		ddata->pinctrl_wakeup = pinctrl_lookup_state(ddata->pinctrl, "wakeup");
> > +	}
> > +
> >  	input->name = pdata->name ? : pdev->name;
> >  	input->phys = "gpio-keys/input0";
> >  	input->dev.parent = dev;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com?part=2
