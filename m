Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AAF29AAEA;
	Mon, 15 Jun 2026 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495348; cv=fail; b=qKZiDCHZ4PWW8dwfC3Kg0wV3FHHFwSQ+40xfiLY20i/s3bzdGno9e7BpyOpigSQvGjDQo5nRGfxtnMNiWk/73TBjbM5elYYmqD2dA2MXFdxtrKRtHRI27grzh6/pyArBzXPbzQ28ZGXF2FpsOYWgGDZkYqtMnOE7nYCC+b1QlCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495348; c=relaxed/simple;
	bh=AQZ4z0ky5EoISCKbZokz9wQ/1I8cFYeXmmgT5YRDXa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gup3wrlJfj95tU468YpP7ftefFs51hNQK6MuyoYdjJlXhH7Ocxzsu/6Bi4JR2IL7L2mtSXXfuuizYbhO5/D8Dgp9Zeso1glAspxJrey+BwT93AtAJbpoFvI5exbenUJZe0RIKgUmW+ey8WXLNATVHZdsUopO1Z90gBa/AIxEfQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FDYqEfVF; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FDYqEfVF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vf5KC3JTEutSp8JRKlipqmxXPqrXe6UT75JImfWWxEL7B6mng37SUgkOYvVJmcCannq2JiXi/MJZNHPDnvRuReJAPFUI+Vg9KGg4b0hJyrqRSEW71QOF0Lov238kym1WAZVURas3e3Iyck2vR6EqdIKXFNezXWyqOK+/g0j8y/LmqVSEocrX+CHgivn3owYm1kYpcYLqQh3/cnKKLtN5aCAA/vkWLhNI38wKASGnzhcQYWpheSXKj5k9XDqvLMY4kHaaRnPtwymn0cDFO8KcDfYQbXxKAhnNSrPogzo8vP4S7W48ZlRf4xh6hh4Wor6o5MTGSG957COkSJnRILnlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8pmyq0jg8Ra5Nzq+IpV5SEs3m2rsUfMOV3Xx/q+xXU=;
 b=qWn1trrpVTpwYKOINxhBmreqdAgdYMu3l2ACBLLM29VFxRc3lexQBY6FsRaQSj3Jmw4mgUu9vs93L1rUji0veOBz5yfC30J/Y824EzMzbUNh4CMT1eWRQlm/PLW2ZPs6N5P3nB85q3TrBe4MeKaTro2gR5RLEdpoXN7l1IzG+yyV7ffCEjnpTQKonapGJMzseiUGAed6a/SQCT3gK5lui1xDdKGAwccfausHzfiW+2qGl3iJ/evSso7QCNTT/FHIlfYmQ56iIq8BJCyLqnqO49y3UxNo1iX5lKcdHFt3C9xU3gEBh9hWrSxpkbfdO7JBJ+wYLY6E8Do0AyhoSQwBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8pmyq0jg8Ra5Nzq+IpV5SEs3m2rsUfMOV3Xx/q+xXU=;
 b=FDYqEfVFjBaZLnt5Y1cbXpKDGh4jtKayT1ZPVoLzhVQeUZpHgy/WInKbD2yHCINRbusQQKjx6Mp+OW0w8vwqibKmvsAgxUOqyn8iXMcZ8DPA4VtMiAueHOqZ90Xzhnsko+OCJrWGn5y9jBzaHDoaMdaxDrlA3yfnMJtjFTK4XrQK/4Y487eIRaiMHbZLmZFPpoDAl3eZW0Z4l5qS/TQ77aOgfplsPwPWSDjDhjRS5AEbFy2u8owlwaLBRNK3x+EhXZ6aXA+qnzua9id/unfzy1XHkGaxlfeLFTKGM04LKU1ukV3oJoBSaKalT62MXI2769jWPXV0ws5NpSho/Ak0wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 03:48:50 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 03:48:50 +0000
Date: Mon, 15 Jun 2026 11:52:00 +0800
From: Joy Zou <joy.zou@oss.nxp.com>
To: Bough Chen <haibo.chen@oss.nxp.com>
Cc: Joy Zou <joy.zou@nxp.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
	imx@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Input: snvs_pwrkey - report press event in
 interrupt handler
