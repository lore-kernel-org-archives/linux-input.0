Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C113A9632;
	Sat, 19 Sep 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823417; cv=fail; b=KjkJ5dSpZxz46mVNpZHdIVke9izyHgJUGdYnoUqJ2KwBr1av7L9kMKgwjqVUl3hBqv1nH8dVY6eV4PUZHc0Hr+9sHfxHG4kIGRGX08dtSmVg2tVDBCgu2yyTVyG7uxtuF6n1BvdfLYbBXTpYLUsgmkxJPP3IVmhqdENqLVTkDVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823417; c=relaxed/simple;
	bh=qIe5nhs8egtOhB27e7lPOqNSwXFrNkqvlIdmK3yLfZs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZKuhYkE65O7dKzev1t6AYknQyvu0rSEJETwvcFRuaHwvhwVTT4/1ojuO1zrBdqzMzl98YwSwnztP7aA4nG0Zl4nuTLbWexzfMo79vmfVN2/gUoUQbrn62JV0gv+HzQNPy5MFHyxwxm1I/6K1VwFq8pip2+SfAjjcByOV/KZECmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=titfLy3n; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="titfLy3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs9Pf1Y4ZMifphL8OekAic7cYIpVcURXURgjx16F2JOJRqZoa5HlqCQB7k6rPsNHGPMT5M+D+zoqfCcjXJGVH0XLIvXYyOjtyMQQLlNt+CgebpgLT2JyJcFLaVNQpBlQfEwTUVDew/x/k8V5lyu4M1F7ItO+DZkIscHdJFPpQziCdIck2DrX6tmIXSaf4aw2Njy75gBU7o72/q8sNx3bTzlAZS/1S3dr3akvbjXHNXJj54WIoQ/VXTf675U6SPtxgqzm1CBzywtr6QIQFhMJCNF2X+pTm18Xm5CcW/VLccVvMmgAlO5PCgg+A81EiHSZz7HLB9uLSlq72Znoo1jZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt9o9I7TKNn6gnUvEg9G2cTJzAGM8X/MuNfwhbmt25E=;
 b=kUt4Px7V7Ye4Chdpy2zqMAXDw53+G/qr0qFk38bzmYo/TFvD0zzZsshmS/ZOudQJALmlVFIrTfI6irE0VwF5wki60YgzfKBDhoX3Hp7us87ubj3fDf032XXnBAMilYLU6ZANpnmqUhsIrFztGBrMrcdjzcWtNpeahJqjl1yEcEdAWIR+jQ5WG2HyfNcdsUJXbT0hy7YKP9hQ1FZxtzefQE7brtTIuoohE+lyDB551vPJ5OfsebbCPjKtnCpV8mk8Am1v/B6gO4M6WHUZOvHH2wX4BbCKMCHzqq50FbkPsb+TAeQ9W5QeHBvNeWN4uw8XtaKwS/lYhL/x/oGKdzVQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt9o9I7TKNn6gnUvEg9G2cTJzAGM8X/MuNfwhbmt25E=;
 b=titfLy3nZX1DST7kiy/Eo8i/RuXnYF0avM5ibX7yjSkoO3t7vL/+HloJLWieYr1a8dH1FsFOvZ7EtXRsRQWElrHIVBFVWwwM+D52LTPvvS7sKzS/bPIPLOn5bi9LM6nalRsr7hTewzB1Rk3SK3W/QfPCgsORHTVTB7MisJjVnP+R42sacNtATUO9Zw/xBIFLre/2VegdHtI2EFj/6GoielZX2Y1M2GBay8tW8sXlPRBHTouPIPj+4l3eyfB1gRXLTaCAVOtvX3lUT4+ZEmh9YaJa0+eAXUaA6hZzFV+qDaBrki6fv5ovYVqApPMvTgAFQ3hZTpsY56Vl7Kw3ZjlQ3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 13:10:12 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 13:10:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Cryolitia PukNgae <cryolitia.pukngae@linux.dev>,
	Kees Cook <kees+treewide@kernel.org>,
	Zeyu WANG <zeyu.thomas.wang@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ariel Silver <arielsilver77@gmail.com>,
	Donglin Lyu <DongLin_Lyu@outlook.com>,
	Alexei Turtanov <9alexei9@gmail.com>,
	Zhefu Zhang <a723356@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-input@vger.kernel.org
