Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793133683;
	b=VDiLQnhWFDSWyf93iDHmoZjXmxzTgIGiO6oHxDNcBoCodhY3WhTF9MyPgtXihXtyOq6v
	 tnu84UwS4p2du9bpoWRTogom7LWTiE9zNvMpqpPpo9tIHs3OvBejqfNh/f5lkxMMS6hDU
	 zu83hzZAER2ABTuAim9aTXH9VMRt8QkiGESJY5DQaBm5xD2ur0eSKvds4j0HsyP67xTmN
	 /jXYVOlXDoH8nTyVrs+kSpykvFKN7HS8ug8NMgWfsFy0+C6io4or3syfyZA/24hiFeeOl
	 b9NIdk68xQa3lt0vGlNJ7Hu+Mldb6yUObcXrv2ryeI8MBUw+99G6dEV+5WjKjvLU2pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133683;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=K61Hcr3+CSDsm04TPuxenl8HtbiSepRTXRB6/hdyc1s=;
	b=XtX77vwAqvrLmhNo9ctiRRLd4fVKc3+cH6wxn5W+FOqsCckBKVEDwi+f++V+tTBRtvYL
	 zqd8q8CUH9xV/EId1Sqklk8DdUftwfHPdfihRmnEJFQMBR7FeZa+JQJhdIsxtgo9lNWPq
	 kquCgFu6tB6TnT+b9e4Q47vgchHSMAaiiSpNzT0HXj3ZeCd+VCAtdXhtYHD9NyZyaD21n
	 aqODbi7rPKpaDmXCCFIznqHCFACkndlkce3oAMypL9phjrybdkHkq6Wry25egun8kdqTc
	 L63d/zHOE5BYPt5FeqQc3JT33EDrZ+EE/qmMMiDxogIEb5PSzrM5UgzmnZp+0iLfsrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="nt3j8IK/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.46
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E7606A31D;
	Tue, 27 Oct 2026 20:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 517E7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nt3j8IK/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJr9LVTxGJUP4dSWgI4fQl9uzNrE04H/MZVETXkdKhyTIWtnDfrXUfN/w2k0+kkC8iEoNaEEkz4L+SaJv8L7fZ/19Sbh0xOwI0No+u9B9KHIzfWK/fgFEYnfLHjQsUSk2pI5VZKHQC1XWVsS6PatAhPk1MbICflB75SVp81jxXSsreOJp0bNuOwC+Mp1M59mtcjikVRQs6kmCF/aYzKKnogSWxj8+o3gURG2lcB054lApsIPtUvMgkB/8TXFm+1iGbFSP6Plinqv2c0QNSncDwL6t5r0AN30RG4BpQ4dO0NnNOxBBvAEkyQVl2wjz/ePpzI+fG4We48ZDyStGsHGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K61Hcr3+CSDsm04TPuxenl8HtbiSepRTXRB6/hdyc1s=;
 b=mx8CVk7V6DoCqVaDvJhIUAP07vJ/+/CYH9VmPXvZQaJsv3f7ga4R75sIBnQQTAFkBguE90ojLJh3JEf78ZHplaR+9KSZ3AHGGYBtZvlW3U2kCX5carm7RU1h89DXCinvYQSAnWBpJkpOWGxcCkGP/WiSffruv3F77GMAlnwdmFicTn3OPt+anRMYkYg6Kjgy6fO1PTZcaJhqRXJ/K8uNy3pX6fsLIB/Vj2gJhzBw0bjRRBqnL+MrB2hVc0BsWIo1yW04IK1llKItyElg7BfLi9vHoNNWTUIaSlOHAx4FLCultq3dzEXunevbnJfbckPtJB70lBKSP96v6qzvXz23Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K61Hcr3+CSDsm04TPuxenl8HtbiSepRTXRB6/hdyc1s=;
 b=nt3j8IK/IvvjLjslr2rSngtzc5kM0/mbGYvQVU+dm3f0Fpz5BlpE02ufeTpnka8vdj4KhL6JQSwax1I6JpQjsMRdHp8jfX1WNkhIOW5hdc4zSAWA0oH6Ea/zHsvmDNt9uGpyuaKgIujiDlKZeazZ4B+l7Jb+XpNtYMa2cNg1caeZcpDYFNyx8CtqjtdmLHWAUHqD5mMOmZfkoA0jMElvLv43DtaQJbDm724fMs6Ld5t0NguTUtTKo5EvlFz7Zh/EZsIN1GLRpaZBSux/OKjYkCDB+Aot8bsht8ksi+ugOYRdbJDH2h9a8f/Ictd9FNx9RUseMt0HP27czm/cJO8whQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBAPR04MB7302.eurprd04.prod.outlook.com (2603:10a6:10:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:41:18 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:41:18 +0000
Date: Tue, 27 Oct 2026 16:41:11 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: keyboard: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <auEMZ3t7wy_wVSrZ@lizhi-Precision-Tower-5810>
References: <20260821023951.53199-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821023951.53199-1-triet.hoang.dev@gmail.com>
X-ClientProxiedBy: DS7PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:8:2b::22) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBAPR04MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c7eab2-ee36-4ba3-5041-08df346aa6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	qZbKpQmlGJG/4ggAka3O6yd/h8xYrH6W2cM/bQhEuqnVTIY75wKbb2RD6hO1cWiGQLI62mDeGhPt52IFq281cdRIKXdvWZsoLT0AdFEO2bqsgRRX5mytSxu7LCsjN6yqq6pNj+ygpLwGGxRo7koLbu0Ba00gQZrXG9vNtSBaGrRtlQjyDItJOABPtsOaTZCuOt1ZVXTljvW675xcwzQ49ubHGOZgZXd/NPQeRie99nc8FQzcJdiXXRku5/9uNqpIBzA7t9XJW+SIXCuKrESm2t4EFu5OsLE5hAuPUT6vGCK5yVOlPemjDATpSV+EvbeuOh4+IktPkPrGzV5+QNjZYeVrttblIwjIHZaqjGFBPbUmKaPZwC0zp0khgPoLZpEGVEcCi9Q49hZryiK5CKSKmyZKOx1NWZATcRVIqrl7CLXX/smZn6ZAYjOhPSa+/wBSJJrgDWGXEAfILRmrkoN/86B4UHqsyY8TvotT3RVaJb0Pl9aSdE/7qJ2XvPvA7AuGWFY8ymFH+sgumvHy0jdfFpPqdG2hJ8RvuhQrNSRJHzFnh+9LUooneoiQvaIjtOCRp6Eumzl64cGDTfb7ZySZtCzjCeFDvqXhMJd8iJzcWRw4ag/gVZC/9U/EmzizDoPlZfuGOUqv8l+eDsk0IQeAeMff/hFSr/tPP3WRuAhFw/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dlnNVYfUObIpXwfx+Rs9EyqYgQOFvnb72RUv72csXm64w2GunuohaGyQltXm?=
 =?us-ascii?Q?HQqOp06s0Ycdg8UQDH/fOesIC1aoxvLTlfDUovlas1TbQjYgtHRWKGtX6ZDI?=
 =?us-ascii?Q?uSTczYP6AJ+oow4asT072KbOoMhcJVznPNBZUkDzPxRAin/hwgx38ws2tZKg?=
 =?us-ascii?Q?BoFk5t+Kjq5WTlOceNhsFoNCpTOkUjRFOnHjROW+qhbKVTPZWs0oXZwY4rtu?=
 =?us-ascii?Q?ob2ljUZoLhkARqrmaJxviKMC1+Hl8JV3w9Ute4pQudawswCk+q3Qob4HAOsr?=
 =?us-ascii?Q?CySgS5QrCk6RWFkz3KCvBrEsa1gANsV32vvdp0oF7h/qVKbgsHFLlZSRYz/o?=
 =?us-ascii?Q?js8jm1uyH8xZwI42w+wgAaeDkT7Ub4H5Jwdypz2JzgBbccUsQDd2+vK8ZZ6U?=
 =?us-ascii?Q?koXgrnCfhCqKvS8ENwF9/ZBy4L/22/kAmhUST/grUsSvsXZzp7moy4IiIzgJ?=
 =?us-ascii?Q?ORLcmCndug7Iq/5kkK64gkUCngSdUiarKIzJdsXoqPb5w+icxnevYt/UC3Be?=
 =?us-ascii?Q?V4f6Y2cAtb6jON47exuRY9IWUzOfzoDHLGGRa5uFe/ErMYNaR/AhHb4L9SEz?=
 =?us-ascii?Q?NqOcwgA8+Jm8FT7EGAbC/CMBckoTiVgtdw8iURmprMunRn8rZkRY51yoXn28?=
 =?us-ascii?Q?E/WijK34VYG9k0XsdgsHUhOnJ5MUpxU42L6HdmGzN8X4kXvqze9zpIoBNhm0?=
 =?us-ascii?Q?ir3xE1GMPzLygeWMF6I2SxqusRRXW+MnAT5JoS4E2sew4SOAn85ov74XtU4O?=
 =?us-ascii?Q?ZOEEG77bqDjOQgE/ovkwwWYwxlZvLHq6wPbRM+pvr1oXAJcG4qlo9wu3ytRf?=
 =?us-ascii?Q?byg5uw26DpWZa8FBMEUHA5jv+U//63gL2p8pGYQds4quiisoP/SxT+bBkJ+O?=
 =?us-ascii?Q?Nm2pTqwpRmlpjVBC0oS2YRyaJ3tQ1ympBPJ+u4phE3bBqUzYKy0BHFitt9tx?=
 =?us-ascii?Q?/G0bUDq91gyCOBEoaKFInKZyhkXQw2/lX2RyLBvYNFbl366IKwhQ1rItTxxw?=
 =?us-ascii?Q?FDb9QlAXJ8x8ye6H3FZocH0d+vQdBIFmgcnwBqoFkjoKhxSrPNx0YNJ3Vdwa?=
 =?us-ascii?Q?8GYtx7JEJYazvQEhxlJTWTmk+lXedEit9y9Gsm/M54w792t9jucHTZa7BrwS?=
 =?us-ascii?Q?LpwiibWbxUJaNe4wKONgql/xE7k7lsMOb1ENDNMLaGLu1PVsNZ3dEaw6Tk8y?=
 =?us-ascii?Q?HuMc3LcX8ntXIEuDxfsTsNirid6pkg+G5IWxQyFeu5CQ44Mp1EjEApEuw080?=
 =?us-ascii?Q?L8EEXXmjK7HU4j+jkGCgiiBICOqauoCcay1Y3qgoSFQn8fFNvhm05QyBr22S?=
 =?us-ascii?Q?as2ITF9YvLoqN5Mr3NiL5asgpspI17qvmogZnLp/fzm69631jOO6ng06C+rH?=
 =?us-ascii?Q?dky1x6ZogWFHRC6k6Caipx5CYiEM6XqA8KG7nd5HflPcwwy7NazxDs9oO2Fa?=
 =?us-ascii?Q?1CBzGfUHbEuHgb2tWCEETSYh5Y/8h0TD5VvpCs0CaTBJZ+sZ0FkBKS4MRBxd?=
 =?us-ascii?Q?9jIFxL57KtG9yL5GEAkU1lWERGsJCehixpXcy+OtKOxaCqUlwWlTDpvKw+8L?=
 =?us-ascii?Q?OtVv+6nxaSQU/MTSoRJKkGQ+SxAxuPfYD9vitQy6bgP8JfsiOw/iypC9Z8fo?=
 =?us-ascii?Q?fj1nDGtDihrqpGor2LYlay5xPvv2q+Gxp44j7Lg1+ZvgjsHJGuvUT26mmgLB?=
 =?us-ascii?Q?HqEtNtfPrpcFC89Khx/VoPyBv3Z+QPmfN7h9mHUobFFHKvq2bAuVB8IHK0OZ?=
 =?us-ascii?Q?InYvPeDKK8k6qSzv1yohT273UlFcsnzPyBbMLOXCelKJaJERaXs5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c7eab2-ee36-4ba3-5041-08df346aa6fb
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:41:18.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vQJKvD0lRyGBJKArOEu42Gdq6ugYdk25yl2HlmQi9Eq+VZte5fsAvSYpkpg/I5EhGIwDtjVFghwvlhlIlu9Bj+bmQ+f1xz63PNyif2AuxQwCbClielYPsuGSRxQJ2Qn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7302

