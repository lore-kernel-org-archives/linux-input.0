Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7063A5E9C;
	Tue, 31 Mar 2026 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953922; cv=fail; b=RCrnEbzl5wsiz5fIrdrCjXKYIPNfeQIxhagHZGa8pIAc1tX8d5YaPGMSukmKSZn2rmqKZnkqoG72xmHOZQqSzN/kCyDDjAeGPubBgii1pG+ctpGpOA/hJegTlGV5CwY9NNOA9y/X1eIE5uKVND5a21G7/hY4hceYe1KxUaVXxVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953922; c=relaxed/simple;
	bh=ntvbQHrh4fKnmeT1Q12F+czawbbZguXNqpkP67evBlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o4Mp5HDIMfqrlJNmtzoXoHgw4Exhy9QW2Lpvhq4wfp9pY0Ttxbagzh7FlfsHMe2/GE8ZqeIuJvo0jidsACoKel5H9dtZ8q+aUZtHs0/uqfWglNplXKIOpcOZsgAUMkd21hYgohGaP7nOeuV5qkVqoB0Ql0MKGmVGpJKEse9++AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PopKXFM+; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PopKXFM+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+glNBoOk69S08x/kuALiiZZB4hF96iD343cpyrAajMO4qqz8SFeb/jqDfcu9GD2EiVLAycWVq/jFw/SF7+obYjWhipUSF8OujLqPpHuUOEB1GMQJdvzdGZthviNwUL0bMMlgM+1oK5EwXROreKBWgDpDAlP87ggkjTjBYK4BvikfRbypens8CU3jkJ5Ed+MK4AaXL3Ej8/x0Vwl2b1JWHaQbYQRiFJS3yqtEAf6r+uAVXsHzdTXYDtaSbtRL03mII9ZJbwws9QNOVpbqIJmPnFIuNkx/zHiUVVYGCKz75wH+/N5oKURkKodbSDA1d14tZb3E04D00G6wkFmTj/f1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaDUkjW6I3lJ0vbgLnHSl1OqAEboOQLz2LCguNHZmY8=;
 b=FXy3CSZ8iVuYQTHFVix34tP93m5NL1w8mj0nSUcr/zmCuGptomklRJ6lRT/xJgX/xAd0PM/MzWDXpQMGvvHuSNizYccDjzNP05IrwOVZElz7oo1dBokUP0uavG6jOQiyRc1kHXObs1IdyTcjnqENYK7HUlU5HINX+RVc4nhwXIo6mc1kidtGQrP9eF5vCgH9pd7+8RBq3TopqCZ05G6h2jCl+Zm+v+4kmeiZTdZEuvp+XuTOjBjzin6Mpf8MH6EAFoz6sGVL/WiQj8nyx2ZgPqDpD2S/VX+a1Qum+XuHlLDPDjjg1cFYL9GG7Y4PJ/j2gwquh/pnSjg7JImkqDqslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaDUkjW6I3lJ0vbgLnHSl1OqAEboOQLz2LCguNHZmY8=;
 b=PopKXFM+GzstHcC+1KMhYRfcLpId+17wEZ2px1nQeiDvJJhP0PLZ4wCVJgX9evw9ZVB8K6qMZmH16Rf3ZHZZvPuuuHxlwfTwEAWXg4cawKgxj75g1nS+/Dd429aMIGj6gokZr46XKI6ag2UWyNb77N7jNYcB2Y+UQ0moO8rRIaF+/oK4zTuIBwGwiJSleafOLF/6LpvGgeh+QMhYHgFHFVAI8MJ4swDX1I1NwIlqkn5CJ7kFd/ASJVFU1HC+BMGvrxsIo78w7YHHwJVd1FsQBPEFtNgjrD1fyHayqCwhXhLIlYInUiWEBXhokH3qxPw+lBAWp5EB8qKxaRnpN8cDYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:45:18 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 10:45:18 +0000
Date: Tue, 31 Mar 2026 18:46:55 +0800
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: snvs_pwrkey - report press event in interrupt
 handler
