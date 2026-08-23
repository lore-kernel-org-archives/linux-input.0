Received: from MI0P293CU007.outbound.protection.outlook.com (mail-italynorthazolkn19013077.outbound.protection.outlook.com [52.103.57.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911F36EA99;
	Sun, 23 Aug 2026 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.57.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510227; cv=fail; b=hwxIM7qHggiwsWM4k3BDksgYJ9IY6s/ucZy3Ix7QX/QC0ZfwL44LdxjyIBKzqfGnPqsPaeGn3cK0Tt1lPwyPvcVOPtsEyF/DULHuvBfnXyJhuJEuq6R4qCDBT/jD9aLbF4cyiQVrYjJUt7e1a5J7mhBBWz9np7XpAwGj/wlWBB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510227; c=relaxed/simple;
	bh=R/8hSOYD8gwYQIY1dAo6hPRkc7qCP59MQag5aO+acfk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WX/3cEVp0a+tiKhOBucdiB7f7A2vyklu7fFhhZv3j6p1jVAVTOxaw1cnQTjybeIITGbRj9OD89H+QRTfuof8MSmeEei5YUwyP+aFdEkx7L2lG0D2BXZDAaFNDLIlmkYi7bGl1xw0k2fj/aFaGmGfXfnhOYbyvddJH9j4Mc0xp4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L5BvifR3; arc=fail smtp.client-ip=52.103.57.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L5BvifR3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDtB4NPFFQiE6yzsnrrCEaF+wlIFw0pSJjWs++smOKwIL3VnJdK7+Qu/+BPhMWPxHZKFFDLX5J7PsWTWGhUdxgmJFXCB0D7+E32jskPc9o77wWqAdgNi4TbH0uIECePO+I/RULxTGS4HNhsN1OJkI7ygeeRoR0Kl1kqWVCFVIISZyZj095lQWJBtalTZ2ZqCP7X+xWYzYLwfazx+L9jB3GyAhjh8EOfdf151g4gyd9h5AaAFfFX0C0WieR1gQ8HZPdodRocxqBGX/Nawhp6VFuW+zYSN7jp2cpAL/xYkbbnX0Ei+jUHj+7S6u2W9VsS9PsZQDPYnrNDZjiVcIZ+xKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryjozj44Ayd2+yvD4QV13RAOeq7w6LdWRxmKynt8EJ4=;
 b=SSEJAVUyl3QXHVN6dgzLhrDTnBZxCRQOGXi1+RxquQ/T7BtL5vslRXGp9Vf9Cxqnpvl0TFjUFf4uYJ9SU1BMZtB+Iv6rImLfxd+I0svmpnnoETbhtPLOS/7N9odrzyRlZbEkimofHveSU6OgIzvZcx3cmljoldKRPj1IeIMh9qVNkL01786l2Jr6xVC7/uOsQEaOXu0FAA6F9gRncIm5h0nfoW9dfcnRY7tVGwUNNGwGjYz+gENpf0yWxbbbkvDClqeCTTM29r2mehXiYj/H+eBmxkiYblHQ6bChmq+Igu/YKpVgmQ1Dx+6iXxSn2gt/DhSvj4wD3PbecYQQ+CeQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryjozj44Ayd2+yvD4QV13RAOeq7w6LdWRxmKynt8EJ4=;
 b=L5BvifR3VrY8dTF9ZuI/RSRObFtbeCPtSLKFTZM2agXk8FMyPodqMV0JFOHwSssw8ZpxkIownRkTBxVk3KRMl2H+LA+sIzcQXs+ZJctjzCm9pScxai8ZhjOw1SO4IvUHMqhWzlI2aOBtPC1SY2/c7e9f7nCnodmGoT6/v1X95DT9KDNuQ2OgT4IHQuoPjOXRImGegRkXDXusZU8J+6z6wD6WynXfaQ1ZNV62Uwk5jt1yHKVs5i5eXov5oLY7qPjaMjRrcuY3eltT5PVt24VC/VLliE0RQ2dEA18SWoueF1JvjOANjMEoENEOC0N+QdAaUprDt6HxYc4CyMX15T2ahw==
Received: from MI2P293MB0448.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:4f::12)
 by MI2P293MB0180.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sun, 23 Aug
 2026 18:37:03 +0000
Received: from MI2P293MB0448.ITAP293.PROD.OUTLOOK.COM
 ([fe80::9239:36a2:514f:8058]) by MI2P293MB0448.ITAP293.PROD.OUTLOOK.COM
 ([fe80::9239:36a2:514f:8058%2]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 18:37:03 +0000
From: Antoni Marzec <amarzec@outlook.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Marzec <amarzec@outlook.com>
Subject: [PATCH] Input: xpad - add 8BitDo Ultimate 3-mode PID 201b
Date: Sun, 23 Aug 2026 20:36:53 +0200
Message-ID:
 <MI2P293MB04481F483D699374C768497BBFA12@MI2P293MB0448.ITAP293.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To MI2P293MB0448.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:4f::12)
X-Microsoft-Original-Message-ID: <20260823183653.8772-1-amarzec@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI2P293MB0448:EE_|MI2P293MB0180:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d6cf93-840b-4503-c474-08df01458691
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|4140399003|5072599009|25010399006|39105399006|22121099003|5062599005|24021099003|19110799012|15080799012|8060799015|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQoXZFfhR4tOG8WmTunB0cSpxR7E+NJ4A6O+cRf/JshAsIhCnFwBnvlqkJSU?=
 =?us-ascii?Q?RhIRPsA6Q+7Gu9Pxn48s1Nm3gS4XC6fOMhJL6f+uCiqgUtnPvGPua66aspo5?=
 =?us-ascii?Q?c67rAoAtznJxDKx1i/YXgaX7Ni3RcbC8Og1voklJfQvpjDtLSgi8iff4/Df2?=
 =?us-ascii?Q?8EJnWXPhrM5T9Y9f0DsnqfT9semEGUg34cfVvitfn0Nxb1iECbzQEULLt27Z?=
 =?us-ascii?Q?asmKCnliwoRPm7iK8GGhvReTpHAj454OiDV5jUEip9DHz8sBJLpVWXdlVl0b?=
 =?us-ascii?Q?FzUPDxmJYUJ3Em606DFXiHG+jMuNsSLYK8fm+te0LWrTzFl6q2E3q2v3hWcX?=
 =?us-ascii?Q?k2OzETFIvtKJ84VRggB+HmwS/Bd6bqahZjdQ7cKfaOC7NXp1wimMu4cugGIi?=
 =?us-ascii?Q?kFYTa2/fO1eTgW8+cTb4nvNchgk9w3fmYo5k89cr3N62ermd9TD+VeuPOaGv?=
 =?us-ascii?Q?9ivve/jzDgNh4TTQl2Nd8BP8kHptBQDFTErThHS9c+ptl1geWVur+0bTdu9P?=
 =?us-ascii?Q?MxVIrpZ8hZQgM46/BZtoG2m0qStVnCMo9LmCQwRIWQMCnlZGH9kGJWKLizQ0?=
 =?us-ascii?Q?0+jQP4XG7reE3RitGcCG0zi3hQfSzihWioLZeihxDKv6m85jvMJ1rh6vY53d?=
 =?us-ascii?Q?ELF1/gX+vjoxlorJqACjNGBqp+hhLeHvGapJm+W3tX/9wpG9mq7U+0CxKJhP?=
 =?us-ascii?Q?Xgcxvi9zk/d8KQk5GvwJGPvwj3uRCZ20pQja46ao9Ur69DLKBQtzqRbE+bna?=
 =?us-ascii?Q?1X0PiXqyGdGU8UuSqAhxaBt1phbljUPdyWJIyUdJjmE8WLn7tbfQSMll2Q5Y?=
 =?us-ascii?Q?BJFlobAIkn3rTR3EQOIf7FFMWmFHxJmgrohmJYO0ng9u4elVnZ+Gy6mQBtZ4?=
 =?us-ascii?Q?o1YjFg8sDh+RwCUOSV0lsyFa0WvU8UUfZ32egu50OJ/G28dTpEEd6OYs6vQD?=
 =?us-ascii?Q?G34y/8Q5WCjyHu49fQyhp8LeSk7wk5S6UKI/yjCWB2YB080rVe9uOOGhOnN1?=
 =?us-ascii?Q?JhNdJMC6tKdVcOQGAuHj6Yd0Qw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXiwAyXi+lmC+dOaozu12E7WUAOCZM30TYqcp4AoAS55CaocWx+T7f1oUzTL?=
 =?us-ascii?Q?b17OgSjoFaYMmrJyoau4TK/CLQnbmtCtvcadxELtleQ8ulgr+zbjWbZOjCKe?=
 =?us-ascii?Q?92i4k6Onyklpoy0X6uOJANlDvN9iVd/JUE6BxwMncUXQjJKyqokmPIpwm8M1?=
 =?us-ascii?Q?FSVDz6qoTnPMTASTcm0QZEyq2TS5vC8ifVjI9O6V471Rj8z9BKdsky626Jjn?=
 =?us-ascii?Q?hluqXtxMauitV0KHLjnt2Tu3R6To9LcKDacYC+zRjKs/sjs4YFYEIeZbXq57?=
 =?us-ascii?Q?CMROMe3f0Bs9Rnd0fPTKu7SUISDo94WpHXbudS34r8r46uTqtwcKE//hcTEt?=
 =?us-ascii?Q?lGvNxerb1OiwNwGEioIzIHPexyeG/V1VQsbU2q6V3Lfr8HRQAShhWpDZETti?=
 =?us-ascii?Q?8yMXDSGUSvQB7FyXLGp0qlLmvIBtaJH0JQGa/ZNYKUv8EKhMVnVraW3wvFmR?=
 =?us-ascii?Q?AfNDy+ohHyIpirQvQOG1Ns+zdD/QuIz56sEC6WTXG6+IgtqoAl4ttSto6A0e?=
 =?us-ascii?Q?7H6tWoGjYv93tSRQJcnHXX/k4MuDNtJtk/vqb9tLOj/1zOVLesSNmdt+ldmq?=
 =?us-ascii?Q?CamlcdY6pAv8VgGIweNVdg/hxzhVqtyAjtxKaQoSsK2NmihNEWN+zyM8p7Uw?=
 =?us-ascii?Q?ddXw+x1K01Jw4kf8SOp/htoYjMIyMoYUh4Cu9KMjcDwCC8yrBQHuS4ektLnh?=
 =?us-ascii?Q?OIEifl0sDXrzjpY12iC+l7iHCN4a1DOogi5qFln8VqtitScfrnh4lCPitpJE?=
 =?us-ascii?Q?lGK00R33THCnzwtJaDBLB9t+H53InkOmA5yW5hcwqaTADIrmoR/BOHRQExaD?=
 =?us-ascii?Q?pKxZiCq6M+AXzofl6udxm4lP2cTO0hcPBPpwQVt8qJNn//qccpn7uqqGOghr?=
 =?us-ascii?Q?7o49MQbseAdoNqyqrgx/nHHh2Q/sfzJDp+CObF/jPQGo+GEOB+GAqW/UftCx?=
 =?us-ascii?Q?7QvR1e2rqakYuesqqUFTdSwuS6bCyxfAVBh2IlMQ1Dy6xoxD5is6qEwyknUe?=
 =?us-ascii?Q?2ujwIEgP6YvQEp6HbpFj2FeZBNUfggF9C0zDw1gDO2ELwma33ExiFFKLSbqO?=
 =?us-ascii?Q?kOEXfzKMRNwozCjbj15gNNyq7aRD9zxy7MKTUpw5pHRwNQsihtTQkpHr6NPc?=
 =?us-ascii?Q?B7VHbBTNOoC4WLL1d1toK0h8TfSGdW6O4uvSqU3CQNzxyYg5XjLSWYdt9fgu?=
 =?us-ascii?Q?oIMNQZ7+lYSqlnP3BHgCj52H1NjvPrm/M3JS11xyY5tGJEg0jg85rUZWo3wS?=
 =?us-ascii?Q?pAdf8bY7MGZXuM1TgRuGVbxCctYvkjP2MBBHnCoYeMkNn45rlt+iWYVscX7K?=
 =?us-ascii?Q?bYeYc8KQ41GEkBIpUicR9cKX9VunZzf4BvVsRItaQJ4eNnNbJJUB3J+OriA2?=
 =?us-ascii?Q?Jx95d7CxqLmyTF1rgAjMOW4ehsDm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d6cf93-840b-4503-c474-08df01458691
X-MS-Exchange-CrossTenant-AuthSource: MI2P293MB0448.ITAP293.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 18:37:03.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI2P293MB0180

The 8BitDo Ultimate 3-mode Controller for Xbox presents USB ID
2dc8:201b during normal 2.4 GHz operation.

There is currently no device-specific entry for this PID, so xpad
falls back to the "Generic X-Box pad" entry without MAP_SHARE_BUTTON.
As a result, pressing the Share button produces no evdev event.

The receiver transiently enumerates as 2dc8:200f while the wireless
connection is being established or has been lost. This PID already
has a device-specific xpad entry with MAP_SHARE_BUTTON. Once the
controller connects, the device re-enumerates as 2dc8:201b.

Add a device entry for 2dc8:201b with MAP_SHARE_BUTTON to expose the
Share button during normal operation.

Signed-off-by: Antoni Marzec <amarzec@outlook.com>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2da0b7f17..7641254f7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -372,6 +372,7 @@ static const struct xpad_device {
 	{ 0x2993, 0x2001, "TECNO Pocket Go", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x200f, "8BitDo Ultimate 3-mode Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
+	{ 0x2dc8, 0x201b, "8BitDo Ultimate 3-mode Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x3106, "8BitDo Ultimate Wireless / Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x3109, "8BitDo Ultimate Wireless Bluetooth", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x310a, "8BitDo Ultimate 2C Wireless Controller", 0, XTYPE_XBOX360 },
-- 
2.55.0

