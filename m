Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30E39656C;
	Mon,  5 Oct 2026 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232999; cv=fail; b=h0ZVt4T0iJA386cxxPrmrfYtYybCncfQJu3YteueDWXIyNoMxl0jX2F1c4ZTBXxNzBDNqxsCVkY0N4S5vZEPPjUGCFdLgtPlGBfgoMCaI+rUKEeX5rDLekUxR6ACYvjux1nN61LdIgWDnsy+xg60sflqMJujhFMyknXOKHW1820=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232999; c=relaxed/simple;
	bh=g/n017PRA/8Hr+XHsrvbTfivPQ21orBySQxhV8P9dms=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6z3MGEkWJJfT5kUUPGyQPVdxkDy+/hqq/k8ExiEeOasw9spRJYsp/mof4DoKrpJwgi2fXvVgGfDYmfX+9OveC7AOlcCM98OvN9qt/JyM7Skm+9PR0Rd8yzrIsb15BxohlIZ74/v741ZWEml1t4H1jYe6zOqA0fq8GSRlKMUrVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=jOx2OlxE; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=VR8BFbSE; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="jOx2OlxE";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="VR8BFbSE"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HLOVh543855;
	Mon, 5 Oct 2026 15:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=dKJuj28VtPHOSZa
	vm79Qw3aCw72vwvaf4mjJdqiwaPY=; b=jOx2OlxEiQWUdnzMhdNHLCpM7xLp+10
	Oc1q+3p87s4eRjSb2N8K4CHXgLlvNewBRycWfrxr1BXUNzNo1j+WpiIQxIbGCeyc
	11qMDERdVxQRyUnE4ASvYABgAOdFq4uYCWRZOU6Rok5kqB5QR0fxQuQX5CS5yOM0
	XaiEzZSbTaOa2a+JDQgRpc8AZqeUv14pCtLTNSGGY/3LV++oZf4Zww79rLr3I8gM
	SF+spaFNN6p/UdCgKzPm6B69UjbrCHWo9oM/N4MbbXeYxyQcrrotSnJKHXuPrhY9
	BiV9wjtCSE77bT78nfLlKMyb171ixaY0ASB74utw0BomSnDbd/+NmRw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h4d7c2jex-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:43:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyM897sX7Zpo1ijldIbIfLX94Pjud/VzSo4Trs/VBTspaAseul7NQpzkjz1pSY0KTQyenMvLV4Mnwy0LsBhxo/jTISpuWRGhuFyp/UeRoA9DTnE445xuJ5A8LvU+v//lDEPNtIaGbU/5COHy0Pz5RPmSw0uR8HnTDA2tpUDuhThkx+C3mWCcxdUocp+1EXWMbXCj6CFYig3uQdGtep4W+rQ5twWXoLPSk5bmfCOtjTyjgYmRDciKfTPeO6M6svF4i5xxSrrPFl8QHxNc3ZYdf18uZ8jJTagxM19bejADsGW3+5lAsTHRBDpbSIQVWZUJBOFZfClEjeC6BXe6syUT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKJuj28VtPHOSZavm79Qw3aCw72vwvaf4mjJdqiwaPY=;
 b=vfeUnpUiNjxw+OKWJLFKqJjLA4nD55BvSb5FWJby6w5h7+CFESyqu/dQZMZV9G7Md1Ctn+PbrzsHXAyuNKJfeIbBImrzdBeCBZp+npbPXk2oMIWyrkV7PsFdFbwiuYqPcomKEcUXfsRyPzuuvNAdjmWfJl3EH3Bi+hS//WLOY+QV1+2pd5Rh8JH39RWfl54Ie93azh1S12OnWSUcrvgmhOxzsIXgKsQHv/aROm+SNFVscVYACzwLn46Ax8/2ehHg/tVyB7UP5tqzR1lI7QVouXNnau9rb3kbnK0tBs0YA3zviV/A2HxJBtgRgZRD5hxH7JMo6Aqlb44c8oapyR9jBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKJuj28VtPHOSZavm79Qw3aCw72vwvaf4mjJdqiwaPY=;
 b=VR8BFbSE62WPKvRSHAiHCpLXIQdSc6ALR6qnY4OkR5wVymr5/rlsrQDQhxgs4qEeElRjK5kdrcedoQu8SbOIgAOZ1a2J+NBE/mGVeCB7KlcstyiQySAqHOik65wN2KQk34tfrNu57V3IU1h3P82d5ei5/FymmL/fzjhtnhTMu/M=
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 20:43:09 +0000
Received: from BN2PEPF0000A98E.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::38) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 20:43:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A98E.mail.protection.outlook.com (10.167.248.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 20:43:09 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 15:42:48 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 15:42:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 5 Oct 2026 15:42:48 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 695KgmSS1854283;
	Mon, 5 Oct 2026 15:42:48 -0500
Date: Mon, 5 Oct 2026 15:42:48 -0500
From: Kendall Willis <k-willis@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <sashiko-reviews@lists.linux.dev>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Input: gpio-keys - support wakeup pinctrl state
 on suspend
Message-ID: <20261005204248.57wr5vyknulpsrtm@uda0506412>
References: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
 <20261001-upstream-gpio-wakeup-v3-2-6f3bcde367a3@ti.com>
 <20261001160201.4F53D1F00898@smtp.kernel.org>
 <20261001161231.eopj5fqxfn6d54sz@uda0506412>
 <asCRyl0MeG1AWiZW@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asCRyl0MeG1AWiZW@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98E:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecd7c1f-8121-4673-5fa3-08df2321446a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|10067099003|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XUiYKf9lVfmNNna0Q3Gt994mLS+eqLtaAM24268Ny667f1f3w1QmkQlC1oJJu1Ygj/n6VtYTdC/km/pU9ycJsuyTNCmTWDx8c7bUFB0jf/zlWf3lH1id82fbUd27gjwcHySQEdGot6266kMPgIQ4f+OagR/jIjugFJXpZFDKxta4G6I4rUnZFqgNJ+KSw3Kxvrz491/gdk8tvpDZvjQwOynu5sX/UnxmK31gKMLDVZ2pPhXxbDQzOM0FMlwA1nOYPNsKrkqONJimytv/gLVSku5sMjEAnoAXPP6KR6Dt1Zs0OfVNdvH4x6ElX2GkfxuFIxF1GWXn9K4UyVW+/A2L5u8ubVRg2r2npiyxzpisNiyquIF+FepDFTWfpnO9oI+J0QMJkIpunNtByw509pIydI4XZSitKLtO+Wwm2QDRBob+ncmrtPZvR782y8Ar7yJt4Zwym/k37bx5MAXlX9TPqySjTX9Qc65fVRF6KEd5RqAU5Xkm+AMSasKmuVgZbxWiAZhsOF6ucoJbKEWYLbzBXPK/1FmTBELmalPNsG8BV1/bhA79wGfrKkaXjzi4lJz6jTKmObAN0Ib1etyJp4MSEw1y9jYCHE9cWdD/w8JUpq2FnTAROJbdI1AtisKQDJrBwMQIX650JVXxvJzRZIN1NrhxudnEL2Mhewigmb3a++H+VtNEJd8JJIgrdrB2nm55HMHcaFQbSsAAuOvtHaHsIQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(10067099003)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yEEJXPA6lhl8vxWtOduDDzUy1EC/FtLfUH/xzWBj+71zFWU4kKHs2tzAAPZf7d85597UHC5yjXDJtYafYgldnRWkvCeDqVfs8gVURjBGziZdCfNi85W7FtIzK6bVewuOhL9Lrg8RFWVFw0hgXBnwLnZQdAbd3r0y1geqM1VTg8heKXXNBS3t3ZRlfuIvoOAOhevpGhfmzvuH+i95I9YnFIlAHm5eUh0S37qCYLikFa0TP5If4DJmW0AAi/Qr9sOowzfCZs73UZ7AKCCsfPKnkfUjJphhSeImj7G1TUC0J1RkcGYG3tdhSJZ3Y1UJSnkyHlKPkODVanfDxe3XlLKSuEylLgS3VHJMkm10m/haSi7gbdXtTpS5fKdML9ljPxlUlzETYCSSq35J6nrcrwztGWXUgWYnil+sNvtPeJZWXmnUHpMp3mOzqRb5s0Yed2mb
X-Exchange-RoutingPolicyChecked:
	EuswOWnrAFz6XGba6in9V32pMjnoy08UHTIm2COLMxc0jWHYUcH8wj/3rDA+hvwaHFnyiRzfYjQNAXsOlDEUdGOqhR2HYMUq+2RsEuG+kpNiPvAp3/9R85hgOi/2VtEyUfTxjweC0uV9VzOHkFkD8HCsSEzgwODUMpVRyyKbvv5PjLqhtfM9McWRS+cr8FwFjsletbMNVd+xgjnQz7xFhxOPr740hHbOKtnop3LNHCsDlhtXk6nAr/wcmjRkGj43DjuONx+KmDS8kWMZmaVGgYE7E23KE5GboFn7TvWncrU8b1TpYHQKjLXdd8KRPPSU2xg9ga8D/+SIvGGrRVEhKw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 20:43:09.7919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecd7c1f-8121-4673-5fa3-08df2321446a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A98E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX1QB4Tmolqft3
 ZYBsw6cw/tl/mY/k/mJZ5Pkmu74U0kA8krQcThOWBif7gZzDomfePvRgp2zDMJBx7s8LqrgZJg6
 Nvh/gfVntgeJNusZoGmxpdfeXnmucYU=
X-Proofpoint-ORIG-GUID: cJGqdjTyqD6ABJzQjOs3O_p3zsFHTgZA
X-Authority-Analysis: v=2.4 cv=RfYFmFtv c=1 sm=1 tr=0 ts=6ac40be1 cx=c_pps
 a=UA+Ybm6NSixuq697YtHT5A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=T5Ejp_LkUWRfFa4TVX8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX8+kwEZSpuDGs
 0EE96u/sNA5reiSWq4Bfvous9K2CeVD4QTXa/MpAGzDaJDctkeMnNfUW0g6KXxzO2TDbKg1khW/
 Qy9BW1K7V7tWjA7QP0Gxi3d0+xPgY63TkIpJxR0yDW3MVV10b/kQJ1d5YpzJfZpOA6ZRK2E2BiG
 RFh2Iig57qO2iy/MT3iaamwnIjKO+BMxaWDet/jyx1t8+UD90J6uWYISMYSNz53oLzdZbGbiCKM
 714Miaz/+Ou22z+Va9d5/LgHxpSJ8lkcZIpNA109kJZ83EVrW9F+fogSUfHtSlgfx0tDhxmRg4+
 Xr1TEkrpVt1Iuv+ZRbMa7eO7323i2UGYbfwrYY6MHaX3ZVsvYxd8LjHSl4f4qRCIQk6FhatrrC5
 aeD0RhSePg64eUzqi4V+XG3yjXSL1a5iAkK8WzPBdHfuhmxZQCOO9iiIUm94I4MFexxUnsY9sem
 i47fU6D1jsmYnfvRHUw==
X-Proofpoint-GUID: cJGqdjTyqD6ABJzQjOs3O_p3zsFHTgZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050081

Hi Dmitry,
On 22:26-20261002, Dmitry Torokhov wrote:
> Hi Kendall,
> 
> On Thu, Oct 01, 2026 at 11:12:31AM -0500, Kendall Willis wrote:
> > Pinctrl is optional to use for gpio-keys so we only care if
> > -EPROBE_DEFER is the error from pinctrl which would mean that it just
> > has not been probed yet. All other errors can fall through and the
> > pinctrl_wakeup variable would be left as NULL.
> 
> If pinctrl is not specified, devm_pinctrl_get() returns -ENODEV (or NULL
> if !CONFIG_PINCTRL). Other errors (-ENOMEM, -EINVAL) indicate genuine
> issues that should not be swallowed.
> 
> Please reset ddata->pinctrl to NULL, ignore -ENODEV, and propagate any
> other errors:
> 
> 	ddata->pinctrl = devm_pinctrl_get(dev);
> 	if (IS_ERR(ddata->pinctrl)) {
> 		error = PTR_ERR(ddata->pinctrl);
> 		ddata->pinctrl = NULL;
> 
> 		if (error != -ENODEV)
> 			return dev_err_probe(dev, error,
> 					     "Failed to get pinctrl\n");
> 	}
> 
> Thanks.
> 
> -- 
> Dmitry

Will update the code to this in the next version. Thanks for pointing
this out.

Best,
Kendall