Message-ID: <ai924K+ixOZylOrB@shlinux89>
References: <20260604-pwrkey-cleanup-v2-0-59fa0ddf0d7c@nxp.com>
 <20260604-pwrkey-cleanup-v2-4-59fa0ddf0d7c@nxp.com>
 <20260605065913.grovxx53yzvi6yxj@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605065913.grovxx53yzvi6yxj@nxp.com>
X-ClientProxiedBy: MA5P287CA0177.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::10) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|VE1PR04MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4b3848-5688-4479-8376-08deca9102a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/g9U++bDYfE0yzXFlyvaRYqdu8uhYTB67BG6ODxdi/faV1BKzscKn3UQENylf3kuHKUdprtAOHCPGeH4qVwwhI16XT2AcYgpfd/MszFZ2PxeSoeZ9KXETmMC7SYy9qEUZ6zMaAcqEBDpm0UGoU/TauFHW9q7sgRgCN3FjfoQ0wcpSN3Nu3r4ANscBq8/+68QKJD7l+xzQu6pAbZwq/Ud99d0dDqAoL2Scror+FKgg3UXRQhltiE3P0c/8tz10JlnoXr7y0GFmiuFmSSmy/3C2P+h70hTXaCnKUelNR7hE5uimJb3JrLFPGCOAbwySIUP8cqfQKSr5UeR3T3iqJTevUxl1IbqhXgHUvbyCKGbM9gGEXgLu8eit8ISac9FNr0l+ntRClYFBA/ceVomBSWxH8zLloDTOShEYzeR3m3T6ZFH73a+JSoSe7XcTJnBZMM9IqnxBN2WmJRloacrMfFURjO8ZfPvMDhYKDjim+cdpxf7Gvr5XZTRcBhECnLji3kRWRlrVUwX62Fp42AicP5PJx2Er4+fmRaN2nUDi8xAxE6qkmYU0O7QlXhpzU2JMXE1KIMhj+joV57cCGj0uLx4xU6qD/QTk0hQY2VCfiBeQFZrB0iPKquXrCyveJ32/fXHZLxvd6jcOrPMyJTfEPXMnBTalr9mrRC8D04XZxIxMHN19mzqPBy2UiFW+MXAh2o3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3FLUr6wzJHlIbWSnZm8+GY5iHcfaKP4S6uDFV/xztJvEEuqYg1aB61H01Oqm?=
 =?us-ascii?Q?5J/PYCUiVM6ShysEGTx9OOz0zYrP4T4/kuAUq//QOOENrak4pbLf2ojlx5xU?=
 =?us-ascii?Q?5xWdcmCJpuJHn/UmGJzrW/PtSPIZXLRsxTQsWFdsEJRjAcs9eDDagrxXxBEl?=
 =?us-ascii?Q?iToSjj8f836kN+jZV+Rr9jsLkKAK5AjnSyCX4wV1UA3JGiu0iK99POFYquuT?=
 =?us-ascii?Q?OAdP0dZUVu5Slai4qJxg+B6gebKleZNpFTv8m5rt9iGmp6CVDWVBG3XIV6Jf?=
 =?us-ascii?Q?9332LMGXZvUDm9qCj9gwMUEYP4MN7/e5nPio775Pwulrrf78yoE4MZPCzhDR?=
 =?us-ascii?Q?+QKtm+Va5VdxfZmqD6Uqr84icXofsVljJcfcdzkqEcSR+2RzUkEKvaGk4isw?=
 =?us-ascii?Q?jruNXwUHWxbxAklqmI3Cv5kNdvphOk1tcEcERtAc29YWPsAReBlXbzcJrTr9?=
 =?us-ascii?Q?GQH4wwYcEo/DZI7FOtkUsHTa6gFbDX5fp3oC+bkegoT+eLDZ94GRiwa90h6y?=
 =?us-ascii?Q?tXN8yOEynEgUDCvaN3SUW4kybr0Bwm2deLcYsawhzyVhAClLNvb9izzoxS+L?=
 =?us-ascii?Q?290lobat/TIhdR+s1Mm0Jzys2ixM4+9ELUcyMFRUDINBrOr1W4CSsrxFvYwZ?=
 =?us-ascii?Q?+3TK+eQMvl2rD1Kr61dEp90XpyHw1b//9T2MAM5mBs0jrceYavpSkMs3KtA+?=
 =?us-ascii?Q?wWTKfSNjDyZXuNMRHLshS6isd6TPDlxDtGWoDDpNyxhMetQLHPs+isgCvRFN?=
 =?us-ascii?Q?BxKSFV81g5vjIZI9xCppUQ3y6dDs4ZZWXI7XTy1CRwbXgc+kthF9leTI0SoP?=
 =?us-ascii?Q?ijLCddyk4lDIUlDkDxmAfD9tLFj2gBE3xN698q/Ll+zRmQeLQT6SjapMrbj1?=
 =?us-ascii?Q?zF5BHNxp/hhSu+yO8E/TbRmYLwba9ZeDPgPXFmJ4TIYcg7SO/lD+lNxAIj5f?=
 =?us-ascii?Q?kUNsqJq1rYCFJ/82TiXMtfPN8EyY0QJ1E9F1STdWLPoxib8RwII0k1OuStdV?=
 =?us-ascii?Q?Xicag0pC1dANWGChNisAEdUkCUXqdN+pk5FCHUHQGncgtcTvVcHPtf0UypVy?=
 =?us-ascii?Q?xeV2NPo1fF5hb+ZXA8w7lej4rtqazE3dw1Kvx7jo4WPkXCBMbYy+4YDxagSx?=
 =?us-ascii?Q?ioJve6HX4LAWmT1mAIOx0MsNi4Yzb+CtmSLimBU8xjP7vql6y6scd8gVobpJ?=
 =?us-ascii?Q?KrPUFX22rda8CCJ152+EnofwrANHhtNaLaigHXVdUixsCKPgtlNY69Haydlb?=
 =?us-ascii?Q?hsDmqYewdadLwWDc84u1OCrXIbzuDCt1wv4GbNeKj0hsDvw3D7rqCunsJ5Bi?=
 =?us-ascii?Q?kItwoUvpSbEMv1BCtNWsMudlX1h3e1cbQTbgberlZx2yJ6vkDKXo/4o7nyLl?=
 =?us-ascii?Q?95yx0YIy3D0gJMrFXSxNkbC0hef+jNhRnzO9vRWp1aFQmqYga1GXeVRIM4Pw?=
 =?us-ascii?Q?4vOTXO9uU9yEPsu2uicj48S9jjfkauGMtZgoLhKqebDwWl45UChlS8j/djRu?=
 =?us-ascii?Q?eFZt6OrCiRKRsi6kHdkGk9aEVOgjIV0d+kYhWj9DKB7B+6wvO1o/6jxsvUBE?=
 =?us-ascii?Q?y/j3OHLwt/xc+1510l7DAhPG97AhWMMiQL/hDo5+MDSzmHWjHFd34VwEr79s?=
 =?us-ascii?Q?o3kY1r7bHJGxH0rdIW6SL2gmKBBpZ+Zc85n//okNQnWzREy/ClDk+C+JXCWl?=
 =?us-ascii?Q?mBAlLIA1ym/fGw6urSgjS+Y2BSd6q1R/RkRjKW+5ZgJ8EQTCTSvVO28bVI/o?=
 =?us-ascii?Q?PjoRj5RhQtU4PsKkJYOdKpJ4Vhmgl2oomEgnCI4e7k/1FZ5BDR0P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4b3848-5688-4479-8376-08deca9102a8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 03:48:50.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUDkq7hukQp+/76uNpwExHznYbYikkV3TfgfERcZqXhcwS71vh2FsxJt0jxr+WlDIskVI6v2YojKW3n9bmQuZzpF8O++T7T7ulVYPLskn9BBXQVZ+tWTaIgpQC89nwNF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261

