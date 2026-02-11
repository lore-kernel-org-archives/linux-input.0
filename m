Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BC3542E8;
	Wed, 11 Feb 2026 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846265; cv=fail; b=Yn74nDKpgAlaTkK4T/tlurBPaynYWG18hyavTKpJpQTmMxmRpz1imc9XvTMV2pUMYVypj2BtkUqiiKk8IlwN89U3qt3RHUz655JwPTG8zueVqJlJLUr0/AsPmZ5dTPbW48g+GoMjYBG4LAVl0DIH5oJDYoVRhMGzOLrfO6oN4g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846265; c=relaxed/simple;
	bh=1w+X3K1Br7AgjVqwDubWMmsacCVQHeCEuokQfzjy+nc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jwrmXZqbau2AkzqeJsUP7PkB1c0UGjOBnt+CxRnPXAQurCvZHP+ZOQQ356uJYfZGpLNhvH6l48Yf9krvJ5EfWF4eG27OAtfLP6tytZ8ZyPQPOmGTTxtHnJdL34wWEl8uHndd/ZYEzF+3IiMcQ64FJMyw8riXrOIIb/NNtUHKK6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ChwBLLId; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ChwBLLId"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8LOz4SUasyxpu+gMpU/ME8RAXrvx6do7Hzp8YLxVOI02BsxsMt4ykDma7rFWwJcxHFpXLV0hcAG5Y10pTpSuf4ZnB4J1C6OQwtKHASKV7nwYKzSsrsGV4cS6Qx7Y6Dt058AC2jSbGvyTxI5zndLuCKmEjCWvMAgXBkJ2YPke1DL0suSlmCj9TG79FkAu1CmTkGYTeTZEq7swvsShbEXqulBAEKFfeEf50S8OpydPtQOmc19LY72b+PBzj3eeSHtRVcufmJMhTniW96wQMzCBwWA0EaGyreM/ISYzjSfoy5AZu8aQCIfrlNhZEMgRq2bvNyPSbqCwbVDIjBrBbablQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui+r/KHydKaa3Xlpb8XKcdehLlDSZfrdsmJ2qltYhfM=;
 b=lnsm/oTCg649bNtQl8UVZR8/36DLN7EXoH9k/ozCJXs5f0oseRrvPiphUfj60W/MyoucwrMXQB2y60V39d+uQ06gsdQuzIAkhVMfNo3vAybzlrRS2DtELrXsrVpxh8e7IHFeYzFSq9liaUbmMMfhEFtxGdglg0vKhTE93DcJyYxuLuJ5s0PqQckirm7vuSQ/4sqlPkwRQ8YdPwCZ9x+fmEjN2DC1+TwSgfo4oT0HeFc7nAFGJ07xMqCl4+KOP7N9L4qW6kf1McFZcSlHZvBgjFGvL36y3mEm5TVg/ow6qDXG33CvgUG2XGUvcztoI9qi2mlhHDMLXg9ff2nz+1AFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui+r/KHydKaa3Xlpb8XKcdehLlDSZfrdsmJ2qltYhfM=;
 b=ChwBLLIdjLIav3vEikAK90AJdajoFliPF7+1uxUAr5APnxzlAvxwopInI5aXBaNOA9bfWMF5ZqSxgLLT1y+//MZm7btGyDAs6vcbXutdM0A625z7ztkMkqjIYG65YLnb3kYnd+XpkgWmuYpHQAgCHuZSs2BhpC4bsM4IxTyVevB4ximTUowqHbWH8YG5wY95tLNqYRxApKvAMJuYAFYqZnmL6w8guhIK/n0t/60D0mSj5P7Wo6Sb4LktyhUtMsa5Cw3rwQz81DnGmSrw6i1k9QUM2WL76iB46H2xSo+YMC8LlqRqK0yWyUc7bzGrIoWWFs99ixBBDrgs4jBMkXVsEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10717.eurprd04.prod.outlook.com (2603:10a6:10:584::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:44:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 21:44:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: input: ti,ads7843: allow spi-cpol property
