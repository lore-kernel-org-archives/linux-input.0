Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209E21C16A;
	Mon, 15 Jun 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534435; cv=fail; b=E7q9/yKvV3BJw0M/SfdxVXopedrIiYUc7vcORA/0RlkFzJMqYdKHPxvdxbJqBwOqeIbRAR5MqDCMTv/IC8facfFNZfB9NDUU+wRk4D54sLAgYBoywLvqcuB0ECtnMfeQ/SSINfiAQ+qV04+rkyqedF2Ypg2cRfM3RpIGjWx0A0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534435; c=relaxed/simple;
	bh=6J7CQeY6g+/LdwEvo6w+gbbo0qtXmydQvIZ4OTM/kwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MRgypG2vbIFt3iB7GMhqAPM1c6yV5/kjt5hfgi5LYsv4noorQoVAY7S9QZ2Z2ewUrXiWoT8odb5Ei/zv67O/hcexXTEYiNJq+j9qhvw37JJDr/3VjhxdkWdEo1diSwJW3vBu/Is2FtKt5kYFWzCgOpwmiXm95fMpkAfOrjzBLb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EwxFxmEn; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EwxFxmEn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz7XlczrU4ESo84GZ+3FESEHlcIiQIDvqnKUXZO6eqGwmP6cA3h0JqHTc21W0lA00SnApIp6SCji4UU48YGqNWoFFiYGHQPP3u88QHMuxDbVT6QaLNEdrlwMB1l7aswfJKgSGS7ySfoFUsYHv0Aper0MMK91F9haqpjANpC42/GjCZ2YsotM4GmKpc2HoPtuuUhStewknxSvXvYA7qok0HXodZKsA3ze3SK1c3mimHzZHJvEzp7tXIYcMyN0Z/tIQAK1x3JJUu9scr6KSR3QkaAxCnF2WhZDKCGIRCk0YG//1UNIpTCh+5tUJ4FmjiXxIYxKbFg4KwCKkB4kBJL8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaasSfT4g0q/lB8mHmhTMM0J0ntG7D2HO7zt3J/kXW4=;
 b=IokJwRbsHLpPK5z48XempvEPV51Fm892obIUaw0ermZM4YISqiHXqNY0g1fnjp7anfjMKAfvXVg+1Vc5R//QitGp39/Ab55jwEQFpbCxLnQ7bPiSrrQE9KqWa4ZQSyoLkasT8fgkEpW2UPPr3c5nzKX8HQKDE5mhbaJEwsylkqxckU2O9+JRFdRiGt6cHTEKPYaXLouyy0ex3jX2eFaWfWE2O126TnKBFBh1gJrxBUeDm7Pbx6AmhdBbmyYv0fBtaBDpAhjSG7JQZAFsozIowC+H21saYQGoFL/J3d4/ielkf6JgHiJXdJBSeit24QgFaQr2qu9GeGs2d2BZzCdHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaasSfT4g0q/lB8mHmhTMM0J0ntG7D2HO7zt3J/kXW4=;
 b=EwxFxmEnNbxKcwjWf/Aa4fya52B4qAC7NiVb0wLv6vEQFkqyT8YdGj8HQdkTWNGBG8Scqm2unPfgyK+AZSZTW8s9Tk50jdSCESlGCPyh8QPjxZ1K+lEqW9ep60uu8IYaKlGVyqpNqIBmn/AccS9g8UNFSbg4/JDhbszwQ2dqGa+74QkQyghCpAPoGH2rtS+vue50uq3SNTfVnrnTnJSeRO1yl2FDt4Q1PnkVNqPvKKrRqHhv18jb/2gUfPwzXl8rZcJkqXM5VahlYc5bkWP8zgIvDsZIeLhYRgu0H1QSjOEI5A1djKMitUK6cDgVdKz437aSGNdoSLHwK9GzaCSFYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:40:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:40:28 +0000
