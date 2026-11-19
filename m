Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104971;
	b=UxSmpSd0nGLT74s3frcbt39Yr3Tflvko1EkaQqLPWoxGdWzf2uqfm9YoWb8WcScQK23O
	 9bAHbPHw3BLz3x2vmiKnswoh/gr5/HuWaZ3wyKYTVKIIp3yJfRjQOw6UyNl7XmwqFT6Jr
	 EC0WmqCNrdV6gdw7mY3IWKrezUKBpm3PXI3kKqzu3XtAQWeYN3QpILnJVHv/bg3hVVRd8
	 WTWcdFyVvX0uNR44q0ehIeDU3vFuNyDZZCiQrUcuCHWbWh74n03ZkOtQE+x54ax7pa8la
	 8JVI74RHMRo3F6YkOUwFS1n/4gELzcrz6pqtdbKJZ10mAOnDGwlx3D5XobUUgdfSgDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104971;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NzVsXIJCsBYNkk8pMhFtk5SD2MRy0n0rMTW4bae0HyQ=;
	b=EzAQOH7aQ6AZTzi6mtUCdGC1lKyDIANANFFHVcXTIL9CFa5VSyEy1eaDsoSU7HN0zlg3
	 zaWFoEmUYW61uYz4+iDr/fNKaglgbBo7A/eTGR89R9o2ewJx9bHQ4UOYLCPCQ/rmXbZbT
	 SPnCN1sXPWB09caWhhXWLo8Od9e5jHQSR4v9rHYUSqUF2Idd/SU6TYBvwZ8E7iOKZYgs6
	 AB1j79X9VWydum8819hLl0TH1bUUuG7dFHMFy7qax3Tnepy4jxi2frpmJylo3xFDPvlyd
	 oVHXWqgMc4nJ3xpBGlqLsidoOrpaluKyDEBt5kp0dNmmEYbCnBgPyr2oN6/ST+DEQmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="n/ANKKmp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.2
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F4606A335;
	Thu, 19 Nov 2026 16:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 022F4606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=n/ANKKmp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0DFa/SfrMg7wmH5w0XGhRs4YPigsZO8rDqLq5YBNJYdCXarrgvJgkNLL3pXlxZYqMIUIuFL1VJL24FEoPSqC4Xnn/Qk1SLE/PhpMyBziqNqTK/egJml/IQmDqebyTZOSUimtqLrtTe59X+F13YiUzJIR6ATDr5G7Phd6YfQsBgKO7BGrGUPd/Y8MLcPA0MaLdVEdRYW7lqqX7TceL6TqkojE/LLnBgU4iwY6O3CSzfTSjI2aQWD/D3iLDIaH8OifVSQCjllGp1ODp3JtffQ63XTFBNjVBnjPSBgI2fGQwKRMCUQc1PTKJVRDWt4Bp62Fyf0mb2ctAjkh2fgQHVMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzVsXIJCsBYNkk8pMhFtk5SD2MRy0n0rMTW4bae0HyQ=;
 b=Iph7Z30tzzjy3nx6rSefuTSXXd1Rcy8t4/M4MNOQCHC40GS6WD2zw17THUEFdQf4H8hlbFEqPS7LWgUpy0ZH3qniCrhS9x2pEwcGIcV+zAn9j9NRKt2eTYmyeU1a3nQVI7p1YvLP4TMLMRlr17Svh+Xq5PeyvgxceZwb0IPhVnilz5TuG/y9czSmKMk9741nl2gEA48tQAi6sWH83nrXzqF2g7xvyhwQF86K5+qvx53hGGGFG3VVGs3Fyk1INIRb6j+hzTjWy2qtl9suWFrOolhUgXdMaxJOQdMtCgAUOLAdRiP7uxO6rfv3eY63RGdjGBO8leuvrM5aPFIsmQkPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzVsXIJCsBYNkk8pMhFtk5SD2MRy0n0rMTW4bae0HyQ=;
 b=n/ANKKmppTnB0rKKvP9wtdgOTMPU0oerZnYXRhGtx9p6PVFhs3he3qvF5lxuE8+mCHD5/o4PQUj1G7VO9O3xxVeau6/5b86mHg2PO05pP0F5lH3e3Q/2Vo9bFvT0Q8NjmvZfuhIx6YQ2KmiiqCTvqZ+n6JkrYq3S55W8KFJ8yLVAnHv8dhJfjjZeL9njTZdZXs68UgfOl+uO6l+UPjPqjBBrms+TfCq+SGXqorOewRWdm0Vec5+Y9dtFP/VqGY4y6v83iMAOq7V5NWAQ0Grz4Eh1YIw6s5gPVQ0wmaQjM1fc27JIhrUGdUG1vgCaUUMxqdHri29q5+GSBQ/8b5UHSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10478.eurprd04.prod.outlook.com (2603:10a6:150:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 16:16:06 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:16:06 +0000
Date: Thu, 19 Nov 2026 10:15:57 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, jic23@kernel.org,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/4] mfd: mxs-lradc: Convert to devm_clk_get_enabled()
Message-ID: <av8gvfhOJ_2PdEMr@SMW015318>
References: <20261119134041.16611-1-festevam@gmail.com>
 <20261119134041.16611-4-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119134041.16611-4-festevam@gmail.com>
