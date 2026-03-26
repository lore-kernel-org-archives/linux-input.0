Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BEF39FCA8;
	Thu, 26 Mar 2026 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555057; cv=fail; b=RXs1Wxct0OiDVunacMvKz17krnxsozUfswcxJ5qhF7yuVNjO8aj08Dlj5QB5yT8J3rB4GC7oELGKVMmlOWd+PvyaJVMtKaVE+0nGZrjPNZiByQL4T76FkyeRm1ChyRPYm4WnbB9/NzKAt1XieerL7Lq2sxUjz3bdeKM03b4C3nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555057; c=relaxed/simple;
	bh=tNd8cP6BcelmWU6s++nUF3J+6PdGltj0ohb3jbxd548=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJmaj+hViZU8diw0cPy5P6K1wUTlPQBf2FOxO1uagesw+Tkp/lwZtiWofGmoBcj87Su79iw4aSIqAS+q/KGvLeHxTHDgy3EFKFleMTlgJcvq66lvCsPy3jt3CgOlQRP6P4zE83VLwTKFT0rECU7r/M1EwYzBlrtEGcVhWDEd/rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TA+s/mBQ; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TA+s/mBQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEExLWhXvHW5Zpj0/37/rtbflF6cknUJehnr2zGulurObMfFPs11lIjmTodhlzazqVIx/MZeYYO4aJJzAkyRhaHPrUyn/x2gBP5Rj6Jg2lWTLo6AkdJotf7YsjbxX4YtR6ZZ5NcUHjaz0iMGCtiNw66gjd5Efe27rx7kGohBCPzoFsMdPnrJICOqWU+5o115eKK8BnX2qUdO8Nxj7AC/v4IjP0V9+yokEO3iGOXWPTjJd97CechwZH8uJZD9fr82A5V0m6xH8GzmyQQH/X5D0UmMuVtI7jFO2s8Qxj5m87srA4Jp4hGT2gcXJt41F32HfgYXFXF7yMPoDyzOcU1+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si5epvSH213Kaa+UOHorLsXsmY6+yor2EcX6MiJb56w=;
 b=JSlSupAb/Ur4/9NWSDM3NneMAdf7+t8OZno4ognQ6ykt3i3XZIZpAqgA7SZjwANKdGaFB2zxVHyRNjtvdKMCGBXE+liSrMDyUzsnh2Yxj/SeT1Rd37KZD4x6rdObG9fsXSHtQZLhdxYn4J9FineEh9oQYEP9SzDqXrjrAtfUmKLihCbOCSwi2XHD5Y/y1YzvFOKda4lI1/MbDsuBdJhgcQngLlQd2FY4F82DVKAjWzdOOL8tF8AqTWV47yTb17/oNYm70swVBoDnqNaPMvCBK5vEPdLVHi4OWnqnT36XojnxD08S8DjwiumzhGIxRJK7Q8b+wQk8pdF+VwWp8wqJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si5epvSH213Kaa+UOHorLsXsmY6+yor2EcX6MiJb56w=;
 b=TA+s/mBQWl1zYFlNtuUBgi4hr/WzpJ80KVTHb+fyexoxfGkBBLPbYJi/+D1rOMXCcGoCz4/dcy0tO4M4hX5SiXKzo8dAEQpDj6LkaJxLpBW2azHgNGTtp/FAsiHYHx+XAMyADfnT6wcdpiOxzTa0KSGxJihwPTwErcG7UOX69McBYjaHsbibYwRWmBlgZQ439cBHNgo6JqyQK9qDSzgum0OlYj4snXh/f9ew5OunGO56n/vShbec5zaUB52TjJJGYGqKqVqKfQ3vew9NAoT4RIkoEbYn9DCdl6gn8BaJcYQBecpDxm9glRveKt/IXEB1ZazBX/zXuWzbi2cnNZ7GTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 19:57:33 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 19:57:33 +0000
Date: Thu, 26 Mar 2026 15:57:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: snvs_pwrkey - report press event in interrupt
 handler
Message-ID: <acWPp7KHxv9a5Az6@lizhi-Precision-Tower-5810>
References: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
 <20260326-pwrkey-cleanup-v1-3-d85d7c0bf275@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-pwrkey-cleanup-v1-3-d85d7c0bf275@nxp.com>
