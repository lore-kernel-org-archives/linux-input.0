Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97A376A00
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209946; cv=fail; b=csmat5ktDw12uJeJotTq6WbOqQYy1CDv5895/AU2gc5JU85H71w4pMU+OfIDBfgp5QjjIU0D0l/p9s9GO0GfPTLwHsROl6LMpcGxY4Abc0mAuip5bDP5S8aWAB/NgoU5gV/DlPCaq35dy2lDPIMLNWknhUtl31C82xc+blr+lP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209946; c=relaxed/simple;
	bh=+we5wKOnzZyfgD6CEQeOBYxa9u59yOeVTHyNoagCB5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hKwNfgDiVmPUO3LMFEtw7BxHLeO6NWxNoRcRzWvonp9z08iysus7YfBZ7QHWCOkY0oM5qRUOZcLmZ8/Hn13xItzLM9K2VRfZWrcjQUXzYIrXh2z5yul+NaNcz5uM7HpVu7kpag/4gENVJUqWZfJHtjrVuiZycQRl03FsoXC9kxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aX4WUK63 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aX4WUK63"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqRCkBBQX8BST42IOe027UIi2o9zKvBHX8nyeBwyV1V5BhyoE5/3W88SEvrR2y+WFIAsHqbRFW+IF7RwHyvJjOoUwoWVPCUbashYxTz5/boM2oPSZQuo63d6KZxjvcY0ONgqpSeP5/b1guDVthuxtvHwsph0iKpPTBwx5HX58zHiOCjbS9YEFvyhK9FBZW3k4KenNnorLHDAztwE099NiKbH3WNzbZHjYrZlh/usYM9UbKJpNZplysjDwfFK/AcYGc9bqvKs5orU7938dSqFEsdGKlkrIad0zAIucupCLmYleVKQBGrDX5WRRneNeTVjSMZO8E0Id7MPUUQv6bZDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRFkuI3BanOyRlQx2Phyb2xbEFTzlfubJ4eGYNakV10=;
 b=VBOP1yaTU5ibe0yJ0Zh2NQvU0ufqMkGXT/z/aCVCHY951kSqZhkIFmrZ/Rorwun1KK7NKyh19FX9NIOLLSCIG6tcpIX00WRtsEx9y3twojofm5XnhNgNnUJDKb3F1Nrw6qRP6g7qDFsv/Dy7FswxUOqOAWAGAptsyWlmbiwWZhHELF3RT7C1wtGfJQ7YLb/EzwcjPP/GFuRiSGQoL8S6zQe3D8Qu018mIhXeBKWKacQG/2GlFDVIn9M8yZ2NH7sQL8z/wzI3rUeMsW18622pNRo2wgcZh+Z/rwGoBPQTpJirvjR5RWrYZ4aG6z+y3mVbzZq+qvtCgyLDUeMmNTN3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRFkuI3BanOyRlQx2Phyb2xbEFTzlfubJ4eGYNakV10=;
 b=aX4WUK63PtbUrZI4C4kk2AzMKq/6BorjWJd4oBVKgIEE/nDxtVR/8TzdwwggKQcA0KM8Gcr3bO2rlKAF6O+5atmx6avkoxmzcuXlH08puqdTvToe2z/b7WYdaqkJqK4Q5g3EPm9EDyWFo06LD/Ue5CZzZTNo5Lc2ItNpx52plfJuSPaw/Axpc0rjSv1L+OpPm6e0CqQxD2384j+7HOKIJAFIy77UytN7ho2+WfiDQlAMcDrTDUNM68W8yC28HMw8eHr8lcQ02sOtqraBr4Y86u9FyzuuHIystKVQaGOAoliOfFwXUe200Edzsf0SCW3K8opvIVwbA48onIAkh60t7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by VI0PR04MB11868.eurprd04.prod.outlook.com (2603:10a6:800:31e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 10:19:00 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 10:18:59 +0000
Date: Tue, 23 Jun 2026 18:22:16 +0800
From: Joy Zou <joy.zou@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 1/4] Input: snvs_pwrkey - make use of dev_err_probe()
Message-ID: <ajpeWBne2V8eYOOG@shlinux89>
References: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
 <20260618-b4-pwrkey-v4-1-4bfda105bdf3@oss.nxp.com>
 <20260618073800.D70B51F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618073800.D70B51F00A3D@smtp.kernel.org>
