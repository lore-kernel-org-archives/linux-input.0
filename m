Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54626374E66;
	Thu, 26 Mar 2026 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554926; cv=fail; b=B5biuyQ/QLnaXWfkrMp5AhGqGMXCvkLHBWXFRPZ8onJ4cp1laZqC8w7ojjYSTB4fTyr50TlYmFzN7nyzhbbYJ6ByHk2IBKA1GZsxAaJnmQLZbfuarqz797AFgGeD0dQ+Xbx9hXwxlEktvNw+vy1Dwx8Crinawi8fdnydWCCW7aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554926; c=relaxed/simple;
	bh=9wuwjtNo9dJ+bQHueXO4aoo//G8rb1gfGxY73PEN0NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QktUSdsH5zdtYggmtxhYGXPNxQMcsQ/tyDSrkQHr42AK7WxXekkccuxdzBsMHaRhefbhiJeBaaAPOJqs44kcAO5Zhs2kAgjppV9HZ9VhNX0ZANatybH3RxEd4kZ9qEoJqaEdPUdBZv6GyrtunPGy0wWYtMh53+BSJT0UcNIQ/1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XRvvPNU5; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XRvvPNU5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCI0XSKu3iJ5JzkgrNErsDUT21MDKXFMJdWtQYzSyKTBwPTzWpBqiS00Iv5hmTkd8Br833yIm+wE94oxpQIsPfdweeavURVdH2pOG+qEI+DYTfrT7a2w35ussOmJ3uo7spJcu593qtOm6Ifq1iuayUlCWSW3UCt3zPXbO9FSIdLb5ZPwEwN/7fpwhqr13dKvEaNdtQ5y12FMgnJ2ATQMQzFnps/5GIxjgAeL7DHPhdg2pgENNx6zPzKhREiaOQA4x+x4jAkpOi5Gnv5NqmfDZJFgMNqHxhxfUZZdYvDVQ2unxWx0wTdjSZOpFkhImUPACoeFmoG3xVCTlWNpjsf4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYgLSFtYCBw3s7iswwh+OeJcWOa8IF2mjYgCBP405X8=;
 b=upAMryxtGW0IN1Sjlu4z+uYO967h8DHUYIScju4KPKUr3YacC2Fg2Qq0Uwq3X1LyWIfTWPjFebutIEU1zxBZk22aIjjVVRFNfcQB/ebbWDqETIayjE/Ze/zEyAm8jwkgscZB/Kc+R9+NCY0131brugVmN6oTuCrrnNI5zG+c8/p04QtarVRCAuxXeLxY/353Cpxpk5ATHsareOKtKmzsg6ShqJmI7FIyAOy72Y9JqrzZYCSs+vOzKr4/vJkHc7/mDpw1so/aEoOKMufytVYTWxG6Txg163haLHTEJJ67ZqLYgITCm6TCAO4muW5m6phwvJAKiUyY3NFydKsSLsPvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYgLSFtYCBw3s7iswwh+OeJcWOa8IF2mjYgCBP405X8=;
 b=XRvvPNU5azSp87An5hHm8uwwl0sQdIEBzkl3+Eot8a6EmrWe9h4uqUHNNhqsH/iWUrornyCOppKEvC0GlPGB4nKYS76IbR4QI1Tog7r6L+9zBnwR5flBepZsWSQwUZC093Hjl7hAOspuAlfyPm8g/bgy1Vx8kjsK1I8a4aIHTl0iqk/6LWtKIXJ3PaXO3X+MNbwGwadKwRkbwRm83JErTj2rRl4PPTdaoQtbT2My/SHSdEqv+hRY9wYR/5AlZxmupniNUQ8yOGqFFaIMXbpPTRxINrxTr41e376GGkYojBBBEpPsd2YVWlMB7IHZJdQ91U4PX7KPvU75iOQaO2jK/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 19:55:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 19:55:22 +0000
Date: Thu, 26 Mar 2026 15:55:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: snvs_pwrkey - use local device pointer avoid
 reference platform_device pointer every time
