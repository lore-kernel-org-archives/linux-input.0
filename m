Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761B3FADE7;
	Mon, 15 Jun 2026 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534607; cv=fail; b=VVVrga4KD4q0FGh+MNFHV5rHiuBR8oCCdMRxkRR1/co4onKPzGGCuoOmETj+YE9trSAdC7UoY3RFmifeRJgYPtxAbxURFkcckl++hugg12XdTRSsYFQ3l0UyeFov1da8DlBoPH/11u83Ws0Dvg3gKXRPrC6PhGUd95sSriPbbYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534607; c=relaxed/simple;
	bh=zuRWipOq5T2Nalnb7+G5Se8ZxY4YiM7Rpmtomd02UoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aHAGdt+VxVIhxH2B/gWYiwa5tHitaNdU/Wwy0+tf9KZFVc+zuxdNqgYligBw0fkaD+sqk3h8yXA1hggx9gYqiD0KpTFQGfwprbOUGN0pOGA4/9yfAsBw0lT3z8OKV9pB2iOShJlS1eASGCU97e27mp5nELWjymYobOXWVX1G3P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HRQRy2ua; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HRQRy2ua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJjXC2Viu+z7mugbIPkRjVpoScK5z04VTJbf+K0+i2TKKLpMlT3COtA7azycAGeQtWcrIrrBxt4gKMJ8v0M+LVO+5Sc7Ex6QgIpR0F8rUrziEcwmoI/DUc7yhG2FhalDHdarKUeAk+bqoQe2NLkHLqt5JZoKREaMVaCfEe19zeyKwhaccWiosJOEwQ2niOM60g8oNtV8HI8BgI08ZRWkYAjX4cOatbcD69gRoiCrVFk9v1fF+aHmJm4Dg7hHgZ3zom8wWX/uErKvTKuqn0oSJ88zAsadCuBhx1gtQdx9CQMsKg8w+NBA5o0S3m5vhWSjQiuUM1LRNIxbblnWXlz0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFcmlkpC5QCGyedFkKfsL+4N0r6QJZegpkKFat0URJc=;
 b=LRgusHWLcd1uGQgYRKDQuMQy7s+Tk+D0Hf7sCgnE3qhxADgul8PUw+qq+IWrSbgIaBWWdb4KpTB1c+O85C3MT3NL0EZ3HDKyV2K7Ps1FE04MzGnagFoRg/InL9S3Fm9F+uAQSEE3SKbrhmL8uRlDB2yWMNyP3NwLq6iC2asFRdD1obS+UFv+CzetxvBogsqhbzNc4Rk73L74fHt5hfL8JbkqIHOO7BfSHGjrpmUso83XQJQL9vwajGXSKnlVkHmzLwghcHD2+0V/r3AqtEmMkK/+D4coe7IEK+gedxehn2O54THqWAHGYRh+v+qmE627ZMx9km3m1PW6eJCBgVeuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFcmlkpC5QCGyedFkKfsL+4N0r6QJZegpkKFat0URJc=;
 b=HRQRy2uau+fSmC3ch9GCekAnJXR+wsBZ9jto3afa0edFxccOmD8FwthCBR0NLk49RQyQxUojAZ89mJt0FfSVN/36XFzoUOH9ioL3kSwt4VCyVNdGER7MJU1RqdMQ+EMv85i+rBb/EeI9tu+c2a+0zUr5uYofh/wumUxky7Ewvs9vDUpY/n/TTqO/LmJJEyt3aXou6xgTQmbtmeVuGTWdG7hlL0BYzF9iRtjv2I4QuX/hp4I/u2Q6mIx/0IyII10o7kPKiChTgPNc5szYa0/avxSbnx4EVaM8cRx+mCh0vRzodmjRdfSUYoS/vBQrbSa4EsMT8NOxwKHoKzmWrTBZaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:43:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:43:22 +0000
Date: Mon, 15 Jun 2026 09:43:12 -0500
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
Message-ID: <ajAPgNELlbL-EhWE@SMW015318>
References: <20260615-b4-pwrkey-v3-0-9510b1173f6e@oss.nxp.com>
 <20260615-b4-pwrkey-v3-3-9510b1173f6e@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pwrkey-v3-3-9510b1173f6e@oss.nxp.com>
