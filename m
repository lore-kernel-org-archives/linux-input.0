Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038A2F8E96;
	Mon, 15 Jun 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534330; cv=fail; b=qnb2VPK4K9MCemE8A6oYf9KWAoof2VznLVPNsQi0l+HivO+2/ab85L04zDmAlP9ZNp9l26L9bBtW2wCZwfuwgd7MyXAPew4/NDAUcY4RFixVK9oizpnXPrjN1xp4eerH1jV9er78fEjdAAh3a8dhZw4J9SjfI7Hkfq5lPlMxxJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534330; c=relaxed/simple;
	bh=Qr7fzwQLTL/T4o/tZ35HggBdCmBmdxokwEAmmbR2v+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uk0zSR5SHoiDF/QIAq8iCfow9ILI7Kv6ODiWsVmgvChly6zf7wZYihyBExWHYczWYbBYH/XOc15y2nf3RvrVcpJLrT8/4tqHcEK6aB0fRRBi7yaJcGsddLdeDzRCkddqHZfeQlIcaSq0I5VqSm2Teu7sAUn0y73YCe1JjUMb5Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wt7w0ku0; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wt7w0ku0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USOiT6+AtNOTpKZK6k32kDTm4UFwcjeT3ssTYbBmoDzTjhKyWQDu6cqucUQnM63CRS9Psiq31sS7jdX6AJAU3Dhf4eAhXDFHNibq0vY8ergHcMF3vnqS1eSrtvpwF7vNgJ84MekFxiI3+qtNjDR4IBrAwxNg4RCg3d3H4iDSc2ZWY5BREZnOt4yzYOdNnAvk+kTa9RIJb5YZl5fHWUbGFs3DcmUY8hspspaj/WYs7bZ9rEHGhMJ8oaCRupXgJplasHdzLKdmrcOpnf0mpd/63ujNWiSYXKWi9yddOC3fHaqQYBAXoPb0mCIQqAT6yWaZM/RRR0iWTz665cX2dVdNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjFS3LVL1iJ4DZ0udSNgAhQU6iRkJxiPX1aZ8dlaDFs=;
 b=Re8hgFzVISnKPfbZypbC5Q/Fs0C59dl7uIgfilxTMrEgK787W7r+N7pzFdF9NiLfSUXFHKjiZghZDCUxHIFH5EsciNDxTzuGWn+PDXD8Ftkf+oUTujxJPN4LjSkXkmcLIdBo4OODi1X5+L/gbyDK9fleIemFsknqyusCiaR2bOKmVxh91aTCLSP3/Qd3IvUC79bUlDJt4OvJGUSMbV2uc22wpPbztTcZuEYqxyT2jxDvH2l6N698OJMKmGy1r7XydSWVUgGwg1q+bQtOsi5bOLzrTVNXX6Ilaeg/cvwy+XONtmMbi2Dfi2RSjtnli7Aek69dX9Gbyb44/noklrc5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjFS3LVL1iJ4DZ0udSNgAhQU6iRkJxiPX1aZ8dlaDFs=;
 b=wt7w0ku084ENzyEOVVlF9fquhu6ZOhebZ+d+KiETAm/cMB5oC1IOGVjTp/6xspZMibo9tLyiFIhvWXu4A/7HLoJLx3w5AjPZhvkSVEodg45k5vi4sTlVG6olbcikIkNuJRxBvhFaciD4yaHhooeVhFvcdpePOLU1oLrRJSVZ0klbUOuKij8iOsqQ556DxWT5uCWnP6BWFl1zupZoy9mWhZdstIZc1/qW/p2NlK5bJO9hneYXupaqHeJSyLEY4960DbeFndDL2uaHC54/DNbxSgEIC6IwDkSVheWGZAiau0bCkU/BQTaJXabhJFXf7wp+dZEdQ+7/jHZhANRhyIobLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9500.eurprd04.prod.outlook.com (2603:10a6:10:361::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:38:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:38:46 +0000
Date: Mon, 15 Jun 2026 09:38:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: joy.zou@oss.nxp.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v3 2/4] Input: snvs_pwrkey - replace hardcoding -EINVAL
 with original error code
Message-ID: <ajAOa9VLrNM3XMj6@SMW015318>
References: <20260615-b4-pwrkey-v3-0-9510b1173f6e@oss.nxp.com>
 <20260615-b4-pwrkey-v3-2-9510b1173f6e@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pwrkey-v3-2-9510b1173f6e@oss.nxp.com>
