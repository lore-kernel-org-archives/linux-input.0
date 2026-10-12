Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514054BE457;
	Mon, 12 Oct 2026 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838900; cv=fail; b=YDgO9v382u+jOyz7UX6Y5hRvZtPDpuRpAyYdQjEIpjr5e/ZVSkNVMAi9cIR93nSg9WeD5HPO/6nWocX8kOUcZylgXuZcLSJLAWDEizUaEkN7k8NXjQ4mTuogFQmT7BFlYJHtz83BnfKf0XYRBkmItLQUCo01aljC1JE9VZHCOeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838900; c=relaxed/simple;
	bh=bkN+9012jNi3JcLOlxO92Lm5Liz4ytlR6aij32EKxOk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MCYZhOKIUj4jPEbcNIPBTomf+U+TWBUR+AzszaxGJiZPNAWWtfQqw+KD8NHHz9oif+QXhFiGppa+WgT4HqwO8PHhBu2TYR5I+X95bk+Wt5DgFEn4isx6hpKcOr0au0s4xOHZ+2M3kkqMWANy8Knd3aodsgFd7FiU73xaXJBmhTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Dr2hvEE2; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dr2hvEE2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TX5HOPYkgTH5zLDUDXOUHpKmRqIQ5IyvqnhvpjBPGQzfllBSVP347qk3M9wxryS/qby70KsugUqI6TgQpa4KirHotTlY3Wdewuu1y4yhf9n/wjjBsxhEI8TLcYFynCrHPLT7Ey20C53Ah5vi82qugNABozvYoTam68vEzAy4y2RLVt9h6aTBB4FWX6YpBp3Z5+pbbxLgi4pCPOI9WSUHo3y3F7K/I7efw0FtJoWrSX0olFsfNDyMZSs02fSbq0sm3OGrSx/XfNzmpmPreVHuOetmkYAdipuMPc8N0DSqiYAG0cTEDMc6+5x+BpSMqVCnuEI860OqFq2X33lqCJF2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+S4/ohrQiMz8GAXBqhfM/WKyWCqap/xazleW/7i5CA=;
 b=HpGAQ+jeb4R5OkkVLzwz8wk2lMWEfw1oa9m05sAk2YQfq1kN2bHUQk/mHz0MHTXnV42X+0l8V4hrQXvNKT5NPAG6mKv2dHDQdYgw7kRkrfi/UlvVc9Nn1EzZrEcnBpASR0oCjwwkk0Ys4ua3OY11Nu7/AulJoJEQyBwARFlT+cttSnZ/M2+rl93/V9U1qZI0ctPTwfFWtv+EqXjmq0IC88aVCUBm9Hf6dZ0J+or4/s++UwDNsVFQtIqeTydZ05jnLCc70spdSj1sFYP5DSxO7XQwOE3J/R0VDmRsFLug6sfSc6TDKR8PJOrXl7WS6/utd9CMW3rUcoRadWYnbl3OxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+S4/ohrQiMz8GAXBqhfM/WKyWCqap/xazleW/7i5CA=;
 b=Dr2hvEE2rXaaXB0ZkbJ1vflf39or8VD9nUYEQ+ZULfHaWYbcQAR5kXrNF/Zpy7jT2rccwtQdPC7CWpMgeJ6OjNTOUiS+B+PuB1um7HfmOrnPeLbbDXuStTE/R1fweJGxdsBZSYgeGh88Z8AGm2HYvDj4wl2sxDlUWlo/bFLID/ykDxhE5oT8gjDp4EaIdZnMQ6GAxgXwmIkjm51SIEJu8PWxCV0LY3KObpPUusQ1mgrxq8Pe7OxaeuC2a+hcvDa+E0K8W3JxSO9/Z/rw5Zmw9WVZ+mkd1N4yN8seHuoh0kWyB3iUZgLtY7e2Qz+axljd0sm4OthAFolA3kk8EC3uGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 21:01:35 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 21:01:35 +0000
