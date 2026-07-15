Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249F3AD52B;
	Wed, 15 Jul 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131315; cv=fail; b=Dz2zZndVmNtDnXlfw2nhjw4w4NLcXTBTDtwo0+OanfsD9QVhEQOhmb+fR/gZdQWpoBDISIayN+Sagj0FbyBI3teeX+2Q/rLXr7LG0/qQEzeyTgHYzn8e/GXsuotDM5NNyfAIcyjbFtOcducrjjVlpv8oM+yceAHzQt2wbOOhW6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131315; c=relaxed/simple;
	bh=lGvLGdVlR+qHijLFjR+pm/TszcyRggvHpI3vuRFm2do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R2y1AWuvDSKzeOfoP/WPsr3NHCbJ3KpoM/8O1pDunTx96PHTS08VrXhwnZHMn0KYvZQWuVPvJ4tavfMfi6w9qb2ubI+Hxo3LtcZYhdm1OiV4eTuINbds3iectjHtt234rWndNv+TB+AWsmI3+BRNxQWES/F2k247F8JRnVkF1Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U7v1XdN9; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U7v1XdN9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcYzncpp+iRS03drt6cyZszSa+/hNl5xjCIpDev+YJDPrUGKEjlE23kFVEPJb9YMpw1rTK9rQw5EDwBZyV+Gw/ZhyrJwZrkDEmp1VIL9Ia9rpAi8pktKaPRf1I2W8yhtnlvKiIYz7jI7iTlLKk9638YB6iAX2GVbVO9kuUJDzx9yKcMWkHu9DpeLpTF+BaIvA7tTsw8GWAIoYElhwlMgE9QxiMFAZcH78VF8ZJo2MVou/F7M5Ok/AJ6IEyEuyJRo6wgjQsWgtJdq4QEJ+gZFbZ3xgxXfFqo4p8NR9YGQB7ajJK7iwf05azQaahELZFvo7Hu7TtsiSRF8bJEGmND8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIwN137uhlbkvIJ0neqmcWiH5PccHs7CkA0vhdk/cwg=;
 b=o2QkCGwppygM/q3d0VZXeIZ0i4ihgZ5ggwq3fSd3BPLiSg9iT6/dInzWbsgEBTOQRVqCtGmnWveFcOGu3h4c/4h5G/Ilp7MOWBuxR4/ZU4J2dBE1X4nQjFVbTidgoFftAu4nyLdfyxN73QM0YAh9AvQnSvS1rCz5XVPRSE3P5DZDaTp0s8JgV9OIJgFlRpicjskV1qBIDI6kw010dwHdUwHt0pd6ITyBuGTPR/5id2B4k2922Gee/tEzFg75POUGVm0HctopW9uT2lnTPMWLh6rA9CrUfs67HvUUCvrS53yIGxyvEjHfWGJ7Wkju7JRk+UnXjX5JcTmCz1M4FKdYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIwN137uhlbkvIJ0neqmcWiH5PccHs7CkA0vhdk/cwg=;
 b=U7v1XdN9kuIs9V5CCUl1Va9ARmbWuZBJZPLFSpGNi1XrPoxCdxeSsbfzUkN7tQbtd1pKXyM+gLaJQ36FsPTCu8JE3AronzsbAY03oI1lf3rVlVhfKBsBfO80hk0cB/aY/uZC9ZsMj48X5Ln6gL9+UPh62V+yb6bMkb0ZyshwljzCp50tHRQKJv/N4ACte5ZpckNgXXYSszuWZ7QRG31F8vUZ5sO8rU9yjChXAir+s8TmDeubar2nUApw/VDSRmhba8NSx3V92oFJjZSdSdMfZ5/ZJj//lnpbHZ0W3K2p1RiPbF0PSQzAyYgwoeszlXDh2r0fMpD8u7MB4Nrxz/lIPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7358.eurprd04.prod.outlook.com (2603:10a6:800:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 16:01:49 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 16:01:49 +0000
Date: Wed, 15 Jul 2026 11:01:39 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: joy.zou@oss.nxp.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v5 4/4] Input: snvs_pwrkey - add press event reporting to
 avoid event loss during suspend
Message-ID: <aleu49Lo4iycHRNS@SMW015318>
References: <20260715-b4-pwrkey-v5-0-07e7353c319e@oss.nxp.com>
 <20260715-b4-pwrkey-v5-4-07e7353c319e@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-b4-pwrkey-v5-4-07e7353c319e@oss.nxp.com>