X-ClientProxiedBy: PH2PEPF0000385B.namprd17.prod.outlook.com
 (2603:10b6:518:1::69) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: df4e14b3-d7ff-4588-9e2f-08decaebce27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7z4ObZL6lo+HDM1elurDujRXwwsOL0nUoZxdNVsqBmGD6zu/qTT63zKFkrOdCDzVn/yQ9KqnycBot8dWDGmmsivAORIeKh837QMpwfqbv0FKnOZLETTggUH5qXGyjKVDHUmWgk/IhL1s633J2HZlRMRmLX7ldaO0UcYFn9sAglKeUVk49c2mYQYO/Av9Mvk9xxhulXlSNQUfq5T/a0pxzbmNUs9teVOJZyCqiStTC8PaCQAser6iX7s63vhICVwFIqg+f0aMTKtcKvhWIaBMhtnQ7whSDf/jjeSe7fk3RZ26ScwjYjbu48bl239Grspo9cK08fivRdgNZYFqCEmReP1cDn+Dfs+gZKwGhbYDjn3McDToEwFyTbwEqv6/LXC2u7fl8TgRW4YnAFKIvAos3dlEq22AdVrAMeP2CNW90bpT9bHr1fiHW/huSUVxBB2BMu6rYqs6j9NzG+d2f7PKoyTAbNrq4H3V87TTG0jicu7GozY+q6aWnm8zXPsQKIh9/rz5JTA2OPTrVzywwLMOmc9KYTmQnFznX/z5C5kMBSrHAQ3UKteJ58rB0KK2zGyzuvLDVcR7KnCDDxyzgZEZ5Rstg05jLcj5kIx8LyTCe/J/kfGXsaeUF0SwqV9V3LGDratu2L2ZBgUgcojw0HyW4Vb6c5/Lebvg8b08XVLGvfzE+kMbK6EVYBngOM3/LYN6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UCFK9/9xqvwCd7qvnWQIQ+rXUCXpd+r6pXuaQHFIEbYrfgzTU0SwFvoB9cVc?=
 =?us-ascii?Q?1B7OHuxvfIcywfDXPvGkD/XPmERpul6yZEhavlTAnbtZcZPzeBAL4BQmZzFy?=
 =?us-ascii?Q?1gLYAQGWn4AxxSzuJRMFrHFZgDXWajMyJMtq0rUQiTS2eix5bTW7TC+/9dss?=
 =?us-ascii?Q?B6Wg01PoGUBZFuSGI3ihHORzMy6PAg/br7EBMS2VPuzrqzxsRpGhzCcL8p4o?=
 =?us-ascii?Q?Fr+U623vzaA23VKrONyeBLkvf9/8HSeCB20KHKHYd7EZs4thwL92YADvDx7Z?=
 =?us-ascii?Q?YXEkZwdmxsb8kHany9Zxi2gXeP4wPmD6I0Nn4o6YPHsu5MDPmIFAF7X3dU5Q?=
 =?us-ascii?Q?cVDRCOGPfQ4xcgVQFR2nBMuaTLPiWYJlj0TUcUKg5izoYudH11G1uPmpJAmO?=
 =?us-ascii?Q?+dcT3STnHsMZTC/6Tq/C15b/bHVH7c7fCC1SBsn9L0oQ0XFkO7J9eQbDrbOw?=
 =?us-ascii?Q?X4BZ/0Wo03pvEmKHiBJPVhypxD4lAZMf5wpm7KR9KBTb5pdh1yf+q5z7Fato?=
 =?us-ascii?Q?exTMo0lpZMNyvcLG/GF3FyUwTbCCwYNXwO+0KCLuEfT/nehQQcHhRP/t+6Jk?=
 =?us-ascii?Q?zXnw8qgGQFZ5+Dvy5pOpoQV4lDwOGdmcWkO+OA4b0A/K8YjnF/bUm/JN7HVF?=
 =?us-ascii?Q?Y5gnOUg1vz8mFr7Bbsk08f6nc2XhmjAJmqxz5XHh3f0Y+KThruR/GQV0z60s?=
 =?us-ascii?Q?Sx3udEwCDBWCWUbxcvgMHC1KG3E9RZmPdIMu+OjoVSPnz3mnUcZ/WpTijy3F?=
 =?us-ascii?Q?q6de5YYFRBIZ0s+3Uud3GesuuZ5XqeTTC9x3B/ugX/gVOkNUnD4WtoZ1K0TR?=
 =?us-ascii?Q?KPqcGRJunphBDGAb4yjia2cYdjxVum8rRsPgLVlNBYVTghuscH8vMxZgBwdK?=
 =?us-ascii?Q?bzJtIy0SbeUp+a/kpeEfPbFF/K0XzwMwgvU31NIj4Ctl+10tPSji1nKnSnTk?=
 =?us-ascii?Q?6nd9HSk7uYPnbcsEp0Itu+JjacOUpEEwN8elLNOEtgGzudFkJ5IUX1OxFf+Z?=
 =?us-ascii?Q?vsSAcsMH0XLqY3XFKKTvy8L1pO1C5rsNHO6+TnhML9zjnpHQxtdiVN5ou7vG?=
 =?us-ascii?Q?gDJ8Z/gBT0CBRDgIECG1JyvJLqqmTDE/yMT4JrYEPhWHCQ6bXcf+k0D+FXZf?=
 =?us-ascii?Q?XZ+geY0/U7XfTc3Cv98sQyO2gLgyj9i3OBGvG7xTbPa04/unejk+EdpCrN0A?=
 =?us-ascii?Q?/lEDs2eoI8eutN8Y7oC8b9+bMbAciqd7dLwuN4oFpXDZ9tY9J1ZYSZYXLgGn?=
 =?us-ascii?Q?YhDnCNxAarBedkdl1K2kVXiEDya+LV/Hyr/N4DhUn5M0HjmcKhVTStb88fFp?=
 =?us-ascii?Q?uhrEhGZMtrplz7N8hyzJB1i388dcusr9qb7xC7Ui/FOXFAJjwJO5g3ZOsNJJ?=
 =?us-ascii?Q?u6u7K9GlxddbVCEN2J5dOyWuR2HTQdHRL40p6kNZNK5gUw+VQbeulbcwD07w?=
 =?us-ascii?Q?ar8F/YwEyeEku6XZMbiWj6HDi3YyGfaTAF0GvVIjosi03UUeNlQj4JO0UKQZ?=
 =?us-ascii?Q?voUQ0aLgu4bwUHk8cSN47/5E1ojDpSk3P0I0OuQwi7Xyo64adZbQ+W0u3lLq?=
 =?us-ascii?Q?F1cYGDZw/sOJk3/FAX0uWkZghMvX0YmgapCUgIV+NaLyKBaa6fRqUcoYtvsw?=
 =?us-ascii?Q?joiucBA5w1u0DCWL8W4KQgJyqSOvdKAvF3Nb7ft0ANC8HbTnu63P6aznLioa?=
 =?us-ascii?Q?P9qj/8+8SqINXrBEWedtKawhKTLwC/oP45Z09OHlG5irsYDJibzNMCG70RHR?=
 =?us-ascii?Q?Num1/KGuMmZNi9Mzyiu8WWeCy3QZPwxBrH2fjRoRzp72LF1IuzEB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4e14b3-d7ff-4588-9e2f-08decaebce27
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:38:46.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHvEXUiTWojkPreVzLHz3f3sKnHaeYp+oMbfKHo9d5lrnX6Xi8hHJdyEz3UAcq97JR2yXwbR6UJB9wG62CelskXD7eulEfoAx5oCZB5Z6qjEyR2usO3a6VJzaGEB/yr7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9500

On Mon, Jun 15, 2026 at 03:52:15PM +0800, joy.zou@oss.nxp.com wrote:

Nit: subject

Input: snvs_pwrkey: propagate error code of platform_get_irq()

>
> Hardcoding -EINVAL discards the actual error code, which breaks probe
> deferral (-EPROBE_DEFER) and loses critical diagnostic information
> needed for proper kernel error handling.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/input/keyboard/snvs_pwrkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 748196fcce75..a291812e6d22 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -148,7 +148,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>
>         pdata->irq = platform_get_irq(pdev, 0);
>         if (pdata->irq < 0)
> -               return -EINVAL;
> +               return pdata->irq;
>
>         error = of_property_read_u32(np, "power-off-time-sec", &val);
>         if (!error) {
>
> --
> 2.34.1
>
>
