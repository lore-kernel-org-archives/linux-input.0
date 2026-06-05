Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D341B34F;
	Fri,  5 Jun 2026 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643059; cv=fail; b=TZKC69RefwRYyZKg32WCLt46IAcysH5dGpRmv++q3K9e2qV5DQMFxljv7fezpm5xKa/gC459cvyCVRG7PQzH1UDblKyb+oBwNHyH0CfOcwDw9jruy/FcNZMmFMn6qAJIqOpx1cDigY3BH3GPwaBDTwRbd2XDMhDdGAqBnz4Rzcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643059; c=relaxed/simple;
	bh=gUaCOiBxxkKfZqj9GERLQT2v3BmjC3/hEUknO6FhKqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b5EZ2NXfW4PI3ShMDWvuaBL9VHe79KuZgb6NrgvM1Rgt6GMqhJk094hxGu3wgRNvwpRyXzVeuYnqbd0E+xo2K4fB/3PbFc0WH6AmN1O1SbnAvw4nHR7ETaZS7E43GsQaJaSvM5/1H7QhPZUAlZHWkxBgLufuMznDDknu7IthbfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rN7aXsW6; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rN7aXsW6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxCZ269VBGvDMEi8SzM2ke0ojFmw96BpkGf09BxVqPw5M23wM1T834fIvHn+BIARUYExdpdMpMHHQIpu5wCRfT+b8H+JQ5PnX06TgOlQug9N3naxi05va+pMzaIKUZck6ZMjmsatyN9vw2Y0EiE0/IfPWgBwTk0sqne4g2nM54IThbrZdoVtooJqTCNznJa9XbXAIa9ZULKEQCqhZJtqkb535vUYpEqL0CCqVF0yF/NhIavsCr0zjR9O1ahHwwwVLDwCjuIt5mGCvJo3+IKqzyBmsWc/ZiroCBn7+2EPQXr+WrflmbkclmTlIfN1sYrV3ZnQ3OwYTIb0HaH/4uoOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJYV6WH+4TSIGlwoM0llogfoMYy3dpMtBr2Zcx6CpeI=;
 b=w3dsuYaVK5jA3vhtJnSojY+lCPvkTmeDNc4Eg+M75avzLKkb+4ds6lxw5S3v1kGd0PRxyOF6euAH/VMB6X4U/EmhuSvptUn6ES+yUFExhmQmg0S+x/MHEoMQ92MKT1no3vc16kqOCeP/Qzlm2lG0LYR5+iQpSY3xC+5q2XB06QVlmYjaMUov5t7Iji+R0hnaIpQVyNsHy7XrtCyweBTyUk4PL1/EbVM6V8nDWzrqt9NlHrLt3LTDb3+BsDuiGWOoCN6N55fRfqc5wPsG9YyooiDlAlLWUrTjfBTwfy0S/OfudmbZTqsFgvhPtp6NEOFKomaG9HcQEnuzWSTrzPmD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJYV6WH+4TSIGlwoM0llogfoMYy3dpMtBr2Zcx6CpeI=;
 b=rN7aXsW6Zh72XLug4IHqSfuuw0CnkuwwZxFPrBne4piNPQax0/V2VQZUBSso8eOgInL5R4kkKfPESIAkyhdOw/X2klMeKo18Mcu2QiAWzRTfBLmK6VP3axBpqFRmsqrrbUGxgrjiAw2SQbP52YKUhPu2HhK/4xYWYAGhy1CVhmuxlhWXA/bQuw8MWRcATSbM0a0dDn9TAXZHncpor0hN2dE0hZLr8Q8AN22KJBDX8h/wHZzPsupLZf6IW+OO+UIZUyxLfq9N4HSCmkFr/pkIS5HDRSWebDH74TwNc2BoS9OuPgnLZcV2+cKIW353dkUhJD/vVBibm5G7lCqyecPayA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by AS8PR04MB7576.eurprd04.prod.outlook.com
 (2603:10a6:20b:29b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:04:14 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 07:04:14 +0000
Date: Fri, 5 Jun 2026 14:59:13 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
	imx@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Input: snvs_pwrkey - report press event in
 interrupt handler
Message-ID: <20260605065913.grovxx53yzvi6yxj@nxp.com>
References: <20260604-pwrkey-cleanup-v2-0-59fa0ddf0d7c@nxp.com>
 <20260604-pwrkey-cleanup-v2-4-59fa0ddf0d7c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-pwrkey-cleanup-v2-4-59fa0ddf0d7c@nxp.com>
X-ClientProxiedBy: MA5PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::18) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|AS8PR04MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2bff39-997c-4a55-f3a0-08dec2d0a6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JnZTuSapACtz2LeEojS12qa5BJHaOihM6IUKlaEFydoLajpvJW+oGbixnmzZw5fGkA5K/QBPSNdjpbc1/tGWG45Ftv84m0pyqAXSB42Le1Jkg91wfmsqvgBml6HlAxXl1rsbvcr2ZWOBoTODwajHTx1KiQ6wgoU7itoBBd5/ifkkagG0zersBhf3TMSJD/pEvyjxg0IhkoLTrtw2NfhIdAymzSb9sQBXmdN3qsYPRRfKLKC4iimg9zGEZQmlSBBDVur7V0WaN7T8eP9xQbU2v3pf2rO9UoOwH8IcD9sHKYNls4/bnxIrxHzcanVwIn6E0kJ4bkpeZ+TbrJ4WeLC074aHzlKzrGmfWhlcbgpXcF1bDt5jO5SbijuFm65fklG14GO7mNKEl9o0LOmn1+1JNl8nq2x2q4Z0kYgq8NAPtcxTurCgF9pGlSi2FKDCVpW8zEgMLpAxoSto/uQXaHwe7p6d29hUUbjs5yRUIeCOKBlZi7ogrfWNZZngef2L6TiwFbXyRDkuQItAvmx+WNrV0g9gwbIKu4sSHEVDR5cjJfOh4rFgNLyKtf0erOE0NAgJlpHuPJE/rYc+PwaVfkIrN1jLWzUaT9SV1dTkxlEmJjDByTpS/5qUMNWvviitjtPI7XNv8Wxl96p0YP73Y7sB9ATD5Z30XN1aVgpeMglbfCefd5n+8XngX9Lqb0PYZF48
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WQ/BsUNFiShn40zmiUU5xSEua2GcObMh1LzhxDCYZhc3F5An7lG/hh8Ey44m?=
 =?us-ascii?Q?D4RWxp7kRePfNAQtBjoUtYOX59uZF8wPudbVthdmuW48MFa2ZjR7NWe34agz?=
 =?us-ascii?Q?CLs1mp4LFvEFc8GPFZMMBhJ7ADM0SMLYOWAsOpXTsjH5s5ZtZvjt9WHEqFCt?=
 =?us-ascii?Q?71bRwMzlZXFmdTHqxeTw7TOjLNzebiCgD1fV0E87FE1JQzt/lnWhb6VBXQt2?=
 =?us-ascii?Q?MFQw0/MEydfnHlqZV/dUfwQ0C1UaOzoP8V9mx/qXYv6yHpi4NjBfoI1Smb1I?=
 =?us-ascii?Q?44eioypdLk+gLR+Ejk6vQHjtd83dcm5nQTpjQt4nI2BLlAOiz9V2LSoRR6PR?=
 =?us-ascii?Q?N8LJtBVXH1f+0StJJaRh2FhQ3+9T96x8EUfIWzTiISO6xirAWWtbybGVvzvL?=
 =?us-ascii?Q?QynlewYcKm+QBKVpsKOBb6EXYx3kO/YNQlHSQl38E/vOdyOq8WbXmvHHqjNi?=
 =?us-ascii?Q?PWfyYKRjRcWT6q1qE2IcPYdh636Dxg29g1uQV/Bj/ShCuPuugJXRG67kSZeY?=
 =?us-ascii?Q?jzkJyHa6fY4cd6tF91X6bqgHoDUkqV0cH8PpGgvXzMkrgDqpaD4S5i9dGK7F?=
 =?us-ascii?Q?F8W23A+ijwWa2rjfK98uAUtlZZGkcyxDDN3ae+iuCSXGoVahmSMf/qYmGhPg?=
 =?us-ascii?Q?xsWlMd2LhhwKlaTck8CxlnS4jPw9Ob++R3RbG6SKhLhEPLauBhZBDNXvGhCe?=
 =?us-ascii?Q?Nw4kwb7AuT7xRY3BKpptRKQtgXdddEUEtBTT2RU0Kuj+KUiccJyj14FAhP+y?=
 =?us-ascii?Q?eRyaCQXW2enccjTaKNBW4wyQuvIBZ7jzyFSKDP79jGgiHPsMoZYS5s6c4g4Z?=
 =?us-ascii?Q?r2afvoBqhR02zuoMNfgBOrDSLsiMTGd62pX4dQ7o82olth+M1yXLRpn/VP0G?=
 =?us-ascii?Q?9tPLZkFmTODGL+ZTgKNoRrSwWvyaAIIWAAOunZ17t4e1Ghg1Pan51zQ1029b?=
 =?us-ascii?Q?BxME5YsNlF/1jzNgXUKsMTQ337PcSzYCbbbvH4GHNXRbLZUHaJlgxXYEDJJX?=
 =?us-ascii?Q?OaakzO6hBjvm6qBXoKtl0H4K9lmyfCMNJgqKvSZqjsH4sZ0tZD0dfvr2Aw/x?=
 =?us-ascii?Q?fIIyhqy/zVn4OPhIWL6IdjCGc5JCPZX+SlQtKW28pUsQjk35MSJRs2dy5hED?=
 =?us-ascii?Q?LjZc0WWC7E+w7BLabZ0IPdMJ3LGsX4zJ0YeniRH8wZeVxVKRF8dT+wYHOUet?=
 =?us-ascii?Q?s21mmVr5lhAOmtaV/XU18WEMWmhHESmycM0MG7ey43TjNvrzOWw6y0lRn6Hv?=
 =?us-ascii?Q?kysxudWN/aofYLV/n586plQD8TAy0dgUjQHGUL+tdv5rl0qH7cd+I7dUZ1p8?=
 =?us-ascii?Q?Na2KvjZarJrfcPFjb50AqKr8lCSTcctKqfw7KTgSf9y9KeUQBeNA+WeAy7/8?=
 =?us-ascii?Q?O7tJQn9rKlEVZGk+nB+mYU2MtvppMGuDp7GAYBHF1PmoXVaoVZszS/bmGuiH?=
 =?us-ascii?Q?t/vIkCUdPtoaBKaDCcbCYwNvlUR1sHRVSscIaJ7rsm4H1oO168g0QLYHPZqK?=
 =?us-ascii?Q?MDcvEFXCzDbsPNeEQzf1UNq94TO7HPashbkA66daguy4BhqsGf2/bm5F6huD?=
 =?us-ascii?Q?Phxb+BKJ6GIFPVgX4M95Gq2UYoD/MEKmm1DRyHBzsdmBKV9+1TNAorc0iQcF?=
 =?us-ascii?Q?aaLXhsPK79vmCUzmimKzrlOys5DpTc0vTKVlQYLhSyGOdmtYQbXLZM98TA9j?=
 =?us-ascii?Q?URAV0EmqsfqVBIa32HyaX1+ByRjgaPs2I7v8IRAFWsHOFSk1hnNSbyyx5pxg?=
 =?us-ascii?Q?jRcsvXk+2shrOziMk17FIxCiKwOh+AXr/QvzXjdmJPJXkCt/4wl+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2bff39-997c-4a55-f3a0-08dec2d0a6a1
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:04:14.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UW5oAe9wygN4oIijKqHyrkqdtzFBqYQNBgwGoqum2Dkw6Maj8rDTPVcxfoNMn+yj/6E2MSsrYOnIL09r8fJvvrz3FOdSUf8JJAaBlZJlre7ru2jls7WEucr/UQxSodD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7576