Date: Mon, 15 Jun 2026 09:40:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: joy.zou@oss.nxp.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v3 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Message-ID: <ajAO0brqPhoMoCeX@SMW015318>
References: <20260615-b4-pwrkey-v3-0-9510b1173f6e@oss.nxp.com>
 <20260615-b4-pwrkey-v3-3-9510b1173f6e@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pwrkey-v3-3-9510b1173f6e@oss.nxp.com>
X-ClientProxiedBy: SA9PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:806:27::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: eed2dc43-1c3a-4745-b6dc-08decaec0acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	lP3nddpmUTRfTTZ5TXNok1JVz+9HO8KlpkM6UG5DNEi5p5IrSidwi9LQHCVLrjbQOALcBE2y/pP17GfpulYuku+9ezJsqxQYnYKACDH92kb8RIhi97f2x/adL1xVfav1CWrP6oqFmmBUCfACvuu83QgblB2hAe9s18k/tJEvc5vHMMG6YbQ2Qkj5DUTneYhjsAQxDdg5/bx3DJGxIcT0Sm1cFtrX7S4ClmDFDuoEDi+Rlvu8cL40rPKUeAPv780N9fjIPrKhpNfYnNKQpK/bmqBFSXEaj3EqJQh4g0w/V9jcbFDQBlnA9VD3kYqPkAt7pL4yAyEJZR3ACaw0N8TKt+dvrQi1X8j9Xzo1X+ojTqME3G3kogd+YPLAlhC8jAITATGHJf5QqdvWbzxHXvUemG9aAg++Q15k/Z6+1/3F/kjBqePhLHeQPWU1JJt5t1ShXsUCICn+xWKB8KBHNHE2qWrCIvLDeVUfrTpfkOjUMHu1MFTYkhY7yEufmsHCLs+93z0jl48rpNNGCeGjRUilf36nBJGteB6cnaQMMufgihBdxJcM5Yw/+KTz9YALLXe5b4lPB8kyMXub3QBzkF93Ta2t1DUEbKCxrkN7PG9b16CrGbZB+Ejc/aK7nmBjQxcgJyzukksPXEhYNG02R2MGhmh05C7p53zmlCKLYs1PK/y8Et3kfoPbPPhNPChzUc2c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gfkuvp81R+0pDf2+UPLAkYSMDy84zP30l51w/tyg9Il0hsPw2YPwsY8Gd7vQ?=
 =?us-ascii?Q?XohuI6FqkM1Qol2SSSEaPKn3Bjfq9QU285pkxVruQbQLFOSjJaisA0UCLF82?=
 =?us-ascii?Q?WK2yYgb8N+qbbrbord5y//Gp9352t7Hp9P9xW8zMRcIdLuiX7jXZeNImWYmm?=
 =?us-ascii?Q?SNeSIiw6vAymHW5kGeqkrGgKmuIteYFPulsqPtDlVeGqPdfn6DjX+IZybo2S?=
 =?us-ascii?Q?wYthwYHb/kjecIJIP86YN2tGBOGhp88/jl8BlCvtrDwpglIpvjXuLnr6+yto?=
 =?us-ascii?Q?vIkL8EQcxtA0xg9uUBp+7XuYxhD2u4wvjrzHaCSKhxfIAE4XmPa+R6peh8nI?=
 =?us-ascii?Q?RYhk5mgE8gPEIKWRKb1wuky62LPYD4CPpabGbtb1BHTxEQsxA405EMvVsQfr?=
 =?us-ascii?Q?i2GWDpklyEDIPKU1PFVfhqaHUKMvxel/6hbtoipUsaGnsdppBIkiQiimzH5V?=
 =?us-ascii?Q?ddXjYkWuptRPIxWSHblMqvsfEMWD1zcFclgM1sdng/W7H39mz4jYH2adgju5?=
 =?us-ascii?Q?HceOb6yHgqN5VYLdhbeV/3CYFuixrYInqScJVfIiyW2gmIknp1FcjfeLT6ex?=
 =?us-ascii?Q?NiI1ty9j1jVMazMYe0CBbQHePnbiU0Ws7FPHLuaz2agqp98cC+Wnau9/mqVz?=
 =?us-ascii?Q?UhiNLGYPBqCoyoJK49iLm5M0Ies8cM53RKbWR37ARkxrRtjfyoKUVac0I0t/?=
 =?us-ascii?Q?9cHqqls8kcd3clpYs6IM5UKF+BT8ZUjPr55+sXj3kHrIDsxsZbYPVi9JEbUx?=
 =?us-ascii?Q?ha0x/SaNmvASE8c+fCIvFBdzNtYLgfjf5kPB58L7LlXF4nIHTigmX37/hlpO?=
 =?us-ascii?Q?DGfjQSAnTsak5dV6hFGKomsccUCW4e4eh4Xrxqyp2ONMVdxXU23wYMX//Q1N?=
 =?us-ascii?Q?hpKQ/6yrZ82vdJkYvbzwNCd9oiiXzVSpTEf6reIwZ7+fnJ8sqHlmVWlO1CAB?=
 =?us-ascii?Q?7s09NmmIR3yecdlDpMnFj/n+2BoZ0Iy3yhBONB6EMUZ5UPAfRueR3IoVUSfu?=
 =?us-ascii?Q?2GaBLh8Xc0Gr7cndm2g57TWo7OWv7XLmQ/E6BHNdjVwHqA4k2yGbwmTbc/BW?=
 =?us-ascii?Q?Ass/OkMuujS38FPsdYFCGH14s7Nu5w2a5e+e0mInby6egrky9eKZrN7+deF2?=
 =?us-ascii?Q?gmRRSQGsPqxLpmprYM1fZcpaWQP3X/q7L1U+bk6krMszehzo3JwVGY0en3v8?=
 =?us-ascii?Q?d6lJ5z7qWN0g8E76qJ4++W2E7unm8xoM5lznREKj1lG67ZXaQzuwBJJelC+v?=
 =?us-ascii?Q?qsxOAFJBkIS1ilRfajg7g7FwTL5PowTwnomOw8wm1yNfFwSkeNrHIB2+/PXr?=
 =?us-ascii?Q?8SE1HVVwMav+X0GblGUNKKg60f4qosejGZPG+A7JnC5OtgjaIwl50RBx9cSS?=
 =?us-ascii?Q?TWHzFmXT7wnUhUUF/tehxIKzcPAsS0IoIhWMtEOAgRnOOXJnqjdpiXt1OPRZ?=
 =?us-ascii?Q?t5BR/1uPtq6oxlSWZRX9ODfaC7Gw8MDkIcQBgoXPmt71u51UuUI7MbBIqOL+?=
 =?us-ascii?Q?xdPin6KBN+gZlBi7kYCqJCGMMu/ta07A85RdbbSxRqd0RWvJeKB/eD5IJKfj?=
 =?us-ascii?Q?CZ7QoSKdZSgvWp6wB818tfax4Et/2JtYMRxe77/FYtPtDihHVrW7ayUME+CF?=
 =?us-ascii?Q?pnIbTRhS/gIPBtMLhEKT/vPSkIR1eBqoZczMyPvylKpvMCwSfaMcto11xDtR?=
 =?us-ascii?Q?wtlx8gqC4xGdOuVrUReEXHjSHwqo1AMb8J8B753srQ3b0y+RmD8P/Q1U5acL?=
 =?us-ascii?Q?nKPMVQeOfJztAHAwVgyDVIOh2XeNc1SBCzo2olLIbPFueqYQViDN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed2dc43-1c3a-4745-b6dc-08decaec0acf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:40:27.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBMOiRpONsBtIxLJkiMNAFQ13f4gH1DuYQI4GIqRrTq73tZQNU4UPtHqnqSz3ngScwHx36q8cbHL6JBoOV7WWujWetIFIXrBiSwmyOLJoUr453XlZ86MNvztxZKyImd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928