Message-ID: <20260331104655.GA1415371@shlinux88>
References: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
 <20260326-pwrkey-cleanup-v1-3-d85d7c0bf275@nxp.com>
 <acWPp7KHxv9a5Az6@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acWPp7KHxv9a5Az6@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 196bcbb2-39d9-4b74-edb4-08de8f129958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V5v64JgKzj1L55ang4JPa2dqavgei9VOMIRfJgNGZiqVQ2wZ+czACgORcHXVTz5qtkDJfSVujYFuMDx75Xs8Zl6s4XmHqDiPO2ff+1cC0vG3W/9us5BXmmAwofg9dEX6z4dCfwC3L4bvRVoewwrNRLQVkF9wqz/3pomwMvDQOBLwkQwbeiEchdqlj2QoLm87J32MFp5aRibeOFFdop6E8aQP1tnxv4l8RQtzJTp1ZZTAl6RfynyYWdnflLzePoL/MXLN7KdIwXrUPqnshKngdxGkQa6c/xx7gxu2kQyK6DAFDxTstftP2X68TMFtxiZdUPElPoJDLAJ1lPq80u4uspAG09ff4t0JsDwki59tOgZY9CP+g1LDAW0z7LqN3OwbzyIarjNcCpBDFEnS4+AQPBITVlOAnxdF57JcQp3TX/PnuIvyvM32aga/Afe8yPOZt/6Oe996jgAogItM25qoE8+Q4pHTk12chtZOgmYuhtQuMriiyW+KhaPnkT3H5cqKrgu0gbdgACvfs0qorcpw8ZRAerJB2s8M9bNWXxDDkKDvEvVvIQuhGHLRBQsdReCEzRoi5HVjHDhjeQ05Qk9e0R1jhEVCqXI1LWpyQZowrT0ASSEEff+rIRvgYpalCbKFW5x+MQUjTiStuz9qiitcMHdUDSem+uJBSp1l1oDZD2KV9wUqvtkHQtDG84AMwc9lgtbrn2ubXcEIAO0gDwxw3HqrqzvqIfTUvZHDz4OHuLI3U/3XtTe9v3Pwcjly/VZaaupimIW6Ed/+VDiyDtDeLna/hLyD5npFTqWcXTFOxs0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XO8/e3eyXp6a1cGwR7fPVn1/evpOSHf/GQVmNrSI7HcgveIAXMj7U+t4hNRl?=
 =?us-ascii?Q?4TM6z0jaG88b+SImEaw1S43OkPvT3GmfMCvUuDeadB+dPQV3ZTtfFZIMzjWF?=
 =?us-ascii?Q?nsOvz5AiWKjqGmo03iZgkPAWS0/9XxodyhvtxyOFTtFi84ZN2Z2oYocmibyA?=
 =?us-ascii?Q?zCesN+uirhLTomzfjoFKOFsC/8DaW5p/b8pfmGhVDqm4IsaJA9F+dVZGhj7R?=
 =?us-ascii?Q?Mi3UqvC0m9Mf0o0wR8JFEahXN3fj9mmc3i4Ox4roi/8NFaLCewnHcDUpPG9y?=
 =?us-ascii?Q?gUVlhlzZxGP/JZzoGpspMQMMvHyPZx9LroRX9+6EN3U434EXs4s9Gt+0YARc?=
 =?us-ascii?Q?1r5t/c3I784GklEV3iMC5E+P2lUYuipH1NEAcDiU574q/qaHOl6GcQfFsk+0?=
 =?us-ascii?Q?ru3M9hWnymcFk4E03aUJJx+2WqU28GZNgtA1FRoekoFgf/auiLNv2KCcBAH6?=
 =?us-ascii?Q?gfm8ZisVj7UmsvGiU1KjPAZCbZgVtG2TJUYCY0qw5BJnUEeRffQYhuEboxso?=
 =?us-ascii?Q?hnCJ5RE/P91gYJXfHvws2UVN2HseyYdM18J99vn8MnE1qR7t+u67ts2W1QX6?=
 =?us-ascii?Q?Bw5pvTRA2HM2d6XNc4L7nslynp/9Ktg0TKUcpZpPxKQi57oL9mP5NU9+XhrW?=
 =?us-ascii?Q?8ciiq8RuKfD0RF7mD1f/dIpLr0BjdYxJHmpZVyduI9+PBoUw8DfuiwLdn1Dy?=
 =?us-ascii?Q?bFzv/pmea9d0be3KePPyyKa+/LkiacDuSCQOOcHnLoO+55oPclC6qv5D1cFq?=
 =?us-ascii?Q?hEzx+pYxCJFmYr+XJjiinirieOoW2T11slZanThGjL8128LjRHthbUnn8l6H?=
 =?us-ascii?Q?5Tsdq/zl+IQqnN4Jxjv+5OBJzxiEuufrcLuMTN0dyYEvUcWs2nJEKfGLx2XG?=
 =?us-ascii?Q?FRgdb9pg6gRZq0hFAByt7E8riGlt9/WGXiqmqtgpAUU6zSHvPheFvG6CDxyd?=
 =?us-ascii?Q?PpUolhtNdsLzai6qlqvL3GMmG9/cj4khUdTWu+04uf39zulvgxrngIW16mkv?=
 =?us-ascii?Q?RfLo6EhzmcSWWIOIFsPtp6Ap8wEMDgJll5tRWZs6yy/oqtWfIkfoJs6fngLW?=
 =?us-ascii?Q?VPofnIBtbDx0lO471mU2/79NgWKbNBIcbZzugARa/1sYFX3sz34LJuoV/wVY?=
 =?us-ascii?Q?irnHxIjUNIsYZPtHLIYKCoKu+W7R92eU4ekNH+e46M70+FX0uMeQfCtrXFUK?=
 =?us-ascii?Q?A9ZzIAHrZHTl47MeK9PKzLJg3A+xKtfk9phfoS2kaJYUMY01jaon7jnLJRVM?=
 =?us-ascii?Q?y0jO98M3rQ+fDsn5aX7B/FhG8129XouBppCc/WO0iHJG9EWGJy4kvu6qAYHF?=
 =?us-ascii?Q?kAx5/e0/ug7THNDqV/1IMo7hjsDASqMnF1iFT2yXo4dmYPM+LZK7cjaji6Fn?=
 =?us-ascii?Q?iWy3de1FTmf+hLRB/rlCfj96m52FSThAmV++MiPVcGgrx0Krm1jcF4UGaHus?=
 =?us-ascii?Q?HaEJeltynoeZgr927bIOC9tUG+y1hEUCZAZ5EdY6vJzOkJlVAQt7R3LiMDRk?=
 =?us-ascii?Q?8RiLVgL628DWXlo19wUxWCrs92LafmHClszOmyaRmg+Ojsy8OQlpMXkVaS4C?=
 =?us-ascii?Q?Y2yzWhZw36lqrt8bPZ7RyY+KTHkB03JWch/nkPOTvrwJvlc+jCMT7EaXtT/S?=
 =?us-ascii?Q?1Sz3r7bZeqwKqMRzFtGz0QN7F0Egf9wrF5JtOe6cQ/qb9DGWns0qtSXYWJSD?=
 =?us-ascii?Q?bfjxFLdfe8beh5LTa3el9K69fxvhy7b3a4KV45DcQGLm/v3f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196bcbb2-39d9-4b74-edb4-08de8f129958
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:45:18.1252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rL2pQCERIHE5eV0vSvMAsYRcq1wv9XYPuUG4uZkJXZAyp/zcWcsFgfAnvHoGLxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853