X-ClientProxiedBy: MA5PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::14) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|VI0PR04MB11868:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b456f3-842d-4e5c-905b-08ded110d727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|19092799006|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	iuqI53M4wyKLk+Zdpin3h55Zivd91g1fULIcPd72RcsglxcYJ0igGhdwx7zFHC1aPnxNkDtLRPDvOuT9sP2Gl2n53o8aPBoKiHa8c9ZLWUb+lRdKJA6JVv64ZG3HT1ORvKI7sRL+5i+GXYe09kFclQzleC0ZMVWl9HI7a5o7mNC7cC5yqPdFN+epa1hnPWsFsbUEKjTHRlhO+FGN7djI3/5YERH7UP3/eaAe1WwvH49PhGZqhRjufUrO2r1E96hxxQvmNDmLg2lSgDSXb2T0vbldQJj+XMjvkCBtXznZRtmb3PBj4eUORchJYtmXo+UgJZdWLFjwRpXuoFGB4RO1rfC1/UZztkhqkX5rJJngRhhvBoDjEQd/2/gXO7WMqOICmdJ3Ed0rmm+OFWohYjF/KzmGgRMViMtcrzNEowYybMxFHubb6NocKKzjxTVWRI9aK10Z5wF2YrS7w3wtTzQmY3WnFDU/2ZB1992F2BAV46wbP4QKsOsZn6MhzqlmTRTMTo5HvGzXfuAXAEURO2jvGekVCd7asGZtdC68bsbx06rrmbFvMRj8HoBNB2ZnE+7r+6O0HN4pJUFjzFvNscEsVdBFiM6jbAWqHXyTCvAuy+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?T17EFbpiq5rf+rGZTZY66ux//UgqoMU1a6CX7g7kUVmk9+udE4Zgx+wrAB?=
 =?iso-8859-1?Q?emQrAewztUg1XAyoNnjiFJr9crGmcS/R08dlr6uHa63YMifKqE+NYwgjsK?=
 =?iso-8859-1?Q?lH8YiIgUTC4OyA74tlZX1Lx839ODu2hhDjG7rYXT3AwS6Jw7VgvDGOwarD?=
 =?iso-8859-1?Q?XPrVokSG75xzVvJ584PeyIdebv1hsQgq7xd/sZyeB2RChB1jW8O4pOE8VW?=
 =?iso-8859-1?Q?Hszfvv0Ns/TZ6c/tVhwM/U77gXA00V3X/+EJf0or08+mV2iazsDLL8VRcR?=
 =?iso-8859-1?Q?H4rcfGSp3tsK+2T9vA+mX9bUiX6LoCW3ia8ehn5jj4C1c4Qe1W6rgLYdUG?=
 =?iso-8859-1?Q?pWkoH7G7/700WffhbX5LYGBul2pPvFARYvNaYg0EflYsQl89Kb5JK8c5Yf?=
 =?iso-8859-1?Q?hyfrXSKmF+g0yOtmBUiM2/FDFZ/44CSNYM9b2ZifwuJVJy/abovBBstbsn?=
 =?iso-8859-1?Q?+T0DB/tmhmj97Bwv05qOz450Pt4Po1zbs7pBZPUQcgnlOYoToJKUSHaLQD?=
 =?iso-8859-1?Q?Qi21acr2twkX0ewOWesIlwRE1bKbKcMImFKZjEGoxNHuYj7ISaYUuphGra?=
 =?iso-8859-1?Q?Dt7bZBikK5QJtjeaGXMK9gK1Uo1T2kicKdgVn4/0ARCJ0QNqXTWLQZA5j3?=
 =?iso-8859-1?Q?qYG9T1xuBoEaA+Ei5rS5Cj8WfktzLMf547oyFxteVhFGt3PgCg8Km+cw6g?=
 =?iso-8859-1?Q?gI+8W6lNPR2nG/Day1JXeMcuOjyVTU7IEB/lInad121ua4gDODJq4SGdvQ?=
 =?iso-8859-1?Q?XfeacaGdYGt70Kf+S50IkloUsZ36Z8MKA1dqOTgS4zC4OcGH0LzpKN5kh1?=
 =?iso-8859-1?Q?yOOY8358ODkmOLlbBGyQ4VJm/LXrK4d6KoMTUXe/cT1ulyJrYOGS4UOptF?=
 =?iso-8859-1?Q?7HuvcKT9IVG/5+eq7lJm71gltgIBwtVPz4gq8X5RR5OrTq8uL3l6HRz85f?=
 =?iso-8859-1?Q?Ph1FLPflM8hqFTEZafKPV5YybNzNPPtBviObk5oUI/Mzh/5nY8SvQAR1qN?=
 =?iso-8859-1?Q?Ii7YZkZHwQjFq3QEnEe24oTKKDej4pGT7YB4h0Kkw8V+mJdLLWGd8xYbj4?=
 =?iso-8859-1?Q?pn06sFMtYVLKMcvPe7L508MIXmZz5ePPSBLZ71PoFIYr3PRkptGjnyhq7b?=
 =?iso-8859-1?Q?Z/sOzzRqnB/9f+e16X5DPaXDrz6Dz+GLpmMicS8xtXgk0d1joNVgQ6K18m?=
 =?iso-8859-1?Q?F6T2NSPpafUTx/JvlPX/bKRSafOlDsoT6zUeKYkjCEfgF9n1A/ZVpGVWZX?=
 =?iso-8859-1?Q?UeZt3wiQReVZqpN5+p7wxQW6u0KI2pKBkmbDivNqTUiQ/iHXT4j4yh/0fR?=
 =?iso-8859-1?Q?mnVwRaKL4fscIA8zUCdyRTBKX2dgfN6hHKl/x73vprEhoF2pO28daYmKtJ?=
 =?iso-8859-1?Q?TXCP6dysLEOELZ+yGi9OUpHI7xoxIa0avXZEeB4KzPACN1S44cMiWGoq/K?=
 =?iso-8859-1?Q?k0TCCF90s9Hpp2HfBtVIVyk0qayzvnkUIh0BV9BL5W+zkuIcNDNaAKE+NG?=
 =?iso-8859-1?Q?AJvX3w20u1SnH46KtC78f5yyQu5QjgZP4gkRyQzWwPErNse/5KlVUE1VMM?=
 =?iso-8859-1?Q?6Bo44NY/NiFpOEIaztAiUezuTnzoLx0ZLoPfF0jleUfYxCksZjhL2iBTcs?=
 =?iso-8859-1?Q?bcSIEWOuVV//2Yo/8xWS7O+z4G7FwZVU7y9QlTVGLLSTavZgB1BEX4KGct?=
 =?iso-8859-1?Q?iCb3mOStUKb7tA1PEqs1d2BDh80ivArcOyWAKATr3G6dkRSzsFrwnTjXKj?=
 =?iso-8859-1?Q?WOYBNnGvoobZ2BFhqFVpL65VjBsc3n7AWdbyiLKy/bEGmIcjoI/u4TUS+3?=
 =?iso-8859-1?Q?7HE+APDj9Onk+BEomIlOx+Wu1BRNyX9i61ERanv67FwN/a00NPdN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b456f3-842d-4e5c-905b-08ded110d727
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:18:59.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuUtXNrPAXd+PGSg0Bh5bcFCVWB+tfLh3fOviB3lhRVPdLzE9TcawsTj9y2L++i5UEWn1XA7z49RZegAUVHVK96MlfbRVNWrofbNk0/yBCB4xzdGURmAoiRTQPyX7T1B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11868