Date: Wed, 11 Feb 2026 16:44:07 -0500
Message-ID: <20260211214409.3696442-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10717:EE_
X-MS-Office365-Filtering-Correlation-Id: 679c7247-0128-48f3-2858-08de69b6b76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lh1Y7N9Blr1HJJtdkRv0w8363xNrlPyLwpjDkjQMa6I7eDZpGYhoVkDkF33N?=
 =?us-ascii?Q?3qdy1hAQOOpxoSscXfP7XqM9VQT3qaL23YDik+ix2tarjTLC81nLmU6HpC9P?=
 =?us-ascii?Q?vzR8qTTZPYLfppCn08zyvS7oW5YNMDVuNFfZtg+5rxsFJIXnHrDL4E38ih8O?=
 =?us-ascii?Q?Ez2fJft1NbiQOx/j5cv3zeGOejQZ4r6jXK9d9KvWORbwdAsjIBsKOCaCAKpW?=
 =?us-ascii?Q?0A6HlPBQyE0XaCoVOgcSv2SnN4VRpt+kQ68XAW+/4mPZ2m8k4xYhnTW3BecW?=
 =?us-ascii?Q?2l2x6GtmTIcKzwdlKNgz9QMZWKVYl70Y8fgM171UG2/OA1Ala64lbBeiiuX0?=
 =?us-ascii?Q?yK/Vx8wRo5XWUFBgKMgzDQ29LEm/ibiUIQA7m+2366PWbDk0Tqou/qm3ArXX?=
 =?us-ascii?Q?yl22nqXLoiJxbqeXh36x/NNIqLO3IvV/tr0MmXLjdXm1LorSdz4oA611Nt/D?=
 =?us-ascii?Q?yOgR4072RKOMuQO/mqnz12GqQRBwGoUIE1mB7yD2qLHtWoamjs9uDurKihqs?=
 =?us-ascii?Q?tyWj/WfPAKKqmNCJNN2qs0+nnFXwVjYwAj6Zbr0kH12kXWr+Huy5tWmLsUFp?=
 =?us-ascii?Q?/3phgXZYoD6IO93CZbpkG9V8DeR9Oa4bYvfwnDPwDS/ns0yyQJ7Q1k9Azqba?=
 =?us-ascii?Q?igCfQPOZRUIXYZoxzj0+yO/WgxRlDKukoOeYoEwPXolxYMSvM2oqD7MXWcNZ?=
 =?us-ascii?Q?jdwZI/DForMV9QL8uY7e5sqQNw9cKFjkDDS2nPuTGjJa/FD826H4dGNiBLG5?=
 =?us-ascii?Q?s/H6r5rNegZP0k9crBBCRRgJ+Spm0v5hVerdRtMB4POEV3U4NYWoS3FcRwTv?=
 =?us-ascii?Q?HEaMFYG6V5uaMrbw3fpiFJQQIrT7cxC8uoTlnuHk5yDmThmi6PCj+Co8NZRo?=
 =?us-ascii?Q?r2Qav4ioSppXdqL9QFByLw3R0MlKnMRpADW/YcSB5THrS7fbFGPxIgj1Z8s2?=
 =?us-ascii?Q?NyFJGKnpcOvSRaUl0YPEKagbQct7WkMDEDUV92y/+DqpJE0YC5lBDyMNrGQp?=
 =?us-ascii?Q?/o03En8lZ7yRJkCxu4NYiXxOKbBG/LYEEEMndV+zCvQjxZ1mbW2rlccaqpvr?=
 =?us-ascii?Q?Vgq1c0sbQ++yFzgaLiZmclaUEwJ7qvGniBWIdipRu6cLPtU3BhZktLyajhJd?=
 =?us-ascii?Q?qe2a1/AQU7UtSUoAnzMWtEjmjFL91DRcLjAJ1Oj6bAzYPegfjDMbOcAGqk24?=
 =?us-ascii?Q?0z2iPyCA1qJ5S5EDTlylsrj8O8FTkwnBda4JfwBU6ZUMiSWeSU7hzyxGQ4Bj?=
 =?us-ascii?Q?TX2aXoocRuw3w+/MZPtPft3zo0XlCRMfPQkriIv16Cp9OPpLrbibLgWQIk0u?=
 =?us-ascii?Q?FO02GNM6O70OSxJ0z0aNGddJv6m6DVzx37WkU+lb3Zy4jQ6VgRc39RSjf8nk?=
 =?us-ascii?Q?EPpJznUiJYLQBdrJERSHlgrksgayWomk80/jc/jvDYkXQYSakqHFxqZuqbFI?=
 =?us-ascii?Q?Ir0XuhKmvsROtTeUnyoALOwMnvLk9nKHNtEAMjNwd4f8Dmd5GS+OgGlyikmO?=
 =?us-ascii?Q?GnQ7Yc/nvwiep8siVtHXZ/kWnEVz7mu8REExVsEX92INtu3hZTKC3BRn8pOI?=
 =?us-ascii?Q?Q+YZt0+8o6bMfePx2OiktGNrBHHLSWmMjH/gS3sJAxNod3CH2l5odWIpnbrN?=
 =?us-ascii?Q?3Mzz5rJVZ/p7EtOwgwWSyZJGlV8iFfVv/bD2ICGmvuDh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pXAa4a8jXELtkaezooVtemRnrj6H956e6xUBmyOl+leqI8CfjHao+/WER1lo?=
 =?us-ascii?Q?QKgx+Ma1n330qQOscVYj3/Heytu3OdgooSs/CurxTmBrPBp3NPAB0rRgHIU8?=
 =?us-ascii?Q?ii6KGxYucsIQt21gO7aBnrZy3znUgIIt+zdhjnu//nbipAlL02tZp/8t3NKz?=
 =?us-ascii?Q?RU1N8XAeS70xMDjfvbK9H7T9vBDksbsIKSsz0yisqkwdyB0rqO7I0TJxfXw2?=
 =?us-ascii?Q?kOEvlkEyENsRZfikxcwlDDh9Wk41bTVBVHr0GZCXe2pDRSWuh0uBDYcvchu6?=
 =?us-ascii?Q?ixU0jqJtVu4wHxkouqfmJ+deMkYmueK0/Oifb3xZ5jb0Y3YDUDWOhWO1ioTd?=
 =?us-ascii?Q?MMJVPviSbqyhNtzf8OuU/qzdbXARB1i8oMVFTBxA7hisjgXiax4iZgv7d6Cd?=
 =?us-ascii?Q?OGnKOo25AAZ7KRgzdvg1Jc6JUxIXpEpiiVDhLIucTNDIqDRq+E6feYJw3vJn?=
 =?us-ascii?Q?BvuikqVF9vSucKndZjTg2XseYKlVhT7MtXsVIXCgliNE7VWhfHHxWuLRXMON?=
 =?us-ascii?Q?swidtHrG4Pc2rbiI3FOZg2WwwqSTmwehIjj0/B+KQAcX9ozooyX3t5ZoiGzW?=
 =?us-ascii?Q?KbThrXOYKjnBqzvbgUXl8FJp7mXskomyVniH3YOC5DmWd9y5R1s2oDNhfMzB?=
 =?us-ascii?Q?EZOnOcq3JGki4+rmZEFDNt1gd7zyUWpkAsrNVn8h6PU4wrwDCMkVmUZVWYt2?=
 =?us-ascii?Q?W++iru50W1jFoywut9izx1TMWOiQ9Sr2sxbsuqEl6hRFXnJ/1q7gQq9XET+T?=
 =?us-ascii?Q?5MsxctIewWlkpWrjfzbeIb/BAm/xeOjQTdF7C7ghh4nC7mmZredH5aWPVvuk?=
 =?us-ascii?Q?ekwaGMl0ZuqJEd78GdcIyk9qi3CvgH/E2HHfn0R2Hh5cZ1m4frk1+wsjBu47?=
 =?us-ascii?Q?p5uV1m2A+3eC47NHOOOENM2neHTBHW5SXUa+ViDqIUr8b9MsBYSW73i+hJ/Y?=
 =?us-ascii?Q?oIwHsylmxLSE500JVJe4cbnai66Q5LFhbh7GIJegrWq4uTvrTTmd1LI5LDdu?=
 =?us-ascii?Q?deqZw0lzmb56Vc3T11tPL1Y74uwuexOiaxAgJs7csOLn3aH/nUhaISt9VYtk?=
 =?us-ascii?Q?gn61oCp+IeEbkd9NsZC829IoizYX0UDIgW3//MYYOkdLRB+cvGsuYWiD8ADy?=
 =?us-ascii?Q?dhf87LX9Sqw1SyqJ54c7n8nhocNQzZmfhOe/JU5LvKmlQo+RyQ1zz2GsdmIX?=
 =?us-ascii?Q?1z3C0IfQBBHGnRur1GSD6fDk6olCJH8V9Q8LFsvWuiaLKWG64hsGyUFkhIR5?=
 =?us-ascii?Q?VZxzceWsVPsVQeWHCfs4yUitKGZ1Nf5ZjSE5OoyvcCvXDcQNIk5swpu1ft6V?=
 =?us-ascii?Q?u9xZasoV6Bji3xVx3fyXrsCwyPmK5MrWKUV00mdiOAw3UvnWR0nqu6a3cbOM?=
 =?us-ascii?Q?Mogs93lrXafWBT81PBhzmGsjr5njXB8ix8pUyqWi3srQq5409S1hAHK85/Xt?=
 =?us-ascii?Q?OFxOCqJpHjuzfzmC6dqwHKroa9VampKRP4eSQtj/ni3GR0xTwe1sfcCOioam?=
 =?us-ascii?Q?9Lv3oJN5eb2pSB0B2e88eq9QCD/Z4d/2BW0Cz1rkf20/Xe4UwvxDYziQGhnD?=
 =?us-ascii?Q?Tlx2Q7gyYt0bD9SvlUthnpGWX2lZcw9MnEzZJ2QMQe8T9Yj1O4J9sFE7H0tf?=
 =?us-ascii?Q?YV2wVIq9kkS7Fj/vdntC944aU8K2IPfHXSE8i8HkMAdyagu2nnxknM1T0wFN?=
 =?us-ascii?Q?ChnCHQAps0p1p8ZiOeTubbQ9wWgyzBmuamL71jX1+qBdxWRCCwmLarZjQBVF?=
 =?us-ascii?Q?SsEQeLZalQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679c7247-0128-48f3-2858-08de69b6b76a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:44:21.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7y+up+aqQuXZ8QVhGotPjmB5xJu4ApnI7hg7hT1U1zhb2xM03ze7Jjhx+VrCzoLkFu08R8sTlTD1qA4wu5vzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10717

Allow spi-cpol property for ti,ads7843.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/input/touchscreen/ti,ads7843.yaml       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml
index 8f6335d7da1c5..6d56e19d49e3f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml
@@ -38,6 +38,8 @@ properties:
 
   wakeup-source: true
 
+  spi-cpol: true
+
   ti,debounce-max:
     deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint16
-- 
2.43.0

