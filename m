Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E69371066;
	Fri,  6 Mar 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824145; cv=fail; b=q05t9Y+TzSlLLsXV+UWIt4ZnsZAr4s/EXHMu2BynaPiV3EYfXS88ZrRCy2h0YC4uwbKz3wQPd3beXtY01HFEjbCbfculry1wP6PHMRLTlYrmc8pw6xpdP9qIZAgZlGJ+thx7RCK3QpwztX6YJxsIxDgHDpI51S7aBlIPM8/Z8MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824145; c=relaxed/simple;
	bh=QhNhYe3SB779j7MpHbAQ0f1iELSYQMsu8R+WS4KsiJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q13LdIWRkekpUvotSdvdV+m7TTLiPHFPfO+VUk9V7nnsSWLCO3A08xGQhiEC4xmsy7176bUjESHcuI/yRY9RH363d280MuJHEs6k+YvwVQS6lO99SLA/f//JGQpu4I4RI+N2icJhM78oIStJFOCvbvBdTBtUngagPf1RSlkQv5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MW4F7Qlu; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MW4F7Qlu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdCJCoOoEy9XU26Lv8/btbT1MQ87tC96CLdW7eAoxi9a1U42a507GlXhxIBIlo4p4wF5V0u39zI00QugLruMKZXbY3a9AtYtqQ8XiXP3sllb6So5zrDlt4x6N+9dmei4oSzgvK2/IiGKYRRmQ4kHbUQpmqtqXIh0a9ClMapO98CAlv+LfCCKBw+rGgG3B82Koxa7Krkp9FTOrpYoCzOQUD+umlX4X/VX8tLsjLV4u/hTB0+v9HFIYezXHJsacVzg/yPD5BucY33gXxxzxRTUYLsbXxz7BU/y4XaWgkQMxzqkvBoz93ceSiVu9kGzc86sl+QdLYRDoR+pD8rQy5Ol9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJsmNzzcsJJiNAFbL4HepZ9D+ruwYxuHpo4q4aneAUc=;
 b=uoI/oiPHJaOhhtkQx/LPlqvxJtjNeWeY1e6aZFii10xT4g/Vu/V92/VENcbgaQe0daiIb50XnH6M+js9mLTe4CQN4ZbdkNTzF9DzL197tuKvIG8GKiz2DaFribbzuLuv2vVJ7cgIIxLMFgx2IlpdGSM8GKIs6WkjskFeEsr2c6KX9mz7Rdprb+5Oah1kwC0ZyIqOovgivCwKmd/3K6mroMmu+jpcjn2hmbxquS5QFk8/RrlXRfj10z7IOgqF8rOkXsScOc1fIG9e30aJsmvqUBPNyH+rk4IsZ0Z/w0J7lYkRMvmaNGS1iVagLnlkukOk+g5DPAN07bUXctZ+J2Sffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJsmNzzcsJJiNAFbL4HepZ9D+ruwYxuHpo4q4aneAUc=;
 b=MW4F7Qlu0zBvJCAi/GWPwlK9j0VnkBvDAjWblHIWBYqlB4srDOgoapjpw/ROSXp3KH33p6Aj4LimUcy8ybowk0Gw+3k6oStiF6nlAL4dDkLAJUlFT1IGW36gtO5jLx0/Lcn8E/j4tbuxvGOMYYh2mPv+myGGocL1FcdWYR7YXf/MF1dbCLiuaNYTi7MICel0PrOctu2yGJmBJI3ZIdIKH4ypk27XB27l+Q9S9F0it/L2PQmVM9Mb+CiQObA4ZBpl4aSbQCWB1upuMV+K7llEheXtTMs0NzDpTfYV4VUDqACyVvW/zF/iU0zl829kmSRlf//WQD5QlogJSLrKkVgqyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by VI0PR04MB10878.eurprd04.prod.outlook.com (2603:10a6:800:259::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 19:09:00 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 19:08:59 +0000
Date: Fri, 6 Mar 2026 14:08:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>,
	Joel Selvaraj <foss@joelselvaraj.com>,
	Jens Reidel <adrian@mainlining.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: input: touchscreen: edt-ft5x06: add
 edt,edt-ft5x06 for legacy platforms
