Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110C35DA42;
	Thu,  5 Mar 2026 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750279; cv=fail; b=ZheDi8lgyeXo3Rz0XznkObR/DSr5lQmEIOlesn2ZYEtOqgV+S6ANDboF4PT0hkhWtAXiBlZcDhSWcX23t9jJ3ebypOxceJ2XHzG81GkQkx/r0DIkjOOHz7mCQHv4kjsupAVGLDP55sU9IrGCly6b4tSfcnvwpONKV++tW4rqHAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750279; c=relaxed/simple;
	bh=dMyrz4mff1pNdETz+GLkMYtxaVIty7jIt1e+lrm29p4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pVPCOVR6sKZ6eS2MkPNNMvEsaEQzCsjwl14vbSDzj3NulYtn/GYL5rjuzRMs6UlyFwU6DBh+gMiOfvVDLes/i6LAAcD4he9PY1yi3CgLqDFLnz8GsO8cqd+UOn0Coh/WIJ3mzARDfuPllspNTpU2YmXLFyTBVZOy7+0+2iF0nUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MHwZvSW3; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MHwZvSW3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTXJzCEZhKnTkSx2dtYm4rmY6YvEP9x1uBZ6uMJRmfyzZ4yMJ8kUfMc/hhMbvnndCVGdf7QLcK4RcxDByxtqcyJjF2L4CVr5FxuLM6xT0VyxeArze+np1E/hNwiEC1MPrfPw+WlkHvcvmKBwnvApu549iIcIeDufDwucXnZRc9KB+NRh7rA4ogPY/WLARqldzxTNFIkYPnHcO62OXLgagpZ7glsP9TyogbZhOT9T0NYHUhEklk+yS+9CALeZqj7dpAh7ex/gqWho/2yoaAQ6nyKGFhSV0WT1cxmkAA+DWT6biLNW6gVHFYgKAOzcyH99NYmXddLrc64BubeRXJWjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXaZomh8yx18nEOeb089LNhAU43VS5RCMLEzQZTmAiA=;
 b=fzktvfF01lkHrwUgiK6l9CILCUcQ9uugUb9NmW39SaxiQWIJcmMJTzMc3e9Xo2G55nuKQy0Q/wocywl059kF+qamE8geet6uYJeyaX/WgfWbHvwxV8Q2z8asxMVL2NRegU9qS78WuVUUaxvCQ0Wl5ZqLCAARDThl3Ah0XcMcwqEvJBW1eQlW30cKm1dx7n+JasuT4GAJOVutC2KwTcu4EOZDvwR/XPeVWhTccVPF0y4L2GRM/g1Q3M9RqoGt0hx0L/ZvY1y8UwNzAw8CNGkYLDlVZxQRvbZfZCViJ7V3BF5AXFyYQlKfyNEVjhO9PdfK/AELHtij66zs4IYj+Zqalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXaZomh8yx18nEOeb089LNhAU43VS5RCMLEzQZTmAiA=;
 b=MHwZvSW3ZzFhZ9dJVJBtXEFCqVw1gBY7hF6s7198KiI07YInXMm9l+Z77sQgHiDujYPPL0hpRHhcyT/CCXvs0B20bnLGlJivg3sMLqmb8+b7oWJe3nRSz8SdlOD9J61NpBHnY/JaHMkxe29as5BL5XZcwMCf89208bjhv8G0hoaZD8kaPKWoybbdzOIncXymTywK+3ixV/icQ/8JSHNeauIROT33P26RB4qQFwjIHEs5mQHXsEMzkwUjVvqouNyEeRDFilHaqpqEyWFr2lgZzDm35rsRTbw3q6vZYUHq6GXTER6Dx62yppyP0PBjEVkjKxTeyQTCAca1TkwmhSJTTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11376.eurprd04.prod.outlook.com (2603:10a6:150:29f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 22:37:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 22:37:50 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Joel Selvaraj <foss@joelselvaraj.com>,
	Jens Reidel <adrian@mainlining.org>,
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: input: touchscreen: edt-ft5x06: add edt,edt-ft5x06 for legacy platforms
Date: Thu,  5 Mar 2026 17:37:29 -0500
Message-ID: <20260305223731.4088953-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11376:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4edc2a-5055-4e60-f4c0-08de7b07d53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	29c4Vzdap701xS/raOINErl6L/R6CcfGr5hOAwEvRT/blPTRKVX91+j8CXTdRUZdOvkIU2rxCHJ8kZa3q+Mv9/ddm3FHy8KSPt9vNmztbqJFLlCE72eRa5Eq2Yjf4iNQDjxormpxTMIVNohTSC7h11qc3E5LOX5NcGqSevHkyuEQPRGkU+oNbSK/8eA8CWHiPjiS1l6X8y2Uw//wqgYMR9BJvfL3Pd0ElK3l9XGZJUSiFCVMIosI8ZsscQCOpNQ3CnV6vgf2Rf5rTImnwwiEnoxWMhiJo9sLtPw3uGSdOpIlXTVAoxLTdfqfmR5vGki3qfAYSTV6wGEOA3vm7lqoP8Af20pf6TYHXIpTT/Si5On43EsqGjyL87ZZfjDhUxHu1bUPFszXPUCwefkdR+PSpw0tX/8XlBCdFqMIy6UqRI+15toL7KXGD9JELZcrMmm8x9QWvmy36/7LlwF4tNbBcsWOkAUA+eSrA15eGC1OwJ/Z8Dr6FR/l6ZXB1PhK0CtZPsowEbq2nfUHDMyhN0rH2CSOxNdxCSJfwAEFbb0FnekBwNje2G2Zc4Cn+oGeE+SODjCyhFMCMMA3blA3plEqi3hKXc9xt11G6xlTwQ7K1KwPrlayBza0LvngMLrJkN6FRZHyon4XpHRlPW44ieVqAYAPCjtMrAs+STzkt1ZLZvRtJXXUycIDL6NkXF+UrSdRhVvM/fdkuaMTsQaMsDaUG3HeSqPcYIV9q12DugN0NW/IZn+5mbTBO5h0vAB3/nY1cDZtfH6X9zw/Ll2NWa3EhvsxLlwd1Ez0EyO7uK2MlXv3lyTpWLm9zmgQkiG9h1wR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExNtaj65bU9Hw42kLys0hfp6ucs8/spstI9E7+O6OelGq3nWnjicuXj91oiw?=
 =?us-ascii?Q?VMpIVw65CTpPivcOYCw6Fw1s0bzW44nQyWlglmxlv0XmvjiJTlGeSJjl5N/F?=
 =?us-ascii?Q?gtM68bea1UpwkpZObtSzQ28nNhz4n3nVRwbpAU25/wF+k2L9W7eIU+nNjP8C?=
 =?us-ascii?Q?omwWWUBPwMqzikTK0w1zFxYZAbILaa4oWdhUkAfiLoyapx/YVRGbRoF7lT/G?=
 =?us-ascii?Q?103Oa2WdRULFxZjlsvRfkXIr+ABLXT7MBi91j/rtYw1gu7w8Z+UTXtDfksPY?=
 =?us-ascii?Q?HkSK245ofCPnAtJ+0SFjW6v7AsxA3QbvXaROTpEfL1UHA8D6wNbH1Jwqdi3p?=
 =?us-ascii?Q?xgVHThfLrra1xsB15jycPYM7J47C602JmiKB+FpbY/+8g60Ax9kexT6HVcUZ?=
 =?us-ascii?Q?RZjzZb24+vnoITJT99hPwsU+cA5NqCZE2Gf9EJq8irRd0zHXeQDYeoNHZuWE?=
 =?us-ascii?Q?WIa73KhotzUkJwvwAyvU8nkTeCem3J6G/SY6ILeSrgqhfQ1btG2sdE896A+4?=
 =?us-ascii?Q?Y7d7Zo2wrWn4g9JPKxjk85VpUqjmUrWM6tvACMMVI2bKwnn7SKnZB96qxaBl?=
 =?us-ascii?Q?Rim3vLji/BmxrlWMjPd1cuQc2fmwmwTW7POqF/oXJUEbitHZNRdBwYpy4Oap?=
 =?us-ascii?Q?LaWp4apfhwAQRh+8hLgpBbp8xxOjmOhKTQeyzee3ld5Gj5DxcTPLB2hXVuTg?=
 =?us-ascii?Q?5sUbelwFVY0FCEGRRVlUQqsT2vyG0MskD9dAM2tzCkX8s2LUtnYJIF+jfJKP?=
 =?us-ascii?Q?k++PqXmVsp9uYao/WyTWEOpXqvTrlwx93+rtsRrMP/YZO1lccfL+jJ7k/8RP?=
 =?us-ascii?Q?A5fY4Vs+e1wXYQgLA2TcsbpyEW36Zv5ApGl3yzpGT7/VVEG4ohcixMgxq8G/?=
 =?us-ascii?Q?JRHvzjk03O8zpTUxgSg73z7Afkvi2YX0us0bd5LXFC3m6zXdeJal3J+nJhMW?=
 =?us-ascii?Q?FuxUm1He8A2bTttDrPELLjscGcklRfx7JUwP2UdhianvoOdIdo065zRGjSav?=
 =?us-ascii?Q?rQTiRPb+16GGshPpZ4jX+0KqosPBapApUJPsnS13ARXdlfiIguhWn4lW/rzt?=
 =?us-ascii?Q?uQfRhDhZOda4HoCX9PeZpd6pu8aIniJmqeO9iIhHsIcxDh+xHpaHAW5Wj5xT?=
 =?us-ascii?Q?5TnGnFZ/eQBAHduZ0uOyo/e99ImlG5BBkRdDqsuQjvNwd8icRqgXODIZJqKi?=
 =?us-ascii?Q?Twl2/nEMJ2cZudW92/DeWuzZe53SU0bfCypgATqOcdo4rjUL+R8uv/GNYese?=
 =?us-ascii?Q?+wJTPvhZvyRVRkq8y2HVzQbyeIzyW+Mpl6v8q8jXmr9YLGFxNN6HnT7GBHGH?=
 =?us-ascii?Q?GZ1lSieSYPlkXkrjPg5kAc3W6JsY/YrSQf4Hj556BIqdLZKziH/2SegP0SSz?=
 =?us-ascii?Q?aq9drpE1dN9oo2CYqLOCS1sw3ELI+IwYrDJdI+tvdDQ722RUiSTJBQgqlcCw?=
 =?us-ascii?Q?AYCLRgaiRioUXiCKx0mrvC8A1WtDH1NP304gyUhjrQ69+SlnKukxprPRDLaP?=
 =?us-ascii?Q?f/LtTSfAoLWj2uwx3Cj0N/4UQ/SSeEFLrbmi/EH5Kbh5FnQPf+QNmetrWjrR?=
 =?us-ascii?Q?mbyJvu5ZKDnCKmup2gBDmXo4d33hVo27jHmpw8qyFDRxDwJLYNCkYqsErBZI?=
 =?us-ascii?Q?e/7PjVA5JhnLmTOwB6es2fx5iyrSEHZr2QvCDRsRVP5eLUWelmE9ftz2O/33?=
 =?us-ascii?Q?2t0A0q70rrK0a3eNuq6OrdYR22q/M0aj+x5l5u+Q7WwUQb1C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4edc2a-5055-4e60-f4c0-08de7b07d53e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 22:37:50.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyULhJ+4pdgmZqfi0F2PqjysJIw6bnx76ntDXg3PFuw8Mfom2loJj3C3uiRMMHJmPlAbFqfMrgFFxIlcsQTM2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11376

The compatible string "edt,edt-ft5x06" has been used for more than a decade
on older platforms such as i.MX6 and OMAP. However, it is currently missing
from the binding documentation.

Add it to the binding to document existing usage and fix the following
CHECK_DTBS warnings.
  arch/arm/boot/dts/nxp/imx/imx6dl-nit6xlite.dtb: /soc/bus@2100000/i2c@21a8000/touchscreen@38: failed to match any schema with compatible: ['edt,edt-ft5x06'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 6f90522de8c0a..213451f823369 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -38,6 +38,7 @@ properties:
       - edt,edt-ft5306
       - edt,edt-ft5406
       - edt,edt-ft5506
+      - edt,edt-ft5x06 # Deprecated, not use for new platform.
       - evervision,ev-ft5726
       - focaltech,ft3518
       - focaltech,ft5426
-- 
2.43.0