X-ClientProxiedBy: SN1PR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:802:20::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 2553bb58-b8f8-4aef-8069-08decaec72c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xrslqb7On49qTXv4lgx0iMi89t5K4bhqHIF2AqhlNqw4+KyWgt5ETo6hwdULAreRNcNMGzX/Eu7FBj62QIXkePFyh5WN0vrrVyb6dSBVA6opcciNz09ruYq8tgHK+q/bAah+jxxmma2+/bXzzv5cdSTIvuik+26uwcArNEHmifPCVlAnXC+B9yEwsvlqBJBQsq6TpmdMpWC8cmIYpqXQM6pnOg/y9ZGnVvJmy5bOMU/N1QUuVNQkxgdQ/EqcVfFZVb1Wyak7nccbuKL8iMN7QRz+6nZHAMp33SPgIXNL7qTCW2XxQiAYFfHfq9C7ArkAVPYMDJc4sBtOkq/+IhY/vX2iEWlWpzteMa16Qvcf+jpVLlIH9IQrLaQJl881EQ9s4RXIFAT2lhl+mBHjiQD6cGD8WeUpRm6GWlzT0hbFXGjhjv4XDg6C2SeK9phhYJyz0tWf5dlomTU0m7L6TIrQiyRAv4/1g3/SjIrRikhgG1HOsdkz7s+4WCL31iuVr0/syiBzY/a5m2hxSCx/O+936RdwYRzdSNQm5/362d131ivl36+s8u7JjmRj2H1vnovGozMLLoQzhwK3uhnK/R0TcyhNI15gb14wW8l7kdhVB1kd+7FlDDj1nqJVC8e2mynPX6Q32j9AVjvnNWmqfJ/0PXZ5Cvd8h/JJ4D4nlGeZvhs0uk842MtN3OrFC3Ge+t/M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yiij2VgQ5prdLMbpXkVcVOI+LY/r4FX7AYzGCNWoHEf4dBZ+bMBUqyovGtQI?=
 =?us-ascii?Q?THe+YXCazuquO+nE5ilntGLgL+kcW8Rxf8F0S9rYc7LkrSUaCvtaLG25gpuW?=
 =?us-ascii?Q?Kza2E5FQabarRWzXA5ad1w9fuWXmXcd05gsVHuRD2mkaYbZYI1ETkGoNxoBT?=
 =?us-ascii?Q?jFkP8+MzJyonCBiAWUmsGujgrERZMaUWBTtnr7i2xHvNpH+oBMC8tKtEp+Oj?=
 =?us-ascii?Q?sLzQhlogepzrtaSAw5U1foepkOd9IgKCYpB2UfaAf1AhfbN6gtWf7SV7x/Lm?=
 =?us-ascii?Q?oZr44uZfXm1T0/9LsUZVgJsQLhyee0dmtwW2+7rIt0wCKcF7t1mrB+ooIYHb?=
 =?us-ascii?Q?1DJNRVZ5k33viJDTASTxSKRjFCqRo6+fJ89vhvCtIk0gTiYcOXD0YHlh2VRH?=
 =?us-ascii?Q?kLnVpHFVH5qoyr+JKxtpeZa+vWJIBT2oLUuO78QaBaV1MEdlcA599BHQGL7d?=
 =?us-ascii?Q?Xz2BGCfyHJqyj/TLcqg4T/rym9NcVX1mS1y+TgueGxCH2Rrl/ZW/Secic7n/?=
 =?us-ascii?Q?uxEdEZmEZM+ZbUXni4P9oD2ckDGokjsJ52nhJE73AT4KUjNTvyKNweZpAVk/?=
 =?us-ascii?Q?Hv8NKVzH+ax4zcM4s2eiN9mifj40bxdhcPCRAKenCfURiQny5j+aa+CcZGyN?=
 =?us-ascii?Q?aP5YydoaS/AFPHJxZgV2NBDTMUk+nPpUKCMXD5q9jLfFwyejFPyjX3ab3K3q?=
 =?us-ascii?Q?gO+B1wc+/zI/9cnYnlmP2kO2Peee15MtCh/kk2mbuSubSk0uhzl3DE/0Cjqn?=
 =?us-ascii?Q?LYCMhS15jcgk9lK1qJ6yQj0CkeEn3Nn9JGh3f7cu9/pPrtXafkDPnN0LIsB6?=
 =?us-ascii?Q?5pgRB5Oed2uMANhickQhSJJIbTEW3vNAlZQx3+RNV/1Zt/8tLs8y8lmXn67U?=
 =?us-ascii?Q?9AIWUOWUJCYhVtci+DQEEupxScg6rLqpgplH5NSNfVtx7I4nEggpX/dzUZ9M?=
 =?us-ascii?Q?Ku9N2SZwDg0cF4V+J0cYcvhxfD1iuC89KXR4wqcxdpYDAKH1PTUb90uhZDzS?=
 =?us-ascii?Q?+S5b6Q5qOm2IuJLVBnspqhSP9n6qlQMmVFFI3kAsDnDffvnLY+i4ttMZdfI3?=
 =?us-ascii?Q?8aiwOeJF7xJo+qVhISR86osGexDQg8uleKR+tfVRDAO3aMZd1cOj8QNKlogt?=
 =?us-ascii?Q?wYoeVyowG87vWx3vW53wJE+TM75/ww7cnyFqzpKX6Ri8oG1CRdgY0NPRy/Lg?=
 =?us-ascii?Q?dhOAeEvDVJHiKs0SHpfc1Zh8PsE+4mOfwm5wdOONTT1FCM8ChrqNDkljmHx9?=
 =?us-ascii?Q?XIZdyvwEVwDfHYLWPxskx8qR7BvCrliBND45nc07ODZUs0ptZE+0LsC1FsXp?=
 =?us-ascii?Q?G+UBIaZIXLf2STszzWCUGLTWyOCQvgEfaE5veV+01H9D6FxNcRZeBhxQSkJy?=
 =?us-ascii?Q?oNJ1JmpuqbHEajJv6ts5SUAWgJAIAV9CKsK3fGezvP+oABf0DT59B7oCI3YT?=
 =?us-ascii?Q?2PIlSMDLRF134LFiKUvaYUaRftYIpcf5F2xwNRvX3O8jfmHW8EUgRxCX4p9O?=
 =?us-ascii?Q?F9y00+XwYiWw3v4UT0P5LVsuVpEOfnreQkxfiizTZwM6nq7AHub2RegMLBio?=
 =?us-ascii?Q?C2hVnOml0cBhiBv+12PagUWiGr99vhXXJpVKtLWCYh9qkOiciWRpJNc6da7k?=
 =?us-ascii?Q?4IlkFtNMkGFg1WSsE8yC0kvijqOGLC832WO+pGF0S+myzvCGF5+iTqOYu31K?=
 =?us-ascii?Q?qAjJtGlv7ajF3t36a/opyIX41zXuQGKpYfG+tPlSG1NyjSAt5AprmU4gdPGl?=
 =?us-ascii?Q?uOUv+X2PXsF1zFoCiYnbWzP+DdzT65hUu9z/shukGSMXUUwndAfT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2553bb58-b8f8-4aef-8069-08decaec72c7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:43:22.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shZHBXjYvyFhPiDojvRVviSshJA9l9bfHqJMOP51Ur7ZX7MbcdW1Vb7AxHkjJvZvAloEs/nnRwWJ2fwtXG6ZC/bQCL3y6Hf9K6p7XwOFVD1PKXEBwDJ2lJMPsIfiUFOH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051

On Mon, Jun 15, 2026 at 03:52:16PM +0800, joy.zou@oss.nxp.com wrote:
> [You don't often get email from joy.zou@oss.nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Joy Zou <joy.zou@nxp.com>
>
> Use local struct device pointer to avoid reference the platform_device
> pointer every time.
>
> No functional change.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
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

look like you missed this one changeing to dev_err_probe() at patch 1.

Frank

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