Message-ID: <acWPImHOZ7psP0nu@lizhi-Precision-Tower-5810>
References: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
 <20260326-pwrkey-cleanup-v1-2-d85d7c0bf275@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-pwrkey-cleanup-v1-2-d85d7c0bf275@nxp.com>
X-ClientProxiedBy: PH8P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::34) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b283e7-f2f4-4749-fca5-08de8b719d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4h9QsBZpCFI+cMJnnYXwDa1FEmBU2SgaH95OGw1+Va6oefXHeIJx2aYhLvhdLh77+sX1U9d46N43BA5pdIhY4We3gcrd2bzgAko8aq77qlFKDMXHMggHDqbekBv+WComhl3KVd7aHlT5Fzl/zJj77l+ua8TbvvQE/NppooXhvIaLgMwOKTchoInLktsVux+zFGvc9SLXkJHIWEMsWOWxsnh1w51Ejb/sH7Z+KIs8FcTzf2FfRhH9MPr/jT3RbzPRR2kEjduPvU3tzYfsOXAfNc2OTvQlEFkBLpFCvnPndphBgJj/Os3kEqtAJssUcr9Qo5QiScZPryG8G7rYyXYKMzhs1kHw5wcOrH8OJr+Espk04bIhKdqUGZ+WFuNIlzJeu1LHvF637wfAnnm1qxUqkUESJEriBcdt1TbNFpIDIhlUY564C7RPISDA3cbtuQyXLI0VHiJuXObH8RLY/ZZJxY/R4MExd1JEJxUx+hrMvqFC4kBG77z+8LdE4WmPBKV8jDk7aBT5c2IJQs0/lucxL9RQ6HLuqEPAQQOPNDp+cwS+nHg6Hvf7VB9wA41MCgX4zurJVU+/HqBQ/1nR+9AZNi4NT8Yn1uth4bwRdeevNNHK/zivaHEAkButqyVIr++zOcYmfIE0ndoBoTyIfcVh79h8DYDjEL1xAY8c7W+/XraDbTRa9kABsyT3zpEC5hTOe+L2Sc0sWOO9Y514djbMHRqD7TUUHJqeQp+uJF6VC178eh93BXcLe7wRc0ampuvXq0BtDH5aBNylLguNDIjc/gPgfNshpC9syM5OqM1JwJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZUT9y5YOttWQq+xTB8Sr/gAXWYrpC1thTOm5AglKLdRK2PUgJUBtgMr5vas?=
 =?us-ascii?Q?bMdH+lIDZcXjw5cW54twX6KITS/aHD5kzbssjskiAKDSjkS2r8bMsOEjrxdP?=
 =?us-ascii?Q?+XrBD8XiMM8/fqGSKu8oHEKSNiwO90IP7oikzum9KTgvIC/SJq6lS1cIV4xL?=
 =?us-ascii?Q?0zMV1Lirx6dEmprCONALxaH43ihNkOyO0FMEeAyljyO7e6KQd21FMZ9tlSdM?=
 =?us-ascii?Q?q7de9ziBVo9bquRwf8aKQyfyRhTSBlzQLk5Os+/0D0qmW87AX1GHtgam4pQZ?=
 =?us-ascii?Q?KusBwqdL/EBlaJdJd60nJSMPcZQa5Xn7Li60AnRiFpmVSNuxaqRkaYWZwJmN?=
 =?us-ascii?Q?Mw5bP6tYM8kXHP3O8ehRiDdA9RKrj68zHcFUNoX1f2jwIO2Ocd3ZAXZzK0I1?=
 =?us-ascii?Q?3aQqmXYSf4H21QhZV/y9C4iEKnwGDZkqhjBxAppylIY6CHUFxj/VdIWwOEoZ?=
 =?us-ascii?Q?I006LsdaVF61cgV1b+S4xH5EXO/+E2Xp1D6Ir8UjMWrE628RKTc4ccCseINM?=
 =?us-ascii?Q?jczyXjzPVchSWmMQesWzM7vnmK+edGDwP0oCKo/YGighfXU75cdbM/24Pq4N?=
 =?us-ascii?Q?sBK6EbAaYeJ6xRdJBzK0qMIaF0PICQe0QuWBT6d5xElzhynl3cT/yBqNc68o?=
 =?us-ascii?Q?uCXXn+jBky4KKIUyFN/ehwElMZSELh7MP/WwDI7MApqh8YgryAocpLZ/bC/3?=
 =?us-ascii?Q?epD9hP+y7BvPRPqpaJzHBIfvDLql2eovat82EYZurcW8ueomDGOSn0NE2UQq?=
 =?us-ascii?Q?Kb8Ua9PKpYoMGgGyjsIlj9Y4YzKtnMkZhCEogFvwMm7VVTJis1Z7R0ZcIOHZ?=
 =?us-ascii?Q?teA+IHwhJABe3XrrZzYL7r8fhadx93FvjOL18Zex6sT+BIqvHQP42okeIPeX?=
 =?us-ascii?Q?DREnDNVhZJjn647/lf+enEMti/ey5l+TE6GROzTp4VsDV0wJfpz05Gp8gJGY?=
 =?us-ascii?Q?zcUvp11eg0Xt25Rv5eW6w7B0PfD/+UIoQCmspmeGDUpYHDaLa8UEz/WVmPEh?=
 =?us-ascii?Q?OfX5B9cS+aOtHOWIEZQxm0XQXm9NuhnqbnB6o25O2y9ZAnTwXG2yrEknsD2j?=
 =?us-ascii?Q?WSpjHjO7dZkEtEPY6qZ/DcCykIZ1XNFI0MhrCb+d69Hp159P+gdsc6w+Oy/4?=
 =?us-ascii?Q?YUH56SACHBCkvG6rJClrS5u2PdY5BOT/h5gnL4j4/M5SoTOiYXfzlEw2qBK0?=
 =?us-ascii?Q?13nuWMNtw2WhWlQ9JHVKLRm7BWbC6R/NrQ9Y+4/9vALwYKQTB9OgSMeFsJVv?=
 =?us-ascii?Q?6L8K6kRuKRXCQ0qcSXC1ZT+AuEO423Tv8SjdB/bNK4rVGQC6j7hV1EmxJHCS?=
 =?us-ascii?Q?oxJQo+esQBFAtDkGApz9h9fA4ztE56Lm6Bnru50t3QPQuFkcwqYwlOw/s+EW?=
 =?us-ascii?Q?H3o+v3hy0gCqraCwNW+G5kngMXA5c2Fwsk9p7Jr4DAdZk3h03JLCUeGr1elG?=
 =?us-ascii?Q?DWHrCn+EP4jInC6wLELMEa5jyuQ4yhjDGI6/7L331NoTyi44Dkrsb+dI4AlZ?=
 =?us-ascii?Q?YsSjm+75YfKn39xJL5kFvAF8n1GPHlQGHhCE/8yz+A9eOQbq/bxhBYfW6HX7?=
 =?us-ascii?Q?sg1OZOHPsmwuG2Ot3A9fRk/rf4oYeSmHuhPZKK8LxoxADWvtfeyZGBrWBGMD?=
 =?us-ascii?Q?4M+gTkBz2cta+4uCAI0As5P27LcNf1ZyREiqc35CvAeZzqH5zzrSrR1SsI8j?=
 =?us-ascii?Q?fNkPKvXMkYREYhiOq6EY/R9dYUit+u72mzl3Qy4SMi4AwMzmoJO5Jd7kYexw?=
 =?us-ascii?Q?C29iLKEDbA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b283e7-f2f4-4749-fca5-08de8b719d3b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:55:22.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rrXgyzVH8SPNS/Y1s2QUUgzNAjfbPZWQeUFMJM2IThTDnBjjF11hI1PUYs/+NaSHtoyjW0SuoBs9SDKcAKb2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813

