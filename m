Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E43914E2;
	Thu, 26 Mar 2026 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554727; cv=fail; b=K+1X9tVM48yKkPq9NmAfaBG8a/HltmzBtuhaJIgFuqhA0vDBkfMY8ytPR9f/8+MkHFAGuLsv6a7EShqmp1mZAEqZ/KjrtfrfRHbEEajgMSOJ+qxWq2/Chhn9jCi1D/eNF9fFqTROC1EokAsV9Y3dByyRTAFmSklmojgLY7FHP6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554727; c=relaxed/simple;
	bh=sE9qC+toahl90dn3dXDZg2msTBloijQwCkQLEfEs4iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dP51CvegjZxXZCSzXCUGNRozEdkd4+PP34V3vskedK/4geVkSf1KSZiKj2L8S5CG14fYc3WmkBL3AY8SnYUsiHRhD0V5nKkVoNrZhQ2t+Cvs2ocExBznVHH0Js5yjDC8/TBcK+xrE4V6mplNlgNED/vZBXUr/SR4/Ni+3vcHPbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oRlmceIN; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oRlmceIN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBVav6EQEGJZi1OO90PsPegB/3A8eHs0TSzlJKm1oquJZMqecsgsTRdy8AB7t3aJqCjlvKHrwUJNvebnIVn6CfGyEJQyWDiB8xxDWeLP9n7TSi4P+1ly5v2wAR/+x252V7wIX4WG+ma+ohH5qyrYOEySxAvlXGFyLgqqVfpfmOZJdzh9dBx8KbbFKZWXBuWfU7U7D+/IWmXd6ZZKjVNgLl4g+n6yxeQslTdbCTYFtQ9YEtsV2OiputT5b+E8/3Pkvt61yeLL57BM+N5hMg269lxGcSmVHCpqcIQSHQpHAqId28yimZkERJWEQQYC8Ow+tGQx5EAvFQyYgrRYXaBYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnNK73XK13Vbmishb8a9VSaL+bv4ZodFyxNi8t/kid4=;
 b=y0EtTUmAbpOtD67sg/l4Jm63IOLyrjbclCFLlNmbepfrL4KxUSBB/S1UfJcR/Np1u9S3X/NHRSnETrKGgi3PlS90A4tUEO7AFIolfRcW8CaISp5HU+1tTVBZzZbij6/u7gSf0F+G0x1OPzWiUFYAoOJr+RT56MNjBKvv/ASkTbcVfF0bv7C+KZIs1dWAn2LBT/W5xNwXXp2nl7YFeEXtUtmjRzPS9KCc9BTA4YlHiwZMWz/1BhJnyPYjzH8ONfgGqYZN5GOVc16Co0Bbit5OALyIYwAXdaqZXJIRprdao2QcC7YOOXG3wD8fXeRDmscs+B0ZcDTU57XdCG/XhlMigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnNK73XK13Vbmishb8a9VSaL+bv4ZodFyxNi8t/kid4=;
 b=oRlmceIND4HKPnCILW7dE0bFPdHSeqD1/7+udVZexn3Ff66bAfAU4yyoQvX2CQwJITJgRauFHdHcCzrJ9MyXgYio9930bq3AfzgGg1w4d0bl2ECnspOg879fkGYBqkIUife6CKhhGQtw5vL+XMbgn1YywqCteRvTu/A+10UNDRf8hPdn/ZXXIoOHi+cvGlPRxXIwIk0s5E2QD4geF3IHx7DVADCR7hP6DyrhjNIB2R6cnhFK6yTjHFRt0Gw2pJhIVXN7BACeJgikuifKBQfdicyMl8lf+9TJbd8wR4RgneYcTGt1lflfihWgD8kaBHxub+gsP0kJKDIencnzpBHvcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11368.eurprd04.prod.outlook.com (2603:10a6:e10:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 19:52:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 19:52:02 +0000
Date: Thu, 26 Mar 2026 15:51:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: snvs_pwrkey - make use of dev_err_probe()
Message-ID: <acWOXW1cwd1BC6kS@lizhi-Precision-Tower-5810>
References: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
 <20260326-pwrkey-cleanup-v1-1-d85d7c0bf275@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-pwrkey-cleanup-v1-1-d85d7c0bf275@nxp.com>
X-ClientProxiedBy: SA9PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:21::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11368:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd1ccfa-8266-485b-d03a-08de8b71267b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|52116014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	UqRq2v/G0s2zaROnb5x0JJiGZGWRaZMUhToTYX7FUbEIjVl80g7z6BEJ19KQT9WV8ZxatDEsynAlF4L/ZdWrugFXWs9U535ofjueVmBboOGlRPij6IsdI65lnpgp5Xt5PkBjA1flNlh5/3oxvFmP3Sd0XZYb1+HY2O1NH2aYmWYul2jXJXTAnsSRTv2CcX0sTx0CUItLuFwLiiTCegQzAJRRSABQb+M/BtrZeiv6oJQ6L2k9bDX6b2ABuuvK04JBP33RCJkMr5hqWEE2rpdTOA3DBYqpQAN9jFahLmscNynoguabSPmKRwL0E+snjAtwzrrYTl8YsZslafEdOiHklKFCg5ZUfHc6iBnD3lawa8qGLECYYEYKnayn1u8jU813LbqiCx+I0AJ0ypcDOCIqOIqRkeHvijMvQwsdjDDRkCFaT0g7X/PioFRGjbL01FBzjFs8D5MMWki7ukyGiXL2L6utieL/7CxxsBjfgmBfV3R2xlPGDZZg18ViR3VOJPCfjPu2jaQwCY8xLxTuC86hhum6yEPKdZiNK4YTZLDv3OlSJZvcscBpjcIovqnoE8yAll58adLAOgDFCY4PihDyW0U65jblmGoH/+nK/45VO7YLINsFHvg9fs0bWeOPpcU2I1izFYfj9CvuUZVrG51XMvKOX0zmFGDLh6Vr0FO7EdHLsmO42hVWUBxAt4HVZc24MzNSn2DxUEXFh7m26D6W5ex9stHl3g+s4GV/lSzts+OLXEcyWeSCJBqpOVPauG5CejVFE8Vg9zVs7saMtEDvhvRUiSXhcxddcoqAbSxStfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(52116014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W1z03kTsC4W4T/uxO3+Rcl9bDKOwPRzuY4hBPxOsl3HRnitfW9m7m0bAbqMt?=
 =?us-ascii?Q?V411XvURIzRPEAZdEWyDg7j5vLZgr4LqBUkuNtvPoMDKqxTCK23uWH1jK7xP?=
 =?us-ascii?Q?VZBOlzsdrM3dQTC1F+VAHvETlxSDgl4nmU25Wg+QYQKp7VjQhg2BxymeKzjM?=
 =?us-ascii?Q?1wLROLlS+ZozRe0tgzlyTzVHdyzTlFB1YsYUH2iauEGFtzjzHPtnGB5nxVxP?=
 =?us-ascii?Q?3h8Pic/rj+ryojAULtO4/KC2U1QUW2//dgCwoaBk2oUR1HTgLOb5qL0rvwjf?=
 =?us-ascii?Q?YKi9GBjB0O6KxDyRbG+00EBBXRCaViUTCUttzE5qAJONanM9cfXRuj3F0BMb?=
 =?us-ascii?Q?Q+mSDw6R5QyoJG5KdDgPWeDeZDIp8kP5f4uuI+d+Hzs3uPGYLpsUtyd3d3QR?=
 =?us-ascii?Q?/Y8bEmygxY3eCTfLk/tVgou1uFXckJ8M66UHZhH2HGqU4yNulqt0bP/IwkHW?=
 =?us-ascii?Q?GnEuTQ6TheFzxbnVLOToI7G7zLlstM32b9sxd1+JSOGjx0XUDDABfpriyXmT?=
 =?us-ascii?Q?1bI4jQfmEme9WzEmztTm83ODileewY8JTVljKov11E0DABxoXT905F7UBZl2?=
 =?us-ascii?Q?66xXp2W7TDBrnCL0vyQWLdJpdTBO+IjjoyugXJl6QDvmNv2vv7Oiwq2pMe0G?=
 =?us-ascii?Q?L/zpjVMLJDevjiGwxjCnjtM88R9vVlwuWo8eI1Z8n34EZOx6HsQNpleDu+Zc?=
 =?us-ascii?Q?qz77fII4ijn19bqwJ1IcY8DZcTcvr4udFNUjcZVfqC5xAHUtF/6hWC3sy6rs?=
 =?us-ascii?Q?O3eWIlF1hRWnaufMyC0uigfHogi7zGevUhJ+m6K3xcUnDlt/1ufdX5PuTC89?=
 =?us-ascii?Q?Y+3aOyvuR7f6+an4oX3N9fOlU5oaVBC6Wqznpq4oyPjq1sR1nGle9qQWw5CY?=
 =?us-ascii?Q?k2txU8IoL2WC44WU5QXhy0gOHMJKvpjgtUYVKOPNkdtViipqFa5rqzaO3rfE?=
 =?us-ascii?Q?xlX0ghpRTeBiu0GiyilZT29kznWNXMB3a2AQX4cd7BsXj8qb9YKG/Zn72djv?=
 =?us-ascii?Q?sPq3s8/tWS19xX2CFqdzO68NXvMwmbz2Mxw9ReGqBPXACzWlHD7fBxrxz6WE?=
 =?us-ascii?Q?v7SfsIaYyxkbMwpg9iEEeEusYb0UqD07ElV4fHuWe+FJuxfGZllv1h1ZcvEx?=
 =?us-ascii?Q?1vy+VfQaVFQWHUDiCCzsXf+pN5zKtVk5OO773tTHDSAVh17X72A9ikm8GZBV?=
 =?us-ascii?Q?j5NyOPgO+tkkrQFIIMrf8AHEwlwKm0HTEpRkcgOYpOwqEWP1/9MbzQJpBq3S?=
 =?us-ascii?Q?pktuzre1hMSd3ekCHR579EBOMa31uBPT7VETOkRaskqmYxypIKZFnUC/lTvf?=
 =?us-ascii?Q?qbJi+t2tIHyBKQbms2DSbshK1dXdI52GC09m6FwXQ1gPyqY+njG0fzc1RKMI?=
 =?us-ascii?Q?vU7DaP7/2i6WWovQac4fyaaTWlxZvR6yHi2Z7QuuY5amVc7F1EOFvuIjYdg4?=
 =?us-ascii?Q?un9Ke6xhDG9Ls0HIHxw4FHnexpLrXYZU4JHDj6vUc+ZDshdrRsatPU2Mz0ig?=
 =?us-ascii?Q?fllt4lJxiSTUDlbUv3bdmW0se6A3HObUqov+xdLQEFx9E4NyI2caIJbMSyX6?=
 =?us-ascii?Q?OdAgynIxCE1urwu2pnLQUxEIAd32On0UxoeDKDXkOcCbdH52POaceZ7gBxDW?=
 =?us-ascii?Q?K4KhrIb95n11Zzy4zGevofVje/10TLjakbEeZN8HMdxY/NRg1Z6B7+/koSyQ?=
 =?us-ascii?Q?IqORvfh7EFNFnNJyqI6IbMyJcsIIQrNMarwmT3pJptQtKyeg0l6hm8lvq8wj?=
 =?us-ascii?Q?wELsUD+FGA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd1ccfa-8266-485b-d03a-08de8b71267b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:52:02.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jUpjlATYoli3u0oVCiuvC9dbgYgVizwvviimwg1OnrcDxdmj/rfLlTVl5LVPp3/yz2wyyjkn79tjUjfmL1yTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11368

On Thu, Mar 26, 2026 at 06:39:38PM +0800, Joy Zou wrote:
> Add dev_err_probe() at return path of probe() to support users to
> identify issues easier.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/input/keyboard/snvs_pwrkey.c | 40 ++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 954055aaf6e29527f22f8129fd47ca17722e2bc9..836ab94c160615f4b0f645d9b9f85d54638c2624 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -124,17 +124,15 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	/* Get SNVS register Page */
>  	np = pdev->dev.of_node;
>  	if (!np)
> -		return -ENODEV;
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Device tree node not found\n");
>
>  	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
>
>  	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
> -	if (IS_ERR(pdata->snvs)) {
> -		dev_err(&pdev->dev, "Can't get snvs syscon\n");
> -		return PTR_ERR(pdata->snvs);
> -	}
> +	if (IS_ERR(pdata->snvs))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
>
>  	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
>  		pdata->keycode = KEY_POWER;
> @@ -142,16 +140,15 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	}
>
>  	clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "Failed to get snvs clock (%pe)\n", clk);
> -		return PTR_ERR(clk);
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +				     "Failed to get snvs clock (%pe)\n", clk);
>
>  	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
>
>  	pdata->irq = platform_get_irq(pdev, 0);
>  	if (pdata->irq < 0)
> -		return -EINVAL;
> +		return dev_err_probe(&pdev->dev, -EINVAL, "Failed to get interrupt\n");
>
>  	error = of_property_read_u32(np, "power-off-time-sec", &val);
>  	if (!error) {
> @@ -165,9 +162,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  			bpt = (val / 5) - 1;
>  			break;
>  		default:
> -			dev_err(&pdev->dev,
> -				"power-off-time-sec %d out of range\n", val);
> -			return -EINVAL;
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +					     "power-off-time-sec %d out of range\n", val);
>  		}
>
>  		regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_BPT_MASK,
> @@ -198,10 +194,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>
>  	/* input customer action to cancel release timer */
>  	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
> -	if (error) {
> -		dev_err(&pdev->dev, "failed to register remove action\n");
> -		return error;
> -	}
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error, "failed to register remove action\n");
>
>  	pdata->input = input;
>  	platform_set_drvdata(pdev, pdata);
> @@ -209,16 +203,12 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	error = devm_request_irq(&pdev->dev, pdata->irq,
>  			       imx_snvs_pwrkey_interrupt,
>  			       0, pdev->name, pdev);
> -	if (error) {
> -		dev_err(&pdev->dev, "interrupt not available.\n");
> -		return error;
> -	}
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
>
>  	error = input_register_device(input);
> -	if (error < 0) {
> -		dev_err(&pdev->dev, "failed to register input device\n");
> -		return error;
> -	}
> +	if (error < 0)
> +		return dev_err_probe(&pdev->dev, error, "failed to register input device\n");
>
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);
>  	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
>
> --
> 2.37.1
>