X-ClientProxiedBy: SA1PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: df89500a-905a-4169-dc15-08de8b71eba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dN1Miht8IviOqBFqcPRooRVvKSHD/yw/IrntIxLW8kpXrKpV4sCEIcxJipDejHgb+pt2rUun2Wcp4LCHiTDKwHq9JLk0LLYyUZSYdOyk9kbgQyMyzsW635NkTrj8K6ffhjuLcdS5F238UE0n4Xr6TGo1gJtPXTT6mXTMKh0x1RclvNQ6b1+pQKpGAXGYtB1LyR2Bqfkl8t/NEw4u4SeIk5L73XselywzXN8swtQfQufVyvXSIGVNi/SII2O0ScAEqx9e5QIG4lT3yRG4fawfMSlohoMdRMr/vv5Ko/ebvWIrSiXOCNSi5U4QBi5ADkzwJRvtKJw3q96/IZBjsKT5wzDi9m0Uw8ITupiBRlepJVlPWG6rCf68MrhqxdHBz3rUVk1p+GZhNP+FZvK93qAJCWSa72vaEgWZ7Ko6MhsNLZFsvRWN4z9GcDmIHHChgjA52+LZxP21pj6QSjkJYF/YKZkjKI+ku203pS/cPxEAsKEwQEmvfJDXJ1MiDeohtQJbGXWzwF5H4Pfitbaio5qMoB1tmdr+pvmaEwKhb5bR6uSPma15AJOrERAAc68yvPaTYfBZp77I6Bk+5wmw9lq+JddEJ/XUljPxTZUBMtOe9QGEiu8N0g7P2M+/EAaCT0AGOqWjZclCY+ScH/zaYWLvvmPgz/wlZ89nrS8G44TfBP/siFYILDBzS8hnFucSFd4E+GDTmctyjg9B5okBMWuIC0jZNt4f38XQYtsyR6AvyDZE5b25APAqUvEf7DUm3MVm3VbuWjWKJ96uz6DBTjhQ7ewEoGcZ7246lnIsuyt4zFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3b+zYRHeKtXoQIcm0KsOFYPh5ENq/CL4QdPGznynAN32ERKaGIUVmXr7Bmao?=
 =?us-ascii?Q?kCp76tJd8kArvS2Rz9a8Vsm+2qqixIwglzWj2llYXvdlX3p0TcUgwJih8mn+?=
 =?us-ascii?Q?fbTqmJwOXZDy1JYDamRmhNwSLy+vjW7V79Ql6a5M0xeNDY5zKyx7By1Nd7aV?=
 =?us-ascii?Q?oazVu+AYJZSezXKyKRXrOGo/+muGvo0wyKS8se5+ptZQO/6z3rMhcOsbZBSn?=
 =?us-ascii?Q?waHF21MBEIzrOWuvPDfUGyq067dmmdyugW86ADdR0Cyf9Dbnck2YZ/ep+s7f?=
 =?us-ascii?Q?me47UcC0/K4ubVE5vXeBlmROLKCI+XaS+HaclurJRnNz/O1ryInjgLUs/hWP?=
 =?us-ascii?Q?z1clk2yXrlS720b8s0rdLTozljcwy/ADqmp/ojuw7VkwYGXrfjnfDxkcqYvi?=
 =?us-ascii?Q?tzlppMBh689vOJe0kqORRmU7fUNXjr1zZMH2f/VBUrKg/LVOND8eFqcUprr1?=
 =?us-ascii?Q?kSFiV5nY28IGhmbkI4iKmUNwsFC6KedELAdCz5sJPNKKet+05bYN7ZiSJTp5?=
 =?us-ascii?Q?DgAPVVdk3ZcG//M1PFKDn1RGEi+u0fNM8ywNkdYmCWcrXh8lsFCSOKQ3wRxb?=
 =?us-ascii?Q?jMWqVZ237VVAqmFdiuaYKDJNpNTqGISgGCkA2DPzFrboQqmwA9XfpHQom3HI?=
 =?us-ascii?Q?3tQq70MMRw8DmezwmV4uvfyb3CQ/c/FFxe4jWTwihcpuUm3XHd0sqiwZDlHV?=
 =?us-ascii?Q?Jz30FUVT/yKwuOVIg5wy5UEKbRgyOLOv+pD+q2B3wXmcWaf/3LnWt4cqPsPJ?=
 =?us-ascii?Q?zMrIPQxTqhlcAOi0ZBcaxOneg8Uiwx1hDmjmvVMq1qsV0JROMd6mIaaATxnH?=
 =?us-ascii?Q?4ElY+tcgmsPzIAFsnDSbzxutF3mTeSDpHX1czcSQNWBRbXhIkFYqHKMFphmq?=
 =?us-ascii?Q?2NzRTRPDxwAHIuUuDlfTupo+7Q1jjatMFaqWxzcpL6/6rbaKt7voptGEREig?=
 =?us-ascii?Q?XICNJ2Hxxml53AUcm9dx52qQDx31JKNBAqSOoq7LgIc2aqBFYx/SXbTmSusg?=
 =?us-ascii?Q?IaXfhRoeF1giVp2jpVBiG+ZwZqOPH90zNPEyecJ3+hc3WNVSuuk9wJBa4EH6?=
 =?us-ascii?Q?3hdd8fOQg29d/7wFSeBqc2T/biP4ahbviPTrCz5EYx5OpnFGN52PYDuG6+DL?=
 =?us-ascii?Q?Lts27Lx9XgtRChq7FRwvfvzLcgMJlxFyEtqeLSAZ6CaWNtueJDlQFqXcni77?=
 =?us-ascii?Q?gEI2WolgPfP6vG4gqPX7GemRmjp376AY0oj8ouiNWegDnIZKPzODMDidX1xP?=
 =?us-ascii?Q?5Nv7VYcdJ4nWxedtu9YiP5BHFHpEcgASW7pok336HaKbeFKpz3PIyX86LB0F?=
 =?us-ascii?Q?9Vr/yd8LXM4JkGS8vlghfnUKmUVW9uCMxhnMjhq7Tn7ocrPXw5lGkyc4A9/N?=
 =?us-ascii?Q?057ruJDmzV/RLkhIJyJbN/rkOkloWPAVcrDHYh4V7OjFssVcV04MkkYtz7az?=
 =?us-ascii?Q?va4ntoIQAQWfr1k7nHQXe2/X2P0f3wMX81bMDW36obt+VoDsqYOzbUOPxaOC?=
 =?us-ascii?Q?//cwXBW+nUUw0ZV9U1PT+pBnxcwshr6Fwhi7Mj4u0eTktR9ajTpiY/z3gUHi?=
 =?us-ascii?Q?2vZW+6frSuVz/6CUYR4bBO/xc2nFpRp6RW9E4bKX5pJjnYrjcbWtbZIFUud6?=
 =?us-ascii?Q?d9wr+jv2TOnmtC0NW9UGN9MOWnCsiFJV5Clijwu06NM2Tkn15NTmaj5E9ZMh?=
 =?us-ascii?Q?XqjbpM7NFX/49Y7dGqTKgAAr+q05ZVPAz/CAy/lYvmJtLkbkluHLQhQZfJB7?=
 =?us-ascii?Q?qFi9TCEdog=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df89500a-905a-4169-dc15-08de8b71eba8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:57:33.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLPP1+4mbc4hOtnE/nkXgPj7Lkc55q7C6WERxL0Z3GtNeRXfA2Ue23rW0NZrVuQpdd/43sJdFFYC2vxufb9YPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813

On Thu, Mar 26, 2026 at 06:39:40PM +0800, Joy Zou wrote:
> On some boards such as i.MX8MQ-EVK, the PCIe driver may take up to
> 200ms to restore the PCIe link during the no_irq resume phase. This
> causes key press events to be lost because the key may be released
> before the timer starts running, as interrupts are disabled during
> this 200ms window.

if irq disable, how imx_snvs_pwrkey_interrupt get run?

Frank
>
> Report key press events directly in interrupt handler to prevent event
> loss during system suspend.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index bab3ab57fdac77256be75a080773ea99372ec9c7..b557c1618d7369e872c6ce708a7b3017264ee385 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -78,6 +78,16 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
>
>  	pm_wakeup_event(input->dev.parent, 0);
>
> +	/*
> +	 * Report key press events directly in interrupt handler to prevent event
> +	 * loss during system suspend.
> +	 */
> +	if (pdev->dev.power.is_suspended) {
> +		pdata->keystate = 1;
> +		input_report_key(input, pdata->keycode, 1);
> +		input_sync(input);
> +	}
> +
>  	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
>  	if (lp_status & SNVS_LPSR_SPO) {
>  		if (pdata->minor_rev == 0) {
>
> --
> 2.37.1
>