Message-ID: <aasmQiZJO2gSKzNH@lizhi-Precision-Tower-5810>
References: <20260305223731.4088953-1-Frank.Li@nxp.com>
 <20260306-wolf-of-striking-fragrance-0dee0e@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-wolf-of-striking-fragrance-0dee0e@quoll>
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|VI0PR04MB10878:EE_
X-MS-Office365-Filtering-Correlation-Id: 434af431-4d6a-4af4-960c-08de7bb3d25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	8R+Wfs4SCR+pIGXYQdZGsSexYbJmlet+bERAb6vjCKm8xABvHNBWWPMkybPqIwT8uQ6XKDwKKF8X9CEiS7ZmaaDMmaIF8XfY2LNaYxvXNIorERBBNgn6AIC9QBcFz7WlBo16M/vg/ARxGejc3bhvsiV0rWO6Nr2yyohMNx60UAAYWVpL9ZcL8ZmY0xL+vw7YMH3fGCtb2r5No1/v8b8Nq8Kncx6sUayvMzgyf/SCgJLBXOU6S/SY5SjvE7sechnv8lxLs5a2blTkdO+g5jg7/uXL5ToiVijXkM8I0jxRPdnHLNozylnyWkyD4itIyYCch9nKoOwjfTrGMK3GzeQR3o+5ThaMxyPA9ZqByQCTntFVZRDRTB+onbp6bnFVlahEpDmVR5JjwhQ9mOnv8oO4sc90eK325YG8/4ltpfBiBX4M9X/vGX6ATfCl/SNZDy85UAETAKOMvlkA9Axcr/zpew5pEE7gZRu98mqPiMfk4CfujLUA/1xSn3Z7TBTHZzx3BiyOGTfMlt8Acl/j6vhSw+JH6aWIG2IoovWBzqoNfU5vMRzhSuEiHny5BmCwDqaYJ8HxYx6n5WzcpuvZZPmj25oNweeTmc3cMMWzVIi/oPi6ZJns2i4KExSEHv/Xtt8x71o/3YsfsL7M9MF2or/qJxq1/fIa8PtEKcWU9TjVLXcoS/FWDKetWY3cxFuk71BjTkezFjOlGMnbt9/qlv0BDZI3Pvc/yxEWZbRJwqBiTt8SlH44PriO5wWy8e2mE+oPJ37pmN6FSvUqhoawMhXgNbSqgiQ/w0iqjEzuHv1QuAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x/1yZRq23XdNxdCAZ2h7KfohvAVvwSGY7EEKoFaJ+VjiVyLdnTuQDx0cD4Wm?=
 =?us-ascii?Q?LQ6nR1RTSEmYGZgPljexs4zRkjcNCDG8sL62Lhpsm+VOR5yJXVlz3csc1CAl?=
 =?us-ascii?Q?E0EcSXoL3hN3MXJvR5lEX0kLHX6ZzvgfgB15EOSZiLX9R6O0P24GexZyNnOr?=
 =?us-ascii?Q?8l1SNA+o2d431rYz1/Ny5gNngm/ZmcLln3/a7It9Hbeq733A7thR5bix/HAX?=
 =?us-ascii?Q?hrSz27PG32Bj3X81Poq+7nmxS5cnuwB5Es93veN3nqGn6ryRSzscl1XlBI8H?=
 =?us-ascii?Q?bel3B8XU0wqHAdQ4/qXPdysTigzm4gbecqVPelge2VmH8WdRibjh4BzBEoLX?=
 =?us-ascii?Q?2gED4VMoKW18ooq2yKImSxuw8rLUpsIZx1Pg6HH88GIUd79WVpHOe36bUbx3?=
 =?us-ascii?Q?LhSRuf+VPTjvDOqcvoP763HA93RC/y0MhHtPewegK7TS595CMZM9yRaP5ENn?=
 =?us-ascii?Q?WhU+Ng1VXJ74AZZunhplqUjxZ8jkwMYv8VwI5Kk2LMDezbQZPjroQuiVTUeL?=
 =?us-ascii?Q?ktZp8Bs4KQWIT/CkE8FxWffdXEkXOMa+r8+KT6Hz8OIAUD9AGNqTt9qEhQHn?=
 =?us-ascii?Q?8+jg2FV4vUUlBDABYPRMLR+JDy13MpT9ITUphtPeIxDQS2EF4gYs/2o+lPdG?=
 =?us-ascii?Q?SRMOD/v9lISbOomOrA8Ly2g52GoPJxxGAZMiOOauuEYNKnag3DJry+X5/F4j?=
 =?us-ascii?Q?EbNAc7N1DvLMqvaXWxSykJbYTtnxxywdGK+H0Sv4uPAI2wIz9y0m3cIju/nx?=
 =?us-ascii?Q?BctBNYk2pID4lRPO0vOI0z/02yvMWd9YK/8aYZvSDBbnL5wrzuwNxCqSeLh1?=
 =?us-ascii?Q?S0Iz3nWBXkvyHLWyQsEp8eWR+gqcjuj42TqKmZgB2mRlnCb6x9RzLInw5hZ9?=
 =?us-ascii?Q?t8aPrM0oM0v93hbTeGMiWphYJdma9wXRiJzoiP+mxVpAKxDt059Do4zGycKn?=
 =?us-ascii?Q?6Y4TuwQwuLOPlgNmnjwcx42FEIj962C/ISvBg3sD0O7JaeIp/T/cfNSE0+Nq?=
 =?us-ascii?Q?TwnU9TT9uVS+8YwAAwgbEYuzaI8F4A3m/TFaa6mY0KeCxNAtQs3fIjt2bn0/?=
 =?us-ascii?Q?5EZs54aMLv4nU4bf0MFiUNu0yzh12W7wYPiJ7ZRYAq/DYUzKa9AxKGpt08Q+?=
 =?us-ascii?Q?6BDWa4QT6ga01zkZiHF650pF5SNU7HWqGJ0mnnPCo2LbcTdip0ISgT09DElW?=
 =?us-ascii?Q?oMe13gwhMJc+jLn8DfGGCCf/7UUb9N7QrtCHs4yIxlz4TGiu6XAE1ypGNgzJ?=
 =?us-ascii?Q?CJXJXcs/ylSOAh/0la+7YTexVmGBLNL91Y0SkjWUYPxzHODGo4YG6AMUvNUW?=
 =?us-ascii?Q?+vmRlAeTMq+0jeQuhJT91wsL7RIYDqTA4APt5DpQYNygcHL2UT3Zvcnmokc3?=
 =?us-ascii?Q?KmpLB5FCXEcspPmEiI3750c3H52BZmqOwsIOcvU3KnV6ZpzrNYjRtiJ3yx/t?=
 =?us-ascii?Q?FH5wryAbT08+T3e/P8Y+H3yWEehGVaZw+tNGnfR4SPObjtZ/m61t8B5ObW1G?=
 =?us-ascii?Q?jTD0ycjJTk/Tvz1P9FNECg5ja9HxAVd7plsreARimSzP/L/NCLqJstITE8yC?=
 =?us-ascii?Q?GPFVSMBg35o7mtlQ/65xa4QCDSob0OF5pH1wDKNK2gOlshRYUUUHjjD2awQ0?=
 =?us-ascii?Q?ftIyXoq1ALOkU66barJVTqhNMpC0Sj35tbokggpGDAcbuhjP4M7IXRBM+6qr?=
 =?us-ascii?Q?sdniwRJgj5ttvf1F6fEuRACcxVQ5TYe6obvUml6K95YGVSh6P81X/3QpOW0t?=
 =?us-ascii?Q?SrPshMO71w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434af431-4d6a-4af4-960c-08de7bb3d25a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 19:08:59.6862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucFjb1cw8/UA8llE2lw42zC6Y63d20hq5LrRG8jSy3NCN0qhVJeIzfIiclSy3ixOT+nodF8S8EmumMAQJdyD8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10878