On Thu, Mar 26, 2026 at 03:57:27PM -0400, Frank Li wrote:
> On Thu, Mar 26, 2026 at 06:39:40PM +0800, Joy Zou wrote:
> > On some boards such as i.MX8MQ-EVK, the PCIe driver may take up to
> > 200ms to restore the PCIe link during the no_irq resume phase. This
> > causes key press events to be lost because the key may be released
> > before the timer starts running, as interrupts are disabled during
> > this 200ms window.
> 
> if irq disable, how imx_snvs_pwrkey_interrupt get run?
> 
Thank you for your comments. I might have missed some details in my commit
message. Could you please review the description below and let me know if
it's clear and comprehensive enough?

The driver implements debounce protection using a timer-based mechanism:
when a key interrupt occurs, a timer is scheduled to verify the key state
after DEBOUNCE_TIME before reporting the event. This works well during
normal operation.

However, key press events can be lost during system resume on platforms
like i.MX8MQ-EVK because:
1. During the no_irq resume phase, PCIe driver restoration can take up to
200ms with IRQs disabled.
2. The power key interrupt remains pending during the no_irq phase.
3. If the key is released before IRQs are re-enabled, the timer eventually
runs but sees the key as released and skips reporting the event.

Report key press events directly in interrupt handler to prevent event
loss during system suspend. This is safe because:

1. Only one event is reported per suspend cycle.
2. Normal operation retains the existing timer-based debounce mechanism.
BR
Joy Zou
> Frank
> >
> > Report key press events directly in interrupt handler to prevent event
> > loss during system suspend.
> >
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > ---
> >  drivers/input/keyboard/snvs_pwrkey.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> > index bab3ab57fdac77256be75a080773ea99372ec9c7..b557c1618d7369e872c6ce708a7b3017264ee385 100644
> > --- a/drivers/input/keyboard/snvs_pwrkey.c
> > +++ b/drivers/input/keyboard/snvs_pwrkey.c
> > @@ -78,6 +78,16 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
> >
> >  	pm_wakeup_event(input->dev.parent, 0);
> >
> > +	/*
> > +	 * Report key press events directly in interrupt handler to prevent event
> > +	 * loss during system suspend.
> > +	 */
> > +	if (pdev->dev.power.is_suspended) {
> > +		pdata->keystate = 1;
> > +		input_report_key(input, pdata->keycode, 1);
> > +		input_sync(input);
> > +	}
> > +
> >  	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
> >  	if (lp_status & SNVS_LPSR_SPO) {
> >  		if (pdata->minor_rev == 0) {
> >
> > --
> > 2.37.1
> >