On Thu, Jun 18, 2026 at 07:38:00AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] Memory leak of struct wake_irq on device unbind
> --
> 
This is a pre-existing issue that won't be fixed in this patchset.
Will address it in a separate fix.
BR
Joy Zou
> commit 469e290fcf154d6638767e1e60cb2427638bea98
> Author: Joy Zou <joy.zou@nxp.com>
> 
> Input: snvs_pwrkey - make use of dev_err_probe()
> 
> This commit updates the probe function of the snvs_pwrkey driver to
> use dev_err_probe() for error handling. This simplifies the code and
> improves logging for deferred probes.
> 
> > diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> > index 954055aaf6e29..8cc6863d26ed8 100644
> > --- a/drivers/input/keyboard/snvs_pwrkey.c
> > +++ b/drivers/input/keyboard/snvs_pwrkey.c
> [ ... ]
> > @@ -209,16 +201,12 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
> >  	error = devm_request_irq(&pdev->dev, pdata->irq,
> >  			       imx_snvs_pwrkey_interrupt,
> >  			       0, pdev->name, pdev);
> > -	if (error) {
> > -		dev_err(&pdev->dev, "interrupt not available.\n");
> > -		return error;
> > -	}
> > +	if (error)
> > +		return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
> >  
> >  	error = input_register_device(input);
> > -	if (error < 0) {
> > -		dev_err(&pdev->dev, "failed to register input device\n");
> > -		return error;
> > -	}
> > +	if (error < 0)
> > +		return dev_err_probe(&pdev->dev, error, "failed to register input device\n");
> >  
> >  	device_init_wakeup(&pdev->dev, pdata->wakeup);
> >  	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> 
> [Severity: Medium]
> This is a pre-existing issue, but does this dev_pm_set_wake_irq() allocation
> leak when the driver is unbound?
> 
> Because this driver relies entirely on devres for resource management and
> does not implement a .remove callback, there is no explicit call to
> dev_pm_clear_wake_irq() upon driver unbind.
> 
> The device core does not automatically free dev->power.wakeirq during
> device_pm_remove(), so this allocated wake_irq structure appears to leak
> every time the driver is unbound.
> 
> Could this be fixed by switching to the managed variant,
> devm_pm_set_wake_irq()?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com?part=1