On Fri, Mar 06, 2026 at 09:41:03AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Mar 05, 2026 at 05:37:29PM -0500, Frank Li wrote:
> > The compatible string "edt,edt-ft5x06" has been used for more than a decade
> > on older platforms such as i.MX6 and OMAP. However, it is currently missing
> > from the binding documentation.
> >
> > Add it to the binding to document existing usage and fix the following
> > CHECK_DTBS warnings.
> >   arch/arm/boot/dts/nxp/imx/imx6dl-nit6xlite.dtb: /soc/bus@2100000/i2c@21a8000/touchscreen@38: failed to match any schema with compatible: ['edt,edt-ft5x06'
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > index 6f90522de8c0a..213451f823369 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > @@ -38,6 +38,7 @@ properties:
> >        - edt,edt-ft5306
> >        - edt,edt-ft5406
> >        - edt,edt-ft5506
> > +      - edt,edt-ft5x06 # Deprecated, not use for new platform.
>
> Then document it as deprecated one.
>
> OTOH, this above is clearly not correct because we also have
> "edt,edt-ft5506", "edt,edt-ft5x06". Just use git grep.
>
> I don't understand, though, what is the point of documenting it if there
> is no ABI implemented (nothing in the driver) and it cannot work.

binding only define ABI. Many compatible string is not existed at driver
code, especially legacy platform.

Go back this case, edt,edt-ft5(2,3,4,5)06 to use the same drvdata linux
kernel. Touchscreen is off board periphial, no spec said use which one.

Two option,
- change binding to allow edt,edt-ft5x06
- change dts to use edt,edt-ft5206 (I guess), which broken ABI. like
previous fsl,imx28-lcdif case.

Which one do you like?

Frank

>
> Best regards,
> Krzysztof
>