On Thu, Jun 04, 2026 at 02:56:24PM +0800, Joy Zou wrote:
> The driver implements debounce protection using a timer-based mechanism:
> when a key interrupt occurs, a timer is scheduled to verify the key state
> after DEBOUNCE_TIME before reporting the event. This works well during
> normal operation.
> 
> However, key press events can be lost during system resume on platforms
> like i.MX8MQ-EVK because:
> 1. During the no_irq resume phase, PCIe driver restoration can take up to
> 200ms with IRQs disabled.
> 2. The power key interrupt remains pending during the no_irq phase.
> 3. If the key is released before IRQs are re-enabled, the timer eventually
> runs but sees the key as released and skips reporting the event.
> 
> Report key press events directly in interrupt handler to prevent event
> loss during system suspend. This is safe because:
> 
> 1. Only one event is reported per suspend cycle.
> 2. Normal operation retains the existing timer-based debounce mechanism.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v2:
> 1. Add a boolean variable suspended and PM callback functions to replace
>    the use of the is_suspended field per AI review comments.
> 2. Move event report handle to else branch in suspended state, since the
>    pdata->minor_rev == 0 branch has no debounce detection per AI review
>    comments.
> 3. Modify the commit message.
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 4a1d04898482669894e9978014b62e4e9774b4e4..f212a6b26185d13e1af62728e7b2add5010adc5a 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -39,6 +39,7 @@ struct pwrkey_drv_data {
>  	int keycode;
>  	int keystate;  /* 1:pressed */
>  	int wakeup;
> +	bool suspended; /* Track suspend state */
>  	struct timer_list check_timer;
>  	struct input_dev *input;
>  	u8 minor_rev;
> @@ -92,6 +93,15 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
>  			input_sync(input);
>  			pm_relax(input->dev.parent);
>  		} else {
> +			/*
> +			 * Report key press events directly in interrupt handler to prevent event
> +			 * loss during system suspend.
> +			 */
> +			if (pdata->suspended) {

Here, pdata->suspended should not be safe for SMP system, maybe to use atomic_read() to make the code more stronger.

> +				pdata->keystate = 1;
> +				input_report_key(input, pdata->keycode, 1);
> +				input_sync(input);
> +			}
>  			mod_timer(&pdata->check_timer,
>  			          jiffies + msecs_to_jiffies(DEBOUNCE_TIME));

Here already report the key when pdata->suspend == true, seems do not need to trigger the timer again.
Is it more reasonable to change like this?
if (atomic_read(&pdata->suspended)) {
	...
} else {
	mode_timer()
}

>  		}
> @@ -219,6 +229,30 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	pdata->suspended = true;
> +

atomic_set(&pdata->suspended, 1) 

> +	return 0;
> +}
> +
> +static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	pdata->suspended = false;
> +

atomic_set(&pdata->suspended, 0);

Regards
Haibo Chen
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops,
> +			 imx_snvs_pwrkey_suspend,
> +			 imx_snvs_pwrkey_resume);
> +
>  static const struct of_device_id imx_snvs_pwrkey_ids[] = {
>  	{ .compatible = "fsl,sec-v4.0-pwrkey" },
>  	{ /* sentinel */ }
> @@ -229,6 +263,7 @@ static struct platform_driver imx_snvs_pwrkey_driver = {
>  	.driver = {
>  		.name = "snvs_pwrkey",
>  		.of_match_table = imx_snvs_pwrkey_ids,
> +		.pm   = &imx_snvs_pwrkey_pm_ops,
>  	},
>  	.probe = imx_snvs_pwrkey_probe,
>  };
> 
> -- 
> 2.50.1
> 