On Fri, Aug 21, 2026 at 09:39:51AM +0700, Triet Hoang wrote:
> Convert deprecated SIMPLE_DEV_PM_OPS
> to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().
>
> This lets us drop the __maybe_unused annotations
> from the resume callbacks and reduces kernel size
> when CONFIG_PM or CONFIG_PM_SLEEP is disabled.
>
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/input/keyboard/imx-sm-bbm-key.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/keyboard/imx-sm-bbm-key.c b/drivers/input/keyboard/imx-sm-bbm-key.c
> index 96486bd23d60..7fbbd44878be 100644
> --- a/drivers/input/keyboard/imx-sm-bbm-key.c
> +++ b/drivers/input/keyboard/imx-sm-bbm-key.c
> @@ -187,7 +187,7 @@ static int scmi_imx_bbm_key_probe(struct scmi_device *sdev)
>  	return ret;
>  }
>
> -static int __maybe_unused scmi_imx_bbm_key_suspend(struct device *dev)
> +static int scmi_imx_bbm_key_suspend(struct device *dev)
>  {
>  	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
>
> @@ -196,12 +196,12 @@ static int __maybe_unused scmi_imx_bbm_key_suspend(struct device *dev)
>  	return 0;
>  }
>
> -static int __maybe_unused scmi_imx_bbm_key_resume(struct device *dev)
> +static int scmi_imx_bbm_key_resume(struct device *dev)
>  {
>  	return 0;
>  }
>
> -static SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_key_ops, scmi_imx_bbm_key_suspend,
> +static DEFINE_SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_key_ops, scmi_imx_bbm_key_suspend,
>  			 scmi_imx_bbm_key_resume);
>
>  static const struct scmi_device_id scmi_id_table[] = {
> @@ -212,7 +212,7 @@ MODULE_DEVICE_TABLE(scmi, scmi_id_table);
>
>  static struct scmi_driver scmi_imx_bbm_key_driver = {
>  	.driver = {
> -		.pm = &scmi_imx_bbm_pm_key_ops,
> +		.pm = pm_sleep_ptr(&scmi_imx_bbm_pm_key_ops),
>  	},
>  	.name = "scmi-imx-bbm-key",
>  	.probe = scmi_imx_bbm_key_probe,
> --
> 2.53.0
>