On Thu, Mar 26, 2026 at 06:39:39PM +0800, Joy Zou wrote:
> Make use of local struct device pointer to not dereference the
> platform_device pointer every time.


Input: snvs_pwrkey - use local device pointer to simple code

Use local struct device pointer to avoid reference the platform_device
pointer every time.

No functional change.

Frank

>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 41 ++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 836ab94c160615f4b0f645d9b9f85d54638c2624..bab3ab57fdac77256be75a080773ea99372ec9c7 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -112,6 +112,7 @@ static void imx_snvs_pwrkey_act(void *pdata)
>
>  static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct pwrkey_drv_data *pdata;
>  	struct input_dev *input;
>  	struct device_node *np;
> @@ -122,33 +123,33 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	u32 vid;
>
>  	/* Get SNVS register Page */
> -	np = pdev->dev.of_node;
> +	np = dev->of_node;
>  	if (!np)
> -		return dev_err_probe(&pdev->dev, -ENODEV, "Device tree node not found\n");
> +		return dev_err_probe(dev, -ENODEV, "Device tree node not found\n");
>
> -	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
>
>  	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
>  	if (IS_ERR(pdata->snvs))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
> +		return dev_err_probe(dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
>
>  	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
>  		pdata->keycode = KEY_POWER;
> -		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
> +		dev_warn(dev, "KEY_POWER without setting in dts\n");
>  	}
>
> -	clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
>  	if (IS_ERR(clk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +		return dev_err_probe(dev, PTR_ERR(clk),
>  				     "Failed to get snvs clock (%pe)\n", clk);
>
>  	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
>
>  	pdata->irq = platform_get_irq(pdev, 0);
>  	if (pdata->irq < 0)
> -		return dev_err_probe(&pdev->dev, -EINVAL, "Failed to get interrupt\n");
> +		return dev_err_probe(dev, -EINVAL, "Failed to get interrupt\n");
>
>  	error = of_property_read_u32(np, "power-off-time-sec", &val);
>  	if (!error) {
> @@ -162,7 +163,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  			bpt = (val / 5) - 1;
>  			break;
>  		default:
> -			return dev_err_probe(&pdev->dev, -EINVAL,
> +			return dev_err_probe(dev, -EINVAL,
>  					     "power-off-time-sec %d out of range\n", val);
>  		}
>
> @@ -182,7 +183,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>
>  	input = devm_input_allocate_device(&pdev->dev);
>  	if (!input) {
> -		dev_err(&pdev->dev, "failed to allocate the input device\n");
> +		dev_err(dev, "failed to allocate the input device\n");
>  		return -ENOMEM;
>  	}
>
> @@ -193,27 +194,27 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	input_set_capability(input, EV_KEY, pdata->keycode);
>
>  	/* input customer action to cancel release timer */
> -	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
> +	error = devm_add_action(dev, imx_snvs_pwrkey_act, pdata);
>  	if (error)
> -		return dev_err_probe(&pdev->dev, error, "failed to register remove action\n");
> +		return dev_err_probe(dev, error, "failed to register remove action\n");
>
>  	pdata->input = input;
>  	platform_set_drvdata(pdev, pdata);
>
> -	error = devm_request_irq(&pdev->dev, pdata->irq,
> -			       imx_snvs_pwrkey_interrupt,
> -			       0, pdev->name, pdev);
> +	error = devm_request_irq(dev, pdata->irq,
> +				 imx_snvs_pwrkey_interrupt,
> +				 0, pdev->name, pdev);
>  	if (error)
> -		return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
> +		return dev_err_probe(dev, error, "interrupt not available.\n");
>
>  	error = input_register_device(input);
>  	if (error < 0)
> -		return dev_err_probe(&pdev->dev, error, "failed to register input device\n");
> +		return dev_err_probe(dev, error, "failed to register input device\n");
>
> -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> -	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +	device_init_wakeup(dev, pdata->wakeup);
> +	error = dev_pm_set_wake_irq(dev, pdata->irq);
>  	if (error)
> -		dev_err(&pdev->dev, "irq wake enable failed.\n");
> +		dev_err(dev, "irq wake enable failed.\n");
>
>  	return 0;
>  }
>
> --
> 2.37.1
>