On Fri, Jun 05, 2026 at 02:59:13PM +0800, Bough Chen wrote:
> On Thu, Jun 04, 2026 at 02:56:24PM +0800, Joy Zou wrote:
> > The driver implements debounce protection using a timer-based mechanism:
> > when a key interrupt occurs, a timer is scheduled to verify the key state
> > after DEBOUNCE_TIME before reporting the event. This works well during
> > normal operation.
> > 
> > However, key press events can be lost during system resume on platforms
> > like i.MX8MQ-EVK because:
> > 1. During the no_irq resume phase, PCIe driver restoration can take up to
> > 200ms with IRQs disabled.
> > 2. The power key interrupt remains pending during the no_irq phase.
> > 3. If the key is released before IRQs are re-enabled, the timer eventually
> > runs but sees the key as released and skips reporting the event.
> > 
> > Report key press events directly in interrupt handler to prevent event
> > loss during system suspend. This is safe because:
> > 
> > 1. Only one event is reported per suspend cycle.
> > 2. Normal operation retains the existing timer-based debounce mechanism.
> > 
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > ---
> > Changes for v2:
> > 1. Add a boolean variable suspended and PM callback functions to replace
> >    the use of the is_suspended field per AI review comments.
> > 2. Move event report handle to else branch in suspended state, since the
> >    pdata->minor_rev == 0 branch has no debounce detection per AI review
> >    comments.
> > 3. Modify the commit message.
> > ---
> >  drivers/input/keyboard/snvs_pwrkey.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> > index 4a1d04898482669894e9978014b62e4e9774b4e4..f212a6b26185d13e1af62728e7b2add5010adc5a 100644
> > --- a/drivers/input/keyboard/snvs_pwrkey.c
> > +++ b/drivers/input/keyboard/snvs_pwrkey.c
> > @@ -39,6 +39,7 @@ struct pwrkey_drv_data {
> >  	int keycode;
> >  	int keystate;  /* 1:pressed */
> >  	int wakeup;
> > +	bool suspended; /* Track suspend state */
> >  	struct timer_list check_timer;
> >  	struct input_dev *input;
> >  	u8 minor_rev;
> > @@ -92,6 +93,15 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
> >  			input_sync(input);
> >  			pm_relax(input->dev.parent);
> >  		} else {
> > +			/*
> > +			 * Report key press events directly in interrupt handler to prevent event
> > +			 * loss during system suspend.
> > +			 */
> > +			if (pdata->suspended) {
> 
> Here, pdata->suspended should not be safe for SMP system, maybe to use atomic_read() to make the code more stronger.
Thanks for your comments! You're right that pdata->suspended needs protection.
However, AI review found there are the pdata->keystate that also need protection.
Instead of using atomic operations for individual fields, I think it would be
more maintainable to use a single lock to protect all related fields consistently.
> 
> > +				pdata->keystate = 1;
> > +				input_report_key(input, pdata->keycode, 1);
> > +				input_sync(input);
> > +			}
> >  			mod_timer(&pdata->check_timer,
> >  			          jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
> 
> Here already report the key when pdata->suspend == true, seems do not need to trigger the timer again.
> Is it more reasonable to change like this?
> if (atomic_read(&pdata->suspended)) {
> 	...
> } else {
> 	mode_timer()
> }
Have checked the interrupt handler only report directly press event, still need
to report release event in timer callback. So can't use the way.
BR
Joy Zou
> 
> >  		}
> > @@ -219,6 +229,30 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> > +
> > +	pdata->suspended = true;
> > +
> 
> atomic_set(&pdata->suspended, 1) 
> 
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> > +
> > +	pdata->suspended = false;
> > +
> 
> atomic_set(&pdata->suspended, 0);
> 
> Regards
> Haibo Chen
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops,
> > +			 imx_snvs_pwrkey_suspend,
> > +			 imx_snvs_pwrkey_resume);
> > +
> >  static const struct of_device_id imx_snvs_pwrkey_ids[] = {
> >  	{ .compatible = "fsl,sec-v4.0-pwrkey" },
> >  	{ /* sentinel */ }
> > @@ -229,6 +263,7 @@ static struct platform_driver imx_snvs_pwrkey_driver = {
> >  	.driver = {
> >  		.name = "snvs_pwrkey",
> >  		.of_match_table = imx_snvs_pwrkey_ids,
> > +		.pm   = &imx_snvs_pwrkey_pm_ops,
> >  	},
> >  	.probe = imx_snvs_pwrkey_probe,
> >  };
> > 
> > -- 
> > 2.50.1
> > 