X-ClientProxiedBy: PH8PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::25) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10478:EE_
X-MS-Office365-Filtering-Correlation-Id: 4095213e-c83e-40f6-c5a1-08df46586a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|23010399003|261028144727099003|261022105027099003|56012099006|11063799006|4143699003|261102123227099003|10067099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QEwW6WgVepKOs+5JKEHeJ/9kaGIPK2lCVd2/PYw6I3NnTOnQ9QQ9Z20MdcQbR/lDvTY3w4VpIPAOJQWB/yCl2hQimB/kHRAgwMEq7/7eX0kA0V3YPo6Jy2n49UVpBvrwZ7GTqFEQl47TwRiF/MfH8fFfqkgu0wRXJ87V1wDK1QHw8QNyr7LTOKL+WASRNC5o1eVRsrOVxpHXryfjaXJSxco4Jl3S00v2V/OvC+b5em8Fckzx95qyvt/a7CGajb5pvZ+o0KP7InpxOVrojN2jqGVwSlRVY47HIrgt2N17rMCWvRvjIHgKqwDsQPWuDn+KBlf0QFOj+YV6xz80OK2vX6Hg6NxiewLaHX+6Pk21jlYezQq1l0clB8BIANqY/ZT4bDuFAVdx1tE7KwPSZFSP0WKrnfJuWkCnh7qtiy7dYvZlWZM5hIOkU5WE222xD0a/tYk9yqKJeJkcqsZLwUjbq4ggXqfRsL5He9pR9qVtj7dg3Pu0HQcOQpw6UYz9W9tNo0l1scZeNqid52jzmcUnK7chVGIjKNXNZq8LU+ykXXYTqfwvhgxViinRurfuPzBWKwQ7YCdu20x9x1kk2lNX7lvhtoEG4lw3kaV11IJvwsBjkFB4by/sJZ1OM5khPajlIvzzUQnYeI1C0Sf8R00BseeuWVRUa3TqdYbYO3Emppk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(23010399003)(261028144727099003)(261022105027099003)(56012099006)(11063799006)(4143699003)(261102123227099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026140227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmegu50j2wzP9D8EbK+A3YRaXsPM6Bh2M8BEuA4cc38M+6N64Ma0Tnmt3M9r?=
 =?us-ascii?Q?/teG6aQ/kZw0+K6ZZPx8GS3McF8ojb83sV4kt581rr7pXoXFS8eSjbQ5+YIr?=
 =?us-ascii?Q?rgPGTSE32TeTZuR6XpfbhXRsgSew04VjzIi21d65kTwyZQGAPGx2xtSM8sjt?=
 =?us-ascii?Q?AB3v8uZpIwlq+UFZCTbRw30BvFVzO00udMDPCpPCd49UzadqnfosU5DN3dqE?=
 =?us-ascii?Q?MmMzxk3GHKlnp51sWk+KsLGd7Hs/30WoKB9e271160PzkCc2/SFBu5kyWZIn?=
 =?us-ascii?Q?alYV8vLkVNE8LtnAfa6+EUa2UUncKVMuoYRY4EClG/GJEj0cvNM+byVzMXSv?=
 =?us-ascii?Q?/UDdOGBtIa9jVuMImwtL64mBCEPpmL5rwgEeU46RwEv0RDdRfeVcFaRfZeyb?=
 =?us-ascii?Q?pmTL2KrwZGJm4304063HcnzNKd1+f4WxEwhaZZ60NWFEQOWqon+CPbuvRPeS?=
 =?us-ascii?Q?G70+nA4zwSrbEld5rTri/muqvXfwymTtDurw+55OYRLowQQ3+OgKdCHMy+Bp?=
 =?us-ascii?Q?0I+Fo8O//sge35yGRLuClAdDgnBsMRaDM2Zn8oy2nLGlE6P0xp65ntpgaX/S?=
 =?us-ascii?Q?qLHqiK9LquhRZxze0xbyZemLoVCctUzcLhgzWR0QbwaFr/jo0v2LKoJMdq1b?=
 =?us-ascii?Q?Xez6qn0YUUv5pCDHl8AEEHf+5oYLYZXY/eRcpU5uKJ2eour4tY4JHggt4IYz?=
 =?us-ascii?Q?CsBtfJTbwNqiZWfYqgccBI6/lf/3Ol4LO3MFozygj8ct0ZU8rOxz3QCHcmPG?=
 =?us-ascii?Q?2JWkOKYCyAECEM9T2D+/EL89RZPb2mkQkfXDDjX4O75Rn9br2ZSFabtSvnZ1?=
 =?us-ascii?Q?Hwfd+lFUUIhavQWSg8essZKog/c4v2orAfWHr7HSzKVT38RZVdpxmuVL9C9L?=
 =?us-ascii?Q?/tOR286DoQ5kYXkj+boG+q4ZoWEzE2zamZb7cn2rH65S+ZNHPlWHMaK4K/af?=
 =?us-ascii?Q?HWWgMMujlEzvF99+0HJ/osTu9IQn1qU8kobJ20p5LITWb5rMnyEmlGK37d9A?=
 =?us-ascii?Q?t96lB4MR/slchyqwYdxb2XtHdDawpTy+LDpAXWJleyyRdO+w7NGsYFUw6bcD?=
 =?us-ascii?Q?7B0l1o95qd5OjguorI5JLnVLetntEBo0NhYnwJR80naMjLT4PrgVZgHHG6iy?=
 =?us-ascii?Q?dJiBHYW+MCG/K6887qpfset3U1h0Uf67xv33V+mgeS5+u87TXklOWWWb/ufa?=
 =?us-ascii?Q?PZxyUoc5nDYEEqzODzvcDKwUX/SNQ1m78njj2pSY2UCjtdp+iycn1zFiYkWB?=
 =?us-ascii?Q?WPJ4pHeczJzZlZyzR2HHNAqQBXCfFpaB+WHQNDWJacW7U7mqIuGz7DyFWNq3?=
 =?us-ascii?Q?c/1PnY+fFF1pjCFt+Q8Scg+/RwSxVYaWTqOSPpRVrzn/oAacmiVED7ETnDd/?=
 =?us-ascii?Q?aRDf9539pQSYr0ZoEqDUg0XAw7f6sTqxCqQ15ivT3JeQbZ1EAIwoWU2SIk2M?=
 =?us-ascii?Q?tKn+3TfXnWMIkGmdOYw2rXKUy0xT9TIY5y3He7GS4ggkz4OFROm3XPr8mQIJ?=
 =?us-ascii?Q?PIf/PHXrcPJ7XM8LZs1lds0GaLdPKYOLgpCTp8A+kp5gec9llcLC4wOmL7lq?=
 =?us-ascii?Q?OqLUjVQ/WghQaSuTCtAOyrNQxu2oicOuQ83WrA3p5B0+3bzKLdX+hWNfUr2v?=
 =?us-ascii?Q?pd3dSmoRdPWAyg17r+tVcdWMo0PvIU82Uz40lKH1lxiDu6W39Vjj6jth8245?=
 =?us-ascii?Q?uvWAGkByp9ZvCWg9QxtAIXrLHVjEorpl+Qg/wgfepl33jaANhLiFrbr/SkSJ?=
 =?us-ascii?Q?ypZPMT5IolZRY+3GXwyHpnnXw+GNNauWARTUGHeedYxXND+tSfKl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4095213e-c83e-40f6-c5a1-08df46586a21
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:16:06.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3t6D+D1oQbD0KzSAR0X/wQ5bH+igOW48W/ZlA8aWZoeqcMoYH1pUHvdV957riZtnNJ+U+NKvuvNJxZB1ym9pm6Zg7rYy/NQnhj0iUEGbSu9QEXll5fFe+FkIJ6wFtI4q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10478

On Thu, Nov 19, 2026 at 10:40:41AM -0300, Fabio Estevam wrote:
> The LRADC clock is acquired with a managed helper but enabled and
> disabled manually.
>
> Acquire the LRADC clock with devm_clk_get_enabled() instead of a bare
> devm_clk_get() followed by a manual clk_prepare_enable(), so it is
> prepared/enabled for the device lifetime and released on unbind.
>
> This conversion makes the code simpler.
>
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v4:
> - None.
>
>  drivers/mfd/mxs-lradc.c | 35 +++++++----------------------------
>  1 file changed, 7 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
> index aa55f88399ef..c3dd2d80e7f1 100644
> --- a/drivers/mfd/mxs-lradc.c
> +++ b/drivers/mfd/mxs-lradc.c
> @@ -160,17 +160,10 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	if (IS_ERR(lradc->base))
>  		return PTR_ERR(lradc->base);
>
> -	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(lradc->clk)) {
> -		dev_err(dev, "Failed to get the delay unit clock\n");
> -		return PTR_ERR(lradc->clk);
> -	}
> -
> -	ret = clk_prepare_enable(lradc->clk);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable the delay unit clock\n");
> -		return ret;
> -	}
> +	lradc->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(lradc->clk))
> +		return dev_err_probe(dev, PTR_ERR(lradc->clk),
> +				     "Failed to get and enable the delay unit clock\n");
>
>  	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
>  					 &ts_wires);
> @@ -193,8 +186,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev,
>  				"Unsupported number of touchscreen wires (%d)\n"
>  				, ts_wires);
> -			ret = -EINVAL;
> -			goto err_clk;
> +			return -EINVAL;
>  		}
>  	} else {
>  		lradc->buffer_vchans = BUFFER_VCHANS_ALL;
> @@ -204,29 +196,17 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>
>  	ret = mxs_lradc_get_irqs(pdev, lradc, data);
>  	if (ret)
> -		goto err_clk;
> +		return ret;
>
>  	num_cells = lradc->touchscreen_wire ? ARRAY_SIZE(mxs_lradc_cells) : 1;
>  	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>  				   mxs_lradc_cells, num_cells, NULL, 0, NULL);
>  	if (ret) {
>  		dev_err(dev, "Failed to add subdevices\n");
> -		goto err_clk;
> +		return ret;

If need respin, return dev_err_probe()

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  	}
>
>  	return 0;
> -
> -err_clk:
> -	clk_disable_unprepare(lradc->clk);
> -
> -	return ret;
> -}
> -
> -static void mxs_lradc_remove(struct platform_device *pdev)
> -{
> -	struct mxs_lradc *lradc = platform_get_drvdata(pdev);
> -
> -	clk_disable_unprepare(lradc->clk);
>  }
>
>  static struct platform_driver mxs_lradc_driver = {
> @@ -235,7 +215,6 @@ static struct platform_driver mxs_lradc_driver = {
>  		.of_match_table = mxs_lradc_dt_ids,
>  	},
>  	.probe = mxs_lradc_probe,
> -	.remove = mxs_lradc_remove,
>  };
>  module_platform_driver(mxs_lradc_driver);
>
> --
> 2.43.0
>
>