From: Frank.Li@oss.nxp.com
To: Support Opensource <support.opensource@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/1] dt-bindings: input: dlg,da9062-onkey: Allow wakeup-source property
Date: Mon, 12 Oct 2026 17:00:53 -0400
Message-ID: <20261012210054.2848389-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0035.namprd14.prod.outlook.com
 (2603:10b6:930:a0::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 788f314c-c7c8-4a82-ddeb-08df28a4001e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|7416014|366016|10067099003|261009223027099003|921020|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	j6jSZxTE2YtV7f2iXYJAFq/+oU1dZaX2KjvNHT/yOf3WUWCxdo4w43U33Di4JxB5OtcelVXkBwgoPOedKxAeWRmKxjjCDhJc4mw+tUsudrFduAeJYRQf0m5dcxDwU1Kjfoyc50nYGUnijxdrlAV8d22GzifEzvmt4WX6sAz7Zt43Z1aBhXdJmVj6HGH4zllP4YGuqCOdGs/0ydmagZASwC20tttGK5h0YqueJ8A+Q1LLu1FZGTQj7pNhCGySCvGGAitmgBIIYXKlYSldxwWz7vsOrc744XUI+8Hxi4Opv5Daxxq2xoBGybcX9ZQCmgsrELvf0veqspiLnLJegJcfmV/mBSFGtqhvj+tCF9zIgbCypztlWh9jeJirp+uwjOHfMCoWVCD+1fTF9Zc/u5pfbc/XOE3vJ7/kBLohZj41J4pcIXhO94m5Uhq5ZJnnptrN2jtlKsF9oXLDrX7YlDTGQrHWbvN5y6AADO+aYwN2A84CcvKJJkvmRAWepaia+sCCAx11D6U5upBkVF0abEApMUxu3ynQFFg0zMhkQ29GwspcGto84GrI12G+4Dsb+cs+pgMqQHO0mspY4GOMk53hLDdTmzrPQnsCsmI3h6ycXugLp2r8aMAwcviBYoZuhYufBzR+nTNxmoDcPahV63KjewBHCrMmkQ6casYM1XKsj+GvAcS+1am+043mH0Bz4CSB52VB+OwSEo9DwimbmGRc6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(7416014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xtr1HjcR5zCndOIAccHqTePIANy/D7bA5Knhg/abFJxGW2zS0tEswvKBxCBT?=
 =?us-ascii?Q?/R0a7U76AJ0O7vgZNq27XBtw1kJNwRS2oqpSc3fjBzBifilw6OZMXizaI8lb?=
 =?us-ascii?Q?mC1nfDSScTGVMmdPfH1bHV2XIfG6ifkpL9+Y/Q+Iuhccn+b38JgEz3CVEDj9?=
 =?us-ascii?Q?oAvlTVY/l7ZWSAhOq+VNByQbwW8E8arPd2nMKqf5QfuPQZvE/WCZSbTXZE63?=
 =?us-ascii?Q?gjfeTOUffnhJvCH+bLFpGpe85DZRtl+O+ykdolXF/auSeQF/LqlSwXe0dneo?=
 =?us-ascii?Q?6xETmMzjO3U8lrk+OKfWNNyOa8XIWVV9RQNl+1hy0eLSbedxTAsJ68OcTjyf?=
 =?us-ascii?Q?6P9Zhiwjv8JzPpVH76YuF+ozqsCsz2oG7JSYo59MQWY1b1i12L9OjAHkiY6E?=
 =?us-ascii?Q?SdBSvtGY+Q25ctFzKQBJ8vgAyyJ3jQaEoVq2R3359QjAztY/PyKv9Ev4pIaX?=
 =?us-ascii?Q?anaH4QgW0RpWpP5p15uUCus3WqZgvHeuAJfDQ9E9XWocKM1Hp6nZlg1ZKF1w?=
 =?us-ascii?Q?1kgYg4YvwfX9su3InyXsEou/cgdRt/L2NKXGfL8kULszbLBJOamWqNlSgM9A?=
 =?us-ascii?Q?B1MrMWGBy2MXPWDnzNzX7ooIyQfoxlcxtlC3FOKB3MQLIXaqPuLPe/VnvpNV?=
 =?us-ascii?Q?tO+hWkvVrR0QO3XN3VzW6folJL8rn81OS5fr7DGVMWuXpG14HyY6DChboA62?=
 =?us-ascii?Q?h4DEDEjxnW3A/Kz2YU02rDZuOWfKqXN8ySl9mul5ltR5bmpSwNl3SSgcI+hu?=
 =?us-ascii?Q?OVrmdeYxKvBDWnqgzVXScfRE/M65B7r6jzXgwHxCbOBXh3Hr5rG+zKEB+0tS?=
 =?us-ascii?Q?nmGNqzPGskjnpXuZao2GLj8LgiWJpKDgHJbUVB9pyave9ig6F+wXSARuHmqm?=
 =?us-ascii?Q?ddId0lIelMFEtgwAJnwtwx5O7VVwBDOofpdGnv+BSHUFl5w3m1M7bGxAyVK+?=
 =?us-ascii?Q?tAriswFaa/yKaCy+y4nF+dbWHqXggS93sFtDv4hdD5R9ynWTfJMVNktWPVGO?=
 =?us-ascii?Q?keg/dLYfzpJqYbb96xDM52oPbXNuaPLa8xGLg3+4vatPg+dnzsvjIpgdSdy1?=
 =?us-ascii?Q?m/Z+AmwLRCoS+JnBbp0yPbHC5WRI/m7UQKFc92vxfU1oB2VJ7u40kbHCIZLo?=
 =?us-ascii?Q?7bnLglA8celDWkWNIghslT+Mhbq1hPJIeGNPIBvrgeNa9tBmtMa/G7HWldNU?=
 =?us-ascii?Q?AUFqWmDqDMmgzwb1x2aVmbnMgXMvrT5+8HhIHYtV5rB7iaYsJ3rLX+d7AyC0?=
 =?us-ascii?Q?n/BvF55WHfZz1jtrRXzQcyuTaFNVrkDIowuuppBjIsz+g7khGRAayDY4AG3O?=
 =?us-ascii?Q?WCdRVo6plOBbmrXeI5NtkpH09BjqOwka31tSKMeVYgzD0yNOWzdO7eC6yEx4?=
 =?us-ascii?Q?DcDtc5/ufXKHeLOjMte5gDgHw+WfKqjYCQpw3+kyueC03YQ3TpWungkmNJmf?=
 =?us-ascii?Q?F21LUiYCV0Kf8lUNu071u8ncZZNd4iyPeUQzE6kAg1KKee+46arQ2qKNK4/Z?=
 =?us-ascii?Q?XWLrsfe7U9cu3rfWoT6XFWwNXwGvwBXa3nGSo4UITp5xUgUZPO2S/41maasb?=
 =?us-ascii?Q?iSwpDjGgkoAVM68bDHc1XNV0JkyO642kz1HCf5slmi32hPrhUtA4L6mXU6Vp?=
 =?us-ascii?Q?elOs6MnfsaOPK24kPKfW/9pFmUgtit7iEK82c5jK8aNCWCLUUMkGBMRzh8kG?=
 =?us-ascii?Q?4Ird58UBMQIwy+CTFF0yuccAIQyotMQMYMh5nf3iomK2G19PVQ4WEznbD2kJ?=
 =?us-ascii?Q?lJixPQwbKvV2l3TNlEXNpovfx2rgtHk45m9t+XVYN6AfRKOrV1mr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788f314c-c7c8-4a82-ddeb-08df28a4001e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 21:01:35.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGRKU+33iT9CzEX3Ec8SGVYgRhUpDi3BhW3bHnOdMsrBWbHB5QOKLT2ujiUs6I7fko/bEuyk2lWA3oJV5Tuz6kUTRbBSzwNQhvSgwj1QOQm1+yMayUurcH7tX77q1wrH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

From: Frank Li <Frank.Li@nxp.com>

Allow wakeup-source property to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: onkey (dlg,da9063-onkey): 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- collect Rob acked tags,
https://lore.kernel.org/imx/20251014184531.2353879-1-Frank.Li@nxp.com/
- update subject. although git log --oneline show mfd, but it belongs to
input subsystem.
---
 Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml b/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
index 1480d95421e18..29ff8fc0d02ec 100644
--- a/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
+++ b/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
@@ -32,6 +32,8 @@ properties:
       the OnKey driver will remove support for the KEY_POWER key press
       when triggered using a long press of the OnKey.
 
+  wakeup-source: true
+
 required:
   - compatible
 
-- 
2.43.0