X-ClientProxiedBy: PH7P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4db75b-79cb-4b8f-cda7-08dee28a6085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|19092799006|6133799003|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	t+ufDkjaYYTrfX6uKeWLri8gVTol0fAXQt8HOJk2NDLQ6d+sCgsgzxOkxI7ioxCWycK7NIBMx+aN4Q/9JewNWfR2mSIcxupdnYUiZGqHHDLmxUbs6q2/j1Mr87idOrYe2z+aIp2ipl4XviJTTPC3QAKEF1b0Tror41+dZyBe1eWyGEyoU+FagTnsCuYSzjduPJwYh4UELlJIEW86RwBIxGykFrih1wpvE/fPt7ZbdrInFdS2I9EzLDe64LZFaXKDVKeU2sX1ZSR022K3vb2ovF/qh89Xop73kfLlBQl2jNtZz6IiT7kpYqDy1qNysUvYrcZ6Vy0ay/2y9ivKqHY3+5F9k90yAZTpkwl3Zo1vhbuBY11miGlBCu3etQF9kci8sbxOYjxLPrLq0F/XLvh171QMyrV5dKAhlzqZx4ozub2VXo9FTcM2AxIS0SnHXgLakZiWPEB/UnFSmsBHICID16YhcW2dNvVquQK1tnsA9VO1NTC8jzSrkpMsXg5gBJ2LKdAw4xNcEnkNMKT6ZH4ciIz1KjBuqEboU1KxoNMYqfHbXSxDpwkIVkeDRm3NW2tJiaAoJZPKPIvE0Ic/r6q/w+ghi8k0Kq7el02JX+z9aoVrqvkuITGdqLq9Jow/nIKBRQQCj454X0zAI+xh9XqelIJ9Zmyc24QCL+hMXCiunrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(19092799006)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KTwyX8T17tSRgcf4W9ykENNTHWfZ2QaT9U0D3w1IOXhIBTR7nUQwULztk7lk?=
 =?us-ascii?Q?FmQKH/yd2RrLJplFgNuZNPU7fFs7nj0H5aI1H7myQk/af7HvE6CyjImjPWbu?=
 =?us-ascii?Q?tt/Tlafw3t8lFy+EpIMwsNKXkUzE9Un4TlTEHkO+U5dYfYdl1G88mgh36Kiy?=
 =?us-ascii?Q?PRth/EHCEQh27tl74Kfu9iZqWZL5YRjdJtaghj/d69EtyXMYGoJdVjRoDTI2?=
 =?us-ascii?Q?fheMuoNJa6q3X+NrDT4OwjEuHidT4aSELI2dZwAk7BMLL065jxykO+8neblp?=
 =?us-ascii?Q?AriDhU7mqjH8sJPBb9eiD5qAJbz5mIl524JzuzF8/N02SoWB5NctQybKmxfB?=
 =?us-ascii?Q?k2JVNUDqIYvmVCIxKysGfDr0RmEDYzXAqsk+ZJAbQCqoKMNMzXoFbaOYvq+A?=
 =?us-ascii?Q?nZ297zfNMKEUzJtiFHbXvJwURIxi2SmX3sdEcA7oTwerMW0AL4Ae28kHY3QF?=
 =?us-ascii?Q?40SXv05+AwWjV/5bTtLb/TCQhB9/LQlQ5L7kHE4/w3mbg1LbVCafh5IHbCbZ?=
 =?us-ascii?Q?bds3dEJJaW/QnaLfWfMeuHRea23QhcswmIaczT0s1pcfIh+MNbEUJ3O7AnfA?=
 =?us-ascii?Q?tEdLbMUk48rBXJPAy3ZZkCeJCF8UqKLOs3N9LSt1LeUaU1FyXgjhir99CcEQ?=
 =?us-ascii?Q?ryMrq/pg9PE6hw794mlBcInJ+tYfeblOD00aG5qwWbm8pV+ODxKk3iOpF49r?=
 =?us-ascii?Q?pEfnk+YmXAB9aJrwbsqTekpYheuzXfDSOttODcHKsXECFT0wzv4cMvPONG0X?=
 =?us-ascii?Q?gsvLsl9ykgvaSFenKL0SkdwPQ0Zfy259aMT2j0Ag37uOmLMNl2EVPCSnPzzj?=
 =?us-ascii?Q?Ybtty1GFELhvosoCBZcdvuwhTJvyh4QuL8sXJ7uJ+qmO86uuJRv7MJGqP6ha?=
 =?us-ascii?Q?xQ2w8XvLb/2ajn7Pad1upIStibh/SPG6L3hb3pQqCO9dVhszO/W6n0MWraoF?=
 =?us-ascii?Q?em1S5EzSLv/GM9rGyKhKC8N1P+qwRPzZf9lA6erlyJJKjzzww1oZFBY0ah60?=
 =?us-ascii?Q?XJD91HMcfKnyqSu5l6kF6Iq2T6WyXfCB8qr+pdznXneMV9vU3zVoOEjjN0Xm?=
 =?us-ascii?Q?JC1m9xKlofyQPSjyFuLUlNmrbmjuXTUzCLqx0YhS9sQIHD4k3NmKucVwnOAU?=
 =?us-ascii?Q?w6e1mXHkB11BlE12a1e3ug8+RP/VeXCTr/dOhyHZiqc6EyM/xTKnrVYWcq8x?=
 =?us-ascii?Q?tcpLGSqiVYFT4VVyq09Fe+TunqGhdUIdPS14lgsYLSzYV/3Xv4MtX2c8LhqY?=
 =?us-ascii?Q?6A44RlrArX4KVQEgUuuYc32mmkjHFoXyV+sEIRMQeyerxJuCSnC74CrNvTzD?=
 =?us-ascii?Q?Kd09mbqrnU5UO3R44eAI2fbKB0zOiUL6ZmQllmefp3MheSPkHyypQ4DzOPO8?=
 =?us-ascii?Q?LJ/amGpRNWCh5r2TYuXLitQGrBxKJ/xGqQFyg8wCjLyv3Oa+haS2a7jEm7SB?=
 =?us-ascii?Q?9c2Pw2xh7ctx5MH2HV55ATl2pR3xJO+7Uo5gAY3m90Fw7grbVu7dYWFcltrL?=
 =?us-ascii?Q?2ce8BRCDc2DrCczSWK+/PoXSo8njETlxTKow9I7Bnl+8QMTwveSZ901HMxDr?=
 =?us-ascii?Q?C8qeSRhcto4RzLkF7JyWeTYciAiS9Srdr0KPwo4WaMjuvz2TGbWB3SgFvQcI?=
 =?us-ascii?Q?PIDCi+9CP75ld977Dj8IMRv9JoYV5pnUMhPfr7PD7tlWEUXpJKE7mXIXWLk/?=
 =?us-ascii?Q?Po6X4HTcqUL8NvgCZ4P95l1XLOBS9zozQjaHpIT9ssgWze/9Qx48qpv4k3L7?=
 =?us-ascii?Q?UbS3/43JLLc1DEHFiq8lfylln3SCN51D3STB3KAaC3I0DEg/ScgV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4db75b-79cb-4b8f-cda7-08dee28a6085
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 16:01:48.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/KDm/S+GhazgghkqOdCUo0Yti8AGDrPaf/DwGAaUpK9EJv6+2OxJaVF1oyleb4yumA+ETGktyRtbezr42MfRGfUOPc9F3R3ewddFB4tNRZTiTJbZ9tNIeoPbfATfI5o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7358

