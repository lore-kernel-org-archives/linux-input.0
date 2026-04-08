Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013080.outbound.protection.outlook.com [52.103.14.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1B3D646D
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668205; cv=fail; b=j7dUkWGdiNTT+rv/hM6sUAGFEWEkB+on/yiYiCjZZ5NnprWPkQwKfLodaKdhx0Pr55Xe2ZRPVGgAxryZJRkHuQYQ3dt91pXgwK5a5cdjcpAJg1+5XcSBbFrULAWbp31VJeJtCKgiBtjGs7XJh6A/Um72ASu/NONGsKcxHnaPn34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668205; c=relaxed/simple;
	bh=zAxF5EI+NuE1Ax6K4ILAxOS3tBhEjpoMedxnaI1BdyA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CvzwZo4HX9RZHyerB9gVKDfZ5WUmvm20nU8xI8AtSpe6I7J4Wdx/ymzHcHQMBsJDiyIYLMaZ0EWN4gU4QJM/x0IsKqZ7P2bLXpVpNCuApUfvyMPElztHYnftLoJuMKG+8p4+fb1dDleYXnS1SsGEE7etCoAEIFra6KhH/TWw1K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cxVZ/u2h; arc=fail smtp.client-ip=52.103.14.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cxVZ/u2h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFwOtGU6ghuWwOGuMJ2lYrRwSgRixL3H8jJ8cE3zgNTYvIdyedbo3ES3cud1peBtTC0AK52/c2TdWzGis7rlcyxsqgvyMDnE52LU5w8DOITZbKgRmz7IIQcdf6sPkIosYLHBLlTGXqOTNv+krdnuZlclnQVva+HR/+0hLMCQxCqwNfleRgNVbdAtEZD4MaKIXYvkzkm0rbQvgFOnymJ6VdBnX9SbkLmpOf6yrY9Rmt++t9T3ooh+d5/4V5k3DHrcs3/yavvAHsicrMIh7qCc+TUdR+paZ0Kb4FEjFLpFoROjdmomSyhzY7m6j1NG4flFOC84PzPtrtRbztciYCiwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUQp7+qbkBrkybPmxkK/gP8Tj3C2j8owu2wHQ6PdPkU=;
 b=XJzKYtHhlFpCRSCYFRKvOGyVi2yDKgydt8LJBqT7sA1p7KOfcQ5OAVYUESiZAajJRdDzX36hcwPNRLnmfju1pz5U5H3VcFcm1bJJHMBS81v0y4qKeM6hOhv/M+BuAkTv7f07DnYENQ/BavWBeWiWUy8uk+lhsMcETgnTc0r7BNNlDy5QIpx7KWkbUFEN8CPgWXLF9CmnlpO2mu4aUL4diZ4WaKBpJiZ+YOoMPo643wRTz5/0jYfACmNb/khDVAo8ckUt8UcuUPQmsc177/j02TB3Q4xINqfObXx2ZOyFB0NfuqcXOJdmnU6RsMLLuAGZF06/DjY2YK9g4svT2hhQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUQp7+qbkBrkybPmxkK/gP8Tj3C2j8owu2wHQ6PdPkU=;
 b=cxVZ/u2hL/hcVaPIxSVDHFLgrVK2GuW8ND6GLbp4BQExIsdblBuHuryGoU0xphRqXiSIMrAP1+LRpaSxPsnlWHB9owa4sWNCKjV1IZAzcplyD390oWsdlxvvoY0Y6/YM01Bf9Gk08JrnsVcD+JjRFe9eE07lQvt/6wlOgM30W62l3Dx634kG5L5L7Mam+kH69DHwOpI02YBhHYXT1dhqkVjo9nVFRZh4ww0lZbsFxcLcvJbhp3dZXe5xlt2kMdAbVTO6qcTfYMyDTTcuobStAMOilYm6n+W/8cCLVErusbb6Tkjas8pLMfDZyE35r/3wGfBqSEU/tbIn3i6jELUTcA==
Received: from SN6PR05MB5806.namprd05.prod.outlook.com (2603:10b6:805:103::11)
 by SN7PR05MB9916.namprd05.prod.outlook.com (2603:10b6:806:32d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 17:10:00 +0000
Received: from SN6PR05MB5806.namprd05.prod.outlook.com
 ([fe80::72f4:b6a1:932e:6f0a]) by SN6PR05MB5806.namprd05.prod.outlook.com
 ([fe80::72f4:b6a1:932e:6f0a%6]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 17:10:00 +0000
From: Roi L <roeilev321_@outlook.com>
To: ping.cheng@wacom.com
Cc: jason.gerecke@wacom.com,
	linux-input@vger.kernel.org,
	Roi L <roeilev321_@outlook.com>
Subject: [PATCH] hid: wacom: add new usb id to device table
Date: Wed,  8 Apr 2026 20:09:47 +0300
Message-ID:
 <SN6PR05MB5806A777C075CE7C870FEAB6DD5B2@SN6PR05MB5806.namprd05.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To SN6PR05MB5806.namprd05.prod.outlook.com (2603:10b6:805:103::11)
X-Microsoft-Original-Message-ID:
 <20260408170947.50916-1-roeilev321_@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR05MB5806:EE_|SN7PR05MB9916:EE_
X-MS-Office365-Filtering-Correlation-Id: 051c5dfe-e27c-4658-d37f-08de9591aa89
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0jb666d4gNbUtSl1tmNA3+UixrXD3yUxifItfE5Li+nZVEaVcCFD5hR/MdgsdFusn7jN2pMaEj9xmmhwsIUP5hxZHKWlUi+CARoF1QMiaelO7GNxRqvi4OfNPWszh1L/7jc8JC3AjrkiNaUSNp/4wgACEt1sX88cjgmrB8NRwIRpl1IaHGR9d+Z6ib/Xd46QH2ugw3LBr7Kb8ry2viPJ5hGAhPTzQfD5RLKDw8ByGRf0Io26gc0/YFxOH78PdblzkzHOmOCtOGrqHyzBhN1sTVXfOgCkxEN/tTROjDDx6jpG6/Za/fCZidyfNVtfdd1dzWMrzrtsULxWSw3Um41aOqCRb55/PDDEaGJODrgIkbcJeosZtQeau63rFM42loZQlG9ldeJqHYJfyzIcn0msKB0V9u7CREmzHIjk9C9BqKSCemOIB8YU45Wj1S1NnPH9BfNYuXKPAl7Q8gjg4H8saYsYslzaeek/T4gaXlCpVlkTP1HSSF1199PM0ESgExocJQ5xm2rLgTR6Kw5Pe38AQfnNGRyzWVct5G8QPUjZqqCNKngrsavFzECHkLcrDv1JhP7AgBGSm72s9RdlCzQtCJfJ6c3IHTiqP0oNEZ+92N40lVJ6mR2krrJMuI3qojYk97wa9qer/cNYlyf96/hS8H7yxdMz/J1Zljt5E8Mb+SLvm4I57RadtwXrr7+5K+oEy28JosRw0Mp8eOZi/zooKQlUaN4OwT7736iiRLnVA+9A=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|461199028|5062599005|19110799012|39105399006|8060799015|15080799012|440099028|3412199025|26104999006|26121999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/nz1GgYqUda/nZo43Ab7MeUGcgxTESmh/z9H1Qu0CfroiHkyNc1VHAnkqWtt?=
 =?us-ascii?Q?rzCjLXK13ABS4q0xr1+rTnkqhsisvhT2k3hw+QZUGVG+o2Ulx+MvjqvJawWg?=
 =?us-ascii?Q?XS1/Y6T40KdHq1H3qmu1ajc3UGhPMh8m0TyO6ty4s9Rwhr1ApuHYh18rOiWs?=
 =?us-ascii?Q?fPzAX5pf5L3mqZdtagWL3I/nk8TpD7Eui9SVpOS8kowklr2WjGuL80Fcx5ub?=
 =?us-ascii?Q?6OmpqNOTIDnHmf9iiBXOWKRet4OBiKp5qA375j0gMrJZNve1j9xvV6wHYt/U?=
 =?us-ascii?Q?DiDwqxSsYsaBR3JQJcGKojz7gPn9PorIhnKf4qiCWRFEzu9Z/AOaU7g5rKnR?=
 =?us-ascii?Q?pnGZjTXHGQ+bVC+lC6ZQjP81gpKgAaZ1WoukI4s3hugKeoaB+DX60rRQxzJT?=
 =?us-ascii?Q?FPoGEXrmLXlSlTHtb8WG51B1gdC5lXzIGpTZMkX34B9i8RzeiSkNDWt96huo?=
 =?us-ascii?Q?fKqb792J6Mw2zeZBkCIk9WqstewgoNTyompoFpBG4jtM5iBnvdqgXZ93Wfz9?=
 =?us-ascii?Q?wRtAx4Iyuj+KswFCZeWRL4QNdtuvIT3q3K+CByfuVEpYb7j27YkJYra486rk?=
 =?us-ascii?Q?ZvdxhIS/uVX1HFKI3dMn9gUIeo26qgGqoRW+tk4FyUuBAxNTrJTOy3gaKGGV?=
 =?us-ascii?Q?EHtm2AuEGwTe/H4nLq6scD5lX027KyU4BpD9HMcS0j/2jBUcFGih7bME43KE?=
 =?us-ascii?Q?0O7hEI83cqyh0rhA27qJEwuE7JiXy+FQkE/cHuOFK9BL0NcTSxISPjzIF6ra?=
 =?us-ascii?Q?VHz/bFe4z4B40Se37IMSU1kVwgWAigCz4ib2J+g0ffDDq19LRhPJwq2sY3zl?=
 =?us-ascii?Q?8I9f/k7VHw6YMMr2KXeGo0fnsImRxVHf/fUzvA+rgvbEe3BGg8lRAzKu5koa?=
 =?us-ascii?Q?CF/LIBCWm1t8chmUsLUx71+9WR/PbXPSQfIPuvA9EWVBFu4Xuldwe2gLYGI/?=
 =?us-ascii?Q?jN2KPwO9BXIv5YI/sEhMrkSKkcRCKB2gEOAj2CwhpLOBoQ8LVxeGKiWGF8Hk?=
 =?us-ascii?Q?iAun4F8ppi3PON94PGSnkdCDLA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efU+9z3eMvp67hSRBFPQ5j4OeerdDriqPoxAfD+ZTgsw31T0vvhhXT99+qoU?=
 =?us-ascii?Q?NS8BOVBAZFqhN2rgrUwT5jEvRhoNs1rDJhsVwF3i8hb1X11yqBEBalzGH6e0?=
 =?us-ascii?Q?Ys+DbnDCDs4PuteNUGmrz4dtb2Z8ISpdxysfMlUjMSiniP/Ye1qjaFnyoelm?=
 =?us-ascii?Q?GT+XhTo36ugJJC6jez+G+fi1ruzs9UrxKaUdv/rVyVlGXqtDcuNwvu805htP?=
 =?us-ascii?Q?94Gz33LFSaoFudZgPMyqw5nDWsP9NU9kzBo/EvOpL87ixbxr1GWr/N0DebPo?=
 =?us-ascii?Q?oxck9b9IK+D/6vbvMWgsOAlWm4sxYLiVk52lU8E8/FwGUKVXH9S/nfeu6meX?=
 =?us-ascii?Q?pxFGPuUIXTOkm1bfGNg+WvK1Dd48AcWO+QTUgDcyDAEtFbIDnyjkfaYpxir2?=
 =?us-ascii?Q?+KBppFGmA2z7LnlJVcqsp6YWbr5IubqvpiHL0V+ufEFltZaBanO1lS+7UQEx?=
 =?us-ascii?Q?rjAZEYOGzkri53kqjhmbtnaIg6OyumGR1mGPPCj9fSBAQ7DtYnoBMkqcUjZ8?=
 =?us-ascii?Q?/7Kqnr+U2g0Zi3t0fXf7gAj6LHKJ6HV/7hpN47aMxs+FS7O2uStTUJcg71kl?=
 =?us-ascii?Q?adk405knbsIqR5fK4DGSjXOLMpoazgIwiVPI5eVV89ZwfXtJn+8G2gsWsMQY?=
 =?us-ascii?Q?GjGu8HfY0z4HmAt5iz9UMgP+n96qioyWwvkpipCZCP91JDVq2X2bTveRamUk?=
 =?us-ascii?Q?2yJZyCYO5bGZ83iB0vltacZ4s3L/KSD5u4os0ocnNyYPoNMUFq02WpbH9nGn?=
 =?us-ascii?Q?9b+F0wTJzj+dlepRD9cL4OZZLr7AeWGBMVwjf1vmzgNl3mEOuthHHL58x2zK?=
 =?us-ascii?Q?wCewPCD1U6VxN6IN0BC6kmDp3xjAJKzTLqHRTJpGQ+KnXc+Tn9BYzb2w7L7/?=
 =?us-ascii?Q?ce6amy0k/V6AKBDCkIV143vIvc06CoUASOzOpjfYQ78qdDPtifOuZgEMiyyz?=
 =?us-ascii?Q?o1YdJJOD6Z/yy5QZrMoU6v4h/XlSwzq1yvd/qlXh0MH8iU2adB7aAYfvGyaf?=
 =?us-ascii?Q?tzsEEW2olx+8SOdkkKkH9d+dT0ycr16riiuqKozowq5eSmjOrJcML97OAKzS?=
 =?us-ascii?Q?L1BcZFPTeTxOKno+zVQQkyYcSTKRoxK6F1KsRaXXYj9aNSWmyAaZGAS+5zT8?=
 =?us-ascii?Q?mEY19LBkTSh6WHZZHSePYObw9mmtxBjeeJVcLpJ4IWSArzQT/3pgXVST2I6n?=
 =?us-ascii?Q?pI97AzKlDQduBACNpm7luike8ACJIdvVKC1J2hGQ31DD72dusqWFs+dZtzY0?=
 =?us-ascii?Q?K26l4bNu5T/SwB7UDrDw1D/h1YII2F211FTk6wAgL/RlIaJ7gNfrv/f1DUEn?=
 =?us-ascii?Q?x/3dVL0IuBsJ2xTZDYdJZ4zKhl2BGa44CbCd5CwaExiVuXFsaK/s34Z78VoY?=
 =?us-ascii?Q?Z7X3U8U2Uhcv0K/IulMcKxlfIgh5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051c5dfe-e27c-4658-d37f-08de9591aa89
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5806.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 17:10:00.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9916

This adds the USB Device ID of Wacom CTL-4100 to the device ID
table.

Signed-off-by: Roi L <roeilev321_@outlook.com>
---
 drivers/hid/wacom_wac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625..100f0ef03d1d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -5116,6 +5116,7 @@ const struct hid_device_id wacom_ids[] = {
 	{ BT_DEVICE_WACOM(0x361) },
 	{ BT_DEVICE_WACOM(0x377) },
 	{ BT_DEVICE_WACOM(0x379) },
+	{ USB_DEVICE_WACOM(0x374) },
 	{ USB_DEVICE_WACOM(0x37A) },
 	{ USB_DEVICE_WACOM(0x37B) },
 	{ BT_DEVICE_WACOM(0x393) },
-- 
2.53.0

