Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325743E3DB0;
	Tue, 31 Mar 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966280; cv=fail; b=kKsXjtDZcY6hCPAG1M0WDqqfZROOqlIXfDwCjsmVeB5c3b1iJoPypp7pF2I+EICsXWpvEfNiFKrlewBWn2ffGet7CaBMvzBwutJN0QKFcoHNdL5Qv9AeR7mIEHi6jCbv/i1/iZrivTTqpSWShHm/2r4yIxl7nJPmEHUo7i//QgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966280; c=relaxed/simple;
	bh=iDOrB0mumEvI5ZjLaJvuoMZGlw0PARt2zLxdEbw4aNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pl/5LtBHoDxmTU8r910oonrdY4n/uHfYREfwMupBsFMphnYDLV+M60gt2dY+VI9wuINyrw/kOEeRIUtm//7GJ/xtw+MBxJwuCE/Cqtzh5Ui6qRfpDo/Oa6XxLnPppafEG82kYMRKg8T+MJNDA7dWV8fPYoxgXQ0TQ6Ji+TVNxlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hpYLoOh5; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hpYLoOh5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6cbqcPvTOfL/sS7qP6ZEVuoikV7h8bkWvPc4UhIJaVIv1RvBqC3n7NH3qX6n5DJqQ1L3jW5VF/t7qd9fC0xpDV2ReA9/UIhVtzVqVYUZFY+CmQbWdC74ZAMqORUB6orbRc6rjZr6nmJ6LGf1mzI6zc5zTPezuPOcvSOZxaclnw5YIuFEoc0nTbkwQtQbdwPepa1OKrGIHAiiOd8u0eLjh3NcV1U2atCt/aVoPSYHBGjjdBOvsKcYMEuuh1f53GY+qGFa2xXVSPTbWEyNe2sjYN1N1Iz8qMHom4xv3Fb49mzuPw2JqHnFzVIceFr/pVqZJ/Q6bNdTw8SJe0/4Ji+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxoYgfVHyGS6XPhXn1VNTT3fDHkqikurTqMCQ7BHCII=;
 b=T3/sFR9P3Vdc11xVdG4vMuZNsiPcZ+heG/jNyoeUEcB+DAuXw2tMWCGbQY31GrsEgnrgHCm3Fx64o7yiVHlcWQFkxL+TKhonnkDo848JPfS3vKASD5IgXsrvi9R+Muu1XSgFRyXYpdBYK7QGFU/Xh0lEqR1xJ/ZKkBPjhOkC55KMmXkRDq5SmiaY5PCWXzW9f0mua7/LFJ6iRtT6UxymWXE7ptqkx4lBKmKocSHFYXfKiD8RfWML8lFZ2k4N2OzYJZiQSMfQj/TXdHBqC0ramzDJGS/tImkdaVq4bJSPfa2Y5JPxng0UYeB3AV+HL5PrcAGj4/xH9dLUw32BcLm2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxoYgfVHyGS6XPhXn1VNTT3fDHkqikurTqMCQ7BHCII=;
 b=hpYLoOh5tpvDnn8Ff40QmskDihQ7Zciz3H3LLLrYh7Vt1/Rl7SsotP04TTBXBmlgsbIBU0n5n4Ho0RfD0w8KG9Eq2nEYBaXf83y0MIpXDLdujfiF4KgzZDpNVjitigPSezRbIyGf1Fe2NgRpGVm2/nWYjhqM0QgRPJZ4MpMv7u9qOeiiU6XaEt/MLqpmUdR7imwQ31iKgELlMDv8MdtEK9n2DBtD8ukPc/hnXWzyedwJYGPB0Jfa6OvvFNJnNrMXoi2EHlHa5pmLmvU5Ko1O6NGw6rX68KvKML6KZihJgcUKBQ9yV2Pw9j6SSqyQWl7nVe05gQ6F789SgXY419Vnnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by BESPR04MB12563.eurprd04.prod.outlook.com (2603:10a6:b10:ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 14:11:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 14:11:16 +0000
Date: Tue, 31 Mar 2026 10:11:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: snvs_pwrkey - report press event in interrupt
 handler
Message-ID: <acvV_Gk3UNUFEsUK@lizhi-Precision-Tower-5810>
References: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
 <20260326-pwrkey-cleanup-v1-3-d85d7c0bf275@nxp.com>
 <acWPp7KHxv9a5Az6@lizhi-Precision-Tower-5810>
 <20260331104655.GA1415371@shlinux88>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331104655.GA1415371@shlinux88>
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|BESPR04MB12563:EE_
X-MS-Office365-Filtering-Correlation-Id: 3775d1d0-13eb-4555-30cb-08de8f2f5f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Pl8qeG19P7AhtnMGolz/MeLPibkv4VhF/XKsi/Rw437C45O4gRXGRpqO2xHAmxIV3Y9SEcuuZ2Uzsu7//NIF3gch3iWm10uJKrZMfxUPaScGmge3TJDjiQNkVOuv48ubpsHiEduTFk6Ym2s9XOwVMesBB/X0hXnrkWCzNOTZtFIhlPal6NPw8J+JnDsfGNNI8S+T01Z0lAQkdOaF7B3RjTlkkKgq8mY9JwX+9x0oTWEJYhAYBfsUeFYUVWp83SEvrETTkxnAWmdO3F5GQIOLU94Tta/c+QatpXx8opxB1siP2AATFjKCMsbzT2zTLVg1WOfSWh3uCXRozbMHl1/IiMgctB6qc10zz7pJY9Bv3Y8wOu9vuHL6Mu+xQjgDhLT0aPzdUbzUxNF/OLZo2sYJ+0A07UZmTtTU2pvrX1ENyRxqfG5npLHQEYGoSpgSGr9I+KmGDyF1bVIQbsLDRJ0Go4w2oiyGmL3ADSv9qNqQXDBt1NeNHuCzx9EzXv2XDMiwbfDV83axvWvyXT25To3oSJPOxHZ/rE/1QLo4AchIhVOXfPIleP1VIGLIIPIPPmxrGb9/IKIWmOhwiOB8ZlKpQte9LPC07Yr/KZin0VkQpL0qBy9xEX+O2w7lUmeMtWLCa0TezLpWN+xaCPt2QDuWxg8S8+NfAqGSFLQK4IOxNKG4TCrZcorvb9g5sN/pWC92l+xqlNbVIqrBb/VW4SihdW2A87rFuYYdpEfOKB0QBov1sKB8A87lOlXM81U2UWlqG/3woa6LV/73YNXHx2vOmRnjhteWw1Jq2x5XmtSYgvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBnKERYAmK+Ewzad10nRviB/vEKEsZK4DjzGU6Ll8LMrLfLTiy/ELtwaXmeF?=
 =?us-ascii?Q?CD/AKuPKarXgK42gT8B0a4zVrx90F2ss18vVbFEAm1Qoo77a2I9dKC3ESEK0?=
 =?us-ascii?Q?xztaUSPdMUvve8y1cfzDLIjMUfuLV5iLfPHVFRaM7T3gLmAmdXK5tNMAzvNM?=
 =?us-ascii?Q?axhMCEIeibKBgeYMCxDUNbc1JbmbPvRXNXfxIr8R+QMfdC0YsgMZFzVccZNJ?=
 =?us-ascii?Q?cny2ITyvWMvqYTaosdMXY7cjM8lMOZTDTkHiNdXUTmXM0t2cqiBk9OkPDVJM?=
 =?us-ascii?Q?vDVzkIJocKKnZ52jwMOHwGYC0EPBHUfZB2XoLJMODfsnihUH+T72rg28lg6f?=
 =?us-ascii?Q?SmjI4LJziBZi8eaN0dIstL1LPuUNOa6yWi2R7aCu8bgV4iDUrspbVZr5qrC5?=
 =?us-ascii?Q?XSosDoK29Sye7GWCF+6CeqtPABUASqwxIvH+TytrguuTuVXiRQXBpCFIP/gI?=
 =?us-ascii?Q?Vf+i81sJ1EezXXF2qqIDIla76nzftkxpQy4DRGuVqD2MnYKmEiKsdbg/VS64?=
 =?us-ascii?Q?IDV4XgK1/v/70FtRESvbbBt04kF0qD/iZ0RXcWMXVQuoGlK5UK8NGga39M1M?=
 =?us-ascii?Q?5uAK24qIgekqjGkL63MbtRw+ErQUHUajaINgmMS9ehIWkXJ6IxPXl9gpj+HA?=
 =?us-ascii?Q?c4/9y7p7yFqyKpZdNpJ/eEJMcjkBBjxwyEZFbgUAxJchgB+rj3LjRAD/YQc9?=
 =?us-ascii?Q?hnA+MzHFMAzc5Cn/cO2qwREG5rKw3foBkoldI4/5ImPdDtaRYE8dmM7NaII/?=
 =?us-ascii?Q?x2vKtsKp6Rx1I95q0dKOVB/12KNN74vAUpCtg5YtmqL9JsbCkn/lpCHc+7f3?=
 =?us-ascii?Q?MdqWl3WrIx8AS7/9mJlpYcSXid0ZbcNDkZXCY5DBDWRhPwS2BGgKVciaW4oC?=
 =?us-ascii?Q?iIyXSlYkVZfGyl58kJ/aii2ol2Xk1oIiwDDQZvOE6yfkefPecj5A0sVe1jux?=
 =?us-ascii?Q?aa8NViOPgU9RcCTxzc5/3foI6WFAkclGJ+otS4+783JXiemwAgOPISxspnGb?=
 =?us-ascii?Q?3KKUqkbG/J2mI4mfNFYVHMi+aE5GCTOXgOhNbV08yH7cwQ+jR3q7n37EkRvQ?=
 =?us-ascii?Q?qNY1HfqA40ph2mnFezS/ntGssmAVK9U0hVKR9epQ076SPFdsBZudRk2BN41A?=
 =?us-ascii?Q?1/oUiXT7mZMEDnyP0H8CTGypiMFLY8AX31lXeyFBPO9vz4Ns30JRo1ky8zMk?=
 =?us-ascii?Q?2ydCe96EpwaqgOZoKmSIZKjK3SMRIJZ7FWCR4lXFmVVDof7UKfP5/q6+kEoA?=
 =?us-ascii?Q?MPWQAnoA+IHfzzpXc0Tvzgz6nRJ1owYZJNJZkQJfEElGllWolp9rMjeoqO6F?=
 =?us-ascii?Q?s0XjMcVSNFSpYi2tc0obtWVDPF3E6vPLXTpQs7paP9e5bno9yRL8Mc1NlJXv?=
 =?us-ascii?Q?uvmP1yWZb0G9vYKSj1qYV/2xN41YxWYx74PtZyrQOwFmKnAfsK6Wiolndp5z?=
 =?us-ascii?Q?buwFhbNVY2sJyQmmSWJ9mq/pWtdockWIrgnkl4eAozBqJGuStfmNGNeHSsbq?=
 =?us-ascii?Q?GVMDk0cJvNz1RoK2STrzrU1FvG31BFjg18IG0krll53yni07s1CCx/xLkVOg?=
 =?us-ascii?Q?6y5Lo02LJxu5FliH6fwcFSxFRaWuBMJdUnO1jTA47uLprJ5/+778VNyItZfK?=
 =?us-ascii?Q?5daxLqVqFMyNY9ExPSdUkUnZ3Kdipc4jaOopWlTxUIXkTRp8MmUT61Nx1X0G?=
 =?us-ascii?Q?CMJOR/vkYZMxgvlvNodpqFyGtCtNOvvIrj0HLRgSmE+lWBZH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3775d1d0-13eb-4555-30cb-08de8f2f5f3c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:11:15.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACuo7w0mD0lp/hZq6eN6d11Ui7Qt252aIFu/De08BaH0Rt5zfybuS/LGQCGT7s0CJYQN6Yh1PEy3GNFh8rHZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12563

On Tue, Mar 31, 2026 at 06:46:55PM +0800, Joy Zou wrote:
> On Thu, Mar 26, 2026 at 03:57:27PM -0400, Frank Li wrote:
> > On Thu, Mar 26, 2026 at 06:39:40PM +0800, Joy Zou wrote:
> > > On some boards such as i.MX8MQ-EVK, the PCIe driver may take up to
> > > 200ms to restore the PCIe link during the no_irq resume phase. This
> > > causes key press events to be lost because the key may be released
> > > before the timer starts running, as interrupts are disabled during
> > > this 200ms window.
> >
> > if irq disable, how imx_snvs_pwrkey_interrupt get run?
> >
> Thank you for your comments. I might have missed some details in my commit
> message. Could you please review the description below and let me know if
> it's clear and comprehensive enough?
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
> Report key press events directly in interrupt handler to prevent event
> loss during system suspend. This is safe because:
>
> 1. Only one event is reported per suspend cycle.
> 2. Normal operation retains the existing timer-based debounce mechanism.

much better. Thanks

Frank

> BR
> Joy Zou
> > Frank
> > >
> > > Report key press events directly in interrupt handler to prevent event
> > > loss during system suspend.
> > >
> > > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > > ---
> > >  drivers/input/keyboard/snvs_pwrkey.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> > > index bab3ab57fdac77256be75a080773ea99372ec9c7..b557c1618d7369e872c6ce708a7b3017264ee385 100644
> > > --- a/drivers/input/keyboard/snvs_pwrkey.c
> > > +++ b/drivers/input/keyboard/snvs_pwrkey.c
> > > @@ -78,6 +78,16 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
> > >
> > >  	pm_wakeup_event(input->dev.parent, 0);
> > >
> > > +	/*
> > > +	 * Report key press events directly in interrupt handler to prevent event
> > > +	 * loss during system suspend.
> > > +	 */
> > > +	if (pdev->dev.power.is_suspended) {
> > > +		pdata->keystate = 1;
> > > +		input_report_key(input, pdata->keycode, 1);
> > > +		input_sync(input);
> > > +	}
> > > +
> > >  	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
> > >  	if (lp_status & SNVS_LPSR_SPO) {
> > >  		if (pdata->minor_rev == 0) {
> > >
> > > --
> > > 2.37.1
> > >