Subject: [PATCH] Input: atkbd - use __assign_bit() where applicable
Date: Sat, 19 Sep 2026 21:07:36 +0800
Message-ID: <20260919130741.3041442-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcd922d-64b5-41f3-7a0b-08df164f5681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	STh3rujwKbjdI1vscvgFCe1hinuef1C5PDW495wgSIlxIM27IEQYuX823VqLqgrHRdKnYv4JYRfdBzLocuRmn+L594Wfj4uGkfLNlQlb8sqUWG0WTi3+M7GBMXg44/YQWJECrBKf7xi0Yv40cKPP5+JssRHWWD4OmoyXuqrphZxcfn3WPsRiwXLSH/JreJ3oYKOkM58nf5Dym9v6h3wtPEx8181MpF9xePMbhhzMNUzB8isPrZwItnQ8Xp0UgqhQtVfLdhfh6RyX0zz1dKlAn9rAvNOR6ckaoVB/APPwYeVw3xX3dPkknHnx1vHltNoVCuCHKh+JGFs7Jmi2Jf51TVQV1afSpD8+PaS0Ml/k59HHrs9gjlyrQc2iGgBbVBsrgON+XQqIOmUPjREYW31pouFS7evfxF7yNl7p/1W9f5doK1URR//Di6qyP68D4nP/fI18K6RX5fyRctfy4oV62GCYFzo0L4Adbxm/rJQ+dwszU6pZFbG4e53sDYiTgofGUSqT/ceU34yUV7n+EeK3Ki9n0T1e+9ubS3TGciwnv/PhRt7bSkQ246B5LVWwkHbmoPbPy1DwULxpZaziPmKuPJUjiouUDHsKejwrQU0yT1Q9wZ65wdoIKYdusllHGAIqz1Ebhzd1h0wi1x5bUqCwyu/LXniTsX6SPQB1xe23sBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pdaWukBvMGXjIG4e1wZHI9ShIP9ymGPOVGQ/KTMDekBZdOVSvACfQDcFcFss?=
 =?us-ascii?Q?t5idfAZ7FDKaVp9n1UCCmj0RfhYb/UJw3oh9bkuRqHECSx5R+ql/s9KX2UQO?=
 =?us-ascii?Q?sXIn1rGll7K+ll9yxwJk8ifhFqg4VrUZvBB8lcEwbrcbOgc6WP/Lcwqnw5PJ?=
 =?us-ascii?Q?TJ8TaozxF3CZjR+OoJk0/V2XqcUupTD8aE1Sl9J0u7XrBpPPMqL/PmYanvas?=
 =?us-ascii?Q?6/uP7OP14N1EwjYhIUK93Mr3AHq0mmrcbopc022GWIJiPMLseKHSxavh4Sct?=
 =?us-ascii?Q?BKGU/qI1vDtD5ViANJNc88OAhjpCHIsQbo9AUQ30chCQfWTVbNgXIU1+PHx9?=
 =?us-ascii?Q?EYxs+JuHExplcpyS9K791V/rHU/JQbxuJxmRhoI1zJ0kBpYaPejiP2nEqzuS?=
 =?us-ascii?Q?KpcsLaiNk0Xs83Xl2M4mAgnY8MyjkTvozVnNc2xykNjiCa5EB0DHOs3qEh7S?=
 =?us-ascii?Q?L5wmfzmc01zcC8bmpXC7KSu3mKsghZslTy0jL/7EfhQ2i0H/re+8ZmyK1hpR?=
 =?us-ascii?Q?2jcpY/bGs07zb12j8/WINojQ6c5mmEctLNkyqC4s3G1UWwuoCNZ9VQo8Tkgg?=
 =?us-ascii?Q?sItJBlx4JwyJ9lUN9TnVQerkJNpAZQbx+Wfo+yDwlvF0VNp++4/+OvwenpK8?=
 =?us-ascii?Q?vSBYI4HSn1UDQJtG8AKOlFj3ZcnmwhPna6p35fqqoZbf2u6ZNiEpMTVAz3Dx?=
 =?us-ascii?Q?fIiVfj5+Kf9xHTu78XmGDTifpU515rM3FpmPWXNANTXqzNJUCEKQxwKFJymZ?=
 =?us-ascii?Q?m0cz9eqcgHTPLXPxVwcXPqPmbFQ2v0JeQHruKiBzg39lfZ0KTLdySqdU89sx?=
 =?us-ascii?Q?c9WjD/kOu11H4RW/6Wls7WHs72CoHCKsd0fY6GldxYD4g7G7nbnzWg9wV5vP?=
 =?us-ascii?Q?7LA5lxvXgmSz2+4A94UW04ciC9HMDg5lNjp6dgx8eM2BEolRyxKeryCauqKd?=
 =?us-ascii?Q?rsrYaGliTpFLmuZAoDz6KjQsCIgjPq9EVYnxlt8nh+oeVub5zH/Ru8MoTHwf?=
 =?us-ascii?Q?KkKeah6fmXvRv3E98K1UyhfSG2diO5jULnocNj+qUTYhtb6LIUNSvE0t300b?=
 =?us-ascii?Q?FffC3yJ4NXhCYb7XYwRw6d+IuXZIEEd2Qds6B4JSceHEKk5dH695l0tHffDv?=
 =?us-ascii?Q?r1FFMmzLD7tVeDVMPZUdTL7FPdvsHMnOsNccu9xZMWKFu2T/4jBlsXOmoT/J?=
 =?us-ascii?Q?bzubetkAaFn/F4JRUxOpoNSHxCtPSa+q4K8pmrL0wDI7pu5czUS5+PAfb5Qm?=
 =?us-ascii?Q?TsZlHVdWRbljmOVxGNjgcdRCfmJJfYQU7NHhFztNeSiQDHcMMCyMxYCs4Yfw?=
 =?us-ascii?Q?suN/+GYOQg+/niFN5p4eLBfiIixWCjPKI7CBEq2Nk49+iAKkMnDIa4U1haDd?=
 =?us-ascii?Q?EK+nfMfUJtZ9+Vz26BVV6/KwuqPCMpSOcOk9Y4sBwXNWwsIZ7rUbxtRu9q0o?=
 =?us-ascii?Q?ZCLHAgKj5/RAYhF4oWxOVMYWvvA3jnUHSADEAwGQoMUtrHta5PdJfG/qF0XY?=
 =?us-ascii?Q?p+THMAh+GPiKPdC54oCh+R6tX6c3y+henJng2isEiyqDKoAeMu7wtrUrWJCz?=
 =?us-ascii?Q?u2IZwQDGglEqgcbU3k1+kKEQGUTK/+GZrB9/BILHZ7lZlJ1nbAHnSB84WD0X?=
 =?us-ascii?Q?MxV33y21JhZx2SqhLxcp/PKAcp3+jQA3PyZHeiWchmgri5Z54paFPkVdLMmd?=
 =?us-ascii?Q?HWghUt7wkKgIpy7G2Ju4z5AbAi8qOli/GM0bYJbZ1uFbCE6cPNK48CoWnEbU?=
 =?us-ascii?Q?jpcPmaGWS3PUHAL3hhu5bjHrw/Sjkbgz6/zq+tJzt7wrAd7Gwyvw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcd922d-64b5-41f3-7a0b-08df164f5681
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 13:10:12.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsGP9AT7kwkEV1bm8uIq6nnaRPAB0yH77ot6w4zasTQkZiZA2O8qjgZe13qCzvjcp4b90YOPlWKQ8ajG3XbvX18Iy4NZnostYuif8KK+GsGTo3BOdRjFJSC/R3ZChmc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with __set_bit/__clear_bit to the
__assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/keyboard/atkbd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 93650c98206d..aad331914589 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -357,10 +357,7 @@ static void atkbd_calculate_xl_bit(struct atkbd *atkbd, u8 code)
 
 	for (i = 0; i < ARRAY_SIZE(xl_table); i++) {
 		if (!((code ^ xl_table[i]) & 0x7f)) {
-			if (code & 0x80)
-				__clear_bit(i, &atkbd->xl_bit);
-			else
-				__set_bit(i, &atkbd->xl_bit);
+			__assign_bit(i, &atkbd->xl_bit, !(code & 0x80));
 			break;
 		}
 	}
-- 
2.51.0