On Wed, Jul 15, 2026 at 05:33:54PM +0800, joy.zou@oss.nxp.com wrote:
> From: Joy Zou <joy.zou@nxp.com>
>
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
> To prevent event loss during system suspend, set a pending_press flag in
> the interrupt handler and report the press event from the timer callback
> when the flag is set. This avoids out-of-order event delivery and keeps
> the existing timer-based debounce mechanism for normal operation.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v5:
> 1. Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS and remove
>    __maybe_unused from suspend/resume callbacks.
> 2. Use pm_ptr() to wrap pm_ops pointer in platform_driver.
> 3. Replace suspended flag check in interrupt handler with a pending_press
>    latch: set pending_press in hardirq context, consume and report the
>    press event from the timer callback in softirq context.
>
> Changes for v3:
> 1. Add spinlock for pdata->keystate and pdata->suspended per AI review
>    comments.
> 2. Replace hardcode value 1 with local variable keystate in input_report_key()
>    under suspended.
>
> Changes for v2:
> 1. Add a boolean variable suspended and PM callback functions to replace
>    the use of the is_suspended field per AI review comments.
> 2. Move event report handle to else branch in suspended state, since the
>    pdata->minor_rev == 0 branch has no debounce detection per AI review
>    comments.
> 3. Modify the commit message.
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/input/keyboard/snvs_pwrkey.c | 72 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index cbe44a38d2b3..970c7d65bd57 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -39,6 +39,9 @@ struct pwrkey_drv_data {
>  	int keycode;
>  	int keystate;  /* 1:pressed */
>  	int wakeup;
> +	bool suspended;     /* Track suspend state */
> +	bool pending_press; /* Key pressed during suspend, report from timer callback */
> +	spinlock_t lock;    /* Protects keystate, suspended and pending_press */
>  	struct timer_list check_timer;
>  	struct input_dev *input;
>  	u8 minor_rev;
> @@ -49,14 +52,38 @@ static void imx_imx_snvs_check_for_events(struct timer_list *t)
>  	struct pwrkey_drv_data *pdata = timer_container_of(pdata, t,
>  							   check_timer);
>  	struct input_dev *input = pdata->input;
> +	bool state_changed = false;
> +	bool pending_press;
>  	u32 state;
>
>  	regmap_read(pdata->snvs, SNVS_HPSR_REG, &state);
>  	state = state & SNVS_HPSR_BTN ? 1 : 0;
>
> -	/* only report new event if status changed */
> -	if (state ^ pdata->keystate) {
> -		pdata->keystate = state;
> +	scoped_guard(spinlock_irqsave, &pdata->lock) {
> +		pending_press = pdata->pending_press;
> +		if (pending_press) {
> +			pdata->pending_press = false;
> +			pdata->keystate = 1;
> +		}
> +		/* only report new event if status changed */
> +		if (state ^ pdata->keystate) {
> +			pdata->keystate = state;
> +			state_changed = true;
> +		}
> +	}
> +
> +	/*
> +	 * Report a press event latched during suspend. If the key is still
> +	 * held, state_changed will be 0 (keystate already set to 1 above),
> +	 * so no duplicate press is reported. If already released,
> +	 * state_changed will fire next to report the release.
> +	 */
> +	if (pending_press) {
> +		input_report_key(input, pdata->keycode, 1);
> +		input_sync(input);
> +	}
> +
> +	if (state_changed) {
>  		input_event(input, EV_KEY, pdata->keycode, state);
>  		input_sync(input);
>  		pm_relax(pdata->input->dev.parent);
> @@ -92,8 +119,17 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
>  			input_sync(input);
>  			pm_relax(input->dev.parent);
>  		} else {
> +			/*
> +			 * If the key is pressed during suspend, latch it so
> +			 * the timer callback can report the press event in
> +			 * softirq context, avoiding out-of-order events.
> +			 */
> +			scoped_guard(spinlock_irqsave, &pdata->lock) {
> +				if (pdata->suspended)
> +					pdata->pending_press = true;
> +			}
>  			mod_timer(&pdata->check_timer,
> -			          jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
> +				  jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
>  		}
>  	}
>
> @@ -151,6 +187,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	if (pdata->irq < 0)
>  		return pdata->irq;
>
> +	spin_lock_init(&pdata->lock);
>  	error = of_property_read_u32(np, "power-off-time-sec", &val);
>  	if (!error) {
>  		switch (val) {
> @@ -217,6 +254,32 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	return 0;
>  }
>
> +static int imx_snvs_pwrkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	scoped_guard(spinlock_irqsave, &pdata->lock)
> +		pdata->suspended = true;
> +
> +	return 0;
> +}
> +
> +static int imx_snvs_pwrkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	scoped_guard(spinlock_irqsave, &pdata->lock)
> +		pdata->suspended = false;
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops,
> +				imx_snvs_pwrkey_suspend,
> +				imx_snvs_pwrkey_resume);
> +
>  static const struct of_device_id imx_snvs_pwrkey_ids[] = {
>  	{ .compatible = "fsl,sec-v4.0-pwrkey" },
>  	{ /* sentinel */ }
> @@ -227,6 +290,7 @@ static struct platform_driver imx_snvs_pwrkey_driver = {
>  	.driver = {
>  		.name = "snvs_pwrkey",
>  		.of_match_table = imx_snvs_pwrkey_ids,
> +		.pm = pm_ptr(&imx_snvs_pwrkey_pm_ops),
>  	},
>  	.probe = imx_snvs_pwrkey_probe,
>  };
>
> --
> 2.34.1
>
>
