Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003C36C0AB
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210006; cv=fail; b=RsHv87uPv69ylY3VlL/HW9+JujOkbbwVJ6dlzhfltygfuoyXbYct0zxzc/K+dR6HY9EnNcWy0rL0IBqOCMTM4//8mvYP9KoPfzaAZYpqYT8UVkQUmqXmCKJ3vXSJWwK0L0JuSTNnAIL2RcGAIGqSGROAswqXaEf07qcBFZoE+uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210006; c=relaxed/simple;
	bh=z26rlDO2hBeUeOr7rl8yCAlK9QqmCJSg4MT4np8Sinw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TYVNl6B4Wxvqzf+Z2SxQUGw+cLGX/y/c/44+bx2uX1acN5Esf3TSDT/Q9+lnxLDoZ0lEslXNUVQvkunvgZsBE2PPPH8X1Hc+aawJAi/MvsGyC1/JP1YhcU+ma9MS1nVclN/JHaMIXiVZ9xBneeoPfPt5TBrU6PNFgSv6pUVwnXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wAzIHqyP reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wAzIHqyP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgH1COKRlboGkkIAcI/7up+NctVh+Wfsl+lZW2/vglHZQXzwEperz3XdmW2vWBUFUYe4VSZdMhI7ErGI+f0bEQ+YPrErYMJ6llUroRzUJHqcFc2rq8n3a86WsIdsfOnUMqSZdwydJwwu4zcsyRtp07rNnaB8cyNwjipcDv47MwMboMYl4fGJe9SF+uLKYLC3N56j60mLrsZp6nSap1WSrJN+dFdB4EoygLxx1HnBhpLUj50jtYz3iDjmuZSdYFP52EPkeg4p4QXyp8M1mchcNn0/0A+Lx1GBd2A8QS+HwK2Dj0tXFXgtOf0wQwzpZUnXKzce7/jpkIriR4UNhuPfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7mjHAxc4G5i8sMEunNBS0QnaiGE/BMvspeqzkw7qi0=;
 b=jLyk4dBqhvp9+8d06e+Z5+zQxtQ3Ln9YDCkaV1b+8ovFbiSE5N5I53BkskxJMnBaXCd/YrnR/AQ5NmNeqVSO76xMTSVgU7XrlhAuUfjBuSo8VBK2x63fxK/tn3Sr/riYv/j4+tEYb+TjvjYGELL8jGo6PS24W6rQZYhr+z3foXDTNt4JMLtlep+tcYFV1HWXfRulC+eV8HevCr/lejdgqmb7Lp4mmT6YiNvQ7UsO/pKQyh/9j1QoxSWzqYo3rYpwG/7h3OBbbiD0Pwe0zHEUuwaKWHH4ih2KABkw7nyRsixMgxQLW1k69S+M+luH95mBhZlLCYWFPR2uDCyAFDfmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7mjHAxc4G5i8sMEunNBS0QnaiGE/BMvspeqzkw7qi0=;
 b=wAzIHqyPZ1/FOK1OBQWFHtFtKlk1j3R+vOMLvr/27DxXMMcu3PWLUZ15fs7EHsK5UOLSmc0HUUVfp8o4FzQ9ORbTPMNFow/2x7xIjVqNZKExizt9rNL5gPqzU9vHJ3UzSyzDw95pf9dMrcaQ570WPsYsQE3PFmWsfBV1OJIIPCQ6B+oZPh0H3hAjdZ4xtYyeMTFmsDie0C5WCcTV87CbIlo7LI0eHq91O+vtwGUrWgg/mjxp3LicMfuzEf7Lv1BSio+Mtt4tAy2DNHkn+LrggMN8b8D3TtAfF5zITYw+ThsY/JFtPG5xAyZSkgMcJawOtVkJFFvkqsCDUtZyTmgwrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by VI0PR04MB11868.eurprd04.prod.outlook.com (2603:10a6:800:31e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 10:20:02 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 10:20:01 +0000
Date: Tue, 23 Jun 2026 18:23:19 +0800
From: Joy Zou <joy.zou@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, imx@lists.linux.dev,
	dmitry.torokhov@gmail.com, Frank.Li@kernel.org
Subject: Re: [PATCH v4 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Message-ID: <ajpel+fJwMij/Olf@shlinux89>
References: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
 <20260618-b4-pwrkey-v4-3-4bfda105bdf3@oss.nxp.com>
 <20260618073947.0E25C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618073947.0E25C1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|VI0PR04MB11868:EE_
X-MS-Office365-Filtering-Correlation-Id: eba62a97-e892-4de9-0bf8-08ded110fc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|19092799006|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2OcmrDmDxUxx6nqUvBPlVro1UGB44as48oW5Wqw8SilLwhGm71R6GxgEjxSMw3Ag0ksjWWr0EomPYrPYm9XiAO2Q5G0p5oqKOKOGDAoIrIeP2b3ncKD/TqB7XgfnXqxBme3COyw8HxkvwTFM2qLFRBULVb2qQrDnR9440xTatVdUOSix3qipK302UedPHiGGmgJ2/6g6f5bkI5rntHGQ3NUKYZw14W+5cTb7M9k8htiygrS4oSd4zyMRAIAUltzK3hHPF6WS6o703MM0DJzAzJkNeYALlIh3tcelhuSvy8ao/JRXXX6gZAzq81/IPJs7rYiAgXUZy0fT3k5WUUHYMNPlVaYiXIT1cCZh/ixXPUxHx4zaDzjDiOHrFhO59oR7rw5u0yp8/pZ0Sy0BGyxYHRb2ci576mTsB16/BeKRHFPRJTd49qck6d7vjt+0hZ0WqqpGFNonc44uyhr/SKVO7qj1COP4W9nzS+xyp3rW3SU0iqM3nfHIerO9mTgKDAYQkkoZayF0DVbm+ZHrpT4ULJYSz97LB6AjEz9lUDdpZ4d9LZZMwbpRM++zmL719mSCa6hS8/Xl5LdSuB2ASzOgC9pTTxiiULNaQ8aXiSw+ylI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Jq5tJwzC9WxRkkjQx80tI4fc7YQMj/Yv/blhQprjbj+JuaZv8A4uDU1xxP?=
 =?iso-8859-1?Q?ZyvpMZC8H5riJRBPRgrH7BlXpm1UtpR1zh/pGgQ7TpXBzp2q57pGow7ZFM?=
 =?iso-8859-1?Q?55bof8J8cfHChtzrCiNuT2ReWQCeREoIX5JRfDlbvfh8jQg7kA5p2t35Dh?=
 =?iso-8859-1?Q?GonhHTnwpysNZLEYphSIe6Rsqe1jVS5ENPnZbO1Dy+uU6noV+o3itEufSS?=
 =?iso-8859-1?Q?UouzjAk+mf1tgv41z6IJd11DvBEyQSYWrybdlvhyzBDy5TvQDcxZ3b7nzV?=
 =?iso-8859-1?Q?5hCW7wJxGdNVteGSqVWV5cUlEl5R2cCo1k6GgGHuYIlTJCkbdzwXQv9IZw?=
 =?iso-8859-1?Q?lues70iZNdgZ1bdBhOnnbB7J2nyEV451DOgTpxUA+aGg8Z0q/O8ROWIrvf?=
 =?iso-8859-1?Q?uv4sPEeQkD4whZ8AcBmIAXtexvvNdfuVKxg6ttn4ZiSs6NdAi66u5mNWeb?=
 =?iso-8859-1?Q?Zz1GZUhggrgoFq9tAfCgpqBOZiUWQ24gOBAEqN0zn48Op0Y8T9kZxfogzu?=
 =?iso-8859-1?Q?JuWl0FkLeW0xInLqj++RikUnjtnAFOCr6hDUQagk6Sr/isIkwyD6xUWdz+?=
 =?iso-8859-1?Q?ayiF3i0ztrNucztapQYDMzsUNw4Qcif+Oc2HQSU1iIQYbh2XMjJByqWm0W?=
 =?iso-8859-1?Q?Putk8ytRDj9Z8Kp9G56YW9BJjb/H6TXAAQz7IdA7mTxsqlNF8BTlr9IrS2?=
 =?iso-8859-1?Q?7ZHwMvi4b8bf6ZTpYvjOVOLIxX6TFOIlkgVgogT3HqxCMG9hQMLlIk3JMD?=
 =?iso-8859-1?Q?uqWj8n6D85Pl/Wv0ACPdZq3hB++WkJxAaZ4IdTgPSr9EsIBgb1k4De0ZRD?=
 =?iso-8859-1?Q?mzZxT1RzFcsqnJd8SyeEOeLSsih39xqflBbdMwjLDzoFxwjiqmsy8rBQd6?=
 =?iso-8859-1?Q?/e9qLwU1u6yfB7exiZ9YOG0qZ2/nXZTNIhpS6jutrrUXQOZDjclohWxcdt?=
 =?iso-8859-1?Q?Xumo9b7OL1uLPdcTuqrxr3Sufxb8JXcwVptn35Jnl8wVaZkKqTNujCI6i3?=
 =?iso-8859-1?Q?szsit4a17K51/1g2y90i50VSNU8MzYNSyYnZYh48FvFHBk3MqX6Zfd/JRM?=
 =?iso-8859-1?Q?5oFWpQ01crZDTtI/ZKW5irr6r4hSaorDfmMGBrilqPZwwGLlnB8BOsaZ6y?=
 =?iso-8859-1?Q?z0ljxGVbLQdYPZd0PXyw3PpT15YlXyaRrYARG5horXzDATqv16Z3CJbZDR?=
 =?iso-8859-1?Q?uow9tMa5PZpqwUTH2mINkqmmnZN29Oncrem3XMDWTz9f/zJ2lRGQPmXAIO?=
 =?iso-8859-1?Q?QUOi6sOYHFc2JaZ2+vcKxRXvDv0tu6XI4cb7blDXscn6/PMNflts7TDRQq?=
 =?iso-8859-1?Q?JiMDasWEfzlnlykkgtoqt1OA1hj53wv502EPogjZSn9mXMnz5OAqrrVi+I?=
 =?iso-8859-1?Q?1Ok7vvNece0UlV9U/auXRTrdOk9b996eeCtj46m8vhe7xKu4YCWm0wPDJK?=
 =?iso-8859-1?Q?RA6FnVgS4dT4VKKN6eX0n3HNO8Ms6jiC4YWybFwZ18whdAFE1cPzqoDSmO?=
 =?iso-8859-1?Q?6kViB0OLq3zvFw/GdAB+DVyw/fNYOYCUO/MvNO0AuwbIcFEpzs9TmDjXsp?=
 =?iso-8859-1?Q?UdB0D+hmePZg6rJLFZ3xeErFRfPQQ0R8Jl45zpu4WfC+Uc+6cZvCwScFq2?=
 =?iso-8859-1?Q?WPf3b8+ZqINJ3rbv2gEeZRkhGOtFldDLtK2yPj1niqKmniZWpq6cBX+x3g?=
 =?iso-8859-1?Q?YUYuCDdD3mmqpr/IDmWffuoiWr8wKzcrAs+0abyKrmEg/83JS5ny7y7pU/?=
 =?iso-8859-1?Q?EncFuo04hGUYCoKTr7Q2H4CYWWX7ZFVNyTykL+1fIBMjLuL2MYKvczpefI?=
 =?iso-8859-1?Q?rf9NdFd61mMd8YvNQVXZdLqm5c4DA6WaAySWkuBuqglF1lEdMZ9n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba62a97-e892-4de9-0bf8-08ded110fc69
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:20:01.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uy+77IfVlM8+zjumAbJHthAaQzc2E/xSuWtWDsvApaRlpJlGfFUju63Rw2rc2iAbVT43pZhy24GgFKE4TbneRgnBz8Plf818aNmkmPoIdsuGkxzVaIaITHR0boqPyFOJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11868

On Thu, Jun 18, 2026 at 07:39:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing cleanup for device wakeup and wake IRQ on driver unbind causes memory leaks and re-bind warnings.
> --
> 
This is a pre-existing issue that won't be fixed in this patchset.
Will address it in a separate fix.
BR
Joy Zou
> commit aed6a36738ed05979b6e5650a6efcf08cfb05a1d
> Author: Joy Zou <joy.zou@nxp.com>
> 
> Input: snvs_pwrkey - use local device pointer to simple code
> 
> This patch introduces a local device pointer in imx_snvs_pwrkey_probe()
> to simplify the code. It replaces repeated references to the platform device
> pointer with the new local variable.
> 
> > diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> > --- a/drivers/input/keyboard/snvs_pwrkey.c
> > +++ b/drivers/input/keyboard/snvs_pwrkey.c
> 
> [ ... ]
> 
> > @@ -191,27 +192,27 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
> 
> [ ... ]
> 
> > -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> > -	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> > +	device_init_wakeup(dev, pdata->wakeup);
> > +	error = dev_pm_set_wake_irq(dev, pdata->irq);
> 
> [Severity: High]
> This is a pre-existing issue, but since there is no remove callback in this
> driver, does this leak the wake IRQ allocation when the driver is unbound?
> 
> When the driver is unbound via sysfs, the wake_irq structure allocated by
> dev_pm_set_wake_irq() seems to remain attached to dev->power.wakeirq.
> 
> If the driver is subsequently rebound, will dev_pm_set_wake_irq() fail with
> -EEXIST and trigger a kernel warning about the wake irq already being
> initialized?
> 
> Furthermore, because device_del() does not automatically free
> dev->power.wakeirq, could this memory permanently leak when the platform
> device is destroyed?
> 
> Would it be better to use devm_pm_set_wake_irq() here to ensure proper
> cleanup?
> 
> >  	if (error)
> > -		dev_err(&pdev->dev, "irq wake enable failed.\n");
> > +		dev_err(dev, "irq wake enable failed.\n");
> >  
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com?part=3