On Mon, Jun 15, 2026 at 03:52:16PM +0800, joy.zou@oss.nxp.com wrote:
>
> Use local struct device pointer to avoid reference the platform_device
> pointer every time.
>
> No functional change.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes for v2:
> 1. Use dev instead of &pdev->dev for devm_input_allocate_device(),
>    which was missed in patch v1 per AI review comments.
> 2. Modify commit message.
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 41 ++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index a291812e6d22..4a1d04898482 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -112,6 +112,7 @@ static void imx_snvs_pwrkey_act(void *pdata)
>
>  static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;
>         struct pwrkey_drv_data *pdata;
>         struct input_dev *input;
>         struct device_node *np;
> @@ -122,26 +123,26 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>         u32 vid;
>
>         /* Get SNVS register Page */
> -       np = pdev->dev.of_node;
> +       np = dev->of_node;
>         if (!np)
> -               return dev_err_probe(&pdev->dev, -ENODEV, "Device tree node not found\n");
> +               return dev_err_probe(dev, -ENODEV, "Device tree node not found\n");
>
> -       pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +       pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>         if (!pdata)
>                 return -ENOMEM;
>
>         pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
>         if (IS_ERR(pdata->snvs))
> -               return dev_err_probe(&pdev->dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
> +               return dev_err_probe(dev, PTR_ERR(pdata->snvs), "Can't get snvs syscon\n");
>
>         if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
>                 pdata->keycode = KEY_POWER;
> -               dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
> +               dev_warn(dev, "KEY_POWER without setting in dts\n");
>         }
>
> -       clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
> +       clk = devm_clk_get_optional_enabled(dev, NULL);
>         if (IS_ERR(clk))
> -               return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +               return dev_err_probe(dev, PTR_ERR(clk),
>                                      "Failed to get snvs clock (%pe)\n", clk);
>
>         pdata->wakeup = of_property_read_bool(np, "wakeup-source");
> @@ -162,7 +163,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>                         bpt = (val / 5) - 1;
>                         break;
>                 default:
> -                       return dev_err_probe(&pdev->dev, -EINVAL,
> +                       return dev_err_probe(dev, -EINVAL,
>                                              "power-off-time-sec %d out of range\n", val);
>                 }
>
> @@ -180,9 +181,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>
>         timer_setup(&pdata->check_timer, imx_imx_snvs_check_for_events, 0);
>
> -       input = devm_input_allocate_device(&pdev->dev);
> +       input = devm_input_allocate_device(dev);
>         if (!input) {
> -               dev_err(&pdev->dev, "failed to allocate the input device\n");
> +               dev_err(dev, "failed to allocate the input device\n");
>                 return -ENOMEM;
>         }
>
> @@ -193,27 +194,27 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>         input_set_capability(input, EV_KEY, pdata->keycode);
>
>         /* input customer action to cancel release timer */
> -       error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
> +       error = devm_add_action(dev, imx_snvs_pwrkey_act, pdata);
>         if (error)
> -               return dev_err_probe(&pdev->dev, error, "failed to register remove action\n");
> +               return dev_err_probe(dev, error, "failed to register remove action\n");
>
>         pdata->input = input;
>         platform_set_drvdata(pdev, pdata);
>
> -       error = devm_request_irq(&pdev->dev, pdata->irq,
> -                              imx_snvs_pwrkey_interrupt,
> -                              0, pdev->name, pdev);
> +       error = devm_request_irq(dev, pdata->irq,
> +                                imx_snvs_pwrkey_interrupt,
> +                                0, pdev->name, pdev);
>         if (error)
> -               return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
> +               return dev_err_probe(dev, error, "interrupt not available.\n");
>
>         error = input_register_device(input);
>         if (error < 0)
> -               return dev_err_probe(&pdev->dev, error, "failed to register input device\n");
> +               return dev_err_probe(dev, error, "failed to register input device\n");
>
> -       device_init_wakeup(&pdev->dev, pdata->wakeup);
> -       error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +       device_init_wakeup(dev, pdata->wakeup);
> +       error = dev_pm_set_wake_irq(dev, pdata->irq);
>         if (error)
> -               dev_err(&pdev->dev, "irq wake enable failed.\n");
> +               dev_err(dev, "irq wake enable failed.\n");
>
>         return 0;
>  }
>
> --
> 2.34.1
>
>
